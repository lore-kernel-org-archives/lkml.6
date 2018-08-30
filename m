Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E973EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9755920645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9755920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeH3IKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 04:10:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42360 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeH3IKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 04:10:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id g23-v6so3249934plq.9;
        Wed, 29 Aug 2018 21:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EoYj1cpTbvhmpbH8N/yv+AYA7x2CQ/7q8geqm55TKmI=;
        b=Tms4l9NFx7jyk8fbnYCT/1bXXJ5qOnThKJzeKXvB+IzBMLRhV+/ySeQjkgAGXSTPc2
         JktU04ZGzSt5EGJuxkVFYd06gBaFL6J272iNNA9ZdH0cQKTv6BQO/aH/2FPqY9W/CdWl
         Suw1rYGlITxmpmZde4Ble7V7gsWL9VvDlKc0PB7gEKqPFGYLEtLqNyYwRl4KnCCm8Jse
         JfpxnzNY1TMUHXSD8ClzAB7IIvvMuAlo+1rSjzG0JCOP1qGWc89PAwfubUFP1h7r/zvj
         jXQUMUqgicU7HZRDIXH/A3ckuAPHcMfjF2yrukRn/aKCknLPAHBqyxN5vTEv/gH0V9Eo
         2otQ==
X-Gm-Message-State: APzg51AIXo1R165/U1U6c2cvLbblJJyZnPVcCdqyhyx2o9wIY9vVkDb9
        XFchIFgIPCIEPpQrZsVoDAAIa8gXpqJOUHzD
X-Google-Smtp-Source: ANB0VdbbJO7sx48rHsPaqG6acpJZnpiD59rDNagaeLFwUHvNfA90OWP3FhHlj9Hp1eEXenFlu9dU7Q==
X-Received: by 2002:a17:902:8a90:: with SMTP id p16-v6mr8626256plo.106.1535602206580;
        Wed, 29 Aug 2018 21:10:06 -0700 (PDT)
Received: from szlin-TW ([122.146.92.136])
        by smtp.gmail.com with ESMTPSA id s14-v6sm11774939pfj.105.2018.08.29.21.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 21:10:06 -0700 (PDT)
Received: from root by szlin-TW with local (Exim 4.91)
        (envelope-from <root@localhost>)
        id 1fvEHU-00065m-Uc; Thu, 30 Aug 2018 12:10:04 +0800
From:   =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= 
        <sz.lin@moxa.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= 
        <sz.lin@moxa.com>, Wes Huang <wes.huang@moxa.com>,
        Fero JD Zhou <FeroJD.Zhou@moxa.com>
Subject: [PATCH 3/3] ARM: dts: am335x: add support for Moxa UC-2102 open platform
Date:   Thu, 30 Aug 2018 12:09:29 +0800
Message-Id: <20180830040929.23357-4-sz.lin@moxa.com>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20180830040929.23357-1-sz.lin@moxa.com>
References: <20180830040929.23357-1-sz.lin@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Moxa UC-2102 open platform

The UC-2102 computing platform is designed for industrial embedded
data acquisition and processing applications.

The features of UC-2102 are:
* eMMC
* SPI flash
* 2x LAN
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
 .../devicetree/bindings/arm/omap/omap.txt     |   2 +-
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/am335x-moxa-uc-2102.dts     | 200 ++++++++++++++++++
 3 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2102.dts

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index c5ca3d6a8099..6876eb8263ed 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -158,7 +158,7 @@ Boards:
   compatible = "phytec,am335x-pcm-953", "phytec,am335x-phycore-som", "ti,am33xx"
 
 - AM335X UC-2100: Wireless-enabled palm-sized industrial computing platform
-  compatible = "moxa,uc-2101", "ti,am33xx"
+  compatible = "moxa,uc-2101", "moxa,uc-2102", "ti,am33xx"
 
 - AM335X UC-8100-ME-T: Communication-centric industrial computing platform
   compatible = "moxa,uc-8100-me-t", "ti,am33xx";
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6167c068601c..15d52cabb1a0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -707,6 +707,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-icev2.dtb \
 	am335x-lxm.dtb \
 	am335x-moxa-uc-2101.dtb \
+	am335x-moxa-uc-2102.dtb \
 	am335x-moxa-uc-8100-me-t.dtb \
 	am335x-nano.dtb \
 	am335x-pdu001.dtb \
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2102.dts b/arch/arm/boot/dts/am335x-moxa-uc-2102.dts
new file mode 100644
index 000000000000..94a7ecc9eb9a
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2102.dts
@@ -0,0 +1,200 @@
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
+	model = "Moxa UC-2102";
+	compatible = "moxa,uc-2102", "ti,am33xx";
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			label = "UC2100:GREEN:USER1";
+			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led2 {
+			label = "UC2100:GREEN:USER2";
+			gpios = <&gpio3 17 GPIO_ACTIVE_HIGH>;
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
+
+			/* Slave 2 */
+			AM33XX_IOPAD(0x870, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* gpmc_wait0.rmii2_crs_dv */
+			AM33XX_IOPAD(0x874, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* gpmc_wpn.rmii2_rxer */
+			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpmc_a0.rmii2_txen */
+			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpmc_a5.rmii2_td0 */
+			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpmc_a4.rmii2_td1 */
+			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* gpmc_a11.rmii2_rd0 */
+			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* gpmc_a10.rmii2_rd1 */
+			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gmii1_col.rmii2_refclk */
+		>;
+	};
+
+	mmc0_pins_default: pinmux_mmc0_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(0x990, PIN_INPUT_PULLUP | MUX_MODE7)	/* mcasp0_aclkx.mmc0_sdcd */
+		>;
+	};
+
+	spi1_pins: pinmux_spi1 {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x964, PIN_INPUT_PULLUP | MUX_MODE4)	/* ecap0_in_pwm0_out.spi1_sclk */
+			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE4)	/* uart1_ctsn.spi1_cs0 */
+			AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE4)	/* uart0_ctsn.spi1_d0 */
+			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE4)	/* uart0_rtsn.spi1_d1 */
+		>;
+	};
+};
+
+&i2c0 {
+	tps: tps@2d {
+		compatible = "ti,tps65910";
+		reg = <0x2d>;
+	};
+};
+
+#include "tps65910.dtsi"
+
+&tps {
+	vcc1-supply = <&vbat>;
+	vcc2-supply = <&vbat>;
+	vcc3-supply = <&vbat>;
+	vcc4-supply = <&vbat>;
+	vcc5-supply = <&vbat>;
+	vcc6-supply = <&vbat>;
+	vcc7-supply = <&vbat>;
+	vccio-supply = <&vbat>;
+
+	regulators {
+		vrtc_reg: regulator@0 {
+			regulator-always-on;
+		};
+
+		vio_reg: regulator@1 {
+			regulator-always-on;
+		};
+
+		vdd1_reg: regulator@2 {
+			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
+			regulator-name = "vdd_mpu";
+			regulator-min-microvolt = <912500>;
+			regulator-max-microvolt = <1378000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vdd2_reg: regulator@3 {
+			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
+			regulator-name = "vdd_core";
+			regulator-min-microvolt = <912500>;
+			regulator-max-microvolt = <1150000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vdd3_reg: regulator@4 {
+			regulator-always-on;
+		};
+
+		vdig1_reg: regulator@5 {
+			regulator-always-on;
+		};
+
+		vdig2_reg: regulator@6 {
+			regulator-always-on;
+		};
+
+		vpll_reg: regulator@7 {
+			regulator-always-on;
+		};
+
+		vdac_reg: regulator@8 {
+			regulator-always-on;
+		};
+
+		vaux1_reg: regulator@9 {
+			regulator-always-on;
+		};
+
+		vaux2_reg: regulator@10 {
+			regulator-always-on;
+		};
+
+		vaux33_reg: regulator@11 {
+			regulator-always-on;
+		};
+
+		vmmc_reg: regulator@12 {
+			compatible = "regulator-fixed";
+			regulator-name = "vmmc_reg";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+};
+
+&mac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cpsw_default>;
+	dual_emac = <1>;
+	status = "okay";
+};
+
+&cpsw_emac0 {
+	status = "okay";
+	phy_id = <&davinci_mdio>, <0x4>;
+	phy-mode = "rmii";
+	dual_emac_res_vlan = <1>;
+};
+
+&cpsw_emac1 {
+	status = "okay";
+	phy_id = <&davinci_mdio>, <0x5>;
+	phy-mode = "rmii";
+	dual_emac_res_vlan = <2>;
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	vmmc-supply = <&vmmcsd_fixed>;
+	bus-width = <4>;
+	pinctrl-0 = <&mmc0_pins_default>;
+	cd-gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
+	wp-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
-- 
2.19.0.rc1

