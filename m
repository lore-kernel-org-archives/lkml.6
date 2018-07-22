Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99390ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C14320874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C14320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbeGVRrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:45 -0400
Received: from mout.perfora.net ([74.208.4.197]:45943 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbeGVRro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:44 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MWAcp-1fWaBB2xhp-00XLOw; Sun, 22 Jul 2018 18:50:21 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 18/28] ARM: tegra: apalis_t30: pinmux clean-up
Date:   Sun, 22 Jul 2018 18:49:26 +0200
Message-Id: <20180722164936.20581-19-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:XMU/whhvpMqWslFETym0q1O9fHLfxeaW1jsUQDYWDx/yRiW1uKk
 WtUIDiTGzsqUezimZQVOLrF+1ns0n13ew92tPt3eNyZb/bur2EJMpeVgHuPxQE9HrzKQcp9
 rnDrg0CPlAiazzhnYuGKh9p9CTA4Y4nM2YC180g2BaMtYWaMeKDNXqWYOldf4Bh2SiVz5Le
 d8U0MBCz0R1ZVrnVD0AXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M/fMYtOVZas=:3J3uSQAvtLibrSqJ93x9X3
 H1fMf7CwPe7oSFpwIVTU1Przl+Q7iz11N0ACdyd8eRyv6KPkHHc/3NuNokNUhlAWRqSe2u0y2
 zhdlxTtKeq0Qc0P+Ywclgi8I+Bnx4bp3otXfA5Q0366fEkxwZPKyRCmXjL+psPD9tpzwKQt+/
 d/bA3vS5rMu/IVO6uBAx+3Iuth3sK2KUOrNuwBPZb5FrQph5CAcq2YINmpn5ag3ikFfBrOldO
 v33Vh4H62Fbt19FpVyd9O21iQxIcztegQLd9xF3oPoeMlyPMBVBjPhWnONRLP8M9YbIU9Npx+
 sUwuo1aly6VVByNeztqkCx7u2O9lg6mrs+RtfokczAjUUv/r85QZkSjBjGmRS43noyEF9SlpY
 A9U5P0uozL+rzQelZcEPzy3Q8ztNIJckXYsfyi1kNSjiakPvC32PL+1ppIOWcI0K0RS8c8Ca6
 6sdai72QdpI9ZS92Q4F7kuw5WrVfQgM+/DWl26WREEb57XEX8mgH1e1124Ax468stFt1SUun7
 oIQN8p9tDRj4nBUYvNiU7ScC3FW7Ht1yZthUhZdW9gCnn6Utl4JF3olYQvqkYEkkNh4kW954+
 qxKZjn9Ti39hAq8hk4XQN8nBnXBk9otdaPqTAoSzLEwMZJXQgUJtbM7i//MuwPdJILN/kcNFf
 GR2bhH1nmPvnizUaodNOg0OWRHzmfyKHfhukkQBZ8BuTajR4fCNR0V5Jgg21+6ZtthN8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Clean-up pinmuxing:
- white-space clean-up
- explicitly disable input of BKL1_PWM and BKL1_PWM_EN#
- annotate Apalis I2C3 usage for CAM
- get rid of nvidia,lock property
- add missing eMMC sdmmc4_cmd_pt7 and explicitly enable input
- explicitly disable lcd_dc1_pd2 (e.g. LM95245 I2C address pin)
- annotate TOUCH_PEN_INT# being on-module

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index ef181d13be31..ac87eeebab03 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -68,10 +68,10 @@
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap3_fs_pp0 {
-				nvidia,pins =	"dap3_fs_pp0",
-						"dap3_sclk_pp3",
-						"dap3_din_pp1",
-						"dap3_dout_pp2";
+				nvidia,pins = "dap3_fs_pp0",
+					      "dap3_sclk_pp3",
+					      "dap3_din_pp1",
+					      "dap3_dout_pp2";
 				nvidia,function = "i2s2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -91,6 +91,7 @@
 				nvidia,function = "pwm0";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			/* BKL1_PWM_EN#, disable TPS65911 PMIC PWM backlight */
 			uart3_cts_n_pa1 {
@@ -98,6 +99,7 @@
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* Apalis CAN1 on SPI6 */
@@ -163,7 +165,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
-			/* Apalis I2C3 */
+			/* Apalis I2C3 (CAM) */
 			cam_i2c_scl_pbb1 {
 				nvidia,pins = "cam_i2c_scl_pbb1",
 					      "cam_i2c_sda_pbb2";
@@ -171,7 +173,6 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <TEGRA_PIN_DISABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
 
@@ -368,10 +369,12 @@
 			/* eMMC (On-module) */
 			sdmmc4_clk_pcc4 {
 				nvidia,pins = "sdmmc4_clk_pcc4",
+					      "sdmmc4_cmd_pt7",
 					      "sdmmc4_rst_n_pcc3";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			sdmmc4_dat0_paa0 {
 				nvidia,pins = "sdmmc4_dat0_paa0",
@@ -385,6 +388,7 @@
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
 			/* LVDS Transceiver Configuration */
@@ -397,7 +401,6 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
-				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			pbb3 {
 				nvidia,pins = "pbb3",
@@ -408,7 +411,6 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
-				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* Power I2C (On-module) */
@@ -419,7 +421,6 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <TEGRA_PIN_DISABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
 
@@ -431,12 +432,12 @@
 			lcd_dc1_pd2 {
 				nvidia,pins = "lcd_dc1_pd2";
 				nvidia,function = "rsvd3";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 
-			/* TOUCH_PEN_INT# */
+			/* TOUCH_PEN_INT# (On-module) */
 			pv0 {
 				nvidia,pins = "pv0";
 				nvidia,function = "rsvd1";
-- 
2.14.4

