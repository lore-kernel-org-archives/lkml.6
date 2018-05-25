Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964924AbeEYFkj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 01:40:39 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43761 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964843AbeEYFkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 01:40:36 -0400
X-Google-Smtp-Source: AB8JxZqQvx7ZPxB0+w/Uda7JoocJ4n/rtP/WB+5Wk8ubJo6ybyo1ofKvjinV3D4YoQ6LiHlUtLNrog==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] arm64: dts: freescale: Add missing cooling device properties for CPUs
Date: Fri, 25 May 2018 11:10:02 +0530
Message-Id: <e4504945d2b684fae2850bbcf03a6d02917a8c8a.1527225682.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1527225682.git.viresh.kumar@linaro.org>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1527225682.git.viresh.kumar@linaro.org>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
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

Do minor rearrangement as well to keep ordering consistent.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 5 ++++-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi | 4 ++++
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 1109f22bda5e..630ee47441f2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -80,8 +80,8 @@
 			reg = <0x0>;
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
-			#cooling-cells = <2>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -91,6 +91,7 @@
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -100,6 +101,7 @@
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -109,6 +111,7 @@
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		l2: l2-cache {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 136ebfa9b333..ee7beab8bfae 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -87,6 +87,7 @@
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -96,6 +97,7 @@
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -105,6 +107,7 @@
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		l2: l2-cache {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 1c6556bcfddf..e64823a25158 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -76,6 +76,7 @@
 			reg = <0x1>;
 			clocks = <&clockgen 1 0>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -84,6 +85,7 @@
 			reg = <0x2>;
 			clocks = <&clockgen 1 0>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -92,6 +94,7 @@
 			reg = <0x3>;
 			clocks = <&clockgen 1 0>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		cpu4: cpu@100 {
@@ -109,6 +112,7 @@
 			reg = <0x101>;
 			clocks = <&clockgen 1 1>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		cpu6: cpu@102 {
@@ -117,6 +121,7 @@
 			reg = <0x102>;
 			clocks = <&clockgen 1 1>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		cpu7: cpu@103 {
@@ -125,6 +130,7 @@
 			reg = <0x103>;
 			clocks = <&clockgen 1 1>;
 			cpu-idle-states = <&CPU_PH20>;
+			#cooling-cells = <2>;
 		};
 
 		CPU_PH20: cpu-ph20 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 8d739301e7b8..c264b6d1bd7f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -65,6 +65,7 @@
 		clocks = <&clockgen 1 0>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster0_l2>;
+		#cooling-cells = <2>;
 	};
 
 	cpu2: cpu@100 {
@@ -84,6 +85,7 @@
 		clocks = <&clockgen 1 1>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster1_l2>;
+		#cooling-cells = <2>;
 	};
 
 	cpu4: cpu@200 {
@@ -103,6 +105,7 @@
 		clocks = <&clockgen 1 2>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster2_l2>;
+		#cooling-cells = <2>;
 	};
 
 	cpu6: cpu@300 {
@@ -122,6 +125,7 @@
 		clocks = <&clockgen 1 3>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster3_l2>;
+		#cooling-cells = <2>;
 	};
 
 	cluster0_l2: l2-cache0 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
index 0884e1a77901..b6ea9e96c866 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
@@ -65,6 +65,7 @@
 		clocks = <&clockgen 1 0>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster0_l2>;
+		#cooling-cells = <2>;
 	};
 
 	cpu2: cpu@100 {
@@ -84,6 +85,7 @@
 		clocks = <&clockgen 1 1>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster1_l2>;
+		#cooling-cells = <2>;
 	};
 
 	cpu4: cpu@200 {
@@ -103,6 +105,7 @@
 		clocks = <&clockgen 1 2>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster2_l2>;
+		#cooling-cells = <2>;
 	};
 
 	cpu6: cpu@300 {
@@ -122,6 +125,7 @@
 		clocks = <&clockgen 1 3>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster3_l2>;
+		#cooling-cells = <2>;
 	};
 
 	cluster0_l2: l2-cache0 {
-- 
2.15.0.194.g9af6a3dea062
