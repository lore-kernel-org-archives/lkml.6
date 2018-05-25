Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935871AbeEYFlO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 01:41:14 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33012 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964969AbeEYFkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 01:40:45 -0400
X-Google-Smtp-Source: AB8JxZpng8qr6X0JMke3reYtZXDqjBB6/3V+FQyq5RTZ+9RNok+YRas6RB7SfEltLoF8Mx3T7c+0LA==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: rockchip: Add missing cooling device properties for CPUs
Date: Fri, 25 May 2018 11:10:05 +0530
Message-Id: <d7f32cb0c3b77901cb5e37320a454e5e1dfed958.1527225682.git.viresh.kumar@linaro.org>
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
 arch/arm64/boot/dts/rockchip/rk3328.dtsi |  3 +++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi |  8 ++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index b8e9da15e00c..902a0907ad34 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -89,6 +89,7 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x1>;
 			clocks = <&cru ARMCLK>;
+			#cooling-cells = <2>;
 			dynamic-power-coefficient = <120>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
@@ -100,6 +101,7 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x2>;
 			clocks = <&cru ARMCLK>;
+			#cooling-cells = <2>;
 			dynamic-power-coefficient = <120>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
@@ -111,6 +113,7 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x3>;
 			clocks = <&cru ARMCLK>;
+			#cooling-cells = <2>;
 			dynamic-power-coefficient = <120>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index ad91ced78649..c32f2a551a1f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -122,6 +122,8 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu_l2: cpu@2 {
@@ -129,6 +131,8 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu_l3: cpu@3 {
@@ -136,6 +140,8 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu_b0: cpu@100 {
@@ -152,6 +158,8 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu_b2: cpu@102 {
@@ -159,6 +167,8 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
+
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu_b3: cpu@103 {
@@ -166,6 +176,8 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
+
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e0040b648f43..da935383a8f2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -108,8 +108,8 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
-			#cooling-cells = <2>; /* min followed by max */
 			clocks = <&cru ARMCLKL>;
+			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 		};
 
@@ -119,6 +119,7 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			clocks = <&cru ARMCLKL>;
+			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 		};
 
@@ -128,6 +129,7 @@
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			clocks = <&cru ARMCLKL>;
+			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 		};
 
@@ -137,6 +139,7 @@
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			clocks = <&cru ARMCLKL>;
+			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 		};
 
@@ -145,8 +148,8 @@
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
-			#cooling-cells = <2>; /* min followed by max */
 			clocks = <&cru ARMCLKB>;
+			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <436>;
 		};
 
@@ -156,6 +159,7 @@
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			clocks = <&cru ARMCLKB>;
+			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <436>;
 		};
 	};
-- 
2.15.0.194.g9af6a3dea062
