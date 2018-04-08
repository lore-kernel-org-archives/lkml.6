Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeDHKco (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 06:32:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53582 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbeDHKck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 06:32:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E4C260541
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
Subject: [[PATCH v2] 2/2] dt-bindings: clock: Introduce QCOM RPMh clock bindings
Date: Sun,  8 Apr 2018 16:02:13 +0530
Message-Id: <1523183533-23171-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523183533-23171-1-git-send-email-tdas@codeaurora.org>
References: <1523183533-23171-1-git-send-email-tdas@codeaurora.org>
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
 .../devicetree/bindings/clock/qcom,rpmh-clk.txt    | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt b/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
new file mode 100644
index 0000000..4ade82b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
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
+		rpmh: clock-controller {
+			compatible = "qcom,rpmh-clk-sdm845";
+			#clock-cells = <1>;
+		};
+	};
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
