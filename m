Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbeD3Him (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:38:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35355 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752474AbeD3Hih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:38:37 -0400
X-Google-Smtp-Source: AB8JxZo29fg1jxdoZz5FV+BV1H28tw4k1G07UOjgs6xf8xdGM8bK9D6OX7MrVAACCDHIGJw8hgRl4Q==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] gpio: vf610: Use of_device_get_match_data()
Date: Mon, 30 Apr 2018 09:38:18 +0200
Message-Id: <20180430073819.31827-11-thierry.reding@gmail.com>
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
 drivers/gpio/gpio-vf610.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 4610cc2938ad..d4ad6d0e02a2 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -254,8 +254,6 @@ static struct irq_chip vf610_gpio_irq_chip = {
 
 static int vf610_gpio_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id = of_match_device(vf610_gpio_dt_ids,
-							   &pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct vf610_gpio_port *port;
@@ -267,7 +265,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
-	port->sdata = of_id->data;
+	port->sdata = of_device_get_match_data(dev);
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->base = devm_ioremap_resource(dev, iores);
 	if (IS_ERR(port->base))
-- 
2.17.0
