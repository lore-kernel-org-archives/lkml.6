Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B3CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C998720825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xkYPOaJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C998720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeKIC3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:29:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38008 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeKIC3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:29:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id d10-v6so22007074wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPCJyVZmDOYNeLsc4tgwn2k4YrO+TQOoxPdkXRVHMuI=;
        b=xkYPOaJ4V8RNsgpz0tDtm4p+U0NWEW9+nWXirBy1Bhu2gPeDveN+LbP2NDngyt+ond
         m0nOnZDw/dfv6N+Xd8YKWgxvFphMBQmAcfXFDx+3amii5D82a9z9lbyXaNok4cUQMxQY
         wCMisU7MGSTAXECi05MKUUPzvUACJ0Htqd7JT0FndBKmFrZgiz0+OI69cARp5OLHs0+3
         BOTmJdJPWe+3jzv8W1+iko6JZyArfJ6GqPngsV1KJSaMTHif3kJRn/k7+goDReqYD2e5
         G17IjOcybrcN/TQrrgEbQYQyyA0C9ihMj89Paqb6yeWC2AvKGKO8z1c8b4WMMzU4lrkc
         YFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPCJyVZmDOYNeLsc4tgwn2k4YrO+TQOoxPdkXRVHMuI=;
        b=PZeKudxQYuGr2qssvVMhUXQ/pem8eXDTglIgNIZiQ5tjVidMn4UoSNu1Fn8B9nExox
         iArDwd4JUs9jEgL+pzGzkADExIsoUXN+bvklfiss5Qftx6FTLM7RwL8d1ym0f0ax/msr
         cGEr6HQwpSskdVsBCDQJM3AG0cg2Nn1kxko+5YtCzl3sOuO2LLzAlh3/XFXx5LNH3WOw
         Zcz6lAUMOxT/fN+J3vtysTte6/KnGWc7/zhbE0gTJC/ae8KTZtPxQ49MCiMzD4aRWmIm
         JTVB+M6YAj70CiAbQvEcbuKq3i5VuGGOh4R62NXrFswizP03YjSV7kyBbZlsds61+lAQ
         EouA==
X-Gm-Message-State: AGRZ1gJ3vG7/YmPR/aSLRG1v8TbgCVXllIJDNI0A770p5exE++AVuLpe
        JY/YQl1VLfntH2v/DFcZGRi73w==
X-Google-Smtp-Source: AJdET5cBtnZnbUITLW6R327dO/QhDlm05sTKDZlugw4OeXA+SnFseJ5bepo1tRkUHk8R5Z4IajcnsA==
X-Received: by 2002:adf:b716:: with SMTP id l22-v6mr5224333wre.157.1541695990620;
        Thu, 08 Nov 2018 08:53:10 -0800 (PST)
Received: from debian-brgl.lan ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h5-v6sm7815987wrs.51.2018.11.08.08.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 08:53:10 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 2/3] gpio: mockup: add locking
Date:   Thu,  8 Nov 2018 17:52:54 +0100
Message-Id: <20181108165255.9940-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108165255.9940-1-brgl@bgdev.pl>
References: <20181108165255.9940-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While no user reported any race condition problems with gpio-mockup,
let's be on the safe side and use a mutex when performing any changes
on the dummy chip structures.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpio-mockup.c | 50 ++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 6a50f9f59c90..3cd92912c414 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -54,6 +54,7 @@ struct gpio_mockup_chip {
 	struct gpio_mockup_line_status *lines;
 	struct irq_sim irqsim;
 	struct dentry *dbg_dir;
+	struct mutex lock;
 };
 
 struct gpio_mockup_dbgfs_private {
@@ -82,29 +83,53 @@ static int gpio_mockup_range_ngpio(unsigned int index)
 	return gpio_mockup_ranges[index * 2 + 1];
 }
 
-static int gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
+static int __gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
 	return chip->lines[offset].value;
 }
 
-static void gpio_mockup_set(struct gpio_chip *gc,
-			    unsigned int offset, int value)
+static int gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
+	int val;
+
+	mutex_lock(&chip->lock);
+	val = __gpio_mockup_get(gc, offset);
+	mutex_unlock(&chip->lock);
+
+	return val;
+}
+
+static void __gpio_mockup_set(struct gpio_chip *gc,
+			      unsigned int offset, int value)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
 	chip->lines[offset].value = !!value;
 }
 
+static void gpio_mockup_set(struct gpio_chip *gc,
+			   unsigned int offset, int value)
+{
+	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
+
+	mutex_lock(&chip->lock);
+	__gpio_mockup_set(gc, offset, value);
+	mutex_unlock(&chip->lock);
+}
+
 static void gpio_mockup_set_multiple(struct gpio_chip *gc,
 				     unsigned long *mask, unsigned long *bits)
 {
+	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 	unsigned int bit;
 
+	mutex_lock(&chip->lock);
 	for_each_set_bit(bit, mask, gc->ngpio)
-		gpio_mockup_set(gc, bit, test_bit(bit, bits));
-
+		__gpio_mockup_set(gc, bit, test_bit(bit, bits));
+	mutex_unlock(&chip->lock);
 }
 
 static int gpio_mockup_dirout(struct gpio_chip *gc,
@@ -112,8 +137,10 @@ static int gpio_mockup_dirout(struct gpio_chip *gc,
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
-	gpio_mockup_set(gc, offset, value);
+	mutex_lock(&chip->lock);
+	__gpio_mockup_set(gc, offset, value);
 	chip->lines[offset].dir = GPIO_MOCKUP_DIR_OUT;
+	mutex_unlock(&chip->lock);
 
 	return 0;
 }
@@ -122,7 +149,9 @@ static int gpio_mockup_dirin(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
+	mutex_lock(&chip->lock);
 	chip->lines[offset].dir = GPIO_MOCKUP_DIR_IN;
+	mutex_unlock(&chip->lock);
 
 	return 0;
 }
@@ -130,8 +159,13 @@ static int gpio_mockup_dirin(struct gpio_chip *gc, unsigned int offset)
 static int gpio_mockup_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
+	int direction;
 
-	return !chip->lines[offset].dir;
+	mutex_lock(&chip->lock);
+	direction = !chip->lines[offset].dir;
+	mutex_unlock(&chip->lock);
+
+	return direction;
 }
 
 static int gpio_mockup_to_irq(struct gpio_chip *gc, unsigned int offset)
@@ -283,6 +317,8 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
+	mutex_init(&chip->lock);
+
 	gc = &chip->gc;
 	gc->base = base;
 	gc->ngpio = ngpio;
-- 
2.19.1

