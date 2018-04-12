Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbeDLBXk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 21:23:40 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:40970 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeDLBXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 21:23:39 -0400
Date: Thu, 12 Apr 2018 11:23:38 +1000
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] block/amiflop: Don't log an error message for an invalid
 ioctl
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S1752272AbeDLBXk/20180412012341Z+1826@vger.kernel.org>

Do as the swim3 driver does and just return -ENOTTY.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/block/amiflop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 3aaf6af3ec23..b9fb794c1255 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1533,9 +1533,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 			return p->type->read_size;
 #endif
 	default:
-		printk(KERN_DEBUG "fd_ioctl: unknown cmd %d for drive %d.",
-		       cmd, drive);
-		return -ENOSYS;
+		return -ENOTTY;
 	}
 	return 0;
 }
-- 
2.16.1
