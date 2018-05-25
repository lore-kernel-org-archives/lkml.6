Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966388AbeEYKc6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:32:58 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40860 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966261AbeEYKcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:32:48 -0400
X-Google-Smtp-Source: AB8JxZqx83qzjuPGpZugm5ruib/IuOi1sfSPQEu5SZzAOL6aWzn32CabZjtbgpOZ8AomWMDotMpMAA==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arm@kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] arm: dts: rk3288: Add missing cooling device properties for CPUs
Date: Fri, 25 May 2018 16:01:56 +0530
Message-Id: <11f16618dc965a7996976a2bca040cd87d1961d2.1527244201.git.viresh.kumar@linaro.org>
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
 arch/arm/boot/dts/rk3288.dtsi | 54 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index d7e49d29ace5..752a892847dd 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -122,18 +122,72 @@
 			compatible = "arm,cortex-a12";
 			reg = <0x501>;
 			resets = <&cru SRST_CORE1>;
+			operating-points = <
+				/* KHz    uV */
+				1608000 1350000
+				1512000 1300000
+				1416000 1200000
+				1200000 1100000
+				1008000 1050000
+				 816000 1000000
+				 696000  950000
+				 600000  900000
+				 408000  900000
+				 312000  900000
+				 216000  900000
+				 126000  900000
+			>;
+			#cooling-cells = <2>; /* min followed by max */
+			clock-latency = <40000>;
+			clocks = <&cru ARMCLK>;
 		};
 		cpu2: cpu@502 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a12";
 			reg = <0x502>;
 			resets = <&cru SRST_CORE2>;
+			operating-points = <
+				/* KHz    uV */
+				1608000 1350000
+				1512000 1300000
+				1416000 1200000
+				1200000 1100000
+				1008000 1050000
+				 816000 1000000
+				 696000  950000
+				 600000  900000
+				 408000  900000
+				 312000  900000
+				 216000  900000
+				 126000  900000
+			>;
+			#cooling-cells = <2>; /* min followed by max */
+			clock-latency = <40000>;
+			clocks = <&cru ARMCLK>;
 		};
 		cpu3: cpu@503 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a12";
 			reg = <0x503>;
 			resets = <&cru SRST_CORE3>;
+			operating-points = <
+				/* KHz    uV */
+				1608000 1350000
+				1512000 1300000
+				1416000 1200000
+				1200000 1100000
+				1008000 1050000
+				 816000 1000000
+				 696000  950000
+				 600000  900000
+				 408000  900000
+				 312000  900000
+				 216000  900000
+				 126000  900000
+			>;
+			#cooling-cells = <2>; /* min followed by max */
+			clock-latency = <40000>;
+			clocks = <&cru ARMCLK>;
 		};
 	};
 
-- 
2.15.0.194.g9af6a3dea062
