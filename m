Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbeD3Hjx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:39:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56191 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752285AbeD3Hi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:38:28 -0400
X-Google-Smtp-Source: AB8JxZp7wz5QtvdHUOwHC6aS2WtRjNMkrUNO94jSp5SZfl8KdEhL8lzSI6vfz/AsGd6KbSXS6fbhvA==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] gpio: mxs: Use of_device_get_match_data()
Date: Mon, 30 Apr 2018 09:38:12 +0200
Message-Id: <20180430073819.31827-5-thierry.reding@gmail.com>
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
 drivers/gpio/gpio-mxs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 435def22445d..5ad8d4db74db 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -290,8 +290,6 @@ MODULE_DEVICE_TABLE(of, mxs_gpio_dt_ids);
 
 static int mxs_gpio_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-			of_match_device(mxs_gpio_dt_ids, &pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *parent;
 	static void __iomem *base;
@@ -306,7 +304,7 @@ static int mxs_gpio_probe(struct platform_device *pdev)
 	port->id = of_alias_get_id(np, "gpio");
 	if (port->id < 0)
 		return port->id;
-	port->devid = (enum mxs_gpio_id) of_id->data;
+	port->devid = (enum mxs_gpio_id)of_device_get_match_data(&pdev->dev);
 	port->dev = &pdev->dev;
 	port->irq = platform_get_irq(pdev, 0);
 	if (port->irq < 0)
-- 
2.17.0
