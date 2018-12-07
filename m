Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99947C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D012083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="odfVR+0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D012083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeLGKO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:14:28 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7394 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGKOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:14:25 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c0a47ff0001>; Fri, 07 Dec 2018 02:14:23 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Dec 2018 02:14:25 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Dec 2018 02:14:25 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 10:14:24 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 7 Dec 2018 10:14:24 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c0a47fe0000>; Fri, 07 Dec 2018 02:14:24 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 1/3] of: add nvidia,thermtrips property
Date:   Fri, 7 Dec 2018 18:10:05 +0800
Message-ID: <1544177407-20203-2-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544177407-20203-1-git-send-email-wni@nvidia.com>
References: <1544177407-20203-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544177663; bh=nNHCTHyDZVdi5MybDDVW0/CDd/jc8GMicoETAORekNE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=odfVR+0L6cv1aL8eUAvSUEwqL4FwVQsXGK5GkJfPI6JPN4sYa6jVn3tWA7c/acTHu
         FAFW0b4SyZa1wX3LLjE93z4XtdozO/eT8r93UytT6PGoyYqTjahNjFCLe4BaMjgwzV
         IhC0vdmwTH2Y6nMumvlmh+yEHnlcLIDnKzQ/wIS98rZswDW+Zi0y3GhbNFwwNGSFdk
         l2xwJjPBLT1Xcw2FH/iQnrecqbgN8fo6obaCNdEKDmnPjejqyGTeoGL8maZFV7a+Sm
         M+87F9+dsrSyIuYz2wHyOolUDX7dkAIFSn/3ZjBGmEGnDDC2YpeTb68ILl+iVXvhii
         frZLIj8pVUbew==
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

