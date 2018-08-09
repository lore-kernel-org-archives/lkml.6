Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92F1C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8EC217C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kbE/5NQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8EC217C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbeHIMR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:17:56 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:32520 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIMRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:17:55 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180809095345epoutp047b5593d7dbf274acc52f068bc50b7865~JLqLvosJX1991719917epoutp04u
        for <linux-kernel@vger.kernel.org>; Thu,  9 Aug 2018 09:53:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180809095345epoutp047b5593d7dbf274acc52f068bc50b7865~JLqLvosJX1991719917epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533808425;
        bh=o3WL1gptVDRg1HETt4tuI5K7r/K2vrJctsOSh+EFjTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbE/5NQNyqyPvTOlysiW1WGYbkz7dh1vQV6UKLC+Hn0ejtONjY8Ay83fi6wDdUuMk
         fTkRFxklIhIK1uyIGdtWxKFbSku2qlDNhu9bQ5mhsI9K6vogHXQOO2aaAKSUCFsqBT
         uWmk1qvdcsTPWg9LLfWi6HanJA8RJvE0J7YiIYco=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180809095342epcas1p42de1d3bd7b37048629cab3edef53aa19~JLqJDnyK62207322073epcas1p43;
        Thu,  9 Aug 2018 09:53:42 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.7B.04176.62F0C6B5; Thu,  9 Aug 2018 18:53:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180809095342epcas1p21503f49bbf9e4814ea76c509c873a559~JLqIt06wB0657706577epcas1p2x;
        Thu,  9 Aug 2018 09:53:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180809095342epsmtrp2c9e20404fbfae6949b9039dbefdea4a7~JLqIqM3Pi0832908329epsmtrp2t;
        Thu,  9 Aug 2018 09:53:42 +0000 (GMT)
X-AuditID: b6c32a37-6c5ff70000001050-77-5b6c0f260e1e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.11.03889.62F0C6B5; Thu,  9 Aug 2018 18:53:42 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.63.222]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180809095341epsmtip1a35fbc270fd2744046e85edf18efa5c4~JLqIhK2t22265222652epsmtip1a;
        Thu,  9 Aug 2018 09:53:41 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, jslaby@suse.cz,
        sw0312.kim@samsung.com
Subject: [PATCH 3.18.y 4/5] switch xattr_handler->set() to passing dentry
 and inode separately
Date:   Thu,  9 Aug 2018 18:53:43 +0900
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1533808424-20649-1-git-send-email-sw0312.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTcRTmt8f1aq1uS+uwHqxLBUlO7+b0FrMHWQ2ykKyoJPSiPzZxD93d
        pILSyF5m7wJXRgulYEU+qDDDLDMd4qMQjPUCzUwjpRwZMs2uu0Z//b7z/b5zvo/DIaXKfrmK
        zLE5scPGWWgiQvb45aq4mJVzLelxXX2L2PKq+wR7vKKKYAPBejnbXV9OsJ6aPsSWXRki2L7z
        w2Fs12SrfANp9JUFZcbGm/fDjOcfepGx3dMcZgzULjXW9g9LUon92GDGXDZ2qLEty56dYzMl
        0dvSMjZl6BPimBhmDZtIq22cFSfRySmpMVtyLEIgWl3AWVwClcrxPB27zuCwu5xYbbbzziQ6
        nWG0GiYuUaPVCq/uwFqtXpBkYvNQ2yN5Xu0EOtgyeAEVIXcHKkHhJFDx4D/mkZWgCFJJ1SE4
        d+4FIRajCLzFD5BYjCGYHPsu/dfyceK3VPxoQDBeeWumCCDoGG0NqQhqNTRWBuXTOJLaA/d6
        rxHTWEoVgn/qTwjPpzKhoncihGXUCph4XyERHdTg+TQc4sOprVB3ckA+bQBUNQE/zvhDyRVU
        ATSM+WRiQzLccHfM4PnwrfVhmIhVEBhpIER8CsEL91Fx0FUEPZOjMyIdDNwuEZxJId0qqKqP
        FYPOgZFfpfJpGigFnD6pFNXL4cmry4RIq+B6dZpIG6H9rHdmDz4EX8d90otoyfX/Qz0IedEC
        nMdbTZhn8nQanrPyLptJk2W31qLQhUUn1qHqzpQmRJGInq14PSc3XSnnCvhD1iYEpJSOVMya
        EihFNnfoMHbYMxwuC+abkF7Y3iWpKirLLtyrzZnB6LU6nY6NZxL0DEMvVGh3pKUrKRPnxLkY
        52HHvz4JGa4qQrOb34x/6PDXJO/axozju23d7yzBop0DI1b/vLf5UTWXuvY9311+Z2Tu6Z86
        zcb9+yq3x/olDfW5bFVvhEFZ2G16bi+1Xejkvh8x1GTu/dyyXhXtrS79deJsmSHg8vuGosw9
        yyTPtrqLN0fc+dIWDqq7+Y1BNLgjxfN0g7t98a0pWsabOSZa6uC5vxsUOr53AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnK4af060QftXFos569ewWTQvXs9m
        8fn3LlaLy7vmsFks2PiI0WLG5JdsFo/63rJbnP97nNWBw+PEjN8sHvvnrmH36NuyitHjzIIj
        7B6fN8l5bHrylimALYrLJiU1J7MstUjfLoEr4+WprawFm/4wVhx70c/YwDjzLGMXIyeHhICJ
        xN0/35m7GLk4hAR2M0p8vnQUKiElMffbdiCbA8gWljh8uBii5iOjRPvRhawgNWwCOhL7l/wG
        s0UEIiQOPJvMBlLELNDKKHFmyWEmkISwQJzE5g1dLCA2i4CqxJ/bi8HivAJuEosav7JBLFOQ
        WHDvLZjNKeAusaPtGdhQIYESiZlH/7BPYORbwMiwilEytaA4Nz232LDAKC+1XK84Mbe4NC9d
        Lzk/dxMjOBy1tHYwnjgRf4hRgINRiYf3Al92tBBrYllxZe4hRgkOZiURXu7/QCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTBycUg2MwR/T9v0VTVdPnvdBgMmk
        YPPagKkHj2yQfruww5+7QWn/3Jyvh7WDPMxuvJzNEKShOOVYp+7nxs3Wc1+ed1j1Zpay/X1u
        tmUfZlpUvvHd6KJoI35gy2T1cJ0pB188SBfXOVV68AG74JwJcxP3HCpIkYz2Zon0Pz796Bqe
        wtX5vDbuG29M1+hQUGIpzkg01GIuKk4EAB5d6h1DAgAA
Message-Id: <20180809095342epcas1p21503f49bbf9e4814ea76c509c873a559~JLqIt06wB0657706577epcas1p2x@epcas1p2.samsung.com>
X-CMS-MailID: 20180809095342epcas1p21503f49bbf9e4814ea76c509c873a559
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180809095342epcas1p21503f49bbf9e4814ea76c509c873a559
References: <20180705005205.GC30522@ZenIV.linux.org.uk>
        <1533808424-20649-1-git-send-email-sw0312.kim@samsung.com>
        <CGME20180809095342epcas1p21503f49bbf9e4814ea76c509c873a559@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

preparation for similar switch in ->setxattr() (see the next commit for
rationale).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

[sw0312.kim: backport to 3.18 including ext3]
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 fs/9p/acl.c                  |    7 +++----
 fs/9p/xattr_security.c       |    5 +++--
 fs/9p/xattr_trusted.c        |    5 +++--
 fs/9p/xattr_user.c           |    5 +++--
 fs/ext2/xattr_security.c     |    7 ++++---
 fs/ext2/xattr_trusted.c      |    7 ++++---
 fs/ext2/xattr_user.c         |    9 +++++----
 fs/ext3/xattr_security.c     |    7 ++++---
 fs/ext3/xattr_trusted.c      |    7 ++++---
 fs/ext3/xattr_user.c         |    9 +++++----
 fs/ext4/xattr_security.c     |    7 ++++---
 fs/ext4/xattr_trusted.c      |    7 ++++---
 fs/ext4/xattr_user.c         |    9 +++++----
 fs/f2fs/xattr.c              |   17 ++++++++---------
 fs/gfs2/xattr.c              |    7 ++++---
 fs/hfsplus/xattr.c           |    7 ++++---
 fs/hfsplus/xattr.h           |    4 ++--
 fs/hfsplus/xattr_security.c  |    7 ++++---
 fs/hfsplus/xattr_trusted.c   |    7 ++++---
 fs/hfsplus/xattr_user.c      |    7 ++++---
 fs/jffs2/security.c          |    7 ++++---
 fs/jffs2/xattr_trusted.c     |    7 ++++---
 fs/jffs2/xattr_user.c        |    7 ++++---
 fs/nfs/nfs4proc.c            |   19 +++++++++----------
 fs/ocfs2/xattr.c             |   23 +++++++++++++----------
 fs/posix_acl.c               |    6 +++---
 fs/reiserfs/xattr.c          |    6 ++++--
 fs/reiserfs/xattr_security.c |    8 ++++----
 fs/reiserfs/xattr_trusted.c  |    8 ++++----
 fs/reiserfs/xattr_user.c     |    8 ++++----
 fs/xattr.c                   |    5 +++--
 fs/xfs/xfs_xattr.c           |    7 ++++---
 include/linux/xattr.h        |    5 +++--
 33 files changed, 144 insertions(+), 119 deletions(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 938e1a4..0928d74 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -279,14 +279,13 @@ static int v9fs_remote_set_acl(struct dentry *dentry, const char *name,
 }
 
 
-static int v9fs_xattr_set_acl(struct dentry *dentry, const char *name,
-			      const void *value, size_t size,
-			      int flags, int type)
+static int v9fs_xattr_set_acl(struct dentry *dentry, struct inode *inode,
+			      const char *name, const void *value,
+			      size_t size, int flags, int type)
 {
 	int retval;
 	struct posix_acl *acl;
 	struct v9fs_session_info *v9ses;
-	struct inode *inode = dentry->d_inode;
 
 	if (strcmp(name, "") != 0)
 		return -EINVAL;
diff --git a/fs/9p/xattr_security.c b/fs/9p/xattr_security.c
index df692f9..242c1f8 100644
--- a/fs/9p/xattr_security.c
+++ b/fs/9p/xattr_security.c
@@ -47,8 +47,9 @@ static int v9fs_xattr_security_get(struct dentry *dentry, struct inode *inode,
 	return retval;
 }
 
-static int v9fs_xattr_security_set(struct dentry *dentry, const char *name,
-			const void *value, size_t size, int flags, int type)
+static int v9fs_xattr_security_set(struct dentry *dentry, struct inode *inode,
+				   const char *name, const void *value,
+				   size_t size, int flags, int type)
 {
 	int retval;
 	char *full_name;
diff --git a/fs/9p/xattr_trusted.c b/fs/9p/xattr_trusted.c
index acfadcf..a1fe7d9 100644
--- a/fs/9p/xattr_trusted.c
+++ b/fs/9p/xattr_trusted.c
@@ -47,8 +47,9 @@ static int v9fs_xattr_trusted_get(struct dentry *dentry, struct inode *inode,
 	return retval;
 }
 
-static int v9fs_xattr_trusted_set(struct dentry *dentry, const char *name,
-			const void *value, size_t size, int flags, int type)
+static int v9fs_xattr_trusted_set(struct dentry *dentry, struct inode *inode,
+				  const char *name, const void *value,
+				  size_t size, int flags, int type)
 {
 	int retval;
 	char *full_name;
diff --git a/fs/9p/xattr_user.c b/fs/9p/xattr_user.c
index 9b37675..7a34aca 100644
--- a/fs/9p/xattr_user.c
+++ b/fs/9p/xattr_user.c
@@ -47,8 +47,9 @@ static int v9fs_xattr_user_get(struct dentry *dentry, struct inode *inode,
 	return retval;
 }
 
-static int v9fs_xattr_user_set(struct dentry *dentry, const char *name,
-			const void *value, size_t size, int flags, int type)
+static int v9fs_xattr_user_set(struct dentry *dentry, struct inode *inode,
+			       const char *name, const void *value,
+			       size_t size, int flags, int type)
 {
 	int retval;
 	char *full_name;
diff --git a/fs/ext2/xattr_security.c b/fs/ext2/xattr_security.c
index 1d53da4..3ece525 100644
--- a/fs/ext2/xattr_security.c
+++ b/fs/ext2/xattr_security.c
@@ -33,12 +33,13 @@ ext2_xattr_security_get(struct dentry *unused, struct inode *inode,
 }
 
 static int
-ext2_xattr_security_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+ext2_xattr_security_set(struct dentry *unused, struct inode *inode,
+			const char *name, const void *value,
+			size_t size, int flags, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return ext2_xattr_set(dentry->d_inode, EXT2_XATTR_INDEX_SECURITY, name,
+	return ext2_xattr_set(inode, EXT2_XATTR_INDEX_SECURITY, name,
 			      value, size, flags);
 }
 
diff --git a/fs/ext2/xattr_trusted.c b/fs/ext2/xattr_trusted.c
index dd05f14..d88cbb1 100644
--- a/fs/ext2/xattr_trusted.c
+++ b/fs/ext2/xattr_trusted.c
@@ -37,12 +37,13 @@ ext2_xattr_trusted_get(struct dentry *unused, struct inode *inode,
 }
 
 static int
-ext2_xattr_trusted_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+ext2_xattr_trusted_set(struct dentry *unused, struct inode *inode,
+		       const char *name, const void *value,
+		       size_t size, int flags, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return ext2_xattr_set(dentry->d_inode, EXT2_XATTR_INDEX_TRUSTED, name,
+	return ext2_xattr_set(inode, EXT2_XATTR_INDEX_TRUSTED, name,
 			      value, size, flags);
 }
 
diff --git a/fs/ext2/xattr_user.c b/fs/ext2/xattr_user.c
index b3289d5..b96a8f8 100644
--- a/fs/ext2/xattr_user.c
+++ b/fs/ext2/xattr_user.c
@@ -41,15 +41,16 @@ ext2_xattr_user_get(struct dentry *unused, struct inode *inode,
 }
 
 static int
-ext2_xattr_user_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+ext2_xattr_user_set(struct dentry *unused, struct inode *inode,
+		    const char *name, const void *value,
+		    size_t size, int flags, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	if (!test_opt(dentry->d_sb, XATTR_USER))
+	if (!test_opt(inode->i_sb, XATTR_USER))
 		return -EOPNOTSUPP;
 
-	return ext2_xattr_set(dentry->d_inode, EXT2_XATTR_INDEX_USER,
+	return ext2_xattr_set(inode, EXT2_XATTR_INDEX_USER,
 			      name, value, size, flags);
 }
 
diff --git a/fs/ext3/xattr_security.c b/fs/ext3/xattr_security.c
index 3e60abc..815f8c4 100644
--- a/fs/ext3/xattr_security.c
+++ b/fs/ext3/xattr_security.c
@@ -34,12 +34,13 @@ ext3_xattr_security_get(struct dentry *unused, struct inode *inode,
 }
 
 static int
-ext3_xattr_security_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+ext3_xattr_security_set(struct dentry *unused, struct inode *inode,
+			const char *name, const void *value,
+			size_t size, int flags, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return ext3_xattr_set(dentry->d_inode, EXT3_XATTR_INDEX_SECURITY,
+	return ext3_xattr_set(inode, EXT3_XATTR_INDEX_SECURITY,
 			      name, value, size, flags);
 }
 
diff --git a/fs/ext3/xattr_trusted.c b/fs/ext3/xattr_trusted.c
index 9fe035b..f9e1769 100644
--- a/fs/ext3/xattr_trusted.c
+++ b/fs/ext3/xattr_trusted.c
@@ -37,12 +37,13 @@ ext3_xattr_trusted_get(struct dentry *unused, struct inode *inode,
 }
 
 static int
-ext3_xattr_trusted_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+ext3_xattr_trusted_set(struct dentry *unused, struct inode *inode,
+		       const char *name, const void *value,
+		       size_t size, int flags, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return ext3_xattr_set(dentry->d_inode, EXT3_XATTR_INDEX_TRUSTED, name,
+	return ext3_xattr_set(inode, EXT3_XATTR_INDEX_TRUSTED, name,
 			      value, size, flags);
 }
 
diff --git a/fs/ext3/xattr_user.c b/fs/ext3/xattr_user.c
index 8856f51..ce7b23d 100644
--- a/fs/ext3/xattr_user.c
+++ b/fs/ext3/xattr_user.c
@@ -39,14 +39,15 @@ ext3_xattr_user_get(struct dentry *unused, struct inode *inode,
 }
 
 static int
-ext3_xattr_user_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+ext3_xattr_user_set(struct dentry *unused, struct inode *inode,
+		    const char *name, const void *value,
+		    size_t size, int flags, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	if (!test_opt(dentry->d_sb, XATTR_USER))
+	if (!test_opt(inode->i_sb, XATTR_USER))
 		return -EOPNOTSUPP;
-	return ext3_xattr_set(dentry->d_inode, EXT3_XATTR_INDEX_USER,
+	return ext3_xattr_set(inode, EXT3_XATTR_INDEX_USER,
 			      name, value, size, flags);
 }
 
diff --git a/fs/ext4/xattr_security.c b/fs/ext4/xattr_security.c
index 7704e94..c0dc82d 100644
--- a/fs/ext4/xattr_security.c
+++ b/fs/ext4/xattr_security.c
@@ -38,12 +38,13 @@ ext4_xattr_security_get(struct dentry *unused, struct inode *inode,
 }
 
 static int
-ext4_xattr_security_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+ext4_xattr_security_set(struct dentry *unused, struct inode *inode,
+			const char *name, const void *value,
+			size_t size, int flags, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return ext4_xattr_set(dentry->d_inode, EXT4_XATTR_INDEX_SECURITY,
+	return ext4_xattr_set(inode, EXT4_XATTR_INDEX_SECURITY,
 			      name, value, size, flags);
 }
 
diff --git a/fs/ext4/xattr_trusted.c b/fs/ext4/xattr_trusted.c
index 7bf8df2..42d6db0 100644
--- a/fs/ext4/xattr_trusted.c
+++ b/fs/ext4/xattr_trusted.c
@@ -41,12 +41,13 @@ ext4_xattr_trusted_get(struct dentry *unused, struct inode *inode,
 }
 
 static int
-ext4_xattr_trusted_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+ext4_xattr_trusted_set(struct dentry *unused, struct inode *inode,
+		       const char *name, const void *value,
+		       size_t size, int flags, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return ext4_xattr_set(dentry->d_inode, EXT4_XATTR_INDEX_TRUSTED,
+	return ext4_xattr_set(inode, EXT4_XATTR_INDEX_TRUSTED,
 			      name, value, size, flags);
 }
 
diff --git a/fs/ext4/xattr_user.c b/fs/ext4/xattr_user.c
index afad2827..f37a4ff 100644
--- a/fs/ext4/xattr_user.c
+++ b/fs/ext4/xattr_user.c
@@ -42,14 +42,15 @@ ext4_xattr_user_get(struct dentry *unused, struct inode *inode,
 }
 
 static int
-ext4_xattr_user_set(struct dentry *dentry, const char *name,
-		    const void *value, size_t size, int flags, int type)
+ext4_xattr_user_set(struct dentry *unused, struct inode *inode,
+		    const char *name, const void *value,
+		    size_t size, int flags, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	if (!test_opt(dentry->d_sb, XATTR_USER))
+	if (!test_opt(inode->i_sb, XATTR_USER))
 		return -EOPNOTSUPP;
-	return ext4_xattr_set(dentry->d_inode, EXT4_XATTR_INDEX_USER,
+	return ext4_xattr_set(inode, EXT4_XATTR_INDEX_USER,
 			      name, value, size, flags);
 }
 
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index a6e15c5..3f4705f 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -87,10 +87,11 @@ static int f2fs_xattr_generic_get(struct dentry *unused, struct inode *inode,
 	return f2fs_getxattr(inode, type, name, buffer, size);
 }
 
-static int f2fs_xattr_generic_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+static int f2fs_xattr_generic_set(struct dentry *unused, struct inode *inode,
+				  const char *name, const void *value,
+				  size_t size, int flags, int type)
 {
-	struct f2fs_sb_info *sbi = F2FS_SB(dentry->d_sb);
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 
 	switch (type) {
 	case F2FS_XATTR_INDEX_USER:
@@ -109,8 +110,7 @@ static int f2fs_xattr_generic_set(struct dentry *dentry, const char *name,
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
 
-	return f2fs_setxattr(dentry->d_inode, type, name,
-					value, size, NULL, flags);
+	return f2fs_setxattr(inode, type, name,	value, size, NULL, flags);
 }
 
 static size_t f2fs_xattr_advise_list(struct dentry *dentry, char *list,
@@ -138,11 +138,10 @@ static int f2fs_xattr_advise_get(struct dentry *unused, struct inode *inode,
 	return sizeof(char);
 }
 
-static int f2fs_xattr_advise_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+static int f2fs_xattr_advise_set(struct dentry *unused, struct inode *inode,
+				 const char *name, const void *value,
+				 size_t size, int flags, int type)
 {
-	struct inode *inode = dentry->d_inode;
-
 	if (strcmp(name, "") != 0)
 		return -EINVAL;
 	if (!inode_owner_or_capable(inode))
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 0c15e9f..96e47b0 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -1227,10 +1227,11 @@ int __gfs2_xattr_set(struct inode *inode, const char *name,
 	return error;
 }
 
-static int gfs2_xattr_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+static int gfs2_xattr_set(struct dentry *unused, struct inode *inode,
+			  const char *name, const void *value,
+			  size_t size, int flags, int type)
 {
-	return __gfs2_xattr_set(dentry->d_inode, name, value,
+	return __gfs2_xattr_set(inode, name, value,
 				size, flags, type);
 }
 
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 1377437..1ac46a2 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -826,8 +826,9 @@ static int hfsplus_osx_getxattr(struct dentry *unused, struct inode *inode,
 	return hfsplus_getxattr(inode, name, buffer, size);
 }
 
-static int hfsplus_osx_setxattr(struct dentry *dentry, const char *name,
-		const void *buffer, size_t size, int flags, int type)
+static int hfsplus_osx_setxattr(struct dentry *unused, struct inode *inode,
+				const char *name, const void *buffer,
+				size_t size, int flags, int type)
 {
 	if (!strcmp(name, ""))
 		return -EINVAL;
@@ -845,7 +846,7 @@ static int hfsplus_osx_setxattr(struct dentry *dentry, const char *name,
 	 * creates), so we pass the name through unmodified (after
 	 * ensuring it doesn't conflict with another namespace).
 	 */
-	return hfsplus_setxattr(dentry, name, buffer, size, flags);
+	return hfsplus_setxattr(inode, name, buffer, size, flags);
 }
 
 static size_t hfsplus_osx_listxattr(struct dentry *dentry, char *list,
diff --git a/fs/hfsplus/xattr.h b/fs/hfsplus/xattr.h
index ba9d80d7..28337f5 100644
--- a/fs/hfsplus/xattr.h
+++ b/fs/hfsplus/xattr.h
@@ -21,10 +21,10 @@ extern const struct xattr_handler *hfsplus_xattr_handlers[];
 int __hfsplus_setxattr(struct inode *inode, const char *name,
 			const void *value, size_t size, int flags);
 
-static inline int hfsplus_setxattr(struct dentry *dentry, const char *name,
+static inline int hfsplus_setxattr(struct inode *inode, const char *name,
 			const void *value, size_t size, int flags)
 {
-	return __hfsplus_setxattr(dentry->d_inode, name, value, size, flags);
+	return __hfsplus_setxattr(inode, name, value, size, flags);
 }
 
 ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
diff --git a/fs/hfsplus/xattr_security.c b/fs/hfsplus/xattr_security.c
index 77d7f29..ccbc7df 100644
--- a/fs/hfsplus/xattr_security.c
+++ b/fs/hfsplus/xattr_security.c
@@ -35,8 +35,9 @@ static int hfsplus_security_getxattr(struct dentry *unused, struct inode *inode,
 	return res;
 }
 
-static int hfsplus_security_setxattr(struct dentry *dentry, const char *name,
-		const void *buffer, size_t size, int flags, int type)
+static int hfsplus_security_setxattr(struct dentry *unused, struct inode *inode,
+				     const char *name, const void *buffer,
+				     size_t size, int flags, int type)
 {
 	char *xattr_name;
 	int res;
@@ -51,7 +52,7 @@ static int hfsplus_security_setxattr(struct dentry *dentry, const char *name,
 	strcpy(xattr_name, XATTR_SECURITY_PREFIX);
 	strcpy(xattr_name + XATTR_SECURITY_PREFIX_LEN, name);
 
-	res = hfsplus_setxattr(dentry, xattr_name, buffer, size, flags);
+	res = hfsplus_setxattr(inode, xattr_name, buffer, size, flags);
 	kfree(xattr_name);
 	return res;
 }
diff --git a/fs/hfsplus/xattr_trusted.c b/fs/hfsplus/xattr_trusted.c
index 5c9e7a0..5d54660 100644
--- a/fs/hfsplus/xattr_trusted.c
+++ b/fs/hfsplus/xattr_trusted.c
@@ -33,8 +33,9 @@ static int hfsplus_trusted_getxattr(struct dentry *unused, struct inode *inode,
 	return res;
 }
 
-static int hfsplus_trusted_setxattr(struct dentry *dentry, const char *name,
-		const void *buffer, size_t size, int flags, int type)
+static int hfsplus_trusted_setxattr(struct dentry *unused, struct inode *inode,
+				    const char *name, const void *buffer,
+				    size_t size, int flags, int type)
 {
 	char *xattr_name;
 	int res;
@@ -49,7 +50,7 @@ static int hfsplus_trusted_setxattr(struct dentry *dentry, const char *name,
 	strcpy(xattr_name, XATTR_TRUSTED_PREFIX);
 	strcpy(xattr_name + XATTR_TRUSTED_PREFIX_LEN, name);
 
-	res = hfsplus_setxattr(dentry, xattr_name, buffer, size, flags);
+	res = hfsplus_setxattr(inode, xattr_name, buffer, size, flags);
 	kfree(xattr_name);
 	return res;
 }
diff --git a/fs/hfsplus/xattr_user.c b/fs/hfsplus/xattr_user.c
index c7c424c..931c054 100644
--- a/fs/hfsplus/xattr_user.c
+++ b/fs/hfsplus/xattr_user.c
@@ -33,8 +33,9 @@ static int hfsplus_user_getxattr(struct dentry *unused, struct inode *inode,
 	return res;
 }
 
-static int hfsplus_user_setxattr(struct dentry *dentry, const char *name,
-		const void *buffer, size_t size, int flags, int type)
+static int hfsplus_user_setxattr(struct dentry *unused, struct inode *inode,
+				 const char *name, const void *buffer,
+				 size_t size, int flags, int type)
 {
 	char *xattr_name;
 	int res;
@@ -49,7 +50,7 @@ static int hfsplus_user_setxattr(struct dentry *dentry, const char *name,
 	strcpy(xattr_name, XATTR_USER_PREFIX);
 	strcpy(xattr_name + XATTR_USER_PREFIX_LEN, name);
 
-	res = hfsplus_setxattr(dentry, xattr_name, buffer, size, flags);
+	res = hfsplus_setxattr(inode, xattr_name, buffer, size, flags);
 	kfree(xattr_name);
 	return res;
 }
diff --git a/fs/jffs2/security.c b/fs/jffs2/security.c
index 77a9db6..f8ee8a2 100644
--- a/fs/jffs2/security.c
+++ b/fs/jffs2/security.c
@@ -59,13 +59,14 @@ static int jffs2_security_getxattr(struct dentry *unused, struct inode *inode,
 				 name, buffer, size);
 }
 
-static int jffs2_security_setxattr(struct dentry *dentry, const char *name,
-		const void *buffer, size_t size, int flags, int type)
+static int jffs2_security_setxattr(struct dentry *unused, struct inode *inode,
+				   const char *name, const void *buffer,
+				   size_t size, int flags, int type)
 {
 	if (!strcmp(name, ""))
 		return -EINVAL;
 
-	return do_jffs2_setxattr(dentry->d_inode, JFFS2_XPREFIX_SECURITY,
+	return do_jffs2_setxattr(inode, JFFS2_XPREFIX_SECURITY,
 				 name, buffer, size, flags);
 }
 
diff --git a/fs/jffs2/xattr_trusted.c b/fs/jffs2/xattr_trusted.c
index 7b2fe19..0f36f46 100644
--- a/fs/jffs2/xattr_trusted.c
+++ b/fs/jffs2/xattr_trusted.c
@@ -26,12 +26,13 @@ static int jffs2_trusted_getxattr(struct dentry *unused, struct inode *inode,
 				 name, buffer, size);
 }
 
-static int jffs2_trusted_setxattr(struct dentry *dentry, const char *name,
-		const void *buffer, size_t size, int flags, int type)
+static int jffs2_trusted_setxattr(struct dentry *unused, struct inode *inode,
+				  const char *name, const void *buffer,
+				  size_t size, int flags, int type)
 {
 	if (!strcmp(name, ""))
 		return -EINVAL;
-	return do_jffs2_setxattr(dentry->d_inode, JFFS2_XPREFIX_TRUSTED,
+	return do_jffs2_setxattr(inode, JFFS2_XPREFIX_TRUSTED,
 				 name, buffer, size, flags);
 }
 
diff --git a/fs/jffs2/xattr_user.c b/fs/jffs2/xattr_user.c
index 0d8b125..62551b6 100644
--- a/fs/jffs2/xattr_user.c
+++ b/fs/jffs2/xattr_user.c
@@ -26,12 +26,13 @@ static int jffs2_user_getxattr(struct dentry *unused, struct inode *inode,
 				 name, buffer, size);
 }
 
-static int jffs2_user_setxattr(struct dentry *dentry, const char *name,
-		const void *buffer, size_t size, int flags, int type)
+static int jffs2_user_setxattr(struct dentry *unused, struct inode *inode,
+			       const char *name, const void *buffer,
+			       size_t size, int flags, int type)
 {
 	if (!strcmp(name, ""))
 		return -EINVAL;
-	return do_jffs2_setxattr(dentry->d_inode, JFFS2_XPREFIX_USER,
+	return do_jffs2_setxattr(inode, JFFS2_XPREFIX_USER,
 				 name, buffer, size, flags);
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3e0df4a1..7ccecfb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4781,12 +4781,11 @@ static int nfs4_do_set_security_label(struct inode *inode,
 }
 
 static int
-nfs4_set_security_label(struct dentry *dentry, const void *buf, size_t buflen)
+nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 {
 	struct nfs4_label ilabel, *olabel = NULL;
 	struct nfs_fattr fattr;
 	struct rpc_cred *cred;
-	struct inode *inode = dentry->d_inode;
 	int status;
 
 	if (!nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL))
@@ -6037,14 +6036,14 @@ nfs4_release_lockowner(struct nfs_server *server, struct nfs4_lock_state *lsp)
 
 #define XATTR_NAME_NFSV4_ACL "system.nfs4_acl"
 
-static int nfs4_xattr_set_nfs4_acl(struct dentry *dentry, const char *key,
-				   const void *buf, size_t buflen,
-				   int flags, int type)
+static int nfs4_xattr_set_nfs4_acl(struct dentry *unused, struct inode *inode,
+				   const char *key, const void *buf,
+				   size_t buflen, int flags, int type)
 {
 	if (strcmp(key, "") != 0)
 		return -EINVAL;
 
-	return nfs4_proc_set_acl(dentry->d_inode, buf, buflen);
+	return nfs4_proc_set_acl(inode, buf, buflen);
 }
 
 static int nfs4_xattr_get_nfs4_acl(struct dentry *unused, struct inode *inode,
@@ -6077,12 +6076,12 @@ static inline int nfs4_server_supports_labels(struct nfs_server *server)
 	return server->caps & NFS_CAP_SECURITY_LABEL;
 }
 
-static int nfs4_xattr_set_nfs4_label(struct dentry *dentry, const char *key,
-				   const void *buf, size_t buflen,
-				   int flags, int type)
+static int nfs4_xattr_set_nfs4_label(struct dentry *unused, struct inode *inode,
+				     const char *key, const void *buf,
+				     size_t buflen, int flags, int type)
 {
 	if (security_ismaclabel(key))
-		return nfs4_set_security_label(dentry, buf, buflen);
+		return nfs4_set_security_label(inode, buf, buflen);
 
 	return -EOPNOTSUPP;
 }
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 8f42eaa..2d6aa1a 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -7262,13 +7262,14 @@ static int ocfs2_xattr_security_get(struct dentry *unused, struct inode *inode,
 			       name, buffer, size);
 }
 
-static int ocfs2_xattr_security_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+static int ocfs2_xattr_security_set(struct dentry *unused, struct inode *inode,
+				    const char *name, const void *value,
+				    size_t size, int flags, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
 
-	return ocfs2_xattr_set(dentry->d_inode, OCFS2_XATTR_INDEX_SECURITY,
+	return ocfs2_xattr_set(inode, OCFS2_XATTR_INDEX_SECURITY,
 			       name, value, size, flags);
 }
 
@@ -7353,13 +7354,14 @@ static int ocfs2_xattr_trusted_get(struct dentry *unused, struct inode *inode,
 			       name, buffer, size);
 }
 
-static int ocfs2_xattr_trusted_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+static int ocfs2_xattr_trusted_set(struct dentry *unused, struct inode *inode,
+				   const char *name, const void *value,
+				   size_t size, int flags, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
 
-	return ocfs2_xattr_set(dentry->d_inode, OCFS2_XATTR_INDEX_TRUSTED,
+	return ocfs2_xattr_set(inode, OCFS2_XATTR_INDEX_TRUSTED,
 			       name, value, size, flags);
 }
 
@@ -7406,17 +7408,18 @@ static int ocfs2_xattr_user_get(struct dentry *unused, struct inode *inode,
 			       buffer, size);
 }
 
-static int ocfs2_xattr_user_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+static int ocfs2_xattr_user_set(struct dentry *unused, struct inode *inode,
+				const char *name, const void *value,
+				size_t size, int flags, int type)
 {
-	struct ocfs2_super *osb = OCFS2_SB(dentry->d_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
 	if (osb->s_mount_opt & OCFS2_MOUNT_NOUSERXATTR)
 		return -EOPNOTSUPP;
 
-	return ocfs2_xattr_set(dentry->d_inode, OCFS2_XATTR_INDEX_USER,
+	return ocfs2_xattr_set(inode, OCFS2_XATTR_INDEX_USER,
 			       name, value, size, flags);
 }
 
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index a9d6c01..81b0008 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -841,10 +841,10 @@ set_posix_acl(struct inode *inode, int type, struct posix_acl *acl)
 EXPORT_SYMBOL(set_posix_acl);
 
 static int
-posix_acl_xattr_set(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags, int type)
+posix_acl_xattr_set(struct dentry *dentry, struct inode *inode,
+		    const char *name, const void *value, size_t size,
+		    int flags, int type)
 {
-	struct inode *inode = dentry->d_inode;
 	struct posix_acl *acl = NULL;
 	int ret;
 
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 40d4fcc..b5d64cc 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -797,7 +797,8 @@ reiserfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 	if (!handler || get_inode_sd_version(dentry->d_inode) == STAT_DATA_V1)
 		return -EOPNOTSUPP;
 
-	return handler->set(dentry, name, value, size, flags, handler->flags);
+	return handler->set(dentry, dentry->d_inode, name, value, size,
+			    flags, handler->flags);
 }
 
 /*
@@ -814,7 +815,8 @@ int reiserfs_removexattr(struct dentry *dentry, const char *name)
 	if (!handler || get_inode_sd_version(dentry->d_inode) == STAT_DATA_V1)
 		return -EOPNOTSUPP;
 
-	return handler->set(dentry, name, NULL, 0, XATTR_REPLACE, handler->flags);
+	return handler->set(dentry, dentry->d_inode, name, NULL, 0,
+			    XATTR_REPLACE, handler->flags);
 }
 
 struct listxattr_buf {
diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
index dad61a9..d68b8da 100644
--- a/fs/reiserfs/xattr_security.c
+++ b/fs/reiserfs/xattr_security.c
@@ -22,16 +22,16 @@ security_get(struct dentry *unused, struct inode *inode, const char *name,
 }
 
 static int
-security_set(struct dentry *dentry, const char *name, const void *buffer,
-	     size_t size, int flags, int handler_flags)
+security_set(struct dentry *unused, struct inode *inode, const char *name,
+	     const void *buffer, size_t size, int flags, int handler_flags)
 {
 	if (strlen(name) < sizeof(XATTR_SECURITY_PREFIX))
 		return -EINVAL;
 
-	if (IS_PRIVATE(dentry->d_inode))
+	if (IS_PRIVATE(inode))
 		return -EPERM;
 
-	return reiserfs_xattr_set(dentry->d_inode, name, buffer, size, flags);
+	return reiserfs_xattr_set(inode, name, buffer, size, flags);
 }
 
 static size_t security_list(struct dentry *dentry, char *list, size_t list_len,
diff --git a/fs/reiserfs/xattr_trusted.c b/fs/reiserfs/xattr_trusted.c
index 9e3cf4a..8202daa 100644
--- a/fs/reiserfs/xattr_trusted.c
+++ b/fs/reiserfs/xattr_trusted.c
@@ -21,16 +21,16 @@ trusted_get(struct dentry *unused, struct inode *inode, const char *name,
 }
 
 static int
-trusted_set(struct dentry *dentry, const char *name, const void *buffer,
-	    size_t size, int flags, int handler_flags)
+trusted_set(struct dentry *unused, struct inode *inode, const char *name,
+	    const void *buffer, size_t size, int flags, int handler_flags)
 {
 	if (strlen(name) < sizeof(XATTR_TRUSTED_PREFIX))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN) || IS_PRIVATE(dentry->d_inode))
+	if (!capable(CAP_SYS_ADMIN) || IS_PRIVATE(inode))
 		return -EPERM;
 
-	return reiserfs_xattr_set(dentry->d_inode, name, buffer, size, flags);
+	return reiserfs_xattr_set(inode, name, buffer, size, flags);
 }
 
 static size_t trusted_list(struct dentry *dentry, char *list, size_t list_size,
diff --git a/fs/reiserfs/xattr_user.c b/fs/reiserfs/xattr_user.c
index 8c0d2ef..5d0ec05 100644
--- a/fs/reiserfs/xattr_user.c
+++ b/fs/reiserfs/xattr_user.c
@@ -19,15 +19,15 @@ user_get(struct dentry *unused, struct inode *inode, const char *name,
 }
 
 static int
-user_set(struct dentry *dentry, const char *name, const void *buffer,
-	 size_t size, int flags, int handler_flags)
+user_set(struct dentry *unused, struct inode *inode, const char *name,
+	 const void *buffer, size_t size, int flags, int handler_flags)
 {
 	if (strlen(name) < sizeof(XATTR_USER_PREFIX))
 		return -EINVAL;
 
-	if (!reiserfs_xattrs_user(dentry->d_sb))
+	if (!reiserfs_xattrs_user(inode->i_sb))
 		return -EOPNOTSUPP;
-	return reiserfs_xattr_set(dentry->d_inode, name, buffer, size, flags);
+	return reiserfs_xattr_set(inode, name, buffer, size, flags);
 }
 
 static size_t user_list(struct dentry *dentry, char *list, size_t list_size,
diff --git a/fs/xattr.c b/fs/xattr.c
index b04fc6b..87bd926 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -773,7 +773,8 @@ generic_setxattr(struct dentry *dentry, const char *name, const void *value, siz
 	handler = xattr_resolve_name(dentry->d_sb->s_xattr, &name);
 	if (!handler)
 		return -EOPNOTSUPP;
-	return handler->set(dentry, name, value, size, flags, handler->flags);
+	return handler->set(dentry, dentry->d_inode, name, value, size,
+			    flags, handler->flags);
 }
 
 /*
@@ -788,7 +789,7 @@ generic_removexattr(struct dentry *dentry, const char *name)
 	handler = xattr_resolve_name(dentry->d_sb->s_xattr, &name);
 	if (!handler)
 		return -EOPNOTSUPP;
-	return handler->set(dentry, name, NULL, 0,
+	return handler->set(dentry, dentry->d_inode, name, NULL, 0,
 			    XATTR_REPLACE, handler->flags);
 }
 
diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index bd4a6ee..8e19527 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -56,10 +56,11 @@ xfs_xattr_get(struct dentry *unused, struct inode *inode, const char *name,
 }
 
 static int
-xfs_xattr_set(struct dentry *dentry, const char *name, const void *value,
-		size_t size, int flags, int xflags)
+xfs_xattr_set(struct dentry *unused, struct inode *inode,
+	      const char *name, const void *value,
+	      size_t size, int flags, int xflags)
 {
-	struct xfs_inode *ip = XFS_I(dentry->d_inode);
+	struct xfs_inode *ip = XFS_I(inode);
 
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index ad4c869..0027b04 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -26,8 +26,9 @@ struct xattr_handler {
 		       const char *name, size_t name_len, int handler_flags);
 	int (*get)(struct dentry *dentry, struct inode *inode, const char *name,
 		   void *buffer, size_t size, int handler_flags);
-	int (*set)(struct dentry *dentry, const char *name, const void *buffer,
-		   size_t size, int flags, int handler_flags);
+	int (*set)(struct dentry *dentry, struct inode *inode, const char *name,
+		   const void *buffer, size_t size, int flags,
+		   int handler_flags);
 };
 
 struct xattr {
-- 
1.7.4.1

