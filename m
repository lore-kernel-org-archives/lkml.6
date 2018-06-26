Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08FDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DC3241A6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHX/CKQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DC3241A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeFZHYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:24:39 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:33533 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbeFZHYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:24:36 -0400
Received: by mail-qk0-f202.google.com with SMTP id t138-v6so9245763qke.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=MGRyqm36qY0jARy3N9fmBwbI7zcmC9aWBijdud7ceWo=;
        b=gHX/CKQFoBuYi5FId3zBdnBCoVS9gPa0ooridda4tcnrPmGBG3zsn2U4+IS1CSIeE6
         Ol91a3SctyrJE9ZYYL1cUlyOBBloBmEr8CLyb/ujkAT6XTkUfzy53Tnc82I9qojqCb1d
         kOMha00X4KphxJqjfYUtDvLE2t1YtnBdM8ZPIHDcnhEi92uFbR8fh/9zg1bsTnulLyi3
         R7fxZe8lEIYb0RgbH361ezUDfxcdxgCztAQ3Tb9wl7wzFrco7nQ+9JdBrDkcEYo0hHC2
         n3459rX0igEMVMEB+ifBLK/QbzFAdD+BlUWxy9EGA/ismb/bXxPu2+tl6hv35AKMpvSi
         YTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=MGRyqm36qY0jARy3N9fmBwbI7zcmC9aWBijdud7ceWo=;
        b=NTWeIAjzjswqp2NEuMIA2AQOlXdsnaDeP6qngVa8S8ab1bIz4YrrT5xTCrWWjEaFVU
         fG1AMBFHyiMIetG61KtsbgtXkExXpEN5FevxV7yzOvSBg4dOPcWyVpAZIukqw6UwYyFM
         N+N4sJ+vRNahvcF+CX5sujsGl1mnvdw/ihmc5sCXl186vqBkCg9/GdHF3L+L8DjkXO5X
         eHoHyV5V9lf2UYuaWcTDWFmGgPfGMjsOtfVv1i+I++aLcO6Q2P+RhTQD7jCCvLPyi3Ry
         wddFegJgnTV1HcW07QICRiELd+f9DAmwbIfTrUkxCg2Mxtap+eX4b/Z6xgmEvMgquTOf
         02Pg==
X-Gm-Message-State: APt69E2PEQUUMBJPdeVTUvsmrKW/jDGVldLr2VqHcQpH6uTZhKvfLB0x
        wzA0htP5mEWZkdltehCXSd7E7jKr4wM=
X-Google-Smtp-Source: AAOMgpcltswDrnVV3MLYO92ZW7JaLGmhu332kE585IQ+Z3TYGhkpI3T2SXIaVdYR5ILrxT6prWagrvAGvN4=
MIME-Version: 1.0
X-Received: by 2002:a0c:f98c:: with SMTP id t12-v6mr195926qvn.2.1529997875788;
 Tue, 26 Jun 2018 00:24:35 -0700 (PDT)
Date:   Tue, 26 Jun 2018 00:23:59 -0700
Message-Id: <20180626072359.185217-1-mpratt@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH] fs: disallow empty path in default getname_kernel
From:   Michael Pratt <mpratt@google.com>
To:     Michael Pratt <mpratt@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mateusz Jurczyk <mjurczyk@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getname and getname_flags return ENOENT for an empty path in the common
case (without LOOKUP_EMPTY). However, getname_kernel currently allows empty
paths in all cases, which can lead to surprising behavior in code that does
not perform its own empty path check.

For example, if you attempt to exec an ELF with a PT_INTERP section
containing only 2 NUL bytes, fs/exec.c:open_exec will actually open the
working directory via do_filp_open(AT_FDCWD, "") and only bail out with
EACCES because only regular files can't be exec'd. One would expect it to
fail with ENOENT or perhaps ENOEXEC.

Many transitive callers of getname_kernel check that the first byte of the
path != '\0', but other parts of the kernel simply happen to be protected
by the difficulty of getting an empty string to them. e.g.,
fs/ext4/super.c:handle_mount_opt Opt_journal_path would open the cwd if
passed an empty path, but the mount option parsing code doesn't allow empty
arguments.

Beyond the ELF case above, I've not found any explicitly incorrect behavior
due to this.

The only user that clearly intends to open an empty path is
fs/fhandle.c:do_handle_open, which is reopening a specific dentry. So add
getname_kernel_flags like getname_flags for use by do_handle_open, while
all other users disallow empty paths.

Signed-off-by: Michael Pratt <mpratt@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Drysdale <drysdale@google.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mateusz Jurczyk <mjurczyk@google.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
---
I discovered the odd behavior with ELF loading and considered simply adding a
NUL-check in open_exec, but it seems better to fix this in the central
getname_kernel where it can help prevent similar oddness in other areas of the
kernel.

 arch/um/drivers/mconsole_kern.c |  2 +-
 fs/coredump.c                   |  2 +-
 fs/fhandle.c                    |  3 ++-
 fs/namei.c                      | 17 ++++++++++++++---
 fs/open.c                       | 13 +++++++------
 include/linux/fs.h              |  3 ++-
 kernel/sysctl_binary.c          |  2 +-
 7 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index d5f9a2d1da1b..7f1638c81ea4 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -135,7 +135,7 @@ void mconsole_proc(struct mc_request *req)
 	ptr += strlen("proc");
 	ptr = skip_spaces(ptr);
 
-	file = file_open_root(mnt->mnt_root, mnt, ptr, O_RDONLY, 0);
+	file = file_open_root(mnt->mnt_root, mnt, ptr, O_RDONLY, 0, 0);
 	if (IS_ERR(file)) {
 		mconsole_reply(req, "Failed to open file", 1, 0);
 		printk(KERN_ERR "open /proc/%s: %ld\n", ptr, PTR_ERR(file));
diff --git a/fs/coredump.c b/fs/coredump.c
index 1e2c87acac9b..c689eee11dcd 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -711,7 +711,7 @@ void do_coredump(const siginfo_t *siginfo)
 			get_fs_root(init_task.fs, &root);
 			task_unlock(&init_task);
 			cprm.file = file_open_root(root.dentry, root.mnt,
-				cn.corename, open_flags, 0600);
+				cn.corename, open_flags, 0600, 0);
 			path_put(&root);
 		} else {
 			cprm.file = filp_open(cn.corename, open_flags, 0600);
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 0ee727485615..c854f06b318a 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -229,7 +229,8 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 		path_put(&path);
 		return fd;
 	}
-	file = file_open_root(path.dentry, path.mnt, "", open_flag, 0);
+	file = file_open_root(path.dentry, path.mnt, "", open_flag, 0,
+			      LOOKUP_EMPTY);
 	if (IS_ERR(file)) {
 		put_unused_fd(fd);
 		retval =  PTR_ERR(file);
diff --git a/fs/namei.c b/fs/namei.c
index 734cef54fdf8..636ed5d47ac4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -212,7 +212,7 @@ getname(const char __user * filename)
 }
 
 struct filename *
-getname_kernel(const char * filename)
+getname_kernel_flags(const char * filename, int flags)
 {
 	struct filename *result;
 	int len = strlen(filename) + 1;
@@ -221,7 +221,12 @@ getname_kernel(const char * filename)
 	if (unlikely(!result))
 		return ERR_PTR(-ENOMEM);
 
-	if (len <= EMBEDDED_NAME_MAX) {
+	if (unlikely(len == 1)) {
+		if (!(flags & LOOKUP_EMPTY)) {
+			__putname(result);
+			return ERR_PTR(-ENOENT);
+		}
+	} else if (len <= EMBEDDED_NAME_MAX) {
 		result->name = (char *)result->iname;
 	} else if (len <= PATH_MAX) {
 		const size_t size = offsetof(struct filename, iname[1]);
@@ -247,6 +252,12 @@ getname_kernel(const char * filename)
 	return result;
 }
 
+struct filename *
+getname_kernel(const char * filename)
+{
+	return getname_kernel_flags(filename, 0);
+}
+
 void putname(struct filename *name)
 {
 	BUG_ON(name->refcnt <= 0);
@@ -3594,7 +3605,7 @@ struct file *do_file_open_root(struct dentry *dentry, struct vfsmount *mnt,
 	if (d_is_symlink(dentry) && op->intent & LOOKUP_OPEN)
 		return ERR_PTR(-ELOOP);
 
-	filename = getname_kernel(name);
+	filename = getname_kernel_flags(name, op->lookup_flags);
 	if (IS_ERR(filename))
 		return ERR_CAST(filename);
 
diff --git a/fs/open.c b/fs/open.c
index d0e955b558ad..cf580f5cd326 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -939,9 +939,9 @@ struct file *dentry_open(const struct path *path, int flags,
 }
 EXPORT_SYMBOL(dentry_open);
 
-static inline int build_open_flags(int flags, umode_t mode, struct open_flags *op)
+static inline int build_open_flags(int flags, umode_t mode, int lookup_flags,
+				   struct open_flags *op)
 {
-	int lookup_flags = 0;
 	int acc_mode = ACC_MODE(flags);
 
 	/*
@@ -1024,7 +1024,7 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 struct file *file_open_name(struct filename *name, int flags, umode_t mode)
 {
 	struct open_flags op;
-	int err = build_open_flags(flags, mode, &op);
+	int err = build_open_flags(flags, mode, 0, &op);
 	return err ? ERR_PTR(err) : do_filp_open(AT_FDCWD, name, &op);
 }
 
@@ -1053,10 +1053,11 @@ struct file *filp_open(const char *filename, int flags, umode_t mode)
 EXPORT_SYMBOL(filp_open);
 
 struct file *file_open_root(struct dentry *dentry, struct vfsmount *mnt,
-			    const char *filename, int flags, umode_t mode)
+			    const char *filename, int flags, umode_t mode,
+			    int lookup_flags)
 {
 	struct open_flags op;
-	int err = build_open_flags(flags, mode, &op);
+	int err = build_open_flags(flags, mode, lookup_flags, &op);
 	if (err)
 		return ERR_PTR(err);
 	return do_file_open_root(dentry, mnt, filename, &op);
@@ -1086,7 +1087,7 @@ EXPORT_SYMBOL(filp_clone_open);
 long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 {
 	struct open_flags op;
-	int fd = build_open_flags(flags, mode, &op);
+	int fd = build_open_flags(flags, mode, 0, &op);
 	struct filename *tmp;
 
 	if (fd)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5c91108846db..c985825291d5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2420,12 +2420,13 @@ extern long do_sys_open(int dfd, const char __user *filename, int flags,
 extern struct file *file_open_name(struct filename *, int, umode_t);
 extern struct file *filp_open(const char *, int, umode_t);
 extern struct file *file_open_root(struct dentry *, struct vfsmount *,
-				   const char *, int, umode_t);
+				   const char *, int, umode_t, int);
 extern struct file * dentry_open(const struct path *, int, const struct cred *);
 extern int filp_close(struct file *, fl_owner_t id);
 
 extern struct filename *getname_flags(const char __user *, int, int *);
 extern struct filename *getname(const char __user *);
+extern struct filename *getname_kernel_flags(const char *, int);
 extern struct filename *getname_kernel(const char *);
 extern void putname(struct filename *name);
 
diff --git a/kernel/sysctl_binary.c b/kernel/sysctl_binary.c
index 07148b497451..d3e1cbfa6cdb 100644
--- a/kernel/sysctl_binary.c
+++ b/kernel/sysctl_binary.c
@@ -1302,7 +1302,7 @@ static ssize_t binary_sysctl(const int *name, int nlen,
 	}
 
 	mnt = task_active_pid_ns(current)->proc_mnt;
-	file = file_open_root(mnt->mnt_root, mnt, pathname, flags, 0);
+	file = file_open_root(mnt->mnt_root, mnt, pathname, flags, 0, 0);
 	result = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out_putname;
-- 
2.18.0.rc2.346.g013aa6912e-goog

