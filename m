Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF843C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFCD208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4lO0s7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFCD208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbeKUD1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:27:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46859 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKUD1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:27:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so1138870pgp.13;
        Tue, 20 Nov 2018 08:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=/6kx2Bggq2klXhF/moriz5e4i2xZPc9arr0AFnneIzY=;
        b=D4lO0s7WhDzdX9NZLLEO7GoRMOAb8rIXaDRecB30ON0rtuJg29hhoqN396DJ5c8psd
         NX95bUw/hIXJLXfQkV+fJsYaO8Cge6Z04z7c2gWZVUvQULx9svBahD/5FTgJvR/YmCPA
         2BmrkzC/Tb6EAIgEj3x3bUtis+UvIX4VUbRWiM/3PTiy/VvFHxomTBNnNw/Vy7ARDMQ9
         +hQvCkiS/lEP8y3/GzzbMw9A83MyJPkdLmxkrnRQ1W4C7xCznPFWypcBLDlUAOkLNhmh
         bxwWkHwSybV4PEQT0AKICDiJ3vZgJOHjwQTthjGjNIZXYgnkUDnQmn8XErbg7y8869Sz
         LuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=/6kx2Bggq2klXhF/moriz5e4i2xZPc9arr0AFnneIzY=;
        b=o2pixvXPSM6gFG8ZAoJJd0+J8J6TwvTkb3fIym7YllUHY4EFQ2rfVIvsefS1Eop+8v
         CTkj8Y01f5+3DtwYqdq397PB8GYDbtvWlMpCkC5sEMtAcoYSRquR73m0Nso38pSIheAq
         LdTbTwYdI5xbtxo8skBfjDOuazA09QWM6Hc//dS/c21fU9FFETwf/FohC2fRcUn09Uyl
         V0Epx2u0cJDSn5BgpmmSzeenhHeA6mTLmMZI2rHrlACyCWTpxxV9zvNUVdTpr/5Y/Na9
         h2A6SbYZhrZatuxyJHvrQiuD5fV2dGZP6Ts870Vr/2+N2aVPbzdSRUJ5MBTmIE7fqt+7
         VLjg==
X-Gm-Message-State: AA+aEWaML1cS4g7kOCWoAklxzAC39gPaqsTI7tXyQ2hneUqTD5Qb1bs2
        w/p6dt+AVHSE3cs/Veoevgw=
X-Google-Smtp-Source: AFSGD/WZjw6utnaLYKAd7Wajrc1tyGSy1aaHlquc8MIat4R1pHKlbIMQ3BJjNq6NBnl5sTq0SHkH5Q==
X-Received: by 2002:a65:66ce:: with SMTP id c14mr2573306pgw.450.1542733025908;
        Tue, 20 Nov 2018 08:57:05 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.152])
        by smtp.gmail.com with ESMTPSA id h8sm27062360pgv.27.2018.11.20.08.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:57:05 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] Staging: iio: adt7316: Switch irq_flags to a local variable
Date:   Tue, 20 Nov 2018 22:26:58 +0530
Message-Id: <20181120165658.7259-1-shreeya.patel23498@gmail.com>
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
index 41bc4ca008bc..ac91163656b5 100644
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

