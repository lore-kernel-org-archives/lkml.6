Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803EAC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E853E217CA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pKcRgZqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E853E217CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbeHIMRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:17:55 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:55131 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730194AbeHIMRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:17:54 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180809095346epoutp028965a57ffe226ed4301d84a860a3594f~JLqM6A2mp2176421764epoutp02G
        for <linux-kernel@vger.kernel.org>; Thu,  9 Aug 2018 09:53:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180809095346epoutp028965a57ffe226ed4301d84a860a3594f~JLqM6A2mp2176421764epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533808426;
        bh=7YgxKxi3BqXHxb8ZF5DmIzAJodP/kY1dkrSY0dG/Mtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKcRgZqZfiQaFBRHrFwi5w/Wc/WF8rFEcXvt4xUXVr1u63zWYXViYf8MjkQv8robv
         exqJzF+4+XI9a+6Z0yLjMl2l40haOLe3TgMYEuZjt3oFHciHRBVW9Wy8i6igCghE4B
         xbn1gIIx5QY4Vh6cAJXvK96P53K4Rta2o4zO3mNs=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180809095344epcas1p1da4e52dc9ba97d5def11732f668aa1f3~JLqKsmPEd2410724107epcas1p1E;
        Thu,  9 Aug 2018 09:53:44 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.0F.04292.62F0C6B5; Thu,  9 Aug 2018 18:53:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20180809095342epcas1p49a6d26e336b6e7f0f120583c410d2afb~JLqIkuZ3z2207322073epcas1p42;
        Thu,  9 Aug 2018 09:53:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180809095342epsmtrp20a2e098b3ff39f55955f5fdec015e0d8~JLqIjgjjF0832908329epsmtrp2q;
        Thu,  9 Aug 2018 09:53:42 +0000 (GMT)
X-AuditID: b6c32a38-d3bff700000010c4-1d-5b6c0f26503d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.22.03759.52F0C6B5; Thu,  9 Aug 2018 18:53:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.63.222]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180809095341epsmtip1c7dbf501de3086bd274bbca1ee393fa3~JLqIXD7rk1957919579epsmtip11;
        Thu,  9 Aug 2018 09:53:41 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, jslaby@suse.cz,
        sw0312.kim@samsung.com
Subject: [PATCH 3.18.y 2/5] ->getxattr(): pass dentry and inode as separate
 arguments
Date:   Thu,  9 Aug 2018 18:53:41 +0900
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1533808424-20649-1-git-send-email-sw0312.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUgTcRjH+e1ut9OaHVPrx3phHVooqbvN6ZUvGEotNLMEi6zmNS/f9mK7
        KVmglmAxzbfeTAw0o0LNqVmaaZIVRUYWkhHJKBHLQguHQUxb287or9/n9+X7PHyfhwdHJJ+E
        UjzHYGZNBkZHYt7o/SdB8pBNq3Tp8ta3UrrR2o7RZS1WjLY7+oX0WH8jRjd1TQK6/sIMRk9W
        zYro0aXnwjhc/aLegaqHrrWL1FU9rUD9qumpSG3v3qDunpoVpGAH2ehslslkTTLWoDVm5hiy
        YsjEVE28RhUhp0KorXQkKTMwejaGTEhKCdmRo3MFImWFjK7AJaUwHEeGxUabjAVmVpZt5Mwx
        ZDpFKUIpeWSoQuF6lYe3KVQuSwabXW1Jya86Lzhhrf6BlgLnO2ABXjgkwuHiR7vQArxxCdEH
        4O+JRyj/mQfQcbMT8J9fAI68f4lYAO4pmb5znNcHAewbu7JcYQewwVaOuvtixBY4dMMhdLMf
        kQbbPl/C3IwQJfCD84+HfYn9cGnmtseDEoFwosWB8ZlksMk262EvYifsK58W8nonBr+XMW4W
        E4Vwsm0S5fUEOPVzZJl94bfnPSKepdA+N7jc8yyAj68Wu4NC4iKA40vzyyYlnG62CNyTIUQQ
        tPaH8Tl94NxCpZAfWAzPlUt4dwB88KwO42UpbOhM5VENv3Sv47fwAsDOOhtSA9Y3/O/ZBEAr
        WM3mc/oslqPyw0M5Rs8VGLJCtUZ9N/BcVzDdBwZeJw0DAgfkSvEbn7x0iZAp5Ir0wwDiCOkn
        XuF0SeJMpugkazJqTAU6lhsGKtfuahGpv9boulWDWUOpFEqlkg6nIlQURa4RK5JT0yVEFmNm
        81g2nzX9qxPgXtJSUC5tvmugx2xtLS0m56o4jcYeH1F5WtKhPdQhmoi1+SZLVLlx2jloyYj7
        WnurN7ci8tSHwqiuM3sd90b3p4Xpiksq0amFXrlzc4Jo38PAtxs7HOaonq6ShxGJ9rWHd909
        WmEeCPBe9D9yffsxb+ue8d3jssvmjjGkZLBmaEp0IINEuWyGCkZMHPMXOvlm6XMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSnK4qf060wc+P5hZz1q9hs2hevJ7N
        4vPvXawWl3fNYbNYsPERo8WMyS/ZLB71vWW3OP/3OKsDh8eJGb9ZPPbPXcPu0bdlFaPHmQVH
        2D0+b5Lz2PTkLVMAWxSXTUpqTmZZapG+XQJXRn9XQEFfL1PF+v73LA2M/68ydjFycEgImEg8
        W1vYxcjJISSwm1HiwncfEFtCQEpi7rftUCXCEocPF3cxcgGVfGSUON7zkhGkhk1AR2L/kt+s
        ILaIQITEgWeT2UCKmAVaGSXOLDnMBJIQFgiV2HNrAxuIzSKgKnFn8W8wm1fATaJx1h12iGUK
        EgvuvQWLcwq4S+xoe8YKcVCJxMyjf9gnMPItYGRYxSiZWlCcm55bbFhgmJdarlecmFtcmpeu
        l5yfu4kRHIhamjsYLy+JP8QowMGoxMN7gS87Wog1say4MvcQowQHs5IIL/d/oBBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXHep3nHIoUE0hNLUrNTUwtSi2CyTBycUg2M1gdfnDTp2LLt7NX6fm21
        qJNG3zuvhBZ+zjKTf/dId27rkh9/Dy3srZziK1Vl+/eVYtyFzW87d3lflN3qwurB4ZsgMm27
        +vF8f5kVRX/91m7cwWHY8z4/aYnaH5d/3iqLbafLnBPa+d/yrfyDfd9ap3tP3Za9yGT6szUn
        uEwkFcJ+t2VocHxlVWIpzkg01GIuKk4EAO+RdZVAAgAA
Message-Id: <20180809095342epcas1p49a6d26e336b6e7f0f120583c410d2afb~JLqIkuZ3z2207322073epcas1p42@epcas1p4.samsung.com>
X-CMS-MailID: 20180809095342epcas1p49a6d26e336b6e7f0f120583c410d2afb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180809095342epcas1p49a6d26e336b6e7f0f120583c410d2afb
References: <20180705005205.GC30522@ZenIV.linux.org.uk>
        <1533808424-20649-1-git-send-email-sw0312.kim@samsung.com>
        <CGME20180809095342epcas1p49a6d26e336b6e7f0f120583c410d2afb@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit ce23e640133484eebc20ca7b7668388213e11327 upstream.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

[sw0312.kim: backport to 3.18]
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 Documentation/filesystems/porting                  |    6 +++++
 .../staging/lustre/lustre/llite/llite_internal.h   |    4 +-
 drivers/staging/lustre/lustre/llite/xattr.c        |    6 +---
 fs/bad_inode.c                                     |    4 +-
 fs/btrfs/xattr.c                                   |    8 +++---
 fs/btrfs/xattr.h                                   |    4 +-
 fs/ceph/super.h                                    |    3 +-
 fs/ceph/xattr.c                                    |    8 +++---
 fs/cifs/cifsfs.h                                   |    2 +-
 fs/cifs/xattr.c                                    |   10 ++++----
 fs/ecryptfs/crypto.c                               |    5 +++-
 fs/ecryptfs/ecryptfs_kernel.h                      |    4 +-
 fs/ecryptfs/inode.c                                |   23 ++++++++++---------
 fs/ecryptfs/mmap.c                                 |    3 +-
 fs/fuse/dir.c                                      |    5 +--
 fs/gfs2/inode.c                                    |    9 +++----
 fs/hfs/attr.c                                      |    5 +--
 fs/hfs/hfs_fs.h                                    |    4 +-
 fs/jfs/jfs_xattr.h                                 |    2 +-
 fs/jfs/xattr.c                                     |    8 +++---
 fs/kernfs/inode.c                                  |    6 ++--
 fs/kernfs/kernfs-internal.h                        |    4 +-
 fs/overlayfs/inode.c                               |    4 +-
 fs/overlayfs/overlayfs.h                           |    4 +-
 fs/overlayfs/super.c                               |    2 +-
 fs/reiserfs/xattr.c                                |    8 +++---
 fs/reiserfs/xattr.h                                |    4 +-
 fs/ubifs/ubifs.h                                   |    4 +-
 fs/ubifs/xattr.c                                   |    6 ++--
 fs/xattr.c                                         |   13 ++++++-----
 include/linux/fs.h                                 |    3 +-
 include/linux/xattr.h                              |    2 +-
 mm/shmem.c                                         |    8 +++---
 net/socket.c                                       |    2 +-
 security/commoncap.c                               |    6 ++--
 security/integrity/evm/evm_main.c                  |    2 +-
 security/selinux/hooks.c                           |    9 ++++---
 security/smack/smack_lsm.c                         |    4 +-
 38 files changed, 112 insertions(+), 102 deletions(-)

diff --git a/Documentation/filesystems/porting b/Documentation/filesystems/porting
index 0f3a139..daf9acd 100644
--- a/Documentation/filesystems/porting
+++ b/Documentation/filesystems/porting
@@ -463,3 +463,9 @@ in your dentry operations instead.
 	of the in-tree instances did).  inode_hash_lock is still held,
 	of course, so they are still serialized wrt removal from inode hash,
 	as well as wrt set() callback of iget5_locked().
+--
+[mandatory]
+	->getxattr() and xattr_handler.get() get dentry and inode passed separately.
+	dentry might be yet to be attached to inode, so do _not_ use its ->d_inode
+	in the instances.  Rationale: !@#!@# security_d_instantiate() needs to be
+	called before we attach dentry to inode.
diff --git a/drivers/staging/lustre/lustre/llite/llite_internal.h b/drivers/staging/lustre/lustre/llite/llite_internal.h
index 36aa0fd..442fe5b 100644
--- a/drivers/staging/lustre/lustre/llite/llite_internal.h
+++ b/drivers/staging/lustre/lustre/llite/llite_internal.h
@@ -1070,8 +1070,8 @@ static inline __u64 ll_file_maxbytes(struct inode *inode)
 /* llite/xattr.c */
 int ll_setxattr(struct dentry *dentry, const char *name,
 		const void *value, size_t size, int flags);
-ssize_t ll_getxattr(struct dentry *dentry, const char *name,
-		    void *buffer, size_t size);
+ssize_t ll_getxattr(struct dentry *dentry, struct inode *inode,
+		    const char *name, void *buffer, size_t size);
 ssize_t ll_listxattr(struct dentry *dentry, char *buffer, size_t size);
 int ll_removexattr(struct dentry *dentry, const char *name);
 
diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index 252a619..fc4b95d3 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -455,11 +455,9 @@ out:
 	return rc;
 }
 
-ssize_t ll_getxattr(struct dentry *dentry, const char *name,
-		    void *buffer, size_t size)
+ssize_t ll_getxattr(struct dentry *dentry, struct inode *inode,
+		    const char *name, void *buffer, size_t size)
 {
-	struct inode *inode = dentry->d_inode;
-
 	LASSERT(inode);
 	LASSERT(name);
 
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index afd2b44..336c284 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -253,8 +253,8 @@ static int bad_inode_setxattr(struct dentry *dentry, const char *name,
 	return -EIO;
 }
 
-static ssize_t bad_inode_getxattr(struct dentry *dentry, const char *name,
-			void *buffer, size_t size)
+static ssize_t bad_inode_getxattr(struct dentry *dentry, struct inode *inode,
+			const char *name, void *buffer, size_t size)
 {
 	return -EIO;
 }
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index fbb0533..6fa0196 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -393,8 +393,8 @@ static int btrfs_is_valid_xattr(const char *name)
 	return 0;
 }
 
-ssize_t btrfs_getxattr(struct dentry *dentry, const char *name,
-		       void *buffer, size_t size)
+ssize_t btrfs_getxattr(struct dentry *dentry, struct inode *inode,
+		       const char *name, void *buffer, size_t size)
 {
 	int ret;
 
@@ -404,12 +404,12 @@ ssize_t btrfs_getxattr(struct dentry *dentry, const char *name,
 	 * for it via sb->s_xattr.
 	 */
 	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
-		return generic_getxattr(dentry, name, buffer, size);
+		return generic_getxattr(dentry, inode, name, buffer, size);
 
 	ret = btrfs_is_valid_xattr(name);
 	if (ret)
 		return ret;
-	return __btrfs_getxattr(dentry->d_inode, name, buffer, size);
+	return __btrfs_getxattr(inode, name, buffer, size);
 }
 
 int btrfs_setxattr(struct dentry *dentry, const char *name, const void *value,
diff --git a/fs/btrfs/xattr.h b/fs/btrfs/xattr.h
index 5049608..8ee4329 100644
--- a/fs/btrfs/xattr.h
+++ b/fs/btrfs/xattr.h
@@ -28,8 +28,8 @@ extern ssize_t __btrfs_getxattr(struct inode *inode, const char *name,
 extern int __btrfs_setxattr(struct btrfs_trans_handle *trans,
 			    struct inode *inode, const char *name,
 			    const void *value, size_t size, int flags);
-extern ssize_t btrfs_getxattr(struct dentry *dentry, const char *name,
-		void *buffer, size_t size);
+extern ssize_t btrfs_getxattr(struct dentry *dentry, struct inode *inode,
+			      const char *name, void *buffer, size_t size);
 extern int btrfs_setxattr(struct dentry *dentry, const char *name,
 		const void *value, size_t size, int flags);
 extern int btrfs_removexattr(struct dentry *dentry, const char *name);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index b82f507..82dd063 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -727,7 +727,8 @@ extern int ceph_setxattr(struct dentry *, const char *, const void *,
 int __ceph_setxattr(struct dentry *, const char *, const void *, size_t, int);
 ssize_t __ceph_getxattr(struct inode *, const char *, void *, size_t);
 int __ceph_removexattr(struct dentry *, const char *);
-extern ssize_t ceph_getxattr(struct dentry *, const char *, void *, size_t);
+extern ssize_t ceph_getxattr(struct dentry *, struct inode *, const char *,
+			     void *, size_t);
 extern ssize_t ceph_listxattr(struct dentry *, char *, size_t);
 extern int ceph_removexattr(struct dentry *, const char *);
 extern void __ceph_build_xattrs_blob(struct ceph_inode_info *ci);
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index f827d55..59640c0 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -773,13 +773,13 @@ out:
 	return err;
 }
 
-ssize_t ceph_getxattr(struct dentry *dentry, const char *name, void *value,
-		      size_t size)
+ssize_t ceph_getxattr(struct dentry *dentry, struct inode *inode,
+		      const char *name, void *value, size_t size)
 {
 	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
-		return generic_getxattr(dentry, name, value, size);
+		return generic_getxattr(dentry, inode, name, value, size);
 
-	return __ceph_getxattr(dentry->d_inode, name, value, size);
+	return __ceph_getxattr(inode, name, value, size);
 }
 
 ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 15da9e3..b0eac15 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -124,7 +124,7 @@ extern int cifs_symlink(struct inode *inode, struct dentry *direntry,
 extern int	cifs_removexattr(struct dentry *, const char *);
 extern int	cifs_setxattr(struct dentry *, const char *, const void *,
 			size_t, int);
-extern ssize_t	cifs_getxattr(struct dentry *, const char *, void *, size_t);
+extern ssize_t	cifs_getxattr(struct dentry *, struct inode *, const char *, void *, size_t);
 extern ssize_t	cifs_listxattr(struct dentry *, char *, size_t);
 extern long cifs_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
 
diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
index 72a4d10..d2c738e 100644
--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -232,8 +232,8 @@ set_ea_exit:
 	return rc;
 }
 
-ssize_t cifs_getxattr(struct dentry *direntry, const char *ea_name,
-	void *ea_value, size_t buf_size)
+ssize_t cifs_getxattr(struct dentry *direntry, struct inode *inode,
+	const char *ea_name, void *ea_value, size_t buf_size)
 {
 	ssize_t rc = -EOPNOTSUPP;
 #ifdef CONFIG_CIFS_XATTR
@@ -246,9 +246,9 @@ ssize_t cifs_getxattr(struct dentry *direntry, const char *ea_name,
 
 	if (direntry == NULL)
 		return -EIO;
-	if (direntry->d_inode == NULL)
+	if (inode == NULL)
 		return -EIO;
-	sb = direntry->d_inode->i_sb;
+	sb = inode->i_sb;
 	if (sb == NULL)
 		return -EIO;
 
@@ -324,7 +324,7 @@ ssize_t cifs_getxattr(struct dentry *direntry, const char *ea_name,
 				goto get_ea_exit; /* rc already EOPNOTSUPP */
 
 			pacl = pTcon->ses->server->ops->get_acl(cifs_sb,
-					direntry->d_inode, full_path, &acllen);
+					inode, full_path, &acllen);
 			if (IS_ERR(pacl)) {
 				rc = PTR_ERR(pacl);
 				cifs_dbg(VFS, "%s: error %zd getting sec desc\n",
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 31b148f..bc82bf3 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1377,7 +1377,9 @@ int ecryptfs_read_xattr_region(char *page_virt, struct inode *ecryptfs_inode)
 	ssize_t size;
 	int rc = 0;
 
-	size = ecryptfs_getxattr_lower(lower_dentry, ECRYPTFS_XATTR_NAME,
+	size = ecryptfs_getxattr_lower(lower_dentry,
+				       ecryptfs_inode_to_lower(ecryptfs_inode),
+				       ECRYPTFS_XATTR_NAME,
 				       page_virt, ECRYPTFS_DEFAULT_EXTENT_SIZE);
 	if (size < 0) {
 		if (unlikely(ecryptfs_verbosity > 0))
@@ -1399,6 +1401,7 @@ int ecryptfs_read_and_validate_xattr_region(struct dentry *dentry,
 	int rc;
 
 	rc = ecryptfs_getxattr_lower(ecryptfs_dentry_to_lower(dentry),
+				     ecryptfs_inode_to_lower(inode),
 				     ECRYPTFS_XATTR_NAME, file_size,
 				     ECRYPTFS_SIZE_AND_MARKER_BYTES);
 	if (rc < ECRYPTFS_SIZE_AND_MARKER_BYTES)
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 4682bef..0030865 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -618,8 +618,8 @@ ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
 			  unsigned char *src, struct dentry *ecryptfs_dentry);
 int ecryptfs_truncate(struct dentry *dentry, loff_t new_length);
 ssize_t
-ecryptfs_getxattr_lower(struct dentry *lower_dentry, const char *name,
-			void *value, size_t size);
+ecryptfs_getxattr_lower(struct dentry *lower_dentry, struct inode *lower_inode,
+			const char *name, void *value, size_t size);
 int
 ecryptfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 		  size_t size, int flags);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 885c6a9..4fb21a7 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1036,29 +1036,30 @@ out:
 }
 
 ssize_t
-ecryptfs_getxattr_lower(struct dentry *lower_dentry, const char *name,
-			void *value, size_t size)
+ecryptfs_getxattr_lower(struct dentry *lower_dentry, struct inode *lower_inode,
+			const char *name, void *value, size_t size)
 {
 	int rc = 0;
 
-	if (!lower_dentry->d_inode->i_op->getxattr) {
+	if (!lower_inode->i_op->getxattr) {
 		rc = -EOPNOTSUPP;
 		goto out;
 	}
-	mutex_lock(&lower_dentry->d_inode->i_mutex);
-	rc = lower_dentry->d_inode->i_op->getxattr(lower_dentry, name, value,
-						   size);
-	mutex_unlock(&lower_dentry->d_inode->i_mutex);
+	mutex_lock(&lower_inode->i_mutex);
+	rc = lower_inode->i_op->getxattr(lower_dentry, lower_inode,
+					 name, value, size);
+	mutex_unlock(&lower_inode->i_mutex);
 out:
 	return rc;
 }
 
 static ssize_t
-ecryptfs_getxattr(struct dentry *dentry, const char *name, void *value,
-		  size_t size)
+ecryptfs_getxattr(struct dentry *dentry, struct inode *inode,
+		  const char *name, void *value, size_t size)
 {
-	return ecryptfs_getxattr_lower(ecryptfs_dentry_to_lower(dentry), name,
-				       value, size);
+	return ecryptfs_getxattr_lower(ecryptfs_dentry_to_lower(dentry),
+				       ecryptfs_inode_to_lower(inode),
+				       name, value, size);
 }
 
 static ssize_t
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 564a1fa..4ee2cac 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -437,7 +437,8 @@ static int ecryptfs_write_inode_size_to_xattr(struct inode *ecryptfs_inode)
 		goto out;
 	}
 	mutex_lock(&lower_inode->i_mutex);
-	size = lower_inode->i_op->getxattr(lower_dentry, ECRYPTFS_XATTR_NAME,
+	size = lower_inode->i_op->getxattr(lower_dentry, lower_inode,
+					   ECRYPTFS_XATTR_NAME,
 					   xattr_virt, PAGE_CACHE_SIZE);
 	if (size < 0)
 		size = 8;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 86ee53f..bef1ee3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1887,10 +1887,9 @@ static int fuse_setxattr(struct dentry *entry, const char *name,
 	return err;
 }
 
-static ssize_t fuse_getxattr(struct dentry *entry, const char *name,
-			     void *value, size_t size)
+static ssize_t fuse_getxattr(struct dentry *entry, struct inode *inode,
+			     const char *name, void *value, size_t size)
 {
-	struct inode *inode = entry->d_inode;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_req *req;
 	struct fuse_getxattr_in inarg;
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index c4ed823..ee95780 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1871,22 +1871,21 @@ static int gfs2_setxattr(struct dentry *dentry, const char *name,
 	return ret;
 }
 
-static ssize_t gfs2_getxattr(struct dentry *dentry, const char *name,
-			     void *data, size_t size)
+static ssize_t gfs2_getxattr(struct dentry *dentry, struct inode *inode,
+			     const char *name, void *data, size_t size)
 {
-	struct inode *inode = dentry->d_inode;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	int ret;
 
 	/* For selinux during lookup */
 	if (gfs2_glock_is_locked_by_me(ip->i_gl))
-		return generic_getxattr(dentry, name, data, size);
+		return generic_getxattr(dentry, inode, name, data, size);
 
 	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
 	ret = gfs2_glock_nq(&gh);
 	if (ret == 0) {
-		ret = generic_getxattr(dentry, name, data, size);
+		ret = generic_getxattr(dentry, inode, name, data, size);
 		gfs2_glock_dq(&gh);
 	}
 	gfs2_holder_uninit(&gh);
diff --git a/fs/hfs/attr.c b/fs/hfs/attr.c
index e057ec5..ce9719c 100644
--- a/fs/hfs/attr.c
+++ b/fs/hfs/attr.c
@@ -56,10 +56,9 @@ out:
 	return res;
 }
 
-ssize_t hfs_getxattr(struct dentry *dentry, const char *name,
-			 void *value, size_t size)
+ssize_t hfs_getxattr(struct dentry *unused, struct inode *inode,
+		     const char *name, void *value, size_t size)
 {
-	struct inode *inode = dentry->d_inode;
 	struct hfs_find_data fd;
 	hfs_cat_rec rec;
 	struct hfs_cat_file *file;
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 95d2552..f234e2a 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -213,8 +213,8 @@ extern void hfs_delete_inode(struct inode *);
 /* attr.c */
 extern int hfs_setxattr(struct dentry *dentry, const char *name,
 			const void *value, size_t size, int flags);
-extern ssize_t hfs_getxattr(struct dentry *dentry, const char *name,
-			    void *value, size_t size);
+extern ssize_t hfs_getxattr(struct dentry *dentry, struct inode *inode,
+			    const char *name, void *value, size_t size);
 extern ssize_t hfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
 
 /* mdb.c */
diff --git a/fs/jfs/jfs_xattr.h b/fs/jfs/jfs_xattr.h
index e8d717d..e69e14f 100644
--- a/fs/jfs/jfs_xattr.h
+++ b/fs/jfs/jfs_xattr.h
@@ -57,7 +57,7 @@ extern int __jfs_setxattr(tid_t, struct inode *, const char *, const void *,
 extern int jfs_setxattr(struct dentry *, const char *, const void *, size_t,
 			int);
 extern ssize_t __jfs_getxattr(struct inode *, const char *, void *, size_t);
-extern ssize_t jfs_getxattr(struct dentry *, const char *, void *, size_t);
+extern ssize_t jfs_getxattr(struct dentry *, struct inode *, const char *, void *, size_t);
 extern ssize_t jfs_listxattr(struct dentry *, char *, size_t);
 extern int jfs_removexattr(struct dentry *, const char *);
 
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 46325d5..7b9a8f9 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -933,8 +933,8 @@ ssize_t __jfs_getxattr(struct inode *inode, const char *name, void *data,
 	return size;
 }
 
-ssize_t jfs_getxattr(struct dentry *dentry, const char *name, void *data,
-		     size_t buf_size)
+ssize_t jfs_getxattr(struct dentry *dentry, struct inode *inode,
+		     const char *name, void *data, size_t buf_size)
 {
 	int err;
 
@@ -944,7 +944,7 @@ ssize_t jfs_getxattr(struct dentry *dentry, const char *name, void *data,
 	 * for it via sb->s_xattr.
 	 */
 	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
-		return generic_getxattr(dentry, name, data, buf_size);
+		return generic_getxattr(dentry, inode, name, data, buf_size);
 
 	if (strncmp(name, XATTR_OS2_PREFIX, XATTR_OS2_PREFIX_LEN) == 0) {
 		/*
@@ -959,7 +959,7 @@ ssize_t jfs_getxattr(struct dentry *dentry, const char *name, void *data,
 			return -EOPNOTSUPP;
 	}
 
-	err = __jfs_getxattr(dentry->d_inode, name, data, buf_size);
+	err = __jfs_getxattr(inode, name, data, buf_size);
 
 	return err;
 }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 9852176..332ccaf 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -220,10 +220,10 @@ int kernfs_iop_removexattr(struct dentry *dentry, const char *name)
 	return simple_xattr_remove(&attrs->xattrs, name);
 }
 
-ssize_t kernfs_iop_getxattr(struct dentry *dentry, const char *name, void *buf,
-			    size_t size)
+ssize_t kernfs_iop_getxattr(struct dentry *unused, struct inode *inode,
+			    const char *name, void *buf, size_t size)
 {
-	struct kernfs_node *kn = dentry->d_fsdata;
+	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_iattrs *attrs;
 
 	attrs = kernfs_iattrs(kn);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index dc84a3e..35b9ee1 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -85,8 +85,8 @@ int kernfs_iop_getattr(struct vfsmount *mnt, struct dentry *dentry,
 int kernfs_iop_setxattr(struct dentry *dentry, const char *name, const void *value,
 			size_t size, int flags);
 int kernfs_iop_removexattr(struct dentry *dentry, const char *name);
-ssize_t kernfs_iop_getxattr(struct dentry *dentry, const char *name, void *buf,
-			    size_t size);
+ssize_t kernfs_iop_getxattr(struct dentry *dentry, struct inode *inode,
+			    const char *name, void *buf, size_t size);
 ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size);
 void kernfs_inode_init(void);
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index df5c285..04b5520 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -246,8 +246,8 @@ static bool ovl_need_xattr_filter(struct dentry *dentry,
 	return type == OVL_PATH_UPPER && S_ISDIR(dentry->d_inode->i_mode);
 }
 
-ssize_t ovl_getxattr(struct dentry *dentry, const char *name,
-		     void *value, size_t size)
+ssize_t ovl_getxattr(struct dentry *dentry, struct inode *inode,
+		     const char *name, void *value, size_t size)
 {
 	struct path realpath;
 	enum ovl_path_type type = ovl_path_real(dentry, &realpath);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f13557f..66b56ea 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -161,8 +161,8 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr);
 int ovl_permission(struct inode *inode, int mask);
 int ovl_setxattr(struct dentry *dentry, const char *name,
 		 const void *value, size_t size, int flags);
-ssize_t ovl_getxattr(struct dentry *dentry, const char *name,
-		     void *value, size_t size);
+ssize_t ovl_getxattr(struct dentry *dentry, struct inode *inode,
+		     const char *name, void *value, size_t size);
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
 int ovl_removexattr(struct dentry *dentry, const char *name);
 struct inode *ovl_d_select_inode(struct dentry *dentry, unsigned file_flags);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b5bddae..7d00d6c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -249,7 +249,7 @@ static bool ovl_is_opaquedir(struct dentry *dentry)
 	if (!S_ISDIR(inode->i_mode) || !inode->i_op->getxattr)
 		return false;
 
-	res = inode->i_op->getxattr(dentry, ovl_opaque_xattr, &val, 1);
+	res = inode->i_op->getxattr(dentry, inode, ovl_opaque_xattr, &val, 1);
 	if (res == 1 && val == 'y')
 		return true;
 
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 9998770..40d4fcc 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -767,8 +767,8 @@ find_xattr_handler_prefix(const struct xattr_handler **handlers,
  * Inode operation getxattr()
  */
 ssize_t
-reiserfs_getxattr(struct dentry * dentry, const char *name, void *buffer,
-		  size_t size)
+reiserfs_getxattr(struct dentry *dentry, struct inode *inode,
+		  const char *name, void *buffer, size_t size)
 {
 	const struct xattr_handler *handler;
 
@@ -777,8 +777,8 @@ reiserfs_getxattr(struct dentry * dentry, const char *name, void *buffer,
 	if (!handler || get_inode_sd_version(dentry->d_inode) == STAT_DATA_V1)
 		return -EOPNOTSUPP;
 
-	return handler->get(dentry, dentry->d_inode, name, buffer, size,
-			    handler->flags);
+	return handler->get(dentry, inode,
+			    name, buffer, size, handler->flags);
 }
 
 /*
diff --git a/fs/reiserfs/xattr.h b/fs/reiserfs/xattr.h
index f620e96..033bac1 100644
--- a/fs/reiserfs/xattr.h
+++ b/fs/reiserfs/xattr.h
@@ -18,8 +18,8 @@ int reiserfs_permission(struct inode *inode, int mask);
 
 #ifdef CONFIG_REISERFS_FS_XATTR
 #define has_xattr_dir(inode) (REISERFS_I(inode)->i_flags & i_has_xattr_dir)
-ssize_t reiserfs_getxattr(struct dentry *dentry, const char *name,
-			  void *buffer, size_t size);
+ssize_t reiserfs_getxattr(struct dentry *dentry, struct inode *inode,
+			  const char *name, void *buffer, size_t size);
 int reiserfs_setxattr(struct dentry *dentry, const char *name,
 		      const void *value, size_t size, int flags);
 ssize_t reiserfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index c4fe900..c35436f 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1750,8 +1750,8 @@ int ubifs_getattr(struct vfsmount *mnt, struct dentry *dentry,
 /* xattr.c */
 int ubifs_setxattr(struct dentry *dentry, const char *name,
 		   const void *value, size_t size, int flags);
-ssize_t ubifs_getxattr(struct dentry *dentry, const char *name, void *buf,
-		       size_t size);
+ssize_t ubifs_getxattr(struct dentry *dentry, struct inode *host,
+		       const char *name, void *buf, size_t size);
 ssize_t ubifs_listxattr(struct dentry *dentry, char *buffer, size_t size);
 int ubifs_removexattr(struct dentry *dentry, const char *name);
 
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index ce6c0d4..698194f 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -357,10 +357,10 @@ out_free:
 	return err;
 }
 
-ssize_t ubifs_getxattr(struct dentry *dentry, const char *name, void *buf,
-		       size_t size)
+ssize_t ubifs_getxattr(struct dentry *dentry, struct inode *host,
+		       const char *name, void *buf, size_t size)
 {
-	struct inode *inode, *host = dentry->d_inode;
+	struct inode *inode;
 	struct ubifs_info *c = host->i_sb->s_fs_info;
 	struct qstr nm = QSTR_INIT(name, strlen(name));
 	struct ubifs_inode *ui;
diff --git a/fs/xattr.c b/fs/xattr.c
index 70a5962..b04fc6b 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -192,7 +192,7 @@ vfs_getxattr_alloc(struct dentry *dentry, const char *name, char **xattr_value,
 	if (!inode->i_op->getxattr)
 		return -EOPNOTSUPP;
 
-	error = inode->i_op->getxattr(dentry, name, NULL, 0);
+	error = inode->i_op->getxattr(dentry, inode, name, NULL, 0);
 	if (error < 0)
 		return error;
 
@@ -203,7 +203,7 @@ vfs_getxattr_alloc(struct dentry *dentry, const char *name, char **xattr_value,
 		memset(value, 0, error + 1);
 	}
 
-	error = inode->i_op->getxattr(dentry, name, value, error);
+	error = inode->i_op->getxattr(dentry, inode, name, value, error);
 	*xattr_value = value;
 	return error;
 }
@@ -255,7 +255,7 @@ vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
 	}
 nolsm:
 	if (inode->i_op->getxattr)
-		error = inode->i_op->getxattr(dentry, name, value, size);
+		error = inode->i_op->getxattr(dentry, inode, name, value, size);
 	else
 		error = -EOPNOTSUPP;
 
@@ -717,15 +717,16 @@ xattr_resolve_name(const struct xattr_handler **handlers, const char **name)
  * Find the handler for the prefix and dispatch its get() operation.
  */
 ssize_t
-generic_getxattr(struct dentry *dentry, const char *name, void *buffer, size_t size)
+generic_getxattr(struct dentry *dentry, struct inode *inode,
+		 const char *name, void *buffer, size_t size)
 {
 	const struct xattr_handler *handler;
 
 	handler = xattr_resolve_name(dentry->d_sb->s_xattr, &name);
 	if (!handler)
 		return -EOPNOTSUPP;
-	return handler->get(dentry, dentry->d_inode, name, buffer, size,
-			    handler->flags);
+	return handler->get(dentry, inode,
+			    name, buffer, size, handler->flags);
 }
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a41353..7586207 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1538,7 +1538,8 @@ struct inode_operations {
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct vfsmount *mnt, struct dentry *, struct kstat *);
 	int (*setxattr) (struct dentry *, const char *,const void *,size_t,int);
-	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
+	ssize_t (*getxattr) (struct dentry *, struct inode *,
+			     const char *, void *, size_t);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*removexattr) (struct dentry *, const char *);
 	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 1088878..ad4c869 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -43,7 +43,7 @@ int __vfs_setxattr_noperm(struct dentry *, const char *, const void *, size_t, i
 int vfs_setxattr(struct dentry *, const char *, const void *, size_t, int);
 int vfs_removexattr(struct dentry *, const char *);
 
-ssize_t generic_getxattr(struct dentry *dentry, const char *name, void *buffer, size_t size);
+ssize_t generic_getxattr(struct dentry *dentry, struct inode *inode, const char *name, void *buffer, size_t size);
 ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
 int generic_setxattr(struct dentry *dentry, const char *name, const void *value, size_t size, int flags);
 int generic_removexattr(struct dentry *dentry, const char *name);
diff --git a/mm/shmem.c b/mm/shmem.c
index fac22b5..8be47d4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2576,10 +2576,10 @@ static int shmem_xattr_validate(const char *name)
 	return -EOPNOTSUPP;
 }
 
-static ssize_t shmem_getxattr(struct dentry *dentry, const char *name,
-			      void *buffer, size_t size)
+static ssize_t shmem_getxattr(struct dentry *dentry, struct inode *inode,
+			      const char *name, void *buffer, size_t size)
 {
-	struct shmem_inode_info *info = SHMEM_I(dentry->d_inode);
+	struct shmem_inode_info *info = SHMEM_I(inode);
 	int err;
 
 	/*
@@ -2588,7 +2588,7 @@ static ssize_t shmem_getxattr(struct dentry *dentry, const char *name,
 	 * for it via sb->s_xattr.
 	 */
 	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
-		return generic_getxattr(dentry, name, buffer, size);
+		return generic_getxattr(dentry, inode, name, buffer, size);
 
 	err = shmem_xattr_validate(name);
 	if (err)
diff --git a/net/socket.c b/net/socket.c
index e723717..a70e86c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -470,7 +470,7 @@ static struct socket *sockfd_lookup_light(int fd, int *err, int *fput_needed)
 #define XATTR_SOCKPROTONAME_SUFFIX "sockprotoname"
 #define XATTR_NAME_SOCKPROTONAME (XATTR_SYSTEM_PREFIX XATTR_SOCKPROTONAME_SUFFIX)
 #define XATTR_NAME_SOCKPROTONAME_LEN (sizeof(XATTR_NAME_SOCKPROTONAME)-1)
-static ssize_t sockfs_getxattr(struct dentry *dentry,
+static ssize_t sockfs_getxattr(struct dentry *dentry, struct inode *inode,
 			       const char *name, void *value, size_t size)
 {
 	const char *proto_name;
diff --git a/security/commoncap.c b/security/commoncap.c
index 6849e6c..bdbe1e1 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -308,7 +308,7 @@ int cap_inode_need_killpriv(struct dentry *dentry)
 	if (!inode->i_op->getxattr)
 	       return 0;
 
-	error = inode->i_op->getxattr(dentry, XATTR_NAME_CAPS, NULL, 0);
+	error = inode->i_op->getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
 	if (error <= 0)
 		return 0;
 	return 1;
@@ -391,8 +391,8 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data
 	if (!inode || !inode->i_op->getxattr)
 		return -ENODATA;
 
-	size = inode->i_op->getxattr((struct dentry *)dentry, XATTR_NAME_CAPS, &caps,
-				   XATTR_CAPS_SZ);
+	size = inode->i_op->getxattr((struct dentry *)dentry, inode,
+				     XATTR_NAME_CAPS, &caps, XATTR_CAPS_SZ);
 	if (size == -ENODATA || size == -EOPNOTSUPP)
 		/* no data, that's ok */
 		return -ENODATA;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index e1998df..106d1ac 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -83,7 +83,7 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
 		return -EOPNOTSUPP;
 
 	for (xattr = evm_config_xattrnames; *xattr != NULL; xattr++) {
-		error = inode->i_op->getxattr(dentry, *xattr, NULL, 0);
+		error = inode->i_op->getxattr(dentry, inode, *xattr, NULL, 0);
 		if (error < 0) {
 			if (error == -ENODATA)
 				continue;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 98370d0..8718f05 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -442,7 +442,8 @@ static int sb_finish_set_opts(struct super_block *sb)
 			rc = -EOPNOTSUPP;
 			goto out;
 		}
-		rc = root_inode->i_op->getxattr(root, XATTR_NAME_SELINUX, NULL, 0);
+		rc = root_inode->i_op->getxattr(root, root_inode,
+						XATTR_NAME_SELINUX, NULL, 0);
 		if (rc < 0 && rc != -ENODATA) {
 			if (rc == -EOPNOTSUPP)
 				printk(KERN_WARNING "SELinux: (dev %s, type "
@@ -1344,13 +1345,13 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			goto out_unlock;
 		}
 		context[len] = '\0';
-		rc = inode->i_op->getxattr(dentry, XATTR_NAME_SELINUX,
+		rc = inode->i_op->getxattr(dentry, inode, XATTR_NAME_SELINUX,
 					   context, len);
 		if (rc == -ERANGE) {
 			kfree(context);
 
 			/* Need a larger buffer.  Query for the right size. */
-			rc = inode->i_op->getxattr(dentry, XATTR_NAME_SELINUX,
+			rc = inode->i_op->getxattr(dentry, inode, XATTR_NAME_SELINUX,
 						   NULL, 0);
 			if (rc < 0) {
 				dput(dentry);
@@ -1364,7 +1365,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 				goto out_unlock;
 			}
 			context[len] = '\0';
-			rc = inode->i_op->getxattr(dentry,
+			rc = inode->i_op->getxattr(dentry, inode,
 						   XATTR_NAME_SELINUX,
 						   context, len);
 		}
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a72b516..764e521 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -219,7 +219,7 @@ static struct smack_known *smk_fetch(const char *name, struct inode *ip,
 	if (buffer == NULL)
 		return NULL;
 
-	rc = ip->i_op->getxattr(dp, name, buffer, SMK_LONGLABEL);
+	rc = ip->i_op->getxattr(dp, ip, name, buffer, SMK_LONGLABEL);
 	if (rc > 0)
 		skp = smk_import_entry(buffer, rc);
 
@@ -3144,7 +3144,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 					TRANS_TRUE, TRANS_TRUE_SIZE,
 					0);
 			} else {
-				rc = inode->i_op->getxattr(dp,
+				rc = inode->i_op->getxattr(dp, inode,
 					XATTR_NAME_SMACKTRANSMUTE, trattr,
 					TRANS_TRUE_SIZE);
 				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
-- 
1.7.4.1

