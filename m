Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2910789-1525994091-2-11595468854125770671
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525994091; b=iIuBcSwWkqzdY8kP114PIlXTiYQHFJvWaD/DvMCFu3l+k67XqU
    m6xmtfwXcsd0wtJhBoCvKiM/3j6gItrfkWRMCwuwY4D5cU7LCqy4RPMMEVouYCls
    Js64bW1CvFcIdoF0eJx4b+Jd6z4WYnA/hKk6iGUiG4SuAPpk0SPnKC7736X7JpPy
    aSaIsOhHzwkS9ij1Lonqn3qPKWnqJ6Gzg4Z0PvvAIN5khcYziCnd1GIkmkkxRBzV
    BiK2H0aKdQrKsGwGJNwh2uJXvnTcS3FwsDwXVPbQCS8XZQoUkjToaWotKENDxu8/
    umfk6UMijWUsRXS89uX/oIJ0uQIDHNTWoE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525994091; bh=
    Qv43QBWYjPF6QR01lgQ02HZiysSDrsIyr4QfMZBh8jA=; b=R4mdgiGN+6c2rhK+
    HZpJOaEuyxV+ZDYVi04AaDL+yGKaa7aZUMcBuECpw8R411b9j41pEI6eug7HCuZt
    aLZxYEhSjQ1UASLQZ/gOMkvyLrKJuGDVHBWGTNQpNaVF/ipaE8J/QIYBlOYQhYw8
    QqA5lbrWv2CjWOMPPteOOoygKivao7UOZOHf5o+YH+PVVmA/auzUAgKi+hgsjVXy
    P1jxDd7ITpfbLaJPUiadxrODyaNTb6/HSJ6A/8tBJJuJb82t7z1928rgSIV00Rd9
    M2x7jkfl0orN9x7goMWtGleZ82wXgxRntAKIL1Xkx3Q/wge2rD1LbBEVcEZ++D51
    AC2VlQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=2csDFq8r x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=2csDFq8r x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJayUFgePmwg/8w/vQ4OAAu4VDqYlkO70QM5jsWXGSYjb83C8iKMrh2jGTbeJI2M4KTKKEiHYyIKRDvlIu+os1QGesoF5wj/opC0dnvaDzXrV9EDtZ0n
    YnrQzqewTQfFcHU4gwz+MzmFtNijVt8YYrP42dVtECZMercpcEnL/8Kt56FfYH+MQwjP6haQmvdnuB3/d/Jj0EdMCxzv8xfjTeT+/bk5pwzQTfLxqIWmBVhX
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=xNf9USuDAAAA:8
    a=VwQbUJbxAAAA:8 a=-M3FdVsweQnkJg63cyUA:9 a=x8gzFH9gYPwA:10
    a=SEwjQc04WA-l_NiBhQ7s:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeEJXOI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 19:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750798AbeEJXOG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 10 May 2018 19:14:06 -0400
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: viro@zeniv.linux.org.uk, darrick.wong@oracle.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, clm@fb.com, jbacik@fb.com,
        dsterba@suse.com
Cc: sandeen@sandeen.net, dhowells@redhat.com, fliu@suse.com,
        jack@suse.cz, jeffm@suse.com, nborisov@suse.com,
        jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v2 1/4] vfs: skip extra attributes check on removal for symlinks
Date: Thu, 10 May 2018 16:13:56 -0700
Message-Id: <20180510231359.16899-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510231359.16899-1-mcgrof@kernel.org>
References: <20180510231359.16899-1-mcgrof@kernel.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Linux filesystems cannot set extra file attributes (stx_attributes as per
statx(2)) on a symbolic link. To set extra file attributes you issue
ioctl(2) with FS_IOC_SETFLAGS, *all* ioctl(2) calls on a symbolic link
yield EBADF.

This is because ioctl(2) tries to obtain struct fd from the symbolic link
file descriptor passed using fdget(), fdget() in turn always returns no
file set when a file descriptor is open with O_PATH. As per symlink(2)
O_PATH and O_NOFOLLOW must *always* be used when you want to get the file
descriptor of a symbolic link, and this holds true for Linux, as such extra
file attributes cannot possibly be set on symbolic links on Linux.

Filesystems repair utilities should be updated to detect this as
corruption and correct this, however, the VFS *does* respect these
extra attributes on symlinks for removal.

Since we cannot set these attributes we should special-case the
immutable/append on delete for symlinks, this would be consistent with
what we *do* allow on Linux for all filesystems. Since this is a clear
sign to the VFS the filesystem must be corrupted filesystems can
implement a verifier to catch this earlier. A generic warning issued for
filesystems which don't implement these verifiers, and the VFS also lets
users delete these pesky symlinks as otherwise users cannot get rid of
them.

The userspace utility chattr(1) cannot set these attributes on symlinks
*and* other special files as well:

	# chattr -a symlink
	chattr: Operation not supported while reading flags on b

The reason for this is different though. Refer to commit 023d111e92195
("chattr.1.in: Document the compression attribute flags E, X, and ...")
merged on e2fsprogs v1.28 since August 2002. This commit prevented
issuing the ioctl() for symlink *and* special files in consideration for
a buggy DRM driver where issuing lsattr on their special files crashed
the system. For details refer to Debian bug 152029 [0].

You can craft your own tool to query the extra file attributes with
the new shiny statx(2) tool, statx(2) will list the attributes if
they were set for instance on a corrupt filesystem. However statx(2)
is only used for *querying* -- not for setting the attributes.

If you implement issuing your own ioctl() for FS_IOC_FSGETXATTR or
FS_IOC_FSSETXATTR on special files (block, char, fifo) it will fail
returning -1 and errno is set to ENOTTY (Inappropriate ioctl for
device). The reason for this is different than for symlinks.
For special files this fails on vfs_ioctl() when the filesystem
f_op callbacks are not set for these special files:

long vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
{
	int error = -ENOTTY;

        if (!filp->f_op->unlocked_ioctl)
		goto out;

	error = filp->f_op->unlocked_ioctl(filp, cmd, arg);
	if (error == -ENOIOCTLCMD)
		error = -ENOTTY;
out:
	return error;
}

The same applies to PF_LOCAL named sockets. Since this varies by
filesystem for special files, only make a special rule to respect
the immutable and append attribute on symlinks.

[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=152029

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 fs/namei.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e861b409c241..23ebc14805dc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2760,6 +2760,26 @@ int __check_sticky(struct inode *dir, struct inode *inode)
 }
 EXPORT_SYMBOL(__check_sticky);
 
+/* Process extra file attributes only when they make sense */
+static bool may_delete_stx_attributes(struct inode *inode)
+{
+	/*
+	 * The VFS does not allow setting append/immutable on symlinks.
+	 *
+	 * Filesystems can implement their own verifier which would avoid this
+	 * generic splat, this generic splat is desirable if the respective
+	 * filesystem repair utility won't implement a fix for this, otherwise
+	 * users end up with a nagging dangling file which is impossible to
+	 * fix in userspace.
+	 */
+	if (S_ISLNK(inode->i_mode)) {
+		WARN_ONCE((IS_APPEND(inode) || IS_IMMUTABLE(inode)),
+		 "Immutable or append flag set on symlink. VFS does not allow this, must be a filesystem corruption. Allowing deletion though");
+	} else if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
+		return  false;
+	return  true;
+}
+
 /*
  *	Check whether we can remove a link victim from directory dir, check
  *  whether the type of victim is right.
@@ -2798,8 +2818,8 @@ static int may_delete(struct inode *dir, struct dentry *victim, bool isdir)
 	if (IS_APPEND(dir))
 		return -EPERM;
 
-	if (check_sticky(dir, inode) || IS_APPEND(inode) ||
-	    IS_IMMUTABLE(inode) || IS_SWAPFILE(inode) || HAS_UNMAPPED_ID(inode))
+	if (check_sticky(dir, inode) || !may_delete_stx_attributes(inode) ||
+	    IS_SWAPFILE(inode) || HAS_UNMAPPED_ID(inode))
 		return -EPERM;
 	if (isdir) {
 		if (!d_is_dir(victim))
-- 
2.17.0

