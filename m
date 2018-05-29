Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936554AbeE2PPQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:15:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56033 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934981AbeE2Onu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:43:50 -0400
X-Google-Smtp-Source: ADUXVKKqrRDsiufGm4H8PX8Q/S6okU9auseWwTYfiR4T+ekL49YLOJngq7kSr3bLZpUyaIfMbFyICQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/39] vfs: export vfs_ioctl() to modules
Date: Tue, 29 May 2018 16:43:07 +0200
Message-Id: <20180529144339.16538-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed by the stacked ioctl implementation in overlayfs.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/internal.h      | 1 -
 fs/ioctl.c         | 1 +
 include/linux/fs.h | 2 ++
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/internal.h b/fs/internal.h
index b82725ba3054..6821cf475fc6 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -189,7 +189,6 @@ extern const struct dentry_operations ns_dentry_operations;
  */
 extern int do_vfs_ioctl(struct file *file, unsigned int fd, unsigned int cmd,
 		    unsigned long arg);
-extern long vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
 /*
  * iomap support:
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 4823431d1c9d..41071915f411 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -49,6 +49,7 @@ long vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
  out:
 	return error;
 }
+EXPORT_SYMBOL(vfs_ioctl);
 
 static int ioctl_fibmap(struct file *filp, int __user *p)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1ea3f153b7f8..598c60092c11 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1623,6 +1623,8 @@ int vfs_mkobj(struct dentry *, umode_t,
 		int (*f)(struct dentry *, umode_t, void *),
 		void *);
 
+extern long vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+
 /*
  * VFS file helper functions.
  */
-- 
2.14.3
