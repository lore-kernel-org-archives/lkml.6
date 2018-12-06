Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63D2C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86015208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544060102;
	bh=WvHEc2BLCVEQoCTYhCUlbgy6Sx6/K3Hx/ILP0EL3YKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nc2iIih+QXbjW6VsGVEA1v473huHlWuFsPKJ7/vx64YnEaCdO3bK+Ps9Q4Ie+y48E
	 CiHlI6cCXRVEfMKUQ5N31p3hj/29b+dTAGLW2HQli5cF79WsIARx3msGo6aNJpAFmK
	 2gY4N8lg5Rbu0E2QLTOkP6Mo7fF+pYEYqEeb3aqU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86015208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeLFBfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:35:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbeLFBfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:35:00 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9800D20892;
        Thu,  6 Dec 2018 01:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544060099;
        bh=WvHEc2BLCVEQoCTYhCUlbgy6Sx6/K3Hx/ILP0EL3YKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkgAzdcGuKvJXlUvfqXHKASVe7GhginMzq18/MMbn3xE2wWll+kgxq9IPRuXDACkE
         wEH+eO3CcExTknR04N8/2sdkAkQ+c6DSanImrFQ3zAg24FgnvD5cEYZLxA/mHJTp2n
         IIr6wSBLl7vyMaJm6D/vUl7zdDPqhdeO6QYeImA8=
Date:   Thu, 6 Dec 2018 09:34:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 4/5] ARM: dts: imx6ul-pico-hobbit: Extend peripherals
 support
Message-ID: <20181206013419.GT3987@dragon>
References: <20181202211809.11621-1-otavio@ossystems.com.br>
 <20181202211809.11621-5-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202211809.11621-5-otavio@ossystems.com.br>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 07:18:08PM -0200, Otavio Salvador wrote:
> From: Fabio Estevam <festevam@gmail.com>
> 
> This adds following peripherals support:
> 
>  - ADC
>  - GPIO LED
>  - GPIOs
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> ---
> 
>  arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 30 ++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
> index 8656ccbb5a06..f2dd6945e98c 100644
> --- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
> +++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
> @@ -14,6 +14,8 @@
>  
>  	leds {
>  		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
>  
>  		led {
>  			label = "gpio-led";
> @@ -58,6 +60,12 @@
>  &i2c3 {
>  	status = "okay";
>  
> +	adc081c: adc@50 {
> +		compatible = "ti,adc081c";
> +		reg = <0x50>;
> +		vref-supply = <&reg_3p3v>;
> +	};
> +

The child nodes should be sorted in order of unit-address.  That said,
it should go after touchscreen@38 below.

I fixed it up and applied the series.

Shawn

>  	polytouch: touchscreen@38 {
>  		compatible = "edt,edt-ft5x06";
>  		reg = <0x38>;
> @@ -68,3 +76,25 @@
>  		touchscreen-size-y = <480>;
>  	};
>  };
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x10b0
> +			MX6UL_PAD_CSI_DATA00__GPIO4_IO21	0x10b0
> +			MX6UL_PAD_CSI_DATA01__GPIO4_IO22	0x10b0
> +			MX6UL_PAD_CSI_DATA02__GPIO4_IO23	0x10b0
> +			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18	0x10b0
> +			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x10b0
> +		>;
> +	};
> +
> +	pinctrl_gpio_leds: gpioledsgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART4_RX_DATA__GPIO1_IO29	0x10b0
> +		>;
> +	};
> +};
> -- 
> 2.19.2
> 
