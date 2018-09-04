Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E14C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDFC20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDFC20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIDTyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:54:24 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.212]:40920 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727573AbeIDTyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:54:20 -0400
Received: from [67.219.246.101] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.us-east-1.aws.symcld.net id 57/B2-18242-AA4AE8B5; Tue, 04 Sep 2018 15:28:42 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleJIrShJLcpLzFFi42Jx8l0noLtqSV+
  0waMl2hbzj5xjtdi4+TaLxaqpO1ksNj2+xmrR9Wsls8XlXXPYLJZev8hk0br3CLvF3+2bWCxe
  bBF34PJYM28No8emVZ1sHpuX1HtsfLeDyaP/r4HH501yAWxRrJl5SfkVCawZzXMusxb8C644t
  WMqewPjNPcuRi4OIYFVjBLzPz9jhHBWM0o8vtvHBuFsZpT4O28GUxcjJwebgI7ElP2HWUBsEQ
  FJibUrFzGDFDELTGGSOP1tFxtIQljAU+LnWogiFgEViYU7nwMVcXDwCrhKLJ6YABKWEJCTuHm
  ukxnE5hRwk1h3dwkjiC0EVLLtay9YK6+AoMTJmU/AbGYBCYmDL14wQ9QoS2xZcYERYo6CxNoD
  55kmMArMQtIyC0nLAkamVYymSUWZ6RkluYmZObqGBga6hoZGuoa6JgZ6iVW6SXqlxbqpicUlu
  oZ6ieXFesWVuck5KXp5qSWbGIGRklLAqLGDcWtL+iFGSQ4mJVFetsV90UJ8SfkplRmJxRnxRa
  U5qcWHGGU4OJQkeLeC5ASLUtNTK9Iyc4AxC5OW4OBREuG1BsatEG9xQWJucWY6ROoUozHHtwf
  dk5g5/ryfOolZiCUvPy9VSpy3BWSSAEhpRmke3CBYKrnEKCslzMvIwMAgxFOQWpSbWYIq/4pR
  nINRSZh3M8gUnsy8Erh9r4BOYQI6ZcmBHpBTShIRUlLAxHD2jON/1ovrjx+amr7u4D/2xmDhh
  in+mmk23dZt0V7qlZIL3ilpnV/05YLqrV1L//Yfa174ho/9+94zjdubBOsNo1g3vf1k7jNr34
  ParCMOT81lNrzyiVJ9yrr6+88Z7E6cE16t2JL9e8mfslDpmKuz3LnDmv9KfLOJYbR8slnO4fg
  UWbEYeSWW4oxEQy3mouJEAANhKGAgAwAA
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-18.tower-385.messagelabs.com!1536074922!5141524!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30167 invoked from network); 4 Sep 2018 15:28:42 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-18.tower-385.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Sep 2018 15:28:42 -0000
Received: from MTK-SMS-XCH04.digi.com (10.10.8.198) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 4 Sep 2018
 10:28:41 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH04.digi.com
 (10.10.8.198) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 4 Sep 2018
 10:28:41 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 4 Sep 2018 17:28:39 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH v2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro
Date:   Tue, 4 Sep 2018 17:28:29 +0200
Message-ID: <1536074909-8654-2-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536074909-8654-1-git-send-email-alex.gonzalez@digi.com>
References: <1536074909-8654-1-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ConnectCore 6UL Single Board Computer (SBC) Pro contains the
ConnectCore 6UL System-On-Module.

Its hardware specifications are:

* 256MB DDR3 memory
* On module 256MB NAND flash
* Dual 10/100 Ethernet
* USB Host and USB OTG
* Parallel RGB display header
* LVDS display header
* CSI camera
* GPIO header
* I2C, SPI, CAN headers
* PCIe mini card and micro SIM slot
* MicroSD external storage
* On board 4GB eMMC flash
* Audio headphone, line in/out, microphone lines

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 394 ++++++++++++++++++++++++++++
 2 files changed, 395 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6135d3dc381c..3f6f8983f6c6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -534,6 +534,7 @@ dtb-$(CONFIG_SOC_IMX6SX) += \
 dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-14x14-evk.dtb \
 	imx6ul-ccimx6ulsbcexpress.dtb \
+	imx6ul-ccimx6ulsbcpro.dtb \
 	imx6ul-geam.dtb \
 	imx6ul-isiot-emmc.dtb \
 	imx6ul-isiot-nand.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
new file mode 100644
index 000000000000..08d550baa684
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Digi International's ConnectCore6UL SBC Pro board device tree source
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
+	model = "Digi International ConnectCore 6UL SBC Pro.";
+	compatible = "digi,ccimx6ulsbcpro", "digi,ccimx6ulsom", "fsl,imx6ul";
+
+	lcd_backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm5 0 50000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		status = "okay";
+	};
+
+	reg_usb_otg1_vbus: reg-usb-otg1 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&adc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc1>;
+	status = "okay";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&ext_3v3>;
+	status = "okay";
+};
+
+/* CAN2 is multiplexed with UART2 RTS/CTS */
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&ext_3v3>;
+	status = "disabled";
+};
+
+&ecspi1 {
+	cs-gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1_master>;
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2 &pinctrl_enet2_mdio>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy1>;
+	phy-reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <26>;
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
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			smsc,disable-energy-detect;
+			reg = <1>;
+		};
+	};
+};
+
+&gpio5 {
+	emmc-usd-mux {
+		gpio-hog;
+		gpios = <1 GPIO_ACTIVE_LOW>;
+		output-high;
+	};
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat0_17
+		     &pinctrl_lcdif_clken
+		     &pinctrl_lcdif_hvsync>;
+	lcd-supply = <&ldo4_ext>;       /* BU90T82 LVDS bridge power */
+	status = "okay";
+};
+
+&ldo4_ext {
+	regulator-max-microvolt = <1800000>;
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	clocks = <&clks IMX6UL_CLK_PWM4>,
+		<&clks IMX6UL_CLK_PWM4>;
+	status = "okay";
+};
+
+&pwm5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm5>;
+	clocks = <&clks IMX6UL_CLK_PWM5>,
+		 <&clks IMX6UL_CLK_PWM5>;
+	status = "okay";
+};
+
+&pwm6 {
+	status = "okay";
+};
+
+&pwm7 {
+	status = "okay";
+};
+
+&pwm8 {
+	status = "okay";
+};
+
+&sai2 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_sai2>;
+	pinctrl-1 = <&pinctrl_sai2_sleep>;
+	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
+			  <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>,
+			  <&clks IMX6UL_CLK_SAI2>;
+	assigned-clock-rates = <0>, <786432000>, <12288000>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	status = "okay";
+};
+
+/* UART2 RTS/CTS muxed with CAN2 */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2_4wires>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+/* UART3 RTS/CTS muxed with CAN 1 */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3_2wires>;
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
+	dr_mode = "otg";
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	pinctrl-0 = <&pinctrl_usbotg1>;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+/* USDHC2 (microSD conflicts with eMMC) */
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	no-1-8-v;
+	broken-cd;	/* no carrier detect line (use polling) */
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_adc1: adc1grp {
+		fsl,pins = <
+			/* EXP_GPIO_2 -> GPIO1_3/ADC1_IN3 */
+			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03        0xb0
+		>;
+	};
+
+	pinctrl_ecspi1_master: ecspi1grp1 {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA20__ECSPI1_SCLK	0x10b0
+			MX6UL_PAD_LCD_DATA22__ECSPI1_MOSI	0x10b0
+			MX6UL_PAD_LCD_DATA23__ECSPI1_MISO	0x10b0
+			MX6UL_PAD_LCD_DATA21__GPIO3_IO26	0x10b0
+		>;
+	};
+
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x40017051
+		>;
+	};
+
+	pinctrl_enet2: enet2grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x40017051
+		>;
+	};
+
+	pinctrl_enet2_mdio: mdioenet2grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
+			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp{
+		fsl,pins = <
+			MX6UL_PAD_UART3_CTS_B__FLEXCAN1_TX	0x1b020
+			MX6UL_PAD_UART3_RTS_B__FLEXCAN1_RX	0x1b020
+		>;
+	};
+	pinctrl_flexcan2: flexcan2grp{
+		fsl,pins = <
+			MX6UL_PAD_UART2_CTS_B__FLEXCAN2_TX	0x1b020
+			MX6UL_PAD_UART2_RTS_B__FLEXCAN2_RX	0x1b020
+		>;
+	};
+
+	pinctrl_lcdif_dat0_17: lcdifdatgrp0-17 {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00	0x79
+			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01	0x79
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x79
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x79
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x79
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x79
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x79
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x79
+			MX6UL_PAD_LCD_DATA08__LCDIF_DATA08	0x79
+			MX6UL_PAD_LCD_DATA09__LCDIF_DATA09	0x79
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x79
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x79
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x79
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x79
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x79
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x79
+			MX6UL_PAD_LCD_DATA16__LCDIF_DATA16	0x79
+			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17	0x79
+		>;
+	};
+
+	pinctrl_lcdif_clken: lcdifctrlgrp1 {
+		fsl,pins = <
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x17050
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
+		>;
+	};
+
+	pinctrl_lcdif_hvsync: lcdifctrlgrp2 {
+		fsl,pins = <
+			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC	0x79
+			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC	0x79
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO05__PWM4_OUT          0x110b0
+		>;
+	};
+
+	pinctrl_pwm5: pwm5grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_DQS__PWM5_OUT		0x110b0
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
+			MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
+			MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
+			MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
+			MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
+			/* Interrupt */
+			MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x80000000
+		>;
+	};
+
+	pinctrl_sai2_sleep: sai2grp-sleep {
+		fsl,pins = <
+			MX6UL_PAD_JTAG_TRST_B__GPIO1_IO15	0x3000
+			MX6UL_PAD_JTAG_TCK__GPIO1_IO14		0x3000
+			MX6UL_PAD_JTAG_TMS__GPIO1_IO11		0x3000
+			MX6UL_PAD_JTAG_TDO__GPIO1_IO12		0x3000
+			/* Interrupt */
+			MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x3000
+		>;
+	};
+
+	pinctrl_uart2_4wires: uart2grp-4wires {
+		fsl,pins = <
+			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
+			MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart3_2wires: uart3grp-2wires {
+		fsl,pins = <
+			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX6UL_PAD_UART5_TX_DATA__UART5_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_HSYNC__USDHC2_CMD		0x17059
+			MX6UL_PAD_CSI_VSYNC__USDHC2_CLK		0x10039
+			MX6UL_PAD_CSI_DATA00__USDHC2_DATA0	0x17059
+			MX6UL_PAD_CSI_DATA01__USDHC2_DATA1	0x17059
+			MX6UL_PAD_CSI_DATA02__USDHC2_DATA2	0x17059
+			MX6UL_PAD_CSI_DATA03__USDHC2_DATA3	0x17059
+			/* Mux selector between eMMC/SD# */
+			MX6UL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x79
+		>;
+	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO00__ANATOP_OTG1_ID	0x17059
+			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0x17059
+			MX6UL_PAD_GPIO1_IO01__USB_OTG1_OC	0x17059
+		>;
+	};
+};
