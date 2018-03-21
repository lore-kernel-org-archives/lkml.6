Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-193552-1521649395-2-12134351670497398730
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521649394; b=oV6Ezx6hPwb+V9Whuk+E6RbKnHrIYJIUyqcJ7oC49EkCWdE
    tpDaYID2SnaB6HuILYBfDGQmzmFLoob80KNj8AhqFoORJ6cUW7AAelCxbS9veLqV
    thHNY/F4PGUC80V+3H6c/xgTRoEg8EklEmOpWgWjFeqXF27FWKxU/GT8a2K13UAg
    TTNpbkM/SLPqFN0GPaTXlvas1vLiSg7yiUee/mUqhqLg3ZW0spVGZENczKV2ONZu
    h9yg4je/utoXFBm23/x1qN4GokyrdO13TCPp0hR8UN1Yt/OGuYKOQqXFIoHeiiKk
    VhYbcN6w9b7Mz22dpk5P//J3A7kolZWroW5fKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521649394; bh=viHAdHFl4jXxuspAw9tLHquOf1
    A8mlQ4tCLdR7kIHW4=; b=sBtTKow8yQmsxDtcY+bL9USAdCDEmYqYT8uzoeToMN
    1C0Gmj4zPJl54EemwkTkTEBfqGdRmg2X7zg1RRCUGkp1/i9Q63wXAVvU3jOW2im+
    KJhoGCmQUj6w2zD0+yp6k3bV7CO3xlKV5raa/HdQQPq+EzAr/FgZW5ssV79esrAS
    kzopqWMCNfVUPKUFPWur+STTWXG/Rt+2C0COo/aaE8HMTPkZnzh8bbOQIHk/kUmj
    A55wxFjEbzIhUzejDREWsK49e82D/Mw+IfzXu+eS8YdNQMCZTLOVuYYs6dG70k+D
    IazbhsaGYV7kMUyfuGBnR+cxV7khVmeQmjhWxS9i6wuw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=C664XORB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=C664XORB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeCUQXN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 12:23:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34522 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbeCUQXK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 12:23:10 -0400
Date: Wed, 21 Mar 2018 09:23:01 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] aio: simplify cancellation
Message-ID: <20180321162301.GA4807@magnolia>
References: <20180321073232.13366-1-hch@lst.de>
 <20180321073232.13366-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321073232.13366-6-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8839 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:32:28AM +0100, Christoph Hellwig wrote:
> With the current aio code there is no need for the magic KIOCB_CANCELLED
> value, as a cancelation just kicks the driver to queue the completion
> ASAP, with all actual completion handling done in another thread. Given
> that both the completion path and cancelation take the context lock there
> is no need for magic cmpxchg loops either.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Moyer <jmoyer@redhat.com>
> ---
>  fs/aio.c | 37 +++++++++----------------------------
>  1 file changed, 9 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index c32c315f05b5..2d40cf5dd4ec 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -156,19 +156,6 @@ struct kioctx {
>  	unsigned		id;
>  };
>  
> -/*
> - * We use ki_cancel == KIOCB_CANCELLED to indicate that a kiocb has been either
> - * cancelled or completed (this makes a certain amount of sense because
> - * successful cancellation - io_cancel() - does deliver the completion to
> - * userspace).
> - *
> - * And since most things don't implement kiocb cancellation and we'd really like
> - * kiocb completion to be lockless when possible, we use ki_cancel to
> - * synchronize cancellation and completion - we only set it to KIOCB_CANCELLED
> - * with xchg() or cmpxchg(), see batch_complete_aio() and kiocb_cancel().
> - */
> -#define KIOCB_CANCELLED		((void *) (~0ULL))
> -
>  struct aio_kiocb {
>  	union {
>  		struct kiocb		rw;
> @@ -565,24 +552,18 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
>  }
>  EXPORT_SYMBOL(kiocb_set_cancel_fn);
>  
> +/*
> + * Only cancel if there ws a ki_cancel function to start with, and we
> + * are the one how managed to clear it (to protect against simulatinious
                  ^^^                                         ^^^^^^^^^^^^^
I have the same complaint about how/who confusion and the spelling error
in this comment, but otherwise looks fine...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D


> + * cancel calls).
> + */
>  static int kiocb_cancel(struct aio_kiocb *kiocb)
>  {
> -	kiocb_cancel_fn *old, *cancel;
> -
> -	/*
> -	 * Don't want to set kiocb->ki_cancel = KIOCB_CANCELLED unless it
> -	 * actually has a cancel function, hence the cmpxchg()
> -	 */
> -
> -	cancel = READ_ONCE(kiocb->ki_cancel);
> -	do {
> -		if (!cancel || cancel == KIOCB_CANCELLED)
> -			return -EINVAL;
> -
> -		old = cancel;
> -		cancel = cmpxchg(&kiocb->ki_cancel, old, KIOCB_CANCELLED);
> -	} while (cancel != old);
> +	kiocb_cancel_fn *cancel = kiocb->ki_cancel;
>  
> +	if (!cancel)
> +		return -EINVAL;
> +	kiocb->ki_cancel = NULL;
>  	return cancel(&kiocb->rw);
>  }
>  
> -- 
> 2.14.2
> 
