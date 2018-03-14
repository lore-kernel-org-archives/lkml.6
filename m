Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeCNROU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:14:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52500 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeCNRNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:13:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BDB6360AF9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc: linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, Lina Iyer <ilina@codeaurora.org>,
        devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: [PATCH v5 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Date: Wed, 14 Mar 2018 11:13:30 -0600
Message-Id: <20180314171330.1828-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180314171330.1828-1-ilina@codeaurora.org>
References: <20180314171330.1828-1-ilina@codeaurora.org>
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

Changes in v4:
	- Fix unwanted capitalization
	- Add reg property
---
 .../devicetree/bindings/soc/qcom/cmd-db.txt        | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/cmd-db.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/cmd-db.txt b/Documentation/devicetree/bindings/soc/qcom/cmd-db.txt
new file mode 100644
index 000000000000..5737ed2ac6e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/cmd-db.txt
@@ -0,0 +1,38 @@
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
+The bindings for Command DB is specified in the reserved-memory section in
+devicetree. The devicetree representation of the command DB driver should be:
+
+Properties:
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: Should be "qcom,cmd-db"
+
+- reg:
+	Usage: required
+	Value type: <prop encoded array>
+	Definition: The register address that points to the location of the
+		    Command DB in memory. Additionally, specify the address
+		    and size of the actual lacation in memory.
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
