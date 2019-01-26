Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A3FC282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AC4218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2o0PuQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfAZRe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:34:26 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36898 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfAZReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 12:34:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so5452919pgb.4;
        Sat, 26 Jan 2019 09:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=DvhpTLrMCf893Ij1Zp0y9TsSt6l1cbqmyDDL66kD/ww=;
        b=R2o0PuQHXwKBaYt9o4/9ZjcFPGpid6eIg6H/W/+kuGUGdQhTFqIXtUcl1L7rK37Tcj
         EBZlqWPPGmG31xjM1WwY4GjQKW1+e6LVecuaWBW1p1VpwcR5ySDYKqoOyvsGRVWW5FPs
         1v/ECV50cp9bNmPEzNhOQjE1L7QPwssVoRZrEvNhmv6gs6wLr5GUuJFLTVzmKY9gRZl4
         9iQJPvQ7zppwZF3tpSGOxYFB7+LgOTQIzNoReHWPPRrglENxqVG4xkG6iZlygGSzMINW
         yzZL/Ap6pQJhvStwgx+tb4F8z3BdIp1Pb1DDNCodYouIGK8qex+VQj7e3AP68TeV3FJR
         zeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=DvhpTLrMCf893Ij1Zp0y9TsSt6l1cbqmyDDL66kD/ww=;
        b=l7DdJ8GlkgQpju50t0FECh+YZIXfbNLbnR/i6FunMmJLktizTgWYMCpldYePSWO/SG
         rVYzvafMwDCo/f5VzXJ/o80dxdIHmh3B6zDZJ6qIdtgzuvWtG1gN/w+lZpk1thKS7Eh7
         O1kNehOMrgaAbaU5RyQ3LLoI6OHTX4YjB/Zl1pjGxDDu27XhiBLBXWtJDoHHqv6fnsM3
         WQikwH7rR4g3SaB+RS3v/G+B4rewGRIVBnC38aSQ8OSLBV+XLu4agI4O3ksDgD5BgAcn
         OMFLyQYpNMajxR3RXjpWAK/icxJDiCrfd/wVUEltu+3KXHoh6rhyaMkKB+M1TQOGNW41
         3zTw==
X-Gm-Message-State: AJcUukdXcSTlyaurqw0d6trLBbRGQU3TXDMyhPj76BtXzq/9rmya16Xk
        XVN0ry7SHRuOi1dsL9FKT50=
X-Google-Smtp-Source: ALg8bN6hi9MLw2VQ87jG63y5qJPdRnCvGw/ROsLLppNanowgD1smlGn7CSKvOD7Cs2VbIT8ueUBLgA==
X-Received: by 2002:a63:5f89:: with SMTP id t131mr14285355pgb.26.1548524063066;
        Sat, 26 Jan 2019 09:34:23 -0800 (PST)
Received: from localhost.localdomain ([49.32.227.18])
        by smtp.gmail.com with ESMTPSA id a65sm28745690pge.65.2019.01.26.09.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 09:34:22 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, jeremyfertic@gmail.com,
        shreeya.patel23498@gmail.com
Subject: [PATCH v4 2/3] Staging: iio: adt7316: Remove multi read and write functions
Date:   Sat, 26 Jan 2019 23:04:01 +0530
Message-Id: <20190126173402.12428-3-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126173402.12428-1-shreeya.patel23498@gmail.com>
References: <20190126173402.12428-1-shreeya.patel23498@gmail.com>
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
index 9dfe3be21849..167eafe3dd8c 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -52,44 +52,6 @@ static int adt7316_i2c_write(void *client, u8 reg, u8 data)
 	return ret;
 }
 
-static int adt7316_i2c_multi_read(void *client, u8 reg, u8 count, u8 *data)
-{
-	struct i2c_client *cl = client;
-	int i, ret;
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
-	int i, ret;
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
@@ -101,8 +63,6 @@ static int adt7316_i2c_probe(struct i2c_client *client,
 		.client = client,
 		.read = adt7316_i2c_read,
 		.write = adt7316_i2c_write,
-		.multi_read = adt7316_i2c_multi_read,
-		.multi_write = adt7316_i2c_multi_write,
 	};
 
 	return adt7316_probe(&client->dev, &bus, id->name, client->irq);
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index ec4848acec9f..06c943c2cc01 100644
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
 	int ret;
 
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
-	int i, ret;
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

