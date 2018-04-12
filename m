Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753951AbeDLPKu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:10:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51448 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753714AbeDLPJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:09:08 -0400
X-Google-Smtp-Source: AIpwx49dRtJ0op6MzSVUdfrsyQVgGnRAsKwFshgdogn6ha2ruxjmZjqE8ppLOmWwAFC/RCO/7LlT1A==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 31/35] Revert "vfs: add d_real_inode() helper"
Date: Thu, 12 Apr 2018 17:08:22 +0200
Message-Id: <20180412150826.20988-32-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180412150826.20988-1-mszeredi@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a118084432d642eeccb961c7c8cc61525a941fcb.

No user of d_real_inode() remains, so it can be removed.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 include/linux/dcache.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c2dea5e78f54..129ef05759a9 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -586,18 +586,6 @@ static inline struct dentry *d_real(struct dentry *dentry,
 		return dentry;
 }
 
-/**
- * d_real_inode - Return the real inode
- * @dentry: The dentry to query
- *
- * If dentry is on a union/overlay, then return the underlying, real inode.
- * Otherwise return d_inode().
- */
-static inline struct inode *d_real_inode(struct dentry *dentry)
-{
-	return d_backing_inode(d_real(dentry, NULL, 0));
-}
-
 struct name_snapshot {
 	const unsigned char *name;
 	unsigned char inline_name[DNAME_INLINE_LEN];
-- 
2.14.3
