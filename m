Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-900250-1524671250-2-11849508534145696357
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671250; b=kEkP7hqKDpZkdkqgJkANh3hO1svrjRY7RZZ3iYXKVLk07h/Z8l
    YMN0Ypy92P08hxOUi97zTyD7evVdghnOlHWestVg2VpgW7nYEa+rWaH6iPv88j0U
    n+XYBjNtGGRc257BbJ3YffHWzON8A57LpHD4vLtPlth9mvZU8oTjrLNRebgHt4vj
    sXvULXoOYQaU7cAcMwRZLAUhyri6jKX1qfpEpz4cePIl8nXnI6QvyiW3TjPJEj0E
    fsf19zVzyaP4GFI/ju2jHadp2dTgtnTLTXozvIzwJ8A7l/7O3HgC7HN3O46fUdI9
    2k7OmlLEfmR1Fr1lS0mDQZ0dkD0EOj0pHxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524671250; bh=4h9Jz3EIG2G0JImJekMKcpm9ecgZAE
    eT0odWAK3oFxU=; b=DYpYqrimqulR70/FhE0WZptR0NfnhS5m0g4QtImvL3a2Kn
    HSU3dZa6OIN642GwsdxN9A3iz6twMUVdNKFkex/+u4a/hzfDa7xBVcn465f3kHnt
    auSEuabjm2XvXB2qHJL8g/IuaSxTAd5FoJ1iQbwPTxMIiIX9ybqMyq8KYJBakNlA
    ByNYx8TnIl9dIaS7SZM9RUJUlMV+1dlb4vFiLq7wAa/E+992Ke/VpWzjNbNVcssh
    Xtenm5V0zPpFE2CFGbezvVrUFxujNjVGXuuF8LwhI1TehJ7iHhNsRKPXEWpc9rmV
    mwe+kCMsP8yH5Fsc6rnbyjGzoq0tcipHoVwuyZaQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=HjhUOvEY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=HjhUOvEY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBxs2sFOwA2TB+cRe+78JqvNnDBhzgZp6FigRi0GjMA23kilaN73M/XoynmR7UHAVdEERUKQV8KVxijpp4Y7eGRWAffiPCmQN9lBHw74t3w4BclZpcX2
    P3Gn4tE953mhouXLpjj/GG5fQZhedny35E9j6fhcE4tSnfC9KaNuKPFrkN6H25Zu4IpPqEA29B+tOirRVsSPejnts1aTrxRFXKYI0eMLtOPB0bY4xN4gm04M
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=mTioiX8BpfavDslvfnIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754655AbeDYPrY (ORCPT <rfc822;linux@kroah.com>);
        Wed, 25 Apr 2018 11:47:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36202 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754196AbeDYPrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:47:23 -0400
Date: Wed, 25 Apr 2018 08:47:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Moving unmaintained filesystems to staging
Message-ID: <20180425154722.GA29415@infradead.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425154602.GA8546@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 08:46:02AM -0700, Matthew Wilcox wrote:
> hfsplus - Mac filesystem.

I don't think this is unmaintained, and it is pretty heavily used.

> minix

Still plenty of use.
