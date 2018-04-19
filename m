Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753799AbeDSXAh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 19:00:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46226 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753579AbeDSXAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 19:00:35 -0400
X-Google-Smtp-Source: AIpwx4/vY1DRpVknDTCjRIEXyGGYfU7sMfXXmec8rYcLOvGYk/ip6kUF+ltgeQf+3cQkv1tKOz8SOg==
From: Stephen Boyd <swboyd@chromium.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] mfd: qcom-spmi-pmic: Add support for pm8005,pm8998,pmi8998
Date: Thu, 19 Apr 2018 16:00:32 -0700
Message-Id: <20180419230032.13611-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatibles and PMIC ids for the pm8005, pm8998, and pmi8998
PMICS found on MSM8998 and SDM845 based platforms.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt | 3 +++
 drivers/mfd/qcom-spmi-pmic.c                             | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
index 6ac06c1b9aec..f708431e2350 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
@@ -29,6 +29,9 @@ Required properties:
                    "qcom,pm8916",
                    "qcom,pm8004",
                    "qcom,pm8909",
+                   "qcom,pmi8998",
+                   "qcom,pm8005",
+                   "qcom,pm8998",
                    or generalized "qcom,spmi-pmic".
 - reg:             Specifies the SPMI USID slave address for this device.
                    For more information see:
diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index 2022bdfa7ab4..0b26387c22e7 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -39,6 +39,9 @@
 #define PM8916_SUBTYPE		0x0b
 #define PM8004_SUBTYPE		0x0c
 #define PM8909_SUBTYPE		0x0d
+#define PM8998_SUBTYPE		0x14
+#define PMI8998_SUBTYPE		0x15
+#define PM8005_SUBTYPE		0x18
 
 static const struct of_device_id pmic_spmi_id_table[] = {
 	{ .compatible = "qcom,spmi-pmic", .data = (void *)COMMON_SUBTYPE },
@@ -54,7 +57,10 @@ static const struct of_device_id pmic_spmi_id_table[] = {
 	{ .compatible = "qcom,pmi8994",   .data = (void *)PMI8994_SUBTYPE },
 	{ .compatible = "qcom,pm8916",    .data = (void *)PM8916_SUBTYPE },
 	{ .compatible = "qcom,pm8004",    .data = (void *)PM8004_SUBTYPE },
+	{ .compatible = "qcom,pmi8998",   .data = (void *)PMI8998_SUBTYPE },
+	{ .compatible = "qcom,pm8005",    .data = (void *)PM8005_SUBTYPE },
 	{ .compatible = "qcom,pm8909",    .data = (void *)PM8909_SUBTYPE },
+	{ .compatible = "qcom,pm8998",    .data = (void *)PM8998_SUBTYPE },
 	{ }
 };
 
-- 
Sent by a computer through tubes
