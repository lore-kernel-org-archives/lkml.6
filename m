Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeEQJbT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:31:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35682 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeEQJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:31:16 -0400
X-Google-Smtp-Source: AB8JxZrInNa2CZoU1XCQjlwMQKw1IjlsrjAOr7Ii/FbxIg6gSs7IVlmQn0AlUDkXKBPRWWedCEvvfQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ARM64: dts: meson-axg: clean-up i2c nodes
Date: Thu, 17 May 2018 11:30:57 +0200
Message-Id: <20180517093100.22225-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180517093100.22225-1-jbrunet@baylibre.com>
References: <20180517093100.22225-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove undocumented and unused "clk_i2c" clock name and the second
interrupt from i2c nodes of meson-axg platform. Those seems to have
been copy/pasted from the vendor kernel

Fixes: dc6f858e2690 ("ARM64: dts: meson-axg: add I2C DT info for Meson-AXG SoC")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 37 +++++++++++-------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 381bd2c707a7..b59f341104d7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -214,50 +214,42 @@
 
 			i2c0: i2c@1f000 {
 				compatible = "amlogic,meson-axg-i2c";
-				status = "disabled";
 				reg = <0x0 0x1f000 0x0 0x20>;
-				interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 47 IRQ_TYPE_EDGE_RISING>;
+				interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&clkc CLKID_I2C>;
-				clock-names = "clk_i2c";
+				status = "disabled";
 			};
 
 			i2c1: i2c@1e000 {
 				compatible = "amlogic,meson-axg-i2c";
+				reg = <0x0 0x1e000 0x0 0x20>;
+				interrupts = <GIC_SPI 214 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				reg = <0x0 0x1e000 0x0 0x20>;
 				status = "disabled";
-				interrupts = <GIC_SPI 214 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 48 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc CLKID_I2C>;
-				clock-names = "clk_i2c";
 			};
 
 			i2c2: i2c@1d000 {
 				compatible = "amlogic,meson-axg-i2c";
-				status = "disabled";
 				reg = <0x0 0x1d000 0x0 0x20>;
-				interrupts = <GIC_SPI 215 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 49 IRQ_TYPE_EDGE_RISING>;
+				interrupts = <GIC_SPI 215 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&clkc CLKID_I2C>;
-				clock-names = "clk_i2c";
+				status = "disabled";
 			};
 
 			i2c3: i2c@1c000 {
 				compatible = "amlogic,meson-axg-i2c";
-				status = "disabled";
 				reg = <0x0 0x1c000 0x0 0x20>;
-				interrupts = <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
+				interrupts = <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&clkc CLKID_I2C>;
-				clock-names = "clk_i2c";
+				status = "disabled";
 			};
 
 			uart_A: serial@24000 {
@@ -1116,13 +1108,12 @@
 
 			i2c_AO: i2c@5000 {
 				compatible = "amlogic,meson-axg-i2c";
-				status = "disabled";
 				reg = <0x0 0x05000 0x0 0x20>;
 				interrupts = <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&clkc CLKID_I2C>;
-				clock-names = "clk_i2c";
+				status = "disabled";
 			};
 
 			uart_AO: serial@3000 {
-- 
2.14.3
