Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbeCJSns (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:43:48 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39514 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbeCJSU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:20:27 -0500
X-Google-Smtp-Source: AG47ELvvHqWeKiyIa1mPHGHa/owW2laYDwNleeLoFkceTkatPnShWBhcm7HaYIXvXWDAVSi7t+ARGg==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 09/83] Add Kconfig and Makefile
Date: Sat, 10 Mar 2018 10:17:50 -0800
Message-Id: <1520705944-6723-10-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/Kconfig       |  2 ++
 fs/Makefile      |  1 +
 fs/nova/Kconfig  | 15 +++++++++++++++
 fs/nova/Makefile |  7 +++++++
 4 files changed, 25 insertions(+)
 create mode 100644 fs/nova/Kconfig
 create mode 100644 fs/nova/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index bc821a8..5e9ff3e 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -58,6 +58,8 @@ config FS_DAX_PMD
 	depends on ZONE_DEVICE
 	depends on TRANSPARENT_HUGEPAGE
 
+source "fs/nova/Kconfig"
+
 # Selected by DAX drivers that do not expect filesystem DAX to support
 # get_user_pages() of DAX mappings. I.e. "limited" indicates no support
 # for fork() of processes with MAP_SHARED mappings or support for
diff --git a/fs/Makefile b/fs/Makefile
index add789e..65ea619 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -113,6 +113,7 @@ obj-$(CONFIG_OMFS_FS)		+= omfs/
 obj-$(CONFIG_JFS_FS)		+= jfs/
 obj-$(CONFIG_XFS_FS)		+= xfs/
 obj-$(CONFIG_9P_FS)		+= 9p/
+obj-$(CONFIG_NOVA_FS)		+= nova/
 obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_NILFS2_FS)		+= nilfs2/
 obj-$(CONFIG_BEFS_FS)		+= befs/
diff --git a/fs/nova/Kconfig b/fs/nova/Kconfig
new file mode 100644
index 0000000..c1c692e
--- /dev/null
+++ b/fs/nova/Kconfig
@@ -0,0 +1,15 @@
+config NOVA_FS
+	tristate "NOVA: log-structured file system for non-volatile memories"
+	depends on FS_DAX
+	select CRC32
+	select LIBCRC32C
+	help
+	  If your system has a block of fast (comparable in access speed to
+	  system memory) and non-volatile byte-addressable memory and you wish
+	  to mount a light-weight filesystem with strong consistency support
+	  over it, say Y here.
+
+	  To compile this as a module, choose M here: the module will be
+	  called nova.
+
+	  If unsure, say N.
diff --git a/fs/nova/Makefile b/fs/nova/Makefile
new file mode 100644
index 0000000..eb19646
--- /dev/null
+++ b/fs/nova/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux NOVA filesystem routines.
+#
+
+obj-$(CONFIG_NOVA_FS) += nova.o
+
+nova-y := bbuild.o inode.o rebuild.o super.o
-- 
2.7.4
