Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518048663; cv=none;
        d=google.com; s=arc-20160816;
        b=U9gezEwZK3eXoA+kt54qGm5NASLYttQ7TWdk4QXl5yzevSci5g3t/60xoJI3YrEnTg
         evKC1dwzSsxdIyWTeb2Y8BvTr0oeWvbbxwecQZIAKLhQcvvYC4VeTF3vnuB7kKWq9PXo
         gvacACTeFutkcZUlHW/xybHjVXH0OuBhZv605hN2fD+zIQC4aDRDNgSjB7Xo7xjh30Ju
         l+69rDklmxE3rulKAxpnHBwHZgB6GOOTC+eDzHWZvSz9/Wn29tPKrKVdydI9301pxKMU
         VW7oz6MholPL0X9fKAJ1S7GTKDIACl+kIwYq7qvrj0vvwdAb1TSV5qBWNBCR2RDG8O1s
         DJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=aFdy+HeSNF1riVMJLvJuxFTengPfyrWMy7/Am5rV/Q4=;
        b=XF+GDpSK8vIoVMGEFvzNIGYnkvtZKyV4ip/V62Duvq2+bWGmiSYYHfwJZqcBgAVtUq
         x1vZ+ITsYE6Bnf1UpfOakcYF6iNk+4ANAoMomGqJrTn45bcCG3a0RbvqH5zIdy+B6wWH
         8U4idFQjcu5H9qU66vOQLMmBP0Pyo7+OSftEWosy8Rq++owts1GrAo8SqmbLYf5EK8Xt
         nRyV5AYhkPlBQR0ERXK+bIQd36bc6aCvkdEsXEshbm81ycxzDX53tnYes2annHRw1Vol
         0SoDnj6xpLSR8bizRIrYQMPEKbANN1gAIsEzlphjcjfpuphAQcT+ufYpXjQ336r8Z4z+
         U9qg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KCc5QlWo;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KCc5QlWo;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225bAD15cXUqq8keuS8DKG3om0Q5MPfGaHkZwmcjD3GzolNr6gqyphGFuN/KSsYaeYN3h0WLYGopbeNYBX6c1u4=
MIME-Version: 1.0
In-Reply-To: <1517877294-4826-12-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com> <1517877294-4826-12-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 8 Feb 2018 01:11:02 +0100
Message-ID: <CAFkk2KT9buoga9RbwQJpXdmE1tYLwha6vAT70KCbjPZb1PVm8A@mail.gmail.com>
Subject: Re: [PATCH 11/14] kconfig: test: check .config sanity for choice
 values with unmet dep
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778788390389?=
X-GMAIL-MSGID: =?utf-8?q?1591789395799598729?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 1:34 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> I fixed a problem where "# CONFIG_..." for choice values are wrongly
> written into the .config file when they are once visible, then become
> invisible later.
>
> Add a test for this subtle case.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig     | 14 ++++++++++++++
>  scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py | 17 +++++++++++++++++
>  scripts/kconfig/tests/no_write_if_dep_unmet/config      |  1 +
>  .../kconfig/tests/no_write_if_dep_unmet/expected_config |  5 +++++
>  4 files changed, 37 insertions(+)
>  create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig
>  create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
>  create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/config
>  create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
>
> diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig b/scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig
> new file mode 100644
> index 0000000..c00b8fe
> --- /dev/null
> +++ b/scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig
> @@ -0,0 +1,14 @@
> +config A
> +       bool "A"
> +
> +choice
> +       prompt "Choice ?"
> +       depends on A
> +
> +config CHOICE_B
> +       bool "Choice B"
> +
> +config CHOICE_C
> +       bool "Choice C"
> +
> +endchoice
> diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py b/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
> new file mode 100644
> index 0000000..d096622
> --- /dev/null
> +++ b/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
> @@ -0,0 +1,17 @@
> +"""
> +Do not write choice values to .config if the dependency is unmet
> +================================================================
> +
> +"# CONFIG_... is not set" should not be written into the .config file
> +for symbols with unmet dependency.
> +
> +This was not working correctly for choice values because choice needs
> +a bit different symbol computation.
> +
> +This checks that no unneeded "# COFIG_... is not set" is contained in
> +the .config file.
> +"""
> +
> +def test(conf):
> +    assert conf.oldaskconfig('config', 'n') == 0
> +    assert conf.config_matches('expected_config')
> diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/config b/scripts/kconfig/tests/no_write_if_dep_unmet/config
> new file mode 100644
> index 0000000..abd280e
> --- /dev/null
> +++ b/scripts/kconfig/tests/no_write_if_dep_unmet/config
> @@ -0,0 +1 @@
> +CONFIG_A=y
> diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config b/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
> new file mode 100644
> index 0000000..0d15e41
> --- /dev/null
> +++ b/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
> @@ -0,0 +1,5 @@
> +#
> +# Automatically generated file; DO NOT EDIT.
> +# Linux Kernel Configuration
> +#
> +# CONFIG_A is not set
> --
> 2.7.4
>

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>

This indirectly tests that choices specified without a type get the
type of the first choice value specified with a type too.

Cheers,
Ulf
