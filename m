Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74355C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE4E20871
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JZyP+EFt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OJ6gF3f6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE4E20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932564AbeGIKXT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:23:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60726 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754431AbeGIKXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:23:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6C94D602AE; Mon,  9 Jul 2018 10:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531131796;
        bh=6RD57p8QZAAFUgE/KafB18TYrrs6KA+oT28yko6XlBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZyP+EFt9y18HxGd5AaNDvHEECwmKoGyK8GVNaF5uOz9QLca2pc6SepMqfv+Tul1s
         k1F4paCQQRbhdg2pX161iFJJl8Qj8R+6Sa7GifJJ5d7dk99NW3oSO6eUtFkPxlaZRf
         pHDXPNeXAEoURNzoz7477mwij5zm69r+q5i5Z2kI=
Received: from kgunda-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B464602AE;
        Mon,  9 Jul 2018 10:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531131795;
        bh=6RD57p8QZAAFUgE/KafB18TYrrs6KA+oT28yko6XlBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJ6gF3f6EBUSUtz2LKNFz9GclyYKNSM4+K8F5BMxpjvtGPRpEiHxIFAANK/pzcyYc
         ctQ81jcfgWA1thKt4Q74ZxFKTPntp12H626QPy8Of40bUhQf4cUupNVnUrT8wO4zeu
         Dr/fzmHSgtsqLJlU0Qmz1WjHZKvcMff7/7PG+nPM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B464602AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kgunda@codeaurora.org
From:   Kiran Gunda <kgunda@codeaurora.org>
To:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V4 1/8] backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c
Date:   Mon,  9 Jul 2018 15:52:14 +0530
Message-Id: <1531131741-19971-2-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm8941-wled.c driver is supporting the WLED peripheral
on pm8941. Rename it to qcom-wled.c so that it can support
WLED on multiple PMICs.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
changes from V3:
	Added Reviewed-by and Acked-by tags.

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
index 2919e23..2c29180 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -306,12 +306,12 @@ config BACKLIGHT_TOSA
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
index 0dcc2c7..741ab36 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -50,8 +50,8 @@ obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
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

