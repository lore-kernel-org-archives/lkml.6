Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeEDHup (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbeEDHuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:50:44 -0400
Date: Fri, 4 May 2018 15:50:28 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 3/6] ARM: dts: imx6sx-sabreauto: add IO expander
 max7310 support
Message-ID: <20180504075027.GY3443@dragon>
References: <1524725898-27974-1-git-send-email-Anson.Huang@nxp.com>
 <1524725898-27974-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524725898-27974-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 02:58:15PM +0800, Anson Huang wrote:
> i.MX6SX Sabre Auto board has two max7310 IO expander
> on I2C3 bus, add support for them.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> no changes since V4.
>  arch/arm/boot/dts/imx6sx-sabreauto.dts | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> index d59084f..812f40b 100644
> --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> @@ -82,6 +82,13 @@
>  			>;
>  		};
>  
> +		pinctrl_i2c3_2: i2c3grp-2 {

Drop suffix number '2'.

Shawn

> +			fsl,pins = <
> +				MX6SX_PAD_KEY_ROW4__I2C3_SDA            0x4001b8b1
> +				MX6SX_PAD_KEY_COL4__I2C3_SCL            0x4001b8b1
> +			>;
> +		};
> +
>  		pinctrl_uart1: uart1grp {
>  			fsl,pins = <
>  				MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
> @@ -272,3 +279,24 @@
>  		};
>  	};
>  };
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3_2>;
> +	status = "okay";
> +
> +	max7310_a: gpio@30 {
> +		compatible = "maxim,max7310";
> +		reg = <0x30>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
> +	max7310_b: gpio@32 {
> +		compatible = "maxim,max7310";
> +		reg = <0x32>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +};
> -- 
> 2.7.4
> 
