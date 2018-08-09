Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB2DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2A321F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j//YYSy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2A321F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeHIUcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:32:11 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34392 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbeHIUcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:32:09 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so2883315plo.1;
        Thu, 09 Aug 2018 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kFQ8CVg+jQXVFN/XTX6jSyz9wX2VnSTn+Xrbjcgf3ec=;
        b=j//YYSy56m+bbKnBz9j6FgDaeAONG2OaouM62P4GStoYrwjqrR8gnnG1eIyXgXhTmH
         R8NcOwxDI4+Qk4S7uojISpS9rfI0GbsFaHS2NNEM8zUqyVLGCF/ZpDcl8Wc/yTvr2y19
         a8ie6eOkQ8YwTwl1mCT8d4smFtuIfHcb061YTtgxXo22pi2YKWe1cdF3/68CzPBHDXrx
         P74wlxNlrWeyw1vzouRIDONcE3ZH3YRc4xGrg7TCE7AsbCxyADWq7EwfJS2DKJQU1mEh
         /sJBgRjEN4uC1O6y2ZbHPduA9wjQd+h/BsiR/0rTXFlAQU/4Z9AfXv/QMu0r/73Zd1yA
         I1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=kFQ8CVg+jQXVFN/XTX6jSyz9wX2VnSTn+Xrbjcgf3ec=;
        b=hpAhkIXGadQg5nzgK//mpelqZ50yEax2bfqSRTa0uMLOqfwu3xc84AVmpdw/J/De2I
         KGrLeW0BSEBau9RKOFfbmdTMpafR+7a70yUwNy85wecRdir6uiM4cvUwV1bmF09cqCyO
         K01d3ducmmPgAEN3eX47wZjj+tIRPNl2PWNPY1jrgWO/rLICQG45TRbsl9NleBsB1omg
         4vRv9ubnWzjhIK0OOj4GZpg9+2kuP0SsXl0uz5/1lRF1ov15Nl7O4LmK9HEshBj+Vfib
         5bFr1GNTE/Wacm4SKrQc8VFUKVPH3BZ19NERRSvg8WXNgMxdZh7t6S0Upeqds6ti0n2Z
         B+ew==
X-Gm-Message-State: AOUpUlHhAoLyC4au3BHDbEXL0qyL6x+6y5PAhMW0b75gEr1FXy3bGeEd
        6JAWS7bO+UnqLVSiEDomzZY=
X-Google-Smtp-Source: AA+uWPwIlzcvMjHYDkfc/80HMQWRd7D8jn/CeAlT7bH/XUNO6INsSK4yy/+rtLSaUuesn/lSNaG81g==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4-v6mr3022703pls.84.1533837970486;
        Thu, 09 Aug 2018 11:06:10 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id f186-v6sm9495549pgc.4.2018.08.09.11.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:06:09 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 09/17] btrfs: do sequential allocation on HMZONED drives
Date:   Fri, 10 Aug 2018 03:04:42 +0900
Message-Id: <20180809180450.5091-10-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On HMZONED drives, writes must always be sequential and directed at a block
group zone write pointer position. Thus, block allocation in a block group
must also be done sequentially using an allocation pointer equal to the
block group zone write pointer plus the number of blocks allocated but not
yet written.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 fs/btrfs/ctree.h            |  22 ++++
 fs/btrfs/extent-tree.c      | 231 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.c |  36 ++++++
 fs/btrfs/free-space-cache.h |  10 ++
 4 files changed, 299 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 14f880126532..5060bcdcb72b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -562,6 +562,20 @@ struct btrfs_full_stripe_locks_tree {
 	struct mutex lock;
 };
 
+/* Block group allocation types */
+enum btrfs_alloc_type {
+
+	/* Regular first fit allocation */
+	BTRFS_ALLOC_FIT		= 0,
+
+	/*
+	 * Sequential allocation: this is for HMZONED mode and
+	 * will result in ignoring free space before a block
+	 * group allocation offset.
+	 */
+	BTRFS_ALLOC_SEQ		= 1,
+};
+
 struct btrfs_block_group_cache {
 	struct btrfs_key key;
 	struct btrfs_block_group_item item;
@@ -674,6 +688,14 @@ struct btrfs_block_group_cache {
 
 	/* Record locked full stripes for RAID5/6 block group */
 	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
+
+	/*
+	 * Allocation offset for the block group to implement sequential
+	 * allocation. This is used only with HMZONED mode enabled and if
+	 * the block group resides on a sequential zone.
+	 */
+	enum btrfs_alloc_type alloc_type;
+	u64 alloc_offset;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fc3daf0e5b92..d4355b9b494e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -7412,6 +7412,15 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		}
 
 have_block_group:
+		if (block_group->alloc_type == BTRFS_ALLOC_SEQ) {
+			offset = btrfs_find_space_for_alloc_seq(block_group,
+								num_bytes,
+								&max_extent_size);
+			if (!offset)
+				goto loop;
+			goto checks;
+		}
+
 		cached = block_group_cache_done(block_group);
 		if (unlikely(!cached)) {
 			have_caching_bg = true;
@@ -9847,11 +9856,223 @@ static void link_block_group(struct btrfs_block_group_cache *cache)
 	}
 }
 
+static int
+btrfs_get_block_group_alloc_offset(struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct extent_map_tree *em_tree = &fs_info->mapping_tree.map_tree;
+	struct extent_map *em;
+	struct map_lookup *map;
+	struct btrfs_device *device;
+	u64 logical = cache->key.objectid;
+	u64 length = cache->key.offset;
+	u64 physical = 0;
+	int ret, alloc_type;
+	int i, j;
+	u64 *alloc_offsets = NULL;
+
+#define WP_MISSING_DEV ((u64)-1)
+
+	/* Sanity check */
+	if (!IS_ALIGNED(length, fs_info->zone_size)) {
+		btrfs_err(fs_info, "unaligned block group at %llu + %llu",
+			  logical, length);
+		return -EIO;
+	}
+
+	/* Get the chunk mapping */
+	em_tree = &fs_info->mapping_tree.map_tree;
+	read_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, logical, length);
+	read_unlock(&em_tree->lock);
+
+	if (!em)
+		return -EINVAL;
+
+	map = em->map_lookup;
+
+	/*
+	 * Get the zone type: if the group is mapped to a non-sequential zone,
+	 * there is no need for the allocation offset (fit allocation is OK).
+	 */
+	alloc_type = -1;
+	alloc_offsets = kcalloc(map->num_stripes, sizeof(*alloc_offsets),
+				GFP_NOFS);
+	if (!alloc_offsets) {
+		free_extent_map(em);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < map->num_stripes; i++) {
+		int is_sequential;
+		struct blk_zone zone;
+
+		device = map->stripes[i].dev;
+		physical = map->stripes[i].physical;
+
+		if (device->bdev == NULL) {
+			alloc_offsets[i] = WP_MISSING_DEV;
+			continue;
+		}
+
+		is_sequential = btrfs_dev_is_sequential(device, physical);
+		if (alloc_type == -1)
+			alloc_type = is_sequential ?
+					BTRFS_ALLOC_SEQ : BTRFS_ALLOC_FIT;
+
+		if ((is_sequential && alloc_type != BTRFS_ALLOC_SEQ) ||
+		    (!is_sequential && alloc_type == BTRFS_ALLOC_SEQ)) {
+			btrfs_err(fs_info, "found block group of mixed zone types");
+			ret = -EIO;
+			goto out;
+		}
+
+		if (!is_sequential)
+			continue;
+
+		/* this zone will be used for allocation, so mark this
+		 * zone non-empty
+		 */
+		clear_bit(physical >> device->zone_size_shift,
+			  device->empty_zones);
+
+		/*
+		 * The group is mapped to a sequential zone. Get the zone write
+		 * pointer to determine the allocation offset within the zone.
+		 */
+		WARN_ON(!IS_ALIGNED(physical, fs_info->zone_size));
+		ret = btrfs_get_dev_zone(device, physical, &zone, GFP_NOFS);
+		if (ret == -EIO || ret == -EOPNOTSUPP) {
+			ret = 0;
+			alloc_offsets[i] = WP_MISSING_DEV;
+			continue;
+		} else if (ret) {
+			goto out;
+		}
+
+
+		switch (zone.cond) {
+		case BLK_ZONE_COND_OFFLINE:
+		case BLK_ZONE_COND_READONLY:
+			btrfs_err(fs_info, "Offline/readonly zone %llu",
+				  physical >> device->zone_size_shift);
+			alloc_offsets[i] = WP_MISSING_DEV;
+			break;
+		case BLK_ZONE_COND_EMPTY:
+			alloc_offsets[i] = 0;
+			break;
+		case BLK_ZONE_COND_FULL:
+			alloc_offsets[i] = fs_info->zone_size;
+			break;
+		default:
+			/* Partially used zone */
+			alloc_offsets[i] = ((zone.wp - zone.start) << 9);
+			break;
+		}
+	}
+
+	if (alloc_type == BTRFS_ALLOC_FIT)
+		goto out;
+
+	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+	case 0: /* single */
+	case BTRFS_BLOCK_GROUP_DUP:
+	case BTRFS_BLOCK_GROUP_RAID1:
+		cache->alloc_offset = WP_MISSING_DEV;
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV)
+				continue;
+			if (cache->alloc_offset == WP_MISSING_DEV)
+				cache->alloc_offset = alloc_offsets[i];
+			if (alloc_offsets[i] != cache->alloc_offset) {
+				btrfs_err(fs_info, "zones' write pointer mismatch");
+				ret = -EIO;
+				goto out;
+			}
+		}
+		break;
+	case BTRFS_BLOCK_GROUP_RAID0:
+		cache->alloc_offset = 0;
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV) {
+				btrfs_err(fs_info, "cannot recover Write pointer");
+				ret = -EIO;
+				goto out;
+			}
+			cache->alloc_offset += alloc_offsets[i];
+			if (alloc_offsets[0] < alloc_offsets[i]) {
+				btrfs_err(fs_info, "zones' write pointer mismatch");
+				ret = -EIO;
+				goto out;
+			}
+		}
+		break;
+	case BTRFS_BLOCK_GROUP_RAID10:
+		/*
+		 * Pass1: check write pointer of RAID1 level: each pointer
+		 * should be equal
+		 */
+		for (i = 0; i < map->num_stripes / map->sub_stripes; i++) {
+			int base = i*map->sub_stripes;
+			u64 offset = WP_MISSING_DEV;
+
+			for (j = 0; j < map->sub_stripes; j++) {
+				if (alloc_offsets[base+j] == WP_MISSING_DEV)
+					continue;
+				if (offset == WP_MISSING_DEV)
+					offset = alloc_offsets[base+j];
+				if (alloc_offsets[base+j] != offset) {
+					btrfs_err(fs_info, "zones' write pointer mismatch");
+					ret = -EIO;
+					goto out;
+				}
+			}
+			for (j = 0; j < map->sub_stripes; j++)
+				alloc_offsets[base+j] = offset;
+		}
+
+		/* Pass2: check write pointer of RAID1 level */
+		cache->alloc_offset = 0;
+		for (i = 0; i < map->num_stripes / map->sub_stripes; i++) {
+			int base = i*map->sub_stripes;
+
+			if (alloc_offsets[base] == WP_MISSING_DEV) {
+				btrfs_err(fs_info, "cannot recover Write pointer");
+				ret = -EIO;
+				goto out;
+			}
+			if (alloc_offsets[0] < alloc_offsets[base]) {
+				btrfs_err(fs_info, "zones' write pointer mismatch");
+				ret = -EIO;
+				goto out;
+			}
+			cache->alloc_offset += alloc_offsets[base];
+		}
+		break;
+	case BTRFS_BLOCK_GROUP_RAID5:
+	case BTRFS_BLOCK_GROUP_RAID6:
+		/* RAID5/6 is not supported yet */
+	default:
+		btrfs_err(fs_info, "Unsupported profile %llu",
+			map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	cache->alloc_type = alloc_type;
+	kfree(alloc_offsets);
+	free_extent_map(em);
+
+	return ret;
+}
+
 static struct btrfs_block_group_cache *
 btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
 			       u64 start, u64 size)
 {
 	struct btrfs_block_group_cache *cache;
+	int ret;
 
 	cache = kzalloc(sizeof(*cache), GFP_NOFS);
 	if (!cache)
@@ -9885,6 +10106,16 @@ btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
 	atomic_set(&cache->trimming, 0);
 	mutex_init(&cache->free_space_lock);
 	btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root);
+	cache->alloc_type = BTRFS_ALLOC_FIT;
+	cache->alloc_offset = 0;
+
+	if (btrfs_fs_incompat(fs_info, HMZONED)) {
+		ret = btrfs_get_block_group_alloc_offset(cache);
+		if (ret) {
+			kfree(cache);
+			return NULL;
+		}
+	}
 
 	return cache;
 }
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index c3888c113d81..b3ff9809d1e4 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2582,6 +2582,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 	u64 align_gap = 0;
 	u64 align_gap_len = 0;
 
+	WARN_ON(block_group->alloc_type == BTRFS_ALLOC_SEQ);
+
 	spin_lock(&ctl->tree_lock);
 	entry = find_free_space(ctl, &offset, &bytes_search,
 				block_group->full_stripe_len, max_extent_size);
@@ -2616,6 +2618,38 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 	return ret;
 }
 
+/*
+ * Simple allocator for sequential only block group. It only allows sequential
+ * allocation. No need to play with trees.
+ */
+
+u64 btrfs_find_space_for_alloc_seq(struct btrfs_block_group_cache *block_group,
+				   u64 bytes, u64 *max_extent_size)
+{
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	u64 start = block_group->key.objectid;
+	u64 avail;
+	u64 ret = 0;
+
+	/* Sanity check */
+	if (block_group->alloc_type != BTRFS_ALLOC_SEQ)
+		return 0;
+
+	spin_lock(&ctl->tree_lock);
+	avail = block_group->key.offset - block_group->alloc_offset;
+	if (avail < bytes) {
+		*max_extent_size = avail;
+		goto out;
+	}
+
+	ret = start + block_group->alloc_offset;
+	block_group->alloc_offset += bytes;
+	ctl->free_space -= bytes;
+out:
+	spin_unlock(&ctl->tree_lock);
+	return ret;
+}
+
 /*
  * given a cluster, put all of its extents back into the free space
  * cache.  If a block group is passed, this function will only free
@@ -2701,6 +2735,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group_cache *block_group,
 	struct rb_node *node;
 	u64 ret = 0;
 
+	WARN_ON(block_group->alloc_type == BTRFS_ALLOC_SEQ);
+
 	spin_lock(&cluster->lock);
 	if (bytes > cluster->max_size)
 		goto out;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 794a444c3f73..79b4fa31bc8f 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -80,6 +80,14 @@ static inline int
 btrfs_add_free_space(struct btrfs_block_group_cache *block_group,
 		     u64 bytenr, u64 size)
 {
+	if (block_group->alloc_type == BTRFS_ALLOC_SEQ) {
+		struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+
+		spin_lock(&ctl->tree_lock);
+		ctl->free_space += size;
+		spin_unlock(&ctl->tree_lock);
+		return 0;
+	}
 	return __btrfs_add_free_space(block_group->fs_info,
 				      block_group->free_space_ctl,
 				      bytenr, size);
@@ -92,6 +100,8 @@ void btrfs_remove_free_space_cache(struct btrfs_block_group_cache
 u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 			       u64 offset, u64 bytes, u64 empty_size,
 			       u64 *max_extent_size);
+u64 btrfs_find_space_for_alloc_seq(struct btrfs_block_group_cache *block_group,
+				   u64 bytes, u64 *max_extent_size);
 u64 btrfs_find_ino_for_alloc(struct btrfs_root *fs_root);
 void btrfs_dump_free_space(struct btrfs_block_group_cache *block_group,
 			   u64 bytes);
-- 
2.18.0

