Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A6FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D962220652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="Sqh5i3iF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D962220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeHaOGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:06:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35916 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeHaOGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:06:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id x207-v6so3838026lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 02:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ZDnX9J1DMM1IbWnX12NFc3HIIJRz7z4lFLm/n43ljk=;
        b=Sqh5i3iFDLeUFZMbBGxLL6YUsGwAL4gH3gmVJ7qcs+5ZKWIvfP1+rsZ6mn4IIQxmLW
         9iNkpqRTKlientC37IiCbH3bvFDuniITaXZzSFb0fkblnFx0LwncVX7c8DcCJAUivfRI
         IKZOLyNwwVBaRp2WKPUq0lEH0cR1JYzmPLjXmyYLNN7Y7rJmqrIVJDfnzYAR2GdjpHGB
         rimLMaQe3aKaKrcq9+Q5DSjU6IDiKJqgE64v0eHc2Cx8wHbdNTmvoqU8LBHkKHvEE4TK
         jlcufTCCvIKfjB+Vjc3HIVsITkQUANjrT/om76Ar0k7rwPp4ss9oSg5fDd0Hi5nPrnm2
         vnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ZDnX9J1DMM1IbWnX12NFc3HIIJRz7z4lFLm/n43ljk=;
        b=mSo4P3C3ajw7ZpxW2t8VxnFeXgL8+JX/x0a6mxy2s5zQhH9eokpKvGuJv1sHQ2OHJe
         jWB4ofiNWUj/QQcDmOVuLJLaxUlkL0clGTHbtsVMbfzI8n67cnwH7LgPDJ3TIChCYssS
         szSvqwvMVwi/YnJ6BokYt3QhbduSi1FDh6eTBLkTM+BsmrEMf1rrBp5apnrk8FTfkn0A
         a1OoEXLO3oh2PkQeyQ9dAmtNHJfUaOBAk3DRJAzNPhRAEAIUNukPgeg9hLR9XtsW52KP
         +8xiEnJn2zG1D8/3w8m2R73rFjw/4r82+0UZiyL0YHoNtawhmNsId3nlxNLc0Ba7KHeG
         ibuA==
X-Gm-Message-State: APzg51CVK/oOn9wDiiwThoMUXjIoE03nzIlTGpKSrWsrymTsmqMsRBct
        E/7fLp7g4fmGIXkZ7Dqnzj+asg==
X-Google-Smtp-Source: ANB0VdY6a4EkQsGQTV/vXWN8czxS2ipSDs9N16HMbQwDRPydKlcrbfyvRtCpKR4s0CVPBi4SWn4oOg==
X-Received: by 2002:a19:6308:: with SMTP id x8-v6mr9626682lfb.140.1535709597116;
        Fri, 31 Aug 2018 02:59:57 -0700 (PDT)
Received: from titan.bredbandsbolaget.se (c-adb2e655.03-91-6d6c6d4.bbcust.telenor.se. [85.230.178.173])
        by smtp.gmail.com with ESMTPSA id l141-v6sm1764715lfg.55.2018.08.31.02.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 02:59:56 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: stop recreating global caches
Date:   Fri, 31 Aug 2018 11:59:30 +0200
Message-Id: <1535709570-8923-2-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535709570-8923-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535709570-8923-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Pblk should not create a set of global caches every time
a pblk instance is created. The global caches should be
made available only when there is one or more pblk instances.

This patch bundles the global caches together with a kref
keeping track of whether the caches should be available or not.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 113 ++++++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 45 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 9aebdee8e4c9..e2cdd840e7d0 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -26,9 +26,19 @@ static unsigned int write_buffer_size;
 module_param(write_buffer_size, uint, 0644);
 MODULE_PARM_DESC(write_buffer_size, "number of entries in a write buffer");
 
-static struct kmem_cache *pblk_ws_cache, *pblk_rec_cache, *pblk_g_rq_cache,
-				*pblk_w_rq_cache;
-static DECLARE_RWSEM(pblk_lock);
+struct pblk_global_caches {
+	struct kmem_cache *ws_cache;
+	struct kmem_cache *rec_cache;
+	struct kmem_cache *g_rq_cache;
+	struct kmem_cache *w_rq_cache;
+	struct kref kref;
+};
+
+static struct pblk_global_caches caches = {
+	.kref = KREF_INIT(0)
+};
+
+static DECLARE_RWSEM(pblk_lock);	/* Protects global caches */
 struct bio_set pblk_bio_set;
 
 static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
@@ -307,53 +317,68 @@ static int pblk_set_addrf(struct pblk *pblk)
 	return 0;
 }
 
-static int pblk_init_global_caches(struct pblk *pblk)
+static int pblk_get_global_caches(void)
 {
 	down_write(&pblk_lock);
-	pblk_ws_cache = kmem_cache_create("pblk_blk_ws",
+
+	if (kref_read(&caches.kref) > 0)
+		goto caches_available;
+
+	caches.ws_cache = kmem_cache_create("pblk_blk_ws",
 				sizeof(struct pblk_line_ws), 0, 0, NULL);
-	if (!pblk_ws_cache) {
-		up_write(&pblk_lock);
-		return -ENOMEM;
-	}
+	if (!caches.ws_cache)
+		goto fail;
 
-	pblk_rec_cache = kmem_cache_create("pblk_rec",
+	caches.rec_cache = kmem_cache_create("pblk_rec",
 				sizeof(struct pblk_rec_ctx), 0, 0, NULL);
-	if (!pblk_rec_cache) {
-		kmem_cache_destroy(pblk_ws_cache);
-		up_write(&pblk_lock);
-		return -ENOMEM;
-	}
+	if (!caches.rec_cache)
+		goto fail_destroy_ws_cache;
 
-	pblk_g_rq_cache = kmem_cache_create("pblk_g_rq", pblk_g_rq_size,
+	caches.g_rq_cache = kmem_cache_create("pblk_g_rq", pblk_g_rq_size,
 				0, 0, NULL);
-	if (!pblk_g_rq_cache) {
-		kmem_cache_destroy(pblk_ws_cache);
-		kmem_cache_destroy(pblk_rec_cache);
-		up_write(&pblk_lock);
-		return -ENOMEM;
-	}
+	if (!caches.g_rq_cache)
+		goto fail_destroy_rec_cache;
 
-	pblk_w_rq_cache = kmem_cache_create("pblk_w_rq", pblk_w_rq_size,
+	caches.w_rq_cache = kmem_cache_create("pblk_w_rq", pblk_w_rq_size,
 				0, 0, NULL);
-	if (!pblk_w_rq_cache) {
-		kmem_cache_destroy(pblk_ws_cache);
-		kmem_cache_destroy(pblk_rec_cache);
-		kmem_cache_destroy(pblk_g_rq_cache);
-		up_write(&pblk_lock);
-		return -ENOMEM;
-	}
+	if (!caches.w_rq_cache)
+		goto fail_destroy_g_rq_cache;
+
+caches_available:
+	kref_get(&caches.kref);
 	up_write(&pblk_lock);
 
 	return 0;
+
+fail_destroy_g_rq_cache:
+	kmem_cache_destroy(caches.g_rq_cache);
+fail_destroy_rec_cache:
+	kmem_cache_destroy(caches.rec_cache);
+fail_destroy_ws_cache:
+	kmem_cache_destroy(caches.ws_cache);
+fail:
+	up_write(&pblk_lock);
+
+	return -ENOMEM;
 }
 
-static void pblk_free_global_caches(struct pblk *pblk)
+static void pblk_destroy_global_caches(struct kref *ref)
 {
-	kmem_cache_destroy(pblk_ws_cache);
-	kmem_cache_destroy(pblk_rec_cache);
-	kmem_cache_destroy(pblk_g_rq_cache);
-	kmem_cache_destroy(pblk_w_rq_cache);
+	struct pblk_global_caches *c;
+
+	c = container_of(ref, struct pblk_global_caches, kref);
+
+	kmem_cache_destroy(c->ws_cache);
+	kmem_cache_destroy(c->rec_cache);
+	kmem_cache_destroy(c->g_rq_cache);
+	kmem_cache_destroy(c->w_rq_cache);
+}
+
+static void pblk_put_global_caches(void)
+{
+	down_write(&pblk_lock);
+	kref_put(&caches.kref, pblk_destroy_global_caches);
+	up_write(&pblk_lock);
 }
 
 static int pblk_core_init(struct pblk *pblk)
@@ -382,7 +407,7 @@ static int pblk_core_init(struct pblk *pblk)
 	if (!pblk->pad_dist)
 		return -ENOMEM;
 
-	if (pblk_init_global_caches(pblk))
+	if (pblk_get_global_caches())
 		goto fail_free_pad_dist;
 
 	/* Internal bios can be at most the sectors signaled by the device. */
@@ -391,27 +416,27 @@ static int pblk_core_init(struct pblk *pblk)
 		goto free_global_caches;
 
 	ret = mempool_init_slab_pool(&pblk->gen_ws_pool, PBLK_GEN_WS_POOL_SIZE,
-				     pblk_ws_cache);
+				     caches.ws_cache);
 	if (ret)
 		goto free_page_bio_pool;
 
 	ret = mempool_init_slab_pool(&pblk->rec_pool, geo->all_luns,
-				     pblk_rec_cache);
+				     caches.rec_cache);
 	if (ret)
 		goto free_gen_ws_pool;
 
 	ret = mempool_init_slab_pool(&pblk->r_rq_pool, geo->all_luns,
-				     pblk_g_rq_cache);
+				     caches.g_rq_cache);
 	if (ret)
 		goto free_rec_pool;
 
 	ret = mempool_init_slab_pool(&pblk->e_rq_pool, geo->all_luns,
-				     pblk_g_rq_cache);
+				     caches.g_rq_cache);
 	if (ret)
 		goto free_r_rq_pool;
 
 	ret = mempool_init_slab_pool(&pblk->w_rq_pool, geo->all_luns,
-				     pblk_w_rq_cache);
+				     caches.w_rq_cache);
 	if (ret)
 		goto free_e_rq_pool;
 
@@ -457,7 +482,7 @@ static int pblk_core_init(struct pblk *pblk)
 free_page_bio_pool:
 	mempool_exit(&pblk->page_bio_pool);
 free_global_caches:
-	pblk_free_global_caches(pblk);
+	pblk_put_global_caches();
 fail_free_pad_dist:
 	kfree(pblk->pad_dist);
 	return -ENOMEM;
@@ -481,7 +506,7 @@ static void pblk_core_free(struct pblk *pblk)
 	mempool_exit(&pblk->e_rq_pool);
 	mempool_exit(&pblk->w_rq_pool);
 
-	pblk_free_global_caches(pblk);
+	pblk_put_global_caches();
 	kfree(pblk->pad_dist);
 }
 
@@ -1074,7 +1099,6 @@ static void pblk_exit(void *private, bool graceful)
 {
 	struct pblk *pblk = private;
 
-	down_write(&pblk_lock);
 	pblk_gc_exit(pblk, graceful);
 	pblk_tear_down(pblk, graceful);
 
@@ -1083,7 +1107,6 @@ static void pblk_exit(void *private, bool graceful)
 #endif
 
 	pblk_free(pblk);
-	up_write(&pblk_lock);
 }
 
 static sector_t pblk_capacity(void *private)
-- 
2.7.4

