Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Ud2uA8szHVugOgAAmS7hNA
	; Sun, 10 Jun 2018 14:20:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CCA5960791; Sun, 10 Jun 2018 14:20:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZhFeVgdw"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 80F9E606FA;
	Sun, 10 Jun 2018 14:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80F9E606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeFJOUz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 10:20:55 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:32708 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeFJOUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 10:20:53 -0400
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w5AEKS7i008587;
        Sun, 10 Jun 2018 23:20:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w5AEKS7i008587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528640429;
        bh=r5BqP4EWKEB60fVQPGq7RdyXYbPwpfCxi+Yo7wVDmYk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ZhFeVgdwLEsD77CYU8vOxMHs2ZO357MCjeKNMPJ1u4oVL+ygFuV0+IK3Tt0p8hKa/
         iNTcBan4k7Bnq6EumpFWPoWMR/mwqHNn53fcpnFNVHT8QE/JJOl7J7o3z+xRJC17au
         0yMovCSMQ5itOqVywakQsTv2gLSxYjSWETjTEaNfWVMDl+22ErJ4gQnWiyphAk1UHz
         EEyaMYmhrzJm46HzlpgJiu14OMWwv4Tk6bhF5pNesCh2BztLpLOERCeH9j6aLmO3EC
         xkz3KrC77D8kDBFkj2SanaQTPqb1jRdYyBTg+1ds568RFpHbNMEBViVIDoiLwtpYin
         y49tUU+yB1QEw==
X-Nifty-SrcIP: [209.85.217.173]
Received: by mail-ua0-f173.google.com with SMTP id m21-v6so11909949uan.0;
        Sun, 10 Jun 2018 07:20:29 -0700 (PDT)
X-Gm-Message-State: APt69E0mPQI80hrGh00J3t6kxj7bjicvOIZl17MRJNn7P+ER57EDlCAz
        epyLa+sWh7gXUJS55YVe8UGSpoxM0kmenTwb7FI=
X-Google-Smtp-Source: ADUXVKLFmzF4Nx71jyi6TEw0f2/b4+090PzKbbpL3tUSS1kaxbyG6FMPrE9dQeOVhof1c9Te670Np5XXQF7Ex84LXiU=
X-Received: by 2002:ab0:7089:: with SMTP id m9-v6mr8896153ual.141.1528640427995;
 Sun, 10 Jun 2018 07:20:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Sun, 10 Jun 2018 07:19:47
 -0700 (PDT)
In-Reply-To: <1527499328-13213-28-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com> <1527499328-13213-28-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 10 Jun 2018 23:19:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT1wOuFCzDfhqeYA=GaTXr94pVFsobFbMt3ODdiAJHMyg@mail.gmail.com>
Message-ID: <CAK7LNAT1wOuFCzDfhqeYA=GaTXr94pVFsobFbMt3ODdiAJHMyg@mail.gmail.com>
Subject: Re: [PATCH v5 27/31] kcov: test compiler capability in Kconfig and
 correct dependency
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-28 18:22 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
> be used with care - it forces a lower limit of another symbol, ignoring
> the dependency.  Currently, KCOV can select GCC_PLUGINS even if arch
> does not select HAVE_GCC_PLUGINS.  This could cause the unmet direct
> dependency.
>
> Now that Kconfig can test compiler capability, let's handle this in a
> more sophisticated way.
>
> There are two ways to enable KCOV; use the compiler that natively
> supports -fsanitize-coverage=trace-pc, or build the SANCOV plugin if
> the compiler has ability to build GCC plugins.  Hence, the correct
> dependency for KCOV is:
>
>   depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
>
> You do not need to build the SANCOV plugin if the compiler already
> supports -fsanitize-coverage=trace-pc.  Hence, the select should be:
>
>   select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
>
> With this, GCC_PLUGIN_SANCOV is selected only when necessary, so
> scripts/Makefile.gcc-plugins can be cleaner.
>
> I also cleaned up Kconfig and scripts/Makefile.kcov as well.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
>   - Replace the previous 'select -> imply' patch with
>     a new approach
>
> Changes in v2:
>   - Drop depends on GCC_VERSION
>
>  Makefile                     |  2 +-
>  lib/Kconfig.debug            | 11 +++++++----
>  scripts/Makefile.gcc-plugins |  6 +-----
>  scripts/Makefile.kcov        | 10 ++++++----
>  4 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 80e0800..4b5a17a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -626,7 +626,7 @@ all: vmlinux
>  CFLAGS_GCOV    := -fprofile-arcs -ftest-coverage \
>         $(call cc-option,-fno-tree-loop-im) \
>         $(call cc-disable-warning,maybe-uninitialized,)
> -export CFLAGS_GCOV CFLAGS_KCOV
> +export CFLAGS_GCOV
>
>  # The arch Makefile can set ARCH_{CPP,A,C}FLAGS to override the default
>  # values of the respective KBUILD_* variables
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c40c7b7..b76cab2 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -736,12 +736,15 @@ config ARCH_HAS_KCOV
>           only for x86_64. KCOV requires testing on other archs, and most likely
>           disabling of instrumentation for some early boot code.
>
> +config CC_HAS_SANCOV_TRACE_PC
> +       def_bool $(cc-option,-fsanitize-coverage=trace-pc)
> +
>  config KCOV
>         bool "Code coverage for fuzzing"
>         depends on ARCH_HAS_KCOV
> +       depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
>         select DEBUG_FS
> -       select GCC_PLUGINS if !COMPILE_TEST
> -       select GCC_PLUGIN_SANCOV if !COMPILE_TEST
> +       select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
>         help
>           KCOV exposes kernel code coverage information in a form suitable
>           for coverage-guided fuzzing (randomized testing).
> @@ -755,7 +758,7 @@ config KCOV
>  config KCOV_ENABLE_COMPARISONS
>         bool "Enable comparison operands collection by KCOV"
>         depends on KCOV
> -       default n
> +       depends on $(cc-option,-fsanitize-coverage=trace-cmp)
>         help
>           KCOV also exposes operands of every comparison in the instrumented
>           code along with operand sizes and PCs of the comparison instructions.
> @@ -765,7 +768,7 @@ config KCOV_ENABLE_COMPARISONS
>  config KCOV_INSTRUMENT_ALL
>         bool "Instrument all code by default"
>         depends on KCOV
> -       default y if KCOV
> +       default y
>         help
>           If you are doing generic system call fuzzing (like e.g. syzkaller),
>           then you will want to instrument the whole kernel and you should
> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
> index 7f5c862..0ce3802 100644
> --- a/scripts/Makefile.gcc-plugins
> +++ b/scripts/Makefile.gcc-plugins
> @@ -14,16 +14,12 @@ ifdef CONFIG_GCC_PLUGINS
>    endif
>
>    ifdef CONFIG_GCC_PLUGIN_SANCOV
> -    ifeq ($(strip $(CFLAGS_KCOV)),)
>        # It is needed because of the gcc-plugin.sh and gcc version checks.
>        gcc-plugin-$(CONFIG_GCC_PLUGIN_SANCOV)           += sancov_plugin.so
>
> -      ifneq ($(PLUGINCC),)
> -        CFLAGS_KCOV := $(SANCOV_PLUGIN)
> -      else
> +      ifeq ($(PLUGINCC),)
>          $(warning warning: cannot use CONFIG_KCOV: -fsanitize-coverage=trace-pc is not supported by compiler)
>        endif
> -    endif
>    endif
>
>    gcc-plugin-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)   += structleak_plugin.so
> diff --git a/scripts/Makefile.kcov b/scripts/Makefile.kcov
> index 5cc7203..d71ba73 100644
> --- a/scripts/Makefile.kcov
> +++ b/scripts/Makefile.kcov
> @@ -1,7 +1,9 @@
>  ifdef CONFIG_KCOV
> -CFLAGS_KCOV    := $(call cc-option,-fsanitize-coverage=trace-pc,)
> -ifeq ($(CONFIG_KCOV_ENABLE_COMPARISONS),y)
> -CFLAGS_KCOV += $(call cc-option,-fsanitize-coverage=trace-cmp,)
> -endif
> +
> +kcov-flags-$(CONFIG_CC_HAS_SANCOV_TRACE_PC)    += -fsanitize-coverage=trace-pc
> +kcov-flags-$(CONFIG_KCOV_ENABLE_COMPARISONS)   += -fsanitize-coverage=trace-cmp
> +kcov-flags-$(CONFIG_GCC_PLUGIN_SANKOV)         += -fplugin=$(objtree)/scripts/gcc-plugins/sancov_plugin.so
> +


This is my mistake.

SANKOV  ->  SANCOV


I fixed it locally.







> +export CFLAGS_KCOV := $(kcov-flags-y)
>
>  endif
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
