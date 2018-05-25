Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935834AbeEYFkr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 01:40:47 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45122 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964947AbeEYFkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 01:40:41 -0400
X-Google-Smtp-Source: AB8JxZoSP6rImsMhyfLPu5Xqwj67+tfYu3iSa15W0cfqWblqEaDdplaOK73Ejw3UfR3sGneABlU9bg==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arm@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arm64: dts: mediatek: Add missing cooling device properties for CPUs
Date: Fri, 25 May 2018 11:10:04 +0530
Message-Id: <49b1086c104b0ee22f6e992a0abb380de9320c09.1527225682.git.viresh.kumar@linaro.org>
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

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 9213c966c224..d49fe125e770 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -89,6 +89,7 @@
 				 <&apmixedsys CLK_APMIXED_MAIN_CORE_EN>;
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			clock-frequency = <1300000000>;
 		};
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 94597e33c806..abd2f15a544b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -168,6 +168,7 @@
 			reg = <0x001>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			#cooling-cells = <2>;
 			clocks = <&infracfg CLK_INFRA_CA53SEL>,
 				 <&apmixedsys CLK_APMIXED_MAINPLL>;
 			clock-names = "cpu", "intermediate";
@@ -193,6 +194,7 @@
 			reg = <0x101>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			#cooling-cells = <2>;
 			clocks = <&infracfg CLK_INFRA_CA57SEL>,
 				 <&apmixedsys CLK_APMIXED_MAINPLL>;
 			clock-names = "cpu", "intermediate";
-- 
2.15.0.194.g9af6a3dea062
