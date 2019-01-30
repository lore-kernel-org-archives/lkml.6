Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9628C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC06221473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbfA3PJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:09:26 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:41587 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbfA3PIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:08:34 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.32.180]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mt6x5-1h8J3Q2ZQ1-00tSws; Wed, 30 Jan 2019 16:07:37 +0100
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
Subject: [PATCH RFC 3/3] hwmon: pwm-fan: Add RPM support via external interrupt
Date:   Wed, 30 Jan 2019 16:07:07 +0100
Message-Id: <1548860827-29796-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548860827-29796-1-git-send-email-stefan.wahren@i2se.com>
References: <1548860827-29796-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:6PYVM5mOr+jBDqoqPfyVkKi+e0aGZeVm24bfzZGyzxFAih7gpae
 raII4Co9rIKaOdehU6cr+sKJGKFDK0+LdZ7ext2u1mV+deLQkPbemEULY/35iHFGKT+1YD9
 94aJjLzqIID3Ss1/9a8YszSUHfuK8FZR0xqIo5CGkojiQrs/fwK3YOi7frm3nYgYHGW3SDC
 15TQNyOBM5d8qcXUoXAKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ix9sLYOMfN0=:37umqU0jLHN7b4sJINs0Ud
 DSyUoEmuFZ1bxKaWUjHbstLKfIvQQ4scDwG/KrX1XRZ7SCCUQKeB3ugQzFhq994piG3qg0PEK
 cadW2OWd0jF9XTLPkCiWUUbBEY4T7Z+unaaaaiXFhCxgnFoLr/lQVl4GkLEO3/GfhVpNYFtcN
 0Xn/ETEq1FH2sNb1+ITxgWNBZek2S+FtI7se5K95bmQ0CfDx15p1s+mdJkvjasChZUtuKzz0o
 ecrxEFCShzw0erB1Yzio1RSeiQamgPb6rpR9J4kuJG/TCWFCPapj2fMvTDJNxai5LXa+gAhDt
 xm4KNrvsek0tySzrHxPrh70P20DO/HL7U6oPX8ZLIakosi6ujZry1Ikii4B9eQnrjfWCf3AtC
 p4yAjdLk9mN4Utdxw1rMYB9DEmGW3Lds1dOhofcheJm2/m1wc9Ck00xvUvnp8c1y7bWndiJ5k
 waKevZR32KS1SBo9ZhbWczEULfespHMPhWYtWPwV0pQvZxJav8hnmnjaIOPhXG2UIxD7byMbO
 8Y935Ps5SDEK+wTEhg+n9+MP5A4RPB3bizp19To5boVFReOz0xufsOn0Ejro9kS0dZ0yVA9TU
 k/RtcNHswm6MdtsRHYILdMa2XY7pe614U3FzJ1tipi1a3fLWz8KeoVyZS8eanLIXgfgdu0/cN
 PGZxXhzgtPSxh4oC6HedzyQ4Iyvv16jzTewOFJQkVlAX6GpbvyjDQvh8u1g1nKqI3fDEhP3ze
 4A9i+Kc63MTey8UVxPOiyxWCYVHF+GhIYcpDgytNKjldZ8E+xkRYKmh7814=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds RPM support to the pwm-fan driver in order to use with
fancontrol/pwmconfig. This feature is intended for 2 pulse-per-revolution
fans which provides a tachometer output signal.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/hwmon/pwm-fan.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 9e0591e..731fdc6 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -18,6 +18,7 @@
 
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -26,13 +27,22 @@
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
 #include <linux/thermal.h>
+#include <linux/timer.h>
 
 #define MAX_PWM 255
+#define SAMPLE_TIME		1 /* seconds */
+#define PULSE_PER_REVOLUTION	2
 
 struct pwm_fan_ctx {
 	struct mutex lock;
 	struct pwm_device *pwm;
 	struct regulator *reg_en;
+
+	int irq;
+	unsigned int pulses;
+	unsigned int rpm;
+	struct timer_list sample_timer;
+
 	unsigned int pwm_value;
 	unsigned int pwm_fan_state;
 	unsigned int pwm_fan_max_state;
@@ -40,6 +50,27 @@ struct pwm_fan_ctx {
 	struct thermal_cooling_device *cdev;
 };
 
+static irqreturn_t pulse_handler(int irq, void *dev_id)
+{
+	struct pwm_fan_ctx *ctx = dev_id;
+
+	if (ctx->pulses < INT_MAX / 2)
+		ctx->pulses++;
+
+	return IRQ_HANDLED;
+}
+
+static void sample_timer(struct timer_list *t)
+{
+	struct pwm_fan_ctx *ctx = from_timer(ctx, t, sample_timer);
+	unsigned int pulses;
+
+	pulses = ctx->pulses;
+	ctx->pulses -= pulses;
+	ctx->rpm = pulses * 60 / SAMPLE_TIME / PULSE_PER_REVOLUTION;
+	mod_timer(&ctx->sample_timer, jiffies + (HZ * SAMPLE_TIME));
+}
+
 static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 {
 	unsigned long period;
@@ -100,11 +131,20 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", ctx->pwm_value);
 }
 
+static ssize_t rpm_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", ctx->rpm);
+}
 
 static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, rpm, 0);
 
 static struct attribute *pwm_fan_attrs[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	NULL,
 };
 
@@ -263,6 +303,19 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		}
 	}
 
+	timer_setup(&ctx->sample_timer, sample_timer, 0);
+
+	ctx->irq = platform_get_irq(pdev, 0);
+	if (ctx->irq >= 0) {
+		ret = devm_request_irq(&pdev->dev, ctx->irq, pulse_handler, 0,
+				       pdev->name, ctx);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't get interrupt working.\n");
+			return ret;
+		}
+		mod_timer(&ctx->sample_timer, jiffies + (HZ * SAMPLE_TIME));
+	}
+
 	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
 						       ctx, pwm_fan_groups);
 	if (IS_ERR(hwmon)) {
@@ -304,6 +357,8 @@ static int pwm_fan_remove(struct platform_device *pdev)
 	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
 
 	thermal_cooling_device_unregister(ctx->cdev);
+	del_timer_sync(&ctx->sample_timer);
+
 	if (ctx->pwm_value)
 		pwm_disable(ctx->pwm);
 
-- 
2.7.4

