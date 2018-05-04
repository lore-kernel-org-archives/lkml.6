Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeEDHsk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751001AbeEDHsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:48:39 -0400
Date: Fri, 4 May 2018 15:48:22 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 2/6] ARM: dts: imx6sx-sabreauto: add max7322 IO
 expander support
Message-ID: <20180504074821.GX3443@dragon>
References: <1524725898-27974-1-git-send-email-Anson.Huang@nxp.com>
 <1524725898-27974-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524725898-27974-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 02:58:14PM +0800, Anson Huang wrote:
> Add MAX7322 IO expander support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> no changes since V4.
>  arch/arm/boot/dts/imx6sx-sabreauto.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> index 2caca934..d59084f 100644
> --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> @@ -163,6 +163,13 @@
>  	pinctrl-0 = <&pinctrl_i2c2_1>;
>  	status = "okay";
>  
> +	max7322: gpio@68 {
> +		compatible = "maxim,max7322";
> +		reg = <0x68>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +

For child nodes having unit-address ('reg' property), sort them in order
of unit-address.

Shawn

>  	pmic: pfuze100@08 {
>  		compatible = "fsl,pfuze100";
>  		reg = <0x08>;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
