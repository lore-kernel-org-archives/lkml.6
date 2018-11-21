Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D454C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418D520989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uPXTR+ST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418D520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbeKUUJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:09:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55397 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbeKUUJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:09:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so4743717wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bXvrUaCBdXRbbMq56OlspLiruOVYgLTKU+757JvGY/Y=;
        b=uPXTR+STqxwJMGYpDPDRUiAfVOY+2bUeXFfbslIMcgr1f9Kyf0jIO2hT8E/9IACLVi
         lLk0X8Cfqbz/cWnOS9Hc3Ey6wpZpKtd5UBsDUXDOllZQlJrCbf0Qm0ZaGCRRvpsyuJ6S
         3pXpwC91rjuMXO0HrEeUmxZg9p66fy0Np4B5AktfwQrGyNZ0/jIPdhrCzvIgf6+Xa4eI
         EhYeEXKBrImBEzy4XBKGTzGntDT9dAD1wF1WatGdBUEqOmePy0ewuVv/am5TD7j30Vfm
         EGKjP1DvvYON2dphvZhkIuxHAipYiR1cE+9a2fEcZMdE6/+AVR/jV3VohItd29tj49bv
         O4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bXvrUaCBdXRbbMq56OlspLiruOVYgLTKU+757JvGY/Y=;
        b=q52kW8qb/wLrthjnUxGaDHP7+N+tQAE6w0Ru0OpJKQOEjtAoZxWX2R97lrgQNKExC2
         JlKngyJN305KqEfK9qj1Gz/jfSfPYZesMlOq7HzR4ZuWhmluDmckZIq71h+psPSlwHPl
         /DCIggSnZ50i+AHR1BoQ1dMKCS9DJj+VVUf80jt8VLOv5X1zbS6UUbU+P2TCR6G/qUgo
         5yn0JnqKqdZDoE6SmxuRKZaUd5e1xak+v666kWdFeli20NxIovItMhkmelAHw/zwFFdh
         +BZCSDKzbnmziSXFNUyxP2ISQBLal9vzwqQTZXSLs1p5wXLB3qASubCDi1YjFWB5llxl
         vEnQ==
X-Gm-Message-State: AA+aEWac9jRpJ8iqHSIvKEmEhfmliSUPnh02nl+jQeyYz57nW/pq8MGT
        N5o1BKt7jP7t0OT6DfA7067kKA==
X-Google-Smtp-Source: AFSGD/USrGD/UxF5KngQm5Y5Z9/vKtMVcBlQCojsUJSNcGeM+y0KeQAaSW5lUKF3TyX2mfL071BstA==
X-Received: by 2002:a1c:adc9:: with SMTP id w192-v6mr5228413wme.103.1542792937190;
        Wed, 21 Nov 2018 01:35:37 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o8sm10443785wrx.15.2018.11.21.01.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:35:36 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 06/12] gpio: davinci: restore a way to manually specify the GPIO base
Date:   Wed, 21 Nov 2018 10:35:17 +0100
Message-Id: <20181121093523.12503-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121093523.12503-1-brgl@bgdev.pl>
References: <20181121093523.12503-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") broke the network support in legacy boot
mode for da850-evm since we can no longer request the MDIO clock GPIO.

Other boards may be broken too, which I haven't tested.

The problem is in the fact that most board files still use the legacy
GPIO API where lines are requested by numbers rather than descriptors.

While this should be fixed eventually, in order to unbreak the board
for now - provide a way to manually specify the GPIO base in platform
data.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-davinci.c                | 2 +-
 include/linux/platform_data/gpio-davinci.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 5c1564fcc24e..bdb29e51b417 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -258,7 +258,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	chips->chip.set = davinci_gpio_set;
 
 	chips->chip.ngpio = ngpio;
-	chips->chip.base = -1;
+	chips->chip.base = pdata->no_auto_base ? pdata->base : -1;
 
 #ifdef CONFIG_OF_GPIO
 	chips->chip.of_gpio_n_cells = 2;
diff --git a/include/linux/platform_data/gpio-davinci.h b/include/linux/platform_data/gpio-davinci.h
index f92a47e18034..a93841bfb9f7 100644
--- a/include/linux/platform_data/gpio-davinci.h
+++ b/include/linux/platform_data/gpio-davinci.h
@@ -17,6 +17,8 @@
 #define __DAVINCI_GPIO_PLATFORM_H
 
 struct davinci_gpio_platform_data {
+	bool	no_auto_base;
+	u32	base;
 	u32	ngpio;
 	u32	gpio_unbanked;
 };
-- 
2.19.1

