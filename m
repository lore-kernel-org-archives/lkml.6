Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C55C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61806208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AmdcHxUL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MbxQKX8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61806208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388785AbeG0Quu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:50:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57692 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732143AbeG0Qut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:50:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 51B9960481; Fri, 27 Jul 2018 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532705304;
        bh=ufMeDiTiQBILFJ97ut1Zwrka7u4qNQCX/o+I6+AiyaA=;
        h=From:To:Cc:Subject:Date:From;
        b=AmdcHxULHSy7y46uscfpF1xzsHrFb7ku9a2NDzHwr+KiUAWSxZjBLLmYQ9UDsvjD3
         ZOkzDc9mUQ/O3bv1Z6JvXxL3XU5zCNdsEpTVpPnQJaChNI4nFwlPoMXzEkwRLtyPut
         MHqjyURgWVXFEDvpFaTmqJkyJ0NdTfyDCX8cDG4Q=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36FF460481;
        Fri, 27 Jul 2018 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532705303;
        bh=ufMeDiTiQBILFJ97ut1Zwrka7u4qNQCX/o+I6+AiyaA=;
        h=From:To:Cc:Subject:Date:From;
        b=MbxQKX8/jCFkXNgqmAs0pz5b4XiyerV7V1bOy/RBqK/coQwDTsMKK19QCMiDxrhyw
         7pxIPO7Kn0aXNPFV3E6VZTnISTWVVYvoAS+So8Mgd8E/qVoEjYjE7pFTTNnJrUDgox
         A/PNHPlCKEDnTOjbRxKz+QtfQ7yoAkj+PAuvBXMc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36FF460481
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 1/4] dt-bindings: reset: Add PDC reset binding for SDM845 SoCs
Date:   Fri, 27 Jul 2018 20:58:08 +0530
Message-Id: <20180727152811.15258-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SDM845 PDC (Power Domain Controller) reset controller binding

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../bindings/reset/qcom,pdc-reset.txt         | 52 +++++++++++++++++++
 include/dt-bindings/reset/qcom,sdm845-pdc.h   | 20 +++++++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
 create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h

diff --git a/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
new file mode 100644
index 000000000000..85e159962e08
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
@@ -0,0 +1,52 @@
+PDC Reset Controller
+======================================
+
+This binding describes a reset-controller found on PDC-Global(Power Domain
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
+For list of all valid reset indicies see
+<dt-bindings/reset/qcom,sdm845-pdc.h>
+
+Example:
+
+modem-pil@4080000 {
+	...
+
+	resets = <&pdc_reset PDC_MODEM_SYNC_RESET>;
+	reset-names = "pdc_restart";
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

