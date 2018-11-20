Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88649C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3AC20684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY0gtWxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3AC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbeKUDYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:24:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46560 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeKUDYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:24:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so1252505ply.13;
        Tue, 20 Nov 2018 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=zNs2xBlZTXJMas/ITpZ31ZhslFUYpV/Egqz6U1dNoRs=;
        b=hY0gtWxXaEwzMwiiCjFUNAtFtcH3i4uRqQtVOss1FKN1xV8ejI6VnanSfU+FF2+KCf
         lu2IBdkf150c5qiknE3W9Z6u6/UP8TyoDqkG9Wtn7cLLEQmyOr8krOU272DOgXXf+vj7
         w4kUca6u8cDPYHa+wMpXV9md2LSSFEBMQJwFNRw0/5JEZVDijbdJc1LTw/Tkfv4yFqRw
         3zVfdVe4Xxgg+lhvPFnZv1dL9kdoBj/w4et8DNLtXgVHrdX+OeITT9HJKDgCewtuUGDg
         ECdtpIxaRuL+cmvExXfGKv6B/WlUBQnXMyYraFm1FMLUhXJeRUrRP2y6mLLXHQvxio82
         nPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=zNs2xBlZTXJMas/ITpZ31ZhslFUYpV/Egqz6U1dNoRs=;
        b=Uz1ZuZpivgfjO/famuTwFmjDkW6w5CYeSSMXBPDl9vlqsVIi7DxFTb34TWklHjYLOr
         8G1sybpj8gi9Gg7mxtKCY0msLi86j1HA5CBavRU9G1KDVl8NTYD1H21pkfhkTF5QK672
         gC7uC3rYSf/EPpNBeFAPlOUJNHwp7IIpKVT43c5cXQcVwUT1aItA03LFyyCggYPfbBwH
         FtZTFfzn6mmfSNnD2dtCgwE0ZloHx5IKx4TwAdHn/2jBrrT+fwi9I+CTzQNfF4MmTXAd
         4jUoKOb+knbZ+r60bHmLuN9IXH7DUlpkNGSvCBxulg2TbRMIGANqeF6xdbcpfGjjTcxe
         cJaA==
X-Gm-Message-State: AA+aEWZftTewxCWY2ieFwIXcPRFIJUJKWBEK1IvyNIqGGkQWVB4uE2iH
        8Vw4a7ZFsR0d9/9JRSWouOk=
X-Google-Smtp-Source: AFSGD/W4AAtdGN8A2VP/oaRM/XVGSFgp9BFBRuCFTM3T2cQO6TeBwjiOAl5FMmzz/bT39vKCbhCJ2A==
X-Received: by 2002:a17:902:20e9:: with SMTP id v38mr1600686plg.250.1542732884190;
        Tue, 20 Nov 2018 08:54:44 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.152])
        by smtp.gmail.com with ESMTPSA id r83sm64235709pfc.115.2018.11.20.08.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:54:43 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] Staging: iio: adt7316: Use device tree data to set ldac_pin
Date:   Tue, 20 Nov 2018 22:24:36 +0530
Message-Id: <20181120165436.7178-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the driver use device tree instead of the platform data.
Hence, use devm_gpiod_get_optional function to get the data from
device tree for ldac-pin and accordingly make the needed changes
in the driver.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 3f22d1088713..deb2f7b40f60 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -177,7 +177,7 @@
 
 struct adt7316_chip_info {
 	struct adt7316_bus	bus;
-	u16			ldac_pin;
+	struct gpio_desc	*ldac_pin;
 	u16			int_mask;	/* 0x2f */
 	u8			config1;
 	u8			config2;
@@ -950,8 +950,8 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
 		if (ret)
 			return -EIO;
 	} else {
-		gpio_set_value(chip->ldac_pin, 0);
-		gpio_set_value(chip->ldac_pin, 1);
+		gpiod_set_value(chip->ldac_pin, 0);
+		gpiod_set_value(chip->ldac_pin, 1);
 	}
 
 	return len;
@@ -2120,7 +2120,13 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	else
 		return -ENODEV;
 
-	chip->ldac_pin = adt7316_platform_data[1];
+	chip->ldac_pin = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_LOW);
+	if (IS_ERR(chip->ldac_pin)) {
+		ret = PTR_ERR(chip->ldac_pin);
+		dev_err(dev, "Failed to request ldac GPIO: %d\n", ret);
+		return ret;
+	}
+
 	if (chip->ldac_pin) {
 		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDCA;
 		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
-- 
2.17.1

