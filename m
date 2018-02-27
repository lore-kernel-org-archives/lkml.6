Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1993284-1519750904-2-11180684237382591450
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
    t=1519750903; b=FCHnBfhk9eC/CtQXi+rgz+kPnb3qDuKhOeh1awitxHdfw3X
    Wyzvh75VHuDs+jgWOuD8F++DxbMepfuXNNs7kN9Aud0PLhh0ii1Jgm1DnHkviCiT
    S5UVGOW4FH1kfLrGONYQ/ikaGtV1MyOnZf9qF6LMfw/z0deh9theTXh6YB0UEiGB
    BgS75az8/0BTusCU+4iFq+w9BV1+glE9dLiBi46Q1F0oqb6N91mmKYyi2Np02081
    BuIWFlzHVadOD64c0q8ajdVyXXx8J3KPvBiAxtDovpwnKKXuau1W87HrC9sF3IXg
    6Ee86/4f8NleukyjohUyUMYdT/sohIBPUfsDbPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519750903; bh=mThZ3It7U6iJkeMa507g/xaPCm
    bVy3s8fvZm6rrRbP8=; b=DzhUAs2QlVquV0WrNskRI0BU43Kb/YBJbqzNlU3sd/
    qO94MAGUJs6ouSmiyC/pK48wUBUt4H6KxGZELFhjMg+kGKGuJKe9p0Z/AVjrUviJ
    lDjb1gBCE9yaISaf3B3RNHdVXJPOYkDO15J1nGX1jpa4eeAwXhBt+nkJA23TfPpV
    sukmEXHuDIBSI3bkI9IwUSNkVk1FA73ZfeHPG2FUUigxlhQaOI82Q9/Z6nA0c4wK
    NIA0jqG/oigyS88yUYdrGCBoFk8ZSd7Pw9gNtYyfuorHGezOaRuuYtK4gF2teMoy
    mDeYAfR9SSICqEe2lWLb/p660hjdPbyIq7XOM2hmzOYA==
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
        id S1751804AbeB0RBl (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 12:01:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:47317 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751654AbeB0RBk (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 27 Feb 2018 12:01:40 -0500
Date: Tue, 27 Feb 2018 18:01:38 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH v4 05/12] ext4, dax: define ext4_dax_*() infrastructure
 in all cases
Message-ID: <20180227170138.3tdjcf7w6duc2ggb@quack2.suse.cz>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151970522183.26729.1211859822335015752.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151970522183.26729.1211859822335015752.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 26-02-18 20:20:21, Dan Williams wrote:
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
>  fs/ext4/file.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index fb6f023622fe..51854e7608f0 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -34,7 +34,6 @@
>  #include "xattr.h"
>  #include "acl.h"
>  
> -#ifdef CONFIG_FS_DAX
>  static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
>  	struct inode *inode = file_inode(iocb->ki_filp);
> @@ -60,7 +59,6 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	file_accessed(iocb->ki_filp);
>  	return ret;
>  }
> -#endif
>  
>  static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
> @@ -70,10 +68,8 @@ static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	if (!iov_iter_count(to))
>  		return 0; /* skip atime */
>  
> -#ifdef CONFIG_FS_DAX
>  	if (IS_DAX(file_inode(iocb->ki_filp)))
>  		return ext4_dax_read_iter(iocb, to);
> -#endif
>  	return generic_file_read_iter(iocb, to);
>  }
>  
> @@ -179,7 +175,6 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>  	return iov_iter_count(from);
>  }
>  
> -#ifdef CONFIG_FS_DAX
>  static ssize_t
>  ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
> @@ -208,7 +203,6 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ret = generic_write_sync(iocb, ret);
>  	return ret;
>  }
> -#endif
>  
>  static ssize_t
>  ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
