Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEEAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FF920842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="Botxz4Wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FF920842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeIZUaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:30:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41477 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeIZU3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:29:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id j15-v6so23114879wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PHnJSU7zm2noHnpLYo0rObnaZ5u0RUsSVsGFUEa2XlA=;
        b=Botxz4WrvvSwaGIVjrzxacQ4F2xwEqrT5+3I9Rio+7LETAqifao5GyMXoYs3R3qukE
         4m5ZYLSsA3IitBuX0qTFSZRvRY2sZupMuBpjww+AuDivfDUm0dafIogeW3j8GhRQFo6T
         GEturI/1D9Rwz2rAOfVRCcjhazE0X6lRdoPAFjXnpSpFmegXnd1754qKlwQ6h441RFUk
         wQbHKcvaGMjv51HzCCj2bQTzI+rRCcw/bSUDupjxyrFO4EZVzAL2hV2GJ+kfl5q5OZ+b
         PKaTxhq1AWUk90CmNbX21BiHuRObD4/Cx9drrYAPJFJ4JlxBsLnV2MN1E5B8rv4+lem8
         MfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PHnJSU7zm2noHnpLYo0rObnaZ5u0RUsSVsGFUEa2XlA=;
        b=BR/2UxHe445XTQTBk8N9VK3k0Zea8yLqMxuFGUj5gWyVlnCfKBIbjXH4HtBvPxR8og
         vAKLe8a5ShOX7noPyr9wFfcDWNS+hclzxGDP2jy24ry5WiGKVUKMZN43EhADybzRClAE
         eUPwyzESMikAzSu4AuRs2pfOWklzW3EquT3Vyvchl6CF7s5Wjk/+b8nZ8GoO+q0Ocz57
         7ro5r/TqSmGAofmekE0Nfa4TxatuXAAzm9XajmElsMEn1Xbbx09SdoImFUJ3wm7m0oeq
         XpaMZovwvP0Cbs488g1Qj1t2YUXjmKTewHdJViG+O5qjGLlfBebhh84XiN8DAEjF5A2E
         7V+g==
X-Gm-Message-State: ABuFfojCU45PkncsSzulVvRpDkTMYbIJdM/wq2Tfya8sMIXvpGLl+xUG
        XiVXNe1Pgen2FEx/xNuBDJnZpnaEBf4=
X-Google-Smtp-Source: ACcGV62gpFwBYPstBRAUt/q3ZmrZ1t2C8VXPLP3oE6GQ+ZpuyCJFlVmJG1fXXekQLtCadNR5YCukoQ==
X-Received: by 2002:adf:fdca:: with SMTP id i10-v6mr5411920wrs.276.1537971396038;
        Wed, 26 Sep 2018 07:16:36 -0700 (PDT)
Received: from localhost.localdomain ([95.144.165.37])
        by smtp.gmail.com with ESMTPSA id v14-v6sm3209974wmh.41.2018.09.26.07.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 07:16:35 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tursulin@ursulin.net, tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] lib/scatterlist: Use consistent types in sgl API
Date:   Wed, 26 Sep 2018 15:16:21 +0100
Message-Id: <20180926141625.17727-3-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
References: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

There is an incosistency between data types used for order and number of
sg elements in the API.

Fix it so both are always unsigned int which, in the case of number of
elements, matches the underlying struct scatterlist.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
---
 include/linux/scatterlist.h | 5 +++--
 lib/scatterlist.c           | 9 +++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index bdede25901b5..f6cf4d7c9a69 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -285,8 +285,9 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
 				    unsigned int *nent_p);
 struct scatterlist *sgl_alloc(unsigned long length, gfp_t gfp,
 			      unsigned int *nent_p);
-void sgl_free_n_order(struct scatterlist *sgl, int nents, int order);
-void sgl_free_order(struct scatterlist *sgl, int order);
+void sgl_free_n_order(struct scatterlist *sgl, unsigned int nents,
+		      unsigned int order);
+void sgl_free_order(struct scatterlist *sgl, unsigned int order);
 void sgl_free(struct scatterlist *sgl);
 #endif /* CONFIG_SGL_ALLOC */
 
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 014018f90e28..23e53dce897d 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -549,11 +549,12 @@ EXPORT_SYMBOL(sgl_alloc);
  * - All pages in a chained scatterlist can be freed at once by setting @nents
  *   to a high number.
  */
-void sgl_free_n_order(struct scatterlist *sgl, int nents, int order)
+void sgl_free_n_order(struct scatterlist *sgl, unsigned int nents,
+		      unsigned int order)
 {
 	struct scatterlist *sg;
 	struct page *page;
-	int i;
+	unsigned int i;
 
 	for_each_sg(sgl, sg, nents, i) {
 		if (!sg)
@@ -571,9 +572,9 @@ EXPORT_SYMBOL(sgl_free_n_order);
  * @sgl: Scatterlist with one or more elements
  * @order: Second argument for __free_pages()
  */
-void sgl_free_order(struct scatterlist *sgl, int order)
+void sgl_free_order(struct scatterlist *sgl, unsigned int order)
 {
-	sgl_free_n_order(sgl, INT_MAX, order);
+	sgl_free_n_order(sgl, UINT_MAX, order);
 }
 EXPORT_SYMBOL(sgl_free_order);
 
-- 
2.17.1

