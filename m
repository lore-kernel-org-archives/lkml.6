Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeEDI2B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbeEDI14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:27:56 -0400
Date: Fri, 4 May 2018 16:27:34 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, haibo.chen@nxp.com, devicetree@vger.kernel.org,
        Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6sx-sabreauto: add egalax touch screen
 support
Message-ID: <20180504082733.GC3443@dragon>
References: <1524813650-19241-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524813650-19241-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 03:20:50PM +0800, Anson Huang wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Add egalax touch screen support on i2c2 bus.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> this patch is based on patch (ARM: dts: imx6sx-sabreauto: add debug LED support) I sent out for review.
>  arch/arm/boot/dts/imx6sx-sabreauto.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> index 6b94f24..2f6e474 100644
> --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> @@ -131,6 +131,12 @@
>  &iomuxc {
>  	imx6x-sabreauto {
>  
> +		pinctrl_egalax_int: egalax_intgrp {

General recommendation: use hyphen instead of underscore in the node
node.

> +			fsl,pins = <
> +				MX6SX_PAD_SD4_RESET_B__GPIO6_IO_22      0x80000000
> +			>;
> +		};
> +
>  		pinctrl_led: ledgrp {
>  			fsl,pins = <
>  				MX6SX_PAD_CSI_PIXCLK__GPIO1_IO_24 0x17059
> @@ -274,6 +280,16 @@
>  	pinctrl-0 = <&pinctrl_i2c2_1>;
>  	status = "okay";
>  
> +	egalax_ts@04 {

Use generic node name - touchscreen, as recommended by Devicetree
Specification, and drop leading zeros in unit-address.

Shawn

> +		compatible = "eeti,egalax_ts";
> +		reg = <0x04>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_egalax_int>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
> +		wakeup-gpios = <&gpio6 22 GPIO_ACTIVE_HIGH>;
> +	};
> +
>  	max7322: gpio@68 {
>  		compatible = "maxim,max7322";
>  		reg = <0x68>;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
