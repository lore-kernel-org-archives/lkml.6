Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeDJR5j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:57:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbeDJR5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:57:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3AD9860D81
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: [PATCH v8 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Date: Tue, 10 Apr 2018 11:57:24 -0600
Message-Id: <20180410175724.7165-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180410175724.7165-1-ilina@codeaurora.org>
References: <20180410175724.7165-1-ilina@codeaurora.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---

Changes in v8:
	- Fix node name
	- Add no-map property
Changes in v7:
	- Fix description of 'reg' property

Changes in v6:
	- Move to bindings/reserved-memory
	- Remove indirection address and use only the actual reserved
	  memory

Changes in v4:
	- Fix unwanted capitalization
	- Add reg property
---
 .../bindings/reserved-memory/qcom,cmd-db.txt       | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt

diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
new file mode 100644
index 000000000000..68395530c0a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
@@ -0,0 +1,37 @@
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
+	Definition: The register address that points to the actual location of
+		    the Command DB in memory.
+
+Example:
+
+	reserved-memory {
+		[...]
+		reserved-memory@85fe0000 {
+			reg = <0x0 0x85fe0000 0x0 0x20000>;
+			compatible = "qcom,cmd-db";
+			no-map;
+		};
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
