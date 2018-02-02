Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeBBHBG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:01:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbeBBHAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:00:47 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE73D21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Fri, 2 Feb 2018 15:00:34 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx53: use PMIC's TSI pins in adc mode
Message-ID: <20180202070033.GB25699@dragon>
References: <20180115142820.31729-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115142820.31729-1-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2018 at 03:28:20PM +0100, Sebastian Reichel wrote:
> PPD uses the PMIC's TSI pins in general purpose ADC mode.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

s/imx53/imx53-ppd

> ---
>  arch/arm/boot/dts/imx53-ppd.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
> index 123297da43a7..80224fa995f9 100644
> --- a/arch/arm/boot/dts/imx53-ppd.dts
> +++ b/arch/arm/boot/dts/imx53-ppd.dts
> @@ -132,6 +132,14 @@
>  		enable-active-high;
>  	};
>  
> +	reg_tsiref: tsiref {

A better node name should be regulator-tsiref.

> +		compatible = "regulator-fixed";
> +		regulator-name = "tsiref";
> +		regulator-min-microvolt = <2500000>;
> +		regulator-max-microvolt = <2500000>;
> +		regulator-always-on;
> +	};
> +
>  	pwm_bl: backlight {
>  		compatible = "pwm-backlight";
>  		pwms = <&pwm2 0 50000>;
> @@ -295,6 +303,9 @@
>  		interrupts = <12 0x8>;
>  		spi-max-frequency = <1000000>;
>  

This new line can be dropped now.

I fixed up all these, and applied the patch.

Shawn 

> +		dlg,tsi-as-adc;
> +		tsiref-supply = <&reg_tsiref>;
> +
>  		regulators {
>  			buck1_reg: buck1 {
>  				regulator-name = "BUCKCORE";
> -- 
> 2.15.1
> 
