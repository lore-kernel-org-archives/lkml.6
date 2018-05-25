Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeEYFl3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 01:41:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40305 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964875AbeEYFki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 01:40:38 -0400
X-Google-Smtp-Source: AB8JxZowNq3p9ne9ohdsFwaUUuz1AyYWQyCLD5huuNJj6RR+m1pOGSspS2BBembp56G207DyPBd+Kg==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arm@kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: hisilicon: Add missing cooling device properties for CPUs
Date: Fri, 25 May 2018 11:10:03 +0530
Message-Id: <0754957a2c3842cf4e36fa27231d327fd8d6d499.1527225682.git.viresh.kumar@linaro.org>
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
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 586b281cd531..247024df714f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -88,8 +88,8 @@
 			next-level-cache = <&CLUSTER0_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			#cooling-cells = <2>; /* min followed by max */
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
 		};
 
@@ -101,6 +101,8 @@
 			next-level-cache = <&CLUSTER0_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			#cooling-cells = <2>; /* min followed by max */
+			dynamic-power-coefficient = <311>;
 		};
 
 		cpu2: cpu@2 {
@@ -111,6 +113,8 @@
 			next-level-cache = <&CLUSTER0_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			#cooling-cells = <2>; /* min followed by max */
+			dynamic-power-coefficient = <311>;
 		};
 
 		cpu3: cpu@3 {
@@ -121,6 +125,8 @@
 			next-level-cache = <&CLUSTER0_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			#cooling-cells = <2>; /* min followed by max */
+			dynamic-power-coefficient = <311>;
 		};
 
 		cpu4: cpu@100 {
@@ -131,6 +137,8 @@
 			next-level-cache = <&CLUSTER1_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			#cooling-cells = <2>; /* min followed by max */
+			dynamic-power-coefficient = <311>;
 		};
 
 		cpu5: cpu@101 {
@@ -141,6 +149,8 @@
 			next-level-cache = <&CLUSTER1_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			#cooling-cells = <2>; /* min followed by max */
+			dynamic-power-coefficient = <311>;
 		};
 
 		cpu6: cpu@102 {
@@ -151,6 +161,8 @@
 			next-level-cache = <&CLUSTER1_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			#cooling-cells = <2>; /* min followed by max */
+			dynamic-power-coefficient = <311>;
 		};
 
 		cpu7: cpu@103 {
@@ -161,6 +173,8 @@
 			next-level-cache = <&CLUSTER1_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			#cooling-cells = <2>; /* min followed by max */
+			dynamic-power-coefficient = <311>;
 		};
 
 		CLUSTER0_L2: l2-cache0 {
-- 
2.15.0.194.g9af6a3dea062
