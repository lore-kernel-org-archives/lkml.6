Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1988021-1519750954-2-3514939328707490577
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrofr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519750953; b=TNLoZR6jtlDq80SHALo1XQIiNcQLgscGfFMbhokE83nALkm
    kaNOwBYbHD+/DaMyfWW5qu8eJ82js5fyve1xUrW7TiNl/pK1HhhiXvPRJi7a5cqU
    A1em8bKzT9gzr0+ppTj0tWRNY07BaznJgmBowuChL2cfIcPEJP4aMkRAgj+XdAUF
    HymfjfITrO1RmA5DKAM2Vo19NU9AU1py2y8Zuf7FUVtUsI4nUEhNz1qSNVUSPOyR
    KrKVIhdN/rwV2495tIeq1ZaSP6iFUdL/uou7FuhOgHQZ5H5JM8q2fI2fT6cF3idx
    Ex5HegjzwDbCM1vvNRu4oIyh8z+kqp/y/fkkyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519750953; bh=1zhKBBnT2cyt5XtGq+cyLdOozJ
    Z3MYyA1XrRnGNPTnc=; b=hzj6lZxw9CEDq+g4HTYPCA+NTvXbCvo5lSbhRZqZaj
    amhq7r99bklBXi8jBOmTHZN8NXb4e6O6Mwwy2edNSoppaSfApD636ordVSC64PA0
    Al7SZ1ZSqfzIPyDNFIEhtCFvyKHzNZbScEaNyitp5OS2FzGttek/4CXquM4yMVnt
    ZSU5Sl1kktc7/5Qq4Dsg7wtZsbN1+l1ozpS5hrg0HTfLQ9RPHn8nZL9PaQtpgf8X
    9xLXzdWQGlDpgcx7/0Hf+hoAOuNV7bcgh3Mf9TCuLgimEULV4qGy6pyEMQcCkjvZ
    VmUtrfJ4c5kHYkS2rqrF33AtgDnB0bQGmU1ECJ9F8cUA==
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
        id S1752183AbeB0RCV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 12:02:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:47361 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750997AbeB0RCT (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 27 Feb 2018 12:02:19 -0500
Date: Tue, 27 Feb 2018 18:02:16 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Jan Kara <jack@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v4 06/12] ext2, dax: replace IS_DAX() with IS_FSDAX()
Message-ID: <20180227170216.ubyy676wfniztvx2@quack2.suse.cz>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151970522696.26729.5581903247926963915.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151970522696.26729.5581903247926963915.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 26-02-18 20:20:27, Dan Williams wrote:
> In preparation for fixing the broken definition of S_DAX in the
> CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y case, convert all IS_DAX() usages to
> use explicit tests for FSDAX since DAX is ambiguous.
> 
> Cc: Jan Kara <jack@suse.com>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  fs/ext2/file.c  |    6 +++---
>  fs/ext2/inode.c |    6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> 
> diff --git a/fs/ext2/file.c b/fs/ext2/file.c
> index 5ac98d074323..702a36df6c01 100644
> --- a/fs/ext2/file.c
> +++ b/fs/ext2/file.c
> @@ -119,7 +119,7 @@ static const struct vm_operations_struct ext2_dax_vm_ops = {
>  
>  static int ext2_file_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	if (!IS_DAX(file_inode(file)))
> +	if (!IS_FSDAX(file_inode(file)))
>  		return generic_file_mmap(file, vma);
>  
>  	file_accessed(file);
> @@ -158,14 +158,14 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  
>  static ssize_t ext2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
> -	if (IS_DAX(iocb->ki_filp->f_mapping->host))
> +	if (IS_FSDAX(iocb->ki_filp->f_mapping->host))
>  		return ext2_dax_read_iter(iocb, to);
>  	return generic_file_read_iter(iocb, to);
>  }
>  
>  static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
> -	if (IS_DAX(iocb->ki_filp->f_mapping->host))
> +	if (IS_FSDAX(iocb->ki_filp->f_mapping->host))
>  		return ext2_dax_write_iter(iocb, from);
>  	return generic_file_write_iter(iocb, from);
>  }
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index e04295e99d90..72284f9fd034 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -733,7 +733,7 @@ static int ext2_get_blocks(struct inode *inode,
>  		goto cleanup;
>  	}
>  
> -	if (IS_DAX(inode)) {
> +	if (IS_FSDAX(inode)) {
>  		/*
>  		 * We must unmap blocks before zeroing so that writeback cannot
>  		 * overwrite zeros with stale data from block device page cache.
> @@ -940,7 +940,7 @@ ext2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  	loff_t offset = iocb->ki_pos;
>  	ssize_t ret;
>  
> -	if (WARN_ON_ONCE(IS_DAX(inode)))
> +	if (WARN_ON_ONCE(IS_FSDAX(inode)))
>  		return -EIO;
>  
>  	ret = blockdev_direct_IO(iocb, inode, iter, ext2_get_block);
> @@ -1294,7 +1294,7 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
>  
>  	inode_dio_wait(inode);
>  
> -	if (IS_DAX(inode)) {
> +	if (IS_FSDAX(inode)) {
>  		error = iomap_zero_range(inode, newsize,
>  					 PAGE_ALIGN(newsize) - newsize, NULL,
>  					 &ext2_iomap_ops);
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
