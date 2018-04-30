Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbeD3Hie (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:38:34 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42889 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbeD3Hib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:38:31 -0400
X-Google-Smtp-Source: AB8JxZo49B0bs8OxRw+9FQEBcANqFB789f7o2zieBAR9StaJqjq5MlXApl3KeN8iCQo3bVh0JecyNg==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] gpio: palmas: Use of_device_get_match_data()
Date: Mon, 30 Apr 2018 09:38:13 +0200
Message-Id: <20180430073819.31827-6-thierry.reding@gmail.com>
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
 drivers/gpio/gpio-palmas.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-palmas.c b/drivers/gpio/gpio-palmas.c
index 3d818195e351..ceb2fef2c8ae 100644
--- a/drivers/gpio/gpio-palmas.c
+++ b/drivers/gpio/gpio-palmas.c
@@ -159,13 +159,9 @@ static int palmas_gpio_probe(struct platform_device *pdev)
 	struct palmas_platform_data *palmas_pdata;
 	struct palmas_gpio *palmas_gpio;
 	int ret;
-	const struct of_device_id *match;
 	const struct palmas_device_data *dev_data;
 
-	match = of_match_device(of_palmas_gpio_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-	dev_data = match->data;
+	dev_data = of_device_get_match_data(&pdev->dev);
 	if (!dev_data)
 		dev_data = &palmas_dev_data;
 
-- 
2.17.0
