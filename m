Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeBFLPs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 06:15:48 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37048 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbeBFLPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 06:15:40 -0500
X-Google-Smtp-Source: AH8x225oQjZHiPGtNf2KpPYec7hU9yHDkR+Tw7yb/XAy9PHDkpLNR5S3Qptwr+RK6R7FXaCFLcTYHg==
From: Sean Fu <fxinrong@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Fu <fxinrong@gmail.com>
Subject: [PATCH] ext4: Remove unnecessary NULL checks in ext4.
Date: Tue,  6 Feb 2018 19:15:30 +0800
Message-Id: <1517915730-11198-1-git-send-email-fxinrong@gmail.com>
X-Mailer: git-send-email 2.6.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL check is done in kmem_cache_destroy. So remove NULL checks in ext4.

Signed-off-by: Sean Fu <fxinrong@gmail.com>
---
 fs/ext4/extents_status.c | 3 +--
 fs/ext4/mballoc.c        | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 763ef18..c4e6fb1 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -162,8 +162,7 @@ int __init ext4_init_es(void)
 
 void ext4_exit_es(void)
 {
-	if (ext4_es_cachep)
-		kmem_cache_destroy(ext4_es_cachep);
+	kmem_cache_destroy(ext4_es_cachep);
 }
 
 void ext4_es_init_tree(struct ext4_es_tree *tree)
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d9f8b90a..4fd1349 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2549,8 +2549,7 @@ static void ext4_groupinfo_destroy_slabs(void)
 	int i;
 
 	for (i = 0; i < NR_GRPINFO_CACHES; i++) {
-		if (ext4_groupinfo_caches[i])
-			kmem_cache_destroy(ext4_groupinfo_caches[i]);
+		kmem_cache_destroy(ext4_groupinfo_caches[i]);
 		ext4_groupinfo_caches[i] = NULL;
 	}
 }
-- 
2.6.2
