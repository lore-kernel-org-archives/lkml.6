Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57C4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A439021902
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jpYfl8ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfBSQHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:07:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42360 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbfBSQHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:07:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so9232667wrg.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2krnFxmiomVyVDb/8h+/xtPx5s60ffpJQDYiPXgWEoY=;
        b=jpYfl8ulWndgrJ/cRqORQPOf82zZX4AJtKgIiXmammQZTopnQDCby/OkvHIum36uPe
         oChw+vyw2hjvUoGtGtajuqhtkin2RdgfZFbcaPvb3knOzX6+YA0cpsbYMUx465C4qkhR
         U0uURrdIoP9I2syzaNq7rKYhe7K+12CJfqEve/JPl8sC9kqtcO0nTLdaevCtKvRkApTL
         5y3KFb7GwVliy3/naqCl/miOwh0XKJUphV2OVIbZWlzD47yKMdjRNebH1RGJNP79bL4j
         R7J6UZ/i2hfav102ih83D/4+MLRvANmmpS37SvjAKGZgt7ibvzEZDfN4Fgbdale2iwoc
         hiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2krnFxmiomVyVDb/8h+/xtPx5s60ffpJQDYiPXgWEoY=;
        b=pqu9vsWReVm2oFfHCGQtm1r0itZPOyxob6w3dVjqvNpzNqjJuL9qrQB0w8RxyEORze
         ojBK0MQMqlOz8YKOZiQwfsHobk7wdjDcIbRY8w2OJSk9dF54Dh5cGM0KtUa/0wDIoTRV
         u+Nejw4xf3F4wai+COHccRgzAaB0dmyYtGtgLMgDtOAfW/768uEZCCDW6RgFwESPas6v
         S+BrOKAcC/Jyuh4QHv/Uiww1cGt807VKG/3o8juebkY459OQWA+A1BfRFdeP8SKzXXfY
         iPX1ql1jm+ginRpvGyRfzRVEJheBEf60GD9Ma+GzGH4CP7I8lfrAtZoAuERzXTtOn1sq
         rRAA==
X-Gm-Message-State: AHQUAuZ7sw6FfB8d2kAIxiI57ox02iAR9IDY3D9iXIYBLds4c4LX2aHv
        IjVELNELPHZAawKgmvEIQ6Z001/NFHM=
X-Google-Smtp-Source: AHgI3IbHOvrVY47hMHGUmiBksXEmmtWN/2jO2eQ56Y/n5Pikmzc5XRU4AXR03Tr9sTncPJcydq7z1Q==
X-Received: by 2002:a5d:4702:: with SMTP id y2mr23155016wrq.149.1550592422186;
        Tue, 19 Feb 2019 08:07:02 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h17sm12161381wrq.17.2019.02.19.08.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 08:07:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 5/7] gpio: mockup: change the type of 'offset' to unsigned int
Date:   Tue, 19 Feb 2019 17:06:48 +0100
Message-Id: <20190219160650.9614-6-brgl@bgdev.pl>
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

