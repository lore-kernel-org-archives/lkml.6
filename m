Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E07C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD9720672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD9720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbeLFKKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:10:10 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40207 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFKKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:10:09 -0500
Received: by mail-qt1-f196.google.com with SMTP id k12so25616213qtf.7;
        Thu, 06 Dec 2018 02:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=hCoU2gbIkFUvFKy10Gd09lC8DMzvZQ0iMHClYT3ZpAo=;
        b=kGGLCwVqsKp8DhCQSmYzbClYqoV+aF/8qzS3A98/CcQ2P+jUVvCAT2Uwg5ATbojM8u
         d6Nbv/wKo8IoeTkqbebh4XwzXnTnsTtxfOUmxvn/3+KKISmqNoqSIjbbzhuK/jlhgs5I
         cY41KidPziZfoBOCA4pFIOnSPO/AEO60JFQea6KG/KRbz9fGCnR1cc1AimLBhPIbX4Rj
         GYJyuBESQCIpdP8rsAPr9MqHscdXJDuvFo5ztLJZEqOsy5ms/i52sOirUBzcLQimNrgM
         YthPgI2QksV0QPRuHo2GTUr4wKhIw4EqQgMEofgTSZXNDXKNFtEY95uOw2ec/hcexpfK
         fV9A==
X-Gm-Message-State: AA+aEWY04GGRC93iecVZCNAdGCb/BfIlw6KyQfRp81ECB9A+y+hoTl/e
        VZi+7B6IloXsAtabGBzPMWM=
X-Google-Smtp-Source: AFSGD/XZdZbc4s/yzcYwlKZHdBoMnBXDb9hCzDx/mpYCsZpMx/7KIRlduCXjuEgmWvSx2qFD8Qj+8g==
X-Received: by 2002:a0c:e394:: with SMTP id a20mr26129000qvl.42.1544091008052;
        Thu, 06 Dec 2018 02:10:08 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id c49sm14363057qtc.94.2018.12.06.02.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 02:10:07 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 06 Dec 2018 08:10:01 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2 7/9] ARM: dts: imx7d-pico: Extend peripherals support
Date:   Thu,  6 Dec 2018 08:09:03 -0200
Message-Id: <20181206100905.15053-8-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

This extends the peripherals supported by the imx7d-pico.dtsi. It
adds:

 - I2C2
 - Flexcan (flexcan1 and flexcan2 ports)
 - USDHC1
 - UART (6 and 7 ports)
 - PWM (4 ports)
 - eCSPI3

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2:
- replace fsl,uart-has-rtscts with uart-has-rtscts

 arch/arm/boot/dts/imx7d-pico.dtsi | 183 ++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 417f034fb354..3fd595a71202 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -78,6 +78,13 @@
 	assigned-clock-rates = <0>, <32768>;
 };
 
+&ecspi3 {
+	cs-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	status = "okay";
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1>;
@@ -103,6 +110,18 @@
 	};
 };
 
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can2>;
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -110,6 +129,12 @@
 	status = "okay";
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
 &i2c4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c4>;
@@ -215,6 +240,29 @@
 	status = "okay";
 };
 
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
+&pwm4 { /* Backlight */
+	status = "okay";
+};
+
 &uart5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart5>;
@@ -223,6 +271,24 @@
 	status = "okay";
 };
 
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart6>;
+	assigned-clocks = <&clks IMX7D_UART6_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart7 { /* Bluetooth */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart7>;
+	assigned-clocks = <&clks IMX7D_UART7_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
 &usbotg1 {
 	vbus-supply = <&reg_usb_otg1_vbus>;
 	status = "okay";
@@ -234,6 +300,21 @@
 	status = "okay";
 };
 
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	tuning-step = <2>;
+	vmmc-supply = <&reg_3p3v>;
+	wakeup-source;
+	no-1-8-v;
+	keep-power-in-suspend;
+	status = "okay";
+};
+
 &usdhc2 { /* Wifi SDIO */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2 &pinctrl_wifi_clk>;
@@ -268,6 +349,15 @@
 };
 
 &iomuxc {
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX7D_PAD_I2C1_SCL__ECSPI3_MISO		0x2
+			MX7D_PAD_I2C1_SDA__ECSPI3_MOSI		0x2
+			MX7D_PAD_I2C2_SCL__ECSPI3_SCLK		0x2
+			MX7D_PAD_I2C2_SDA__GPIO4_IO11		0x14
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__I2C1_SDA	0x4000007f
@@ -275,6 +365,13 @@
 		>;
 	};
 
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX7D_PAD_UART2_TX_DATA__I2C2_SDA	0x4000007f
+			MX7D_PAD_UART2_RX_DATA__I2C2_SCL	0x4000007f
+		>;
+	};
+
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x3
@@ -295,6 +392,20 @@
 		>;
 	};
 
+	pinctrl_can1: can1frp {
+		fsl,pins = <
+			MX7D_PAD_SAI1_RX_DATA__FLEXCAN1_RX	0x59
+			MX7D_PAD_SAI1_TX_BCLK__FLEXCAN1_TX	0x59
+		>;
+	};
+
+	pinctrl_can2: can2frp {
+		fsl,pins = <
+			MX7D_PAD_SAI1_TX_SYNC__FLEXCAN2_RX	0x59
+			MX7D_PAD_SAI1_TX_DATA__FLEXCAN2_TX	0x59
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX7D_PAD_SAI1_RX_BCLK__I2C4_SDA		0x4000007f
@@ -302,6 +413,24 @@
 		>;
 	};
 
+	pinctrl_pwm1: pwm1 {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO08__PWM1_OUT   0x7f
+		>;
+	};
+
+	pinctrl_pwm2: pwm2 {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO09__PWM2_OUT   0x7f
+		>;
+	};
+
+	pinctrl_pwm3: pwm3 {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO10__PWM3_OUT   0x7f
+		>;
+	};
+
 	pinctrl_reg_wlreg_on: regregongrp {
 		fsl,pins = <
 			MX7D_PAD_ECSPI1_SCLK__GPIO4_IO16	0x59
@@ -324,12 +453,66 @@
 		>;
 	};
 
+	pinctrl_uart6: uart6grp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA08__UART6_DCE_RX	0x79
+			MX7D_PAD_EPDC_DATA09__UART6_DCE_TX	0x79
+			MX7D_PAD_EPDC_DATA10__UART6_DCE_RTS	0x79
+			MX7D_PAD_EPDC_DATA11__UART6_DCE_CTS	0x79
+		>;
+	};
+
+	pinctrl_uart7: uart7grp {
+		fsl,pins = <
+			MX7D_PAD_ECSPI2_MOSI__UART7_DCE_TX	0x79
+			MX7D_PAD_ECSPI2_SCLK__UART7_DCE_RX	0x79
+			MX7D_PAD_ECSPI2_SS0__UART7_DCE_CTS	0x79
+			MX7D_PAD_ECSPI2_MISO__UART7_DCE_RTS	0x79
+		>;
+	};
+
 	pinctrl_usbotg1_pwr: usbotg_pwr {
 		fsl,pins = <
 			MX7D_PAD_UART3_TX_DATA__GPIO4_IO5	0x14
 		>;
 	};
 
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x59
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x19
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
+			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x15
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x5a
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x1a
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5a
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5a
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5a
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5a
+			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x15
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x5b
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x1b
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5b
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5b
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5b
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5b
+			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x15
+		>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_CMD__SD2_CMD		0x59
-- 
2.19.2

