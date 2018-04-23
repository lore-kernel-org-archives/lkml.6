Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932617AbeDWVfn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:35:43 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37060 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeDWVfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:35:38 -0400
X-Google-Smtp-Source: AIpwx48gCmwUqZIaRlSXC4YwOH8AiNeRYu0LpcQonTgO1EBbE4anj2T6AnNA09Ncf1mbbj+2ilOtrg==
Date: Tue, 24 Apr 2018 00:35:34 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc: use #pragma once
Message-ID: <20180423213534.GA9043@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring /proc into 21st century.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/fd.h            |    6 +-----
 fs/proc/internal.h      |    1 +
 include/linux/proc_fs.h |    6 +-----
 3 files changed, 3 insertions(+), 10 deletions(-)

--- a/fs/proc/fd.h
+++ b/fs/proc/fd.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PROCFS_FD_H__
-#define __PROCFS_FD_H__
-
+#pragma once
 #include <linux/fs.h>
 
 extern const struct file_operations proc_fd_operations;
@@ -16,5 +14,3 @@ static inline unsigned int proc_fd(struct inode *inode)
 {
 	return PROC_I(inode)->fd;
 }
-
-#endif /* __PROCFS_FD_H__ */
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -1,3 +1,4 @@
+#pragma once
 /* Internal procfs definitions
  *
  * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -1,10 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
 /*
  * The proc filesystem constants/structures
  */
-#ifndef _LINUX_PROC_FS_H
-#define _LINUX_PROC_FS_H
-
 #include <linux/types.h>
 #include <linux/fs.h>
 
@@ -82,5 +80,3 @@ static inline struct proc_dir_entry *proc_net_mkdir(
 struct ns_common;
 int open_related_ns(struct ns_common *ns,
 		   struct ns_common *(*get_ns)(struct ns_common *ns));
-
-#endif /* _LINUX_PROC_FS_H */
