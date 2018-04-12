Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeDLPLH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:11:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34617 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753695AbeDLPJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:09:07 -0400
X-Google-Smtp-Source: AIpwx4/8QhEAvk4S2Uf4wiyvZDC6LvIZfRxhjgyeAHhoQ2EgJN9Bmxj3a8Y7nYJmJEBdC8V0RXDKtg==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 30/35] Revert "vfs: make argument of d_real_inode() const"
Date: Thu, 12 Apr 2018 17:08:21 +0200
Message-Id: <20180412150826.20988-31-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180412150826.20988-1-mszeredi@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7b1742eb06ead6d02a6cf3c44587088e5392d1aa.

No user of d_real_inode() remains, so it can be removed.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 include/linux/dcache.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 8ca25ea3b9db..c2dea5e78f54 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -593,10 +593,9 @@ static inline struct dentry *d_real(struct dentry *dentry,
  * If dentry is on a union/overlay, then return the underlying, real inode.
  * Otherwise return d_inode().
  */
-static inline struct inode *d_real_inode(const struct dentry *dentry)
+static inline struct inode *d_real_inode(struct dentry *dentry)
 {
-	/* This usage of d_real() results in const dentry */
-	return d_backing_inode(d_real((struct dentry *) dentry, NULL, 0));
+	return d_backing_inode(d_real(dentry, NULL, 0));
 }
 
 struct name_snapshot {
-- 
2.14.3
