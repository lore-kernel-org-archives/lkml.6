Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx4+/DsIeisr/ucJR1CoohBH7g6ITMLLCZP0EWmonXGwowqxjQpFJF8oyyPK2gEEiHFnUFMKg
ARC-Seal: i=1; a=rsa-sha256; t=1523599429; cv=none;
        d=google.com; s=arc-20160816;
        b=PTvq1OZa8RbhtxGxm+ZFQsIt3CSrVpfHskoJlqD44YmPVB5EGx7elQIL78g8c9QueH
         6UMUzyNTq/7uVKpsrAVGgJZGmqg6HHyHJX/RN9ThgRhWwBjAA684uCu3dP+hTcJpsJjv
         /a2s3g2wm1ySTVRQXD4Mnc5eESzgn1QEuvHLPpwnyzoycZejtk6FD4P7z+Y+jYw3ZDPz
         zL/lYsvDKhhxf12aiEoi1Fjo9S2/fRiVZw/ia7Z5IGjZ6B6D/N13xUx2V8W4wwkQ45M+
         FmWd0z58mVAY4ooajo1/u5bk1MoD2Jk6UNt9a84IZxevg6yMSB1M2qykvGy5O/UKeYEo
         mcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=wEeu8oosbsND6/YeHDDaQnCv966W0O4E35VGcVqWLuw=;
        b=HuKcDk7OY9702zSLCRn4VqAg+vn+5/7dNgzEuwiPCnndYjnZpqH6rGODYjdHZyWKMo
         tr+V5CAjU5LZR08tBofHavrpDiz8gJ+TwxrHOelLoGuKyR2Cd6gBT95tBQNZkPNFCXjb
         8+tyf5rAWoHPOeruo26JGU2qYQC6Eoxszsz4+tm3ciL7tq/u7DQpH2ip78pNkgBPaA74
         YQIuMvHBVvqPKe2uK+zvdoS/Nmc0dXmitFmxT/SHPrNEobFyf17rSfCSE88zlrHgPdMz
         Ko6lznBLe3DZ2DtaHp5Zho+XacQMxqUvEZ+cOEuXztipx4eAVGboISyqAky7lXKFjxEc
         GThQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=qYc/Y0Nu;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=qYc/Y0Nu;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w3D63Rg8014290
X-Nifty-SrcIP: [209.85.213.43]
MIME-Version: 1.0
In-Reply-To: <CAFkk2KTpTXPzNpe6L33_a4YJ=DD0pwz+iEjvm-c1gVeCJGn_6w@mail.gmail.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-5-git-send-email-yamada.masahiro@socionext.com> <CAFkk2KTpTXPzNpe6L33_a4YJ=DD0pwz+iEjvm-c1gVeCJGn_6w@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 13 Apr 2018 15:02:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNASExWFQ3G_sKGkpnMJhXObeDd7UxfKuE-ZPfuqZfb0ypw@mail.gmail.com>
Message-ID: <CAK7LNASExWFQ3G_sKGkpnMJhXObeDd7UxfKuE-ZPfuqZfb0ypw@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] kconfig: reference environments directly and
 remove 'option env=' syntax
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538224428128?=
X-GMAIL-MSGID: =?utf-8?q?1597609795565063436?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-01 11:27 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> Here's a more in-depth review:
>
> On Tue, Mar 27, 2018 at 7:29 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> To get an environment value, Kconfig needs to define a symbol using
>> "option env=" syntax.  It is tedious to add a config entry for each
>> environment given that we need more environments such as 'CC', 'AS',
>
> "Environment variables" would be clearer. I've never seen them called
> "environments".
>
>> 'srctree' etc. to evaluate the compiler capability in Kconfig.
>>
>> Adding '$' to symbols is weird.  Kconfig can reference symbols directly
>> like this:
>>
>>   config FOO
>>           string
>>           default BAR
>>
>> So, I want to use the following syntax to get environment 'BAR' from
>> the system:
>>
>>   config FOO
>>           string
>>           default $BAR
>>
>> Looking at the code, the symbols prefixed with 'S' are expanded by:
>>  - conf_expand_value()
>>    This is used to expand 'arch/$ARCH/defconfig' and 'defconfig_list'
>>  - expand_string_value()
>>    This is used to expand strings in 'source' and 'mainmenu'
>>
>> All of them are fixed values independent of user configuration.  So,
>> this kind of syntax should be moved to simply take the environment.
>>
>> This change makes the code much cleaner.  The bounce symbols 'SRCARCH',
>> 'ARCH', 'SUBARCH', 'KERNELVERSION' are gone.
>>
>> sym_init() hard-coding 'UNAME_RELEASE' is also gone.  'UNAME_RELEASE'
>> should be be given from the environment.
>>
>> ARCH_DEFCONFIG is a normal symbol, so it should be simply referenced
>> by 'default ARCH_DEFCONFIG'.
>>
>> The environments are expanding in the lexer; when '$' is encountered,
>
> s/environments/environment variables/
>
>> it is expanded, and resulted strings are pushed back to the input
>> stream.  This makes the implementation simpler.
>>
>> For example, the following code works.
>>
>> [Example code]
>>
>>   config TOOLCHAIN_LIST
>>           string
>>           default "My tools: CC=$CC, AS=$AS, CPP=$CPP"
>>
>> [Result]
>>
>>   $ make -s alldefconfig && tail -n 1 .config
>>   CONFIG_TOOLCHAIN_LIST="My tools: CC=gcc, AS=as, CPP=gcc -E"
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> I tested all 'make *config' for arch architectures.
>> I confirmed this commit still produced the same result
>> (by my kconfig test tool).
>>
>>
>> Changes in v2:
>>   - Move the string expansion to the lexer phase.
>>   - Split environment helpers to env.c
>>
>>  Documentation/kbuild/kconfig-language.txt |  8 ---
>>  Kconfig                                   |  4 --
>>  Makefile                                  |  3 +-
>>  arch/sh/Kconfig                           |  4 +-
>>  arch/sparc/Kconfig                        |  4 +-
>>  arch/tile/Kconfig                         |  2 +-
>>  arch/um/Kconfig.common                    |  4 --
>>  arch/x86/Kconfig                          |  4 +-
>>  arch/x86/um/Kconfig                       |  4 +-
>>  init/Kconfig                              | 10 +---
>>  scripts/kconfig/confdata.c                | 31 +---------
>>  scripts/kconfig/env.c                     | 95 +++++++++++++++++++++++++++++++
>>  scripts/kconfig/kconf_id.c                |  1 -
>>  scripts/kconfig/lkc.h                     |  8 +--
>>  scripts/kconfig/menu.c                    |  3 -
>>  scripts/kconfig/symbol.c                  | 56 ------------------
>>  scripts/kconfig/util.c                    | 75 ++++++++----------------
>>  scripts/kconfig/zconf.l                   | 20 ++++++-
>>  scripts/kconfig/zconf.y                   |  2 +-
>>  19 files changed, 158 insertions(+), 180 deletions(-)
>>  create mode 100644 scripts/kconfig/env.c
>>
>> diff --git a/Documentation/kbuild/kconfig-language.txt b/Documentation/kbuild/kconfig-language.txt
>> index f5b9493..0e966e8 100644
>> --- a/Documentation/kbuild/kconfig-language.txt
>> +++ b/Documentation/kbuild/kconfig-language.txt
>> @@ -198,14 +198,6 @@ applicable everywhere (see syntax).
>>      enables the third modular state for all config symbols.
>>      At most one symbol may have the "modules" option set.
>>
>> -  - "env"=<value>
>> -    This imports the environment variable into Kconfig. It behaves like
>> -    a default, except that the value comes from the environment, this
>> -    also means that the behaviour when mixing it with normal defaults is
>> -    undefined at this point. The symbol is currently not exported back
>> -    to the build environment (if this is desired, it can be done via
>> -    another symbol).
>> -
>
> The new behavior needs to be documented later as well (but iirc you
> already mentioned that somewhere else).
>
>>    - "allnoconfig_y"
>>      This declares the symbol as one that should have the value y when
>>      using "allnoconfig". Used for symbols that hide other symbols.
>> diff --git a/Kconfig b/Kconfig
>> index 8c4c1cb..e6ece5b 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -5,8 +5,4 @@
>>  #
>>  mainmenu "Linux/$ARCH $KERNELVERSION Kernel Configuration"
>>
>> -config SRCARCH
>> -       string
>> -       option env="SRCARCH"
>> -
>>  source "arch/$SRCARCH/Kconfig"
>> diff --git a/Makefile b/Makefile
>> index 5c395ed..4ae1486 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -284,7 +284,8 @@ include scripts/Kbuild.include
>>  # Read KERNELRELEASE from include/config/kernel.release (if it exists)
>>  KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
>>  KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
>> -export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
>> +UNAME_RELEASE := $(shell uname --release)
>> +export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION UNAME_RELEASE
>>
>>  # SUBARCH tells the usermode build what the underlying arch is.  That is set
>>  # first, and if a usermode build is happening, the "ARCH=um" on the command
>> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
>> index 97fe293..14f3ef1 100644
>> --- a/arch/sh/Kconfig
>> +++ b/arch/sh/Kconfig
>> @@ -57,7 +57,7 @@ config SUPERH
>>           <http://www.linux-sh.org/>.
>>
>>  config SUPERH32
>> -       def_bool ARCH = "sh"
>> +       def_bool "$ARCH" = "sh"
>>         select HAVE_KPROBES
>>         select HAVE_KRETPROBES
>>         select HAVE_IOREMAP_PROT if MMU && !X2TLB
>> @@ -76,7 +76,7 @@ config SUPERH32
>>         select HAVE_CC_STACKPROTECTOR
>>
>>  config SUPERH64
>> -       def_bool ARCH = "sh64"
>> +       def_bool "$ARCH" = "sh64"
>>         select HAVE_EXIT_THREAD
>>         select KALLSYMS
>>
>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>> index 8767e45..86b852e 100644
>> --- a/arch/sparc/Kconfig
>> +++ b/arch/sparc/Kconfig
>> @@ -1,6 +1,6 @@
>>  config 64BIT
>> -       bool "64-bit kernel" if ARCH = "sparc"
>> -       default ARCH = "sparc64"
>> +       bool "64-bit kernel" if "$ARCH" = "sparc"
>> +       default "$ARCH" = "sparc64"
>>         help
>>           SPARC is a family of RISC microprocessors designed and marketed by
>>           Sun Microsystems, incorporated.  They are very widely found in Sun
>> diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
>> index ef9d403..acc2182 100644
>> --- a/arch/tile/Kconfig
>> +++ b/arch/tile/Kconfig
>> @@ -119,7 +119,7 @@ config HVC_TILE
>>  # Building with ARCH=tilegx (or ARCH=tile) implies using the
>>  # 64-bit TILE-Gx toolchain, so force CONFIG_TILEGX on.
>>  config TILEGX
>> -       def_bool ARCH != "tilepro"
>> +       def_bool "$ARCH" != "tilepro"
>>         select ARCH_SUPPORTS_ATOMIC_RMW
>>         select GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
>>         select HAVE_ARCH_JUMP_LABEL
>> diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
>> index c68add8..07f84c8 100644
>> --- a/arch/um/Kconfig.common
>> +++ b/arch/um/Kconfig.common
>> @@ -54,10 +54,6 @@ config HZ
>>         int
>>         default 100
>>
>> -config SUBARCH
>> -       string
>> -       option env="SUBARCH"
>> -
>>  config NR_CPUS
>>         int
>>         range 1 1
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 0fa71a7..986fb0a 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1,8 +1,8 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  # Select 32 or 64 bit
>>  config 64BIT
>> -       bool "64-bit kernel" if ARCH = "x86"
>> -       default ARCH != "i386"
>> +       bool "64-bit kernel" if "$ARCH" = "x86"
>> +       default "$ARCH" != "i386"
>>         ---help---
>>           Say yes to build a 64-bit kernel - formerly known as x86_64
>>           Say no to build a 32-bit kernel - formerly known as i386
>> diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
>> index 13ed827..d355413 100644
>> --- a/arch/x86/um/Kconfig
>> +++ b/arch/x86/um/Kconfig
>> @@ -16,8 +16,8 @@ config UML_X86
>>         select GENERIC_FIND_FIRST_BIT
>>
>>  config 64BIT
>> -       bool "64-bit kernel" if SUBARCH = "x86"
>> -       default SUBARCH != "i386"
>> +       bool "64-bit kernel" if $SUBARCH = "x86"
>> +       default $SUBARCH != "i386"
>>
>>  config X86_32
>>         def_bool !64BIT
>> diff --git a/init/Kconfig b/init/Kconfig
>> index df18492..b4814e6 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1,11 +1,3 @@
>> -config ARCH
>> -       string
>> -       option env="ARCH"
>> -
>> -config KERNELVERSION
>> -       string
>> -       option env="KERNELVERSION"
>> -
>>  config DEFCONFIG_LIST
>>         string
>>         depends on !UML
>> @@ -13,7 +5,7 @@ config DEFCONFIG_LIST
>>         default "/lib/modules/$UNAME_RELEASE/.config"
>>         default "/etc/kernel-config"
>>         default "/boot/config-$UNAME_RELEASE"
>> -       default "$ARCH_DEFCONFIG"
>> +       default ARCH_DEFCONFIG
>>         default "arch/$ARCH/defconfig"
>>
>>  config CONSTRUCTORS
>> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
>> index df26c7b..98c2014 100644
>> --- a/scripts/kconfig/confdata.c
>> +++ b/scripts/kconfig/confdata.c
>> @@ -81,39 +81,13 @@ const char *conf_get_autoconfig_name(void)
>>         return name ? name : "include/config/auto.conf";
>>  }
>>
>> -static char *conf_expand_value(const char *in)
>> -{
>> -       struct symbol *sym;
>> -       const char *src;
>> -       static char res_value[SYMBOL_MAXLENGTH];
>> -       char *dst, name[SYMBOL_MAXLENGTH];
>> -
>> -       res_value[0] = 0;
>> -       dst = name;
>> -       while ((src = strchr(in, '$'))) {
>> -               strncat(res_value, in, src - in);
>> -               src++;
>> -               dst = name;
>> -               while (isalnum(*src) || *src == '_')
>> -                       *dst++ = *src++;
>> -               *dst = 0;
>> -               sym = sym_lookup(name, 0);
>> -               sym_calc_value(sym);
>> -               strcat(res_value, sym_get_string_value(sym));
>> -               in = src;
>> -       }
>> -       strcat(res_value, in);
>> -
>> -       return res_value;
>> -}
>> -
>>  char *conf_get_default_confname(void)
>>  {
>>         struct stat buf;
>>         static char fullname[PATH_MAX+1];
>>         char *env, *name;
>>
>> -       name = conf_expand_value(conf_defname);
>> +       name = expand_string_value(conf_defname);
>>         env = getenv(SRCTREE);
>>         if (env) {
>>                 sprintf(fullname, "%s/%s", env, name);
>> @@ -274,7 +248,8 @@ int conf_read_simple(const char *name, int def)
>>                         if (expr_calc_value(prop->visible.expr) == no ||
>>                             prop->expr->type != E_SYMBOL)
>>                                 continue;
>> -                       name = conf_expand_value(prop->expr->left.sym->name);
>> +                       sym_calc_value(prop->expr->left.sym);
>> +                       name = sym_get_string_value(prop->expr->left.sym);
>>                         in = zconf_fopen(name);
>>                         if (in) {
>>                                 conf_message(_("using defaults found in %s"),
>> diff --git a/scripts/kconfig/env.c b/scripts/kconfig/env.c
>> new file mode 100644
>> index 0000000..9702f5c
>> --- /dev/null
>> +++ b/scripts/kconfig/env.c
>> @@ -0,0 +1,95 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// Copyright (C) 2018 Masahiro Yamada <yamada.masahiro@socionext.com>
>> +
>> +static LIST_HEAD(env_list);
>> +
>> +struct env {
>> +       char *name;
>> +       char *value;
>> +       struct list_head node;
>> +};
>> +
>> +static struct env *env_list_lookup(const char *name)
>> +{
>> +       struct env *e;
>> +
>> +       list_for_each_entry(e, &env_list, node) {
>> +               if (!strcmp(name, e->name))
>> +                       return e;
>> +       }
>> +
>> +       return NULL;
>> +}
>
> This function might be unnecessary -- see below.
>
>> +
>> +static void env_list_add(const char *name, const char *value)
>> +{
>> +       struct env *e;
>> +
>> +       e = xmalloc(sizeof(*e));
>> +       e->name = xstrdup(name);
>> +       e->value = xstrdup(value);
>> +
>> +       list_add_tail(&e->node, &env_list);
>> +}
>> +
>> +static void env_list_del(struct env *e)
>> +{
>> +       list_del(&e->node);
>> +       free(e->name);
>> +       free(e->value);
>> +       free(e);
>> +}
>> +
>> +/* the returned pointer must be freed when done */
>> +static char *env_expand(const char *name)
>
> This function is basically just getenv() with some dependency
> housekeeping added. A name like env_get() or env_lookup() would be
> clearer I think.
>
>> +{
>> +       struct env *e;
>> +       const char *value;
>> +
>
>> +       e = env_list_lookup(name);
>> +       if (e)
>> +               return xstrdup(e->value);
>
> Not sure this bit is needed. It is always safe to get the value from
> getenv(). See below.
>
>> +
>> +       value = getenv(name);
>> +       if (!value) {
>> +               fprintf(stderr, "environment variable \"%s\" undefined\n", name);
>> +               value = "";
>> +       }
>> +
>> +       /*
>> +        * we need to remember all referenced environments.
>
> s/environments/environment variables/
>
>> +        * They will be written out to include/config/auto.conf.cmd
>> +        */
>> +       env_list_add(name, value);
>
> AFAICS, we only need the following functionality:
>
>     1. Record referenced environment variables along with their value
>
>     2. Go through all the recorded environment variables and write
> dependency information
>
> For (1), I think it would be better to simply have env_list_add() (or
> some other suitable name) add the variable to the list if it isn't
> already there (like a kind of set). It is always safe to get the value
> of the environment variable from getenv(), and that seems less
> confusing.

I think this is a cached value
for frequently referenced environment variable
such as $(CC), $(srctree).


>> +
>> +       return xstrdup(value);
>
> The returned string is never modified, and the result from getenv()
> never gets stale, so I think the strdup() is unnecessary. The function
> could return a const char * to avoid accidental modification.


The expanded text is always freed when done.
This simplifies the implementation.


If X is defined as

   X = $(shell echo ABC)

The result of $(X) is an allocated string, which must be freed later.

If X is an environment variable, we could handle it as a read-only string,
but we are not allowed to free it.

If we do not do strdup(), we need to remember where it came from.



-- 
Best Regards
Masahiro Yamada
