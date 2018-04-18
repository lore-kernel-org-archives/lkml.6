Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeDRHOs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:14:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:36332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753151AbeDRHOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:14:45 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 18 Apr 2018 16:47:01 +1000
Subject: [PATCH 2/6] rhashtable: remove incorrect comment on r{hl,
 hash}table_walk_enter()
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152403402192.16895.9740762152906281009.stgit2@noble>
In-Reply-To: <152403346237.16895.8767189357062722046.stgit2@noble>
References: <152403346237.16895.8767189357062722046.stgit2@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither rhashtable_walk_enter() or rhltable_walk_enter() sleep, so
remove the comments which suggest that they do.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |    3 ---
 lib/rhashtable.c           |    3 ---
 2 files changed, 6 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 87d443a5b11d..b01d88e196c2 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -1268,9 +1268,6 @@ static inline int rhashtable_walk_init(struct rhashtable *ht,
  * For a completely stable walk you should construct your own data
  * structure outside the hash table.
  *
- * This function may sleep so you must not call it from interrupt
- * context or with spin locks held.
- *
  * You must call rhashtable_walk_exit after this function returns.
  */
 static inline void rhltable_walk_enter(struct rhltable *hlt,
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 2b2b79974b61..19db8e563c40 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -668,9 +668,6 @@ EXPORT_SYMBOL_GPL(rhashtable_insert_slow);
  * For a completely stable walk you should construct your own data
  * structure outside the hash table.
  *
- * This function may sleep so you must not call it from interrupt
- * context or with spin locks held.
- *
  * You must call rhashtable_walk_exit after this function returns.
  */
 void rhashtable_walk_enter(struct rhashtable *ht, struct rhashtable_iter *iter)
