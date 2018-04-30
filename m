Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeD3Hi2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:38:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38367 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbeD3HiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:38:24 -0400
X-Google-Smtp-Source: AB8JxZqX6BTU0MigdWqmYmCOCdz0iFmyriQrIHtcY1qYUl3G4MOkXTat8brXtB7tWXyRCDU10OdqDg==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] gpio: dwapb: Use of_device_get_match_data()
Date: Mon, 30 Apr 2018 09:38:09 +0200
Message-Id: <20180430073819.31827-2-thierry.reding@gmail.com>
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
 drivers/gpio/gpio-dwapb.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 226977f78482..c25fa72d499f 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -684,13 +684,7 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
 
 	gpio->flags = 0;
 	if (dev->of_node) {
-		const struct of_device_id *of_devid;
-
-		of_devid = of_match_device(dwapb_of_match, dev);
-		if (of_devid) {
-			if (of_devid->data)
-				gpio->flags = (uintptr_t)of_devid->data;
-		}
+		gpio->flags = (uintptr_t)of_device_get_match_data(dev);
 	} else if (has_acpi_companion(dev)) {
 		const struct acpi_device_id *acpi_id;
 
-- 
2.17.0
