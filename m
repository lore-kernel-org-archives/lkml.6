Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2915802-1522394054-2-11974069794475266511
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522394054; b=drQMngIbs4V58gqetuZPyvEzom0ro316mKvGlf4rolCL5O6D3j
    zQqR65GopXmrddez7zlp6mnLSFQL0HB5oyPR3B/PUuB7p6jMIQcutTKRa3mWQZBx
    tLcSZoH3Xcx7pyrUEaMuUrt/JniYj6gQu2ixKxw6QskXNIOAJ3hHgGHzq9IugWpJ
    cksfebAs7pswWP1D+uJK7ZuYPmq2kn3SVP9o6JaYcHzaFxON68D2Bynr3H/WKTco
    F7+pcFkq80kWRzM+hzPvezE4znopdRLAhhPcVj/OwtTo88Gz7jFivPnrgdOkJnxw
    8d0rEi7DYtrJEbTbQmRAPuKwkTMOvXTl4img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522394054; bh=Dv1Zb2ASY+t/VZgpEeAXeQeVlxsm+p
    Y38qKiBTMBohQ=; b=KNucpVcMGx/EiEJz4/A6cW2D15/FfJv7R1RPXSFkMOgysH
    2pKqI2MJo2FiIMHEvVX+AIThytqBRE3o2KxdeUI75v2fzV1wW2xcNct9xPIwKInX
    9F/0rVLosUJcs6VIWAAvJALzPO7e7LWnIDMh/bjpwwy4iUm16L42JW6eErxkcIuj
    Wgj/KRBWaylr5+kRVLleL7sgw7cizvMyJ/4SZhnswwGVsKmkxqmcTFglV0oYi0YH
    bDW+voRlTNtbKDa2hDF3AdT+hX2PB2R5nskQ+7kqFE+SFvoWEiB75ajTTcIBtLZj
    XmiII9AAziFMAj1j4/aK5kcR+ie/gM+kJOAsdElA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPGbl8FMh1KGgeavtVaqc1uATy8zNPUI5kO6Sf1FguqA9LvjB1dmyic01WGhIjNALqX88HaurknebF8T/+3+pk4HAkNtWJh3eTEk/zaY8eCpaoODwcDA
    ESlxBfL4S4i0sqcHK2Fz7X3Uf0yhcoHrxws0GlF1xurfTUXwHPfDby36LEqrG1Ys+E4UhMabmEuVZ3INUJ2yFHJqaxnBcjSEApCS+16XoiQmYsuR1ee6JRxb
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=p0KFoyKtMr7-g0Oo7E8A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeC3HOM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 03:14:12 -0400
Received: from verein.lst.de ([213.95.11.211]:53889 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752427AbeC3HOK (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 30 Mar 2018 03:14:10 -0400
Date: Fri, 30 Mar 2018 09:14:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/30] aio: add delayed cancel support
Message-ID: <20180330071408.GB17095@lst.de>
References: <20180329203328.3248-1-hch@lst.de> <20180329203328.3248-8-hch@lst.de> <20180329223500.GY30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329223500.GY30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 11:35:00PM +0100, Al Viro wrote:
> Uh-oh...  What happens to existing users of kiocb_set_cancel_fn() now?
> AFAICS, those guys will *not* get aio_kiocb freed at all in case of
> io_cancel(2).  Look: we mark them with AIO_IOCB_CANCELLED and
> call whatever ->ki_cancel() the driver has set.  Later the damn
> thing calls ->ki_complete() (i.e. aio_complete_rw()), which calls
> aio_complete(iocb, res, res2, 0) and gets false.  Nothing's freed,
> struct file is leaked.

True, we'd need a complete call from it.

> Frankly, the more I look at that, the less I like what you've done
> with ->ki_cancel() overloading.  In regular case it's just accelerating
> the call of ->ki_complete(), which will do freeing.  Here you have
> ->ki_cancel() free the damn thing, with the resulting need to play
> silly buggers with locking, freeing logics in aio_complete(), etc.

I don't really like it all that much either, but I also think the
current model is pretty broken - called under spinlock with irqs
disabled is not even what the current users expect.  Second issue
with the existing ki_cancel is that kiocb_set_cancel_fn operates
on a kiocb, but expects that to be embedded in an aio_kiocb, which
might not always be the case, althought in-kernel I/O is unlikely to
be used on them.  And based on all of these I bet gadget aio cancel
is basically untested.

Anyway, I guess splitting poll direct cancel out in a way that doesn't
overload ->ki_cancel might be a good idea.  It all is inside aio.c
so simply switching on the opcode similar to the submission path
might be one option, or having separate methods.  Moving ki_cancel
to kiocb would also solve above mismatch issue.
