Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeEGKRJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:17:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54534 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbeEGKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:17:04 -0400
X-Google-Smtp-Source: AB8JxZpdJshRPqmcNRgqIdrAmi8G2f6QQR+lHwxSvXaZvPhPdSx2lOxXCWeEH3I9SlpuZT9VzGmE6w==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Vadim Pasternak <vadimp@mellanox.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] eeprom: at24: fix retrieving the at24_chip_data structure
Date: Mon,  7 May 2018 12:16:58 +0200
Message-Id: <20180507101658.7788-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit feb2f19b1e8f ("eeprom: at24: move platform data processing into
a separate routine") introduced a bug where we incorrectly retireve the
at24_chip_data structure. Remove the unnecessary ampersand operator.

Fixes: feb2f19b1e8f ("eeprom: at24: move platform data processing into a separate routine")
Reported-by: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0c125f207aea..33053b0d1fdf 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -518,7 +518,7 @@ static int at24_get_pdata(struct device *dev, struct at24_platform_data *pdata)
 	if (of_node && of_match_device(at24_of_match, dev))
 		cdata = of_device_get_match_data(dev);
 	else if (id)
-		cdata = (void *)&id->driver_data;
+		cdata = (void *)id->driver_data;
 	else
 		cdata = acpi_device_get_match_data(dev);
 
-- 
2.17.0
