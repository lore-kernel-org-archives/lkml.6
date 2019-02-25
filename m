Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4018C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27702087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfBYDHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 22:07:02 -0500
Received: from inva021.nxp.com ([92.121.34.21]:37974 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfBYDHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 22:07:01 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C16720012F;
        Mon, 25 Feb 2019 04:06:59 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F02D200139;
        Mon, 25 Feb 2019 04:06:53 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 12974402F2;
        Mon, 25 Feb 2019 11:06:47 +0800 (SGT)
From:   Yuantian Tang <andy.tang@nxp.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] arm64: dts: ls1088a: add one more thermal zone node
Date:   Mon, 25 Feb 2019 11:00:49 +0800
Message-Id: <20190225030049.20401-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ls1088a has 2 thermal sensors. This patch adds the second node
to dts to enable it.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   43 +++++++++++++++++++++--
 1 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 661137f..9f52bc9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -129,19 +129,19 @@
 	};
 
 	thermal-zones {
-		cpu_thermal: cpu-thermal {
+		ccu {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 0>;
 
 			trips {
-				cpu_alert: cpu-alert {
+				ccu_alert: ccu-alert {
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit: cpu-crit {
+				ccu_crit: ccu-crit {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -150,7 +150,42 @@
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu_alert>;
+					trip = <&ccu_alert>;
+					cooling-device =
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		plt {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 1>;
+
+			trips {
+				plt_alert: plt-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				plt_crit: plt-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&plt_alert>;
 					cooling-device =
 						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-- 
1.7.1

