Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeD3Hkp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:40:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56185 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeD3Hi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:38:26 -0400
X-Google-Smtp-Source: AB8JxZpey0OsrgiDybG4xmYTRAnFYoVQfzPnFVg6fMWpW//vvs6Yn/41Y5Ms6n8MIwUe1IKFf6OXQQ==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] gpio: ge: Use of_device_get_match_data()
Date: Mon, 30 Apr 2018 09:38:10 +0200
Message-Id: <20180430073819.31827-3-thierry.reding@gmail.com>
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
 drivers/gpio/gpio-ge.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index 1fe2d3418f2f..4c43562434cf 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -52,8 +52,6 @@ MODULE_DEVICE_TABLE(of, gef_gpio_ids);
 
 static int __init gef_gpio_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-		of_match_device(gef_gpio_ids, &pdev->dev);
 	struct gpio_chip *gc;
 	void __iomem *regs;
 	int ret;
@@ -82,7 +80,7 @@ static int __init gef_gpio_probe(struct platform_device *pdev)
 	}
 
 	gc->base = -1;
-	gc->ngpio = (u16)(uintptr_t)of_id->data;
+	gc->ngpio = (u16)of_device_get_match_data(&pdev->dev);
 	gc->of_gpio_n_cells = 2;
 	gc->of_node = pdev->dev.of_node;
 
-- 
2.17.0
