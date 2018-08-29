Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A456C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64652083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="qIzPA0bQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64652083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeH2QUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:20:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44151 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbeH2QUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:20:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id s10-v6so3757298edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wd6ju+Sj812p5ByhVH0axrtjEx4TVCFUhWAzZE7kqEw=;
        b=qIzPA0bQXyNgjNTrtOKifSD0zdslXCpsZvF+bkEaSONuPWXRkydNhAjsaWCsRw2jWc
         XCPPhKt/SxRPRSdQxvH+qqnXafETwXBhFaS5ywVfGLvaanhAvu90LG3+34ImcymlH0Ag
         7JJDf3sDQ2EEdl3cd3+Pa+DB+vMs/Ty2M1f5YYEqwB9KO73+SLgHTanye9gs3Oh/Ggm4
         LcttKgD+959fLOIgoRafD/53KBALcLb5n26tcjfbC9Dy61Hmf7CSVGwtNbexuOUA1bre
         3yzSJkoodzt4wQ6VrpahBgtOO25VpLpxdhKw3zM41kbUy0bc1JbBNbY9Ai8HpVx1UWOM
         fLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wd6ju+Sj812p5ByhVH0axrtjEx4TVCFUhWAzZE7kqEw=;
        b=npAvI9y0djplt4ctsEjWfc013x6z3K54kfoMplaentam8ZnUPecsMyfyebubUCbR1V
         qhLNx9KWKAPan8nMctVXUB72joUK/b+oA27kZfg2U4edfGUD00pFSW0jrxHASCBkAjxj
         BT9K4SfkksBEuzSxs6ChKhTIlJ90rKypSbuaXNp0hN9dZo3HX+nvJaJS9MVj0hQlyoJT
         mXKg+uGdBkT7oCmZR974IPC6OQoFb2x8H/yoeT0j+ECzP7MW/uTq5x+8pO4DcFLLByZY
         YP9CVs3pBYwpuYxg730O2h/+QetWU02XTw9oOWHaRp0Eh08WWKEqwmpIKxOuJqkyFcZ1
         UoAw==
X-Gm-Message-State: APzg51A+NIxk3u1A8UPeEKpRqLh1BOR+rPXXK9kOMam+/AEOSCv7WUoE
        SD9DQQDz3F9FJDDpIqznb5ghHA==
X-Google-Smtp-Source: ANB0VdZD7GouwO7N0cfZYacQcNFQbeF8s7QYSvEoXvkqDz6DHT5/uQocDYy5v9QHzj4HS0N+367acg==
X-Received: by 2002:a50:8cd7:: with SMTP id r23-v6mr7407214edr.240.1535545435062;
        Wed, 29 Aug 2018 05:23:55 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id f26-v6sm1752068edb.28.2018.08.29.05.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 05:23:54 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 3/7] lightnvm: pblk: allocate line map bitmaps using a mempool
Date:   Wed, 29 Aug 2018 14:23:30 +0200
Message-Id: <1535545414-550-4-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Line map bitmap allocations are fairly large and can fail. Allocation
failures are fatal to pblk, stoping the write pipeline. To avoid this,
allocate the bitmaps using a mempool instead.

Mempool allocations never fail if called from a process context,
and pblk *should* only allocate map bitmaps in process context,
but keep the failure handling for robustness sake.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c     | 22 +++++++++++++++-------
 drivers/lightnvm/pblk-init.c     | 18 ++++++++++++++++++
 drivers/lightnvm/pblk-recovery.c |  2 +-
 drivers/lightnvm/pblk.h          |  4 ++++
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 36ac9eff8ebd..a1033d82b9cc 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1049,15 +1049,18 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
 static int pblk_line_alloc_bitmaps(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 
-	line->map_bitmap = kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
+	line->map_bitmap = mempool_alloc(l_mg->bitmap_pool, GFP_KERNEL);
 	if (!line->map_bitmap)
 		return -ENOMEM;
 
+	memset(line->map_bitmap, 0, lm->sec_bitmap_len);
+
 	/* will be initialized using bb info from map_bitmap */
-	line->invalid_bitmap = kmalloc(lm->sec_bitmap_len, GFP_KERNEL);
+	line->invalid_bitmap = mempool_alloc(l_mg->bitmap_pool, GFP_KERNEL);
 	if (!line->invalid_bitmap) {
-		kfree(line->map_bitmap);
+		mempool_free(line->map_bitmap, l_mg->bitmap_pool);
 		line->map_bitmap = NULL;
 		return -ENOMEM;
 	}
@@ -1243,7 +1246,9 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
 
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
 {
-	kfree(line->map_bitmap);
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+
+	mempool_free(line->map_bitmap, l_mg->bitmap_pool);
 	line->map_bitmap = NULL;
 	line->smeta = NULL;
 	line->emeta = NULL;
@@ -1261,8 +1266,11 @@ static void pblk_line_reinit(struct pblk_line *line)
 
 void pblk_line_free(struct pblk_line *line)
 {
-	kfree(line->map_bitmap);
-	kfree(line->invalid_bitmap);
+	struct pblk *pblk = line->pblk;
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+
+	mempool_free(line->map_bitmap, l_mg->bitmap_pool);
+	mempool_free(line->invalid_bitmap, l_mg->bitmap_pool);
 
 	pblk_line_reinit(line);
 }
@@ -1741,7 +1749,7 @@ void pblk_line_close(struct pblk *pblk, struct pblk_line *line)
 
 	list_add_tail(&line->list, move_list);
 
-	kfree(line->map_bitmap);
+	mempool_free(line->map_bitmap, l_mg->bitmap_pool);
 	line->map_bitmap = NULL;
 	line->smeta = NULL;
 	line->emeta = NULL;
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8adc8ac8b03c..76a4a271b9cf 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -498,6 +498,9 @@ static void pblk_line_mg_free(struct pblk *pblk)
 		pblk_mfree(l_mg->eline_meta[i]->buf, l_mg->emeta_alloc_type);
 		kfree(l_mg->eline_meta[i]);
 	}
+
+	mempool_destroy(l_mg->bitmap_pool);
+	kmem_cache_destroy(l_mg->bitmap_cache);
 }
 
 static void pblk_line_meta_free(struct pblk_line_mgmt *l_mg,
@@ -797,6 +800,17 @@ static int pblk_line_mg_init(struct pblk *pblk)
 			goto fail_free_smeta;
 	}
 
+	l_mg->bitmap_cache = kmem_cache_create("pblk_lm_bitmap",
+			lm->sec_bitmap_len, 0, 0, NULL);
+	if (!l_mg->bitmap_cache)
+		goto fail_free_smeta;
+
+	/* the bitmap pool is used for both valid and map bitmaps */
+	l_mg->bitmap_pool = mempool_create_slab_pool(PBLK_DATA_LINES * 2,
+				l_mg->bitmap_cache);
+	if (!l_mg->bitmap_pool)
+		goto fail_destroy_bitmap_cache;
+
 	/* emeta allocates three different buffers for managing metadata with
 	 * in-memory and in-media layouts
 	 */
@@ -849,6 +863,10 @@ static int pblk_line_mg_init(struct pblk *pblk)
 			kfree(l_mg->eline_meta[i]->buf);
 		kfree(l_mg->eline_meta[i]);
 	}
+
+	mempool_destroy(l_mg->bitmap_pool);
+fail_destroy_bitmap_cache:
+	kmem_cache_destroy(l_mg->bitmap_cache);
 fail_free_smeta:
 	for (i = 0; i < PBLK_DATA_LINES; i++)
 		kfree(l_mg->sline_meta[i]);
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 3bd2b6b0a359..eea901d7cebc 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -939,7 +939,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			list_move_tail(&line->list, move_list);
 			spin_unlock(&l_mg->gc_lock);
 
-			kfree(line->map_bitmap);
+			mempool_free(line->map_bitmap, l_mg->bitmap_pool);
 			line->map_bitmap = NULL;
 			line->smeta = NULL;
 			line->emeta = NULL;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index fd274985aa82..1a31fda3a9f2 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -530,6 +530,10 @@ struct pblk_line_mgmt {
 	struct pblk_emeta *eline_meta[PBLK_DATA_LINES];
 	unsigned long meta_bitmap;
 
+	/* Cache and mempool for map/invalid bitmaps */
+	struct kmem_cache *bitmap_cache;
+	mempool_t *bitmap_pool;
+
 	/* Helpers for fast bitmap calculations */
 	unsigned long *bb_template;
 	unsigned long *bb_aux;
-- 
2.7.4

