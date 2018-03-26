Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeCZGuB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 02:50:01 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38676 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbeCZGt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 02:49:59 -0400
X-Google-Smtp-Source: AG47ELtIY6YpYgVMIR8hYQjZ9ILyt9nJPPClnSqiSioXGbBc1rEJCRmTFP++vRa020jy5awOqPGFsQ==
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>
Subject: [PATCH 1/2] zram: correct flag name of ZRAM_ACCESS
Date: Mon, 26 Mar 2018 15:49:50 +0900
Message-Id: <20180326064951.123940-1-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZRAM_ACCESS is meant to lock a slot of zram so correct the name.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 drivers/block/zram/zram_drv.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0f3fadd71230..4feb983ec9a3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -755,12 +755,12 @@ static DEVICE_ATTR_RO(debug_stat);
 
 static void zram_slot_lock(struct zram *zram, u32 index)
 {
-	bit_spin_lock(ZRAM_ACCESS, &zram->table[index].value);
+	bit_spin_lock(ZRAM_LOCK, &zram->table[index].value);
 }
 
 static void zram_slot_unlock(struct zram *zram, u32 index)
 {
-	bit_spin_unlock(ZRAM_ACCESS, &zram->table[index].value);
+	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].value);
 }
 
 static void zram_meta_free(struct zram *zram, u64 disksize)
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index d71c8000a964..baecba5d56a5 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -46,7 +46,7 @@
 enum zram_pageflags {
 	/* Page consists the same element */
 	ZRAM_SAME = ZRAM_FLAG_SHIFT,
-	ZRAM_ACCESS,	/* page is now accessed */
+	ZRAM_LOCK,	/* zram slot is locked */
 	ZRAM_WB,	/* page is stored on backing_device */
 
 	__NR_ZRAM_PAGEFLAGS,
-- 
2.17.0.rc0.231.g781580f067-goog
