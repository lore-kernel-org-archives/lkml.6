Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D7AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CBE2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="FS31z7iH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfBDXJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:09:41 -0500
Received: from vern.gendns.com ([98.142.107.122]:42458 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbfBDXJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8qKRBFRTH9ZlQ+nCypAosq40t2H6pbB7sIjdnsc+C5I=; b=FS31z7iHM0DKZalwai6hyeHzjH
        c+F8kXDq2WEX+JG+tXNaXXd6mBROOVKabIN8uxxGAWOSER0hVcSpJVjwD0FJqicUTA5fTPWCyeHFT
        4+EngKRScxikRQ/rpSVv7PBdHJVALMuyH289mxDw9R22qo1BdwKBVl/lttOvtK3L/gvh7I5rAwjG1
        iteFgeeht/igBXVPG9Ir9oHkm91nx/GclFzPWQlZvLvdChaC64sxHtd738hqMa84IVMH+rEnneydt
        TLo3ej0Ev7enVYq2lQSPn1a4UhP4Iy2eZGkgdhAgYmLIJ1mYu+k71WoqlQu3wneEkbI/CYuycV9uP
        pZ7dSiUw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:58964 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqnJT-0004go-FJ; Mon, 04 Feb 2019 18:06:03 -0500
Subject: Re: [PATCH 14/35] ARM: davinci: aintc: use the new irqchip config
 structure in dm* SoCs
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-15-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <96ce8a1e-0b51-7cf0-0cb9-f0f6ae1e563d@lechnology.com>
Date:   Mon, 4 Feb 2019 17:09:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-15-brgl@bgdev.pl>
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
> once we make the aintc driver stop using davinci_soc_info.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/dm355.c  | 11 +++++++++++
>   arch/arm/mach-davinci/dm365.c  | 11 +++++++++++
>   arch/arm/mach-davinci/dm644x.c | 11 +++++++++++
>   arch/arm/mach-davinci/dm646x.c | 11 +++++++++++
>   4 files changed, 44 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
> index cf574956ce1d..0dcfcbec522a 100644
> --- a/arch/arm/mach-davinci/dm355.c
> +++ b/arch/arm/mach-davinci/dm355.c
> @@ -15,6 +15,7 @@
>   #include <linux/dma-mapping.h>
>   #include <linux/dmaengine.h>
>   #include <linux/init.h>
> +#include <linux/irqchip/irq-davinci-aintc.h>
>   #include <linux/platform_data/edma.h>
>   #include <linux/platform_data/gpio-davinci.h>
>   #include <linux/platform_data/spi-davinci.h>
> @@ -738,6 +739,16 @@ int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
>   	return 0;
>   }
>   
> +static const struct davinci_aintc_config dm355_aintc_config = {
> +	.reg = {
> +		.start		= DAVINCI_ARM_INTC_BASE,
> +		.end		= DAVINCI_ARM_INTC_BASE + SZ_4K,

missing a minus 1 after SZ_4K?

+		.end		= DAVINCI_ARM_INTC_BASE + SZ_4K - 1,

(repeated 3 more times below)

> +		.flags		= IORESOURCE_MEM,
> +	},
> +	.num_irqs		= 64,
> +	.prios			= dm355_aintc_prios,
> +};
> +
>   void __init dm355_init_irqs(void)
>   {
>   	davinci_aintc_init();

