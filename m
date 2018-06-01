Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3474461-1527866804-2-12370875908020925156
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527866804; b=fzzQXnZ0cDs8fcDw0IZQa3z5hpDAhMApgfulGHqFSsC7yjQnaq
    p91ewgpmr5dT/nsJoAcvxFo/C6UUtPCIC92me/C66nmIXKEm4Qnd9FLPWSAj+1C1
    hREws/fII0HMXUmIjgp4Gu+biERamRgtek7iHMdHDc44ODWfBRhgV0s74OJKmYlo
    izzLP9Nbh0Jp/bpfNQpp6VYxCASmnRp0WF9SBinjoiF4imVPyQKnYK6cEVlXXeaW
    8mUGAzqzhFhMAB/U1MzhZ9a+oxssiz42HmNoBRUGES1e+PSIbhYHaQNP68pvX0DJ
    ClBoNej18KeEFqawyjxvjkuRhQvPdDf2+lMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527866804; bh=Qt0hNmjAsUlatBnP4nqMCHtP2qQB2M
    MysPBzwnlEakg=; b=Ot6/H7impTrXroHomTQ4750fqQmlFH1l8Gvlq0lOhVKyQ9
    oUEwpG/CebEFdTRMe8LECy3hhvJVM7ebUlvInm8pIgmwg2eHnhvFevJW52Te9RY0
    AENqliFLVfWmFJpFAwWbrQl2yWtFUYLAX4iylzg0zqYBe+Tb8omdeGTFrvZM9Nhf
    22FN4IpCzvV2YwS48R1sBuJ/5+RQT/FR1hE44oIlQCnUwZofj9Hw745yFwDAGgZU
    pAACZt8CPVnKcQ3OEeQswoDrrJeI9HI/q74IKJ01unjnvoNtIuijS83HO4P4+6/l
    dODVbMfMEj6h1/k/FGUJH0kU5jASvYbJ3Idiu8aA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
    header.d=szeredi.hu header.i=@szeredi.hu header.b=Jk0fauEj
    header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=TLI30o+T;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
      header.d=szeredi.hu header.i=@szeredi.hu header.b=Jk0fauEj
      header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=TLI30o+T;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfII9IzP8MTByBjCWUxR/RU/Z1bJzYlpKew6560E+ADxyHSnwvEjq9e+jOeOnRHXkxWM6jkNiTp/9+VevolEVDv51t6Jl2cZbypjke4y9xZ6BuRHHI6mr
    ryaIyiEtN4Wc9ji085kNBnfa2ZzMM1XMcML+alrjHJP1rmk8HFr9nsP4+Fbl4vg+1FBYmjxheqPpY9SFgSuDKQKAPDxpQ/3wRt/I/xxlw5V4KAtvrqxBRJuF
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=VcIgcaG0cDTAu_lxaYwA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeFAP0c (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 11:26:32 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43313 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752970AbeFAP0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:26:30 -0400
X-Google-Smtp-Source: ADUXVKKLYfbLtU/FTT6bdF5Zrd2uEvKaXHyB5xDRDLlgJBZpZRF6P28jOOjhpqL1kSc0C4TT5tjZ0w==
Date: Fri, 1 Jun 2018 17:26:25 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [GIT PULL] overlayfs update for 4.18
Message-ID: <20180601152625.GD23785@veci.piliscsaba.redhat.com>
References: <20180529132148.GC23785@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529132148.GC23785@veci.piliscsaba.redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 03:21:48PM +0200, Miklos Szeredi wrote:
> Hi Al,
> 
> I'm sending this pull request to you instead of Linus, because a bigger than
> usual chunk involves the VFS.
> 
> Please pull from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git for-viro
> 
> This update contains the following:
> 
>  - Deal with vfs_mkdir() not instantiating dentry.
> 
>  - Stack file operations.  This solves the ro/rw file descriptor inconsistency,
>    weirdness with ioctl, as well as removing a bunch of overlay specific hacks
>    from the VFS.
> 
>  - Allow metadata-only copy-up when data is unchanged.
> 
>  - Various cleanups in VFS and overlayfs.

Updated tree pushed to same place.

Incremental patch against previous pull and posted patchset.

Thanks,
Miklos
---

diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
index 0a8e3c4543d1..79be4a77ca08 100644
--- a/Documentation/filesystems/overlayfs.txt
+++ b/Documentation/filesystems/overlayfs.txt
@@ -280,7 +280,7 @@ parameter metacopy=on/off. Lastly, there is also a per mount option
 metacopy=on/off to enable/disable this feature per mount.
 
 Do not use metacopy=on with untrusted upper/lower directories. Otherwise
-it is possible that an attacker can create a handcrafted file with
+it is possible that an attacker can create an handcrafted file with
 appropriate REDIRECT and METACOPY xattrs, and gain access to file on lower
 pointed by REDIRECT. This should not be possible on local system as setting
 "trusted." xattrs will require CAP_SYS_ADMIN. But it should be possible
@@ -318,7 +318,7 @@ does not support NFS export, lower filesystem does not have a valid UUID or
 if the upper filesystem does not support extended attributes.
 
 For "metadata only copy up" feature there is no verification mechanism at
-mount time. So if same upper is mounted with different set of lower, mount
+mount time. So if same upper is mouted with different set of lower, mount
 probably will succeed but expect the unexpected later on. So don't do it.
 
 It is quite a common practice to copy overlay layers to a different
diff --git a/fs/overlayfs/Kconfig b/fs/overlayfs/Kconfig
index 08b04d9fd6e6..e0a090eca65e 100644
--- a/fs/overlayfs/Kconfig
+++ b/fs/overlayfs/Kconfig
@@ -11,7 +11,7 @@ config OVERLAY_FS
 	  For more information see Documentation/filesystems/overlayfs.txt
 
 config OVERLAY_FS_REDIRECT_DIR
-	bool "Overlayfs: turn on redirect directory feature by default"
+	bool "Overlayfs: turn on redirect dir feature by default"
 	depends on OVERLAY_FS
 	help
 	  If this config option is enabled then overlay filesystems will use
@@ -46,7 +46,7 @@ config OVERLAY_FS_INDEX
 	depends on OVERLAY_FS
 	help
 	  If this config option is enabled then overlay filesystems will use
-	  the index directory to map lower inodes to upper inodes by default.
+	  the inodes index dir to map lower inodes to upper inodes by default.
 	  In this case it is still possible to turn off index globally with the
 	  "index=off" module option or on a filesystem instance basis with the
 	  "index=off" mount option.
@@ -67,7 +67,7 @@ config OVERLAY_FS_NFS_EXPORT
 	depends on !OVERLAY_FS_METACOPY
 	help
 	  If this config option is enabled then overlay filesystems will use
-	  the index directory to decode overlay NFS file handles by default.
+	  the inodes index dir to decode overlay NFS file handles by default.
 	  In this case, it is still possible to turn off NFS export support
 	  globally with the "nfs_export=off" module option or on a filesystem
 	  instance basis with the "nfs_export=off" mount option.
@@ -133,7 +133,7 @@ config OVERLAY_FS_METACOPY
 	help
 	  If this config option is enabled then overlay filesystems will
 	  copy up only metadata where appropriate and data copy up will
-	  happen when a file is opened for WRITE operation. It is still
+	  happen when a file is opended for WRITE operation. It is still
 	  possible to turn off this feature globally with the "metacopy=off"
 	  module option or on a filesystem instance basis with the
 	  "metacopy=off" mount option.
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 296037afecdb..bdadedf73e51 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -27,7 +27,7 @@
 
 static int ovl_ccup_set(const char *buf, const struct kernel_param *param)
 {
-	pr_warn("overlayfs: \"check_copy_up\" module option is obsolete\n");
+	WARN(1, "overlayfs: \"check_copy_up\" module option is obsolete\n");
 	return 0;
 }
 
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ec350d4d921c..7063e0f588cc 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -116,35 +116,35 @@ int ovl_cleanup_and_whiteout(struct dentry *workdir, struct inode *dir,
 	goto out;
 }
 
-static int ovl_mkdir_real(struct inode *dir, struct dentry **newdentry,
-			  umode_t mode)
+static struct dentry *ovl_mkdir_real(struct inode *dir, struct dentry *dentry,
+				     umode_t mode)
 {
 	int err;
-	struct dentry *d, *dentry = *newdentry;
 
 	err = ovl_do_mkdir(dir, dentry, mode);
-	if (err)
-		return err;
-
-	if (likely(!d_unhashed(dentry)))
-		return 0;
+	if (err) {
+		dput(dentry);
+		return ERR_PTR(err);
+	}
 
 	/*
 	 * vfs_mkdir() may succeed and leave the dentry passed
 	 * to it unhashed and negative. If that happens, try to
 	 * lookup a new hashed and positive dentry.
 	 */
-	d = lookup_one_len(dentry->d_name.name, dentry->d_parent,
-			   dentry->d_name.len);
-	if (IS_ERR(d)) {
-		pr_warn("overlayfs: failed lookup after mkdir (%pd2, err=%i).\n",
-			dentry, err);
-		return PTR_ERR(d);
+	if (unlikely(d_unhashed(dentry))) {
+		struct dentry *d;
+
+		d = lookup_one_len(dentry->d_name.name, dentry->d_parent,
+				   dentry->d_name.len);
+		if (IS_ERR(d)) {
+			pr_warn("overlayfs: failed lookup after mkdir (%pd2, err=%i).\n",
+				dentry, err);
+		}
+		dput(dentry);
+		dentry = d;
 	}
-	dput(dentry);
-	*newdentry = d;
-
-	return 0;
+	return dentry;
 }
 
 struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
@@ -169,8 +169,7 @@ struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
 
 		case S_IFDIR:
 			/* mkdir is special... */
-			err =  ovl_mkdir_real(dir, &newdentry, attr->mode);
-			break;
+			return ovl_mkdir_real(dir, newdentry, attr->mode);
 
 		case S_IFCHR:
 		case S_IFBLK:
@@ -193,7 +192,7 @@ struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
 		 * Not quite sure if non-instantiated dentry is legal or not.
 		 * VFS doesn't seem to care so check and warn here.
 		 */
-		err = -EIO;
+		err = -ENOENT;
 	}
 out:
 	if (err) {
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index ca7c3461e424..31f32fc1004b 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -128,7 +128,7 @@ static int ovl_open(struct inode *inode, struct file *file)
 	/* No longer need these flags, so don't pass them on to underlying fs */
 	file->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
-	realfile = ovl_open_realfile(file, ovl_inode_realdata(inode));
+	realfile = ovl_open_realfile(file, ovl_inode_real(file_inode(file)));
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
