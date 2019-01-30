Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1390C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC01921473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbfA3Imf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:42:35 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:60798 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730311AbfA3ImY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:42:24 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id F3F675FE11; Wed, 30 Jan 2019 16:42:17 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>,
        Andre Przywara <andre.przywara@arm.com>,
        Emmanuel Vadot <manu@freebsd.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] arm64: dts: allwinner: h5: Add CPU Operating Performance Points table
Date:   Wed, 30 Jan 2019 16:42:03 +0800
Message-Id: <20190130084203.25053-11-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130084203.25053-1-wens@csie.org>
References: <20190130084203.25053-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an OPP (Operating Performance Points) table for the CPU cores to
enable DVFS (Dynamic Voltage & Frequency Scaling) on the H5. The table
originates from Armbian, but the maximum voltage is raised slightly to
account for boards using slightly higher voltages.

This has been tested on the Libre Computer ALL-H3-CC-H5 and the Bananapi
M2+ v1.2 H5, both with adequate cooling. The former has a fixed 1.2V
regulator, while the latter has a GPIO controlled regulator switchable
between 1.1V and 1.3V.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 67 ++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 25bb8227a6fd..0e83b8a25f9c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -54,6 +54,8 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@1 {
@@ -63,6 +65,8 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@2 {
@@ -72,6 +76,8 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@3 {
@@ -81,6 +87,67 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
+		};
+	};
+
+	cpu_opp_table: opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <1000000 1000000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@648000000 {
+			opp-hz = /bits/ 64 <648000000>;
+			opp-microvolt = <1040000 1040000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <1080000 1080000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@912000000 {
+			opp-hz = /bits/ 64 <912000000>;
+			opp-microvolt = <1120000 1120000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@960000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			opp-microvolt = <1160000 1160000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1200000 1200000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-microvolt = <1240000 1240000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <1260000 1260000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1152000000 {
+			opp-hz = /bits/ 64 <1152000000>;
+			opp-microvolt = <1300000 1300000 1310000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 	};
 
-- 
2.20.1

