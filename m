Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF887C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5BA2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5BA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937357AbeFSHch (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:32:37 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.208]:27991 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937326AbeFSHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:32:33 -0400
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.us-west-2.aws.symcld.net id 86/43-07043-091B82B5; Tue, 19 Jun 2018 07:32:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRWlGSWpSXmKPExsXi5LtOQHfCRo1
  ogyUrhS3mHznHarFx820Wi1VTd7JYbHp8jdWi69dKZovLu+awWSy9fpHJonXvEXaLv9s3sVi8
  2CLuwOWxZt4aRo9NqzrZPDYvqffY+G4Hk0f/XwOPz5vkAtiiWDPzkvIrElgzlm9eyVzwS7dix
  rQPjA2Mm9S6GLk4hARWMUocOPqFHcLZwijxas0RIIeTg01AR2LK/sMsILaIgKTE2pWLmEGKmA
  V+MUq8/HOcDSQhLOAn8XvGGlYQm0VAVWLz1aNgzbwCrhK7VvwBq5EQkJO4ea6TGcTmFHCTOPf
  pI1hcCKjm0OoFzBD1ghInZz4BW8YsICFx8MULZogaZYktKy4wQsxRkFh74DzTBEb+WUhaZiFp
  WcDItIrRIqkoMz2jJDcxM0fX0MBA19DQSNfQ2ELXyNBIL7FKN1mvtFi3PLW4RBfILS/WK67MT
  c5J0ctLLdnECIwLBiDYwfj3UMohRkkOJiVRXrE4jWghvqT8lMqMxOKM+KLSnNTiQ4wyHBxKEr
  whG4BygkWp6akVaZk5wAiFSUtw8CiJ8GqCpHmLCxJzizPTIVKnGBWlxHkVQBICIImM0jy4Nlh
  SuMQoKyXMywh0iBBPQWpRbmYJqvwrRnEORiVhXieQKTyZeSVw018BLWYCWrylSh1kcUkiQkqq
  gdFEXSsoadk0vtarc1ZN0Th8v6gi6o2edkVI2YoQpgsJAZebbKZ82GTw2+Fl/rSezunnxKed8
  i5cULhg9YUXTP98n9fmRH1+YXms8pnxvVtPFdv709Y/3nBX7WJPVs2yCFv9ehWhiDm5zy5K3T
  Z//an3bfuGzXdNZe5yPevcd2xSA0MHg/3PK1pKLMUZiYZazEXFiQAL4BJpBQMAAA==
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-11.tower-365.messagelabs.com!1529393551!46188!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12036 invoked from network); 19 Jun 2018 07:32:32 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-11.tower-365.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Jun 2018 07:32:32 -0000
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 19 Jun 2018
 02:32:30 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Tue, 19 Jun 2018 09:32:28 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Express
Date:   Tue, 19 Jun 2018 09:32:14 +0200
Message-ID: <1529393534-7827-3-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529393534-7827-1-git-send-email-alex.gonzalez@digi.com>
References: <1529393534-7827-1-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ConnectCore 6UL Single Board Computer (SBC) Express contains the
ConnectCore 6UL System-On-Module.

Its hardware specifications are:

* 256MB DDR3 memory
* 256MB NAND flash
* Single Ethernet
* USB Host and USB-OTG
* MicroSD external storage
* Groove connectors and Raspberry Pi Hat compatible expansion header

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts | 205 ++++++++++++++++++++++++
 2 files changed, 206 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de760d40..6135d3dc381c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -533,6 +533,7 @@ dtb-$(CONFIG_SOC_IMX6SX) += \
 	imx6sx-udoo-neo-full.dtb
 dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-14x14-evk.dtb \
+	imx6ul-ccimx6ulsbcexpress.dtb \
 	imx6ul-geam.dtb \
 	imx6ul-isiot-emmc.dtb \
 	imx6ul-isiot-nand.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts
new file mode 100644
index 000000000000..1e3c4200b924
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Digi International's ConnectCore6UL SBC Express board device tree source
+ *
+ * Copyright 2018 Digi International, Inc.
+ *
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx6ul.dtsi"
+#include "imx6ul-ccimx6ulsom.dtsi"
+
+/ {
+	model = "Digi International ConnectCore 6UL SBC Express.";
+	compatible = "digi,ccimx6ulsbcexpress", "digi,ccimx6ulsom",
+		     "fsl,imx6ul";
+};
+
+&adc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc1>;
+	adc-ch-list = <4>;
+	status = "okay";
+};
+
+&ecspi3 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3_master>;
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			smsc,disable-energy-detect;
+			reg = <0>;
+		};
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&ext_3v3>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	broken-cd;      /* no carrier detect line (use polling) */
+	no-1-8-v;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	imx6ul-ccimx6ul {
+		pinctrl_adc1: adc1grp {
+			fsl,pins = <
+				/* GPIO1_4/ADC1_IN4 (pin 7 of the expansion header) */
+				MX6UL_PAD_GPIO1_IO04__GPIO1_IO04        0xb0
+			>;
+		};
+
+		pinctrl_ecspi3_master: ecspi3grp1 {
+			fsl,pins = <
+				MX6UL_PAD_UART2_RX_DATA__ECSPI3_SCLK	0x10b0
+				MX6UL_PAD_UART2_CTS_B__ECSPI3_MOSI	0x10b0
+				MX6UL_PAD_UART2_RTS_B__ECSPI3_MISO	0x10b0
+				MX6UL_PAD_UART2_TX_DATA__GPIO1_IO20	0x10b0 /* Chip Select */
+			>;
+		};
+
+		pinctrl_ecspi3_slave: ecspi3grp2 {
+			fsl,pins = <
+				MX6UL_PAD_UART2_RX_DATA__ECSPI3_SCLK	0x10b0
+				MX6UL_PAD_UART2_CTS_B__ECSPI3_MOSI	0x10b0
+				MX6UL_PAD_UART2_RTS_B__ECSPI3_MISO	0x10b0
+				MX6UL_PAD_UART2_TX_DATA__ECSPI3_SS0	0x10b0 /* Chip Select */
+			>;
+		};
+
+		pinctrl_enet1: enet1grp {
+			fsl,pins = <
+				MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
+				MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
+				MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
+				MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
+				MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
+				MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
+				MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
+				MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
+				MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
+				MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x40017051
+			>;
+		};
+
+		pinctrl_flexcan1: flexcan1grp{
+			fsl,pins = <
+				MX6UL_PAD_LCD_DATA08__FLEXCAN1_TX	0x1b020
+				MX6UL_PAD_LCD_DATA09__FLEXCAN1_RX	0x1b020
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX6UL_PAD_GPIO1_IO00__I2C2_SCL 0x4001b8b0
+				MX6UL_PAD_GPIO1_IO01__I2C2_SDA 0x4001b8b0
+			>;
+		};
+
+		pinctrl_pwm1: pwm1grp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_DATA00__PWM1_OUT		0x10b0
+			>;
+		};
+
+		pinctrl_uart4: uart4grp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_CLK__UART4_DCE_TX		0x1b0b1
+				MX6UL_PAD_LCD_ENABLE__UART4_DCE_RX	0x1b0b1
+			>;
+		};
+
+		pinctrl_uart5: uart5grp {
+			fsl,pins = <
+				MX6UL_PAD_UART5_TX_DATA__UART5_DCE_TX	0x1b0b1
+				MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX	0x1b0b1
+			>;
+		};
+
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX6UL_PAD_CSI_HSYNC__USDHC2_CMD		0x17059
+				MX6UL_PAD_CSI_VSYNC__USDHC2_CLK		0x10071
+				MX6UL_PAD_CSI_DATA00__USDHC2_DATA0	0x17059
+				MX6UL_PAD_CSI_DATA01__USDHC2_DATA1	0x17059
+				MX6UL_PAD_CSI_DATA02__USDHC2_DATA2	0x17059
+				MX6UL_PAD_CSI_DATA03__USDHC2_DATA3	0x17059
+			>;
+		};
+
+		/* General purpose pinctrl */
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				/* GPIOs BANK 3 */
+				MX6UL_PAD_LCD_RESET__GPIO3_IO04		0xf030
+			>;
+		};
+
+	};
+};
