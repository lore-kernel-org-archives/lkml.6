Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936438AbeE2Ooe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:44:34 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40086 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934857AbeE2OoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:44:09 -0400
X-Google-Smtp-Source: AB8JxZrO6DUkXy5UXW4YQT2PIIXgf41HCrJT3uStTmrQ8XNScone3r8IBFlmLmkk/4GtOdfAGd9kQw==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/39] ovl: add O_DIRECT support
Date: Tue, 29 May 2018 16:43:23 +0200
Message-Id: <20180529144339.16538-24-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 3f610a5b38e4..e5e7ccaaf9ec 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -110,6 +110,9 @@ static int ovl_open(struct inode *inode, struct file *file)
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
+	/* For O_DIRECT dentry_open() checks f_mapping->a_ops->direct_IO */
+	file->f_mapping = realfile->f_mapping;
+
 	file->private_data = realfile;
 
 	return 0;
-- 
2.14.3
