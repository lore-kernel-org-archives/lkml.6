Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbeD3Hkn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:40:43 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45473 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbeD3Hi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:38:27 -0400
X-Google-Smtp-Source: AB8JxZqh8yB6NfN2lLQoOHNQxxnNxcheaGu9BoJXqKJUT8wAoxf+gKpcA1nxsfb/ZkFL15g8Ys/WZQ==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] gpio: ingenic: Use of_device_get_match_data()
Date: Mon, 30 Apr 2018 09:38:11 +0200
Message-Id: <20180430073819.31827-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430073819.31827-1-thierry.reding@gmail.com>
References: <20180430073819.31827-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Use of_device_get_match_data() instead of open-coding it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpio-ingenic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-ingenic.c b/drivers/gpio/gpio-ingenic.c
index 15fb2bc796a8..e738e384a5ca 100644
--- a/drivers/gpio/gpio-ingenic.c
+++ b/drivers/gpio/gpio-ingenic.c
@@ -285,8 +285,6 @@ MODULE_DEVICE_TABLE(of, ingenic_gpio_of_match);
 static int ingenic_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id = of_match_device(
-			ingenic_gpio_of_match, dev);
 	struct ingenic_gpio_chip *jzgc;
 	u32 bank;
 	int err;
@@ -323,7 +321,7 @@ static int ingenic_gpio_probe(struct platform_device *pdev)
 	jzgc->gc.parent = dev;
 	jzgc->gc.of_node = dev->of_node;
 	jzgc->gc.owner = THIS_MODULE;
-	jzgc->version = (enum jz_version)of_id->data;
+	jzgc->version = (enum jz_version)of_device_get_match_data(dev);
 
 	jzgc->gc.set = ingenic_gpio_set;
 	jzgc->gc.get = ingenic_gpio_get;
-- 
2.17.0
