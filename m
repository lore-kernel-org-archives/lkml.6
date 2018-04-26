Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2746918-1524757323-2-2127826104265935148
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524757323; b=S8bDik9CY14FZOf+GEQQuRpjWiUYUwBRmo5VpcEHpf3Btm5v7/
    UnGlmIO0jf60rjaYOpxJ3DGNW1dzWOo5aBVBlo5Be+FVz67JUNnI2uFSeGvT5WyR
    aYaeqxR4i7G4WRZNoLrlIvjg/voUt40ogQWt/luyKbQwIx6Z92wPLF6+dlleiYn9
    rJlw8W6hu6t0vi0HpUJ2hQQid+382VT4hvU5Hp2IItXVPLpsfiZ6aNQw/sLj/9f+
    f3hTa167X9+yqAnP73QsUSlr+Rj9m+V9gcEZ6C6vuEx++he8NDBJlTS+ALHFk6iJ
    Hf9vrb8N3ALFQkKYkIt48YjmgVvSaf/lwWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524757323; bh=kHAj1gBOP/kqfYVjf4D5YZA99nBXLB
    I4FbQk7wXMWYo=; b=BtUtx83mcFhtdAT5+jsmIbdXXH/awjKRlEU35R4Y4GMhgK
    M8gMa2w+UUqA13X8E7U6dHDTx3msJt/++55nGwT63XoZJBo+CONDWEnIuFYXJGji
    HVJOZCjJSqD5TG44H7P3b+LbDiA639t1mzA3KNCVSC2iqKcjN9tACtmo4yl+ycCc
    gbv1Xbvtc2DEKRWp+NauRlU6fSEuMtH3NsPXgH6utmJR7eg0usvqfiCjlX4qeyoC
    FM56Z839sscWgsoDTsulIAGKPKzaBE5R+40Xfp+uLidirHagIGUeS3q/5/4VQPQR
    kqqn15URZLrs6SwksQ0L2mD464vfRZtODE1qirlg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Aodivwri x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Aodivwri x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfODmmVpcYp5RaBVtU/Aw3bGqIXOHHQnfhQqe2CEGl6EFDeVlv98sJ1BzXq87WuV68LBFMIwYNn5YY9l9/alDgvTq6vEDrkzci5S3syObatTvpR8ssz6Y
    or1H6dFUe3LYT7k2tVSRTz9I/8cIrfFlyeU/LLwNdGhfBGgtjqJDKl5LI9jt1eZMixv68RFAFq+YxwkZUXIr9Y0LQu06awIcIVfaK5izzwTN8IN3XMS8AaY6
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Dq04FmDg5MZ4D2MopJgA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755998AbeDZPmB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 11:42:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52084 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755709AbeDZPmA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Apr 2018 11:42:00 -0400
Date: Thu, 26 Apr 2018 08:41:52 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] aio: remove the extra get_file/fput pair in
 io_submit_one
Message-ID: <20180426154152.GB26258@magnolia>
References: <20180415150108.1341-1-hch@lst.de>
 <20180415150108.1341-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415150108.1341-5-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8875 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804260148
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 15, 2018 at 05:01:05PM +0200, Christoph Hellwig wrote:
> If we release the lockdep write protection token before calling into
> ->write_iter and thus never access the file pointer after an -EIOCBQUEUED
> return from ->write_iter or ->read_iter we don't need this extra
> reference.

Hmm, subtleties lurk to this unfamiliar reader...

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/aio.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 18507743757a..d7be32cdd1db 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1515,16 +1515,17 @@ static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
>  		return ret;
>  	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
>  	if (!ret) {
> -		req->ki_flags |= IOCB_WRITE;
> -		file_start_write(file);
> -		ret = aio_ret(req, call_write_iter(file, req, &iter));
>  		/*
>  		 * We release freeze protection in aio_complete().  Fool lockdep
>  		 * by telling it the lock got released so that it doesn't
>  		 * complain about held lock when we return to userspace.
>  		 */
> -		if (S_ISREG(file_inode(file)->i_mode))
> +		if (S_ISREG(file_inode(file)->i_mode)) {
> +			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);

It took me a while to figure out that this ^^^ is the same as the
file_start_write call that you remove above, can you please update the
comment to note that we take freeze protection for the file before
screwing with lockdep? e.g.,

/*
 * Open-code file_start_write here to grab freeze protection, which will
 * be released by another thread in aio_complete().  Fool lockdep by
 * telling it the lock got released so that it doesn't complain about
 * held lock when we return to userspace.
 */

>  			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> +		}
> +		req->ki_flags |= IOCB_WRITE;
> +		ret = aio_ret(req, call_write_iter(file, req, &iter));
>  	}
>  	kfree(iovec);
>  	return ret;
> @@ -1599,7 +1600,6 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  	req->ki_user_iocb = user_iocb;
>  	req->ki_user_data = iocb->aio_data;
>  
> -	get_file(file);

Here we have a reference to *file, but...

>  	switch (iocb->aio_lio_opcode) {
>  	case IOCB_CMD_PREAD:
>  		ret = aio_read(&req->common, iocb, false, compat);
> @@ -1618,7 +1618,6 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  		ret = -EINVAL;
>  		break;
>  	}
> -	fput(file);

...by the time we get to here the reference may have gone away, but
you'd have to dig through aio_{read,write} -> call_{r,w}_iter ->
{r,w}_iter in order to figure out that the reference isn't valid
anymore on a EIOCBQUEUED return.

That's a little subtle, can you add a comment about that?

/*
 * If ret is EIOCBQUEUED here, the ->read_iter/->write_iter dropped the
 * reference on *file.  We don't ourselves ensure a reference to the
 * file, so we must be careful about that here and in the subfunctions.
 */

--D

>  
>  	if (ret && ret != -EIOCBQUEUED)
>  		goto out_put_req;
> -- 
> 2.17.0
> 
