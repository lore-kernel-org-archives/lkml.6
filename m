Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeEDIXc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:23:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751748AbeEDIX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:23:29 -0400
Date: Fri, 4 May 2018 16:23:13 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6sx-sabreauto: add debug LED support
Message-ID: <20180504082312.GB3443@dragon>
References: <1524812288-799-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524812288-799-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 02:58:08PM +0800, Anson Huang wrote:
> There is a debug LED(D11) connected to GPIO1_IO24, add
> support for it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> this patch is based on patch series (ARM: dts: imx6sx-sabreauto: add wdog external reset support).

In this case, you can include these two patches into the series, if you
need to resend the series.

Shawn

>  arch/arm/boot/dts/imx6sx-sabreauto.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> index eb1452c..6b94f24 100644
> --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> @@ -18,6 +18,18 @@
>  		reg = <0x80000000 0x80000000>;
>  	};
>  
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_led>;
> +
> +		user {
> +			label = "debug";
> +			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
>  	regulators {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -119,6 +131,12 @@
>  &iomuxc {
>  	imx6x-sabreauto {
>  
> +		pinctrl_led: ledgrp {
> +			fsl,pins = <
> +				MX6SX_PAD_CSI_PIXCLK__GPIO1_IO_24 0x17059
> +			>;
> +		};
> +

Try to sort the pinctrl node alphabetically.

Shawn

>  		pinctrl_enet1_1: enet1grp-1 {
>  			fsl,pins = <
>  				MX6SX_PAD_ENET1_MDIO__ENET1_MDIO        0xa0b1
> -- 
> 2.7.4
> 
