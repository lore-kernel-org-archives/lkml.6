Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3264303-1522272924-2-1161933591418594286
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522272923; b=UIQTPU5edSuODYzNZ3+HmNG34ngq4WIqtzzczlS8CqJXuny
    YT+jCYkiS12lPajPjd8CqRfQTIV+jbUgE8VoqdONVp3Qi68HsZDuvFTNXrAPBidb
    BE1TTpLe8xtzE6wJp9eOypjRtKuvyGnjxs4KinqNuzT7oCbWTfpJ0n9s4sGEwFaJ
    XOdLRzagreCHfoxS+AKroxtRH40lM67wPhjIm4OHevmk++WI8zR598ycYX4DrCrB
    /1wt8D4JDqKKxqzju4hRD0ymrTpOm43JrlD/9e/eJ7ncsV+QY4Yq44EK7pblzM5Z
    WXB2s0c/zDvZj/VaXSmoTn2n+/Bw/emAmiPtqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522272923; bh=f8VJe1xWcaX/Xx/qE8G3ata9as
    boiyUkWvRudjvLNso=; b=OAZasZ/1Yx6WJcYf8dGvY6/XNB/bbF/DG+N335dpr/
    b8a720JDy3PEeyLLSsKfHKLnR0pGtGSZ8Jocs3O6noOor7ym2cIQ0x8OIXKS0YWs
    tOYBbOi/IBsL9aue1IC8UxEvSVslfMIJ1yTY5yhSO6qe/F9WDhadMKCQ8hu30yQn
    io8AHzPEE0NxTzgSTVTD7vahTJQ8AKkyqhsmQIYWquF7WYoMNSh55B/3txMl5ouC
    2Wr+NK8kStDNOLfaGUZ+XSjfjYjym2UBlUGfuNTWbL3bLjwiqPrU0h11u5xInWEg
    wCyTZzgsn/QbDJXUF8K9AOJnssUD14lqgT38opSVwrXQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLkt37nv0U4A7hyr82Di1+k+rM4twF8eoJYR9sPWCbazqP7kGK9btoe9GUNSriHRxlYh250s+jM1ehpF7k4AhkQ/kTEhOSPY99dzbCO46MjffiJYQe4p
    bHKHAPqlSW6izapLXCgB5Wzn4LYvH9pMXulec7hec0t/R7yK8exr3z2VGR7m3CgsmivJLDd/iWPsEinJikH4AtFh1hIVTSGOvyUKrLMz8Xy+cNeD0UG2vD+k
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=gNQtK-quL3SsdyW9mKQA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753392AbeC1VfE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 17:35:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43522 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753117AbeC1VfD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 17:35:03 -0400
Date: Wed, 28 Mar 2018 22:34:59 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/30] aio: add delayed cancel support
Message-ID: <20180328213459.GW30522@ZenIV.linux.org.uk>
References: <20180328072926.17131-1-hch@lst.de>
 <20180328072926.17131-8-hch@lst.de>
 <20180328163526.GV30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328163526.GV30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 05:35:26PM +0100, Al Viro wrote:
> On Wed, Mar 28, 2018 at 09:29:03AM +0200, Christoph Hellwig wrote:
> >  static void aio_fsync_work(struct work_struct *work)
> >  {
> >  	struct fsync_iocb *req = container_of(work, struct fsync_iocb, work);
> > +	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, fsync);
> > +	struct file *file = req->file;
> >  	int ret;
> >  
> >  	ret = vfs_fsync(req->file, req->datasync);
> > -	fput(req->file);
> > -	aio_complete(container_of(req, struct aio_kiocb, fsync), ret, 0);
> > +	if (aio_complete(iocb, ret, 0, 0))
> > +		fput(file);
> 
> IDGI.
> 	1) can aio_complete() ever return false here?
> 	2) do we ever have aio_kiocb that would not have an associated
> struct file * that needs to be dropped on successful aio_complete()?  AFAICS,
> rw, fsync and poll variants all have one, and I'm not sure what kind of
> async IO *could* be done without an opened file.

OK, hell with that.  I've tried to play with turning kiocb into a struct with
anon union in it, with poll and fsync parts folded into that sucker and ki_filp
lifted into common part.  Possible, but it's hairy as hell and can be done
afterwards.

However, doing that digging has turned up something really nasty.  Look:
in io_cancel(2) you have 
        spin_lock_irq(&ctx->ctx_lock);
        kiocb = lookup_kiocb(ctx, iocb, key);   
        if (kiocb) {
                if (kiocb->flags & AIO_IOCB_DELAYED_CANCEL) {
                        kiocb->flags |= AIO_IOCB_CANCELLED;
                } else {
                        ret = kiocb_cancel(kiocb);
                        kiocb = NULL;
                }
        }
        spin_unlock_irq(&ctx->ctx_lock);

Now, suppose two threads call io_cancel() on the same aio_poll in progress.
Both hit that code and *both* find the same kiocb.  Sure, the first one
will shortly do
        if (kiocb)
                ret = kiocb_cancel(kiocb);
which will remove it from the list.  Too late, though - you've already dropped
->ctx_lock, letting the second one find it.  Result: two aio_poll_cancel() in
parallel, with resulting double-free and double-fput().

You really need to remove it from the ->active_reqs before dropping the lock.
free_ioctx_users() does it correctly, io_cancel(2) fucks it up.

I'd add something like
struct aio_kiocb *kiocb_cancel_locked(struct aio_kiocb *kiocb)
{
	if (!kiocb)
		return ERR_PTR(-EINVAL);
	if (kiocb->flags & AIO_IOCB_DELAYED_CANCEL) {
		list_del(&kiocb->ki_list);
		kiocb->flags |= AIO_IOCB_CANCELLED;
		return kiocb;
	} else {
		return ERR_PTR(kiocb_cancel(kiocb));
	}
}

with 
        spin_lock_irq(&ctx->ctx_lock);
        while (!list_empty(&ctx->active_reqs)) {
                req = list_first_entry(&ctx->active_reqs,
                                       struct aio_kiocb, ki_list);
		req = kiocb_cancel_locked(req);
		if (!IS_ERR_OR_NULL(req))
                        list_add_tail(&req->ki_list, &list);
        }
        spin_unlock_irq(&ctx->ctx_lock);

in free_ioctx_users() and
        spin_lock_irq(&ctx->ctx_lock);
        kiocb = kiocb_cancel_locked(lookup_kiocb(ctx, iocb, key));
        spin_unlock_irq(&ctx->ctx_lock);
	ret = IS_ERR_OR_NULL(kiocb) ? PTR_ERR(kiocb) : kiocb_cancel(kiocb);
in io_cancel(2)...

