Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02995C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A605320858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="PFSqvrw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A605320858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbeIRNe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:34:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44501 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbeIRNen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:34:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id s10-v6so1085618edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JsNkcWVJOCarqC/bpmGqL72RhGJqbuV9+ZO/3dipo28=;
        b=PFSqvrw1y+EYiSIxgVMbXa+Zr2jx+xV/zLNTU99RMx7EZTAWOzX3WeUFbU3lQI0KAe
         AB6j1iLGyPGWvYcYsB0DlmhR/h4PwMrqKC038cvTLtRt8KMT8cuL4ZUIr5ncHbzzAERB
         72K/FAZ/TYpP3fLseAfohuOvRAj11s+lm4VLeTAV56pYm13e1OCbT/V69TDz7j8bxnQ7
         DXfx40Uy0yeauawWTUd83k+u897eXl0MJpmH+LekYYkkbSfmmbATPdxsnzfni1w/Ndm+
         AraA8UB3iqLoHUGeBxMDelXGFOfKr1BpRNlRx401rx1IidB74OPTILuDQGnpQbYxNDbU
         cqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JsNkcWVJOCarqC/bpmGqL72RhGJqbuV9+ZO/3dipo28=;
        b=lU6uItTn+BA4EStQt7/4UjaRhjGoUzPionX/3JxKTHFBtt+t9bjXckJOn6+pS5UO5y
         qDynbFEORa4ZSLY5I2lzC9GBj7yFGeJFtAiIVUEps+UntR1D/lh743rM1GKUJkIJsCH9
         z8wngj/bwFqXgNsP0ZrcYpPrSbghRjJkHcyA1QpoMRdWuauOLWX1b9LB6noFMHRMnPsG
         U8n+gFHo6MRKaANOJ7upRqe3M9yl4eyB9KjcOumhmzOwdqapabXAy2kxlvRj2NZe29b8
         rhoEixk96I5q/RZVX9X7ZdqggicyJ+x9p2Y/3yKK9V5LZOX2TKVb00v9Hp1ADOv2yuDB
         MpMQ==
X-Gm-Message-State: APzg51APG5UOjYQAtUH42ihrOAy56wNLBLamW7aC+Gn3kgVz5Sn+xKo4
        Qu3aWsT7ert6V1ewT6ldljw6Qg==
X-Google-Smtp-Source: ANB0VdYP6/qOkj3P8+vJYeMI6VLfhX51yZ/woSyJvYEupT5el0yQISuzHbJ8tNMvjamwccaK6L3G7w==
X-Received: by 2002:aa7:c384:: with SMTP id k4-v6mr49638213edq.270.1537257794543;
        Tue, 18 Sep 2018 01:03:14 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id l48-v6sm7221062eda.94.2018.09.18.01.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 01:03:13 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/4] lightnvm: pblk: encapsulate rb pointer operations
Date:   Tue, 18 Sep 2018 10:03:03 +0200
Message-Id: <1537257785-31630-3-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
References: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pblk's read/write buffer is always a power-of-2, thus wrapping up the
buffer can be done with a bit mask. Since this is an implementation
detail internal to the write buffer, make a helper that hides pointer
increment + wrap, and allows to  transparently relax this assumption in
the future.

Signed-off-by: Javier González <javier@cnexlabs.com>
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
index e70ece87a9f4..0ffc19cff697 100644
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
2.7.4

