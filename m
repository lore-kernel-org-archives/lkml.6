Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757193AbeDZW7d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:59:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37574 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755522AbeDZW70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:59:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFB07605FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=clew@codeaurora.org
From: Chris Lew <clew@codeaurora.org>
To: bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: aneela@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        clew@codeaurora.org
Subject: [PATCH v3 1/6] dt-bindings: soc: qcom: Add label for GLINK bindings
Date: Thu, 26 Apr 2018 15:59:00 -0700
Message-Id: <1524783545-21951-2-git-send-email-clew@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524783545-21951-1-git-send-email-clew@codeaurora.org>
References: <1524783545-21951-1-git-send-email-clew@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are GLINK clients who open the same channel on multiple GLINK
links. These clients need a way to distinguish which remoteproc they
are communicating to. Add a label property to identify the edge this
node represents.

Signed-off-by: Chris Lew <clew@codeaurora.org>
---

Changes since v1:
- Add explanation for label in commit message

 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
index 9663cab52246..0b8cc533ca83 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
@@ -10,6 +10,11 @@ edge.
 	Value type: <stringlist>
 	Definition: must be "qcom,glink-rpm"
 
+- label:
+	Usage: optional
+	Value type: <string>
+	Definition: should specify the subsystem name this edge corresponds to.
+
 - interrupts:
 	Usage: required
 	Value type: <prop-encoded-array>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
