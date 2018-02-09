Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeBII6p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 03:58:45 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36630 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeBII6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:58:42 -0500
X-Google-Smtp-Source: AH8x224huOFFyn7hq/DbHH69ahpactXJNTkHJZhHZAsWvkKSXkkiALfBdI+Pdx0Xv0j7mfv1o58Tgw==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] ARM: dts: exynos: Remove "cooling-{min|max}-level" for CPU nodes
Date: Fri,  9 Feb 2018 14:28:01 +0530
Message-Id: <f808613a9c7a4f23d3a0c64b6f3d4df1b905b16b.1518166039.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "cooling-min-level" and "cooling-max-level" properties are not
parsed by any part of the kernel currently and the max cooling state of
a CPU cooling device is found by referring to the cpufreq table instead.

Remove the unused properties from the CPU nodes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/exynos4210.dtsi      |  2 --
 arch/arm/boot/dts/exynos4412.dtsi      |  2 --
 arch/arm/boot/dts/exynos5250.dtsi      |  2 --
 arch/arm/boot/dts/exynos5420-cpus.dtsi | 16 ----------------
 arch/arm/boot/dts/exynos5422-cpus.dtsi | 16 ----------------
 5 files changed, 38 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index cc978cf28267..58ab34a233da 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -49,8 +49,6 @@
 				400000	975000
 				200000	950000
 			>;
-			cooling-min-level = <4>;
-			cooling-max-level = <2>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index e4ad2fc0329e..5f5cc12f2075 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -42,8 +42,6 @@
 			clocks = <&clock CLK_ARM_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
-			cooling-min-level = <13>;
-			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 56626d1a4235..bb4180ef7885 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -77,8 +77,6 @@
 				 300000  937500
 				 200000  925000
 			>;
-			cooling-min-level = <15>;
-			cooling-max-level = <9>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
 		cpu@1 {
diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
index 123f0cef658d..a8e449471304 100644
--- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
@@ -30,8 +30,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <1024>;
 		};
@@ -43,8 +41,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <1024>;
 		};
@@ -56,8 +52,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <1024>;
 		};
@@ -69,8 +63,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <1024>;
 		};
@@ -83,8 +75,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <539>;
 		};
@@ -96,8 +86,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <539>;
 		};
@@ -109,8 +97,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <539>;
 		};
@@ -122,8 +108,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <539>;
 		};
diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index c593809c7f08..7c130a00d1a8 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -29,8 +29,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <539>;
 		};
@@ -42,8 +40,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <539>;
 		};
@@ -55,8 +51,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <539>;
 		};
@@ -68,8 +62,6 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <539>;
 		};
@@ -82,8 +74,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <15>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <1024>;
 		};
@@ -95,8 +85,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <15>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <1024>;
 		};
@@ -108,8 +96,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <15>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <1024>;
 		};
@@ -121,8 +107,6 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
-			cooling-min-level = <0>;
-			cooling-max-level = <15>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <1024>;
 		};
-- 
2.15.0.194.g9af6a3dea062
