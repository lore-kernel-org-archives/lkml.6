Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeD3Hi4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:38:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51062 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbeD3Hij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:38:39 -0400
X-Google-Smtp-Source: AB8JxZpv2ffYCZ9RJju7rfqQ9NJ54huSyRCJj8YG2I8g8xFzwk45yeiwRyVpO8vhe2/noSZpMy6BrA==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] gpio: xlp: Use of_device_get_match_data()
Date: Mon, 30 Apr 2018 09:38:19 +0200
Message-Id: <20180430073819.31827-12-thierry.reding@gmail.com>
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
 drivers/gpio/gpio-xlp.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-xlp.c b/drivers/gpio/gpio-xlp.c
index e74bd43a6974..8e4275eaa7d7 100644
--- a/drivers/gpio/gpio-xlp.c
+++ b/drivers/gpio/gpio-xlp.c
@@ -322,14 +322,7 @@ static int xlp_gpio_probe(struct platform_device *pdev)
 		return irq;
 
 	if (pdev->dev.of_node) {
-		const struct of_device_id *of_id;
-
-		of_id = of_match_device(xlp_gpio_of_ids, &pdev->dev);
-		if (!of_id) {
-			dev_err(&pdev->dev, "Unable to match OF ID\n");
-			return -ENODEV;
-		}
-		soc_type = (uintptr_t) of_id->data;
+		soc_type = (uintptr_t)of_device_get_match_data(&pdev->dev);
 	} else {
 		const struct acpi_device_id *acpi_id;
 
-- 
2.17.0
