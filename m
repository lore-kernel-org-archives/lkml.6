Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C10C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6078220840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cHKFfRQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbfAPUPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:15:09 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33763 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732397AbfAPUPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:15:06 -0500
Received: by mail-yw1-f65.google.com with SMTP id p65so2952394ywe.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 12:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=awa79T+kyx6VZKS7urmfQCd1R09XTg+c5Pfm4+eLFDE=;
        b=cHKFfRQ5YKjciYjd8iziH+qR38wH3iMnFxB5C7Xnxrc3Cr4iW9rDOCfaDOdilHUnMN
         TNon+oSQDVjeUoUZHYw3qaGIrU705oze7rfC5xJpX4dBUsEmcGGt01bt9/8+NlM4xK4h
         6fiK4p2Qq0ffUoJ+KxLbIdPfoQ15yez+oeHDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=awa79T+kyx6VZKS7urmfQCd1R09XTg+c5Pfm4+eLFDE=;
        b=IDUR+AySf2ab9wdNsQ6WIrXo6JIuOjIJwq/2WYfzebzUyt8WIM9W9MYzBvKJJghq0l
         bHnGKn3pBEuoeAEU8aUKooCP2qkfkscKB7jKArb11yeLKAz9MB1U13vOUk3EdGgT0c9E
         UjqAGu4NFpq+/nMfdkSUKaWOstzvuoSKbQzUDSRIMr8QFyTLCuhbtk2JUjH1CDBTLMtZ
         3oiz4QJ122h5xBsaa0Bqj9Sy2XHgzpxXsMMzl8S6Q6bUTAP3e/M7Qkbt7SJOpjhS4OuD
         A9+tRCqbRvLf9NZtgjduzhiHbVstwls/gIY/KyRsjdC/kyY2ro4F09pNsKwBFi5vJYFo
         QYzg==
X-Gm-Message-State: AJcUuke+KZX1z46Rghbaz7lTe49rs23jbDZtp3KVQtoQifxRodLm/T6P
        ffi8mF3IovAr9LZWQgtUxCtEIg==
X-Google-Smtp-Source: ALg8bN7+atlby7ihq5YcsnR59OrsRycWnio8d0DP9VHzmvb+R7NsMJlc/CpqwTUChIoOsKv0xJOYZg==
X-Received: by 2002:a81:3358:: with SMTP id z85mr9364471ywz.398.1547669705220;
        Wed, 16 Jan 2019 12:15:05 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w63sm2541026ywc.46.2019.01.16.12.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 12:15:04 -0800 (PST)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Praveen Kumar B <praveen.b@broadcom.com>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH V2 3/4] drivers: pwm: pwm-bcm-kona: Add cygnus-pwm support
Date:   Thu, 17 Jan 2019 01:45:15 +0530
Message-Id: <1547669716-20070-4-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Praveen Kumar B <praveen.b@broadcom.com>

Add support for new version of pwm-cygnus.
Add support to make PWM changes configured and stable.

Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 drivers/pwm/pwm-bcm-kona.c | 95 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index fe63289..143843f 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/ioport.h>
 #include <linux/math64.h>
 #include <linux/module.h>
@@ -65,10 +66,19 @@
 #define DUTY_CYCLE_HIGH_MIN			(0x00000000)
 #define DUTY_CYCLE_HIGH_MAX			(0x00ffffff)
 
+#define PWM_MONITOR_OFFSET			0xb0
+#define PWM_MONITOR_TIMEOUT_US			5
+
+enum kona_pwmc_ver {
+	KONA_PWM = 1,
+	CYGNUS_PWM
+};
+
 struct kona_pwmc {
 	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
+	enum kona_pwmc_ver version;
 };
 
 static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *_chip)
@@ -76,10 +86,36 @@ static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *_chip)
 	return container_of(_chip, struct kona_pwmc, chip);
 }
 
+static int kona_pwmc_wait_stable(struct pwm_chip *chip, unsigned int chan,
+				 unsigned int kona_ver)
+{
+	struct kona_pwmc *kp = to_kona_pwmc(chip);
+	unsigned int value;
+
+	switch (kona_ver) {
+	case KONA_PWM:
+		/*
+		 * There must be a min 400ns delay between clearing trigger and
+		 * settingit. Failing to do this may result in no PWM signal.
+		 */
+		ndelay(400);
+		return 0;
+
+	case CYGNUS_PWM:
+		return readl_poll_timeout(kp->base + PWM_MONITOR_OFFSET, value,
+					  !(value & (BIT(chan))), 0,
+					  PWM_MONITOR_TIMEOUT_US);
+
+	default:
+		return -ENODEV;
+
+	}
+}
+
 /*
  * Clear trigger bit but set smooth bit to maintain old output.
  */
-static void kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
+static int kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
 	unsigned int chan)
 {
 	unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
@@ -88,14 +124,10 @@ static void kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
 	value &= ~(1 << PWM_CONTROL_TRIGGER_SHIFT(chan));
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
-	/*
-	 * There must be a min 400ns delay between clearing trigger and setting
-	 * it. Failing to do this may result in no PWM signal.
-	 */
-	ndelay(400);
+	return kona_pwmc_wait_stable(&kp->chip, chan, kp->version);
 }
 
-static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
+static int kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
 {
 	unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
 
@@ -104,8 +136,7 @@ static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
 	value |= 1 << PWM_CONTROL_TRIGGER_SHIFT(chan);
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
-	/* Trigger bit must be held high for at least 400 ns. */
-	ndelay(400);
+	return kona_pwmc_wait_stable(&kp->chip, chan, kp->version);
 }
 
 static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -113,8 +144,13 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct kona_pwmc *kp = to_kona_pwmc(chip);
 	unsigned int chan = pwm->hwpwm;
 	unsigned int value;
+	int ret;
 
-	kona_pwmc_prepare_for_settings(kp, chan);
+	ret = kona_pwmc_prepare_for_settings(kp, chan);
+	if (ret < 0) {
+		dev_err(chip->dev, "failed to prepare pwm settings: %d\n", ret);
+		return;
+	}
 
 	/* Simulate a disable by configuring for zero duty */
 	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
@@ -125,7 +161,11 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	value &= ~PRESCALE_MASK(chan);
 	writel(value, kp->base + PRESCALE_OFFSET);
 
-	kona_pwmc_apply_settings(kp, chan);
+	ret = kona_pwmc_apply_settings(kp, chan);
+	if (ret < 0) {
+		dev_err(chip->dev, "failed to apply pwm settings: %d\n", ret);
+		return;
+	}
 
 	clk_disable_unprepare(kp->clk);
 }
@@ -188,7 +228,12 @@ static int kona_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			}
 		}
 
-		kona_pwmc_prepare_for_settings(kp, chan);
+		ret = kona_pwmc_prepare_for_settings(kp, chan);
+		if (ret < 0) {
+			dev_err(chip->dev,
+				"failed to prepare pwm settings: %d\n", ret);
+			return ret;
+		}
 
 		value = readl(kp->base + PRESCALE_OFFSET);
 		value &= ~PRESCALE_MASK(chan);
@@ -208,7 +253,12 @@ static int kona_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			writel(value, kp->base + PWM_CONTROL_OFFSET);
 		}
 
-		kona_pwmc_apply_settings(kp, chan);
+		ret = kona_pwmc_apply_settings(kp, chan);
+		if (ret < 0) {
+			dev_err(chip->dev,
+				"failed to prepare pwm settings: %d\n", ret);
+			return ret;
+		}
 	} else if (cstate.enabled) {
 		kona_pwmc_disable(chip, pwm);
 	}
@@ -221,14 +271,26 @@ static int kona_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	.owner = THIS_MODULE,
 };
 
+static const struct of_device_id bcm_kona_pwmc_dt[] = {
+	{ .compatible = "brcm,kona-pwm", .data = (void *)KONA_PWM},
+	{ .compatible = "brcm,cygnus-pwm", .data = (void *)CYGNUS_PWM},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bcm_kona_pwmc_dt);
+
 static int kona_pwmc_probe(struct platform_device *pdev)
 {
 	struct kona_pwmc *kp;
 	struct resource *res;
+	const struct of_device_id *of_id;
 	unsigned int chan;
 	unsigned int value = 0;
 	int ret = 0;
 
+	of_id = of_match_node(bcm_kona_pwmc_dt, pdev->dev.of_node);
+	if (!of_id)
+		return -ENODEV;
+
 	kp = devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
 	if (kp == NULL)
 		return -ENOMEM;
@@ -241,6 +303,7 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 	kp->chip.npwm = 6;
 	kp->chip.of_xlate = of_pwm_xlate_with_flags;
 	kp->chip.of_pwm_n_cells = 3;
+	kp->version = (enum kona_pwmc_ver)of_id->data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	kp->base = devm_ioremap_resource(&pdev->dev, res);
@@ -287,12 +350,6 @@ static int kona_pwmc_remove(struct platform_device *pdev)
 	return pwmchip_remove(&kp->chip);
 }
 
-static const struct of_device_id bcm_kona_pwmc_dt[] = {
-	{ .compatible = "brcm,kona-pwm" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, bcm_kona_pwmc_dt);
-
 static struct platform_driver kona_pwmc_driver = {
 	.driver = {
 		.name = "bcm-kona-pwm",
-- 
1.9.1

