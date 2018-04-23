Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932611AbeDWW3v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 18:29:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:54575 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932367AbeDWW3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 18:29:45 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date: Tue, 24 Apr 2018 08:29:13 +1000
Subject: [PATCH 1/4] rhashtable: remove outdated comments about
 grow_decision etc
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152452255339.1456.7705319430843121379.stgit@noble>
In-Reply-To: <152452244405.1456.8175298512483573078.stgit@noble>
References: <152452244405.1456.8175298512483573078.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

grow_decision and shink_decision no longer exist, so remove
the remaining references to them.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 1f8ad121eb43..87d443a5b11d 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -836,9 +836,8 @@ static inline void *__rhashtable_insert_fast(
  *
  * It is safe to call this function from atomic context.
  *
- * Will trigger an automatic deferred table resizing if the size grows
- * beyond the watermark indicated by grow_decision() which can be passed
- * to rhashtable_init().
+ * Will trigger an automatic deferred table resizing if residency in the
+ * table grows beyond 70%.
  */
 static inline int rhashtable_insert_fast(
 	struct rhashtable *ht, struct rhash_head *obj,
@@ -866,9 +865,8 @@ static inline int rhashtable_insert_fast(
  *
  * It is safe to call this function from atomic context.
  *
- * Will trigger an automatic deferred table resizing if the size grows
- * beyond the watermark indicated by grow_decision() which can be passed
- * to rhashtable_init().
+ * Will trigger an automatic deferred table resizing if residency in the
+ * table grows beyond 70%.
  */
 static inline int rhltable_insert_key(
 	struct rhltable *hlt, const void *key, struct rhlist_head *list,
@@ -890,9 +888,8 @@ static inline int rhltable_insert_key(
  *
  * It is safe to call this function from atomic context.
  *
- * Will trigger an automatic deferred table resizing if the size grows
- * beyond the watermark indicated by grow_decision() which can be passed
- * to rhashtable_init().
+ * Will trigger an automatic deferred table resizing if residency in the
+ * table grows beyond 70%.
  */
 static inline int rhltable_insert(
 	struct rhltable *hlt, struct rhlist_head *list,
@@ -922,9 +919,8 @@ static inline int rhltable_insert(
  *
  * It is safe to call this function from atomic context.
  *
- * Will trigger an automatic deferred table resizing if the size grows
- * beyond the watermark indicated by grow_decision() which can be passed
- * to rhashtable_init().
+ * Will trigger an automatic deferred table resizing if residency in the
+ * table grows beyond 70%.
  */
 static inline int rhashtable_lookup_insert_fast(
 	struct rhashtable *ht, struct rhash_head *obj,
@@ -981,9 +977,8 @@ static inline void *rhashtable_lookup_get_insert_fast(
  *
  * Lookups may occur in parallel with hashtable mutations and resizing.
  *
- * Will trigger an automatic deferred table resizing if the size grows
- * beyond the watermark indicated by grow_decision() which can be passed
- * to rhashtable_init().
+ * Will trigger an automatic deferred table resizing if residency in the
+ * table grows beyond 70%.
  *
  * Returns zero on success.
  */
@@ -1134,8 +1129,8 @@ static inline int __rhashtable_remove_fast(
  * walk the bucket chain upon removal. The removal operation is thus
  * considerable slow if the hash table is not correctly sized.
  *
- * Will automatically shrink the table via rhashtable_expand() if the
- * shrink_decision function specified at rhashtable_init() returns true.
+ * Will automatically shrink the table if permitted when residency drops
+ * below 30%.
  *
  * Returns zero on success, -ENOENT if the entry could not be found.
  */
@@ -1156,8 +1151,8 @@ static inline int rhashtable_remove_fast(
  * walk the bucket chain upon removal. The removal operation is thus
  * considerable slow if the hash table is not correctly sized.
  *
- * Will automatically shrink the table via rhashtable_expand() if the
- * shrink_decision function specified at rhashtable_init() returns true.
+ * Will automatically shrink the table if permitted when residency drops
+ * below 30%
  *
  * Returns zero on success, -ENOENT if the entry could not be found.
  */
