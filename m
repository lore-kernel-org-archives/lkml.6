Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220212-1527604998-2-8229296911549361310
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527604997; b=VkUbeW3kuEneyHTIP1y6c2y17jsH9GtHsfkfVny2GZpfhH9wbB
    4yNu6oh28uLtClLUrjHlgE8NSP7Bnkq/+DddwUdhuHqR8fWv0ylvZWBdZYYIL7es
    ytXsojZN7WwGPWuZjaHfFsDG4YyJ7O5Hvtj0DDIJKYftml8W7U0XzPxOf5WmWF1D
    xDP86xINzqx74d1imjumvQvh08b/tkJ8WcAzNDkEgmdHfl3FLxUGFKqdLjkJf9nu
    2Wn57FWty2vUlSjVD3wJ4k5Fj1X6RblDWmTJkDxAkajLCiFz3Rs+M9Smq1ziqMrp
    EBoGEHgT38iUA5M6+DX7f4uevxJTFsxPqpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527604997; bh=
    bCuWMipXeZgs5EkGuZd9Du1ScYpc7/0QnEbFyewqj9c=; b=Ed+UAsFWvkjcLOaY
    KiCb9bLYb0uHjh0MxqBmP8yW0psCzj2PPYc+eJs7NghHjewFFqrCHeuwGtOOE/N9
    rou1Wi+oPp7uzpmbXkwDF2qX/0Qw7BWKRybL94I+02oGbguJkPsfvlyU3m4QTHXJ
    19KUvB4acopJYkIFCm/+/QaeLTriXpIdvkBetfQ2sxeI2sCfEatIh9yOBG9RJhYt
    l63df9BLxFFPgKSD/vEo5T8II832LbJuHZeX4RsVizIrY/xmPbddeM8qKBNGskg6
    U8nL3aicIkRAdUQZLpGAglFwAWCdzE9m5L6MeW/E/EcEsAxSDr3dUoT5d3Sl4IOl
    xJXWPg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=JlKyG43z;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=JlKyG43z;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLl16Nl8+Yk8Lha0Euyw4f0z748wPqfId0u4j41+robUxezDNh+NDpZe8CIing4EXlof3L7/JcnKEIdJmV04cJXx0bc4FVqwfcHqYwfTtvEpZk22PZ5B
    MkTzh5zK/+CtUMZNum5FEWCOvD+TeUv5sJFS5onszNFkhVqjKt+Ym0pPcGXkieFfKh2RVMrl4naGpVKmn8rmvgba0q9fHPDp0qtsVtByLIb1BMxGT1tbZrJk
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8
    a=20KFwNOVAAAA:8 a=30nu9Qzmxvu8vXWHDqQA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935460AbeE2OnK (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:43:10 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37036 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935075AbeE2Ol4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:41:56 -0400
X-Google-Smtp-Source: ADUXVKKAsIKCCeNNHbxnXPgbkIQTQemFpvJYU7ERhz96hRv2+LwQHFdQTe1zJaLQuJrQDHUk5wY7Jw==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] ovl: create helper ovl_create_temp()
Date: Tue, 29 May 2018 16:41:38 +0200
Message-Id: <20180529144143.16378-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144143.16378-1-mszeredi@redhat.com>
References: <20180529144143.16378-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Amir Goldstein <amir73il@gmail.com>

Also used ovl_create_temp() in ovl_create_index() instead of calling
ovl_do_mkdir() directly, so now all callers of ovl_do_mkdir() are routed
through ovl_create_real(), which paves the way for Al's fix for non-hashed
result from vfs_mkdir().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c   | 14 ++++----------
 fs/overlayfs/dir.c       | 13 +++++++++----
 fs/overlayfs/overlayfs.h |  2 +-
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index d3e9c1eeb7a4..1b442c14c531 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -365,14 +365,10 @@ static int ovl_create_index(struct dentry *dentry, struct dentry *origin,
 	if (err)
 		return err;
 
-	temp = ovl_lookup_temp(indexdir);
+	temp = ovl_create_temp(indexdir, OVL_CATTR(S_IFDIR | 0));
 	if (IS_ERR(temp))
 		goto temp_err;
 
-	err = ovl_do_mkdir(dir, temp, S_IFDIR);
-	if (err)
-		goto out;
-
 	err = ovl_set_upper_fh(upper, temp);
 	if (err)
 		goto out_cleanup;
@@ -500,12 +496,10 @@ static int ovl_get_tmpfile(struct ovl_copy_up_ctx *c, struct dentry **tempp)
 	if (new_creds)
 		old_creds = override_creds(new_creds);
 
-	if (c->tmpfile) {
+	if (c->tmpfile)
 		temp = ovl_do_tmpfile(c->workdir, c->stat.mode);
-	} else {
-		temp = ovl_create_real(d_inode(c->workdir),
-				       ovl_lookup_temp(c->workdir), &cattr);
-	}
+	else
+		temp = ovl_create_temp(c->workdir, &cattr);
 	if (IS_ERR(temp))
 		goto temp_err;
 	err = 0;
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 425ddb098c4a..1b181292a624 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -43,7 +43,7 @@ int ovl_cleanup(struct inode *wdir, struct dentry *wdentry)
 	return err;
 }
 
-struct dentry *ovl_lookup_temp(struct dentry *workdir)
+static struct dentry *ovl_lookup_temp(struct dentry *workdir)
 {
 	struct dentry *temp;
 	char name[20];
@@ -169,6 +169,12 @@ struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
 	return newdentry;
 }
 
+struct dentry *ovl_create_temp(struct dentry *workdir, struct ovl_cattr *attr)
+{
+	return ovl_create_real(d_inode(workdir), ovl_lookup_temp(workdir),
+			       attr);
+}
+
 static int ovl_set_opaque_xerr(struct dentry *dentry, struct dentry *upper,
 			       int xerr)
 {
@@ -287,8 +293,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	if (upper->d_parent->d_inode != udir)
 		goto out_unlock;
 
-	opaquedir = ovl_create_real(wdir, ovl_lookup_temp(workdir),
-				    OVL_CATTR(stat.mode));
+	opaquedir = ovl_create_temp(workdir, OVL_CATTR(stat.mode));
 	err = PTR_ERR(opaquedir);
 	if (IS_ERR(opaquedir))
 		goto out_unlock;
@@ -388,7 +393,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(upper))
 		goto out_unlock;
 
-	newdentry = ovl_create_real(wdir, ovl_lookup_temp(workdir), cattr);
+	newdentry = ovl_create_temp(workdir, cattr);
 	err = PTR_ERR(newdentry);
 	if (IS_ERR(newdentry))
 		goto out_dput;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6bbde513e068..3f13d0965e03 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -346,7 +346,6 @@ static inline void ovl_copyattr(struct inode *from, struct inode *to)
 
 /* dir.c */
 extern const struct inode_operations ovl_dir_inode_operations;
-struct dentry *ovl_lookup_temp(struct dentry *workdir);
 int ovl_cleanup_and_whiteout(struct dentry *workdir, struct inode *dir,
 			     struct dentry *dentry);
 struct ovl_cattr {
@@ -361,6 +360,7 @@ struct ovl_cattr {
 struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
 			       struct ovl_cattr *attr);
 int ovl_cleanup(struct inode *dir, struct dentry *dentry);
+struct dentry *ovl_create_temp(struct dentry *workdir, struct ovl_cattr *attr);
 
 /* copy_up.c */
 int ovl_copy_up(struct dentry *dentry);
-- 
2.14.3
