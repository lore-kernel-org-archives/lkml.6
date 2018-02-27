Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1988021-1519750852-2-5358992488444448427
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
    t=1519750852; b=XkAnEbnFcCzuHwm9c2YIgjcoy3Xz1JJyFZkWksFS/qijlDR
    jG87/MVwSbeoyKXuPwjxyYfyHNZBQLmYWYylNgCoaSg/nKOOdT8jLCzPLbVk/is7
    Uy5M9JbeovUdNvtHGACtbKAyy32jym2tQnsS6PwWYePmZSYjVeI4aY5dEKhKRUL2
    i0EYrLYlenqHDlR1jYSO7ak6F7JuYt1KUYtRwTPdq14epc4Vh4LXsg2fRUJgnwz9
    UJHv0pLinKJ7z34YeaOsSA2Y2R7C7afsTJfk1JLu3qWFWxF+l9hYd8QNrLBBgEBG
    rbxNjpE/EnCTQr3qyWceH+pgdmfMq47U5gqWxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519750852; bh=ZCVFn7pMEdUucKz3KJh5ngUMzX
    aOoji44lDRhDp5psE=; b=L3saWzRr8xs4uOBbekNVLxUP/igtxuwNtLCL+hSyA/
    sBuNCk9sSx8RqlZeFaKqBW25ord7QuXB1pgylAoLICJqoFdP8I8u6P6zbwFsgz2k
    eCccjZilO3AiR4ym60vgEIwQt0UfbSnQOhBCT6Kuo+mBWZg0v0fiXCnoXMAqE62A
    dEqz4BT+LM8Z3AxCZsxoYY/zAFf1x3Rap8jlXd7VdPFRGsf9uIuign0aS1e0jeq2
    w7801dzPoIJnSyuvWemUe78lovHBqMCU2kFHLiUbAUJ8suR7QVj8IisXURH5ZqiI
    YnxOL8TkMf6dUTuYppYOpfpb2/KdRYC4SvRFgABQ6DVA==
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
        id S1751962AbeB0RAf (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 12:00:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:47230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751735AbeB0RAe (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 27 Feb 2018 12:00:34 -0500
Date: Tue, 27 Feb 2018 18:00:31 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH v4 03/12] ext2, dax: finish implementing dax_sem helpers
Message-ID: <20180227170031.lgf5tc3vt3umrwbb@quack2.suse.cz>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151970521121.26729.7741760690622342144.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151970521121.26729.7741760690622342144.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 26-02-18 20:20:11, Dan Williams wrote:
> dax_sem_{up,down}_write_sem() allow the ext2 dax semaphore to be compiled
> out in the CONFIG_FS_DAX=n case. However there are still some open coded
> uses of the semaphore. Add dax_sem_{up_read,down_read,_is_locked}()
> helpers and convert all open-coded usages of the semaphore to the
> helpers.

Just one nit below. With that fixed you can add:

Reviewed-by: Jan Kara <jack@suse.cz>

> Cc: Jan Kara <jack@suse.com>
> Cc: <stable@vger.kernel.org>
> Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  fs/ext2/ext2.h  |    6 ++++++
>  fs/ext2/file.c  |    5 ++---
>  fs/ext2/inode.c |    4 +---
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index 032295e1d386..7ceb29733cdb 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -711,9 +711,15 @@ struct ext2_inode_info {
>  #ifdef CONFIG_FS_DAX
>  #define dax_sem_down_write(ext2_inode)	down_write(&(ext2_inode)->dax_sem)
>  #define dax_sem_up_write(ext2_inode)	up_write(&(ext2_inode)->dax_sem)
> +#define dax_sem_is_locked(ext2_inode)	rwsem_is_locked(&(ext2_inode)->dax_sem)
> +#define dax_sem_down_read(ext2_inode)	down_read(&(ext2_inode)->dax_sem)
> +#define dax_sem_up_read(ext2_inode)	up_read(&(ext2_inode)->dax_sem)
>  #else
>  #define dax_sem_down_write(ext2_inode)
>  #define dax_sem_up_write(ext2_inode)
> +#define dax_sem_is_locked(ext2_inode)	(true)

This is a bit dangerous as depending on the use of dax_sem_is_locked()
you'd need this to return true or false. E.g. assume we'd have a place
where we'd like to do:

	WARN_ON(dax_sem_is_locked(inode));

or just

	if (dax_sem_is_locked(inode))
		bail out due to congestion...

How I'd solve this is that I'd define:

#define assert_dax_sem_locked(ext2_inode) WARN_ON(rwsem_is_locked(&(ext2_inode)->dax_sem)

and just as do {} while (0) for !CONFIG_FS_DAX.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
