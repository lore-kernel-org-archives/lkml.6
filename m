Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E24ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E195120693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXRYZoQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E195120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbeGQSu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:50:28 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34878 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbeGQSu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:50:28 -0400
Received: by mail-lf0-f65.google.com with SMTP id f18-v6so1532207lfc.2;
        Tue, 17 Jul 2018 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QaJ7ttVA72aV94Rh03/JiLjYYA6jS/C/gXFMPtN/Hag=;
        b=tXRYZoQ450Ol5Bx2/DlrhzrjVtiwLyE+bQKNflohRzqRCSsSyR30VFFrohYgUaxquN
         zV1HWak8Raeye5gp4jlxrdk6EIXGjgGKkpj6Q8u1o8ZJjJs6hNTMGeKUTJx2B7IDgpU1
         QigWm1a6RMGcFxUzitHrPOmhn3u5DH0KhftreAR5OVAFNVh4suDo3RUJrQmzNZD1zVeq
         pC5sqfAXgJDkAv/d3petvjzH1hzMDyW16SiHpYt/6LlEv6ZOl12V1ryjdaBz51oxFPkD
         LIwc7TCtDXbZMSgyfqwY9pEXCPl6T39/WEbW07+qi9My3Tg6z2/hmyLz34pzgnYxUf/q
         QZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QaJ7ttVA72aV94Rh03/JiLjYYA6jS/C/gXFMPtN/Hag=;
        b=qFGCCUOaM9UFsi4vv7QjI2U3wwp3IRfT0rLSswAH3Cc7lmrEieFQJCpP4SqlK791we
         z8pRaiWNdooM+hrTcCliAcyi6RvDJG/xn0M3h2v+/Rwnlw/AInSoColTsG/wnXVT7JMi
         lrgUeyiM+XnJmS+bcFdzJSZWOlDo+TKRBYTjaJEXgq1UFB04tY6IWDJeKFKiRl/NDPml
         TNx+i5mB5vT2b5GuUXG1+XQgn7CgGQxO0r91KmA7EO8kkU9whXXVntLnCSyUnP+Bxett
         55km24cLMDu/2u4A4VopXlIFrW2mkvwY8WdImUxapgEfGB05N3J3V6JnIowf9pBLsPU6
         mDBQ==
X-Gm-Message-State: AOUpUlE/qXE7n6kWIILWyMMEhDu2NjXKqq2uMKuCJnCZ5CJKDNH4fifX
        oco9lgrfIlMt+ZGaNXwa+hg=
X-Google-Smtp-Source: AAOMgpfBW7XSd6On2v42uJ06Tkr8C+4E3oFWd+d2cWy0ecYpi7D+t0G3t737KUPkEv5goPGDNciCcA==
X-Received: by 2002:a19:de4e:: with SMTP id v75-v6mr1870982lfg.14.1531851396196;
        Tue, 17 Jul 2018 11:16:36 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.googlemail.com with ESMTPSA id u19-v6sm260911lje.51.2018.07.17.11.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 11:16:35 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 1/2] Input: atmel_mxt_ts: Add support for  optional regulators.
Date:   Tue, 17 Jul 2018 20:16:25 +0200
Message-Id: <1531851386-17840-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531851386-17840-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1531851386-17840-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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
Changes from v1:
  - Enable regulators only if reset_gpio is present.
  - Switch from devm_regulator_get_optional to devm_regulator_get
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 46 ++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 54fe190fd4bc..005f0fee9fc8 100644
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
@@ -3076,6 +3079,22 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -3087,7 +3106,26 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	disable_irq(client->irq);
 
 	if (data->reset_gpio) {
-		msleep(MXT_RESET_GPIO_TIME);
+		error = regulator_enable(data->vdd_reg);
+		if (error) {
+			dev_err(&client->dev, "Failed to enable vdd regulator: %d\n",
+				error);
+			return error;
+		}
+
+		error = regulator_enable(data->avdd_reg);
+		if (error) {
+			dev_err(&client->dev, "Failed to enable avdd regulator: %d\n",
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
 		gpiod_set_value(data->reset_gpio, 1);
 		msleep(MXT_RESET_INVALID_CHG);
 	}
@@ -3116,6 +3154,10 @@ static int mxt_remove(struct i2c_client *client)
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

