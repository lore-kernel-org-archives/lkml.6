Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-52214-1519433661-2-13497822085320080522
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519433661; b=uiV35o7+NohmFGFkyy1+OxxDZ8ReIj487JgD69ZZeQhlzpn
    nKTSWGdquHyO5eatS7+fxxmHAZxBQ2oc/j+ypZtIT4XR15WmXrL8QMeemlBBC2dg
    qdJylFEsNZ0wdjv3WOigtVKp4UBWyb5PliNFEh5C4AGBIRtQ5rdmea1vYbW00pHd
    RTdOtc5q02bPew9ciefcRax3x0EaNkT1Jo6ZHSkE3ydkjWSIYD+VJxeFm50n6vvS
    ms32QkQD+Cy51QRCOfbhiJWi3Dcq1C8e4xvTXeiTLBaOH9ecbsRI6a4a6ExhJFl0
    lVF80wOFneQtuW0JykRblrM8rPHfTlHDkoiPHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519433661; bh=8/rfDc7InjAWSzdDmwJ/MvVbf+/PFyliV7eByo/K+uY=; b=g
    HVoTCptYfatTfzi/0VJzqJh+3UveBOX542xVk0AKvQZkJcdlOlo/KNtCNepaqyCv
    dXwxxlnV8f8TJXqAL+NqqkjvnWhgkHH4emsDoC2B8nkqFuPpOYyB4Q9YzJ27yaGP
    5+RvAM4YBHEvEYM/cTZUJs6dULf6FCJztIdqQu2YaMprHHoNusuwxP/KHw7S/wrH
    bS2Mu9WrvmoV7eUy3+Ai9y4aqN8OSHgI1TvSUDoDs5p2sj7HsFHLBIzvnCnMFlJJ
    3sPnQIUs9Ik+FQ0gSUXqKyMUj0MLJRjmSkTRNEJNLL+/hX5iKDZbfgBVEqExGZGi
    kRARFeJKCyNsSoEuOPKmw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeBXAx7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 19:53:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:58895 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752768AbeBXAwd (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 19:52:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,385,1515484800";
   d="scan'208";a="37031460"
Subject: [PATCH v3 3/6] xfs, dax: introduce IS_FSDAX()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 23 Feb 2018 16:43:27 -0800
Message-ID: <151943300713.29249.545330864711927648.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151943298533.29249.14597996053028346159.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151943298533.29249.14597996053028346159.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Given that S_DAX is non-zero in the FS_DAX=n + DEV_DAX=y case, another
mechanism besides the plain IS_DAX() check to compile out dead
filesystem-dax code paths. Without IS_FSDAX() xfs will fail at link time
with:

    ERROR: "dax_finish_sync_fault" [fs/xfs/xfs.ko] undefined!
    ERROR: "dax_iomap_fault" [fs/xfs/xfs.ko] undefined!
    ERROR: "dax_iomap_rw" [fs/xfs/xfs.ko] undefined!

This compile failure was previously hidden by the fact that S_DAX was
erroneously defined to '0' in the FS_DAX=n + DEV_DAX=y case.

Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org
Cc: <stable@vger.kernel.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/xfs/xfs_file.c    |   14 +++++++-------
 fs/xfs/xfs_ioctl.c   |    4 ++--
 fs/xfs/xfs_iomap.c   |    6 +++---
 fs/xfs/xfs_reflink.c |    2 +-
 include/linux/fs.h   |    2 ++
 5 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 9ea08326f876..46a098b90fd0 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -288,7 +288,7 @@ xfs_file_read_iter(
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return -EIO;
 
-	if (IS_DAX(inode))
+	if (IS_FSDAX(inode))
 		ret = xfs_file_dax_read(iocb, to);
 	else if (iocb->ki_flags & IOCB_DIRECT)
 		ret = xfs_file_dio_aio_read(iocb, to);
@@ -726,7 +726,7 @@ xfs_file_write_iter(
 	if (XFS_FORCED_SHUTDOWN(ip->i_mount))
 		return -EIO;
 
-	if (IS_DAX(inode))
+	if (IS_FSDAX(inode))
 		ret = xfs_file_dax_write(iocb, from);
 	else if (iocb->ki_flags & IOCB_DIRECT) {
 		/*
@@ -1045,7 +1045,7 @@ __xfs_filemap_fault(
 	}
 
 	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
-	if (IS_DAX(inode)) {
+	if (IS_FSDAX(inode)) {
 		pfn_t pfn;
 
 		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &xfs_iomap_ops);
@@ -1070,7 +1070,7 @@ xfs_filemap_fault(
 {
 	/* DAX can shortcut the normal fault path on write faults! */
 	return __xfs_filemap_fault(vmf, PE_SIZE_PTE,
-			IS_DAX(file_inode(vmf->vma->vm_file)) &&
+			IS_FSDAX(file_inode(vmf->vma->vm_file)) &&
 			(vmf->flags & FAULT_FLAG_WRITE));
 }
 
@@ -1079,7 +1079,7 @@ xfs_filemap_huge_fault(
 	struct vm_fault		*vmf,
 	enum page_entry_size	pe_size)
 {
-	if (!IS_DAX(file_inode(vmf->vma->vm_file)))
+	if (!IS_FSDAX(file_inode(vmf->vma->vm_file)))
 		return VM_FAULT_FALLBACK;
 
 	/* DAX can shortcut the normal fault path on write faults! */
@@ -1124,12 +1124,12 @@ xfs_file_mmap(
 	 * We don't support synchronous mappings for non-DAX files. At least
 	 * until someone comes with a sensible use case.
 	 */
-	if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
+	if (!IS_FSDAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
 		return -EOPNOTSUPP;
 
 	file_accessed(filp);
 	vma->vm_ops = &xfs_file_vm_ops;
-	if (IS_DAX(file_inode(filp)))
+	if (IS_FSDAX(file_inode(filp)))
 		vma->vm_flags |= VM_MIXEDMAP | VM_HUGEPAGE;
 	return 0;
 }
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 89fb1eb80aae..234279ff66ce 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1108,9 +1108,9 @@ xfs_ioctl_setattr_dax_invalidate(
 	}
 
 	/* If the DAX state is not changing, we have nothing to do here. */
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) && IS_DAX(inode))
+	if ((fa->fsx_xflags & FS_XFLAG_DAX) && IS_FSDAX(inode))
 		return 0;
-	if (!(fa->fsx_xflags & FS_XFLAG_DAX) && !IS_DAX(inode))
+	if (!(fa->fsx_xflags & FS_XFLAG_DAX) && !IS_FSDAX(inode))
 		return 0;
 
 	/* lock, flush and invalidate mapping in preparation for flag change */
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 66e1edbfb2b2..cf794d429aec 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -241,7 +241,7 @@ xfs_iomap_write_direct(
 	 * the reserve block pool for bmbt block allocation if there is no space
 	 * left but we need to do unwritten extent conversion.
 	 */
-	if (IS_DAX(VFS_I(ip))) {
+	if (IS_FSDAX(VFS_I(ip))) {
 		bmapi_flags = XFS_BMAPI_CONVERT | XFS_BMAPI_ZERO;
 		if (imap->br_state == XFS_EXT_UNWRITTEN) {
 			tflags |= XFS_TRANS_RESERVE;
@@ -952,7 +952,7 @@ static inline bool imap_needs_alloc(struct inode *inode,
 	return !nimaps ||
 		imap->br_startblock == HOLESTARTBLOCK ||
 		imap->br_startblock == DELAYSTARTBLOCK ||
-		(IS_DAX(inode) && imap->br_state == XFS_EXT_UNWRITTEN);
+		(IS_FSDAX(inode) && imap->br_state == XFS_EXT_UNWRITTEN);
 }
 
 static inline bool need_excl_ilock(struct xfs_inode *ip, unsigned flags)
@@ -988,7 +988,7 @@ xfs_file_iomap_begin(
 		return -EIO;
 
 	if (((flags & (IOMAP_WRITE | IOMAP_DIRECT)) == IOMAP_WRITE) &&
-			!IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
+			!IS_FSDAX(inode) && !xfs_get_extsz_hint(ip)) {
 		/* Reserve delalloc blocks for regular writeback. */
 		return xfs_file_iomap_begin_delay(inode, offset, length, iomap);
 	}
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 270246943a06..a126e00e05e3 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1351,7 +1351,7 @@ xfs_reflink_remap_range(
 		goto out_unlock;
 
 	/* Don't share DAX file data for now. */
-	if (IS_DAX(inode_in) || IS_DAX(inode_out))
+	if (IS_FSDAX(inode_in) || IS_FSDAX(inode_out))
 		goto out_unlock;
 
 	ret = vfs_clone_file_prep_inodes(inode_in, pos_in, inode_out, pos_out,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 79c413985305..a4310a95011b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1909,6 +1909,8 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
 				 (inode)->i_rdev == WHITEOUT_DEV)
 
+#define IS_FSDAX(inode) (IS_ENABLED(CONFIG_FS_DAX) && IS_DAX(inode))
+
 static inline bool HAS_UNMAPPED_ID(struct inode *inode)
 {
 	return !uid_valid(inode->i_uid) || !gid_valid(inode->i_gid);
