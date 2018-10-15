Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B725DC71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD4A208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGleGMmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD4A208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeJOXIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbeJOXId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:08:33 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B674F208AE;
        Mon, 15 Oct 2018 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539616971;
        bh=JFFJ8ptDPJR6I3XgjHYDRIMU6BbqInkY5Dd8yIUyqho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dGleGMmzHakHtBFCiw9AytWY+cGngS6d5EkhiczRfKd0q4dS/bA898HN+hIjNiWQb
         M3DuSS4vfmQ+rU5nrhykD0/oHqZYxVikGpAlhOxWHIlAale4Q63BxyAX3E/5pjmA0Y
         jWbssJ4tzzOmdOEXnEzvGU7vU1AdUDAcxY9/O5Vs=
Received: by mail-wr1-f48.google.com with SMTP id a13-v6so21832530wrt.5;
        Mon, 15 Oct 2018 08:22:50 -0700 (PDT)
X-Gm-Message-State: ABuFfoiVbYSRHv+599P83lCNFNvzgfpN2P5haPc/sl1DrGUBHqM2geF+
        adkgUaqJiqeIz3uDffX9h66hLDMgRxVqbjyg8FM=
X-Google-Smtp-Source: ACcGV61pbntDtM1G+9DKxQH6/YEKGHdugHAht44vElCohK+hJie5rf4/ZkBxiqx66zqNclf+0Q4da2CAB6mRblRKZn0=
X-Received: by 2002:adf:e152:: with SMTP id f18-v6mr14171502wri.42.1539616969124;
 Mon, 15 Oct 2018 08:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677@eucas1p2.samsung.com>
 <20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677~dzHYfFW2j0676906769eucas1p2c@eucas1p2.samsung.com>
In-Reply-To: <20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677~dzHYfFW2j0676906769eucas1p2c@eucas1p2.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 15 Oct 2018 17:22:37 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdR0q_2DGbMrroqNcVfCPSkh0=ry=yyb9qmSDFf+TWbFg@mail.gmail.com>
Message-ID: <CAJKOXPdR0q_2DGbMrroqNcVfCPSkh0=ry=yyb9qmSDFf+TWbFg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
To:     =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Cc:     kgene@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 at 15:50, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> "Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
> config option) is not working properly (debug messages are not
> displayed after resume) on Exynos platforms because GPIOs restore
> code is not implemented.
>
> Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
> SAMSUNG_PM_DEBUG config option to hide it on Exynos platforms.
> Then convert Exynos code to not require <plat/pm-common.h>
> header (use pr_debug() directly instead of S3C_PMDBG() macro and
> remove redundant s3c_pm_*() calls).
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v2:
> - convert Exynos code to not require <plat/pm-common.h> header
>
> Should by applied on top of "[PATCH] ARM: EXYNOS: remove no longer
> needed s3c_pm_check_*() calls".
>
>  arch/arm/mach-exynos/suspend.c |   14 ++++----------
>  arch/arm/plat-samsung/Kconfig  |    3 ++-
>  2 files changed, 6 insertions(+), 11 deletions(-)
>
> Index: b/arch/arm/mach-exynos/suspend.c
> ===================================================================
> --- a/arch/arm/mach-exynos/suspend.c    2018-10-15 15:11:15.296187842 +0200
> +++ b/arch/arm/mach-exynos/suspend.c    2018-10-15 15:22:54.656205454 +0200
> @@ -30,8 +30,6 @@
>  #include <asm/smp_scu.h>
>  #include <asm/suspend.h>
>
> -#include <plat/pm-common.h>
> -
>  #include "common.h"
>
>  #define REG_TABLE_END (-1U)
> @@ -490,11 +488,9 @@ static int exynos_suspend_enter(suspend_
>  {
>         int ret;
>
> -       s3c_pm_debug_init();
> -
> -       S3C_PMDBG("%s: suspending the system...\n", __func__);
> +       pr_debug("%s: suspending the system...\n", __func__);
>
> -       S3C_PMDBG("%s: wakeup masks: %08x,%08x\n", __func__,
> +       pr_debug("%s: wakeup masks: %08x,%08x\n", __func__,
>                         exynos_irqwake_intmask, exynos_get_eint_wake_mask());
>
>         if (exynos_irqwake_intmask == -1U
> @@ -504,7 +500,6 @@ static int exynos_suspend_enter(suspend_
>                 return -EINVAL;
>         }
>
> -       s3c_pm_save_uarts();
>         if (pm_data->pm_prepare)
>                 pm_data->pm_prepare();
>         flush_cache_all();
> @@ -517,12 +512,11 @@ static int exynos_suspend_enter(suspend_
>
>         if (pm_data->pm_resume_prepare)
>                 pm_data->pm_resume_prepare();
> -       s3c_pm_restore_uarts();
>
> -       S3C_PMDBG("%s: wakeup stat: %08x\n", __func__,
> +       pr_debug("%s: wakeup stat: %08x\n", __func__,
>                         pmu_raw_readl(S5P_WAKEUP_STAT));
>
> -       S3C_PMDBG("%s: resuming the system...\n", __func__);
> +       pr_debug("%s: resuming the system...\n", __func__);
>
>         return 0;
>  }
> Index: b/arch/arm/plat-samsung/Kconfig
> ===================================================================
> --- a/arch/arm/plat-samsung/Kconfig     2018-10-15 15:16:22.804195586 +0200
> +++ b/arch/arm/plat-samsung/Kconfig     2018-10-15 15:16:22.800195586 +0200
> @@ -238,7 +238,8 @@ comment "Power management"
>
>  config SAMSUNG_PM_DEBUG
>         bool "Samsung PM Suspend debug"
> -       depends on PM && DEBUG_KERNEL
> +       depends on DEBUG_KERNEL

I don't get this change - why moving PM to line below?

Best regards,
Krzysztof

> +       depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
>         depends on DEBUG_EXYNOS_UART || DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
>         help
>           Say Y here if you want verbose debugging from the PM Suspend and
