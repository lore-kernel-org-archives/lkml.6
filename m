Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539398-1525879317-2-8249190704860816455
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525879316; b=WvRTihB5gKMm/FCAlolctYTIIRKxvMvuphjcLnrfGTsmssd9fT
    NVmeKVdPvyR0HDceL7E0py9EKN8IjEMODCkoe+zg7vkejUUfG+nLZkgOiDqo+e1e
    8TXeR5GT8fEmNRxjBpfje6y3qWqIlx4o8hqjIo/1Q6XgcAvbSQbrSgXyTOj5WzAg
    n2vGJoRfigfxJ1PKRH8a0rgqRA2DseBK2iugINk3dIR4+DixIx1CJJr2tIhDzxPL
    C4CwNH0qMIizh8R24tg4ML9iJt5f9WVsOM7nGzPXwFV22B4Dzpu4KniXPV9Mhk+A
    Ma88Fy11V/kpt8K4iawNhlzqu8GFmjrXT0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525879316; bh=b8V83KRkwLrFU/oObgwEaHQWUD5qsq
    XHLoRV9qPNgHQ=; b=j3to4cTaF4kg/Y8jGXBT9ZWcI3kgU0W/qnv6G+xfOnvslZ
    z7A7xA25FySsCQ8Hr5gztYkEH7UHwp6tpAmhfdagJ7lJ6x5oBGu+hn4LszKfRoxR
    dNeEj1Pr+JAnOrOeLFT0IJToDQH9Ha3F6Wkv26l/au0WkU5GaEGfsWzWSEWUJYgI
    e4rspmukhhES58ZJGduaBGlnLyYXR6KD/N6l5bOHEnNCg2jIwgmJJVqT1I0CZ3Zp
    hxr0FLikjI0cm54H9pHtQXPXFFlgG1p6WHMq92/2cn2oM7cku+fp5HCJ106kCQ2L
    okxzYsQ55OjleK4Lq3p3AgQ9SEfOiqf8nbYK36EQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=thunk.org header.i=@thunk.org header.b=X43V4ZW3 x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=thunk.org header.i=@thunk.org header.b=X43V4ZW3 x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHtPQjnPnZxx3t5KG7xVUHd/UGhOQo0IGxIB+LTEd+r6OLQWHIbs1Xkly9Z1jz4amTrFJOHkkxXApCIj42Bz4KPpsvoW3rDy9+R6M7SDk5lDdNFnUAfX
    OCHrPzqnncPwCAmJOSmHEjHE4ViX8ok/82faMgjq0lwCF8hYD1jOTDAMWbbQch1iO/GblJdRi1JMflpD1c6NbxHcaCuARgz1KHX1aVtz9PW4anR5vJ9CKt8W
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=zNVVqKnCjlLL44hRDJIA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935065AbeEIPVx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 11:21:53 -0400
Received: from imap.thunk.org ([74.207.234.97]:34012 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935391AbeEIPVw (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 9 May 2018 11:21:52 -0400
Date: Wed, 9 May 2018 11:21:49 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Jens Axboe <axboe@kernel.dk>
Cc: adam.manzanares@wdc.com, viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] fs: Convert kiocb rw_hint from enum to u16
Message-ID: <20180509152149.GG28388@thunk.org>
Mail-Followup-To: Jens Axboe <axboe@kernel.dk>, adam.manzanares@wdc.com,
        viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180508174202.2537-1-adam.manzanares@wdc.com>
 <20180508174202.2537-3-adam.manzanares@wdc.com>
 <20180509133432.GD28388@thunk.org>
 <0aad993b-448c-3586-cfc0-f2e50b1dda28@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aad993b-448c-3586-cfc0-f2e50b1dda28@kernel.dk>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 08:23:00AM -0600, Jens Axboe wrote:
> Streams is essentially the only thing ki_hint is currently used for,
> with the write life time hints mapping to a stream. The idea for the
> user side API was to have other things than just write life time hints.
> 
> Since Adam wants to do priorities, he'd either need to pack into the
> existing ki_hint, or do this patch does, which is make it smaller and
> add a new member. I think the latter is cleaner.

Fair enough; but maybe we can use a u8 instead of a u16?  65,535
priorities still seem like way more than would ever make sense.  I
think 256 priorities is still way to many, but it's simpler while
still reserving number of bits for future se.

            		       	       	   - Ted
