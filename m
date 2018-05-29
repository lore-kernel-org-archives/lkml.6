Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2273583-1527607125-2-18393321140915224213
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527607124; b=F9dFZGBrNBRwIP8AZIyaRs8X7witpLRDwUUWiOHEbXQ2l0LlgK
    gC7xzNW8I3Yf0/AMOzp39V4wXLOaktBOQS10c26t+AP3HpTVzZIpW7mLP8lNhp/u
    sNJcH/lQleQP84ymAph+afFsnY1mFVidxWJBE+vecwkXghfNBU0vjD4Mbh2cerIt
    OqaIbpB6y4N0+lC3g/JunMUZ1IjCyN6P2guuh+YmTKr0qXAsl0xTOdykjXQ2rzjI
    QQrXrF5V9z7Pt1zbBc+fu6ZoguDd+itVGlH88in24qYl8MHdpZ6Hbv9ag7q38BrI
    HbkuiOMrqwkKpFMKfmOGGIN0eVzQdlBOh6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527607124; bh=
    I1KUxerfk7z7CB0xUdfwPN9pjTAcuBdvN11a0kCDz+A=; b=FiyphQ+YFvrOv9i1
    Q/1gefDm7/UDNfXfmMQjuAGkjBG7s56ESC72TNGrz8w0mfuJi6QCkAi65+2rc3Rf
    JveR6j8xIm7Q9qExeoGK/1lGUbuAcQbVcdQJ9egc44KdirWTJYX9idiGvWoBxvjp
    G8LXcvYwS8RIPIGBToz7/x64Ku9HuQdXszTzCnX2+5bCBRkbkvJMRtsbU1BXGrVh
    0zabZKJO2im4ykn09BfHC0MX1isEX/J2LDOxa0F43cxASMtSXwHVTm5vWrvRmd20
    lFfTgO+Fb7FK1eJETzcF5E+SK2QmcrWNP5AmeRhic6LYwSM0rL2xGxJrmZGLGfgt
    Go0TPg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Ec9LSTgX;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Ec9LSTgX;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBfZ98XfUOouz6zQgFOUZBqwN+hQy/ESgeUfHv8qfGkBU5opEavfpZrps2KwBkntWMUiUFVIQkrgl2raZ03N2+qtogEpEUuoHPcOr5QvKUoG0Q8FBez7
    AJOgiXwBhS11sT1z8iePOI8VuwKqtrhHPNcVuWdE948aUJuiv02hOMenC3vmA5P59oZCA9GuKbSMfvAgAvuvKvAKcjPAScTg9CEasQE3wbPG5AtSduwpHRBA
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8
    a=drOt6m5kAAAA:8 a=20KFwNOVAAAA:8 a=EBYIsx4ljoaROXK9V2kA:9
    a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935207AbeE2PSG (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 11:18:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42698 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935056AbeE2Olz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:41:55 -0400
X-Google-Smtp-Source: AB8JxZpNB/FOdTmPz+HtVh35qak/Bip6v+Ed3aO0H7WHQDCcLbVGdEpfDtibvNXZ1+KP0plF4j3K7g==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] ovl: return dentry from ovl_create_real()
Date: Tue, 29 May 2018 16:41:37 +0200
Message-Id: <20180529144143.16378-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144143.16378-1-mszeredi@redhat.com>
References: <20180529144143.16378-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Amir Goldstein <amir73il@gmail.com>

Al Viro suggested to simplify callers of ovl_create_real() by
returning the created dentry (or ERR_PTR) from ovl_create_real().
This prep patch makes Al's patch change less callers.

Also used ovl_create_temp() in ovl_create_index() instead of calling
ovl_do_mkdir() directly, so now all callers of ovl_do_mkdir() are routed
through ovl_create_real(), which paves the way for Al's fix for non-hashed
result from vfs_mkdir().

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c   | 15 ++++--------
 fs/overlayfs/dir.c       | 62 +++++++++++++++++++++++-------------------------
 fs/overlayfs/overlayfs.h |  4 ++--
 fs/overlayfs/super.c     |  7 +++---
 4 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 5f4c78b1bbeb..d3e9c1eeb7a4 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -502,19 +502,12 @@ static int ovl_get_tmpfile(struct ovl_copy_up_ctx *c, struct dentry **tempp)
 
 	if (c->tmpfile) {
 		temp = ovl_do_tmpfile(c->workdir, c->stat.mode);
-		if (IS_ERR(temp))
-			goto temp_err;
 	} else {
-		temp = ovl_lookup_temp(c->workdir);
-		if (IS_ERR(temp))
-			goto temp_err;
-
-		err = ovl_create_real(d_inode(c->workdir), temp, &cattr);
-		if (err) {
-			dput(temp);
-			goto out;
-		}
+		temp = ovl_create_real(d_inode(c->workdir),
+				       ovl_lookup_temp(c->workdir), &cattr);
 	}
+	if (IS_ERR(temp))
+		goto temp_err;
 	err = 0;
 	*tempp = temp;
 out:
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0fb3ef85f298..425ddb098c4a 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -114,13 +114,17 @@ int ovl_cleanup_and_whiteout(struct dentry *workdir, struct inode *dir,
 	goto out;
 }
 
-int ovl_create_real(struct inode *dir, struct dentry *newdentry,
-		    struct ovl_cattr *attr)
+struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
+			       struct ovl_cattr *attr)
 {
 	int err;
 
+	if (IS_ERR(newdentry))
+		return newdentry;
+
+	err = -ESTALE;
 	if (newdentry->d_inode)
-		return -ESTALE;
+		goto out;
 
 	if (attr->hardlink) {
 		err = ovl_do_link(attr->hardlink, dir, newdentry);
@@ -157,7 +161,12 @@ int ovl_create_real(struct inode *dir, struct dentry *newdentry,
 		 */
 		err = -ENOENT;
 	}
-	return err;
+out:
+	if (err) {
+		dput(newdentry);
+		return ERR_PTR(err);
+	}
+	return newdentry;
 }
 
 static int ovl_set_opaque_xerr(struct dentry *dentry, struct dentry *upper,
@@ -224,14 +233,14 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 		attr->mode &= ~current_umask();
 
 	inode_lock_nested(udir, I_MUTEX_PARENT);
-	newdentry = lookup_one_len(dentry->d_name.name, upperdir,
-				   dentry->d_name.len);
+	newdentry = ovl_create_real(udir,
+				    lookup_one_len(dentry->d_name.name,
+						   upperdir,
+						   dentry->d_name.len),
+				    attr);
 	err = PTR_ERR(newdentry);
 	if (IS_ERR(newdentry))
 		goto out_unlock;
-	err = ovl_create_real(udir, newdentry, attr);
-	if (err)
-		goto out_dput;
 
 	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry)) {
 		/* Setting opaque here is just an optimization, allow to fail */
@@ -239,9 +248,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	}
 
 	ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink);
-	newdentry = NULL;
-out_dput:
-	dput(newdentry);
+	err = 0;
 out_unlock:
 	inode_unlock(udir);
 	return err;
@@ -280,15 +287,12 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	if (upper->d_parent->d_inode != udir)
 		goto out_unlock;
 
-	opaquedir = ovl_lookup_temp(workdir);
+	opaquedir = ovl_create_real(wdir, ovl_lookup_temp(workdir),
+				    OVL_CATTR(stat.mode));
 	err = PTR_ERR(opaquedir);
 	if (IS_ERR(opaquedir))
 		goto out_unlock;
 
-	err = ovl_create_real(wdir, opaquedir, OVL_CATTR(stat.mode));
-	if (err)
-		goto out_dput;
-
 	err = ovl_copy_xattr(upper, opaquedir);
 	if (err)
 		goto out_cleanup;
@@ -318,7 +322,6 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 
 out_cleanup:
 	ovl_cleanup(wdir, opaquedir);
-out_dput:
 	dput(opaquedir);
 out_unlock:
 	unlock_rename(workdir, upperdir);
@@ -379,20 +382,16 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	if (err)
 		goto out;
 
-	newdentry = ovl_lookup_temp(workdir);
-	err = PTR_ERR(newdentry);
-	if (IS_ERR(newdentry))
-		goto out_unlock;
-
 	upper = lookup_one_len(dentry->d_name.name, upperdir,
 			       dentry->d_name.len);
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
-		goto out_dput;
+		goto out_unlock;
 
-	err = ovl_create_real(wdir, newdentry, cattr);
-	if (err)
-		goto out_dput2;
+	newdentry = ovl_create_real(wdir, ovl_lookup_temp(workdir), cattr);
+	err = PTR_ERR(newdentry);
+	if (IS_ERR(newdentry))
+		goto out_dput;
 
 	/*
 	 * mode could have been mutilated due to umask (e.g. sgid directory)
@@ -439,11 +438,9 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 			goto out_cleanup;
 	}
 	ovl_instantiate(dentry, inode, newdentry, hardlink);
-	newdentry = NULL;
-out_dput2:
-	dput(upper);
+	err = 0;
 out_dput:
-	dput(newdentry);
+	dput(upper);
 out_unlock:
 	unlock_rename(workdir, upperdir);
 out:
@@ -455,7 +452,8 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 
 out_cleanup:
 	ovl_cleanup(wdir, newdentry);
-	goto out_dput2;
+	dput(newdentry);
+	goto out_dput;
 }
 
 static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index aa8286419133..6bbde513e068 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -358,8 +358,8 @@ struct ovl_cattr {
 
 #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode = (m) })
 
-int ovl_create_real(struct inode *dir, struct dentry *newdentry,
-		    struct ovl_cattr *attr);
+struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
+			       struct ovl_cattr *attr);
 int ovl_cleanup(struct inode *dir, struct dentry *dentry);
 
 /* copy_up.c */
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 286d36772e9c..704b37311467 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -611,9 +611,10 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 			goto retry;
 		}
 
-		err = ovl_create_real(dir, work, OVL_CATTR(attr.ia_mode));
-		if (err)
-			goto out_dput;
+		work = ovl_create_real(dir, work, OVL_CATTR(attr.ia_mode));
+		err = PTR_ERR(work);
+		if (IS_ERR(work))
+			goto out_err;
 
 		/*
 		 * Try to remove POSIX ACL xattrs from workdir.  We are good if:
-- 
2.14.3
