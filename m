Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3875449-1523366855-2-7463072017595427660
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523366853; b=h60LDCnxb+SCVx1yNWzrxqtubsaI/EGBulxh7nTuTtz+qY3UMG
    VWNNQ4V0Q9y9zZgcZuXUJlWFP0WyhsxvTDGlz18uA4vPtfbMTOejjwYpMYfmN1Eu
    kJhRCAjveJwnAbdX8QBC/DrC5whWwKguxeI8iZY/oexW064tRNoVDM9f5hClChOA
    1ZoyWJrd3TuL41rS4gWOQNkyKVhoFyMfqNsIGy6fag2zEM5dA4JgY/lR/vi09dQ6
    KR1tCZvIDQVsYY73pq5239qQsnHrvzifVF7sD0SoAWBq4qOcyfJ0dJnNoHHMZso/
    qR65UYVCLm6f5r29r+MaJn/GC6KmfNf7dCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523366853; bh=kunZC+qenBih+JDW7yYSjE/qY6D7Uz
    n5UlxjlxO2N0k=; b=BsW4v5JOyBwwIfdtog5Yink2zq1f1Rsc1r5YY/mg2JbrQB
    KteQV/iIm3nzhe5/mcHkEaPe+Eb5wNzHxGYxiKuvlVf5b2Tj+dQ7GO5U2cxXgnlj
    6rqWmvou3P+KpzKdNw0MjlSYpruYteRrekFAiJ4Rroz+KKeBbpbQrtCQnE61tqqg
    EnF6vgj2MNTr8H8T9KKtSqdncnGJpIeDSuzkw1M79Fikx4QWZFX/zKlkS3V6IyAY
    KpY5vj3qink4Y0jiGXmUkWF2nsNQ1o17aVo/L/l8IKnbXlc2tHi70KRyZcXp9+9l
    5sKgoEI5XDsc+qEY+f7VK2agwmXbHuSSvgmNfrCg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Iu5Ioszq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=x;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=cmpxchg.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cmpxchg.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Iu5Ioszq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=x;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=cmpxchg.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cmpxchg.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF7le3Usb6JqoVcKIvWmI7FE51u3BJhQ0LeyRcTow9G7CxB2YwzFmi546S/ltlHCnY23hqEO8fYIgcshwKyGwyoixOWrZM3Mp+BNcFoGzqT4GR1cVk12
    AXYhc14+tyIZW+uK5URkunZpzZRO8CpsTqvorSItR1ih81hL7hQrdGWMqV0WohIWGG36wUUxoHihGMna0KVN55QxHRyhd/n2JA5/R2/gJjljVEN8f0fVH3+I
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=ufHFDILaAAAA:8 a=pidHIxcN53k2Xu601f0A:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=ZmIg1sZ3JBWsdXgziEIF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbeDJN1b (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:27:31 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:50980 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753425AbeDJN1b (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 09:27:31 -0400
Date: Tue, 10 Apr 2018 09:00:19 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] slab: __GFP_ZERO is incompatible with a constructor
Message-ID: <20180410130019.GA7010@cmpxchg.org>
References: <20180410125351.15837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410125351.15837-1-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 05:53:50AM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> __GFP_ZERO requests that the object be initialised to all-zeroes,
> while the purpose of a constructor is to initialise an object to a
> particular pattern.  We cannot do both.  Add a warning to catch any
> users who mistakenly pass a __GFP_ZERO flag when allocating a slab with
> a constructor.
> 
> Fixes: d07dbea46405 ("Slab allocators: support __GFP_ZERO in all allocators")
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: stable@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
