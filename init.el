;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages (quote (helm helm-gtags tabbar tabbar-ruler))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; make {copy, cut, paste, undo} have {C-c, C-x, C-v, C-z} keys
(cua-mode 1)
;; auto insert closing bracket
(electric-pair-mode 1)
;; make cursor movement stop in between camelCase words.
(global-subword-mode 1)
;; make typing delete/overwrites selected text
(delete-selection-mode 1)
;; turn on highlighting current line
(global-hl-line-mode 1)
;; turn on bracket match highlight
(show-paren-mode 1)
;; remember cursor position. When file is opened, put cursor at last position
(if (version< emacs-version "25.0")
    (progn
      (require 'saveplace)
      (setq-default save-place t))
  (save-place-mode 1))
;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
;; diplay line numbers
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))
;; show cursor position within line
(column-number-mode 1)
;; when a file is updated outside emacs, make it update if it's already opened in emacs
(global-auto-revert-mode 1)
;; keep a list of recently opened files
(require 'recentf)
(recentf-mode 1)
;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))
;; Display lines number by default
(global-linum-mode t)
;; Display line number wider
(setq linum-format "%3d\u2502 ")
;; set default style for c code
(setq c-default-style "linux"
          c-basic-offset 4)
;; Set line tabs
(setq c-basic-offset 8
      tab-width 8)
;; make tab key always call a indent command.
(setq-default tab-always-indent t)

;; make tab key call indent command or insert tab character, depending on cursor position
(setq-default tab-always-indent nil)

;; make tab key do indent first then completion.
(setq-default tab-always-indent 'complete)

;; Highlight lines with more than 80 characters and trailing whitespace
(require 'whitespace)
(setq whitespace-style '(face empty lines-tail trailing))
(global-whitespace-mode t)

;; CPPutils-cmake configuration
(add-hook 'c-mode-common-hook
          (lambda ()
            (if (derived-mode-p 'c-mode 'c++-mode)
                (cppcm-reload-all)
              )))
;; OPTIONAL, somebody reported that they can use this package with Fortran
(add-hook 'c90-mode-hook (lambda () (cppcm-reload-all)))
;; OPTIONAL, avoid typing full path when starting gdb
(global-set-key (kbd "C-c C-g")
 '(lambda ()(interactive) (gud-gdb (concat "gdb --fullname " (cppcm-get-exe-path-current-buffer)))))
;; OPTIONAL, some users need specify extra flags forwarded to compiler
(setq cppcm-extra-preprocss-flags-from-user '("-I/usr/src/linux/include" "-DNDEBUG"))
;; AUTOCOMPLETE command
(require 'auto-complete)
(require 'auto-complete-config)
;; AUTOCOMPLETE by default
(ac-config-default)
(global-auto-complete-mode t)
;; YASNIPPET
(require 'yasnippet)
(yas-global-mode 1)
; OR, keeping YASnippet defaults try out ~/Downloads/interesting-snippets
(setq yas-snippet-dirs (append yas-snippet-dirs
                               '("~/Downloads/interesting-snippets")))
(add-hook 'prog-mode-hook #'yas-minor-mode)
;; Auto-Complete-c headers
(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/5/../../../../x86_64-linux-gnu/include"))
;; now call this function for c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)
;; split windows on star emacs
(split-window-below)
(split-window-right)
;;controlling windows size 
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)
;; fix bug with keybindings of iedit
(define-key global-map (kbd "C-c ;") 'iedit-mode)
