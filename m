Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B99C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB092172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB092172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbeI1RLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:11:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40393 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbeI1RLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:11:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so4190227pgm.7;
        Fri, 28 Sep 2018 03:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YoQb1Fg1yj91FsM5nm90qqgp+JBR3bZInFkTKyJvtBE=;
        b=hvychTvM6+J4tR6Bn0OisAIVJItDC4bVZUoMgcrdZy5vfJMSYhVTrLLulAs9Cv3l1x
         Do7fAOZFHQsH1eCzxyEGViv4GuEQGf3KU4TtodzbYKHteN9ylvtw2/TUrm/mNKotOASW
         rAOvjicBkMZdFOwOY5efYMqXyEXAN1IjFJCM9CD5kxfI8lJJQzZABpQDnQsm6ZKIQE5I
         tQYCU8oZpdCJuKbHjcowAHoNUT/jq9c9mWwPhFYY2P+w3dSjhADgsDFrLeBnV67UFYZa
         RSQ7LG5vkOurZ5RaL2ly8W0ehueZpi8ewqsHqATQpsNTMzXijTv9Rhkxzr0pk8CZTuo/
         QlGg==
X-Gm-Message-State: ABuFfojz9tFu9nEYY8+l4JCMS+YeP6SV0z03Ss0DXFcbjJJPtsug7/Z0
        iAOybVZxNffTxz4JH96/O+mpKBUVLSptCA==
X-Google-Smtp-Source: ACcGV60JlyrS6qnTM+UiFDJq5U8nTdjiTxFiypXadn4eDJGhO4M/O+ZYrC/JFm289Ij/uCeTENIv0g==
X-Received: by 2002:a63:225a:: with SMTP id t26-v6mr5254976pgm.275.1538131681681;
        Fri, 28 Sep 2018 03:48:01 -0700 (PDT)
Received: from szlin-TW ([122.146.92.136])
        by smtp.gmail.com with ESMTPSA id s85-v6sm10774409pfi.15.2018.09.28.03.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 03:48:01 -0700 (PDT)
Received: from root by szlin-TW with local (Exim 4.91)
        (envelope-from <root@localhost>)
        id 1g5qJU-00082j-6P; Fri, 28 Sep 2018 18:48:00 +0800
From:   =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= 
        <sz.lin@moxa.com>
Cc:     =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= 
        <sz.lin@moxa.com>, Wes Huang <wes.huang@moxa.com>,
        Fero JD Zhou <FeroJD.Zhou@moxa.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v2 3/3] ARM: dts: am335x: add support for Moxa UC-2101 open platform
Date:   Fri, 28 Sep 2018 18:47:52 +0800
Message-Id: <20180928104754.30866-1-sz.lin@moxa.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Moxa UC-2101 open platform

The UC-2101 computing platform is designed for industrial embedded
data acquisition and processing applications.

The features of UC-2101 are:
* eMMC
* SPI flash
* 1x LAN
* 1x RS-232/422/485 ports, software-selectable
* EEPROM
* TPM 2.0
* Watchdog
* RTC
* User gpio-keys
* User LEDs
* User button

Signed-off-by: Wes Huang (黃淵河) <wes.huang@moxa.com>
Signed-off-by: Fero JD Zhou (周俊達) <FeroJD.Zhou@moxa.com>
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
---
Changes from v1:
- Use property phy-handle instead of phy_id

 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts | 69 +++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2101.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fb548cf161e0..95def61bd21a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -710,6 +710,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-evmsk.dtb \
 	am335x-icev2.dtb \
 	am335x-lxm.dtb \
+	am335x-moxa-uc-2101.dtb \
 	am335x-moxa-uc-8100-me-t.dtb \
 	am335x-nano.dtb \
 	am335x-pdu001.dtb \
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2101.dts b/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
new file mode 100644
index 000000000000..48aee6de4cdb
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 MOXA Inc. - https://www.moxa.com/
+ *
+ * Authors: SZ Lin (林上智) <sz.lin@moxa.com>
+ *          Wes Huang (黃淵河) <wes.huang@moxa.com>
+ *          Fero JD Zhou (周俊達) <FeroJD.Zhou@moxa.com>
+ */
+
+/dts-v1/;
+
+#include "am335x-moxa-uc-2100-common.dtsi"
+
+/ {
+	model = "Moxa UC-2101";
+	compatible = "moxa,uc-2101", "ti,am33xx";
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			label = "UC2100:GREEN:USER";
+			gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+};
+
+&am33xx_pinmux {
+	pinctrl-names = "default";
+
+	cpsw_default: cpsw_default {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
+			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txen.rmii1_txen */
+			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
+			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mii1_refclk.rmii1_refclk */
+		>;
+	};
+
+	spi1_pins: pinmux_spi1 {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x964, PIN_INPUT_PULLUP | MUX_MODE4)	 /* ecap0_in_pwm0_out.spi1_sclk */
+			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE4)	 /* uart1_ctsn.spi1_cs0 */
+			AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE4)	 /* uart0_ctsn.spi1_d0 */
+			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE4)	 /* uart0_rtsn.spi1_d1 */
+		>;
+	};
+};
+
+&davinci_mdio {
+	phy0: ethernet-phy@4 {
+		reg = <4>;
+	};
+};
+
+&cpsw_emac0 {
+	status = "okay";
+	phy-handle = <&phy0>;
+	phy-mode = "rmii";
+};
+
+&cpsw_emac1 {
+	status = "disabled";
+};
-- 
2.19.0

