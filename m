Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751023AbeBPWqz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 17:46:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46160 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbeBPWqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 17:46:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCFA360863
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org
Cc: sboyd@codeaurora.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>, devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: [PATCH v3 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Date: Fri, 16 Feb 2018 15:46:14 -0700
Message-Id: <20180216224614.24037-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180216224614.24037-1-ilina@codeaurora.org>
References: <20180216224614.24037-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahesh Sivasubramanian <msivasub@codeaurora.org>

Command DB provides information on shared resources like clocks,
regulators etc., probed at boot by the remote subsytem and made
available in shared memory.

Cc: devicetree@vger.kernel.org
Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 .../devicetree/bindings/arm/msm/cmd-db.txt         | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/cmd-db.txt

diff --git a/Documentation/devicetree/bindings/arm/msm/cmd-db.txt b/Documentation/devicetree/bindings/arm/msm/cmd-db.txt
new file mode 100644
index 000000000000..039be54fe9c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/cmd-db.txt
@@ -0,0 +1,30 @@
+Command DB
+---------
+
+Command DB is a database that provides a mapping between resource key and the
+resource address for a system resource managed by a remote processor. The data
+is stored in a shared memory region and is loaded by the remote processor.
+
+Some of the Qualcomm Technologies Inc SoC's have hardware accelerators for
+controlling shared resources. Depending on the board configuration the shared
+resource properties may change. These properties are dynamically probed by the
+remote processor and made available in the shared memory.
+
+The devicetree representation of the command DB driver should be:
+
+PROPERTIES:
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: Should be "qcom,cmd-db"
+
+Example:
+
+	reserved-memory {
+		[...]
+		qcom,cmd-db@c3f000c {
+			reg = <0x0 0xc3f000c 0x0 0x8>,
+			      <0x0 0x85fe0000 0x0 0x20000>;
+			compatible = "qcom,cmd-db";
+		};
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
