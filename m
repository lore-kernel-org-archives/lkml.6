Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3621199-1521623815-2-12393070609433108524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521623815; b=q0dmATia/tVJw+h3/XcfTXtqdfkGp50qw5k/t++FIBHherZ
    9VTXmDDhfsMne1qjAJHEQhfWmV7hfKQx/+ecaVmcFZXj4Mxu9N1byehv/yZAwDSG
    FDVXJIiMldNgsBZwmZjeYsLTt/0pp0B2yx9p0zWJOtf2nmAe9BM0A6DK6IihLfVY
    Hj2CeKdqRRc4InI+c2+tYyDA4GOQr55x9FdBwtx0TH3eH0saMsBNdYDSUlGxK52T
    rRfZog+RFGVXgdjyJssvpe5+C9OzUxoIDWJeS4SewIfNaphNnkMMNtXP9mjlttmu
    E9lt0XMEFiC8SR6jqnrobFFMV6W+KDdH/qeWVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623815; bh=6osunecmNyY3qqjaZK7cLc2Iyd
    bpaAlC0ejnHKQLAUM=; b=JgnQsYMIehTtWSeSpeqJmz0v3Qs5YbqO7kX/vjXSC9
    cPGuSCMe4XchzX84vZhDfdAVwjksBzyDd9nEMu5rbo+YoN4OkZegBtZmVLYATQCH
    6PaICoL781XHwBZ9Y4OMbfJsQ5TrFEwHBywGRmFBnLGLN0nsUPZUCLJRhnffmWkY
    Xc6mWD19U9xbwUh2QIo7cj7jCTRevPgObR2rbF5RK0skuCcjELiq0gAbPAF6U6dV
    +kfLNIvC9BHorcVsyYCXxA1hNvToKJFmIiCAaLtJQ4nAtomcxCNO5SEJTiFkuc9f
    p/DO9hsBMrj7dKD2aIBYIJWgDOkvJbHYQ2EYWdGdmceQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeCUJQv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:16:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCUJQu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:16:50 -0400
Date: Wed, 21 Mar 2018 10:16:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] aio: sanitize ki_list handling
Message-ID: <20180321091648.GL14085@kroah.com>
References: <20180321073232.13366-1-hch@lst.de>
 <20180321073232.13366-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321073232.13366-5-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:32:27AM +0100, Christoph Hellwig wrote:
> Instead of handcoded non-null checks always initialize ki_list to an
> empty list and use list_empty / list_empty_careful on it.  While we're
> at it also error out on a double call to kiocb_set_cancel_fn instead
> of ignoring it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Moyer <jmoyer@redhat.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  fs/aio.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 6295fc00f104..c32c315f05b5 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -555,13 +555,12 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
>  	struct kioctx *ctx = req->ki_ctx;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&ctx->ctx_lock, flags);
> -
> -	if (!req->ki_list.next)
> -		list_add(&req->ki_list, &ctx->active_reqs);
> +	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
> +		return;

Will be fun to see if the syzkaller code ends up tripping on this one,
their use of panic-on-warn always is "interesting"...

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


>  
> +	spin_lock_irqsave(&ctx->ctx_lock, flags);
> +	list_add_tail(&req->ki_list, &ctx->active_reqs);
>  	req->ki_cancel = cancel;
> -
>  	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
>  }
>  EXPORT_SYMBOL(kiocb_set_cancel_fn);
> @@ -1034,7 +1033,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
>  		goto out_put;
>  
>  	percpu_ref_get(&ctx->reqs);
> -
> +	INIT_LIST_HEAD(&req->ki_list);
>  	req->ki_ctx = ctx;
>  	return req;
>  out_put:
> @@ -1080,7 +1079,7 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
>  	unsigned tail, pos, head;
>  	unsigned long	flags;
>  
> -	if (iocb->ki_list.next) {
> +	if (!list_empty_careful(iocb->ki_list.next)) {
>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&ctx->ctx_lock, flags);
> -- 
> 2.14.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-api" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
