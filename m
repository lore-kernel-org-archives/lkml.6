Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbeDLPXK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:23:10 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37027 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753205AbeDLPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:08:42 -0400
X-Google-Smtp-Source: AIpwx49QGqGoZtv0bPbQfqXGvHXBI2enGQmTLj/IN3cRL2E/LGOaZ7YWu7dzBvhfOURqwyu/Li8iwA==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/35] ovl: deal with overlay files in ovl_d_real()
Date: Thu, 12 Apr 2018 17:07:59 +0200
Message-Id: <20180412150826.20988-9-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180412150826.20988-1-mszeredi@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e8551c97de51..ad6a5baf226b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -97,6 +97,10 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
 	struct dentry *real;
 	int err;
 
+	/* It's an overlay file */
+	if (inode && d_inode(dentry) == inode)
+		return dentry;
+
 	if (flags & D_REAL_UPPER)
 		return ovl_dentry_upper(dentry);
 
-- 
2.14.3
