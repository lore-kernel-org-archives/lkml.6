Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D55FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D315820868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="Db6RH/OS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D315820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeH2QUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:20:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38144 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeH2QUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:20:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id h33-v6so3777692edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lzDu+omVFir9hg9tJTLksPTFQvlNgd9rJmmR2DmzXbg=;
        b=Db6RH/OSi8kcRputTXCYNlu0oSblIVQhK+xt4Yk4qbOWWRaK8saQIGC8zvZBiJnrTS
         B1Jtegz9LuB4ayek/bCe3cfNUzfow5RRBi5fsUQ5yHsrqxxRvweK707GZ8YxKKM+eAFY
         6rWxOH/ld/uufEDduKaMQrmSHm69EWnhhXP25AeM9HyGdyewUTjSCubfnISY3u7jIN8Q
         o4aRvuhhuHmddrXjKHGazXJdjgD43bDy7i2ewNBFjYp5uJ0PhOWpTcQyYQIBmqZHVRFg
         DCraqzLhxYT82fMfQZngw7+3eKf5EtDDt69UvxslLuwQhp9eFE7rg6X+wad8I1JptQwp
         qXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lzDu+omVFir9hg9tJTLksPTFQvlNgd9rJmmR2DmzXbg=;
        b=q5Wn44YkIEOo3iQ92bXDg8pkjtXeXFM7H9WIOTEq2UlAKTsWymUQNaWQ9jCeKLAr7J
         5gg7CkPTi1jQEEjB70gQWrOHnOvNR0woa8PdYA+G8eFFGhsMD5wPpJx/gDI23KqkwQWb
         9uMf8mQIdCG+OxHpp73u+o/AI2ZgOLII5ooJaZPyVdX6tBX+borTyPQeqB1rTuBLLtFh
         fd24pKKv+0dcjq1JTIbZ21RZxfBr18/1RYVgMjNObfRqnjFB6kpjeHYmmGZiAIM0gEoU
         Pc4OAME1mjcm+/xcnS15eQFJKfUBfEvG5HWJFhFhEI5ZnRzkgNIm7SMP+R270RVoq6WO
         kMvw==
X-Gm-Message-State: APzg51AYcl0Vaks6mKjlrgjqHVfrYZkP5wLQe7u2hpL2hWIJ9A+BtSGQ
        VXTcfaPaUKmchh//QQ9tD8SO6A==
X-Google-Smtp-Source: ANB0VdZcF+Wlv4LdALKD/btw46rWUaPA4qVFqJrRiAWOpRYK67A6Wq1DR5SAg1KjnJ0khZViIYHzOA==
X-Received: by 2002:a50:b8c5:: with SMTP id l63-v6mr7182646ede.80.1535545437349;
        Wed, 29 Aug 2018 05:23:57 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id f26-v6sm1752068edb.28.2018.08.29.05.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 05:23:56 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 5/7] lightnvm: pblk: remove unused parameters in pblk_up_rq
Date:   Wed, 29 Aug 2018 14:23:32 +0200
Message-Id: <1535545414-550-6-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The parameters nr_ppas and ppa_list are not used, so remove them.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 3 +--
 drivers/lightnvm/pblk-write.c | 5 ++---
 drivers/lightnvm/pblk.h       | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a1033d82b9cc..f7bff3ae52ac 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1920,8 +1920,7 @@ void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
 	up(&rlun->wr_sem);
 }
 
-void pblk_up_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
-		unsigned long *lun_bitmap)
+void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index fd67325f6e54..8aa4b9ee5092 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -81,8 +81,7 @@ static void pblk_complete_write(struct pblk *pblk, struct nvm_rq *rqd,
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	atomic_long_sub(c_ctx->nr_valid, &pblk->inflight_writes);
 #endif
-
-	pblk_up_rq(pblk, rqd->ppa_list, rqd->nr_ppas, c_ctx->lun_bitmap);
+	pblk_up_rq(pblk, c_ctx->lun_bitmap);
 
 	pos = pblk_rb_sync_init(&pblk->rwb, &flags);
 	if (pos == c_ctx->sentry) {
@@ -242,7 +241,7 @@ static void pblk_submit_rec(struct work_struct *work)
 	pblk_map_remaining(pblk, ppa_list);
 	pblk_queue_resubmit(pblk, c_ctx);
 
-	pblk_up_rq(pblk, rqd->ppa_list, rqd->nr_ppas, c_ctx->lun_bitmap);
+	pblk_up_rq(pblk, c_ctx->lun_bitmap);
 	if (c_ctx->nr_padded)
 		pblk_bio_free_pages(pblk, rqd->bio, c_ctx->nr_valid,
 							c_ctx->nr_padded);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 1a31fda3a9f2..1bdac22e7897 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -827,8 +827,7 @@ void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas);
 void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
 		  unsigned long *lun_bitmap);
 void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas);
-void pblk_up_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
-		unsigned long *lun_bitmap);
+void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap);
 int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 		       int nr_pages);
 void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
-- 
2.7.4

