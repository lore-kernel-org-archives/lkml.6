Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeC2GTG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 02:19:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37200 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeC2GTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 02:19:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4AD5E60AE0
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
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 2/2] dt-bindings: clock: Introduce QCOM RPMh clock bindings
Date: Thu, 29 Mar 2018 11:47:53 +0530
Message-Id: <1522304274-18989-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522304274-18989-1-git-send-email-tdas@codeaurora.org>
References: <1522304274-18989-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Nischal <anischal@codeaurora.org>

Add RPMh clock device bindings for Qualcomm Technology Inc's SoCs. These
devices would be used for communicating resource state requests to control
the clocks managed by RPMh.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,rpmh.txt        | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmh.txt

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmh.txt b/Documentation/devicetree/bindings/clock/qcom,rpmh.txt
new file mode 100644
index 0000000..8222c88
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmh.txt
@@ -0,0 +1,22 @@
+Qualcomm Technologies, Inc. RPMh Clocks
+-------------------------------------------------------
+
+Resource Power Manager Hardened (RPMh) manages shared resources on
+some Qualcomm Technologies Inc. SoCs. It accepts clock requests from
+other hardware subsystems via RSC to control clocks.
+
+Required properties :
+- compatible : shall contain "qcom,rpmh-clk-sdm845"
+
+- #clock-cells : must contain 1
+
+Example :
+
+#include <dt-bindings/clock/qcom,rpmh.h>
+
+	&apps_rsc {
+		clock_rpmh: qcom,rpmhclk {
+		compatible = "qcom,rpmh-clk-sdm845";
+		#clock-cells = <1>;
+		};
+	};
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
