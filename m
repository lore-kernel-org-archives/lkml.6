Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D4AC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D922084F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNow0tf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfASSjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:39:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46439 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbfASSjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 13:39:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so8177695pfe.13;
        Sat, 19 Jan 2019 10:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=RtrWvJAg8tLRadW6+RGapN9Sh+dFGoMqmkYArH9t5tY=;
        b=UNow0tf4Q13A0CNJ9QQS57gJzTJYgNE5OJu+9QlzocQhuAoF3Ipa/RXfX6s0oXQmXb
         SNAGhSmEn71joXJuLY0Ij7f9EZzKdbWRJgCU4IgIJWW+Xz+LrZGgI02hVFCb9PSwxgwW
         I6ZhPtiF13A8qOQmgborzcGuFzUIH8f6oLJVH80xFJAjtPpypb1hrTK0g9TgGVZuIokO
         lRmm8q9SZbDanby3aefdF038Ytx2klIEunoZEy5NK/CiK6XDZtJZGQgKOy67Cgb8Six7
         1DUBXiYTpCjxb3Ws34AlSqzWsBUkoxvnPZ5ZhbcmPd3K5dNnlnJWTybzO+sCYuPtug48
         BtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=RtrWvJAg8tLRadW6+RGapN9Sh+dFGoMqmkYArH9t5tY=;
        b=klBib8689/osjqUOd3wwE02RAYvOwi1vNADbS6pG5vTotRI4ilNUWidkhWMSutMB+3
         zUBPVZLlIuoTtkahgszeQDJc5YicxR/FYzKmnm30yNW2zMqbP24nXrOMvYnDp0NuUxhz
         v+iaKqjhdL5PlQDHAI0MGsU8Revh+d+OXqwoc4ehJw0XpYBvtQ+YNl+1YF+VPzvlwjiW
         BkXkSly9irOHkR+0ZL9mVgTvKB36aneKo9gUCwv+zonKtsIhECNojJqNDHkYbAS0PSDQ
         H5XaFjiBShhb+v6jrzE6I8t+RAwgwrA4EW12+6ejAiF9ZULk2yFwo3fIDRQpvyjukklo
         tUQQ==
X-Gm-Message-State: AJcUukcWyMWs8PZfuSW0Ygj2o7Hk4WLwxS0ZvG+HUkJC7k0kgBoxBNQ+
        7KgCcBEfV7z8NUBdwkTDoRM=
X-Google-Smtp-Source: ALg8bN60L4OE3J/62YXR/m1V18tCI9i4Ii50F/1N7EkJEzkEg1yPiwJsSSSPWg9ZWb4Sq/ytvUIG+g==
X-Received: by 2002:a63:374e:: with SMTP id g14mr22819442pgn.59.1547923186093;
        Sat, 19 Jan 2019 10:39:46 -0800 (PST)
Received: from localhost.localdomain ([49.33.214.52])
        by smtp.gmail.com with ESMTPSA id m20sm10127471pgb.56.2019.01.19.10.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 10:39:45 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, shreeya.patel23498@gmail.com
Subject: [PATCH v2 1/3] Staging: iio: adt7316: Remove irq from bus structure
Date:   Sun, 20 Jan 2019 00:09:30 +0530
Message-Id: <20190119183932.14321-2-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119183932.14321-1-shreeya.patel23498@gmail.com>
References: <20190119183932.14321-1-shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

interrupt request is not needed to be present in the bus
structure. It is a good option to pass it as a parameter
in the probe function instead of having it in the bus structure.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c |  3 +--
 drivers/staging/iio/addac/adt7316-spi.c |  4 ++--
 drivers/staging/iio/addac/adt7316.c     | 15 +++++++--------
 drivers/staging/iio/addac/adt7316.h     |  3 +--
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index ac91163656b5..335c17731cf7 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -103,14 +103,13 @@ static int adt7316_i2c_probe(struct i2c_client *client,
 {
 	struct adt7316_bus bus = {
 		.client = client,
-		.irq = client->irq,
 		.read = adt7316_i2c_read,
 		.write = adt7316_i2c_write,
 		.multi_read = adt7316_i2c_multi_read,
 		.multi_write = adt7316_i2c_multi_write,
 	};
 
-	return adt7316_probe(&client->dev, &bus, id->name);
+	return adt7316_probe(&client->dev, &bus, id->name, client->irq);
 }
 
 static const struct i2c_device_id adt7316_i2c_id[] = {
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index e75827e326a6..adaaa3eecd04 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -93,7 +93,6 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 {
 	struct adt7316_bus bus = {
 		.client = spi_dev,
-		.irq = spi_dev->irq,
 		.read = adt7316_spi_read,
 		.write = adt7316_spi_write,
 		.multi_read = adt7316_spi_multi_read,
@@ -112,7 +111,8 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 	adt7316_spi_write(spi_dev, 0, 0);
 	adt7316_spi_write(spi_dev, 0, 0);
 
-	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias);
+	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias,
+			     spi_dev->irq);
 }
 
 static const struct spi_device_id adt7316_spi_id[] = {
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 1ca4ee0f30ee..6b4b80fd80cc 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1807,12 +1807,12 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static int adt7316_setup_irq(struct iio_dev *indio_dev)
+static int adt7316_setup_irq(struct iio_dev *indio_dev, int irq)
 {
 	struct adt7316_chip_info *chip = iio_priv(indio_dev);
 	int irq_type, ret;
 
-	irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
+	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));
 
 	switch (irq_type) {
 	case IRQF_TRIGGER_HIGH:
@@ -1828,13 +1828,12 @@ static int adt7316_setup_irq(struct iio_dev *indio_dev)
 		break;
 	}
 
-	ret = devm_request_threaded_irq(&indio_dev->dev, chip->bus.irq,
+	ret = devm_request_threaded_irq(&indio_dev->dev, irq,
 					NULL, adt7316_event_handler,
 					irq_type | IRQF_ONESHOT,
 					indio_dev->name, indio_dev);
 	if (ret) {
-		dev_err(&indio_dev->dev, "failed to request irq %d\n",
-			chip->bus.irq);
+		dev_err(&indio_dev->dev, "failed to request irq %d\n", irq);
 		return ret;
 	}
 
@@ -2134,7 +2133,7 @@ static const struct iio_info adt7516_info = {
  * device probe and remove
  */
 int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
-		const char *name)
+		  const char *name, int irq)
 {
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
@@ -2180,8 +2179,8 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (chip->bus.irq > 0) {
-		ret = adt7316_setup_irq(indio_dev);
+	if (irq > 0) {
+		ret = adt7316_setup_irq(indio_dev, irq);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
index fd7c5c92b599..03d5300a98cd 100644
--- a/drivers/staging/iio/addac/adt7316.h
+++ b/drivers/staging/iio/addac/adt7316.h
@@ -16,7 +16,6 @@
 
 struct adt7316_bus {
 	void *client;
-	int irq;
 	int (*read)(void *client, u8 reg, u8 *data);
 	int (*write)(void *client, u8 reg, u8 val);
 	int (*multi_read)(void *client, u8 first_reg, u8 count, u8 *data);
@@ -30,6 +29,6 @@ extern const struct dev_pm_ops adt7316_pm_ops;
 #define ADT7316_PM_OPS NULL
 #endif
 int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
-		   const char *name);
+		  const char *name, int irq);
 
 #endif
-- 
2.17.1

