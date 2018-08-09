Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9680CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8242238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ajt9eHyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8242238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeHIUcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:32:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37317 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeHIUcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:32:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so3111652pgq.4;
        Thu, 09 Aug 2018 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zw+Oaw/Tl2oNtEEEP6XycO0L6Z2wH1XyyckuMiebc7A=;
        b=Ajt9eHyvhCtHlMp9/wqCgdpmQ1ildhiCibU8l439eFS+komvQRYTz1cNy+lsoC6Bhh
         xHEU15Mx506NO07WAIVR7o6sXHXnvRw7gxo1gE6Ys5BbWlyQ/DQgpejwmHe/4XSdvUVE
         Lgu0X4QunuddHyc1H/wnnvFQF8w4vF/PbZlfM2wILvXbodmiKnbRqgSBV5mxDfpPWhkx
         GiUm5AV54ILxwpO2JzlIKQvJLSe/MVLTxJxjaarhK0NlpL1O6RBPmnd9lBpcHXK1KM8T
         P6lJBt+ee3Q+NgdHwdQOQNY988cV6Nh7BBqGdK6oHkDv0spfKAsRJcNNMpg7fEIwXGgx
         Eq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=zw+Oaw/Tl2oNtEEEP6XycO0L6Z2wH1XyyckuMiebc7A=;
        b=Pmp7HpGNEGv9E6hOI84kxRaNYY59AXq+g1E7V/qseyAxh48drVp8oHE5EXlxpEOobZ
         zARmUL/HO2c+cDPvrS0wAvjXIHRf/8qloRHEgo2B31XvM/C3qRCva1fN2HyBCO3aAZeR
         95qkgPrffxrlgAROKn9DdsQ9v8BDxCGpoDBOUxUqSSmx2TolMAYD69XAL9pvoxLw8QPV
         4scO7b/FCjuwAIrmKwOfUyXG5T6Tj6Gav9SiLx0EAtGvk9tf0J92O/ewQv3JOjiVjyAd
         +UHmQYELQ1zmJ8qyMGt/HjNDUihDdeScMACVdMdNja6GCui8zPD/3FHreZh6fvLJuapq
         jFbg==
X-Gm-Message-State: AOUpUlHVzf6erHZH+ni+I2Qza6zjti4oT7IaZ1lcJR8TaCvNRRWPlODM
        aFtWIiyGDQZMsooBg2Qs9pU=
X-Google-Smtp-Source: AA+uWPx109VKCWOn2yfdWuD85NYGOAFWe2LDBbeTm+4kbVhz9NCTZoGU6OmPTHgwukJsSUvkct7Oxw==
X-Received: by 2002:a63:8c0b:: with SMTP id m11-v6mr3138084pgd.372.1533837975469;
        Thu, 09 Aug 2018 11:06:15 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id f90-v6sm12943493pfh.168.2018.08.09.11.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:06:14 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 11/17] btrfs: introduce submit buffer
Date:   Fri, 10 Aug 2018 03:04:44 +0900
Message-Id: <20180809180450.5091-12-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sequential allocation is not enough to maintain sequential delivery of
write IOs to the device. Various features (async compress, async checksum,
...) of btrfs affect ordering of the IOs. This patch introduce submit
buffer to sort WRITE bios belonging to a block group and sort them out
sequentially in increasing block address to achieve sequential write
sequences with submit_stripe_bio().

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 fs/btrfs/ctree.h       |   3 +
 fs/btrfs/extent-tree.c |   5 ++
 fs/btrfs/volumes.c     | 121 +++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.h     |   3 +
 4 files changed, 128 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5060bcdcb72b..ebbbf46aa540 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -696,6 +696,9 @@ struct btrfs_block_group_cache {
 	 */
 	enum btrfs_alloc_type alloc_type;
 	u64 alloc_offset;
+	spinlock_t submit_lock;
+	u64 submit_offset;
+	struct list_head submit_buffer;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d4355b9b494e..6b7b632b0791 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -105,6 +105,7 @@ void btrfs_put_block_group(struct btrfs_block_group_cache *cache)
 	if (atomic_dec_and_test(&cache->count)) {
 		WARN_ON(cache->pinned > 0);
 		WARN_ON(cache->reserved > 0);
+		WARN_ON(!list_empty(&cache->submit_buffer));
 
 		/*
 		 * If not empty, someone is still holding mutex of
@@ -10059,6 +10060,8 @@ btrfs_get_block_group_alloc_offset(struct btrfs_block_group_cache *cache)
 		goto out;
 	}
 
+	cache->submit_offset = logical + cache->alloc_offset;
+
 out:
 	cache->alloc_type = alloc_type;
 	kfree(alloc_offsets);
@@ -10095,6 +10098,7 @@ btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
 
 	atomic_set(&cache->count, 1);
 	spin_lock_init(&cache->lock);
+	spin_lock_init(&cache->submit_lock);
 	init_rwsem(&cache->data_rwsem);
 	INIT_LIST_HEAD(&cache->list);
 	INIT_LIST_HEAD(&cache->cluster_list);
@@ -10102,6 +10106,7 @@ btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&cache->ro_list);
 	INIT_LIST_HEAD(&cache->dirty_list);
 	INIT_LIST_HEAD(&cache->io_list);
+	INIT_LIST_HEAD(&cache->submit_buffer);
 	btrfs_init_free_space_ctl(cache);
 	atomic_set(&cache->trimming, 0);
 	mutex_init(&cache->free_space_lock);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 08d13da2553f..ca03b7136892 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -513,6 +513,8 @@ static noinline void run_scheduled_bios(struct btrfs_device *device)
 	spin_unlock(&device->io_lock);
 
 	while (pending) {
+		struct btrfs_bio *bbio;
+		struct completion *sent = NULL;
 
 		rmb();
 		/* we want to work on both lists, but do more bios on the
@@ -550,7 +552,12 @@ static noinline void run_scheduled_bios(struct btrfs_device *device)
 			sync_pending = 0;
 		}
 
+		bbio = cur->bi_private;
+		if (bbio)
+			sent = bbio->sent;
 		btrfsic_submit_bio(cur);
+		if (sent)
+			complete(sent);
 		num_run++;
 		batch_run++;
 
@@ -5542,6 +5549,7 @@ static struct btrfs_bio *alloc_btrfs_bio(int total_stripes, int real_stripes)
 
 	atomic_set(&bbio->error, 0);
 	refcount_set(&bbio->refs, 1);
+	INIT_LIST_HEAD(&bbio->list);
 
 	return bbio;
 }
@@ -6351,7 +6359,7 @@ static void btrfs_end_bio(struct bio *bio)
  * the work struct is scheduled.
  */
 static noinline void btrfs_schedule_bio(struct btrfs_device *device,
-					struct bio *bio)
+					struct bio *bio, int need_seqwrite)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	int should_queue = 1;
@@ -6365,7 +6373,12 @@ static noinline void btrfs_schedule_bio(struct btrfs_device *device,
 
 	/* don't bother with additional async steps for reads, right now */
 	if (bio_op(bio) == REQ_OP_READ) {
+		struct btrfs_bio *bbio = bio->bi_private;
+		struct completion *sent = bbio->sent;
+
 		btrfsic_submit_bio(bio);
+		if (sent)
+			complete(sent);
 		return;
 	}
 
@@ -6373,7 +6386,7 @@ static noinline void btrfs_schedule_bio(struct btrfs_device *device,
 	bio->bi_next = NULL;
 
 	spin_lock(&device->io_lock);
-	if (op_is_sync(bio->bi_opf))
+	if (op_is_sync(bio->bi_opf) && need_seqwrite == 0)
 		pending_bios = &device->pending_sync_bios;
 	else
 		pending_bios = &device->pending_bios;
@@ -6412,8 +6425,21 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 
 	btrfs_bio_counter_inc_noblocked(fs_info);
 
+	/* queue all bios into scheduler if sequential write is required */
+	if (bbio->need_seqwrite) {
+		if (!async) {
+			DECLARE_COMPLETION_ONSTACK(sent);
+
+			bbio->sent = &sent;
+			btrfs_schedule_bio(dev, bio, bbio->need_seqwrite);
+			wait_for_completion_io(&sent);
+		} else {
+			btrfs_schedule_bio(dev, bio, bbio->need_seqwrite);
+		}
+		return;
+	}
 	if (async)
-		btrfs_schedule_bio(dev, bio);
+		btrfs_schedule_bio(dev, bio, bbio->need_seqwrite);
 	else
 		btrfsic_submit_bio(bio);
 }
@@ -6465,6 +6491,90 @@ static void __btrfs_map_bio(struct btrfs_fs_info *fs_info, u64 logical,
 	btrfs_bio_counter_dec(fs_info);
 }
 
+static void __btrfs_map_bio_zoned(struct btrfs_fs_info *fs_info, u64 logical,
+		struct btrfs_bio *bbio, int async_submit)
+{
+	u64 length = bbio->orig_bio->bi_iter.bi_size;
+	struct btrfs_block_group_cache *cache = NULL;
+	int sent;
+	LIST_HEAD(submit_list);
+
+	WARN_ON(bio_op(bbio->orig_bio) != REQ_OP_WRITE);
+
+	cache = btrfs_lookup_block_group(fs_info, logical);
+	if (!cache || cache->alloc_type != BTRFS_ALLOC_SEQ) {
+		if (cache)
+			btrfs_put_block_group(cache);
+		__btrfs_map_bio(fs_info, logical, bbio, async_submit);
+		return;
+	}
+
+	bbio->need_seqwrite = 1;
+
+	spin_lock(&cache->submit_lock);
+	if (cache->submit_offset == logical)
+		goto send_bios;
+
+	if (cache->submit_offset > logical) {
+		btrfs_info(fs_info, "sending unaligned bio... %llu+%llu %llu\n",
+			logical, length, cache->submit_offset);
+		spin_unlock(&cache->submit_lock);
+		WARN_ON(1);
+		btrfs_put_block_group(cache);
+		__btrfs_map_bio(fs_info, logical, bbio, async_submit);
+		return;
+	}
+
+	/* buffer the unaligned bio */
+	list_add_tail(&bbio->list, &cache->submit_buffer);
+	spin_unlock(&cache->submit_lock);
+	btrfs_put_block_group(cache);
+
+	return;
+
+send_bios:
+	spin_unlock(&cache->submit_lock);
+	/* send this bio */
+	__btrfs_map_bio(fs_info, logical, bbio, 1);
+
+loop:
+	/* and send previously buffered following bios */
+	spin_lock(&cache->submit_lock);
+	cache->submit_offset += length;
+	length = 0;
+	INIT_LIST_HEAD(&submit_list);
+
+	/* collect sequential bios into submit_list */
+	do {
+		struct btrfs_bio *next;
+
+		sent = 0;
+		list_for_each_entry_safe(bbio, next,
+					 &cache->submit_buffer, list) {
+			struct bio *orig_bio = bbio->orig_bio;
+			u64 logical = (u64)orig_bio->bi_iter.bi_sector << 9;
+
+			if (logical == cache->submit_offset + length) {
+				sent = 1;
+				length += orig_bio->bi_iter.bi_size;
+				list_move_tail(&bbio->list, &submit_list);
+			}
+		}
+	} while (sent);
+	spin_unlock(&cache->submit_lock);
+
+	/* send the collected bios */
+	list_for_each_entry(bbio, &submit_list, list) {
+		__btrfs_map_bio(bbio->fs_info,
+				(u64)bbio->orig_bio->bi_iter.bi_sector << 9,
+				bbio, 1);
+	}
+
+	if (length)
+		goto loop;
+	btrfs_put_block_group(cache);
+}
+
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num, int async_submit)
 {
@@ -6515,7 +6625,10 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		BUG();
 	}
 
-	__btrfs_map_bio(fs_info, logical, bbio, async_submit);
+	if (btrfs_fs_incompat(fs_info, HMZONED) && bio_op(bio) == REQ_OP_WRITE)
+		__btrfs_map_bio_zoned(fs_info, logical, bbio, async_submit);
+	else
+		__btrfs_map_bio(fs_info, logical, bbio, async_submit);
 	return BLK_STS_OK;
 }
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 58053d2e24aa..3db90f5395cd 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -317,6 +317,9 @@ struct btrfs_bio {
 	int mirror_num;
 	int num_tgtdevs;
 	int *tgtdev_map;
+	int need_seqwrite;
+	struct list_head list;
+	struct completion *sent;
 	/*
 	 * logical block numbers for the start of each stripe
 	 * The last one or two are p/q.  These are sorted,
-- 
2.18.0

