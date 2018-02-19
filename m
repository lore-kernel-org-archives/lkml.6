Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519077993; cv=none;
        d=google.com; s=arc-20160816;
        b=VO0tMKgy5/bHPXa0UpGfS4yCrHw+10Koj2Yc0/4VW4UO8WAYz458E2RFSNvBHtaK7l
         MchxorVzVDAQ2GdItta4Fh/tku7jTdNTrG7DLe2EKGnNvaUd9aDCky+hDwVHaLuP8trH
         qFkwRuV25V+7WPq5JB2QIFfPRzG1EwXzdzIdj27pGR8KNDdHJ/jTOAYL7zd2aKH4B0W7
         Wzm/xB70RNZf+aolqJ6iqmYHzhfZau+TNf4q2OEYwcL8kW9pilPAgDQ9KRXifsKytP7r
         +no6hFfa1i6V9jtPCu6lCIvESSPLG9mUUkfZ9BlhLVlYcD6Hc6YgltfjE4kprTpgUQmu
         q+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=WkqQFyZcsgXm0F5TPw9IqKJ1OvvwPdhz3jrIIm65DW8=;
        b=uOhJS1HRoFM0x8Dx/WVgOguKGj62N1wkAHmKnHgLaRbjP5yihFcD4jmGy7rx7oltBu
         PeUphswyATyK6pUCQ3CiL7R+KGm/coAazhMpDLyR0seVkkyEDpB6AdlngBBpNB/GwTbr
         06KHhcFzIv3gQTBTfw3Sg4+roPaZU+LrUBQ1gHVlYPf8ZPGtn+EMdrm0roD7foJ2kfJN
         3EoPE8GEM80GLYWm8gK6hYLsN1DkEwBeQNx6FVrQxPE3rMWrjPQXJ5VmVSuiZOoFcM6i
         cGZRHfn/hxFTfSyldopI6hwaodNXoc65h+PgD1d9At5o/QlK1JQuojmaiESN2duqZoUD
         RVpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=n+AjsDMs;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=n+AjsDMs;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227JKUVvjELztkHsF2kPqnOba/f9nZBTHf6hTIH/rWCIvmdmPj/DqSGtRi0DRk7xh/5LtoAJgw==
Date: Mon, 19 Feb 2018 23:06:18 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/23] kconfig: add function support and implement
 'shell' function
Message-ID: <20180219220618.5efvutflvfjsxpss@huvuddator>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <1518806331-7101-8-git-send-email-yamada.masahiro@socionext.com>
 <20180217161636.h6miw4xhu2mfjzvd@huvuddator>
 <CAK7LNAQDwqW8UMaXXKtbg9YUVRitobe9RraUQ3mmYQdxDgqYpA@mail.gmail.com>
 <20180219175059.iirtcd2pugmbje7f@huvuddator>
 <CAFkk2KQL_cU2YPpgkw2TZnmQ6nUgpawYizW+JLQn7WOBwDThGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFkk2KQL_cU2YPpgkw2TZnmQ6nUgpawYizW+JLQn7WOBwDThGQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583925672243095?=
X-GMAIL-MSGID: =?utf-8?q?1592868726218034393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 09:06:55PM +0100, Ulf Magnusson wrote:
> On Mon, Feb 19, 2018 at 6:50 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> > On Tue, Feb 20, 2018 at 12:57:13AM +0900, Masahiro Yamada wrote:
> >> 2018-02-18 1:16 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> >> > On Sat, Feb 17, 2018 at 03:38:35AM +0900, Masahiro Yamada wrote:
> >> >> This commit adds a new concept 'function' to Kconfig.  A function call
> >> >> resembles a variable reference with arguments, and looks like this:
> >> >>
> >> >>   $(function arg1, arg2, arg3, ...)
> >> >>
> >> >> (Actually, this syntax was inspired by Makefile.)
> >> >>
> >> >> Real examples will look like this:
> >> >>
> >> >>   $(shell true)
> >> >>   $(cc-option -fstackprotector)
> >> >>
> >> >> This commit adds the basic infrastructure to add, delete, evaluate
> >> >> functions.
> >> >>
> >> >> Also, add the first built-in function $(shell ...).  This evaluates
> >> >> to 'y' if the given command exits with 0, 'n' otherwise.
> >> >>
> >> >> I am also planning to support user-defined functions (a.k.a 'macro')
> >> >> for cases where hard-coding is not preferred.
> >> >>
> >> >> If you want to try this feature, the hello-world code is someting below.
> >> >>
> >> >> Example code:
> >> >>
> >> >>   config CC_IS_GCC
> >> >>           bool
> >> >>           default $(shell $CC --version | grep -q gcc)
> >> >>
> >> >>   config CC_IS_CLANG
> >> >>           bool
> >> >>           default $(shell $CC --version | grep -q clang)
> >> >>
> >> >>   config CC_HAS_OZ
> >> >>           bool
> >> >>           default $(shell $CC -Werror -Oz -c -x c /dev/null -o /dev/null)
> >> >>
> >> >> Result:
> >> >>
> >> >>   $ make -s alldefconfig && tail -n 3 .config
> >> >>   CONFIG_CC_IS_GCC=y
> >> >>   # CONFIG_CC_IS_CLANG is not set
> >> >>   # CONFIG_CC_HAS_OZ is not set
> >> >>
> >> >>   $ make CC=clang -s alldefconfig && tail -n 3 .config
> >> >>   # CONFIG_CC_IS_GCC is not set
> >> >>   CONFIG_CC_IS_CLANG=y
> >> >>   CONFIG_CC_HAS_OZ=y
> >> >>
> >> >> A function call can appear anywhere a symbol reference can appear.
> >> >> So, the following code is possible.
> >> >>
> >> >> Example code:
> >> >>
> >> >>   config CC_NAME
> >> >>           string
> >> >>           default "gcc" if $(shell $CC --version | grep -q gcc)
> >> >>           default "clang" if $(shell $CC --version | grep -q clang)
> >> >>           default "unknown compiler"
> >> >>
> >> >> Result:
> >> >>
> >> >>   $ make -s alldefconfig && tail -n 1 .config
> >> >>   CONFIG_CC_NAME="gcc"
> >> >>
> >> >>   $ make CC=clang -s alldefconfig && tail -n 1 .config
> >> >>   CONFIG_CC_NAME="clang"
> >> >>
> >> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> >> ---
> >> >>
> >> >> Reminder for myself:
> >> >> Update Documentation/kbuild/kconfig-language.txt
> >> >>
> >> >>
> >> >>  scripts/kconfig/function.c  | 149 ++++++++++++++++++++++++++++++++++++++++++++
> >> >>  scripts/kconfig/lkc_proto.h |   5 ++
> >> >>  scripts/kconfig/util.c      |  46 +++++++++++---
> >> >>  scripts/kconfig/zconf.l     |  38 ++++++++++-
> >> >>  scripts/kconfig/zconf.y     |   9 +++
> >> >>  5 files changed, 238 insertions(+), 9 deletions(-)
> >> >>  create mode 100644 scripts/kconfig/function.c
> >> >>
> >> >> diff --git a/scripts/kconfig/function.c b/scripts/kconfig/function.c
> >> >> new file mode 100644
> >> >> index 0000000..60e59be
> >> >> --- /dev/null
> >> >> +++ b/scripts/kconfig/function.c
> >> >> @@ -0,0 +1,149 @@
> >> >> +// SPDX-License-Identifier: GPL-2.0
> >> >> +//
> >> >> +// Copyright (C) 2018 Masahiro Yamada <yamada.masahiro@socionext.com>
> >> >> +
> >> >> +#include <stdio.h>
> >> >> +#include <stdlib.h>
> >> >> +#include <string.h>
> >> >> +
> >> >> +#include "list.h"
> >> >> +
> >> >> +#define FUNCTION_MAX_ARGS            10
> >> >> +
> >> >> +static LIST_HEAD(function_list);
> >> >> +
> >> >> +struct function {
> >> >> +     const char *name;
> >> >> +     char *(*func)(int argc, char *argv[]);
> >> >> +     struct list_head node;
> >> >> +};
> >> >> +
> >> >> +static struct function *func_lookup(const char *name)
> >> >> +{
> >> >> +     struct function *f;
> >> >> +
> >> >> +     list_for_each_entry(f, &function_list, node) {
> >> >> +             if (!strcmp(name, f->name))
> >> >> +                     return f;
> >> >> +     }
> >> >> +
> >> >> +     return NULL;
> >> >> +}
> >> >> +
> >> >> +static void func_add(const char *name, char *(*func)(int argc, char *argv[]))
> >> >> +{
> >> >> +     struct function *f;
> >> >> +
> >> >> +     f = func_lookup(name);
> >> >> +     if (f) {
> >> >> +             fprintf(stderr, "%s: function already exists. ignored.\n", name);
> >> >> +             return;
> >> >> +     }
> >> >> +
> >> >> +     f = xmalloc(sizeof(*f));
> >> >> +     f->name = name;
> >> >> +     f->func = func;
> >> >> +
> >> >> +     list_add_tail(&f->node, &function_list);
> >> >> +}
> >> >> +
> >> >> +static void func_del(struct function *f)
> >> >> +{
> >> >> +     list_del(&f->node);
> >> >> +     free(f);
> >> >> +}
> >> >> +
> >> >> +static char *func_call(int argc, char *argv[])
> >> >> +{
> >> >> +     struct function *f;
> >> >> +
> >> >> +     f = func_lookup(argv[0]);
> >> >> +     if (!f) {
> >> >> +             fprintf(stderr, "%s: function not found\n", argv[0]);
> >> >> +             return NULL;
> >> >> +     }
> >> >> +
> >> >> +     return f->func(argc, argv);
> >> >> +}
> >> >> +
> >> >> +static char *func_eval(const char *func)
> >> >> +{
> >> >> +     char *expanded, *saveptr, *str, *token, *res;
> >> >> +     const char *delim;
> >> >> +     int argc = 0;
> >> >> +     char *argv[FUNCTION_MAX_ARGS];
> >> >> +
> >> >> +     expanded = expand_string_value(func);
> >> >> +
> >> >> +     str = expanded;
> >> >> +     delim = " ";
> >> >> +
> >> >> +     while ((token = strtok_r(str, delim, &saveptr))) {
> >> >> +             argv[argc++] = token;
> >> >> +             str = NULL;
> >> >> +             delim = ",";
> >> >> +     }
> >> >> +
> >> >> +     res = func_call(argc, argv);
> >> >> +
> >> >> +     free(expanded);
> >> >> +
> >> >> +     return res ?: xstrdup("");
> >> >> +}
> >> >> +
> >> >> +char *func_eval_n(const char *func, size_t n)
> >> >> +{
> >> >> +     char *tmp, *res;
> >> >> +
> >> >> +     tmp = xmalloc(n + 1);
> >> >> +     memcpy(tmp, func, n);
> >> >> +     *(tmp + n) = '\0';
> >> >> +
> >> >> +     res = func_eval(tmp);
> >> >> +
> >> >> +     free(tmp);
> >> >> +
> >> >> +     return res;
> >> >> +}
> >> >> +
> >> >> +/* built-in functions */
> >> >> +static char *do_shell(int argc, char *argv[])
> >> >> +{
> >> >> +     static const char *pre = "(";
> >> >> +     static const char *post = ") >/dev/null 2>&1";
> >> >> +     char *cmd;
> >> >> +     int ret;
> >> >> +
> >> >> +     if (argc != 2)
> >> >> +             return NULL;
> >> >> +
> >> >> +     /*
> >> >> +      * Surround the command with ( ) in case it is piped commands.
> >> >> +      * Also, redirect stdout and stderr to /dev/null.
> >> >> +      */
> >> >> +     cmd = xmalloc(strlen(pre) + strlen(argv[1]) + strlen(post) + 1);
> >> >> +     strcpy(cmd, pre);
> >> >> +     strcat(cmd, argv[1]);
> >> >> +     strcat(cmd, post);
> >> >> +
> >> >> +     ret = system(cmd);
> >> >> +
> >> >> +     free(cmd);
> >> >> +
> >> >> +     return xstrdup(ret == 0 ? "y" : "n");
> >> >> +}
> >> >> +
> >> >> +void func_init(void)
> >> >> +{
> >> >> +     /* register built-in functions */
> >> >> +     func_add("shell", do_shell);
> >> >> +}
> >> >> +
> >> >> +void func_exit(void)
> >> >> +{
> >> >> +     struct function *f, *tmp;
> >> >> +
> >> >> +     /* unregister all functions */
> >> >> +     list_for_each_entry_safe(f, tmp, &function_list, node)
> >> >> +             func_del(f);
> >> >> +}
> >> >> diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
> >> >> index 9884adc..09a4f53 100644
> >> >> --- a/scripts/kconfig/lkc_proto.h
> >> >> +++ b/scripts/kconfig/lkc_proto.h
> >> >> @@ -48,5 +48,10 @@ const char * sym_get_string_value(struct symbol *sym);
> >> >>
> >> >>  const char * prop_get_type_name(enum prop_type type);
> >> >>
> >> >> +/* function.c */
> >> >> +char *func_eval_n(const char *func, size_t n);
> >> >> +void func_init(void);
> >> >> +void func_exit(void);
> >> >> +
> >> >>  /* expr.c */
> >> >>  void expr_print(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken);
> >> >> diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
> >> >> index dddf85b..ed89fb9 100644
> >> >> --- a/scripts/kconfig/util.c
> >> >> +++ b/scripts/kconfig/util.c
> >> >> @@ -93,9 +93,10 @@ static char *env_expand_n(const char *name, size_t n)
> >> >>  }
> >> >>
> >> >>  /*
> >> >> - * Expand environments embedded in the string given in argument. Environments
> >> >> - * to be expanded shall be prefixed by a '$'. Unknown environment expands to
> >> >> - * the empty string.
> >> >> + * Expand environments and functions embedded in the string given in argument.
> >> >> + * Environments to be expanded shall be prefixed by a '$'. Functions to be
> >> >> + * evaluated shall be surrounded by $(). Unknown environment/function expands
> >> >> + * to the empty string.
> >> >>   */
> >> >>  char *expand_string_value(const char *in)
> >> >>  {
> >> >> @@ -113,11 +114,40 @@ char *expand_string_value(const char *in)
> >> >>       while ((p = strchr(in, '$'))) {
> >> >>               char *new;
> >> >>
> >> >> -             q = p + 1;
> >> >> -             while (isalnum(*q) || *q == '_')
> >> >> -                     q++;
> >> >> -
> >> >> -             new = env_expand_n(p + 1, q - p - 1);
> >> >> +             /*
> >> >> +              * If the next character is '(', it is a function.
> >> >> +              * Otherwise, environment.
> >> >> +              */
> >> >> +             if (*(p + 1) == '(') {
> >> >> +                     int nest = 0;
> >> >> +
> >> >> +                     q = p + 2;
> >> >> +                     while (1) {
> >> >> +                             if (*q == '\0') {
> >> >> +                                     fprintf(stderr,
> >> >> +                                             "unterminated function: %s\n",
> >> >> +                                             p);
> >> >> +                                     new = xstrdup("");
> >> >> +                                     break;
> >> >> +                             } else if (*q == '(') {
> >> >> +                                     nest++;
> >> >> +                             } else if (*q == ')') {
> >> >> +                                     if (nest-- == 0) {
> >> >> +                                             new = func_eval_n(p + 2,
> >> >> +                                                               q - p - 2);
> >> >> +                                             q++;
> >> >> +                                             break;
> >> >> +                                     }
> >> >> +                             }
> >> >> +                             q++;
> >> >> +                     }
> >> >> +             } else {
> >> >> +                     q = p + 1;
> >> >> +                     while (isalnum(*q) || *q == '_')
> >> >> +                             q++;
> >> >> +
> >> >> +                     new = env_expand_n(p + 1, q - p - 1);
> >> >> +             }
> >> >>
> >> >>               reslen = strlen(res) + (p - in) + strlen(new) + 1;
> >> >>               res = xrealloc(res, reslen);
> >> >> diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
> >> >> index 0d89ea6..f433ab0 100644
> >> >> --- a/scripts/kconfig/zconf.l
> >> >> +++ b/scripts/kconfig/zconf.l
> >> >> @@ -1,7 +1,7 @@
> >> >>  %option nostdinit noyywrap never-interactive full ecs
> >> >>  %option 8bit nodefault perf-report perf-report
> >> >>  %option noinput
> >> >> -%x COMMAND HELP STRING PARAM
> >> >> +%x COMMAND HELP STRING PARAM FUNCTION
> >> >>  %{
> >> >>  /*
> >> >>   * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
> >> >> @@ -25,6 +25,7 @@ static struct {
> >> >>
> >> >>  static char *text;
> >> >>  static int text_size, text_asize;
> >> >> +static int function_nest;
> >> >>
> >> >>  struct buffer {
> >> >>       struct buffer *parent;
> >> >> @@ -138,6 +139,12 @@ n        [$A-Za-z0-9_-]
> >> >>               new_string();
> >> >>               BEGIN(STRING);
> >> >>       }
> >> >> +     "$("    {
> >> >> +             new_string();
> >> >> +             append_string(yytext, yyleng);
> >> >> +             function_nest = 0;
> >> >> +             BEGIN(FUNCTION);
> >> >> +     }
> >> >>       \n      BEGIN(INITIAL); current_file->lineno++; return T_EOL;
> >> >>       ({n}|[/.])+     {
> >> >>               const struct kconf_id *id = kconf_id_lookup(yytext, yyleng);
> >> >> @@ -196,6 +203,35 @@ n        [$A-Za-z0-9_-]
> >> >>       }
> >> >>  }
> >> >>
> >> >> +<FUNCTION>{
> >> >> +     [^()\n]* {
> >> >> +             append_string(yytext, yyleng);
> >> >> +     }
> >> >> +     "(" {
> >> >> +             append_string(yytext, yyleng);
> >> >> +             function_nest++;
> >> >> +     }
> >> >> +     ")" {
> >> >> +             append_string(yytext, yyleng);
> >> >> +             if (function_nest-- == 0) {
> >> >> +                     BEGIN(PARAM);
> >> >> +                     yylval.string = text;
> >> >> +                     return T_WORD;
> >> >
> >> > T_WORD_QUOTE (which would turn into a constant symbol in most contexts)
> >> > would be better here, IMO. That would turn $(foo) into just an alias for
> >> > "$(foo)".
> >> >
> >> > See below.
> >> >
> >> >> +             }
> >> >> +     }
> >> >> +     \n {
> >> >> +             fprintf(stderr,
> >> >> +                     "%s:%d:warning: multi-line function not supported\n",
> >> >> +                     zconf_curname(), zconf_lineno());
> >> >> +             current_file->lineno++;
> >> >> +             BEGIN(INITIAL);
> >> >> +             return T_EOL;
> >> >> +     }
> >> >> +     <<EOF>> {
> >> >> +             BEGIN(INITIAL);
> >> >> +     }
> >> >> +}
> >> >> +
> >> >>  <HELP>{
> >> >>       [ \t]+  {
> >> >>               ts = 0;
> >> >> diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
> >> >> index 784083d..d9977de 100644
> >> >> --- a/scripts/kconfig/zconf.y
> >> >> +++ b/scripts/kconfig/zconf.y
> >> >> @@ -534,11 +534,19 @@ void conf_parse(const char *name)
> >> >>
> >> >>       zconf_initscan(name);
> >> >>
> >> >> +     func_init();
> >> >>       _menu_init();
> >> >>
> >> >>       if (getenv("ZCONF_DEBUG"))
> >> >>               yydebug = 1;
> >> >>       yyparse();
> >> >> +
> >> >> +     /*
> >> >> +      * Currently, functions are evaluated only when Kconfig files are
> >> >> +      * parsed. We can free functions here.
> >> >> +      */
> >> >> +     func_exit();
> >> >> +
> >> >>       if (yynerrs)
> >> >>               exit(1);
> >> >>       if (!modules_sym)
> >> >> @@ -778,4 +786,5 @@ void zconfdump(FILE *out)
> >> >>  #include "confdata.c"
> >> >>  #include "expr.c"
> >> >>  #include "symbol.c"
> >> >> +#include "function.c"
> >> >>  #include "menu.c"
> >> >> --
> >> >> 2.7.4
> >> >>
> >> >
> >> > Here's a simplification idea I'm throwing out there:
> >> >
> >> > What about only allowing $ENV and $() within quotes, and just having
> >> > them always do simple text substitution (so that they'd indirectly
> >> > always generate T_WORD_QUOTE tokens)?
> >>
> >>
> >> I ended up with a new state <FUNCTION>,
> >> but the real problem is the lexer is too ugly.
> >>
> >> So, maybe, the solution is not to make it into a string,
> >> but to re-write the lexer.
> >>
> >>
> >> <STRING> and <FUNCTION> are almost the same in the sense
> >> that whitespaces do not split tokens.
> >>
> >> The difference is the characters to start/end with.
> >>
> >>   ' ... '
> >>   " ... "
> >>   ( ... )
> >>
> >> If we encounter with the 3 special characters,  ' , '', (,
> >> then we enter into <STRING> state,
> >> then it ends with ', ", ), respectively.
> >> (but we need to take care of nesting, escaping)
> >>
> >> Double-surrounding like  "$(cc-option -Oz)"
> >> looks ugly to me.
> >
> > It makes it clear that all we're doing is string interpolation, which is
> > the important thing.
> >
> > The simplest and to me sanest way to implement $(cc-option -Oz) is as
> > "$(cc-option -Oz)" (a SYMBOL_CONST symbol, which lives in a separate
> > namespace -- see below), and at that point $(cc-option -Oz) would just
> > be syntactic sugar for "$(cc-option -Oz)".
> >
> > IMO, that syntactic sugar just hides how simple the behavior really is
> > and makes Kconfig more confusing. Plus it complicates the
> > implementation.
> >
> >>
> >>
> >>
> >>
> >>
> >> > Pros:
> >> >
> >> >  - Zero new syntax outside of strings (until the macro stuff).
> >> >
> >> >  - Makes the behavior and limitations of the syntax obvious: You can't
> >> >    have $(foo) expand to a full expression, only to (possibly part of) a
> >> >    value. This is a good limitation, IMO, and it's already there.
> >> >
> >> >  - Super simple and straightforward Kconfig implementation. All the new
> >> >    magic would happen in expand_string_value().
> >> >
> >> > Neutral:
> >> >
> >> >  - Just as general where it matters. Take something like
> >> >
> >> >      default "$(foo)"
> >> >
> >> >    If $(foo) happens to expand to "y", then that will do its usual thing
> >> >    for a bool/tristate symbol. Same for string symbols, etc. It'd just
> >> >    be a thin preprocessing step on constant symbol values.
> >> >
> >> >  - The only loss in generality would be that you can no longer have
> >> >    a function expand to the name of non-constant symbol. For example,
> >> >    take the following:
> >> >
> >> >         default $(foo)
> >> >
> >> >    If $(foo) expands to MY_SYMBOL, then that would work as
> >> >
> >> >         default MY_SYMBOL
> >>
> >>
> >> Probably, this is a "do not do this".
> >>
> >>
> >> If the symbol is 'int' type,
> >> and  $MY_NUMBER is expanded to 1,
> >> it is our intention.
> >
> > Just to summarize the tradeoffs in each approach:
> >
> > Approach 1:
> > Let $(fn ...) expand to FOO and reference the symbol FOO if it exists
> >
> > Approach 2:
> > Let $(fn ...) expand to "FOO", which could never reference existing
> > symbols
> >
> >
> > Pros of approach 1:
> >
> >   - If someone legitimately wants to do indirection by generating
> >     Kconfig symbol names, they can.
> >
> > Cons of approach 1:
> >
> >   - If $(fn ...) happens to expand to the name of an existing symbol, it
> >     will reference it, even if it wasn't intended. This might get really
> >     tricky to debug, as it probably won't be obvious that this is how it
> >     works.
> >
> >
> > Pros of approach 2:
> >
> >   - You can never accidentally reference an existing symbol when it
> >     wasn't intended. You always generate a "value". Constant symbols
> >     live in a separate namespace.
> >
> >   - The behavior is simpler to understand, IMO. $(fn ...) and $FOO
> >     consistently deal with values and just do string interpolation. You
> >     don't get "either a symbol or a value" depending on what's already
> >     defined.
> >
> > Cons of approach 2:
> >
> >   - You can't do indirection by generating Kconfig symbol names. I
> >     suspect there'd always be cleaner ways to do that in practice, but
> >     I'm showing my bias here.
> >
> >
> > Approach 2 seems much simpler and less magical to me.
> >
> >>
> >>
> >>
> >>
> >>
> >> >   (I.e., it would default to the value of the symbol MY_SYMBOL.)
> >> >
> >> >   With the quotes, it would instead work as
> >> >
> >> >      default "MY_SYMBOL"
> >> >
> >> >   IMO, the second version is less confusing, and deliberately using the
> >> >   first version seems like a bad idea (there's likely to be cleaner ways
> >> >   to do the indirection in plain Kconfig).
> >> >
> >> >   This is also why I think T_WORD_QUOTE is better in the code above. It
> >> >   would make $(foo) work more like a shorthand for "$(foo)".
> >> >
> >> >
> >> > Cons:
> >> >
> >> >  - Bit more typing to add the quotes
> >> >
> >> >  - Maybe it isn't widely known that "n", "m", "y" work just like n, m, y
> >> >    for bool and tristate symbols (the latter automatically get converted
> >> >    to the former), though you see them quite a lot in Kconfig files.
> >>
> >> Not only bool/tristate, but also int/hex.
> >> "1" is equivalent to 1.
> >>
> >>
> >> Kconfig is screwed up in handling of literals.
> >
> > I don't actually think the design is horrible here (though it has
> > flaws). The biggest problem is that it's poorly documented and
> > understood.
> >
> > Expressions are composed of symbols and operators. You have ordinary
> > symbols and constant symbols (quoted stuff, "values" if you will). All
> > symbols have a tristate value and a string value. Which value gets used,
> > and how, depends on the operator.
> >
> > Note that constant symbols are actually stored separately from
> > nonconstant symbols internally (see SYMBOL_CONST). 1 and "1" are not the
> > same symbol (this is easy to miss unless you've spent too much
> > deciphering Kconfig's code). The reason a plain 1 works is that
> > undefined symbols share many behaviors with constant symbols.
> >
> > The biggest mess-up in Kconfig I think is not making the constant vs.
> > undefined distinction clear. It would have been neater if references to
> > undefined symbols simply threw an error, though that gets a bit icky
> > with shared Kconfig files, like in the kernel (would need to make sure
> > that referenced symbols are always defined or predeclare them as
> > undefined).
> >
> > Some people might object to "1" as well, but it would've been a lesser
> > evil I think, once the symbol/value distinction would be clear.
> >
> > The other option would be to tack some kind of complicated type system
> > on top of Kconfig's evaluation semantics. That's overkilling it, IMO.
> >
> >>
> >>
> >> >    ("n", "foo bar", etc., are all just constant symbols. Kconfig keeps
> >> >    track of them separately from non-constant symbols. The constant
> >> >    symbols "n", "m", and "y" are predefined.)
> >> >
> >> >    If we go with obligatory quotes, I volunteer to explain things in
> >> >    kconfig-language.txt at least, to make it clear why you'd see quotes
> >> >    in bool/tristate symbols using $(shell). I suspect it wouldn't be
> >> >    that tricky to figure out anyway.
> >>
> >>
> >> I think the right thing to do is
> >> to fix the code instead of advertising it.
> >
> > I don't think the behavior is all bad, just obscure. It could easily be
> > explained.
> 
> Some unrelated rambling on how Kconfig could've done it differently:
> 
> Currently, "n"/"m"/"y" are the canonical predefined tristate symbols.
> n/m/y just get transformed into those whenever they're looked up, as a
> syntactic shorthand (which has probably confused a lot of people).
> 
> Another option would've been to have three predefined ordinary symbols
> n/m/y, and get rid of "n"/"m"/"y". Then none of the constant (quoted)
> symbols would be "magic".
> 
> In practice, I think that'd just lead to breaking a different set of
> invariants though. You'd get three magic ordinary symbols instead of
> three magic constant symbols, and you'd end up with slightly iffy
> stuff like defined symbols that have no define location (and probably
> other stuff I haven't thought of). Conceptually, it makes sense to
> group n/m/y among the constant symbols.
> 
> So, I'm not sure changing things there would be an improvement.
> Strange as Kconfig is, some parts do actually kinda make sense at some
> level.
> 
> And if you're aware of how quotes and "n"/"m"/"y" work, and think that
> $() stuff ought to produce constant values (like I do... I'll stop
> nagging about it soon), then it makes to limit it to within "".
> 
> Cheers,
> Ulf

Here's how the description in kconfig-language.txt might look by the
way. It might clarify why I think it would be really simple:

	Within quotes, some simple forms of string interpolation are
	supported:
	
	  - $ENV is replaced by the value of the environment variable
	    ENV.

	  - $(success cmd) is replaced by "y" if the exit status of cmd
	    is 0, and with "n" otherwise. cmd is passed as-is to the
	    shell and may contain e.g. spaces or pipes.

	  - $(stdout cmd) is replaced by the first line cmd writes to
	    stdout. Like for $(success), cmd is passed as-is to the
	    shell.

	  - To avoid repetition, a custom macro can be defined as
	    follows:

	        macro my-macro "$(success cmd $(1) --flag $(2))"

	    $(my-macro foo bar) is then be replaced by
	    $(success cmd foo --flag bar), which is in turn replaced
	    by either "n" or "y".

	For bool and tristate symbols, note that "n", "m", and "y" are
	synonymous with n, m, and y (the latter are a syntactic
	shorthand for the former). This allows tests to be implemented
	as follows:

	    config CC_IS_GCC
	        def_bool "$(success $CC --version | grep -q gcc)"

	Assuming that CC is GCC, this would turn into

	    config CC_IS_GCC
		def_bool "y"

	Here's an example that makes use of $(stdout):

	    config DEFCONFIG_LIST
	        ...
		default "/boot/config-$(stdout uname --release)"
		...

	After expansion, this might turn into

	    config DEFCONFIG_LIST
	        ...
		default "/boot/config-4.13.0-32-generic"
	
	Note that this syntax also works for other contexts where
	quoted strings appear, e.g.

	    source "arch/$SRCARCH/Kconfig"


	String expansion is done during parsing, meaning you can't look
	up values of config symbols inside strings. Macros must be
	defined before the point where they are used.


It seems simple and gotcha-free to me. All the expansion got could be
done during tokenization.

Cheers,
Ulf
