Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755798AbeEHUXB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 16:23:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42360 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755647AbeEHUW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 16:22:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4817D60712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From: Rishabh Bhatnagar <rishabhb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org,
        tsoni@codeaurora.org, ckadabi@codeaurora.org, evgreen@chromium.org,
        robh@kernel.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v6 1/2] dt-bindings: Documentation for qcom, llcc
Date: Tue,  8 May 2018 13:22:00 -0700
Message-Id: <1525810921-15878-2-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525810921-15878-1-git-send-email-rishabhb@codeaurora.org>
References: <1525810921-15878-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for last level cache controller device tree bindings,
client bindings usage examples.

Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
new file mode 100644
index 0000000..a586a17
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
@@ -0,0 +1,32 @@
+== Introduction==
+
+LLCC (Last Level Cache Controller) provides last level of cache memory in SOC,
+that can be shared by multiple clients. Clients here are different cores in the
+SOC, the idea is to minimize the local caches at the clients and migrate to
+common pool of memory. Cache memory is divided into partitions called slices
+which are assigned to clients. Clients can query the slice details, activate
+and deactivate them.
+
+Properties:
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qcom,sdm845-llcc"
+
+- reg:
+	Usage: required
+	Value Type: <prop-encoded-array>
+	Definition: Start address and the range of the LLCC registers.
+
+- max-slices:
+	usage: required
+	Value Type: <u32>
+	Definition: Number of cache slices supported by hardware
+
+Example:
+
+	llcc: qcom,llcc@1100000 {
+		compatible = "qcom,sdm845-llcc";
+		reg = <0x1100000 0x250000>;
+		max-slices = <32>;
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
