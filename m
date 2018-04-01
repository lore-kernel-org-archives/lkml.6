Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbeDABmL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 21:42:11 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47384 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbeDABlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 21:41:08 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <455c2ccbea2f83947630e3068ecadf4ab4434fb9.1522546571.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1522546571.git.fthain@telegraphics.com.au>
References: <cover.1522546571.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 07/12] block/swim: Remove extra put_disk() call from error
 path
Date: Sat, 31 Mar 2018 21:41:05 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/block/swim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 87c70fcce875..19d7d27468c7 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -873,7 +873,6 @@ static int swim_floppy_init(struct swim_priv *swd)
 							      &swd->lock);
 		if (!swd->unit[drive].disk->queue) {
 			err = -ENOMEM;
-			put_disk(swd->unit[drive].disk);
 			goto exit_put_disks;
 		}
 		blk_queue_bounce_limit(swd->unit[drive].disk->queue,
-- 
2.16.1
