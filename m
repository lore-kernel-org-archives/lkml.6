Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F933C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC482086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="y7u1S9jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC482086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeH2MkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:40:19 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:33248 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeH2MkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:40:19 -0400
Received: by mail-ed1-f49.google.com with SMTP id h9-v6so3334562edr.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LhGt7Nv20EEp/EzGapKE4siyAKFCL1bubJrbDTIJDrw=;
        b=y7u1S9jzkWYjcCv61YGSlHsJ3WIMm9DS/2hv21VYaW22xQ8mlb6+Qv1ExMMUxXwnbR
         IQ8HoSHW3yzp2P1a/80K7fmN6JAaiBP0kcLCTXFEJpWpmh+eeXyunzXAS6/Ai2HC/JB8
         6Hws+UhWAA5oVTL3nijLqa2mtK16mNNm+1PlbIe63GpOApFsmSuC4nk8sXQhbrsDDNgD
         rGRLqMttzYZFZjwdUQzEhEceBuCdQL2SuRhX7uNB12UswsH7ksmJxeo6aDKjve2gV6DA
         1CjWSC8UyUaTi3+bBl5lEIwQqhiodK9YnogPQrnCpXAHFEH0zXGuWLW4gySMcXPDLlbY
         sBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LhGt7Nv20EEp/EzGapKE4siyAKFCL1bubJrbDTIJDrw=;
        b=NMG2lAoVSbyhsxqxScm+v6MFNz9p5aRkYh14qLFyoHUG+4PPnbDIgkSnchOmIxCXGA
         /TKrdVf9G1eZby9caIf/N+DmhO9k3a1ex0fn0L2gQm7i/ohSL2+HndEBfUDQ9EwFyLM+
         tqKToG20ytruLvb7zsnNiAZgArD7hSJZWxs+H287IJ4KFjmf+na+GeFx9k48Iwj9taQh
         f8avBX5X7f6micdg00JxYyQ6Hnj1C89cHzyfcVHXLsF+I3lbzwC787Qujyj9qP3Pz5Wh
         Quks4dZGkwglgeey0OOT9y0JOGhl3piy4OwNL+5kamyBitO3r1SE1ioiimrLsDE6CS/m
         sUOQ==
X-Gm-Message-State: APzg51BVnhC5m3VSvdqyyrDRX08xuX3M/TN57gBhRxKSfqeWb6UxYjqo
        5c2cv9c8Jo0+3Qi5sD+Zw7jKpg==
X-Google-Smtp-Source: ANB0VdbnBhO6tIIFiFUi+31KPqKPBDuBQlWXPq9bUepG4/yMUMWX0PPQmeUvik7m8VNpIvrBA7463w==
X-Received: by 2002:aa7:d78c:: with SMTP id s12-v6mr6550953edq.69.1535532268280;
        Wed, 29 Aug 2018 01:44:28 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id g38-v6sm1601812edc.40.2018.08.29.01.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 01:44:27 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: improve line helpers
Date:   Wed, 29 Aug 2018 10:44:18 +0200
Message-Id: <1535532258-24039-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current helper to obtain a line from a ppa returns the line id,
which requires its users to explicitly retrieve the pointer to the line
with the id.

Make 2 different helpers: one returning the line id and one returning
the line directly.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 15 ++++++---------
 drivers/lightnvm/pblk-rb.c    |  2 +-
 drivers/lightnvm/pblk-read.c  |  4 ++--
 drivers/lightnvm/pblk-write.c |  4 ++--
 drivers/lightnvm/pblk.h       | 13 +++++++++----
 5 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 8e3f3c5fe233..dbf037b2b32f 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -35,7 +35,7 @@ static void pblk_line_mark_bb(struct work_struct *work)
 		struct pblk_line *line;
 		int pos;
 
-		line = &pblk->lines[pblk_ppa_to_line(*ppa)];
+		line = pblk_ppa_to_line(pblk, *ppa);
 		pos = pblk_ppa_to_pos(&dev->geo, *ppa);
 
 		pblk_err(pblk, "failed to mark bb, line:%d, pos:%d\n",
@@ -83,7 +83,7 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 	struct pblk_line *line;
 	int pos;
 
-	line = &pblk->lines[pblk_ppa_to_line(rqd->ppa_addr)];
+	line = pblk_ppa_to_line(pblk, rqd->ppa_addr);
 	pos = pblk_ppa_to_pos(geo, rqd->ppa_addr);
 	chunk = &line->chks[pos];
 
@@ -204,7 +204,6 @@ void pblk_map_invalidate(struct pblk *pblk, struct ppa_addr ppa)
 {
 	struct pblk_line *line;
 	u64 paddr;
-	int line_id;
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	/* Callers must ensure that the ppa points to a device address */
@@ -212,8 +211,7 @@ void pblk_map_invalidate(struct pblk *pblk, struct ppa_addr ppa)
 	BUG_ON(pblk_ppa_empty(ppa));
 #endif
 
-	line_id = pblk_ppa_to_line(ppa);
-	line = &pblk->lines[line_id];
+	line = pblk_ppa_to_line(pblk, ppa);
 	paddr = pblk_dev_ppa_to_line_addr(pblk, ppa);
 
 	__pblk_map_invalidate(pblk, line, paddr);
@@ -1493,7 +1491,7 @@ void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa)
 {
 	struct pblk_line *line;
 
-	line = &pblk->lines[pblk_ppa_to_line(ppa)];
+	line = pblk_ppa_to_line(pblk, ppa);
 	kref_put(&line->ref, pblk_line_put_wq);
 }
 
@@ -1759,7 +1757,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 		struct nvm_geo *geo = &dev->geo;
 
 		pblk_err(pblk, "could not async erase line:%d,blk:%d\n",
-					pblk_ppa_to_line(ppa),
+					pblk_ppa_to_line_id(ppa),
 					pblk_ppa_to_pos(geo, ppa));
 	}
 
@@ -2131,8 +2129,7 @@ void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
 
 		/* If the L2P entry maps to a line, the reference is valid */
 		if (!pblk_ppa_empty(ppa) && !pblk_addr_in_cache(ppa)) {
-			int line_id = pblk_ppa_to_line(ppa);
-			struct pblk_line *line = &pblk->lines[line_id];
+			struct pblk_line *line = pblk_ppa_to_line(pblk, ppa);
 
 			kref_get(&line->ref);
 		}
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index f6eec0212dfc..a7648e12f54f 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -225,7 +225,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int to_update)
 		pblk_update_map_dev(pblk, w_ctx->lba, w_ctx->ppa,
 							entry->cacheline);
 
-		line = &pblk->lines[pblk_ppa_to_line(w_ctx->ppa)];
+		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
 		kref_put(&line->ref, pblk_line_put);
 		clean_wctx(w_ctx);
 		rb->l2p_update = (rb->l2p_update + 1) & (rb->nr_entries - 1);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 97d602f153e2..6d13763f2f6a 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -249,9 +249,9 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 	i = 0;
 	hole = find_first_zero_bit(read_bitmap, nr_secs);
 	do {
-		int line_id = pblk_ppa_to_line(rqd->ppa_list[i]);
-		struct pblk_line *line = &pblk->lines[line_id];
+		struct pblk_line *line;
 
+		line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
 		kref_put(&line->ref, pblk_line_put);
 
 		meta_list[hole].lba = lba_list_media[i];
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index a3c77092ad3f..8ea66bb83c29 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -148,7 +148,7 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
 	u64 paddr;
 	int done = 0;
 
-	line = &pblk->lines[pblk_ppa_to_line(*ppa)];
+	line = pblk_ppa_to_line(pblk, *ppa);
 	spin_lock(&line->lock);
 
 	while (!done)  {
@@ -198,7 +198,7 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		/* Decrese the reference count to the line as we will
 		 * re-map these entries
 		 */
-		line = &pblk->lines[pblk_ppa_to_line(w_ctx->ppa)];
+		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
 		kref_put(&line->ref, pblk_line_put);
 
 		pos = (pos + 1) & (rb->nr_entries - 1);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 23e6b3528852..6195e3f5d2e6 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -994,11 +994,17 @@ static inline int pblk_pad_distance(struct pblk *pblk)
 	return geo->mw_cunits * geo->all_luns * geo->ws_opt;
 }
 
-static inline int pblk_ppa_to_line(struct ppa_addr p)
+static inline int pblk_ppa_to_line_id(struct ppa_addr p)
 {
 	return p.a.blk;
 }
 
+static inline struct pblk_line *pblk_ppa_to_line(struct pblk *pblk,
+						 struct ppa_addr p)
+{
+	return &pblk->lines[pblk_ppa_to_line_id(p)];
+}
+
 static inline int pblk_ppa_to_pos(struct nvm_geo *geo, struct ppa_addr p)
 {
 	return p.a.lun * geo->num_ch + p.a.ch;
@@ -1049,7 +1055,7 @@ static inline struct nvm_chk_meta *pblk_dev_ppa_to_chunk(struct pblk *pblk,
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct pblk_line *line = &pblk->lines[pblk_ppa_to_line(p)];
+	struct pblk_line *line = pblk_ppa_to_line(pblk, p);
 	int pos = pblk_ppa_to_pos(geo, p);
 
 	return &line->chks[pos];
@@ -1391,8 +1397,7 @@ static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
 		int i;
 
 		for (i = 0; i < rqd->nr_ppas; i++) {
-			ppa = ppa_list[i];
-			line = &pblk->lines[pblk_ppa_to_line(ppa)];
+			line = pblk_ppa_to_line(pblk, ppa_list[i]);
 
 			spin_lock(&line->lock);
 			if (line->state != PBLK_LINESTATE_OPEN) {
-- 
2.7.4

