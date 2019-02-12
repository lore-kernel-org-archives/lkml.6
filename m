Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92B4C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8690A214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="prLohWPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfBLNQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:16:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37158 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbfBLNQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:16:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id x10so2961616wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2krnFxmiomVyVDb/8h+/xtPx5s60ffpJQDYiPXgWEoY=;
        b=prLohWPzjO6r7oy/SqAxGyYcNu9nV9Ckew5tqyG8tffL0ODI5q59dasHbcZ+PSsRQl
         pPY76sfs0/D180MH1FR6jWJYSJZypTsJB0uL27Q4EoELbForT4U2jMhXZ5jVgIOmhNSK
         nx2v2bIMooJ935xBD2vmPgSa3UtA2xtMXQ/UfsKgkPX6QYNidIkjVTvSMwykxcf8nIWD
         T4qRm5yQ0tQ+cPAmVVucKVWYwEDikwVC8dS0zioqFrNmGHlelZIGOG3AyRaYt/zfja53
         t0/jO3Wznd2g2gM4jlswDbCYKCt+sLwuOAsygDP6xFR/niVkvlEzswhl3VcUZbaFnTt6
         h+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2krnFxmiomVyVDb/8h+/xtPx5s60ffpJQDYiPXgWEoY=;
        b=DSUC+vN8qXW+2OfdS1KmYg+f1NUhuGrwZ/EZvNlHTszWeglspmWBUM+bJE2HxoqfmF
         uwT5sPqvw57k1nQRJSWcNj4ngK4gpvz4aPik4N8GyUCP5jYcn1w9SODgbeDPwdSBTO2Q
         hgn7N29dSHixhU/XadNmYXQ80ZqC+alUsnR54c42jg3xYX2CqlOnFPhorAmU5idYfgCq
         bsgxs1oG4+dHIW6tOQUzmq+bGQYa1xnFi7nU9PdFblwZSYS8XRR2Pm2oUJz0QzNn5hrr
         c8r0G8y/hk8XSPrVDLKYZUYwEGboyr/q22LZD/wXgo1j0AVtNQ6EcLyQKTuGtBouNtfQ
         X/rg==
X-Gm-Message-State: AHQUAuaxD+cnuHDih58a3vXTi319OO09JzNWUW+U5/NKMmPGZ8SFsRPR
        mkbgP54m+5LequSmK0OAS+JIHQ==
X-Google-Smtp-Source: AHgI3IZ0FO5EXo2xkPmHpTih1JaNjzGXV4g53ldcf5K+gF22Re24JjofQdkHGq1HZbO0gwYe2r2rmQ==
X-Received: by 2002:a1c:be04:: with SMTP id o4mr2830848wmf.19.1549977390893;
        Tue, 12 Feb 2019 05:16:30 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id p6sm5478517wre.63.2019.02.12.05.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 05:16:30 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 5/7] gpio: mockup: change the type of 'offset' to unsigned int
Date:   Tue, 12 Feb 2019 14:15:58 +0100
Message-Id: <20190212131600.18960-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212131600.18960-1-brgl@bgdev.pl>
References: <20190212131600.18960-1-brgl@bgdev.pl>
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

