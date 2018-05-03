Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeECJ6b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:58:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42520 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeECJ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:58:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41030607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kgunda@codeaurora.org
From: Kiran Gunda <kgunda@codeaurora.org>
To: bjorn.andersson@linaro.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V1 1/5] qcom: wled: Rename pm8941-wled.c to qcom-wled.c
Date: Thu,  3 May 2018 15:27:08 +0530
Message-Id: <1525341432-15818-2-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm8941-wled.c driver is supporting the WLED peripheral
on pm8941. Rename it to qcom-wled.c so that it can support
WLED on multiple PMICs.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
 .../bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt}    | 2 +-
 drivers/video/backlight/Kconfig                                   | 8 ++++----
 drivers/video/backlight/Makefile                                  | 2 +-
 drivers/video/backlight/{pm8941-wled.c => qcom-wled.c}            | 0
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename Documentation/devicetree/bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt} (95%)
 rename drivers/video/backlight/{pm8941-wled.c => qcom-wled.c} (100%)

diff --git a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
similarity index 95%
rename from Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
rename to Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
index e5b294d..fb39e32 100644
--- a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
@@ -1,4 +1,4 @@
-Binding for Qualcomm PM8941 WLED driver
+Binding for Qualcomm Technologies, Inc. WLED driver
 
 Required properties:
 - compatible: should be "qcom,pm8941-wled"
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 4e1d2ad..8c095e3 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -299,12 +299,12 @@ config BACKLIGHT_TOSA
 	  If you have an Sharp SL-6000 Zaurus say Y to enable a driver
 	  for its backlight
 
-config BACKLIGHT_PM8941_WLED
-	tristate "Qualcomm PM8941 WLED Driver"
+config BACKLIGHT_QCOM_WLED
+	tristate "Qualcomm PMIC WLED Driver"
 	select REGMAP
 	help
-	  If you have the Qualcomm PM8941, say Y to enable a driver for the
-	  WLED block.
+	  If you have the Qualcomm PMIC, say Y to enable a driver for the
+	  WLED block. Currently it supports PM8941 and PMI8998.
 
 config BACKLIGHT_SAHARA
 	tristate "Tabletkiosk Sahara Touch-iT Backlight Driver"
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 5e28f01..6fd76ef 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -49,8 +49,8 @@ obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
 obj-$(CONFIG_BACKLIGHT_OT200)		+= ot200_bl.o
 obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
 obj-$(CONFIG_BACKLIGHT_PCF50633)	+= pcf50633-backlight.o
-obj-$(CONFIG_BACKLIGHT_PM8941_WLED)	+= pm8941-wled.o
 obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
+obj-$(CONFIG_BACKLIGHT_QCOM_WLED)	+= qcom-wled.o
 obj-$(CONFIG_BACKLIGHT_SAHARA)		+= kb3886_bl.o
 obj-$(CONFIG_BACKLIGHT_SKY81452)	+= sky81452-backlight.o
 obj-$(CONFIG_BACKLIGHT_TOSA)		+= tosa_bl.o
diff --git a/drivers/video/backlight/pm8941-wled.c b/drivers/video/backlight/qcom-wled.c
similarity index 100%
rename from drivers/video/backlight/pm8941-wled.c
rename to drivers/video/backlight/qcom-wled.c
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
