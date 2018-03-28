Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522237671; cv=none;
        d=google.com; s=arc-20160816;
        b=gFzQbwlKzF4Sj728RNPTvZeqqSXMAwNN1Ef4I+E655iTtif61fU2BLesBtATTPw1XO
         VvYqssqe+GTLVp+yYGgnJM+6p/aRlx3kXeupodpYHE7jeFT1kQpaEZq9Ns1+MhzKwU/l
         FPUWUKJ5zwTld4yAltGQWqFcVZdD50u8SMFq39lIn66sjhauNjaoQ8ap42oBzCGy4NfA
         aFGMiYdeyaANBMOuRtAbW+cUUViZMCJj8JDnzFnIcZEuWnYfoiAYNrXvnyPad7xnPuut
         WxTxIwYTNLIT3I+CLq2gfl8CnMjZKcY6pdvWtgoJU7wMzZSI0qiaHgOjus1+/TSr5hi+
         up+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=FAgWcHMR3HfetGd1gIMFVBbc3KU1HRjboMPRyirwVNw=;
        b=HaH0M0wU6CebrG1wFZhpcqeV4fCusREsOs7obFnhCcq31WBUjJ/ykfkecZqd6AENum
         ipT+ifJ4ssgkaPckLmTaZQb+t9Df9OD1xae+kwoqCTK4rnNBYtUjjg0Lymp2GqDxaLXM
         6oLZx1Ab6684E8xtO/LtsVM3Ilbw7jL+kLP0hadlCXNcSYRfGNCiwRgzGCjy8lVTLb9G
         70d9R5WKVBcPSJDCM6s9PF4qKnPm1seebbDK1iVJw9JfS8j1PyFqCFgFrMF3VRQnMKMf
         K4cVv+/6+/9wbHfW00pMWaE8+HqWlHwkPBV7jeGb2Tc36aAfJj7yGeKWoelgwBwkDCJg
         7jPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Pl1UMHSB;
       dkim=pass header.i=@chromium.org header.s=google header.b=FuOS+6Z0;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Pl1UMHSB;
       dkim=pass header.i=@chromium.org header.s=google header.b=FuOS+6Z0;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4+g3WTnaZaEvS88rwRofyjMXmmzJPe8t1pqHSaeA416JNx05wj8vkpFN3tJRxjH5sL2+ihUTgih3iu48ATBXjk=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-21-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-21-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 04:47:50 -0700
X-Google-Sender-Auth: bm-CBd_BHcJlWiZfY3QYl1iT1IU
Message-ID: <CAGXu5jJQfYXqsF7pcRsUtY9Mrw+Yi_Y6+CBAwDrQT_4kpUiHDA@mail.gmail.com>
Subject: Re: [PATCH v2 20/21] gcc-plugins: enable GCC_PLUGINS for COMPILE_TEST
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067568210936951?=
X-GMAIL-MSGID: =?utf-8?q?1596181888955462955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The plugin availability is checked in Kconfig, so all{yes,mod}config
> will not be bothered.  Remove 'depends on !COMPILE_TEST'.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - Remove more 'depends on'
>
>  arch/Kconfig | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 88cc925..b07094c 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -414,7 +414,6 @@ menuconfig GCC_PLUGINS
>         bool "GCC plugins"
>         depends on HAVE_GCC_PLUGINS
>         depends on $(success $srctree/scripts/gcc-plugin.sh $HOSTCXX $CC)
> -       depends on !COMPILE_TEST
>         help
>           GCC plugins are loadable modules that provide extra features to the
>           compiler. They are useful for runtime instrumentation and static analysis.

This one is nice, yes! We get coverage for anyone with plugin support.

> @@ -424,7 +423,6 @@ menuconfig GCC_PLUGINS
>  config GCC_PLUGIN_CYC_COMPLEXITY
>         bool "Compute the cyclomatic complexity of a function" if EXPERT
>         depends on GCC_PLUGINS
> -       depends on !COMPILE_TEST
>         help
>           The complexity M of a function's control flow graph is defined as:
>            M = E - N + 2P
> @@ -487,7 +485,6 @@ config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
>  config GCC_PLUGIN_STRUCTLEAK_VERBOSE
>         bool "Report forcefully initialized variables"
>         depends on GCC_PLUGIN_STRUCTLEAK
> -       depends on !COMPILE_TEST
>         help
>           This option will cause a warning to be printed each time the
>           structleak plugin finds a variable it thinks needs to be
> @@ -527,7 +524,6 @@ config GCC_PLUGIN_RANDSTRUCT
>  config GCC_PLUGIN_RANDSTRUCT_PERFORMANCE
>         bool "Use cacheline-aware structure randomization"
>         depends on GCC_PLUGIN_RANDSTRUCT
> -       depends on !COMPILE_TEST
>         help
>           If you say Y here, the RANDSTRUCT randomization will make a
>           best effort at restricting randomization to cacheline-sized

All three of these, though, please leave as they were. They're either
needlessly noisy for COMPILE_TEST (GCC_PLUGIN_CYC_COMPLEXITY and
*_VERBOSE), or reduce the COMPILE_TEST coverage
(GCC_PLUGIN_RANDSTRUCT_PERFORMANCE).

(And perhaps a comment is needed to explain these to avoid confusion
in the future?)

-Kees

-- 
Kees Cook
Pixel Security
