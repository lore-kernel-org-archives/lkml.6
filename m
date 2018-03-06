Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeCFOkl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:40:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932820AbeCFOki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:40:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3BB1608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk
Cc: sricharan@codeaurora.org
Subject: [PATCH v9 10/15] dt-bindings: arm: Document qcom,kpss-gcc
Date: Tue,  6 Mar 2018 20:09:03 +0530
Message-Id: <1520347148-27852-11-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520347148-27852-1-git-send-email-sricharan@codeaurora.org>
References: <1520347148-27852-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

The ACC and GCC regions present in KPSSv1 contain registers to
control clocks and power to each Krait CPU and L2. Documenting
the bindings here.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  |  7 +++++
 .../devicetree/bindings/arm/msm/qcom,kpss-gcc.txt  | 32 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
index 1333db9..382a574 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
@@ -21,10 +21,17 @@ PROPERTIES
 		    the register region. An optional second element specifies
 		    the base address and size of the alias register region.
 
+- clock-output-names:
+	Usage: optional
+	Value type: <string>
+	Definition: Name of the output clock. Typically acpuX_aux where X is a
+		    CPU number starting at 0.
+
 Example:
 
 	clock-controller@2088000 {
 		compatible = "qcom,kpss-acc-v2";
 		reg = <0x02088000 0x1000>,
 		      <0x02008000 0x1000>;
+		clock-output-names = "acpu0_aux";
 	};
diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
new file mode 100644
index 0000000..37fc0a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
@@ -0,0 +1,32 @@
+Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
+
+PROPERTIES
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: should be one of the following. The generic compatible
+			"qcom,kpss-gcc" should also be included.
+			"qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc"
+			"qcom,kpss-gcc-apq8064", "qcom,kpss-gcc"
+			"qcom,kpss-gcc-msm8974", "qcom,kpss-gcc"
+			"qcom,kpss-gcc-msm8960", "qcom,kpss-gcc"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: base address and size of the register region
+
+- clock-output-names:
+	Usage: required
+	Value type: <string>
+	Definition: Name of the output clock. Typically acpu_l2_aux indicating
+		    an L2 cache auxiliary clock.
+
+Example:
+
+	l2cc: clock-controller@2011000 {
+		compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc";
+		reg = <0x2011000 0x1000>;
+		clock-output-names = "acpu_l2_aux";
+	};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
