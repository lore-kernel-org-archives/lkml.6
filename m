Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeFDH4s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:56:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37212 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeFDH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:56:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C783E604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, robh@kernel.org
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 1/2] dt-bindings: clock: Introduce QCOM Display clock bindings
Date: Mon,  4 Jun 2018 13:26:24 +0530
Message-Id: <1528098985-3676-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528098985-3676-1-git-send-email-tdas@codeaurora.org>
References: <1528098985-3676-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for display clock controller for Qualcomm
Technology Inc's SoCs.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,dispcc.txt      | 19 +++++++++
 include/dt-bindings/clock/qcom,dispcc-sdm845.h     | 45 ++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc.txt
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sdm845.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc.txt b/Documentation/devicetree/bindings/clock/qcom,dispcc.txt
new file mode 100644
index 0000000..d639e18
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc.txt
@@ -0,0 +1,19 @@
+Qualcomm Technologies, Inc. Display Clock Controller Binding
+------------------------------------------------------------
+
+Required properties :
+
+- compatible : shall contain "qcom,sdm845-dispcc"
+- reg : shall contain base register location and length.
+- #clock-cells : from common clock binding, shall contain 1.
+- #reset-cells : from common reset binding, shall contain 1.
+- #power-domain-cells : from generic power domain binding, shall contain 1.
+
+Example:
+	dispcc: clock-controller@af00000 {
+		compatible = "qcom,sdm845-dispcc";
+		reg = <0xaf00000 0x100000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+		#power-domain-cells = <1>;
+	};
diff --git a/include/dt-bindings/clock/qcom,dispcc-sdm845.h b/include/dt-bindings/clock/qcom,dispcc-sdm845.h
new file mode 100644
index 0000000..11eed4b
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,dispcc-sdm845.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_DISP_CC_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_DISP_CC_SDM845_H
+
+/* DISP_CC clock registers */
+#define DISP_CC_MDSS_AHB_CLK					0
+#define DISP_CC_MDSS_AXI_CLK					1
+#define DISP_CC_MDSS_BYTE0_CLK					2
+#define DISP_CC_MDSS_BYTE0_CLK_SRC				3
+#define DISP_CC_MDSS_BYTE0_INTF_CLK				4
+#define DISP_CC_MDSS_BYTE1_CLK					5
+#define DISP_CC_MDSS_BYTE1_CLK_SRC				6
+#define DISP_CC_MDSS_BYTE1_INTF_CLK				7
+#define DISP_CC_MDSS_ESC0_CLK					8
+#define DISP_CC_MDSS_ESC0_CLK_SRC				9
+#define DISP_CC_MDSS_ESC1_CLK					10
+#define DISP_CC_MDSS_ESC1_CLK_SRC				11
+#define DISP_CC_MDSS_MDP_CLK					12
+#define DISP_CC_MDSS_MDP_CLK_SRC				13
+#define DISP_CC_MDSS_MDP_LUT_CLK				14
+#define DISP_CC_MDSS_PCLK0_CLK					15
+#define DISP_CC_MDSS_PCLK0_CLK_SRC				16
+#define DISP_CC_MDSS_PCLK1_CLK					17
+#define DISP_CC_MDSS_PCLK1_CLK_SRC				18
+#define DISP_CC_MDSS_ROT_CLK					19
+#define DISP_CC_MDSS_ROT_CLK_SRC				20
+#define DISP_CC_MDSS_RSCC_AHB_CLK				21
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK				22
+#define DISP_CC_MDSS_VSYNC_CLK					23
+#define DISP_CC_MDSS_VSYNC_CLK_SRC				24
+#define DISP_CC_PLL0						25
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC				26
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC				27
+
+/* DISP_CC Reset */
+#define DISP_CC_MDSS_RSCC_BCR					0
+
+/* DISP_CC GDSCR */
+#define MDSS_GDSC						0
+
+#endif
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
