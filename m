Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9D3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE43B214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bEtZO6Ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeLRHfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:35:18 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8296 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbeLRHfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:35:17 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c18a32e0002>; Mon, 17 Dec 2018 23:35:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Dec 2018 23:35:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Dec 2018 23:35:16 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:16 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:15 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 07:35:15 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c18a3310001>; Mon, 17 Dec 2018 23:35:15 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 03/12] arm64: dts: tegra210: set thermtrip
Date:   Tue, 18 Dec 2018 15:34:35 +0800
Message-ID: <1545118484-23641-5-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545118484-23641-1-git-send-email-wni@nvidia.com>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545118511; bh=Pfxfdgnv5/IIDUk+o7WtuuT2E4eppKOazkbdTy8g7zI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=bEtZO6Ls1/R74JTitAvBfUGlgM0HUFx6CyQK3JEP9FByUs2aBvKZw8daqhOd47t8b
         TV14HhVbgWIF13M2LmoQTlo3i9jIFFoyh3DyEbVAmiXcGAtijbZM0RoIO2UZYB5aPx
         wRHdPSiPYzB2ZQHzfoCYQtsuoJIY8ObcslnA5/+6T1cDeoc3IyGY8OKbEcI+9rwm8z
         qtNMbd/D/GjcjOK1K4mKb+5soJaCMSxLdXgW0G/9p4Y2JNLLPmAD/icFtTyLK60kkN
         GB4hVvtxlt2YZc9lai/qONL18PrxlHaiOJZ5RDMyUm2n3v78oNqaHKNUT1fXYR7Zz9
         Kabulcwrl+vyQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set "nvidia,thermtrips" property, it used to set
HW shutdown temperatures.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 2205d66b0443..36c7dce7fa69 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1332,6 +1332,9 @@
 		reset-names = "soctherm";
 		#thermal-sensor-cells = <1>;
 
+		nvidia,thermtrips = <TEGRA124_SOCTHERM_SENSOR_CPU 102500
+				     TEGRA124_SOCTHERM_SENSOR_GPU 103000>;
+
 		throttle-cfgs {
 			throttle_heavy: heavy {
 				nvidia,priority = <100>;
@@ -1351,8 +1354,8 @@
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
 
 			trips {
-				cpu-shutdown-trip {
-					temperature = <102500>;
+				cpu-critical-trip {
+					temperature = <102000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -1379,7 +1382,7 @@
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
 
 			trips {
-				mem-shutdown-trip {
+				mem-critical-trip {
 					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
@@ -1401,8 +1404,8 @@
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
 
 			trips {
-				gpu-shutdown-trip {
-					temperature = <103000>;
+				gpu-critical-trip {
+					temperature = <102500>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -1429,7 +1432,7 @@
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
 
 			trips {
-				pllx-shutdown-trip {
+				pllx-critical-trip {
 					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
-- 
2.7.4

