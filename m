Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932797AbeD0LCc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:02:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36640 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932700AbeD0LC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:02:29 -0400
X-Google-Smtp-Source: AB8JxZrQ2sKRMRqWVFpImAx2a1N36P/k8oavkofTHu9q61H0WAosxA04/QqxOWUfYT9/dZQEuGc2ZA==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH] spi: mpc52xx: Use gpio_is_valid()
Date: Fri, 27 Apr 2018 16:32:17 +0530
Message-Id: <aef1b612f61b530012459def8ac958f88674e1c8.1524826858.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the manual validity checks for the GPIO with the
gpio_is_valid().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/spi/spi-mpc52xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index e8b59ce..0e55784 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -447,7 +447,7 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 
 		for (i = 0; i < ms->gpio_cs_count; i++) {
 			gpio_cs = of_get_gpio(op->dev.of_node, i);
-			if (gpio_cs < 0) {
+			if (!gpio_is_valid(gpio_cs)) {
 				dev_err(&op->dev,
 					"could not parse the gpio field in oftree\n");
 				rc = -ENODEV;
-- 
1.9.1
