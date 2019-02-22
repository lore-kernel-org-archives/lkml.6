Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B88C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEEB2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfBVNqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:46:45 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:54349 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfBVNqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:46:42 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.42.136]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M6DSo-1gzLwE2WRU-006h8U; Fri, 22 Feb 2019 14:46:06 +0100
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
Subject: [PATCH V3 2/2] hwmon: pwm-fan: Add optional regulator support
Date:   Fri, 22 Feb 2019 14:45:24 +0100
Message-Id: <1550843124-10992-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550843124-10992-1-git-send-email-stefan.wahren@i2se.com>
References: <1550843124-10992-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:NlVN2sXQK4iQZ+CbQkfSXqK0tGzIEq3ndxMjQl5A1TVybMy1zsN
 RQtiGJdTgnEuf0M3zU86vWORaLibt3FnJDLscHI8VK15tPON3uX8Ck3Kw8kfXTZyrKfz0n/
 hIBEVj/brIhbB00Zzi0DrALdTN0iwF0Y/+Uq9X1GtBYfwZgg9O1GbalwGK4qrR052vwqgcQ
 wZNaTu8h1QxT60jtlFmLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W7TgeG4HLeI=:8LQA5DbbbhBIMYyq8gcBiq
 HI3qG70Viv9CpDlWgLRCP1yXuj7ocsOU0fBkTDfThlnm6VSvKYY5GIpd6hvd5JxD7cPLAL8F5
 5pVD9a/Y/2u7005NmA9tpV7R/M2gGFBqnvsQQKpwhTvQxbg8txe2+Xxl7+/JI8wRfrqLsVQaY
 WE3iRc2YrngYkfdU/38Arj5rXfHJNVc23WU6wuklKkSKc4wcFA6w3IQ77ZSId+zAc7X0cpLFE
 4Vqwibap9MuYs+/zbQCyXI8R+ZeMKMuwJxzJQnecoXQF60zH31rUxoof4Rfrz94YY7vIxSjo/
 Q9cIL54+vuFYvSTiYTcPKzCA8TAgBO7ncisdWtkQcJOxGOrtLT+V7oL2dK1N3ZOiAzv2cHR8P
 wEKAKwkGEKzUNA0KOKvMbCGv2XM0UYU34e53uxuSVkk5cmFTgHW6EW/Eu5Q7FA2GfqIxSaDfb
 TFAsxkk4mJWm8fcihz91tNj9hfe/tSpiSXgp+9BRwblc44mCYdFI09J+SQUaADY6mYJBqprro
 vj30+0Q9e0Kk7Sd58NfYHSzRiv0FmV1F9qqWInF9PIagDb8gv56fRlUmRR5AHGBw818O63ko4
 qcO2bvjuVP0smi2lfzrxcn4/gj1Kk79S1l0NBohRwv7lO0UGGjyffvQGeZ+fmG9CZtJxUttUt
 jcMjr2NG1M50L9SVIjUFn7XAsiZEyJDLnzj/clc9jOFZxoTc2V1tW/FJSrt0UP494ZDrK20ZC
 7wH6jDDLEbcYi1utBcfc/MhzRWtEX9xFsQUyle5lVaSRt3wSQ/6SfoD7mEI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds optional regulator support to the pwm-fan driver. This is
necessary for pwm fans which are powered by a switchable supply.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/hwmon/pwm-fan.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 2c94482..167221c 100644
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
+		if (PTR_ERR(ctx->reg_en) != -ENODEV)
+			return PTR_ERR(ctx->reg_en);
+
+		ctx->reg_en = NULL;
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
 
@@ -307,6 +332,14 @@ static int pwm_fan_suspend(struct device *dev)
 		pwm_disable(ctx->pwm);
 	}
 
+	if (ctx->reg_en) {
+		ret = regulator_disable(ctx->reg_en);
+		if (ret) {
+			dev_err(dev, "Failed to disable fan supply: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -317,6 +350,14 @@ static int pwm_fan_resume(struct device *dev)
 	unsigned long duty;
 	int ret;
 
+	if (ctx->reg_en) {
+		ret = regulator_enable(ctx->reg_en);
+		if (ret) {
+			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
+			return ret;
+		}
+	}
+
 	if (ctx->pwm_value == 0)
 		return 0;
 
-- 
2.7.4

