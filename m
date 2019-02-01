Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B768C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45C620869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549001947;
	bh=lSKGv2Sb6thunnofkbGM1esWz8mcJqbEDptaAQIxnZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IZNhGNffMIMLAgjODrDkYmPNYGveZUjMXMaadubCfwpHaduELtAQl7OP6BDVGtu1y
	 HXyFU1aLrAKmfNZhjwDSanUqMJp4JGeeY08P6A4a+SG1gWebi1e1xYwH3c0N5iRnHH
	 ylhdBXVtrfvN67+B1UmcRQv/2pIU6o0d60jU/L5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfBAGTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 01:19:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbfBAGTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 01:19:04 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D62212082F;
        Fri,  1 Feb 2019 06:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549001941;
        bh=lSKGv2Sb6thunnofkbGM1esWz8mcJqbEDptaAQIxnZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2vMi9RI6A7G7eTX/cit+X5pNtGxkiVcTNgJ7+kitLfDjJji6nmp8/sVeDVgYcZI7Q
         Qo21uXcP/xPPGj95wBWexeUKAxYHoTHW5n1gBRPAPYio4kTKN3u3Mu9QUZhDTSp8H5
         n8iw7rIZOoNHXG5UqxEvp7EQczpZk9xUrbzHr4h4=
Date:   Fri, 1 Feb 2019 14:18:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] ARM: dts: imx: Add support for Logic PD i.MX6QD EVM
Message-ID: <20190201061846.GI19882@dragon>
References: <20190123141018.20186-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123141018.20186-1-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 08:10:17AM -0600, Adam Ford wrote:
> The EVM consists of a system on module (SOM) and baseboard, and LCD.
> This patch adds a DTSI file for the SOM and baseboard separately,
> then a wrapper to combine them and specify processor type and a
> LCD information.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
> V3: Change tmp102->temperature-sensor
>     Change at24->eeprom
>     Both per Fabio
> V2:  Make node names more generic and label names more specific.
> Don't make audio regulator always-on.
> Remove I2C touch controller until the driver is available
> Switch LVDS display to a compatible display that's available
> Fix memory node.
> Fix whitespace
> 
> diff --git a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
> new file mode 100644
> index 000000000000..55cdb702a355
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
> @@ -0,0 +1,555 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2019 Logic PD, Inc.
> +
> +/ {
> +	keyboard {
> +		compatible = "gpio-keys";
> +
> +		btn0 {
> +			gpios = <&pcf8575 0 GPIO_ACTIVE_LOW>;
> +			label = "btn0";
> +			linux,code = <KEY_WAKEUP>;
> +			debounce-interval = <10>;
> +			wakeup-source;
> +		};
> +
> +		btn1 {
> +			gpios = <&pcf8575 1 GPIO_ACTIVE_LOW>;
> +			label = "btn1";
> +			linux,code = <KEY_WAKEUP>;
> +			debounce-interval = <10>;
> +			wakeup-source;
> +		};
> +
> +		btn2 {
> +			gpios = <&pcf8575 2 GPIO_ACTIVE_LOW>;
> +			label = "btn2";
> +			linux,code = <KEY_WAKEUP>;
> +			debounce-interval = <10>;
> +			wakeup-source;
> +		};

Have a newline between nodes.

> +		btn3 {
> +			gpios = <&pcf8575 3 GPIO_ACTIVE_LOW>;
> +			label = "btn3";
> +			linux,code = <KEY_WAKEUP>;
> +			debounce-interval = <10>;
> +			wakeup-source;
> +		};
> +
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		gen_led0 {

We prefer to use hyphen than underscore in node name.

> +			label = "led0";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_led0>;
> +			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "cpu0";
> +		};
> +
> +		gen_led1 {
> +			label = "led1";
> +			gpios = <&pcf8575 8 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		gen_led2 {
> +			label = "led2";
> +			gpios = <&pcf8575 9 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		gen_led3 {
> +			label = "led3";
> +			gpios = <&pcf8575 10 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "default-on";
> +		};
> +	};
> +
> +	reg_usb_otg_vbus: regulator-otg-vbus {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usb_otg>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usb_h1_vbus: regulator-usb-h1-vbus {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usb_h1_vbus>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_h1_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_3v3: regulator-3v3 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_3v3>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "reg_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +

One newline is good enough.

> +	reg_enet: regulator-ethernet {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_enet>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "ethernet-supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <70000>;
> +		enable-active-high;
> +		vin-supply = <&sw4_reg>;
> +	};
> +
> +	reg_audio: regulator-audio {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_audio>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "3v3_aud";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		vin-supply = <&reg_3v3>;
> +	};
> +
> +	reg_hdmi: regulator-hdmi {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_hdmi>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "hdmi-supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		vin-supply = <&reg_3v3>;
> +	};
> +
> +	reg_uart3: regulator-uart3 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_uart3>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "uart3-supply";
> +		gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +		vin-supply = <&reg_3v3>;
> +	};
> +
> +	reg_1v8: regulator-1v8 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_1v8>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "1v8-supply";
> +		gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +		vin-supply = <&reg_3v3>;
> +	};
> +
> +	reg_pcie: regulator-pcie {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_pcie>;
> +		regulator-name = "mpcie_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_mipi: regulator-mipi {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_mipi>;
> +		regulator-name = "mipi_pwr_en";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		gpio = <&gpio3 19 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	sound {
> +		compatible = "fsl,imx-audio-wm8962";
> +		model = "wm8962-audio";
> +		ssi-controller = <&ssi2>;
> +		audio-codec = <&wm8962>;
> +		audio-routing =
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"Ext Spk", "SPKOUTL",
> +			"Ext Spk", "SPKOUTR",
> +			"AMIC", "MICBIAS",
> +			"IN3R", "AMIC";
> +		mux-int-port = <2>;
> +		mux-ext-port = <4>;
> +	};
> +};
> +
> +&audmux {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_audmux>;
> +	status = "okay";
> +};
> +
> +&ecspi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	status = "disabled";
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-mode = "rgmii";
> +	phy-reset-duration = <10>;
> +	phy-reset-gpios = <&gpio1 24 GPIO_ACTIVE_LOW>;
> +	phy-supply = <&reg_enet>;
> +	interrupt-parent = <&gpio1>;
> +	interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	wm8962: codec@1a {

audio-codec for node name.

> +		compatible = "wlf,wm8962";
> +		reg = <0x1a>;
> +		clocks = <&clks IMX6QDL_CLK_CKO>;
> +		clock-names = "xclk";
> +		DCVDD-supply = <&reg_audio>;
> +		DBVDD-supply = <&reg_audio>;
> +		AVDD-supply = <&reg_audio>;
> +		CPVDD-supply = <&reg_audio>;
> +		MICVDD-supply = <&reg_audio>;
> +		PLLVDD-supply = <&reg_audio>;
> +		SPKVDD1-supply = <&reg_audio>;
> +		SPKVDD2-supply = <&reg_audio>;
> +		gpio-cfg = <
> +			0x0000 /* 0:Default */
> +			0x0000 /* 1:Default */
> +			0x0013 /* 2:FN_DMICCLK */
> +			0x0000 /* 3:Default */
> +			0x8014 /* 4:FN_DMICCDAT */
> +			0x0000 /* 5:Default */
> +		>;
> +	};
> +};
> +
> +&i2c3 {
> +	ov5640: camera@10 {
> +		compatible = "ovti,ov5640";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ov5640>;
> +		reg = <0x10>;
> +		clocks = <&clks IMX6QDL_CLK_CKO>;
> +		clock-names = "xclk";
> +		DOVDD-supply = <&reg_mipi>;
> +		AVDD-supply = <&reg_mipi>;
> +		DVDD-supply = <&reg_mipi>;
> +		reset-gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
> +		powerdown-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			ov5640_to_mipi_csi2: endpoint {
> +				remote-endpoint = <&mipi_csi2_in>;
> +				clock-lanes = <0>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +	};
> +
> +	pcf8575: gpio@20 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pcf8574>;
> +		compatible = "nxp,pcf8575";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		lines-initial-states = <0x0710>;
> +		wakeup-source;
> +	};
> +};
> +
> +&ipu1_csi1_from_mipi_vc1 {
> +	clock-lanes = <0>;
> +	data-lanes = <1 2>;
> +};
> +
> +&mipi_csi {
> +	status = "okay";
> +
> +	port@0 {
> +		reg = <0>;
> +
> +		mipi_csi2_in: endpoint {
> +			remote-endpoint = <&ov5640_to_mipi_csi2>;
> +			clock-lanes = <0>;
> +			data-lanes = <1 2>;
> +		};
> +	};
> +};
> +
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie>;
> +	reset-gpio = <&gpio1 9 GPIO_ACTIVE_LOW>;
> +	status = "okay";

Please end property list with 'status'.

> +	vpcie-supply = <&reg_pcie>;
> +};
> +
> +&pwm3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm3>;
> +};
> +
> +&ssi2 {
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	vbus-supply = <&reg_usb_h1_vbus>;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	vbus-supply = <&reg_usb_otg_vbus>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg>;
> +	disable-over-current;
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +	vmmc-supply = <&reg_3v3>;
> +	no-1-8-v;
> +	keep-power-in-suspend;
> +	status = "okay";

Ditto

> +	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> +};
> +
> +&iomuxc {
> +

Drop this newline.

> +	pinctrl_audmux: audmuxgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
> +			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD  0x110b0
> +			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS 0x130b0
> +			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
> +		>;
> +	};
> +
> +	pinctrl_ecspi1: ecspi1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_COL0__ECSPI1_SCLK	0x100b1
> +			MX6QDL_PAD_KEY_ROW0__ECSPI1_MOSI	0x100b1
> +			MX6QDL_PAD_KEY_COL1__ECSPI1_MISO	0x100b1
> +			MX6QDL_PAD_KEY_ROW1__ECSPI1_SS0		0x100b1
> +		>;
> +	};
> +
> +	pinctrl_enet: enetgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b8b0
> +			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
> +			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b030
> +			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b030
> +			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b030
> +			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b030
> +			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b030
> +			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x100b0
> +			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b030
> +			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
> +			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b030
> +			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x13030
> +			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x13030
> +			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b030
> +			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b030
> +			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x13030
> +			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25	0x1b0b0	/* ENET_INT */
> +			MX6QDL_PAD_ENET_RX_ER__GPIO1_IO24	0x1b0b0	/* ETHR_nRST */
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D21__I2C1_SCL	0x4001b8b1
> +			MX6QDL_PAD_EIM_D28__I2C1_SDA	0x4001b8b1
> +		>;
> +	};
> +
> +	pinctrl_led0: led0grp {
> +	    fsl,pins = <
> +		MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x1b0b0
> +	    >;
> +	};
> +
> +	pinctrl_ov5640: ov5640grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D26__GPIO3_IO26	0x1b0b1
> +			MX6QDL_PAD_EIM_D27__GPIO3_IO27	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_pcf8574: pcf8575grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_BCLK__GPIO6_IO31 0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_pcie: pciegrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_8__GPIO1_IO08 0x1b0b0
> +			MX6QDL_PAD_GPIO_9__GPIO1_IO09 0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_pwm3: pwm3grp {
> +	    fsl,pins = <
> +		MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
> +	    >;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D23__UART3_CTS_B		0x1b0b1
> +			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
> +			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
> +			MX6QDL_PAD_EIM_EB3__UART3_RTS_B		0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usbotg: usbotggrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_1__USB_OTG_ID	0xd17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1b0b0	/* CD */
> +			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17069
> +			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10069
> +			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17069
> +			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17069
> +			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17069
> +			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17069
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: h100-usdhc2-100mhz {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1b0b0	/* CD */
> +			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x170b9
> +			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x100b9
> +			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x170b9
> +			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
> +			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
> +			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x170b9
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: h100-usdhc2-200mhz {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1b0b0	/* CD */
> +			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x170f9
> +			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x100f9
> +			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x170f9
> +			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x170f9
> +			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x170f9
> +			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x170f9
> +		>;
> +	};
> +
> +	pinctrl_reg_1v8: reg1v8grp {

Please sort these pinctrl nodes alphabetically.

> +	    fsl,pins = <
> +		MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x1b0b0
> +	    >;
> +	};
> +
> +	pinctrl_reg_3v3: reg3v3grp {
> +	    fsl,pins = <
> +		MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b0
> +	    >;
> +	};
> +
> +	pinctrl_reg_audio: reg-audiogrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_reg_enet: reg-enetgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D31__GPIO3_IO31	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_reg_hdmi: reg-hdmigrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D20__GPIO3_IO20	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_reg_mipi: reg-mipigrp {
> +		fsl,pins = <MX6QDL_PAD_EIM_D19__GPIO3_IO19 0x1b0b1>;
> +	};
> +
> +	pinctrl_reg_pcie: reg-pciegrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_2__GPIO1_IO02	0x1b0b0
> +			>;
> +	};
> +
> +	pinctrl_reg_uart3: reguart3grp {
> +	    fsl,pins = <
> +		MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28	0x1b0b0
> +	    >;
> +	};
> +
> +	pinctrl_reg_usb_h1_vbus: usbh1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_reg_usb_otg: reg-usb-otggrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0
> +		>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/imx6-logicpd-som.dtsi b/arch/arm/boot/dts/imx6-logicpd-som.dtsi
> new file mode 100644
> index 000000000000..078588798403
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6-logicpd-som.dtsi
> @@ -0,0 +1,363 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2019 Logic PD, Inc.
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	memory@10000000 {
> +		device_type = "memory";
> +		reg = <0x10000000 0x80000000>;
> +	};
> +
> +	reg_wl18xx_vmmc: regulator-wl18xx {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vwl1837";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio7 0 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <70000>;
> +		enable-active-high;
> +	};
> +};
> +
> +&clks {
> +	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
> +			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
> +	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
> +				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
> +};
> +
> +&gpmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpmi_nand>;
> +	status = "okay";

Move it to end of property list.

> +	nand-on-flash-bbt;
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	pfuze100: pmic@8 {
> +		compatible = "fsl,pfuze100";
> +		reg = <0x08>;
> +
> +		regulators {
> +			sw1a_reg: sw1ab {
> +				regulator-min-microvolt = <725000>;
> +				regulator-max-microvolt = <1450000>;
> +				regulator-name = "vddcore";
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <6250>;
> +			};
> +
> +			sw1c_reg: sw1c {
> +				regulator-min-microvolt = <725000>;
> +				regulator-max-microvolt = <1450000>;
> +				regulator-name = "vddsoc";
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <6250>;
> +			};
> +
> +			sw2_reg: sw2 {
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "gen_3v3";
> +				regulator-boot-on;
> +			};
> +
> +			sw3a_reg: sw3a {
> +				regulator-min-microvolt = <1350000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-name = "sw3a_vddr";
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw3b_reg: sw3b {
> +				regulator-min-microvolt = <1350000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-name = "sw3b_vddr";
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw4_reg: sw4 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "gen_rgmii";
> +			};
> +
> +			swbst_reg: swbst {
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5150000>;
> +				regulator-name = "gen_5v0";
> +			};
> +
> +			snvs_reg: vsnvs {
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-name = "gen_vsns";
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vref_reg: vrefddr {
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vgen1_reg: vgen1 {
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-name = "gen_1v5";
> +			};
> +
> +			vgen2_reg: vgen2 {
> +				regulator-name = "vgen2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +			};
> +
> +			vgen3_reg: vgen3 {
> +				regulator-name = "gen_vadj_0";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			vgen4_reg: vgen4 {
> +				regulator-name = "gen_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen5_reg: vgen5 {
> +				regulator-name = "gen_vadj_1";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen6_reg: vgen6 {
> +				regulator-name = "gen_2v5";
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <2500000>;
> +				regulator-always-on;
> +			};
> +
> +			coin_reg: coin {
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	temperature-sensor@4a {
> +		compatible = "ti,tmp102";
> +		reg = <0x4a>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_tempsense>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> +		#thermal-sensor-cells = <1>;
> +	};
> +
> +	temperature-sensor@49 {

Please keep nodes with unit-address sorted in the address order.

> +		compatible = "ti,tmp102";
> +		reg = <0x49>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> +		#thermal-sensor-cells = <1>;
> +	};
> +
> +	eeprom@51 {
> +		compatible = "atmel,24c64";
> +		pagesize = <32>;
> +		read-only;	/* Manufacturing EEPROM programmed at factory */
> +		reg = <0x51>;
> +	};
> +
> +	eeprom@52 {
> +		compatible = "atmel,24c64";
> +		pagesize = <32>;
> +		reg = <0x52>;
> +	};
> +};
> +
> +/* Reroute power feeding the CPU to come from the external PMIC */
> +&reg_arm
> +{
> +	vin-supply = <&sw1a_reg>;
> +};
> +
> +&reg_soc
> +{
> +	vin-supply = <&sw1c_reg>;
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <	/* Enable ARM Debugger */
> +			MX6QDL_PAD_CSI0_MCLK__ARM_TRACE_CTL	0x1b0b0
> +			MX6QDL_PAD_CSI0_PIXCLK__ARM_EVENTO	0x1b0b0
> +			MX6QDL_PAD_CSI0_VSYNC__ARM_TRACE00	0x1b0b0
> +			MX6QDL_PAD_CSI0_DATA_EN__ARM_TRACE_CLK	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT4__ARM_TRACE01	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT5__ARM_TRACE02	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT6__ARM_TRACE03	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT7__ARM_TRACE04	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT8__ARM_TRACE05	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT9__ARM_TRACE06	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT10__ARM_TRACE07	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT11__ARM_TRACE08	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT12__ARM_TRACE09	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT13__ARM_TRACE10	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT14__ARM_TRACE11	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT15__ARM_TRACE12	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT16__ARM_TRACE13	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT17__ARM_TRACE14	0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT18__ARM_TRACE15	0x1b0b0
> +			MX6QDL_PAD_GPIO_0__CCM_CLKO1        0x130b0
> +		>;
> +	};
> +
> +	pinctrl_gpmi_nand: gpmi-nandgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_NANDF_CLE__NAND_CLE		0x0b0b1
> +			MX6QDL_PAD_NANDF_ALE__NAND_ALE		0x0b0b1
> +			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0x0b0b1
> +			MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0x0b000
> +			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0x0b0b1
> +			MX6QDL_PAD_SD4_CMD__NAND_RE_B		0x0b0b1
> +			MX6QDL_PAD_SD4_CLK__NAND_WE_B		0x0b0b1
> +			MX6QDL_PAD_NANDF_D0__NAND_DATA00	0x0b0b1
> +			MX6QDL_PAD_NANDF_D1__NAND_DATA01	0x0b0b1
> +			MX6QDL_PAD_NANDF_D2__NAND_DATA02	0x0b0b1
> +			MX6QDL_PAD_NANDF_D3__NAND_DATA03	0x0b0b1
> +			MX6QDL_PAD_NANDF_D4__NAND_DATA04	0x0b0b1
> +			MX6QDL_PAD_NANDF_D5__NAND_DATA05	0x0b0b1
> +			MX6QDL_PAD_NANDF_D6__NAND_DATA06	0x0b0b1
> +			MX6QDL_PAD_NANDF_D7__NAND_DATA07	0x0b0b1
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
> +			MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
> +			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_RST__GPIO7_IO08		0x13059	/* BT_EN */
> +			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
> +			MX6QDL_PAD_SD4_DAT5__UART2_RTS_B	0x1b0b1
> +			MX6QDL_PAD_SD4_DAT6__UART2_CTS_B	0x1b0b1
> +			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD1_CMD__SD1_CMD	0x170B9
> +			MX6QDL_PAD_SD1_CLK__SD1_CLK	0x100B9
> +			MX6QDL_PAD_SD1_DAT0__SD1_DATA0	0x170B9
> +			MX6QDL_PAD_SD1_DAT1__SD1_DATA1	0x170B9
> +			MX6QDL_PAD_SD1_DAT2__SD1_DATA2	0x170B9
> +			MX6QDL_PAD_SD1_DAT3__SD1_DATA3	0x170B9
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17049
> +			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10049
> +			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17049
> +			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17049
> +			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17049
> +			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17049
> +			MX6QDL_PAD_SD3_DAT4__GPIO7_IO01	0x130b0 /* WL_IRQ */
> +			MX6QDL_PAD_SD3_DAT5__GPIO7_IO00	0x17059 /* WLAN_EN */
> +		>;
> +	};
> +
> +	pinctrl_tempsense: tempsensegrp {

Sort it properly.

> +		fsl,pins = <
> +			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x1b0b0
> +		>;
> +	};
> +};
> +
> +&snvs_poweroff {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";

Move it to end.

> +	uart-has-rtscts;

Have a newline between properties and child node.

> +	bluetooth {
> +		compatible = "ti,wl1837-st";
> +		enable-gpios = <&gpio7 8 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	non-removable;
> +	keep-power-in-suspend;
> +	enable-sdio-wakeup;

wakeup-source

> +	status = "okay";

Move it to end.

> +	vmmc-supply = <&sw2_reg>;
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	non-removable;
> +	cap-power-off-card;
> +	keep-power-in-suspend;
> +	wakeup-source;
> +	vmmc-supply = <&reg_wl18xx_vmmc>;
> +	status = "okay";

Move it to end.

> +	#address-cells = <1>;
> +	#size-cells = <0>;

Have a newline here.

> +	wlcore: wlcore@2 {
> +		  compatible = "ti,wl1837";
> +		  reg = <2>;
> +		  interrupt-parent = <&gpio7>;
> +		  interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
> +		  tcxo-clock-frequency = <26000000>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/imx6q-logicpd.dts b/arch/arm/boot/dts/imx6q-logicpd.dts
> new file mode 100644
> index 000000000000..877a4599e564
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-logicpd.dts
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2019 Logic PD, Inc.
> +
> +/dts-v1/;
> +#include "imx6q.dtsi"
> +#include "imx6-logicpd-som.dtsi"
> +#include "imx6-logicpd-baseboard.dtsi"
> +
> +/ {
> +	model = "Logic PD i.MX6QD SOM-M3";
> +	compatible = "fsl,imx6q";
> +
> +	backlight: backlight_lvds {

Use hyphen.

Shawn

> +		compatible = "pwm-backlight";
> +		pwms = <&pwm3 0 20000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;
> +		power-supply = <&reg_lcd>;
> +	};
> +
> +	panel-lvds0 {
> +		compatible = "okaya,rs800480t-7x0gp";
> +
> +		port {
> +			panel_in_lvds0: endpoint {
> +				remote-endpoint = <&lvds0_out>;
> +			};
> +		};
> +	};
> +
> +	reg_lcd: regulator-lcd {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd_reg>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "lcd_panel_pwr";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio4 17 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +		vin-supply = <&reg_3v3>;
> +		startup-delay-us = <500000>;
> +	};
> +
> +	reg_lcd_reset: regulator-lcd-reset {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd_reset>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "nLCD_RESET";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +		vin-supply = <&reg_lcd>;
> +	};
> +};
> +
> +&clks {
> +	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
> +			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>,
> +			  <&clks IMX6QDL_CLK_IPU1_DI0_PRE_SEL>,
> +			  <&clks IMX6QDL_CLK_IPU2_DI0_PRE_SEL>;
> +	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
> +				 <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
> +				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
> +				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>;
> +};
> +
> +&hdmi {
> +	ddc-i2c-bus = <&i2c3>;
> +	status = "okay";
> +};
> +
> +&ldb {
> +	status = "okay";
> +
> +	lvds-channel@0 {
> +		fsl,data-mapping = "spwg";
> +		fsl,data-width = <24>;
> +		status = "okay";
> +
> +		port@4 {
> +			reg = <4>;
> +			lvds0_out: endpoint {
> +				remote-endpoint = <&panel_in_lvds0>;
> +			};
> +		};
> +	};
> +
> +};
> +
> +&pwm3 {
> +	status = "okay";
> +};
> +
> +&reg_hdmi {
> +	regulator-always-on;	/* Without this, the level shifter on HDMI doesn't turn on */
> +};
> +
> +&iomuxc {
> +	pinctrl_lcd_reg: lcdreg {
> +		fsl,pins = <
> +			MX6QDL_PAD_DI0_PIN15__GPIO4_IO17	0x100b0	/* R_LCD_PANEL_PWR */
> +		>;
> +	};
> +
> +	pinctrl_lcd_reset: lcdreset {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_A25__GPIO5_IO02	0x100b0	/* LCD_nRESET */
> +		>;
> +	};
> +
> +	pinctrl_touchscreen: touchscreengrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_6__GPIO1_IO06	0x1b0b0	/* TOUCH_nPINTDAV */
> +		>;
> +	};
> +};
> -- 
> 2.17.1
> 
