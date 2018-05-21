Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeEUEiq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:38:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:55618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752398AbeEUEin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:38:43 -0400
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Simmons <jsimmons@infradead.org>,
        Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 21 May 2018 14:35:12 +1000
Subject: [PATCH 11/30] staging: lustre: move LERRCHKSUM() to libcfs_debug.h
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152687731277.24196.3530883599521811927.stgit@noble>
In-Reply-To: <152687724799.24196.7718555295926047576.stgit@noble>
References: <152687724799.24196.7718555295926047576.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro is only used for debug messages, so use
it to the debug code.
Also improve the documentation slightly.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 .../staging/lustre/include/linux/libcfs/libcfs.h   |    7 -------
 .../lustre/include/linux/libcfs/libcfs_debug.h     |    7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
index 57d66aff546b..be40cf4fb44a 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
@@ -89,13 +89,6 @@
 
 #define LIBCFS_VERSION "0.7.0"
 
-/*
- * Lustre Error Checksum: calculates checksum
- * of Hex number by XORing each bit.
- */
-#define LERRCHKSUM(hexnum) (((hexnum) & 0xf) ^ ((hexnum) >> 4 & 0xf) ^ \
-			   ((hexnum) >> 8 & 0xf))
-
 /* need both kernel and user-land acceptor */
 #define LNET_ACCEPTOR_MIN_RESERVED_PORT    512
 #define LNET_ACCEPTOR_MAX_RESERVED_PORT    1023
diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
index 0dc7b91efe7c..07f7d306ba9a 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
@@ -165,6 +165,13 @@ do {									\
 	__CDEBUG(&cdls, mask, format, ## __VA_ARGS__);			\
 } while (0)
 
+/*
+ * Lustre Error Checksum: calculates checksum
+ * of Hex number by XORing the nybbles.
+ */
+#define LERRCHKSUM(hexnum) (((hexnum) & 0xf) ^ ((hexnum) >> 4 & 0xf) ^ \
+			   ((hexnum) >> 8 & 0xf))
+
 #define CWARN(format, ...)	CDEBUG_LIMIT(D_WARNING, format, ## __VA_ARGS__)
 #define CERROR(format, ...)	CDEBUG_LIMIT(D_ERROR, format, ## __VA_ARGS__)
 #define CNETERR(format, a...)	CDEBUG_LIMIT(D_NETERROR, format, ## a)
