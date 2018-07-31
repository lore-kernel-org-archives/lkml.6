Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186BFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC4C208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXqw1/1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC4C208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbeGaQ7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:59:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40387 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbeGaQ7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:59:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19-v6so14053444ljc.7;
        Tue, 31 Jul 2018 08:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZ94a8W+BvjEbwmHniIBt9d9Nc6fsheuNctdvesDdc8=;
        b=eXqw1/1CKd3PdVIAa30McnUNJJ4ysC0/HgBx2i00jwKFRhCFW1Xyczpj8H812WrYbA
         ybPIGIgkpBJmYxWtcyXV5UOz1VrCFT/c8qDzaEuCinzHL5DQdtMJ4JFv4EcwRHvTm97y
         PyiUDUA1lS4IrM6d2v4Zb04q34TXjTwFxwJhjhZES8eUwTGq504Y+GlWmZxHxdYirFXe
         HAcdb0tQJw39pIuGGPaJDNs5Oaq5zBp/H27oJiyp1b8/yhZ855iRFca2PsnSEYQIJjKk
         dsaJo22KMgGGctfHXg3t+xUsebVH1BKUVqBnA8TsPWTIZlmHIn9mXr6Fuhsu6I6StmRu
         ueGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZ94a8W+BvjEbwmHniIBt9d9Nc6fsheuNctdvesDdc8=;
        b=Xg2PBMDFtJFCNT4ow+U2CDjEiFQ81A5e0sQEyy8gm0hX9LdFk9RKXxqt+fdq9YwpYo
         xnkHuXwzr9sIKQcpRWrjHpxryjPTKjB9Z6ZTpDz2cqjPo1+mdsOgSSME8rJQL+/5Hc76
         baIksysucrtVqvI2xkdlThnoGgEOlilr/rbwlX2fAxx1WfZk5KsOhvh+yWsF/Woprobw
         sBNPUAV5bTXNdSoxwteI4crpUOCPpswx0dkQW+1YVCAJ3ftO46F977IDMlATBIbd45ql
         WqNhFnQklxlFPZvVI1Gkt5CBfTWlpVJXjJDS35UZWM0mOr7juuqGNWRhTtK71Ncu0cD3
         NWRw==
X-Gm-Message-State: AOUpUlG1thYCKVJuaUUW+iKNepZE5l9GlzLZtdemihO+7Z1tHi0JcnDl
        HT0nahdNDOeGntugoozT9aI=
X-Google-Smtp-Source: AAOMgpdptiUabp5AVa30SIhYXopXkcC0/vAlc9HrefE3Hvtoh/8KgU60xuI/O+ao5PCb9Wr4d5P49Q==
X-Received: by 2002:a2e:4d9d:: with SMTP id c29-v6mr15693014ljd.132.1533050301996;
        Tue, 31 Jul 2018 08:18:21 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-173-71.play-internet.pl. [94.254.173.71])
        by smtp.googlemail.com with ESMTPSA id p88-v6sm2606209ljp.90.2018.07.31.08.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 08:18:21 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v3 1/3] Input: atmel_mxt_ts: Add support for  optional regulators.
Date:   Tue, 31 Jul 2018 17:18:09 +0200
Message-Id: <1533050291-11502-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533050291-11502-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1533050291-11502-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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
Changes from v2:
  - Move code enabling regulators into separate method,
    to make code more readable.

Changes from v1:
  - Enable regulators only if reset_gpio is present.
  - Switch from devm_regulator_get_optional to devm_regulator_get
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 65 +++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 54fe190fd4bc..2cd7f6db6ba9 100644
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
@@ -310,6 +311,8 @@ struct mxt_data {
 	struct t7_config t7_cfg;
 	struct mxt_dbg dbg;
 	struct gpio_desc *reset_gpio;
+	struct regulator *vdd_reg;
+	struct regulator *avdd_reg;
 
 	/* Cached parameters from object table */
 	u16 T5_address;
@@ -3016,6 +3019,38 @@ static const struct dmi_system_id chromebook_T9_suspend_dmi[] = {
 	{ }
 };
 
+static int mxt_regulator_enable(struct mxt_data *data)
+{
+	int error;
+
+	if (data->reset_gpio) {
+		error = regulator_enable(data->vdd_reg);
+		if (error) {
+			dev_err(&data->client->dev, "Failed to enable vdd regulator: %d\n",
+				error);
+			return error;
+		}
+
+		error = regulator_enable(data->avdd_reg);
+		if (error) {
+			dev_err(&data->client->dev, "Failed to enable avdd regulator: %d\n",
+				error);
+			return error;
+		}
+
+		/*
+		 * According to maXTouch power sequencing specification, RESET line
+		 * must be kept low until some time after regulators come up to
+		 * voltage
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
@@ -3076,6 +3111,22 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -3086,11 +3137,9 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
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
@@ -3116,6 +3165,10 @@ static int mxt_remove(struct i2c_client *client)
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
2.7.4

