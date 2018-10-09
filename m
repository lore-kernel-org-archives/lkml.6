Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7E1C677EC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D64214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="y2HST959"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D64214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJISaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:30:21 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:36035 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbeJISaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:21 -0400
Received: by mail-pg1-f169.google.com with SMTP id f18-v6so657342pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LdthOGfSxOQcK2tkE505Bz/pVIbRjjEabjNYbvM1YsU=;
        b=y2HST9596jyAccwgByMhpqbDDeW8O0YUHhNNlFW4P9tqf+32f5xoG9szA3NUZz/ICJ
         5wGgeMHutklqJFE3Pppxa65kZIghL07Nr/UFBGhv3bPcjA2NeZzVYDcscvUOIosB4nXq
         ekUj4WEzNFlxU+4MFq1gkT6/1Ynipptgmm58UtIi05Abec2GKBIk9ba6hMfcp82+xhDO
         jh9MyXjx3E5u+oRslEsd+TZNXNQlD1P4BO7KYDLIMqBXAMZkp8nj6f7O1F1tQlGN16zl
         OfXR2XnySE8fg2NP0VRHmDKWl07TRXGWNVdphpSxd7vCUIGd9O7uxVC40VRjNxZfkZyD
         lxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LdthOGfSxOQcK2tkE505Bz/pVIbRjjEabjNYbvM1YsU=;
        b=XhUkV6/LB6Bq2ISHOjpxVD6+Znc66aSGqNjA8iVFKDLBBo8PgZTb08KFqJu2R/vmiy
         sew3H3V4U0iSlnnJwA11NwkSovzbLSsra1Nq8ZfjQ1R3HH2EH9AUkpi/0SgMMzm1y8YE
         X/2FLmhLMObxsCDN77MF1WyI9gIAGjXBCphFM/w+IDXNMFBZV6lJpdCCc3AbcU2CIpW9
         Om/b7V5vtDefFE4Bus0AklHjXu0u2yuB5bOA25+BcLcfFevn5/TChujpyp6aWb0wzIAY
         sp/ZAUsD+AiVLdnQ1sPOC4cfHCPjZgTLo05e0P/hwVSKFBnnPXhNC6grTg/RLXVAHjO0
         trqw==
X-Gm-Message-State: ABuFfoiESArQ15mUQ9GtgaiDgJnXkLe1GnZYkE0dwBMxNm4DDfCS8gXc
        H0c6+/xYFmPGRWT/NdYfZZAHww==
X-Google-Smtp-Source: ACcGV624UmI1TrdJ6aUiAGIErZhzujAiq+W+TLyLjyBuz2hg0nTHLwHmgdHmqe7LwPob2AZ85p5JJQ==
X-Received: by 2002:a65:4301:: with SMTP id j1-v6mr25122465pgq.279.1539083633993;
        Tue, 09 Oct 2018 04:13:53 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:13:52 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 12/45] lightnvm: pblk: improve line helpers
Date:   Tue,  9 Oct 2018 13:11:42 +0200
Message-Id: <20181009111215.7653-13-mb@lightnvm.io>
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

The current helper to obtain a line from a ppa returns the line id,
which requires its users to explicitly retrieve the pointer to the line
with the id.

Make 2 different helpers: one returning the line id and one returning
the line directly.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c  | 15 ++++++---------
 drivers/lightnvm/pblk-rb.c    |  2 +-
 drivers/lightnvm/pblk-read.c  |  4 ++--
 drivers/lightnvm/pblk-write.c |  4 ++--
 drivers/lightnvm/pblk.h       | 13 +++++++++----
 5 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 5f99cf396072..36ac9eff8ebd 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -32,7 +32,7 @@ static void pblk_line_mark_bb(struct work_struct *work)
 		struct pblk_line *line;
 		int pos;
 
-		line = &pblk->lines[pblk_ppa_to_line(*ppa)];
+		line = pblk_ppa_to_line(pblk, *ppa);
 		pos = pblk_ppa_to_pos(&dev->geo, *ppa);
 
 		pblk_err(pblk, "failed to mark bb, line:%d, pos:%d\n",
@@ -80,7 +80,7 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 	struct pblk_line *line;
 	int pos;
 
-	line = &pblk->lines[pblk_ppa_to_line(rqd->ppa_addr)];
+	line = pblk_ppa_to_line(pblk, rqd->ppa_addr);
 	pos = pblk_ppa_to_pos(geo, rqd->ppa_addr);
 	chunk = &line->chks[pos];
 
@@ -192,7 +192,6 @@ void pblk_map_invalidate(struct pblk *pblk, struct ppa_addr ppa)
 {
 	struct pblk_line *line;
 	u64 paddr;
-	int line_id;
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	/* Callers must ensure that the ppa points to a device address */
@@ -200,8 +199,7 @@ void pblk_map_invalidate(struct pblk *pblk, struct ppa_addr ppa)
 	BUG_ON(pblk_ppa_empty(ppa));
 #endif
 
-	line_id = pblk_ppa_to_line(ppa);
-	line = &pblk->lines[line_id];
+	line = pblk_ppa_to_line(pblk, ppa);
 	paddr = pblk_dev_ppa_to_line_addr(pblk, ppa);
 
 	__pblk_map_invalidate(pblk, line, paddr);
@@ -1430,7 +1428,7 @@ void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa)
 {
 	struct pblk_line *line;
 
-	line = &pblk->lines[pblk_ppa_to_line(ppa)];
+	line = pblk_ppa_to_line(pblk, ppa);
 	kref_put(&line->ref, pblk_line_put_wq);
 }
 
@@ -1688,7 +1686,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 		struct nvm_geo *geo = &dev->geo;
 
 		pblk_err(pblk, "could not async erase line:%d,blk:%d\n",
-					pblk_ppa_to_line(ppa),
+					pblk_ppa_to_line_id(ppa),
 					pblk_ppa_to_pos(geo, ppa));
 	}
 
@@ -2059,8 +2057,7 @@ void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
 
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
index ad1d7713bbda..49744caaa300 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -252,9 +252,9 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
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
index df99c45778d4..c23b65aaa27b 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -113,7 +113,7 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
 	u64 paddr;
 	int done = 0;
 
-	line = &pblk->lines[pblk_ppa_to_line(*ppa)];
+	line = pblk_ppa_to_line(pblk, *ppa);
 	spin_lock(&line->lock);
 
 	while (!done)  {
@@ -171,7 +171,7 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		/* Decrese the reference count to the line as we will
 		 * re-map these entries
 		 */
-		line = &pblk->lines[pblk_ppa_to_line(w_ctx->ppa)];
+		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
 		kref_put(&line->ref, pblk_line_put);
 
 		pos = (pos + 1) & (rb->nr_entries - 1);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index f95fe75fef6e..af9477b7e803 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -984,11 +984,17 @@ static inline int pblk_pad_distance(struct pblk *pblk)
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
@@ -1039,7 +1045,7 @@ static inline struct nvm_chk_meta *pblk_dev_ppa_to_chunk(struct pblk *pblk,
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct pblk_line *line = &pblk->lines[pblk_ppa_to_line(p)];
+	struct pblk_line *line = pblk_ppa_to_line(pblk, p);
 	int pos = pblk_ppa_to_pos(geo, p);
 
 	return &line->chks[pos];
@@ -1371,8 +1377,7 @@ static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
 		int i;
 
 		for (i = 0; i < rqd->nr_ppas; i++) {
-			ppa = ppa_list[i];
-			line = &pblk->lines[pblk_ppa_to_line(ppa)];
+			line = pblk_ppa_to_line(pblk, ppa_list[i]);
 
 			spin_lock(&line->lock);
 			if (line->state != PBLK_LINESTATE_OPEN) {
-- 
2.17.1

