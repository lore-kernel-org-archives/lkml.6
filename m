Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A77C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FFA20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FFA20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeIBOZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:05 -0400
Received: from mout.perfora.net ([74.208.4.194]:34161 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbeIBOZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:04 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LfRRn-1fXkoY2pCL-00owCo; Sun, 02 Sep 2018 12:09:44 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 14/37] ARM: tegra: colibri_t20: pinmux clean-up
Date:   Sun,  2 Sep 2018 12:08:43 +0200
Message-Id: <20180902100906.25792-15-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:G0r4HRny+T17/aP0J6dR4dywZjbRE/6Jlj9FFvIREeSxJxUmKoa
 5Mpp1Uuoy9CL4URiVJyJgfQoZ508CD8LUfjYbqIYGqG3LruDbCedrWhnmM0RdBOkHx4+2nJ
 JGfXQ29K2oT4qo6GKM6DFJd/XYK2URe28x+8KcuV6aYOWWveJ5g2T5+ce9MwnGMBVDxLodY
 1ZNxlmJVZrCFwACrORDIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Umgui8BdJxI=:aGSPfyw0hqDoMONSLQU8Ny
 QdoxQ/o9J3F09ANhaviaVLcQtXEn1QrUlNh+n2LBbC3y6ugRZJ9y/Az0ngVZ1Ug3djyW2Hu7d
 zNb49QFOc8UQ72yRaJdSPKyDTvoeoztvm/rxiBOY/9L5TIYeIHAs7eAMDsurgjiIuzQEn8nnC
 7dkxurFtLQIoqdwPB7mFCv0BPx4P8bjv4T/PHCYrXGdL0Hp/jxdPgSM0dQkLuGQrSybwMUvGa
 K4SuCfhVq3dbGT+KexTeubiV7QRjazpsTfe1DMdhSwtI04dnGldYJF4nwjU5MqXn/vG4Dc85H
 SvHBpyJ5MXN9EtAL8e1vCPzNIgPNQ9vAtpJvX/Zm0JjjECaPIN1Ll+KBZueXyIl69402MeMZC
 LsXcoGYNg3pREPIK9q8mVlDFNF1sXU4PYexKm/7HewV/4R5BuYI1mNWhmEMalkgEYHKV//pX+
 CSzMyy1tL0YpkWcX4zWCyOU8acTGLSeimYj/hDjW9v7gDJzCA4m9vJr9Rm7zsWYwkEBjcgdKl
 9C6VK365SoQ5L7xZfk1QgUt13oFoZqezZkE2qqj7V08i5BdRyvvOBVjGlQPsbNjhat+bcQ1Bt
 KDT2yjKvBQmVgeqSKSqJaVJ3g+yKeoq8OogW4ro9b3Sxc7wJhA0P/YvuZZE+uPFpWUG1Q8hjP
 EMnYI8+24SSU9lznsyJkZnmNyCKHNQAVcD8pY/lPRbmpITZb52hjY0Nx+mNte5NUiTh4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Just cosmetic pinmux clean-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Also replace underscores in node names with dashes.

 arch/arm/boot/dts/tegra20-colibri-iris.dts |  10 +-
 arch/arm/boot/dts/tegra20-colibri.dtsi     | 287 ++++++++++++++++++++---------
 2 files changed, 202 insertions(+), 95 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 194f40646a83..e026478b58d0 100644
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
+			hotplug-detect {
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
-			sdio4 {
+			mmc {
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
-			uarta {
+			uart-a {
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
-			uartd {
+			uart-b {
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 		};
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index ba84184e09b8..dfe237cea14b 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -29,175 +29,282 @@
 		pinctrl-0 = <&state_default>;
 
 		state_default: pinmux {
-			audio_refclk {
+			/* Analogue Audio AC97 to WM9712 (On-module) */
+			audio-refclk {
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
+			gpio-uac {
+				nvidia,pins = "uac";
+				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
-			gpio_pta {
+
+			/*
+			 * Buffer Enables for nPWE and RDnWR (On-module,
+			 * see GPIO hogging further down below)
+			 */
+			gpio-pta {
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
+			gpio-gmi {
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
+			bl-on {
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
+			pwm-a-b {
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
+			ext-io {
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
+			ulpi-refclk {
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
+			hotplug-detect {
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
+			mmc-8bit {
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
+			cif-mclk {
+				nvidia,pins = "csus";
+				nvidia,function = "vi_sensor_clk";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			cif {
+				nvidia,pins = "dtb", "dtc", "dtd";
+				nvidia,function = "vi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			spi4 {
+
+			/* Colibri PWM<C>, PWM<D> */
+			pwm-c-d {
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
+			uart-a {
 				nvidia,pins = "sdio1";
 				nvidia,function = "uarta";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 			};
-			uartd {
+
+			/* Colibri UART-B */
+			uart-b {
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
+			uart-c {
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
+			usbh-oc {
+				nvidia,pins = "spih";
+				nvidia,function = "spi2_alt";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
-			usb_gpio {
-				nvidia,pins = "spig", "spih";
+
+			/* Colibri USBH_PEN */
+			usbh-pen {
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
+			gpio-dte {
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

