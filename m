Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932447AbeEWJ5q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932272AbeEWJ5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:57:02 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v6 3/4] ARM: dts: tegra: Fix unit_address_vs_reg and avoid_unnecessary_addr_size DTC warnings
Date: Wed, 23 May 2018 11:56:45 +0200
Message-Id: <1527069406-6359-3-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527069406-6359-1-git-send-email-krzk@kernel.org>
References: <1527069406-6359-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded address/size cells properties and unit addresses to fix
DTC warnings like:

    arch/arm/boot/dts/tegra30-apalis-eval.dtb: Warning (unit_address_vs_reg):
        /i2c@7000d000/stmpe811@41/stmpe_touchscreen@0: node has a unit name, but no reg property
    arch/arm/boot/dts/tegra30-apalis-eval.dtb: Warning (avoid_unnecessary_addr_size):
        /i2c@7000d000/stmpe811@41: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Stefan Agner <stefan@agner.ch>

---

Changes since v5:
1. Add Stefan's reviewed-by tag.

Changes since v4:
1. None
---
 arch/arm/boot/dts/tegra30-apalis.dtsi  | 4 +---
 arch/arm/boot/dts/tegra30-beaver.dts   | 3 ---
 arch/arm/boot/dts/tegra30-colibri.dtsi | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 9465fc592b7b..d1a2c0a253c8 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -589,8 +589,6 @@
 		/* STMPE811 touch screen controller */
 		stmpe811@41 {
 			compatible = "st,stmpe811";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			reg = <0x41>;
 			interrupts = <TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
 			interrupt-parent = <&gpio>;
@@ -599,7 +597,7 @@
 			blocks = <0x5>;
 			irq-trigger = <0x1>;
 
-			stmpe_touchscreen@0 {
+			stmpe_touchscreen {
 				compatible = "st,stmpe-ts";
 				/* 3.25 MHz ADC clock speed */
 				st,adc-freq = <1>;
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 1434d50438f9..b0d40ac8ac6e 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -1790,9 +1790,6 @@
 			vccio-supply = <&vdd_5v_in_reg>;
 
 			regulators {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				vdd1_reg: vdd1 {
 					regulator-name = "vddio_ddr_1v2";
 					regulator-min-microvolt = <1200000>;
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 9bf3327665d3..526ed71cf7a3 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -351,8 +351,6 @@
 		/* STMPE811 touch screen controller */
 		stmpe811@41 {
 			compatible = "st,stmpe811";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			reg = <0x41>;
 			interrupts = <TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
 			interrupt-parent = <&gpio>;
-- 
2.7.4
