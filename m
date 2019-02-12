Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067DEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC51214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="x780J2pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfBLNRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:17:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39983 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbfBLNQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:16:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so2968959wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KudoSL2eX7oA8yYhs/QJyb1yYcVSQLsZjpboPNVdhXI=;
        b=x780J2pgnSH3MCPhRODpXksDoTsMpVGDc9hCflmyDdsyhRO6lW8ITYpZ5SLLpzGPQr
         Aps3W4QQeNS/tXG0q1QrpaO4oAo5Y86vNLvOy/vvGuXadEiwB4ZHmL5PKEMTyDwfyIO5
         Cjq7hv5NuL92qbOKQAuTk5aQLjStNJZttsRA6WXuibiTpaqSuOssF8gdPEM0boLtlyjI
         Ngd5GaB4noXvDI9X4cwI/ad0/WDr8daESeicXySkIPc8xAZWUHnDXggcDidmTXlXRvu9
         Z11IGQE6IGNUtP4ot7FXEwe0RT3lrvxeWC47ka6DgUIgoJ37uYcEyi10EOGBJ9LhVD9/
         dkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KudoSL2eX7oA8yYhs/QJyb1yYcVSQLsZjpboPNVdhXI=;
        b=YQ7dvi85oP6jYqma3gkDv/aCGSI6jgAuK9sUA5dd/GCNTCgFNga2iRlx57dYaowYj0
         F71ecib70eG/Iyp3r6E9MzDq5vUQdm2RTwwj4j2gz5W60s6+z4aEjaQLl67fquXRSB0d
         TmSPfGKWXUtqdtFN7t1N5xnsy0Y0UP+VyLGO/7gI6/CLrAgk2VFQfEidwFwpgbmDCwV9
         U5f+Z3NUkYRr7Wacs5E6pCavnq3bZ/xPr8YFoRqUB82s04RzSaKcY37Xxhos+N8pE1Mm
         ARvOyYn1Sux5n+VCOePixley+s8TziILtRc5qrtcDJb1r/UC6UbjVybU38ADDhzXFcQv
         tlxw==
X-Gm-Message-State: AHQUAuZIrHuteGrXtQE0es9d7XeIW1mIp+bfMMQ+fVJbx2XQZNfwpN+r
        rVARVYe78bEAuxFMB1tha+5ZKw==
X-Google-Smtp-Source: AHgI3IY75La6dsQ/EdfJEDRk+ekOrHl7rzJRhQE8dDX7mfnqTjmedMFCl/DlP4Djc/RSyukfmxzqZw==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr2969541wme.73.1549977387350;
        Tue, 12 Feb 2019 05:16:27 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id p6sm5478517wre.63.2019.02.12.05.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 05:16:26 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 2/7] gpio: mockup: add locking
Date:   Tue, 12 Feb 2019 14:15:55 +0100
Message-Id: <20190212131600.18960-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212131600.18960-1-brgl@bgdev.pl>
References: <20190212131600.18960-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

While no user reported any race condition problems with gpio-mockup,
let's be on the safe side and use a mutex when performing any changes
on the dummy chip structures.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 50 ++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 6a50f9f59c90..b4c1de6acf74 100644
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
 	chip->lines[offset].dir = GPIO_MOCKUP_DIR_OUT;
+	__gpio_mockup_set(gc, offset, value);
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
2.20.1

