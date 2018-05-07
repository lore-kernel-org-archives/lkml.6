Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488117-1525682366-2-14563736649657098706
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525682366; b=LBWx+D2/pdJGRe36CpJp2xMhOyGh18tWpbDPkZZj0INs0Oofwp
    Aa5KZBLIClwP0hTdtPWWbCyADcNeRjBKx7HavUYxoRa2N8+6TtW1mOdoly33bDWt
    ijm7CNXJ2q2WXWePWhZtDm9dRohseVy8Sbrh6hHZ4C+Aem0iSCa2n5n2HUN+mC3A
    dGsNIGtH2rN4bm4OXrOqQYU4Dduxgzgck99pdk05ucHW+1wOsnBmsPUmSc6pljdH
    ER7XwbQ2z2f0mRJl93XIpgAoOf+9QhztZ/hL5HxoimEYXJ6u2lEJlLkREWrfSlse
    fxzuAky0Ssu9yFFgxXil6NvVtwSJB8AF+hxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525682366; bh=
    yKU4lfqn9wFsOSDbrge2pgxLuOH+3O0+7qQ9e41r/Ik=; b=AligHwlMnnFbnEjQ
    GXzOcWxtkVNBB+4We9UvnTPV55wOhSBnjnLb3AYKLu81noV23p0vsC/iQUnFI4NU
    TWHsuYGSF7sEVZH+3FL5WH1TCvgpG8LoycqKWenfWSnOCvExFLfBF6SlJAFnVG7S
    6ysgciOG6AeEh0iwTpakE6TInVNPpVIQXc1p2u31YGM25piUX1RPFnrWz0sjTXYx
    /T/T7iBl/ZS8eo98HoZIzae1AJKOmtD8Njy6sapCWSzgOPl/K5iaj5UJmVWceQIT
    FtO1eFmRl5JhEdOp4gqqNFwDASbEMu5JQCYZKc3YUDqHY4HITL/ZDVoCe+bwMRby
    m9s76A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=H34o8yB0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=H34o8yB0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHQ7ROQT5/6Hm8JTqbQBQfkSIOWawB0ffi5EUSTW6p1yppjLV5/vuL9T/EBXCxsbh4uS2GsGmlHq8ULz/kUlVslldiUbRl2ZB2DQqLv4eZI59ds6SQAp
    UcAPQFWbp0kjT5PWe+nFAqPxhiXnAxgUCQu4PsjoKBwrt7kioboNepZmDzSC40hDtzy4WT+5uPTYis3i6Rg13lUbhn+uizOqKfaVLCzZ9XLHFwxkp90mMrpX
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=zQMKuaQcLMqwseincdcA:9 a=jE_Ig3V6-SG8mqgm:21 a=mgHzOQ11Ht8y0Y57:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752329AbeEGIjS (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:39:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35334 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeEGIit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:49 -0400
X-Google-Smtp-Source: AB8JxZo+s0CBisNClht1LJvD94GsQ1tv2cY7j9arqeRAzu2TWTtjuwEKAutcWOiLcoqC2DZYMCPaMw==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 31/35] Revert "vfs: do get_write_access() on upper layer of overlayfs"
Date: Mon,  7 May 2018 10:38:03 +0200
Message-Id: <20180507083807.28792-32-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This reverts commit 4d0c5ba2ff79ef9f5188998b29fd28fcb05f3667.

We now get write access on both overlay and underlying layers so this patch
is no longer needed for correct operation.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/locks.c |  3 +--
 fs/open.c  | 15 ++-------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 62bbe8b31f26..9c0e5f3da66c 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1654,8 +1654,7 @@ check_conflicting_open(const struct dentry *dentry, const long arg, int flags)
 	if (flags & FL_LAYOUT)
 		return 0;
 
-	if ((arg == F_RDLCK) &&
-	    (atomic_read(&d_real_inode(dentry)->i_writecount) > 0))
+	if ((arg == F_RDLCK) && (atomic_read(&inode->i_writecount) > 0))
 		return -EAGAIN;
 
 	if ((arg == F_WRLCK) && ((d_count(dentry) > 1) ||
diff --git a/fs/open.c b/fs/open.c
index 127b49819afb..0d63b57c7f89 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -68,7 +68,6 @@ int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
 long vfs_truncate(const struct path *path, loff_t length)
 {
 	struct inode *inode;
-	struct dentry *upperdentry;
 	long error;
 
 	inode = path->dentry->d_inode;
@@ -91,17 +90,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 	if (IS_APPEND(inode))
 		goto mnt_drop_write_and_out;
 
-	/*
-	 * If this is an overlayfs then do as if opening the file so we get
-	 * write access on the upper inode, not on the overlay inode.  For
-	 * non-overlay filesystems d_real() is an identity function.
-	 */
-	upperdentry = d_real(path->dentry, NULL, O_WRONLY);
-	error = PTR_ERR(upperdentry);
-	if (IS_ERR(upperdentry))
-		goto mnt_drop_write_and_out;
-
-	error = get_write_access(upperdentry->d_inode);
+	error = get_write_access(inode);
 	if (error)
 		goto mnt_drop_write_and_out;
 
@@ -120,7 +109,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 		error = do_truncate(path->dentry, length, 0, NULL);
 
 put_write_and_out:
-	put_write_access(upperdentry->d_inode);
+	put_write_access(inode);
 mnt_drop_write_and_out:
 	mnt_drop_write(path->mnt);
 out:
-- 
2.14.3
