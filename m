Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbeDDDPS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 23:15:18 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43956 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753742AbeDDDPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 23:15:13 -0400
X-Google-Smtp-Source: AIpwx49q/h/KhPBvuiiKIDY3cS8+JONbeqUFFfm/NCmfiv185Vl+5W5V46QxkX4nvzMEjm96dEy2+w==
From: Leo Yan <leo.yan@linaro.org>
To: Wei Xu <xuwei5@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Leo Yan <leo.yan@linaro.org>, Kaihua Zhong <zhongkaihua@huawei.com>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: [PATCH 3/5] dts: arm64: hi3660: Add CPU frequency scaling support
Date: Wed,  4 Apr 2018 11:14:33 +0800
Message-Id: <1522811675-12741-4-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522811675-12741-1-git-send-email-leo.yan@linaro.org>
References: <1522811675-12741-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two CPU OPP tables, one table is corresponding to one cluster,
which allow CPU frequency scaling on hi3660 platforms.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 86 +++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 3a3bcff..a39da09 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -62,6 +62,8 @@
 			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <592>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu1: cpu@1 {
@@ -72,6 +74,8 @@
 			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <592>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu2: cpu@2 {
@@ -82,6 +86,8 @@
 			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <592>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu3: cpu@3 {
@@ -92,6 +98,8 @@
 			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <592>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu4: cpu@100 {
@@ -102,6 +110,8 @@
 			next-level-cache = <&A73_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
 			capacity-dmips-mhz = <1024>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		cpu5: cpu@101 {
@@ -112,6 +122,8 @@
 			next-level-cache = <&A73_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
 			capacity-dmips-mhz = <1024>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		cpu6: cpu@102 {
@@ -122,6 +134,8 @@
 			next-level-cache = <&A73_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
 			capacity-dmips-mhz = <1024>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		cpu7: cpu@103 {
@@ -132,6 +146,8 @@
 			next-level-cache = <&A73_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
 			capacity-dmips-mhz = <1024>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		idle-states {
@@ -174,6 +190,76 @@
 		};
 	};
 
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <533000000>;
+			opp-microvolt = <700000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp01 {
+			opp-hz = /bits/ 64 <999000000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp02 {
+			opp-hz = /bits/ 64 <1402000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp03 {
+			opp-hz = /bits/ 64 <1709000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp04 {
+			opp-hz = /bits/ 64 <1844000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <300000>;
+		};
+	};
+
+	cluster1_opp: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp10 {
+			opp-hz = /bits/ 64 <903000000>;
+			opp-microvolt = <700000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp11 {
+			opp-hz = /bits/ 64 <1421000000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp12 {
+			opp-hz = /bits/ 64 <1805000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp13 {
+			opp-hz = /bits/ 64 <2112000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp14 {
+			opp-hz = /bits/ 64 <2362000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <300000>;
+		};
+	};
+
 	gic: interrupt-controller@e82b0000 {
 		compatible = "arm,gic-400";
 		reg = <0x0 0xe82b1000 0 0x1000>, /* GICD */
-- 
1.9.1
