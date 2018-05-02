Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1424822-1525298709-2-18024770014730434972
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
    1525298709; b=OueMzz1n8VJQxQT8Hn2ogjy4FI9eg7ZUXbdvB19oyVriswYAkc
    Vzlt7Krd94fvbeDqhH2LuT7Wi8zFMZp5kfffrjC1pJhtuJ8LkEICZqLq0Afo3Ncl
    BlHsdFf5Mu23jAtRHivvCN1iW/+/ysYl7SmYJii+1TkGdIn0MaD+C8dAo8X8uY6i
    rolCwzk1N8tCVlvVLcb5yYT+XkywtEe9dwDTwcT80IFWy0JWSsye8IkoN++T4E+Y
    FG7OX5QVf7QU5hCL5CoosOBgbZbKAbX2LVSPytfDsBIZ558InYWfEhLu7t0XON6k
    mocLEgz3r4r4ZDp4If6THrgj5bq2VnNZr3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525298709; bh=/jlX+o0DDyqsSziWishKoQWC599q6x
    LZxkrpiImeF1M=; b=CNO5bFybghqz11ZbhQVN1MaCnkSQ4i4BhUi0OKSWfPnucL
    BWMVt3xRqcBhlk6hNHmEU1R0k/QdrFgVx1SrHfataXl40KQrE4rLVU5X85Xg7pbn
    af+22GjGDlPHg0DJrD79Q8ylE4n0HN3xJptOZl6maGdIFyVXH5yT+D5GgRwdR1IF
    ox3jSgblRUWOMrYaf7axtWB4/OHGiU/mjApVyalr3BnZGboNdl/hyb/H5Oyo0J/h
    M58Dormc6qIxslQtuseQRRMVaq9prb4Pw5LvgMp07MCuj/YRU+GpwFg+tB7/CJ90
    CZSQsjPfrp9SDfnoOPEYtNM8BL0dg5aCbdBMBWdg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=vOLHhlu6 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=vOLHhlu6 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOO+igN6HeTJjL/cuvVJQ1/YMVdXRwmQOAdWPdfMD+N2fWksCNLwkE6USYG42WGxr2Ke7HAcdMv8GxCaZl+6hpn+v7Icj9nhabRNi1tVq81lFg0v+57n
    sKwM+v+nXAiFpsFdRjEKnoC7sdO40XNEEsBvSD1FWln3axkyNNFB2wIqEC/GJ29ZRy8e7ewhm21qoYCX8j5bNTxIH3Iscd7M9LplQmAg6WIr4haS83Wy1e3Z
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=Ua4lRIThFaeybDTNelYA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeEBWFH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 18:05:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54554 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbeEBWFG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 18:05:06 -0400
Date: Wed, 2 May 2018 15:04:57 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] aio: remove the extra get_file/fput pair in
 io_submit_one
Message-ID: <20180502220457.GB4116@magnolia>
References: <20180502211448.18276-1-hch@lst.de>
 <20180502211448.18276-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502211448.18276-5-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805020183
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 11:14:45PM +0200, Christoph Hellwig wrote:
> If we release the lockdep write protection token before calling into
> ->write_iter and thus never access the file pointer after an -EIOCBQUEUED
> return from ->write_iter or ->read_iter we don't need this extra
> reference.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/aio.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 18507743757a..e5866e2fc331 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1515,16 +1515,19 @@ static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
>  		return ret;
>  	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
>  	if (!ret) {
> -		req->ki_flags |= IOCB_WRITE;
> -		file_start_write(file);
> -		ret = aio_ret(req, call_write_iter(file, req, &iter));
>  		/*
> -		 * We release freeze protection in aio_complete().  Fool lockdep
> -		 * by telling it the lock got released so that it doesn't
> -		 * complain about held lock when we return to userspace.
> +		 * Open-code file_start_write here to grab freeze protection,
> +		 * which will be released by another thread in aio_complete().
> +		 * Fool lockdep by telling it the lock got released so that it
> +		 * doesn't complain about the held lock when we return to
> +		 * userspace.
>  		 */
> -		if (S_ISREG(file_inode(file)->i_mode))
> +		if (S_ISREG(file_inode(file)->i_mode)) {
> +			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
>  			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> +		}
> +		req->ki_flags |= IOCB_WRITE;
> +		ret = aio_ret(req, call_write_iter(file, req, &iter));
>  	}
>  	kfree(iovec);
>  	return ret;
> @@ -1599,7 +1602,6 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  	req->ki_user_iocb = user_iocb;
>  	req->ki_user_data = iocb->aio_data;
>  
> -	get_file(file);
>  	switch (iocb->aio_lio_opcode) {
>  	case IOCB_CMD_PREAD:
>  		ret = aio_read(&req->common, iocb, false, compat);
> @@ -1618,8 +1620,13 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  		ret = -EINVAL;
>  		break;
>  	}
> -	fput(file);
>  
> +	/*
> +	 * If ret is -EIOCBQUEUED, ownership of the file reference acquired
> +	 * above passed to the file system, which at this point might have
> +	 * dropped the reference, so we must be careful to not reference it
> +	 * once we have called into the file system.
> +	 */
>  	if (ret && ret != -EIOCBQUEUED)
>  		goto out_put_req;
>  	return 0;
> -- 
> 2.17.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-api" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
