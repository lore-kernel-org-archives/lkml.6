Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688AEC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2024B20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx9N47JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2024B20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLGO3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:29:09 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41167 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeLGO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:29:06 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so3152239lfj.8;
        Fri, 07 Dec 2018 06:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+OENI6YtzSczLSuymPnFLAriTDDg6DPhxH59mLlxng=;
        b=Wx9N47JXA0kxNsiHKrumv040W7czuEfj/tQSCfblQxXVckW73b2Z5wN2DcD7Ig9y63
         0JwoRZDcFjcV3E+42WvSntm3HZnYAzYsMMJyoCe1oy9ALzbJraLdfH75MohITf8jcXZm
         +4EGkgFxEOedNHjlSM033SO1Dw+tVZrTdONNCchri5jahpXrn4ZHNs1cjA6txoCVyKFk
         PENspGs45go8eoOtO1zQFKVZKk6Zucc9YeYtmqgtzp8VN6nKVjGkKrIuwBRHKyt0P5rN
         NJcIWpu8tJn45jmpe1YL8ggeJGbHF5HfvLwjvKWKLgTKRMzyV1hawSpRtDcHS9xr8f4X
         3kJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+OENI6YtzSczLSuymPnFLAriTDDg6DPhxH59mLlxng=;
        b=RsoGAQZpPgff1IxbHP/GykvQ5j8UN+pjT8l/vx9nHWWqU2mTttZZR785QhIVJPFgNF
         bdaOnwklLd7Kc3GblOeVQYpKYxEkHXsIaIhc2j7rHkeSCJvjScuwmayd77TLblNFePaU
         uPB8/mLiUc60L9Nia8FolJ4s9b+KYlzkhbvJKhax3xTHo5JBTm0yHwaa3CLfJHsfyL+1
         DcS2eJW+6kQBDBgs+Vu/DOSQuY8QKy3+RrUe8ef55c8+yGtAWoo4WVaiM09T0sXWFLn3
         q9aCr2kktGvaCC9JIq2dfLVPNzO0cPdDl/GTNU1lVC49R1OmmcRu2IN3HgzNeYUpseMc
         KvGQ==
X-Gm-Message-State: AA+aEWZDIT8z3Grv380O6S8bZ6vbRwlFTlY5vz7SzRvuQjsJcVgpYRjA
        6oNSDw7/Jw9qJe2LnPFqpEo=
X-Google-Smtp-Source: AFSGD/Xel2TAfxU/X85KmS2yoOaa1eMH70+7GtbBT3zSR22gSbGsDe46di7TQVf6SYoJPVUlKA0YMw==
X-Received: by 2002:a19:280f:: with SMTP id o15mr1461603lfo.0.1544192943060;
        Fri, 07 Dec 2018 06:29:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
        by smtp.googlemail.com with ESMTPSA id v64sm630504lfa.48.2018.12.07.06.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 06:29:02 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v4 1/3] Input: atmel_mxt_ts: Add support for  optional regulators
Date:   Fri,  7 Dec 2018 15:28:55 +0100
Message-Id: <20181207142857.15818-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
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
Changes from v3:
  - Fix checkpatch issues
  - Drop sentence punctuation from subject of one of patches

Changes from v2:
  - Move code enabling regulators into separate method,
    to make code more readable.

Changes from v1:
  - Enable regulators only if reset_gpio is present.
  - Switch from devm_regulator_get_optional to devm_regulator_get
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 65 +++++++++++++++++++++---
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index d3aacd534e9c..1dc8ad0da5af 100644
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
@@ -3038,6 +3041,38 @@ static const struct dmi_system_id chromebook_T9_suspend_dmi[] = {
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
@@ -3098,6 +3133,22 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -3108,11 +3159,9 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
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
@@ -3138,6 +3187,10 @@ static int mxt_remove(struct i2c_client *client)
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

