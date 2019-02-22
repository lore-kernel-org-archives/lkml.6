Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9951FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59171207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dc5crdso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfBVAxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:53:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37842 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfBVAxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:53:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id q3so262549pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 16:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gdQxnmvBZwkplDEWKBHm1j3BT2milNpraeTIVr9GVTw=;
        b=dc5crdsodXAT2b6t9Jp5DyNpoDN5wM7Xwnap9+EdALkS0eGCSAIZqJu4Nexbd2Uo0Q
         dCrHPl4/9HL/SDYADJlYlUz/PUaJtxyppBdub0gGs+fg4PGqCgITnajq0aXa290mWZD4
         is0EgnlnhAqztt6NHky43jL00lvrSn392ONtxKybL5SMPRozjAruW9sGGJlDuT+lDdjR
         Ea/aG7ON3aLxHwV/oQK6rt/yGsZxKM3BaZItYAQirTUd0s69YRA13goy1WJk6Dxqzskk
         Z7XvUUXGOBtRWI7EszmOLoXUok6rl+ZNVRIj9O1xhgxGS87tm2y3ZO+dV/AXHrx4nd+E
         31Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdQxnmvBZwkplDEWKBHm1j3BT2milNpraeTIVr9GVTw=;
        b=r1BymgY1qbzVXxBrjkCUhSxRgNGdqkVANtkCBtfUmG5ErCsEZkYZvHO1cE6UqRmyEi
         EWE/dOvNkWJk/IwrE0x0mN6KmKnYopLTJQzRDtLr56y2r1b5s5kueNK3GCmZn/wzKzGt
         v5vmvMkRQaCaoudCvID08zxTyINgpfxl/M/aQwnMy4ltYiI+TDAfTxiW3Aw8+J7NTPKt
         /91shKoWdpT7QAvx/Tms5xSieyywjP8MqoudT2uZSio5wtVD3KkS7QjcFU7RLLcXOGil
         29zfS+qPbXGUI3UL+k42T3tqUqRZWoaztpx2dc+wRmqwlSCvJ8FRyTpQxAzOsDa9tnpY
         6q1A==
X-Gm-Message-State: AHQUAubO2tKUElovoufxNMLDhSiGbHX5VDCB3Nu6ajmKOHHb64g7gv4R
        OGguBoFC0kRlYMrQPeLcWJw0A06qSE8GpxX9u+V3GA==
X-Google-Smtp-Source: AHgI3IY/W9fHPBLSGfV8Z91TkZv2oXYv2Vry+qiBy5W0pGCCliA8fcIVjODa0F9QL91u9MudzThGiKcMntBRDloAZ1g=
X-Received: by 2002:a17:902:bb89:: with SMTP id m9mr1409099pls.320.1550796787192;
 Thu, 21 Feb 2019 16:53:07 -0800 (PST)
MIME-Version: 1.0
References: <1550722418-9189-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1550722418-9189-1-git-send-email-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 21 Feb 2019 16:52:55 -0800
Message-ID: <CAKwvOd=YBsupApffP_5QUB5dbQr8k-43DgKhckqkcsGiuXK=MA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: compute false-positive -Wmaybe-uninitialized
 cases in Kconfig
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 8:14 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Since -Wmaybe-uninitialized was introduced by GCC 4.7, we have patched
> various false positives:
>
>  - commit e74fc973b6e5 ("Turn off -Wmaybe-uninitialized when building
>    with -Os") turned off this option for -Os.
>
>  - commit 815eb71e7149 ("Kbuild: disable 'maybe-uninitialized' warning
>    for CONFIG_PROFILE_ALL_BRANCHES") turned off this option for
>    CONFIG_PROFILE_ALL_BRANCHES
>
>  - commit a76bcf557ef4 ("Kbuild: enable -Wmaybe-uninitialized warning
>    for "make W=1"") turned off this option for GCC < 4.9
>    Arnd provided more explanation in https://lkml.org/lkml/2017/3/14/903
>
> I think this looks better by shifting the logic from Makefile to Kconfig.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I verified that mainline+this patch did not regression arm64
allyesconfig clang build.
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Thanks for the patch! Would you mind adding a link tag to:
Link: https://github.com/ClangBuiltLinux/linux/issues/350

> ---
>
>  Makefile             | 10 +++-------
>  init/Kconfig         | 17 +++++++++++++++++
>  kernel/trace/Kconfig |  1 +
>  3 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 1bb0535..b21aa2e3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -656,17 +656,13 @@ KBUILD_CFLAGS     += $(call cc-disable-warning, int-in-bool-context)
>
>  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>  KBUILD_CFLAGS  += $(call cc-option,-Oz,-Os)
> -KBUILD_CFLAGS  += $(call cc-disable-warning,maybe-uninitialized,)
> -else
> -ifdef CONFIG_PROFILE_ALL_BRANCHES
> -KBUILD_CFLAGS  += -O2 $(call cc-disable-warning,maybe-uninitialized,)
>  else
>  KBUILD_CFLAGS   += -O2
>  endif
> -endif
>
> -KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
> -                       $(call cc-disable-warning,maybe-uninitialized,))
> +ifdef CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED
> +KBUILD_CFLAGS   += -Wno-maybe-uninitialized
> +endif
>
>  # Tell gcc to never replace conditional load with a non-conditional one
>  KBUILD_CFLAGS  += $(call cc-option,--param=allow-store-data-races=0)
> diff --git a/init/Kconfig b/init/Kconfig
> index c9386a3..1f05a88 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -26,6 +26,22 @@ config CLANG_VERSION
>  config CC_HAS_ASM_GOTO
>         def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
>
> +config CC_HAS_WARN_MAYBE_UNINITIALIZED
> +       def_bool $(cc-option,-Wmaybe-uninitialized)
> +       help
> +         GCC >= 4.7 supports this option.
> +
> +config CC_DISABLE_WARN_MAYBE_UNINITIALIZED
> +       bool
> +       depends on CC_HAS_WARN_MAYBE_UNINITIALIZED
> +       default CC_IS_GCC && GCC_VERSION < 40900  # unreliable for GCC < 4.9
> +       help
> +         GCC's -Wmaybe-uninitialized is not reliable by definition.
> +         Lots of false positive warnings are produced in some cases.
> +
> +         If this option is enabled, -Wno-maybe-uninitialzed is passed
> +         to the compiler to suppress maybe-uninitialized warnings.
> +
>  config CONSTRUCTORS
>         bool
>         depends on !UML
> @@ -1113,6 +1129,7 @@ config CC_OPTIMIZE_FOR_PERFORMANCE
>
>  config CC_OPTIMIZE_FOR_SIZE
>         bool "Optimize for size"
> +       imply CC_DISABLE_WARN_MAYBE_UNINITIALIZED  # avoid false positives
>         help
>           Enabling this option will pass "-Os" instead of "-O2" to
>           your compiler resulting in a smaller kernel.
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index fa8b1fe..8bd1d6d 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -370,6 +370,7 @@ config PROFILE_ANNOTATED_BRANCHES
>  config PROFILE_ALL_BRANCHES
>         bool "Profile all if conditionals" if !FORTIFY_SOURCE
>         select TRACE_BRANCH_PROFILING
> +       imply CC_DISABLE_WARN_MAYBE_UNINITIALIZED  # avoid false positives
>         help
>           This tracer profiles all branch conditions. Every if ()
>           taken in the kernel is recorded whether it hit or miss.
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
