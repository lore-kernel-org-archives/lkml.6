Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753919AbeE3QuA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752850AbeE3Qt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:49:58 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: Add missing CPU clocks to secondary CPUs on Exynos542x
Date: Wed, 30 May 2018 18:49:22 +0200
Message-Id: <20180530164922.31851-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Secondary CPUs should have the same information in DeviceTree as booting
CPU from both correctness point of view and for possible hotplug
scenarios.

Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-cpus.dtsi | 6 ++++++
 arch/arm/boot/dts/exynos5422-cpus.dtsi | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
index a8e449471304..0ee6e92a3c29 100644
--- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
@@ -38,6 +38,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x1>;
+			clocks = <&clock CLK_ARM_CLK>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
@@ -49,6 +50,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x2>;
+			clocks = <&clock CLK_ARM_CLK>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
@@ -60,6 +62,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x3>;
+			clocks = <&clock CLK_ARM_CLK>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
@@ -83,6 +86,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
+			clocks = <&clock CLK_KFC_CLK>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
@@ -94,6 +98,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
+			clocks = <&clock CLK_KFC_CLK>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
@@ -105,6 +110,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
+			clocks = <&clock CLK_KFC_CLK>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index 7c130a00d1a8..e4a5857c135f 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -37,6 +37,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
+			clocks = <&clock CLK_KFC_CLK>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
@@ -48,6 +49,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
+			clocks = <&clock CLK_KFC_CLK>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
@@ -59,6 +61,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
+			clocks = <&clock CLK_KFC_CLK>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
@@ -69,8 +72,8 @@
 		cpu4: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
-			clocks = <&clock CLK_ARM_CLK>;
 			reg = <0x0>;
+			clocks = <&clock CLK_ARM_CLK>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
@@ -82,6 +85,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x1>;
+			clocks = <&clock CLK_ARM_CLK>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
@@ -93,6 +97,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x2>;
+			clocks = <&clock CLK_ARM_CLK>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
@@ -104,6 +109,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x3>;
+			clocks = <&clock CLK_ARM_CLK>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-- 
2.14.1
