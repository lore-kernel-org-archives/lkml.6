Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED95DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974BC206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974BC206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeIFNxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:53:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbeIFNxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:53:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2253F87927;
        Thu,  6 Sep 2018 09:19:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D03A3FA981;
        Thu,  6 Sep 2018 09:19:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/11] coda: Move internal defs out of include/linux/ [ver
 #2]
From:   David Howells <dhowells@redhat.com>
To:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Thu, 06 Sep 2018 10:19:04 +0100
Message-ID: <153622554434.14298.9218401640808986085.stgit@warthog.procyon.org.uk>
In-Reply-To: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
References: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 06 Sep 2018 09:19:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 06 Sep 2018 09:19:06 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move include/linux/coda_psdev.h to fs/coda/ as there's nothing else that
uses it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Yann Droneaud <ydroneaud@opteya.com>
cc: Jan Harkes <jaharkes@cs.cmu.edu>
cc: coda@cs.cmu.edu
cc: codalist@coda.cs.cmu.edu
cc: linux-fsdevel@vger.kernel.org
---

 fs/coda/cache.c            |    2 +
 fs/coda/cnode.c            |    2 +
 fs/coda/coda_linux.c       |    2 +
 fs/coda/coda_psdev.h       |   88 ++++++++++++++++++++++++++++++++++++++++++++
 fs/coda/dir.c              |    2 +
 fs/coda/file.c             |    3 +-
 fs/coda/inode.c            |    2 +
 fs/coda/pioctl.c           |    3 +-
 fs/coda/psdev.c            |    3 +-
 fs/coda/symlink.c          |    3 +-
 fs/coda/upcall.c           |    2 +
 include/linux/coda_psdev.h |   88 --------------------------------------------
 12 files changed, 98 insertions(+), 102 deletions(-)
 create mode 100644 fs/coda/coda_psdev.h
 delete mode 100644 include/linux/coda_psdev.h

diff --git a/fs/coda/cache.c b/fs/coda/cache.c
index 201fc08a8b4f..3b8c4513118f 100644
--- a/fs/coda/cache.c
+++ b/fs/coda/cache.c
@@ -21,7 +21,7 @@
 #include <linux/spinlock.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
+#include "coda_psdev.h"
 #include "coda_linux.h"
 #include "coda_cache.h"
 
diff --git a/fs/coda/cnode.c b/fs/coda/cnode.c
index 845b5a66952a..2e5badf67f98 100644
--- a/fs/coda/cnode.c
+++ b/fs/coda/cnode.c
@@ -8,8 +8,8 @@
 #include <linux/time.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
 #include <linux/pagemap.h>
+#include "coda_psdev.h"
 #include "coda_linux.h"
 
 static inline int coda_fideq(struct CodaFid *fid1, struct CodaFid *fid2)
diff --git a/fs/coda/coda_linux.c b/fs/coda/coda_linux.c
index f3d543dd9a98..f7741e4f499a 100644
--- a/fs/coda/coda_linux.c
+++ b/fs/coda/coda_linux.c
@@ -18,7 +18,7 @@
 #include <linux/string.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
+#include "coda_psdev.h"
 #include "coda_linux.h"
 
 /* initialize the debugging variables */
diff --git a/fs/coda/coda_psdev.h b/fs/coda/coda_psdev.h
new file mode 100644
index 000000000000..e1abfb0fc9f9
--- /dev/null
+++ b/fs/coda/coda_psdev.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CODA_PSDEV_H
+#define __CODA_PSDEV_H
+
+#include <linux/backing-dev.h>
+#include <linux/mutex.h>
+#include <linux/coda_psdev.h>
+
+struct kstatfs;
+
+/* messages between coda filesystem in kernel and Venus */
+struct upc_req {
+	struct list_head    uc_chain;
+	caddr_t	            uc_data;
+	u_short	            uc_flags;
+	u_short             uc_inSize;  /* Size is at most 5000 bytes */
+	u_short	            uc_outSize;
+	u_short	            uc_opcode;  /* copied from data to save lookup */
+	int		    uc_unique;
+	wait_queue_head_t   uc_sleep;   /* process' wait queue */
+};
+
+#define CODA_REQ_ASYNC  0x1
+#define CODA_REQ_READ   0x2
+#define CODA_REQ_WRITE  0x4
+#define CODA_REQ_ABORT  0x8
+
+/* communication pending/processing queues */
+struct venus_comm {
+	u_long		    vc_seq;
+	wait_queue_head_t   vc_waitq; /* Venus wait queue */
+	struct list_head    vc_pending;
+	struct list_head    vc_processing;
+	int                 vc_inuse;
+	struct super_block *vc_sb;
+	struct mutex	    vc_mutex;
+};
+
+static inline struct venus_comm *coda_vcp(struct super_block *sb)
+{
+	return (struct venus_comm *)((sb)->s_fs_info);
+}
+
+/* upcalls */
+int venus_rootfid(struct super_block *sb, struct CodaFid *fidp);
+int venus_getattr(struct super_block *sb, struct CodaFid *fid,
+		  struct coda_vattr *attr);
+int venus_setattr(struct super_block *, struct CodaFid *, struct coda_vattr *);
+int venus_lookup(struct super_block *sb, struct CodaFid *fid, 
+		 const char *name, int length, int *type, 
+		 struct CodaFid *resfid);
+int venus_close(struct super_block *sb, struct CodaFid *fid, int flags,
+		kuid_t uid);
+int venus_open(struct super_block *sb, struct CodaFid *fid, int flags,
+	       struct file **f);
+int venus_mkdir(struct super_block *sb, struct CodaFid *dirfid, 
+		const char *name, int length, 
+		struct CodaFid *newfid, struct coda_vattr *attrs);
+int venus_create(struct super_block *sb, struct CodaFid *dirfid, 
+		 const char *name, int length, int excl, int mode,
+		 struct CodaFid *newfid, struct coda_vattr *attrs) ;
+int venus_rmdir(struct super_block *sb, struct CodaFid *dirfid, 
+		const char *name, int length);
+int venus_remove(struct super_block *sb, struct CodaFid *dirfid, 
+		 const char *name, int length);
+int venus_readlink(struct super_block *sb, struct CodaFid *fid, 
+		   char *buffer, int *length);
+int venus_rename(struct super_block *, struct CodaFid *new_fid, 
+		 struct CodaFid *old_fid, size_t old_length, 
+		 size_t new_length, const char *old_name, 
+		 const char *new_name);
+int venus_link(struct super_block *sb, struct CodaFid *fid, 
+		  struct CodaFid *dirfid, const char *name, int len );
+int venus_symlink(struct super_block *sb, struct CodaFid *fid,
+		  const char *name, int len, const char *symname, int symlen);
+int venus_access(struct super_block *sb, struct CodaFid *fid, int mask);
+int venus_pioctl(struct super_block *sb, struct CodaFid *fid,
+		 unsigned int cmd, struct PioctlData *data);
+int coda_downcall(struct venus_comm *vcp, int opcode, union outputArgs *out);
+int venus_fsync(struct super_block *sb, struct CodaFid *fid);
+int venus_statfs(struct dentry *dentry, struct kstatfs *sfs);
+
+/*
+ * Statistics
+ */
+
+extern struct venus_comm coda_comms[];
+#endif
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 00876ddadb43..b4bb34862899 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -23,7 +23,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
+#include "coda_psdev.h"
 #include "coda_linux.h"
 #include "coda_cache.h"
 
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 1cbc1f2298ee..ef135b209e18 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -22,8 +22,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
-
+#include "coda_psdev.h"
 #include "coda_linux.h"
 #include "coda_int.h"
 
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 97424cf206c0..4c512572f257 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -27,7 +27,7 @@
 #include <linux/vmalloc.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
+#include "coda_psdev.h"
 #include "coda_linux.h"
 #include "coda_cache.h"
 
diff --git a/fs/coda/pioctl.c b/fs/coda/pioctl.c
index e0c17b7dccce..644d48c12ce8 100644
--- a/fs/coda/pioctl.c
+++ b/fs/coda/pioctl.c
@@ -20,8 +20,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
-
+#include "coda_psdev.h"
 #include "coda_linux.h"
 
 /* pioctl ops */
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index c5234c21b539..a13764e9bb79 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -43,8 +43,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
-
+#include "coda_psdev.h"
 #include "coda_linux.h"
 
 #include "coda_int.h"
diff --git a/fs/coda/symlink.c b/fs/coda/symlink.c
index 202297d156df..8907d0508198 100644
--- a/fs/coda/symlink.c
+++ b/fs/coda/symlink.c
@@ -17,8 +17,7 @@
 #include <linux/pagemap.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
-
+#include "coda_psdev.h"
 #include "coda_linux.h"
 
 static int coda_symlink_filler(struct file *file, struct page *page)
diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 1175a1722411..8babd2cc647a 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -33,7 +33,7 @@
 #include <linux/vfs.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
+#include "coda_psdev.h"
 #include "coda_linux.h"
 #include "coda_cache.h"
 
diff --git a/include/linux/coda_psdev.h b/include/linux/coda_psdev.h
deleted file mode 100644
index c61e70b97319..000000000000
--- a/include/linux/coda_psdev.h
+++ /dev/null
@@ -1,88 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __CODA_PSDEV_H
-#define __CODA_PSDEV_H
-
-#include <linux/backing-dev.h>
-#include <linux/mutex.h>
-#include <uapi/linux/coda_psdev.h>
-
-struct kstatfs;
-
-/* messages between coda filesystem in kernel and Venus */
-struct upc_req {
-	struct list_head    uc_chain;
-	caddr_t	            uc_data;
-	u_short	            uc_flags;
-	u_short             uc_inSize;  /* Size is at most 5000 bytes */
-	u_short	            uc_outSize;
-	u_short	            uc_opcode;  /* copied from data to save lookup */
-	int		    uc_unique;
-	wait_queue_head_t   uc_sleep;   /* process' wait queue */
-};
-
-#define CODA_REQ_ASYNC  0x1
-#define CODA_REQ_READ   0x2
-#define CODA_REQ_WRITE  0x4
-#define CODA_REQ_ABORT  0x8
-
-/* communication pending/processing queues */
-struct venus_comm {
-	u_long		    vc_seq;
-	wait_queue_head_t   vc_waitq; /* Venus wait queue */
-	struct list_head    vc_pending;
-	struct list_head    vc_processing;
-	int                 vc_inuse;
-	struct super_block *vc_sb;
-	struct mutex	    vc_mutex;
-};
-
-static inline struct venus_comm *coda_vcp(struct super_block *sb)
-{
-	return (struct venus_comm *)((sb)->s_fs_info);
-}
-
-/* upcalls */
-int venus_rootfid(struct super_block *sb, struct CodaFid *fidp);
-int venus_getattr(struct super_block *sb, struct CodaFid *fid,
-		  struct coda_vattr *attr);
-int venus_setattr(struct super_block *, struct CodaFid *, struct coda_vattr *);
-int venus_lookup(struct super_block *sb, struct CodaFid *fid, 
-		 const char *name, int length, int *type, 
-		 struct CodaFid *resfid);
-int venus_close(struct super_block *sb, struct CodaFid *fid, int flags,
-		kuid_t uid);
-int venus_open(struct super_block *sb, struct CodaFid *fid, int flags,
-	       struct file **f);
-int venus_mkdir(struct super_block *sb, struct CodaFid *dirfid, 
-		const char *name, int length, 
-		struct CodaFid *newfid, struct coda_vattr *attrs);
-int venus_create(struct super_block *sb, struct CodaFid *dirfid, 
-		 const char *name, int length, int excl, int mode,
-		 struct CodaFid *newfid, struct coda_vattr *attrs) ;
-int venus_rmdir(struct super_block *sb, struct CodaFid *dirfid, 
-		const char *name, int length);
-int venus_remove(struct super_block *sb, struct CodaFid *dirfid, 
-		 const char *name, int length);
-int venus_readlink(struct super_block *sb, struct CodaFid *fid, 
-		   char *buffer, int *length);
-int venus_rename(struct super_block *, struct CodaFid *new_fid, 
-		 struct CodaFid *old_fid, size_t old_length, 
-		 size_t new_length, const char *old_name, 
-		 const char *new_name);
-int venus_link(struct super_block *sb, struct CodaFid *fid, 
-		  struct CodaFid *dirfid, const char *name, int len );
-int venus_symlink(struct super_block *sb, struct CodaFid *fid,
-		  const char *name, int len, const char *symname, int symlen);
-int venus_access(struct super_block *sb, struct CodaFid *fid, int mask);
-int venus_pioctl(struct super_block *sb, struct CodaFid *fid,
-		 unsigned int cmd, struct PioctlData *data);
-int coda_downcall(struct venus_comm *vcp, int opcode, union outputArgs *out);
-int venus_fsync(struct super_block *sb, struct CodaFid *fid);
-int venus_statfs(struct dentry *dentry, struct kstatfs *sfs);
-
-/*
- * Statistics
- */
-
-extern struct venus_comm coda_comms[];
-#endif

