Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720527-2-14951814437197161052
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720527; b=McbAJtAJ4PJBqpqX7+tcvusu5xhVViiEUHQN4He+J8FEEFR
    +De0MfVTdMIozYe/ukqqepq3boXs3s4NkKScS98a9h/WSmKF1QM+znTYnr3WatdB
    dT0UHmzT1DCae1bw02rK3/Gj9r7Ozk3lwb5G6duS6b/aSt32Fq5wTs4LGqrO5ANT
    UkkQ67N6GVFnLWViB6c4d1VBFniHnnBovg58inYogEj3Uq5LGwXC39M7SKJFcG28
    vhmDm2JLduZwyVeWYe//+E5gERu9/QOcHh/6upW4fMVCzayXE8YQw/9Z4Hw+vKSS
    k1+4zSvZTz6ydTS7+7ek94+B+RHVo2CgVzWv9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720527; bh=ELhARkDq4UBFES4DrMm4zT6mXR
    xlZpk6R5g2eqsRlmk=; b=nPqPLxJVrAWPKBoD5QEq7PaMD4r6DBRd5y+fCvEFGf
    X+Khx3SKcNg4BJ9vwZRRviANQmWX9JWRFgIm9IOEf2Xdz7fChqNxptuE+Hj4LB1J
    tZT88CJ2RMwg5Pu7BJzOFIyRuPmxXKzfMWeQXNCdiuICaZrPRUPyMBLOdEdqozt2
    LmS+UFPyaCFwQHtbvg2RRVGsWgnYcIZMybqgkqLOpK7Kk2Q5d0wb1xIlAA96Hrwo
    +z3td4sWDV29TdBQk54wae1p5pYIrggHTWw7fMddpW29WoHmfch4fDOzLwVmaOfK
    nbwOzJWUS+9UM7/jOVVY3/tM0f5SqP6G9iRtKCIoJf5A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162138AbeBOPWD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:22:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162248AbeBOPV7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:59 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jin Qian <jinqian@google.com>, Jin Qian <jinqian@android.com>
Subject: [PATCH 4.4 035/108] dont put symlink bodies in pagecache into highmem
Date: Thu, 15 Feb 2018 16:16:32 +0100
Message-Id: <20180215151227.323543261@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 21fc61c73c3903c4c312d0802da01ec2b323d174 upstream.

kmap() in page_follow_link_light() needed to go - allowing to hold
an arbitrary number of kmaps for long is a great way to deadlocking
the system.

new helper (inode_nohighmem(inode)) needs to be used for pagecache
symlinks inodes; done for all in-tree cases.  page_follow_link_light()
instrumented to yell about anything missed.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jin Qian <jinqian@google.com>
Signed-off-by: Jin Qian <jinqian@android.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c    |    1 +
 fs/ext4/namei.c    |    1 +
 fs/ext4/symlink.c  |   10 +++-------
 fs/f2fs/inode.c    |    1 +
 fs/f2fs/namei.c    |    5 ++---
 fs/inode.c         |    6 ++++++
 include/linux/fs.h |    1 +
 7 files changed, 15 insertions(+), 10 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4417,6 +4417,7 @@ struct inode *ext4_iget(struct super_blo
 			inode->i_op = &ext4_symlink_inode_operations;
 			ext4_set_aops(inode);
 		}
+		inode_nohighmem(inode);
 	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 	      S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		inode->i_op = &ext4_special_inode_operations;
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3151,6 +3151,7 @@ static int ext4_symlink(struct inode *di
 	if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
 		if (!encryption_required)
 			inode->i_op = &ext4_symlink_inode_operations;
+		inode_nohighmem(inode);
 		ext4_set_aops(inode);
 		/*
 		 * We cannot call page_symlink() with transaction started
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -45,7 +45,7 @@ static const char *ext4_encrypted_follow
 		cpage = read_mapping_page(inode->i_mapping, 0, NULL);
 		if (IS_ERR(cpage))
 			return ERR_CAST(cpage);
-		caddr = kmap(cpage);
+		caddr = page_address(cpage);
 		caddr[size] = 0;
 	}
 
@@ -75,16 +75,12 @@ static const char *ext4_encrypted_follow
 	/* Null-terminate the name */
 	if (res <= plen)
 		paddr[res] = '\0';
-	if (cpage) {
-		kunmap(cpage);
+	if (cpage)
 		page_cache_release(cpage);
-	}
 	return *cookie = paddr;
 errout:
-	if (cpage) {
-		kunmap(cpage);
+	if (cpage)
 		page_cache_release(cpage);
-	}
 	kfree(paddr);
 	return ERR_PTR(res);
 }
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -202,6 +202,7 @@ make_now:
 			inode->i_op = &f2fs_encrypted_symlink_inode_operations;
 		else
 			inode->i_op = &f2fs_symlink_inode_operations;
+		inode_nohighmem(inode);
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
 	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -351,6 +351,7 @@ static int f2fs_symlink(struct inode *di
 		inode->i_op = &f2fs_encrypted_symlink_inode_operations;
 	else
 		inode->i_op = &f2fs_symlink_inode_operations;
+	inode_nohighmem(inode);
 	inode->i_mapping->a_ops = &f2fs_dblock_aops;
 
 	f2fs_lock_op(sbi);
@@ -942,7 +943,7 @@ static const char *f2fs_encrypted_follow
 	cpage = read_mapping_page(inode->i_mapping, 0, NULL);
 	if (IS_ERR(cpage))
 		return ERR_CAST(cpage);
-	caddr = kmap(cpage);
+	caddr = page_address(cpage);
 	caddr[size] = 0;
 
 	/* Symlink is encrypted */
@@ -982,13 +983,11 @@ static const char *f2fs_encrypted_follow
 	/* Null-terminate the name */
 	paddr[res] = '\0';
 
-	kunmap(cpage);
 	page_cache_release(cpage);
 	return *cookie = paddr;
 errout:
 	kfree(cstr.name);
 	f2fs_fname_crypto_free_buffer(&pstr);
-	kunmap(cpage);
 	page_cache_release(cpage);
 	return ERR_PTR(res);
 }
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2028,3 +2028,9 @@ void inode_set_flags(struct inode *inode
 				  new_flags) != old_flags));
 }
 EXPORT_SYMBOL(inode_set_flags);
+
+void inode_nohighmem(struct inode *inode)
+{
+	mapping_set_gfp_mask(inode->i_mapping, GFP_USER);
+}
+EXPORT_SYMBOL(inode_nohighmem);
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3066,5 +3066,6 @@ static inline bool dir_relax(struct inod
 }
 
 extern bool path_noexec(const struct path *path);
+extern void inode_nohighmem(struct inode *inode);
 
 #endif /* _LINUX_FS_H */
