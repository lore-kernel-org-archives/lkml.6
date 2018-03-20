Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4107823-1521505550-2-18338089960889296035
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
    t=1521505550; b=TBfx1dCckzsqUca100dJnIk++O10tkrIsRY2vCIQK1l5IwY
    Ep2IU2Ah4dsYqCypOKqt/ul6lbynealc7DZOaij8ocaG1wZF3r1YR0cShkmSLDA/
    XHuGbLd17KUeKxgX9SZW+rQytmqv6V8cHfBUIGlx1sND6SqYSXuce4qc5/Qpi5NS
    SeWImRQwZDCybpLF2/SJxxBqyzGWJe1F7qMZQMnnrpF06NV0EQhBP/3LgoMNfDMb
    zrbqomRQSx+qxtw4M01Td7mOGYp8Y5p+FhkkmpF0sb4kC3ET4Jz/X2C2bfVReOtR
    O4tmMJ1X4gLyDUt2cbxK06dm0SsSkpf+Pm16+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521505550; bh=t2X2G50t+HdcnazSiAjEbacNql
    IcxDfAtrTieU7myUM=; b=oVO3YoLzptzKnHGAjeu93U0Vij4h5Au5LxkUIOZo9+
    dQkbIeGaqvKcZiz6+JAePbZtYqg+I4g3qyr/h/utkXPQChoGa4WQniENy/Z5MwDg
    nJ1TgL/4nG6gvZO34zox914MizREwjopimoq4UWE5DJoFT4Xo5oGeonLl1xNem6m
    HYdgQkf9A4DbRQizD8LgeYIrwjhizNPtTjbXHUYr4ziaddQb+lXvJ7BZVnyS9pnb
    ECih7eDthkWK5rJu/bH/Au4RD+85TNl7vefvBXMXpOIIH3WNtDjpacqcwZeAsKsy
    uFjw+swLA61MVtpw3Sg1BLHxZXIBMzFFYrN6UH6McpZQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=kFt4sJxA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddvvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirdduheenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepiedvkeeinecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=kFt4sJxA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddvvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirdduheenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepiedvkeeinecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934724AbeCTAZR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 20:25:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41712 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934168AbeCTAZQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Mar 2018 20:25:16 -0400
Date: Mon, 19 Mar 2018 17:25:07 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/36] aio: simplify cancellation
Message-ID: <20180320002507.GC7282@magnolia>
References: <20180305212743.16664-1-hch@lst.de>
 <20180305212743.16664-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305212743.16664-6-hch@lst.de>
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

On Mon, Mar 05, 2018 at 01:27:12PM -0800, Christoph Hellwig wrote:
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

"...are the one who managed to clear it (to protect against simultaneous
cancel calls)." ?

Really only complaining because who/how are both English words...

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
