Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeA3Mju (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:39:50 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:57916 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751974AbeA3Mjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:39:42 -0500
From: Klaus Goger <klaus.goger@theobroma-systems.com>
To: linux-rockchip@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: [PATCH 4/4] arm64: dts: rockchip: add OPPs for rk3368-lion
Date: Tue, 30 Jan 2018 13:39:31 +0100
Message-Id: <20180130123931.50781-5-klaus.goger@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180130123931.50781-1-klaus.goger@theobroma-systems.com>
References: <20180130123931.50781-1-klaus.goger@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds CPU operation points for the RK3368. We only add them to the
the RK3368-uQ7 SoM (Lion) because patches for the SoC where reverted
in the past.
commit 6354a06cbaa8 ("Revert "arm64: dts: rockchip: Add basic cpu
frequencies for RK3368"")

Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>

---

 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi | 96 ++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
index 72be1ae0854f..881f0b44c5b5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
@@ -11,6 +11,70 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	cluster0_opp: opp-table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <950000 950000 1350000>;
+			clock-latency-ns = <40000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <950000 950000 1350000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <975000 975000 1350000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1050000 1050000 1350000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1150000 1150000 1350000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1300000 1300000 1350000>;
+			turbo-mode;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-microvolt = <1300000 1300000 1350000>;
+			turbo-mode;
+		};
+	};
+
+	cluster1_opp: opp-table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <950000 950000 1350000>;
+			clock-latency-ns = <40000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <950000 950000 1350000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <1025000 1025000 1350000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1125000 1125000 1350000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1225000 1225000 1350000>;
+		};
+	};
+
 	ext_gmac: gmac-clk {
 		compatible = "fixed-clock";
 		clock-frequency = <125000000>;
@@ -239,36 +303,52 @@
 	status = "okay";
 };
 
-&cpu_l0 {
+&cpu_b0 {
+	clocks = <&cru ARMCLKB>;
 	cpu-supply = <&vdd_cpu>;
+	operating-points-v2 = <&cluster0_opp>;
 };
 
-&cpu_l1 {
+&cpu_b1 {
+	clocks = <&cru ARMCLKB>;
 	cpu-supply = <&vdd_cpu>;
+	operating-points-v2 = <&cluster0_opp>;
 };
 
-&cpu_l2 {
+&cpu_b2 {
+	clocks = <&cru ARMCLKB>;
 	cpu-supply = <&vdd_cpu>;
+	operating-points-v2 = <&cluster0_opp>;
 };
 
-&cpu_l3 {
+&cpu_b3 {
+	clocks = <&cru ARMCLKB>;
 	cpu-supply = <&vdd_cpu>;
+	operating-points-v2 = <&cluster0_opp>;
 };
 
-&cpu_b0 {
+&cpu_l0 {
+	clocks = <&cru ARMCLKL>;
 	cpu-supply = <&vdd_cpu>;
+	operating-points-v2 = <&cluster1_opp>;
 };
 
-&cpu_b1 {
+&cpu_l1 {
+	clocks = <&cru ARMCLKL>;
 	cpu-supply = <&vdd_cpu>;
+	operating-points-v2 = <&cluster1_opp>;
 };
 
-&cpu_b2 {
+&cpu_l2 {
+	clocks = <&cru ARMCLKL>;
 	cpu-supply = <&vdd_cpu>;
+	operating-points-v2 = <&cluster1_opp>;
 };
 
-&cpu_b3 {
+&cpu_l3 {
+	clocks = <&cru ARMCLKL>;
 	cpu-supply = <&vdd_cpu>;
+	operating-points-v2 = <&cluster1_opp>;
 };
 
 &pinctrl {
-- 
2.11.0
