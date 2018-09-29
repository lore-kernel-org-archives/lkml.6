Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2249CC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14012087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14012087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeI3ESd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:33 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51926 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728699AbeI3ESc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:32 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6B-0000H6-Q7; Sat, 29 Sep 2018 22:48:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006tM-3Z; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Wu Fengguang" <fengguang.wu@intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.719829743@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 056/131] mm: drop vm_ops->remap_pages and
 generic_file_remap_pages() stub
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

commit d83a08db5ba6072caa658745881f4baa9bad6a08 upstream.

Nobody uses it anymore.

[akpm@linux-foundation.org: fix filemap_xip.c]
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Wu Fengguang <fengguang.wu@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16:
 - Deleted code is slightly different
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/9p/vfs_file.c   | 2 --
 fs/btrfs/file.c    | 1 -
 fs/ceph/addr.c     | 1 -
 fs/cifs/file.c     | 1 -
 fs/ext4/file.c     | 1 -
 fs/f2fs/file.c     | 1 -
 fs/fuse/file.c     | 1 -
 fs/gfs2/file.c     | 1 -
 fs/nfs/file.c      | 1 -
 fs/nilfs2/file.c   | 1 -
 fs/ocfs2/mmap.c    | 1 -
 fs/ubifs/file.c    | 1 -
 fs/xfs/xfs_file.c  | 1 -
 include/linux/fs.h | 6 ------
 include/linux/mm.h | 3 ---
 mm/filemap.c       | 1 -
 mm/filemap_xip.c   | 1 -
 mm/shmem.c         | 1 -
 18 files changed, 26 deletions(-)

--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -831,7 +831,6 @@ static const struct vm_operations_struct
 	.fault = filemap_fault,
 	.map_pages = filemap_map_pages,
 	.page_mkwrite = v9fs_vm_page_mkwrite,
-	.remap_pages = generic_file_remap_pages,
 };
 
 static const struct vm_operations_struct v9fs_mmap_file_vm_ops = {
@@ -839,7 +838,6 @@ static const struct vm_operations_struct
 	.fault = filemap_fault,
 	.map_pages = filemap_map_pages,
 	.page_mkwrite = v9fs_vm_page_mkwrite,
-	.remap_pages = generic_file_remap_pages,
 };
 
 
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2025,7 +2025,6 @@ static const struct vm_operations_struct
 	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= btrfs_page_mkwrite,
-	.remap_pages	= generic_file_remap_pages,
 };
 
 static int btrfs_file_mmap(struct file	*filp, struct vm_area_struct *vma)
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1327,7 +1327,6 @@ out:
 static struct vm_operations_struct ceph_vmops = {
 	.fault		= ceph_filemap_fault,
 	.page_mkwrite	= ceph_page_mkwrite,
-	.remap_pages	= generic_file_remap_pages,
 };
 
 int ceph_mmap(struct file *file, struct vm_area_struct *vma)
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3111,7 +3111,6 @@ static struct vm_operations_struct cifs_
 	.fault = filemap_fault,
 	.map_pages = filemap_map_pages,
 	.page_mkwrite = cifs_page_mkwrite,
-	.remap_pages = generic_file_remap_pages,
 };
 
 int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma)
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -195,7 +195,6 @@ static const struct vm_operations_struct
 	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite   = ext4_page_mkwrite,
-	.remap_pages	= generic_file_remap_pages,
 };
 
 static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -87,7 +87,6 @@ static const struct vm_operations_struct
 	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= f2fs_vm_page_mkwrite,
-	.remap_pages	= generic_file_remap_pages,
 };
 
 static int get_parent_ino(struct inode *inode, nid_t *pino)
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2138,7 +2138,6 @@ static const struct vm_operations_struct
 	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= fuse_page_mkwrite,
-	.remap_pages	= generic_file_remap_pages,
 };
 
 static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -496,7 +496,6 @@ static const struct vm_operations_struct
 	.fault = filemap_fault,
 	.map_pages = filemap_map_pages,
 	.page_mkwrite = gfs2_page_mkwrite,
-	.remap_pages = generic_file_remap_pages,
 };
 
 /**
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -618,7 +618,6 @@ static const struct vm_operations_struct
 	.fault = filemap_fault,
 	.map_pages = filemap_map_pages,
 	.page_mkwrite = nfs_vm_page_mkwrite,
-	.remap_pages = generic_file_remap_pages,
 };
 
 static int nfs_need_sync_write(struct file *filp, struct inode *inode)
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -136,7 +136,6 @@ static const struct vm_operations_struct
 	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= nilfs_page_mkwrite,
-	.remap_pages	= generic_file_remap_pages,
 };
 
 static int nilfs_file_mmap(struct file *file, struct vm_area_struct *vma)
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -173,7 +173,6 @@ out:
 static const struct vm_operations_struct ocfs2_file_vm_ops = {
 	.fault		= ocfs2_fault,
 	.page_mkwrite	= ocfs2_page_mkwrite,
-	.remap_pages	= generic_file_remap_pages,
 };
 
 int ocfs2_mmap(struct file *file, struct vm_area_struct *vma)
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1556,7 +1556,6 @@ static const struct vm_operations_struct
 	.fault        = filemap_fault,
 	.map_pages = filemap_map_pages,
 	.page_mkwrite = ubifs_vm_page_mkwrite,
-	.remap_pages = generic_file_remap_pages,
 };
 
 static int ubifs_file_mmap(struct file *file, struct vm_area_struct *vma)
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1481,5 +1481,4 @@ static const struct vm_operations_struct
 	.fault		= xfs_filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= xfs_filemap_page_mkwrite,
-	.remap_pages	= generic_file_remap_pages,
 };
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2430,12 +2430,6 @@ extern int sb_min_blocksize(struct super
 
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
-static inline int generic_file_remap_pages(struct vm_area_struct *vma,
-		unsigned long addr, unsigned long size, pgoff_t pgoff)
-{
-	BUG();
-	return 0;
-}
 int generic_write_checks(struct file *file, loff_t *pos, size_t *count, int isblk);
 extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -268,9 +268,6 @@ struct vm_operations_struct {
 	int (*migrate)(struct vm_area_struct *vma, const nodemask_t *from,
 		const nodemask_t *to, unsigned long flags);
 #endif
-	/* called by sys_remap_file_pages() to populate non-linear mapping */
-	int (*remap_pages)(struct vm_area_struct *vma, unsigned long addr,
-			   unsigned long size, pgoff_t pgoff);
 };
 
 struct mmu_gather;
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2078,7 +2078,6 @@ const struct vm_operations_struct generi
 	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= filemap_page_mkwrite,
-	.remap_pages	= generic_file_remap_pages,
 };
 
 /* This is used for a general mmap of a disk file */
--- a/mm/filemap_xip.c
+++ b/mm/filemap_xip.c
@@ -306,7 +306,6 @@ out:
 static const struct vm_operations_struct xip_file_vm_ops = {
 	.fault	= xip_file_fault,
 	.page_mkwrite	= filemap_page_mkwrite,
-	.remap_pages = generic_file_remap_pages,
 };
 
 int xip_file_mmap(struct file * file, struct vm_area_struct * vma)
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2793,7 +2793,6 @@ static const struct vm_operations_struct
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
 #endif
-	.remap_pages	= generic_file_remap_pages,
 };
 
 static struct dentry *shmem_mount(struct file_system_type *fs_type,

