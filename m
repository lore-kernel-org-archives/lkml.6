Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeCPJiq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:38:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42124 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeCPJil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:38:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AC7E60C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org
Cc: sricharan@codeaurora.org
Subject: [PATCH v2 01/13] firmware: qcom: scm: Add ipq4019 soc compatible
Date: Fri, 16 Mar 2018 15:08:09 +0530
Message-Id: <1521193101-4586-2-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible for ipq4019.
This does not need clocks to do scm calls.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 3 ++-
 drivers/firmware/qcom_scm.c                             | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index 7b40054..fcf6979 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -11,9 +11,10 @@ Required properties:
  * "qcom,scm-msm8660" for MSM8660 platforms
  * "qcom,scm-msm8690" for MSM8690 platforms
  * "qcom,scm-msm8996" for MSM8996 platforms
+ * "qcom,scm-ipq4019" for IPQ4019 platforms
  * "qcom,scm" for later processors (MSM8916, APQ8084, MSM8974, etc)
 - clocks: One to three clocks may be required based on compatible.
- * No clock required for "qcom,scm-msm8996"
+ * No clock required for "qcom,scm-msm8996", "qcom,scm-ipq4019"
  * Only core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660", and "qcom,scm-msm8960"
  * Core, iface, and bus clocks required for "qcom,scm"
 - clock-names: Must contain "core" for the core clock, "iface" for the interface
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 5a7d6930..e778af7 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -603,6 +603,9 @@ static void qcom_scm_shutdown(struct platform_device *pdev)
 	{ .compatible = "qcom,scm-msm8996",
 	  .data = NULL, /* no clocks */
 	},
+	{ .compatible = "qcom,scm-ipq4019",
+	  .data = NULL, /* no clocks */
+	},
 	{ .compatible = "qcom,scm",
 	  .data = (void *)(SCM_HAS_CORE_CLK
 			   | SCM_HAS_IFACE_CLK
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
