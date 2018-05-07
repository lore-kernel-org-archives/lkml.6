Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488117-1525682373-2-18143473334838885371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525682373; b=Mjpsoqs8viX9EFzClwZBGj1ePCkcnxsNVk+6dTJzg1m6LjyTQG
    glsRptbZ0FT9vheYYmqd7xTGS1wkB3MfdpkWXSe3tHvNslNeWmjoybAYpX6k8wmn
    Zjq4SZT/7TWjOYz46SXIB6myPUVlK/OMroPkD7A4K5ysw0g2YPbhwzUGE8IRERE8
    BSrbLNGzyt0X2ht4OIpRfR6Mv8kltVn06RaFlywZr/IQyDP+WAlXPBi/SssvZO0C
    Jy4YdNoJKhgthOxF9Vb5uGZgTby5f92OEINyAET4AMxsO982H7LgqK8hRmwobGT+
    MELtlaDigKVfiA5Ba1r4mpeHx0iEqcrTgb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525682373; bh=
    He7/cXJzAEWO0mDS1kknE8KCxFxCrMw+aRlepPL2vDA=; b=Rj4qkfPA3X4kSJUG
    qDsg5zWE0kvn6/JZB3pxO/XkcK4UXnpHCuhzRvSP3OuEg8jaSjju2ekPVjUBPnKc
    5eaqw3a/sIQP6IQBxANnKVT42eif8i7udqA+BDSkAtKD8F4fSnbQWXRIgIq2eknl
    wlH9adgy0cPscpQcJ+qoPg5A2HQH6XDDUvjLHoJSVjdR+pFU7P2jov8j2KuJTchD
    DuJ2K5K7usrq1v+pHQMe/wFfQ8tBNyDFTGzpHeCjoKQFYvCELHsQm1c8KTorcbzV
    R2I8Sr5nqL6KRSSNxpPSfPIrUOixtyu72718Y+6A04bIpvarLNeeZj7N5bUmQpAD
    G0Ut3g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=SYFG5msH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
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
      header.i=@1e100.net header.b=SYFG5msH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFAd/NNnbm1aCtEMA0KG2wh5pGXuKwpdxXUj3Bipl+NO4ITYSXsqSmryTkHqhic0DCb8wpnhsBns2+wj7SL+hva0c303FHGoJ2uQi2Z4jBiBD6heJrbN
    SJuzbp1tJajrfg2C8dOaLw9+yvX5gYkiO6Z59GfXmK7i9prRMxIJiR/p5PDrFLfJ+mLWhK2/1lhKgv77/QmrodlgoeMLHxHNcgTJu2LYy3lAtbIxqSVhX3Vh
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=n1Xvik20PHS8cDOiRF4A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeEGIjZ (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:39:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39083 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbeEGIip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:45 -0400
X-Google-Smtp-Source: AB8JxZqB+EnDI7wXPeDSnXx9IyXNiXPbSWZhsu0G7Sb7lNcu5RPEU9OTw0Encwgy3/YnJ63opK0ACw==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 28/35] Revert "ovl: fix relatime for directories"
Date: Mon,  7 May 2018 10:38:00 +0200
Message-Id: <20180507083807.28792-29-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This reverts commit cd91304e7190b4c4802f8e413ab2214b233e0260.

Overlayfs no longer relies on the vfs correct atime handling.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/inode.c             | 21 ++++-----------------
 fs/overlayfs/super.c   |  3 ---
 include/linux/dcache.h |  3 ---
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 13ceb98c3bd3..e97d0193221d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1573,24 +1573,11 @@ EXPORT_SYMBOL(bmap);
 static void update_ovl_inode_times(struct dentry *dentry, struct inode *inode,
 			       bool rcu)
 {
-	struct dentry *upperdentry;
+	if (!rcu) {
+		struct inode *realinode = d_real_inode(dentry);
 
-	/*
-	 * Nothing to do if in rcu or if non-overlayfs
-	 */
-	if (rcu || likely(!(dentry->d_flags & DCACHE_OP_REAL)))
-		return;
-
-	upperdentry = d_real(dentry, NULL, 0, D_REAL_UPPER);
-
-	/*
-	 * If file is on lower then we can't update atime, so no worries about
-	 * stale mtime/ctime.
-	 */
-	if (upperdentry) {
-		struct inode *realinode = d_inode(upperdentry);
-
-		if ((!timespec_equal(&inode->i_mtime, &realinode->i_mtime) ||
+		if (unlikely(inode != realinode) &&
+		    (!timespec_equal(&inode->i_mtime, &realinode->i_mtime) ||
 		     !timespec_equal(&inode->i_ctime, &realinode->i_ctime))) {
 			inode->i_mtime = realinode->i_mtime;
 			inode->i_ctime = realinode->i_ctime;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index c3d8c7ea180f..006dc70d7425 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -107,9 +107,6 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
 	if (inode && d_inode(dentry) == inode)
 		return dentry;
 
-	if (flags & D_REAL_UPPER)
-		return ovl_dentry_upper(dentry);
-
 	if (!d_is_reg(dentry)) {
 		if (!inode || inode == d_inode(dentry))
 			return dentry;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 94acbde17bb1..b2b829bcb7c0 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -563,9 +563,6 @@ static inline struct dentry *d_backing_dentry(struct dentry *upper)
 	return upper;
 }
 
-/* d_real() flags */
-#define D_REAL_UPPER	0x2	/* return upper dentry or NULL if non-upper */
-
 /**
  * d_real - Return the real dentry
  * @dentry: the dentry to query
-- 
2.14.3
