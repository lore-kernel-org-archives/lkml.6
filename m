Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754535AbeCGMtD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:49:03 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32996 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeCGMrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:47:32 -0500
X-Google-Smtp-Source: AG47ELvWrjA9vF3O/Ispc+VeAMtYg16uPKDpUdkZtU1V7jNCawGcbbpj2Yi3LcRRx/y68FBvMyOyRw==
From: Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] lib/scatterlist: Drop unused sgl_free_order
Date: Wed,  7 Mar 2018 12:47:11 +0000
Message-Id: <20180307124712.14963-6-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

No code calls it so remove it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
---
 include/linux/scatterlist.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index f665a278011a..3ffc5f3bf181 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -297,23 +297,13 @@ sgl_alloc(unsigned long length, gfp_t gfp, unsigned int *nent_p)
 	return sgl_alloc_order(length, 0, false, gfp, nent_p);
 }
 
-/**
- * sgl_free_order - free a scatterlist and its pages
- * @sgl: Scatterlist with one or more elements
- * @order: Second argument for __free_pages()
- */
-static inline void sgl_free_order(struct scatterlist *sgl, unsigned int order)
-{
-	sgl_free_n_order(sgl, UINT_MAX, order);
-}
-
 /**
  * sgl_free - free a scatterlist and its pages
  * @sgl: Scatterlist with one or more elements
  */
 static inline void sgl_free(struct scatterlist *sgl)
 {
-	sgl_free_order(sgl, 0);
+	sgl_free_n_order(sgl, UINT_MAX, 0);
 }
 
 #endif /* CONFIG_SGL_ALLOC */
-- 
2.14.1
