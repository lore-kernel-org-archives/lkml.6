Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4267C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5189B20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOeljsRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5189B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeKZTVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:21:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44515 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeKZTVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:21:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so6205939pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w41fEMDO17MJRF+j3d4MXBw+LJzj/V+0iPAAHd54R6c=;
        b=qOeljsRg4j9kcIw9hcgXxKAFejtWHkfy+QKBYKF/jfynQNll/AoEmLLGm60nZP8TVc
         ZylqNBYxcBsndup0MQHLpsLVRsUMqtDZ4usBRgYHkKTJS0JVD1bKZx1nTp5LGILeYjGh
         53AIxCyX2eVTkCmg/M/Yl1ThOEf3nWswd5i35A/lco+DDViQoDYWXqfegBtOvhR8SKxS
         QCsUCDkkZMkRixormFhv+v3WiDnfGwT4cbPnBE5L1dUKaQzjgKkuq3geix7rLKHJoC2E
         /dVxHukdrprfFadjidqeiIKtSdKbOCEuZfnqNKwLDzJaIEPHRpb7iS3dBufqRZlrfsny
         +yDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=w41fEMDO17MJRF+j3d4MXBw+LJzj/V+0iPAAHd54R6c=;
        b=f7EC24LeC7Etak26SYxFdMvhGd3SJ9whEHm0a9DlOg1fbr+zyCCapif6UFVCszDIy9
         PUPoUVrjrUVc15F4Kul2Bo0BbEfFuaUfAphsFLlyf6AcUymX9FuO0+eJgEL/MSlkuT66
         cgx5XB1z9dFNAVdYvlajdp4mHR31dLwBcA1QSMrbdlHvD/XujXsrmo6kUlk4FGMD2fNx
         2Rbp51/FIl8qFHpiDN77epNahGk2Ilva0+984iMBgClqZAgEI9SqK4Rr7NZhLNis/n8u
         CpyLHmK4AGYSOYk4+KBTlTN69cNQhcmJTucW6K14U70xU16IM8sQrPU/BMCFdkoStXtX
         V1Yw==
X-Gm-Message-State: AA+aEWY5I1QIatpxMy7laqS6fkvc1a4wI4uE+yWwHTDzekAaPd6zD1Jt
        zwGZeIAYV+pcJa6B3EYNpC3UmjyKxBA=
X-Google-Smtp-Source: AFSGD/X/Ad1P4U/1TcS9e/IjpQNf3N0DT4A0ENIIudvWYNXV8Dc0cUXfGb0C0QRXqLRTeiBYt8s31w==
X-Received: by 2002:a63:9041:: with SMTP id a62mr23412906pge.163.1543220910135;
        Mon, 26 Nov 2018 00:28:30 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j197sm82846611pgc.76.2018.11.26.00.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:28:29 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 3/7] zram: refactoring flags and writeback stuff
Date:   Mon, 26 Nov 2018 17:28:09 +0900
Message-Id: <20181126082813.81977-4-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181126082813.81977-1-minchan@kernel.org>
References: <20181126082813.81977-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does renaming some variables and restructuring
some codes for better redability in writeback and zs_free_page.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 105 +++++++++++++---------------------
 drivers/block/zram/zram_drv.h |   8 +--
 2 files changed, 44 insertions(+), 69 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 514f5aaf6eff..fee7e67c750d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -55,17 +55,17 @@ static void zram_free_page(struct zram *zram, size_t index);
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
-	return bit_spin_trylock(ZRAM_LOCK, &zram->table[index].value);
+	return bit_spin_trylock(ZRAM_LOCK, &zram->table[index].flags);
 }
 
 static void zram_slot_lock(struct zram *zram, u32 index)
 {
-	bit_spin_lock(ZRAM_LOCK, &zram->table[index].value);
+	bit_spin_lock(ZRAM_LOCK, &zram->table[index].flags);
 }
 
 static void zram_slot_unlock(struct zram *zram, u32 index)
 {
-	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].value);
+	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].flags);
 }
 
 static inline bool init_done(struct zram *zram)
@@ -76,7 +76,7 @@ static inline bool init_done(struct zram *zram)
 static inline bool zram_allocated(struct zram *zram, u32 index)
 {
 
-	return (zram->table[index].value >> (ZRAM_FLAG_SHIFT + 1)) ||
+	return (zram->table[index].flags >> (ZRAM_FLAG_SHIFT + 1)) ||
 					zram->table[index].handle;
 }
 
@@ -99,19 +99,19 @@ static void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
 static bool zram_test_flag(struct zram *zram, u32 index,
 			enum zram_pageflags flag)
 {
-	return zram->table[index].value & BIT(flag);
+	return zram->table[index].flags & BIT(flag);
 }
 
 static void zram_set_flag(struct zram *zram, u32 index,
 			enum zram_pageflags flag)
 {
-	zram->table[index].value |= BIT(flag);
+	zram->table[index].flags |= BIT(flag);
 }
 
 static void zram_clear_flag(struct zram *zram, u32 index,
 			enum zram_pageflags flag)
 {
-	zram->table[index].value &= ~BIT(flag);
+	zram->table[index].flags &= ~BIT(flag);
 }
 
 static inline void zram_set_element(struct zram *zram, u32 index,
@@ -127,15 +127,15 @@ static unsigned long zram_get_element(struct zram *zram, u32 index)
 
 static size_t zram_get_obj_size(struct zram *zram, u32 index)
 {
-	return zram->table[index].value & (BIT(ZRAM_FLAG_SHIFT) - 1);
+	return zram->table[index].flags & (BIT(ZRAM_FLAG_SHIFT) - 1);
 }
 
 static void zram_set_obj_size(struct zram *zram,
 					u32 index, size_t size)
 {
-	unsigned long flags = zram->table[index].value >> ZRAM_FLAG_SHIFT;
+	unsigned long flags = zram->table[index].flags >> ZRAM_FLAG_SHIFT;
 
-	zram->table[index].value = (flags << ZRAM_FLAG_SHIFT) | size;
+	zram->table[index].flags = (flags << ZRAM_FLAG_SHIFT) | size;
 }
 
 #if PAGE_SIZE != 4096
@@ -282,16 +282,11 @@ static ssize_t mem_used_max_store(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
-static bool zram_wb_enabled(struct zram *zram)
-{
-	return zram->backing_dev;
-}
-
 static void reset_bdev(struct zram *zram)
 {
 	struct block_device *bdev;
 
-	if (!zram_wb_enabled(zram))
+	if (!zram->backing_dev)
 		return;
 
 	bdev = zram->bdev;
@@ -318,7 +313,7 @@ static ssize_t backing_dev_show(struct device *dev,
 	ssize_t ret;
 
 	down_read(&zram->init_lock);
-	if (!zram_wb_enabled(zram)) {
+	if (!zram->backing_dev) {
 		memcpy(buf, "none\n", 5);
 		up_read(&zram->init_lock);
 		return 5;
@@ -448,7 +443,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	return err;
 }
 
-static unsigned long get_entry_bdev(struct zram *zram)
+static unsigned long alloc_block_bdev(struct zram *zram)
 {
 	unsigned long blk_idx;
 	unsigned long ret = 0;
@@ -481,13 +476,13 @@ static unsigned long get_entry_bdev(struct zram *zram)
 	return ret;
 }
 
-static void put_entry_bdev(struct zram *zram, unsigned long entry)
+static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 {
 	int was_set;
 	unsigned long flags;
 
 	spin_lock_irqsave(&zram->bitmap_lock, flags);
-	was_set = test_and_clear_bit(entry, zram->bitmap);
+	was_set = test_and_clear_bit(blk_idx, zram->bitmap);
 	spin_unlock_irqrestore(&zram->bitmap_lock, flags);
 	WARN_ON_ONCE(!was_set);
 }
@@ -601,7 +596,7 @@ static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
 	if (!bio)
 		return -ENOMEM;
 
-	entry = get_entry_bdev(zram);
+	entry = alloc_block_bdev(zram);
 	if (!entry) {
 		bio_put(bio);
 		return -ENOSPC;
@@ -612,7 +607,7 @@ static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
 	if (!bio_add_page(bio, bvec->bv_page, bvec->bv_len,
 					bvec->bv_offset)) {
 		bio_put(bio);
-		put_entry_bdev(zram, entry);
+		free_block_bdev(zram, entry);
 		return -EIO;
 	}
 
@@ -630,18 +625,7 @@ static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
 	return 0;
 }
 
-static void zram_wb_clear(struct zram *zram, u32 index)
-{
-	unsigned long entry;
-
-	zram_clear_flag(zram, index, ZRAM_WB);
-	entry = zram_get_element(zram, index);
-	zram_set_element(zram, index, 0);
-	put_entry_bdev(zram, entry);
-}
-
 #else
-static bool zram_wb_enabled(struct zram *zram) { return false; }
 static inline void reset_bdev(struct zram *zram) {};
 static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
 					u32 index, struct bio *parent,
@@ -656,7 +640,8 @@ static int read_from_bdev(struct zram *zram, struct bio_vec *bvec,
 {
 	return -EIO;
 }
-static void zram_wb_clear(struct zram *zram, u32 index) {}
+
+static void free_block_bdev(struct zram *zram, unsigned long blk_idx) {};
 #endif
 
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
@@ -678,11 +663,6 @@ static void zram_accessed(struct zram *zram, u32 index)
 	zram->table[index].ac_time = ktime_get_boottime();
 }
 
-static void zram_reset_access(struct zram *zram, u32 index)
-{
-	zram->table[index].ac_time = 0;
-}
-
 static ssize_t read_block_state(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
@@ -763,7 +743,6 @@ static void zram_debugfs_unregister(struct zram *zram)
 static void zram_debugfs_create(void) {};
 static void zram_debugfs_destroy(void) {};
 static void zram_accessed(struct zram *zram, u32 index) {};
-static void zram_reset_access(struct zram *zram, u32 index) {};
 static void zram_debugfs_register(struct zram *zram) {};
 static void zram_debugfs_unregister(struct zram *zram) {};
 #endif
@@ -964,17 +943,18 @@ static void zram_free_page(struct zram *zram, size_t index)
 {
 	unsigned long handle;
 
-	zram_reset_access(zram, index);
-
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+	zram->table[index].ac_time = 0;
+#endif
 	if (zram_test_flag(zram, index, ZRAM_HUGE)) {
 		zram_clear_flag(zram, index, ZRAM_HUGE);
 		atomic64_dec(&zram->stats.huge_pages);
 	}
 
-	if (zram_wb_enabled(zram) && zram_test_flag(zram, index, ZRAM_WB)) {
-		zram_wb_clear(zram, index);
-		atomic64_dec(&zram->stats.pages_stored);
-		return;
+	if (zram_test_flag(zram, index, ZRAM_WB)) {
+		zram_clear_flag(zram, index, ZRAM_WB);
+		free_block_bdev(zram, zram_get_element(zram, index));
+		goto out;
 	}
 
 	/*
@@ -983,10 +963,8 @@ static void zram_free_page(struct zram *zram, size_t index)
 	 */
 	if (zram_test_flag(zram, index, ZRAM_SAME)) {
 		zram_clear_flag(zram, index, ZRAM_SAME);
-		zram_set_element(zram, index, 0);
 		atomic64_dec(&zram->stats.same_pages);
-		atomic64_dec(&zram->stats.pages_stored);
-		return;
+		goto out;
 	}
 
 	handle = zram_get_handle(zram, index);
@@ -997,10 +975,11 @@ static void zram_free_page(struct zram *zram, size_t index)
 
 	atomic64_sub(zram_get_obj_size(zram, index),
 			&zram->stats.compr_data_size);
+out:
 	atomic64_dec(&zram->stats.pages_stored);
-
 	zram_set_handle(zram, index, 0);
 	zram_set_obj_size(zram, index, 0);
+	WARN_ON_ONCE(zram->table[index].flags & ~(1UL << ZRAM_LOCK));
 }
 
 static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
@@ -1011,24 +990,20 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 	unsigned int size;
 	void *src, *dst;
 
-	if (zram_wb_enabled(zram)) {
-		zram_slot_lock(zram, index);
-		if (zram_test_flag(zram, index, ZRAM_WB)) {
-			struct bio_vec bvec;
-
-			zram_slot_unlock(zram, index);
+	zram_slot_lock(zram, index);
+	if (zram_test_flag(zram, index, ZRAM_WB)) {
+		struct bio_vec bvec;
 
-			bvec.bv_page = page;
-			bvec.bv_len = PAGE_SIZE;
-			bvec.bv_offset = 0;
-			return read_from_bdev(zram, &bvec,
-					zram_get_element(zram, index),
-					bio, partial_io);
-		}
 		zram_slot_unlock(zram, index);
+
+		bvec.bv_page = page;
+		bvec.bv_len = PAGE_SIZE;
+		bvec.bv_offset = 0;
+		return read_from_bdev(zram, &bvec,
+				zram_get_element(zram, index),
+				bio, partial_io);
 	}
 
-	zram_slot_lock(zram, index);
 	handle = zram_get_handle(zram, index);
 	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
 		unsigned long value;
@@ -1140,7 +1115,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 
 	if (unlikely(comp_len >= huge_class_size)) {
 		comp_len = PAGE_SIZE;
-		if (zram_wb_enabled(zram) && allow_wb) {
+		if (zram->backing_dev && allow_wb) {
 			zcomp_stream_put(zram->comp);
 			ret = write_to_bdev(zram, bvec, index, bio, &element);
 			if (!ret) {
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 89da501292ff..d75bf190f262 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -30,7 +30,7 @@
 
 
 /*
- * The lower ZRAM_FLAG_SHIFT bits of table.value is for
+ * The lower ZRAM_FLAG_SHIFT bits of table.flags is for
  * object size (excluding header), the higher bits is for
  * zram_pageflags.
  *
@@ -41,7 +41,7 @@
  */
 #define ZRAM_FLAG_SHIFT 24
 
-/* Flags for zram pages (table[page_no].value) */
+/* Flags for zram pages (table[page_no].flags) */
 enum zram_pageflags {
 	/* zram slot is locked */
 	ZRAM_LOCK = ZRAM_FLAG_SHIFT,
@@ -60,7 +60,7 @@ struct zram_table_entry {
 		unsigned long handle;
 		unsigned long element;
 	};
-	unsigned long value;
+	unsigned long flags;
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	ktime_t ac_time;
 #endif
@@ -105,8 +105,8 @@ struct zram {
 	 * zram is claimed so open request will be failed
 	 */
 	bool claim; /* Protected by bdev->bd_mutex */
-#ifdef CONFIG_ZRAM_WRITEBACK
 	struct file *backing_dev;
+#ifdef CONFIG_ZRAM_WRITEBACK
 	struct block_device *bdev;
 	unsigned int old_block_size;
 	unsigned long *bitmap;
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

