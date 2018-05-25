Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966444AbeEYKfA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:35:00 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32827 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966217AbeEYKck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:32:40 -0400
X-Google-Smtp-Source: AB8JxZrODJkphJZ33ZPhbKXNbFKS4FmXSIqG7JeRZ4tjKmqU9oZkSO+1N7CSKLoVFT4W+Bu+/qNb/g==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] arm: dts: exynos: Add missing cooling device properties for CPUs
Date: Fri, 25 May 2018 16:01:53 +0530
Message-Id: <cfd8de4b2ad1cfd7b0f1a0706c0b6b918e1ebffc.1527244201.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1527244200.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1527244200.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Fix other missing properties (clocks, OPP, clock latency) as well to
make it all work.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi |  9 +++++++++
 arch/arm/boot/dts/exynos5250.dtsi | 23 +++++++++++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 962af97c1883..aff5d66ae058 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -78,6 +78,22 @@
 			compatible = "arm,cortex-a7";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			clocks = <&cmu CLK_ARM_CLK>;
+			clock-names = "cpu";
+			#cooling-cells = <2>;
+
+			operating-points = <
+				1000000 1150000
+				900000  1112500
+				800000  1075000
+				700000  1037500
+				600000  1000000
+				500000  962500
+				400000  925000
+				300000  887500
+				200000  850000
+				100000  850000
+			>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 88fb47cef9a8..b6091c27f155 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -55,6 +55,19 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x901>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+			clock-latency = <160000>;
+
+			operating-points = <
+				1200000 1250000
+				1000000 1150000
+				800000	1075000
+				500000	975000
+				400000	975000
+				200000	950000
+			>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 7b43c10c510b..51f72f0327e5 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -49,21 +49,30 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA01>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu@a02 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA02>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu@a03 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA03>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 2daf505b3d08..69648f83b8b4 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -84,6 +84,29 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1700000000>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+			clock-latency = <140000>;
+
+			operating-points = <
+				1700000 1300000
+				1600000 1250000
+				1500000 1225000
+				1400000 1200000
+				1300000 1150000
+				1200000 1125000
+				1100000 1100000
+				1000000 1075000
+				 900000 1050000
+				 800000 1025000
+				 700000 1012500
+				 600000 1000000
+				 500000  975000
+				 400000  950000
+				 300000  937500
+				 200000  925000
+			>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 
-- 
2.15.0.194.g9af6a3dea062
