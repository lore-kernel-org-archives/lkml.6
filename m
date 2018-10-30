Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD875C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974B52082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PGNr4zA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974B52082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeJaD2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:28:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38759 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeJaD2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:28:02 -0400
Received: by mail-it1-f196.google.com with SMTP id j9so3072407itl.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q05dSOPfwm/UowrXt9AMeUMp3mZmjRCMcDVjG5ZA724=;
        b=PGNr4zA6ebujuKlxOULXkMmbfq/R4beWrMw0Nu0fvrEeiA5Igow5iNHLwpY4+BzyuK
         2Mw1k6TX/N3b47omYHlIDk1NlwWLJEgIYORpyDa3NwnB1J//92Y4tSJAhaLetXfAQPPu
         ZYcpGtPPKuFNmPSSQzA+wC/nzPBVocGc9KVRdgOGB6Kmj0GsFEiRESXyODL+7GxD4B+K
         FmrZJ5bTVm0QGKQ1dYN9mrH5Bf/HAUq4hQJ0Gjmcd4AQUzAWUZR8VndwB9MkNGSmYc9u
         ZmYrhx5TR2M0C3DubfvEAagYyAFAC9ByKjQUJ4/9YCvXCvg1w0+hFs32d4YehDSBYQc/
         Cizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q05dSOPfwm/UowrXt9AMeUMp3mZmjRCMcDVjG5ZA724=;
        b=MAdEJLU0OdbLTcEYwxpj6GbzWT28nDKgrgo9PZ3dE5hH6ed5yj+wFGAfvR3VQ8BiyX
         1R6McD4BPyfscu/9qzOyj7duvdxg/oxL9gcil+wmeR/+KLVkmlfTw8aARYtpVNLnJi7j
         OC58JvQNxFxVHQ5CyGTy3w3iqp5zvWoP2SvJ/ZpJnmsal9EBFNB9pQE2Pb9RJubqk/v8
         mf740YZqZsmlImG2vLyuW4sN66tZyQ9vIOz8fQpSDvFyjDfnwPJzc4JkGLOfMXt+PwJZ
         yODcEzDV7zUToNNg8yTrogGyk551i+yXivl9fAZf9evewuZ31tU+LfE3Lh1/GzoKbYbT
         pWPQ==
X-Gm-Message-State: AGRZ1gLn+7o0PxEvv5UZ36yjBosrj5qWhTs6gK4ra87s5D0Ym4x6lRo6
        XD1xg0oD5rz9TGQjjOTQvDzLZw==
X-Google-Smtp-Source: AJdET5dy6uy6nRfx5Hma+m2+ePPwrCzjLsteH9Avh6zyrLjEgCl1yJSs4diaNDq8i4+18SHX7TaQSQ==
X-Received: by 2002:a24:8247:: with SMTP id t68-v6mr24622itd.68.1540924406008;
        Tue, 30 Oct 2018 11:33:26 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o20-v6sm4895739itc.34.2018.10.30.11.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:33:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/16] block: add REQ_HIPRI and inherit it from IOCB_HIPRI
Date:   Tue, 30 Oct 2018 12:32:51 -0600
Message-Id: <20181030183252.17857-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
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

