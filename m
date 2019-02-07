Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7714C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806622173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfBGQjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:39:14 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:41551 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfBGQjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:39:11 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.54.161]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N4Q8u-1hHjLR1Hdu-011Odb; Thu, 07 Feb 2019 17:38:35 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 2/2] hwmon: pwm-fan: Add optional regulator support
Date:   Thu,  7 Feb 2019 17:38:00 +0100
Message-Id: <1549557480-14436-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549557480-14436-1-git-send-email-stefan.wahren@i2se.com>
References: <1549557480-14436-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:527t2r+5wT4Tj26tDEC6KLuXpAa9eMoa/YYhqOJvj0xK4GUIO4p
 C0+xemkf1AvTeCutx9FhIk/lTXRRr9mMv0X99kDeDMcHxMw3xHfT4xaG5w5l1yOEldn7E8j
 KwT94kSC3Mcd/Uqtyc7kf/47mjhJkKxOv5cuUzMdVl/0FCvrMc2lHka6BCqexoXJ/naBkhe
 418hulCzLlFCFIFo75ttg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XwBqw9vFi2s=:HoeoWZEaUFk2xfmoSgAQIR
 oO+FWxVuRoRKWT1OdHFmtBqLHCwPVyzqUGnHcdoG1cPLjpTrg8Xoouoe46h4b5YFh91U0Jbc6
 MIzPA8sVG88m/CvRb3m2qA5xKTePKfT8iJsQyLQ4DTa9bkuWA5LisKb3SkecebYIilS067YNP
 C7VNu5PFJE0CLYeTIAIlUuHfTc2/1S/CFRTYIT+T2tkZeK6Ei9OMxHyjgTrLYtm4fOVYMewU9
 GRzLDIGxZ2BB+vCxtmYQi41bl2OaF17SOmEphGJxnMIbHZwqDjRfoB4LJaIWiTkQAoLDafNQh
 wuA+zY70gfljNhvTQIYajlYpgy1WXCWhGvAeUZ5Bej3zDQATkO1Nu/hrSY0tbra8glem7MJur
 2JMgkz02L0qM0P7esFR1wb6seP/ZIuhhtiLX6A7Lr/WEGsxBztsvVXwUTGN++vKYxKVJOcu/p
 gM2M9jgYDAxQ2fyHFGlnnJSC+f+hN4gkQBJvIFYOA3Qtr1L5i0p9nd6bFGAN7pkHLMSrHr/Kv
 crBqbVLz6sSKIwZqQwaJ6qYEJveLaQoKH95AJxEXkKyAPZSmlaSRt1UrIGVN7+REw4Kx3cRJL
 LNivjqNot6B1iJnpbxAqE8FT1cv4VWquA80lzVaO6shc89HBNqT2HJr/5pkX8+AWmRp3Flbou
 Lk1okqp6igjZ7g5KShiE+Ru6qk5v+P3Cab1AC0/Th54dyyrUjKtnb0kqqgeDkr/30C0NfQpUl
 UWYhbTavdLkTqdw464mwTR/14srkg8Zf4iOpxAgtsODUWM7NWkTgIPUmR2Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds optional regulator support to the pwm-fan driver. This is
necessary for pwm fans which are powered by a switchable supply.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/hwmon/pwm-fan.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 2c94482..344915c 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
 #include <linux/thermal.h>
 
@@ -31,6 +32,7 @@
 struct pwm_fan_ctx {
 	struct mutex lock;
 	struct pwm_device *pwm;
+	struct regulator *reg_en;
 	unsigned int pwm_value;
 	unsigned int pwm_fan_state;
 	unsigned int pwm_fan_max_state;
@@ -231,6 +233,21 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctx);
 
+	ctx->reg_en = devm_regulator_get_optional(&pdev->dev, "fan");
+	if (IS_ERR(ctx->reg_en)) {
+		if (PTR_ERR(ctx->reg_en) == -ENODEV)
+			ctx->reg_en = NULL;
+		else
+			return PTR_ERR(ctx->reg_en);
+	} else {
+		ret = regulator_enable(ctx->reg_en);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to enable fan supply: %d\n", ret);
+			return ret;
+		}
+	}
+
 	ctx->pwm_value = MAX_PWM;
 
 	/* Set duty cycle to maximum allowed and enable PWM output */
@@ -241,7 +258,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	ret = pwm_apply_state(ctx->pwm, &state);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to configure PWM\n");
-		return ret;
+		goto err_reg_disable;
 	}
 
 	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
@@ -277,6 +294,10 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	state.enabled = false;
 	pwm_apply_state(ctx->pwm, &state);
 
+err_reg_disable:
+	if (ctx->reg_en)
+		regulator_disable(ctx->reg_en);
+
 	return ret;
 }
 
@@ -287,6 +308,10 @@ static int pwm_fan_remove(struct platform_device *pdev)
 	thermal_cooling_device_unregister(ctx->cdev);
 	if (ctx->pwm_value)
 		pwm_disable(ctx->pwm);
+
+	if (ctx->reg_en)
+		regulator_disable(ctx->reg_en);
+
 	return 0;
 }
 
@@ -299,6 +324,12 @@ static int pwm_fan_suspend(struct device *dev)
 
 	pwm_get_args(ctx->pwm, &args);
 
+	if (ctx->reg_en) {
+		ret = regulator_disable(ctx->reg_en);
+		if (ret)
+			dev_err(dev, "Failed to disable fan supply: %d\n", ret);
+	}
+
 	if (ctx->pwm_value) {
 		ret = pwm_config(ctx->pwm, 0, args.period);
 		if (ret < 0)
@@ -317,6 +348,12 @@ static int pwm_fan_resume(struct device *dev)
 	unsigned long duty;
 	int ret;
 
+	if (ctx->reg_en) {
+		ret = regulator_enable(ctx->reg_en);
+		if (ret)
+			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
+	}
+
 	if (ctx->pwm_value == 0)
 		return 0;
 
-- 
2.7.4

