Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx4/Optx3pxCXGUQVbjyjw2pisSQFnpkGhWFYnelrdpE7fyQmjMvWstrWExOi23JwJnBcgr4A
ARC-Seal: i=1; a=rsa-sha256; t=1522168807; cv=none;
        d=google.com; s=arc-20160816;
        b=Rq1LM1E5JKo29PG5/KaCV99gYgFXPD4dd8daYM8DHli16L1zzcTcjJVXSIRkRVMpJH
         M2rufyIO9oKKCFtwLV/Xl3cg5TgHAbNzB+J1kVRiVeO6pPopJffEPWy1zALO2Pl7uvTe
         BXBCs9+xGLpPAo0/TIuI4JQr/8mIooY1b4wt1LcWzZy0o6HAPJjDU+4y1QwB6aqvjQHH
         7pA1ongukJ+aMqiWhnJaDhVhgvJGVFwiEfdAeVNbMLVZM92k1iY0NoXxv3Oh2/2tKuFK
         hZQkffmxmuHLCrzgO+WsB2tv7v3OI8U/i3rNHsEqeYJmeXWSokRSA19X+nUWD1tAnyKh
         O5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=uN5xiltM1nI3XEn4SrAVEbRPsKduyLYF2eSb69kg3PA=;
        b=fZJzx9jSoUS79Ehz3YLZcM/oqD46YopveNrdWxjubgKTUTxW7neUPlXXYGrMNe3zkp
         Qsk141kQWdolbVZU6JlR6DbiAnlbv2QJHHsW4wzxGXFi3L2N/zB8hx7UTenEC18XtOGd
         x294KmC2+08kKR7j9SOczKCSTlhIgNkr0gtXkrl+iy122NvdxLaDURLArWGQOexwjzDJ
         xAxxaIHaVHmsCDCTrWE4aRglLS0SW2dy2dzVFn8Kdxh38Kc8tPE3sETaIm6hFUig+roE
         v9/VP5z3NSWHgEPnjIaZ0F0ujQDSMZLQAxPJ/J1hw3t8C4H1DHapeR0CLd92gMOG93zE
         +u4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Iqlkfpm3;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Iqlkfpm3;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w2RGdsmN016755
X-Nifty-SrcIP: [209.85.217.171]
MIME-Version: 1.0
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 28 Mar 2018 01:39:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR89KNWVbUBZiOP1Yv7V-0rGO3L3xKvza9hnHjn0DFJcw@mail.gmail.com>
Message-ID: <CAK7LNAR89KNWVbUBZiOP1Yv7V-0rGO3L3xKvza9hnHjn0DFJcw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] kconfig: move compiler capability tests to Kconfig
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Emese Revfy <re.emese@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067544503943402?=
X-GMAIL-MSGID: =?utf-8?q?1596109679683095991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-27 14:29 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>
> Here is v2 to start to move compiler capability tests to Kconfig.
>
> V1:
> https://lkml.org/lkml/2018/2/16/610
>
> I brushed up the implementation even more.
>
> Major changes for v2:
> [1] Environments and functions are expanded in the lexer (zconf.l)
>     The parser (zconf.y) receives expanded tokens.  This simplifies
>     the implementation.
>
> [2] Implement only one built-in function 'shell'.  This returns
>     stdout from the command.  We need something to return 'y' or 'n'.
>     This is now implemented as a macro 'success'.
>
> [3] Macros (user-defined function) are defined by 'macro' keyword
>     instead of string type symbol.
>
>     ex1) macro success $(shell ($(1) && echo y) || echo n)
>     ex2) macro cc-option $(success $CC -Werror $(1) -c -x c /dev/null -o /dev/null)
>
> My plan for v3
> --------------
>
> The MW is approaching, but I'd like to make it more lovely if
> I have some time.
>
> While I was writing these patches, I noticed a kind of similarity
> between Makefile and Kconfig.
>
> Makefile can define variables and functions to do text processing
> during the parse phase.  After parsing, it builds up dependency
> graph, and moves on to the execution phase.  Then, it generates
> objects as needed by checking time-stamps.
>
> [Makefile]
>
>   OBJ := foo.o
>   SRC := foo.c
>   CC := gcc
>
>   $(OBJ): $(SRC)
>             $(CC) -c -o $(OBJ) $(SRC)
>
> [Makefile after text processing]
>
>   foo.o: foo.c
>           gcc -c -o foo.o foo.c
>
> Now, we are adding tools for text processing to Kconfig.  Functions
> are statically expanded by the lexer.  After all source files are
> parsed, Kconfig moves on to the evaluation phase.  Then, users can
> tweak symbol values from menus.
>
> So, we should be able to describe Kconfig like follows:
>
> [Kconfig]
>
>    MY_SYMBOL := CC_STACKPROTECTOR
>    MY_PROMPT := "Stackprotector"
>    success = $(shell ($(1) && echo y) || echo n)
>    cc-option = $(success $CC -Werror $(1) -c -x c /dev/null -o /dev/null)
>
>    config $(MY_SYMBOL)
>            bool $(MY_PROMPT)
>            depends on $(cc-option -fstack-protector)
>
> [Kconfig after text processing]
>
>    config CC_STACKPROTECTOR
>            bool "Stackptector"
>            depends on y
>
> So, I think it is better to use '=' assignment for defining functions.
> I will remove the 'macro' keyword.
> Also, support variables.  A variable is a function with no argument.
> So, it will be easy to implement it as a sub-set of function feature.
> It is better to support two flavors of assignments, '=' and ':=' as well.
>
> Masahiro Yamada (21):
>   kbuild: remove kbuild cache
>   kbuild: remove CONFIG_CROSS_COMPILE support
>   kconfig: move and rename sym_expand_string_value()
>   kconfig: reference environments directly and remove 'option env='
>     syntax
>   kconfig: remove string expansion in file_lookup()
>   kconfig: remove string expansion for mainmenu after yyparse()
>   kconfig: add function support and implement 'shell' function
>   kconfig: replace $UNAME_RELEASE with function call
>   kconfig: add 'macro' keyword to support user-defined function
>   kconfig: add 'success' and 'cc-option' macros
>   stack-protector: test compiler capability in Kconfig and drop AUTO
>     mode
>   kconfig: show compiler version text in the top comment
>   kconfig: add CC_IS_GCC and GCC_VERSION
>   kconfig: add CC_IS_CLANG and CLANG_VERSION
>   gcov: remove CONFIG_GCOV_FORMAT_AUTODETECT
>   kcov: imply GCC_PLUGINS and GCC_PLUGIN_SANCOV instead of select'ing
>     them
>   gcc-plugins: always build plugins with C++
>   gcc-plugins: move GCC version check for PowerPC to Kconfig
>   gcc-plugins: test GCC plugin support in Kconfig
>   gcc-plugins: enable GCC_PLUGINS for COMPILE_TEST
>   arm64: move GCC version check for ARCH_SUPPORTS_INT128 to Kconfig
>
>  Documentation/kbuild/kconfig-language.txt |   8 --
>  Kconfig                                   |   4 +-
>  Makefile                                  | 103 ++------------
>  arch/Kconfig                              |  37 ++---
>  arch/arm64/Kconfig                        |   1 +
>  arch/arm64/Makefile                       |   2 -
>  arch/powerpc/Kconfig                      |   2 +-
>  arch/sh/Kconfig                           |   4 +-
>  arch/sparc/Kconfig                        |   4 +-
>  arch/tile/Kconfig                         |   2 +-
>  arch/um/Kconfig.common                    |   4 -
>  arch/x86/Kconfig                          |  12 +-
>  arch/x86/um/Kconfig                       |   4 +-
>  init/Kconfig                              |  44 +++---
>  kernel/gcov/Kconfig                       |  17 +--
>  kernel/gcov/Makefile                      |   2 -
>  lib/Kconfig.debug                         |   7 +-
>  scripts/Kbuild.include                    | 101 ++------------
>  scripts/Makefile.gcc-plugins              |  95 ++++---------
>  scripts/clang-version.sh                  |  24 ++--
>  scripts/gcc-plugin.sh                     |  37 +----
>  scripts/gcc-plugins/Makefile              |  15 +-
>  scripts/gcc-x86_32-has-stack-protector.sh |   7 +-
>  scripts/gcc-x86_64-has-stack-protector.sh |   5 -
>  scripts/kconfig/confdata.c                |  31 +---
>  scripts/kconfig/env.c                     |  95 +++++++++++++
>  scripts/kconfig/function.c                | 225 ++++++++++++++++++++++++++++++
>  scripts/kconfig/kconf_id.c                |   1 -
>  scripts/kconfig/lkc.h                     |   9 +-
>  scripts/kconfig/lkc_proto.h               |   7 +-
>  scripts/kconfig/menu.c                    |   3 -
>  scripts/kconfig/symbol.c                  | 109 ---------------
>  scripts/kconfig/util.c                    |  96 ++++++++++---
>  scripts/kconfig/zconf.l                   |  51 ++++++-
>  scripts/kconfig/zconf.y                   |  35 ++---
>  35 files changed, 608 insertions(+), 595 deletions(-)
>  create mode 100644 scripts/kconfig/env.c
>  create mode 100644 scripts/kconfig/function.c
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



For convenience, the whole of this series is available at
the following branch.

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 kconfig-shell-v2


-- 
Best Regards
Masahiro Yamada
