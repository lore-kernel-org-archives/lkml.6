Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B90C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E3F2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E3F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbeLBVZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:25:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40511 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeLBVZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:25:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id k12so11643087qtf.7;
        Sun, 02 Dec 2018 13:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=slBDNr8VMbExiqIhU7Y+ETJVl7U13ZRMGYQiL+sy9Z0=;
        b=KxawpjKSL4MtLLnnsCDgI1DxV+BcZvySmLnB956b/wjFn1cEtkSlZMNFskKLBX3iYA
         nr5UvCZQNf+IefvVEKdN2hVS35e5GCqkMtHhpofvkz37PlUu/I42pNlQ2gIoAim3SIES
         ItZI0z+u8JSHksf1S/UHi7tVKr8QO1Syw0A0vd116Aghm8aiC/ZvvekL6RAe4JEryLiq
         ReuH8WbRuVqLFFV0w68OorEBOv8udAbhCR5/hv8nlsVQuJaoEl6qOEDEP5Cg046Zd/GO
         OPxmsRdoUfAsgfOtNCk7ExuMhr2BbLbh8xKOm6Txhydas7QdhYr2LyRScP9h2Xz1f05W
         Ln5Q==
X-Gm-Message-State: AA+aEWYuBc3qA9jGXPphE0hij2S04xvUQILZsQTLx/mURMLNqd4qzCr0
        LlljC+JrSYVhCWTNLy2GqAY=
X-Google-Smtp-Source: AFSGD/WBlY8bsILDyw4kORp5drjI7dNZZ67giChuDjPRJxz7n3/lYwPcTXBZm5J2+5locQ1jGPFxFQ==
X-Received: by 2002:aed:2471:: with SMTP id s46mr12898503qtc.160.1543785951211;
        Sun, 02 Dec 2018 13:25:51 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id s9sm7407251qta.35.2018.12.02.13.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 13:25:50 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 02 Dec 2018 19:25:44 -0200
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
Subject: [PATCH 3/9] ARM: dts: imx7d-pico-pi: Move SoM related part to imx7d-pico.dtsi
Date:   Sun,  2 Dec 2018 19:25:14 -0200
Message-Id: <20181202212520.16650-4-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202212520.16650-1-otavio@ossystems.com.br>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

imx7d-pico-pi board contains:

- One SoM board (imx7d pico)
- One base board (pi).

In order to make it easier for adding support for other board variants,
move the commom SoM part to the imx7d-pico.dtsi file.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx7d-pico-pi.dts | 116 ++--------------------------
 arch/arm/boot/dts/imx7d-pico.dtsi   | 111 +++++++++++++++++++++++++-
 2 files changed, 113 insertions(+), 114 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-pico-pi.dts b/arch/arm/boot/dts/imx7d-pico-pi.dts
index 33951f4c7f41..039c17066fe0 100644
--- a/arch/arm/boot/dts/imx7d-pico-pi.dts
+++ b/arch/arm/boot/dts/imx7d-pico-pi.dts
@@ -5,6 +5,9 @@
 #include "imx7d-pico.dtsi"
 
 / {
+	model = "TechNexion PICO-IMX7D Board and PI baseboard";
+	compatible = "technexion,imx7d-pico-pi", "fsl,imx7d";
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "imx7-sgtl5000";
@@ -16,43 +19,14 @@
 		};
 
 		dailink_master: simple-audio-card,codec {
-			sound-dai = <&codec>;
+			sound-dai = <&sgtl5000>;
 			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
 		};
 	};
 };
 
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet1>;
-	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
-			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
-	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
-	assigned-clock-rates = <0>, <100000000>;
-	phy-mode = "rgmii";
-	phy-handle = <&ethphy0>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <1>;
-			status = "okay";
-		};
-	};
-};
-
 &i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	codec: sgtl5000@a {
+	sgtl5000: codec@a {
 		#sound-dai-cells = <0>;
 		reg = <0x0a>;
 		compatible = "fsl,sgtl5000";
@@ -61,83 +35,3 @@
 		VDDIO-supply = <&reg_vref_1v8>;
 	};
 };
-
-
-&sai1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai1>;
-	assigned-clocks = <&clks IMX7D_SAI1_ROOT_SRC>,
-			  <&clks IMX7D_SAI1_ROOT_CLK>;
-	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
-	assigned-clock-rates = <0>, <24576000>;
-	status = "okay";
-};
-
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
-	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
-	status = "okay";
-};
-
-&usbotg1 {
-	vbus-supply = <&reg_usb_otg1_vbus>;
-	status = "okay";
-};
-
-&usbotg2 {
-	vbus-supply = <&reg_usb_otg2_vbus>;
-	dr_mode = "host";
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_enet1: enet1grp {
-		fsl,pins = <
-			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x3
-			MX7D_PAD_SD2_WP__ENET1_MDC			0x3
-			MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC	0x1
-			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x1
-			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x1
-			MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2	0x1
-			MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3	0x1
-			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x1
-			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC	0x1
-			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x1
-			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x1
-			MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
-			MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
-			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX7D_PAD_UART1_TX_DATA__I2C1_SDA	0x4000007f
-			MX7D_PAD_UART1_RX_DATA__I2C1_SCL	0x4000007f
-		>;
-	};
-
-	pinctrl_sai1: sai1grp {
-		fsl,pins = <
-			MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK	0x1f
-			MX7D_PAD_ENET1_CRS__SAI1_TX_SYNC	0x1f
-			MX7D_PAD_ENET1_COL__SAI1_TX_DATA0	0x30
-			MX7D_PAD_ENET1_TX_CLK__SAI1_RX_DATA0	0x1f
-		>;
-	};
-
-	pinctrl_uart5: uart5grp {
-		fsl,pins = <
-			MX7D_PAD_I2C4_SDA__UART5_DCE_TX		0x79
-			MX7D_PAD_I2C4_SCL__UART5_DCE_RX		0x79
-		>;
-	};
-
-	pinctrl_usbotg1_pwr: usbotg_pwr {
-		fsl,pins = <
-			MX7D_PAD_UART3_TX_DATA__GPIO4_IO5	0x14
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index d957454ce16b..7319e2ecec5c 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -7,9 +7,6 @@
 #include "imx7d.dtsi"
 
 / {
-	model = "Technexion Pico i.MX7D Board";
-	compatible = "technexion,imx7d-pico", "fsl,imx7d";
-
 	/* Will be filled by the bootloader */
 	memory@80000000 {
 		device_type = "memory";
@@ -79,6 +76,37 @@
 	assigned-clock-rates = <0>, <32768>;
 };
 
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
+			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
+	assigned-clock-rates = <0>, <100000000>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
 &i2c4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c4>;
@@ -174,6 +202,35 @@
 	};
 };
 
+&sai1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&clks IMX7D_SAI1_ROOT_SRC>,
+			  <&clks IMX7D_SAI1_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+	assigned-clock-rates = <0>, <24576000>;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	status = "okay";
+};
+
+&usbotg1 {
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	status = "okay";
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usdhc2 { /* Wifi SDIO */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2 &pinctrl_wifi_clk>;
@@ -208,6 +265,32 @@
 };
 
 &iomuxc {
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX7D_PAD_UART1_TX_DATA__I2C1_SDA	0x4000007f
+			MX7D_PAD_UART1_RX_DATA__I2C1_SCL	0x4000007f
+		>;
+	};
+
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x3
+			MX7D_PAD_SD2_WP__ENET1_MDC			0x3
+			MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC	0x1
+			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x1
+			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x1
+			MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2	0x1
+			MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3	0x1
+			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x1
+			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC	0x1
+			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x1
+			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x1
+			MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
+			MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
+			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX7D_PAD_SAI1_RX_BCLK__I2C4_SDA		0x4000007f
@@ -221,6 +304,28 @@
 		>;
 	};
 
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK	0x1f
+			MX7D_PAD_ENET1_CRS__SAI1_TX_SYNC	0x1f
+			MX7D_PAD_ENET1_COL__SAI1_TX_DATA0	0x30
+			MX7D_PAD_ENET1_TX_CLK__SAI1_RX_DATA0	0x1f
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SDA__UART5_DCE_TX		0x79
+			MX7D_PAD_I2C4_SCL__UART5_DCE_RX		0x79
+		>;
+	};
+
+	pinctrl_usbotg1_pwr: usbotg_pwr {
+		fsl,pins = <
+			MX7D_PAD_UART3_TX_DATA__GPIO4_IO5	0x14
+		>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_CMD__SD2_CMD		0x59
-- 
2.19.2

