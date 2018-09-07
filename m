Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA87AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443FA206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUFVyuZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443FA206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeIGLNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeIGLNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:13:01 -0400
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1D1A2086B;
        Fri,  7 Sep 2018 06:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536302016;
        bh=ZJDGwRrjCiLRTv40v5nwRCEVIRjFUsHnUO7uLnnU6oI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qUFVyuZkEByluFS1cMxthdyODqotaSpnGWP1phj/bjC3EioO009Qze2ALLDUkXFbB
         rqgY2l0BDKwXwjvs3Rxv+jIsBxBW12HpgWb8/T9AiSPIf9iHh+dlijBF/GF/chWh8d
         c2iMr2l1xDoHOKHsMwG99DwTt3I6ardriMgQQd8c=
Received: by mail-wm0-f54.google.com with SMTP id n11-v6so13394374wmc.2;
        Thu, 06 Sep 2018 23:33:35 -0700 (PDT)
X-Gm-Message-State: APzg51AuDz1db6/c+3LKE7W6pHj1jS0JxUFfSI/snB49Ik+SmJFggfDR
        p6svT4jy37Dj+9U/cseIW19XaEkQjFwmOufIF3Y=
X-Google-Smtp-Source: ANB0VdbGAidbHr/60TtaV5Lizg7kEoLegJ7/1lW2BlOE94aRBnt5D8APperqTGIEY28gBfQoNZ3a29nTPj6CvbTaZrA=
X-Received: by 2002:a7b:c215:: with SMTP id x21-v6mr3670764wmi.72.1536302014171;
 Thu, 06 Sep 2018 23:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180907003716.57737-1-alexander.levin@microsoft.com> <20180907003716.57737-27-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-27-alexander.levin@microsoft.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 7 Sep 2018 08:33:22 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdjrVxb4-G2d52KU_MKFPnV5SjmAwr3fW6v8iA1Z32WSQ@mail.gmail.com>
Message-ID: <CAJKOXPdjrVxb4-G2d52KU_MKFPnV5SjmAwr3fW6v8iA1Z32WSQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 27/67] ARM: exynos: Define EINT_WAKEUP_MASK
 registers for S5Pv210 and Exynos5433
To:     Alexander.Levin@microsoft.com
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018 at 02:54, Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>
> From: Krzysztof Kozlowski <krzk@kernel.org>
>
> [ Upstream commit e5cda42c16d89720c29678f51d95a119490ef7d8 ]
>
> S5Pv210 and Exynos5433/Exynos7 have different address of
> EINT_WAKEUP_MASK register.  Rename existing S5P_EINT_WAKEUP_MASK to
> avoid confusion and add new ones.

This should not be backported to stable. It does not fix anything but
prepares the code for a8be2af0218c ("pinctrl: samsung: Write external
wakeup interrupt mask").

Best regards,
Krzysztof

>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  arch/arm/mach-exynos/suspend.c              | 2 +-
>  include/linux/soc/samsung/exynos-regs-pmu.h | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> index b529ba04ed16..a6a4ba334147 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -279,7 +279,7 @@ static int exynos5420_cpu_suspend(unsigned long arg)
>  static void exynos_pm_set_wakeup_mask(void)
>  {
>         /* Set wake-up mask registers */
> -       pmu_raw_writel(exynos_get_eint_wake_mask(), S5P_EINT_WAKEUP_MASK);
> +       pmu_raw_writel(exynos_get_eint_wake_mask(), EXYNOS_EINT_WAKEUP_MASK);
>         pmu_raw_writel(exynos_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
>  }
>
> diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
> index bebdde5dccd6..f248e7e079b7 100644
> --- a/include/linux/soc/samsung/exynos-regs-pmu.h
> +++ b/include/linux/soc/samsung/exynos-regs-pmu.h
> @@ -46,7 +46,7 @@
>  #define EXYNOS_SWRESET                         0x0400
>
>  #define S5P_WAKEUP_STAT                                0x0600
> -#define S5P_EINT_WAKEUP_MASK                   0x0604
> +#define EXYNOS_EINT_WAKEUP_MASK                        0x0604
>  #define S5P_WAKEUP_MASK                                0x0608
>  #define S5P_WAKEUP_MASK2                               0x0614
>
> @@ -184,6 +184,9 @@
>  #define S5P_CORE_WAKEUP_FROM_LOCAL_CFG         (0x3 << 8)
>  #define S5P_CORE_AUTOWAKEUP_EN                 (1 << 31)
>
> +/* Only for S5Pv210 */
> +#define S5PV210_EINT_WAKEUP_MASK       0xC004
> +
>  /* Only for EXYNOS4210 */
>  #define S5P_CMU_CLKSTOP_LCD1_LOWPWR    0x1154
>  #define S5P_CMU_RESET_LCD1_LOWPWR      0x1174
> @@ -645,6 +648,7 @@
>                                          | EXYNOS5420_KFC_USE_STANDBY_WFI3)
>
>  /* For EXYNOS5433 */
> +#define EXYNOS5433_EINT_WAKEUP_MASK                            (0x060C)
>  #define EXYNOS5433_USBHOST30_PHY_CONTROL                       (0x0728)
>  #define EXYNOS5433_PAD_RETENTION_AUD_OPTION                    (0x3028)
>  #define EXYNOS5433_PAD_RETENTION_MMC2_OPTION                   (0x30C8)
> --
> 2.17.1
