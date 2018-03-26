Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeC0Bva (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 21:51:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbeC0Bv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 21:51:27 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 27 Mar 2018 10:33:04 +1100
Subject: [PATCH 2/6] rhashtable: remove outdated comments about
 grow_decision etc
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152210718423.11435.12622499872176836575.stgit@noble>
In-Reply-To: <152210688405.11435.13010923693146415942.stgit@noble>
References: <152210688405.11435.13010923693146415942.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

grow_decision and shink_decision no longer exist, so remove
the remaining references to them.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index c9df2527e0cd..3bd19d29f46b 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -834,9 +834,8 @@ static inline void *__rhashtable_insert_fast(
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
@@ -864,9 +863,8 @@ static inline int rhashtable_insert_fast(
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
@@ -888,9 +886,8 @@ static inline int rhltable_insert_key(
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
@@ -920,9 +917,8 @@ static inline int rhltable_insert(
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
@@ -979,9 +975,8 @@ static inline void *rhashtable_lookup_get_insert_fast(
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
@@ -1132,8 +1127,8 @@ static inline int __rhashtable_remove_fast(
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
@@ -1154,8 +1149,8 @@ static inline int rhashtable_remove_fast(
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
