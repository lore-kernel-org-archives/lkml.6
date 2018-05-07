Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-474343-1525682318-2-1249575904024665802
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525682318; b=M201mibkzYPCQNsFNjNA0LgIbMrS5gJllRDh9oZN2lheZYp/L0
    Z+4PxdqUxd7U/nCCwWpUwwdiXEk/fmZW+rw9I75svTc3ip+VmxgvaAsllDwNRbtP
    +zLJSfVPNn6+wJtdvdKwHcaHFxn75HauogheM96Ofez3m0aWxI5BdRUkEHzZfOY8
    hSwnFhAgh6QDepRICUE7NSgP34yrChhk7hdF0H4VUzbUy2n0pTnztA/cTTQ/uMfX
    6D8oZTK3wOvyaH7Ys2ZcCZ7gQaqsfqZ71SHpU/B04BIFesILwQmRWASiIuMzFxTJ
    n/JAtc1IQP2Qq0WrEEvHdJisWKS4UQGuTYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525682318; bh=
    akjp4HmhVaO9blh1QR/ndToq9TEu0xVehImZbvHkhc0=; b=OFoEL450lvMgI0S1
    mUeWC7Om0r/tjU5AZFFBR8sPJR7kCS/lm/wQTD9hGbORnGmWEnlFZPGJ6waR89qD
    fYYYwWG1HSGt/1Jb6bZ2IuT589pNFm5mUcU4MgnRg+E3/6FWmz7vH6YexlP9qo0g
    oCDcjfDEXULgunuGo5HxbI7HthoIXCxdca6CUNwdI8AE7LIIvWA2u2oZXrGr9ozW
    VMNJcI75g5XUC7Mb1idTh30x6G3iKNKGQZft6fGCUF3dxBPB6PpgtOZvUV9nGO0e
    Va9/hjskiCeTgkK5x/iWRgyFlORgSUM0SGYwEXjNH4hl6PV88+lP8DKRd09+JmYV
    5rMSjA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=KX/pw2I7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=KX/pw2I7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPibq0odR9mRUkLTrHQnPCl7fOh1rLvE4Whscbx0rrhnHXhDlix3g5iWrNBK13MBDuqLkG7Xpoa6h146pfbwd144ybYY7aO904kBChmKf22MlRCdxKCl
    2qbppuhLSOWNztA0gYMgO4Bki2Sq2O/i+QDYb5glHP615sDk1XIh7mSiUnCV+gltc/SkmwqWwceQN3ptBPF5zcHPzXPM9brzlSYSgU4RXAcFEXJfD3nVfy1+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=FScwnjTil3FeJceEasMA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeEGIig (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:38:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36902 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbeEGIiY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:24 -0400
X-Google-Smtp-Source: AB8JxZo+r7FOjTG7WHZ9/D9v4S5To5LLMx3hEnHDJBFbgSraGbQoBE2qJ3EUAm/kDYFwbCtu8FvKBQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/35] ovl: copy up file size as well
Date: Mon,  7 May 2018 10:37:41 +0200
Message-Id: <20180507083807.28792-10-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Copy i_size of the underlying inode to the overlay inode in ovl_copyattr().

This is in preparation for stacking I/O operations on overlay files.

This patch shouldn't have any observable effect.

Remove stale comment from ovl_setattr() [spotted by Vivek Goyal].

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/inode.c     | 9 ---------
 fs/overlayfs/overlayfs.h | 2 ++
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index f7b1910bb9d4..ba3f832cc39a 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -22,15 +22,6 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 	struct dentry *upperdentry;
 	const struct cred *old_cred;
 
-	/*
-	 * Check for permissions before trying to copy-up.  This is redundant
-	 * since it will be rechecked later by ->setattr() on upper dentry.  But
-	 * without this, copy-up can be triggered by just about anybody.
-	 *
-	 * We don't initialize inode->size, which just means that
-	 * inode_newsize_ok() will always check against MAX_LFS_FILESIZE and not
-	 * check for a swapfile (which this won't be anyway).
-	 */
 	err = setattr_prepare(dentry, attr);
 	if (err)
 		return err;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 4e26778774c3..b9f7c632ab9c 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/uuid.h>
+#include <linux/fs.h>
 #include "ovl_entry.h"
 
 enum ovl_path_type {
@@ -348,6 +349,7 @@ static inline void ovl_copyattr(struct inode *from, struct inode *to)
 	to->i_atime = from->i_atime;
 	to->i_mtime = from->i_mtime;
 	to->i_ctime = from->i_ctime;
+	i_size_write(to, i_size_read(from));
 }
 
 static inline void ovl_copyflags(struct inode *from, struct inode *to)
-- 
2.14.3
