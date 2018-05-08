Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbeEHIZl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933184AbeEHIY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:24:59 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 2/3] ARM: dts: tegra: Fix unit_address_vs_reg and avoid_unnecessary_addr_size DTC warnings
Date: Tue,  8 May 2018 10:24:40 +0200
Message-Id: <1525767881-28516-3-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525767881-28516-1-git-send-email-krzk@kernel.org>
References: <1525767881-28516-1-git-send-email-krzk@kernel.org>
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
---
 arch/arm/boot/dts/tegra30-apalis.dtsi  | 4 +---
 arch/arm/boot/dts/tegra30-beaver.dts   | 3 ---
 arch/arm/boot/dts/tegra30-colibri.dtsi | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 184f60c720fa..5038ca7b68af 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -590,8 +590,6 @@
 		/* STMPE811 touch screen controller */
 		stmpe811@41 {
 			compatible = "st,stmpe811";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			reg = <0x41>;
 			interrupts = <TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
 			interrupt-parent = <&gpio>;
@@ -600,7 +598,7 @@
 			blocks = <0x5>;
 			irq-trigger = <0x1>;
 
-			stmpe_touchscreen@0 {
+			stmpe_touchscreen {
 				compatible = "st,stmpe-ts";
 				/* 3.25 MHz ADC clock speed */
 				st,adc-freq = <1>;
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 72369877d284..961934f70639 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -1791,9 +1791,6 @@
 			vccio-supply = <&vdd_5v_in_reg>;
 
 			regulators {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				vdd1_reg: vdd1 {
 					regulator-name = "vddio_ddr_1v2";
 					regulator-min-microvolt = <1200000>;
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index cc46cedf80b9..a593dc8be47f 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -352,8 +352,6 @@
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
