Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1993284-1519750981-2-7535130452371679820
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519750980; b=nM5pPl/psxV8ybxmC8hz31V2IQZgOHOInOZGdANeI+Ouqaw
    fNwY7m0CaCQA+0jfLE/snGW23O9/jDZv6on2G9XB/KLlU+eYTTUpULzqei2/MeHc
    ojfnx0XkaccdZKeoswwVasWxlS6G0OqEjxXCm/dXW5NWwjY1ljAiiarWkNQ4e3uB
    cQp+bcD0lhphfyXmKygGkAXxBERtIdPqgJ4KRUDeDYyE6JfE36kBtGfTyZPMl3Aa
    +2vtEjhU/mNfbImx3irwlIgIZAorqUz/FuxGaGGDdcd8WTmdQWtFA18gHHtH0SLC
    I6WhgRzFED6a7aObDnfCaRtlg8Ry0t763uVtJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519750980; bh=XlVTR7vAi1Xy403HYTQi/Mq9iD
    NHCHyGE9RmVltwqts=; b=jgiUQWlW3Qy/5dwbyo4BQzhHcNwJjyfZyjUM5U0i0R
    b46mWLdh/up6WTmGSzlDqQSc3V+AC5lmlfP34WhaoWxpquhZSZIU0FAoA/H2TKjQ
    7bK3IyFnUWFHxsZsUml2N+c9fUsORv6YQVZFxcvs19YHLiauaUXN2arNGk0dEUKC
    MgL3PPW8DYjBS6em/ygV8Elr3BZJKZS9NR9RfxltFZj+D2/hstMejAsftP7QjDT5
    XzoJ+XgURCUwdVN6RS+KltCCy/4PUb/bUtsJi1TNcKVITezOIqRafSTuiAm5GWmO
    VpWgy+8qjMSfNTVUOqRetutHY+o4pcyGwROWxqZpmy5g==
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
        id S1751907AbeB0RC5 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 12:02:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:47418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750997AbeB0RC4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 27 Feb 2018 12:02:56 -0500
Date: Tue, 27 Feb 2018 18:02:53 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v4 07/12] ext4, dax: replace IS_DAX() with IS_FSDAX()
Message-ID: <20180227170253.4p33pk3fi53w5qcl@quack2.suse.cz>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151970523209.26729.7690806551692959424.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151970523209.26729.7690806551692959424.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 26-02-18 20:20:32, Dan Williams wrote:
> In preparation for fixing the broken definition of S_DAX in the
> CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y case, convert all IS_DAX() usages to
> use explicit tests for FSDAX since DAX is ambiguous.
> 
> Cc: Jan Kara <jack@suse.com>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/file.c  |   12 +++++-------
>  fs/ext4/inode.c |    4 ++--
>  fs/ext4/ioctl.c |    2 +-
>  fs/ext4/super.c |    2 +-
>  4 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 51854e7608f0..561ea843b458 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -48,7 +48,7 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	 * Recheck under inode lock - at this point we are sure it cannot
>  	 * change anymore
>  	 */
> -	if (!IS_DAX(inode)) {
> +	if (!IS_FSDAX(inode)) {
>  		inode_unlock_shared(inode);
>  		/* Fallback to buffered IO in case we cannot support DAX */
>  		return generic_file_read_iter(iocb, to);
> @@ -68,7 +68,7 @@ static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	if (!iov_iter_count(to))
>  		return 0; /* skip atime */
>  
> -	if (IS_DAX(file_inode(iocb->ki_filp)))
> +	if (IS_FSDAX(file_inode(iocb->ki_filp)))
>  		return ext4_dax_read_iter(iocb, to);
>  	return generic_file_read_iter(iocb, to);
>  }
> @@ -216,10 +216,8 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
>  		return -EIO;
>  
> -#ifdef CONFIG_FS_DAX
> -	if (IS_DAX(inode))
> +	if (IS_FSDAX(inode))
>  		return ext4_dax_write_iter(iocb, from);
> -#endif
>  	if (!o_direct && (iocb->ki_flags & IOCB_NOWAIT))
>  		return -EOPNOTSUPP;
>  
> @@ -361,11 +359,11 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	 * We don't support synchronous mappings for non-DAX files. At least
>  	 * until someone comes with a sensible use case.
>  	 */
> -	if (!IS_DAX(file_inode(file)) && (vma->vm_flags & VM_SYNC))
> +	if (!IS_FSDAX(file_inode(file)) && (vma->vm_flags & VM_SYNC))
>  		return -EOPNOTSUPP;
>  
>  	file_accessed(file);
> -	if (IS_DAX(file_inode(file))) {
> +	if (IS_FSDAX(file_inode(file))) {
>  		vma->vm_ops = &ext4_dax_vm_ops;
>  		vma->vm_flags |= VM_MIXEDMAP | VM_HUGEPAGE;
>  	} else {
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c94780075b04..1879b33aa391 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3858,7 +3858,7 @@ static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  		return 0;
>  
>  	/* DAX uses iomap path now */
> -	if (WARN_ON_ONCE(IS_DAX(inode)))
> +	if (WARN_ON_ONCE(IS_FSDAX(inode)))
>  		return 0;
>  
>  	trace_ext4_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
> @@ -4076,7 +4076,7 @@ static int ext4_block_zero_page_range(handle_t *handle,
>  	if (length > max || length < 0)
>  		length = max;
>  
> -	if (IS_DAX(inode)) {
> +	if (IS_FSDAX(inode)) {
>  		return iomap_zero_range(inode, from, length, NULL,
>  					&ext4_iomap_ops);
>  	}
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 7e99ad02f1ba..040fc6570ddb 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -790,7 +790,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  				 "Online defrag not supported with bigalloc");
>  			err = -EOPNOTSUPP;
>  			goto mext_out;
> -		} else if (IS_DAX(inode)) {
> +		} else if (IS_FSDAX(inode)) {
>  			ext4_msg(sb, KERN_ERR,
>  				 "Online defrag not supported with DAX");
>  			err = -EOPNOTSUPP;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 39bf464c35f1..933e12940181 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1161,7 +1161,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
>  	if (inode->i_ino == EXT4_ROOT_INO)
>  		return -EPERM;
>  
> -	if (WARN_ON_ONCE(IS_DAX(inode) && i_size_read(inode)))
> +	if (WARN_ON_ONCE(IS_FSDAX(inode) && i_size_read(inode)))
>  		return -EINVAL;
>  
>  	res = ext4_convert_inline_data(inode);
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
