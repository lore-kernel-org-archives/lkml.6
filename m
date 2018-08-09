Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949C4C46471
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20401217C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LsSrJwK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20401217C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbeHIMR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:17:57 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:19901 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeHIMR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:17:56 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180809095345epoutp0178b70fb03c641c84a342e963ef6646cf~JLqL-dppI1526515265epoutp01G
        for <linux-kernel@vger.kernel.org>; Thu,  9 Aug 2018 09:53:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180809095345epoutp0178b70fb03c641c84a342e963ef6646cf~JLqL-dppI1526515265epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533808425;
        bh=59Y3nsByptoFxfOBcKNQL5+SAdSS29Dw09qnVTfbevY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsSrJwK0M+Tth9EKzYM+fNk+9nbCkHetp3qfCIFqAtNGyZSaDpZLLkg0ljwdRfAyd
         7VVeyjlia+uYZkekFYxccfojwyEcfZwPEmmnTQpfVFja1ScRRzlfuRCS419rX4epdQ
         8mFEAASre5UwCINj3JtONDnYDBRjJW1M82a6NqoQ=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180809095342epcas1p48f548a0fdd0d40f4eae78b08abc8eeff~JLqI7cAw21558015580epcas1p4H;
        Thu,  9 Aug 2018 09:53:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.0F.04292.62F0C6B5; Thu,  9 Aug 2018 18:53:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180809095342epcas1p1dde47ac63e7c4af1e389a524ff4f3a52~JLqIjpab22410724107epcas1p1B;
        Thu,  9 Aug 2018 09:53:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180809095341epsmtrp17aecb79b8767e5524382a100b603cbee~JLqIf8WGc0614706147epsmtrp1E;
        Thu,  9 Aug 2018 09:53:41 +0000 (GMT)
X-AuditID: b6c32a38-d53ff700000010c4-1c-5b6c0f265f9f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.11.03889.52F0C6B5; Thu,  9 Aug 2018 18:53:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.63.222]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180809095341epsmtip151ba3ea7ba9d7277de9262976319a0ac~JLqIRy0l51957119571epsmtip1p;
        Thu,  9 Aug 2018 09:53:41 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, jslaby@suse.cz,
        sw0312.kim@samsung.com
Subject: [PATCH 3.18.y 1/5] xattr_handler: pass dentry and inode as separate
 arguments of ->get()
Date:   Thu,  9 Aug 2018 18:53:40 +0900
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <20180705005205.GC30522@ZenIV.linux.org.uk>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURzm7HF3tWaXpXkaJuuSopLTu4deQyXwwSQJUSpIYl3mQcW92J2S
        QSmWz6QsrdywNDUks2a+KKksM82QCiLLoIfSAy1FnFYiZtuu0l/nO9/3/b7zOz9+OF8yKZTi
        uUYrshgZPYl5C/qehIaHB2/RZ0a+HfWjGxwdGH2qxYHRzpV+If26vwGjm+5MAbq+dhqjp87O
        iuiXqyPCvbjmWf2KQDNwpUOkOdvTDjRjTUMijbMrUNP1ZZaXhh1GsTmIyUIWGTLqTFm5xuw4
        cl+GNkGrjoqkwqkYOpqUGRkDiiMTU9PCk3P1roZIWQGjz3dRaQzLkhHxsRZTvhXJckysNY7M
        pCiFnIqMlisUrlN5ZI9C7bIcRTntzlK+eWAJHGtrrhYVg+cjoAp44ZBQwYrFbkEV8MYlxF0A
        ezraeG5BQiwAaKv154RfAFZcfiDYqKgvH+ZxwgMAHStjGHdxAvi9cdjjwojdcKB1RejGvsRB
        eHPyIubGfKIITqz99eCthA7apmc8fgERBBtLFjDuBRls+jjrwjjuRdDw/Xy0Ox8SnRgcHyzj
        uXkxUQAfVgZy9kT4ta91/Ttb4cxIj4jDUjh9rmwdlwP42HaSy6kDcHx1YV1Qwm/XqjyZfCIU
        OvojuDZ94NxStdBNQ0IMK8oknHsXvPf0AsbRUmjvzOBoDeytHF0fyRkA62qaRTVgh/1/aBMA
        7WAbMrOGbMRSZpWcZQxsvjFbrjMZuoBnvcLou+D+i9RBQOCA3Cx+5ZOXKREyBWyhYRBAnE/6
        ijetuShxFlN4HFlMWku+HrGDQO2a3Xm+1E9nci2r0aql1AqlUkmrqCg1RZH+YsX+jEwJkc1Y
        UR5CZmTZqOPhXtJiYCvtSQopyS3H2uy6OW3QfLq9anK+NfbRYtSed8HoQPut7Y6I0JikoSur
        196YO1W+H4rM2Pil+LrllMDKgBcnUpQ/fv/se7Qt/tPYmHN0s0+GIPXJ7fQE272Qg6eZPwu3
        Q1ui7RPnAqTLHde7u3vZLkVy766dI8ufVTdaun0irx7KIgVsDkOF8S0s8w/hlTwDdAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSnK4qf060weleY4s569ewWTQvXs9m
        8fn3LlaLy7vmsFks2PiI0WLG5JdsFo/63rJbnP97nNWBw+PEjN8sHvvnrmH36NuyitHjzIIj
        7B6fN8l5bHrylimALYrLJiU1J7MstUjfLoErY9XnVuaC/V8ZK5Yv6mFvYDx1nLGLkZNDQsBE
        Ykb7MaYuRi4OIYHdjBK9T1tYIBJSEnO/bQcq4gCyhSUOHy6GqPnIKPF7xy5WkBo2AR2J/Ut+
        g9kiAhESB55NZgMpYhZoZZQ4s+QwE0hCWCBRovnDKbAiFgFViflNn9hAbF4BN4mJ62GWKUgs
        uPeWDWQZp4CFxK0P5iBhIQFziYbph9gmMPItYGRYxSiZWlCcm55bbFhglJdarlecmFtcmpeu
        l5yfu4kRHIxaWjsYT5yIP8QowMGoxMN7gS87Wog1say4MvcQowQHs5IIL/d/oBBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXFe+fxjkUIC6YklqdmpqQWpRTBZJg5OqQZGN6lfPAejEl7fu/uyj/lb
        bKGzio/3ubRlC0XTwvurv2pwP/0qvPVKTPlG42XeW9Y7tWeVHjq/OmYaN7fIKpM26fsr+q+1
        L5x6YZlt5cwEjSqbq7oe3Nv5lv0+pvWQfZNbUnQEY6P7rsSjCumfT20wV2ALr3zJ+uLDuRm3
        tPr/NG9XOPfjXASnEktxRqKhFnNRcSIA2v7aoUICAAA=
Message-Id: <20180809095342epcas1p1dde47ac63e7c4af1e389a524ff4f3a52~JLqIjpab22410724107epcas1p1B@epcas1p1.samsung.com>
X-CMS-MailID: 20180809095342epcas1p1dde47ac63e7c4af1e389a524ff4f3a52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180809095342epcas1p1dde47ac63e7c4af1e389a524ff4f3a52
References: <20180705005205.GC30522@ZenIV.linux.org.uk>
        <CGME20180809095342epcas1p1dde47ac63e7c4af1e389a524ff4f3a52@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit b296821a7c42fa58baa17513b2b7b30ae66f3336 upstream.

... and do not assume they are already attached to each other

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

[sw0312.kim: backport to 3.18 including ext3]
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 fs/9p/acl.c                  |    7 ++++---
 fs/9p/xattr_security.c       |    5 +++--
 fs/9p/xattr_trusted.c        |    5 +++--
 fs/9p/xattr_user.c           |    5 +++--
 fs/ext2/xattr_security.c     |    6 +++---
 fs/ext2/xattr_trusted.c      |    6 +++---
 fs/ext2/xattr_user.c         |    8 ++++----
 fs/ext3/xattr_security.c     |    6 +++---
 fs/ext3/xattr_trusted.c      |    6 +++---
 fs/ext3/xattr_user.c         |    8 ++++----
 fs/ext4/xattr_security.c     |    6 +++---
 fs/ext4/xattr_trusted.c      |    6 +++---
 fs/ext4/xattr_user.c         |    8 ++++----
 fs/f2fs/xattr.c              |   15 +++++++--------
 fs/gfs2/xattr.c              |    6 +++---
 fs/hfsplus/xattr.c           |    7 ++++---
 fs/hfsplus/xattr.h           |   10 +++++-----
 fs/hfsplus/xattr_security.c  |    7 ++++---
 fs/hfsplus/xattr_trusted.c   |    7 ++++---
 fs/hfsplus/xattr_user.c      |    7 ++++---
 fs/jffs2/security.c          |    7 ++++---
 fs/jffs2/xattr_trusted.c     |    7 ++++---
 fs/jffs2/xattr_user.c        |    7 ++++---
 fs/nfs/nfs4proc.c            |   14 ++++++++------
 fs/ocfs2/xattr.c             |   23 +++++++++++++----------
 fs/posix_acl.c               |   10 +++++-----
 fs/reiserfs/xattr.c          |    3 ++-
 fs/reiserfs/xattr_security.c |    8 ++++----
 fs/reiserfs/xattr_trusted.c  |    8 ++++----
 fs/reiserfs/xattr_user.c     |    8 ++++----
 fs/squashfs/xattr.c          |   22 +++++++++++++---------
 fs/xattr.c                   |    3 ++-
 fs/xfs/xfs_xattr.c           |    4 ++--
 include/linux/xattr.h        |    4 ++--
 34 files changed, 145 insertions(+), 124 deletions(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index cc67477..938e1a4 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -230,8 +230,9 @@ static int v9fs_remote_get_acl(struct dentry *dentry, const char *name,
 	return v9fs_xattr_get(dentry, full_name, buffer, size);
 }
 
-static int v9fs_xattr_get_acl(struct dentry *dentry, const char *name,
-			      void *buffer, size_t size, int type)
+static int v9fs_xattr_get_acl(struct dentry *dentry, struct inode *inode,
+			      const char *name, void *buffer, size_t size,
+			      int type)
 {
 	struct v9fs_session_info *v9ses;
 	struct posix_acl *acl;
@@ -247,7 +248,7 @@ static int v9fs_xattr_get_acl(struct dentry *dentry, const char *name,
 	if ((v9ses->flags & V9FS_ACCESS_MASK) != V9FS_ACCESS_CLIENT)
 		return v9fs_remote_get_acl(dentry, name, buffer, size, type);
 
-	acl = v9fs_get_cached_acl(dentry->d_inode, type);
+	acl = v9fs_get_cached_acl(inode, type);
 	if (IS_ERR(acl))
 		return PTR_ERR(acl);
 	if (acl == NULL)
diff --git a/fs/9p/xattr_security.c b/fs/9p/xattr_security.c
index cb247a1..df692f9 100644
--- a/fs/9p/xattr_security.c
+++ b/fs/9p/xattr_security.c
@@ -19,8 +19,9 @@
 #include <linux/slab.h>
 #include "xattr.h"
 
-static int v9fs_xattr_security_get(struct dentry *dentry, const char *name,
-			void *buffer, size_t size, int type)
+static int v9fs_xattr_security_get(struct dentry *dentry, struct inode *inode,
+				   const char *name, void *buffer, size_t size,
+				   int type)
 {
 	int retval;
 	char *full_name;
diff --git a/fs/9p/xattr_trusted.c b/fs/9p/xattr_trusted.c
index e30d33b..acfadcf 100644
--- a/fs/9p/xattr_trusted.c
+++ b/fs/9p/xattr_trusted.c
@@ -19,8 +19,9 @@
 #include <linux/slab.h>
 #include "xattr.h"
 
-static int v9fs_xattr_trusted_get(struct dentry *dentry, const char *name,
-			void *buffer, size_t size, int type)
+static int v9fs_xattr_trusted_get(struct dentry *dentry, struct inode *inode,
+				  const char *name, void *buffer, size_t size,
+				  int type)
 {
 	int retval;
 	char *full_name;
diff --git a/fs/9p/xattr_user.c b/fs/9p/xattr_user.c
index d0b701b..9b37675 100644
--- a/fs/9p/xattr_user.c
+++ b/fs/9p/xattr_user.c
@@ -19,8 +19,9 @@
 #include <linux/slab.h>
 #include "xattr.h"
 
-static int v9fs_xattr_user_get(struct dentry *dentry, const char *name,
-			void *buffer, size_t size, int type)
+static int v9fs_xattr_user_get(struct dentry *dentry, struct inode *inode,
+			       const char *name, void *buffer, size_t size,
+			       int type)
 {
 	int retval;
 	char *full_name;
diff --git a/fs/ext2/xattr_security.c b/fs/ext2/xattr_security.c
index c0ebc4d..1d53da4 100644
--- a/fs/ext2/xattr_security.c
+++ b/fs/ext2/xattr_security.c
@@ -23,12 +23,12 @@ ext2_xattr_security_list(struct dentry *dentry, char *list, size_t list_size,
 }
 
 static int
-ext2_xattr_security_get(struct dentry *dentry, const char *name,
-		       void *buffer, size_t size, int type)
+ext2_xattr_security_get(struct dentry *unused, struct inode *inode,
+			const char *name, void *buffer, size_t size, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return ext2_xattr_get(dentry->d_inode, EXT2_XATTR_INDEX_SECURITY, name,
+	return ext2_xattr_get(inode, EXT2_XATTR_INDEX_SECURITY, name,
 			      buffer, size);
 }
 
diff --git a/fs/ext2/xattr_trusted.c b/fs/ext2/xattr_trusted.c
index 7e19257..dd05f14 100644
--- a/fs/ext2/xattr_trusted.c
+++ b/fs/ext2/xattr_trusted.c
@@ -27,12 +27,12 @@ ext2_xattr_trusted_list(struct dentry *dentry, char *list, size_t list_size,
 }
 
 static int
-ext2_xattr_trusted_get(struct dentry *dentry, const char *name,
-		void *buffer, size_t size, int type)
+ext2_xattr_trusted_get(struct dentry *unused, struct inode *inode,
+		       const char *name, void *buffer, size_t size, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return ext2_xattr_get(dentry->d_inode, EXT2_XATTR_INDEX_TRUSTED, name,
+	return ext2_xattr_get(inode, EXT2_XATTR_INDEX_TRUSTED, name,
 			      buffer, size);
 }
 
diff --git a/fs/ext2/xattr_user.c b/fs/ext2/xattr_user.c
index f470e44..b3289d5 100644
--- a/fs/ext2/xattr_user.c
+++ b/fs/ext2/xattr_user.c
@@ -29,14 +29,14 @@ ext2_xattr_user_list(struct dentry *dentry, char *list, size_t list_size,
 }
 
 static int
-ext2_xattr_user_get(struct dentry *dentry, const char *name,
-		void *buffer, size_t size, int type)
+ext2_xattr_user_get(struct dentry *unused, struct inode *inode,
+		    const char *name, void *buffer, size_t size, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	if (!test_opt(dentry->d_sb, XATTR_USER))
+	if (!test_opt(inode->i_sb, XATTR_USER))
 		return -EOPNOTSUPP;
-	return ext2_xattr_get(dentry->d_inode, EXT2_XATTR_INDEX_USER,
+	return ext2_xattr_get(inode, EXT2_XATTR_INDEX_USER,
 			      name, buffer, size);
 }
 
diff --git a/fs/ext3/xattr_security.c b/fs/ext3/xattr_security.c
index 722c2bf..3e60abc 100644
--- a/fs/ext3/xattr_security.c
+++ b/fs/ext3/xattr_security.c
@@ -24,12 +24,12 @@ ext3_xattr_security_list(struct dentry *dentry, char *list, size_t list_size,
 }
 
 static int
-ext3_xattr_security_get(struct dentry *dentry, const char *name,
-		void *buffer, size_t size, int type)
+ext3_xattr_security_get(struct dentry *unused, struct inode *inode,
+			const char *name, void *buffer, size_t size, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return ext3_xattr_get(dentry->d_inode, EXT3_XATTR_INDEX_SECURITY,
+	return ext3_xattr_get(inode, EXT3_XATTR_INDEX_SECURITY,
 			      name, buffer, size);
 }
 
diff --git a/fs/ext3/xattr_trusted.c b/fs/ext3/xattr_trusted.c
index d75727c..9fe035b 100644
--- a/fs/ext3/xattr_trusted.c
+++ b/fs/ext3/xattr_trusted.c
@@ -27,12 +27,12 @@ ext3_xattr_trusted_list(struct dentry *dentry, char *list, size_t list_size,
 }
 
 static int
-ext3_xattr_trusted_get(struct dentry *dentry, const char *name,
-		       void *buffer, size_t size, int type)
+ext3_xattr_trusted_get(struct dentry *unused, struct inode *inode,
+		       const char *name, void *buffer, size_t size, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return ext3_xattr_get(dentry->d_inode, EXT3_XATTR_INDEX_TRUSTED,
+	return ext3_xattr_get(inode, EXT3_XATTR_INDEX_TRUSTED,
 			      name, buffer, size);
 }
 
diff --git a/fs/ext3/xattr_user.c b/fs/ext3/xattr_user.c
index 5612af3..8856f51 100644
--- a/fs/ext3/xattr_user.c
+++ b/fs/ext3/xattr_user.c
@@ -27,14 +27,14 @@ ext3_xattr_user_list(struct dentry *dentry, char *list, size_t list_size,
 }
 
 static int
-ext3_xattr_user_get(struct dentry *dentry, const char *name, void *buffer,
-		size_t size, int type)
+ext3_xattr_user_get(struct dentry *unused, struct inode *inode,
+		    const char *name, void *buffer, size_t size, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	if (!test_opt(dentry->d_sb, XATTR_USER))
+	if (!test_opt(inode->i_sb, XATTR_USER))
 		return -EOPNOTSUPP;
-	return ext3_xattr_get(dentry->d_inode, EXT3_XATTR_INDEX_USER,
+	return ext3_xattr_get(inode, EXT3_XATTR_INDEX_USER,
 			      name, buffer, size);
 }
 
diff --git a/fs/ext4/xattr_security.c b/fs/ext4/xattr_security.c
index d2a2006..7704e94 100644
--- a/fs/ext4/xattr_security.c
+++ b/fs/ext4/xattr_security.c
@@ -28,12 +28,12 @@ ext4_xattr_security_list(struct dentry *dentry, char *list, size_t list_size,
 }
 
 static int
-ext4_xattr_security_get(struct dentry *dentry, const char *name,
-		       void *buffer, size_t size, int type)
+ext4_xattr_security_get(struct dentry *unused, struct inode *inode,
+			const char *name, void *buffer, size_t size, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return ext4_xattr_get(dentry->d_inode, EXT4_XATTR_INDEX_SECURITY,
+	return ext4_xattr_get(inode, EXT4_XATTR_INDEX_SECURITY,
 			      name, buffer, size);
 }
 
diff --git a/fs/ext4/xattr_trusted.c b/fs/ext4/xattr_trusted.c
index 95f1f4a..7bf8df2 100644
--- a/fs/ext4/xattr_trusted.c
+++ b/fs/ext4/xattr_trusted.c
@@ -31,12 +31,12 @@ ext4_xattr_trusted_list(struct dentry *dentry, char *list, size_t list_size,
 }
 
 static int
-ext4_xattr_trusted_get(struct dentry *dentry, const char *name, void *buffer,
-		size_t size, int type)
+ext4_xattr_trusted_get(struct dentry *unused, struct inode *inode,
+		       const char *name, void *buffer, size_t size, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return ext4_xattr_get(dentry->d_inode, EXT4_XATTR_INDEX_TRUSTED,
+	return ext4_xattr_get(inode, EXT4_XATTR_INDEX_TRUSTED,
 			      name, buffer, size);
 }
 
diff --git a/fs/ext4/xattr_user.c b/fs/ext4/xattr_user.c
index 0edb7611..afad2827 100644
--- a/fs/ext4/xattr_user.c
+++ b/fs/ext4/xattr_user.c
@@ -30,14 +30,14 @@ ext4_xattr_user_list(struct dentry *dentry, char *list, size_t list_size,
 }
 
 static int
-ext4_xattr_user_get(struct dentry *dentry, const char *name,
-		    void *buffer, size_t size, int type)
+ext4_xattr_user_get(struct dentry *unused, struct inode *inode,
+		    const char *name, void *buffer, size_t size, int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	if (!test_opt(dentry->d_sb, XATTR_USER))
+	if (!test_opt(inode->i_sb, XATTR_USER))
 		return -EOPNOTSUPP;
-	return ext4_xattr_get(dentry->d_inode, EXT4_XATTR_INDEX_USER,
+	return ext4_xattr_get(inode, EXT4_XATTR_INDEX_USER,
 			      name, buffer, size);
 }
 
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index deca872..a6e15c5 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -62,10 +62,11 @@ static size_t f2fs_xattr_generic_list(struct dentry *dentry, char *list,
 	return total_len;
 }
 
-static int f2fs_xattr_generic_get(struct dentry *dentry, const char *name,
-		void *buffer, size_t size, int type)
+static int f2fs_xattr_generic_get(struct dentry *unused, struct inode *inode,
+				  const char *name, void *buffer, size_t size,
+				  int type)
 {
-	struct f2fs_sb_info *sbi = F2FS_SB(dentry->d_sb);
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 
 	switch (type) {
 	case F2FS_XATTR_INDEX_USER:
@@ -83,7 +84,7 @@ static int f2fs_xattr_generic_get(struct dentry *dentry, const char *name,
 	}
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return f2fs_getxattr(dentry->d_inode, type, name, buffer, size);
+	return f2fs_getxattr(inode, type, name, buffer, size);
 }
 
 static int f2fs_xattr_generic_set(struct dentry *dentry, const char *name,
@@ -127,11 +128,9 @@ static size_t f2fs_xattr_advise_list(struct dentry *dentry, char *list,
 	return size;
 }
 
-static int f2fs_xattr_advise_get(struct dentry *dentry, const char *name,
-		void *buffer, size_t size, int type)
+static int f2fs_xattr_advise_get(struct dentry *unused, struct inode *inode,
+		const char *name, void *buffer, size_t size, int type)
 {
-	struct inode *inode = dentry->d_inode;
-
 	if (strcmp(name, "") != 0)
 		return -EINVAL;
 
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 0b81f78..0c15e9f 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -583,10 +583,10 @@ out:
  *
  * Returns: actual size of data on success, -errno on error
  */
-static int gfs2_xattr_get(struct dentry *dentry, const char *name,
-		void *buffer, size_t size, int type)
+static int gfs2_xattr_get(struct dentry *unused, struct inode *inode,
+			  const char *name, void *buffer, size_t size, int type)
 {
-	struct gfs2_inode *ip = GFS2_I(dentry->d_inode);
+	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_ea_location el;
 	int error;
 
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index ff10f3d..1377437 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -803,8 +803,9 @@ end_removexattr:
 	return err;
 }
 
-static int hfsplus_osx_getxattr(struct dentry *dentry, const char *name,
-					void *buffer, size_t size, int type)
+static int hfsplus_osx_getxattr(struct dentry *unused, struct inode *inode,
+				const char *name, void *buffer, size_t size,
+				int type)
 {
 	if (!strcmp(name, ""))
 		return -EINVAL;
@@ -822,7 +823,7 @@ static int hfsplus_osx_getxattr(struct dentry *dentry, const char *name,
 	 * creates), so we pass the name through unmodified (after
 	 * ensuring it doesn't conflict with another namespace).
 	 */
-	return hfsplus_getxattr(dentry, name, buffer, size);
+	return hfsplus_getxattr(inode, name, buffer, size);
 }
 
 static int hfsplus_osx_setxattr(struct dentry *dentry, const char *name,
diff --git a/fs/hfsplus/xattr.h b/fs/hfsplus/xattr.h
index 288530c..ba9d80d7 100644
--- a/fs/hfsplus/xattr.h
+++ b/fs/hfsplus/xattr.h
@@ -30,12 +30,12 @@ static inline int hfsplus_setxattr(struct dentry *dentry, const char *name,
 ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
 			void *value, size_t size);
 
-static inline ssize_t hfsplus_getxattr(struct dentry *dentry,
-					const char *name,
-					void *value,
-					size_t size)
+static inline ssize_t hfsplus_getxattr(struct inode *inode,
+				       const char *name,
+				       void *value,
+				       size_t size)
 {
-	return __hfsplus_getxattr(dentry->d_inode, name, value, size);
+	return __hfsplus_getxattr(inode, name, value, size);
 }
 
 ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size);
diff --git a/fs/hfsplus/xattr_security.c b/fs/hfsplus/xattr_security.c
index 6ec5e10..77d7f29 100644
--- a/fs/hfsplus/xattr_security.c
+++ b/fs/hfsplus/xattr_security.c
@@ -13,8 +13,9 @@
 #include "xattr.h"
 #include "acl.h"
 
-static int hfsplus_security_getxattr(struct dentry *dentry, const char *name,
-					void *buffer, size_t size, int type)
+static int hfsplus_security_getxattr(struct dentry *unused, struct inode *inode,
+				     const char *name, void *buffer,
+				     size_t size, int type)
 {
 	char *xattr_name;
 	int res;
@@ -29,7 +30,7 @@ static int hfsplus_security_getxattr(struct dentry *dentry, const char *name,
 	strcpy(xattr_name, XATTR_SECURITY_PREFIX);
 	strcpy(xattr_name + XATTR_SECURITY_PREFIX_LEN, name);
 
-	res = hfsplus_getxattr(dentry, xattr_name, buffer, size);
+	res = hfsplus_getxattr(inode, xattr_name, buffer, size);
 	kfree(xattr_name);
 	return res;
 }
diff --git a/fs/hfsplus/xattr_trusted.c b/fs/hfsplus/xattr_trusted.c
index 3c5f27e..5c9e7a0 100644
--- a/fs/hfsplus/xattr_trusted.c
+++ b/fs/hfsplus/xattr_trusted.c
@@ -11,8 +11,9 @@
 #include "hfsplus_fs.h"
 #include "xattr.h"
 
-static int hfsplus_trusted_getxattr(struct dentry *dentry, const char *name,
-					void *buffer, size_t size, int type)
+static int hfsplus_trusted_getxattr(struct dentry *unused, struct inode *inode,
+				    const char *name, void *buffer, size_t size,
+				    int type)
 {
 	char *xattr_name;
 	int res;
@@ -27,7 +28,7 @@ static int hfsplus_trusted_getxattr(struct dentry *dentry, const char *name,
 	strcpy(xattr_name, XATTR_TRUSTED_PREFIX);
 	strcpy(xattr_name + XATTR_TRUSTED_PREFIX_LEN, name);
 
-	res = hfsplus_getxattr(dentry, xattr_name, buffer, size);
+	res = hfsplus_getxattr(inode, xattr_name, buffer, size);
 	kfree(xattr_name);
 	return res;
 }
diff --git a/fs/hfsplus/xattr_user.c b/fs/hfsplus/xattr_user.c
index 2b625a5..c7c424c 100644
--- a/fs/hfsplus/xattr_user.c
+++ b/fs/hfsplus/xattr_user.c
@@ -11,8 +11,9 @@
 #include "hfsplus_fs.h"
 #include "xattr.h"
 
-static int hfsplus_user_getxattr(struct dentry *dentry, const char *name,
-					void *buffer, size_t size, int type)
+static int hfsplus_user_getxattr(struct dentry *unused, struct inode *inode,
+				 const char *name, void *buffer, size_t size,
+				 int type)
 {
 	char *xattr_name;
 	int res;
@@ -27,7 +28,7 @@ static int hfsplus_user_getxattr(struct dentry *dentry, const char *name,
 	strcpy(xattr_name, XATTR_USER_PREFIX);
 	strcpy(xattr_name + XATTR_USER_PREFIX_LEN, name);
 
-	res = hfsplus_getxattr(dentry, xattr_name, buffer, size);
+	res = hfsplus_getxattr(inode, xattr_name, buffer, size);
 	kfree(xattr_name);
 	return res;
 }
diff --git a/fs/jffs2/security.c b/fs/jffs2/security.c
index aca97f3..77a9db6 100644
--- a/fs/jffs2/security.c
+++ b/fs/jffs2/security.c
@@ -48,13 +48,14 @@ int jffs2_init_security(struct inode *inode, struct inode *dir,
 }
 
 /* ---- XATTR Handler for "security.*" ----------------- */
-static int jffs2_security_getxattr(struct dentry *dentry, const char *name,
-				   void *buffer, size_t size, int type)
+static int jffs2_security_getxattr(struct dentry *unused, struct inode *inode,
+				   const char *name, void *buffer, size_t size,
+				   int type)
 {
 	if (!strcmp(name, ""))
 		return -EINVAL;
 
-	return do_jffs2_getxattr(dentry->d_inode, JFFS2_XPREFIX_SECURITY,
+	return do_jffs2_getxattr(inode, JFFS2_XPREFIX_SECURITY,
 				 name, buffer, size);
 }
 
diff --git a/fs/jffs2/xattr_trusted.c b/fs/jffs2/xattr_trusted.c
index 1c86819..7b2fe19 100644
--- a/fs/jffs2/xattr_trusted.c
+++ b/fs/jffs2/xattr_trusted.c
@@ -16,12 +16,13 @@
 #include <linux/mtd/mtd.h>
 #include "nodelist.h"
 
-static int jffs2_trusted_getxattr(struct dentry *dentry, const char *name,
-		void *buffer, size_t size, int type)
+static int jffs2_trusted_getxattr(struct dentry *unused, struct inode *inode,
+				  const char *name, void *buffer, size_t size,
+				  int type)
 {
 	if (!strcmp(name, ""))
 		return -EINVAL;
-	return do_jffs2_getxattr(dentry->d_inode, JFFS2_XPREFIX_TRUSTED,
+	return do_jffs2_getxattr(inode, JFFS2_XPREFIX_TRUSTED,
 				 name, buffer, size);
 }
 
diff --git a/fs/jffs2/xattr_user.c b/fs/jffs2/xattr_user.c
index 916b5c9..0d8b125 100644
--- a/fs/jffs2/xattr_user.c
+++ b/fs/jffs2/xattr_user.c
@@ -16,12 +16,13 @@
 #include <linux/mtd/mtd.h>
 #include "nodelist.h"
 
-static int jffs2_user_getxattr(struct dentry *dentry, const char *name,
-			       void *buffer, size_t size, int type)
+static int jffs2_user_getxattr(struct dentry *unused, struct inode *inode,
+			       const char *name, void *buffer, size_t size,
+			       int type)
 {
 	if (!strcmp(name, ""))
 		return -EINVAL;
-	return do_jffs2_getxattr(dentry->d_inode, JFFS2_XPREFIX_USER,
+	return do_jffs2_getxattr(inode, JFFS2_XPREFIX_USER,
 				 name, buffer, size);
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 321044c..3e0df4a1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6047,13 +6047,14 @@ static int nfs4_xattr_set_nfs4_acl(struct dentry *dentry, const char *key,
 	return nfs4_proc_set_acl(dentry->d_inode, buf, buflen);
 }
 
-static int nfs4_xattr_get_nfs4_acl(struct dentry *dentry, const char *key,
-				   void *buf, size_t buflen, int type)
+static int nfs4_xattr_get_nfs4_acl(struct dentry *unused, struct inode *inode,
+				   const char *key, void *buf, size_t buflen,
+				   int type)
 {
 	if (strcmp(key, "") != 0)
 		return -EINVAL;
 
-	return nfs4_proc_get_acl(dentry->d_inode, buf, buflen);
+	return nfs4_proc_get_acl(inode, buf, buflen);
 }
 
 static size_t nfs4_xattr_list_nfs4_acl(struct dentry *dentry, char *list,
@@ -6086,11 +6087,12 @@ static int nfs4_xattr_set_nfs4_label(struct dentry *dentry, const char *key,
 	return -EOPNOTSUPP;
 }
 
-static int nfs4_xattr_get_nfs4_label(struct dentry *dentry, const char *key,
-				   void *buf, size_t buflen, int type)
+static int nfs4_xattr_get_nfs4_label(struct dentry *unused, struct inode *inode,
+				     const char *key, void *buf, size_t buflen,
+				     int type)
 {
 	if (security_ismaclabel(key))
-		return nfs4_get_security_label(dentry->d_inode, buf, buflen);
+		return nfs4_get_security_label(inode, buf, buflen);
 	return -EOPNOTSUPP;
 }
 
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 068e8af..8f42eaa 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -7252,12 +7252,13 @@ static size_t ocfs2_xattr_security_list(struct dentry *dentry, char *list,
 	return total_len;
 }
 
-static int ocfs2_xattr_security_get(struct dentry *dentry, const char *name,
-				    void *buffer, size_t size, int type)
+static int ocfs2_xattr_security_get(struct dentry *unused, struct inode *inode,
+				    const char *name, void *buffer, size_t size,
+				    int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return ocfs2_xattr_get(dentry->d_inode, OCFS2_XATTR_INDEX_SECURITY,
+	return ocfs2_xattr_get(inode, OCFS2_XATTR_INDEX_SECURITY,
 			       name, buffer, size);
 }
 
@@ -7342,12 +7343,13 @@ static size_t ocfs2_xattr_trusted_list(struct dentry *dentry, char *list,
 	return total_len;
 }
 
-static int ocfs2_xattr_trusted_get(struct dentry *dentry, const char *name,
-		void *buffer, size_t size, int type)
+static int ocfs2_xattr_trusted_get(struct dentry *unused, struct inode *inode,
+				   const char *name, void *buffer, size_t size,
+				   int type)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return ocfs2_xattr_get(dentry->d_inode, OCFS2_XATTR_INDEX_TRUSTED,
+	return ocfs2_xattr_get(inode, OCFS2_XATTR_INDEX_TRUSTED,
 			       name, buffer, size);
 }
 
@@ -7390,16 +7392,17 @@ static size_t ocfs2_xattr_user_list(struct dentry *dentry, char *list,
 	return total_len;
 }
 
-static int ocfs2_xattr_user_get(struct dentry *dentry, const char *name,
-		void *buffer, size_t size, int type)
+static int ocfs2_xattr_user_get(struct dentry *unused, struct inode *inode,
+				const char *name, void *buffer, size_t size,
+				int type)
 {
-	struct ocfs2_super *osb = OCFS2_SB(dentry->d_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
 	if (osb->s_mount_opt & OCFS2_MOUNT_NOUSERXATTR)
 		return -EOPNOTSUPP;
-	return ocfs2_xattr_get(dentry->d_inode, OCFS2_XATTR_INDEX_USER, name,
+	return ocfs2_xattr_get(inode, OCFS2_XATTR_INDEX_USER, name,
 			       buffer, size);
 }
 
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 38c9193..a9d6c01 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -795,18 +795,18 @@ posix_acl_to_xattr(struct user_namespace *user_ns, const struct posix_acl *acl,
 EXPORT_SYMBOL (posix_acl_to_xattr);
 
 static int
-posix_acl_xattr_get(struct dentry *dentry, const char *name,
-		void *value, size_t size, int type)
+posix_acl_xattr_get(struct dentry *unused, struct inode *inode,
+		    const char *name, void *value, size_t size, int type)
 {
 	struct posix_acl *acl;
 	int error;
 
-	if (!IS_POSIXACL(dentry->d_inode))
+	if (!IS_POSIXACL(inode))
 		return -EOPNOTSUPP;
-	if (S_ISLNK(dentry->d_inode->i_mode))
+	if (S_ISLNK(inode->i_mode))
 		return -EOPNOTSUPP;
 
-	acl = get_acl(dentry->d_inode, type);
+	acl = get_acl(inode, type);
 	if (IS_ERR(acl))
 		return PTR_ERR(acl);
 	if (acl == NULL)
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 7c36898..9998770 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -777,7 +777,8 @@ reiserfs_getxattr(struct dentry * dentry, const char *name, void *buffer,
 	if (!handler || get_inode_sd_version(dentry->d_inode) == STAT_DATA_V1)
 		return -EOPNOTSUPP;
 
-	return handler->get(dentry, name, buffer, size, handler->flags);
+	return handler->get(dentry, dentry->d_inode, name, buffer, size,
+			    handler->flags);
 }
 
 /*
diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
index e7f8939..dad61a9 100644
--- a/fs/reiserfs/xattr_security.c
+++ b/fs/reiserfs/xattr_security.c
@@ -9,16 +9,16 @@
 #include <linux/uaccess.h>
 
 static int
-security_get(struct dentry *dentry, const char *name, void *buffer, size_t size,
-		int handler_flags)
+security_get(struct dentry *unused, struct inode *inode, const char *name,
+	     void *buffer, size_t size, int handler_flags)
 {
 	if (strlen(name) < sizeof(XATTR_SECURITY_PREFIX))
 		return -EINVAL;
 
-	if (IS_PRIVATE(dentry->d_inode))
+	if (IS_PRIVATE(inode))
 		return -EPERM;
 
-	return reiserfs_xattr_get(dentry->d_inode, name, buffer, size);
+	return reiserfs_xattr_get(inode, name, buffer, size);
 }
 
 static int
diff --git a/fs/reiserfs/xattr_trusted.c b/fs/reiserfs/xattr_trusted.c
index 5eeb0c4..9e3cf4a 100644
--- a/fs/reiserfs/xattr_trusted.c
+++ b/fs/reiserfs/xattr_trusted.c
@@ -8,16 +8,16 @@
 #include <linux/uaccess.h>
 
 static int
-trusted_get(struct dentry *dentry, const char *name, void *buffer, size_t size,
-	    int handler_flags)
+trusted_get(struct dentry *unused, struct inode *inode, const char *name,
+	    void *buffer, size_t size, int handler_flags)
 {
 	if (strlen(name) < sizeof(XATTR_TRUSTED_PREFIX))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN) || IS_PRIVATE(dentry->d_inode))
+	if (!capable(CAP_SYS_ADMIN) || IS_PRIVATE(inode))
 		return -EPERM;
 
-	return reiserfs_xattr_get(dentry->d_inode, name, buffer, size);
+	return reiserfs_xattr_get(inode, name, buffer, size);
 }
 
 static int
diff --git a/fs/reiserfs/xattr_user.c b/fs/reiserfs/xattr_user.c
index e50eab0..8c0d2ef 100644
--- a/fs/reiserfs/xattr_user.c
+++ b/fs/reiserfs/xattr_user.c
@@ -7,15 +7,15 @@
 #include <linux/uaccess.h>
 
 static int
-user_get(struct dentry *dentry, const char *name, void *buffer, size_t size,
-	 int handler_flags)
+user_get(struct dentry *unused, struct inode *inode, const char *name,
+	 void *buffer, size_t size, int handler_flags)
 {
 
 	if (strlen(name) < sizeof(XATTR_USER_PREFIX))
 		return -EINVAL;
-	if (!reiserfs_xattrs_user(dentry->d_sb))
+	if (!reiserfs_xattrs_user(inode->i_sb))
 		return -EOPNOTSUPP;
-	return reiserfs_xattr_get(dentry->d_inode, name, buffer, size);
+	return reiserfs_xattr_get(inode, name, buffer, size);
 }
 
 static int
diff --git a/fs/squashfs/xattr.c b/fs/squashfs/xattr.c
index 92fcde7..090963e 100644
--- a/fs/squashfs/xattr.c
+++ b/fs/squashfs/xattr.c
@@ -223,13 +223,15 @@ static size_t squashfs_user_list(struct dentry *d, char *list, size_t list_size,
 	return XATTR_USER_PREFIX_LEN;
 }
 
-static int squashfs_user_get(struct dentry *d, const char *name, void *buffer,
-	size_t size, int type)
+static int squashfs_user_get(struct dentry *unused,
+			     struct inode *inode,
+			     const char *name,
+			     void *buffer, size_t size, int type)
 {
 	if (name[0] == '\0')
 		return  -EINVAL;
 
-	return squashfs_xattr_get(d->d_inode, SQUASHFS_XATTR_USER, name,
+	return squashfs_xattr_get(inode, SQUASHFS_XATTR_USER, name,
 		buffer, size);
 }
 
@@ -253,13 +255,14 @@ static size_t squashfs_trusted_list(struct dentry *d, char *list,
 	return XATTR_TRUSTED_PREFIX_LEN;
 }
 
-static int squashfs_trusted_get(struct dentry *d, const char *name,
-	void *buffer, size_t size, int type)
+static int squashfs_trusted_get(struct dentry *d, struct inode *inode,
+				const char *name, void *buffer, size_t size,
+				int type)
 {
 	if (name[0] == '\0')
 		return  -EINVAL;
 
-	return squashfs_xattr_get(d->d_inode, SQUASHFS_XATTR_TRUSTED, name,
+	return squashfs_xattr_get(inode, SQUASHFS_XATTR_TRUSTED, name,
 		buffer, size);
 }
 
@@ -280,13 +283,14 @@ static size_t squashfs_security_list(struct dentry *d, char *list,
 	return XATTR_SECURITY_PREFIX_LEN;
 }
 
-static int squashfs_security_get(struct dentry *d, const char *name,
-	void *buffer, size_t size, int type)
+static int squashfs_security_get(struct dentry *d, struct inode *inode,
+				 const char *name, void *buffer, size_t size,
+				 int type)
 {
 	if (name[0] == '\0')
 		return  -EINVAL;
 
-	return squashfs_xattr_get(d->d_inode, SQUASHFS_XATTR_SECURITY, name,
+	return squashfs_xattr_get(inode, SQUASHFS_XATTR_SECURITY, name,
 		buffer, size);
 }
 
diff --git a/fs/xattr.c b/fs/xattr.c
index d536edb..70a5962 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -724,7 +724,8 @@ generic_getxattr(struct dentry *dentry, const char *name, void *buffer, size_t s
 	handler = xattr_resolve_name(dentry->d_sb->s_xattr, &name);
 	if (!handler)
 		return -EOPNOTSUPP;
-	return handler->get(dentry, name, buffer, size, handler->flags);
+	return handler->get(dentry, dentry->d_inode, name, buffer, size,
+			    handler->flags);
 }
 
 /*
diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index 93455b9..bd4a6ee 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -34,10 +34,10 @@
 
 
 static int
-xfs_xattr_get(struct dentry *dentry, const char *name,
+xfs_xattr_get(struct dentry *unused, struct inode *inode, const char *name,
 		void *value, size_t size, int xflags)
 {
-	struct xfs_inode *ip = XFS_I(dentry->d_inode);
+	struct xfs_inode *ip = XFS_I(inode);
 	int error, asize = size;
 
 	if (strcmp(name, "") == 0)
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 91b0a68..1088878 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -24,8 +24,8 @@ struct xattr_handler {
 	int flags;	/* fs private flags passed back to the handlers */
 	size_t (*list)(struct dentry *dentry, char *list, size_t list_size,
 		       const char *name, size_t name_len, int handler_flags);
-	int (*get)(struct dentry *dentry, const char *name, void *buffer,
-		   size_t size, int handler_flags);
+	int (*get)(struct dentry *dentry, struct inode *inode, const char *name,
+		   void *buffer, size_t size, int handler_flags);
 	int (*set)(struct dentry *dentry, const char *name, const void *buffer,
 		   size_t size, int flags, int handler_flags);
 };
-- 
1.7.4.1

