Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5ABC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9D72054F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRb6AMUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9D72054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeJLXiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:38:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36097 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbeJLXiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:38:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id l81-v6so6430280pfg.3;
        Fri, 12 Oct 2018 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IkgJTXU2KMmUNbg8R4P9gmqinHJnXup6lY0sYNRyuK8=;
        b=bRb6AMUd3jHNo4xhaaw3BBolF+UNauOjttqm5KAFKbwK4Vhr0ptLVA8j1q/uTQvzJd
         VjzJqKS878BCQhq32G+j+f6R9+26KG9GHwj5SNguR+D++sfyfVViDHm+jJNjVfyOBt2U
         /lAScVYPP9o6zkF58gotzAAtodl9m1s7WJlI6ZWNLD5mv/n2jouhg6FD8whQbPbNWQ90
         pN34eiVH9WlpFyGy6MCSGj/9tL8uQKCG0eFb/zu5SxDQrc1Jo9X0+gPvj+Kql+TDZWRQ
         dHTnwrlDu0/CxSOcvwQsf88hIdmvUbXVk0KZHIKorCBkNZicEGn8Qy7FtD81Wb2Olb1u
         SiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IkgJTXU2KMmUNbg8R4P9gmqinHJnXup6lY0sYNRyuK8=;
        b=Lm8w+eieh88GFzacxt36ksRfwDb0h7PUHZ7TNGpvoTyq7FUEtoBtbl3+H8IT8Zybis
         niX0PtH1cRSRiYh831JhfYT7xIs92tiVpwn7XoarvIVvEKdDYJpU0nH13M4LXQlCKCDp
         u6kruVHp24tpyOJyB1HIz/iexZXriWsvZkM3dnSX80tc5h9ifD8WeKT2SH5x/oSd7Mf9
         kuAWB582empem8HxTC+WEdt126Mzg43/isk7OOGK9AEgm5n1lI6PAV60T7Qjxu5Esot8
         hnoQnxAWHuICqE5NVJww02YphrqnEaodvGdbrFP+2Fc3qFi2klpK449D4VTGsESb6INu
         LgLQ==
X-Gm-Message-State: ABuFfogTZtX5L4oZAtcelQkA44FwgCyN9yZbv+878YuXnh9MO2/DVJo1
        4tDybQ4cHZkaDyMGf3Gly7JCXHvjyvZRpBBR
X-Google-Smtp-Source: ACcGV61t6/yxog4HZ1bwaEuJi6QFCRiLveBp5Crf/6u4ZxzfBSM8jI7LiWOhKZJ3furnkIZDiT5eGA==
X-Received: by 2002:a63:b25e:: with SMTP id t30-v6mr6057511pgo.401.1539360295464;
        Fri, 12 Oct 2018 09:04:55 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([113.87.163.157])
        by smtp.gmail.com with ESMTPSA id z63-v6sm2629571pfz.31.2018.10.12.09.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 09:04:54 -0700 (PDT)
From:   Guoju Fang <fangguoju@gmail.com>
To:     colyli@suse.de, kent.overstreet@gmail.com,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guoju Fang <fangguoju@gmail.com>
Subject: [PATCH] bcache: fix superblock being corrupted with non-4KB page size
Date:   Thu, 11 Oct 2018 02:27:43 +0800
Message-Id: <1539196063-129439-1-git-send-email-fangguoju@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In read_super(), after read super block  by __bread(), a page is used to
cache the data. But it will cause superblock corrupted when PAGE_SIZE is
8KB or larger, because bh->b_data doesn't always point to the beginning
of the page. So use a bio_vec struct to point the superblock cached.

Signed-off-by: Guoju Fang <fangguoju@gmail.com>
---
 drivers/md/bcache/super.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 30ba9ae..64715a8 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -58,7 +58,7 @@
 /* Superblock */
 
 static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
-			      struct page **res)
+			      struct bio_vec *bv)
 {
 	const char *err;
 	struct cache_sb *s;
@@ -188,7 +188,9 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 	err = NULL;
 
 	get_page(bh->b_page);
-	*res = bh->b_page;
+	bv->bv_page = bh->b_page;
+	bv->bv_len = SB_SIZE;
+	bv->bv_offset = (unsigned long)bh->b_data & ~PAGE_MASK;
 err:
 	put_bh(bh);
 	return err;
@@ -204,7 +206,8 @@ static void write_bdev_super_endio(struct bio *bio)
 
 static void __write_super(struct cache_sb *sb, struct bio *bio)
 {
-	struct cache_sb *out = page_address(bio_first_page_all(bio));
+	struct cache_sb *out = page_address(bio_first_bvec_all(bio)->bv_page) +
+		    bio_first_bvec_all(bio)->bv_offset;
 	unsigned int i;
 
 	bio->bi_iter.bi_sector	= SB_SECTOR;
@@ -1277,7 +1280,7 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
 
 /* Cached device - bcache superblock */
 
-static void register_bdev(struct cache_sb *sb, struct page *sb_page,
+static void register_bdev(struct cache_sb *sb, struct bio_vec *bv,
 				 struct block_device *bdev,
 				 struct cached_dev *dc)
 {
@@ -1290,8 +1293,8 @@ static void register_bdev(struct cache_sb *sb, struct page *sb_page,
 	dc->bdev->bd_holder = dc;
 
 	bio_init(&dc->sb_bio, dc->sb_bio.bi_inline_vecs, 1);
-	bio_first_bvec_all(&dc->sb_bio)->bv_page = sb_page;
-	get_page(sb_page);
+	memcpy(bio_first_bvec_all(&dc->sb_bio), bv, sizeof(*bv));
+	get_page(bv->bv_page);
 
 
 	if (cached_dev_init(dc, sb->block_size << 9))
@@ -2089,7 +2092,7 @@ static int cache_alloc(struct cache *ca)
 	return 0;
 }
 
-static int register_cache(struct cache_sb *sb, struct page *sb_page,
+static int register_cache(struct cache_sb *sb, struct bio_vec *bv,
 				struct block_device *bdev, struct cache *ca)
 {
 	const char *err = NULL; /* must be set for any error case */
@@ -2101,8 +2104,8 @@ static int register_cache(struct cache_sb *sb, struct page *sb_page,
 	ca->bdev->bd_holder = ca;
 
 	bio_init(&ca->sb_bio, ca->sb_bio.bi_inline_vecs, 1);
-	bio_first_bvec_all(&ca->sb_bio)->bv_page = sb_page;
-	get_page(sb_page);
+	memcpy(bio_first_bvec_all(&ca->sb_bio), bv, sizeof(*bv));
+	get_page(bv->bv_page);
 
 	if (blk_queue_discard(bdev_get_queue(bdev)))
 		ca->discard = CACHE_DISCARD(&ca->sb);
@@ -2195,7 +2198,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	char *path = NULL;
 	struct cache_sb *sb = NULL;
 	struct block_device *bdev = NULL;
-	struct page *sb_page = NULL;
+	struct bio_vec bv = { NULL };
 
 	if (!try_module_get(THIS_MODULE))
 		return -EBUSY;
@@ -2233,7 +2236,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	if (set_blocksize(bdev, 4096))
 		goto err_close;
 
-	err = read_super(sb, bdev, &sb_page);
+	err = read_super(sb, bdev, &bv);
 	if (err)
 		goto err_close;
 
@@ -2245,7 +2248,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 			goto err_close;
 
 		mutex_lock(&bch_register_lock);
-		register_bdev(sb, sb_page, bdev, dc);
+		register_bdev(sb, &bv, bdev, dc);
 		mutex_unlock(&bch_register_lock);
 	} else {
 		struct cache *ca = kzalloc(sizeof(*ca), GFP_KERNEL);
@@ -2253,12 +2256,12 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 		if (!ca)
 			goto err_close;
 
-		if (register_cache(sb, sb_page, bdev, ca) != 0)
+		if (register_cache(sb, &bv, bdev, ca) != 0)
 			goto err;
 	}
 out:
-	if (sb_page)
-		put_page(sb_page);
+	if (bv.bv_page)
+		put_page(bv.bv_page);
 	kfree(sb);
 	kfree(path);
 	module_put(THIS_MODULE);
-- 
1.8.3.1

