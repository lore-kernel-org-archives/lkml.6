Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72648ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5832147A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n4/l0eCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5832147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeGQJ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:57:58 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36880 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbeGQJ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:57:57 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so216817plc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=W/KaE2CGT04ugRxUZLVYfCyoA/4KLXtPNhHXRxSn6MU=;
        b=n4/l0eCGA2QboQIZ8s+ivYumjQReoArMmFquB9jYhUESHVMvLBv75p/B7vlRkd0J3p
         /YZ0zKj7YLbGOYC0lLDoF4rTwRE0dTFS3L/Qv15Jsm1RZ21kPZ2NmDc58wLgj9NJFpUz
         PaxkLl2FqRhCFpRFKijLESzDDo54AFcvpvo24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W/KaE2CGT04ugRxUZLVYfCyoA/4KLXtPNhHXRxSn6MU=;
        b=l6OIyqTH8GLvfov8rYATQirUA2gamkdPgiRTDUzyA1WllHVsGqkXgUzkC4DiHhY3Zg
         ZUbYQOHC663kDbqLbiSqfVvfozuCe0o7Whs0TbSC+QCz3nxGH9fojk+cIGt5aYclk3oV
         5ZXhpd0Z1BEbh+Mlue9g1ydU1UxQSWVrbrC3v/lmG0EVeHKGlTu49HX8/rjDEDBqAHIf
         o2PmukbsLJRuKYCOUpdaMdyvGb7gc+h7ytX7RG0v8gGlr/WsvRJZMNk0Yq50CzDe5WDC
         nyYySd1CE5q/7b5lNkmsr2iBrFqzoRjliKA46YEMBbY+UXtUZK5CCRM+BlyFJa0Gj49M
         HM0g==
X-Gm-Message-State: AOUpUlFB3WJ2nNcTpsBtNKU0/2e0KdBFT0zH6qcBISKwQx2Jsynh+ZcZ
        adYjKzbN1OCIx6nSHPgXGL1yoQ==
X-Google-Smtp-Source: AAOMgpeqsjf4qzPlBgLFUcz2/Z3dRSANp4EsQTBUbr5+SVbkqqkp9xdw7hl8EXo8lWBDmOXGNKerQw==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3-v6mr908640plb.80.1531819576962;
        Tue, 17 Jul 2018 02:26:16 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id l85-v6sm2652869pfk.34.2018.07.17.02.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 02:26:16 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        Davide Bonfanti <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simone CIANNI <simone.cianni@bticino.it>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Subject: [PATCH v3 1/3] ARM: dts: i.MX6: imx6dl-mamoj: Add parallel display support
Date:   Tue, 17 Jul 2018 14:55:24 +0530
Message-Id: <20180717092526.32215-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
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
Changes for v3:
- update node name lcd_display as display
- Use proper vlaue with VDOUT_RESET pin 
- updtae pinctrl_lcd_power iomux label as pinctrl_ipu1_lcdif_pwr
Changes for v2:
- collect Fabio r-w-b tag

 arch/arm/boot/dts/imx6dl-mamoj.dts | 185 +++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
index 6b2d29138bed..38e94fd11a3f 100644
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
+	display: disp0 {
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
+		pinctrl-0 = <&pinctrl_ipu1_lcdif_pwr>;
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
+			MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04	   0x10 /* VDOUT_RESET */
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
+	pinctrl_ipu1_lcdif_pwr: ipu1lcdifpwrgrp {
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
2.17.1

