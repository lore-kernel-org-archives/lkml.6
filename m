Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751023AbeCGFAM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 00:00:12 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:32953 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeCGFAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 00:00:09 -0500
X-Google-Smtp-Source: AG47ELvJJeHaJrTQAE6AWheiA35Sg/HOxYlr5+kytdkAQ/PJPW2svfv5Asf5reyPCwcSLR3b+wTVgA==
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-arm-msm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: msm8916: Add cpu cooling maps
Date: Wed,  7 Mar 2018 10:30:02 +0530
Message-Id: <4d134dee2154ae3fa56b375aaed9568e21b1a777.1520398076.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <9f7199f0027ef2382e5ccc61a5118d0a00fa2e63.1520340931.git.amit.kucheria@linaro.org>
References: <9f7199f0027ef2382e5ccc61a5118d0a00fa2e63.1520340931.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1520398076.git.amit.kucheria@linaro.org>
References: <cover.1520398076.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Add cpu cooling maps for cpu passive trip points. The cpu cooling
device states are mapped to cpufreq based scaling frequencies.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e468277..66b318e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/clock/qcom,gcc-msm8916.h>
 #include <dt-bindings/reset/qcom,gcc-msm8916.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM8916";
@@ -115,6 +116,7 @@
 			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs 0>;
 			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		CPU1: cpu@1 {
@@ -126,6 +128,7 @@
 			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs 0>;
 			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		CPU2: cpu@2 {
@@ -137,6 +140,7 @@
 			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs 0>;
 			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		CPU3: cpu@3 {
@@ -148,6 +152,7 @@
 			cpu-idle-states = <&CPU_SPC>;
 			clocks = <&apcs 0>;
 			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		L2_0: l2-cache {
@@ -196,6 +201,13 @@
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu-thermal1 {
@@ -216,6 +228,13 @@
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 	};
-- 
2.7.4
