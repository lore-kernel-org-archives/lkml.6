Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2666C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8776C21901
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546039560;
	bh=V4/grCzbai5eW702BlKyqyAKyVcxCYtRYCjhJXfXyLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nrrKUQgsE7cVv0tRXw5ok6som4chZamqugJHg++o6LpiMlYB0cMb7+sKcCmpLjKJS
	 rv7wx/2a001omLk2aqlBGdK3Q90QOhj6Or6qgQ/PDh7q3ExEokZLtTWvV5/wQEBI5C
	 zOIQb7y9MUwLX0FIGlmZ2e6rInzehxvO2ahusBD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeL1XZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 18:25:59 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36336 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeL1XZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 18:25:59 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so28628517itj.1;
        Fri, 28 Dec 2018 15:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xLWKpArYmP939ZciSeWZtiKAwoluQd+BRd7JdU1nnwQ=;
        b=kuoAv99azyhnaUBOmdbXBtQ5HytoyRcc2fmsV6eGji6m3nKO90kcU3Ym3aKGvSNp3p
         DcqzLSZJ4PbcMkbAUnmggwj03cFOMmEfIdknCqb1ZM7/3/fny83LGRArPsSUswGEbkPB
         ZwnFbmNlTaEJo2E2eQr3f3oobQQUAtIsoI/v98QCzRc4QlqqJ5peZdFCyWEhhy+H6xtb
         vGxMkci046uanVoL6ixXc7XvP2IvWNNaVJVXuKoL1/b/gp9RgAD1c6yUH935WR7GhP1F
         UhYRfQZK6OQ5THwS+nLboP0IoEsTDvtnS4fHOePV9TWZExk80SsDGDRWvGU4XUCeNi3k
         OZ+A==
X-Gm-Message-State: AA+aEWag3QFjENmbe9LJAvXUYhiLSrLdFgzAV6zcXhchXDT3VvfY73F3
        qL+j2ix9ufwTnvJ3iABy2g==
X-Google-Smtp-Source: AFSGD/WkP376usd0YBwSN7ffqk+04TgSzBcWd73v9BkrHguXDSLT5ab5CqPCTQhNB8Ly9V6h+Zx2Pg==
X-Received: by 2002:a02:89dd:: with SMTP id e29mr20406039jak.21.1546039557745;
        Fri, 28 Dec 2018 15:25:57 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id v202sm16107447ita.13.2018.12.28.15.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 15:25:57 -0800 (PST)
Date:   Fri, 28 Dec 2018 17:25:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Message-ID: <20181228232556.GA14277@bogus>
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 02:42:11PM +0000, Vokáč Michal wrote:
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
> Changes since v1:
>  - Enable HDMI on Hydra board.
>  - Move regulators to the root node and remove simple-bus property. (Rob)
>  - Remove reg and unit-address property from regulators. (Rob)
>  - Use correct names for led-controller and pmic node. (Rob)
>  - Use wakeup-source instead of deprecated enable-sdio-wakeup. (Shawn)
> 
> Link to v1: http://patchwork.ozlabs.org/patch/991975/
> 
> No change regarding the documentation and split of the dtsi files as
> I did not get answers to my questions and was not sure how to proceed.
> Andrew pointed me to the Kirkwood Synology platform. That boards use
> the same concept to organize the "disabled" and "okay" nodes.
> 
> Thanks,
> Michal
> 
>  arch/arm/boot/dts/Makefile                 |   3 +
>  arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 595 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6dl-yapp4-draco.dts   |  61 +++
>  arch/arm/boot/dts/imx6dl-yapp4-hydra.dts   |  49 +++
>  arch/arm/boot/dts/imx6dl-yapp4-ursa.dts    |  57 +++
>  5 files changed, 765 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-draco.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-ursa.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b0e966d..9bdf394 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -443,6 +443,9 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
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
> index 0000000..7eb6427
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> @@ -0,0 +1,595 @@
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
> +	reg_usb_h1_vbus: reg_usb_h1_vbus {

Use '-' rather than '_' in node names.

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
> +	reg_usb_otg_vbus: reg_usb_otg_vbus {
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
> +	reg_pcie: reg_pcie {
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
> +	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>;
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
> +		compatible = "ti,lp5562";
> +		label = "lp5562_leds";

label should be for a specific led. The use here doesn't seem that 
useful.

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
> +		compatible = "solomon,ssd1305fb-i2c";

Not documented.

> +		reg = <0x3d>;
> +		solomon,height = <64>;
> +		solomon,width = <128>;
> +		solomon,page-offset = <0>;
> +		solomon,prechargep2 = <15>;
> +		reset-gpios = <&gpio_oled 1 GPIO_ACTIVE_LOW>;
> +		vbat-supply = <&sw2_reg>;
> +		status = "disabled";
> +	};

[...]

> diff --git a/arch/arm/boot/dts/imx6dl-yapp4-draco.dts b/arch/arm/boot/dts/imx6dl-yapp4-draco.dts
> new file mode 100644
> index 0000000..2b9a7ad
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-yapp4-draco.dts
> @@ -0,0 +1,61 @@
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

All compatible strings should be documented, not just SoC vendor boards.

> +
> +	cpus {
> +		/delete-node/ cpu@1;

Seems like this is a chip property, not a board specific property. IOW, 
you need an imx6solo.dtsi file.

> +	};
