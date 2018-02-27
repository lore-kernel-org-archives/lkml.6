Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1993284-1519751042-2-16376027547048134830
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519751041; b=fQ0UMXeTNa9itPhxPAMFkVYiPqWXPp3mkuhOGEztbsPBHpe
    Z4xj7Po05B2GRl5FhY/zuWFTVPWBMrRk9wQ1imDswJVMrXT3xRf3QEN7K71NCfGD
    Ij9GYfCLAeV6XWRRXA0UQTMZeKfxgyJJjoTSWR2cWdUGjwFJZxPXcLd9fG6ipJ2F
    z8u/sBAS2LZZUTw4h7gmdDvlIE0HMfboZZBkezlOJSOqwI9M9mN+OypBdasXdAJy
    ZH7Xb83BQOPbVXMPyH9ANGlwPLG4Rzj3ARYTajGJi29xoJKPULYlxXUkmmM+drRE
    2QBa5Rs6FnDfU3iroypYkU0dVCsINK3hsYQ1Vig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519751041; bh=BxsdjqlR7WawGBG6oJBnEMALB9
    aDPA9dkYDf0ZPO04s=; b=dUQMc64UyM2HOhiOfvqg7vIX+E7MQ3n/KqgBY+/8dw
    aDJ0pc/bSpyaKUPBSU6l6CptAxD4Ux7JL7Zu7+KQ+YpYv+34D7oT0CdGzPAuYGFj
    r9kMcBiqqnlVgx0lBfl8IwEiykDC47kZi5APvNngYeC5vdDc0RJ8mpgk8EzvwNZz
    sLIkhmNlmeACrOXVvomYyypqsarjJQAXJsyWpeZ1msIC3wzqXNA//yWGRuNMiVs3
    wLM7EfnkHhz1pcsW9cUXd4+RiUXm4mLjDXXIohP8YA1S2bs/VHIOA+B4eTdUjARa
    G0OFQ8Wf+ofi9JZKH6+sxPCBS5wcM5c3WBFBKPZNj9Zg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeB0RDn (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 12:03:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:47490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbeB0RDm (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 27 Feb 2018 12:03:42 -0500
Date: Tue, 27 Feb 2018 18:03:40 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Matthew Wilcox <mawilcox@microsoft.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v4 08/12] xfs, dax: replace IS_DAX() with IS_FSDAX()
Message-ID: <20180227170340.yzaxfiuso6mjsedv@quack2.suse.cz>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151970523724.26729.2708434307206092584.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151970523724.26729.2708434307206092584.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 26-02-18 20:20:37, Dan Williams wrote:
> In preparation for fixing the broken definition of S_DAX in the
> CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y case, convert all IS_DAX() usages to
> use explicit tests for FSDAX since DAX is ambiguous.
> 
> Cc: Jan Kara <jack@suse.com>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: linux-xfs@vger.kernel.org
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xfs/xfs_file.c    |   14 +++++++-------
>  fs/xfs/xfs_ioctl.c   |    4 ++--
>  fs/xfs/xfs_iomap.c   |    6 +++---
>  fs/xfs/xfs_reflink.c |    2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)
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
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
