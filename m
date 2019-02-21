Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9149C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B636920836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Rc/XMK1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfBUKT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:19:26 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11636 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfBUKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:19:22 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6e7b280000>; Thu, 21 Feb 2019 02:19:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 21 Feb 2019 02:19:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 21 Feb 2019 02:19:22 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 10:19:21 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 10:19:21 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6e7b270000>; Thu, 21 Feb 2019 02:19:21 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>,
        <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 11/12] of: Add bindings of OC hw throttle for Tegra soctherm
Date:   Thu, 21 Feb 2019 18:18:46 +0800
Message-ID: <1550744327-4677-12-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550744327-4677-1-git-send-email-wni@nvidia.com>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550744360; bh=F9FD14V6kuNcXDhMxRFipwy+7yYwxOf3CKXdpbwkTps=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Rc/XMK1QxMVqglU9YD1wu9GdNXso9amemreE2JZN7OM1lu2BPSPkQ0514c9fMT3gz
         6l520DVusGCEFtm5olAbYZvfq3S330TdOf/7ChJwJV3Wml7hXXyqC+MB8uSALA028P
         UPgt7U9FHcJyZVMhn7rGywhI+KFcPvJG4zPux70PYkvubX8nzwFeNYpaWBJnB1IJ/X
         oMF53R69NrxjJzzyinbYzm1mp9+rEfv/SOraL9u8MRqhJMSKavFUGdwnbogXdARYaW
         bOxOQzrRAFA1mBxIm+AP5PbsLJ0uVdgKhGFJiYPqxgg7Be5kpAR4ZAtb+tatW66Fex
         BbbKDUOsbkp0w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add OC HW throttle configuration for soctherm in DT.
It is used to describe the OCx throttle events.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
index cf6d0be56b7a..f02f38527a6b 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
@@ -64,6 +64,20 @@ Required properties :
       - #cooling-cells: Should be 1. This cooling device only support on/off state.
         See ./thermal.txt for a description of this property.
 
+      Optional properties: The following properties are T210 specific and
+      valid only for OCx throttle events.
+      - nvidia,count-threshold: Specifies the number of OC events that are
+        required for triggering an interrupt. Interrupts are not triggered if
+        the property is missing. A value of 0 will interrupt on every OC alarm.
+      - nvidia,polarity-active-low: Configures the polarity of the OC alaram
+        signal. If present, this means assert low, otherwise assert high.
+      - nvidia,alarm-filter: Number of clocks to filter event. When the filter
+        expires (which means the OC event has not occurred for a long time),
+        the counter is cleared and filter is rearmed. Default value is 0.
+      - nvidia,throttle-period-us: Specifies the number of uSec for which
+        throttling is engaged after the OC event is deasserted. Default value
+        is 0.
+
 Optional properties:
 - nvidia,thermtrips : When present, this property specifies the temperature at
   which the soctherm hardware will assert the thermal trigger signal to the
@@ -134,6 +148,17 @@ Example :
 			 * arbiter will select the highest priority as the final throttle
 			 * settings to skip cpu pulse.
 			 */
+
+			throttle_oc1: oc1 {
+				nvidia,priority = <50>;
+				nvidia,polarity-active-low;
+				nvidia,count-threshold = <100>;
+				nvidia,alarm-filter = <5100000>;
+				nvidia,throttle-period-us = <0>;
+				nvidia,cpu-throt-percent = <75>;
+				nvidia,gpu-throt-level =
+						<TEGRA_SOCTHERM_THROT_LEVEL_MED>;
+                        };
 		};
 	};
 
-- 
2.7.4

