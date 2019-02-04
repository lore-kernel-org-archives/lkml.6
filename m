Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D02BC282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC1A20820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="VWRsboRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfBDX6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:58:05 -0500
Received: from vern.gendns.com ([98.142.107.122]:53414 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbfBDX6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ztTJUNn6xrf1rSdLZeO+Zk3GlaPqIoy0zfh9SL17tEw=; b=VWRsboRXDXhTU2PuFgko9WO0ar
        yuDbkdgakDDqnlRWUlUMzuwM5pE6WEtl0KTWGPDjvCN5LTuidO5q0j9XDmhPWrbTPSvIaoHtCcbLu
        Gs1J0+pampPqJdbKYkND1EPxS2DKlbmbXCfe/Stxvc0GQjsblo0guCTdzi5XOJHXkkd2VFVaCiG+D
        PZ3D4kVW7HPOqAcJ5d92Swrh/FCwYRvXaeDAaEh+wEYphpQbE4V8EDiXL/CbuWDqMygaGvSqBdviY
        2dOHrUJVjiqaF5+zAs4pPDrs7NuhOuJnxSbZUzrPi3N0TwnU/I9FrS8QPeRwsfqXJdsyO0qZe+ZY1
        RZxTt3hA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:59834 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqo4J-0000wp-0o; Mon, 04 Feb 2019 18:54:27 -0500
Subject: Re: [PATCH 22/35] ARM: davinci: cp-intc: add the new config
 structures for da8xx SoCs
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-23-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <d465f3d9-c767-43df-c4cc-7a3e7b6b20d9@lechnology.com>
Date:   Mon, 4 Feb 2019 17:58:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-23-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the new-style config structures for dm* SoCs. They will be used
> once we make the cp-intc driver stop using davinci_soc_info.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/da830.c | 10 ++++++++++
>   arch/arm/mach-davinci/da850.c | 10 ++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
> index 8b9220badef5..6d3da4364f7a 100644
> --- a/arch/arm/mach-davinci/da830.c
> +++ b/arch/arm/mach-davinci/da830.c
> @@ -12,6 +12,7 @@
>   #include <linux/clk/davinci.h>
>   #include <linux/gpio.h>
>   #include <linux/init.h>
> +#include <linux/irqchip/irq-davinci-cp-intc.h>
>   #include <linux/platform_data/gpio-davinci.h>
>   
>   #include <asm/mach/map.h>
> @@ -742,6 +743,15 @@ void __init da830_init(void)
>   	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
>   }
>   
> +static const struct davinci_cp_intc_config da830_cp_intc_config = {
> +	.reg = {
> +		.start		= DA8XX_CP_INTC_BASE,
> +		.end		= DA8XX_CP_INTC_BASE + SZ_8K,

Missing minus one?

+		.end		= DA8XX_CP_INTC_BASE + SZ_8K - 1,

> +		.flags		= IORESOURCE_MEM,
> +	},
> +	.num_irqs		= DA830_N_CP_INTC_IRQ,
> +};
> +
>   void __init da830_init_irqs(void)
>   {
>   	cp_intc_init();
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 9f48e1ac61fb..5e7f2c962abf 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -18,6 +18,7 @@
>   #include <linux/cpufreq.h>
>   #include <linux/gpio.h>
>   #include <linux/init.h>
> +#include <linux/irqchip/irq-davinci-cp-intc.h>
>   #include <linux/mfd/da8xx-cfgchip.h>
>   #include <linux/platform_data/clk-da8xx-cfgchip.h>
>   #include <linux/platform_data/clk-davinci-pll.h>
> @@ -671,6 +672,15 @@ void __init da850_init(void)
>   	WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
>   }
>   
> +static const struct davinci_cp_intc_config da850_cp_intc_config = {
> +	.reg = {
> +		.start		= DA8XX_CP_INTC_BASE,
> +		.end		= DA8XX_CP_INTC_BASE + SZ_8K,

same here

> +		.flags		= IORESOURCE_MEM,
> +	},
> +	.num_irqs		= DA850_N_CP_INTC_IRQ,
> +};
> +
>   void __init da850_init_irqs(void)
>   {
>   	cp_intc_init();
> 

