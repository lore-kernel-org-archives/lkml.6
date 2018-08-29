Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BAFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADAA20867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="iyIzmVT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADAA20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeH2QUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:20:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36988 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbeH2QUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:20:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20-v6so1099631edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dEOMsr/EO2TZzLIOiOu9mo5dI59Aiw6t2Vf9/2wyrcc=;
        b=iyIzmVT/XR8nQohoEOdt61vvMQmbx2Gf+y4XB2tGR3I4UZvARemu5GyL+wgdoV7fHP
         04g8u+PJ0f9srsoSvHKEqLFe2A5+bMLgpTMafcA9OJwIYitmgF0yMVLAqzyqAMohPf7j
         2eYzqLJBtU4O7bUEDSR5GZlBV68HO9AnHZoMdw78BuC21m8qhzrPA3N2529ueyAVMPGC
         sX8dJhQspC5LXGBCgqQnY6QwybTRG0c6x0PZscpngB4bK+G0/vBq61x4hP9CztnFUY8c
         xFiH7Y03q8MA+C1y4NXz6zRngzC5ircx6ueSC23pGp/2XjMrlipa05S+CV2+BR9EIh7C
         WQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dEOMsr/EO2TZzLIOiOu9mo5dI59Aiw6t2Vf9/2wyrcc=;
        b=Rap+e1rslH7hno2olRJ5mywzvKaVPLpAkgLHixxOTDyEkRVytH9G3PqTJyYoOqZzzQ
         JV9lI1x+FhLcxR2n0ef1ezypZAhoH7RGsRHapYBHBp9z1JIwLYs8seFm6fpxYkr5C9N2
         t4UlUl5dSvkHbpcIrEt+hiW9TdKrE04EZsM4LpW6fyTd12etJIO3dEzCyzK5PCiX4D3/
         CY8GcX/KO1+YQQagq5UgL3YX6Cx1xPxydjm0Qo8BzT+M7tSrHjtm+wyeyu017YuQBgxV
         IM9zJLzv9mY3jRsqlDAPx1Qn02T+Ja0JYfQ++fiV4KasSDbqWcHvhRRBOQsWP2NJHTwU
         E76Q==
X-Gm-Message-State: APzg51AZh5apGHa5OwSGceSfwuiYdIZrFB/o4kjn4hs7v4lR4tAvxD62
        yNkPM6Tb/YOtsVqwvv+gLsmfWw==
X-Google-Smtp-Source: ANB0Vda6609BCGz7a/znEodqVH1KDtKJwtLXPSUaJfN40R+J0FnvPM+8YRp41df4VFbX9xtdTQPKjQ==
X-Received: by 2002:a50:acc6:: with SMTP id x64-v6mr7472654edc.152.1535545436315;
        Wed, 29 Aug 2018 05:23:56 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id f26-v6sm1752068edb.28.2018.08.29.05.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 05:23:55 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 4/7] lightnvm: pblk: move global caches to module init/exit
Date:   Wed, 29 Aug 2018 14:23:31 +0200
Message-Id: <1535545414-550-5-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Pblk's global caches should not be initialized every time
a pblk instance is created, so move the creation and destruction
of the caches to module init/exit.

Also remove the global pblk lock as it is no longer needed after
the move.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 76a4a271b9cf..0be64220b5d8 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -27,7 +27,6 @@ MODULE_PARM_DESC(write_buffer_size, "number of entries in a write buffer");
 
 static struct kmem_cache *pblk_ws_cache, *pblk_rec_cache, *pblk_g_rq_cache,
 				*pblk_w_rq_cache;
-static DECLARE_RWSEM(pblk_lock);
 struct bio_set pblk_bio_set;
 
 static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
@@ -306,21 +305,17 @@ static int pblk_set_addrf(struct pblk *pblk)
 	return 0;
 }
 
-static int pblk_init_global_caches(struct pblk *pblk)
+static int pblk_init_global_caches(void)
 {
-	down_write(&pblk_lock);
 	pblk_ws_cache = kmem_cache_create("pblk_blk_ws",
 				sizeof(struct pblk_line_ws), 0, 0, NULL);
-	if (!pblk_ws_cache) {
-		up_write(&pblk_lock);
+	if (!pblk_ws_cache)
 		return -ENOMEM;
-	}
 
 	pblk_rec_cache = kmem_cache_create("pblk_rec",
 				sizeof(struct pblk_rec_ctx), 0, 0, NULL);
 	if (!pblk_rec_cache) {
 		kmem_cache_destroy(pblk_ws_cache);
-		up_write(&pblk_lock);
 		return -ENOMEM;
 	}
 
@@ -329,7 +324,6 @@ static int pblk_init_global_caches(struct pblk *pblk)
 	if (!pblk_g_rq_cache) {
 		kmem_cache_destroy(pblk_ws_cache);
 		kmem_cache_destroy(pblk_rec_cache);
-		up_write(&pblk_lock);
 		return -ENOMEM;
 	}
 
@@ -339,15 +333,13 @@ static int pblk_init_global_caches(struct pblk *pblk)
 		kmem_cache_destroy(pblk_ws_cache);
 		kmem_cache_destroy(pblk_rec_cache);
 		kmem_cache_destroy(pblk_g_rq_cache);
-		up_write(&pblk_lock);
 		return -ENOMEM;
 	}
-	up_write(&pblk_lock);
 
 	return 0;
 }
 
-static void pblk_free_global_caches(struct pblk *pblk)
+static void pblk_free_global_caches(void)
 {
 	kmem_cache_destroy(pblk_ws_cache);
 	kmem_cache_destroy(pblk_rec_cache);
@@ -381,13 +373,10 @@ static int pblk_core_init(struct pblk *pblk)
 	if (!pblk->pad_dist)
 		return -ENOMEM;
 
-	if (pblk_init_global_caches(pblk))
-		goto fail_free_pad_dist;
-
 	/* Internal bios can be at most the sectors signaled by the device. */
 	ret = mempool_init_page_pool(&pblk->page_bio_pool, NVM_MAX_VLBA, 0);
 	if (ret)
-		goto free_global_caches;
+		goto free_pad_dist;
 
 	ret = mempool_init_slab_pool(&pblk->gen_ws_pool, PBLK_GEN_WS_POOL_SIZE,
 				     pblk_ws_cache);
@@ -455,9 +444,7 @@ static int pblk_core_init(struct pblk *pblk)
 	mempool_exit(&pblk->gen_ws_pool);
 free_page_bio_pool:
 	mempool_exit(&pblk->page_bio_pool);
-free_global_caches:
-	pblk_free_global_caches(pblk);
-fail_free_pad_dist:
+free_pad_dist:
 	kfree(pblk->pad_dist);
 	return -ENOMEM;
 }
@@ -480,7 +467,6 @@ static void pblk_core_free(struct pblk *pblk)
 	mempool_exit(&pblk->e_rq_pool);
 	mempool_exit(&pblk->w_rq_pool);
 
-	pblk_free_global_caches(pblk);
 	kfree(pblk->pad_dist);
 }
 
@@ -1067,7 +1053,6 @@ static void pblk_exit(void *private, bool graceful)
 {
 	struct pblk *pblk = private;
 
-	down_write(&pblk_lock);
 	pblk_gc_exit(pblk, graceful);
 	pblk_tear_down(pblk, graceful);
 
@@ -1076,7 +1061,6 @@ static void pblk_exit(void *private, bool graceful)
 #endif
 
 	pblk_free(pblk);
-	up_write(&pblk_lock);
 }
 
 static sector_t pblk_capacity(void *private)
@@ -1237,9 +1221,22 @@ static int __init pblk_module_init(void)
 	ret = bioset_init(&pblk_bio_set, BIO_POOL_SIZE, 0, 0);
 	if (ret)
 		return ret;
+
 	ret = nvm_register_tgt_type(&tt_pblk);
 	if (ret)
-		bioset_exit(&pblk_bio_set);
+		goto fail_exit_bioset;
+
+	ret = pblk_init_global_caches();
+	if (ret)
+		goto fail_unregister_tgt_type;
+
+	return 0;
+
+fail_unregister_tgt_type:
+	nvm_unregister_tgt_type(&tt_pblk);
+fail_exit_bioset:
+	bioset_exit(&pblk_bio_set);
+
 	return ret;
 }
 
@@ -1247,6 +1244,7 @@ static void pblk_module_exit(void)
 {
 	bioset_exit(&pblk_bio_set);
 	nvm_unregister_tgt_type(&tt_pblk);
+	pblk_free_global_caches();
 }
 
 module_init(pblk_module_init);
-- 
2.7.4

