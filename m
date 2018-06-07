Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DBoZFXY3GVvEZgAAmS7hNA
	; Thu, 07 Jun 2018 13:48:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F004B608D4; Thu,  7 Jun 2018 13:48:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dkUNanMY"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 84AE26089E;
	Thu,  7 Jun 2018 13:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84AE26089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932347AbeFGNsF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:48:05 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42334 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753103AbeFGNsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:48:03 -0400
Received: by mail-pl0-f68.google.com with SMTP id w17-v6so6184219pll.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hPzjhy/8DGYv0nH0+OkS0QJZkKBpwKFMiF7eCEi3T04=;
        b=dkUNanMYiog5ldnZDOwGr43xcVb1iCrsO84awo2MFgV3pwn1Bkcm95oIX7ErZDMJ7t
         ceztBocGZX6zccQ8nL3sOkfCiN0lSt1SpmbBoa5bPkRPIFysYGjbgzHjakicu6rWOONf
         lsEL6y6tNJe+IPRIYam3KNYuXbb1AU2ikNkjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hPzjhy/8DGYv0nH0+OkS0QJZkKBpwKFMiF7eCEi3T04=;
        b=oZIZlHHxwGwq6wsx15UwwS0JcrEnpOF//ke7IXOZC5tWYyoMbgQLpkSuOiUwe8xnIG
         8bYjNB0RHiwMIhGcjohaIxlb22wbgMvkt02OXryilZB0QXmHw+SSnyGvpT4JWdy46tHa
         HOUyTiuPOlgsCDfaTnR/Yd/yISX5E5eIIwidVjkKgJ80u2PeLgMdnYeXKLJkqDyaefjb
         VSDXbNJyN61s2bxHHuGKA5GSr/F2I94dF3zQFIH8GXsR6zysMNUffPfz12kPL20bjq7y
         0fLeey5/e+MYpU6LsamwoggxxV+PQU0sApuo9q8nRL3hI3WwYLFgPXbt6xhScQitcvWA
         lK7w==
X-Gm-Message-State: APt69E2SxrXx+ge8lzc4eUZDP/Z84TrmTWw0DwhBApnPDlxrLEMLqery
        qy4wczJSd/oz8/sdJmh3Ao7BXg==
X-Google-Smtp-Source: ADUXVKK/NWkIhFrEET37ez+xqob88MRoBUfRHOJ75OQe32y3uOq267lwlNl/3Pm0U8XXQYvcuXp4CA==
X-Received: by 2002:a17:902:7b95:: with SMTP id w21-v6mr2129068pll.255.1528379282439;
        Thu, 07 Jun 2018 06:48:02 -0700 (PDT)
Received: from localhost.localdomain ([115.97.190.51])
        by smtp.gmail.com with ESMTPSA id r30-v6sm12879137pgn.58.2018.06.07.06.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 06:48:01 -0700 (PDT)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        "davide . bonfanti" <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simone CIANNI <simone.cianni@bticino.it>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Subject: [PATCH v2 2/4] ARM: dts: i.MX6: imx6dl-mamoj: Add parallel display support
Date: Thu,  7 Jun 2018 19:17:46 +0530
Message-Id: <20180607134748.2970-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds parallel display support for i.MX6DL Mamoj board
along with relevant backlight through pwm.

LCD power sequence is added by 'Michael Trimarchi'.

Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes for v2:
- collect Fabio r-w-b tag

 arch/arm/boot/dts/imx6dl-mamoj.dts | 185 +++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
index 6b2d29138bed..ed9050c5dbcc 100644
--- a/arch/arm/boot/dts/imx6dl-mamoj.dts
+++ b/arch/arm/boot/dts/imx6dl-mamoj.dts
@@ -6,11 +6,133 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "imx6dl.dtsi"
 
 / {
 	model = "BTicino i.MX6DL Mamoj board";
 	compatible = "bticino,imx6dl-mamoj", "fsl,imx6dl";
+
+	backlight_lcd: backlight-lcd {
+		compatible = "pwm-backlight";
+		pwms = <&pwm3 0 25000>; /* 25000ns -> 40kHz */
+		brightness-levels = <0 4 8 16 32 64 128 160 192 224 255>;
+		default-brightness-level = <7>;
+	};
+
+	lcd_display: disp0 {
+		compatible = "fsl,imx-parallel-display";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interface-pix-fmt = "rgb24";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1_lcdif>;
+		status = "okay";
+
+		port@0 {
+			reg = <0>;
+
+			lcd_display_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			lcd_display_out: endpoint {
+				remote-endpoint = <&lcd_panel_in>;
+			};
+		};
+	};
+
+	panel-lcd {
+		compatible = "rocktech,rk070er9427";
+		backlight = <&backlight_lcd>;
+		power-supply = <&reg_lcd_lr>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd_power>;
+
+		port {
+			lcd_panel_in: endpoint {
+				remote-endpoint = <&lcd_display_out>;
+			};
+		};
+	};
+
+	reg_lcd_3v3: regulator-lcd-dvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-dvdd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 1 0>;
+		enable-active-high;
+		startup-delay-us = <21000>;
+	};
+
+	reg_lcd_power: regulator-lcd-power {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-enable";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 6 0>;
+		enable-active-high;
+		vin-supply = <&reg_lcd_3v3>;
+	};
+
+	reg_lcd_vgl: regulator-lcd-vgl {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-vgl";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 20 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <6000>;
+		enable-active-high;
+		vin-supply = <&reg_lcd_power>;
+	};
+
+	reg_lcd_vgh: regulator-lcd-vgh {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-vgh";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <6000>;
+		enable-active-high;
+		vin-supply = <&reg_lcd_avdd>;
+	};
+
+	reg_lcd_vcom: regulator-lcd-vcom {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-vcom";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio4 14 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <11000>;
+		enable-active-high;
+		vin-supply = <&reg_lcd_vgh>;
+	};
+
+	reg_lcd_lr: regulator-lcd-lr {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-lr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_lcd_vcom>;
+	};
+
+	reg_lcd_avdd: regulator-lcd-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-avdd";
+		regulator-min-microvolt = <10280000>;
+		regulator-max-microvolt = <10280000>;
+		gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <6000>;
+		enable-active-high;
+		vin-supply = <&reg_lcd_vgl>;
+	};
 };
 
 &fec {
@@ -147,6 +269,16 @@
 	};
 };
 
+&ipu1_di0_disp0 {
+	remote-endpoint = <&lcd_display_in>;
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
@@ -200,6 +332,59 @@
 		>;
 	};
 
+	pinctrl_ipu1_lcdif: pinctrlipu1lcdif { /* parallel port 24-bit */
+		fsl,pins = <
+			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10 /* VDOUT_PCLK */
+			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
+			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10 /* VDOUT_HSYNC */
+			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10 /* VDOUT_VSYNC */
+			MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04	   0x80000000 /* VDOUT_RESET */
+			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x10
+			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
+			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
+			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
+			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
+			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
+			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
+			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
+			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
+			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
+			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
+			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
+			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
+			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
+			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
+			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
+			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
+			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
+			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
+			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
+			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
+			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
+			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
+			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
+		>;
+	};
+
+	pinctrl_lcd_power: lcd_power {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_DA1__GPIO3_IO01		0x40013058 /* EN_LCD33V */
+			MX6QDL_PAD_SD4_DAT5__GPIO2_IO13		0x4001b0b0 /* EN_AVDD */
+			MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x40013058 /* ENVGH */
+			MX6QDL_PAD_EIM_A18__GPIO2_IO20		0x40013058 /* ENVGL */
+			MX6QDL_PAD_EIM_DA6__GPIO3_IO06		0x40013058 /* LCD_POWER */
+			MX6QDL_PAD_KEY_COL4__GPIO4_IO14		0x40013058 /* EN_VCOM_LCD */
+			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x40013058 /* LCD_L_R */
+			MX6QDL_PAD_EIM_DA2__GPIO3_IO02		0x40013058 /* LCD_U_D */
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT1__PWM3_OUT 0x1b0b1
+		>;
+	};
+
 	pinctrl_uart3: uart3grp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
-- 
2.14.3
