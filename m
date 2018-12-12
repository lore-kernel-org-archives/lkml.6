Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9987C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6AD2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4npIULt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6AD2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeLLQsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:48:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37829 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbeLLQsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:48:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so9137924pfb.4;
        Wed, 12 Dec 2018 08:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VQ76MmWEDHFd/lV2BrEIdRPF1rRqm0REaoxdp+MMFxQ=;
        b=Y4npIULtH9OjYsb1UxqeCZ8/mH2XfBxKFpHYnEEi6LbaGhZqPQa0w27PnMwcVborA2
         z4qYv50Si7dDgaKnRi9JVgguf9G5FVfPvltTT4ZkjUq5th0hqv9xHlcff7fUY8dpt+sX
         1VK33+HBxClLM55hrg6xTCLhfBgdO87iIeQEKYliIvCbo06mLr5Gk4P5K3GD+DWUw/1R
         qIiEwNT/q23/aVRa4oM9gLyx1ySOZ/w/13xChCyt2hh6Kjn4BM/jhwg0BAIaRg0isC0i
         rhZZoAlRvjUz0p/Ixh8+V+j3Tl9Wdl5ljlnfoEFYoxjxEdPkXhUkgD7niP8j6BCocuiH
         +GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VQ76MmWEDHFd/lV2BrEIdRPF1rRqm0REaoxdp+MMFxQ=;
        b=QJr8ocIrv/QMD1mNgLrvMVV7/IzCh9v1cIgpqrGHDjSccowpiUxDxG0V6s6LdVKSf7
         y6fzAsPH03r/hXmOBFzn2JxrMfUKLWAGGxb3+h7F2kkZzBJYFWRh9QQNSxMZtVSCUNdE
         uDEWp83HT0gTBK6F2DzlMWEzG4vCV6Z3S+E0t3ohlBIQn6irk305FbEmkx34MYzL0VIv
         d//ZFFhboGyHwWAMIkZ9/d/TJQ/0QiZRu2sh5Kt4rZywC6QfC6hJw8lI71I29t34Pcwu
         zvwPsHyCypGIIAZG//VJqiAbbMC5Iz6ChIeLH5Uicm3euPqvxOBFQpPN4T40h8Kmju76
         irMA==
X-Gm-Message-State: AA+aEWYd9KSYAouhVgk9/rVpPqsXcs2KlhvFP4JKstpUTSoGLTI0DC9s
        yB225K44qBXXsW5WwxCF2Zk=
X-Google-Smtp-Source: AFSGD/Wx3eZE9/KZyUYq2m5eUJF8mXSy/pTAdxeW7gLK1vWjItRHBGge0mH+QQmxFLQH2+FvWpeZIg==
X-Received: by 2002:a62:4b4d:: with SMTP id y74mr20658935pfa.186.1544633281239;
        Wed, 12 Dec 2018 08:48:01 -0800 (PST)
Received: from localhost.localdomain ([27.59.69.235])
        by smtp.googlemail.com with ESMTPSA id v191sm44489471pgb.77.2018.12.12.08.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 08:48:00 -0800 (PST)
From:   Hardik Singh Rathore <hardiksingh.k@gmail.com>
To:     jic23@kernel.org
Cc:     Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: adt7316: drop unnecessary initialization of variables
Date:   Wed, 12 Dec 2018 22:17:46 +0530
Message-Id: <20181212164747.6402-1-hardiksingh.k@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialization is unnecessary when the variable is written before it is
read. There were some occasions in which the driver would initialize `ret'
during declaration without need.

Purely a cosmetic change with no functional impact.

Signed-off-by: Hardik Singh Rathore <hardiksingh.k@gmail.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c | 6 +++---
 drivers/staging/iio/addac/adt7316-spi.c | 4 ++--
 drivers/staging/iio/addac/adt7316.c     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 473e5e34ec00..48736c0ab0ef 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -47,7 +47,7 @@ static int adt7316_i2c_read(void *client, u8 reg, u8 *data)
 static int adt7316_i2c_write(void *client, u8 reg, u8 data)
 {
 	struct i2c_client *cl = client;
-	int ret = 0;
+	int ret;
 
 	ret = i2c_smbus_write_byte_data(cl, reg, data);
 	if (ret < 0)
@@ -59,7 +59,7 @@ static int adt7316_i2c_write(void *client, u8 reg, u8 data)
 static int adt7316_i2c_multi_read(void *client, u8 reg, u8 count, u8 *data)
 {
 	struct i2c_client *cl = client;
-	int i, ret = 0;
+	int i, ret;
 
 	if (count > ADT7316_REG_MAX_ADDR)
 		count = ADT7316_REG_MAX_ADDR;
@@ -78,7 +78,7 @@ static int adt7316_i2c_multi_read(void *client, u8 reg, u8 count, u8 *data)
 static int adt7316_i2c_multi_write(void *client, u8 reg, u8 count, u8 *data)
 {
 	struct i2c_client *cl = client;
-	int i, ret = 0;
+	int i, ret;
 
 	if (count > ADT7316_REG_MAX_ADDR)
 		count = ADT7316_REG_MAX_ADDR;
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 5cd22743e140..f524b4ccf5c7 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -27,7 +27,7 @@ static int adt7316_spi_multi_read(void *client, u8 reg, u8 count, u8 *data)
 {
 	struct spi_device *spi_dev = client;
 	u8 cmd[2];
-	int ret = 0;
+	int ret;
 
 	if (count > ADT7316_REG_MAX_ADDR)
 		count = ADT7316_REG_MAX_ADDR;
@@ -56,7 +56,7 @@ static int adt7316_spi_multi_write(void *client, u8 reg, u8 count, u8 *data)
 {
 	struct spi_device *spi_dev = client;
 	u8 buf[ADT7316_REG_MAX_ADDR + 2];
-	int i, ret = 0;
+	int i, ret;
 
 	if (count > ADT7316_REG_MAX_ADDR)
 		count = ADT7316_REG_MAX_ADDR;
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 2f8a122f475d..2d1e707a8676 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2104,7 +2104,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
 	unsigned short *adt7316_platform_data = dev->platform_data;
-	int ret = 0;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
 	if (!indio_dev)
-- 
2.17.1

