Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3F872C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6538208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6538208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755249AbeFNNOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:14:31 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62368 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754986AbeFNNO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:14:28 -0400
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="13060561"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jun 2018 06:14:27 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Thu, 14 Jun 2018
 06:14:26 -0700
Subject: Re: [PATCH 4/4] arm: dts: add support for Laird SOM60 module and DVK
 boards
To:     Ben Whitten <ben.whitten@gmail.com>, <devicetree@vger.kernel.org>
CC:     Ben Whitten <ben.whitten@lairdtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
 <1528966340-23216-4-git-send-email-ben.whitten@lairdtech.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <e1f730ca-da21-1756-b781-b6552fb28101@microchip.com>
Date:   Thu, 14 Jun 2018 15:14:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528966340-23216-4-git-send-email-ben.whitten@lairdtech.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2018 at 10:51, Ben Whitten wrote:
> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
> ---
>   arch/arm/boot/dts/Makefile                    |   3 +-
>   arch/arm/boot/dts/at91-dvk_som60.dts          |  95 +++++++++++
>   arch/arm/boot/dts/at91-dvk_su60_somc.dtsi     | 159 ++++++++++++++++++
>   arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi |  96 +++++++++++
>   arch/arm/boot/dts/at91-som60.dtsi             | 229 ++++++++++++++++++++++++++
>   5 files changed, 581 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/at91-dvk_som60.dts
>   create mode 100644 arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
>   create mode 100644 arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi
>   create mode 100644 arch/arm/boot/dts/at91-som60.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 486ab59..4d3d9ca 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -63,7 +63,8 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>   	at91-sama5d4ek.dtb \
>   	at91-vinco.dtb \

About where you added dtbs...

>   	at91-wb50n.dtb \
> -	at91-gatwick.dtb
> +	at91-gatwick.dtb \
> +	at91-dvk_som60.dtb

1/ As they are based on sama5d3, I would like to see them between 
"at91-sama5d2_xplained.dtb" and "sama5d31ek.dtb"
2/ within this range, please sort all these 4 alphabetically
3/ don't laugh at me, I try to deal with our historical way of "sorting" 
entries in this Makefile for AT91... ;-)

BTW, I realize now that your "at91-wb45n.dtb" entry from patch 1 should 
go just after the "at91-kizboxmini.dts" (alphabetical order in 
at91sam9x5 "location").


>   dtb-$(CONFIG_ARCH_ATLAS6) += \
>   	atlas6-evb.dtb
>   dtb-$(CONFIG_ARCH_ATLAS7) += \
> diff --git a/arch/arm/boot/dts/at91-dvk_som60.dts b/arch/arm/boot/dts/at91-dvk_som60.dts
> new file mode 100644
> index 0000000..ededd5b
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-dvk_som60.dts
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * at91-dvk_som60.dts - Device Tree file for the DVK SOM60 board
> + *
> + *  Copyright (C) 2018 Laird,
> + *		  2018 Ben Whitten <ben.whitten@lairdtech.com>
> + *
> + */
> +/dts-v1/;
> +#include "at91-som60.dtsi"
> +#include "at91-dvk_su60_somc.dtsi"
> +#include "at91-dvk_su60_somc_lcm.dtsi"
> +
> +/ {
> +	model = "Laird DVK SOM60";
> +	compatible = "laird,dvk-som60", "laird,som60", "atmel,sama5d36", "atmel,sama5d3", "atmel,sama5";
> +
> +	chosen {
> +		stdout-path = &dbgu;
> +		tick-timer = &pit;
> +	};
> +};
> +
> +&mmc0 {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +};
> +
> +&ssc0 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&usart1 {
> +	status = "okay";
> +};
> +
> +&usart2 {
> +	status = "okay";
> +};
> +
> +&usart3 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&dbgu {
> +	status = "okay";
> +};
> +
> +&pit {
> +	status = "okay";
> +};
> +
> +&adc0 {
> +	status = "okay";
> +};
> +
> +&can1 {
> +	status = "okay";
> +};
> +
> +&macb0 {
> +	status = "okay";
> +};
> +
> +&macb1 {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> +
> +&usb2 {
> +	status = "okay";
> +};
> +
> diff --git a/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi b/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
> new file mode 100644
> index 0000000..6031c2f
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * at91-dvk_su60_somc.dtsi - Device Tree file for the DVK SOM60 base board
> + *
> + *  Copyright (C) 2018 Laird,
> + *		  2018 Ben Whitten <ben.whitten@lairdtech.com>
> + *
> + */
> +
> +/ {
> +	sound {
> +		compatible = "atmel,asoc-wm8904";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pck2_as_audio_mck>;
> +
> +		atmel,model = "wm8904 @ DVK-SOM60";
> +		atmel,audio-routing =
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"IN2L", "Line In Jack",
> +			"IN2R", "Line In Jack",
> +			"Mic", "MICBIAS",
> +			"IN1L", "Mic";
> +
> +		atmel,ssc-controller = <&ssc0>;
> +		atmel,audio-codec = <&wm8904>;
> +
> +		status = "okay";
> +	};
> +};
> +
> +&mmc0 {
> +	status = "okay";
> +
> +	pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3 &pinctrl_mmc0_cd>;
> +	slot@0 {
> +		bus-width = <4>;
> +		cd-gpios = <&pioE 31 GPIO_ACTIVE_HIGH>;
> +		cd-inverted;
> +	};
> +};
> +
> +&spi0 {
> +	status = "okay";
> +
> +	/* spi0.0: 4M Flash Macronix MX25R4035FM1IL0 */
> +	spi-flash@0 {
> +		compatible = "mxicy,mx25u4035", "jedec,spi-nor";
> +		spi-max-frequency = <33000000>;
> +		reg = <0>;
> +	};
> +};
> +
> +&ssc0 {
> +	atmel,clk-from-rk-pin;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	wm8904: wm8904@1a {
> +		compatible = "wlf,wm8904";
> +		reg = <0x1a>;
> +		clocks = <&pck2>;
> +		clock-names = "mclk";
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	eeprom@87 {
> +		compatible = "giantec,24c32";

It must work, however...

I read in recent patches on dts directory that :

"We now require all at24 users to use the "atmel,<model>" fallback in 
device tree for different manufacturers."

Moreover, I don't see giantec in the vendor prefix list.


> +		reg = <87>;
> +		pagesize = <32>;
> +	};
> +};
> +
> +&usart1 {
> +	status = "okay";
> +};
> +
> +&usart2 {
> +	status = "okay";
> +};
> +
> +&usart3 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&dbgu {
> +	status = "okay";
> +};
> +
> +&pit {
> +	status = "okay";
> +};
> +
> +&adc0 {
> +	status = "okay";
> +};
> +
> +&can1 {
> +	status = "okay";
> +};
> +
> +&macb0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	ethernet-phy@7 {
> +		reg = <7>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_geth_int>;
> +		interrupt-parent = <&pioB>;
> +		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +		txen-skew-ps = <800>;
> +		txc-skew-ps = <3000>;
> +		rxdv-skew-ps = <400>;
> +		rxc-skew-ps = <3000>;
> +		rxd0-skew-ps = <400>;
> +		rxd1-skew-ps = <400>;
> +		rxd2-skew-ps = <400>;
> +		rxd3-skew-ps = <400>;
> +	};
> +};
> +
> +&macb1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	ethernet-phy@1 {
> +		reg = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_eth_int>;
> +		interrupt-parent = <&pioC>;
> +		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> +
> +&usb2 {
> +	status = "okay";
> +};
> +
> diff --git a/arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi b/arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi
> new file mode 100644
> index 0000000..d98c644
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * at91-dvk_su60_somc_lcm.dtsi - Device Tree file for the DVK SOM60 LCD board
> + *
> + *  Copyright (C) 2018 Laird,
> + *		  2018 Ben Whitten <ben.whitten@lairdtech.com>
> + *
> + */
> +
> +/ {
> +	ahb {
> +		apb {
> +			pinctrl@fffff200 {
> +				board {
> +					pinctrl_lcd_ctp_int: lcd_ctp_int {
> +						 atmel,pins =
> +							 <AT91_PIOC 28 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&hlcdc_pwm 0 50000 0>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;
> +		status = "okay";
> +	};
> +
> +	panel: panel {
> +		/* Actually Winstar WF70GTIAGDNG0 */
> +		compatible = "innolux,at070tn92", "simple-panel";
> +		backlight = <&backlight>;
> +		power-supply = <&vcc_lcd_reg>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";
> +
> +		port@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +
> +			panel_input: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&hlcdc_panel_output>;
> +			};
> +		};
> +	};
> +
> +	vcc_lcd_reg: fixedregulator_lcd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC LCM";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		status = "okay";
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	ft5426@56 {
> +		/* Actually FT5426 */
> +		compatible = "edt,edt-ft5406";
> +		reg = <56>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd_ctp_int>;
> +
> +		interrupt-parent = <&pioC>;
> +		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
> +
> +		touchscreen-size-x = <800>;
> +		touchscreen-size-y = <480>;
> +	};
> +};
> +
> +&hlcdc {
> +	status = "okay";
> +
> +	hlcdc-display-controller {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
> +
> +		port@0 {
> +			hlcdc_panel_output: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&panel_input>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/at91-som60.dtsi b/arch/arm/boot/dts/at91-som60.dtsi
> new file mode 100644
> index 0000000..1843284
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-som60.dtsi
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * at91-som60.dtsi - Device Tree file for the SOM60 module
> + *
> + *  Copyright (C) 2018 Laird,
> + *		  2018 Ben Whitten <ben.whitten@lairdtech.com>
> + *
> + */
> +#include "sama5d36.dtsi"
> +
> +/ {
> +	model = "Laird SOM60";
> +	compatible = "laird,som60", "atmel,sama5d36", "atmel,sama5d3", "atmel,sama5";
> +
> +	chosen {
> +		stdout-path = &dbgu;
> +	};
> +
> +	memory {
> +		reg = <0x20000000 0x8000000>;
> +	};
> +
> +	clocks {
> +		slow_xtal {
> +			clock-frequency = <32768>;
> +		};
> +
> +		main_xtal {
> +			clock-frequency = <12000000>;
> +		};
> +	};
> +
> +	ahb {
> +		apb {
> +			pinctrl@fffff200 {
> +				board {
> +					pinctrl_mmc0_cd: mmc0_cd {
> +						atmel,pins =
> +							<AT91_PIOE 31 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
> +					};
> +
> +					pinctrl_mmc0_en: mmc0_en {
> +						atmel,pins =
> +							<AT91_PIOE 30 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +					};
> +
> +					pinctrl_nand0_wp: nand0_wp {
> +						atmel,pins =
> +							<AT91_PIOE 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
> +					};
> +
> +					pinctrl_usb_vbus: usb_vbus {
> +						atmel,pins =
> +							<AT91_PIOE 20 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>; /* Conflicts with USART2_SCK */
> +					};
> +
> +					pinctrl_usart2_sck: usart2_sck {
> +						atmel,pins =
> +							<AT91_PIOE 20 AT91_PERIPH_B AT91_PINCTRL_NONE>; /* Conflicts with USB_VBUS */
> +					};
> +
> +					pinctrl_usb_oc: usb_oc {
> +						atmel,pins =
> +							<AT91_PIOE 15 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>; /* Conflicts with USART3_SCK */
> +					};
> +
> +					pinctrl_usart3_sck: usart3_sck {
> +						atmel,pins =
> +							<AT91_PIOE 15 AT91_PERIPH_B AT91_PINCTRL_NONE>; /* Conflicts with USB_OC */
> +					};
> +
> +					pinctrl_usba_vbus: usba_vbus {
> +					   atmel,pins =
> +							<AT91_PIOC 14 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
> +					};
> +
> +					pinctrl_geth_int: geth_int {
> +						atmel,pins =
> +							<AT91_PIOB 25 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>; /* Conflicts with USART1_SCK */
> +					};
> +
> +					pinctrl_usart1_sck: usart1_sck {
> +						atmel,pins =
> +							<AT91_PIOB 25 AT91_PERIPH_A AT91_PINCTRL_NONE>; /* Conflicts with GETH_INT */
> +					};
> +
> +					pinctrl_eth_int: eth_int {
> +						atmel,pins =
> +							<AT91_PIOC 10 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
> +					};
> +
> +					pinctrl_pck2_as_audio_mck: pck2_as_audio_mck {
> +						atmel,pins =
> +							<AT91_PIOC 15 AT91_PERIPH_B AT91_PINCTRL_NONE>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&mmc0 {
> +	slot@0 {
> +		reg = <0>;
> +		bus-width = <8>;
> +	};
> +};
> +
> +&mmc1 {
> +	status = "okay";
> +	slot@0 {
> +		reg = <0>;
> +		bus-width = <4>;
> +	};
> +};
> +
> +&spi0 {
> +	cs-gpios = <&pioD 13 0>, <0>, <0>, <0>;
> +};
> +
> +&usart0 {
> +	atmel,use-dma-rx;
> +	atmel,use-dma-tx;
> +	status = "okay";
> +	pinctrl-0 = <&pinctrl_usart0 &pinctrl_usart0_rts_cts>;
> +};
> +
> +&usart1 {
> +	pinctrl-0 = <&pinctrl_usart1 &pinctrl_usart1_rts_cts>;
> +};
> +
> +&usart2 {
> +	pinctrl-0 = <&pinctrl_usart2 &pinctrl_usart2_rts_cts>;
> +};
> +
> +&usart3 {
> +	pinctrl-0 = <&pinctrl_usart3 &pinctrl_usart3_rts_cts>;
> +};
> +
> +&adc0 {
> +	pinctrl-0 = <
> +		&pinctrl_adc0_adtrg
> +		&pinctrl_adc0_ad0
> +		&pinctrl_adc0_ad1
> +		&pinctrl_adc0_ad2
> +		&pinctrl_adc0_ad3
> +		&pinctrl_adc0_ad4
> +		&pinctrl_adc0_ad5
> +		>;
> +};
> +
> +&macb0 {
> +	phy-mode = "rgmii";
> +};
> +
> +&macb1 {
> +	phy-mode = "rmii";
> +};
> +
> +
> +&ebi {
> +	pinctrl-0 = <&pinctrl_ebi_nand_addr>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&nand_controller {
> +	status = "okay";
> +
> +	nand: nand@3 {
> +		reg = <0x3 0x0 0x2>;
> +		atmel,rb = <0>;
> +		nand-bus-width = <8>;
> +		nand-ecc-mode = "hw";
> +		nand-ecc-strength = <8>;
> +		nand-ecc-step-size = <512>;
> +		nand-on-flash-bbt;
> +		label = "atmel_nand";
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			ubootspl@0 {
> +				label = "u-boot-spl";
> +				reg = <0x0 0x20000>;
> +			};
> +
> +			uboot@20000 {
> +				label = "u-boot";
> +				reg = <0x20000 0x80000>;
> +			};
> +
> +			ubootenv@a0000 {
> +				label = "u-boot-env";
> +				reg = <0xa0000 0x20000>;
> +			};
> +
> +			ubootenv@c0000 {
> +				label = "u-boot-env";
> +				reg = <0xc0000 0x20000>;
> +			};
> +
> +			ubi@e0000 {
> +				label = "ubi";
> +				reg = <0xe0000 0xfe00000>;
> +			};
> +		};
> +	};
> +};
> +
> +&usb0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usba_vbus>;
> +	atmel,vbus-gpio = <&pioC 14 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&usb1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb_vbus &pinctrl_usb_oc>;
> +	num-ports = <3>;
> +	atmel,vbus-gpio = <0
> +		&pioE 20 GPIO_ACTIVE_HIGH
> +		0>;
> +	atmel,oc-gpio = <0
> +		&pioE 15 GPIO_ACTIVE_LOW
> +		0>;
> +};
> 


-- 
Nicolas Ferre
