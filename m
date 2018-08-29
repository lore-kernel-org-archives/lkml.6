Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0E6C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873EF205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oYBKOZ5d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JucZNkrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873EF205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeH2XLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:11:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeH2XLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:11:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7EB536063F; Wed, 29 Aug 2018 19:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535569962;
        bh=Hm3OBGOt7g6jSMl2zPxhchR02WL/oBCSsvGXV8/peYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYBKOZ5dYlqMzH+biwUBm6OzoATcnomzbEcaZWZrcKQLPGAFsL896KOUXjTfOt5cF
         k2QkN9ZPwgya7TDdAkVYa7bpNmUjz0J+1JxA3XdK0egEtFOjB2VqfR836zDLdKx0b3
         OKRyDJ1T+PN0pW9ZxSDqx6Xp5y5JJLw30+gOGRZw=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A52660540;
        Wed, 29 Aug 2018 19:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535569961;
        bh=Hm3OBGOt7g6jSMl2zPxhchR02WL/oBCSsvGXV8/peYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JucZNkrBe0f6PdMVf58B2LddbYYJEIF1ZCFJMSjBaDXr/6jAWieDuBJXBI+M4XJVC
         qrV1UZTtmvKJAFU9lhYEfxePi4D4HhYdsTMcMjCIT5qOVkRwxt45JPQOBJ8UhJccEj
         zl4gByb0iSDNNwWXgwJhiujXZsE3LarqdFb6EZIY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A52660540
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        mka@chromium.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 1/6] dt-bindings: reset: Add PDC Global binding for SDM845 SoCs
Date:   Thu, 30 Aug 2018 00:42:10 +0530
Message-Id: <20180829191215.10071-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180829191215.10071-1-sibis@codeaurora.org>
References: <20180829191215.10071-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDC Global (Power Domain Controller) binding for SDM845 SoCs.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../bindings/reset/qcom,pdc-global.txt        | 52 +++++++++++++++++++
 include/dt-bindings/reset/qcom,sdm845-pdc.h   | 20 +++++++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
 create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h

diff --git a/Documentation/devicetree/bindings/reset/qcom,pdc-global.txt b/Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
new file mode 100644
index 000000000000..a62a492843e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
@@ -0,0 +1,52 @@
+PDC Global
+======================================
+
+This binding describes a reset-controller found on PDC-Global (Power Domain
+Controller) block for Qualcomm Technologies Inc SDM845 SoCs.
+
+Required properties:
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be:
+		    "qcom,sdm845-pdc-global"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must specify the base address and size of the register
+	            space.
+
+- #reset-cells:
+	Usage: required
+	Value type: <uint>
+	Definition: must be 1; cell entry represents the reset index.
+
+Example:
+
+pdc_reset: reset-controller@b2e0000 {
+	compatible = "qcom,sdm845-pdc-global";
+	reg = <0xb2e0000 0x20000>;
+	#reset-cells = <1>;
+};
+
+PDC reset clients
+======================================
+
+Device nodes that need access to reset lines should
+specify them as a reset phandle in their corresponding node as
+specified in reset.txt.
+
+For a list of all valid reset indices see
+<dt-bindings/reset/qcom,sdm845-pdc.h>
+
+Example:
+
+modem-pil@4080000 {
+	...
+
+	resets = <&pdc_reset PDC_MODEM_SYNC_RESET>;
+	reset-names = "pdc_reset";
+
+	...
+};
diff --git a/include/dt-bindings/reset/qcom,sdm845-pdc.h b/include/dt-bindings/reset/qcom,sdm845-pdc.h
new file mode 100644
index 000000000000..53c37f9c319a
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,sdm845-pdc.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_RESET_PDC_SDM_845_H
+#define _DT_BINDINGS_RESET_PDC_SDM_845_H
+
+#define PDC_APPS_SYNC_RESET	0
+#define PDC_SP_SYNC_RESET	1
+#define PDC_AUDIO_SYNC_RESET	2
+#define PDC_SENSORS_SYNC_RESET	3
+#define PDC_AOP_SYNC_RESET	4
+#define PDC_DEBUG_SYNC_RESET	5
+#define PDC_GPU_SYNC_RESET	6
+#define PDC_DISPLAY_SYNC_RESET	7
+#define PDC_COMPUTE_SYNC_RESET	8
+#define PDC_MODEM_SYNC_RESET	9
+
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

