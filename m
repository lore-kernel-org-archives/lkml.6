Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E9DC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4ED921848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="A2WsQ99n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfBTLMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:12:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34154 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfBTLMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:12:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so4453240wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 03:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1lfqJzHdcjA20Q30XeL0tcyEj0lgU0X5EuBNLTHV4pc=;
        b=A2WsQ99nTNxk2DvdpKBcLgTQ6phol5QkP5nDsbzEu1AfRT3Lb4D6+M50rFaG+uW63M
         j+hVQ4QSL7Q1pRbvkpJN/IWLiUN5kFVOMAnyBl1ECjUFiwIwEHGWv2Abbv5tzzxfGRId
         d47Kb+lBLKZIP76G1z/2Lyhs63l65H9OH2I08oeSfMmp62CnuJrESzVIx1V2DyvAl1+m
         +bYgyv9/ExQYpG7RRew+C9jzL4/QxEHlAeR7jun+FLZ6htOqroxdQGkOTl2arBUtnbVZ
         nqyJT34uUvvhuPJEmkMZ95ha3VmE0r85rFRUykx2GCZy54zKhpvEkN5ijF+HU/ZuWXs7
         bUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1lfqJzHdcjA20Q30XeL0tcyEj0lgU0X5EuBNLTHV4pc=;
        b=Ij9XsujhWn3hyxukgZ+xK4pYRJ2+y5U6SytiCLb5DJf0I8Ogk9K+rh6whNd7G9fWG7
         Jx/GLxQaMaIiZyTb6BQ3taE0EQwHqwCtQVezGiFaNWdLTN4nhcikKpLUT1tfHy3VKLiH
         a83GYkvxqXqt0RPBtOnoTAjgMz6ukvIm83UZxc3/bh8nTE6XbhLIsTQ35iukRVeewtlq
         lzvenUvmxfpRiCgX/6H0RB+TpEU4ml88vDQXUITCsH9V3Tdgt0g+Xudyhtlf42Xu+lZH
         mdshPK+RST3/IMohHmMHSXCgZvvuAdcEIHmUCfY+NW39U+qs3k/vbUYouEEzO+9aMk7N
         nKkA==
X-Gm-Message-State: AHQUAubHWXiYssgwGBO2GdTqT9F1mmUdWP3/wH3e74I5ZkE8cL1t5ZtU
        S0H9jwC9mvNT1IL4YE9VObTqIA==
X-Google-Smtp-Source: AHgI3IbDAqZ3ugDZeFPszLr/bYipvH7gDKtGdO7ryf/W4BSUHYVfTgawMy/7Lk7xOviDBqT6PVbsRA==
X-Received: by 2002:a1c:cb86:: with SMTP id b128mr6125906wmg.46.1550661169996;
        Wed, 20 Feb 2019 03:12:49 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c18sm22969770wre.32.2019.02.20.03.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:12:49 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/2] gpio: davinci: use devm_platform_ioremap_resource()
Date:   Wed, 20 Feb 2019 12:12:40 +0100
Message-Id: <20190220111240.10041-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220111240.10041-1-brgl@bgdev.pl>
References: <20190220111240.10041-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the new helper that wraps the calls to platform_get_resource() and
devm_ioremap_resource() together.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-davinci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index bdb29e51b417..188b8e5c8e67 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -198,7 +198,6 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	struct davinci_gpio_controller *chips;
 	struct davinci_gpio_platform_data *pdata;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 
 	pdata = davinci_gpio_get_pdata(pdev);
 	if (!pdata) {
@@ -236,8 +235,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	if (!chips)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gpio_base = devm_ioremap_resource(dev, res);
+	gpio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gpio_base))
 		return PTR_ERR(gpio_base);
 
-- 
2.20.1

