Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B3FC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F93223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LCyGpzxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F93223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbeKMXtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:49:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54179 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733229AbeKMXtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:49:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id f10-v6so11978617wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 05:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjpgGaYWzkrTyqB9MlsAxGRgdPqZmjwayR/Z33XA7DA=;
        b=LCyGpzxCXNaHTsgP+0aiXMct89jOJgFzoIGgviOzwMHkS3ZoxxuhBUFjBn2EYyEEc0
         xnZuzAXtgfBfLK6EDuxqMrJImPBQgsg2S+hngfZx8S+kP6BMUDXAeLsjqqTV04cmbWhm
         qPGeVI7zxITjuIR268WI6dDn4XBypn2pD0jTwjNdfkRTFQ9pZsyJs4jT4o/rqsabMbEt
         UGODXs9wSmpkNtF7Dqrab6RXrtSWItou9qG4an28Xo39d1aVr8nHLT8MBYv7QfzOvs62
         OYrTBehFLnrEhxUr+jvEyMYegqYfbUqbr4dlRmwh8Mdb3wTS4CQ1450akVZs+CtSfUgX
         kXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjpgGaYWzkrTyqB9MlsAxGRgdPqZmjwayR/Z33XA7DA=;
        b=GGdRdUC7zmN9ff8bvJJT8KaDFeDUQMeJvuqvQ7NgMFwZVVX54lJ5apZGnG5F8C8G8J
         ooqE88G/JeGhw8k++rkVldiycQYp8lUtmtcntzjZSpuhfTgZzBEWwDKO12IIxaFJdT8s
         IR1bnbUZmDwkMj2zLffvqQke3awCBBx401Vo1qnJtq1/pSYrHWdSZl14TCrmEhmy4dqi
         uU5a4Ag5WPdjg9vlEHhXB1KYbQ1AEqBUYpmoF85DVM+Vl7niaQotQ9ppJuimUa/ES3OM
         +NOCifT/YHGcy9Q0HeyfLH2YDvvtcxD2gTQ/jGdMOFxaNPXA5fSe3/pC7VFJ4SyNVYLj
         6hIg==
X-Gm-Message-State: AGRZ1gLh67H3PYQuO/NT1Sn5sXILO2F4annShITj/Jq4dNAnqIyBKljd
        ViBMmvC6n72mbYZyCwK858s3IA==
X-Google-Smtp-Source: AJdET5fVtnAHQ/TYlu0JxEcW90ac3CiqkyfkMxw1Yc1qD/RYO4G0m9rleq5hkuqSsnaV7oe0/JZifg==
X-Received: by 2002:a1c:aacf:: with SMTP id t198-v6mr3472108wme.108.1542117064742;
        Tue, 13 Nov 2018 05:51:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id j40-v6sm15170050wre.48.2018.11.13.05.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 05:51:04 -0800 (PST)
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
Subject: [PATCH 2/3] gpio: davinci: restore a way to manually specify the GPIO base
Date:   Tue, 13 Nov 2018 14:50:50 +0100
Message-Id: <20181113135051.15308-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113135051.15308-1-brgl@bgdev.pl>
References: <20181113135051.15308-1-brgl@bgdev.pl>
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

