Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94B7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C44A20863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548996617;
	bh=nUVPrh8ZBx6kcfIW95VpOacTG1rxE/J69Np3y+rhw3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LyN10a4KQ9sWPxQhSrlQSn54HOSDn+t1RTOQn5ZtW/P3lWRi+xXSXsq6mNS2vxXzK
	 2VdAbfIyVKvwt2OvZzuB0NNDQJjmAOWVZf0niRKLevPnONglX5nTKzzfgK5ooVQpnp
	 SaVIXlD5q2RKVUBUS043hFQuyoFw8PJWL1JU6ETk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfBAEuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 23:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbfBAEuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 23:50:15 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A72520863;
        Fri,  1 Feb 2019 04:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548996614;
        bh=nUVPrh8ZBx6kcfIW95VpOacTG1rxE/J69Np3y+rhw3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bhf2mXn2xScl4uaenAmfBDTGyAXzhkpME+MWDhewJBtlWC1N19H1mF8X0hkVXHNnB
         jMCPp9Mt9MSSzZ1TNvG9Ej1j6/EzwYrkGVKRz38HnS04zivYGA5UlM16Wyb4uflyNU
         E5+y6MWXyOhBBxxv6+4x9ZLtSN1p1bsSSci/juUc=
Date:   Fri, 1 Feb 2019 12:50:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alison Wang <alison.wang@nxp.com>
Cc:     leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls1028a: Add Audio DT nodes
Message-ID: <20190201045002.GH19882@dragon>
References: <20190123052135.26829-1-alison.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123052135.26829-1-alison.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 01:21:35PM +0800, Alison Wang wrote:
> This patch adds Audio DT nodes for LS1028ARDB and LS1028AQDS boards.
> 
> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |   62 ++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts |   63 +++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    |   57 +++++++++++++++++++
>  3 files changed, 182 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 14c79f4..139728e 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -32,6 +32,49 @@
>  		device_type = "memory";
>  		reg = <0x0 0x80000000 0x1 0x00000000>;
>  	};
> +
> +	sys_mclk: clock-mclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +	};
> +
> +	reg_1p8v: regulator-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1P8V";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,widgets =
> +			"Microphone", "Microphone Jack",
> +			"Headphone", "Headphone Jack",
> +			"Speaker", "Speaker Ext",
> +			"Line", "Line In Jack";
> +		simple-audio-card,routing =
> +			"MIC_IN", "Microphone Jack",
> +			"Microphone Jack", "Mic Bias",
> +			"LINE_IN", "Line In Jack",
> +			"Headphone Jack", "HP_OUT",
> +			"Speaker Ext", "LINE_OUT";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai1>;
> +			frame-master;
> +			bitclock-master;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +			frame-master;
> +			bitclock-master;
> +			system-clock-frequency = <25000000>;
> +		};
> +	};
>  };
>  
>  &duart0 {
> @@ -89,5 +132,24 @@
>  				reg = <0x57>;
>  			};
>  		};
> +
> +		i2c@5 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x5>;
> +
> +			codec: sgtl5000@a {

sgtl5000: audio-codec@a

> +				#sound-dai-cells = <0>;
> +				compatible = "fsl,sgtl5000";
> +				reg = <0xa>;
> +				VDDA-supply = <&reg_1p8v>;
> +				VDDIO-supply = <&reg_1p8v>;
> +				clocks = <&sys_mclk>;
> +			};
> +		};
>  	};
>  };
> +
> +&sai1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index fdeb417..1b3d5e3 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -28,6 +28,49 @@
>  		device_type = "memory";
>  		reg = <0x0 0x80000000 0x1 0x0000000>;
>  	};
> +
> +	sys_mclk: clock-mclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +	};
> +
> +	reg_1p8v: regulator-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1P8V";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,widgets =
> +			"Microphone", "Microphone Jack",
> +			"Headphone", "Headphone Jack",
> +			"Speaker", "Speaker Ext",
> +			"Line", "Line In Jack";
> +		simple-audio-card,routing =
> +			"MIC_IN", "Microphone Jack",
> +			"Microphone Jack", "Mic Bias",
> +			"LINE_IN", "Line In Jack",
> +			"Headphone Jack", "HP_OUT",
> +			"Speaker Ext", "LINE_OUT";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai4>;
> +			frame-master;
> +			bitclock-master;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +			frame-master;
> +			bitclock-master;
> +			system-clock-frequency = <25000000>;
> +		};
> +	};
>  };
>  
>  &i2c0 {
> @@ -39,6 +82,22 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x1>;
> +
> +			codec: sgtl5000@a {
> +				#sound-dai-cells = <0>;
> +				compatible = "fsl,sgtl5000";
> +				reg = <0xa>;
> +				VDDA-supply = <&reg_1p8v>;
> +				VDDIO-supply = <&reg_1p8v>;
> +				clocks = <&sys_mclk>;
> +				sclk-strength = <3>;

What is this property?

> +			};
> +		};
> +
>  		i2c@2 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -71,3 +130,7 @@
>  &duart1 {
>  	status = "okay";
>  };
> +
> +&sai4 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index a8cf92a..48c9e3a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -335,5 +335,62 @@
>  				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> +
> +		edma0: edma@22c0000 {

dma-controller

> +			#dma-cells = <2>;
> +			compatible = "fsl,vf610-edma";
> +			reg = <0x0 0x22c0000 0x0 0x10000>,
> +			      <0x0 0x22d0000 0x0 0x10000>,
> +			      <0x0 0x22e0000 0x0 0x10000>;
> +			interrupts = <0 56 0x4>,
> +				     <0 56 0x4>;

Use GIC_SPI and IRQ_TYPE_LEVEL_HIGH.

> +			interrupt-names = "edma-tx", "edma-err";
> +			dma-channels = <32>;
> +			clock-names = "dmamux0", "dmamux1";
> +			clocks = <&clockgen 4 1>,
> +				 <&clockgen 4 1>;
> +		};
> +
> +		sai1: sai@f100000 {

audio-controller

Shawn

> +			#sound-dai-cells = <0>;
> +			compatible = "fsl,vf610-sai";
> +			reg = <0x0 0xf100000 0x0 0x10000>;
> +			interrupts = <0 82 0x4>;
> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> +				 <&clockgen 4 1>, <&clockgen 4 1>;
> +			clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +			dma-names = "tx", "rx";
> +			dmas = <&edma0 1 4>,
> +			       <&edma0 1 3>;
> +			status = "disabled";
> +		};
> +
> +		sai2: sai@f110000 {
> +			#sound-dai-cells = <0>;
> +			compatible = "fsl,vf610-sai";
> +			reg = <0x0 0xf110000 0x0 0x10000>;
> +			interrupts = <0 82 0x4>;
> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> +				 <&clockgen 4 1>, <&clockgen 4 1>;
> +			clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +			dma-names = "tx", "rx";
> +			dmas = <&edma0 1 6>,
> +			       <&edma0 1 5>;
> +			status = "disabled";
> +		};
> +
> +		sai4: sai@f130000 {
> +			#sound-dai-cells = <0>;
> +			compatible = "fsl,vf610-sai";
> +			reg = <0x0 0xf130000 0x0 0x10000>;
> +			interrupts = <0 83 0x4>;
> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> +				 <&clockgen 4 1>, <&clockgen 4 1>;
> +			clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +			dma-names = "tx", "rx";
> +			dmas = <&edma0 1 10>,
> +			       <&edma0 1 9>;
> +			status = "disabled";
> +		};
>  	};
>  };
> -- 
> 1.7.1
> 
