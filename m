Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522237473; cv=none;
        d=google.com; s=arc-20160816;
        b=jLO7IJJsmyXgGN3b1HplBw0c4YW1HfjqRjX08UF2DKS+qDuugCWUAMNFWx8JLrtM/q
         EtlNiZvQBo097dMHc5GcnRH3xwm8arczEuPuXXcI09Tg+cpML5dcrQmKwyi/dYlgjEaV
         j/UCDLCzewwmYJjRW0Sgm/JruMS3LmDHCZWNvYmHO9OTSYgETsmi8hgJtaNnZYQpF4yk
         3sI2W7cy31pCcYk9CF7dCKgwAO979ML/kX+9b/qDHOsKEH5fYNN/fNtc3lNzbmXgW6dz
         hoFeGy76XL+33jpOgG0ZsE9g8PiOgDmUtsvlvk3RQIqu2EAn7DFQo/midauBBHW+GzcD
         /RYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=1+5uOATyFMmVV9uywZTpDnhaIM836Z9EdXeLsFl9o6w=;
        b=eNCOPpQgM5upeXGnvt9+eY9FbiyCaGmKAmZfUY45/j6z91WOMyP/Iw9wvUZN0PFMfI
         G86Z9cvU3h4ujXvQH9EfL0akXEV8o2hJPKsxvkDgi6oDcs50/Aid2T9/JzZVy2K5jOwU
         vLfanZ+euWxjx1Lfj6AYc3UnC1ewn9RkMFfgnCCtlWIi0XrpFNF69FaVSqzNh78rq9zn
         CJUfKRKg7oTa2XcfHZ1PRqRBoFJ+9OCANSqPxLv4LbkmX7itrBPI477MrJPN+b25JFDH
         ybOtjxXOSmelAtJnxg5OHCHLCmuJTiGe8BLM491NODBz4OsO+RanalAE2YKetemgwwFx
         y9HA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=VLpKKHUV;
       dkim=pass header.i=@chromium.org header.s=google header.b=T29Q9vd1;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=VLpKKHUV;
       dkim=pass header.i=@chromium.org header.s=google header.b=T29Q9vd1;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4987/nvsOIiYohP9oyS2ua44aPqZq4Mi7GDVW41+edkxY7Vh26Bg0yycSSGD3SUYTmiBewDeVgNZ/SxbUa7w/A=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-20-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-20-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 04:44:32 -0700
X-Google-Sender-Auth: BVfWeCvreBACn9Qbm96MH6wluwE
Message-ID: <CAGXu5jJB3AKMC8U--H61eUkFJeMogLMq00dBUUrfg4n2b4FbOQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/21] gcc-plugins: test GCC plugin support in Kconfig
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Emese Revfy <re.emese@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067545439308966?=
X-GMAIL-MSGID: =?utf-8?q?1596181680820496392?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Run scripts/gcc-plugin.sh from Kconfig.  Users can enable GCC_PLUGINS
> only when it is supported.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2: None
>
>  arch/Kconfig                 |  4 +++
>  scripts/Makefile.gcc-plugins | 82 ++++++++++++++++----------------------------
>  scripts/gcc-plugin.sh        |  1 -
>  3 files changed, 33 insertions(+), 54 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index b42378d..88cc925 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -407,9 +407,13 @@ config HAVE_GCC_PLUGINS
>           An arch should select this symbol if it supports building with
>           GCC plugins.
>
> +config CC_HAS_GCC_PLUGINS
> +       bool
> +

This doesn't seem used anywhere?

>  menuconfig GCC_PLUGINS
>         bool "GCC plugins"
>         depends on HAVE_GCC_PLUGINS
> +       depends on $(success $srctree/scripts/gcc-plugin.sh $HOSTCXX $CC)
>         depends on !COMPILE_TEST
>         help
>           GCC plugins are loadable modules that provide extra features to the
> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
> index 25da4c0..19d0d5b 100644
> --- a/scripts/Makefile.gcc-plugins
> +++ b/scripts/Makefile.gcc-plugins
> [...]
> -# If plugins aren't supported, abort the build before hard-to-read compiler
> -# errors start getting spewed by the main build.
> -PHONY += gcc-plugins-check
> -gcc-plugins-check: FORCE
> -ifdef CONFIG_GCC_PLUGINS
> -  ifeq ($(PLUGINCC),)
> -    ifneq ($(GCC_PLUGINS_CFLAGS),)
> -      $(Q)$(srctree)/scripts/gcc-plugin.sh --show-error $(HOSTCXX) $(CC) || true
> -      @echo "Cannot use CONFIG_GCC_PLUGINS: your gcc installation does not support plugins, perhaps the necessary headers are missing?" >&2 && exit 1

As mentioned in the other email, we lose the error reporting. Now the
lack of plugins is just a silent =n in menuconfig. Keeping
--show-error in the Kconfig call and retaining stderr would be nice.

I need to do some further testing with SANCOV, but otherwise this all
looks correct, and my testing shows it behaving correctly.

-Kees

-- 
Kees Cook
Pixel Security
