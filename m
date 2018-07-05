Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6327BC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2748123E90
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2748123E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754431AbeGENkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:40:53 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:41290 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753657AbeGENdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:33:21 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 220BACD50;
        Thu,  5 Jul 2018 16:33:17 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 08/34] media: camss: Unify the clock names
Date:   Thu,  5 Jul 2018 16:32:39 +0300
Message-Id: <1530797585-8555-9-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
References: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify the clock names - use names closer to the clock
definitions.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: devicetree@vger.kernel.org
Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 .../devicetree/bindings/media/qcom,camss.txt       | 24 +++++++++++-----------
 drivers/media/platform/qcom/camss/camss.c          | 20 ++++++++----------
 2 files changed, 20 insertions(+), 24 deletions(-)

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
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index abf6184..0b663e0 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -32,8 +32,7 @@ static const struct resources csiphy_res[] = {
 	/* CSIPHY0 */
 	{
 		.regulator = { NULL },
-		.clock = { "camss_top_ahb", "ispif_ahb",
-			   "camss_ahb", "csiphy0_timer" },
+		.clock = { "top_ahb", "ispif_ahb", "ahb", "csiphy0_timer" },
 		.clock_rate = { { 0 },
 				{ 0 },
 				{ 0 },
@@ -45,8 +44,7 @@ static const struct resources csiphy_res[] = {
 	/* CSIPHY1 */
 	{
 		.regulator = { NULL },
-		.clock = { "camss_top_ahb", "ispif_ahb",
-			   "camss_ahb", "csiphy1_timer" },
+		.clock = { "top_ahb", "ispif_ahb", "ahb", "csiphy1_timer" },
 		.clock_rate = { { 0 },
 				{ 0 },
 				{ 0 },
@@ -60,8 +58,7 @@ static const struct resources csid_res[] = {
 	/* CSID0 */
 	{
 		.regulator = { "vdda" },
-		.clock = { "camss_top_ahb", "ispif_ahb",
-			   "csi0_ahb", "camss_ahb",
+		.clock = { "top_ahb", "ispif_ahb", "csi0_ahb", "ahb",
 			   "csi0", "csi0_phy", "csi0_pix", "csi0_rdi" },
 		.clock_rate = { { 0 },
 				{ 0 },
@@ -78,8 +75,7 @@ static const struct resources csid_res[] = {
 	/* CSID1 */
 	{
 		.regulator = { "vdda" },
-		.clock = { "camss_top_ahb", "ispif_ahb",
-			   "csi1_ahb", "camss_ahb",
+		.clock = { "top_ahb", "ispif_ahb", "csi1_ahb", "ahb",
 			   "csi1", "csi1_phy", "csi1_pix", "csi1_rdi" },
 		.clock_rate = { { 0 },
 				{ 0 },
@@ -96,10 +92,10 @@ static const struct resources csid_res[] = {
 
 static const struct resources_ispif ispif_res = {
 	/* ISPIF */
-	.clock = { "camss_top_ahb", "camss_ahb", "ispif_ahb",
+	.clock = { "top_ahb", "ahb", "ispif_ahb",
 		   "csi0", "csi0_pix", "csi0_rdi",
 		   "csi1", "csi1_pix", "csi1_rdi" },
-	.clock_for_reset = { "camss_vfe_vfe", "camss_csi_vfe" },
+	.clock_for_reset = { "vfe0", "csi_vfe0" },
 	.reg = { "ispif", "csi_clk_mux" },
 	.interrupt = "ispif"
 
@@ -108,8 +104,8 @@ static const struct resources_ispif ispif_res = {
 static const struct resources vfe_res = {
 	/* VFE0 */
 	.regulator = { NULL },
-	.clock = { "camss_top_ahb", "camss_vfe_vfe", "camss_csi_vfe",
-		   "iface", "bus", "camss_ahb" },
+	.clock = { "top_ahb", "vfe0", "csi_vfe0",
+		   "vfe_ahb", "vfe_axi", "ahb" },
 	.clock_rate = { { 0 },
 			{ 50000000, 80000000, 100000000, 160000000,
 			  177780000, 200000000, 266670000, 320000000,
-- 
2.7.4

