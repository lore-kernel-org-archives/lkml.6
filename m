Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3281902-1517860761-2-4279620293106332891
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517860760; b=AnaPSNrZ/OqseGuAqT0V7dg3VcnrJ7dBlfOKwfv36RR8tqD
    3F+r6RG4biK3Ff1GuxyoBfu/xd9l4U1S23Rq+UqgxpYaaQqYbfyio84DNYchfc32
    5ie8+qTeZbPh6RhqQqKTfucglGnniPQ/o3XN6RlvKK8xcEwgV1aiH+vIwcU/AuDe
    +Wn3A0gv5MmlmbA58IHa4D/gf527dcdDvFG6GCvGGtpiYmGlfiGHIbenzHsJWvnt
    C9haDFGDvH39e8v4zE2uao3hkyYNfqEjsOfFO5x01lyqh+S6lmyT84WCt8NYrEMs
    /lRk6dgX72BhOX8QArgb3HlJjXu9rf/spzoB4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517860760; bh=YRgAiT7aegv1Z/bUA5t8JIYRxm
    haZm/Qg4mAmxzMsug=; b=vyyQoazXfKBKhdaA27fADdrOUMyW9tBcUJrnbjdlNl
    KFhWO+8/4N3tZv/hSp5W3U0t7eLDPRuo+WEA8Tz4Nu0dhysHfwkkGurIxv1nxjU/
    qcN4/w8DKrdsh4razEvVCY6Alf+R3QHwOyfCRHEuMnARA4zIHQLW2cKxXernpAPf
    L9pPsJ1DKIDoGTLBnI2+Rae26SVQKWd6VlHKtGa8T89Lkuf4j6LCnR7XYxdG0p/d
    K3vsa/X6XTUqqOqzj/s6yqVIvFdXuZDmql9SWtNLqK7mI6jB+qh3qPcKdNVdtRcU
    ZQeAj7+LuvIY1GoAQe4wr5lAttmOUhu0WC7L12BzjUQA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=lTTbYW+e x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AF8zW4K7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=lTTbYW+e x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AF8zW4K7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeBET7E (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 14:59:04 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41716 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeBET6c (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 14:58:32 -0500
X-Google-Smtp-Source: AH8x226yuXIrwbPWUfjFfhH4omnNLtrWgM4+z7wPClMX9yMoQh8pDyggePpMkBq8I/ggZYjtxWRIcg==
From: Jin Qian <jinqian@android.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: Jin Qian <jinqian@google.com>, stable@vger.kernel.org,
        Jin Qian <jinqian@android.com>
Subject: [PATCH 1/1] ext4: don't put symlink in pagecache into highmem
Date: Mon,  5 Feb 2018 11:57:39 -0800
Message-Id: <20180205195739.9654-1-jinqian@android.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jin Qian <jinqian@google.com>

partial backport of 21fc61c73c3903c4c312d0802da01ec2b323d174.

ext4_encrypted_follow_link uses kmap() for cpage
  caddr = kmap(cpage);

_ext4_fname_disk_to_usr calls virt_to_page on the kmapped address.
  _ext4_fname_disk_to_usr()
    ext4_fname_decrypt()
      sg_init_one()
        sg_init_one(&src_sg, iname->name, iname->len);
          sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));

Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jin Qian <jinqian@android.com>
---
 fs/ext4/inode.c    |  1 +
 fs/ext4/namei.c    |  1 +
 fs/ext4/symlink.c  | 10 +++-------
 fs/inode.c         |  6 ++++++
 include/linux/fs.h |  1 +
 5 files changed, 12 insertions(+), 7 deletions(-)

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
