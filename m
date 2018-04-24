Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeDXRru (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752864AbeDXRqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:46:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4696D217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: exynos: Bring order in fixed-regulators naming in Midas boards
Date: Tue, 24 Apr 2018 19:46:01 +0200
Message-Id: <20180424174602.3915-4-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424174602.3915-1-krzk@kernel.org>
References: <20180424174602.3915-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

exynos4412-midas.dtsi is base for galaxy-s3.dtsi and n710x.dts.  All of
them contain fixed regulators named "voltage-regulator-X".  Their
indexes got mixed up while splitting common code in commit c769eaf7a85d
("ARM: dts: exynos: Split Trats2 DTS in preparation for Midas boards").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi | 4 ++--
 arch/arm/boot/dts/exynos4412-midas.dtsi     | 8 ++++----
 arch/arm/boot/dts/exynos4412-n710x.dts      | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
index 31cd5f6fd83c..606946a264da 100644
--- a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
+++ b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
@@ -15,7 +15,7 @@
 		i2c10 = &i2c_cm36651;
 	};
 
-	lcd_vdd3_reg: voltage-regulator-2 {
+	lcd_vdd3_reg: voltage-regulator-6 {
 		compatible = "regulator-fixed";
 		regulator-name = "LCD_VDD_2.2V";
 		regulator-min-microvolt = <2200000>;
@@ -24,7 +24,7 @@
 		enable-active-high;
 	};
 
-	ps_als_reg: voltage-regulator-5 {
+	ps_als_reg: voltage-regulator-7 {
 		compatible = "regulator-fixed";
 		regulator-name = "LED_A_3.0V";
 		regulator-min-microvolt = <3000000>;
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 4b182e26cfc8..dc11ca1673e8 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -55,7 +55,7 @@
 		status = "disabled";
 	};
 
-	cam_af_reg: voltage-regulator-3 {
+	cam_af_reg: voltage-regulator-2 {
 		compatible = "regulator-fixed";
 		regulator-name = "CAM_AF";
 		regulator-min-microvolt = <2800000>;
@@ -64,7 +64,7 @@
 		status = "disabled";
 	};
 
-	vsil12: voltage-regulator-6 {
+	vsil12: voltage-regulator-3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VSIL_1.2V";
 		regulator-min-microvolt = <1200000>;
@@ -74,7 +74,7 @@
 		vin-supply = <&buck7_reg>;
 	};
 
-	vcc33mhl: voltage-regulator-7 {
+	vcc33mhl: voltage-regulator-4 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC_3.3_MHL";
 		regulator-min-microvolt = <3300000>;
@@ -83,7 +83,7 @@
 		enable-active-high;
 	};
 
-	vcc18mhl: voltage-regulator-8 {
+	vcc18mhl: voltage-regulator-5 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC_1.8_MHL";
 		regulator-min-microvolt = <1800000>;
diff --git a/arch/arm/boot/dts/exynos4412-n710x.dts b/arch/arm/boot/dts/exynos4412-n710x.dts
index 36818b1697a4..fe2bfd76cc4e 100644
--- a/arch/arm/boot/dts/exynos4412-n710x.dts
+++ b/arch/arm/boot/dts/exynos4412-n710x.dts
@@ -13,7 +13,7 @@
 
 	/* bootargs are passed in by bootloader */
 
-	cam_vdda_reg: voltage-regulator-9 {
+	cam_vdda_reg: voltage-regulator-6 {
 		compatible = "regulator-fixed";
 		regulator-name = "CAM_SENSOR_CORE_1.2V";
 		regulator-min-microvolt = <1200000>;
-- 
2.14.1
