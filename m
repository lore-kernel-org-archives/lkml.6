Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbeCPOek (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:34:40 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:52421 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbeCPOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:34:38 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Niklas Cassel <niklass@axis.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dcache: remove trailing whitespace
Date: Fri, 16 Mar 2018 15:34:00 +0100
Message-Id: <20180316143400.8698-1-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove trailing whitespace.
Remove empty line and trailing whitespace after function comments.
Remove an extra space in one of the comments.
Fix a typo in of the comments.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
I know that these type of patches are not really appreciated,
however, there is enough trailing whitespace in this file to
distract me from reading the real code.

 fs/dcache.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c5e53fb9ad8b..b8a3e654d7c0 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -254,7 +254,7 @@ static void __d_free(struct rcu_head *head)
 {
 	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
 
-	kmem_cache_free(dentry_cache, dentry); 
+	kmem_cache_free(dentry_cache, dentry);
 }
 
 static void __d_free_external_name(struct rcu_head *head)
@@ -710,7 +710,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	unsigned int d_flags;
 
 	/*
-	 * If we have a d_op->d_delete() operation, we sould not
+	 * If we have a d_op->d_delete() operation, we should not
 	 * let the dentry count go to zero, so use "put_or_lock".
 	 */
 	if (unlikely(dentry->d_flags & DCACHE_OP_DELETE))
@@ -800,7 +800,7 @@ static inline bool fast_dput(struct dentry *dentry)
 }
 
 
-/* 
+/*
  * This is dput
  *
  * This is complicated by the fact that we do not want to put
@@ -819,7 +819,7 @@ static inline bool fast_dput(struct dentry *dentry)
 
 /*
  * dput - release a dentry
- * @dentry: dentry to release 
+ * @dentry: dentry to release
  *
  * Release a dentry. This will drop the usage count and if appropriate
  * call the dentry unlink method as well as removing it from the queues and
@@ -1427,7 +1427,7 @@ int d_set_mounted(struct dentry *dentry)
  * searching.
  *
  * It returns zero iff there are no unused children,
- * otherwise  it returns the number of children moved to
+ * otherwise it returns the number of children moved to
  * the end of the unused list. This may not be the total
  * number of unused children, because select_parent can
  * drop the lock and return early due to latency
@@ -1630,7 +1630,6 @@ EXPORT_SYMBOL(d_invalidate);
  * available. On a success the dentry is returned. The name passed in is
  * copied and the copy passed in may be reused after this call.
  */
- 
 struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 {
 	struct external_name *ext = NULL;
@@ -1657,14 +1656,14 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 
 		ext = kmalloc(size + name->len, GFP_KERNEL_ACCOUNT);
 		if (!ext) {
-			kmem_cache_free(dentry_cache, dentry); 
+			kmem_cache_free(dentry_cache, dentry);
 			return NULL;
 		}
 		atomic_set(&ext->u.count, 1);
 		dname = ext->name;
 	} else  {
 		dname = dentry->d_iname;
-	}	
+	}
 
 	dentry->d_name.len = name->len;
 	dentry->d_name.hash = name->hash;
@@ -1889,7 +1888,6 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
  * (or otherwise set) by the caller to indicate that it is now
  * in use by the dcache.
  */
- 
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
@@ -2133,7 +2131,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		if (!found) {
 			iput(inode);
 			return ERR_PTR(-ENOMEM);
-		} 
+		}
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
@@ -2342,7 +2340,7 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 	 * See Documentation/filesystems/path-lookup.txt for more details.
 	 */
 	rcu_read_lock();
-	
+
 	hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
 
 		if (dentry->d_name.hash != hash)
@@ -2405,7 +2403,7 @@ EXPORT_SYMBOL(d_hash_and_lookup);
  * it from the hash queues and waiting for
  * it to be deleted later when it has no users
  */
- 
+
 /**
  * d_delete - delete a dentry
  * @dentry: The dentry to delete
@@ -2413,7 +2411,6 @@ EXPORT_SYMBOL(d_hash_and_lookup);
  * Turn the dentry into a negative dentry if possible, otherwise
  * remove it from the hash queues so it can be deleted later
  */
- 
 void d_delete(struct dentry * dentry)
 {
 	struct inode *inode = dentry->d_inode;
@@ -2451,7 +2448,6 @@ static void __d_rehash(struct dentry *entry)
  *
  * Adds a dentry to the hash according to its name.
  */
- 
 void d_rehash(struct dentry * entry)
 {
 	spin_lock(&entry->d_lock);
@@ -2651,7 +2647,6 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
  * This adds the entry to the hash queues and initializes @inode.
  * The entry was actually filled in earlier during d_alloc().
  */
-
 void d_add(struct dentry *entry, struct inode *inode)
 {
 	if (inode) {
@@ -3070,7 +3065,6 @@ EXPORT_SYMBOL(d_splice_alias);
  * Returns false otherwise.
  * Caller must ensure that "new_dentry" is pinned before calling is_subdir()
  */
-  
 bool is_subdir(struct dentry *new_dentry, struct dentry *old_dentry)
 {
 	bool result;
-- 
2.14.2
