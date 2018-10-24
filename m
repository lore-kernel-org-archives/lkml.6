Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FA1ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E6E20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E6E20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJYBgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:36:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50311 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbeJYBgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:36:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D2565208AE; Wed, 24 Oct 2018 19:07:19 +0200 (CEST)
Received: from localhost (unknown [185.7.230.213])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8EA782075C;
        Wed, 24 Oct 2018 19:07:09 +0200 (CEST)
Date:   Wed, 24 Oct 2018 18:07:09 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add device node for Mali-400
 GPU
Message-ID: <20181024170709.m4s4x3o6qfr4mdbs@flea>
References: <20181023161203.2956-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023161203.2956-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 09:42:03PM +0530, Jagan Teki wrote:
> Add support for Allwinner A64 has Mali-400MP2.
> 
> All interrupt lines are mentioned in the manual so used the same.
> Used 408MHz as assigned clock rate used by BSP, so used the same as
> well.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Note:
> - Modules was able to load it on 4.19. 
> 
>  .../bindings/gpu/arm,mali-utgard.txt          |  1 +
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 +++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> index 63cd91176a68..a0ee62a5b221 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> @@ -11,6 +11,7 @@ Required properties:
>        + allwinner,sun4i-a10-mali
>        + allwinner,sun7i-a20-mali
>        + allwinner,sun8i-h3-mali
> +      + allwinner,sun50i-a64-mali
>        + allwinner,sun50i-h5-mali
>        + amlogic,meson-gxbb-mali
>        + amlogic,meson-gxl-mali

Please make a separate patch for this change.

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index f82e6b165d57..2db3aa151902 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -812,6 +812,31 @@
>  			};
>  		};
>  
> +		mali: gpu@1c40000 {
> +			compatible = "allwinner,sun50i-a64-mali", "arm,mali-400";
> +			reg = <0x01c40000 0x10000>;
> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
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
> +			assigned-clock-rates = <408000000>;

This is not needed and should be done in the driver.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
