Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998D6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9DB208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCvlHE2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9DB208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeGPURt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:17:49 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:49102 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbeGPURt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:17:49 -0400
Received: by mail-yb0-f202.google.com with SMTP id v1-v6so36352949ybm.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=H6NALeg3lViT3S6DjyL4tYLosFh80Ug4LFZXp6rvTsE=;
        b=dCvlHE2XvcmRPc24h3JneVRNHUYY3uODKF7j4RqGxa/dijZmr9x6QJTqm4/1w7wgKZ
         k9oo5FcKvYDuNzV8A2oTFlDO69I59yZaPV+n8I8RaqaWuhYtUxuqhbc/5Sqow1lmpaG5
         NKtCsnk6tAcNMjK/IkPy4tW7zzS6eOO4OSuGSxGf/1qXYLL2Hu6n7K/eP3fkSdyFcZmD
         qZodS/Aczgq3Ur6THGhifNX8ykSvZW325dPjFh2JMUIV/23CI53BGPWX/vDtDcVxECkb
         4u2lfu3buOmclHNG6b8RQyrhp1XyqSD3gfw1Hoo0X5D2vpZtVgBCYz+gtbIUVHKf0Fs3
         QgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=H6NALeg3lViT3S6DjyL4tYLosFh80Ug4LFZXp6rvTsE=;
        b=tLD2UujFJEzXizVvNKaRLcbiIq7kodNrGTI69YKvHkNFtmU4igdI6oNjchCEXvSLr+
         wZzABotf+nlsgLrqV8V8lnwFvGIiTeJV1qm4kr0oGX31WE+SRdH/RrIc2kcaqUJY4dZL
         Jm4+7c5EAPhcXd5iSxFbkR6WEhj3PD8q2FoHnI2GcTCWP58o+hDw2J9C8PVMJYiU5yRz
         nzCxKJcQyaXPV8R/u+TkGhFdVG4kk3elCjTKcE7Ymm4vgSRJYN5vFon2MQ/fiygN8BRi
         irq9ilpZ0oJWkt5fsVaPirNaqsX3ceKCRWNOafd2F1HeVI3+yOcdMA4OTyLOUC1D24fe
         xIdQ==
X-Gm-Message-State: AOUpUlEp/Cs1mkA2JDWlYlsp3VFUgXmvqOaHEROTIHfItxCSqU01Di/h
        FXjDnZdBFC+aOn1Hwh4xTCNjMUM7sw==
X-Google-Smtp-Source: AAOMgpcd+QpIrAdXWbgL0ZJcFcBP2XAllFkOcCyLkiNYLylpG/9XBWdwJ1wjDcNpmNnZDym6+aaJC4vqIA==
MIME-Version: 1.0
X-Received: by 2002:a0d:cad5:: with SMTP id m204-v6mr5263732ywd.242.1531770533782;
 Mon, 16 Jul 2018 12:48:53 -0700 (PDT)
Date:   Mon, 16 Jul 2018 21:48:43 +0200
Message-Id: <20180716194843.252772-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] fs: don't let getdents return bogus names
From:   Jann Horn <jannh@google.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, jannh@google.com
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you e.g. run `find` on a directory for which getdents returns
"filenames" that contain slashes, `find` passes those "filenames" back to
the kernel, which then interprets them as paths. That could conceivably
cause userspace to do something bad when accessing something like an
untrusted USB stick, but I'm not aware of any specific example.

Instead of returning bogus filenames to userspace, return -EUCLEAN.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
I didn't get any replies to my mail "readdir() and directory names
containing slashes" from a few days ago, so here's a suggested fix.

As often, I'm not entirely sure whether this should be marked for stable
backport.
Does anyone want to bikeshed the choice of error number? ext4 uses
-EUCLEAN (aliased as -EFSCORRUPTED) for signalling filesystem corruption;
I think vfat just skips errors; fuse uses -EIO for this specific problem.

Behavior of "find" when encountering such filesystem corruption:

$ sudo mount img mnt
$ strace -v -e trace=getdents ls mnt
getdents(3, [{d_ino=1, d_off=1, d_reclen=24, d_name=".", d_type=DT_DIR}, {d_ino=1, d_off=2, d_reclen=24, d_name="..", d_type=DT_DIR}, {d_ino=67, d_off=16384, d_reclen=32, d_name="../../xx", d_type=DT_DIR}], 32768) = 80
getdents(3, [], 32768)                  = 0
+++ exited with 0 +++
$ find ../xx -ls
   406454      4 drwxr-xr-x   3 user     user         4096 Jul 16 20:48 ../xx
   406455      4 drwxr-xr-x   2 user     user         4096 Jul 16 20:48 ../xx/blah
   406457      0 -rw-r--r--   1 user     user            0 Jul 16 20:48 ../xx/blah/bar
$ find mnt -ls
        1     16 drwxr-xr-x   3 root     root        16384 Jan  1  1970 mnt
   406454      4 drwxr-xr-x   3 user     user         4096 Jul 16 20:48 mnt/../../xx
   406455      4 drwxr-xr-x   2 user     user         4096 Jul 16 20:48 mnt/../../xx/blah
   406457      0 -rw-r--r--   1 user     user            0 Jul 16 20:48 mnt/../../xx/blah/bar

 arch/alpha/kernel/osf_sys.c |  3 +++
 fs/readdir.c                | 33 +++++++++++++++++++++++++++++++++
 include/linux/fs.h          |  3 +++
 3 files changed, 39 insertions(+)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 6e921754c8fc..f16857d9782d 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -40,6 +40,7 @@
 #include <linux/vfs.h>
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
+#include <linux/fs.h>
 
 #include <asm/fpu.h>
 #include <asm/io.h>
@@ -117,6 +118,8 @@ osf_filldir(struct dir_context *ctx, const char *name, int namlen,
 	unsigned int reclen = ALIGN(NAME_OFFSET + namlen + 1, sizeof(u32));
 	unsigned int d_ino;
 
+	if (bogus_dirent_name(&buf->error, name, namlen, __func__))
+		return -EUCLEAN;
 	buf->error = -EINVAL;	/* only used if we fail */
 	if (reclen > buf->count)
 		return -EINVAL;
diff --git a/fs/readdir.c b/fs/readdir.c
index d97f548e6323..a061a52b06d1 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -88,6 +88,29 @@ struct readdir_callback {
 	int result;
 };
 
+/*
+ * Most filesystems don't filter out bogus directory entry names, and userspace
+ * can get very confused by such names. Behave as if a low-level IO error had
+ * happened while reading directory entries.
+ */
+bool bogus_dirent_name(int *errp, const char *name, int namlen,
+		       const char *caller)
+{
+	if (namlen == 0) {
+		pr_err_once("%s: filesystem returned bogus empty name\n",
+			    caller);
+		*errp = -EUCLEAN;
+		return true;
+	}
+	if (memchr(name, '/', namlen)) {
+		pr_err_once("%s: filesystem returned bogus name '%*pEhp' (contains slash)\n",
+			    caller, namlen, name);
+		*errp = -EUCLEAN;
+		return true;
+	}
+	return false;
+}
+
 static int fillonedir(struct dir_context *ctx, const char *name, int namlen,
 		      loff_t offset, u64 ino, unsigned int d_type)
 {
@@ -98,6 +121,8 @@ static int fillonedir(struct dir_context *ctx, const char *name, int namlen,
 
 	if (buf->result)
 		return -EINVAL;
+	if (bogus_dirent_name(&buf->result, name, namlen, __func__))
+		return -EUCLEAN;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
 		buf->result = -EOVERFLOW;
@@ -173,6 +198,8 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
 		sizeof(long));
 
+	if (bogus_dirent_name(&buf->error, name, namlen, __func__))
+		return -EUCLEAN;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
@@ -259,6 +286,8 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
 		sizeof(u64));
 
+	if (bogus_dirent_name(&buf->error, name, namlen, __func__))
+		return -EUCLEAN;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
@@ -358,6 +387,8 @@ static int compat_fillonedir(struct dir_context *ctx, const char *name,
 
 	if (buf->result)
 		return -EINVAL;
+	if (bogus_dirent_name(&buf->result, name, namlen, __func__))
+		return -EUCLEAN;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
 		buf->result = -EOVERFLOW;
@@ -427,6 +458,8 @@ static int compat_filldir(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct compat_linux_dirent, d_name) +
 		namlen + 2, sizeof(compat_long_t));
 
+	if (bogus_dirent_name(&buf->error, name, namlen, __func__))
+		return -EUCLEAN;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d78d146a98da..5d12a40bcc0c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1680,6 +1680,9 @@ struct dir_context {
 	loff_t pos;
 };
 
+bool bogus_dirent_name(int *errp, const char *name, int namlen,
+		       const char *caller);
+
 struct block_device_operations;
 
 /* These macros are for out of kernel modules to test that
-- 
2.18.0.203.gfac676dfb9-goog

