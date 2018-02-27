Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1988021-1519750875-2-17948535695556614563
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519750874; b=bX3dvmCp0tVSqQUvUrjTeHSX23H4Pj6FC5H0ytzc8iUDhwA
    FTLvQFEOU19yTDP/Bg1ZjHHq2dV0/dRLWik+x2mcuyON8dPARw+wmm4wb8aGOWV7
    7S2ksPmSOz+1VM9SVP8vJnkSgFpgGZBNrxA3jny2sCDuf9ef8SkvAG6e+tPGlzD7
    z296lOeFjMzqCJFrnf7peRwyqbxmSNjiCL1Oi30bVoxOp7TYe1U73Gmt5ILU4FP5
    Z8A1AsF94IUuHbVBNm3YxbPLTcR51KXGi8inRKLwpRNb5uePhZaiF5pXiYLs92vZ
    C3TurGSu2QnZSdH6G86Ql6KzSmSvuLuOd7x+OfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519750874; bh=iaN7SAluWCrpiriwXnVrOU1veb
    wyzSUZlWDdNnqtC6w=; b=KPXB7lmPY0R7d8CCOrZ5WEFeT7BoX+0Jehb4azz2mv
    WdtcVaHhTpWXWqlHSW+zkLnlVGdIBIu+QjpgcU+szw6DXlAVnXboDkCiBCGjbcCX
    c/CX24YlDIMfIMVB8/2zJj+F4yJeP2ulVM3v4g0Zi2BezZT+4mg9aAnMzDY67xD7
    raWs137U3yituIc5ie/M2nqvKrFdoalyXdIwh23jITbg3rTwd791G2plCo3AsZBf
    G/G2BQzJt3ub2kiZ0iuyfrqBHPV1azdvu4kZeHLEEdH6Ah7OoYGHNYq8/+o7v2RQ
    rZvDWsKqCBNlw/NvtrZss6d9r5IWRnFQfg2/aEACF1TA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbeB0RBN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 12:01:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:47279 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751804AbeB0RBM (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 27 Feb 2018 12:01:12 -0500
Date: Tue, 27 Feb 2018 18:01:10 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH v4 04/12] ext2, dax: define ext2_dax_*() infrastructure
 in all cases
Message-ID: <20180227170110.uymbsfbk33unpjid@quack2.suse.cz>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151970521671.26729.14342103844044388890.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151970521671.26729.14342103844044388890.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 26-02-18 20:20:16, Dan Williams wrote:
> In preparation for fixing S_DAX to be defined in the CONFIG_FS_DAX=n +
> CONFIG_DEV_DAX=y case, move the definition of these routines outside of
> the "#ifdef CONFIG_FS_DAX" guard. This is also a coding-style fix to
> move all ifdef handling to header files rather than in the source. The
> compiler will still be able to determine that all the related code can
> be discarded in the CONFIG_FS_DAX=n case.
> 
> Cc: Jan Kara <jack@suse.com>
> Cc: <stable@vger.kernel.org>
> Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext2/file.c      |    8 --------
>  include/linux/dax.h |   10 ++++++++--
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext2/file.c b/fs/ext2/file.c
> index 1c7ea1bcddde..5ac98d074323 100644
> --- a/fs/ext2/file.c
> +++ b/fs/ext2/file.c
> @@ -29,7 +29,6 @@
>  #include "xattr.h"
>  #include "acl.h"
>  
> -#ifdef CONFIG_FS_DAX
>  static ssize_t ext2_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
>  	struct inode *inode = iocb->ki_filp->f_mapping->host;
> @@ -128,9 +127,6 @@ static int ext2_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	vma->vm_flags |= VM_MIXEDMAP;
>  	return 0;
>  }
> -#else
> -#define ext2_file_mmap	generic_file_mmap
> -#endif
>  
>  /*
>   * Called when filp is released. This happens when all file descriptors
> @@ -162,19 +158,15 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  
>  static ssize_t ext2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
> -#ifdef CONFIG_FS_DAX
>  	if (IS_DAX(iocb->ki_filp->f_mapping->host))
>  		return ext2_dax_read_iter(iocb, to);
> -#endif
>  	return generic_file_read_iter(iocb, to);
>  }
>  
>  static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
> -#ifdef CONFIG_FS_DAX
>  	if (IS_DAX(iocb->ki_filp->f_mapping->host))
>  		return ext2_dax_write_iter(iocb, from);
> -#endif
>  	return generic_file_write_iter(iocb, from);
>  }
>  
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 0185ecdae135..47edbce4fc52 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -93,8 +93,6 @@ void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
>  void dax_write_cache(struct dax_device *dax_dev, bool wc);
>  bool dax_write_cache_enabled(struct dax_device *dax_dev);
>  
> -ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
> -		const struct iomap_ops *ops);
>  int dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
>  		    pfn_t *pfnp, int *errp, const struct iomap_ops *ops);
>  int dax_finish_sync_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
> @@ -107,6 +105,8 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  int __dax_zero_page_range(struct block_device *bdev,
>  		struct dax_device *dax_dev, sector_t sector,
>  		unsigned int offset, unsigned int length);
> +ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
> +		const struct iomap_ops *ops);
>  #else
>  static inline int __dax_zero_page_range(struct block_device *bdev,
>  		struct dax_device *dax_dev, sector_t sector,
> @@ -114,6 +114,12 @@ static inline int __dax_zero_page_range(struct block_device *bdev,
>  {
>  	return -ENXIO;
>  }
> +
> +static inline ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
> +		const struct iomap_ops *ops)
> +{
> +	return -ENXIO;
> +}
>  #endif
>  
>  static inline bool dax_mapping(struct address_space *mapping)
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
