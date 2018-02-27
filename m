Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753788AbeB0OMr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:12:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54436 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753547AbeB0OIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:08:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8BC6A60BEB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: viresh.kumar@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, robh@kernel.org, sricharan@codeaurora.org,
        linux@arm.linux.org.uk
Subject: [PATCH v8 05/15] dt-bindings: clock: Document qcom,hfpll
Date: Tue, 27 Feb 2018 19:36:52 +0530
Message-Id: <1519740422-3835-6-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
References: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Adds bindings document for qcom,hfpll instantiated within
the Krait processor subsystem as separate register region.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,hfpll.txt       | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,hfpll.txt

diff --git a/Documentation/devicetree/bindings/clock/qcom,hfpll.txt b/Documentation/devicetree/bindings/clock/qcom,hfpll.txt
new file mode 100644
index 0000000..771cb0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,hfpll.txt
@@ -0,0 +1,46 @@
+High-Frequency PLL (HFPLL)
+
+PROPERTIES
+
+- compatible:
+	Usage: required
+	Value type: <string>:
+		shall contain only one of the following. The generic
+		compatible "qcom,hfpll" should be also included.
+
+                        "qcom,hfpll-ipq8064", "qcom,hfpll"
+                        "qcom,hfpll-apq8064", "qcom,hfpll"
+                        "qcom,hfpll-msm8974", "qcom,hfpll"
+                        "qcom,hfpll-msm8960", "qcom,hfpll"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: address and size of HPLL registers. An optional second
+		    element specifies the address and size of the alias
+		    register region.
+
+- clock-output-names:
+	Usage: required
+	Value type: <string>
+	Definition: Name of the PLL. Typically hfpllX where X is a CPU number
+		    starting at 0. Otherwise hfpll_Y where Y is more specific
+		    such as "l2".
+
+Example:
+
+1) An HFPLL for the L2 cache.
+
+	clock-controller@f9016000 {
+		compatible = "qcom,hfpll-ipq8064", "qcom,hfpll";
+		reg = <0xf9016000 0x30>;
+		clock-output-names = "hfpll_l2";
+	};
+
+2) An HFPLL for CPU0. This HFPLL has the alias register region.
+
+	clock-controller@f908a000 {
+		compatible = "qcom,hfpll-ipq8064", "qcom,hfpll";
+		reg = <0xf908a000 0x30>, <0xf900a000 0x30>;
+		clock-output-names = "hfpll0";
+	};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
