Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3209358-1525387407-2-3143674785815455711
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
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525387407; b=HZ5uNhMhz86CTxEPzLClH+cNXsDG4TfvwLGpLf8OPghGa6sy/i
    kViyYre9KJlYYtzrRmR7HPp0dFZe/JidHM71iEMxCqhn5xOZFHR5LzeJs8hHJ7GV
    uVbjx7+cIaXARIcqeaOUUAS59y9g/qGo9idVbGqTmHmygF9A9GLtCBpcCUnVuJ4d
    +UHGfnMooXpWAIuMWcqQRbnwBrZ/NNcWP9UcqnYbFnKiAx2NcEaqEiJe5j6pUpjo
    0vxmEsY7QK3W4zWi5cPv1Kf2UqGnAgYFwI8Pup9jXA2HDKiPD5zO/sBJLaekCtM3
    Dn100DLVBw3ey1cRFmpIcjMy/y4UumDsJVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525387407; bh=FGN9fb7WUntN2ZOTkZqJIXMtrvXenH
    k32qGYuOBxStc=; b=Js+IPdB22mDNtNLyDik62wlpP2yjPZ3nIf5BDjpoDnm1T2
    faYcOTMw77g7kX+mXZBthxY4gvC0sQ+/eGmzCtT9lJelAsPq89K7+eFm2OuHOhbM
    4Wy8i6pEnNdy5bxSItNqHW4fHEd4++sQZCEfUGQeVFFnFJ+jziW+it+1GpOgp98i
    8STFpJaWl8qvFoBlOxJu99+CFCleUo3pWAmxchXblpcsHAbja1sU8C8Xuq8tEoMd
    b5s6TDIo7Dkg95S7mFeagYIJYBTeSq8br5G+GPwUaIAcG4IJpPZXDb3dvT0ykqlG
    hg3Ep6Ygvv2TXn2EInmFAMD5hPijoES3n15oAkWg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=fp6swl85
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=fp6swl85
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfORCob05obHcvn6z5svGhWXQQH5aBakA1CBtcBbaa8YTPV1wMveHqAcxmPLI/ch7lU2lio7mOnLY2op3Hm5p6EKjSFeuccKhsKwgIp0CrLi6a1gBAchZ
    XrEekRtCke4/erIVWYVlqNWj7KQrepg7DPahNE8y+lAOuleXL/QqWXyhBEOIORr626ijYmAMi2shwTydtSOEt0GtWikuKfFKNDmk4lWpfdNdX9Yj1guKHfte
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=yDi9mTBSSXKHG8BmxV0A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeECWnN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 18:43:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeECWnL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 18:43:11 -0400
Date: Thu, 3 May 2018 15:43:08 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Adam Manzanares <Adam.Manzanares@wdc.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fs: Add aio iopriority support for block_dev
Message-ID: <20180503224308.GA30823@bombadil.infradead.org>
References: <20180503182114.2797-1-adam.manzanares@wdc.com>
 <20180503183353.GC1562@bombadil.infradead.org>
 <47e0a519-37b4-f5e7-0616-8659d11c2b69@wdc.com>
 <18300bdb-a12f-0b6c-1317-6db3e4391d57@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18300bdb-a12f-0b6c-1317-6db3e4391d57@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 02:24:58PM -0600, Jens Axboe wrote:
> On 5/3/18 2:15 PM, Adam Manzanares wrote:
> > On 5/3/18 11:33 AM, Matthew Wilcox wrote:
> >> Or we could just make ki_hint a u8 or u16 ... seems unlikely we'll need
> >> 32 bits of ki_hint.  (currently defined values are 1-5)
> > 
> > I like the approach of using a u16 for the ki_hint. I'll update and 
> > resubmit.
> 
> It's intended to be a mask. If you do shrink it for now, then we need some
> guard code to ensure it can always carry what it needs to.

ummm ...

enum rw_hint {
        WRITE_LIFE_NOT_SET      = 0,
        WRITE_LIFE_NONE         = RWH_WRITE_LIFE_NONE,
        WRITE_LIFE_SHORT        = RWH_WRITE_LIFE_SHORT,
...

                .ki_hint = file_write_hint(filp),

static inline enum rw_hint file_write_hint(struct file *file)

#define RWF_WRITE_LIFE_NOT_SET  0
#define RWH_WRITE_LIFE_NONE     1
#define RWH_WRITE_LIFE_SHORT    2
#define RWH_WRITE_LIFE_MEDIUM   3
#define RWH_WRITE_LIFE_LONG     4
#define RWH_WRITE_LIFE_EXTREME  5

It doesn't look like it's being used as a mask.
