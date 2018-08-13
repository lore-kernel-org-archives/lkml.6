Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88994C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D551217FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZTFgWHGP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y0nXuuPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D551217FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeHMJO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:14:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42056 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbeHMJO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:14:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4DB1160B6B; Mon, 13 Aug 2018 06:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534142047;
        bh=y/nBwQkSeVMPfUZLRXJeuFmQk8Duhcmql/6Qy5H2o28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTFgWHGPA4SOTF5FXSYyx8nKaWCSs/19YcG/s/LKKXguXmUiJ7VoPIqejg/ZwyxwZ
         cLA7N8whyopQI5OBXyGfe0c74Tk7XXSwir+mxdGK5xLKCC30Ybgrsw/bwfcb0yFGMq
         Dapsec4Eql1TsOySVwNN12emZIIj3bLdN0etv5cI=
Received: from anischal-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anischal@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CEE20604BE;
        Mon, 13 Aug 2018 06:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534142046;
        bh=y/nBwQkSeVMPfUZLRXJeuFmQk8Duhcmql/6Qy5H2o28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y0nXuuPR+Y3JM0Ruvun9+Vk9dmyAT1kN0tBRfbwsT6WPxXt7zd3mYB/Qyz5UgOcfS
         An95H/8yiDjVwe/72V4Si/wDpa2ZdOp6uL6xj6YXNyASGeoTINk9rUuVIDeca2vTSD
         127vhzrPr7mIbySX3BeyDgW5oeMVDCx87/dkaS58=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CEE20604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From:   Amit Nischal <anischal@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v3 3/4] dt-bindings: clock: Introduce QCOM Graphics clock bindings
Date:   Mon, 13 Aug 2018 12:03:06 +0530
Message-Id: <1534141987-29601-4-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534141987-29601-1-git-send-email-anischal@codeaurora.org>
References: <1534141987-29601-1-git-send-email-anischal@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for graphics clock controller for
Qualcomm Technology Inc's SDM845 SoCs.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,gpucc.txt       | 18 ++++++++++
 include/dt-bindings/clock/qcom,gpucc-sdm845.h      | 38 ++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc.txt
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sdm845.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.txt b/Documentation/devicetree/bindings/clock/qcom,gpucc.txt
new file mode 100644
index 0000000..93752db
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.txt
@@ -0,0 +1,18 @@
+Qualcomm Graphics Clock & Reset Controller Binding
+--------------------------------------------------
+
+Required properties :
+- compatible : shall contain "qcom,sdm845-gpucc".
+- reg : shall contain base register location and length.
+- #clock-cells : from common clock binding, shall contain 1.
+- #reset-cells : from common reset binding, shall contain 1.
+- #power-domain-cells : from generic power domain binding, shall contain 1.
+
+Example:
+	gpucc: clock-controller@5090000 {
+		compatible = "qcom,sdm845-gpucc";
+		reg = <0x5090000 0x9000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+		#power-domain-cells = <1>;
+	};
diff --git a/include/dt-bindings/clock/qcom,gpucc-sdm845.h b/include/dt-bindings/clock/qcom,gpucc-sdm845.h
new file mode 100644
index 0000000..643b42a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gpucc-sdm845.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_GPU_CC_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_GPU_CC_SDM845_H
+
+/* GPU_CC clock registers */
+#define GPU_CC_CRC_AHB_CLK			0
+#define GPU_CC_CX_APB_CLK			1
+#define GPU_CC_CX_GFX3D_CLK			2
+#define GPU_CC_CX_GFX3D_SLV_CLK			3
+#define GPU_CC_CX_GMU_CLK			4
+#define GPU_CC_CX_SNOC_DVM_CLK			5
+#define GPU_CC_CXO_CLK				6
+#define GPU_CC_GMU_CLK_SRC			7
+#define GPU_CC_GX_GMU_CLK			8
+#define GPU_CC_GX_GFX3D_CLK_SRC			9
+#define GPU_CC_GX_GFX3D_CLK			10
+#define GPU_CC_PLL0				11
+#define GPU_CC_PLL0_OUT_EVEN			12
+#define GPU_CC_PLL1				13
+
+/* GPU_CC Resets */
+#define GPUCC_GPU_CC_ACD_BCR			0
+#define GPUCC_GPU_CC_CX_BCR			1
+#define GPUCC_GPU_CC_GFX3D_AON_BCR		2
+#define GPUCC_GPU_CC_GMU_BCR			3
+#define GPUCC_GPU_CC_GX_BCR			4
+#define GPUCC_GPU_CC_SPDM_BCR			5
+#define GPUCC_GPU_CC_XO_BCR			6
+
+/* GPU_CC GDSCRs */
+#define GPU_CX_GDSC				0
+#define GPU_GX_GDSC				1
+
+#endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

