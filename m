Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932835AbeE2JyZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:54:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40130 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932772AbeE2JyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:54:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66B5C60261
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
From: Vijay Viswanath <vviswana@codeaurora.org>
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com, vviswana@codeaurora.org,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
Subject: [PATCH V2 3/4] Documentation: sdhci-msm: Add new compatible string for SDCC v5
Date: Tue, 29 May 2018 15:22:40 +0530
Message-Id: <1527587561-27448-4-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sayali Lokhande <sayalil@codeaurora.org>

For SDCC version 5.0.0 and higher, new compatible string
"qcom,sdhci-msm-v5" is added.

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index bfdcdc4..502b3b8 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -4,7 +4,12 @@ This file documents differences between the core properties in mmc.txt
 and the properties used by the sdhci-msm driver.
 
 Required properties:
-- compatible: Should contain "qcom,sdhci-msm-v4".
+- compatible: Should contain:
+		"qcom,sdhci-msm-v4" for sdcc versions less than 5.0
+		"qcom,sdhci-msm-v5" for sdcc versions >= 5.0
+		For SDCC version 5.0.0, MCI registers are removed from SDCC
+		interface and some registers are moved to HC. New compatible
+		string is added to support this change - "qcom,sdhci-msm-v5".
 - reg: Base address and length of the register in the following order:
 	- Host controller register map (required)
 	- SD Core register map (required)
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
