Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB21FECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA5421522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="KHxExsC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA5421522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391501AbeIVEVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:21:43 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:55094 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeIVEVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:21:43 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 1E7245C2143;
        Sat, 22 Sep 2018 00:30:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537569045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vD/+xfbqNFYaoW2mp1+9Ubp/snEIYqJjZn2drmGc4lc=;
        b=KHxExsC+QfoETlpeo3wJAm1gkuF4JpSAIOitEG0HVcwszqJo6fN4R0yluA8N9Hvo+EDOhh
        GYRck1eEDxNR71dP9ZhJ6MU+KKZ6xsLLQMducKs22nJlHNsHzks35ChyHvIrZPvUzxhWCV
        DdH23xtF5bZW8FvsDcJz/4DdlLevjBs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Sep 2018 15:30:45 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] ARM: dts: Add support for Liebherr's BK4 device (vf610
 based)
In-Reply-To: <20180921152726.31742-1-lukma@denx.de>
References: <20180921152726.31742-1-lukma@denx.de>
Message-ID: <6208c70880286ec061f02f1ce679dcdc@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.09.2018 08:27, Lukasz Majewski wrote:
> This commit adds DTS support for BK4 device from Liebherr. It
> uses vf610 SoC from NXP.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/boot/dts/Makefile      |   1 +
>  arch/arm/boot/dts/vf610-bk4.dts | 504 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 505 insertions(+)
>  create mode 100644 arch/arm/boot/dts/vf610-bk4.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b5bd3de87c33..e6f159895fa9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -577,6 +577,7 @@ dtb-$(CONFIG_SOC_LS1021A) += \
>  	ls1021a-twr.dtb
>  dtb-$(CONFIG_SOC_VF610) += \
>  	vf500-colibri-eval-v3.dtb \
> +	vf610-bk4.dtb \
>  	vf610-colibri-eval-v3.dtb \
>  	vf610m4-colibri.dtb \
>  	vf610-cosmic.dtb \
> diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
> new file mode 100644
> index 000000000000..4ad7e739a0ad
> --- /dev/null
> +++ b/arch/arm/boot/dts/vf610-bk4.dts
> @@ -0,0 +1,504 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2018
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + */
> +
> +/dts-v1/;
> +#include "vf610.dtsi"
> +
> +/ {
> +	model = "Liebherr BK4 controller";
> +	compatible = "lwn,bk4", "fsl,vf610";
> +
> +	chosen {
> +		bootargs = "console=ttyLP1,115200";
> +	};
> +
> +	memory@80000000 {
> +		reg = <0x80000000 0x8000000>;
> +	};
> +
> +	audio_ext: mclk_osc {

Node name should be somewhat generic. I know its the same in twr board,
we probably should fix it there. The device tree spec has some
recommendation, I would suggest using just "oscillator-audio".

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24576000>;
> +	};
> +
> +	enet_ext: eth_osc {

Same here, oscillator-ethernet maybe.


> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <50000000>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
> +
> +		/* LED D5 */
> +		led0: heartbeat {
> +			label = "heartbeat";
> +			gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

We stopped using a regulator subnode. Just move the regulators to the
top and use unique names such as "regulator-3p3v".

> +
> +		reg_3p3v: regulator@0 {
> +			compatible = "regulator-fixed";
> +			reg = <0>;
> +			regulator-name = "3P3V";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_vcc_3v3_mcu: regulator@1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "vcc_3v3_mcu";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +	};
> +};
> +
> +&adc0 {
> +	vref-supply = <&reg_vcc_3v3_mcu>;
> +	status = "okay";
> +};
> +
> +&adc1 {
> +	vref-supply = <&reg_vcc_3v3_mcu>;
> +	status = "okay";
> +};
> +
> +&can0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can0>;
> +	status = "okay";
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can1>;
> +	status = "okay";
> +};
> +
> +&clks {
> +	clocks = <&sxosc>, <&fxosc>, <&enet_ext>, <&audio_ext>;
> +	clock-names = "sxosc", "fxosc", "enet_ext", "audio_ext";
> +};
> +
> +&dspi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_dspi0>;
> +	bus-num = <0>;
> +	status = "okay";
> +
> +	spidev0@0 {
> +		compatible = "fsl,vf610-dspi";

I don't think this is right. A subnode of the dspi controller should use
a device tree binding of SPI device. What is connected to that SPI in
your case? 

> +		spi-max-frequency = <30000000>;
> +		reg = <0>;
> +		fsl,spi-cs-sck-delay = <200>;
> +		fsl,spi-sck-cs-delay = <400>;
> +	};
> +};
> +
> +&dspi3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_dspi3>;
> +	bus-num = <3>;
> +	status = "okay";
> +
> +	spidev3@0 {
> +		compatible = "fsl,vf610-dspi";

Same here...

> +		spi-max-frequency = <30000000>;
> +		reg = <0>;
> +		fsl,spi-slave-mode;
> +	};
> +};
> +
> +&edma0 {
> +	status = "okay";
> +};
> +
> +&edma1 {
> +	status = "okay";
> +};
> +
> +&esdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_esdhc1>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&fec0 {
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec0>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		ethphy0: ethernet-phy@1 {
> +			reg = <1>;
> +			clocks = <&clks VF610_CLK_ENET_50M>;
> +			clock-names = "rmii-ref";
> +		};
> +	};
> +};
> +
> +&fec1 {
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		ethphy1: ethernet-phy@1 {
> +			reg = <1>;
> +			clocks = <&clks VF610_CLK_ENET_50M>;
> +			clock-names = "rmii-ref";
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	eeprom: eeprom@50 {
> +		compatible = "at24,24c256";
> +		reg = <0x50>;
> +	};
> +
> +	rtc: rtc@68 {
> +		compatible = "stm,rv4162";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&iomuxc {

This node should go to the very end since it is so large..

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_bk4_common>;
> +
> +	pinctrl_bk4_common: commongrp {

Are those pins all controlled from user space? If they are controlled by
a particular kernel driver, you should add those pins to the pinctrl
node assigned to the particular device tree node.

--
Stefan

> +		fsl,pins = <
> +			/* One_Wire_PSU_EN */
> +			VF610_PAD_PTC29__GPIO_102		0x1183
> +			/* SPI */
> +			VF610_PAD_PTB26__GPIO_96		0x1183
> +			VF610_PAD_PTE14__GPIO_119		0x1183
> +			VF610_PAD_PTE4__GPIO_109		0x1181
> +			/* Feedback_Lines */
> +			VF610_PAD_PTC31__GPIO_104		0x1181
> +			VF610_PAD_PTA7__GPIO_134		0x1181
> +			VF610_PAD_PTD9__GPIO_88		0x1181
> +			VF610_PAD_PTE1__GPIO_106		0x1183
> +			VF610_PAD_PTB2__GPIO_24		0x1181
> +			VF610_PAD_PTB3__GPIO_25		0x1181
> +			VF610_PAD_PTB1__GPIO_23		0x1181
> +			/* SDHC */
> +			VF610_PAD_PTE19__GPIO_124		0x1183
> +			VF610_PAD_PTB23__GPIO_93		0x1181
> +			/* GPI */
> +			VF610_PAD_PTE2__GPIO_107		0x1181
> +			VF610_PAD_PTE3__GPIO_108		0x1181
> +			VF610_PAD_PTE5__GPIO_110		0x1181
> +			VF610_PAD_PTE6__GPIO_111		0x1181
> +			/* GPO */
> +			VF610_PAD_PTE0__GPIO_105		0x1183
> +			VF610_PAD_PTE7__GPIO_112		0x1183
> +			/* RS485 */
> +			VF610_PAD_PTB8__GPIO_30		0x1183
> +			VF610_PAD_PTB9__GPIO_31		0x1183
> +			VF610_PAD_PTE8__GPIO_113		0x1183
> +			/* MPBUS MPB_EN */
> +			VF610_PAD_PTE28__GPIO_133		0x1183
> +			/* LEDS */
> +			VF610_PAD_PTE15__GPIO_120		0x1183
> +			VF610_PAD_PTA12__GPIO_5		0x1183
> +			VF610_PAD_PTA16__GPIO_6		0x1183
> +			VF610_PAD_PTE9__GPIO_114		0x1183
> +			VF610_PAD_PTE20__GPIO_125		0x1183
> +			VF610_PAD_PTE23__GPIO_128		0x1183
> +			VF610_PAD_PTE16__GPIO_121		0x1183
> +			/* MISC */
> +			VF610_PAD_PTE10__GPIO_115		0x1183
> +			VF610_PAD_PTE11__GPIO_116		0x1183
> +			VF610_PAD_PTE17__GPIO_122		0x1183
> +			VF610_PAD_PTC30__GPIO_103		0x1183
> +			VF610_PAD_PTB0__GPIO_22		0x1181
> +			/* RESETINFO */
> +			VF610_PAD_PTE26__GPIO_131		0x1183
> +			VF610_PAD_PTD6__GPIO_85		0x1181
> +			VF610_PAD_PTE27__GPIO_132		0x1181
> +			VF610_PAD_PTE13__GPIO_118		0x1181
> +			VF610_PAD_PTE21__GPIO_126		0x1181
> +			VF610_PAD_PTE22__GPIO_127		0x1181
> +			/* EE_5V_EN */
> +			VF610_PAD_PTE18__GPIO_123		0x1183
> +			/* EE_5V_OC_N */
> +			VF610_PAD_PTE25__GPIO_130		0x1181
> +		>;
> +	};
> +
> +	pinctrl_can0: can0grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB14__CAN0_RX		0x1181
> +			VF610_PAD_PTB15__CAN0_TX		0x1182
> +		>;
> +	};
> +
> +	pinctrl_can1: can1grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB16__CAN1_RX		0x1181
> +			VF610_PAD_PTB17__CAN1_TX		0x1182
> +		>;
> +	};
> +
> +	pinctrl_dspi0: dspi0grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB18__DSPI0_CS1		0x1182
> +			VF610_PAD_PTB19__DSPI0_CS0		0x1182
> +			VF610_PAD_PTB20__DSPI0_SIN		0x1181
> +			VF610_PAD_PTB21__DSPI0_SOUT		0x1182
> +			VF610_PAD_PTB22__DSPI0_SCK		0x1182
> +		>;
> +	};
> +
> +	pinctrl_dspi3: dspi3grp {
> +		fsl,pins = <
> +			VF610_PAD_PTD10__DSPI3_CS0		0x1181
> +			VF610_PAD_PTD11__DSPI3_SIN		0x1181
> +			VF610_PAD_PTD12__DSPI3_SOUT		0x1182
> +			VF610_PAD_PTD13__DSPI3_SCK		0x1181
> +		>;
> +	};
> +
> +	pinctrl_esdhc1: esdhc1grp {
> +		fsl,pins = <
> +			VF610_PAD_PTA24__ESDHC1_CLK		0x31ef
> +			VF610_PAD_PTA25__ESDHC1_CMD		0x31ef
> +			VF610_PAD_PTA26__ESDHC1_DAT0		0x31ef
> +			VF610_PAD_PTA27__ESDHC1_DAT1		0x31ef
> +			VF610_PAD_PTA28__ESDHC1_DATA2		0x31ef
> +			VF610_PAD_PTA29__ESDHC1_DAT3		0x31ef
> +			VF610_PAD_PTB28__GPIO_98		0x219d
> +		>;
> +	};
> +
> +	pinctrl_fec0: fec0grp {
> +		fsl,pins = <
> +			VF610_PAD_PTA6__RMII_CLKIN		0x30dd
> +			VF610_PAD_PTC0__ENET_RMII0_MDC		0x30de
> +			VF610_PAD_PTC1__ENET_RMII0_MDIO	0x30df
> +			VF610_PAD_PTC2__ENET_RMII0_CRS		0x30dd
> +			VF610_PAD_PTC3__ENET_RMII0_RXD1	0x30dd
> +			VF610_PAD_PTC4__ENET_RMII0_RXD0	0x30dd
> +			VF610_PAD_PTC5__ENET_RMII0_RXER	0x30dd
> +			VF610_PAD_PTC6__ENET_RMII0_TXD1	0x30de
> +			VF610_PAD_PTC7__ENET_RMII0_TXD0	0x30de
> +			VF610_PAD_PTC8__ENET_RMII0_TXEN	0x30de
> +		>;
> +	};
> +
> +	pinctrl_fec1: fec1grp {
> +		fsl,pins = <
> +			VF610_PAD_PTC9__ENET_RMII1_MDC		0x30de
> +			VF610_PAD_PTC10__ENET_RMII1_MDIO	0x30df
> +			VF610_PAD_PTC11__ENET_RMII1_CRS	0x30dd
> +			VF610_PAD_PTC12__ENET_RMII1_RXD1	0x30dd
> +			VF610_PAD_PTC13__ENET_RMII1_RXD0	0x30dd
> +			VF610_PAD_PTC14__ENET_RMII1_RXER	0x30dd
> +			VF610_PAD_PTC15__ENET_RMII1_TXD1	0x30de
> +			VF610_PAD_PTC16__ENET_RMII1_TXD0	0x30de
> +			VF610_PAD_PTC17__ENET_RMII1_TXEN	0x30de
> +		>;
> +	};
> +
> +	pinctrl_gpio_leds: gpio_leds {
> +		fsl,pins = <
> +			VF610_PAD_PTE12__GPIO_117	0x1183
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			VF610_PAD_PTA22__I2C2_SCL               0x34df
> +			VF610_PAD_PTA23__I2C2_SDA               0x34df
> +		>;
> +	};
> +
> +	pinctrl_nfc: nfcgrp {
> +		fsl,pins = <
> +			VF610_PAD_PTD23__NF_IO7		0x28df
> +			VF610_PAD_PTD22__NF_IO6		0x28df
> +			VF610_PAD_PTD21__NF_IO5		0x28df
> +			VF610_PAD_PTD20__NF_IO4		0x28df
> +			VF610_PAD_PTD19__NF_IO3		0x28df
> +			VF610_PAD_PTD18__NF_IO2		0x28df
> +			VF610_PAD_PTD17__NF_IO1		0x28df
> +			VF610_PAD_PTD16__NF_IO0		0x28df
> +			VF610_PAD_PTB24__NF_WE_B		0x28c2
> +			VF610_PAD_PTB25__NF_CE0_B		0x28c2
> +			VF610_PAD_PTB27__NF_RE_B		0x28c2
> +			VF610_PAD_PTC26__NF_RB_B		0x283d
> +			VF610_PAD_PTC27__NF_ALE		0x28c2
> +			VF610_PAD_PTC28__NF_CLE		0x28c2
> +		>;
> +	};
> +
> +	pinctrl_uart0: uart0grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB10__UART0_TX		0x21a2
> +			VF610_PAD_PTB11__UART0_RX		0x21a1
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB4__UART1_TX		0x21a2
> +			VF610_PAD_PTB5__UART1_RX		0x21a1
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB6__UART2_TX		0x21a2
> +			VF610_PAD_PTB7__UART2_RX		0x21a1
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			VF610_PAD_PTA20__UART3_TX		0x21a2
> +			VF610_PAD_PTA21__UART3_RX		0x21a1
> +		>;
> +	};
> +
> +	pinctrl_qspi0: qspi0grp {
> +		fsl,pins = <
> +			VF610_PAD_PTD0__QSPI0_A_QSCK	0x397f
> +			VF610_PAD_PTD1__QSPI0_A_CS0	0x397f
> +			VF610_PAD_PTD2__QSPI0_A_DATA3	0x397f
> +			VF610_PAD_PTD3__QSPI0_A_DATA2	0x397f
> +			VF610_PAD_PTD4__QSPI0_A_DATA1	0x397f
> +			VF610_PAD_PTD5__QSPI0_A_DATA0	0x397f
> +			VF610_PAD_PTD7__QSPI0_B_QSCK	0x397f
> +			VF610_PAD_PTD8__QSPI0_B_CS0	0x397f
> +			VF610_PAD_PTD11__QSPI0_B_DATA1	0x397f
> +			VF610_PAD_PTD12__QSPI0_B_DATA0	0x397f
> +		>;
> +	};
> +};
> +
> +&nfc {
> +	assigned-clocks = <&clks VF610_CLK_NFC>;
> +	assigned-clock-rates = <33000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_nfc>;
> +	status = "okay";
> +
> +	nand@0 {
> +		compatible = "fsl,vf610-nfc-nandcs";
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		nand-bus-width = <16>;
> +		nand-ecc-mode = "hw";
> +		nand-ecc-strength = <24>;
> +		nand-ecc-step-size = <2048>;
> +		nand-on-flash-bbt;
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart0>;
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
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	status = "okay";
> +};
> +
> +&usbdev0 {
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&usbmisc0 {
> +	status = "okay";
> +};
> +
> +&usbmisc1 {
> +	status = "okay";
> +};
> +
> +&usbphy0 {
> +	status = "okay";
> +};
> +
> +&usbphy1 {
> +	status = "okay";
> +};
> +
> +&qspi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_qspi0>;
> +	status = "okay";
> +
> +	flash0: n25q128a13@0 {
> +		compatible = "n25q128a13", "jedec,spi-nor";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <66000000>;
> +		spi-rx-bus-width = <4>;
> +		reg = <0>;
> +	};
> +
> +	flash1: n25q128a13@1 {
> +		compatible = "n25q128a13", "jedec,spi-nor";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <66000000>;
> +		spi-rx-bus-width = <2>;
> +		reg = <1>;
> +	};
> +};
