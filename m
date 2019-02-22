Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F5DC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DCF204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqVRVTDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfBVS01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:26:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43485 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfBVS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:26:26 -0500
Received: by mail-lf1-f68.google.com with SMTP id j1so2422870lfb.10;
        Fri, 22 Feb 2019 10:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KsmxRwp7SOmta/Ucao4e6WVvG+vtj6B7DkivFWsH1HI=;
        b=sqVRVTDNURoS/aTNCTpptmCDFgl2YIV8lI+mLmAScfKYJCtbD6JwQZcxr4l/1tcMbo
         lEuLnowAU6UEvg6W29qN2B3URPYniSW3k0QgUAd6LWRoo3lC0p5CRkxERwh1CPcQ1OdW
         n5YGx/wuDz3XUiQLRCvuQQVQ94+3h2kO0cQy7Bgjra8jVTNm/+A7mQd3/p9fdx83TVOx
         mE0Cl2EePhbK7R+dM+L0xLASJD6WGJII03lXY+RkZb5N2TVXxMmY09f6NZWkDrLgiYY9
         x1qhotxEjYPjepY8Ffody83vxWPwhnfCWMnS+e0bJ/iZ3/ni3aYwsoVRMdgVy2P2JqPU
         O6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KsmxRwp7SOmta/Ucao4e6WVvG+vtj6B7DkivFWsH1HI=;
        b=E9i+B8L4GzYJIhwpCL9VEunEdavt3o4GwE1ADWSfSpvv7MXl6ur8LdPetNZh4/wdKA
         2v0+xHceR0cq6VWZgqhPer/7ThKxDfzvgfCpdTRnV7lyr8djN8q7VBI3619KfM++00qK
         CCOptJObEKTy3yom2UHH1e3iWiPMTKeGqwN5Swt1aDffYtJYkyaS58/dtYL/rvy1YhJN
         x66rESEMzI3U94aC1yvy7Xu0AG1yCIPjyarsknX3g3SXQ/mC79+1E970KjHfDehA4md9
         kzcm73ZjjOK/qTnBJY/d2mjx06zxnSJY+0OXC0cooBTAczprsqMEPZWlBPboHzyVACCQ
         184w==
X-Gm-Message-State: AHQUAuYNVe0sI4j4BhGkGFnQaa3BfZfkRa7X31cAvoHEPyN86KOGHcRM
        HUtyXgqOtudKFLM2vLGcN8TLBCJM
X-Google-Smtp-Source: AHgI3Ia0DtY+SqdyZTDECU8sXwAnpo92rDzYlQrdn82mx+H2Xr27m8dM2WMhElVa1lknt5zfDQqvQA==
X-Received: by 2002:a19:7406:: with SMTP id v6mr3270867lfe.33.1550859983590;
        Fri, 22 Feb 2019 10:26:23 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id s14sm679732lje.4.2019.02.22.10.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 10:26:22 -0800 (PST)
Subject: Re: [PATCH v5 8/8] ARM: tegra: Add firmware calls required for
 suspend-resume
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190222175926.23366-1-digetx@gmail.com>
 <20190222175926.23366-9-digetx@gmail.com>
Message-ID: <1b58a7f4-8ad0-9b5a-4ca7-b01b3c47425f@gmail.com>
Date:   Fri, 22 Feb 2019 21:26:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222175926.23366-9-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.02.2019 20:59, Dmitry Osipenko пишет:
> In order to resume CPU from suspend via trusted Foundations firmware,
> the LP1/LP2 boot vectors and CPU caches need to be set up using the
> firmware calls.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/pm.c            | 53 ++++++++++++++++++-----------
>  arch/arm/mach-tegra/reset-handler.S | 26 ++++++++++++++
>  arch/arm/mach-tegra/sleep.S         |  3 +-
>  3 files changed, 61 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
> index 66c8cd63dd86..f209f59e0daf 100644
> --- a/arch/arm/mach-tegra/pm.c
> +++ b/arch/arm/mach-tegra/pm.c
> @@ -33,6 +33,7 @@
>  #include <soc/tegra/pmc.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/firmware.h>
>  #include <asm/idmap.h>
>  #include <asm/proc-fns.h>
>  #include <asm/smp_plat.h>
> @@ -160,6 +161,28 @@ int tegra_cpu_do_idle(void)
>  
>  static int tegra_sleep_cpu(unsigned long v2p)
>  {
> +	/*
> +	 * L2 cache disabling using kernel API only allowed when all
> +	 * secondary CPU's are offline. Cache have to be disabled with
> +	 * MMU-on if cache maintenance is done via Trusted Foundations
> +	 * firmware. Note that CPUIDLE won't ever enter powergate on Tegra30
> +	 * if any of secondary CPU's is online and this is the LP2-idle
> +	 * code-path only for Tegra20/30.
> +	 */
> +	if (trusted_foundations_registered())
> +		outer_disable();
> +
> +	/*
> +	 * Note that besides of setting up CPU reset vector this firmware
> +	 * call may also do the following, depending on the FW version:
> +	 * 	1) Disable L2. But this doesn't matter since we already
> +	 * 	   disabled the L2.
> +	 *	2) Disable D-cache. This need to be taken into account in
> +	 *	   particular by the tegra_disable_clean_inv_dcache() which
> +	 *	   shall avoid the re-disable.
> +	 */
> +	call_firmware_op(prepare_idle, TF_PM_MODE_LP2);
> +
>  	setup_mm_for_reboot();
>  	tegra_sleep_cpu_finish(v2p);
>  
> @@ -196,24 +219,13 @@ void tegra_idle_lp2_last(void)
>  	cpu_cluster_pm_enter();
>  	suspend_cpu_complex();
>  
> -	/*
> -	 * L2 cache disabling using kernel API only allowed when all
> -	 * secondary CPU's are offline. Cache have to be disabled early
> -	 * if cache maintenance is done via Trusted Foundations firmware.
> -	 * Note that CPUIDLE won't ever enter powergate on Tegra30 if any
> -	 * of secondary CPU's is online and this is the LP2 codepath only
> -	 * for Tegra20/30.
> -	 */
> -	if (trusted_foundations_registered())
> -		outer_disable();
> -
>  	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
>  
>  	/*
>  	 * Resume L2 cache if it wasn't re-enabled early during resume,
>  	 * which is the case for Tegra30 that has to re-enable the cache
>  	 * via firmware call. In other cases cache is already enabled and
> -	 * hence re-enabling is a no-op.
> +	 * hence re-enabling is a no-op. This is always a no-op on Tegra114+.
>  	 */
>  	outer_resume();
>  
> @@ -235,6 +247,15 @@ enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
>  
>  static int tegra_sleep_core(unsigned long v2p)
>  {
> +	/*
> +	 * Cache have to be disabled with MMU-on if cache maintenance is done
> +	 * via Trusted Foundations firmware. This is a no-op on Tegra114+.
> +	 */
> +	if (trusted_foundations_registered())
> +		outer_disable();
> +
> +	call_firmware_op(prepare_idle, TF_PM_MODE_LP1);
> +
>  	setup_mm_for_reboot();
>  	tegra_sleep_core_finish(v2p);
>  
> @@ -360,14 +381,6 @@ static int tegra_suspend_enter(suspend_state_t state)
>  		break;
>  	}
>  
> -	/*
> -	 * Cache have to be disabled early if cache maintenance is done
> -	 * via Trusted Foundations firmware. Otherwise this is a no-op,
> -	 * like on Tegra114+.
> -	 */
> -	if (trusted_foundations_registered())
> -		outer_disable();
> -
>  	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, tegra_sleep_func);

Seems I messed up the rebasing a tad. Will send another version.
