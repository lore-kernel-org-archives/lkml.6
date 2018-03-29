Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-977504-1522333530-2-10532304614701478795
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522333529; b=HuNph2UeJHRD5l9jo9LHLUfTRDxiYknRfRp9dxCQ8TXQ2hQoCM
    TDcOspuHCUGyRs7AKcyUA/n6XhnR2W0hjcqwZ3AZ3S7E2sRwBI6tys8v12CnDUzv
    /Ii1yPITlSfN+NR920bsAXrzeKRVlYftuCA+UTwoqdI+3gaP0B1A4iYg7aQye0sJ
    Y8UFZISg3L6poZAzZaDIKTpDu8wzNxbfA2/NvjB9ViTUZv3RsD9ecSJXnmtn/5i7
    s591w54lAQo+K8CXffKoTAKXR73eNh+0b1uOQHE/g4CJQd+aFZzGTTppbyDZOtiv
    DioGJj+I3IFxf+jF2rbpJL/XXgc6htIOyOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522333529; bh=tBc/7upvUFhKLWKhcvSPiO/AK148f7
    8y74B3Ch9BoC0=; b=AYvuEdIKKv3UcP43f+mzgIQC6Jfr3MGiyFcKZQUlY4DAWM
    LUxXaJKQJ3REZxMgph2SvkATGR3TryNqLsNLe2BSrQsRVppVcZf7FkfJzyw2OA3K
    D5cAACactCN2l0DE6go6vyDEL9i5rydmx37YLPin2EdiLfuAPPEkwkhEsOG3g2YL
    FWxT9BGx6CNglqDlH4KTCUF6hxar38R5VUhHcKWmVb13qOdXRbJsvsX+IzvpCIXD
    AJ8JCDBghgKuyb2CRm5zcawJhO7DD7ZKEX30tko3DM6VnhjgCniDzkt1phoJkmtW
    yKwQ23cqhx1NiL2qcbcYMzeJCsrdz2zkPzSNy6sg==
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
X-CM-Envelope: MS4wfKOr1b0sRwFkRXDW2TwMEJIugy7OnJAhtdPrAz5NoPUuLH/hinRZIjUlQapw6C74LZxZ7SegioRmuBabuHcB0gZpfLLUOBiIlZL5GZEIb2/Rx5pjM1Bb
    BFDCmQ9wkcY0Nsx/PP8bsLaKDoLJ7YiHqJd6YSZWKA8Vs9AGE2Ok9YgJNxR5irpCsHiMOn8TgyEzxE29tdHryDz5mJrSPFljx/pySEeQmOnj1q5Mdy7ucWSX
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=4JrhP_CENe8OTT19QtcA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbeC2OZL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 10:25:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38360 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeC2OZK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 10:25:10 -0400
Date: Thu, 29 Mar 2018 15:25:06 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/30] aio: add delayed cancel support
Message-ID: <20180329142506.GX30522@ZenIV.linux.org.uk>
References: <20180328072926.17131-1-hch@lst.de>
 <20180328072926.17131-8-hch@lst.de>
 <20180328163526.GV30522@ZenIV.linux.org.uk>
 <20180329085305.GA22215@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329085305.GA22215@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 10:53:05AM +0200, Christoph Hellwig wrote:
> On Wed, Mar 28, 2018 at 05:35:26PM +0100, Al Viro wrote:
> > >  	ret = vfs_fsync(req->file, req->datasync);
> > > -	fput(req->file);
> > > -	aio_complete(container_of(req, struct aio_kiocb, fsync), ret, 0);
> > > +	if (aio_complete(iocb, ret, 0, 0))
> > > +		fput(file);
> > 
> > IDGI.
> > 	1) can aio_complete() ever return false here?
> 
> It won't.  But sometimes checking the return value and sometimes not
> seems like a bad pattern.
> 
> > 	2) do we ever have aio_kiocb that would not have an associated
> > struct file * that needs to be dropped on successful aio_complete()?  AFAICS,
> > rw, fsync and poll variants all have one, and I'm not sure what kind of
> > async IO *could* be done without an opened file.
> 
> All have a file assoiated at least right now.  As mentioned last time
> finding a struct to pass that file would be rather annoying, so we'd either
> have to pass it explicitly, or do something nasty like duplicating the
> pointer in the aio_kiocb in addition to struct kiocb.  Which might not
> be that bad after all, as it would only bloat the aio_kiocb and not
> struct kiocb used on stack all over.

OK.  Let's leave that alone for now.  Re deferred cancels - AFAICS, we *must*
remove the sucker from ctx->active_reqs before dropping ->ctx_lock.

As it is, you are creating a io_cancel()/io_cancel() race leading to double
fput().  It's not that hard to fix; I can do that myself while applying your
series (as described in previous posting - kiocb_cancel_locked() returning
NULL or ERR_PTR() in non-deferred case and pointer to aio_kiocb removed from
->active_reqs in deferred one) or you could fix it in some other way and
update your branch.

As it is, the race is user-exploitable and not that hard to trigger - AIO_POLL,
then have two threads try and cancel it at the same time.
