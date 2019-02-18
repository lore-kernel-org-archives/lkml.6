Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285CCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAA721736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yc+N+50x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390198AbfBRQmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:42:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36407 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389809AbfBRQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:41:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id o17so19120265wrw.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 08:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03DPhzkzBjEgdOWVhFdZb0AzmHi0UfZRp68bha7kwZI=;
        b=yc+N+50xTetVaxVV217OU4cyqtiTiA7Vgs2fxtpWImQFJCAq5P/EeDZIPg6Shs9RH9
         xGE7T/WyzDUVmHEpDIAc4597l0rZ71qJJ2alLiqfKJOKcpt34jTtVes59p0ofmFmoqyI
         70wCqFN5dHHr8FxIv1Vmq3AhIB6CUaZs943q5zZeVaPCTz1JU7jLDJm27cnJ4G3iMgp8
         hbMGvAHSlvrUZPRBGlMc6O2kigQC4WQQ4ZrKtRPBbcR1LoYJAQMPxtlotI+ppyI0+7+B
         ZgN0OEK2FTJ5V+YsPLFEMjP/lwuyTZgw10bzQjeOiBaUHRmXz74uG1tPCqfDGeIeyG7t
         VXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03DPhzkzBjEgdOWVhFdZb0AzmHi0UfZRp68bha7kwZI=;
        b=Afb0nk+yaK+eksVIkMZFnbq8jGJZNMhyO8mTWqQam5SESD5MmPZAqoQiuAcJfzPY6k
         ZXkRPay6mO+FpMoIlL4qEZ+YvsvI5id10VvcgUVSOaMsASFCjt993kUHyMTThGLvY4kg
         XlKdJ6MXgLkrqeOFv7ky2Yd09LW8oTUEjv0a5yGK4YAVCuy8JplNnhKrDe2XTYV7k1mU
         2PKBqR3BLokpe/jDSUVGQ93IdPLEK5UsVGmAtOxoqEhQJtDsNdNIWbrhyrs1MklQC38O
         6ZqzrO+fsu4580+8lFfaxfmQ0lFL0R4P2WMoxHA5QvKrjtsRf214EBXq32P5+IuK3U+5
         MpJQ==
X-Gm-Message-State: AHQUAuZM6MzYK44CAMd2luP1wRusuw+dWjLXwgDTS2xyuj2v8k1PLNC9
        b1VThDpYMWKKXHHLaLPtvu8GHg==
X-Google-Smtp-Source: AHgI3IZzK7Kd/28ioJqsnPTO4h0gog4pfI3LFHvuCLvF2N/aENE6/YL6sJQ1ecXSZyll7BRmvji8eQ==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr17176950wrp.29.1550508107028;
        Mon, 18 Feb 2019 08:41:47 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id w10sm6325442wru.5.2019.02.18.08.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 08:41:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 4/7] gpio: mockup: don't create the debugfs link named after the label
Date:   Mon, 18 Feb 2019 17:41:35 +0100
Message-Id: <20190218164138.24921-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218164138.24921-1-brgl@bgdev.pl>
References: <20190218164138.24921-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

User-space tests no longer use it and we're breaking the interface
anyway.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 1c945c967f60..0317917a3678 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -234,7 +234,7 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 				      struct gpio_mockup_chip *chip)
 {
 	struct gpio_mockup_dbgfs_private *priv;
-	struct dentry *evfile, *link;
+	struct dentry *evfile;
 	struct gpio_chip *gc;
 	const char *devname;
 	char *name;
@@ -247,10 +247,6 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 	if (IS_ERR_OR_NULL(chip->dbg_dir))
 		goto err;
 
-	link = debugfs_create_symlink(gc->label, gpio_mockup_dbg_dir, devname);
-	if (IS_ERR_OR_NULL(link))
-		goto err;
-
 	for (i = 0; i < gc->ngpio; i++) {
 		name = devm_kasprintf(dev, GFP_KERNEL, "%d", i);
 		if (!name)
-- 
2.20.1

