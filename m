Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5E4C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5ECE2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="l8XbY/U9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5ECE2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeLKTR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:26 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40350 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbeLKTRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:22 -0500
Received: by mail-lj1-f177.google.com with SMTP id n18-v6so14035739lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wU5IGf/IyJdy8E6pFE20BoISwxjYZEejL799cEuLgMo=;
        b=l8XbY/U90YceqUUbbdJ8jZ3AimHblgIxtbTOSxh71p+RjIKxtiWaEgLpyvQmL1j6B1
         bxhkcbxGTHjWGGYkebIZfTZZakEqD4bCtHNm62qfsm/gjXjkb/dVouYYWv4ZXrN0AYUg
         A8lKzr/Kpd50Q6fEa8U7UifuDmdZKKS1kyoSs/Bopz08pzB2hERpjLUZrHdjbqOg3b6Q
         D0oHqk3Psc2KgfE8QLT2FCi7g0wIW8idFQbvima6gT9sLQ7Tum5K5L0ctezVTaGZk0Yn
         SiZg8SCE4DQ1kPebeqpRrMxw9MKVGVpydxwSgPkVyGNxjBhVHRVZvezxEHOWYBYpRgAd
         PgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wU5IGf/IyJdy8E6pFE20BoISwxjYZEejL799cEuLgMo=;
        b=Mxbm8YmPs45Aby7yYnab3sPxDGuGnXDkaf4UypGml71ZAOqYxmYcYH8AjVWRBcj19d
         m3hO9BFJ0pJ2KTe7yvFwAGiMYOqBX3zlZhCd0aap2BfbzQkDsOB6sgYyYG4ddaFy3b+c
         m99DMZ8r3LFy1Jei7uRkPQulX2wakeqzzx90MTL/1jJPL8vT3SOgzviedTjlHB+ZrMbE
         Ao7NT4UuOBsUmMFoi8kWR9dRq+ul31SuIwhqsvqcDFaB+q9LdbexoYTIkIYdZWPdxv/o
         SmF4YfvuwSiieiOV3w9RLnlqt8+DuQnuZz6By0ePhwitNTYyiVJDi5HGgtWPiJdbWm1P
         TOgg==
X-Gm-Message-State: AA+aEWY0OdSeq7F1ZE4+UEGqVz3g47+OR8EncNNTfhqEGAluVJ9fhb2/
        Hxo5wErLL1vR5bE6ucVpQQCC0A==
X-Google-Smtp-Source: AFSGD/XgcqFzcTWqOriOaX7BJKHTfC1QNrMBG4R3B2qaiu2/ykO1/UlrGbHKke70Yn9/BMZkzSqehg==
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr10465788ljj.49.1544555839929;
        Tue, 11 Dec 2018 11:17:19 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:19 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 16/21] lightnvm: pblk: move lba list to partial read context
Date:   Tue, 11 Dec 2018 20:16:22 +0100
Message-Id: <20181211191627.15542-17-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

Currently DMA allocated memory is reused on partial read
for lba_list_mem and lba_list_media arrays. In preparation
for dynamic DMA pool sizes we need to move this arrays
into pblk_pr_ctx structures.

Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c | 20 +++++---------------
 drivers/lightnvm/pblk.h      |  2 ++
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 9fba614adeeb..19917d3c19b3 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -224,7 +224,6 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 	unsigned long *read_bitmap = pr_ctx->bitmap;
 	int nr_secs = pr_ctx->orig_nr_secs;
 	int nr_holes = nr_secs - bitmap_weight(read_bitmap, nr_secs);
-	__le64 *lba_list_mem, *lba_list_media;
 	void *src_p, *dst_p;
 	int hole, i;
 
@@ -237,13 +236,9 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 		rqd->ppa_list[0] = ppa;
 	}
 
-	/* Re-use allocated memory for intermediate lbas */
-	lba_list_mem = (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
-	lba_list_media = (((void *)rqd->ppa_list) + 2 * pblk_dma_ppa_size);
-
 	for (i = 0; i < nr_secs; i++) {
-		lba_list_media[i] = meta_list[i].lba;
-		meta_list[i].lba = lba_list_mem[i];
+		pr_ctx->lba_list_media[i] = meta_list[i].lba;
+		meta_list[i].lba = pr_ctx->lba_list_mem[i];
 	}
 
 	/* Fill the holes in the original bio */
@@ -255,7 +250,7 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 		line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
 		kref_put(&line->ref, pblk_line_put);
 
-		meta_list[hole].lba = lba_list_media[i];
+		meta_list[hole].lba = pr_ctx->lba_list_media[i];
 
 		src_bv = new_bio->bi_io_vec[i++];
 		dst_bv = bio->bi_io_vec[bio_init_idx + hole];
@@ -295,13 +290,9 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
 	struct pblk_pr_ctx *pr_ctx;
 	struct bio *new_bio, *bio = r_ctx->private;
-	__le64 *lba_list_mem;
 	int nr_secs = rqd->nr_ppas;
 	int i;
 
-	/* Re-use allocated memory for intermediate lbas */
-	lba_list_mem = (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
-
 	new_bio = bio_alloc(GFP_KERNEL, nr_holes);
 
 	if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
@@ -312,12 +303,12 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 		goto fail_free_pages;
 	}
 
-	pr_ctx = kmalloc(sizeof(struct pblk_pr_ctx), GFP_KERNEL);
+	pr_ctx = kzalloc(sizeof(struct pblk_pr_ctx), GFP_KERNEL);
 	if (!pr_ctx)
 		goto fail_free_pages;
 
 	for (i = 0; i < nr_secs; i++)
-		lba_list_mem[i] = meta_list[i].lba;
+		pr_ctx->lba_list_mem[i] = meta_list[i].lba;
 
 	new_bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
@@ -325,7 +316,6 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 	rqd->bio = new_bio;
 	rqd->nr_ppas = nr_holes;
 
-	pr_ctx->ppa_ptr = NULL;
 	pr_ctx->orig_bio = bio;
 	bitmap_copy(pr_ctx->bitmap, read_bitmap, NVM_MAX_VLBA);
 	pr_ctx->bio_init_idx = bio_init_idx;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index e5b88a25d4d6..0e9d3960ac4c 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -132,6 +132,8 @@ struct pblk_pr_ctx {
 	unsigned int bio_init_idx;
 	void *ppa_ptr;
 	dma_addr_t dma_ppa_list;
+	__le64 lba_list_mem[NVM_MAX_VLBA];
+	__le64 lba_list_media[NVM_MAX_VLBA];
 };
 
 /* Pad context */
-- 
2.17.1

