Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EB5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A3C2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JZ3Cdpf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfBSQHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:07:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39256 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfBSQHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:07:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so21502344wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2P/9cB+jmoaw2Dnwldpp3xOYGEGj2ZimLHwmer8wLno=;
        b=JZ3Cdpf01v3f95tWFcyIm1PFjLLpFXqUbezFbWiNdrZav1XK9jmJd9vtle/LuBaTi6
         +d5i3FCo3NhCPQdvxBANYKYjgRPvMwRJHeg5Yo18I6+cyoMWWD/KT5s+ibSjko0MCiho
         ffazSsnPstdgmv8H5a4ZTCVGkAaiTb1NBVaAdTypIJREED0IKBGQiEjPcOFe7KDbzdJ/
         cnucl64didN0AWXGSYY6WVENAUlpEVMtGoXmMK4u0cuKma2vpEcTFQkk7+WsexMzMghD
         389MKMl7yQGDsZfjOnDI5nVaWaggrzg0SLfmAUdmYbs2CcMy4ucEewOhsw0RMCnjcKTq
         Sotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2P/9cB+jmoaw2Dnwldpp3xOYGEGj2ZimLHwmer8wLno=;
        b=Q/0IBWI66YMGR0y/qeBQwYGEWhjVtbruZ0vuc+2eDrZZeUKVZpAxQ8MnLflAwCXkcm
         JiJvh/4o2H3ibvOthSaSfS4mKZg+IqxtCZD5rLiZ1VBDqhS+rVIITm+/FZfyR/UdUijH
         2/pe/5tuFjOUpjqOvPy+YEJmwq0hglu92Tr+s+Ln03ziG3HAFh5aDFvzmgeO1hhDgtT6
         5b//vJSVCpl6MFmES7SezdMZLK4CiJrEx9Vllhs1O1rMpO0Pq2oeov78MYVXK3ool0hk
         w8WPaLH9OQYOI/H6ADvM6MR4871a3yhqHna+MIpKbrx88KYLsHVBQa4lQFOexyktDFIG
         DJOw==
X-Gm-Message-State: AHQUAuaJDb5b779QC1/MfSwpRejUAzkm28Xig14BPiHdnV0bTonu9e3Q
        cgnKmP4aI6h6Z7OXREtt3RDSCg==
X-Google-Smtp-Source: AHgI3IbHTkJfATmA1ixBS46x3h49PMwOuh2XTCmY4OQl1AwKcLpRC3yJnrF0EI4oSBcvR3oH3cEWTA==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr6977634wrq.305.1550592423407;
        Tue, 19 Feb 2019 08:07:03 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h17sm12161381wrq.17.2019.02.19.08.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 08:07:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 6/7] gpio: mockup: change the signature of unlocked get/set helpers
Date:   Tue, 19 Feb 2019 17:06:49 +0100
Message-Id: <20190219160650.9614-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219160650.9614-1-brgl@bgdev.pl>
References: <20190219160650.9614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The unlocked variants only get called from places where we already have
the pointer to the underlying gpio_mockup_chip structure, so take it
as parameter instead of struct gpio_chip.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 433adb3b4617..c498b0fbbec8 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -83,10 +83,9 @@ static int gpio_mockup_range_ngpio(unsigned int index)
 	return gpio_mockup_ranges[index * 2 + 1];
 }
 
-static int __gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
+static int __gpio_mockup_get(struct gpio_mockup_chip *chip,
+			     unsigned int offset)
 {
-	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
-
 	return chip->lines[offset].value;
 }
 
@@ -96,7 +95,7 @@ static int gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
 	int val;
 
 	mutex_lock(&chip->lock);
-	val = __gpio_mockup_get(gc, offset);
+	val = __gpio_mockup_get(chip, offset);
 	mutex_unlock(&chip->lock);
 
 	return val;
@@ -110,7 +109,7 @@ static int gpio_mockup_get_multiple(struct gpio_chip *gc,
 
 	mutex_lock(&chip->lock);
 	for_each_set_bit(bit, mask, gc->ngpio) {
-		val = __gpio_mockup_get(gc, bit);
+		val = __gpio_mockup_get(chip, bit);
 		__assign_bit(bit, bits, val);
 	}
 	mutex_unlock(&chip->lock);
@@ -118,11 +117,9 @@ static int gpio_mockup_get_multiple(struct gpio_chip *gc,
 	return 0;
 }
 
-static void __gpio_mockup_set(struct gpio_chip *gc,
+static void __gpio_mockup_set(struct gpio_mockup_chip *chip,
 			      unsigned int offset, int value)
 {
-	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
-
 	chip->lines[offset].value = !!value;
 }
 
@@ -132,7 +129,7 @@ static void gpio_mockup_set(struct gpio_chip *gc,
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
 	mutex_lock(&chip->lock);
-	__gpio_mockup_set(gc, offset, value);
+	__gpio_mockup_set(chip, offset, value);
 	mutex_unlock(&chip->lock);
 }
 
@@ -144,7 +141,7 @@ static void gpio_mockup_set_multiple(struct gpio_chip *gc,
 
 	mutex_lock(&chip->lock);
 	for_each_set_bit(bit, mask, gc->ngpio)
-		__gpio_mockup_set(gc, bit, test_bit(bit, bits));
+		__gpio_mockup_set(chip, bit, test_bit(bit, bits));
 	mutex_unlock(&chip->lock);
 }
 
@@ -155,7 +152,7 @@ static int gpio_mockup_dirout(struct gpio_chip *gc,
 
 	mutex_lock(&chip->lock);
 	chip->lines[offset].dir = GPIO_MOCKUP_DIR_OUT;
-	__gpio_mockup_set(gc, offset, value);
+	__gpio_mockup_set(chip, offset, value);
 	mutex_unlock(&chip->lock);
 
 	return 0;
-- 
2.20.1

