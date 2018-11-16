Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25400C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F0D2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3rqOmR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F0D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbeKQJOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:14:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35656 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeKQJOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:14:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so11219687pgu.2;
        Fri, 16 Nov 2018 14:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=wcOr0IyKfNnQzLgC+t07yZkvswNA9tMU8FyJkchOris=;
        b=D3rqOmR27SbqitfqRcX4mV50QGNxqp1dASTsjtRThO5T0O1W69lg2F+rOMMEdw2QPp
         8bSIXObng/7C+Iw3OIZiCNXt9cmD860vf95OHDIT2UAxV3eFC1N9yptzF/c6MmDxZNg1
         IVdH/y1lLVcQNjl+N4KGoxuYANnOr1nzrtMqCKhp6ziynQAPkwScp7NrLH8eR4iRRj8W
         mf7Xr3UkY+J+w7m2BUmbLEKLwkspxYFefo09I2M6RZMrykJL/IffkuDckP8SXO7ENmp3
         AKjzl6PtzlPbu2n4vJg8r7tLNrLdRSJbZ84TaRqxM0/KfhNTEkaTt0G0eDv5RW5Z4+ra
         fztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=wcOr0IyKfNnQzLgC+t07yZkvswNA9tMU8FyJkchOris=;
        b=fSCW8Qelvt2O/EiV5nEqezKd3cQlLxaeiUQIq/rmG/OIlwJANsxwtDoDPQDXz1NayS
         /0MAGI2/EGGhjPPSm0Z99LyUlEAOwzu4fyV5nF1avQsNF8QiCDH2P4hHo06Z2vDgs5fc
         v5ig0/A90Iv7/JvJCxczi4kyqspwrFRyiNxsCSM+vdLjEEeuJU+qusyxWiIGesrAMI6Q
         ingX0fXafUutqDwqTrCa5c3h2JdKjDyRHqTWexVTvYVCu1vaNoJVxDcGDgpvt0bGdspA
         YEIWWs96adR2IirnuutNSOL8HaEFlFRU9O1FrIUkNhJl8EXKM8bIec0qqdhSE7o/eEWW
         IfHw==
X-Gm-Message-State: AGRZ1gJIlDz15Q2heUmSGbAHQFlOoCBHy5K4czjrRMC5+JdV8d6TLNJn
        GAz7Q6goEexnqH/XyyFVAH4=
X-Google-Smtp-Source: AJdET5d8t5MH/dIeL+10DWve5kO2nZJ4mq+gL1DFmwEEZKNCVrT+EliGYcH6i+xgw4F5CaMoBoIneQ==
X-Received: by 2002:a63:5c41:: with SMTP id n1mr10265692pgm.1.1542409195175;
        Fri, 16 Nov 2018 14:59:55 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.154])
        by smtp.gmail.com with ESMTPSA id w80-v6sm55317406pfk.11.2018.11.16.14.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:59:54 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] Staging: iio: adt7316: Switch irq_flags to a local variable
Date:   Sat, 17 Nov 2018 04:29:49 +0530
Message-Id: <20181116225949.24913-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to store irq_flags into the structure as it
is always set to the same thing. Hence switch irq_flags to a
local variable.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c | 1 -
 drivers/staging/iio/addac/adt7316-spi.c | 1 -
 drivers/staging/iio/addac/adt7316.c     | 8 ++++----
 drivers/staging/iio/addac/adt7316.h     | 1 -
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index d4b5060c18ee..91d6cdcb747e 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -104,7 +104,6 @@ static int adt7316_i2c_probe(struct i2c_client *client,
 	struct adt7316_bus bus = {
 		.client = client,
 		.irq = client->irq,
-		.irq_flags = IRQF_TRIGGER_LOW,
 		.read = adt7316_i2c_read,
 		.write = adt7316_i2c_write,
 		.multi_read = adt7316_i2c_multi_read,
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 5cd22743e140..e75827e326a6 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -94,7 +94,6 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 	struct adt7316_bus bus = {
 		.client = spi_dev,
 		.irq = spi_dev->irq,
-		.irq_flags = IRQF_TRIGGER_LOW,
 		.read = adt7316_spi_read,
 		.write = adt7316_spi_write,
 		.multi_read = adt7316_spi_multi_read,
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index deb2f7b40f60..dfae22619287 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2102,6 +2102,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
 	unsigned short *adt7316_platform_data = dev->platform_data;
+	int irq_flags = IRQF_TRIGGER_LOW;
 	int ret = 0;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
@@ -2146,19 +2147,18 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 
 	if (chip->bus.irq > 0) {
 		if (adt7316_platform_data[0])
-			chip->bus.irq_flags = adt7316_platform_data[0];
+			irq_flags = adt7316_platform_data[0];
 
 		ret = devm_request_threaded_irq(dev, chip->bus.irq,
 						NULL,
 						adt7316_event_handler,
-						chip->bus.irq_flags |
-						IRQF_ONESHOT,
+						irq_flags | IRQF_ONESHOT,
 						indio_dev->name,
 						indio_dev);
 		if (ret)
 			return ret;
 
-		if (chip->bus.irq_flags & IRQF_TRIGGER_HIGH)
+		if (irq_flags & IRQF_TRIGGER_HIGH)
 			chip->config1 |= ADT7316_INT_POLARITY;
 	}
 
diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
index ec40fbb698a6..fd7c5c92b599 100644
--- a/drivers/staging/iio/addac/adt7316.h
+++ b/drivers/staging/iio/addac/adt7316.h
@@ -17,7 +17,6 @@
 struct adt7316_bus {
 	void *client;
 	int irq;
-	int irq_flags;
 	int (*read)(void *client, u8 reg, u8 *data);
 	int (*write)(void *client, u8 reg, u8 val);
 	int (*multi_read)(void *client, u8 first_reg, u8 count, u8 *data);
-- 
2.17.1

