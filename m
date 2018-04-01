Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbeDABle (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 21:41:34 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47452 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753208AbeDABlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 21:41:10 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <fa0c52b4839001e0b5c9d068c21d2f8d38b5e1d9.1522546571.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1522546571.git.fthain@telegraphics.com.au>
References: <cover.1522546571.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 12/12] block/swim: Select appropriate drive on device open
Date: Sat, 31 Mar 2018 21:41:05 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/block/swim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index c4eb54575574..64226c56ffb2 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -660,7 +660,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 		swim_write(base, setup, S_IBM_DRIVE | S_FCLK_DIV2);
 
 	udelay(10);
-	swim_drive(base, INTERNAL_DRIVE);
+	swim_drive(base, fs->location);
 	swim_motor(base, ON);
 	swim_action(base, SETMFM);
 	if (fs->ejected)
-- 
2.16.1
