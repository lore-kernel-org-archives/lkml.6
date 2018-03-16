Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbeCPEI5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 00:08:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49118 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeCPEIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 00:08:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2407360C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 3/7] dt-bindings: opp: Introduce qcom-opp bindings
Date: Fri, 16 Mar 2018 09:38:20 +0530
Message-Id: <20180316040824.21472-4-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180316040824.21472-1-rnayak@codeaurora.org>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Qualcomm platforms, an OPP node needs to describe an
additional level/corner value that is then communicated to
a remote microprocessor by the CPU, which then takes some
actions (like adjusting voltage values across various rails)
based on the value passed.

Describe these bindings in the qcom-opp bindings document.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 Documentation/devicetree/bindings/opp/qcom-opp.txt | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt

diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
new file mode 100644
index 000000000000..56fe87751881
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
@@ -0,0 +1,25 @@
+Qualcomm OPP bindings to descibe OPP nodes with corner/level values
+
+OPP tables for devices on qualcomm platforms require an additional
+platform specific corner/level value to be specified.
+This value is passed on to the RPM (Resource Power Manager) by
+the CPU, which then takes the necessary actions to set a voltage
+rail to a appropriate voltage based on the value passed.
+
+The bindings are based on top of the operating-points-v2 bindings
+described in Documentation/devicetree/bindings/opp/opp.txt
+Additional properties are described below.
+
+* OPP Table Node
+
+Required properties:
+- compatible: Allow OPPs to express their compatibility. It should be:
+  "operating-points-v2-qcom"
+
+* OPP Node
+
+Required properties:
+- qcom,level: On Qualcomm platforms an OPP node can describe a positive value
+representing a corner/level thats comminicated with a remote microprocessor
+(Usually called the RPM) which then translates it into a certain voltage on
+a voltage rail.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
