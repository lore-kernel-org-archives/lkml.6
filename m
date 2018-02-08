Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518114965; cv=none;
        d=google.com; s=arc-20160816;
        b=O/Wm82R4NsONsG0zIzQ4ks+qQpMnuaVrXp4UzKh2e3bz+9jIHPeBAlH13BGVQpnMrr
         CJEH/eahjb9NC+AXc+hPayHk/b2uWDNIRiNi961axX4Zbocf7qUvT3LCFK0zneKWcroh
         A3CCcuJzmE1+J89rvRAi0crbAvW+iy39oJRxHW1XpN+pUXiGvX2eROBtmdGwvRYeu6N/
         k4jPznKkLM6CGoWB1GGbS6sLW34W457Jp0S9uFHPm8cWVdfg6ckWleprvAtpImJWUdWm
         qpO6VGD86wew1EQny39f3iuLzf8OlK8xgYa8NXeW9OuyFQT3OD5GhzndxwctZ6cBkR5Q
         Pfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=SdNfOkXEeTYB5wezLE6N5+DqwxbhJXkEycqPOwbUByc=;
        b=VfyaNXXi11oXSePtu9fdh+toyiO7nBM2dgK/pVmUoyW1y0RhEYRoo6lFTNM9/ky/mU
         jT/XtrW3s1Iu1SSBfxuzqKHaMpkY9Cc58pdP5Yrx6ldIwKMr+k3Y5/UY9tGUF/e0B9EC
         JVTnHs2xTpxzmBiIuhbK6q2g3GuzTAP+4uco6yS/KHdR53j8k2rtlIwWo593XhP34RnK
         eot0I652lAWi4fVyl9mu9iBSVsHOndX0Y5FGFzfOqchj4MQTzioc/ZHgSlXRMzpAocCC
         Ny+N+tTUwpGflILS5EasuHJMvS/xQ4DKQ3PqyYmkj262BN/2Gs+A1mAJDc0k7FzV29p2
         KCTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=UCdJHv+o;
       dkim=pass header.i=@chromium.org header.s=google header.b=datZatZN;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=UCdJHv+o;
       dkim=pass header.i=@chromium.org header.s=google header.b=datZatZN;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x227D3DLBrA+AGnjAj/1EgFvuLlVUKWKjJvClvoCA9zSGlIWcMGkEfVQFR/tkbe6/kdWPnpA6EeazPEGIekMTYTQ=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1518106752-29228-8-git-send-email-yamada.masahiro@socionext.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com> <1518106752-29228-8-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 9 Feb 2018 05:30:46 +1100
X-Google-Sender-Auth: HNJvJJZz-FrX4TdxfiFMQZKeUeA
Message-ID: <CAGXu5jJ02qRCcqTK_M9sFtekizz+0WoHBCBKF_mh-A870eg6eg@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] Test stackprotector options in Kconfig to kill CC_STACKPROTECTOR_AUTO
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Ulf Magnusson <ulfalizer@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>,
	linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368439232985?=
X-GMAIL-MSGID: =?utf-8?q?1591858918184711345?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 3:19 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Add CC_HAS_STACKPROTECTOR(_STRONG) and proper dependency.
>
> I re-arranged the choice values, _STRONG, _REGULAR, _NONE in this order
> because the default of choice is the first visible symbol.
> [...]
> +# is this necessary?
> +#ifeq ($(CONFIG_CC_STACKPROTECTOR_NONE),y)
> +#KBUILD_CFLAGS += -fno-stack-protector
> +#endif

Yes, and also in the case of a broken stack protector, because some
compilers enable stack protector by default, so if we've selected it
to be NONE or detected it as broken, we need to force it off in the
compiler.

> +# TODO: run scripts/gcc-$(SRCARCH)_$(BITS)-has-stack-protector.sh from Kconfig

FWIW, this is the part that I got stuck on.
gcc-$(SRCARCH)_$(BITS)-has-stack-protector.sh depends on the KBUILD
flags that got built up and detected up to this point in the Makefile,
so I couldn't find a way to run it out of Kconfig since it didn't know
what the KBUILD flags were yet.

> +
>  ifeq ($(cc-name),clang)
>  KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 76c0b54..50723d8 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -538,10 +538,20 @@ config HAVE_CC_STACKPROTECTOR
>           - its compiler supports the -fstack-protector option
>           - it has implemented a stack canary (e.g. __stack_chk_guard)
>
> +config CC_HAS_STACKPROTECTOR
> +       bool
> +       option shell="$CC -Werror -fstack-protector -c -x c /dev/null"
> +
> +config CC_HAS_STACKPROTECTOR_STRONG
> +       bool
> +       option shell="$CC -Werror -fstack-protector-strong -c -x c /dev/null"

I'm nervous we'll get tripped up here, since $CC may not include the
right $(KBUILD_CPPFLAGS) and $(CC_OPTION_CFLAGS) as in cc-option, both
of which are calculated during the Makefile run. But maybe it won't be
a problem in actual use.

> +
> +config CC_STACKPROTECTOR
> +       bool
> +
>  choice
>         prompt "Stack Protector buffer overflow detection"
>         depends on HAVE_CC_STACKPROTECTOR
> -       default CC_STACKPROTECTOR_AUTO
>         help
>           This option turns on the "stack-protector" GCC feature. This
>           feature puts, at the beginning of functions, a canary value on
> @@ -551,26 +561,10 @@ choice
>           overwrite the canary, which gets detected and the attack is then
>           neutralized via a kernel panic.
>
> -config CC_STACKPROTECTOR_NONE
> -       bool "None"
> -       help
> -         Disable "stack-protector" GCC feature.
> -
> -config CC_STACKPROTECTOR_REGULAR
> -       bool "Regular"
> -       help
> -         Functions will have the stack-protector canary logic added if they
> -         have an 8-byte or larger character array on the stack.
> -
> -         This feature requires gcc version 4.2 or above, or a distribution
> -         gcc with the feature backported ("-fstack-protector").
> -
> -         On an x86 "defconfig" build, this feature adds canary checks to
> -         about 3% of all kernel functions, which increases kernel code size
> -         by about 0.3%.
> -
>  config CC_STACKPROTECTOR_STRONG
>         bool "Strong"
> +       depends on CC_HAS_STACKPROTECTOR_STRONG
> +       select CC_STACKPROTECTOR
>         help
>           Functions will have the stack-protector canary logic added in any
>           of the following conditions:
> @@ -588,11 +582,25 @@ config CC_STACKPROTECTOR_STRONG
>           about 20% of all kernel functions, which increases the kernel code
>           size by about 2%.
>
> -config CC_STACKPROTECTOR_AUTO
> -       bool "Automatic"
> +config CC_STACKPROTECTOR_REGULAR
> +       bool "Regular"
> +       depends on CC_HAS_STACKPROTECTOR
> +       select CC_STACKPROTECTOR
> +       help
> +         Functions will have the stack-protector canary logic added if they
> +         have an 8-byte or larger character array on the stack.
> +
> +         This feature requires gcc version 4.2 or above, or a distribution
> +         gcc with the feature backported ("-fstack-protector").
> +
> +         On an x86 "defconfig" build, this feature adds canary checks to
> +         about 3% of all kernel functions, which increases kernel code size
> +         by about 0.3%.
> +
> +config CC_STACKPROTECTOR_NONE
> +       bool "None"
>         help
> -         If the compiler supports it, the best available stack-protector
> -         option will be chosen.
> +         Disable "stack-protector" GCC feature.
>
>  endchoice

I continue to love the idea, but we can't know a given ssp option is
_working_ until we run the test script, which may depend on compiler
flags. Regardless, I'll give this series a try and see if I can fix
anything I trip over. I've got a lot of notes on testing after getting
..._AUTO working. Whatever happens, I hugely prefer having the
automatic selection possible in the Kconfig! Thanks for working on
this! :)

-Kees

-- 
Kees Cook
Pixel Security
