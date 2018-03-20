Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4107823-1521505299-2-2919500060591776456
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES enrosv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521505298; b=IgLhqzwdD9qN5zc3zZCqYV0/hThWh34nho2Jp6sf5wOr9Xx
    wsmM0ZDECPgvXcQ+J/Y8S7CiRyEkFz6C2cYfmK5lSsGNbhuK4Jc+9K5OL4mgEJ02
    99Ne8aku4v9n4vuSyK6A/+X3nZYAJ6cDZvdvxWk1YCXBODMhnPWV70S+g+Rka0ZQ
    K4dlMYcbQsL1cM0hm0nzKtKdA0K5BKcujeyR9/jOlfyU18O3MJu7RkCQATpk3fqg
    Hq/7zkXuBWYSWT9blr/Yr8PcYLm2ljPpX/LStuUqRmZok2xGTCFMrPIki4CK4pCX
    x8FBF2Ot5MyUzm+nJ/tuPame7NguMOvAeUYTzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521505298; bh=tPczHELdzOZTBH2V8BOUjG2vbd
    iafyRN6Y/GihXaLys=; b=iUVENQbhmJsblR3yt7B4FA1Q++GvTRYPVasg2iZfpP
    V0YdaFgZOUPOjCYOBJQDDfTo5i2apy+PSgU/cgfBRNytqNqgxT7LwNCWnUkbYLFw
    5IsCARJcWkT20/M6YMjgGkYZuT6IbgTGP4BlI2uYkiyRA2gcAEHzzrW6uOjNcXLg
    0nvHHJy7lMYEQy4izjf5rFvxwZ64KKJEM5+mvlzcXVl4Ar3k5iJty7HtFFc+XnPr
    ioHtmQiO90WQ+CBfFH6omrpNmydmlYpapE1ul291Wjj8X7PdlxKs5FJCf4RuUG1X
    +UsKjWpZSIPS814lBA/CmQgdJ3oDQ4VUIPBjQsXsMHqA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Zieq7md/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddvudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirdduleenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheefieeknecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Zieq7md/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddvudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirdduleenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheefieeknecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965690AbeCTAVO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 20:21:14 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38308 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934168AbeCTAVM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Mar 2018 20:21:12 -0400
Date: Mon, 19 Mar 2018 17:21:03 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/36] aio: sanitize ki_list handling
Message-ID: <20180320002103.GB7282@magnolia>
References: <20180305212743.16664-1-hch@lst.de>
 <20180305212743.16664-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305212743.16664-5-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8836 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803190149
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 01:27:11PM -0800, Christoph Hellwig wrote:
> Instead of handcoded non-null checks always initialize ki_list to an
> empty list and use list_empty / list_empty_careful on it.  While we're
> at it also error out on a double call to kiocb_set_cancel_fn instead
> of ignoring it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Moyer <jmoyer@redhat.com>

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

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
