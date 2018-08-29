Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA059C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8D520644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="QLrjXIWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8D520644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeH2NJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:09:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34028 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeH2NJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:09:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so3215738eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 02:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T2llQm9lPdMX9KmlWxL2qTE6v5PKCWHcCH6cDJNICTg=;
        b=QLrjXIWrYzQ2MITMfV7E7wp8eD27SISqZsN0IDqgm35JOobdyHwhfVWFZEdFOreqp1
         nUAfuc0V2CkLrtxV1yl4cGD2zsQGL89l5399jI9QIAug/V5vH9EmBXxZzuaLZz3PiadL
         cT4XS2d46Td7lisnK7iJjAwqFo63hHk9rmYe2B9niEKPVXFCMwHlCoRBmtsWdwNWutx8
         9MEBj7z+Z24RXiJT5xAzGlaA61bjxHgnTTpT7FBEe5+veXL7hb+KLiMdhzvp190FgXSc
         RHBsLDbZ4CBQeUfFahB1caAyBIWme9VOoTCaNcGoLiJD4sG+d1UQUdTzEETtyryUVk1D
         uUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T2llQm9lPdMX9KmlWxL2qTE6v5PKCWHcCH6cDJNICTg=;
        b=rM5zz1PfL1Ljtq3RpQC4b+GeGJwIdIbFcfE9A8pMiryM0o+22pu/eTLkPw+QOEGN3n
         TLUs9qiJe+ze0qUuUGPVsMFXz8ExWnDw9NjQA7H3h6ZbIMR8Q+0pLY4R4iL6c+J7Nup7
         PzEJKsZsZMORTkrsmcpSNRmcn0+/RGJI4+5k077T3xypGw2MfMghifivAehloa1TxNxs
         7+YcaKa/TtoRjj0d2S5HzMaR/6GQ2ve32dcNZGsR1eyVJndPH3AdPjKWeQeDXi80bV3J
         ysMwomqFMwc7p2cfdATZQKdxyMZt+5eswTc4BqkUJE15MgOAQUqP6MCeQ3Qp0p4Phe2J
         EdDA==
X-Gm-Message-State: APzg51Bsk87lrwv9mDK2p95gXLNM0GE7bWityess6/TFUVaiDyVdntIZ
        LnJDTRChxDspPJcy6C1tRNzDWg==
X-Google-Smtp-Source: ANB0VdZZ+jllO+I9lPrnZXbhTS6XUGIqszrOpAqh0e33JMZlIsJxBXZSu9jbVCXZ0aSAFBtKPooJHg==
X-Received: by 2002:a50:b0c1:: with SMTP id j59-v6mr6722192edd.267.1535533985403;
        Wed, 29 Aug 2018 02:13:05 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id c28-v6sm1833346edc.52.2018.08.29.02.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 02:13:04 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: recover open lines on 2.0 devices
Date:   Wed, 29 Aug 2018 11:12:57 +0200
Message-Id: <1535533977-32164-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the OCSSD 2.0 spec, each chunk reports its write pointer. This means
that pblk does not need to scan open lines to find the write pointer,
but instead, it can retrieve it directly (and verify it).

This patch uses the write pointer on open lines to (i) recover the line
up until the last written lba and (ii) reconstruct the map bitmap and
rest of line metadata so that the line can be used for new data.

Since the 1.2 path in lightnvm core has been re-implemented to populate
the chunk structure and thus recover the write pointer on
initialization, this patch removes 1.2 specific recovery, as the 2.0
path can be reused.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-recovery.c | 406 ++++++++++++---------------------------
 1 file changed, 124 insertions(+), 282 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 188c89819a40..8114013c37b8 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -86,15 +86,39 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
 	return 0;
 }
 
-static int pblk_calc_sec_in_line(struct pblk *pblk, struct pblk_line *line)
+static void pblk_update_line_wp(struct pblk *pblk, struct pblk_line *line,
+				u64 written_secs)
+{
+	int i;
+
+	for (i = 0; i < written_secs; i += pblk->min_write_pgs)
+		pblk_alloc_page(pblk, line, pblk->min_write_pgs);
+}
+
+static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
 {
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
 	int nr_bb = bitmap_weight(line->blk_bitmap, lm->blk_per_line);
+	u64 written_secs = 0;
+	int valid_chunks = 0;
+	int i;
 
-	return lm->sec_per_line - lm->smeta_sec - lm->emeta_sec[0] -
-				nr_bb * geo->clba;
+	for (i = 0; i < lm->blk_per_line; i++) {
+		struct nvm_chk_meta *chunk = &line->chks[i];
+
+		if (chunk->state & NVM_CHK_ST_OFFLINE)
+			continue;
+
+		written_secs += chunk->wp;
+		valid_chunks++;
+	}
+
+	if (lm->blk_per_line - nr_bb != valid_chunks)
+		pblk_err(pblk, "recovery line %d is bad\n", line->id);
+
+	pblk_update_line_wp(pblk, line, written_secs - lm->smeta_sec);
+
+	return written_secs;
 }
 
 struct pblk_recov_alloc {
@@ -106,115 +130,6 @@ struct pblk_recov_alloc {
 	dma_addr_t dma_meta_list;
 };
 
-static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
-			       struct pblk_recov_alloc p, u64 r_ptr)
-{
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
-	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
-	struct nvm_rq *rqd;
-	struct bio *bio;
-	void *data;
-	dma_addr_t dma_ppa_list, dma_meta_list;
-	u64 r_ptr_int;
-	int left_ppas;
-	int rq_ppas, rq_len;
-	int i, j;
-	int ret = 0;
-
-	ppa_list = p.ppa_list;
-	meta_list = p.meta_list;
-	rqd = p.rqd;
-	data = p.data;
-	dma_ppa_list = p.dma_ppa_list;
-	dma_meta_list = p.dma_meta_list;
-
-	left_ppas = line->cur_sec - r_ptr;
-	if (!left_ppas)
-		return 0;
-
-	r_ptr_int = r_ptr;
-
-next_read_rq:
-	memset(rqd, 0, pblk_g_rq_size);
-
-	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0);
-	if (!rq_ppas)
-		rq_ppas = pblk->min_write_pgs;
-	rq_len = rq_ppas * geo->csecs;
-
-	bio = bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
-	if (IS_ERR(bio))
-		return PTR_ERR(bio);
-
-	bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(bio, REQ_OP_READ, 0);
-
-	rqd->bio = bio;
-	rqd->opcode = NVM_OP_PREAD;
-	rqd->meta_list = meta_list;
-	rqd->nr_ppas = rq_ppas;
-	rqd->ppa_list = ppa_list;
-	rqd->dma_ppa_list = dma_ppa_list;
-	rqd->dma_meta_list = dma_meta_list;
-
-	if (pblk_io_aligned(pblk, rq_ppas))
-		rqd->is_seq = 1;
-
-	ppa_list = nvm_rq_to_ppa_list(rqd);
-
-	for (i = 0; i < rqd->nr_ppas; ) {
-		struct ppa_addr ppa;
-		int pos;
-
-		ppa = addr_to_gen_ppa(pblk, r_ptr_int, line->id);
-		pos = pblk_ppa_to_pos(geo, ppa);
-
-		while (test_bit(pos, line->blk_bitmap)) {
-			r_ptr_int += pblk->min_write_pgs;
-			ppa = addr_to_gen_ppa(pblk, r_ptr_int, line->id);
-			pos = pblk_ppa_to_pos(geo, ppa);
-		}
-
-		for (j = 0; j < pblk->min_write_pgs; j++, i++, r_ptr_int++)
-			ppa_list[i] =
-				addr_to_gen_ppa(pblk, r_ptr_int, line->id);
-	}
-
-	/* If read fails, more padding is needed */
-	ret = pblk_submit_io_sync(pblk, rqd);
-	if (ret) {
-		pblk_err(pblk, "I/O submission failed: %d\n", ret);
-		return ret;
-	}
-
-	atomic_dec(&pblk->inflight_io);
-
-	/* At this point, the read should not fail. If it does, it is a problem
-	 * we cannot recover from here. Need FTL log.
-	 */
-	if (rqd->error && rqd->error != NVM_RSP_WARN_HIGHECC) {
-		pblk_err(pblk, "L2P recovery failed (%d)\n", rqd->error);
-		return -EINTR;
-	}
-
-	for (i = 0; i < rqd->nr_ppas; i++) {
-		u64 lba = le64_to_cpu(meta_list[i].lba);
-
-		if (lba == ADDR_EMPTY || lba > pblk->rl.nr_secs)
-			continue;
-
-		pblk_update_map(pblk, lba, ppa_list[i]);
-	}
-
-	left_ppas -= rq_ppas;
-	if (left_ppas > 0)
-		goto next_read_rq;
-
-	return 0;
-}
-
 static void pblk_recov_complete(struct kref *ref)
 {
 	struct pblk_pad_rq *pad_rq = container_of(ref, struct pblk_pad_rq, ref);
@@ -236,8 +151,9 @@ static void pblk_end_io_recov(struct nvm_rq *rqd)
 	kref_put(&pad_rq->ref, pblk_recov_complete);
 }
 
-static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
-			      int left_ppas)
+/* pad line using line bitmap.  */
+static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
+			       int left_ppas)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
@@ -371,143 +287,42 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 	return ret;
 }
 
-/* When this function is called, it means that not all upper pages have been
- * written in a page that contains valid data. In order to recover this data, we
- * first find the write pointer on the device, then we pad all necessary
- * sectors, and finally attempt to read the valid data
- */
-static int pblk_recov_scan_all_oob(struct pblk *pblk, struct pblk_line *line,
-				   struct pblk_recov_alloc p)
+static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
+				      struct pblk_line *line)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
-	struct nvm_rq *rqd;
-	struct bio *bio;
-	void *data;
-	dma_addr_t dma_ppa_list, dma_meta_list;
-	u64 w_ptr = 0, r_ptr;
-	int rq_ppas, rq_len;
-	int i, j;
-	int ret = 0;
-	int rec_round;
-	int left_ppas = pblk_calc_sec_in_line(pblk, line) - line->cur_sec;
-
-	ppa_list = p.ppa_list;
-	meta_list = p.meta_list;
-	rqd = p.rqd;
-	data = p.data;
-	dma_ppa_list = p.dma_ppa_list;
-	dma_meta_list = p.dma_meta_list;
-
-	/* we could recover up until the line write pointer */
-	r_ptr = line->cur_sec;
-	rec_round = 0;
-
-next_rq:
-	memset(rqd, 0, pblk_g_rq_size);
-
-	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0);
-	if (!rq_ppas)
-		rq_ppas = pblk->min_write_pgs;
-	rq_len = rq_ppas * geo->csecs;
-
-	bio = bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
-	if (IS_ERR(bio))
-		return PTR_ERR(bio);
-
-	bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(bio, REQ_OP_READ, 0);
-
-	rqd->bio = bio;
-	rqd->opcode = NVM_OP_PREAD;
-	rqd->meta_list = meta_list;
-	rqd->nr_ppas = rq_ppas;
-	rqd->ppa_list = ppa_list;
-	rqd->dma_ppa_list = dma_ppa_list;
-	rqd->dma_meta_list = dma_meta_list;
-
-	if (pblk_io_aligned(pblk, rq_ppas))
-		rqd->is_seq = 1;
-
-	for (i = 0; i < rqd->nr_ppas; ) {
-		struct ppa_addr ppa;
-		int pos;
-
-		w_ptr = pblk_alloc_page(pblk, line, pblk->min_write_pgs);
-		ppa = addr_to_gen_ppa(pblk, w_ptr, line->id);
+	struct pblk_line_meta *lm = &pblk->lm;
+	struct pblk_lun *rlun;
+	struct nvm_chk_meta *chunk;
+	struct ppa_addr ppa;
+	u64 line_wp;
+	int pos, i;
+
+	rlun = &pblk->luns[0];
+	ppa = rlun->bppa;
+	pos = pblk_ppa_to_pos(geo, ppa);
+	chunk = &line->chks[pos];
+
+	line_wp = chunk->wp;
+
+	for (i = 1; i < lm->blk_per_line; i++) {
+		rlun = &pblk->luns[i];
+		ppa = rlun->bppa;
 		pos = pblk_ppa_to_pos(geo, ppa);
+		chunk = &line->chks[pos];
 
-		while (test_bit(pos, line->blk_bitmap)) {
-			w_ptr += pblk->min_write_pgs;
-			ppa = addr_to_gen_ppa(pblk, w_ptr, line->id);
-			pos = pblk_ppa_to_pos(geo, ppa);
-		}
-
-		for (j = 0; j < pblk->min_write_pgs; j++, i++, w_ptr++)
-			rqd->ppa_list[i] =
-				addr_to_gen_ppa(pblk, w_ptr, line->id);
-	}
-
-	ret = pblk_submit_io_sync(pblk, rqd);
-	if (ret) {
-		pblk_err(pblk, "I/O submission failed: %d\n", ret);
-		return ret;
+		if (chunk->wp > line_wp)
+			return 1;
+		else if (chunk->wp < line_wp)
+			line_wp = chunk->wp;
 	}
 
-	atomic_dec(&pblk->inflight_io);
-
-	/* This should not happen since the read failed during normal recovery,
-	 * but the media works funny sometimes...
-	 */
-	if (!rec_round++ && !rqd->error) {
-		rec_round = 0;
-		for (i = 0; i < rqd->nr_ppas; i++, r_ptr++) {
-			u64 lba = le64_to_cpu(meta_list[i].lba);
-
-			if (lba == ADDR_EMPTY || lba > pblk->rl.nr_secs)
-				continue;
-
-			pblk_update_map(pblk, lba, rqd->ppa_list[i]);
-		}
-	}
-
-	/* Reached the end of the written line */
-	if (rqd->error == NVM_RSP_ERR_EMPTYPAGE) {
-		int pad_secs, nr_error_bits, bit;
-		int ret;
-
-		bit = find_first_bit((void *)&rqd->ppa_status, rqd->nr_ppas);
-		nr_error_bits = rqd->nr_ppas - bit;
-
-		/* Roll back failed sectors */
-		line->cur_sec -= nr_error_bits;
-		line->left_msecs += nr_error_bits;
-		bitmap_clear(line->map_bitmap, line->cur_sec, nr_error_bits);
-
-		pad_secs = pblk_pad_distance(pblk);
-
-		ret = pblk_recov_pad_oob(pblk, line, pad_secs);
-		if (ret)
-			pblk_err(pblk, "OOB padding failed (err:%d)\n", ret);
-
-		ret = pblk_recov_read_oob(pblk, line, p, r_ptr);
-		if (ret)
-			pblk_err(pblk, "OOB read failed (err:%d)\n", ret);
-
-		left_ppas = 0;
-	}
-
-	left_ppas -= rq_ppas;
-	if (left_ppas > 0)
-		goto next_rq;
-
-	return ret;
+	return 0;
 }
 
 static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
-			       struct pblk_recov_alloc p, int *done)
+			       struct pblk_recov_alloc p)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
@@ -517,11 +332,16 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	struct bio *bio;
 	void *data;
 	dma_addr_t dma_ppa_list, dma_meta_list;
-	u64 paddr;
+	__le64 *lba_list;
+	u64 paddr = 0;
+	bool padded = false;
 	int rq_ppas, rq_len;
 	int i, j;
-	int ret = 0;
-	int left_ppas = pblk_calc_sec_in_line(pblk, line);
+	int ret;
+	u64 left_ppas = pblk_sec_in_open_line(pblk, line);
+
+	if (pblk_line_wp_is_unbalanced(pblk, line))
+		pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
 
 	ppa_list = p.ppa_list;
 	meta_list = p.meta_list;
@@ -530,7 +350,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	dma_ppa_list = p.dma_ppa_list;
 	dma_meta_list = p.dma_meta_list;
 
-	*done = 1;
+	lba_list = emeta_to_lbas(pblk, line->emeta->buf);
 
 next_rq:
 	memset(rqd, 0, pblk_g_rq_size);
@@ -558,11 +378,11 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	if (pblk_io_aligned(pblk, rq_ppas))
 		rqd->is_seq = 1;
 
+retry_rq:
 	for (i = 0; i < rqd->nr_ppas; ) {
 		struct ppa_addr ppa;
 		int pos;
 
-		paddr = pblk_alloc_page(pblk, line, pblk->min_write_pgs);
 		ppa = addr_to_gen_ppa(pblk, paddr, line->id);
 		pos = pblk_ppa_to_pos(geo, ppa);
 
@@ -572,9 +392,9 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 			pos = pblk_ppa_to_pos(geo, ppa);
 		}
 
-		for (j = 0; j < pblk->min_write_pgs; j++, i++, paddr++)
+		for (j = 0; j < pblk->min_write_pgs; j++, i++)
 			rqd->ppa_list[i] =
-				addr_to_gen_ppa(pblk, paddr, line->id);
+				addr_to_gen_ppa(pblk, paddr + j, line->id);
 	}
 
 	ret = pblk_submit_io_sync(pblk, rqd);
@@ -586,31 +406,33 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 
 	atomic_dec(&pblk->inflight_io);
 
-	/* Reached the end of the written line */
+	/* If a read fails, do a best effort by padding the line and retrying */
 	if (rqd->error) {
-		int nr_error_bits, bit;
+		int pad_distance, ret;
 
-		bit = find_first_bit((void *)&rqd->ppa_status, rqd->nr_ppas);
-		nr_error_bits = rqd->nr_ppas - bit;
+		if (padded) {
+			pblk_log_read_err(pblk, rqd);
+			return -EINTR;
+		}
 
-		/* Roll back failed sectors */
-		line->cur_sec -= nr_error_bits;
-		line->left_msecs += nr_error_bits;
-		bitmap_clear(line->map_bitmap, line->cur_sec, nr_error_bits);
+		pad_distance = pblk_pad_distance(pblk, line);
+		ret = pblk_recov_pad_line(pblk, line, pad_distance);
+		if (ret)
+			return ret;
 
-		left_ppas = 0;
-		rqd->nr_ppas = bit;
-
-		if (rqd->error != NVM_RSP_ERR_EMPTYPAGE)
-			*done = 0;
+		padded = true;
+		goto retry_rq;
 	}
 
 	for (i = 0; i < rqd->nr_ppas; i++) {
 		u64 lba = le64_to_cpu(meta_list[i].lba);
 
+		lba_list[paddr++] = cpu_to_le64(lba);
+
 		if (lba == ADDR_EMPTY || lba > pblk->rl.nr_secs)
 			continue;
 
+		line->nr_valid_lbas++;
 		pblk_update_map(pblk, lba, rqd->ppa_list[i]);
 	}
 
@@ -618,7 +440,11 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	if (left_ppas > 0)
 		goto next_rq;
 
-	return ret;
+#ifdef CONFIG_NVM_PBLK_DEBUG
+	WARN_ON(padded && !pblk_line_is_full(line));
+#endif
+
+	return 0;
 }
 
 /* Scan line for lbas on out of bound area */
@@ -632,7 +458,7 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 	struct pblk_recov_alloc p;
 	void *data;
 	dma_addr_t dma_ppa_list, dma_meta_list;
-	int done, ret = 0;
+	int ret = 0;
 
 	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_meta_list);
 	if (!meta_list)
@@ -647,7 +473,8 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 		goto free_meta_list;
 	}
 
-	rqd = pblk_alloc_rqd(pblk, PBLK_READ);
+	rqd = mempool_alloc(&pblk->r_rq_pool, GFP_KERNEL);
+	memset(rqd, 0, pblk_g_rq_size);
 
 	p.ppa_list = ppa_list;
 	p.meta_list = meta_list;
@@ -656,24 +483,17 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 	p.dma_ppa_list = dma_ppa_list;
 	p.dma_meta_list = dma_meta_list;
 
-	ret = pblk_recov_scan_oob(pblk, line, p, &done);
+	ret = pblk_recov_scan_oob(pblk, line, p);
 	if (ret) {
-		pblk_err(pblk, "could not recover L2P from OOB\n");
+		pblk_err(pblk, "could not recover L2P form OOB\n");
 		goto out;
 	}
 
-	if (!done) {
-		ret = pblk_recov_scan_all_oob(pblk, line, p);
-		if (ret) {
-			pblk_err(pblk, "could not recover L2P from OOB\n");
-			goto out;
-		}
-	}
-
 	if (pblk_line_is_full(line))
 		pblk_line_recov_close(pblk, line);
 
 out:
+	mempool_free(rqd, &pblk->r_rq_pool);
 	kfree(data);
 free_meta_list:
 	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
@@ -762,7 +582,7 @@ static void pblk_recov_wa_counters(struct pblk *pblk,
 }
 
 static int pblk_line_was_written(struct pblk_line *line,
-			    struct pblk *pblk)
+				 struct pblk *pblk)
 {
 
 	struct pblk_line_meta *lm = &pblk->lm;
@@ -788,6 +608,18 @@ static int pblk_line_was_written(struct pblk_line *line,
 	return 1;
 }
 
+static bool pblk_line_is_open(struct pblk *pblk, struct pblk_line *line)
+{
+	struct pblk_line_meta *lm = &pblk->lm;
+	int i;
+
+	for (i = 0; i < lm->blk_per_line; i++)
+		if (line->chks[i].state & NVM_CHK_ST_OPEN)
+			return true;
+
+	return false;
+}
+
 struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
@@ -898,6 +730,11 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		line->emeta = emeta;
 		memset(line->emeta->buf, 0, lm->emeta_len[0]);
 
+		if (pblk_line_is_open(pblk, line)) {
+			pblk_recov_l2p_from_oob(pblk, line);
+			goto next;
+		}
+
 		if (pblk_line_emeta_read(pblk, line, line->emeta->buf)) {
 			pblk_recov_l2p_from_oob(pblk, line);
 			goto next;
@@ -936,15 +773,20 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			line->smeta = NULL;
 			line->emeta = NULL;
 		} else {
-			if (open_lines > 1)
-				pblk_err(pblk, "failed to recover L2P\n");
+			spin_lock(&line->lock);
+			line->state = PBLK_LINESTATE_OPEN;
+			spin_unlock(&line->lock);
+
+			line->emeta->mem = 0;
+			atomic_set(&line->emeta->sync, 0);
 
 			trace_pblk_line_state(pblk_disk_name(pblk), line->id,
 					line->state);
 
-			open_lines++;
-			line->meta_line = meta_line;
 			data_line = line;
+			line->meta_line = meta_line;
+
+			open_lines++;
 		}
 	}
 
@@ -990,7 +832,7 @@ int pblk_recov_pad(struct pblk *pblk)
 	left_msecs = line->left_msecs;
 	spin_unlock(&l_mg->free_lock);
 
-	ret = pblk_recov_pad_oob(pblk, line, left_msecs);
+	ret = pblk_recov_pad_line(pblk, line, left_msecs);
 	if (ret) {
 		pblk_err(pblk, "tear down padding failed (%d)\n", ret);
 		return ret;
-- 
2.7.4

