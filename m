Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518047835; cv=none;
        d=google.com; s=arc-20160816;
        b=Td22hTL7v2DiIWLEN/bA2o6PydSUHuwkO9mxSQtnK1LgD46eZXTcVmNdQV5xxWwOrR
         dPbvniOHID8gR8VepxmyoPkVW/mJi0N592EWJ5vN3fNUTAAb+DgwZ8cDjrKzgmgH6tyc
         GsI/CDSD6GSoFQtfpf9V4ystUvK4YhTStHFSB/a5gWNqOqXgm8TF8uf3rgxmOhu2sliF
         BRl8SSDuqWAYZY6IHHGTDRRic3FSk3tr0/22d0KygpbCcXGr+dkBfsxttZko5TwF5NyM
         70iqiYazoVCohrVoNv/b5wJ2CEcktdvV43RPoSzBsBYOVH44izBkgbCMtWeYmjzMDjNB
         kTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=5yqcdVUVD3gDoEipYjAd5MvS4tCC8WchoCLYolwH3Qk=;
        b=I1Sq5x4SgbGtafi6Bbyqkz0wQjMNg0kZpTXPWlFqWi7mxr7O2ERQzWEm9HzUjRz0lA
         QVodZv2ptm7NG2UVVfLl9cOqN1czrP6wRybQAy4vBdGv1i+XVRPoLBo4ha+YRhk4CILW
         kWHxKOXPuessvyuKgHOwgQ63SPnRlnOsrHz/JPBaq4LZAseuYbOgpvefXocKRfpNpXth
         35Z3Qg/YrCEMCByT+rg8hKEnVDRwGT9vVSnOadQQ84AOsYmgcPdD48HAjZn8DIqJfENb
         aOfU8tPHDmY0A1yvlQZokPt+yKRYuyyhDwRIDUhY5vOVyfNJ8VjWEVyVZL5XoEqYLvb4
         3+8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Hyl0oKA+;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Hyl0oKA+;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225e1Bo21X6vsSOajnbaZaUlVDUsw+lbhPl6rbqzekuqcRXEfh9ZHzG/LvK2ELTMwsTOhBfKP4E+XExIZDwq17M=
MIME-Version: 1.0
In-Reply-To: <1517877294-4826-9-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com> <1517877294-4826-9-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 8 Feb 2018 00:57:14 +0100
Message-ID: <CAFkk2KQr71Z_kwbC8BqKp1qQrvsVSWiGwGgXWcWLBJFCod-LZQ@mail.gmail.com>
Subject: Re: [PATCH 08/14] kconfig: test: add basic 'choice' tests
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778784557400?=
X-GMAIL-MSGID: =?utf-8?q?1591788526334049920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 1:34 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The calculation of 'choice' is a bit complicated part in Kconfig.
>
> The behavior of 'y' choice is intuitive.  If choice values are tristate,
> the choice can be 'm' where each value can be enabled independently.
> Also, if a choice is marked as 'optional', the whole choice can be
> invisible.
>
> Test basic functionality of choice.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/kconfig/tests/choice/Kconfig               | 54 ++++++++++++++++++++++
>  scripts/kconfig/tests/choice/__init__.py           | 37 +++++++++++++++
>  .../kconfig/tests/choice/alldef_expected_config    |  5 ++
>  .../kconfig/tests/choice/allmod_expected_config    |  9 ++++
>  scripts/kconfig/tests/choice/allno_expected_config |  5 ++
>  .../kconfig/tests/choice/allyes_expected_config    |  9 ++++
>  .../kconfig/tests/choice/oldask0_expected_stdout   | 10 ++++
>  scripts/kconfig/tests/choice/oldask1_config        |  2 +
>  .../kconfig/tests/choice/oldask1_expected_stdout   | 15 ++++++
>  9 files changed, 146 insertions(+)
>  create mode 100644 scripts/kconfig/tests/choice/Kconfig
>  create mode 100644 scripts/kconfig/tests/choice/__init__.py
>  create mode 100644 scripts/kconfig/tests/choice/alldef_expected_config
>  create mode 100644 scripts/kconfig/tests/choice/allmod_expected_config
>  create mode 100644 scripts/kconfig/tests/choice/allno_expected_config
>  create mode 100644 scripts/kconfig/tests/choice/allyes_expected_config
>  create mode 100644 scripts/kconfig/tests/choice/oldask0_expected_stdout
>  create mode 100644 scripts/kconfig/tests/choice/oldask1_config
>  create mode 100644 scripts/kconfig/tests/choice/oldask1_expected_stdout
>
> diff --git a/scripts/kconfig/tests/choice/Kconfig b/scripts/kconfig/tests/choice/Kconfig
> new file mode 100644
> index 0000000..cc60e9c
> --- /dev/null
> +++ b/scripts/kconfig/tests/choice/Kconfig
> @@ -0,0 +1,54 @@
> +config MODULES
> +       bool "Enable loadable module support"
> +       option modules
> +       default y
> +
> +choice
> +       prompt "boolean choice"
> +       default BOOL_CHOICE1
> +
> +config BOOL_CHOICE0
> +       bool "choice 0"
> +
> +config BOOL_CHOICE1
> +       bool "choice 1"
> +
> +endchoice
> +
> +choice
> +       prompt "optional boolean choice"
> +       optional
> +       default OPT_BOOL_CHOICE1
> +
> +config OPT_BOOL_CHOICE0
> +       bool "choice 0"
> +
> +config OPT_BOOL_CHOICE1
> +       bool "choice 1"
> +
> +endchoice
> +
> +choice
> +       prompt "tristate choice"
> +       default TRI_CHOICE1
> +
> +config TRI_CHOICE0
> +       tristate "choice 0"
> +
> +config TRI_CHOICE1
> +       tristate "choice 1"
> +
> +endchoice
> +
> +choice
> +       prompt "optional tristate choice"
> +       optional
> +       default OPT_TRI_CHOICE1
> +
> +config OPT_TRI_CHOICE0
> +       tristate "choice 0"
> +
> +config OPT_TRI_CHOICE1
> +       tristate "choice 1"
> +
> +endchoice
> diff --git a/scripts/kconfig/tests/choice/__init__.py b/scripts/kconfig/tests/choice/__init__.py
> new file mode 100644
> index 0000000..42022ac
> --- /dev/null
> +++ b/scripts/kconfig/tests/choice/__init__.py
> @@ -0,0 +1,37 @@
> +"""
> +Basic choice tests
> +==================
> +
> +The handling of 'choice' is a bit complicated part in Kconfig.
> +
> +The behavior of 'y' choice is intuitive.  If choice values are tristate,
> +the choice can be 'm' where each value can be enabled independently.
> +Also, if a choice is marked as 'optional', the whole choice can be
> +invisible.
> +
> +Test basic functionality of choice.
> +"""
> +
> +def test_oldask0(conf):
> +    assert conf.oldaskconfig() == 0
> +    assert conf.stdout_contains('oldask0_expected_stdout')
> +
> +def test_oldask1(conf):
> +    assert conf.oldaskconfig('oldask1_config') == 0
> +    assert conf.stdout_contains('oldask1_expected_stdout')
> +
> +def test_allyes(conf):
> +    assert conf.allyesconfig() == 0
> +    assert conf.config_contains('allyes_expected_config')
> +
> +def test_allmod(conf):
> +    assert conf.allmodconfig() == 0
> +    assert conf.config_contains('allmod_expected_config')
> +
> +def test_allno(conf):
> +    assert conf.allnoconfig() == 0
> +    assert conf.config_contains('allno_expected_config')
> +
> +def test_alldef(conf):
> +    assert conf.alldefconfig() == 0
> +    assert conf.config_contains('alldef_expected_config')
> diff --git a/scripts/kconfig/tests/choice/alldef_expected_config b/scripts/kconfig/tests/choice/alldef_expected_config
> new file mode 100644
> index 0000000..7a754bf
> --- /dev/null
> +++ b/scripts/kconfig/tests/choice/alldef_expected_config
> @@ -0,0 +1,5 @@
> +CONFIG_MODULES=y
> +# CONFIG_BOOL_CHOICE0 is not set
> +CONFIG_BOOL_CHOICE1=y
> +# CONFIG_TRI_CHOICE0 is not set
> +# CONFIG_TRI_CHOICE1 is not set
> diff --git a/scripts/kconfig/tests/choice/allmod_expected_config b/scripts/kconfig/tests/choice/allmod_expected_config
> new file mode 100644
> index 0000000..f1f5dcd
> --- /dev/null
> +++ b/scripts/kconfig/tests/choice/allmod_expected_config
> @@ -0,0 +1,9 @@
> +CONFIG_MODULES=y
> +# CONFIG_BOOL_CHOICE0 is not set
> +CONFIG_BOOL_CHOICE1=y
> +# CONFIG_OPT_BOOL_CHOICE0 is not set
> +CONFIG_OPT_BOOL_CHOICE1=y
> +CONFIG_TRI_CHOICE0=m
> +CONFIG_TRI_CHOICE1=m
> +CONFIG_OPT_TRI_CHOICE0=m
> +CONFIG_OPT_TRI_CHOICE1=m
> diff --git a/scripts/kconfig/tests/choice/allno_expected_config b/scripts/kconfig/tests/choice/allno_expected_config
> new file mode 100644
> index 0000000..b88ee7a
> --- /dev/null
> +++ b/scripts/kconfig/tests/choice/allno_expected_config
> @@ -0,0 +1,5 @@
> +# CONFIG_MODULES is not set
> +# CONFIG_BOOL_CHOICE0 is not set
> +CONFIG_BOOL_CHOICE1=y
> +# CONFIG_TRI_CHOICE0 is not set
> +CONFIG_TRI_CHOICE1=y
> diff --git a/scripts/kconfig/tests/choice/allyes_expected_config b/scripts/kconfig/tests/choice/allyes_expected_config
> new file mode 100644
> index 0000000..e5a062a
> --- /dev/null
> +++ b/scripts/kconfig/tests/choice/allyes_expected_config
> @@ -0,0 +1,9 @@
> +CONFIG_MODULES=y
> +# CONFIG_BOOL_CHOICE0 is not set
> +CONFIG_BOOL_CHOICE1=y
> +# CONFIG_OPT_BOOL_CHOICE0 is not set
> +CONFIG_OPT_BOOL_CHOICE1=y
> +# CONFIG_TRI_CHOICE0 is not set
> +CONFIG_TRI_CHOICE1=y
> +# CONFIG_OPT_TRI_CHOICE0 is not set
> +CONFIG_OPT_TRI_CHOICE1=y
> diff --git a/scripts/kconfig/tests/choice/oldask0_expected_stdout b/scripts/kconfig/tests/choice/oldask0_expected_stdout
> new file mode 100644
> index 0000000..b251bba
> --- /dev/null
> +++ b/scripts/kconfig/tests/choice/oldask0_expected_stdout
> @@ -0,0 +1,10 @@
> +Enable loadable module support (MODULES) [Y/n/?] (NEW)
> +boolean choice
> +  1. choice 0 (BOOL_CHOICE0) (NEW)
> +> 2. choice 1 (BOOL_CHOICE1) (NEW)
> +choice[1-2?]:
> +optional boolean choice [N/y/?] (NEW)
> +tristate choice [M/y/?] (NEW)
> +  choice 0 (TRI_CHOICE0) [N/m/?] (NEW)
> +  choice 1 (TRI_CHOICE1) [N/m/?] (NEW)
> +optional tristate choice [N/m/y/?] (NEW)
> diff --git a/scripts/kconfig/tests/choice/oldask1_config b/scripts/kconfig/tests/choice/oldask1_config
> new file mode 100644
> index 0000000..b67bfe3
> --- /dev/null
> +++ b/scripts/kconfig/tests/choice/oldask1_config
> @@ -0,0 +1,2 @@
> +# CONFIG_MODULES is not set
> +CONFIG_OPT_BOOL_CHOICE0=y
> diff --git a/scripts/kconfig/tests/choice/oldask1_expected_stdout b/scripts/kconfig/tests/choice/oldask1_expected_stdout
> new file mode 100644
> index 0000000..c2125e9b
> --- /dev/null
> +++ b/scripts/kconfig/tests/choice/oldask1_expected_stdout
> @@ -0,0 +1,15 @@
> +Enable loadable module support (MODULES) [N/y/?]
> +boolean choice
> +  1. choice 0 (BOOL_CHOICE0) (NEW)
> +> 2. choice 1 (BOOL_CHOICE1) (NEW)
> +choice[1-2?]:
> +optional boolean choice [Y/n/?] (NEW)
> +optional boolean choice
> +> 1. choice 0 (OPT_BOOL_CHOICE0)
> +  2. choice 1 (OPT_BOOL_CHOICE1) (NEW)
> +choice[1-2?]:
> +tristate choice
> +  1. choice 0 (TRI_CHOICE0) (NEW)
> +> 2. choice 1 (TRI_CHOICE1) (NEW)
> +choice[1-2?]:
> +optional tristate choice [N/y/?]
> --
> 2.7.4
>

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
