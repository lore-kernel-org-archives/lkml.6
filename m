Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D99AC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CD32075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="oON6cxI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CD32075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeJISby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:31:54 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:36059 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeJISbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:31:53 -0400
Received: by mail-pf1-f178.google.com with SMTP id l81-v6so684172pfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mq7QT5AwEHerzLjtp9AEpsdA3BnMo73ASBrU7qWuG9g=;
        b=oON6cxI0qVT59/WE1KlehgABIyHbHlLwYQaf3LE/PYHn/MLgXFkBDMtN/qeRYq+Vu8
         IooPGjEC7NcgOUo/fX3kH7wAyzojRLCsGOmQ0NVRMDzdhx8YGOUcxbhTvaKpxqDmQpV0
         +ziTzelqwZ6Ux+ihgFuFYaZPMAPRTLqTYec98zjkFeUQeGS52v/Ajrz5555mETL99N7M
         /0dFwoBjh9s5+tt/19yyy4NZp3FKH5BbSiU+mq5P0/7UqH8DLPS4whDS/l1e2cnCX88h
         Go+7iZVvZJW5gokV3y1VpiE9qcE/7BW8tjL8NQq7zJNMX4gelAPrR2i6J5GtTdk0NGM0
         /BGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mq7QT5AwEHerzLjtp9AEpsdA3BnMo73ASBrU7qWuG9g=;
        b=SA3tfpR3Vx1QZTYF9Q8UsSsWVbmxg+wqRxLKfbDjnAg3rC7DXoA+CWqmXFyqVM0FOk
         vDxNI8exm7EaLFWg96fH8DrWPnyz3PENFIjLS/X/qGG0+shovfMKJzbpJ/npHeX/igQA
         o8bkEdWV0bnLqiajAvLU9tTGvVtJ4x6zttBl/l24tgIKWpDI+ualBjRRGYBtZ+AcaCg/
         iFt4mt6uHTJOBsUhkK46jokz3bFP0zumUKlO2JCqHGryOOv22NifeW/lpNyoazQHfqbn
         C5+V01IVy1/ghStg9sLrjv9EIpDRt+Ryuv53zlpg1o/Aw7uLBNMZsF824WSd25DkotDu
         CMWQ==
X-Gm-Message-State: ABuFfohW/bUmHBnyD7zbNIRU6d3+U9xVsiaAUxi2y18jYc1ZQ9298MhZ
        5MuojJ7r3QBx6oJwU/6yBhDIEA==
X-Google-Smtp-Source: ACcGV60aveD2tS5WmOC1gzETUgwvv3i+TiFOWORUS/Jdbqa5W9/3/z8etsYpCZKlF0b4nUAspqgW/w==
X-Received: by 2002:a63:a012:: with SMTP id r18-v6mr25673128pge.282.1539083726204;
        Tue, 09 Oct 2018 04:15:26 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:15:25 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 39/45] lightnvm: pblk: encapsulate rb pointer operations
Date:   Tue,  9 Oct 2018 13:12:09 +0200
Message-Id: <20181009111215.7653-40-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier@javigon.com>

pblk's read/write buffer is always a power-of-2, thus wrapping up the
buffer can be done with a bit mask. Since this is an implementation
detail internal to the write buffer, make a helper that hides pointer
increment + wrap, and allows to transparently relax this assumption in
the future.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-rb.c    | 21 +++++++++++++--------
 drivers/lightnvm/pblk-write.c |  7 ++-----
 drivers/lightnvm/pblk.h       |  2 ++
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 82829e8151db..e46d8cb9d28b 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -169,6 +169,12 @@ static unsigned int pblk_rb_space(struct pblk_rb *rb)
 	return pblk_rb_ring_space(rb, mem, sync, rb->nr_entries);
 }
 
+unsigned int pblk_rb_ptr_wrap(struct pblk_rb *rb, unsigned int p,
+			      unsigned int nr_entries)
+{
+	return (p + nr_entries) & (rb->nr_entries - 1);
+}
+
 /*
  * Buffer count is calculated with respect to the submission entry signaling the
  * entries that are available to send to the media
@@ -195,8 +201,7 @@ unsigned int pblk_rb_read_commit(struct pblk_rb *rb, unsigned int nr_entries)
 
 	subm = READ_ONCE(rb->subm);
 	/* Commit read means updating submission pointer */
-	smp_store_release(&rb->subm,
-				(subm + nr_entries) & (rb->nr_entries - 1));
+	smp_store_release(&rb->subm, pblk_rb_ptr_wrap(rb, subm, nr_entries));
 
 	return subm;
 }
@@ -229,7 +234,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int to_update)
 		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
 		kref_put(&line->ref, pblk_line_put);
 		clean_wctx(w_ctx);
-		rb->l2p_update = (rb->l2p_update + 1) & (rb->nr_entries - 1);
+		rb->l2p_update = pblk_rb_ptr_wrap(rb, rb->l2p_update, 1);
 	}
 
 	pblk_rl_out(&pblk->rl, user_io, gc_io);
@@ -408,7 +413,7 @@ static int pblk_rb_may_write(struct pblk_rb *rb, unsigned int nr_entries,
 		return 0;
 
 	/* Protect from read count */
-	smp_store_release(&rb->mem, (*pos + nr_entries) & (rb->nr_entries - 1));
+	smp_store_release(&rb->mem, pblk_rb_ptr_wrap(rb, *pos, nr_entries));
 	return 1;
 }
 
@@ -432,7 +437,7 @@ static int pblk_rb_may_write_flush(struct pblk_rb *rb, unsigned int nr_entries,
 	if (!__pblk_rb_may_write(rb, nr_entries, pos))
 		return 0;
 
-	mem = (*pos + nr_entries) & (rb->nr_entries - 1);
+	mem = pblk_rb_ptr_wrap(rb, *pos, nr_entries);
 	*io_ret = NVM_IO_DONE;
 
 	if (bio->bi_opf & REQ_PREFLUSH) {
@@ -572,7 +577,7 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
 		/* Release flags on context. Protect from writes */
 		smp_store_release(&entry->w_ctx.flags, flags);
 
-		pos = (pos + 1) & (rb->nr_entries - 1);
+		pos = pblk_rb_ptr_wrap(rb, pos, 1);
 	}
 
 	if (pad) {
@@ -652,7 +657,7 @@ int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t lba,
 
 struct pblk_w_ctx *pblk_rb_w_ctx(struct pblk_rb *rb, unsigned int pos)
 {
-	unsigned int entry = pos & (rb->nr_entries - 1);
+	unsigned int entry = pblk_rb_ptr_wrap(rb, pos, 0);
 
 	return &rb->entries[entry].w_ctx;
 }
@@ -698,7 +703,7 @@ unsigned int pblk_rb_sync_advance(struct pblk_rb *rb, unsigned int nr_entries)
 		}
 	}
 
-	sync = (sync + nr_entries) & (rb->nr_entries - 1);
+	sync = pblk_rb_ptr_wrap(rb, sync, nr_entries);
 
 	/* Protect from counts */
 	smp_store_release(&rb->sync, sync);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 277abc8633f7..fa8726493b39 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -140,12 +140,11 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 	struct pblk_w_ctx *w_ctx;
 	struct ppa_addr ppa_l2p;
 	int flags;
-	unsigned int pos, i;
+	unsigned int i;
 
 	spin_lock(&pblk->trans_lock);
-	pos = sentry;
 	for (i = 0; i < nr_entries; i++) {
-		entry = &rb->entries[pos];
+		entry = &rb->entries[pblk_rb_ptr_wrap(rb, sentry, i)];
 		w_ctx = &entry->w_ctx;
 
 		/* Check if the lba has been overwritten */
@@ -164,8 +163,6 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		 */
 		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
 		kref_put(&line->ref, pblk_line_put);
-
-		pos = (pos + 1) & (rb->nr_entries - 1);
 	}
 	spin_unlock(&pblk->trans_lock);
 }
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 22586b78198a..7660811aa8af 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -760,6 +760,8 @@ unsigned int pblk_rb_read_commit(struct pblk_rb *rb, unsigned int entries);
 
 unsigned int pblk_rb_sync_init(struct pblk_rb *rb, unsigned long *flags);
 unsigned int pblk_rb_sync_advance(struct pblk_rb *rb, unsigned int nr_entries);
+unsigned int pblk_rb_ptr_wrap(struct pblk_rb *rb, unsigned int p,
+			      unsigned int nr_entries);
 void pblk_rb_sync_end(struct pblk_rb *rb, unsigned long *flags);
 unsigned int pblk_rb_flush_point_count(struct pblk_rb *rb);
 
-- 
2.17.1

