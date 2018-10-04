Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74C4C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE2D21477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Arw3DpS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE2D21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeJDOF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:05:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41148 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbeJDOF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:05:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id f38-v6so7573190edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jyy4AEhaHgBsFcjUA5m834ykTX5xZo5pflcdsfAujAM=;
        b=Arw3DpS8exWSwk4ItYtZw5reDtWVW82nT5ixpLSHvYCFl4ERsmIALEmwtyPQfRtl8r
         c1kv43s4eLmtE3If5YYcYtenrx0gVQNZ3O+p2b/+mCu/wDDw0l9ghMcn/LfydVGt7ETm
         afTNZ6r2Hft0JyRHomzcAa/oIi1zKdRauPZ7kuRSB2aePckUTJMRCi39zUYb/rkZBCXC
         gUg6n0vDRGZca8yV7U3O7YxdynHCckgYCH8IgyQm0UPx3LJ17r7hDA8D7rArJV90BHTT
         g1lwFtPvoakfheH+S/+kpPZyMEDX5RseJVsE230hi7TQCAL7kQq1I5M95z4ytZB0H/rI
         0Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jyy4AEhaHgBsFcjUA5m834ykTX5xZo5pflcdsfAujAM=;
        b=hFOz9WQj8YJ30GF95wMxsHx6doiqoB9O0D3J2j3W4BGSHsN+ss0u0FKIXJIS5uu8kf
         nApP9LXLaXvn800O7u9NMyZsGIbMn/tSQET+fGJuJdva24ulzYM3OXxfLN+QSaGVbPZP
         x/f+SB3jwbiKtkqZIlAMEfdXHNcDWeTG6sKGXLbG8obMOACPfZQAYfveNqe3pN+ntdT7
         JPxDfiOMIzLabPv+UvhcuNilz8TZW3m166vxcGrtYSObSmgawPuSzGrPTbWqzuJ/tVtH
         0HqR4vd+T17bJRjeBi9aFYxpHUn5Xo4llvINWj3oUum9bxYqquDipTYJM5TGsS+q/fuF
         6Afg==
X-Gm-Message-State: ABuFfogJe1C6DqbsFK9j5Cx0328nhO7zF4ocZl688teiEfYYJAmA62kN
        K8VhxiHWSxwJWqNO6XlMmCE90w==
X-Google-Smtp-Source: ACcGV60sIIiBi9RPSqZeNXla/o2EpbFHswaz9xg7L5MnfqhJyJ836h1ndkP1txERoaiSzennQL8+VA==
X-Received: by 2002:a50:be8d:: with SMTP id b13-v6mr6658596edk.157.1538637244273;
        Thu, 04 Oct 2018 00:14:04 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id f39-v6sm1297462ede.75.2018.10.04.00.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 00:14:03 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/2] lightnvm: pblk: retrieve chunk metadata on erase
Date:   Thu,  4 Oct 2018 09:13:55 +0200
Message-Id: <1538637235-25469-3-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>
References: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the OCSSD 2.0 spec, the device populates the metadata pointer (if
provided) when a chunk is reset. Implement this path in pblk. This is
the base for implementing wear-leveling and supporting variable size
chunks (e.g., due to the device mapping out certain sectors).

For 1.2, reset the write pointer and the state on core so that the erase
path is transparent to pblk wrt OCSSD version.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c      | 44 ++++++++++++++++++++++++++++++++++--
 drivers/lightnvm/pblk-core.c | 54 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index efb976a863d2..dceaae4e795f 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -750,9 +750,40 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 }
 EXPORT_SYMBOL(nvm_submit_io);
 
+/* Take only addresses in generic format */
+static void nvm_set_chunk_state_12(struct nvm_dev *dev, struct nvm_rq *rqd)
+{
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
+	int i;
+
+	for (i = 0; i < rqd->nr_ppas; i++) {
+		struct ppa_addr ppa;
+		struct nvm_chk_meta *chunk;
+
+		chunk = ((struct nvm_chk_meta *)rqd->meta_list) + i;
+
+		if (rqd->error)
+			chunk->state = NVM_CHK_ST_OFFLINE;
+		else
+			chunk->state = NVM_CHK_ST_FREE;
+
+		chunk->wp = 0;
+		chunk->wi = 0;
+		chunk->type = NVM_CHK_TP_W_SEQ;
+		chunk->cnlb = dev->geo.clba;
+
+		/* recalculate slba for the chunk */
+		ppa = ppa_list[i];
+		ppa.g.pg = ppa.g.pl = ppa.g.sec = 0;
+
+		chunk->slba = generic_to_dev_addr(dev, ppa).ppa;
+	}
+}
+
 int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
+	struct nvm_geo *geo = &dev->geo;
 	int ret;
 
 	if (!dev->ops->submit_io_sync)
@@ -765,8 +796,12 @@ int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 
 	/* In case of error, fail with right address format */
 	ret = dev->ops->submit_io_sync(dev, rqd);
+
 	nvm_rq_dev_to_tgt(tgt_dev, rqd);
 
+	if (geo->version == NVM_OCSSD_SPEC_12 && rqd->opcode == NVM_OP_ERASE)
+		nvm_set_chunk_state_12(dev, rqd);
+
 	return ret;
 }
 EXPORT_SYMBOL(nvm_submit_io_sync);
@@ -775,10 +810,15 @@ void nvm_end_io(struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *tgt_dev = rqd->dev;
 
-	/* Convert address space */
-	if (tgt_dev)
+	if (tgt_dev) {
+		/* Convert address space */
 		nvm_rq_dev_to_tgt(tgt_dev, rqd);
 
+		if (tgt_dev->geo.version == NVM_OCSSD_SPEC_12 &&
+						rqd->opcode == NVM_OP_ERASE)
+			nvm_set_chunk_state_12(tgt_dev->parent, rqd);
+	}
+
 	if (rqd->end_io)
 		rqd->end_io(rqd);
 }
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6944aac43b01..2507c4838283 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -80,7 +80,7 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct nvm_chk_meta *chunk;
+	struct nvm_chk_meta *chunk, *dev_chunk;
 	struct pblk_line *line;
 	int pos;
 
@@ -90,22 +90,42 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 
 	atomic_dec(&line->left_seblks);
 
+	/* pblk submits a single erase per command */
+	dev_chunk = rqd->meta_list;
+
+	chunk->state = dev_chunk->state;
+	chunk->type = dev_chunk->type;
+	chunk->wi = dev_chunk->wi;
+	chunk->cnlb = dev_chunk->cnlb;
+	chunk->wp = dev_chunk->wp;
+
 	if (rqd->error) {
 		trace_pblk_chunk_reset(pblk_disk_name(pblk),
 				&rqd->ppa_addr, PBLK_CHUNK_RESET_FAILED);
 
-		chunk->state = NVM_CHK_ST_OFFLINE;
+#ifdef CONFIG_NVM_PBLK_DEBUG
+		if (chunk->state != NVM_CHK_ST_OFFLINE)
+			print_chunk(pblk, chunk,
+				"corrupted erase chunk state", rqd->error);
+#endif
+
 		pblk_mark_bb(pblk, line, rqd->ppa_addr);
 	} else {
 		trace_pblk_chunk_reset(pblk_disk_name(pblk),
 				&rqd->ppa_addr, PBLK_CHUNK_RESET_DONE);
 
-		chunk->state = NVM_CHK_ST_FREE;
+#ifdef CONFIG_NVM_PBLK_DEBUG
+		if (chunk->state != NVM_CHK_ST_FREE || chunk->wp ||
+						dev_chunk->slba != chunk->slba)
+			print_chunk(pblk, chunk,
+				"corrupted erase chunk state", rqd->error);
+#endif
 	}
 
 	trace_pblk_chunk_state(pblk_disk_name(pblk), &rqd->ppa_addr,
 				chunk->state);
 
+	pblk_free_rqd_meta(pblk, rqd);
 	atomic_dec(&pblk->inflight_io);
 }
 
@@ -923,14 +943,16 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 	return ret;
 }
 
-static void pblk_setup_e_rq(struct pblk *pblk, struct nvm_rq *rqd,
-			    struct ppa_addr ppa)
+static int pblk_setup_e_rq(struct pblk *pblk, struct nvm_rq *rqd,
+			   struct ppa_addr ppa)
 {
 	rqd->opcode = NVM_OP_ERASE;
 	rqd->ppa_addr = ppa;
 	rqd->nr_ppas = 1;
 	rqd->is_seq = 1;
 	rqd->bio = NULL;
+
+	return pblk_alloc_rqd_meta(pblk, rqd);
 }
 
 static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
@@ -938,10 +960,12 @@ static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
 	struct nvm_rq rqd = {NULL};
 	int ret;
 
+	ret = pblk_setup_e_rq(pblk, &rqd, ppa);
+	if (ret)
+		return ret;
+
 	trace_pblk_chunk_reset(pblk_disk_name(pblk), &ppa,
-				PBLK_CHUNK_RESET_START);
-
-	pblk_setup_e_rq(pblk, &rqd, ppa);
+						PBLK_CHUNK_RESET_START);
 
 	/* The write thread schedules erases so that it minimizes disturbances
 	 * with writes. Thus, there is no need to take the LUN semaphore.
@@ -1746,11 +1770,15 @@ void pblk_line_put_wq(struct kref *ref)
 int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 {
 	struct nvm_rq *rqd;
-	int err;
+	int ret;
 
 	rqd = pblk_alloc_rqd(pblk, PBLK_ERASE);
 
-	pblk_setup_e_rq(pblk, rqd, ppa);
+	ret = pblk_setup_e_rq(pblk, rqd, ppa);
+	if (ret) {
+		pblk_free_rqd(pblk, rqd, PBLK_ERASE);
+		return ret;
+	}
 
 	rqd->end_io = pblk_end_io_erase;
 	rqd->private = pblk;
@@ -1761,8 +1789,8 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 	/* The write thread schedules erases so that it minimizes disturbances
 	 * with writes. Thus, there is no need to take the LUN semaphore.
 	 */
-	err = pblk_submit_io(pblk, rqd);
-	if (err) {
+	ret = pblk_submit_io(pblk, rqd);
+	if (ret) {
 		struct nvm_tgt_dev *dev = pblk->dev;
 		struct nvm_geo *geo = &dev->geo;
 
@@ -1771,7 +1799,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 					pblk_ppa_to_pos(geo, ppa));
 	}
 
-	return err;
+	return ret;
 }
 
 struct pblk_line *pblk_line_get_data(struct pblk *pblk)
-- 
2.7.4

