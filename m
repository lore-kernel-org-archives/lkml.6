Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2AAC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6992122545
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6992122545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934896AbeGFTj3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:39:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43701 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934894AbeGFTjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:39:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 39C8D2079C; Fri,  6 Jul 2018 21:39:22 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0E0552069C;
        Fri,  6 Jul 2018 21:39:22 +0200 (CEST)
Date:   Fri, 6 Jul 2018 21:39:23 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        alsa-devel@alsa-project.org, nicolas.ferre@microchip.com,
        boris.brezillon@bootlin.com, robh+dt@kernel.org,
        broonie@kernel.org, sboyd@kernel.org,
        Cristian.Birsan@microchip.com,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: Re: [PATCH v5 4/5] ARM: dts: at91: sama5d2: add nodes for I2S
 controllers
Message-ID: <20180706193923.GC16084@piout.net>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
 <20180618141239.10892-5-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618141239.10892-5-codrin.ciubotariu@microchip.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Codrin,

On 18/06/2018 17:12:38+0300, Codrin Ciubotariu wrote:
> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> 
> This patch adds DT nodes for I2S0 and I2S1. It also adds an alias for
> each I2S node.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> [codrin.ciubotariu@microchip.com: added phandle to new mux clock]
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> The bindings for the I2S node are applied to broonie/sound.git .
> 
> Changes in v5:
> 	- the previous name was:
> 	  [PATCH v4 6/7] ARM: dts: at91: sama5d2: add nodes for I2S controllers
> 
>  arch/arm/boot/dts/sama5d2.dtsi | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index eeb6afa1cda7..eca73ce40bc5 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -58,6 +58,8 @@
>  		serial1 = &uart3;
>  		tcb0 = &tcb0;
>  		tcb1 = &tcb1;
> +		i2s0 = &i2s0;
> +		i2s1 = &i2s1;
>  	};
>  
>  	cpus {
> @@ -1313,6 +1315,22 @@
>  				clocks = <&clk32k>;
>  			};
>  
> +			i2s0: i2s@f8050000 {
> +				compatible = "atmel,sama5d2-i2s";
> +				reg = <0xf8050000 0x100>;
> +				interrupts = <54 IRQ_TYPE_LEVEL_HIGH 7>;
> +				dmas = <&dma0
> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +					 AT91_XDMAC_DT_PERID(31))>,
> +				       <&dma0
> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +					 AT91_XDMAC_DT_PERID(32))>;
> +				dma-names = "tx", "rx";
> +				clocks = <&i2s0_clk>, <&i2s0_gclk>, <&audio_pll_pmc>, <&i2s0muxck>;
> +				clock-names = "pclk", "gclk", "aclk", "muxclk";
> +				status = "disabled";
> +			};
> +

Can you resend the DTS patches after removing the unnecessary clocks?

Thanks,

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
