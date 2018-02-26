Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2556621-1519639591-2-11689468127891572848
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519639590; b=DeZjcv/sjH9ORPqbYjk/zSUfYvmuPv3JChykLf5IYNbbKi/
    ERvDoRU49nwZ+MUZAF5kBTfdOIe5QMa947iVsm2DJeD5Y3+Z3Sv+5swura/IfaIl
    XYskYH8b0ZnFGZP8vpEGzAsUlVckREsjJ1sJ3c+ICcdoc7fopzQGm/OyH8uUEGpv
    3EmDjYQ4qdPtJp6hfBn5Ei3qTT9PrTKRUYHUi8qOrLKYLLpGHlAAo1MGIiToWJaS
    6EIf98HkbbYVMHitDVTBd8QaSqTWPU3azUI1Yq08WEjJYv0yiM3r8l1IIlVTBuoH
    3b/pNGl2s2XC81VuaA+ii8+U/lJ6UY6uxaSRWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519639590; bh=uYIbnoerEPXN3gl9+m8mJ3GrB1
    lp2RheY0LNlmgtFao=; b=EYmWXck7YHNjoIDsA0YCtfsFa7/4bwEJGZdCzo4IEH
    KuK/jaMjA9htK908VclUH0CkwQODCLlD0xuI9P6ROyXyplp+mApKgtItiigVe9nt
    S83dVtkZmq/n2OMFUu0bRXmlquesfpzBBtsNV6td9RpryO8wtma+RZO+CaV/BD0X
    nCFSXZ4zbmcEB4O5/Lq2EK4ZQTqFix2jaV/+gD0nlDCkGWN5Gzajgbx90xT5zNFD
    VxpIqjCTE0hSl2m5REaQ4dIQg+6OlSPUsqX5TVkwNutNyo3SYeflFF3Hsjeb0PJH
    lsBuuWznJXZea3DjwE/AFo5kRW12IYqKRmSKUR7t155A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbeBZKGQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 05:06:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:53506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751548AbeBZKGO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 05:06:14 -0500
Date: Mon, 26 Feb 2018 11:06:11 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>
Subject: Re: [PATCH v3 3/6] xfs, dax: introduce IS_FSDAX()
Message-ID: <20180226100611.sgw2rucvv6yhzn5y@quack2.suse.cz>
References: <151943298533.29249.14597996053028346159.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151943300713.29249.545330864711927648.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151943300713.29249.545330864711927648.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 23-02-18 16:43:27, Dan Williams wrote:
> Given that S_DAX is non-zero in the FS_DAX=n + DEV_DAX=y case, another
> mechanism besides the plain IS_DAX() check to compile out dead
> filesystem-dax code paths. Without IS_FSDAX() xfs will fail at link time
> with:
> 
>     ERROR: "dax_finish_sync_fault" [fs/xfs/xfs.ko] undefined!
>     ERROR: "dax_iomap_fault" [fs/xfs/xfs.ko] undefined!
>     ERROR: "dax_iomap_rw" [fs/xfs/xfs.ko] undefined!
> 
> This compile failure was previously hidden by the fact that S_DAX was
> erroneously defined to '0' in the FS_DAX=n + DEV_DAX=y case.
> 
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: linux-xfs@vger.kernel.org
> Cc: <stable@vger.kernel.org>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

As much as I appreciate that relying on compiler to optimize out dead
branches results in nicer looking code this is an example where it
backfires. Also having IS_DAX() and IS_FSDAX() doing almost the same, just
not exactly the same, is IMHO a recipe for confusion (e.g. a casual reader
could think why does ext4 get away with using IS_DAX while XFS has to use
IS_FSDAX?). So I'd just prefer to handle this as is usual in other kernel
areas - define empty stubs for all exported functions when CONFIG_FS_DAX is
not enabled. That way code can stay without ugly ifdefs and we don't have
to bother with IS_FSDAX vs IS_DAX distinction in filesystem code. Thoughts?

								Honza

> ---
>  fs/xfs/xfs_file.c    |   14 +++++++-------
>  fs/xfs/xfs_ioctl.c   |    4 ++--
>  fs/xfs/xfs_iomap.c   |    6 +++---
>  fs/xfs/xfs_reflink.c |    2 +-
>  include/linux/fs.h   |    2 ++
>  5 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 9ea08326f876..46a098b90fd0 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -288,7 +288,7 @@ xfs_file_read_iter(
>  	if (XFS_FORCED_SHUTDOWN(mp))
>  		return -EIO;
>  
> -	if (IS_DAX(inode))
> +	if (IS_FSDAX(inode))
>  		ret = xfs_file_dax_read(iocb, to);
>  	else if (iocb->ki_flags & IOCB_DIRECT)
>  		ret = xfs_file_dio_aio_read(iocb, to);
> @@ -726,7 +726,7 @@ xfs_file_write_iter(
>  	if (XFS_FORCED_SHUTDOWN(ip->i_mount))
>  		return -EIO;
>  
> -	if (IS_DAX(inode))
> +	if (IS_FSDAX(inode))
>  		ret = xfs_file_dax_write(iocb, from);
>  	else if (iocb->ki_flags & IOCB_DIRECT) {
>  		/*
> @@ -1045,7 +1045,7 @@ __xfs_filemap_fault(
>  	}
>  
>  	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> -	if (IS_DAX(inode)) {
> +	if (IS_FSDAX(inode)) {
>  		pfn_t pfn;
>  
>  		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &xfs_iomap_ops);
> @@ -1070,7 +1070,7 @@ xfs_filemap_fault(
>  {
>  	/* DAX can shortcut the normal fault path on write faults! */
>  	return __xfs_filemap_fault(vmf, PE_SIZE_PTE,
> -			IS_DAX(file_inode(vmf->vma->vm_file)) &&
> +			IS_FSDAX(file_inode(vmf->vma->vm_file)) &&
>  			(vmf->flags & FAULT_FLAG_WRITE));
>  }
>  
> @@ -1079,7 +1079,7 @@ xfs_filemap_huge_fault(
>  	struct vm_fault		*vmf,
>  	enum page_entry_size	pe_size)
>  {
> -	if (!IS_DAX(file_inode(vmf->vma->vm_file)))
> +	if (!IS_FSDAX(file_inode(vmf->vma->vm_file)))
>  		return VM_FAULT_FALLBACK;
>  
>  	/* DAX can shortcut the normal fault path on write faults! */
> @@ -1124,12 +1124,12 @@ xfs_file_mmap(
>  	 * We don't support synchronous mappings for non-DAX files. At least
>  	 * until someone comes with a sensible use case.
>  	 */
> -	if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
> +	if (!IS_FSDAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
>  		return -EOPNOTSUPP;
>  
>  	file_accessed(filp);
>  	vma->vm_ops = &xfs_file_vm_ops;
> -	if (IS_DAX(file_inode(filp)))
> +	if (IS_FSDAX(file_inode(filp)))
>  		vma->vm_flags |= VM_MIXEDMAP | VM_HUGEPAGE;
>  	return 0;
>  }
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 89fb1eb80aae..234279ff66ce 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1108,9 +1108,9 @@ xfs_ioctl_setattr_dax_invalidate(
>  	}
>  
>  	/* If the DAX state is not changing, we have nothing to do here. */
> -	if ((fa->fsx_xflags & FS_XFLAG_DAX) && IS_DAX(inode))
> +	if ((fa->fsx_xflags & FS_XFLAG_DAX) && IS_FSDAX(inode))
>  		return 0;
> -	if (!(fa->fsx_xflags & FS_XFLAG_DAX) && !IS_DAX(inode))
> +	if (!(fa->fsx_xflags & FS_XFLAG_DAX) && !IS_FSDAX(inode))
>  		return 0;
>  
>  	/* lock, flush and invalidate mapping in preparation for flag change */
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 66e1edbfb2b2..cf794d429aec 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -241,7 +241,7 @@ xfs_iomap_write_direct(
>  	 * the reserve block pool for bmbt block allocation if there is no space
>  	 * left but we need to do unwritten extent conversion.
>  	 */
> -	if (IS_DAX(VFS_I(ip))) {
> +	if (IS_FSDAX(VFS_I(ip))) {
>  		bmapi_flags = XFS_BMAPI_CONVERT | XFS_BMAPI_ZERO;
>  		if (imap->br_state == XFS_EXT_UNWRITTEN) {
>  			tflags |= XFS_TRANS_RESERVE;
> @@ -952,7 +952,7 @@ static inline bool imap_needs_alloc(struct inode *inode,
>  	return !nimaps ||
>  		imap->br_startblock == HOLESTARTBLOCK ||
>  		imap->br_startblock == DELAYSTARTBLOCK ||
> -		(IS_DAX(inode) && imap->br_state == XFS_EXT_UNWRITTEN);
> +		(IS_FSDAX(inode) && imap->br_state == XFS_EXT_UNWRITTEN);
>  }
>  
>  static inline bool need_excl_ilock(struct xfs_inode *ip, unsigned flags)
> @@ -988,7 +988,7 @@ xfs_file_iomap_begin(
>  		return -EIO;
>  
>  	if (((flags & (IOMAP_WRITE | IOMAP_DIRECT)) == IOMAP_WRITE) &&
> -			!IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
> +			!IS_FSDAX(inode) && !xfs_get_extsz_hint(ip)) {
>  		/* Reserve delalloc blocks for regular writeback. */
>  		return xfs_file_iomap_begin_delay(inode, offset, length, iomap);
>  	}
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 270246943a06..a126e00e05e3 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1351,7 +1351,7 @@ xfs_reflink_remap_range(
>  		goto out_unlock;
>  
>  	/* Don't share DAX file data for now. */
> -	if (IS_DAX(inode_in) || IS_DAX(inode_out))
> +	if (IS_FSDAX(inode_in) || IS_FSDAX(inode_out))
>  		goto out_unlock;
>  
>  	ret = vfs_clone_file_prep_inodes(inode_in, pos_in, inode_out, pos_out,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 79c413985305..a4310a95011b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1909,6 +1909,8 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
>  #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
>  				 (inode)->i_rdev == WHITEOUT_DEV)
>  
> +#define IS_FSDAX(inode) (IS_ENABLED(CONFIG_FS_DAX) && IS_DAX(inode))
> +
>  static inline bool HAS_UNMAPPED_ID(struct inode *inode)
>  {
>  	return !uid_valid(inode->i_uid) || !gid_valid(inode->i_gid);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
