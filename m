Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2432626-1519638287-2-13862697940229902188
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519638286; b=JkbDr2fJLtxxzlwX0dcUnsfnGfqQDBrDVvofD37trilO5I+
    gKdvKEZRLIftIUF1uXy+fiezjzgBm9HhrvJ5IyI25FygkF3F8Qr//0MoguEgYQnO
    yaxQPqfsaiaIrn4hcsUUBSnoT2aJcT/RebofjBoNHQyFdK2w9/MhMW2sNm53ypLr
    zwUGetNtt3MZ2cxUPyUCnTFSSij2EnTg2V2uWi7j/t5rRHClNsEhPH5aSO+dRJl8
    SWyGECB1Ue8I8Zem4OW1xN2T8ta4gcUfWUNs4JtyWrufra5f4dSzDnFMNpzGCBX4
    jKdmGCXThpo3XWbSVnBUNY0INpUtD1gTiYGHxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519638286; bh=IhzyJFvgGrhuYdCJjJTbOmWjg5
    EEaeHCmfhglVYvDqQ=; b=CUevNeBjxidqnp9P5tnCza1BiOqWsP/sQbAntOzQM9
    Q3yf1SIwsKmmwzU3sCUEsLYKHtqaTU5UCCvuUOPlTJtnPpZd7GmwO02UuUGFp1BS
    wJFyO5DyQOjSLIuHRr1nataRq9kwNE2cQsTGQrZiYaOJElR9DNOKdAqUE/J2Fgbw
    8nkhfDB1433jA50wkanQnTFImYZNeT9+gel13wVYjiR3a2M1+T9NZ4MJPixnomMx
    2LhpVoI8jjhm+oUqY9wOxMyataXmGbZIN+Y771pd6vhAyuypAUmgA1lp87faXXHN
    5vZvFka4znAFRfRB8QpOPu96Hgx5Az8fIvzK1PpA2tEQ==
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
        id S1752297AbeBZJob (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 04:44:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:51431 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbeBZJoa (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 04:44:30 -0500
Date: Mon, 26 Feb 2018 10:44:28 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/5] dax: fix dax_mapping() definition in the FS_DAX=n
 + DEV_DAX=y case
Message-ID: <20180226094428.awvicgxhohj4ezpq@quack2.suse.cz>
References: <151937026001.18973.12034171121582300402.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151937027102.18973.18360014199243139223.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151937027102.18973.18360014199243139223.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 22-02-18 23:17:51, Dan Williams wrote:
> An address_space will only have dax exceptional entries when FS_DAX is
> enabled. The current reliance on S_DAX causes compile failures when
> S_DAX is defined for DEV_DAX, but FS_DAX is disabled. Make dax_mapping()
> always return false so that mm/truncate.c drops its link time
> dependencies on fs/dax.c.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jan Kara <jack@suse.cz>
> Cc: <stable@vger.kernel.org>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/dax.h |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 0185ecdae135..62e8cf7eb566 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -107,6 +107,10 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  int __dax_zero_page_range(struct block_device *bdev,
>  		struct dax_device *dax_dev, sector_t sector,
>  		unsigned int offset, unsigned int length);
> +static inline bool dax_mapping(struct address_space *mapping)
> +{
> +	return mapping->host && IS_DAX(mapping->host);
> +}
>  #else
>  static inline int __dax_zero_page_range(struct block_device *bdev,
>  		struct dax_device *dax_dev, sector_t sector,
> @@ -114,12 +118,11 @@ static inline int __dax_zero_page_range(struct block_device *bdev,
>  {
>  	return -ENXIO;
>  }
> -#endif
> -
>  static inline bool dax_mapping(struct address_space *mapping)
>  {
> -	return mapping->host && IS_DAX(mapping->host);
> +	return false;
>  }
> +#endif
>  
>  struct writeback_control;
>  int dax_writeback_mapping_range(struct address_space *mapping,
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
