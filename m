Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00606C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95607223C8
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2/Qw4zg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95607223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389444AbeKPRcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:32:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34904 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389319AbeKPRcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:32:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id v9-v6so10975643pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 23:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F3cWLhZOlnQNJUEIAW5vLC0XEJ49Lspw+greXuBl+TM=;
        b=k2/Qw4zgVLwnM3Nry+X8na8voyEoUVjqkTjicWohPO6SSCMZMRNUb18rRBq1pOQhAQ
         30zZu+HxjP5FG1qeyJ8NIEMuN+xGakmgS1kf8vtjHQJFgACFBPqqWvG2KntrrzdJqE5t
         f6ASmjDjf2zT6u25aINjMt06O/Dw9I8PS6eh3maTwWd8Z4G0GydlUieMFKDRuz1j7UKm
         xp4AGegplkGBNOs0y9v9s9bfs+aP3iY21+ydOiR2pE8DnPpsgCHC/i3cDldbBg5FxE9g
         6l1ewpwe8u/cW7he95Obq8maIVGU0aRyL+qpBqT8k+ZzwrAW/Xwrulmn2jx8mESufmR2
         8aCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=F3cWLhZOlnQNJUEIAW5vLC0XEJ49Lspw+greXuBl+TM=;
        b=ITeP6TfrKg5Lq67ueVIRnPYjyai+e0W8wFm4cAZKlVrhcOaLrn6T6yg4+lwjfk8MPT
         E6RVtUTKCFmplEwxPiZAUdkOYSXjZVM/BDr2uyx3W/93Mq5uWc/Skmn8TGSv8+n0KEPc
         c9TgPoSPUWK0gSdkfzc4aBQfresC9Ss75n+L6DZdRpSyQJelJLhbqyS6+vVyk9LXFzYr
         c2im3qcO7vime/EwKUm7T8VVWGmGZ9+CWO8OWxwpFokFjrdHyAWMSff973cLGyq5V8Z7
         LUxo/O7jyQyQ+fwUfO8/OlI331phRfejOoyH8kjpYsXQqpf1lMBNEPVlnNsbxWFRvtXR
         FTdA==
X-Gm-Message-State: AGRZ1gJnlRZQ6KLrB6kVc9fIcAOD6hoVxlVVfTL5p5UfqGlsDI8lSYoC
        R9LCVFZC/NCg6csUF10giqE=
X-Google-Smtp-Source: AJdET5eE7cU/AoB3GCPJ3Ei/juve6bJ3ydyIJxawSbxLmh4LQ7YlI647DzzhayOcMvczPgpEj33Wdw==
X-Received: by 2002:a63:990a:: with SMTP id d10mr8910719pge.279.1542352853384;
        Thu, 15 Nov 2018 23:20:53 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:7630:de9:f6f2:276f])
        by smtp.gmail.com with ESMTPSA id e9sm13974637pff.5.2018.11.15.23.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 23:20:52 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 4/6] zram: support idle page writeback
Date:   Fri, 16 Nov 2018 16:20:33 +0900
Message-Id: <20181116072035.155108-5-minchan@kernel.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181116072035.155108-1-minchan@kernel.org>
References: <20181116072035.155108-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports new feature "zram idle page writeback".
On zram-swap usecase, zram has usually idle swap pages come
from many processes. It's pointless to keep in memory(ie, zram).

To solve the problem, this feature gives idle page writeback to
backing device so the goal is to save more memory space
on embedded system.

Normal sequence to use the feature is as follows,

while (1) {
        # mark allocated zram slot to idle
        echo 1 > /sys/block/zram0/idle
        sleep several hours
        # idle zram slots are still IDLE marked.
        echo 3 > /sys/block/zram0/writeback
        # write the IDLE marked slot into backing device and free
        # the memory.
}

echo 'val' > /sys/block/zramX/writeback

val is combination of bits.

0th bit: hugepage writeback
1th bit: idlepage writeback

Thus,
1 -> hugepage writeback
2 -> idlepage writeabck
3 -> writeback both pages

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/ABI/testing/sysfs-block-zram |   7 +
 Documentation/blockdev/zram.txt            |  19 +++
 drivers/block/zram/Kconfig                 |   5 +-
 drivers/block/zram/zram_drv.c              | 166 +++++++++++++++++++--
 drivers/block/zram/zram_drv.h              |   1 +
 5 files changed, 187 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index 04c9a5980bc7..d1f80b077885 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -106,3 +106,10 @@ Contact:	Minchan Kim <minchan@kernel.org>
 		idle file is write-only and mark zram slot as idle.
 		If system has mounted debugfs, user can see which slots
 		are idle via /sys/kernel/debug/zram/zram<id>/block_state
+
+What:		/sys/block/zram<id>/writeback
+Date:		November 2018
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		The writeback file is write-only and trigger idle and/or
+		huge page writeback to backing device.
diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
index f3bcd716d8a9..60b585dab6e0 100644
--- a/Documentation/blockdev/zram.txt
+++ b/Documentation/blockdev/zram.txt
@@ -244,6 +244,25 @@ to backing storage rather than keeping it in memory.
 User should set up backing device via /sys/block/zramX/backing_dev
 before disksize setting.
 
+User can writeback idle pages to backing device. To use the feature,
+first, user need to mark zram slots allocated currently as idle.
+Afterward, slots not accessed since then will have still idle mark.
+Then, if user does,
+	"echo val > /sys/block/zramX/writeback"
+
+  val is combination of bits.
+
+  0th bit: hugepage writeback
+  1th bit: idlepage writeback
+
+  Thus,
+  1 -> hugepage writeback
+  2 -> idlepage writeabck
+  3 -> writeback both pages
+
+zram will writeback the idle/huge pages to backing device and free the
+memory space pages occupied so save memory.
+
 = memory tracking
 
 With CONFIG_ZRAM_MEMORY_TRACKING, user can know information of the
diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index fcd055457364..1ffc64770643 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -15,7 +15,7 @@ config ZRAM
 	  See Documentation/blockdev/zram.txt for more information.
 
 config ZRAM_WRITEBACK
-       bool "Write back incompressible page to backing device"
+       bool "Write back incompressible or idle page to backing device"
        depends on ZRAM
        help
 	 With incompressible page, there is no memory saving to keep it
@@ -23,6 +23,9 @@ config ZRAM_WRITEBACK
 	 For this feature, admin should set up backing device via
 	 /sys/block/zramX/backing_dev.
 
+	 With /sys/block/zramX/{idle,writeback}, application could ask
+	 idle page's writeback to the backing device to save in memory.
+
 	 See Documentation/blockdev/zram.txt for more information.
 
 config ZRAM_MEMORY_TRACKING
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f956179076ce..b7b5c9e5f0cd 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -52,6 +52,9 @@ static unsigned int num_devices = 1;
 static size_t huge_class_size;
 
 static void zram_free_page(struct zram *zram, size_t index);
+static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
+				u32 index, int offset, struct bio *bio);
+
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
@@ -73,13 +76,6 @@ static inline bool init_done(struct zram *zram)
 	return zram->disksize;
 }
 
-static inline bool zram_allocated(struct zram *zram, u32 index)
-{
-
-	return (zram->table[index].flags >> (ZRAM_FLAG_SHIFT + 1)) ||
-					zram->table[index].handle;
-}
-
 static inline struct zram *dev_to_zram(struct device *dev)
 {
 	return (struct zram *)dev_to_disk(dev)->private_data;
@@ -138,6 +134,13 @@ static void zram_set_obj_size(struct zram *zram,
 	zram->table[index].flags = (flags << ZRAM_FLAG_SHIFT) | size;
 }
 
+static inline bool zram_allocated(struct zram *zram, u32 index)
+{
+	return zram_get_obj_size(zram, index) ||
+			zram_test_flag(zram, index, ZRAM_SAME) ||
+			zram_test_flag(zram, index, ZRAM_WB);
+}
+
 #if PAGE_SIZE != 4096
 static inline bool is_partial_io(struct bio_vec *bvec)
 {
@@ -295,10 +298,14 @@ static ssize_t idle_store(struct device *dev,
 	}
 
 	for (index = 0; index < nr_pages; index++) {
+		/*
+		 * Do not mark ZRAM_UNDER_WB slot as ZRAM_IDLE to close race.
+		 * See the comment in writeback_store.
+		 */
 		zram_slot_lock(zram, index);
-		if (!zram_allocated(zram, index))
+		if (!zram_allocated(zram, index) ||
+				zram_test_flag(zram, index, ZRAM_UNDER_WB))
 			goto next;
-
 		zram_set_flag(zram, index, ZRAM_IDLE);
 next:
 		zram_slot_unlock(zram, index);
@@ -553,6 +560,142 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 	return 1;
 }
 
+static ssize_t writeback_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	int index;
+	struct bio bio;
+	struct bio_vec bio_vec;
+	struct page *page;
+	ssize_t ret;
+	unsigned long mode;
+	unsigned long blk_idx = 0;
+
+#define HUGE_WRITEBACK 0x1
+#define IDLE_WRITEBACK 0x2
+
+	ret = kstrtoul(buf, 10, &mode);
+	if (ret)
+		return ret;
+
+	if (!(mode & (HUGE_WRITEBACK|IDLE_WRITEBACK)))
+		return -EINVAL;
+
+	down_read(&zram->init_lock);
+	if (!init_done(zram)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!zram->backing_dev) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (index = 0; index < nr_pages; index++) {
+		struct bio_vec bvec;
+
+		bvec.bv_page = page;
+		bvec.bv_len = PAGE_SIZE;
+		bvec.bv_offset = 0;
+
+		if (!blk_idx) {
+			blk_idx = alloc_block_bdev(zram);
+			if (!blk_idx) {
+				ret = -ENOSPC;
+				break;
+			}
+		}
+
+		zram_slot_lock(zram, index);
+		if (!zram_allocated(zram, index))
+			goto next;
+
+		if (zram_test_flag(zram, index, ZRAM_WB) ||
+				zram_test_flag(zram, index, ZRAM_SAME) ||
+				zram_test_flag(zram, index, ZRAM_UNDER_WB))
+			goto next;
+
+		if ((mode & IDLE_WRITEBACK &&
+			  !zram_test_flag(zram, index, ZRAM_IDLE)) &&
+		    (mode & HUGE_WRITEBACK &&
+			  !zram_test_flag(zram, index, ZRAM_HUGE)))
+			goto next;
+		/*
+		 * Clearing ZRAM_UNDER_WB is duty of caller.
+		 * IOW, zram_free_page never clear it.
+		 */
+		zram_set_flag(zram, index, ZRAM_UNDER_WB);
+		zram_slot_unlock(zram, index);
+		if (zram_bvec_read(zram, &bvec, index, 0, NULL)) {
+			zram_slot_lock(zram, index);
+			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
+			zram_slot_unlock(zram, index);
+			continue;
+		}
+
+		bio_init(&bio, &bio_vec, 1);
+		bio_set_dev(&bio, zram->bdev);
+		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
+		bio.bi_opf = REQ_OP_WRITE | REQ_SYNC;
+
+		bio_add_page(&bio, bvec.bv_page, bvec.bv_len,
+				bvec.bv_offset);
+		/*
+		 * XXX: A single page IO would be inefficient for write
+		 * but it would be not bad as starter.
+		 */
+		ret = submit_bio_wait(&bio);
+		if (ret) {
+			zram_slot_lock(zram, index);
+			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
+			zram_slot_unlock(zram, index);
+			continue;
+		}
+
+		/*
+		 * We released zram_slot_lock so need to check if the slot was
+		 * changed. If there is freeing for the slot, we can catch it
+		 * easily by zram_allocated.
+		 * A subtle case is the slot is freed/reallocated/marked as
+		 * ZRAM_IDLE again. To close the race, idle_store doesn't
+		 * mark ZRAM_IDLE once it found the slot was ZRAM_UNDER_WB.
+		 * Thus, we could close the race by checking ZRAM_IDLE bit.
+		 */
+		zram_slot_lock(zram, index);
+		if (!zram_allocated(zram, index) ||
+			  !zram_test_flag(zram, index, ZRAM_IDLE)) {
+			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
+			goto next;
+		}
+
+		zram_free_page(zram, index);
+		zram_clear_flag(zram, index, ZRAM_UNDER_WB);
+		zram_set_flag(zram, index, ZRAM_WB);
+		zram_set_element(zram, index, blk_idx);
+		blk_idx = 0;
+		atomic64_inc(&zram->stats.pages_stored);
+next:
+		zram_slot_unlock(zram, index);
+	}
+	if (blk_idx)
+		free_block_bdev(zram, blk_idx);
+	ret = len;
+	__free_page(page);
+out:
+	up_read(&zram->init_lock);
+
+	return ret;
+}
+
 struct zram_work {
 	struct work_struct work;
 	struct zram *zram;
@@ -1013,7 +1156,8 @@ static void zram_free_page(struct zram *zram, size_t index)
 	atomic64_dec(&zram->stats.pages_stored);
 	zram_set_handle(zram, index, 0);
 	zram_set_obj_size(zram, index, 0);
-	WARN_ON_ONCE(zram->table[index].flags & ~(1UL << ZRAM_LOCK));
+	WARN_ON_ONCE(zram->table[index].flags &
+		~(1UL << ZRAM_LOCK | 1UL << ZRAM_UNDER_WB));
 }
 
 static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
@@ -1650,6 +1794,7 @@ static DEVICE_ATTR_RW(max_comp_streams);
 static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
 static DEVICE_ATTR_RW(backing_dev);
+static DEVICE_ATTR_WO(writeback);
 #endif
 
 static struct attribute *zram_disk_attrs[] = {
@@ -1664,6 +1809,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_comp_algorithm.attr,
 #ifdef CONFIG_ZRAM_WRITEBACK
 	&dev_attr_backing_dev.attr,
+	&dev_attr_writeback.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 214fa4bb46b9..07695fe70e17 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -47,6 +47,7 @@ enum zram_pageflags {
 	ZRAM_LOCK = ZRAM_FLAG_SHIFT,
 	ZRAM_SAME,	/* Page consists the same element */
 	ZRAM_WB,	/* page is stored on backing_device */
+	ZRAM_UNDER_WB,	/* page is under writeback */
 	ZRAM_HUGE,	/* Incompressible page */
 	ZRAM_IDLE,	/* not accessed page since last idle marking */
 
-- 
2.19.1.1215.g8438c0b245-goog

