Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeEGIii (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:38:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35263 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeEGIiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:25 -0400
X-Google-Smtp-Source: AB8JxZpQESIGtMq1MKOALWZqZLLXbvuUNmUKEQuSL57sMxie6BJbkgNy2OlctaQWYvS+6HNO5991eg==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/35] ovl: deal with overlay files in ovl_d_real()
Date: Mon,  7 May 2018 10:37:42 +0200
Message-Id: <20180507083807.28792-11-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
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
