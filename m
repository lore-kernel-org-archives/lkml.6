Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE126C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8128B2238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUv1yRcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8128B2238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeHIUcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:32:08 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36040 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeHIUcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:32:07 -0400
Received: by mail-pl0-f65.google.com with SMTP id e11-v6so2877314plb.3;
        Thu, 09 Aug 2018 11:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rARAqk1ykm9dLRLpQ087kt8xNkxGu2tjsN++jua7gEc=;
        b=PUv1yRcr9a16xU8SRrYAwnyBY2Px5fil2rk56rw5TDgSz2H2wd4tiLBrcuixFy8/XM
         F+gWTjAW8i3iBB2ECBVwWrRLmhWeyd0N4TwYqt1ozlR+fjHl+X33TkjWjZaW0UiylT3N
         vU896YyPJMdHsTEaSqiBUwl/Z+Eo+dEXxqAG4b62CVfmSgb9X+dsNLwPLqznVvvscWTy
         B/rCMSZexg/Mu7mZ+6Gq9//zdAQPz/gbumIInZlvXkfYct8ML3EwGpFgDs2X03fxXMoe
         nvnYwGFvuFcCKC6Heg1Ec9CJQ45+EKQlYXmiHQB2cYKjjqk+1JHPa0BDtcy6urL1dGIp
         y0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=rARAqk1ykm9dLRLpQ087kt8xNkxGu2tjsN++jua7gEc=;
        b=AF+9pDn/7Y21V9zWpXc5++RHhoa6jxZ2uOjQthSEDs853Vf9U4mCsGcJ6pr2vzDgcx
         ivWKfkjedKXF8HA7Is6AuR8GoYCWdCq/8xZkoNEkXBpNPGO4ahjY+OBeAHd5M0JKr7DK
         ELRaDjU3j1HoPut/K5CZpwwbrlijckfh9tiH2qGAJI6hcEEpHsXiZKtOcFgJBQ/XYkst
         Cjr6ah4McOpw2D0nG0epFCjxGXZ88G4uX82lB0oofJBPQbWivse73RSX9sem6YVAjgjI
         kruZ3g+Y0/0d5Rt5Mw31a2uQpwgHUJxNxaRG5M334sJOMh2c5OV3+4iuXTNFZQDdm1zJ
         wqJA==
X-Gm-Message-State: AOUpUlGdjXl3tb3PauPzNjKsx6yOiaUKc/GWIRQZDBd7DDyp0P1WVfAC
        /tuqDPXT9s7uGUutMKexUD4KXUaX3BM=
X-Google-Smtp-Source: AA+uWPwStJ318ffx+52ZVy7y6Xisx5t0aOhKRgMNCl4MCYg2Nf6qqmJEFXAoNKcohRrUE11TA91ARw==
X-Received: by 2002:a17:902:6b89:: with SMTP id p9-v6mr2983866plk.272.1533837968062;
        Thu, 09 Aug 2018 11:06:08 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id s195-v6sm23604653pgs.76.2018.08.09.11.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:06:07 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 08/17] btrfs: align extent allocation to zone boundary
Date:   Fri, 10 Aug 2018 03:04:41 +0900
Message-Id: <20180809180450.5091-9-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In HMZONED mode, align the device extents to zone boundaries so that write
I/Os can begin at the start of a zone, as mandated on host-managed zoned
block devices. Also, check that a region allocation is always over empty
zones.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 fs/btrfs/extent-tree.c |  3 ++
 fs/btrfs/volumes.c     | 69 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f77226d8020a..fc3daf0e5b92 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9527,6 +9527,9 @@ int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr)
 		min_free = div64_u64(min_free, dev_min);
 	}
 
+	/* We cannot allocate size less than zone_size anyway */
+	min_free = max_t(u64, min_free, fs_info->zone_size);
+
 	/* We need to do this so that we can look at pending chunks */
 	trans = btrfs_join_transaction(root);
 	if (IS_ERR(trans)) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ba7ebb80de4d..ada13120c2cd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1521,6 +1521,31 @@ static int contains_pending_extent(struct btrfs_transaction *transaction,
 	return ret;
 }
 
+static u64 dev_zone_align(struct btrfs_device *device, u64 pos)
+{
+	if (device->zone_size)
+		return ALIGN(pos, device->zone_size);
+	return pos;
+}
+
+static int is_empty_zone_region(struct btrfs_device *device,
+				u64 pos, u64 num_bytes)
+{
+	if (device->zone_size == 0)
+		return 1;
+
+	WARN_ON(!IS_ALIGNED(pos, device->zone_size));
+	WARN_ON(!IS_ALIGNED(num_bytes, device->zone_size));
+
+	while (num_bytes > 0) {
+		if (!btrfs_dev_is_empty_zone(device, pos))
+			return 0;
+		pos += device->zone_size;
+		num_bytes -= device->zone_size;
+	}
+
+	return 1;
+}
 
 /*
  * find_free_dev_extent_start - find free space in the specified device
@@ -1564,9 +1589,14 @@ int find_free_dev_extent_start(struct btrfs_transaction *transaction,
 	/*
 	 * We don't want to overwrite the superblock on the drive nor any area
 	 * used by the boot loader (grub for example), so we make sure to start
-	 * at an offset of at least 1MB.
+	 * at an offset of at least 1MB on a regular disk. For a zoned block
+	 * device, skip the first zone of the device entirely.
 	 */
-	search_start = max_t(u64, search_start, SZ_1M);
+	if (device->zone_size)
+		search_start = max_t(u64, dev_zone_align(device, search_start),
+				     device->zone_size);
+	else
+		search_start = max_t(u64, search_start, SZ_1M);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -1632,6 +1662,8 @@ int find_free_dev_extent_start(struct btrfs_transaction *transaction,
 			if (contains_pending_extent(transaction, device,
 						    &search_start,
 						    hole_size)) {
+				search_start = dev_zone_align(device,
+							      search_start);
 				if (key.offset >= search_start) {
 					hole_size = key.offset - search_start;
 				} else {
@@ -1640,6 +1672,14 @@ int find_free_dev_extent_start(struct btrfs_transaction *transaction,
 				}
 			}
 
+			if (!is_empty_zone_region(device, search_start,
+						  num_bytes)) {
+				search_start = dev_zone_align(device,
+							      search_start+1);
+				btrfs_release_path(path);
+				goto again;
+			}
+
 			if (hole_size > max_hole_size) {
 				max_hole_start = search_start;
 				max_hole_size = hole_size;
@@ -1664,7 +1704,7 @@ int find_free_dev_extent_start(struct btrfs_transaction *transaction,
 		extent_end = key.offset + btrfs_dev_extent_length(l,
 								  dev_extent);
 		if (extent_end > search_start)
-			search_start = extent_end;
+			search_start = dev_zone_align(device, extent_end);
 next:
 		path->slots[0]++;
 		cond_resched();
@@ -1680,6 +1720,14 @@ int find_free_dev_extent_start(struct btrfs_transaction *transaction,
 
 		if (contains_pending_extent(transaction, device, &search_start,
 					    hole_size)) {
+			search_start = dev_zone_align(device,
+						      search_start);
+			btrfs_release_path(path);
+			goto again;
+		}
+
+		if (!is_empty_zone_region(device, search_start, num_bytes)) {
+			search_start = dev_zone_align(device, search_start+1);
 			btrfs_release_path(path);
 			goto again;
 		}
@@ -4832,6 +4880,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int i;
 	int j;
 	int index;
+	int hmzoned = btrfs_fs_incompat(info, HMZONED);
 
 	BUG_ON(!alloc_profile_is_valid(type, 0));
 
@@ -4851,13 +4900,18 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	ncopies = btrfs_raid_array[index].ncopies;
 
 	if (type & BTRFS_BLOCK_GROUP_DATA) {
-		max_stripe_size = SZ_1G;
+		if (hmzoned)
+			max_stripe_size = info->zone_size;
+		else
+			max_stripe_size = SZ_1G;
 		max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
 		if (!devs_max)
 			devs_max = BTRFS_MAX_DEVS(info);
 	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
 		/* for larger filesystems, use larger metadata chunks */
-		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
+		if (hmzoned)
+			max_stripe_size = info->zone_size;
+		else if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
 			max_stripe_size = SZ_1G;
 		else
 			max_stripe_size = SZ_256M;
@@ -4865,7 +4919,10 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		if (!devs_max)
 			devs_max = BTRFS_MAX_DEVS(info);
 	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
-		max_stripe_size = SZ_32M;
+		if (hmzoned)
+			max_stripe_size = info->zone_size;
+		else
+			max_stripe_size = SZ_32M;
 		max_chunk_size = 2 * max_stripe_size;
 		if (!devs_max)
 			devs_max = BTRFS_MAX_DEVS_SYS_CHUNK;
-- 
2.18.0

