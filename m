Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD192C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F282083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VhDs1+WD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F282083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLGKOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:14:32 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14618 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGKOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:14:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c0a47fa0000>; Fri, 07 Dec 2018 02:14:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Dec 2018 02:14:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Dec 2018 02:14:29 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 10:14:28 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 7 Dec 2018 10:14:29 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c0a48030002>; Fri, 07 Dec 2018 02:14:28 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 3/3] arm64: dts: tegra210: set thermtrip
Date:   Fri, 7 Dec 2018 18:10:07 +0800
Message-ID: <1544177407-20203-4-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544177407-20203-1-git-send-email-wni@nvidia.com>
References: <1544177407-20203-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544177658; bh=9AJ9SFRAIcIBPmc/HlPCTC67fy3Vwake9TMBHYQ2Bbc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=VhDs1+WD525q9lizbZM3gtgHKBefyjjsitjzIrly9qbvCnKa2W9oY1mOcxd4TTJFu
         VzPKRElC7K3Pj1cKI2vBko196ean3b/5JbsoG088gyfSiyD/hHxNbV4JzvhcMhPwvA
         1M/0lfdktnmWtFkhVCfZieuiG1ng7aaIpf0GQLHZ3b4M+JwIyv9qozV5Kxv6IN50oW
         +YpIWD/1MI1lL+4bEBTS2Snr5R3oWpWH+gZ88P/OBAmUJDBnmArxnSEGEdOihzCjQF
         aJsW84vyKAY6JJ3rVdXsFcFNbecT5+7cjdnnR13OuxvyQRh3WPy4k+436rfJdmmaNV
         Lf80eULrqzsdg==
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
index 8fe47d6445a5..f2e89b218b23 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1330,6 +1330,9 @@
 		reset-names = "soctherm";
 		#thermal-sensor-cells = <1>;
 
+		nvidia,thermtrips = <TEGRA124_SOCTHERM_SENSOR_CPU 102500
+				     TEGRA124_SOCTHERM_SENSOR_GPU 103000>;
+
 		throttle-cfgs {
 			throttle_heavy: heavy {
 				nvidia,priority = <100>;
@@ -1349,8 +1352,8 @@
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
 
 			trips {
-				cpu-shutdown-trip {
-					temperature = <102500>;
+				cpu-critical-trip {
+					temperature = <102000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -1377,7 +1380,7 @@
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
 
 			trips {
-				mem-shutdown-trip {
+				mem-critical-trip {
 					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
@@ -1399,8 +1402,8 @@
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
 
 			trips {
-				gpu-shutdown-trip {
-					temperature = <103000>;
+				gpu-critical-trip {
+					temperature = <102500>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -1427,7 +1430,7 @@
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
 
 			trips {
-				pllx-shutdown-trip {
+				pllx-critical-trip {
 					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
-- 
2.7.4

