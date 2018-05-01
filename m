Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbeEAIl7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:41:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53784 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbeEAIlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:41:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B211560F6E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [v5 1/2] dt-bindings: clock: Introduce QCOM RPMh clock bindings
Date: Tue,  1 May 2018 14:11:32 +0530
Message-Id: <1525164093-16645-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525164093-16645-1-git-send-email-tdas@codeaurora.org>
References: <1525164093-16645-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPMh clock device bindings for Qualcomm Technology Inc's SoCs. These
devices would be used for communicating resource state requests to control
the clocks managed by RPMh.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
Signed-off-by: Taniya Das <tdas@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/qcom,rpmh-clk.txt    | 32 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,rpmh.h              | 24 ++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
 create mode 100644 include/dt-bindings/clock/qcom,rpmh.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt b/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
new file mode 100644
index 0000000..ecc1dbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
@@ -0,0 +1,32 @@
+Qualcomm Technologies, Inc. RPMh Clocks
+-------------------------------------------------------
+
+Resource Power Manager Hardened (RPMh) manages shared resources on
+some Qualcomm Technologies Inc. SoCs. It accepts clock requests from
+other hardware subsystems via RSC to control clocks.
+
+Required properties :
+- compatible : shall contain "qcom,sdm845-rpmh-clk"
+
+- #clock-cells : must contain 1
+
+Optional properties :
+- assigned-clk-divs : property should contain a list of divs for each clock in
+			the clk-output-names property. In case divs are not
+			provided the clock rate would be same as parent rate.
+- clk-output-names :  a list of strings of clock output signal for the divs to
+			 be applied.
+
+Example :
+
+#include <dt-bindings/clock/qcom,rpmh.h>
+
+	&apps_rsc {
+		rpmhcc: clock-controller {
+			compatible = "qcom,sdm845-rpmh-clk";
+			#clock-cells = <1>;
+			assigned-clk-divs = <2 2 2>;
+			clk-output-names = "bi_tcxo", "lnbb_clk2",
+						"lnbb_clk3";
+		};
+	};
diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/clock/qcom,rpmh.h
new file mode 100644
index 0000000..36caab2
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,rpmh.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+
+
+#ifndef _DT_BINDINGS_CLK_MSM_RPMH_H
+#define _DT_BINDINGS_CLK_MSM_RPMH_H
+
+/* RPMh controlled clocks */
+#define RPMH_CXO_CLK				0
+#define RPMH_CXO_CLK_A				1
+#define RPMH_LN_BB_CLK2				2
+#define RPMH_LN_BB_CLK2_A			3
+#define RPMH_LN_BB_CLK3				4
+#define RPMH_LN_BB_CLK3_A			5
+#define RPMH_RF_CLK1				6
+#define RPMH_RF_CLK1_A				7
+#define RPMH_RF_CLK2				8
+#define RPMH_RF_CLK2_A				9
+#define RPMH_RF_CLK3				10
+#define RPMH_RF_CLK3_A				11
+#define RPMH_RF_CLK4				12
+#define RPMH_RF_CLK4_A				13
+
+#endif
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
