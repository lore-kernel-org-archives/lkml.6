Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DBCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60A9214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="K3wXAfhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390155AbfBRQmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:42:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43393 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389935AbfBRQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:41:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id d17so4677973wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 08:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2krnFxmiomVyVDb/8h+/xtPx5s60ffpJQDYiPXgWEoY=;
        b=K3wXAfhqB1lwapY8HaGiJDwTTC3QwVK7jr3Wbz04hL0cM11MrM/uRDTWe49BoHA0HR
         ysyu8ijd0/LwFP52MDz7iCIYemlvi4V36UWp5JsHAdJCk6w1dtn8iIg+BCy/KyxwOhTl
         8H5UdGX0EXJhU9lL16gTqeRy7NcgO0j9QMLzBrTPMMG4Sjjh9nNZIvAT0uttZbaWkH4X
         cDNB0ISSdpkrq+lRbHfHkRhDe08I62vM9aJ/ARL0Zqfua/OlEXNHGasVc7oO/5/RwCDU
         i2G27cC4IliCZ85REpG+JCj6/n6u8B48eOM4aQ+/xiWCJ8K+TJyq3KR8M4CsSMxKUMJa
         uNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2krnFxmiomVyVDb/8h+/xtPx5s60ffpJQDYiPXgWEoY=;
        b=dyXG96q41sAHKmfJnDwwvqly9BZrqH8ob/0Rb1U7EVf1Sm8WkskMK73ttG1qUfECR7
         pqrukbNidP4haxiRp5wYA3fY26i+IRoOomCPdVwY4M1xZ4QA0zjBmoaAjE41huVd7sDV
         x9UzpueYRttsiszkmcrz8lE9UBA3h+8+RRnp1NOftx8wln6rZwnkd02Ro9m7HbstS7+Z
         TMheIpcmM7Gx0nFzFclSGzIig5RSUOri/BJl7OyuGS/ukr5pUMsLxxLUtPrCBnYqZXzv
         US75TeKl6b1U4esPCkDyK36rBVVI4EZuKhiNALa45l3goJvVVqDATX+S/akTXfSMppzz
         QHdQ==
X-Gm-Message-State: AHQUAuaZ+ezLAoNpp22b88mGYTUQbQZD74Q31/e9X8DsjxFR03mYJ9H2
        rEczlUoMj/Fc6lFT5490rsOnlA==
X-Google-Smtp-Source: AHgI3IbJ91hYL7OytLIHBiYgCJSOImj8P6vAS6X3ru3tNnf+hDQBRC8SOY8EfF8bWTyKmPopJIswlw==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr17455932wrq.189.1550508108086;
        Mon, 18 Feb 2019 08:41:48 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id w10sm6325442wru.5.2019.02.18.08.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 08:41:47 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 5/7] gpio: mockup: change the type of 'offset' to unsigned int
Date:   Mon, 18 Feb 2019 17:41:36 +0100
Message-Id: <20190218164138.24921-6-brgl@bgdev.pl>
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

This field can never be negative.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 0317917a3678..433adb3b4617 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -60,7 +60,7 @@ struct gpio_mockup_chip {
 struct gpio_mockup_dbgfs_private {
 	struct gpio_mockup_chip *chip;
 	struct gpio_desc *desc;
-	int offset;
+	unsigned int offset;
 };
 
 static int gpio_mockup_ranges[GPIO_MOCKUP_MAX_RANGES];
-- 
2.20.1

