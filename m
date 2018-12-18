Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305A1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32F4217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PwZXEUFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeLRHgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:36:24 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18433 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLRHfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:35:11 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c18a3290001>; Mon, 17 Dec 2018 23:35:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Dec 2018 23:35:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Dec 2018 23:35:11 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:10 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 07:35:10 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c18a32c0002>; Mon, 17 Dec 2018 23:35:10 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 01/12] of: Add bindings of thermtrip for Tegra soctherm
Date:   Tue, 18 Dec 2018 15:34:33 +0800
Message-ID: <1545118484-23641-3-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545118484-23641-1-git-send-email-wni@nvidia.com>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545118505; bh=nNHCTHyDZVdi5MybDDVW0/CDd/jc8GMicoETAORekNE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=PwZXEUFi3/3yczS22EJ9v2U7vUySZQhYdnHnLnSvxRlU8hpkqxucRWMQTw286+RZO
         swUiHmdhaVcW2bngyG2eNUczBxhXxuOGilMSRN9d3IKHX117GKtmbT3bbb3dWF61Qu
         Axtx6K6/tAW2l4rsS6JvW5FBECEDvmjZDgBYY2JlaTCMFdxxWfiaFwVpE5q+uO32Tu
         oUqJKvtLxPxPUzbSufpo4bjPF07BgtNy5P/s1l9FQ+WaqB9aEpqAv80lo0/bZMb0pI
         s2iOrKuKFPphLAamAKR40EZe702s+9cTd2EYzcHS1L4XZPqvPCTjvKE2n69yjzab5B
         lZxp9S/O2+3uQ==
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

