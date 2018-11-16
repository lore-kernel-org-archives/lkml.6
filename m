Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DB52077B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiF+uM5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DB52077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbeKQJLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:11:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38674 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:11:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so1772638plb.5;
        Fri, 16 Nov 2018 14:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=zNs2xBlZTXJMas/ITpZ31ZhslFUYpV/Egqz6U1dNoRs=;
        b=AiF+uM5iSK+i5Ybez9CbgCfedUkPQxXfIHeWLPZPDZbNRg46tFoX5p11nW4xN9rm68
         fMisNWkqd6ZfFhbWuzEEKmoUo1t6BsTkWbJYL8QMhIq+Z4BO+YrMwOI3WspseyvIy2Nn
         MAPQ02oNvvdjD6pluaMsmsKv6b3pCtbyPFiREw7mHMiar4qUGJKx1b8eKNmvOd7rFxve
         4rc49Fj5lDjwy/yVkF+v5zEvYSseh30nvZ4A9vrzke7nhMi7WIbsPLgk3I4NBSBYwf/L
         lV39wGVbg+yPYvAmsH1B6s9A+h3vaPfdvLmYupVhaMU9NdnQDTF+P4R32WuaboULmIEs
         s01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=zNs2xBlZTXJMas/ITpZ31ZhslFUYpV/Egqz6U1dNoRs=;
        b=RzC+vR3La307UUOWJu8kCHhC8SG+OACYRRIuwE/RFZwkI1OcwUc+GVa/5AWVCHiy+v
         Abn8k5baUCBhnRF7YF1VDhKRU2+m27RVXYrDxrK8BgByxV3ud+0X1PNCp8kfzlh8PZCg
         ugPGUodBvz28T0erAAppx+lmz8zFs6sgsPSMS3ZzGubOXEnOQgdVaprRHEzPT7pBgqGQ
         0hVBGKg0XXoAMfIG3d/pbf9aLFBwkS0OwU4bAHHKVK5PG08bu7X4xcWPuIbDQq/EGUHg
         dappic9QadFAspxc9HG1ztsIWF5Th9jhchAxwANYKiy2JkR7/QsTbo9xmWTAudxvK4Bg
         yYGw==
X-Gm-Message-State: AA+aEWZRN48w2ZwHRGjc1eAzGilzuD06E6Mpb2T8YTda1J9lx1d7cjyx
        eP9Oy5ym7QFzJFXGCwMdsMU=
X-Google-Smtp-Source: AFSGD/UDjI9jweK8d1XWCdKp0ehNYdtxmWaSQH/YO1r8y2He1fUV2uUwdtkkwfSWwokmF+ocin6VQA==
X-Received: by 2002:a17:902:8ec9:: with SMTP id x9mr839145plo.27.1542409057583;
        Fri, 16 Nov 2018 14:57:37 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.154])
        by smtp.gmail.com with ESMTPSA id 137-v6sm35425004pfz.103.2018.11.16.14.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:57:37 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] Staging: iio: adt7316: Use device tree data to set ldac_pin
Date:   Sat, 17 Nov 2018 04:27:32 +0530
Message-Id: <20181116225732.24823-1-shreeya.patel23498@gmail.com>
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

