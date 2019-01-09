Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC708C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CC020821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfAIHSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:18:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44035 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfAIHSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:18:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x097IZWP3856831
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 23:18:35 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x097IZHM3856828;
        Tue, 8 Jan 2019 23:18:35 -0800
Date:   Tue, 8 Jan 2019 23:18:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-mosz81pa6iwxko4p2owbm3ss@git.kernel.org>
Cc:     dhowells@redhat.com, acme@redhat.com, wangnan0@huawei.com,
        tglx@linutronix.de, hpa@zytor.com, jolsa@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, lclaudio@redhat.com, adrian.hunter@intel.com
Reply-To: tglx@linutronix.de, dhowells@redhat.com, acme@redhat.com,
          wangnan0@huawei.com, linux-kernel@vger.kernel.org,
          lclaudio@redhat.com, namhyung@kernel.org,
          adrian.hunter@intel.com, hpa@zytor.com, mingo@kernel.org,
          jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools include uapi: Sync linux/fs.h copy with the
 kernel sources
Git-Commit-ID: fdc42ca190c7d8976f4f9240752f0bd008270b72
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fdc42ca190c7d8976f4f9240752f0bd008270b72
Gitweb:     https://git.kernel.org/tip/fdc42ca190c7d8976f4f9240752f0bd008270b72
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 8 Jan 2019 13:48:14 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 8 Jan 2019 14:09:33 -0300

tools include uapi: Sync linux/fs.h copy with the kernel sources

To get the changes in:

  e262e32d6bde ("vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled")

That made the mount flags string table generator to switch to using
mount.h instead.

This silences the following perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fs.h' differs from latest version at 'include/uapi/linux/fs.h'
  diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-mosz81pa6iwxko4p2owbm3ss@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fs.h | 60 ++++++-------------------------------------
 1 file changed, 8 insertions(+), 52 deletions(-)

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index a441ea1bfe6d..121e82ce296b 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -14,6 +14,11 @@
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
+/* Use of MS_* flags within the kernel is restricted to core mount(2) code. */
+#if !defined(__KERNEL__)
+#include <linux/mount.h>
+#endif
+
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
  * the file limit at runtime and only root can increase the per-process
@@ -101,57 +106,6 @@ struct inodes_stat_t {
 
 #define NR_FILE  8192	/* this can well be larger on a larger system */
 
-
-/*
- * These are the fs-independent mount-flags: up to 32 flags are supported
- */
-#define MS_RDONLY	 1	/* Mount read-only */
-#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
-#define MS_NODEV	 4	/* Disallow access to device special files */
-#define MS_NOEXEC	 8	/* Disallow program execution */
-#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
-#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
-#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
-#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
-#define MS_NOATIME	1024	/* Do not update access times. */
-#define MS_NODIRATIME	2048	/* Do not update directory access times */
-#define MS_BIND		4096
-#define MS_MOVE		8192
-#define MS_REC		16384
-#define MS_VERBOSE	32768	/* War is peace. Verbosity is silence.
-				   MS_VERBOSE is deprecated. */
-#define MS_SILENT	32768
-#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
-#define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
-#define MS_PRIVATE	(1<<18)	/* change to private */
-#define MS_SLAVE	(1<<19)	/* change to slave */
-#define MS_SHARED	(1<<20)	/* change to shared */
-#define MS_RELATIME	(1<<21)	/* Update atime relative to mtime/ctime. */
-#define MS_KERNMOUNT	(1<<22) /* this is a kern_mount call */
-#define MS_I_VERSION	(1<<23) /* Update inode I_version field */
-#define MS_STRICTATIME	(1<<24) /* Always perform atime updates */
-#define MS_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-
-/* These sb flags are internal to the kernel */
-#define MS_SUBMOUNT     (1<<26)
-#define MS_NOREMOTELOCK	(1<<27)
-#define MS_NOSEC	(1<<28)
-#define MS_BORN		(1<<29)
-#define MS_ACTIVE	(1<<30)
-#define MS_NOUSER	(1<<31)
-
-/*
- * Superblock flags that can be altered by MS_REMOUNT
- */
-#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_I_VERSION|\
-			 MS_LAZYTIME)
-
-/*
- * Old magic mount flag and mask
- */
-#define MS_MGC_VAL 0xC0ED0000
-#define MS_MGC_MSK 0xffff0000
-
 /*
  * Structure for FS_IOC_FSGETXATTR[A] and FS_IOC_FSSETXATTR.
  */
@@ -269,7 +223,8 @@ struct fsxattr {
 #define FS_POLICY_FLAGS_PAD_16		0x02
 #define FS_POLICY_FLAGS_PAD_32		0x03
 #define FS_POLICY_FLAGS_PAD_MASK	0x03
-#define FS_POLICY_FLAGS_VALID		0x03
+#define FS_POLICY_FLAG_DIRECT_KEY	0x04	/* use master key directly */
+#define FS_POLICY_FLAGS_VALID		0x07
 
 /* Encryption algorithms */
 #define FS_ENCRYPTION_MODE_INVALID		0
@@ -281,6 +236,7 @@ struct fsxattr {
 #define FS_ENCRYPTION_MODE_AES_128_CTS		6
 #define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7 /* Removed, do not use. */
 #define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8 /* Removed, do not use. */
+#define FS_ENCRYPTION_MODE_ADIANTUM		9
 
 struct fscrypt_policy {
 	__u8 version;
