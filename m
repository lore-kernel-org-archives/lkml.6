Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87D7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F0820836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BAhoG5gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfBUKUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:20:14 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17424 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfBUKTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:19:04 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6e7b1d0003>; Thu, 21 Feb 2019 02:19:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 21 Feb 2019 02:19:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 21 Feb 2019 02:19:03 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 10:19:03 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 10:19:03 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 10:19:03 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6e7b14000e>; Thu, 21 Feb 2019 02:19:03 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>,
        <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 04/12] of: Add bindings of gpu hw throttle for Tegra soctherm
Date:   Thu, 21 Feb 2019 18:18:39 +0800
Message-ID: <1550744327-4677-5-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550744327-4677-1-git-send-email-wni@nvidia.com>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550744350; bh=yf7RsdMTytvmphVZqy6f64Lis9JM+aVLoe7j05Siirk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=BAhoG5gjanWYIPcqN9t4KxL/tJqjAK95ilKoAyCB3+u2G/+BN0VSPqvL7vowIqahc
         JEHVpCCEeaM8WBhvAUAFodAhDQ6IuV9jeDAzw0yF6QSUHSiMt3W5aiI3vhQcEBV7Id
         j69W50kLX6lLCP7W+U227/VyO7FL2dCifDn8BuTukdvyD/ZYtMdnLzpgXvzRMk19ZP
         tkZgAdMRErrgjeCZqA1VGF4BxACqfXJaaLdpMwvYyWdHcLsj66uDQpxk1CMGL2vVG4
         a4njuoi+ZXglCOamspZgVzMdcv29t5P7fBAH0jwbzK66aaGLEbsABcOAhVWWtt2sQy
         COWVZWuhAxFtg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "nvidia,gpu-throt-level" property to set gpu hw
throttle level.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 .../bindings/thermal/nvidia,tegra124-soctherm.txt       | 17 +++++++++++++++--
 include/dt-bindings/thermal/tegra124-soctherm.h         |  8 ++++----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
index ab66d6feab4b..cf6d0be56b7a 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
@@ -52,6 +52,15 @@ Required properties :
         Must set as following values:
         TEGRA_SOCTHERM_THROT_LEVEL_LOW, TEGRA_SOCTHERM_THROT_LEVEL_MED
         TEGRA_SOCTHERM_THROT_LEVEL_HIGH, TEGRA_SOCTHERM_THROT_LEVEL_NONE
+      - nvidia,gpu-throt-level: This property is for Tegra124 and Tegra210.
+        It is the level of pulse skippers, which used to throttle clock
+        frequencies. It indicates gpu clock throttling depth and can be
+        programmed to any of the following values which represent a throttling
+        percentage:
+        TEGRA_SOCTHERM_THROT_LEVEL_NONE (0%)
+        TEGRA_SOCTHERM_THROT_LEVEL_LOW (50%),
+        TEGRA_SOCTHERM_THROT_LEVEL_MED (75%),
+        TEGRA_SOCTHERM_THROT_LEVEL_HIGH (85%).
       - #cooling-cells: Should be 1. This cooling device only support on/off state.
         See ./thermal.txt for a description of this property.
 
@@ -96,22 +105,26 @@ Example :
 		throttle-cfgs {
 			/*
 			 * When the "heavy" cooling device triggered,
-			 * the HW will skip cpu clock's pulse in 85% depth
+			 * the HW will skip cpu clock's pulse in 85% depth,
+			 * skip gpu clock's pulse in 85% level
 			 */
 			throttle_heavy: heavy {
 				nvidia,priority = <100>;
 				nvidia,cpu-throt-percent = <85>;
+				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
 
 				#cooling-cells = <1>;
 			};
 
 			/*
 			 * When the "light" cooling device triggered,
-			 * the HW will skip cpu clock's pulse in 50% depth
+			 * the HW will skip cpu clock's pulse in 50% depth,
+			 * skip gpu clock's pulse in 50% level
 			 */
 			throttle_light: light {
 				nvidia,priority = <80>;
 				nvidia,cpu-throt-percent = <50>;
+				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_LOW>;
 
 				#cooling-cells = <1>;
 			};
diff --git a/include/dt-bindings/thermal/tegra124-soctherm.h b/include/dt-bindings/thermal/tegra124-soctherm.h
index c15e8b709a0d..444c7bdde146 100644
--- a/include/dt-bindings/thermal/tegra124-soctherm.h
+++ b/include/dt-bindings/thermal/tegra124-soctherm.h
@@ -12,9 +12,9 @@
 #define TEGRA124_SOCTHERM_SENSOR_PLLX 3
 #define TEGRA124_SOCTHERM_SENSOR_NUM 4
 
-#define TEGRA_SOCTHERM_THROT_LEVEL_LOW  0
-#define TEGRA_SOCTHERM_THROT_LEVEL_MED  1
-#define TEGRA_SOCTHERM_THROT_LEVEL_HIGH 2
-#define TEGRA_SOCTHERM_THROT_LEVEL_NONE -1
+#define TEGRA_SOCTHERM_THROT_LEVEL_NONE 0
+#define TEGRA_SOCTHERM_THROT_LEVEL_LOW  1
+#define TEGRA_SOCTHERM_THROT_LEVEL_MED  2
+#define TEGRA_SOCTHERM_THROT_LEVEL_HIGH 3
 
 #endif
-- 
2.7.4

