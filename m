Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A1FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AB721841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fiMhWpPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeLRHfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:35:20 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8305 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeLRHfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:35:18 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c18a3300002>; Mon, 17 Dec 2018 23:35:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Dec 2018 23:35:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Dec 2018 23:35:18 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:17 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 07:35:17 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c18a3330004>; Mon, 17 Dec 2018 23:35:17 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 04/12] of: Add bindings of gpu hw throttle for Tegra soctherm
Date:   Tue, 18 Dec 2018 15:34:36 +0800
Message-ID: <1545118484-23641-6-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545118484-23641-1-git-send-email-wni@nvidia.com>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545118512; bh=DvywBLgymtuHtdQVAmcWVgLWinucGK52qF/cX0AEx64=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=fiMhWpPvbTO2X4brLpZ+yJfSaaZ3QY2qBMn9fKtVWLxr18Q1yBvsqRDmBGFBEGFew
         1EDzTDGPm0WHX4ifRevFhcP58zMsRknDsP1FOpUU6GyXj5C0cLvMpjObHeV8SPeTI5
         QMNaxyfq/MTW9AVU1xGf7aU0sem8hT+nRbLZtlKen3ppVfij6Z0dPO8SOhFTUo/tYK
         syvL/C2EYpHQn8EejoVlh3zbl9aRe5/ctHMCHaVGvBh0XZvyCyLNI8mCxD7ABZe5pb
         Iwi93haay4ql/gMs0LPzVFPNIWl455DHBZxzd/Yx0nedStBBpdhQofuKpx7qigJFWE
         oPGrGlK9Hm9oA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "nvidia,gpu-throt-level" property to set gpu hw
throttle level.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 17 +++++++++++++++--
 include/dt-bindings/thermal/tegra124-soctherm.h    | 22 ++++++++++++++++++----
 2 files changed, 33 insertions(+), 6 deletions(-)

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
index c15e8b709a0d..75853df1c609 100644
--- a/include/dt-bindings/thermal/tegra124-soctherm.h
+++ b/include/dt-bindings/thermal/tegra124-soctherm.h
@@ -1,5 +1,19 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright (c) 2014 - 2018, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Author:
+ *      Mikko Perttunen <mperttunen@nvidia.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
  * This header provides constants for binding nvidia,tegra124-soctherm.
  */
 
@@ -12,9 +26,9 @@
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

