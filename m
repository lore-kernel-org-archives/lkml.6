Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3238303-1520554854-2-4599666704829636593
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520554853; b=OCgOWIuJ91pNd4KugDskol2mM2V2qJT1hdTO2DsrAmPkfIJ
    64FO/u2QWZXCQ6QzJFVBfm267CBE8i7GnNX328wmwc5DNZxYEnX+FUihEeRjJ8Lz
    0jM7fsvS91lhyFREm+Tb1K6fUgYkhY6Bb+F3N+WOib+IRMR32bxBl9zL8d0S94A7
    muCD7GMjK2aOxTYmO3YZ8aw4qvnfhQiNgDpJ9E/Bt4wtE6mnRym3cJpW+X95pQsQ
    pSuIgOXPsnTchajmCu9WP5a19ATGwgyByAckeNqpaSRNwUdJbQ/9A7vwGGNq0qmR
    a+A5Pf9rmQPEJI/outfrOxs1JRY4xbNzcuriHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520554853; bh=U94dr1JwP1TVWDYdXhXKm12jxH
    j11rAlrv3SuZ5x31s=; b=A2fZGlgPY0wp67JdQQ7a78Cq1vVVuFiQM3NpruY/iG
    +sDZvpEfGp66R7Oh7Pul2SRo5XsNB+jeE1ei1RJeshQdc0BmDfhlv6zDuGd+wnrn
    Oys7QRXT+TLoStOcByA6TATfW59+pZ38um6qsVZxOXzGweStEI+qU/wjRa2WHbo7
    Pomdya2dihE8YkY/mk0iBgzDXs4OVCwHWRhWMZh7moAemhB3YlNPAudgvOaXcLkn
    cw6MVhIP2Q15lsCenEyQVsWc6tdP1aTHz6c3w+b5oQ0ppcdTp9pNrQ/6UUQ9yIPM
    gm6UlmFCO5kElh+pLh46XO/X6gA2Vn1nX0ljdM2VUicg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeCIAUu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 19:20:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:2417 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751215AbeCIAUt (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 19:20:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="23166131"
Date: Thu, 8 Mar 2018 17:20:48 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] loop: Fix lost writes caused by missing flag
Message-ID: <20180309002048.GA22835@linux.intel.com>
References: <20180212230558.5546-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212230558.5546-1-ross.zwisler@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This has gotten Reviewed-by tags from Christoph and Ming Lei.

Al, are you the right person to merge this?  Or is the correct person Jens,
whom I accidentally didn't include when I sent this out?

Just wanted to make sure this got merged, and to see whether it was targeting
v4.16 or v4.17.

Thanks,
- Ross

On Mon, Feb 12, 2018 at 04:05:58PM -0700, Ross Zwisler wrote:
> The following commit:
> 
> commit aa4d86163e4e ("block: loop: switch to VFS ITER_BVEC")
> 
> replaced __do_lo_send_write(), which used ITER_KVEC iterators, with
> lo_write_bvec() which uses ITER_BVEC iterators.  In this change, though,
> the WRITE flag was lost:
> 
> -       iov_iter_kvec(&from, ITER_KVEC | WRITE, &kvec, 1, len);
> +       iov_iter_bvec(&i, ITER_BVEC, bvec, 1, bvec->bv_len);
> 
> This flag is necessary for the DAX case because we make decisions based on
> whether or not the iterator is a READ or a WRITE in dax_iomap_actor() and
> in dax_iomap_rw().
> 
> We end up going through this path in configurations where we combine a PMEM
> device with 4k sectors, a loopback device and DAX.  The consequence of this
> missed flag is that what we intend as a write actually turns into a read in
> the DAX code, so no data is ever written.
> 
> The very simplest test case is to create a loopback device and try and
> write a small string to it, then hexdump a few bytes of the device to see
> if the write took.  Without this patch you read back all zeros, with this
> you read back the string you wrote.
> 
> For XFS this causes us to fail or panic during the following xfstests:
> 
> 	xfs/074 xfs/078 xfs/216 xfs/217 xfs/250
> 
> For ext4 we have a similar issue where writes never happen, but we don't
> currently have any xfstests that use loopback and show this issue.
> 
> Fix this by restoring the WRITE flag argument to iov_iter_bvec().  This
> causes the xfstests to all pass.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Fixes: commit aa4d86163e4e ("block: loop: switch to VFS ITER_BVEC")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: stable@vger.kernel.org
> ---
>  drivers/block/loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d5fe720cf149..89d2ee00cced 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -266,7 +266,7 @@ static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
>  	struct iov_iter i;
>  	ssize_t bw;
>  
> -	iov_iter_bvec(&i, ITER_BVEC, bvec, 1, bvec->bv_len);
> +	iov_iter_bvec(&i, ITER_BVEC | WRITE, bvec, 1, bvec->bv_len);
>  
>  	file_start_write(file);
>  	bw = vfs_iter_write(file, &i, ppos, 0);
> -- 
> 2.14.3
> 
