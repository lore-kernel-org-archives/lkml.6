Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B0BC676ED
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C627120880
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFONTUXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfATPgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 10:36:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33059 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfATPgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 10:36:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so8314750pgu.0;
        Sun, 20 Jan 2019 07:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fRCPX5chTIBAFsDlbyZCIlcj9BgORSL+wFqz9r1DqOs=;
        b=cFONTUXnI/smo10RppPd+szehK1qn9ddmEJiFruYrUwbAwyBxqmaqV1kn4qMFMz8vu
         Q4ObGBrlpGWrrZbOToiUdYl90Zs5FuXfds3HXrE7qhGdMOtP4bDabhvyC+pirkXm77WD
         lf/sOkb5/cHEZt/K5ijvWkQHI9OBEECXApyJ3GW5pjd0qJazloZXC42ceIZFxfUVNS+w
         dS6LaNCsrWeT4T3DLZBXwErCAXYFIz6xTdCvnXOdlV0/tfnCWRUO26199oTLu79XGt93
         G2RJhzkVVzv1O5wuw2dBgse/PggfVU4FW24Nm36JFMonloDcPF50TsuhQ9E9pHjlxrLp
         NibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fRCPX5chTIBAFsDlbyZCIlcj9BgORSL+wFqz9r1DqOs=;
        b=je6jADnTb5DLsEwkIuB5w/qySGLGYg5zDsYNqwBjAdGJPhmM3bEhQJYEyJgttsLh2R
         6vccir914D1NpLZ4FexFxa+Ii2wmFeOMldoDh4UbS4cvshRifamuYta9JuPyP7a/KCPn
         9pjY3Lwhcsist5a2ACI/1PSqoiwf9fOzTwLmLcmPmiD8d7gUuSwDQYLgkkdJls4l8OPj
         TL+6u70IU+5/5S79dMdeYSZohTADMzapdY4jRLIwNn4PEwnsVMvBAWzGiKki7chdhAu2
         Rf5bISXijWnTkuNUnRDDkXR9lUorD2nl9cPDLkIK4rFOjutzZIyESzwPFzZ/LFIAhPix
         tBjQ==
X-Gm-Message-State: AJcUuketa1JdKJhx25Upwj2YE2bsv4ARLGZ7D/mTAdjIr8PyHTCe/fcN
        6op6qnx9NqkOQmCyGfm7Ndo=
X-Google-Smtp-Source: ALg8bN4eZpUHtcD8b9YiUg5EKFUG9iX9v7y+0khaM8o58jL7kO0qK9gD0lB9M2VMn7DS8a5dLTqOLQ==
X-Received: by 2002:a63:f141:: with SMTP id o1mr25320499pgk.134.1547998605263;
        Sun, 20 Jan 2019 07:36:45 -0800 (PST)
Received: from localhost.localdomain ([223.189.18.171])
        by smtp.gmail.com with ESMTPSA id o8sm21451376pfa.42.2019.01.20.07.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 07:36:44 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, jeremyfertic@gmail.com,
        shreeya.patel23498@gmail.com
Subject: [PATCH v3 1/3] Staging: iio: adt7316: Remove irq from bus structure
Date:   Sun, 20 Jan 2019 21:06:31 +0530
Message-Id: <20190120153633.18231-2-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190120153633.18231-1-shreeya.patel23498@gmail.com>
References: <20190120153633.18231-1-shreeya.patel23498@gmail.com>
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
index 2d51bd425662..b6571db2e8d8 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -99,14 +99,13 @@ static int adt7316_i2c_probe(struct i2c_client *client,
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
index 8cf3ff25eb62..30808a897fc2 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1809,12 +1809,12 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
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
@@ -1830,13 +1830,12 @@ static int adt7316_setup_irq(struct iio_dev *indio_dev)
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
 
@@ -2136,7 +2135,7 @@ static const struct iio_info adt7516_info = {
  * device probe and remove
  */
 int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
-		  const char *name)
+		  const char *name, int irq)
 {
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
@@ -2182,8 +2181,8 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
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
index 84ca4f6c88f5..03d5300a98cd 100644
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
-		  const char *name);
+		  const char *name, int irq);
 
 #endif
-- 
2.17.1

