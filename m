Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeEGIqM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:46:12 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44542 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbeEGIig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:36 -0400
X-Google-Smtp-Source: AB8JxZqFmPRtFMyz8NXJviXX9B+lUorc/5YECLUshiH714Sg+tU9A6RGiwVc0wMDv5rUcGKqS++rGg==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/35] ovl: add O_DIRECT support
Date: Mon,  7 May 2018 10:37:52 +0200
Message-Id: <20180507083807.28792-21-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 2028f6886649..ce871a15e185 100644
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
