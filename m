Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D02ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80622084E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3BBlF+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80622084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbeGMSqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:46:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43371 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbeGMSqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:46:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id r13-v6so25181443ljg.10;
        Fri, 13 Jul 2018 11:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUEo8oTgOxKKgN9CB/xquVykx3NZ4EIVn8RiU4PVBlk=;
        b=K3BBlF+4/LaVztEUuOL5ECGwYC+tIQ4S+NqVdi9opEbgdzjoKLqVM7rhLMIVYTgY37
         1bT7Be8Lx82G8OxWYvTG0BYNEtviOFL7NFKZWR6p2JwqRnf1gOM2y/P7ekuF33jM2jYY
         s6c620+ZUTe1bn3GbHcd1+IM+0WtfOK109xnxuY7z1j8zmNvaqnYRoNwV9C4eZm7ZzaY
         aa1APhsnkoKtozf8mnQGVBfI6WD3g4IunMUZpB6GYurfWhIcwL/Q+Oj1ZnnNyCHmKnyC
         wu9Depe5Qcr1JFvwNF2yZR5AasVplZFqDys99IuUxJR3H2QLmtqPcSmXSEM124mEISv8
         0x+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUEo8oTgOxKKgN9CB/xquVykx3NZ4EIVn8RiU4PVBlk=;
        b=FSXYnHlvKWxCkO8QE7PgNA0rmdiJTi2Q32HzCtyVWsYpEH5u0fxFYTLw55MoFw1tci
         F32FVfG/Vn/kdi7tfGZMtK8jO39p5YwNiPcWlkXuLvj6Zkf7UAewWkQsXNujg6B/KdDp
         0DrExdKIV7j83G6/hcE6R6+GjDgZ0HEWRr07IyVLJ9sCvNkzeaiZFysHIRkZjcLOpbsL
         bTzXwb98F9NvNgynDvIEIMmybSzJvgeVp3m16wbTjp8FasP7/mc/Ma1TALIoeAgSaFf3
         G+L/lu0nkjvVgus9aLUWROHwEstzshE3lkB3tF/3QxGZ5B1yShXzL2iLkEWJWl38b5Tw
         Sy6Q==
X-Gm-Message-State: AOUpUlEkoUqO3S9JZmnYmjXqRP1+RUwqfo/W+dzCltqVAfyWAU8cJKSd
        lWyCOZCq7S75fQq3skhc++s=
X-Google-Smtp-Source: AAOMgpdaOXp6bCOxeZN+/axCSmpFs/oTQa+t8huYUb0Xe8Osgb4gUmQnudnCk8/X1ApbDiJsN5J3hQ==
X-Received: by 2002:a2e:9ec9:: with SMTP id h9-v6mr3721490ljk.133.1531506633023;
        Fri, 13 Jul 2018 11:30:33 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.googlemail.com with ESMTPSA id j12-v6sm491268ljh.13.2018.07.13.11.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 11:30:31 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 1/2] Input: atmel_mxt_ts: Add support for optional regulators.
Date:   Fri, 13 Jul 2018 20:30:07 +0200
Message-Id: <1531506608-24479-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531506608-24479-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1531506608-24479-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds optional regulators, which can be used to power
up touchscreen. After enabling regulators, we need to wait 150msec.
This value is taken from official driver.

It was tested on Samsung Galaxy i9000 (based on Samsung S5PV210 SOC).

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 45 ++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 54fe190fd4bc..a7625ec8fb9f 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/property.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/gpio/consumer.h>
 #include <linux/property.h>
@@ -198,6 +199,7 @@ enum t100_type {
 #define MXT_RESET_INVALID_CHG	100	/* msec */
 #define MXT_RESET_TIME		200	/* msec */
 #define MXT_RESET_TIMEOUT	3000	/* msec */
+#define MXT_REGULATOR_DELAY	150	/* msec */
 #define MXT_CRC_TIMEOUT		1000	/* msec */
 #define MXT_FW_RESET_TIME	3000	/* msec */
 #define MXT_FW_CHG_TIMEOUT	300	/* msec */
@@ -310,6 +312,8 @@ struct mxt_data {
 	struct t7_config t7_cfg;
 	struct mxt_dbg dbg;
 	struct gpio_desc *reset_gpio;
+	struct regulator *vdd_reg;
+	struct regulator *avdd_reg;
 
 	/* Cached parameters from object table */
 	u16 T5_address;
@@ -3076,6 +3080,40 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return error;
 	}
 
+	data->vdd_reg = devm_regulator_get_optional(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_reg)) {
+		error = PTR_ERR(data->vdd_reg);
+		dev_err(&client->dev, "Failed to get vdd regulator: %d\n",
+			error);
+		return error;
+	}
+
+	if (data->vdd_reg) {
+		error = regulator_enable(data->vdd_reg);
+		if (error) {
+			dev_err(&client->dev, "Failed to enable vdd regulator: %d\n",
+				error);
+			return error;
+		}
+	}
+
+	data->avdd_reg = devm_regulator_get_optional(&client->dev, "avdd");
+	if (IS_ERR(data->avdd_reg)) {
+		error = PTR_ERR(data->avdd_reg);
+		dev_err(&client->dev, "Failed to get avdd regulator: %d\n",
+			error);
+		return error;
+	}
+
+	if (data->avdd_reg) {
+		error = regulator_enable(data->avdd_reg);
+		if (error) {
+			dev_err(&client->dev, "Failed to enable avdd regulator: %d\n",
+				error);
+			return error;
+		}
+	}
+
 	error = devm_request_threaded_irq(&client->dev, client->irq,
 					  NULL, mxt_interrupt, IRQF_ONESHOT,
 					  client->name, data);
@@ -3086,6 +3124,9 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	disable_irq(client->irq);
 
+	if (!IS_ERR(data->vdd_reg) || !IS_ERR(data->avdd_reg))
+		msleep(MXT_REGULATOR_DELAY);
+
 	if (data->reset_gpio) {
 		msleep(MXT_RESET_GPIO_TIME);
 		gpiod_set_value(data->reset_gpio, 1);
@@ -3116,6 +3157,10 @@ static int mxt_remove(struct i2c_client *client)
 	struct mxt_data *data = i2c_get_clientdata(client);
 
 	disable_irq(data->irq);
+	if (!IS_ERR(data->avdd_reg))
+		regulator_disable(data->avdd_reg);
+	if (!IS_ERR(data->vdd_reg))
+		regulator_disable(data->vdd_reg);
 	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
-- 
2.7.4

