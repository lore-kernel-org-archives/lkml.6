Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29A8C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0652174E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6azNIAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0652174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeH0E6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 00:58:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbeH0E6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 00:58:44 -0400
Received: from dragon (unknown [104.237.86.214])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6771E2174A;
        Mon, 27 Aug 2018 01:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535332463;
        bh=3l1jMqHGei/KZw19IB00NHx1QO3zpFfMMnmwKH5ZH+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6azNIAgi53UTT2f4Y005D15zF7sQdaZQ1PNEKnhfCTadVfMVRYD6eqbwaClKBLnD
         U9iyHg8L9xp3P9pWaZG9WAjL2pDw2gYRAThOTOUfa2UvMzfUF4BlV0LW6DmOCFQEOp
         q3w4F6dsu4wZvcEhQKqhddr4sujo6E2n9Uc6fyg8=
Date:   Mon, 27 Aug 2018 09:13:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jan Tuerk <jan.tuerk@emtrion.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/4] ARM: dts: Add support for emtrion emCON-MX6 series
Message-ID: <20180827011328.GA29208@dragon>
References: <20180822155137.10018-1-jan.tuerk@emtrion.com>
 <20180824132617.43975-1-jan.tuerk@emtrion.com>
 <20180824132617.43975-3-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824132617.43975-3-jan.tuerk@emtrion.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 03:26:13PM +0200, Jan Tuerk wrote:
> This patch adds support for the emtrion GmbH emCON-MX6 modules.
> They are available with imx.6 Solo, Dual-Lite, Dual and Quad
> equipped with Memory from 512MB to 2GB (configured by U-Boot).
> 
> Our default developer-Kit ships with the Avari baseboard and the
> EDT ETM0700G0BDH6 Display (imx6[q|dl]-emcon-avari).
> 
> The devicetree is split into the common part providing all module
> components and the basic support for all SoC versions
> (imx6qdl-emcon.dtsi) and parts which are i.mx6 S|DL and D|Q relevant.
> Finally the support for the avari baseboard in the developer-kit
> configuration is provided by the emcon-avari dts files.
> 
> Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
> ---
>  arch/arm/boot/dts/Makefile                 |   2 +
>  arch/arm/boot/dts/imx6dl-emcon-avari.dts   |  14 +
>  arch/arm/boot/dts/imx6q-emcon-avari.dts    |  14 +
>  arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi | 177 +++++
>  arch/arm/boot/dts/imx6qdl-emcon.dtsi       | 832 +++++++++++++++++++++
>  5 files changed, 1039 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-emcon-avari.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-emcon-avari.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6qdl-emcon.dtsi
> 
> Changes in v6: 
>   - none (PATCH 4/4 - fix typo)
> 
> Changes for v5:
>   - rename boardID -> boardid.
>   - remove Author info.
>   - rename regulators from reg_xxx to reg-xxx.
>   - delete mx6q/mx6dl specific camera pinmux and the corresponding file.
>   - delete defaults in hoggrp.
>   - rename parallel-display to display and panel to lcd.
>   - rename rtc label to ds1307.
>   - add alias for rtc0 pointing to ds1307.
>   - move memory and stdout from the baseboard to the module description.
>   - reviewed the pinmux names for more consitent nameing.
>     => pin-groups -> postfix grp (..audmux -> audmuxgrp)
>     => single-pin -> non-postfix (..emcon_gpio1)
>   - rename label wdt to watchdog
>   - coding-style 
>     -> remove end of file new-lines
>     -> clean-up new-lines between nodes
>     -> re-align brightness values for the backlights.
> 
> Unchanged in v5:
>   - pinctrl for emcon_gpio0..8, emcon_irqa..c, etc. => they're used 
>     with different functions for different (customer) baseboards. Having
>     them in a single pinctrl it could only be referenced in a single
>     entity.
>   - keep "unused" pinctrls in the module-description. They're matching 
>     the connector spec and are intended to be defined for upcoming or
>     customer baseboards without defining them again and again. 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b5bd3de87c33..f7d1a2bd28ef 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -394,6 +394,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-cubox-i-emmc-som-v15.dtb \
>  	imx6dl-cubox-i-som-v15.dtb \
>  	imx6dl-dfi-fs700-m60.dtb \
> +	imx6dl-emcon-avari.dtb \
>  	imx6dl-gw51xx.dtb \
>  	imx6dl-gw52xx.dtb \
>  	imx6dl-gw53xx.dtb \
> @@ -458,6 +459,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-display5-tianma-tm070-1280x768.dtb \
>  	imx6q-dmo-edmqmx6.dtb \
>  	imx6q-dms-ba16.dtb \
> +	imx6q-emcon-avari.dtb \
>  	imx6q-evi.dtb \
>  	imx6q-gk802.dtb \
>  	imx6q-gw51xx.dtb \
> diff --git a/arch/arm/boot/dts/imx6dl-emcon-avari.dts b/arch/arm/boot/dts/imx6dl-emcon-avari.dts
> new file mode 100644
> index 000000000000..46eb7c2c7344
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-emcon-avari.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0 or MIT)
> +/*
> + * Copyright (C) 2018 emtrion GmbH
> + */
> +
> +/dts-v1/;
> +#include "imx6dl.dtsi"
> +#include "imx6qdl-emcon.dtsi"
> +#include "imx6qdl-emcon-avari.dtsi"
> +
> +/ {
> +	model = "emtrion SoM emCON-MX6 Solo/Dual-Lite Avari";
> +	compatible = "emtrion,emcon-mx6-avari", "fsl,imx6dl";
> +};
> diff --git a/arch/arm/boot/dts/imx6q-emcon-avari.dts b/arch/arm/boot/dts/imx6q-emcon-avari.dts
> new file mode 100644
> index 000000000000..fe719e0f8cae
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-emcon-avari.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0 or MIT)
> +/*
> + * Copyright (C) 2018 emtrion GmbH
> + */
> +
> +/dts-v1/;
> +#include "imx6q.dtsi"
> +#include "imx6qdl-emcon.dtsi"
> +#include "imx6qdl-emcon-avari.dtsi"
> +
> +/ {
> +	model = "emtrion SoM emCON-MX6 Dual/Quad on Avari";
> +	compatible = "emtrion,emcon-mx6-avari", "fsl,imx6q";
> +};
> diff --git a/arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi b/arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi
> new file mode 100644
> index 000000000000..b6bbb30ca538
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: (GPL-2.0 or MIT)
> +/*
> + * Copyright (C) 2018 emtrion GmbH
> + */
> +
> +/ {
> +	aliases {
> +		mmc0 = &usdhc3;
> +		mmc2 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		mmc3 = &usdhc4;
> +		boardid = &boardid;

Please keep them alphabetically sorted.

> +	};
> +
> +	reg_wall_5p0: reg-wall5p0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "Main-Supply";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reg_base3p3: reg-base3p3 {
> +		compatible = "regulator-fixed";
> +		vin-supply = <&reg_wall_5p0>;
> +		regulator-name = "3V3-avari";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reg_base1p5: reg-base1p5 {
> +		compatible = "regulator-fixed";
> +		vin-supply = <&reg_base3p3>;
> +		regulator-name = "1V5-avari";
> +		regulator-min-microvolt = <1500000>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reg_usb_otg: reg-otgvbus {
> +		compatible = "regulator-fixed";
> +		vin-supply = <&reg_wall_5p0>;
> +		regulator-name = "OTG_VBUS";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio1 8 GPIO_ACTIVE_LOW>;
> +		regulator-always-on;
> +	};
> +
> +	clk_codec: clock-codec {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency  = <12000000>;
> +	};
> +
> +	sound {
> +		compatible = "fsl,imx-audio-sgtl5000";
> +		model = "emCON-avari-sgtl5000";
> +		ssi-controller = <&ssi2>;
> +		audio-codec = <&sgtl5000>;
> +		audio-routing =
> +			"Headphone Jack", "HP_OUT";
> +		mux-int-port = <2>;
> +		mux-ext-port = <3>;
> +	};
> +};
> +
> +&audmux {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_audmux>;
> +	status = "okay";
> +};
> +
> +&can1 {
> +	status = "okay";
> +};
> +
> +&can2 {
> +	status = "okay";
> +};
> +
> +&ecspi2 {
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	ddc-i2c-bus = <&i2c2>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	sgtl5000: audio-codec@a {
> +		compatible = "fsl,sgtl5000";
> +		reg = <0x0a>;
> +		#sound-dai-cells = <0>;
> +		clocks = <&clk_codec>;
> +		VDDA-supply = <&reg_base3p3>;
> +		VDDIO-supply = <&reg_base3p3>;
> +	};
> +
> +	boardid: gpio@3a {
> +		compatible = "nxp,pca8574";
> +		reg = <0x3a>;
> +		gpio-controller;
> +		#gpio-cells = <1>;
> +	};
> +
> +	captouch: touchscreen@38 {

The I2C device nodes should be arranged in order of device/unit address.
That said, touchscreen@38 should go before gpio@3a.

> +		compatible = "edt,edt-ft5406";
> +		reg = <0x38>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_irq_touch2 &pinctrl_emcon_gpio4>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
> +		wake-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
> +		wakeup-source;
> +	};
> +};
> +
> +&pcie {
> +	status = "okay";
> +};
> +
> +&rgb_encoder {
> +	status = "okay";
> +};
> +
> +&rgb_panel {
> +	compatible = "edt,etm0700g0bdh6";
> +	status = "okay";
> +};
> +
> +&ssi2 {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +	uart-has-rtscts;
> +};
> +
> +&uart3 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
> new file mode 100644
> index 000000000000..4958ae3b924c
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
> @@ -0,0 +1,832 @@
> +// SPDX-License-Identifier: (GPL-2.0 or MIT)
> +/*
> + * Copyright (C) 2018 emtrion GmbH
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +
> +	model = "emtrion SoM emCON-MX6";
> +	compatible = "emtrion,emcon-mx6";
> +
> +	aliases {
> +		mmc0 = &usdhc3;
> +		mmc2 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		rtc0 = &ds1307;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	memory@10000000 {
> +		reg = <0x10000000 0x40000000>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_emcon_wake>;
> +
> +		wake {
> +			label = "Wake";
> +			linux,code = <KEY_WAKEUP>;
> +			gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	som_leds: leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_som_leds>;
> +
> +		green {
> +			label = "som:green";
> +			gpios = <&gpio3 0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			default-state = "on";
> +		};
> +
> +		red {
> +			label = "som:red";
> +			gpios = <&gpio3 1 GPIO_ACTIVE_LOW>;
> +			default-state = "keep";
> +		};
> +
> +	};
> +
> +	lvds_backlight: lvds-backlight {
> +		compatible = "pwm-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lvds_bl>;
> +		enable-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>;
> +		pwms = <&pwm1 0 50000>;
> +		brightness-levels = <
> +			0 4 8 16 32 64 80 96 112
> +			128 144 160 176 250
> +		>;
> +		default-brightness-level = <13>;
> +		status = "okay";
> +	};
> +
> +	pwm_fan: pwm-fan {
> +		compatible = "pwm-fan";
> +		cooling-min-state = <0>;
> +		cooling-max-state = <4>;
> +		#cooling-cells = <2>;
> +		pwms = <&pwm4 0 50000>;
> +		cooling-levels = <0 64 127 191 255>;
> +		status = "disabled";
> +	};
> +
> +
> +	rgb_encoder: display {
> +		compatible = "fsl,imx-parallel-display";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_rgb24_display>;
> +		status = "disabled";
> +
> +		port@0 {
> +			reg = <0>;
> +
> +			rgb_encoder_in: endpoint {
> +				remote-endpoint = <&ipu1_di0_disp0>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			rgb_encoder_out: endpoint {
> +				remote-endpoint = <&rgb_panel_in>;
> +			};
> +		};
> +	};
> +
> +	rgb_panel: lcd {
> +		backlight = <&rgb_backlight>;
> +		power-supply = <&reg_parallel_disp>;
> +
> +		port {
> +			rgb_panel_in: endpoint {
> +				remote-endpoint = <&rgb_encoder_out>;
> +			};
> +		};
> +	};
> +
> +	reg_parallel_disp: reg-parallel-display {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_rgb_bl_en>;
> +		regulator-name = "LCD-Supply";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio7 9 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_lvds_disp: reg-lvds-display {
> +		compatible = "regulator-fixed";
> +		regulator-name = "LVDS-Supply";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio7 10 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	rgb_backlight: rgb-backlight {
> +		compatible = "pwm-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_rgb_bl>;
> +		enable-gpios = <&gpio6 8 GPIO_ACTIVE_HIGH>;
> +		pwms = <&pwm3 0 5000000>;
> +		brightness-levels = <
> +			250 176 160 144 128 112
> +			96 80 64 48 32 16 8 1
> +		>;
> +		default-brightness-level = <13>;
> +		status = "okay";
> +	};
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can1>;
> +};
> +
> +&can2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can2>;
> +};
> +
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	cs-gpios = <&gpio2 25 GPIO_ACTIVE_HIGH>,
> +	<&gpio2 26 GPIO_ACTIVE_HIGH>;

This line needs a proper indentation.

> +};
> +
> +&ecspi4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_nor_flash>;
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-mode = "rgmii";
> +	phy-reset-gpios = <&gpio5 20 GPIO_ACTIVE_LOW>;
> +	phy-reset-duration = <50>;
> +	phy-supply = <&vdd_1V8_reg>;
> +	phy-handle = <&ksz9031>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ksz9031: phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			interrupt-parent = <&gpio1>;
> +			interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
> +			rxdv-skew-ps = <480>;
> +			txen-skew-ps = <480>;
> +			rxd0-skew-ps = <480>;
> +			rxd1-skew-ps = <480>;
> +			rxd2-skew-ps = <480>;
> +			rxd3-skew-ps = <480>;
> +			txd0-skew-ps = <420>;
> +			txd1-skew-ps = <420>;
> +			txd2-skew-ps = <360>;
> +			txd3-skew-ps = <360>;
> +			txc-skew-ps = <1020>;
> +			rxc-skew-ps = <960>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	ds1307: rtc@68 {
> +		compatible = "dallas,ds1307";
> +		reg = <0x68>;
> +	};
> +
> +	da9063: pmic@58 {

Sort I2C devices in address.

Shawn

> +		compatible = "dlg,da9063";
> +		reg = <0x58>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-controller;
