Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948739-1527216998-2-7230771795589600015
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527216997; b=RQeKXBomjh16ScvMyg6MK9UxH4RRwoy3uh2ovM2hx931NGSelU
    n6pDi+hPbekUGsWR0tcssE8pdRYOzlfnawdID04z8noajuW73icL7enjm5rOF34k
    qHmcdiA4q+9pf2En2yt3ju5xVBjvP4F/gFfzN8832P0G7iLlZS0LhGY0tkemT2/u
    ZEp6A7JttM17YNlRrEpOqjVsl7BYmfCiLIoWyk5U6PT3j/tsXk0G8t3WRGlvn68V
    7UcpT8bLJioDj7G2P3zjjKPUMiZFxYjTKmGXfUqTmL0XMoiRXjhEJjC+LdZkuxSs
    gPsX8cvYDxsQA0q21klUW9KmbqWN4odYY7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527216997; bh=
    gS7chac+9o0t12o8leXVYtpx6fby2+jJbYF852rWybM=; b=GuGl1yeu/on/svus
    vMJ+92Z67ibaRbneC6yuVhSOlraoyKEZBNjf1vYzMmdmNC1Y6bNxVwiK1vhmCrJh
    ZQoU6l0GamZofuIKJFCi2IVHyeWYWL4BgAMY2f2XmqCHLqjiZAntzDv9m97XnqkN
    dofm5OkccECPIH7wpcZb5DgQGkeCAfeZv2etPyCUDZGdFfL8VdBokR7fMoWDhzl2
    cB92BN6aPMmgmXKH3wpvJ7mqJbm5FQH7GDjX3083cWubbg3onTe7wRqNgq/9vyrp
    v0h/YS6CFjGG/JLGNMzdLPl88RZW8k/jeqc2omYhGOpDgo+TH1uPAqf7adfd+7gB
    B7yBhw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCubdsZkCDdF97/gWjsQxlX86NeSH1lvTBhvKv9po5AN6fI/df/k6JG4ZscZUv0ou8EmDMnagnpJvvvXr0kPnWe+qmxe1xfZl570NsUgVtSswDNG2bub
    jbtkYBMr5NFa5X+gl70CmS3JEOv/jUAX6xbiKhf0NhVnQN0KxwMVGbi2hkrYLEevCjGiEvFQaubt9giJMEzP+nYXKEds2U8pqpawuVlHWa7ra+q7rs0cAv+k
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=yPCof4ZbAAAA:8
    a=QyXUC8HyAAAA:8 a=EhJ_728YtSMCoFuJMW4A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755279AbeEYC43 (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 22:56:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:22225 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbeEYCzX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 May 2018 22:55:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,438,1520924400";
   d="scan'208";a="42054614"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH 1/7] fs: allow per-device dax status checking for filesystems
Date: Thu, 24 May 2018 20:55:12 -0600
Message-Id: <20180525025518.11405-2-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180525025518.11405-1-ross.zwisler@linux.intel.com>
References: <20180525025518.11405-1-ross.zwisler@linux.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Darrick J. Wong" <darrick.wong@oracle.com>

Remove __bdev_dax_supported and change to bdev_dax_supported that takes a
bdev parameter.  This enables multi-device filesystems like xfs to check
that a dax device can work for the particular filesystem.  Once that's
in place, actually fix all the parts of XFS where we need to be able to
distinguish between datadev and rtdev.

This patch fixes the problem where we screw up the dax support checking
in xfs if the datadev and rtdev have different dax capabilities.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 drivers/dax/super.c | 30 +++++++++++++++---------------
 fs/ext2/super.c     |  2 +-
 fs/ext4/super.c     |  2 +-
 fs/xfs/xfs_ioctl.c  |  3 ++-
 fs/xfs/xfs_iops.c   | 30 +++++++++++++++++++++++++-----
 fs/xfs/xfs_super.c  | 10 ++++++++--
 include/linux/dax.h | 10 +++-------
 7 files changed, 55 insertions(+), 32 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 2b2332b605e4..9206539c8330 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -73,8 +73,8 @@ EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
 #endif
 
 /**
- * __bdev_dax_supported() - Check if the device supports dax for filesystem
- * @sb: The superblock of the device
+ * bdev_dax_supported() - Check if the device supports dax for filesystem
+ * @bdev: block device to check
  * @blocksize: The block size of the device
  *
  * This is a library function for filesystems to check if the block device
@@ -82,33 +82,33 @@ EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
  *
  * Return: negative errno if unsupported, 0 if supported.
  */
-int __bdev_dax_supported(struct super_block *sb, int blocksize)
+int bdev_dax_supported(struct block_device *bdev, int blocksize)
 {
-	struct block_device *bdev = sb->s_bdev;
 	struct dax_device *dax_dev;
 	pgoff_t pgoff;
 	int err, id;
 	void *kaddr;
 	pfn_t pfn;
 	long len;
+	char buf[BDEVNAME_SIZE];
 
 	if (blocksize != PAGE_SIZE) {
-		pr_debug("VFS (%s): error: unsupported blocksize for dax\n",
-				sb->s_id);
+		pr_debug("%s: error: unsupported blocksize for dax\n",
+				bdevname(bdev, buf));
 		return -EINVAL;
 	}
 
 	err = bdev_dax_pgoff(bdev, 0, PAGE_SIZE, &pgoff);
 	if (err) {
-		pr_debug("VFS (%s): error: unaligned partition for dax\n",
-				sb->s_id);
+		pr_debug("%s: error: unaligned partition for dax\n",
+				bdevname(bdev, buf));
 		return err;
 	}
 
 	dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
 	if (!dax_dev) {
-		pr_debug("VFS (%s): error: device does not support dax\n",
-				sb->s_id);
+		pr_debug("%s: error: device does not support dax\n",
+				bdevname(bdev, buf));
 		return -EOPNOTSUPP;
 	}
 
@@ -119,8 +119,8 @@ int __bdev_dax_supported(struct super_block *sb, int blocksize)
 	put_dax(dax_dev);
 
 	if (len < 1) {
-		pr_debug("VFS (%s): error: dax access failed (%ld)\n",
-				sb->s_id, len);
+		pr_debug("%s: error: dax access failed (%ld)\n",
+				bdevname(bdev, buf), len);
 		return len < 0 ? len : -EIO;
 	}
 
@@ -137,14 +137,14 @@ int __bdev_dax_supported(struct super_block *sb, int blocksize)
 	} else if (pfn_t_devmap(pfn)) {
 		/* pass */;
 	} else {
-		pr_debug("VFS (%s): error: dax support not enabled\n",
-				sb->s_id);
+		pr_debug("%s: error: dax support not enabled\n",
+				bdevname(bdev, buf));
 		return -EOPNOTSUPP;
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(__bdev_dax_supported);
+EXPORT_SYMBOL_GPL(bdev_dax_supported);
 #endif
 
 enum dax_device_flags {
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index de1694512f1f..9627c3054b5c 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -961,7 +961,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 
 	if (sbi->s_mount_opt & EXT2_MOUNT_DAX) {
-		err = bdev_dax_supported(sb, blocksize);
+		err = bdev_dax_supported(sb->s_bdev, blocksize);
 		if (err) {
 			ext2_msg(sb, KERN_ERR,
 				"DAX unsupported by block device. Turning off DAX.");
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index eb104e8476f0..089170e99895 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3732,7 +3732,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 					" that may contain inline data");
 			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX;
 		}
-		err = bdev_dax_supported(sb, blocksize);
+		err = bdev_dax_supported(sb->s_bdev, blocksize);
 		if (err) {
 			ext4_msg(sb, KERN_ERR,
 				"DAX unsupported by block device. Turning off DAX.");
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 89fb1eb80aae..0effd46b965f 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1103,7 +1103,8 @@ xfs_ioctl_setattr_dax_invalidate(
 	if (fa->fsx_xflags & FS_XFLAG_DAX) {
 		if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
 			return -EINVAL;
-		if (bdev_dax_supported(sb, sb->s_blocksize) < 0)
+		if (bdev_dax_supported(xfs_find_bdev_for_inode(VFS_I(ip)),
+				sb->s_blocksize) < 0)
 			return -EINVAL;
 	}
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index a3ed3c811dfa..6e83acf74a95 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1195,6 +1195,30 @@ static const struct inode_operations xfs_inline_symlink_inode_operations = {
 	.update_time		= xfs_vn_update_time,
 };
 
+/* Figure out if this file actually supports DAX. */
+static bool
+xfs_inode_supports_dax(
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/* Only supported on non-reflinked files. */
+	if (!S_ISREG(VFS_I(ip)->i_mode) || xfs_is_reflink_inode(ip))
+		return false;
+
+	/* DAX mount option or DAX iflag must be set. */
+	if (!(mp->m_flags & XFS_MOUNT_DAX) &&
+	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
+		return false;
+
+	/* Block size must match page size */
+	if (mp->m_sb.sb_blocksize != PAGE_SIZE)
+		return false;
+
+	/* Device has to support DAX too. */
+	return xfs_find_daxdev_for_inode(VFS_I(ip)) != NULL;
+}
+
 STATIC void
 xfs_diflags_to_iflags(
 	struct inode		*inode,
@@ -1213,11 +1237,7 @@ xfs_diflags_to_iflags(
 		inode->i_flags |= S_SYNC;
 	if (flags & XFS_DIFLAG_NOATIME)
 		inode->i_flags |= S_NOATIME;
-	if (S_ISREG(inode->i_mode) &&
-	    ip->i_mount->m_sb.sb_blocksize == PAGE_SIZE &&
-	    !xfs_is_reflink_inode(ip) &&
-	    (ip->i_mount->m_flags & XFS_MOUNT_DAX ||
-	     ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
+	if (xfs_inode_supports_dax(ip))
 		inode->i_flags |= S_DAX;
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d71424052917..62188c2a4c36 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1690,11 +1690,17 @@ xfs_fs_fill_super(
 		sb->s_flags |= SB_I_VERSION;
 
 	if (mp->m_flags & XFS_MOUNT_DAX) {
+		int	error2 = 0;
+
 		xfs_warn(mp,
 		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
 
-		error = bdev_dax_supported(sb, sb->s_blocksize);
-		if (error) {
+		error = bdev_dax_supported(mp->m_ddev_targp->bt_bdev,
+				sb->s_blocksize);
+		if (mp->m_rtdev_targp)
+			error2 = bdev_dax_supported(mp->m_rtdev_targp->bt_bdev,
+					sb->s_blocksize);
+		if (error && error2) {
 			xfs_alert(mp,
 			"DAX unsupported by block device. Turning off DAX.");
 			mp->m_flags &= ~XFS_MOUNT_DAX;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index f9eb22ad341e..509a85ac8470 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -64,12 +64,7 @@ static inline bool dax_write_cache_enabled(struct dax_device *dax_dev)
 struct writeback_control;
 int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgoff);
 #if IS_ENABLED(CONFIG_FS_DAX)
-int __bdev_dax_supported(struct super_block *sb, int blocksize);
-static inline int bdev_dax_supported(struct super_block *sb, int blocksize)
-{
-	return __bdev_dax_supported(sb, blocksize);
-}
-
+int bdev_dax_supported(struct block_device *bdev, int blocksize);
 static inline struct dax_device *fs_dax_get_by_host(const char *host)
 {
 	return dax_get_by_host(host);
@@ -84,7 +79,8 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
 int dax_writeback_mapping_range(struct address_space *mapping,
 		struct block_device *bdev, struct writeback_control *wbc);
 #else
-static inline int bdev_dax_supported(struct super_block *sb, int blocksize)
+static inline int bdev_dax_supported(struct block_device *bdev,
+		int blocksize)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.14.3
