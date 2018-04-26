Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755454AbeDZKlc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:41:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38853 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755318AbeDZKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:41:27 -0400
X-Google-Smtp-Source: AB8JxZo/DwCyr1JYlF2A9ahYbOSmN0Sy85qr/jo1MsmTqDKUf1DW7pW1ug5lUz3laqLwRq4m1N5BwA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson: add MMC resets
Date: Thu, 26 Apr 2018 12:41:19 +0200
Message-Id: <20180426104119.13659-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset lines to the mmc controllers of the meson gx and axg SoCs

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 854d5b25effd..56c84afb2802 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/axg-clkc.h>
 #include <dt-bindings/gpio/meson-axg-gpio.h>
+#include <dt-bindings/reset/amlogic,meson-axg-reset.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -130,6 +131,7 @@
 					<&clkc CLKID_SD_EMMC_B_CLK0>,
 					<&clkc CLKID_FCLK_DIV2>;
 				clock-names = "core", "clkin0", "clkin1";
+				resets = <&reset RESET_SD_EMMC_B>;
 			};
 
 			sd_emmc_c: mmc@7000 {
@@ -141,6 +143,7 @@
 					<&clkc CLKID_SD_EMMC_C_CLK0>,
 					<&clkc CLKID_FCLK_DIV2>;
 				clock-names = "core", "clkin0", "clkin1";
+				resets = <&reset RESET_SD_EMMC_C>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index c3b8e0d3fbc9..1cbb0829b15d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -715,6 +715,7 @@
 		 <&clkc CLKID_SD_EMMC_A_CLK0>,
 		 <&clkc CLKID_FCLK_DIV2>;
 	clock-names = "core", "clkin0", "clkin1";
+	resets = <&reset RESET_SD_EMMC_A>;
 };
 
 &sd_emmc_b {
@@ -722,6 +723,7 @@
 		 <&clkc CLKID_SD_EMMC_B_CLK0>,
 		 <&clkc CLKID_FCLK_DIV2>;
 	clock-names = "core", "clkin0", "clkin1";
+	resets = <&reset RESET_SD_EMMC_B>;
 };
 
 &sd_emmc_c {
@@ -729,6 +731,7 @@
 		 <&clkc CLKID_SD_EMMC_C_CLK0>,
 		 <&clkc CLKID_FCLK_DIV2>;
 	clock-names = "core", "clkin0", "clkin1";
+	resets = <&reset RESET_SD_EMMC_C>;
 };
 
 &spicc {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 00b5bbd0b3e1..6e4a07112ed8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -724,13 +724,15 @@
 		 <&clkc CLKID_SD_EMMC_A_CLK0>,
 		 <&clkc CLKID_FCLK_DIV2>;
 	clock-names = "core", "clkin0", "clkin1";
+	resets = <&reset RESET_SD_EMMC_A>;
 };
 
 &sd_emmc_b {
 	clocks = <&clkc CLKID_SD_EMMC_B>,
 		 <&clkc CLKID_SD_EMMC_B_CLK0>,
 		 <&clkc CLKID_FCLK_DIV2>;
-       clock-names = "core", "clkin0", "clkin1";
+	clock-names = "core", "clkin0", "clkin1";
+	resets = <&reset RESET_SD_EMMC_B>;
 };
 
 &sd_emmc_c {
@@ -738,6 +740,7 @@
 		 <&clkc CLKID_SD_EMMC_C_CLK0>,
 		 <&clkc CLKID_FCLK_DIV2>;
 	clock-names = "core", "clkin0", "clkin1";
+	resets = <&reset RESET_SD_EMMC_C>;
 };
 
 &spicc {
-- 
2.14.3
