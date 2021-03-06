call plug#begin()

"languages
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'

"scheme specific (remove after tycs)
Plug 'taithethai/vim-scheme', { 'for': 'scheme', 'on': 'SchemeConnect' }
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle<Paste>

"config/templating/extensions
Plug 'Quramy/tsuquyomi' "typescript IDE
Plug 'elzr/vim-json'
Plug 'mxw/vim-jsx'
Plug 'hashivim/vim-terraform'
Plug 'digitaltoad/vim-pug'
Plug 'tpope/vim-markdown'
Plug 'wavded/vim-stylus'
Plug 'slim-template/vim-slim'
"misc
"jceb/vim-orgmode
Plug 'morhetz/gruvbox' "colorscheme
Plug 'w0rp/ale' "linting
Plug 'tomtom/tcomment_vim' "commenting blocks
Plug 'tpope/vim-surround' "change surrounding
Plug 'vim-airline/vim-airline' "status bar
Plug 'karthikv/tradeship-vim' "auto imports
Plug '/usr/local/opt/fzf'  "fuzzy finder
Plug 'scrooloose/nerdtree' "filenav
Plug 'airblade/vim-gitgutter' 
Plug 'Xuyuanp/nerdtree-git-plugin' "git for NERDtree
Plug 'wesQ3/vim-windowswap' "keybind is sww at first buffer, and sww to swap buffer
Plug 'ap/vim-css-color' "color preview
Plug 'mbbill/undotree' "undo tree :UndotreeToggle
Plug 'janko-m/vim-test' "test inside vim
Plug 'Shougo/vimproc.vim', {'do' : 'make'} "vimproc dependency of tsuquyomi
Plug 'chrisbra/NrrwRgn' "<leader>nr for narrow highlighted content
Plug 'jremmen/vim-ripgrep' " :Rg for ripgrep in vim
call plug#end()

"enable filetypes (already done by vim-plug, but in case that changes)
filetype plugin indent on
syntax enable

set nocompatible  "no compatibility with vi
set omnifunc=syntaxcomplete#Complete  "omni search
set ruler  "display current cursor position in lower right corner
set hidden  "switch between buffers without saving
set showcmd  "show command on bottom right
set number  "line numbers
set laststatus=2  "always show the status line
set incsearch  "incremental searching
set nofoldenable  "disable code folding
set mousehide  "hide mouse when typing
set splitbelow  "split windows below the current window
set showmode "show current mode
set completeopt=longest,menuone  "code completion
set wildmenu  "more useful command-line completion
set wildmode=list:longest  "auto-completion menu
set mouse=  "mouse selection shouldn't change vim mode; allows cmd + C to work
set rtp+=~/.fzf  "for fzf file searching

"tabs default to two spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

"smart indenting
set smartindent
set autoindent

"better line wrapping
set wrap
set textwidth=90
set formatoptions=qrn1

"case insensitive search
set ignorecase
set smartcase

"file types
au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.epy set filetype=htmldjango
au BufNewFile,BufRead *.json set filetype=json

"gruvbox theme
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
colorscheme gruvbox

"highlighting
highlight LineNr ctermfg=black
highlight Pmenu ctermbg=grey ctermfg=black
highlight PmenuSel ctermbg=red ctermfg=white
highlight Comment cterm=italic gui=italic


"completion
imap <C-j> <C-n>
imap <C-k> <C-p>

"easier window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

"helpful shortcuts
let mapleader='s'
nmap <Leader>l :vsplit<CR><C-l>
nmap <Leader>j :split<CR>
nmap <Leader>r :redraw!<CR>
nmap <Leader>s :set spell! spell?<CR>
nmap <Leader>h :set hls! hls?<CR>
nmap <Leader>2 :set ts=2 sts=2 sw=2 et<CR>
nmap <Leader>4 :set ts=4 sts=4 sw=4 et<CR>
"nmap <Leader>p :set invpaste paste?<CR>
nmap <Leader>v :source ~/.vimrc<CR>
nmap <C-p> :FZF<CR>
nmap <Leader>t :TestFile<CR>
nmap <Leader>h :UndoTreeToggle<CR>

"line movement
nmap <M-j> :m+<CR>==
nmap <M-k> :m-2<CR>==
imap <M-j> <Esc>:m+<CR>==gi
imap <M-k> <Esc>:m-2<CR>==gi
vmap <M-j> :m'>+<CR>gv=gv
vmap <M-k> :m-2<CR>gv=gv

"spelling corrections
iab teh the
iab Teh The

let g:javascript_plugin_flow = 1  "vim-javascript: enable flow highlighting
let g:jsx_ext_required = 0  "vim-jsx: make .jsx extension not requried

 let g:ale_linters = {
 \  'javascript': ['eslint'],
 \  'typescript': ['eslint'],
 \}
 
 " \  'typescript': ['tsserver'],
let g:ale_fixers = {
\  'javascript': ['eslint'],
 \  'typescript': ['eslint'],
\}
let g:ale_fix_on_save = 1

"tradeship: import on shortcut
nnoremap <C-A-i> :Tradeship<CR>

"automatically add end braces
inoremap <CR> <C-R>=CleverBrace()<CR>
function! CleverBrace()
  if strpart(getline('.'), col('.') - 2, 1) =~ '{'
    return "\<CR>}\<ESC>O"
  else
    return "\<CR>"
endfunction

"NERDTree
autocmd vimenter * NERDTree
"close vim if NERDTree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"always show hidden files
let g:NERDTreeShowHidden=1
":Ntl runs :NERDTree ~/Lambdaschool/
" :command! Ntl NERDTree ~/Lambdaschool

"vim-test
let g:test#javascript#mocha#file_pattern = '.*\.spec\.js' "spec file recognition
let g:test#strategy = 'neovim' "use :terminal for testing
let g:test#javascript#mocha#options = '--require esm' "require esm for javascript testing

"tsuquyomi bindings
nmap <Leader>d :TsuquyomiSplitDefinition<CR>
let g:tsuquyomi_completion_detail = 1 "typescript extra completion details
let g:tsuquyomi_javascript_support = 1
let g:tsuquyomi_use_local_typescript = 0
let g:tsuquyomi_use_dev_node_module = 0

"Map escape to exit terminal mode
tnoremap <Esc> <C-\><C-n>
