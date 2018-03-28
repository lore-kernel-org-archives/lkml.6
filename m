Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522236660; cv=none;
        d=google.com; s=arc-20160816;
        b=zkiycbxZlfqPsh0kaEbFZtaGttHbPpuz/kbyzc5MtLD4STLsQSj57Cox5pHLeowUxO
         oLzvyGAH9DexwQ2MznTSJgiY5p2En2WG1Orm8zAyUPGu2KCTCH6cT96kS6A/S5TxISdc
         IB+GaDIJQPxnkLp4uTwVf49Utw23WdNxdgffRhzsw2GkBj8FaduRB1EBD8bBDlGNPmXh
         zQXF87Toztpj1+2ZMu/+o5sSbKI/UFAtyajIcnTr+0vRliWew13n7IXQbunZyCb9WJyQ
         hP63KJj/AaJ2Zp0Y7T/rmX2ydzZx+rKYqLgCo8flXCKvNKCZOvBHPxRB5wyc5psHk3IX
         Vs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Qy+9YcLlsKmURIYVduJrOTcaOq8ClTGwNMLz7CTX/ZY=;
        b=STXBRuki7I7FWPGmcl+w/T3B4y+aoqBORWNsB5rC6epoHktTMXY+anmFRTWpjYX9i+
         N08xfH9WJCI4SqSndHXeFYzKMfnPSy5Kd/JklPmR53dBpc20nptSp/5T+WqRMX0cb3vg
         cxkqTV2Y3qV2m36OxV7B5DI5+9keIgPq6Eh2lDjJM5qnZUvmrK6pS+ad3nSHbsoXORyL
         9PWsJleMRB1+z3sGE8cmv9zJGNVlEfdVAGXBme6WPWE4DRzUThEcpUuLfN8Apx2Ww0h9
         9C3JISwKOOKbWPnnLHAcmFzKXaBRFVijebyo0MBAVeVb1fckKoOuY57TaFKB5PQ8xRrP
         ObzA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=RkjbxsZW;
       dkim=pass header.i=@chromium.org header.s=google header.b=Ppx4NfQ3;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=RkjbxsZW;
       dkim=pass header.i=@chromium.org header.s=google header.b=Ppx4NfQ3;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx497swgZCRQEnemtTNak9XF4cBmUFLab/3wn+D1rs3s8+mEP7+G1YSFdcqhhYWKHvo+zcajljmyGKvO9BoI8x+k=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-19-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-19-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 04:30:59 -0700
X-Google-Sender-Auth: vTK08mkU7Ie4CO1ncu1gZkjHj58
Message-ID: <CAGXu5jJrd2w5ys6tfwH6zd6dpep65XuV3wCZs=hUi=p5nbjDHw@mail.gmail.com>
Subject: Re: [PATCH v2 18/21] gcc-plugins: move GCC version check for PowerPC
 to Kconfig
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Emese Revfy <re.emese@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067545737829576?=
X-GMAIL-MSGID: =?utf-8?q?1596180829236776023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> For PowerPC, GCC 5.2 is the requirement for GCC plugins.  Move the
> version check to Kconfig so that the GCC plugin menus will be hidden
> if an older compiler is in use.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> ---
>
> Changes in v2: None
>
>  arch/powerpc/Kconfig         | 2 +-
>  scripts/Makefile.gcc-plugins | 8 --------
>  2 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 73ce5dd..b8474c2 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -195,7 +195,7 @@ config PPC
>         select HAVE_FTRACE_MCOUNT_RECORD
>         select HAVE_FUNCTION_GRAPH_TRACER
>         select HAVE_FUNCTION_TRACER
> -       select HAVE_GCC_PLUGINS
> +       select HAVE_GCC_PLUGINS                 if GCC_VERSION >= 50200
>         select HAVE_GENERIC_GUP
>         select HAVE_HW_BREAKPOINT               if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
>         select HAVE_IDE
> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
> index b0f9108..25da4c0 100644
> --- a/scripts/Makefile.gcc-plugins
> +++ b/scripts/Makefile.gcc-plugins
> @@ -56,14 +56,6 @@ gcc-plugins-check: FORCE
>  ifdef CONFIG_GCC_PLUGINS
>    ifeq ($(PLUGINCC),)
>      ifneq ($(GCC_PLUGINS_CFLAGS),)
> -      # Various gccs between 4.5 and 5.1 have bugs on powerpc due to missing
> -      # header files. gcc <= 4.6 doesn't work at all, gccs from 4.8 to 5.1 have
> -      # issues with 64-bit targets.
> -      ifeq ($(ARCH),powerpc)
> -        ifeq ($(call cc-ifversion, -le, 0501, y), y)
> -         @echo "Cannot use CONFIG_GCC_PLUGINS: plugin support on gcc <= 5.1 is buggy on powerpc, please upgrade to gcc 5.2 or newer" >&2 && exit 1

I think we should retain the "buggy" note as a comment in Kconfig
since that knowledge isn't obvious just from the GCC_VERSION test.

> -        endif
> -      endif
>        $(Q)$(srctree)/scripts/gcc-plugin.sh --show-error $(HOSTCXX) $(CC) || true
>        @echo "Cannot use CONFIG_GCC_PLUGINS: your gcc installation does not support plugins, perhaps the necessary headers are missing?" >&2 && exit 1
>      endif
> --
> 2.7.4
>

-Kees

-- 
Kees Cook
Pixel Security
