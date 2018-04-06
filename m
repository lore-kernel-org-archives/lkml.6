Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402127-1522990719-2-2398262828294141953
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522990718; b=vqCBCssflqceOSTFplaQ5uqHT5dKIS92LuL5btaB/c+wvxpY3R
    S8lxGl/6WP67mruEKgCFSr3n3uu3XlCRhGfFFi3IDsLayOnhDR38o+PpAoKPndNu
    COjNLJFzdnPLjTT27v0GsmDqBbIveVl2BfAXQkg20DU/ExmJJgkb64ICMfjQ/NHb
    1YzPRFJRQUz9xIq8vx3URZUM7sDIhVmMcz9BukQUA0AyQXcqi1jxpBXIM2dmZNAW
    +ykcvPUIvc8+KJ9dcFonNbLIrMmVsILPPFId9TFzYyha5FalN3nS6W+v34DwHxAp
    f6h0dWbwZFQrTMoLZsjL6Uuqt6EMKM/1YldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522990718; bh=Dh4hwgu6pHWgf5GFvkjsDJaVyWwLXn
    pBTz7wZyAMNUI=; b=r1NWEgNVJufwz3NLK1vw1+iOAJv/QaxplZ9u4p25esrfSq
    GiVeC/iDGUkh6TDUW22APyvc5R8RCjx1fQifzBsDayPEXHWxSgfnKRVqDWoIy97X
    vOFaE4yEkP7ds35zPomJdi2P6VGmBp1FAK85+2a5sTrHt395e63ub1rDvUsw96qI
    iffSvCfc6AOOabkwqYpi3J4Ep+AZAhnobbBEzwI/YHU/Ble3JcYZlW3G8GngojZ2
    ayGCp5rUKFPY/P3yUkssTrRtjT1Uxxx61LrZ55XtVGRyXuWb1kOtzzPv/qrAjLlW
    cwZ46Et80JfppQSTnegHL3a3fNU6rNX2gmavkSTw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfMtvQrWJvGN/pWr/j2T6+y+7+BRjk59okdYdf5KXOn8QQw0OR4ieYS843g5sHNP6vN5/AhVaGoEHeyXCkiG4YOIUYcZyzTTGLUIaxmkz7Kl7egq2c7ZO
    rbpzfGGqP22OC50xrZxsdobRtnVVGEKWdWQ3JYgWUfOIjRhKAXn5fy/YXS80bJ2wWGuwnKpj+pryGl3emTYPkNTL40HIde/K+aHbnGi9MUGq1q2eqa/aPuRK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Newdxa483icPIVLupAoA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeDFE6h (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 00:58:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48582 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeDFE6g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Apr 2018 00:58:36 -0400
Date: Fri, 6 Apr 2018 05:58:33 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/32] fs: introduce new ->get_poll_head and ->poll_mask
 methods
Message-ID: <20180406045833.GW30522@ZenIV.linux.org.uk>
References: <20180330150809.28094-1-hch@lst.de>
 <20180330150809.28094-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330150809.28094-6-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 05:07:42PM +0200, Christoph Hellwig wrote:

> +  get_poll_head: Returns the struct wait_queue_head that poll, select,
> +  epoll or aio poll should wait on in case this instance only has single
> +  waitqueue.  Can return NULL to indicate polling is not supported,
> +  or a POLL* value using the POLL_TO_PTR helper in case a grave error
> +  occured and ->poll_mask shall not be called.

> +		if (IS_ERR(head))
> +			return PTR_TO_POLL(head);

> + * ->get_poll_head can return a __poll_t in the PTR_ERR, use these macros
> + * to return the value and recover it.  It takes care of the negation as
> + * well as off the annotations.
> + */
> +#define POLL_TO_PTR(mask)	(ERR_PTR(-(__force int)(mask)))

Uh-oh...
static inline bool __must_check IS_ERR(__force const void *ptr)
{
        return IS_ERR_VALUE((unsigned long)ptr);
}
#define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
#define MAX_ERRNO       4095

IOW, your trick relies upon arguments of PTR_TO_POLL being no greater
than 4095.  Now, consider
#define EPOLLRDHUP      (__force __poll_t)0x00002000
which is to say, 8192...

So anything that tries e.g. POLL_TO_PTR(EPOLLRDHUP | EPOLLERR) will be in
for a quiet unpleasant surprise...
