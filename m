Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B8CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7540222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jllBMCP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438931AbfBNNnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:43:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50803 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436757AbfBNNnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:43:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so6308503wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 05:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGhY56a8nIJgDsb5sjnpobT0rUV/Z8DFoqhyFGaVyME=;
        b=jllBMCP0TADIBm7Wuko6SCPiDeehfvOlFElLa9wWSZScgE3T4ixwzHyjClpe3Me0Rw
         1C/NUdtzisnHKlU6g7EZIaw59FigkSH0Y6wNsxUb5noYP1zV66tWMp88rZPTGkGS+F3T
         yPJovgqF6aaBf9iKpjFlad79bwHO2HhFUclfVhwzulQeL1F5J8nq5VG1Tz7SItwVOJzV
         NAvCx67SZcjhUU9tnGZHuk9sthQjta41uuPx0ZDBaIVm1EEIooi43l/wEUQWmK+Xzo0V
         Byuloqldo7hEmCVaUj6leNhVuAtIHIKjdF1wlaGwM/x7l09Prhtwl1qCfbT6u1KLoV5B
         KWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGhY56a8nIJgDsb5sjnpobT0rUV/Z8DFoqhyFGaVyME=;
        b=Xj7z27Qd0GUv0BG/kk7Oou3C8+g+NRhRS9Gg9KyUjd/iVgoVFbbAjQ2gs+irFKrN/X
         olCe8bhw3rsbqAQvMDq4cs5r5ymGaS1jV7P1v4JsGINyNknaqYUCLwAMjUPUrV9uedNJ
         ZLV+A1Zz23Y5/yuDpY+XkhWlIAtM/M9I/uSXiwYS9zEHVAl84pmEC3faTnD5amXriZOJ
         vzAsPGMPWmmpFeiR3+G/DaiTT2/x0PyuAP4eTSCdgOy90jgZGBH9o/2CKMBVuwLkEi9D
         dWhNeY2DubJ/yQgXu/kqMAkit9HvL4e+OpmEJ1fJDy3/iFo/5gimO2+RLmKvEMgDc3B4
         yKrw==
X-Gm-Message-State: AHQUAuYj+VjgMnMH0FXOU7OtOZWXSor47SSOmIbPpH9zEJIFYrQwV64M
        B16SG7iwQZxyUTZs8eV6lZ8RPQ==
X-Google-Smtp-Source: AHgI3IYxydVGWTe48PLKcfoTF7puoaYTCPRQRFLXGw3NSJwUy2JJ9Y9U/sDP/UWhStAYW5QuDpgMBg==
X-Received: by 2002:a7b:c04f:: with SMTP id u15mr2693391wmc.49.1550151781663;
        Thu, 14 Feb 2019 05:43:01 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 62sm4963460wra.46.2019.02.14.05.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 05:43:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 5/7] gpio: mockup: change the type of 'offset' to unsigned int
Date:   Thu, 14 Feb 2019 14:42:30 +0100
Message-Id: <20190214134232.3821-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214134232.3821-1-brgl@bgdev.pl>
References: <20190214134232.3821-1-brgl@bgdev.pl>
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
index 9d279d641374..4e7688348c0e 100644
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

