Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751124AbeC0Sfy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 14:35:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38128 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeC0Sfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 14:35:53 -0400
X-Google-Smtp-Source: AIpwx490cmfujBbR1cTo1pc0iI+q/ON4IPl+eFzRI46IJMaf98nDRukf/8ornc3teTBoUY9H23fygw==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: luisbg@kernel.org, salah.triki@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] fs:befs: Fix :should be foo *bar
Date: Tue, 27 Mar 2018 19:35:33 +0100
Message-Id: <20180327183533.7238-1-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used checkpatch.pl to find "foo * bar" should be "foo *bar"

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 fs/befs/btree.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/befs/btree.c b/fs/befs/btree.c
index 1b7e0f7128d6..5fc7d63792a0 100644
--- a/fs/befs/btree.c
+++ b/fs/befs/btree.c
@@ -89,12 +89,12 @@ static const befs_off_t BEFS_BT_INVAL = 0xffffffffffffffffULL;
 
 /* local functions */
 static int befs_btree_seekleaf(struct super_block *sb, const befs_data_stream *ds,
-			       befs_btree_super * bt_super,
+			       befs_btree_super *bt_super,
 			       struct befs_btree_node *this_node,
-			       befs_off_t * node_off);
+			       befs_off_t *node_off);
 
 static int befs_bt_read_super(struct super_block *sb, const befs_data_stream *ds,
-			      befs_btree_super * sup);
+			      befs_btree_super *sup);
 
 static int befs_bt_read_node(struct super_block *sb, const befs_data_stream *ds,
 			     struct befs_btree_node *node,
@@ -110,11 +110,11 @@ static char *befs_bt_keydata(struct befs_btree_node *node);
 
 static int befs_find_key(struct super_block *sb,
 			 struct befs_btree_node *node,
-			 const char *findkey, befs_off_t * value);
+			 const char *findkey, befs_off_t *value);
 
 static char *befs_bt_get_key(struct super_block *sb,
 			     struct befs_btree_node *node,
-			     int index, u16 * keylen);
+			     int index, u16 *keylen);
 
 static int befs_compare_strings(const void *key1, int keylen1,
 				const void *key2, int keylen2);
@@ -132,7 +132,7 @@ static int befs_compare_strings(const void *key1, int keylen1,
  */
 static int
 befs_bt_read_super(struct super_block *sb, const befs_data_stream *ds,
-		   befs_btree_super * sup)
+		   befs_btree_super *sup)
 {
 	struct buffer_head *bh;
 	befs_disk_btree_super *od_sup;
@@ -243,7 +243,7 @@ befs_bt_read_node(struct super_block *sb, const befs_data_stream *ds,
  */
 int
 befs_btree_find(struct super_block *sb, const befs_data_stream *ds,
-		const char *key, befs_off_t * value)
+		const char *key, befs_off_t *value)
 {
 	struct befs_btree_node *this_node;
 	befs_btree_super bt_super;
@@ -328,7 +328,7 @@ befs_btree_find(struct super_block *sb, const befs_data_stream *ds,
  */
 static int
 befs_find_key(struct super_block *sb, struct befs_btree_node *node,
-	      const char *findkey, befs_off_t * value)
+	      const char *findkey, befs_off_t *value)
 {
 	int first, last, mid;
 	int eq;
@@ -409,8 +409,8 @@ befs_find_key(struct super_block *sb, struct befs_btree_node *node,
  */
 int
 befs_btree_read(struct super_block *sb, const befs_data_stream *ds,
-		loff_t key_no, size_t bufsize, char *keybuf, size_t * keysize,
-		befs_off_t * value)
+		loff_t key_no, size_t bufsize, char *keybuf, size_t *keysize,
+		befs_off_t *value)
 {
 	struct befs_btree_node *this_node;
 	befs_btree_super bt_super;
@@ -542,7 +542,7 @@ static int
 befs_btree_seekleaf(struct super_block *sb, const befs_data_stream *ds,
 		    befs_btree_super *bt_super,
 		    struct befs_btree_node *this_node,
-		    befs_off_t * node_off)
+		    befs_off_t *node_off)
 {
 
 	befs_debug(sb, "---> %s", __func__);
@@ -673,7 +673,7 @@ befs_bt_keydata(struct befs_btree_node *node)
  */
 static char *
 befs_bt_get_key(struct super_block *sb, struct befs_btree_node *node,
-		int index, u16 * keylen)
+		int index, u16 *keylen)
 {
 	int prev_key_end;
 	char *keystart;
-- 
2.16.2
