Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeEUEj3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:39:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:55721 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750704AbeEUEj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:39:27 -0400
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Simmons <jsimmons@infradead.org>,
        Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 21 May 2018 14:35:13 +1000
Subject: [PATCH 17/30] staging: lustre: move RESV_PORT definitions to
 lnet/lib-lnet.h
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152687731296.24196.10868768030783641432.stgit@noble>
In-Reply-To: <152687724799.24196.7718555295926047576.stgit@noble>
References: <152687724799.24196.7718555295926047576.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are network related on only used in lnet, so move
to lib-lnet.h

Signed-off-by: NeilBrown <neilb@suse.com>
---
 .../staging/lustre/include/linux/libcfs/libcfs.h   |    4 ----
 .../staging/lustre/include/linux/lnet/lib-lnet.h   |    4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
index c7d025cccb40..20dfe8872d24 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
@@ -89,10 +89,6 @@
 
 #define LIBCFS_VERSION "0.7.0"
 
-/* need both kernel and user-land acceptor */
-#define LNET_ACCEPTOR_MIN_RESERVED_PORT    512
-#define LNET_ACCEPTOR_MAX_RESERVED_PORT    1023
-
 extern struct blocking_notifier_head libcfs_ioctl_list;
 static inline int notifier_from_ioctl_errno(int err)
 {
diff --git a/drivers/staging/lustre/include/linux/lnet/lib-lnet.h b/drivers/staging/lustre/include/linux/lnet/lib-lnet.h
index df4c72507a15..82561e9e44eb 100644
--- a/drivers/staging/lustre/include/linux/lnet/lib-lnet.h
+++ b/drivers/staging/lustre/include/linux/lnet/lib-lnet.h
@@ -68,6 +68,10 @@ extern struct lnet the_lnet;	/* THE network */
 /** exclusive lock */
 #define LNET_LOCK_EX		CFS_PERCPT_LOCK_EX
 
+/* need both kernel and user-land acceptor */
+#define LNET_ACCEPTOR_MIN_RESERVED_PORT    512
+#define LNET_ACCEPTOR_MAX_RESERVED_PORT    1023
+
 static inline int lnet_is_route_alive(struct lnet_route *route)
 {
 	/* gateway is down */
