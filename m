Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2228598-1527605236-2-9438928457714536710
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527605236; b=AGt0nisATtWT4v+6ZoVu55Rn04mBUAWw2pZvZpiHe9bc0lQEMe
    brZ/eQPeUP3YkCpex3ChuTYKJoUU+4UM6PCmjHvkbIyKY0vEIRsmUfeJ8qAq6h2g
    13Ge3JO7T1BOe/30tgcbbeozM+WDJ8oZDULeEjaJQEwe/czuNBvSo9nMkCDA6Wuk
    0i0iR9NvL7kVqdLwJHGTdKiV/T+yEzxECq2jt1GIHgz62m5NdfFKXeM1x/217tGY
    M5kWejP+6I+aDIXvcjHasFZNGauo+DxFcybeQKpMKcFWgex6SzoGqCbdU9QIlbSY
    mscHi1BrI/Ru0OxjoYJcn0rdPArF7gOhYRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527605236; bh=
    nGRz8vYCLTy70vxps3g840DCu6g3pyPa/5D51Ssm/fE=; b=NesiJFyOUUo/i3/1
    B7urqrhenLrUrcHQuA6Wf3+hCh7HE1H1P5nnP42+rSBSwqZVCnZbsMzAYGb1oW7/
    KoVH9CKmuawEIl6B90swNlCxTYClxnwq9p3vb9Y4tmZp0IcixQrCrMg/VEaNlPq1
    lNelSCOLZGRLQOiRyoJG4SozCjTwC4zOS8KK7kgzXmD5du2PVaQKaMBAMn7diFOC
    BWyytlEyZfDWwkGYPmRYaAxCrtOQSyMXuDkyp2ERzTrBJKPgMbf6VclMOTFvpSlG
    +RUkGBhTyiEzGendWBtBqTyl3ij/CF0htn7s2OdFR4DbGe9Q4TeFP+ChCC49Syed
    OeMZ6A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=WxKO1ztQ;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=WxKO1ztQ;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHTSILyq+V0jIfofRHv6TqeK1z4NomK87WRxmmeBmERp6rKZC8bVPR+6MSdUzEIheKhy4uM3fD63Uwu1xbPkrnSxFb/RhGoVheQkobwsV/7QOWvaOw7p
    ku3+4J437rvRT45pKYsGDdJbBti8dktIX77JA7UpdrHpS45/YyQ1rdI5x6HI+QQLfnOeqvZdougFuEy1V0DwPNwFy5P2r7kWtPS0qHGxrbn/yLkCZh+nh2KE
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=pGLkceISAAAA:8 a=tT_kTcrF_ZXhjj2JNUIA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936669AbeE2OrK (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:47:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35738 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936673AbeE2Oqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:46:45 -0400
X-Google-Smtp-Source: ADUXVKJWghAgXCFWqSSPeTPHFaYhlC6zOFxmj9T0yd1WC46rkyZyowB7Qwkh1QpwBmi6W2Cn4qbDKA==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/28] ovl: Check redirect on index as well
Date: Tue, 29 May 2018 16:46:08 +0200
Message-Id: <20180529144612.16675-25-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144612.16675-1-mszeredi@redhat.com>
References: <20180529144612.16675-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vivek Goyal <vgoyal@redhat.com>

Right now we seem to check redirect only if upperdentry is found.  But it
is possible that there is no upperdentry but later we found an index.

We need to check redirect on index as well and set it in
ovl_inode->redirect.  Otherwise link code can assume that dentry does not
have redirect and place a new one which breaks things.  In my testing
overlay/033 test started failing in xfstests.  Following are the details.

For example do following.

$ mkdir lower upper work merged

 - Make lower dir with 4 links.
  $ echo "foo" > lower/l0.txt
  $ ln  lower/l0.txt lower/l1.txt
  $ ln  lower/l0.txt lower/l2.txt
  $ ln  lower/l0.txt lower/l3.txt

 - Mount with index on and metacopy on.

  $ mount -t overlay -o lowerdir=lower,upperdir=upper,workdir=work,\
                        index=on,metacopy=on none merged

 - Link lower

  $ ln merged/l0.txt merged/l4.txt
    (This will metadata copy up of l0.txt and put an absolute redirect
     /l0.txt)

  $ echo 2 > /proc/sys/vm/drop/caches

  $ ls merged/l1.txt
  (Now l1.txt will be looked up.  There is no upper dentry but there is
   lower dentry and index will be found.  We don't check for redirect on
   index, hence ovl_inode->redirect will be NULL.)

 - Link Upper

  $ ln merged/l4.txt merged/l5.txt
  (Lookup of l4.txt will use inode from l1.txt lookup which is still in
   cache.  It has ovl_inode->redirect NULL, hence link will put a new
   redirect and replace /l0.txt with /l4.txt

 - Drop caches.
  echo 2 > /proc/sys/vm/drop_caches

 - List l1.txt and it returns -ESTALE

  $ ls merged/l0.txt

  (It returns stale because, we found a metacopy of l0.txt in upper and it
   has redirect l4.txt but there is no file named l4.txt in lower layer.
   So lower data copy is not found and -ESTALE is returned.)

So problem here is that we did not process redirect on index.  Check
redirect on index as well and then problem is fixed.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/namei.c     | 50 +++++++++++++-----------------------------------
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/util.c      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 37 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index e38fa61e08df..2acd494ea9f0 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -31,32 +31,13 @@ static int ovl_check_redirect(struct dentry *dentry, struct ovl_lookup_data *d,
 			      size_t prelen, const char *post)
 {
 	int res;
-	char *s, *next, *buf = NULL;
+	char *buf;
 
-	res = vfs_getxattr(dentry, OVL_XATTR_REDIRECT, NULL, 0);
-	if (res < 0) {
-		if (res == -ENODATA || res == -EOPNOTSUPP)
-			return 0;
-		goto fail;
-	}
-	buf = kzalloc(prelen + res + strlen(post) + 1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	buf = ovl_get_redirect_xattr(dentry, prelen + strlen(post));
+	if (IS_ERR_OR_NULL(buf))
+		return PTR_ERR(buf);
 
-	if (res == 0)
-		goto invalid;
-
-	res = vfs_getxattr(dentry, OVL_XATTR_REDIRECT, buf, res);
-	if (res < 0)
-		goto fail;
-	if (res == 0)
-		goto invalid;
 	if (buf[0] == '/') {
-		for (s = buf; *s++ == '/'; s = next) {
-			next = strchrnul(s, '/');
-			if (s == next)
-				goto invalid;
-		}
 		/*
 		 * One of the ancestor path elements in an absolute path
 		 * lookup in ovl_lookup_layer() could have been opaque and
@@ -67,9 +48,7 @@ static int ovl_check_redirect(struct dentry *dentry, struct ovl_lookup_data *d,
 		 */
 		d->stop = false;
 	} else {
-		if (strchr(buf, '/') != NULL)
-			goto invalid;
-
+		res = strlen(buf) + 1;
 		memmove(buf + prelen, buf, res);
 		memcpy(buf, d->name.name, prelen);
 	}
@@ -81,16 +60,6 @@ static int ovl_check_redirect(struct dentry *dentry, struct ovl_lookup_data *d,
 	d->name.len = strlen(d->redirect);
 
 	return 0;
-
-err_free:
-	kfree(buf);
-	return 0;
-fail:
-	pr_warn_ratelimited("overlayfs: failed to get redirect (%i)\n", res);
-	goto err_free;
-invalid:
-	pr_warn_ratelimited("overlayfs: invalid redirect (%s)\n", buf);
-	goto err_free;
 }
 
 static int ovl_acceptable(void *ctx, struct dentry *dentry)
@@ -1071,8 +1040,15 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 
 	if (upperdentry)
 		ovl_dentry_set_upper_alias(dentry);
-	else if (index)
+	else if (index) {
 		upperdentry = dget(index);
+		upperredirect = ovl_get_redirect_xattr(upperdentry, 0);
+		if (IS_ERR(upperredirect)) {
+			err = PTR_ERR(upperredirect);
+			upperredirect = NULL;
+			goto out_free_oe;
+		}
+	}
 
 	if (upperdentry || ctr) {
 		struct ovl_inode_params oip = {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index bde352e414e7..24f1d0e8a178 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -276,6 +276,7 @@ void ovl_nlink_end(struct dentry *dentry, bool locked);
 int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir);
 int ovl_check_metacopy_xattr(struct dentry *dentry);
 bool ovl_is_metacopy_dentry(struct dentry *dentry);
+char *ovl_get_redirect_xattr(struct dentry *dentry, int padding);
 
 static inline bool ovl_is_impuredir(struct dentry *dentry)
 {
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 1aa9e0c5a327..8cfb62cc8672 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -865,3 +865,53 @@ bool ovl_is_metacopy_dentry(struct dentry *dentry)
 
 	return (oe->numlower > 1);
 }
+
+char *ovl_get_redirect_xattr(struct dentry *dentry, int padding)
+{
+	int res;
+	char *s, *next, *buf = NULL;
+
+	res = vfs_getxattr(dentry, OVL_XATTR_REDIRECT, NULL, 0);
+	if (res < 0) {
+		if (res == -ENODATA || res == -EOPNOTSUPP)
+			return NULL;
+		goto fail;
+	}
+
+	buf = kzalloc(res + padding + 1, GFP_KERNEL);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	if (res == 0)
+		goto invalid;
+
+	res = vfs_getxattr(dentry, OVL_XATTR_REDIRECT, buf, res);
+	if (res < 0)
+		goto fail;
+	if (res == 0)
+		goto invalid;
+
+	if (buf[0] == '/') {
+		for (s = buf; *s++ == '/'; s = next) {
+			next = strchrnul(s, '/');
+			if (s == next)
+				goto invalid;
+		}
+	} else {
+		if (strchr(buf, '/') != NULL)
+			goto invalid;
+	}
+
+	return buf;
+
+err_free:
+	kfree(buf);
+	return ERR_PTR(res);
+fail:
+	pr_warn_ratelimited("overlayfs: failed to get redirect (%i)\n", res);
+	goto err_free;
+invalid:
+	pr_warn_ratelimited("overlayfs: invalid redirect (%s)\n", buf);
+	res = -EINVAL;
+	goto err_free;
+}
-- 
2.14.3
