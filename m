Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeEOCVQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:21:16 -0400
Received: from icp-osb-irony-out9.external.iinet.net.au ([203.59.1.226]:43399
        "EHLO icp-osb-irony-out9.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752013AbeEOCVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:21:14 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CwBgC2Q/pa/+U/0XZcHgEGDINDgVwog?=
 =?us-ascii?q?3SUdkYBAQEBAQaBBzR8kzKBeB4YAYRAgxMhNBgBAgEBAQEBAQJsKIVSVigBDAI?=
 =?us-ascii?q?YDgJJFhOFFwysAYIcGgKIMIIngQmHHIEMgQeBPopPglQChziFQos8CY5Rh2uFA?=
 =?us-ascii?q?wGSCBw4gVJNLgo7gkOQWzIwegEBj3sBAQ?=
X-IPAS-Result: =?us-ascii?q?A2CwBgC2Q/pa/+U/0XZcHgEGDINDgVwog3SUdkYBAQEBAQa?=
 =?us-ascii?q?BBzR8kzKBeB4YAYRAgxMhNBgBAgEBAQEBAQJsKIVSVigBDAIYDgJJFhOFFwysA?=
 =?us-ascii?q?YIcGgKIMIIngQmHHIEMgQeBPopPglQChziFQos8CY5Rh2uFAwGSCBw4gVJNLgo?=
 =?us-ascii?q?7gkOQWzIwegEBj3sBAQ?=
X-IronPort-AV: E=Sophos;i="5.49,402,1520870400";
   d="scan'208";a="75207484"
Subject: [PATCH] autofs - clean up includes
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 15 May 2018 10:20:52 +0800
Message-ID: <152635085258.5968.9743527195522188148.stgit@pluto.themaw.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove includes that aren't needed from autofs (and fs/compat_ioctl.c).

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h  |    2 +-
 fs/autofs/dev-ioctl.c |   13 -------------
 fs/autofs/inode.c     |    6 +-----
 fs/autofs/root.c      |    6 ------
 fs/autofs/waitq.c     |    4 ----
 fs/compat_ioctl.c     |    1 -
 6 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 9110b66c7ef1..9400a9f6318a 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -25,7 +25,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/completion.h>
-#include <asm/current.h>
+#include <linux/file.h>
 
 /* This is the range of ioctl() numbers we claim as ours */
 #define AUTOFS_IOC_FIRST     AUTOFS_IOC_READY
diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index a2281ab2b957..ea4ca1445ab7 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -7,23 +7,10 @@
  * option, any later version, incorporated herein by reference.
  */
 
-#include <linux/module.h>
-#include <linux/vmalloc.h>
 #include <linux/miscdevice.h>
-#include <linux/init.h>
-#include <linux/wait.h>
-#include <linux/namei.h>
-#include <linux/fcntl.h>
-#include <linux/file.h>
-#include <linux/fdtable.h>
-#include <linux/sched.h>
-#include <linux/cred.h>
 #include <linux/compat.h>
 #include <linux/syscalls.h>
 #include <linux/magic.h>
-#include <linux/dcache.h>
-#include <linux/uaccess.h>
-#include <linux/slab.h>
 
 #include "autofs_i.h"
 
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 6262819ede45..b51980fc274e 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -7,16 +7,12 @@
  * option, any later version, incorporated herein by reference.
  */
 
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/file.h>
 #include <linux/seq_file.h>
 #include <linux/pagemap.h>
 #include <linux/parser.h>
-#include <linux/bitops.h>
 #include <linux/magic.h>
+
 #include "autofs_i.h"
-#include <linux/module.h>
 
 struct autofs_info *autofs_new_ino(struct autofs_sb_info *sbi)
 {
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index a4b36e44f73c..a3d414150578 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -9,13 +9,7 @@
  */
 
 #include <linux/capability.h>
-#include <linux/errno.h>
-#include <linux/stat.h>
-#include <linux/slab.h>
-#include <linux/param.h>
-#include <linux/time.h>
 #include <linux/compat.h>
-#include <linux/mutex.h>
 
 #include "autofs_i.h"
 
diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index 8a566fa66afe..8c858126c751 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -7,11 +7,7 @@
  * option, any later version, incorporated herein by reference.
  */
 
-#include <linux/slab.h>
-#include <linux/time.h>
-#include <linux/signal.h>
 #include <linux/sched/signal.h>
-#include <linux/file.h>
 #include "autofs_i.h"
 
 /* We make this a static variable rather than a part of the superblock; it
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index b3e1768b636e..9907475b4226 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -38,7 +38,6 @@
 #include <linux/ppp-ioctl.h>
 #include <linux/if_pppox.h>
 #include <linux/mtio.h>
-#include <linux/auto_fs.h>
 #include <linux/tty.h>
 #include <linux/vt_kern.h>
 #include <linux/fb.h>
