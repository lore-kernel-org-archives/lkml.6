Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C70FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCF62086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfA2RIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:08:21 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:55109 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfA2RIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:08:16 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.39.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N4h7p-1hGpFw2Ii7-011fhB; Tue, 29 Jan 2019 18:07:43 +0100
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
Subject: [PATCH 2/2] hwmon: pwm-fan: Add optional regulator support
Date:   Tue, 29 Jan 2019 18:07:11 +0100
Message-Id: <1548781631-5736-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548781631-5736-1-git-send-email-stefan.wahren@i2se.com>
References: <1548781631-5736-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:jtwELjB805zwxqlcR6KebkiceUBiO0fSX6J2nGv0aL+sLxhIYJx
 oN2dI/J/CdLZIDZc/kcMDfhUlEaIYCChiaiQc9TcDIz0nmgPv0mOQVUKafnuX0e04HyBWPD
 VLR1JqsDHzSamsLLr3UaM08IURRIC0X2eq6hSGym4NAPuiwZz+JojmUkYd2thCaHKnbDmL6
 WsYARiQQwcoWV8RXpRPag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sieGw/6SFdw=:QMBajiXet03YKU6cgp/CMn
 BUh8SyL4rtW5nESaQGiS3W3wExw8+WgjPw5OqyGMiolEziNjiSbihVG4mwoDHaenuOQAM3m9w
 Rl1wMvd+u85wG8cqEKfVYmkmRit9yoIe8QiD5KQKv8MYGAFRJaoQA06TKVYbBEjrUe1mS/RhY
 H5W3FGiuOE7Wq013yKu0nyKK28xjmUXkjvC2uKVq4d2uLw2J3aAI+TRcnAL47F/R9vodGsmnF
 dP2Zj8l1Z27F2HpC+LEtQE9lX2Abn9MUoI+ouUNrMkNNLQXktg3R4uaASb/o62sB+tILpkdmf
 iNYv7einDGojWYb9usKJihNjkjzV4+eZQ6vNuwmWsVaQtDlBYG9/vTpo5n27AmKIcKmO1Z+lj
 qQnMFXkgGXMj+P/aSq5oZcWc0Jk6g5bwpd1r0eLJPAiDpjtsWnGS1VcsWdx9loYZnsa0T3aLh
 f5Co7xAIam7+G6TY8fXu63AUfRmi58q8yFiWZpWG6WjeKyFWZXec96STiPX/HiI6SBeHuUFkC
 +3r/p5SJPXzQoEZJ9E7KcuQk2rUL0qlgoORliC1pNug6YsbhE2lbEquoyVm56TEV8vfJIy+eR
 O/YmyVEiKnX7bm0i1A8/1uTsmPkZfM6DMX1X8ITEB3Aeb7vSWSg1R0lawF5xdMF8uRlihrJst
 NzPKJm6mRsWQcPxESEAKIm5enpDs4Ga7g2TMPBYQdWdoVTjJp0EXgwUhjZWvMMZlbWYhJm7Q7
 NNF3bjCtJb8dlmg0B+3DI7gkI0rQGehDd/8CaVFqCHHmtB8TEtQaNEtLJvk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds optional regulator support to the pwm-fan driver. This is
necessary for pwm fans which are powered by a switchable supply.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/hwmon/pwm-fan.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 2c94482..9e0591e 100644
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
@@ -244,6 +246,23 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ctx->reg_en = devm_regulator_get_optional(&pdev->dev, "fan");
+	if (!IS_ERR(ctx->reg_en)) {
+		ret = regulator_enable(ctx->reg_en);
+		if (ret)
+			dev_err(&pdev->dev,
+				"Failed to enable fan supply: %d\n", ret);
+	} else {
+		switch (PTR_ERR(ctx->reg_en)) {
+		case -ENODEV:
+		case -ENOSYS:
+			ctx->reg_en = NULL;
+			break;
+		default:
+			return PTR_ERR(ctx->reg_en);
+		}
+	}
+
 	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
 						       ctx, pwm_fan_groups);
 	if (IS_ERR(hwmon)) {
@@ -287,6 +306,10 @@ static int pwm_fan_remove(struct platform_device *pdev)
 	thermal_cooling_device_unregister(ctx->cdev);
 	if (ctx->pwm_value)
 		pwm_disable(ctx->pwm);
+
+	if (ctx->reg_en)
+		regulator_disable(ctx->reg_en);
+
 	return 0;
 }
 
@@ -299,6 +322,12 @@ static int pwm_fan_suspend(struct device *dev)
 
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
@@ -317,6 +346,12 @@ static int pwm_fan_resume(struct device *dev)
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

