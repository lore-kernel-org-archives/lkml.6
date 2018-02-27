Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1988021-1519751259-2-4787518231127782445
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519751258; b=tJQ9979cuPlK9qyNEF1v0Y733VceAbEwBklKxyeWD/6OVak
    362dkz6nvPV/q+JeCKrkzqj5gBkWyCfG3rTVF8MQSEQ2VA0kAzQ5uZhQ66Nagz1h
    BHnNM9n495PMNK5UgqYbcM1dqsksVjqbIyX+Qab/2GSev49CURIkexp6RmCDAFdS
    xTajU2iYzGZZOvg0aku/k17ziAtgRmWa9jQm3Jl725+TfJKzXqbr5QuvmwU3Fzz4
    Lt5QaOlsNyfEjZAIGZ2gnmqQZ1OUMKWR5t8lvlw7ldnAv5Ppo0F4WNN5Q4WKB3o1
    Fu3vP9wCqO2zZJsu7KEoPyQp1ifiOk0oyxgjt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519751258; bh=04ANkSF+hg6m0gZJgtO39J9f8v
    wtzds3oU3eXjbEobg=; b=MBGDZJGLNBvWR1cUOmlikKWu1yPb8O0jyCSG+n+z81
    bX7RgiNRzyWxhvtxipa8i+0Un4wWOxKABc5wyUsw+VFtDeCfELtdB5RgyiUYHI0Y
    cwk60kwQAoEv1EzDUcXTG54+LqaeII7cgiIZ6OtG05FNHdR9aqF98iF4UfjjRL+y
    idmdB1rqhlL19FCAieTETjJtM0OR34Q+QjZBFFG4UP4UCttaCrsnBvWHGDwkvDQP
    nyN4hnUNsxiXbeLSQWdfTh1UmQW04ojfpZ13b+6CmZZHDd9Ls7fpTe5GBb5puAfF
    +Ih64Hs1M9+p+TzwOyvqlLMRciGfUkWerxrt3Xclj8pA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeB0RGc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 12:06:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:47730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751818AbeB0RGb (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 27 Feb 2018 12:06:31 -0500
Date: Tue, 27 Feb 2018 18:06:29 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Jan Kara <jack@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v4 10/12] fs, dax: kill IS_DAX()
Message-ID: <20180227170629.t54gjterrprylp3w@quack2.suse.cz>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151970524837.26729.14336810163194275690.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151970524837.26729.14336810163194275690.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 26-02-18 20:20:48, Dan Williams wrote:
> In preparation for fixing the broken definition of S_DAX in the
> CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y case, convert all the remaining
> IS_DAX() usages to use explicit tests for FSDAX.
> 
> Cc: Jan Kara <jack@suse.com>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/iomap.c          |    2 +-
>  include/linux/dax.h |    2 +-
>  include/linux/fs.h  |    3 +--
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap.c b/fs/iomap.c
> index afd163586aa0..fe379d8949fd 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -377,7 +377,7 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
>  		offset = pos & (PAGE_SIZE - 1); /* Within page */
>  		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
>  
> -		if (IS_DAX(inode))
> +		if (IS_FSDAX(inode))
>  			status = iomap_dax_zero(pos, offset, bytes, iomap);
>  		else
>  			status = iomap_zero(inode, pos, offset, bytes, iomap);
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 47edbce4fc52..ce520e932adc 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -124,7 +124,7 @@ static inline ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>  
>  static inline bool dax_mapping(struct address_space *mapping)
>  {
> -	return mapping->host && IS_DAX(mapping->host);
> +	return mapping->host && IS_FSDAX(mapping->host);
>  }
>  
>  struct writeback_control;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4a5aa8761011..8021f10068d3 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1903,7 +1903,6 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
>  #define IS_IMA(inode)		((inode)->i_flags & S_IMA)
>  #define IS_AUTOMOUNT(inode)	((inode)->i_flags & S_AUTOMOUNT)
>  #define IS_NOSEC(inode)		((inode)->i_flags & S_NOSEC)
> -#define IS_DAX(inode)		((inode)->i_flags & S_DAX)
>  #define IS_ENCRYPTED(inode)	((inode)->i_flags & S_ENCRYPTED)
>  
>  #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
> @@ -3203,7 +3202,7 @@ extern int file_update_time(struct file *file);
>  
>  static inline bool io_is_direct(struct file *filp)
>  {
> -	return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
> +	return (filp->f_flags & O_DIRECT) || IS_FSDAX(filp->f_mapping->host);
>  }
>  
>  static inline bool vma_is_dax(struct vm_area_struct *vma)
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
