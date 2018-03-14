Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbeCNPge (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:36:34 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45958 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeCNPgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:36:31 -0400
X-Google-Smtp-Source: AG47ELsF7Qx71DEOQn5m5nwMqt5tFAdV9u3wEEpIxlBEL3UBPvRxGJmrxHxK2hrKkhag2V14HHHsHA==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: dwmw2@infradead.org
Cc: computersforpeace@gmail.com, boris.brezillon@free-electrons.com,
        marek.vasut@gmail.com, richard@nod.at, cyrille.pitchen@wedev4u.fr,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: [PATCH 2/3] mtd: maps: Remove print after allocation failure
Date: Wed, 14 Mar 2018 21:05:17 +0530
Message-Id: <1521041718-32492-2-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521041718-32492-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1521041718-32492-1-git-send-email-arushisinghal19971997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prints after [k|v][m|z|c]alloc() functions are not needed, because
in case of failure, allocator will print their internal error prints
anyway.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/mtd/maps/sun_uflash.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index 1e73bba..80a253c 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -62,10 +62,8 @@ int uflash_devinit(struct platform_device *op, struct device_node *dp)
 	}
 
 	up = kzalloc(sizeof(struct uflash_dev), GFP_KERNEL);
-	if (!up) {
-		printk(KERN_ERR PFX "Cannot allocate struct uflash_dev\n");
+	if (!up)
 		return -ENOMEM;
-	}
 
 	/* copy defaults and tweak parameters */
 	memcpy(&up->map, &uflash_map_templ, sizeof(uflash_map_templ));
-- 
2.7.4
