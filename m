Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-260780-1521516008-2-3415881685548397395
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521516008; b=Z9loWzswtwi2kHSaDYEB3SZXyrPda5KrT2GdRU8p7vk/G+E
    rlFlG+F3RmHBMK34zWJYmSodJQtz+JeJMUnoPtqB7qryr93eFECQMGRZ7/OkGRTe
    rjTBNBuOP7bLq3RbkJrDe6/VVSw2wRy4nJU42P3S+dhYqd0ymk2hyVRjhHLAcMvi
    CxaJFqx4IYIWhMZqQDeQz/If6uXKwlIU4aR4e+OQr/kyoO6NmWHYd6bIbTq2R+9K
    eME6d1aOjhF2cpBLX3fRx46fFYXYs5263nPnZxMvcLkbv1OcZBdj3ihCZYTvLDme
    x8FiLkgfduXK9goTuh/ZUR4DOD0Uu4KtCu7jnbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521516008; bh=pUjSS7+toLUPuFQLnwVbiaeuew
    YpnoI7FNuNBtddYaw=; b=h2hHUhVTWOzWb3H3UCyqF5ued3bcUrV8BQm2Fhv0Cy
    5NQCFg6S5468934N4JvlJEy36L5m6gzdKX+WbCrAoyrfLSxn0hIcyE2r4s9GRpw7
    r/D7/oA8dJclbRA+oGmShIn5dR30zUnmzDYBWJ1WJW3wvSRqksJTpm+MNv7eeAvV
    TmapF5IB6RjQtiyesBynUX39kslq+lcpZ7o9g1RowgwSwqGptsgwX4M2mfSPw4Vt
    VS6OeLht7tM0K//vXRMA2hdb2LATPExSKdewycjZub4xVJFNvVy9c0YC5bm7sDSO
    wB1oDvO18DIsTdT4qchZqv69BYl8IgTq1n8VilWBnB/Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=NHmeyfZ1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirddvheenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekuddtnecuvehluhhsthgvrhfuihiivgeptd
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=NHmeyfZ1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirddvheenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekuddtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbeCTDUG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 23:20:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35428 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeCTDUF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Mar 2018 23:20:05 -0400
Date: Mon, 19 Mar 2018 20:19:57 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/36] aio: add delayed cancel support
Message-ID: <20180320031957.GJ7282@magnolia>
References: <20180305212743.16664-1-hch@lst.de>
 <20180305212743.16664-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305212743.16664-8-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8837 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200006
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 01:27:14PM -0800, Christoph Hellwig wrote:
> The upcoming aio poll support would like to be able to complete the
> iocb inline from the cancellation context, but that would cause
> a lock order reversal.  Add support for optionally moving the cancelation
> outside the context lock to avoid this reversal.

I started to wonder which lock order reversal the commit message refers
to?

I think the reason for adding delayed cancellations is that we want to
be able to call io_cancel -> kiocb_cancel -> aio_poll_cancel ->
aio_complete without double locking ctx_lock?

--D

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Moyer <jmoyer@redhat.com>
> ---
>  fs/aio.c | 49 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 0b6394b4e528..9d7d6e4cde87 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -170,6 +170,10 @@ struct aio_kiocb {
>  	struct list_head	ki_list;	/* the aio core uses this
>  						 * for cancellation */
>  
> +	unsigned int		flags;		/* protected by ctx->ctx_lock */
> +#define AIO_IOCB_DELAYED_CANCEL	(1 << 0)
> +#define AIO_IOCB_CANCELLED	(1 << 1)
> +
>  	/*
>  	 * If the aio_resfd field of the userspace iocb is not zero,
>  	 * this is the underlying eventfd context to deliver events to.
> @@ -536,9 +540,9 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
>  #define AIO_EVENTS_FIRST_PAGE	((PAGE_SIZE - sizeof(struct aio_ring)) / sizeof(struct io_event))
>  #define AIO_EVENTS_OFFSET	(AIO_EVENTS_PER_PAGE - AIO_EVENTS_FIRST_PAGE)
>  
> -void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
> +static void __kiocb_set_cancel_fn(struct aio_kiocb *req,
> +		kiocb_cancel_fn *cancel, unsigned int iocb_flags)
>  {
> -	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
>  	struct kioctx *ctx = req->ki_ctx;
>  	unsigned long flags;
>  
> @@ -548,8 +552,15 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
>  	spin_lock_irqsave(&ctx->ctx_lock, flags);
>  	list_add_tail(&req->ki_list, &ctx->active_reqs);
>  	req->ki_cancel = cancel;
> +	req->flags |= iocb_flags;
>  	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
>  }
> +
> +void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
> +{
> +	return __kiocb_set_cancel_fn(container_of(iocb, struct aio_kiocb, rw),
> +			cancel, 0);
> +}
>  EXPORT_SYMBOL(kiocb_set_cancel_fn);
>  
>  /*
> @@ -603,17 +614,27 @@ static void free_ioctx_users(struct percpu_ref *ref)
>  {
>  	struct kioctx *ctx = container_of(ref, struct kioctx, users);
>  	struct aio_kiocb *req;
> +	LIST_HEAD(list);
>  
>  	spin_lock_irq(&ctx->ctx_lock);
> -
>  	while (!list_empty(&ctx->active_reqs)) {
>  		req = list_first_entry(&ctx->active_reqs,
>  				       struct aio_kiocb, ki_list);
> -		kiocb_cancel(req);
> -	}
>  
> +		if (req->flags & AIO_IOCB_DELAYED_CANCEL) {
> +			req->flags |= AIO_IOCB_CANCELLED;
> +			list_move_tail(&req->ki_list, &list);
> +		} else {
> +			kiocb_cancel(req);
> +		}
> +	}
>  	spin_unlock_irq(&ctx->ctx_lock);
>  
> +	while (!list_empty(&list)) {
> +		req = list_first_entry(&list, struct aio_kiocb, ki_list);
> +		kiocb_cancel(req);
> +	}
> +
>  	percpu_ref_kill(&ctx->reqs);
>  	percpu_ref_put(&ctx->reqs);
>  }
> @@ -1785,15 +1806,22 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
>  	if (unlikely(!ctx))
>  		return -EINVAL;
>  
> -	spin_lock_irq(&ctx->ctx_lock);
> +	ret = -EINVAL;
>  
> +	spin_lock_irq(&ctx->ctx_lock);
>  	kiocb = lookup_kiocb(ctx, iocb, key);
> +	if (kiocb) {
> +		if (kiocb->flags & AIO_IOCB_DELAYED_CANCEL) {
> +			kiocb->flags |= AIO_IOCB_CANCELLED;
> +		} else {
> +			ret = kiocb_cancel(kiocb);
> +			kiocb = NULL;
> +		}
> +	}
> +	spin_unlock_irq(&ctx->ctx_lock);
> +
>  	if (kiocb)
>  		ret = kiocb_cancel(kiocb);
> -	else
> -		ret = -EINVAL;
> -
> -	spin_unlock_irq(&ctx->ctx_lock);
>  
>  	if (!ret) {
>  		/*
> @@ -1805,7 +1833,6 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
>  	}
>  
>  	percpu_ref_put(&ctx->users);
> -
>  	return ret;
>  }
>  
> -- 
> 2.14.2
> 
