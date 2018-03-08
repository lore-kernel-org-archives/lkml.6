Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936005AbeCHRiV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:38:21 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44120 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934121AbeCHRiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:38:18 -0500
X-Google-Smtp-Source: AG47ELsW/CUTVBlnj4tVm7PP1mOuWxeSwukBk6yzKrAKOVFyOb59ECXuAApuN+H0dJ/xMh4Vl/0maQ==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/3] mfd: rave-sp: Convert print_hex_dump() to print_hex_dump_debug()
Date: Thu,  8 Mar 2018 09:37:55 -0800
Message-Id: <20180308173756.13787-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308173756.13787-1-andrew.smirnov@gmail.com>
References: <20180308173756.13787-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert print_hex_dump() to print_hex_dump_debug() to be able to
leverage CONFIG_DYNAMIC_DEBUG.

Cc: linux-kernel@vger.kernel.org
Cc: cphealy@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/mfd/rave-sp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index be243678a61e..5c1442fa2308 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -309,8 +309,8 @@ static int rave_sp_write(struct rave_sp *sp, const u8 *data, u8 data_size)
 
 	length = dest - frame;
 
-	print_hex_dump(KERN_DEBUG, "rave-sp tx: ", DUMP_PREFIX_NONE,
-		       16, 1, frame, length, false);
+	print_hex_dump_debug("rave-sp tx: ", DUMP_PREFIX_NONE,
+			     16, 1, frame, length, false);
 
 	return serdev_device_write(sp->serdev, frame, length, HZ);
 }
@@ -451,8 +451,8 @@ static void rave_sp_receive_frame(struct rave_sp *sp,
 	struct device *dev           = &sp->serdev->dev;
 	u8 crc_calculated[checksum_length];
 
-	print_hex_dump(KERN_DEBUG, "rave-sp rx: ", DUMP_PREFIX_NONE,
-		       16, 1, data, length, false);
+	print_hex_dump_debug("rave-sp rx: ", DUMP_PREFIX_NONE,
+			     16, 1, data, length, false);
 
 	if (unlikely(length <= checksum_length)) {
 		dev_warn(dev, "Dropping short frame\n");
-- 
2.14.3
