Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12125C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71B721736
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547372087;
	bh=9zXpcOEU5rJs3lMMuSiagh5+0qzFuZfsxBQtpm9rAik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iFOmHduYngktBHKfuIU6kQ1NkLUq9Y1ZS70u1Uy7orMatwDCy3G3h7xbEZ8FmRrdJ
	 vQhaCpALtl7VY9qQVBFwllErPiS0Hj9qFYbRa2gHKIokLJi/TaUN6OtwA3bYsNphH3
	 aSZgfG4sRhDYed9mKqzVEPIPr0oreHWypXvOeGd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfAMJer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 04:34:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfAMJeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 04:34:46 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FB862084C;
        Sun, 13 Jan 2019 09:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547372084;
        bh=9zXpcOEU5rJs3lMMuSiagh5+0qzFuZfsxBQtpm9rAik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/rNHLhD/a36QPgWTB67TQEqXXE6Q1HfSfDQZBxO7wbN52deRIAiR992BUgaZp6tx
         OWuWazF7kkSm/JEJqnJujwP1mliTZBJel2DSiA+Eqr3Lf+a7qzUipYtj0WsD8TyhC3
         PwwghekUQOgfHTzlLKK72dVH4xI0jEV+7Aiwab5E=
Date:   Sun, 13 Jan 2019 17:34:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH shawn/for-next v3 2/2] ARM: dts: imx: Add Y Soft IOTA
 Draco, Hydra and Ursa boards
Message-ID: <20190113093422.GM11426@dragon>
References: <1547137215-25928-1-git-send-email-michal.vokac@ysoft.com>
 <1547137215-25928-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547137215-25928-2-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 04:20:51PM +0000, Vokáč Michal wrote:
> These are i.MX6S/DL based SBCs embedded in various Y Soft products.
> All share the same board design but have slightly different HW
> configuration.
> 
> Ursa
> - i.MX6S SoC, 512MB RAM DDR3, 4GB eMMC, microSD
> - parallel WVGA 7" LCD with touch panel
> - 1x Eth (QCA8334 switch)
> - USB OTG
> - USB host (micro-B)
> 
> Draco
> - i.MX6S SoC, 512MB RAM DDR3, 4GB eMMC, microSD
> - parallel WVGA 7" LCD with touch panel
> - 2x Eth (QCA8334 switch)
> - USB OTG
> - USB host (micro-B)
> - RGB LED (I2C LP5562)
> - 3.5mm audio jack + codec (LM49350)
> 
> Hydra
> - i.MX6DL SoC, 2GB RAM DDR3, 4GB eMMC, microSD
> - I2C OLED display, capacitive matrix keys
> - 2x Eth (QCA8334 switch)
> - USB OTG
> - RGB LED (I2C LP5562)
> - 3.5mm audio jack + codec (LM49350)
> - HDMI
> - miniPCIe slot
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> Changes since v2:
>  - Remove cpus {/delete-node/ cpu@1;}; node from i.MX6Solo based board. (Fabio)
>  - Use "device_type = "memory";" in memory nodes. (Fabio)
>  - Use GPIO_ACTIVE_LOW for fec phy-reset-gpios. (Fabio)
>  - Use "-" in node names. (Rob)
>  - Remove label from led-controller node. (Rob)
> 
> Changes since v1:
>  - Enable HDMI on Hydra board.
>  - Move regulators to the root node and remove simple-bus property. (Rob)
>  - Remove reg and unit-address property from regulators. (Rob)
>  - Use correct names for led-controller and pmic node. (Rob)
>  - Use wakeup-source instead of deprecated enable-sdio-wakeup. (Shawn)
> 
>  arch/arm/boot/dts/Makefile                 |   3 +
>  arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 594 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6dl-yapp4-draco.dts   |  58 +++
>  arch/arm/boot/dts/imx6dl-yapp4-hydra.dts   |  50 +++
>  arch/arm/boot/dts/imx6dl-yapp4-ursa.dts    |  54 +++
>  5 files changed, 759 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-draco.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-ursa.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index bd40148..c0a9b89 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -445,6 +445,9 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-wandboard.dtb \
>  	imx6dl-wandboard-revb1.dtb \
>  	imx6dl-wandboard-revd1.dtb \
> +	imx6dl-yapp4-draco.dtb \
> +	imx6dl-yapp4-hydra.dtb \
> +	imx6dl-yapp4-ursa.dtb \
>  	imx6q-apalis-eval.dtb \
>  	imx6q-apalis-ixora.dtb \
>  	imx6q-apalis-ixora-v1.1.dtb \
> diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> new file mode 100644
> index 0000000..48c2847
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> @@ -0,0 +1,594 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2015-2018 Y Soft Corporation, a.s.
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
> +		brightness-levels = <0 32 64 128 255>;
> +		default-brightness-level = <32>;
> +		num-interpolated-steps = <8>;
> +		power-supply = <&sw2_reg>;
> +		status = "disabled";
> +	};
> +
> +	lcd_display: display {
> +		compatible = "fsl,imx-parallel-display";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interface-pix-fmt = "rgb24";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ipu1>;
> +		status = "disabled";
> +
> +		port@0 {
> +			reg = <0>;
> +
> +			lcd_display_in: endpoint {
> +				remote-endpoint = <&ipu1_di0_disp0>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			lcd_display_out: endpoint {
> +				remote-endpoint = <&lcd_panel_in>;
> +			};
> +		};
> +	};
> +
> +	panel: panel {
> +		compatible = "dataimage,scf0700c48ggu18";
> +		power-supply = <&sw2_reg>;
> +		status = "disabled";
> +
> +		port {
> +			lcd_panel_in: endpoint {
> +				remote-endpoint = <&lcd_display_out>;
> +			};
> +		};
> +	};
> +
> +	reg_usb_h1_vbus: reg-usb-h1-vbus {

Please spell out regulator in node name, and abbr. 'reg-' for label is
all right.

> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usbh1_vbus>;
> +		regulator-name = "usb_h1_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		status = "disabled";
> +	};
> +
> +	reg_usb_otg_vbus: reg-usb-otg-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usbotg_vbus>;
> +		regulator-name = "usb_otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		status = "okay";
> +	};
> +
> +	reg_pcie: reg-pcie {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pcie_reg>;
> +		regulator-name = "MPCIE_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 19 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		status = "disabled";
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-mode = "rgmii-id";
> +	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
> +	phy-reset-duration = <20>;
> +	phy-supply = <&sw2_reg>;
> +	phy-handle = <&ethphy0>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy_port2: phy@1 {
> +			reg = <1>;
> +		};
> +
> +		phy_port3: phy@2 {
> +			reg = <2>;
> +		};
> +
> +		switch@0 {
> +			compatible = "qca,qca8334";
> +			reg = <0>;
> +
> +			switch_ports: ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				ethphy0: port@0 {
> +					reg = <0>;
> +					label = "cpu";
> +					phy-mode = "rgmii";
> +					ethernet = <&fec>;

Please have a newline between properties and child node.

> +					fixed-link {
> +						speed = <1000>;
> +						full-duplex;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					label = "eth2";
> +					phy-handle = <&phy_port2>;
> +				};
> +
> +				port@3 {
> +					reg = <3>;
> +					label = "eth1";
> +					phy-handle = <&phy_port3>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&hdmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hdmi_cec>;
> +	ddc-i2c-bus = <&i2c2>;
> +	status = "disabled";
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	eeprom@57 {
> +		compatible = "atmel,24c128";
> +		reg = <0x57>;
> +		pagesize = <64>;
> +		status = "okay";
> +	};
> +
> +	leds: led-controller@30 {

Please sort child nodes of i2c bus in order of unit-address.

> +		compatible = "ti,lp5562";
> +		reg = <0x30>;
> +		clock-mode = /bits/ 8 <1>;
> +		status = "disabled";
> +
> +		chan0 {
> +			chan-name = "R";
> +			led-cur = /bits/ 8 <0x20>;
> +			max-cur = /bits/ 8 <0x60>;
> +		};
> +
> +		chan1 {
> +			chan-name = "G";
> +			led-cur = /bits/ 8 <0x20>;
> +			max-cur = /bits/ 8 <0x60>;
> +		};
> +
> +		chan2 {
> +			chan-name = "B";
> +			led-cur = /bits/ 8 <0x20>;
> +			max-cur = /bits/ 8 <0x60>;
> +		};
> +
> +		chan3 {
> +			chan-name = "W";
> +			led-cur = /bits/ 8 <0x0>;
> +			max-cur = /bits/ 8 <0x0>;
> +		};
> +	};
> +
> +	pmic@8 {
> +		compatible = "fsl,pfuze200";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		reg = <0x8>;
> +
> +		regulators {
> +			sw1a_reg: sw1ab {
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1875000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <6250>;
> +			};
> +
> +			sw2_reg: sw2 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw3a_reg: sw3a {
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1975000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw3b_reg: sw3b {
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1975000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			swbst_reg: swbst {
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5150000>;
> +			};
> +
> +			snvs_reg: vsnvs {
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <3000000>;
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
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +			};
> +
> +			vgen2_reg: vgen2 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +			};
> +
> +			vgen3_reg: vgen3 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen4_reg: vgen4 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen5_reg: vgen5 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen6_reg: vgen6 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	touchscreen: touchscreen@5c {
> +		compatible = "pixcir,pixcir_tangoc";
> +		reg = <0x5c>;
> +		pinctrl-0 = <&pinctrl_touch>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> +		attb-gpio = <&gpio4 5 GPIO_ACTIVE_HIGH>;
> +		reset-gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> +		touchscreen-size-x = <800>;
> +		touchscreen-size-y = <480>;
> +		status = "disabled";
> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "disabled";
> +
> +	gpio_oled: gpio@41 {
> +		compatible = "nxp,pca9536";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		reg = <0x41>;
> +		vcc-supply = <&sw2_reg>;
> +		status = "disabled";
> +	};
> +
> +	oled: oled@3d {

Sort child nodes in unit-address.

> +		compatible = "solomon,ssd1305fb-i2c";
> +		reg = <0x3d>;
> +		solomon,height = <64>;
> +		solomon,width = <128>;
> +		solomon,page-offset = <0>;
> +		solomon,prechargep2 = <15>;
> +		reset-gpios = <&gpio_oled 1 GPIO_ACTIVE_LOW>;
> +		vbat-supply = <&sw2_reg>;
> +		status = "disabled";
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_enet: enetgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b020
> +			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b020
> +			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b020
> +			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b020
> +			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b020
> +			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b020
> +			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b020
> +			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b020
> +			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b020
> +			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b020
> +			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b020
> +			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b020
> +			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b020
> +			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b020
> +			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b010
> +			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x1b010
> +			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25	0x1b098
> +		>;
> +	};
> +
> +	pinctrl_hdmi_cec: hdmicecgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_A25__HDMI_TX_CEC_LINE	0x1b898
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_COL3__I2C2_SCL	0x4001b899
> +			MX6QDL_PAD_KEY_ROW3__I2C2_SDA	0x4001b899
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_3__I2C3_SCL	0x4001b899
> +			MX6QDL_PAD_GPIO_6__I2C3_SDA	0x4001b899
> +		>;
> +	};
> +
> +	pinctrl_ipu1: ipu1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
> +			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10
> +			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10
> +			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
> +			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
> +			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
> +			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
> +			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
> +			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
> +			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
> +			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
> +			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
> +			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
> +			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
> +			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
> +			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
> +			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
> +			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
> +			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
> +			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
> +			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
> +			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
> +			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
> +			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
> +			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
> +			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
> +			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
> +		>;
> +	};
> +
> +	pinctrl_pcie: pciegrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x1b098
> +			MX6QDL_PAD_KEY_COL4__GPIO4_IO14		0x1b098
> +			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20	0x1b098
> +		>;
> +	};
> +
> +	pinctrl_pcie_reg: pciereggrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D19__GPIO3_IO19	0x1b098
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_18__GPIO7_IO13	0x1b098
> +		>;
> +	};
> +
> +	pinctrl_backlight_pwm: pwm1grp {

Name the label in a way consistent with node name, i.e.
pinctrl_pwm_xxx, and sort it alphabetically.

Shawn

> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_9__PWM1_OUT	0x8
> +		>;
> +	};
> +
> +	pinctrl_touch: touchgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_19__GPIO4_IO05	0x1b098
> +			MX6QDL_PAD_GPIO_2__GPIO1_IO02	0x1b098
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0a8
> +			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA	0x1b0a8
> +		>;
> +	};
> +
> +	pinctrl_usbh1: usbh1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D30__USB_H1_OC	0x1b098
> +		>;
> +	};
> +
> +	pinctrl_usbh1_vbus: usbh1-vbus {
> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x98
> +		>;
> +	};
> +
> +	pinctrl_usbotg: usbotggrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x1b098
> +			MX6QDL_PAD_EIM_D21__USB_OTG_OC		0x1b098
> +		>;
> +	};
> +
> +	pinctrl_usbotg_vbus: usbotg-vbus {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x98
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_A16__GPIO2_IO22	0x1b018
> +			MX6QDL_PAD_SD3_RST__GPIO7_IO08	0x1b018
> +			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
> +			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x10059
> +			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x17059
> +			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x17059
> +			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x17059
> +			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc4: usdhc4grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD4_CMD__SD4_CMD	0x1f069
> +			MX6QDL_PAD_SD4_CLK__SD4_CLK	0x10069
> +			MX6QDL_PAD_SD4_DAT0__SD4_DATA0	0x17069
> +			MX6QDL_PAD_SD4_DAT1__SD4_DATA1	0x17069
> +			MX6QDL_PAD_SD4_DAT2__SD4_DATA2	0x17069
> +			MX6QDL_PAD_SD4_DAT3__SD4_DATA3	0x17069
> +			MX6QDL_PAD_SD4_DAT4__SD4_DATA4	0x17069
> +			MX6QDL_PAD_SD4_DAT5__SD4_DATA5	0x17069
> +			MX6QDL_PAD_SD4_DAT6__SD4_DATA6	0x17069
> +			MX6QDL_PAD_SD4_DAT7__SD4_DATA7	0x17069
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_1__WDOG2_B	0x1b0b0
> +		>;
> +	};
> +};
> +
> +&ipu1_di0_disp0 {
> +	remote-endpoint = <&lcd_display_in>;
> +};
> +
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie>;
> +	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
> +	vpcie-supply = <&reg_pcie>;
> +	status = "disabled";
> +};
> +
> +&pwm1 {
> +	#pwm-cells = <3>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_backlight_pwm>;
> +	status = "disabled";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbh1>;
> +	vbus-supply = <&reg_usb_h1_vbus>;
> +	status = "disabled";
> +};
> +
> +&usbotg {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg>;
> +	vbus-supply = <&reg_usb_otg_vbus>;
> +	srp-disable;
> +	hnp-disable;
> +	adp-disable;
> +	status = "okay";
> +};
> +
> +&usbphy1 {
> +	fsl,tx-d-cal = <106>;
> +	status = "okay";
> +};
> +
> +&usbphy2 {
> +	fsl,tx-d-cal = <109>;
> +	status = "disabled";
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio7 8 GPIO_ACTIVE_LOW>;
> +	wp-gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
> +	no-1-8-v;
> +	keep-power-in-suspend;
> +	wakeup-source;
> +	vmmc-supply = <&sw2_reg>;
> +	status = "disabled";
> +};
> +
> +&usdhc4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc4>;
> +	bus-width = <8>;
> +	non-removable;
> +	no-1-8-v;
> +	keep-power-in-suspend;
> +	vmmc-supply = <&sw2_reg>;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	status = "disabled";
> +};
> +
> +&wdog2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6dl-yapp4-draco.dts b/arch/arm/boot/dts/imx6dl-yapp4-draco.dts
> new file mode 100644
> index 0000000..a38c407
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-yapp4-draco.dts
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2015-2018 Y Soft Corporation, a.s.
> +
> +/dts-v1/;
> +
> +#include "imx6dl.dtsi"
> +#include "imx6dl-yapp4-common.dtsi"
> +
> +/ {
> +	model = "Y Soft IOTA Draco i.MX6Solo board";
> +	compatible = "ysoft,imx6dl-yapp4-draco", "fsl,imx6dl";
> +
> +	memory@10000000 {
> +		device_type = "memory";
> +		reg = <0x10000000 0x20000000>;
> +	};
> +};
> +
> +&backlight {
> +	status = "okay";
> +};
> +
> +&lcd_display {
> +	status = "okay";
> +};
> +
> +&leds {
> +	status = "okay";
> +};
> +
> +&panel {
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +};
> +
> +&reg_usb_h1_vbus {
> +	status = "okay";
> +};
> +
> +&touchscreen {
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	status = "okay";
> +};
> +
> +&usbphy2 {
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts b/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
> new file mode 100644
> index 0000000..f979270
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2015-2018 Y Soft Corporation, a.s.
> +
> +/dts-v1/;
> +
> +#include "imx6dl.dtsi"
> +#include "imx6dl-yapp4-common.dtsi"
> +
> +/ {
> +	model = "Y Soft IOTA Hydra i.MX6DualLite board";
> +	compatible = "ysoft,imx6dl-yapp4-hydra", "fsl,imx6dl";
> +
> +	memory@10000000 {
> +		device_type = "memory";
> +		reg = <0x10000000 0x80000000>;
> +	};
> +};
> +
> +&gpio_oled {
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +};
> +
> +&leds {
> +	status = "okay";
> +};
> +
> +&oled {
> +	status = "okay";
> +};
> +
> +&pcie {
> +	status = "okay";
> +};
> +
> +&reg_pcie {
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6dl-yapp4-ursa.dts b/arch/arm/boot/dts/imx6dl-yapp4-ursa.dts
> new file mode 100644
> index 0000000..0d594e4
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-yapp4-ursa.dts
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2015-2018 Y Soft Corporation, a.s.
> +
> +/dts-v1/;
> +
> +#include "imx6dl.dtsi"
> +#include "imx6dl-yapp4-common.dtsi"
> +
> +/ {
> +	model = "Y Soft IOTA Ursa i.MX6Solo board";
> +	compatible = "ysoft,imx6dl-yapp4-ursa", "fsl,imx6dl";
> +
> +	memory@10000000 {
> +		device_type = "memory";
> +		reg = <0x10000000 0x20000000>;
> +	};
> +};
> +
> +&backlight {
> +	status = "okay";
> +};
> +
> +&lcd_display {
> +	status = "okay";
> +};
> +
> +&panel {
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +};
> +
> +&reg_usb_h1_vbus {
> +	status = "okay";
> +};
> +
> +&switch_ports {
> +	/delete-node/ port@2;
> +};
> +
> +&touchscreen {
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	status = "okay";
> +};
> +
> +&usbphy2 {
> +	status = "okay";
> +};
> -- 
> 2.1.4
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
