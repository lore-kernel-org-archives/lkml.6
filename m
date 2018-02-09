Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeBIJA4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:00:56 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39616 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbeBII6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:58:48 -0500
X-Google-Smtp-Source: AH8x227X6JH95STvawxyb/gHhsELsm8R3fvQ0P2DSqO790GHEACTQ4PUeOlvHoqxv9IiY1vJgadb9w==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 03/10] ARM: dts: mt7623: Remove "cooling-{min|max}-level" for CPU nodes
Date: Fri,  9 Feb 2018 14:28:03 +0530
Message-Id: <33d7494641d2f89c827e5e09d1143f125c33e784.1518166039.git.viresh.kumar@linaro.org>
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
 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 4 ----
 arch/arm/boot/dts/mt7623.dtsi                                  | 2 --
 2 files changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
index f6403089edcf..d36f07e0a2bb 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
@@ -21,8 +21,6 @@ Binding for MediaTek's CPUFreq driver
 	       flow is handled by hardware, hence no software "voltage tracking" is
 	       needed.
 - #cooling-cells:
-- cooling-min-level:
-- cooling-max-level:
 	Please refer to Documentation/devicetree/bindings/thermal/thermal.txt
 	for detail.
 
@@ -67,8 +65,6 @@ Binding for MediaTek's CPUFreq driver
 		clock-names = "cpu", "intermediate";
 		operating-points-v2 = <&cpu_opp_table>;
 		#cooling-cells = <2>;
-		cooling-min-level = <0>;
-		cooling-max-level = <7>;
 	};
 	cpu@1 {
 		device_type = "cpu";
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index b750da5362f7..8e7c65464c9d 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -87,8 +87,6 @@
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
-			cooling-min-level = <0>;
-			cooling-max-level = <7>;
 			clock-frequency = <1300000000>;
 		};
 
-- 
2.15.0.194.g9af6a3dea062
