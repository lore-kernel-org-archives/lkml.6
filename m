Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2266183-1527607049-2-12239726565869974427
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527607048; b=Azk8LetBhmxNiefOS6MosGI+azr4E+59jevYYiU7jGjlxsd9B6
    3ZXri+X/+L8EUwSJ1ha1hWlkrFGpqrGJ5jME/YxlNnCr3vuNfHkOXlJtAF5pIKf1
    MLgFLV0/6JXjj+fGt32X2JL7bP+P6MG+PhotXNRfUOXm17fP7pqjg1GtUL0229lI
    e3t9TBIRndrMkGvC/ii0XKbx90Ca9P0y67ABSvJ9apeeaBxju3BwRzXjQZk3Ds0W
    WlZU09sUC/bDfrvF1+HQCW+03rzWANUh+I4nQ6zJN/l82iLH8ULQKO11/rZqhtHh
    29kvJ1ycld96C2SiW0vSpftADB22GDQrERbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527607048; bh=
    QHHw+y/T7t2a0iee/KElpoQLye4NLOE4b0YxbK0I6D4=; b=hmg3rVyyEr4vM9h9
    0IwF2W5AMeU8hB0tgq/TSz+HQD7FVhEdh7Mpyh3BWI6hgJ072o35IiGi7aQKCocG
    DCXyRyIpRgdFa6ajWsabIkzYRsoPZbT1VCMoDQO8cW9UlLRErJPQ6a0vj8ME3UCj
    fHyC55nt8Z8VF1s6DH3eqdgMAuuzXOz/N4BY/O6wLKsIy60op2Sqpa06aV3fH/4U
    oL3ema3Sdui99oMveEEhfM64lizSfUdB57t0JB3bG9zm+0mXAB4eO64N7Fb03KgX
    kmYUYWe18GB9ZwsKZrRGZ/qvJ+sxhxZLvCGgkDvqwA+mjhvszaIJYomidWLSXoWE
    XRadiw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=DdMcR3Kv;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=DdMcR3Kv;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC4orInSm0nPoLeXl+XdTXkh86tUwln4IDuw3L3UYa5LOQX5J2Qv7sw1+3EM6b7lu5BAFFy8TuqIt6OfJLWJOnpt9z7hhf5CmjDItFDNb5+8OGzMsh5+
    veDbD8n9xEaivrn+8RpNEgXkHBBJ06sGaPLBXlSWSGi7LqP1xhB71YW4enWBjyPC1r2I6Z/yYHvBZJ/Gi3ciDn0rYZ6B/3Iwif14T0t/Ve7PIOBW0we1ik9e
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=aYJj23L624zupuIOXLgA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935241AbeE2PQw (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 11:16:52 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:45968 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935123AbeE2Ono (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:43:44 -0400
X-Google-Smtp-Source: AB8JxZoyA/tnCjmrTaXKwuPOpCIPDOpkrctoD7geLBcfJA31HCJnhni3ME405m8nkrAm8afRruvcrQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/39] vfs: dedupe: rationalize args
Date: Tue, 29 May 2018 16:43:02 +0200
Message-Id: <20180529144339.16538-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clean up f_op->dedupe_file_range() interface.

1) Use loff_t for offsets and length instead of u64
2) Order the arguments the same way as {copy|clone}_file_range().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/btrfs/ctree.h   | 5 +++--
 fs/btrfs/ioctl.c   | 5 +++--
 fs/ocfs2/file.c    | 6 +++---
 fs/read_write.c    | 4 ++--
 fs/xfs/xfs_file.c  | 6 +++---
 include/linux/fs.h | 4 ++--
 6 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 990e011c9f0c..5968ba5aa0d1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3271,8 +3271,9 @@ void btrfs_get_block_group_info(struct list_head *groups_list,
 				struct btrfs_ioctl_space_info *space);
 void update_ioctl_balance_args(struct btrfs_fs_info *fs_info, int lock,
 			       struct btrfs_ioctl_balance_args *bargs);
-loff_t btrfs_dedupe_file_range(struct file *src_file, u64 loff, u64 olen,
-			    struct file *dst_file, u64 dst_loff);
+loff_t btrfs_dedupe_file_range(struct file *src_file, loff_t loff,
+			       struct file *dst_file, loff_t dst_loff,
+			       loff_t olen);
 
 /* file.c */
 int __init btrfs_auto_defrag_init(void);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 1b5cc5fd4868..70eac76804df 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3194,8 +3194,9 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
 
 #define BTRFS_MAX_DEDUPE_LEN	SZ_16M
 
-loff_t btrfs_dedupe_file_range(struct file *src_file, u64 loff, u64 olen,
-			       struct file *dst_file, u64 dst_loff)
+loff_t btrfs_dedupe_file_range(struct file *src_file, loff_t loff,
+			       struct file *dst_file, loff_t dst_loff,
+			       loff_t olen)
 {
 	struct inode *src = file_inode(src_file);
 	struct inode *dst = file_inode(dst_file);
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 4a81d82ab7f6..a024715cd227 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2538,10 +2538,10 @@ static int ocfs2_file_clone_range(struct file *file_in,
 }
 
 static loff_t ocfs2_file_dedupe_range(struct file *src_file,
-				      u64 loff,
-				      u64 len,
+				      loff_t loff,
 				      struct file *dst_file,
-				      u64 dst_loff)
+				      loff_t dst_loff,
+				      loff_t len)
 {
 	int error;
 
diff --git a/fs/read_write.c b/fs/read_write.c
index c41e2a1eb7c7..1818581cadf6 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -2046,8 +2046,8 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 			info->status = -EINVAL;
 		} else {
 			deduped = dst_file->f_op->dedupe_file_range(file, off,
-							len, dst_file,
-							info->dest_offset);
+							dst_file,
+							info->dest_offset, len);
 			if (deduped == -EBADE)
 				info->status = FILE_DEDUPE_RANGE_DIFFERS;
 			else if (deduped < 0)
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index cf51d47efdb6..75704edfba82 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -875,10 +875,10 @@ xfs_file_clone_range(
 STATIC loff_t
 xfs_file_dedupe_range(
 	struct file	*src_file,
-	u64		loff,
-	u64		len,
+	loff_t		loff,
 	struct file	*dst_file,
-	u64		dst_loff)
+	loff_t		dst_loff,
+	loff_t		len)
 {
 	struct inode	*srci = file_inode(src_file);
 	u64		max_dedupe;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8e49defc7aab..b0f290944220 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1738,8 +1738,8 @@ struct file_operations {
 			loff_t, size_t, unsigned int);
 	int (*clone_file_range)(struct file *, loff_t, struct file *, loff_t,
 			u64);
-	loff_t (*dedupe_file_range)(struct file *, u64, u64, struct file *,
-			u64);
+	loff_t (*dedupe_file_range)(struct file *, loff_t,
+				    struct file *, loff_t, loff_t);
 } __randomize_layout;
 
 struct inode_operations {
-- 
2.14.3
