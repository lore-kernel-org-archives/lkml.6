Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D801C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24361205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24361205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeKAQyP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:54:15 -0400
Received: from mailoutvs49.siol.net ([185.57.226.240]:60050 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727803AbeKAQyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:54:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 791C852068C;
        Thu,  1 Nov 2018 08:52:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dPG_-GTlUxRA; Thu,  1 Nov 2018 08:52:19 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 1292D5212DA;
        Thu,  1 Nov 2018 08:52:19 +0100 (CET)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 5A17252068C;
        Thu,  1 Nov 2018 08:52:18 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Lothar Felten <lothar.felten@gmail.com>
Cc:     linux-sunxi@googlegroups.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maxime.ripard@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org
Subject: Re: [PATCH] ARM: dtsi: sun8i-r40: add mali node
Date:   Thu, 01 Nov 2018 08:52:17 +0100
Message-ID: <1868657.3A2CuZcRV2@jernej-laptop>
In-Reply-To: <20181101073833.2936-1-lothar.felten@gmail.com>
References: <20181101073833.2936-1-lothar.felten@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 01. november 2018 ob 08:38:33 CET je Lothar Felten napisal(a):
> This patch adds a node for the mali 400 GPU of the R40/V40 SoC
> 
> Signed-off-by: Lothar Felten <lothar.felten@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi
> b/arch/arm/boot/dts/sun8i-r40.dtsi index 6f4c9ca5a3ee..ddf765e931f3 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -542,6 +542,31 @@
> 
>  		};
> 
> +		mali: gpu@1c40000 {
> +			compatible = "allwinner,sun7i-a20-mali", "arm,mali-400";
> +			reg = <0x01c40000 0x10000>;
> +			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "gp",
> +					  "gpmmu",
> +					  "pp0",
> +					  "ppmmu0",
> +					  "pp1",
> +					  "ppmmu1",
> +					  "pmu";
> +			clocks = <&ccu CLK_BUS_GPU>, <&ccu CLK_GPU>;
> +			clock-names = "bus", "core";
> +			resets = <&ccu RST_BUS_GPU>;
> +
> +			assigned-clocks = <&ccu CLK_GPU>;
> +			assigned-clock-rates = <384000000>;

In previous e-mail I already stated that above 2 lines doesn't belong here. 
Driver is responsible for clock rate management.

> +		};
> +
>  		gmac: ethernet@1c50000 {
>  			compatible = "allwinner,sun8i-r40-gmac";
>  			syscon = <&ccu>;
> @@ -813,7 +838,8 @@
>  		};
> 
>  		hdmi_phy: hdmi-phy@1ef0000 {
> -			compatible = "allwinner,sun8i-r40-hdmi-phy";
> +			compatible = "allwinner,sun8i-r40-hdmi-phy",
> +				     "allwinner,sun50i-a64-hdmi-phy";

In previous e-mail I also stated that above changes are not related to GPU 
node and they are also not needed, since HDMI on R40 works without this.

>  			reg = <0x01ef0000 0x10000>;
>  			clocks = <&ccu CLK_BUS_HDMI1>, <&ccu CLK_HDMI_SLOW>,
>  				 <&ccu 7>, <&ccu 16>;

You cleary didn't read rules for patch submission. When you are sending new 
version of the patch, you have to state which version is it in subject line 
and write a changelog below "---" line.

Best regards,
Jernej




