Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16D0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7706820660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977619;
	bh=quKsa3jjf9vqC4MQ+McXFmVoWPhFOQE25L2i2n/i+C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hxGNFZkLUsk0S3kpbaNBSPup/FPNiiUpBgHPBjx85ugbsIB0dbziFMv7wMIkh6g/v
	 H1hAwTvx5v/ql7slsu7ZzSFZhLTrlzOK+76dk3v4AnE3xghgAtTWYA4oErn8iBk7Rt
	 /GdsB6gykhBt77VMa1WJMRa9hUbP2Fip3Z8kKZsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbfAHUAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:00:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733067AbfAHUAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:00:15 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 716CB20883;
        Tue,  8 Jan 2019 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977613;
        bh=quKsa3jjf9vqC4MQ+McXFmVoWPhFOQE25L2i2n/i+C8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qi8XRs845lsiZ+8OZ2XLh9P3Y+y0PwdLHj2no7z97xK38q+sEHQkCGyEvscR0QEc/
         tTQcjo3C2Htbze33IoRKxo2ncNg98d8PWV9tXjebBSE06EqVzOwgAsmuCbvXGou2J8
         11HkNn/rNI75JfYGtMdPLgPtohU1WAHB+BsYNHrE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 15/16] tools include uapi: Sync linux/fs.h copy with the kernel sources
Date:   Tue,  8 Jan 2019 16:59:09 -0300
Message-Id: <20190108195910.17726-16-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/include/uapi/linux/fs.h | 60 +++++------------------------------
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
-- 
2.20.1

