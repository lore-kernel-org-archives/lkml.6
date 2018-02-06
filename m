Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2459548-1517961275-2-4839611933882175787
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES rosk.us-asciien, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517961275; b=mM28SkmP3BSycp0SW4/URn6JhJp1uT7tOCnsrBiLKHyGioo
    pxyaoOGNvtAB5uLoznpP/qBj5POnv7Wbp2KmZPVy7d2cq0ahy1CsaLbGROQJYPsA
    4TxAjGNM6Rk1Y9t9gbOLHx2ucHOGTHeAjeW8tpr3EtuyJtL9qS/V4LYwWaU4P1Rj
    iTPIKZ5K7iKLrtrw6k1Gw93XZTKXAKF4XOG8cC2FUlJLq98zJfGM5jOYJcNxgxRj
    prS6i0X6ic7uhYvobkhnSNG9z8f2zCZir6jTtAF0mRDdkzVG5Xkv6/wwuAo1Vheu
    R1CHw5OvdR9TggpLMeSrmxHnsNfP/JU4aqFqd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517961275; bh=729lUuyFgk51mhgNKycHQylmyQ
    Gq74T667TSmIy6xUE=; b=q33RizJ78Cp2CaJcGkFPYdu9O27n7cJygv4Bs05+mJ
    WGG4cGbNXk+PLSHVhWAXW7mYhYE5ZQkv6bnxOo+4GFxlgZQs8XUUaQL8+eXvfNmY
    W6E6oB2RKiMSbFmOHKKpTJYH7KfdCxVTXLNq72KR8wCb1r//AZSZkSIvkUpRRj6H
    5fJO1JkF1yDWVjcXwKXSJYHLXgRM7nHYyhhinzeDmiRU9bUU1xGF8Tlv4pt3UCtE
    RaAlB6IzkOemyJ8FIwCUQQINP0DNqChjq9bkQqfm8/W14b6U99AQ3NvnDRBp8gIz
    tJpvnLcui4gcUpuZTggtGFAWfKS/tsCKTq+MrOPRVN+g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=d1Mv1Avy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EZefjOWi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=d1Mv1Avy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EZefjOWi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754224AbeBFXyc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 18:54:32 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33667 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754220AbeBFXya (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 18:54:30 -0500
X-Google-Smtp-Source: AH8x227c4B6/9yeeDPgyIcMpJjlXSzpdOPafE6BL3b2vyL2cKc6UVfljBDMsWvSWBVGqPbHh4wZ3YA==
From: Jin Qian <jinqian@android.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Changman Lee <cm224.lee@samsung.com>,
        Chao Yu <chao2.yu@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Cc: Jin Qian <jinqian@google.com>,
        linux-stable <stable@vger.kernel.org>,
        Jin Qian <jinqian@android.com>
Subject: [PATCHv2 1/1] ext4/f2fs: don't put symlink in pagecache into highmem
Date: Tue,  6 Feb 2018 15:53:53 -0800
Message-Id: <20180206235354.79591-1-jinqian@android.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jin Qian <jinqian@google.com>

partial backport from 21fc61c73c3903c4c312d0802da01ec2b323d174 upstream
to v4.4 to prevent virt_to_page on highmem.

ext4_encrypted_follow_link uses kmap() for cpage
  caddr = kmap(cpage);

_ext4_fname_disk_to_usr calls virt_to_page on the kmapped address.
  _ext4_fname_disk_to_usr()
    ext4_fname_decrypt()
      sg_init_one()
        sg_init_one(&src_sg, iname->name, iname->len);
          sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));

Cc: linux-stable <stable@vger.kernel.org> # 4.4.y
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jin Qian <jinqian@google.com>
Signed-off-by: Jin Qian <jinqian@android.com>
---
 fs/ext4/inode.c    |  1 +
 fs/ext4/namei.c    |  1 +
 fs/ext4/symlink.c  | 10 +++-------
 fs/f2fs/inode.c    |  1 +
 fs/f2fs/namei.c    |  5 ++---
 fs/inode.c         |  6 ++++++
 include/linux/fs.h |  1 +
 7 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4df1cb19a243..f0cabc8c96cb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4417,6 +4417,7 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 			inode->i_op = &ext4_symlink_inode_operations;
 			ext4_set_aops(inode);
 		}
+		inode_nohighmem(inode);
 	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 	      S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		inode->i_op = &ext4_special_inode_operations;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 4c36dca486cc..32960b3ecd4f 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3151,6 +3151,7 @@ static int ext4_symlink(struct inode *dir,
 	if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
 		if (!encryption_required)
 			inode->i_op = &ext4_symlink_inode_operations;
+		inode_nohighmem(inode);
 		ext4_set_aops(inode);
 		/*
 		 * We cannot call page_symlink() with transaction started
diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index e8e7af62ac95..287c3980fa0b 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -45,7 +45,7 @@ static const char *ext4_encrypted_follow_link(struct dentry *dentry, void **cook
 		cpage = read_mapping_page(inode->i_mapping, 0, NULL);
 		if (IS_ERR(cpage))
 			return ERR_CAST(cpage);
-		caddr = kmap(cpage);
+		caddr = page_address(cpage);
 		caddr[size] = 0;
 	}
 
@@ -75,16 +75,12 @@ static const char *ext4_encrypted_follow_link(struct dentry *dentry, void **cook
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
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 97e20decacb4..5528801a5baf 100644
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
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 2c32110f9fc0..484df6850747 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -351,6 +351,7 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 		inode->i_op = &f2fs_encrypted_symlink_inode_operations;
 	else
 		inode->i_op = &f2fs_symlink_inode_operations;
+	inode_nohighmem(inode);
 	inode->i_mapping->a_ops = &f2fs_dblock_aops;
 
 	f2fs_lock_op(sbi);
@@ -942,7 +943,7 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void **cook
 	cpage = read_mapping_page(inode->i_mapping, 0, NULL);
 	if (IS_ERR(cpage))
 		return ERR_CAST(cpage);
-	caddr = kmap(cpage);
+	caddr = page_address(cpage);
 	caddr[size] = 0;
 
 	/* Symlink is encrypted */
@@ -982,13 +983,11 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void **cook
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
diff --git a/fs/inode.c b/fs/inode.c
index b0edef500590..b95615f3fc50 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2028,3 +2028,9 @@ void inode_set_flags(struct inode *inode, unsigned int flags,
 				  new_flags) != old_flags));
 }
 EXPORT_SYMBOL(inode_set_flags);
+
+void inode_nohighmem(struct inode *inode)
+{
+	mapping_set_gfp_mask(inode->i_mapping, GFP_USER);
+}
+EXPORT_SYMBOL(inode_nohighmem);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c8decb7075d6..f746a59fcc88 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3066,5 +3066,6 @@ static inline bool dir_relax(struct inode *inode)
 }
 
 extern bool path_noexec(const struct path *path);
+extern void inode_nohighmem(struct inode *inode);
 
 #endif /* _LINUX_FS_H */
-- 
2.16.0.rc1.238.g530d649a79-goog
