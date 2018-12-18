Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89324C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5465C217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nWh/s32j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeLRHfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:35:37 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7787 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeLRHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:35:34 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c18a33d0001>; Mon, 17 Dec 2018 23:35:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Dec 2018 23:35:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Dec 2018 23:35:33 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:33 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 07:35:33 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c18a3430004>; Mon, 17 Dec 2018 23:35:33 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 11/12] of: Add bindings of OC hw throttle for Tegra soctherm
Date:   Tue, 18 Dec 2018 15:34:43 +0800
Message-ID: <1545118484-23641-13-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545118484-23641-1-git-send-email-wni@nvidia.com>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545118525; bh=BaP7Dxf9eFw33bFgzuMnsX2+krlq9W2LoLSe3EbirIs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=nWh/s32juDKY8aSXkolevagLXf27KAHvhDbo0BoXZ3HungauCHjG9o+aOpOrcSiNn
         PyVyKkYzO4C/j+wTEpcOCyo0HHacdodWDrrRiM35ylM8MCpAwYhcXvgOr+Kc+hjIOA
         PlaXyxgomvghLVgzHTK2fzl5MiZfMyukHm+1xyh9SRkU+DJGZA9/HWol4RSWBHugOQ
         OpvGqO9NjuOQXFYrnoJfXZYfWs30hGfOWNq0WckKzaaJG501T6Me095uiwMkKOaG2m
         MHM1MMPwrvhewcgZW8oyjDG7yZApnBx329Bx+4t9KcnU1FMesbQtG7Go4z3jT6slsW
         z7Qs1W3G/9icQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add OC HW throttle configuration for soctherm in DT.
It is used to describe the OCx throttle events.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
index cf6d0be56b7a..d112a8e59ec3 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
@@ -64,6 +64,21 @@ Required properties :
       - #cooling-cells: Should be 1. This cooling device only support on/off state.
         See ./thermal.txt for a description of this property.
 
+      Optional properties: The following properties are T210 specific and
+      valid only for OCx throttle events.
+      - nvidia,count-threshold: Specifies the number of OC events that are
+        required for triggering an interrupt. Interrupts are not triggered if
+        the property is missing. A value of 0 will interrupt on every OC alarm.
+      - nvidia,polarity-active-low: Configures the polarity of the OC alaram
+        signal. Accepted values are 1 for assert low and 0 for assert high.
+        Default value is 0.
+      - nvidia,alarm-filter: Number of clocks to filter event. When the filter
+        expires (which means the OC event has not occurred for a long time),
+        the counter is cleared and filter is rearmed. Default value is 0.
+      - nvidia,throttle-period: Specifies the number of uSec for which
+        throttling is engaged after the OC event is deasserted. Default value
+        is 0.
+
 Optional properties:
 - nvidia,thermtrips : When present, this property specifies the temperature at
   which the soctherm hardware will assert the thermal trigger signal to the
@@ -134,6 +149,17 @@ Example :
 			 * arbiter will select the highest priority as the final throttle
 			 * settings to skip cpu pulse.
 			 */
+
+			throttle_oc1: oc1 {
+				nvidia,priority = <50>;
+				nvidia,polarity-active-low = <1>;
+				nvidia,count-threshold = <100>;
+				nvidia,alarm-filter = <5100000>;
+				nvidia,throttle-period = <0>;
+				nvidia,cpu-throt-percent = <75>;
+				nvidia,gpu-throt-level =
+						<TEGRA_SOCTHERM_THROT_LEVEL_MED>;
+                        };
 		};
 	};
 
-- 
2.7.4

