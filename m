Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3618868-1521623741-2-5570275454985757045
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
    t=1521623740; b=qXOLWYAWh1UZlt2qFeA9XkjjJ5OlVfEcofl3IuD2PJjSZmM
    MpoEFBpWRvBJpCJDd9y9gz6EP1MytrAaKHMZ7ZYoInxfK+mh87/c02IvPp/H6n7U
    oEX4VGlg8H+knvVXL4jtWYdQwNoirtI0hW15iD+mpyMxNZLed6EGutjonEZxWReL
    4taL/B09pqUo46SrkEO/vFIdTAazgJG3SMXFsHSipfLYLsIgsjv5A0Ma0mWhfBg9
    qknAomfkXh5YEVcprqB63JO+zPZNlQHMNEBsbzCQjn1Aa1hpe4czIRPZk6tBraHv
    QAZUPPDxVvyK5z6YPszdierI223cE1MmX/6Wavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623740; bh=Ku7N46dvbQWHqeBoAUuwLdpCyE
    gOdpNfLUGN5Q+oR3U=; b=Tpcm76rB97kUlSVwi/7tY9DRXPBFdrAY+60/WgXNLr
    64A6Cck42YVb0fpMdnnPP+zVV3XXdnPNBSF6HSW9KaFZTHCqsYCJ8yf5hGjDD8en
    eRDSiLdC8jxFjqmv6Q8wZra00BRVz/1K7HIKtxbfhRfzDO1tZKOF1YSd7At/uVWP
    lZT2WscZ0HxA5PE9w0R17mQEatH4mDTEXC3mmM1n6Yt/wqvAIPeBW2bgtd8+Tubw
    KuSXDzjtAaRF1j95SOUzRzJG4ZIdtFmEc9ZZCt9abqzUgj8xlhUScmln3Kj+XrXF
    yTM+MYkWRl8+OK7qRt82mvDEYssZaLP2L4C0xZUMmgUA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S1751539AbeCUJP0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:15:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35022 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbeCUJPZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:15:25 -0400
Date: Wed, 21 Mar 2018 10:15:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] aio: refactor read/write iocb setup
Message-ID: <20180321091522.GK14085@kroah.com>
References: <20180321073232.13366-1-hch@lst.de>
 <20180321073232.13366-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321073232.13366-4-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:32:26AM +0100, Christoph Hellwig wrote:
> Don't reference the kiocb structure from the common aio code, and move
> any use of it into helper specific to the read/write path.  This is in
> preparation for aio_poll support that wants to use the space for different
> fields.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Moyer <jmoyer@redhat.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  fs/aio.c | 171 ++++++++++++++++++++++++++++++++++++---------------------------
>  1 file changed, 97 insertions(+), 74 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 41fc8ce6bc7f..6295fc00f104 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -170,7 +170,9 @@ struct kioctx {
>  #define KIOCB_CANCELLED		((void *) (~0ULL))
>  
>  struct aio_kiocb {
> -	struct kiocb		common;
> +	union {
> +		struct kiocb		rw;
> +	};
>  
>  	struct kioctx		*ki_ctx;
>  	kiocb_cancel_fn		*ki_cancel;
> @@ -549,7 +551,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
>  
>  void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
>  {
> -	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, common);
> +	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
>  	struct kioctx *ctx = req->ki_ctx;
>  	unsigned long flags;
>  
> @@ -582,7 +584,7 @@ static int kiocb_cancel(struct aio_kiocb *kiocb)
>  		cancel = cmpxchg(&kiocb->ki_cancel, old, KIOCB_CANCELLED);
>  	} while (cancel != old);
>  
> -	return cancel(&kiocb->common);
> +	return cancel(&kiocb->rw);
>  }
>  
>  static void free_ioctx(struct work_struct *work)
> @@ -1040,15 +1042,6 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
>  	return NULL;
>  }
>  
> -static void kiocb_free(struct aio_kiocb *req)
> -{
> -	if (req->common.ki_filp)
> -		fput(req->common.ki_filp);
> -	if (req->ki_eventfd != NULL)
> -		eventfd_ctx_put(req->ki_eventfd);
> -	kmem_cache_free(kiocb_cachep, req);
> -}
> -
>  static struct kioctx *lookup_ioctx(unsigned long ctx_id)
>  {
>  	struct aio_ring __user *ring  = (void __user *)ctx_id;
> @@ -1079,29 +1072,14 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
>  /* aio_complete
>   *	Called when the io request on the given iocb is complete.
>   */
> -static void aio_complete(struct kiocb *kiocb, long res, long res2)
> +static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
>  {
> -	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, common);
>  	struct kioctx	*ctx = iocb->ki_ctx;
>  	struct aio_ring	*ring;
>  	struct io_event	*ev_page, *event;
>  	unsigned tail, pos, head;
>  	unsigned long	flags;
>  
> -	BUG_ON(is_sync_kiocb(kiocb));

Ah, nevermind about my previous email, sorry, should have kept
reading...

> +static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
> +{
> +	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
> +
> +	WARN_ON_ONCE(is_sync_kiocb(kiocb));

That's nicer, thanks.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
