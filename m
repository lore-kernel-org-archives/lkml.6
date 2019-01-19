Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C12EC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DC22084F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nehJCdfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfASSjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:39:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35014 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbfASSjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 13:39:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so8210789pfi.2;
        Sat, 19 Jan 2019 10:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=sVOAklPk261L5+RTM1KzurR44bu8p9J8BGuUmJ4GCSg=;
        b=nehJCdfosBLJWbp4TGUGU5Q2xMmcFXHpMIVpJJOz72gSaPStSwSrJDduvJ1TN4+xsS
         i5kGQR+BxN/U9mwOL+DXT+nV/88/UBHLkZ3CocTp0Hx6Dwa5nyfEHEsF5TOvKQByMp/o
         NwaRajsgTqrWojJ6tTOXwxOLzSri1JJ7u273LaZHZpnpG4B+Xqdy+u9PkJAgn72PkypQ
         FnLZXq33ED56aZGmUhMPMIY3DFOWIOiHq+srHWFYYN8wZMjGjxDERdZberCuHW91uDpe
         nvL0nQcCBZ6+cWuuygnQkQ5xX4bO3dfyyA+7XNpGGUKGshTJyKnvhPcZYeyekr3NBZ0E
         JVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=sVOAklPk261L5+RTM1KzurR44bu8p9J8BGuUmJ4GCSg=;
        b=JpFmzwlxm3Lz0T56Gizo5EjsykbAmiUM3yiQtcIyuRlz36gbBk5Rd/0Ssk8PUuoe3h
         OG1fj7+i9pZMjHhKHBpN+dX1CCVbmC0Rxw+e1q6oVd1yxgUOUeEyOOH2FQxZGnUS5r0h
         pVdFAVETzQ8WJONt3xkII0CxmEkGLvqy1W+Be3X9oz7F9bHEwrUnqsW9qKlmAYvy682L
         EeyQ2NDPmqILgWh9y3CYSt8mDdk/vRsUuI2Df85LvUhpPYiIo2pSi5VbDY6AqestwbaS
         0xXB+f0YnsbUhUpC8BClY7WHRwmzxMTCm9iP8JdnV8IMz5Xn8EElR5eCMLgwIcUQMtpo
         Onmg==
X-Gm-Message-State: AJcUukeRUlGZUEUF9FMoEg0WOiuBqqSaHqlWW1d7VllJO3smg+e1Ylcf
        X3J9FbwZfz7lBqMZ0RHngP4=
X-Google-Smtp-Source: ALg8bN6Wh4HAnsz6LaDG05bGZ/WCLvIhzPQg7go7Tg4bX8Dd+4O2TXj0D5pArRFGS+/ngbVEtStvUQ==
X-Received: by 2002:a62:5d0c:: with SMTP id r12mr25055773pfb.0.1547923190835;
        Sat, 19 Jan 2019 10:39:50 -0800 (PST)
Received: from localhost.localdomain ([49.33.214.52])
        by smtp.gmail.com with ESMTPSA id m20sm10127471pgb.56.2019.01.19.10.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 10:39:50 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, shreeya.patel23498@gmail.com
Subject: [PATCH v2 2/3] Staging: iio: adt7316: Remove multi read and write functions
Date:   Sun, 20 Jan 2019 00:09:31 +0530
Message-Id: <20190119183932.14321-3-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119183932.14321-1-shreeya.patel23498@gmail.com>
References: <20190119183932.14321-1-shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, adt7316 doesn't use multi read and multi write
functions hence remove the redundant code and make the
necessary changes in the code.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c | 40 -------------------------
 drivers/staging/iio/addac/adt7316-spi.c | 31 ++++---------------
 drivers/staging/iio/addac/adt7316.h     |  2 --
 3 files changed, 6 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 335c17731cf7..40aa9e2f1966 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -56,44 +56,6 @@ static int adt7316_i2c_write(void *client, u8 reg, u8 data)
 	return ret;
 }
 
-static int adt7316_i2c_multi_read(void *client, u8 reg, u8 count, u8 *data)
-{
-	struct i2c_client *cl = client;
-	int i, ret = 0;
-
-	if (count > ADT7316_REG_MAX_ADDR)
-		count = ADT7316_REG_MAX_ADDR;
-
-	for (i = 0; i < count; i++) {
-		ret = adt7316_i2c_read(cl, reg, &data[i]);
-		if (ret < 0) {
-			dev_err(&cl->dev, "I2C multi read error\n");
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static int adt7316_i2c_multi_write(void *client, u8 reg, u8 count, u8 *data)
-{
-	struct i2c_client *cl = client;
-	int i, ret = 0;
-
-	if (count > ADT7316_REG_MAX_ADDR)
-		count = ADT7316_REG_MAX_ADDR;
-
-	for (i = 0; i < count; i++) {
-		ret = adt7316_i2c_write(cl, reg, data[i]);
-		if (ret < 0) {
-			dev_err(&cl->dev, "I2C multi write error\n");
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 /*
  * device probe and remove
  */
@@ -105,8 +67,6 @@ static int adt7316_i2c_probe(struct i2c_client *client,
 		.client = client,
 		.read = adt7316_i2c_read,
 		.write = adt7316_i2c_write,
-		.multi_read = adt7316_i2c_multi_read,
-		.multi_write = adt7316_i2c_multi_write,
 	};
 
 	return adt7316_probe(&client->dev, &bus, id->name, client->irq);
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index adaaa3eecd04..1a78dc1e2840 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -23,15 +23,12 @@
  * adt7316 register access by SPI
  */
 
-static int adt7316_spi_multi_read(void *client, u8 reg, u8 count, u8 *data)
+static int adt7316_spi_read(void *client, u8 reg, u8 *data)
 {
 	struct spi_device *spi_dev = client;
 	u8 cmd[2];
 	int ret = 0;
 
-	if (count > ADT7316_REG_MAX_ADDR)
-		count = ADT7316_REG_MAX_ADDR;
-
 	cmd[0] = ADT7316_SPI_CMD_WRITE;
 	cmd[1] = reg;
 
@@ -43,7 +40,7 @@ static int adt7316_spi_multi_read(void *client, u8 reg, u8 count, u8 *data)
 
 	cmd[0] = ADT7316_SPI_CMD_READ;
 
-	ret = spi_write_then_read(spi_dev, cmd, 1, data, count);
+	ret = spi_write_then_read(spi_dev, cmd, 1, data, 1);
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI read data error\n");
 		return ret;
@@ -52,21 +49,17 @@ static int adt7316_spi_multi_read(void *client, u8 reg, u8 count, u8 *data)
 	return 0;
 }
 
-static int adt7316_spi_multi_write(void *client, u8 reg, u8 count, u8 *data)
+static int adt7316_spi_write(void *client, u8 reg, u8 val)
 {
 	struct spi_device *spi_dev = client;
 	u8 buf[ADT7316_REG_MAX_ADDR + 2];
-	int i, ret = 0;
-
-	if (count > ADT7316_REG_MAX_ADDR)
-		count = ADT7316_REG_MAX_ADDR;
+	int ret = 0;
 
 	buf[0] = ADT7316_SPI_CMD_WRITE;
 	buf[1] = reg;
-	for (i = 0; i < count; i++)
-		buf[i + 2] = data[i];
+	buf[2] = val;
 
-	ret = spi_write(spi_dev, buf, count + 2);
+	ret = spi_write(spi_dev, buf, 3);
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI write error\n");
 		return ret;
@@ -75,16 +68,6 @@ static int adt7316_spi_multi_write(void *client, u8 reg, u8 count, u8 *data)
 	return ret;
 }
 
-static int adt7316_spi_read(void *client, u8 reg, u8 *data)
-{
-	return adt7316_spi_multi_read(client, reg, 1, data);
-}
-
-static int adt7316_spi_write(void *client, u8 reg, u8 val)
-{
-	return adt7316_spi_multi_write(client, reg, 1, &val);
-}
-
 /*
  * device probe and remove
  */
@@ -95,8 +78,6 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 		.client = spi_dev,
 		.read = adt7316_spi_read,
 		.write = adt7316_spi_write,
-		.multi_read = adt7316_spi_multi_read,
-		.multi_write = adt7316_spi_multi_write,
 	};
 
 	/* don't exceed max specified SPI CLK frequency */
diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
index 03d5300a98cd..e9f288420234 100644
--- a/drivers/staging/iio/addac/adt7316.h
+++ b/drivers/staging/iio/addac/adt7316.h
@@ -18,8 +18,6 @@ struct adt7316_bus {
 	void *client;
 	int (*read)(void *client, u8 reg, u8 *data);
 	int (*write)(void *client, u8 reg, u8 val);
-	int (*multi_read)(void *client, u8 first_reg, u8 count, u8 *data);
-	int (*multi_write)(void *client, u8 first_reg, u8 count, u8 *data);
 };
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.17.1

