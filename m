Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE6AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A96920855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kqwV69ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfBUKTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:19:07 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11597 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbfBUKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:19:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6e7b170000>; Thu, 21 Feb 2019 02:19:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 Feb 2019 02:19:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 Feb 2019 02:19:04 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 10:18:55 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 10:18:55 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 10:18:55 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6e7b0d0000>; Thu, 21 Feb 2019 02:18:55 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>,
        <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 01/12] of: Add bindings of thermtrip for Tegra soctherm
Date:   Thu, 21 Feb 2019 18:18:36 +0800
Message-ID: <1550744327-4677-2-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550744327-4677-1-git-send-email-wni@nvidia.com>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550744343; bh=nNHCTHyDZVdi5MybDDVW0/CDd/jc8GMicoETAORekNE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=kqwV69yeeCTqXQatJ/YyaaaN77gdZGcU5dAHR+0ggzeDpeK/DNSuE676b5IpUTRCA
         N3mGwq2jvvgE5E4VXxhyqgPYDNxn/qDI+3VzIFq08PHAZa5ibcGBbcpAlAfQUwGkDm
         U+AEi1MHGnfYS3DcMTOhwMIqzrwv6pmwnlCX0mfiBg86htFqV5aPcrKuDa0J5U6m3u
         ltjomH8iRa96GDqXzr1c3k5Y3g5nI0D5sE16myb7GrEz2odvIOmOwP6ka1d4ljIxmP
         ySxM48YGrm8twkoT+sHpuZHfjAWaiYAq5b+2Z6Go+xRZLBFf8tbrTC2AuKKH9gR2Lh
         73wx0ZhKoYjNQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional property "nvidia,thermtrips".
If present, these trips will be used as HW shutdown trips,
and critical trips will be used as SW shutdown trips.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 .../bindings/thermal/nvidia,tegra124-soctherm.txt    | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
index b6c0ae53d4dc..ab66d6feab4b 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
@@ -55,10 +55,21 @@ Required properties :
       - #cooling-cells: Should be 1. This cooling device only support on/off state.
         See ./thermal.txt for a description of this property.
 
+Optional properties:
+- nvidia,thermtrips : When present, this property specifies the temperature at
+  which the soctherm hardware will assert the thermal trigger signal to the
+  Power Management IC, which can be configured to reset or shutdown the device.
+  It is an array of pairs where each pair represents a tsensor id followed by a
+  temperature in milli Celcius. In the absence of this property the critical
+  trip point will be used for thermtrip temperature.
+
 Note:
-- the "critical" type trip points will be set to SOC_THERM hardware as the
-shut down temperature. Once the temperature of this thermal zone is higher
-than it, the system will be shutdown or reset by hardware.
+- the "critical" type trip points will be used to set the temperature at which
+the SOC_THERM hardware will assert a thermal trigger if the "nvidia,thermtrips"
+property is missing. When the thermtrips property is present, the breach of a
+critical trip point is reported back to the thermal framework to implement
+software shutdown.
+
 - the "hot" type trip points will be set to SOC_THERM hardware as the throttle
 temperature. Once the the temperature of this thermal zone is higher
 than it, it will trigger the HW throttle event.
@@ -79,6 +90,9 @@ Example :
 
 		#thermal-sensor-cells = <1>;
 
+		nvidia,thermtrips = <TEGRA124_SOCTHERM_SENSOR_CPU 102500
+				     TEGRA124_SOCTHERM_SENSOR_GPU 103000>;
+
 		throttle-cfgs {
 			/*
 			 * When the "heavy" cooling device triggered,
-- 
2.7.4

