Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F1FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E552086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E552086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeH2MKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:34 -0400
Received: from mout.perfora.net ([74.208.4.194]:34891 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727757AbeH2MKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:33 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MQPKk-1gMOcr16xI-00Tn4M; Wed, 29 Aug 2018 10:14:45 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 15/31] ARM: tegra: colibri_t20: add missing pinmux
Date:   Wed, 29 Aug 2018 10:13:51 +0200
Message-Id: <20180829081407.11304-16-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:4UF3p/Ay/FW0rBqrn5bwzhkuROJjUU0ow2EvCxUFmJL9Wq5QmKg
 TMdeAibQN2uCKnRq0OCkdNH6MnY8Xeb5IZBqK1c2mwLATLFfMWgXI/BmLZh8Aa/nYKQByEi
 Xgp7Xfu9u2FvMVWSmks7odqNifdl3RTQZNkVVFISO5K4DC0PkkVs9nUs3C8Y/v7BXnUZYjI
 kOwJsKu7pGGtszuZxIVOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nJ7gIYz2tac=:q1wD45sOM6+cxQkAs4UDvi
 x9CFTt3lTMFqsJgojglbh8PySvofAbZ7FEvqh1rAv2RTPshCkdVTDvljNWafqY5PJCvCic0xF
 htv1nKiW6PAmfiXqNl3TnOd5uh2kUQbzEZxtPMQuGf1XrVZZ5YTQnZxI8Gs/Cgd52Gz6TfVdl
 Vx0UdGJy6b+7Wm1dZY1oj7B+qEMcaNiamGr+BU+Mr3pDrqrjDxfXYumRLJ8aHeTU4R0ayic16
 IkDoMkNTDT04w+ZTHAZSSvKVP7B3pNQi3BAdDW2ciHrLkyd7YXRxaKINZgfoLSyMr+9drfCGJ
 ELQ80+WV/s1w5dTmH/Ko2m2ONtTRGSnTkF8IPrTGDM4dC8hkHJQiJzVT+Ykk6fvtPW/1N4WKu
 vkXnT2oI+rEV0aZaayBuiQ1mULqb6xwA7DLIfgvvvEnEP+0zjHBLiTBcUs2uF8PSwdQz5whSF
 D2k6py2Q2KH/53p97Ky/KKvUGYmsY1drVoWaqWWJeFujyzXrqJn+98C3AH1ff4kXzCYf35kcv
 Cp1mscSf14H8VoXEN/HCw0Odkem3SEcizDGNXzX5Tc+NO0pBqaDSfcn69QUhYutFjeFYaHuqz
 kwO9/fVWfi0feeMDQEw4WM19/M3RNSl6rf4qgHDNctruLwG7QWyW7vwDyCR7uCt16eCr5t8Ol
 GHJV+H/rqZfl5918oCxA/22Wq+T/8EADYDYjnKZYN9tUHRAnKIec0rSk1Zgzmu+aNi7Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Explicitly add pinmux' for all T20 SoC ball groups now:
- Colibri Address/Data Bus (GMI) further pins used as GPIOs
- Colibri BL_ON
- Colibri EXT_IO*
- Colibri L_BIAS, LCD_M1 is muxed with LCD_DE today's display need DE,
  disable LCD_M1
- more Colibri LCD pins (L_* resp. LDD<*>)
- Colibri LCD (Optional 24 BPP Support)
- Colibri MMCCD
- uart_a_dsr and uart_a_dcd as GPIOs
- Colibri USB_CDET
- I2C3 (Optional)
- JTAG_RTCK
- LAN_RESET, LAN_EXT_WAKEUP and LAN_PME (All On-module)
- more NAND pins
- RESET_OUT
- THERMD_ALERT# (On-module), unlatched I2C address pin of LM95245
  temperature sensor therefore requires disabling for now

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts |  40 +++++++++
 arch/arm/boot/dts/tegra20-colibri.dtsi     | 134 +++++++++++++++++++++++++----
 2 files changed, 159 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index f2f01b0d9336..be531d4c2ae8 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -29,6 +29,10 @@
 
 	pinmux@70000014 {
 		state_default: pinmux {
+			bl_on {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
 			ddc {
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
@@ -37,10 +41,38 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
+			i2c {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			lm1 {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
 			mmc {
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
+			mmccd {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			pwm_a_b {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			pwm_c_d {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			ssp {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
 			uart_a {
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
@@ -48,6 +80,14 @@
 			uart_b {
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
+
+			uart_c {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			usbh_pen {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 2e6ecc3040f7..a7403ce9ee99 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -75,20 +75,36 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
-			/* Colibri Address/Data Bus (GMI) */
-			gpio_gmi {
-				nvidia,pins = "ata", "atc", "atd", "ate",
-					"dap1", "dap2", "dap4", "gpu", "irrx",
-					"irtx", "spia", "spib", "spic";
+			/*
+			 * Colibri Address/Data Bus (GMI)
+			 * Note: spid and spie optionally used for SPI1
+			 */
+			gmi {
+				nvidia,pins = "atc", "atd", "ate", "dap1",
+					      "dap2", "dap4", "gmd", "gpu",
+					      "irrx", "irtx", "spia", "spib",
+					      "spic", "spid", "spie", "uca",
+					      "ucb";
 				nvidia,function = "gmi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			/* Further pins may be used as GPIOs */
+			gmi_gpio1 {
+				nvidia,pins = "lpw0", "lsc1", "lsck", "lsda";
+				nvidia,function = "hdmi";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			gmi_gpio2 {
+				nvidia,pins = "lcsn", "ldc", "lm0", "lsdi";
+				nvidia,function = "rsvd4";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
 
 			/* Colibri BL_ON */
 			bl_on {
 				nvidia,pins = "dta";
-				nvidia,function = "vi";
+				nvidia,function = "rsvd1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
@@ -113,8 +129,8 @@
 			 * Note: dtf optionally used for I2C3
 			 */
 			ext_io {
-				nvidia,pins = "dtf";
-				nvidia,function = "i2c3";
+				nvidia,pins = "dtf", "spdi";
+				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
@@ -151,15 +167,31 @@
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
 
+			/*
+			 * Colibri L_BIAS, LCD_M1 is muxed with LCD_DE
+			 * today's display need DE, disable LCD_M1
+			 */
+			lm1 {
+				nvidia,pins = "lm1";
+				nvidia,function = "rsvd3";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* Colibri LCD (L_* resp. LDD<*>) */
 			lcd {
 				nvidia,pins = "ld0", "ld1", "ld2", "ld3",
 					      "ld4", "ld5", "ld6", "ld7",
 					      "ld8", "ld9", "ld10", "ld11",
 					      "ld12", "ld13", "ld14", "ld15",
-					      "ld16", "ld17", "lhs", "lpw0",
-					      "lpw2", "lsc0", "lsc1", "lsck",
-					      "lsda", "lspi", "lvs";
+					      "ld16", "ld17", "lhs", "lsc0",
+					      "lspi", "lvs";
+				nvidia,function = "displaya";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			/* Colibri LCD (Optional 24 BPP Support) */
+			lcd_24 {
+				nvidia,pins = "ldi", "lhp0", "lhp1", "lhp2",
+					      "lpp", "lvp1";
 				nvidia,function = "displaya";
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
@@ -172,6 +204,14 @@
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* Colibri MMCCD */
+			mmccd {
+				nvidia,pins = "gmb";
+				nvidia,function = "gmi_int";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* Colibri MMC (Optional 8-bit) */
 			mmc_8bit {
 				nvidia,pins = "gme";
@@ -220,6 +260,16 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
+			uart_a_dsr {
+				nvidia,pins = "lpw1";
+				nvidia,function = "rsvd3";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			uart_a_dcd {
+				nvidia,pins = "lpw2";
+				nvidia,function = "hdmi";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
 
 			/* Colibri UART-B */
 			uart_b {
@@ -237,12 +287,20 @@
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* Colibri USB_CDET */
+			usb_cdet {
+				nvidia,pins = "spdo";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* Colibri USBH_OC */
 			usbh_oc {
 				nvidia,pins = "spih";
 				nvidia,function = "spi2_alt";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
 
 			/* Colibri USBH_PEN */
@@ -250,7 +308,7 @@
 				nvidia,pins = "spig";
 				nvidia,function = "spi2_alt";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
 
 			/* Colibri VGA not supported */
@@ -261,6 +319,33 @@
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* I2C3 (Optional) */
+			i2c3 {
+				nvidia,pins = "dtf";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* JTAG_RTCK */
+			jtag_rtck {
+				nvidia,pins = "gpu7";
+				nvidia,function = "rtck";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			/*
+			 * LAN_RESET, LAN_EXT_WAKEUP and LAN_PME
+			 * (All On-module)
+			 */
+			gpio_gpv {
+				nvidia,pins = "gpv";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
 			/*
 			 * LAN_V_BUS, VDD_FAULT, BATT_FAULT, WM9712 PENDOWN
 			 * (All On-module); Colibri CAN_INT
@@ -274,7 +359,7 @@
 
 			/* NAND (On-module) */
 			nand {
-				nvidia,pins = "kbca", "kbcc", "kbcd",
+				nvidia,pins = "kbca", "kbcb", "kbcc", "kbcd",
 					      "kbce", "kbcf";
 				nvidia,function = "nand";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -297,6 +382,14 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
+			/* RESET_OUT */
+			reset_out {
+				nvidia,pins = "ata";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
 			/*
 			 * SPI1 (Optional)
 			 * Note: spid and spie used for Colibri Address/Data
@@ -308,6 +401,17 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
+
+			/*
+			 * THERMD_ALERT# (On-module), unlatched I2C address pin
+			 * of LM95245 temperature sensor therefore requires
+			 * disabling for now
+			 */
+			lvp0 {
+				nvidia,pins = "lvp0";
+				nvidia,function = "rsvd3";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
 		};
 	};
 
-- 
2.14.4

