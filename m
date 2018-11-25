Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D322C04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 04:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437502086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 04:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nvl9UqOk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nvl9UqOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437502086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeKYP0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 10:26:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58882 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeKYP0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 10:26:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 89B5D6079C; Sun, 25 Nov 2018 04:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543120587;
        bh=SStUNadNDp88mqC2T/xLCxjW2QV8V19SYDG+Wrwma9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nvl9UqOkiXIuluWmOdqxrlZM6FAc0aKMKKS64JCMakoqCYYBFcZVoLYNtVfrqn9r6
         FYtZeEVNSJw8Tyb3YA+Smxlumu416vmT4otXKj0JsLFnSQEcuaYCWCLCY/w4NSNAd6
         QepO1iuMecU66qbXZgw1OahKeYk1E/vNd1emocLI=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72DC1602D7;
        Sun, 25 Nov 2018 04:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543120587;
        bh=SStUNadNDp88mqC2T/xLCxjW2QV8V19SYDG+Wrwma9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nvl9UqOkiXIuluWmOdqxrlZM6FAc0aKMKKS64JCMakoqCYYBFcZVoLYNtVfrqn9r6
         FYtZeEVNSJw8Tyb3YA+Smxlumu416vmT4otXKj0JsLFnSQEcuaYCWCLCY/w4NSNAd6
         QepO1iuMecU66qbXZgw1OahKeYk1E/vNd1emocLI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72DC1602D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v4 1/2] dt-bindings: clock: Introduce QCOM Graphics clock bindings
Date:   Sun, 25 Nov 2018 10:06:07 +0530
Message-Id: <1543120569-14444-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543120569-14444-1-git-send-email-tdas@codeaurora.org>
References: <1543120569-14444-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Nischal <anischal@codeaurora.org>

Add device tree bindings for graphics clock controller for
Qualcomm Technology Inc's SDM845 SoCs.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,gpucc.txt       | 18 ++++++++++++++++
 include/dt-bindings/clock/qcom,gpucc-sdm845.h      | 24 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)
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
index 0000000..9690d90
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gpucc-sdm845.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_GPU_CC_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_GPU_CC_SDM845_H
+
+/* GPU_CC clock registers */
+#define GPU_CC_CX_GMU_CLK			0
+#define GPU_CC_CXO_CLK				1
+#define GPU_CC_GMU_CLK_SRC			2
+#define GPU_CC_PLL1				3
+
+/* GPU_CC Resets */
+#define GPUCC_GPU_CC_CX_BCR			0
+#define GPUCC_GPU_CC_GMU_BCR			1
+#define GPUCC_GPU_CC_XO_BCR			2
+
+/* GPU_CC GDSCRs */
+#define GPU_CX_GDSC				0
+#define GPU_GX_GDSC				1
+
+#endif
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

