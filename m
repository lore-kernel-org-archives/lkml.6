Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2228598-1527604995-2-1053028872577110871
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527604994; b=j1IncUdoDCOoOA/8mP2X288DXl8TjyA5Sq9NeAYd0FjlM0+xuR
    to00JC7b36izGrsrMn99+ni4svc7UUYcjMni1KlJXfzXF0QZNGIMbVsTLCYT/UsG
    AyPB7Ne26nqMrD4EwDEDv0NJl4D+Qw+2OSjz91yvkf6mN2pN/oUi0CqVj476QhzF
    SqgqVUpA5GExlikBKkhSV7vkrGczx3PjvBpfyvqWYr0EChBkyWlK0rlNU9rEgQY3
    ylhzCagyM8snkz8Pyn7dSraltbASOgDiqBee3Mw5/K1lMgsFB465T31VA5m7oPZA
    1QOATYJ8+IT41gxUFmWwBUVGzciGOEtOmORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527604994; bh=
    53ZIQla1hR5Z7f9c+JKR/MxRo99GSX5FarhAiacxpCs=; b=ImfIRi55ViM7VXd4
    rM90K9innntfNaz4mt1V4JHrHF3TFjxvCva/eZPTtVgcwt2ekahkGiV2/JOdECcZ
    3bS9G1XZZ5phgXwWJ5RABo9PAdeiF7xwfSiGI56ZJYRHNUVgX4DMSpDeZue5b/ax
    JCoV0wrBcNlfnGgRRtiqilB+z/GisYhiBCm3YaF8B/BeWpBJIaVQXCjtJUb9keab
    +kJa7TeYhvKwD1U/hTR/pHJZ7LUEPt5weHUMacsiPb8Jg/2U1IaelK5r7WLU+4ae
    qTS7ow/rxLjWJ32v1oNSqxD9RtQBSKO8DJUwezxAViRr1hj0PbuXL3Kq4Y1tfwK5
    c02h8g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=EmySfAhe;
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
      header.i=@1e100.net header.b=EmySfAhe;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOxgo58B8msbdbhYaMRl93pJqdB7q9wjEPCZFDuuYr4N9aOQXuTqJ1KFkTKD+GYyhOsdVNFnWUFXyrkAn5hiRXP0PU+loAR9ixDwDnrrujDIhUI1DUsd
    4vGZZkchjMSLVTF1V46Ht5rUeM1hI7gRFomnCXy7ZdR8nrxwOfs4dzokj59QVQ6klm/OesqsSWAcGWmokBG0NW3YOgT2yV+3xI+2k8lHmpJjVjXAyyUVLFzs
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8
    a=20KFwNOVAAAA:8 a=3rmx1KfD8S3Ev5g28ZgA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935228AbeE2OmV (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:42:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41162 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935224AbeE2OmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:42:02 -0400
X-Google-Smtp-Source: AB8JxZopo48T/T5D7dK/IC1V9OQMCpi0TgyxtPZgpPT+tLzOyjQ7Bx+g2OhJ00McQnB/De966hX42w==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] ovl: use inode_insert5() to hash a newly created inode
Date: Tue, 29 May 2018 16:41:43 +0200
Message-Id: <20180529144143.16378-12-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144143.16378-1-mszeredi@redhat.com>
References: <20180529144143.16378-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Amir Goldstein <amir73il@gmail.com>

Currently, there is a small window where ovl_obtain_alias() can
race with ovl_instantiate() and create two different overlay inodes
with the same underlying real non-dir non-hardlink inode.

The race requires an adversary to guess the file handle of the
yet to be created upper inode and decode the guessed file handle
after ovl_creat_real(), but before ovl_instantiate().
This race does not affect overlay directory inodes, because those
are decoded via ovl_lookup_real() and not with ovl_obtain_alias().

This patch fixes the race, by using inode_insert5() to add a newly
created inode to cache.

If the newly created inode apears to already exist in cache (hashed
by the same real upper inode), we instantiate the dentry with the old
inode and drop the new inode, instead of silently not hashing the new
inode.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/dir.c       | 59 ++++++++++++++++++++++++++++++++++++++++--------
 fs/overlayfs/inode.c     | 12 ++++++++--
 fs/overlayfs/overlayfs.h |  1 +
 3 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index b33d37d1a87c..b2bc313241a6 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -228,24 +228,54 @@ static int ovl_set_opaque(struct dentry *dentry, struct dentry *upperdentry)
 	return ovl_set_opaque_xerr(dentry, upperdentry, -EIO);
 }
 
-/* Common operations required to be done after creation of file on upper */
-static void ovl_instantiate(struct dentry *dentry, struct inode *inode,
-			    struct dentry *newdentry, bool hardlink)
+/*
+ * Common operations required to be done after creation of file on upper.
+ * If @hardlink is false, then @inode is a pre-allocated inode, we may or
+ * may not use to instantiate the new dentry.
+ */
+static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
+			   struct dentry *newdentry, bool hardlink)
 {
+	struct ovl_inode_params oip = {
+		.upperdentry = newdentry,
+		.newinode = inode,
+	};
+
 	ovl_dentry_version_inc(dentry->d_parent, false);
 	ovl_dentry_set_upper_alias(dentry);
 	if (!hardlink) {
-		ovl_inode_update(inode, newdentry);
-		ovl_copyattr(newdentry->d_inode, inode);
+		/*
+		 * ovl_obtain_alias() can be called after ovl_create_real()
+		 * and before we get here, so we may get an inode from cache
+		 * with the same real upperdentry that is not the inode we
+		 * pre-allocated.  In this case we will use the cached inode
+		 * to instantiate the new dentry.
+		 *
+		 * XXX: if we ever use ovl_obtain_alias() to decode directory
+		 * file handles, need to use ovl_get_inode_locked() and
+		 * d_instantiate_new() here to prevent from creating two
+		 * hashed directory inode aliases.
+		 */
+		inode = ovl_get_inode(dentry->d_sb, &oip);
+		if (WARN_ON(IS_ERR(inode)))
+			return PTR_ERR(inode);
 	} else {
 		WARN_ON(ovl_inode_real(inode) != d_inode(newdentry));
 		dput(newdentry);
 		inc_nlink(inode);
 	}
+
 	d_instantiate(dentry, inode);
+	if (inode != oip.newinode) {
+		pr_warn_ratelimited("overlayfs: newly created inode found in cache (%pd2)\n",
+				    dentry);
+	}
+
 	/* Force lookup of new upper hardlink to find its lower */
 	if (hardlink)
 		d_drop(dentry);
+
+	return 0;
 }
 
 static bool ovl_type_merge(struct dentry *dentry)
@@ -284,11 +314,17 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 		ovl_set_opaque(dentry, newdentry);
 	}
 
-	ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink);
-	err = 0;
+	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink);
+	if (err)
+		goto out_cleanup;
 out_unlock:
 	inode_unlock(udir);
 	return err;
+
+out_cleanup:
+	ovl_cleanup(udir, newdentry);
+	dput(newdentry);
+	goto out_unlock;
 }
 
 static struct dentry *ovl_clear_empty(struct dentry *dentry,
@@ -473,8 +509,9 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup;
 	}
-	ovl_instantiate(dentry, inode, newdentry, hardlink);
-	err = 0;
+	err = ovl_instantiate(dentry, inode, newdentry, hardlink);
+	if (err)
+		goto out_cleanup;
 out_dput:
 	dput(upper);
 out_unlock:
@@ -557,6 +594,7 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 	if (err)
 		goto out;
 
+	/* Preallocate inode to be used by ovl_get_inode() */
 	err = -ENOMEM;
 	inode = ovl_new_inode(dentry->d_sb, mode, rdev);
 	if (!inode)
@@ -566,7 +604,8 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 	attr.mode = inode->i_mode;
 
 	err = ovl_create_or_link(dentry, inode, &attr, false);
-	if (err)
+	/* Did we end up using the preallocated inode? */
+	if (inode != d_inode(dentry))
 		iput(inode);
 
 out_drop_write:
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 2b9e8370500c..1db5b3b458a1 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -749,6 +749,15 @@ static bool ovl_hash_bylower(struct super_block *sb, struct dentry *upper,
 	return true;
 }
 
+static struct inode *ovl_iget5(struct super_block *sb, struct inode *newinode,
+			       struct inode *key)
+{
+	return newinode ? inode_insert5(newinode, (unsigned long) key,
+					 ovl_inode_test, ovl_inode_set, key) :
+			  iget5_locked(sb, (unsigned long) key,
+				       ovl_inode_test, ovl_inode_set, key);
+}
+
 struct inode *ovl_get_inode(struct super_block *sb,
 			    struct ovl_inode_params *oip)
 {
@@ -776,8 +785,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 						      upperdentry);
 		unsigned int nlink = is_dir ? 1 : realinode->i_nlink;
 
-		inode = iget5_locked(sb, (unsigned long) key, ovl_inode_test,
-				     ovl_inode_set, key);
+		inode = ovl_iget5(sb, oip->newinode, key);
 		if (!inode)
 			goto out_nomem;
 		if (!(inode->i_state & I_NEW)) {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index b8a0160742b2..3c5e9f18b0d9 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -329,6 +329,7 @@ int ovl_update_time(struct inode *inode, struct timespec *ts, int flags);
 bool ovl_is_private_xattr(const char *name);
 
 struct ovl_inode_params {
+	struct inode *newinode;
 	struct dentry *upperdentry;
 	struct ovl_path *lowerpath;
 	struct dentry *index;
-- 
2.14.3
