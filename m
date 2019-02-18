Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87F8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982C0218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jPDMpttv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfBRJsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:48:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36150 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbfBRJsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:48:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so16379518wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 01:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2krnFxmiomVyVDb/8h+/xtPx5s60ffpJQDYiPXgWEoY=;
        b=jPDMpttvnTfhSuKSdO2j+xPSSP5WsaqSthB4QBgzlsLk1nxcuQZNcwYzpsmCZdd6+Z
         R364lce/9znpsJepREEUT6nH/BFPC58dJZKgJOATVz3OXuTJORS7fVbZ+HpGFMCYOo/4
         M5Umq65Lj3tk8pLiPMQJRB4r50DdsqugUUbGsuffDF4Wh7/696CYDwxw4Ow/AV8MCNHm
         R+aFlpphXDHJAtYryIPPsbkkx6NgIesHSKGXqpJDmlrAgOASV08WHBVJbeLWJf+nubSZ
         JtCguR239gcLyIMJTi3Rkgpp93yAmTzH9+GbjhDFJtvtb5/3Mea39rxbFRNGoVuWobnS
         38/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2krnFxmiomVyVDb/8h+/xtPx5s60ffpJQDYiPXgWEoY=;
        b=QOGzOuoMglrvTEqaHBAWhIWgzLP+fXLJQDdyoosw05HtrLKBEyZZl3ofhMhhqfhnOQ
         m3aRHWERUmib9+jtklbGOgJhvr+NOPVUZGh3QRaKlANtlGtTgyMkZ+2lvDyp85+ncaU+
         hFrVAgoNXa9tO9a1nGgWijqbjyTlVXlLvGhAtCqp7HUby/nlkQbeIrFs2mYZ8nntNtqs
         Y8irj/Mfy+mH/FOTChZHsE2Fu7QYdG2HJaUAt0iQnQtw09eQ3S9dma25/BBq06Ph8wrz
         74+sCAWOqcSN1+uN1sD2dTTJ4dH1knsMvZxJduCgddkJ9oCStemEgfgI+4mpXQFkWXIe
         uirw==
X-Gm-Message-State: AHQUAuarou5Qfy7w0GSRm11VgP+LKdhAj08JHygFearQ0acOX/OjZ6Dx
        yxf84ckx+TrqstDaAWh435/JlG9n4rk=
X-Google-Smtp-Source: AHgI3IbwYyGNGnQC8Q2qq3FWGA0aoppGWlDfW+n1rFcWlveqoMXANZPBoKl8Q328YKzCUgEjXj/GLA==
X-Received: by 2002:a1c:7a1a:: with SMTP id v26mr3224765wmc.129.1550483293586;
        Mon, 18 Feb 2019 01:48:13 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id u15sm17582974wmu.17.2019.02.18.01.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 01:48:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/6] gpio: mockup: change the type of 'offset' to unsigned int
Date:   Mon, 18 Feb 2019 10:47:57 +0100
Message-Id: <20190218094759.14545-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218094759.14545-1-brgl@bgdev.pl>
References: <20190218094759.14545-1-brgl@bgdev.pl>
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

