Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C68ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAEF20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAEF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388458AbeGWMHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:07:54 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:39911 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388058AbeGWMEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:04:45 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 636FBCD57;
        Mon, 23 Jul 2018 14:04:02 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v3 08/35] media: dt-bindings: media: qcom,camss: Unify the clock names
Date:   Mon, 23 Jul 2018 14:02:25 +0300
Message-Id: <1532343772-27382-9-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532343772-27382-1-git-send-email-todor.tomov@linaro.org>
References: <1532343772-27382-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use more logical clock names - similar to the names in documentation.
This will allow better handling of the clocks in the driver when support
for more hardware versions is added - equivalent clocks on different
hardware versions will have the same name.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: devicetree@vger.kernel.org
Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 .../devicetree/bindings/media/qcom,camss.txt       | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,camss.txt b/Documentation/devicetree/bindings/media/qcom,camss.txt
index cadeceb..032e8ed 100644
--- a/Documentation/devicetree/bindings/media/qcom,camss.txt
+++ b/Documentation/devicetree/bindings/media/qcom,camss.txt
@@ -53,7 +53,7 @@ Qualcomm Camera Subsystem
 	Usage: required
 	Value type: <stringlist>
 	Definition: Should contain the following entries:
-                - "camss_top_ahb"
+                - "top_ahb"
                 - "ispif_ahb"
                 - "csiphy0_timer"
                 - "csiphy1_timer"
@@ -67,11 +67,11 @@ Qualcomm Camera Subsystem
                 - "csi1_phy"
                 - "csi1_pix"
                 - "csi1_rdi"
-                - "camss_ahb"
-                - "camss_vfe_vfe"
-                - "camss_csi_vfe"
-                - "iface"
-                - "bus"
+                - "ahb"
+                - "vfe0"
+                - "csi_vfe0"
+                - "vfe_ahb"
+                - "vfe_axi"
 - vdda-supply:
 	Usage: required
 	Value type: <phandle>
@@ -161,7 +161,7 @@ Qualcomm Camera Subsystem
 			<&gcc GCC_CAMSS_CSI_VFE0_CLK>,
 			<&gcc GCC_CAMSS_VFE_AHB_CLK>,
 			<&gcc GCC_CAMSS_VFE_AXI_CLK>;
-                clock-names = "camss_top_ahb",
+                clock-names = "top_ahb",
                         "ispif_ahb",
                         "csiphy0_timer",
                         "csiphy1_timer",
@@ -175,11 +175,11 @@ Qualcomm Camera Subsystem
                         "csi1_phy",
                         "csi1_pix",
                         "csi1_rdi",
-                        "camss_ahb",
-                        "camss_vfe_vfe",
-                        "camss_csi_vfe",
-                        "iface",
-                        "bus";
+                        "ahb",
+                        "vfe0",
+                        "csi_vfe0",
+                        "vfe_ahb",
+                        "vfe_axi";
 		vdda-supply = <&pm8916_l2>;
 		iommus = <&apps_iommu 3>;
 		ports {
-- 
2.7.4

