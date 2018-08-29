Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C17EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C362086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C362086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeH2MKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:41 -0400
Received: from mout.perfora.net ([74.208.4.196]:38723 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeH2MKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:40 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MPFe2-1fzJKt0Jma-004RcM; Wed, 29 Aug 2018 10:14:43 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 14/31] ARM: tegra: colibri_t20: pinmux clean-up
Date:   Wed, 29 Aug 2018 10:13:50 +0200
Message-Id: <20180829081407.11304-15-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:XSJyJ3IYRnVD6afifIm4x2jf39h+H2IW7i6yYB+/B2jEIzpddWn
 hymAuRU5GXJpd1IMZI8HQ95xi+h1BfquidXfwF3SWz6ri0oN7HMRD2I9nsrh+H1TDyjBCVu
 +HBn4q8gVdnbzetj1BE7g20G5sTakHbp3ybGyJLciTwyKIcPPLw4N1FO6eNuojh2ypKYzB1
 iMRfBsGlzTRLf+Mcjj/kg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7KGBCoDph28=:ZRtbJgDSY9fxilWnapzEZ/
 LRfi/gWKPZtPulaGjDNrsJj28HlBeCGq9WDGG3R8gURRqG7dTVtEn6Lpk+Q8HDf/AIMuduo/v
 +e92Gi3kxAit9zHm9uqebLTtwAXK9fopDb9K4SNI6ks0XFACqO7ID+uylwr4/1UJK5I8209Ci
 nEqkVUM5BFP1xvnoGzzA5AFqQELGL2LCwyYRtvp+c/cjoq6X5n1YVvhk3hSTkOlmMjC4YvGoa
 Lm43SZD0KDk6LgXhJoycsRcdCXzbKBwxxTl6xwnAmwGq77INb9sIBGwfeGUToJl0OUexuEV4Q
 AKw+O2aTJkX/dxkBDsVBnY0fMY0D2Mp7Cmq48I23d4FK4biKpgRIQji+6ZNP4DkL5M+oKBLPV
 tgANtzwuJbR1Ln8LrUgg3UjP1QFeiDASEpFudJpDriUvbaFpSBFwpYuENbqOYDv5TTQiHXQjI
 YIN1Fp4HL8dpU4Tq+ux6+x+ciJs8kSQ5LEucvfqiuhFFML1iNNZBaYR3brVXQjv1as+AZfXi4
 onUPBM6kJCgY70WVhSVKdLR2YdT+koVaSlvKzHSVdEcE0ykmSYq8HJ0oPbuCvlvwALU0CvRxG
 G8qCD3mSZSz2pm1zvhW73sGU1w6ETH2/J5sQ70AaW8I65hbALpJ4PX5ln/kc2ywjjcB0VaCcs
 SyR4v5uyNcFVQwFqQ3NQgdmtBFwbXbpMJUj8HxzATK6Y2LonouRs+5xtxYWWAXpHfW0o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Just cosmetic pinmux clean-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts |  10 +-
 arch/arm/boot/dts/tegra20-colibri.dtsi     | 283 ++++++++++++++++++++---------
 2 files changed, 200 insertions(+), 93 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 194f40646a83..f2f01b0d9336 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -29,23 +29,23 @@
 
 	pinmux@70000014 {
 		state_default: pinmux {
-			hdint {
+			ddc {
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
-			i2cddc {
+			hotplug_detect {
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
-			sdio4 {
+			mmc {
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
-			uarta {
+			uart_a {
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
-			uartd {
+			uart_b {
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 		};
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index ba84184e09b8..2e6ecc3040f7 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -29,175 +29,282 @@
 		pinctrl-0 = <&state_default>;
 
 		state_default: pinmux {
+			/* Analogue Audio AC97 to WM9712 (On-module) */
 			audio_refclk {
 				nvidia,pins = "cdev1";
 				nvidia,function = "plla_out";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
-			crt {
-				nvidia,pins = "crtp";
-				nvidia,function = "crt";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
 			dap3 {
 				nvidia,pins = "dap3";
 				nvidia,function = "dap3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
-			displaya {
-				nvidia,pins = "ld0", "ld1", "ld2", "ld3",
-					"ld4", "ld5", "ld6", "ld7", "ld8",
-					"ld9", "ld10", "ld11", "ld12", "ld13",
-					"ld14", "ld15", "ld16", "ld17",
-					"lhs", "lpw0", "lpw2", "lsc0",
-					"lsc1", "lsck", "lsda", "lspi", "lvs";
-				nvidia,function = "displaya";
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			gpio_dte {
-				nvidia,pins = "dte";
-				nvidia,function = "rsvd1";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-			gpio_gmi {
-				nvidia,pins = "ata", "atc", "atd", "ate",
-					"dap1", "dap2", "dap4", "gpu", "irrx",
-					"irtx", "spia", "spib", "spic";
-				nvidia,function = "gmi";
+
+			/*
+			 * AC97_RESET, ULPI_RESET, AC97_INT aka WM9712 GENIRQ
+			 * (All on-module), SODIMM Pin 45 Wakeup
+			 */
+			gpio_uac {
+				nvidia,pins = "uac";
+				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
+
+			/*
+			 * Buffer Enables for nPWE and RDnWR (On-module,
+			 * see GPIO hogging further down below)
+			 */
 			gpio_pta {
 				nvidia,pins = "pta";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
-			gpio_uac {
-				nvidia,pins = "uac";
-				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+
+			/*
+			 * CLK_32K_OUT, CORE_PWR_REQ, CPU_PWR_REQ, PWR_INT_N,
+			 * SYS_CLK_REQ (All on-module)
+			 */
+			pmc {
+				nvidia,pins = "pmc";
+				nvidia,function = "pwr_on";
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
-			hdint {
-				nvidia,pins = "hdint";
-				nvidia,function = "hdmi";
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+
+			/* Colibri Address/Data Bus (GMI) */
+			gpio_gmi {
+				nvidia,pins = "ata", "atc", "atd", "ate",
+					"dap1", "dap2", "dap4", "gpu", "irrx",
+					"irtx", "spia", "spib", "spic";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
-			i2c1 {
-				nvidia,pins = "rm";
-				nvidia,function = "i2c1";
+
+			/* Colibri BL_ON */
+			bl_on {
+				nvidia,pins = "dta";
+				nvidia,function = "vi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			i2c3 {
-				nvidia,pins = "dtf";
-				nvidia,function = "i2c3";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+
+			/* Colibri Backlight PWM<A>, PWM<B> */
+			pwm_a_b {
+				nvidia,pins = "sdc";
+				nvidia,function = "pwm";
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			i2cddc {
+
+			/* Colibri DDC */
+			ddc {
 				nvidia,pins = "ddc";
 				nvidia,function = "i2c2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			i2cp {
-				nvidia,pins = "i2cp";
-				nvidia,function = "i2cp";
+
+			/*
+			 * Colibri EXT_IO*
+			 * Note: dtf optionally used for I2C3
+			 */
+			ext_io {
+				nvidia,pins = "dtf";
+				nvidia,function = "i2c3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			irda {
-				nvidia,pins = "uad";
-				nvidia,function = "irda";
+
+			/*
+			 * Colibri Ethernet (On-module)
+			 * ULPI EHCI instance 1 USB2_DP/N -> AX88772B
+			 */
+			ulpi {
+				nvidia,pins = "uaa", "uab", "uda";
+				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
-			nand {
-				nvidia,pins = "kbca", "kbcc", "kbcd",
-					"kbce", "kbcf";
-				nvidia,function = "nand";
+			ulpi_refclk {
+				nvidia,pins = "cdev2";
+				nvidia,function = "pllp_out4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
-			owc {
-				nvidia,pins = "owc";
-				nvidia,function = "owr";
+
+			/* Colibri HOTPLUG_DETECT (HDMI) */
+			hotplug_detect {
+				nvidia,pins = "hdint";
+				nvidia,function = "hdmi";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Colibri I2C */
+			i2c {
+				nvidia,pins = "rm";
+				nvidia,function = "i2c1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			pmc {
-				nvidia,pins = "pmc";
-				nvidia,function = "pwr_on";
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+
+			/* Colibri LCD (L_* resp. LDD<*>) */
+			lcd {
+				nvidia,pins = "ld0", "ld1", "ld2", "ld3",
+					      "ld4", "ld5", "ld6", "ld7",
+					      "ld8", "ld9", "ld10", "ld11",
+					      "ld12", "ld13", "ld14", "ld15",
+					      "ld16", "ld17", "lhs", "lpw0",
+					      "lpw2", "lsc0", "lsc1", "lsck",
+					      "lsda", "lspi", "lvs";
+				nvidia,function = "displaya";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			pwm {
-				nvidia,pins = "sdb", "sdc", "sdd";
-				nvidia,function = "pwm";
+
+			/* Colibri MMC */
+			mmc {
+				nvidia,pins = "atb", "gma";
+				nvidia,function = "sdio4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			sdio4 {
-				nvidia,pins = "atb", "gma", "gme";
+
+			/* Colibri MMC (Optional 8-bit) */
+			mmc_8bit {
+				nvidia,pins = "gme";
 				nvidia,function = "sdio4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			spi1 {
-				nvidia,pins = "spid", "spie", "spif";
-				nvidia,function = "spi1";
+
+			/*
+			 * Colibri Parallel Camera (Optional)
+			 * pins multiplexed with others and therefore disabled
+			 * Note: dta used for BL_ON by default
+			 */
+			cif_mclk {
+				nvidia,pins = "csus";
+				nvidia,function = "vi_sensor_clk";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			spi4 {
+			cif {
+				nvidia,pins = "dtb", "dtc", "dtd";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Colibri PWM<C>, PWM<D> */
+			pwm_c_d {
+				nvidia,pins = "sdb", "sdd";
+				nvidia,function = "pwm";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Colibri SSP */
+			ssp {
 				nvidia,pins = "slxa", "slxc", "slxd", "slxk";
 				nvidia,function = "spi4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			uarta {
+
+			/* Colibri UART-A */
+			uart_a {
 				nvidia,pins = "sdio1";
 				nvidia,function = "uarta";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			uartd {
+
+			/* Colibri UART-B */
+			uart_b {
 				nvidia,pins = "gmc";
 				nvidia,function = "uartd";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			ulpi {
-				nvidia,pins = "uaa", "uab", "uda";
-				nvidia,function = "ulpi";
+
+			/* Colibri UART-C */
+			uart_c {
+				nvidia,pins = "uad";
+				nvidia,function = "irda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			ulpi_refclk {
-				nvidia,pins = "cdev2";
-				nvidia,function = "pllp_out4";
+
+			/* Colibri USBH_OC */
+			usbh_oc {
+				nvidia,pins = "spih";
+				nvidia,function = "spi2_alt";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
-			usb_gpio {
-				nvidia,pins = "spig", "spih";
+
+			/* Colibri USBH_PEN */
+			usbh_pen {
+				nvidia,pins = "spig";
 				nvidia,function = "spi2_alt";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
-			vi {
-				nvidia,pins = "dta", "dtb", "dtc", "dtd";
-				nvidia,function = "vi";
+
+			/* Colibri VGA not supported */
+			vga {
+				nvidia,pins = "crtp";
+				nvidia,function = "crt";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			vi_sc {
-				nvidia,pins = "csus";
-				nvidia,function = "vi_sensor_clk";
+
+			/*
+			 * LAN_V_BUS, VDD_FAULT, BATT_FAULT, WM9712 PENDOWN
+			 * (All On-module); Colibri CAN_INT
+			 */
+			gpio_dte {
+				nvidia,pins = "dte";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* NAND (On-module) */
+			nand {
+				nvidia,pins = "kbca", "kbcc", "kbcd",
+					      "kbce", "kbcf";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Onewire (Optional) */
+			owr {
+				nvidia,pins = "owc";
+				nvidia,function = "owr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Power I2C (On-module) */
+			i2cp {
+				nvidia,pins = "i2cp";
+				nvidia,function = "i2cp";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/*
+			 * SPI1 (Optional)
+			 * Note: spid and spie used for Colibri Address/Data
+			 *       Bus (GMI)
+			 */
+			spi1 {
+				nvidia,pins = "spid", "spie", "spif";
+				nvidia,function = "spi1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-- 
2.14.4

