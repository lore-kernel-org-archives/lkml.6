Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-157256-1523381931-2-5282728265504853946
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523381931; b=pV1dhJWkUamvQLbbocmPiGa7g62DLFxi2smpmmdmTXdSohvI0B
    Vun+jjWEycm+pCJNss9/AwFB+XeX2BPoL68ALHmB5GTvG/URSMR9InfL1yvx/R1P
    XY0UpfGlpL4M6n6ILApvcI0mvvOEUUWhdOzfxrkbs1Mxae+nBltPw0ix9SGLriSK
    Kk+InJ8QC5HfAX3nBsWW+M1VlFO5NccRrwBH0TpL0ycSmaGJ8Ixa7rXBvpnR1cyo
    gOkxEUn3HBsiZKYRKqiBprPoo66KKk4XPbkE2QIV2ba3Dv1bUvdHGIhx17MC/kIt
    zifaTfl+EipHbakq01GCLR+cw0Q5ngx/BrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523381931; bh=9jyzQSkuCFH6oiXdW8grLDBPGUKGA9
    ue1iIaaM32MB4=; b=PiFSOdX9wYXW5t3UcFI5eRgF+YUXZCb9KL5AvcWycfDlbz
    EriRVx2jSZupNrcpRxZ90LRchUQ0tytxYX4c3NnsvZePKd3dsM/uS9+e1YfOcHqj
    edSBBedWB7UV/2kEwmy9wfkxRA30CPNZhFZTRyjANvfZPP1J5HkTobAfuCJSIhCG
    kunXrErEk8x6R7TmGKlgw8XUT81XpVHjHKSFZYNmrJcArgmJ0vhy1fJbKagfbRFq
    /UOPmPbGgwX44PCzejqtGygyzjzL8GgOz5LM0yXvg5TOwmcVm/LX3zvyYHW2fHPL
    F1B1aHRnF57v7lvb0K2xOHnAV2ATN0tIuHUfO3gw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=RJ60/l2l x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=RJ60/l2l x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPg6i2GGdBU1ZKAMeiacYQprApGiVutV/wreX1UUbPCGHRGqhZq4jz2ysTyoEt+RuoOpdJqA+slQzkhl8AKgs17aXFkTf5LikvKUuC6fAVfKVVCsKRy9
    y3//ia+RsDj034/4je1oycH6ArTdf5g56h37MOu4tadBmpTmBapcWUON/GxlaDPBuXJdUxi877jVDBHXG+JdSyc2xWOvWYgskcQ9fskRRaIO5FoTp9ZOTM9d
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=ENpfDnSZKegL9Pcs_RYA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeDJRis (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 13:38:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeDJRir (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 13:38:47 -0400
Date: Tue, 10 Apr 2018 10:38:41 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Christopher Lameter <cl@linux.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, linux-mm@kvack.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] slab: __GFP_ZERO is incompatible with a constructor
Message-ID: <20180410173841.GD3614@bombadil.infradead.org>
References: <20180410125351.15837-1-willy@infradead.org>
 <fee8a8bc-3db5-a66a-33cb-0729143ba615@gmail.com>
 <20180410165054.GC3614@bombadil.infradead.org>
 <alpine.DEB.2.20.1804101228170.29384@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1804101228170.29384@nuc-kabylake>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 12:30:23PM -0500, Christopher Lameter wrote:
> On Tue, 10 Apr 2018, Matthew Wilcox wrote:
> 
> > If we want to get rid of the concept of constructors, it's doable,
> > but somebody needs to do the work to show what the effects will be.
> 
> How do you envision dealing with the SLAB_TYPESAFE_BY_RCU slab caches?
> Those must have a defined state of the objects at all times and a constructor is
> required for that. And their use of RCU is required for numerous lockless
> lookup algorithms in the kernhel.

Not at all times.  Only once they've been used.  Re-constructing them
once they've been used might break the rcu typesafety, I suppose ...
would need to examine the callers.
