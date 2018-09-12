Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9605FC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA01206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OFrcFoR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA01206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeILNIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:08:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38828 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeILNIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:08:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so1270924wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tSFZT3LAOIYqPhjgbXCd3WYyA+0oJtKYwUPe0/uc6vQ=;
        b=OFrcFoR4v2gJAfx/09eF3oU6Vay/jbM/eKXwkiFQFerpCV6Ycr2rvxR/NcwEPzsZLt
         rMGQMwpaL7T8J3Gc/gG5XyYYMABsbg+53Ho4f2hVMRioPR5ue30Z+fa7/x7xyhoUNTdC
         cZEJQ4YQYysgoi9xrA+9E2zCMNzbV1FOy9AU3cyVG+uRGoAujWIx+ucFo9dCvhvTvpZD
         dCloXMTtjuqHLkI1wujQQ+GZ5auGvcvjTxbZ7D7Pa/sZ55WnWYyuSdJX+zUiIS7Bq9qL
         Cc8tLTAUf8ZsJaROaZlNA6rOa31Htp0FhbNAuItzkxewC2KJTJ2lzfg7SeGB8RGV8imh
         KneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tSFZT3LAOIYqPhjgbXCd3WYyA+0oJtKYwUPe0/uc6vQ=;
        b=CfHeOB+V2eiCKKp0wpj67zRIw79sGKFGhnIuFsyjAmZ0NDQFFDaRU3Ac142HXDf53m
         g5HWLuht6+Kc5fjN/nSha6EvlN8mAmlJiZ3x/XSm8lHvxJJQhYQ6OZhomtsaI13h7dWo
         LNW93gWH9dWTLeyKqLF1QGJyaG8Xbg5JhWtWujxsUBrLyGysOsM0/7tc2CL8g37Tci3R
         p8afamAH7NxHa2mO2DbfCK1u7ELdS0bQqHM0brf/Lbpx5yvZhSBzd0egKlI9GtPkqTtl
         gwg+IuvJGCLfj4wZfQt0UPxlnUuFzL8EBu713jMKQ4t24i+6MVWUKicdqRtn7wBwYNUt
         wV0Q==
X-Gm-Message-State: APzg51Dam61J/y2Glw86INwUS9A2Vp/9K6L6UtcprOEyNMcKUYYXi03l
        zMmAQh/E2mGbt2jQraWFElK+QQ==
X-Google-Smtp-Source: ANB0VdaobGHeiCtXJiEsDH339J8Hlne2ybYkkjtL5teWuXfGth2JNREAmvf+IKee4fnqzcyrP3aZbg==
X-Received: by 2002:a1c:1a48:: with SMTP id a69-v6mr746660wma.43.1536739508244;
        Wed, 12 Sep 2018 01:05:08 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id 139-v6sm1225182wmp.4.2018.09.12.01.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 01:05:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Devang Panchal <devang.panchal@softnautics.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/2] eeprom: eeprom_93xx46: use resource management
Date:   Wed, 12 Sep 2018 10:04:56 +0200
Message-Id: <20180912080457.12238-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912080457.12238-1-brgl@bgdev.pl>
References: <20180912080457.12238-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use resource managed variants of nvmem_register() and kzalloc().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 38766968bfa2..c6dd9ad9bf7b 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -439,7 +439,7 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
+	edev = devm_kzalloc(&spi->dev, sizeof(*edev), GFP_KERNEL);
 	if (!edev)
 		return -ENOMEM;
 
@@ -449,8 +449,7 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 		edev->addrlen = 6;
 	else {
 		dev_err(&spi->dev, "unspecified address type\n");
-		err = -EINVAL;
-		goto fail;
+		return -EINVAL;
 	}
 
 	mutex_init(&edev->lock);
@@ -473,11 +472,9 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 	edev->nvmem_config.word_size = 1;
 	edev->nvmem_config.size = edev->size;
 
-	edev->nvmem = nvmem_register(&edev->nvmem_config);
-	if (IS_ERR(edev->nvmem)) {
-		err = PTR_ERR(edev->nvmem);
-		goto fail;
-	}
+	edev->nvmem = devm_nvmem_register(&spi->dev, &edev->nvmem_config);
+	if (IS_ERR(edev->nvmem))
+		return PTR_ERR(edev->nvmem);
 
 	dev_info(&spi->dev, "%d-bit eeprom %s\n",
 		(pd->flags & EE_ADDR8) ? 8 : 16,
@@ -490,21 +487,15 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, edev);
 	return 0;
-fail:
-	kfree(edev);
-	return err;
 }
 
 static int eeprom_93xx46_remove(struct spi_device *spi)
 {
 	struct eeprom_93xx46_dev *edev = spi_get_drvdata(spi);
 
-	nvmem_unregister(edev->nvmem);
-
 	if (!(edev->pdata->flags & EE_READONLY))
 		device_remove_file(&spi->dev, &dev_attr_erase);
 
-	kfree(edev);
 	return 0;
 }
 
-- 
2.18.0

