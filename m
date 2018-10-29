Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E64DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F8320657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="COF20vKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F8320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeJ3B1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:27:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35483 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbeJ3B1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:27:33 -0400
Received: by mail-io1-f66.google.com with SMTP id 79-v6so5379146iou.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q05dSOPfwm/UowrXt9AMeUMp3mZmjRCMcDVjG5ZA724=;
        b=COF20vKrj63JShQizBSeV2pci2HC1D41bwvx4tlSvmxUL68aRt2QDcWMN19XF7+rjs
         HF621Qbl3ilDuNe9zDt/4g8b2bSUZuw30VNTOaHxZZIkXCZ1G6sC0CSJk+cTUiHZVeXM
         72rj/ZKwgcvhSlKkYz6s96R0KGRJ1MKNgdTxb0T/cO3Q0XML/YmwI8ct4Htok4Df2Ded
         0ST/kzTllASH4rCbj5cOzABgYqLOhvpgGR2My/tVRYxMoEJUgFjceEIKIlYQqIbF96Jw
         175VKDPkz9zW8oK8+oxKnodMmUqFi1dq/2o2B/c4Hqd85mjI45A4W9e1SH5EmBdZbwap
         926g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q05dSOPfwm/UowrXt9AMeUMp3mZmjRCMcDVjG5ZA724=;
        b=LSaioPY9ub86YCcejLI0x71IM9+9tcG9LQSFd/KqyQeYfxf7WzmOqh8/e/nio7VXJ/
         sj/zLeWWDOzg6FpSLj/+7E/UsfIq2oWh1bP8sS/nIuZnyT9OedwPE+6i+YBxOE1g1Tty
         c3lLi2g10wGY2HnXQ7751O9Y7AsElecxqYl4bDwyrjHggRpPrbSN0X0d/Gw3ybPSqhiW
         ZUBvAoBswI3IWB3/g7ZzbCSPaCLL5LJcmtcPFj2CaX8/O1IxuPWy1tFy5/OgzAQMWcYp
         kP6+iAd0UGuZ4FS7sbnk0W+7aH+3lBfkT8p0sZKUH18qri8llO4T70v9tzz9kRJDA3Aw
         /vgg==
X-Gm-Message-State: AGRZ1gK9U24Y4yLtt5s+AUxs2V9iGeec95XleNgDJmgb7SVTAkvuf0FI
        rKGR13pISKse8gSulvxw31u9sQ==
X-Google-Smtp-Source: AJdET5dD0eA5AJlugFKS6rUc7yreRdJuV2LCZCeHZocHlVpxudSJPTCWefQyvXPJSc8a/aKoDik/Qg==
X-Received: by 2002:a6b:8ec9:: with SMTP id q192-v6mr8719024iod.248.1540831091352;
        Mon, 29 Oct 2018 09:38:11 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q15-v6sm3367019itc.38.2018.10.29.09.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:38:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/14] block: add REQ_HIPRI and inherit it from IOCB_HIPRI
Date:   Mon, 29 Oct 2018 10:37:37 -0600
Message-Id: <20181029163738.10172-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029163738.10172-1-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use IOCB_HIPRI to poll for IO in the caller instead of scheduling.
This information is not available for (or after) IO submission. The
driver may make different queue choices based on the type of IO, so
make the fact that we will poll for this IO known to the lower layers
as well.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c            | 2 ++
 fs/direct-io.c            | 2 ++
 fs/iomap.c                | 9 ++++++++-
 include/linux/blk_types.h | 4 +++-
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 38b8ce05cbc7..8bb8090c57a7 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -232,6 +232,8 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		bio.bi_opf = dio_bio_write_op(iocb);
 		task_io_account_write(ret);
 	}
+	if (iocb->ki_flags & IOCB_HIPRI)
+		bio.bi_opf |= REQ_HIPRI;
 
 	qc = submit_bio(&bio);
 	for (;;) {
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 093fb54cd316..ffb46b7aa5f7 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1265,6 +1265,8 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	} else {
 		dio->op = REQ_OP_READ;
 	}
+	if (iocb->ki_flags & IOCB_HIPRI)
+		dio->op_flags |= REQ_HIPRI;
 
 	/*
 	 * For AIO O_(D)SYNC writes we need to defer completions to a workqueue
diff --git a/fs/iomap.c b/fs/iomap.c
index ec15cf2ec696..50ad8c8d1dcb 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1554,6 +1554,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 		unsigned len)
 {
 	struct page *page = ZERO_PAGE(0);
+	int flags = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 
 	bio = bio_alloc(GFP_KERNEL, 1);
@@ -1562,9 +1563,12 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
+	if (dio->iocb->ki_flags & IOCB_HIPRI)
+		flags |= REQ_HIPRI;
+
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
-	bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC | REQ_IDLE);
+	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
 
 	atomic_inc(&dio->ref);
 	return submit_bio(bio);
@@ -1663,6 +1667,9 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 				bio_set_pages_dirty(bio);
 		}
 
+		if (dio->iocb->ki_flags & IOCB_HIPRI)
+			bio->bi_opf |= REQ_HIPRI;
+
 		iov_iter_advance(dio->submit.iter, n);
 
 		dio->size += n;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 093a818c5b68..d6c2558d6b73 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -322,6 +322,8 @@ enum req_flag_bits {
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
+	__REQ_HIPRI,
+
 	/* for driver use */
 	__REQ_DRV,
 	__REQ_SWAP,		/* swapping request. */
@@ -342,8 +344,8 @@ enum req_flag_bits {
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
-
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
+#define REQ_HIPRI		(1ULL << __REQ_HIPRI)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
-- 
2.17.1

