Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66A9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89729206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnRyMRjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbeLNPMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:12:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38359 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbeLNPMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:12:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id p86so4513093lfg.5;
        Fri, 14 Dec 2018 07:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDJY0iulsgx7iN3Slcal1yubzfA4l/+2jzl1Lo0q7x8=;
        b=YnRyMRjyoYUoa1T/lnyviF6hzTQKfzw8lD7MwA/HobzairVIQZIW07DfpDJextINJf
         hHd3xbR2R5pY95UONlZNkcywcrUyaCJo0YZWl3AASOrF0ZpJfFUK/NvEiGNNCkOdijgV
         DwfC0Zc7cVpA84uTALkBgi9NpD4dox5Vtc0+G702De9lqh/lxl8bMkfyXjDuQPA+HiNW
         1KgRiGC5CxHLEJT8FWPR+iOcoxoZDJX11HZ30AhQyp01NQj5pC1DH45fXsmIZtB2k2ZZ
         LLbC5VreBU9Q3x6uOwuBcZZIwadoDxU+oYEDUmkkJPxEhZeUcH/s0btKNazqfFxXmlkH
         cQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDJY0iulsgx7iN3Slcal1yubzfA4l/+2jzl1Lo0q7x8=;
        b=hubktTY3cpwgTR9zCTnYiMoeljkpWhFI/cMYQ2/6lQOThYZd+cfYPhIJ8IdX8cHHgm
         1/tkn8fPyr0g9WIFLwuVzmmo1jF0qLNYQlE+GSDDw7jXrYxuVpoHZnvV2qSoJei3tT2N
         ifsAXTJRIhpxNqweKFEzk9Vtg0/Y++ImZTadS5lOEhKp/530sLDMI/Dd9O4PTKKFH8bb
         7T3ZmuifoxRVtn5kpA2lL/waJPcWu1FOkxlFw/M3i04h5YBsVH71xQvHwhNFK9Yt3hfg
         U8xCytOKxlrYxCRaCtqjI5tuMxPEIghAGS5kqY7INOZok6M4gkyVtbmgkDqwXcLSI1XT
         9kQg==
X-Gm-Message-State: AA+aEWanXAOGFkj1YoPSC66hrSPnvafsxtlQLMBTWAhqB0tvY4Sobx0q
        kfwkPVuDz/cCELzYQKD9394=
X-Google-Smtp-Source: AFSGD/VdHqcg0co6kob+PtNe4FXaN8qc1HI3HiQH+J8lppE8KwqwD1UR3Q+Ro19KLWiMhrXHCLUKbg==
X-Received: by 2002:a19:c115:: with SMTP id r21mr2047482lff.144.1544800360099;
        Fri, 14 Dec 2018 07:12:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:976:99fb:a7e3:627c])
        by smtp.googlemail.com with ESMTPSA id o17sm951975lff.77.2018.12.14.07.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 07:12:39 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v5 1/3] Input: atmel_mxt_ts: Add support for  optional regulators
Date:   Fri, 14 Dec 2018 16:12:12 +0100
Message-Id: <20181214151214.5391-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
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
Changes from v4:
  - Add missing regulator_disable for vdd in case of error,
    when enabling avdd regulator

Changes from v3:
  - Fix checkpatch issues
  - Drop sentence punctuation from patch subject

Changes from v2:
  - Move code enabling regulators into separate method,
    to make code more readable.

Changes from v1:
  - Enable regulators only if reset_gpio is present.
  - Switch from devm_regulator_get_optional to devm_regulator_get
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 67 +++++++++++++++++++++---
 1 file changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index d3aacd534e9c..55a107fc1b73 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/property.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/gpio/consumer.h>
 #include <asm/unaligned.h>
@@ -194,10 +195,10 @@ enum t100_type {
 
 /* Delay times */
 #define MXT_BACKUP_TIME		50	/* msec */
-#define MXT_RESET_GPIO_TIME	20	/* msec */
 #define MXT_RESET_INVALID_CHG	100	/* msec */
 #define MXT_RESET_TIME		200	/* msec */
 #define MXT_RESET_TIMEOUT	3000	/* msec */
+#define MXT_REGULATOR_DELAY	150	/* msec */
 #define MXT_CRC_TIMEOUT		1000	/* msec */
 #define MXT_FW_RESET_TIME	3000	/* msec */
 #define MXT_FW_CHG_TIMEOUT	300	/* msec */
@@ -323,6 +324,8 @@ struct mxt_data {
 	struct t7_config t7_cfg;
 	struct mxt_dbg dbg;
 	struct gpio_desc *reset_gpio;
+	struct regulator *vdd_reg;
+	struct regulator *avdd_reg;
 
 	/* Cached parameters from object table */
 	u16 T5_address;
@@ -3038,6 +3041,40 @@ static const struct dmi_system_id chromebook_T9_suspend_dmi[] = {
 	{ }
 };
 
+static int mxt_regulator_enable(struct mxt_data *data)
+{
+	int error;
+
+	if (data->reset_gpio) {
+		error = regulator_enable(data->vdd_reg);
+		if (error) {
+			dev_err(&data->client->dev,
+				"Failed to enable vdd regulator: %d\n", error);
+			return error;
+		}
+
+		error = regulator_enable(data->avdd_reg);
+		if (error) {
+			regulator_disable(data->vdd_reg);
+
+			dev_err(&data->client->dev,
+				"Failed to enable avdd regulator: %d\n", error);
+			return error;
+		}
+
+		/*
+		 * According to maXTouch power sequencing specification,
+		 * RESET line must be kept low until some time
+		 * after regulators come up to voltage
+		 */
+		msleep(MXT_REGULATOR_DELAY);
+		gpiod_set_value(data->reset_gpio, 1);
+		msleep(MXT_RESET_INVALID_CHG);
+	}
+
+	return 0;
+}
+
 static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct mxt_data *data;
@@ -3098,6 +3135,22 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return error;
 	}
 
+	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_reg)) {
+		error = PTR_ERR(data->vdd_reg);
+		dev_err(&client->dev, "Failed to get vdd regulator: %d\n",
+			error);
+		return error;
+	}
+
+	data->avdd_reg = devm_regulator_get(&client->dev, "avdd");
+	if (IS_ERR(data->avdd_reg)) {
+		error = PTR_ERR(data->avdd_reg);
+		dev_err(&client->dev, "Failed to get avdd regulator: %d\n",
+			error);
+		return error;
+	}
+
 	error = devm_request_threaded_irq(&client->dev, client->irq,
 					  NULL, mxt_interrupt, IRQF_ONESHOT,
 					  client->name, data);
@@ -3108,11 +3161,9 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	disable_irq(client->irq);
 
-	if (data->reset_gpio) {
-		msleep(MXT_RESET_GPIO_TIME);
-		gpiod_set_value(data->reset_gpio, 1);
-		msleep(MXT_RESET_INVALID_CHG);
-	}
+	error = mxt_regulator_enable(data);
+	if (error)
+		return error;
 
 	error = mxt_initialize(data);
 	if (error)
@@ -3138,6 +3189,10 @@ static int mxt_remove(struct i2c_client *client)
 	struct mxt_data *data = i2c_get_clientdata(client);
 
 	disable_irq(data->irq);
+	if (data->reset_gpio) {
+		regulator_disable(data->avdd_reg);
+		regulator_disable(data->vdd_reg);
+	}
 	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
-- 
2.17.1

