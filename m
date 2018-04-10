Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbeDJNNN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:13:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56030 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753244AbeDJNMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:12:23 -0400
X-Google-Smtp-Source: AIpwx49AZWtzX6XgwTmDy9KdLHX9M0kb5e/ZDiOhXlddj7AwKSKaQ1D9FEf67GBNFS2uW6PfiyVcjg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>, Sven Van Asbroeck <svendev@arcx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 1/4] eeprom: at24: don't assign the i2c ID table to at24_driver
Date: Tue, 10 Apr 2018 15:12:03 +0200
Message-Id: <20180410131206.25760-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410131206.25760-1-brgl@bgdev.pl>
References: <20180410131206.25760-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We switched to using probe_new(), so this is no longer used
by i2c core.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0c125f207aea..2310f26ac4f3 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -737,7 +737,6 @@ static struct i2c_driver at24_driver = {
 	},
 	.probe_new = at24_probe,
 	.remove = at24_remove,
-	.id_table = at24_ids,
 };
 
 static int __init at24_init(void)
-- 
2.17.0
