Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934234AbeEILdE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:33:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54600 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934018AbeEILdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:33:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2593A60F8F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From: Amit Nischal <anischal@codeaurora.org>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v2 1/2] dt-bindings: clock: Introduce QCOM Video clock bindings
Date: Wed,  9 May 2018 17:02:30 +0530
Message-Id: <1525865551-20489-2-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525865551-20489-1-git-send-email-anischal@codeaurora.org>
References: <1525865551-20489-1-git-send-email-anischal@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for video clock controller for
Qualcomm Technology Inc's SoCs.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,videocc.txt     | 19 ++++++++++++
 include/dt-bindings/clock/qcom,videocc-sdm845.h    | 35 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,videocc.txt
 create mode 100644 include/dt-bindings/clock/qcom,videocc-sdm845.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.txt b/Documentation/devicetree/bindings/clock/qcom,videocc.txt
new file mode 100644
index 0000000..e7c035a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.txt
@@ -0,0 +1,19 @@
+Qualcomm Video Clock & Reset Controller Binding
+-----------------------------------------------
+
+Required properties :
+- compatible : shall contain "qcom,sdm845-videocc"
+- reg : shall contain base register location and length
+- #clock-cells : from common clock binding, shall contain 1.
+- #power-domain-cells : from generic power domain binding, shall contain 1.
+
+Optional properties :
+- #reset-cells : from common reset binding, shall contain 1.
+
+Example:
+	videocc: clock-controller@ab00000 {
+		compatible = "qcom,sdm845-videocc";
+		reg = <0xab00000 0x10000>;
+		#clock-cells = <1>;
+		#power-domain-cells = <1>;
+	};
diff --git a/include/dt-bindings/clock/qcom,videocc-sdm845.h b/include/dt-bindings/clock/qcom,videocc-sdm845.h
new file mode 100644
index 0000000..1b86816
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,videocc-sdm845.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_VIDEO_CC_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_VIDEO_CC_SDM845_H
+
+/* VIDEO_CC clock registers */
+#define VIDEO_CC_APB_CLK		0
+#define VIDEO_CC_AT_CLK			1
+#define VIDEO_CC_QDSS_TRIG_CLK		2
+#define VIDEO_CC_QDSS_TSCTR_DIV8_CLK	3
+#define VIDEO_CC_VCODEC0_AXI_CLK	4
+#define VIDEO_CC_VCODEC0_CORE_CLK	5
+#define VIDEO_CC_VCODEC1_AXI_CLK	6
+#define VIDEO_CC_VCODEC1_CORE_CLK	7
+#define VIDEO_CC_VENUS_AHB_CLK		8
+#define VIDEO_CC_VENUS_CLK_SRC		9
+#define VIDEO_CC_VENUS_CTL_AXI_CLK	10
+#define VIDEO_CC_VENUS_CTL_CORE_CLK	11
+#define VIDEO_PLL0			12
+
+/* VIDEO_CC Resets */
+#define VIDEO_CC_VENUS_BCR		0
+#define VIDEO_CC_VCODEC0_BCR		1
+#define VIDEO_CC_VCODEC1_BCR		2
+#define VIDEO_CC_INTERFACE_BCR		3
+
+/* VIDEO_CC GDSCRs */
+#define VENUS_GDSC			0
+#define VCODEC0_GDSC			1
+#define VCODEC1_GDSC			2
+
+#endif
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
