Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC049C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9816120866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="kfFpqdaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9816120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeIKQem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:34:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40268 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeIKQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:34:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so18983091edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 04:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xbgo1LGVQwAYYKdtkjbMKXFZCrRnyHLRtcvNkoiVhWQ=;
        b=kfFpqdaYXMD32gkLh9IOQnrs/CKASbcJ0sthHJRmeSCXsBHHpYoJkiLlGBVAj7Aac/
         E6T0/ZmJqsEQvnd5wAAEVoHBqdWUZhU0Xt7LsjKZuHbL58rcWNSe/Qm0R/cmuk3xPkIi
         Ll0v/tJxCxdAlB+dj2P7ns4xuTtcOQ4/ZyulvDWN+ScDDJKsjmxA/PV2dRPaNJzgKq7v
         KupHEfbFk5S2HXNZHeMfIlvVxuGN0E5lVSo1zmX7uoOpNnq8G0yw267GIemztt88AsYt
         jvKKinV6gniKCXdRfZRRrfx6fn+3VxpLdptfUwoqv/WlT1sCTPei96Pxf384aNttFUSP
         AxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbgo1LGVQwAYYKdtkjbMKXFZCrRnyHLRtcvNkoiVhWQ=;
        b=rQLVe/ip05wsBScxc0xlVk8THkPGyqGhyRTOKFpsK3mMyNZsV5eYJIUMrFu4csQUMb
         Uq2aIPuATWowpMtxJ9sm+11YULiP7zOb3AvcHdnZGo718kfjST7GGIcrpnBcwsobvbGA
         X/rHxp7BBixA5f8PYBGh5PXwobiN2AHmHgmKpJNqOFKHcvUmJZPOmGGf2itueShsww2U
         iZiclGcgriBO6tWDW6C2XjQVzsRLKVBNm/TOYnvxWWTKgl+Q+5MXbB6QmhKtgIktzttU
         YsdpDbuCP1PcmYtsQNsqOrD338ByGsLU7ipP6og6SXxZKOl3HzPfk+tB91cVtvk6bM4L
         jxcg==
X-Gm-Message-State: APzg51CZeigmMtWpypRxZimrijFmHgqZ3k5Liv6Y6BEYqLPIorHjV/uK
        b/x+eKnbXlyIpaR+gsx9UQK9G9xcND8=
X-Google-Smtp-Source: ANB0VdbwOyppuwwr/tYHAbT7nwOZJE9174zBCIl8bGjwdFCzCSkHfD9KyyRuahvVrEu6TA/hJqJQqg==
X-Received: by 2002:a50:f0c2:: with SMTP id a2-v6mr29041235edm.90.1536665741841;
        Tue, 11 Sep 2018 04:35:41 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id n15-v6sm10934976edn.44.2018.09.11.04.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Sep 2018 04:35:41 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/2] lightnvm: pblk: retrieve chunk metadata on erase
Date:   Tue, 11 Sep 2018 13:35:34 +0200
Message-Id: <1536665734-14305-3-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536665734-14305-1-git-send-email-javier@cnexlabs.com>
References: <1536665734-14305-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the OCSSD 2.0 spec, the device populates the metadata pointer (if
provided) when a chunk is reset. Implement this path in pblk and use it
for sanity chunk checks.

For 1.2, reset the write pointer and the state on core so that the erase
path is transparent to pblk wrt OCSSD version.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c      | 44 ++++++++++++++++++++++++++++++++++++--
 drivers/lightnvm/pblk-core.c | 51 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 80 insertions(+), 15 deletions(-)

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
index 417d12b274da..80f0ec756672 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -79,7 +79,7 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct nvm_chk_meta *chunk;
+	struct nvm_chk_meta *chunk, *dev_chunk;
 	struct pblk_line *line;
 	int pos;
 
@@ -89,22 +89,39 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 
 	atomic_dec(&line->left_seblks);
 
+	/* pblk submits a single erase per command */
+	dev_chunk = rqd->meta_list;
+
+	if (dev_chunk->slba != chunk->slba || dev_chunk->wp)
+		print_chunk(pblk, chunk, "corrupted erase chunk", 0);
+
+	memcpy(chunk, dev_chunk, sizeof(struct nvm_chk_meta));
+
 	if (rqd->error) {
 		trace_pblk_chunk_reset(pblk_disk_name(pblk),
 				&rqd->ppa_addr, PBLK_CHUNK_RESET_FAILED);
 
-		chunk->state = NVM_CHK_ST_OFFLINE;
+#ifdef CONFIG_NVM_PBLK_DEBUG
+		if (chunk->state != NVM_CHK_ST_OFFLINE)
+			print_chunk(pblk, chunk,
+					"corrupted erase chunk state", 0);
+#endif
 		pblk_mark_bb(pblk, line, rqd->ppa_addr);
 	} else {
 		trace_pblk_chunk_reset(pblk_disk_name(pblk),
 				&rqd->ppa_addr, PBLK_CHUNK_RESET_DONE);
 
-		chunk->state = NVM_CHK_ST_FREE;
+#ifdef CONFIG_NVM_PBLK_DEBUG
+		if (chunk->state != NVM_CHK_ST_FREE)
+			print_chunk(pblk, chunk,
+					"corrupted erase chunk state", 0);
+#endif
 	}
 
 	trace_pblk_chunk_state(pblk_disk_name(pblk), &rqd->ppa_addr,
 				chunk->state);
 
+	pblk_free_rqd_meta(pblk, rqd);
 	atomic_dec(&pblk->inflight_io);
 }
 
@@ -952,14 +969,16 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
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
@@ -967,10 +986,12 @@ static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
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
@@ -1774,11 +1795,15 @@ void pblk_line_put_wq(struct kref *ref)
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
@@ -1789,8 +1814,8 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 	/* The write thread schedules erases so that it minimizes disturbances
 	 * with writes. Thus, there is no need to take the LUN semaphore.
 	 */
-	err = pblk_submit_io(pblk, rqd);
-	if (err) {
+	ret = pblk_submit_io(pblk, rqd);
+	if (ret) {
 		struct nvm_tgt_dev *dev = pblk->dev;
 		struct nvm_geo *geo = &dev->geo;
 
@@ -1799,7 +1824,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 					pblk_ppa_to_pos(geo, ppa));
 	}
 
-	return err;
+	return ret;
 }
 
 struct pblk_line *pblk_line_get_data(struct pblk *pblk)
-- 
2.7.4

