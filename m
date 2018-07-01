Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDE1C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 02:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C80D253AB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 02:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHV9PhNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C80D253AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeGACo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 22:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbeGACoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 22:44:25 -0400
Received: from dragon (unknown [45.56.152.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0788F2539A;
        Sun,  1 Jul 2018 02:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530413064;
        bh=9+pyTX8hauK2geufOZ1mPh9cvmLiMgztwNLbwGv8WsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tHV9PhNrDr4R6HTh1bthbifFecvGPjJkOKlAdD9dclHDAv2LHlE8jbn9rN9p6i5c8
         p3jqY8RZGHUvH1AJSRm7cRydqFgcAjSJSwxnANIcU5PaWKgBoKBlpbVNHe5El3kgLI
         0vsEJrcWS9MU0qrNgjo5bjn+AyJCTKEi6MO6RG1U=
Date:   Sun, 1 Jul 2018 10:44:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alex Gonzalez <alex.gonzalez@digi.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC
 Express
Message-ID: <20180701024413.GC4348@dragon>
References: <1529393534-7827-1-git-send-email-alex.gonzalez@digi.com>
 <1529393534-7827-3-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529393534-7827-3-git-send-email-alex.gonzalez@digi.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 09:32:14AM +0200, Alex Gonzalez wrote:
> The ConnectCore 6UL Single Board Computer (SBC) Express contains the
> ConnectCore 6UL System-On-Module.
> 
> Its hardware specifications are:
> 
> * 256MB DDR3 memory
> * 256MB NAND flash
> * Single Ethernet
> * USB Host and USB-OTG
> * MicroSD external storage
> * Groove connectors and Raspberry Pi Hat compatible expansion header
> 
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
> ---
>  arch/arm/boot/dts/Makefile                      |   1 +
>  arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts | 205 ++++++++++++++++++++++++
>  2 files changed, 206 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 37a3de760d40..6135d3dc381c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -533,6 +533,7 @@ dtb-$(CONFIG_SOC_IMX6SX) += \
>  	imx6sx-udoo-neo-full.dtb
>  dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ul-14x14-evk.dtb \
> +	imx6ul-ccimx6ulsbcexpress.dtb \
>  	imx6ul-geam.dtb \
>  	imx6ul-isiot-emmc.dtb \
>  	imx6ul-isiot-nand.dtb \
> diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts
> new file mode 100644
> index 000000000000..1e3c4200b924
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Digi International's ConnectCore6UL SBC Express board device tree source
> + *
> + * Copyright 2018 Digi International, Inc.
> + *
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "imx6ul.dtsi"
> +#include "imx6ul-ccimx6ulsom.dtsi"
> +
> +/ {
> +	model = "Digi International ConnectCore 6UL SBC Express.";
> +	compatible = "digi,ccimx6ulsbcexpress", "digi,ccimx6ulsom",
> +		     "fsl,imx6ul";
> +};
> +
> +&adc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc1>;
> +	adc-ch-list = <4>;

Undocumented DT property.

> +	status = "okay";
> +};
> +
> +&ecspi3 {
> +	fsl,spi-num-chipselects = <1>;

This property is obsoleted.

> +	cs-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi3_master>;
> +	status = "okay";
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet1>;
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy0>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			smsc,disable-energy-detect;
> +			reg = <0>;
> +		};
> +	};
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	xceiver-supply = <&ext_3v3>;
> +	status = "okay";
> +};

Nodes are well sorted alphabetically in label name, but this one is not.

> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm1>;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	status = "okay";
> +};
> +
> +&uart5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart5>;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	dr_mode = "host";
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	dr_mode = "host";
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	broken-cd;      /* no carrier detect line (use polling) */
> +	no-1-8-v;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	imx6ul-ccimx6ul {

Drop this container node.

Shawn

> +		pinctrl_adc1: adc1grp {
> +			fsl,pins = <
> +				/* GPIO1_4/ADC1_IN4 (pin 7 of the expansion header) */
> +				MX6UL_PAD_GPIO1_IO04__GPIO1_IO04        0xb0
> +			>;
> +		};
> +
> +		pinctrl_ecspi3_master: ecspi3grp1 {
> +			fsl,pins = <
> +				MX6UL_PAD_UART2_RX_DATA__ECSPI3_SCLK	0x10b0
> +				MX6UL_PAD_UART2_CTS_B__ECSPI3_MOSI	0x10b0
> +				MX6UL_PAD_UART2_RTS_B__ECSPI3_MISO	0x10b0
> +				MX6UL_PAD_UART2_TX_DATA__GPIO1_IO20	0x10b0 /* Chip Select */
> +			>;
> +		};
> +
> +		pinctrl_ecspi3_slave: ecspi3grp2 {
> +			fsl,pins = <
> +				MX6UL_PAD_UART2_RX_DATA__ECSPI3_SCLK	0x10b0
> +				MX6UL_PAD_UART2_CTS_B__ECSPI3_MOSI	0x10b0
> +				MX6UL_PAD_UART2_RTS_B__ECSPI3_MISO	0x10b0
> +				MX6UL_PAD_UART2_TX_DATA__ECSPI3_SS0	0x10b0 /* Chip Select */
> +			>;
> +		};
> +
> +		pinctrl_enet1: enet1grp {
> +			fsl,pins = <
> +				MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
> +				MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
> +				MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
> +				MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
> +				MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
> +				MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
> +				MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
> +				MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
> +				MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
> +				MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x40017051
> +			>;
> +		};
> +
> +		pinctrl_flexcan1: flexcan1grp{
> +			fsl,pins = <
> +				MX6UL_PAD_LCD_DATA08__FLEXCAN1_TX	0x1b020
> +				MX6UL_PAD_LCD_DATA09__FLEXCAN1_RX	0x1b020
> +			>;
> +		};
> +
> +		pinctrl_i2c2: i2c2grp {
> +			fsl,pins = <
> +				MX6UL_PAD_GPIO1_IO00__I2C2_SCL 0x4001b8b0
> +				MX6UL_PAD_GPIO1_IO01__I2C2_SDA 0x4001b8b0
> +			>;
> +		};
> +
> +		pinctrl_pwm1: pwm1grp {
> +			fsl,pins = <
> +				MX6UL_PAD_LCD_DATA00__PWM1_OUT		0x10b0
> +			>;
> +		};
> +
> +		pinctrl_uart4: uart4grp {
> +			fsl,pins = <
> +				MX6UL_PAD_LCD_CLK__UART4_DCE_TX		0x1b0b1
> +				MX6UL_PAD_LCD_ENABLE__UART4_DCE_RX	0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_uart5: uart5grp {
> +			fsl,pins = <
> +				MX6UL_PAD_UART5_TX_DATA__UART5_DCE_TX	0x1b0b1
> +				MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX	0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_usdhc2: usdhc2grp {
> +			fsl,pins = <
> +				MX6UL_PAD_CSI_HSYNC__USDHC2_CMD		0x17059
> +				MX6UL_PAD_CSI_VSYNC__USDHC2_CLK		0x10071
> +				MX6UL_PAD_CSI_DATA00__USDHC2_DATA0	0x17059
> +				MX6UL_PAD_CSI_DATA01__USDHC2_DATA1	0x17059
> +				MX6UL_PAD_CSI_DATA02__USDHC2_DATA2	0x17059
> +				MX6UL_PAD_CSI_DATA03__USDHC2_DATA3	0x17059
> +			>;
> +		};
> +
> +		/* General purpose pinctrl */
> +		pinctrl_hog: hoggrp {
> +			fsl,pins = <
> +				/* GPIOs BANK 3 */
> +				MX6UL_PAD_LCD_RESET__GPIO3_IO04		0xf030
> +			>;
> +		};
> +
> +	};
> +};
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
