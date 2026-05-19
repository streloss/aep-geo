@echo off
chcp 65001 >nul
echo ==========================================
echo   🚀 Деплой на GitHub Pages
echo ==========================================
echo.

:: Проверка git
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Git не найден. Скачай с https://git-scm.com
    pause
    exit /b 1
)

:: Проверка GitHub репо
if not exist .git (
    echo 📦 Инициализация git-репозитория...
    git init
    git branch -M main
)

echo.
echo 🔗 Нужно создать репозиторий на GitHub:
echo    1. Открой https://github.com/new
echo    2. Название: aep-geo (или любое другое)
echo    3. НЕ ставь галочку "Add a README"
echo    4. Нажми Create repository
echo.
set /p REPO_URL="Вставь ссылку на репозиторий (HTTPS): "

git remote remove origin 2>nul
git remote add origin "%REPO_URL%"

echo.
echo 📤 Загрузка файлов...
git add -A
git commit -m "feat: добавлен реферат и шпаргалка по АЭС" 2>nul || echo ⚠️ Коммит уже существует или пустой
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo ❌ Ошибка пуша. Возможные причины:
    echo    - Неправильная ссылка
    echo    - Нужно авторизоваться (введи логин/токен)
    echo.
    echo 💡 Совет: используй Personal Access Token вместо пароля!
    pause
    exit /b 1
)

echo.
echo ✅ Файлы загружены!
echo.
echo 📋 Следующий шаг — включи GitHub Pages:
echo    1. Открой репозиторий на github.com
echo    2. Settings → Pages (внизу слева)
echo    3. Source: Deploy from a branch
echo    4. Branch: main / root
echo    5. Save
echo.
echo 🌐 Через 1-2 минуты сайт будет доступен:
echo    %REPO_URL:github.com=твойник.github.io%
echo    (замени твойник на свой ник)
echo.
pause
