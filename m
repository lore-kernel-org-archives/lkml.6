Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789B6C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1C823E90
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1C823E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754092AbeGENjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:39:17 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:41286 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753750AbeGENdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:33:22 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 58D6FCD57;
        Thu,  5 Jul 2018 16:33:17 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 15/34] media: dt-bindings: media: qcom,camss: Add 8996 bindings
Date:   Thu,  5 Jul 2018 16:32:46 +0300
Message-Id: <1530797585-8555-16-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
References: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update binding document for MSM8996.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: devicetree@vger.kernel.org
Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/qcom,camss.txt       | 44 +++++++++++++++++++---
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,camss.txt b/Documentation/devicetree/bindings/media/qcom,camss.txt
index e938eb0..09eb6ed 100644
--- a/Documentation/devicetree/bindings/media/qcom,camss.txt
+++ b/Documentation/devicetree/bindings/media/qcom,camss.txt
@@ -5,8 +5,9 @@ Qualcomm Camera Subsystem
 - compatible:
 	Usage: required
 	Value type: <stringlist>
-	Definition: Should contain:
+	Definition: Should contain one of:
 		- "qcom,msm8916-camss"
+		- "qcom,msm8996-camss"
 - reg:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -19,11 +20,16 @@ Qualcomm Camera Subsystem
 		- "csiphy0_clk_mux"
 		- "csiphy1"
 		- "csiphy1_clk_mux"
+		- "csiphy2"		(8996 only)
+		- "csiphy2_clk_mux"	(8996 only)
 		- "csid0"
 		- "csid1"
+		- "csid2"		(8996 only)
+		- "csid3"		(8996 only)
 		- "ispif"
 		- "csi_clk_mux"
 		- "vfe0"
+		- "vfe1"		(8996 only)
 - interrupts:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -34,10 +40,14 @@ Qualcomm Camera Subsystem
 	Definition: Should contain the following entries:
 		- "csiphy0"
 		- "csiphy1"
+		- "csiphy2"		(8996 only)
 		- "csid0"
 		- "csid1"
+		- "csid2"		(8996 only)
+		- "csid3"		(8996 only)
 		- "ispif"
 		- "vfe0"
+		- "vfe1"		(8996 only)
 - power-domains:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -57,6 +67,7 @@ Qualcomm Camera Subsystem
 		- "ispif_ahb"
 		- "csiphy0_timer"
 		- "csiphy1_timer"
+		- "csiphy2_timer"	(8996 only)
 		- "csi0_ahb"
 		- "csi0"
 		- "csi0_phy"
@@ -67,9 +78,25 @@ Qualcomm Camera Subsystem
 		- "csi1_phy"
 		- "csi1_pix"
 		- "csi1_rdi"
+		- "csi2_ahb"		(8996 only)
+		- "csi2"		(8996 only)
+		- "csi2_phy"		(8996 only)
+		- "csi2_pix"		(8996 only)
+		- "csi2_rdi"		(8996 only)
+		- "csi3_ahb"		(8996 only)
+		- "csi3"		(8996 only)
+		- "csi3_phy"		(8996 only)
+		- "csi3_pix"		(8996 only)
+		- "csi3_rdi"		(8996 only)
 		- "ahb"
 		- "vfe0"
 		- "csi_vfe0"
+		- "vfe0_ahb",		(8996 only)
+		- "vfe0_stream",	(8996 only)
+		- "vfe1",		(8996 only)
+		- "csi_vfe1",		(8996 only)
+		- "vfe1_ahb",		(8996 only)
+		- "vfe1_stream",	(8996 only)
 		- "vfe_ahb"
 		- "vfe_axi"
 - vdda-supply:
@@ -90,14 +117,18 @@ Qualcomm Camera Subsystem
 		- reg:
 			Usage: required
 			Value type: <u32>
-			Definition: Selects CSI2 PHY interface - PHY0 or PHY1.
+			Definition: Selects CSI2 PHY interface - PHY0, PHY1
+				    or PHY2 (8996 only)
 	Endpoint node properties:
 		- clock-lanes:
 			Usage: required
 			Value type: <u32>
-			Definition: The physical clock lane index. The value
-				    must always be <1> as the physical clock
-				    lane is lane 1.
+			Definition: The physical clock lane index. On 8916
+				    the value must always be <1> as the physical
+				    clock lane is lane 1. On 8996 the value must
+				    always be <7> as the hardware supports D-PHY
+				    and C-PHY, indexes are in a common set and
+				    D-PHY physical clock lane is labeled as 7.
 		- data-lanes:
 			Usage: required
 			Value type: <prop-encoded-array>
@@ -105,7 +136,8 @@ Qualcomm Camera Subsystem
 				    Position of an entry determines the logical
 				    lane number, while the value of an entry
 				    indicates physical lane index. Lane swapping
-				    is supported.
+				    is supported. Physical lane indexes for
+				    8916: 0, 2, 3, 4; for 8996: 0, 1, 2, 3.
 
 * An Example
 
-- 
2.7.4

