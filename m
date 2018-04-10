Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753315AbeDJUJW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:09:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37478 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeDJUJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:09:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47DEF6081C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From: Rishabh Bhatnagar <rishabhb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, kyan@codeaurora.org, ckadabi@codeaurora.org,
        stanimir.varbanov@linaro.org, evgreen@chromium.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v4 1/2] Documentation: Documentation for qcom, llcc
Date: Tue, 10 Apr 2018 13:08:12 -0700
Message-Id: <1523390893-10904-2-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523390893-10904-1-git-send-email-rishabhb@codeaurora.org>
References: <1523390893-10904-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for last level cache controller device tree bindings,
client bindings usage examples.

Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
new file mode 100644
index 0000000..497cf0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
@@ -0,0 +1,58 @@
+== Introduction==
+
+LLCC (Last Level Cache Controller) provides last level of cache memory in SOC,
+that can be shared by multiple clients. Clients here are different cores in the
+SOC, the idea is to minimize the local caches at the clients and migrate to
+common pool of memory
+
+Properties:
+- compatible:
+	 Usage: required
+	 Value type: <string>
+	 Definition: must be "qcom,sdm845-llcc"
+
+- reg:
+	 Usage: required
+	 Value Type: <prop-encoded-array>
+	 Definition: must be addresses and sizes of the LLCC registers
+
+- #cache-cells:
+	 Usage: required
+	 Value Type: <u32>
+	 Definition: Number of cache cells, must be 1
+
+- max-slices:
+	 usage: required
+	 Value Type: <u32>
+	 Definition: Number of cache slices supported by hardware
+
+Example:
+
+	llcc: qcom,llcc@1100000 {
+		compatible = "qcom,sdm845-llcc";
+		reg = <0x1100000 0x250000>;
+		#cache-cells = <1>;
+		max-slices = <32>;
+	};
+
+== Client ==
+
+Properties:
+- cache-slice-names:
+	 Usage: required
+	 Value type: <stringlist>
+	 Definition: A set of names that identify the usecase names of a
+			client that uses cache slice. These strings are
+			used to look up the cache slice entries by name.
+
+- cache-slices:
+	 Usage: required
+	 Value type: <prop-encoded-array>
+	 Definition: The tuple has phandle to llcc device as the first
+			argument and the second argument is the usecase
+			id of the client.
+For Example:
+	venus {
+		cache-slice-names = "vidsc0", "vidsc1";
+	 	cache-slices = <&llcc VIDSC0_ID>, <&llcc VIDSC1_ID>;
+	};
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
