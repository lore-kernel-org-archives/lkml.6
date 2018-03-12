Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750752AbeCLLKc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:10:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34118 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbeCLLK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:10:29 -0400
X-Google-Smtp-Source: AG47ELvBEDiDCTAZKDowRQJEgGOsxkSovU8YZDJJ/QEx935Hunq+mowTqZZkHO986uM2KNkbhxSVXg==
From: Neil Armstrong <narmstrong@baylibre.com>
To: khilman@baylibre.com
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal Lazo <michal.lazo@gmail.com>
Subject: [PATCH] ARM64: dts: meson: bump mali450 clk to 744MHz
Date: Mon, 12 Mar 2018 12:10:21 +0100
Message-Id: <1520853021-5412-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mali-450 IP can run up to 744MHz, bump the frequency using
the GP0 PLL clock.

Cc: Michal Lazo <michal.lazo@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi     | 11 +++++++----
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi | 11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 3290a4dc..6013d32 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -284,14 +284,17 @@
 		 * MALI_0 and MALI_1 muxed to a single clock by a glitch
 		 * free mux to safely change frequency while running.
 		 */
-		assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
+		assigned-clocks = <&clkc CLKID_GP0_PLL>,
+				  <&clkc CLKID_MALI_0_SEL>,
 				  <&clkc CLKID_MALI_0>,
 				  <&clkc CLKID_MALI>; /* Glitch free mux */
-		assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
+		assigned-clock-parents = <0>, /* Do Nothing */
+					 <&clkc CLKID_GP0_PLL>,
 					 <0>, /* Do Nothing */
 					 <&clkc CLKID_MALI_0>;
-		assigned-clock-rates = <0>, /* Do Nothing */
-				       <666666666>,
+		assigned-clock-rates = <744000000>,
+				       <0>, /* Do Nothing */
+				       <744000000>,
 				       <0>; /* Do Nothing */
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
index f06cc234..972df67 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
@@ -30,14 +30,17 @@
 		 * MALI_0 and MALI_1 muxed to a single clock by a glitch
 		 * free mux to safely change frequency while running.
 		 */
-		assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
+		assigned-clocks = <&clkc CLKID_GP0_PLL>,
+				  <&clkc CLKID_MALI_0_SEL>,
 				  <&clkc CLKID_MALI_0>,
 				  <&clkc CLKID_MALI>; /* Glitch free mux */
-		assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
+		assigned-clock-parents = <0>, /* Do Nothing */
+					 <&clkc CLKID_GP0_PLL>,
 					 <0>, /* Do Nothing */
 					 <&clkc CLKID_MALI_0>;
-		assigned-clock-rates = <0>, /* Do Nothing */
-				       <666666666>,
+		assigned-clock-rates = <744000000>,
+				       <0>, /* Do Nothing */
+				       <744000000>,
 				       <0>; /* Do Nothing */
 	};
 };
-- 
2.7.4
