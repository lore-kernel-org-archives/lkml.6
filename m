Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423128AbeCBMwI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:52:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56813 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422890AbeCBMwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:52:03 -0500
Date: Fri, 2 Mar 2018 13:51:59 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: tpc: Device tree description of the TPC board
Message-ID: <20180302125159.gufvhyy4ipyunmil@pengutronix.de>
References: <20180302121750.12865-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302121750.12865-1-lukma@denx.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:38:38 up 70 days, 20:57, 80 users,  load average: 0.11, 0.12,
 0.14
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Fri, Mar 02, 2018 at 01:17:50PM +0100, Lukasz Majewski wrote:
> This commit adds device tree description of K+P's TPC board.

Can we get a hint what this board is? I assume this one:

Technologic Systems' Full i.MX6 Portfolio Including SBC, COM, and Touch
Panel PCs

Anyway, future developers are thankful if they have the information
around when they have to work on that file or have to decide if it is to
be removed.

> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/boot/dts/Makefile         |   1 +
>  arch/arm/boot/dts/imx6q-kp-tpc.dts |  84 +++++++
>  arch/arm/boot/dts/imx6q-kp.dtsi    | 468 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 553 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-kp-tpc.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-kp.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38543dc..c148c4cf28f2 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -459,6 +459,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-icore-ofcap10.dtb \
>  	imx6q-icore-ofcap12.dtb \
>  	imx6q-icore-rqs.dtb \
> +	imx6q-kp-tpc.dtb \
>  	imx6q-marsboard.dtb \
>  	imx6q-mccmon6.dtb \
>  	imx6q-nitrogen6x.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-kp-tpc.dts b/arch/arm/boot/dts/imx6q-kp-tpc.dts
> new file mode 100644
> index 000000000000..955462e778c9
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-kp-tpc.dts
> +/dts-v1/;
> +
> +#include "imx6q-kp.dtsi"
> +
> +/ {
> +	model = "Freescale i.MX6 Quad K+P TPC Board";
> +	compatible = "fsl,imx6q-tpc", "fsl,imx6q";

If it is what I think it is the vendor is not fsl.

> +};
> +
> +&lcd_display {
> +	display-timings {
> +		800x480x60 {
> +			clock-frequency = <34209000>;
> +			hactive = <800>;
> +			vactive = <480>;
> +			hback-porch = <85>;
> +			hfront-porch = <15>;
> +			vback-porch = <34>;
> +			vfront-porch = <10>;
> +			hsync-len = <28>;
> +			vsync-len = <1>;
> +			hsync-active = <1>;
> +			vsync-active = <1>;
> +			de-active = <1>;
> +		};
> +	};
> +};
> +
> +&ipu1_di0_disp0 {
> +	remote-endpoint = <&lcd_display_in>;
> +};
> +
> +&can1 {
> +	status = "disabled";
> +};
> +
> +&can2 {
> +	status = "disabled";
> +};

These are not enabled in your base dtsi, so no need to disabled it here.

> +
> +&uart1 {
> +	status = "okay";
> +};

This is already enabled in your base dtsi.

> +
> +&uart2 {
> +	status = "disabled";
> +};

This is still disabled, no need to enable.

> diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi b/arch/arm/boot/dts/imx6q-kp.dtsi
> new file mode 100644
> index 000000000000..47a10fb1d46b
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-kp.dtsi
> +
> +	memory: memory {
> +		reg = <0x10000000 0x40000000>;
> +	};
> +
> +	pwm-buzzer {
> +		compatible = "pwm-backlight";

What is it? A backlight or a buzzer?

> +		pwms = <&pwm2 0 500000>; //2kHz
> +		brightness-levels = <
> +			0   7  8  9
> +			10 11 12 13 14 15 16 17 18 19
> +			20 21 22 23 24 25 26 27 28 29
> +			30 31 32 33 34 35 36 37 38 39
> +			40 41 42 43 44 45 46 47 48 49
> +			50 51 52 53 54 55 56 57 58 59
> +			60 61 62 63 64 65 66 67 68 69
> +			70 71 72 73 74 75 76 77 78 79
> +			80 81 82 83 84 85 86 87 88 89
> +			90 91 92 93 94 95 96 97 98 99
> +			100
> +			>;
> +		default-brightness-level = <0>;
> +	};
> +
> +	regulators {

AFAIK regulators shall no longer be in a separate subnode.

> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reg_usb_h1_vbus: regulator@1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;

drop the reg property and also the @1 in the name.

> +			regulator-name = "usb_h1_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +		};
> +
> +		reg_audio: regulator@2 {
> +			compatible = "regulator-fixed";
> +			reg = <2>;

ditto

> +			regulator-name = "sgtl5000-supply";
> +			gpio = <&gpio6 31 GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +			regulator-always-on;
> +		};
> +
> +		reg_3p3v: regulator@3 {
> +			compatible = "regulator-fixed";
> +			reg = <4>;

ditto.

(You have to change the node names of course to make them unique again)


Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
