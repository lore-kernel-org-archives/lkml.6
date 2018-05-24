Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2150367-1527175836-2-9129717483632134312
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
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527175835; b=LRYy4BCRw95YiylbT+3V9D5UgFF3JOxPtJR4ZMMyBo8JhtI7p7
    uocU/ukdh87v6RHqYhh/pQZ8c7nGYN6yxC7tjfSXRU0NwiiZa5kACksH/21TR+E0
    du8oQDJQbDdUTYylIA6rI7ib6TL6S32I77RgxTKO/aIgW0LomfweYjwntuM3RVcL
    2r0AJT+v3EgNay/7kB74jOXMwd2/oor49dCjF92oZQ8h7wNn7y9R3CPbtim3DnRj
    TD2M1jqCZV0dl5efesSkwZ2ke/8AVzmFfRht1r1S3fiTLBA93VOqB+3ieJG9V5EQ
    Acajs6BkXgwgOODkb5/Px2c4N+L897Zjg1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527175835; bh=HK+UlldLSaISAJyFYpFGosBGunHmCw
    pvYWwVK8L4R/4=; b=MzaNx+6JUDx0HQI2hATw8KHMxV0Gro1K3GwfMNH+NbRx/L
    xxwnNHHQYzs7AN/QBHdb+cDfF6TMRVgxLUxnhVPXsAqaM66XqLZLlNx9JzkIlTQr
    /qfG84fKPmnyo7YOGc4FL8pvZsJlRnazxn3m+LB1m4WFhqMm1o6BDh9xGzvqoK6Q
    HmHjYXTo3TLzTIY59tkXnGjB6Eic7m7fZ/y58WDxzeJFiUSNtGiql8W0tmA0g3lj
    9cad83ScE71CGIjZ7EMEwtF5dxdsd5uXyehFNZyBwBqOUXVwgUax4iO2xKg23VSr
    d2nsw2PxvfjiXW5XSg/nb4idUFwShFJgmly2Hl0g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=cmpxchg.org header.i=@cmpxchg.org header.b=LRFATiHg
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=x;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=cmpxchg.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=cmpxchg.org header.mx.error=NOERROR
    header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=cmpxchg.org header.i=@cmpxchg.org header.b=LRFATiHg
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=x;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=cmpxchg.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=cmpxchg.org header.mx.error=NOERROR
      header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGO6FkvaAjGYhJygxirXjJDQKs7AfIjgGgDDqChzkBzPCzeuTpLPVMHerkDT6kaS/lfhsWtB6SGpGOG/HnxGpWpbCx/9Eog3AgBwbhOWh3Ou0/ExbytK
    eqcRgAe4nTBQeC2hMjaX2wmWUhbreO+H3cm7VhZGKfDNJcJRI8lhfLV7WGJfmIi2r2m21QZlhWxrS6/p6Qszb/uB813sDC2Yiv8J++Xc7+KCw0+HJRGc8UJG
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=QcGLD7kE4u5gkqeYnBYA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967120AbeEXPaa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 11:30:30 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:51978 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966698AbeEXPa3 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 24 May 2018 11:30:29 -0400
Date: Thu, 24 May 2018 11:32:25 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [RFC PATCH 0/5] kmalloc-reclaimable caches
Message-ID: <20180524153225.GA7329@cmpxchg.org>
References: <20180524110011.1940-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524110011.1940-1-vbabka@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 01:00:06PM +0200, Vlastimil Babka wrote:
> - the vmstat/meminfo counter name is rather general and might suggest it also
>   includes reclaimable page caches, which it doesn't
>
> Suggestions welcome for all three points. For the last one, we might also keep
> the counter separate from nr_slab_reclaimable, not superset. I did a superset
> as IIRC somebody suggested that in the older threads or at LSF.

Yeah, the "reclaimable" name is too generic. How about KReclaimable?

The counter being a superset sounds good to me. We use this info for
both load balancing and manual debugging. For load balancing code it's
nice not having to worry about finding all the counters that hold
reclaimable memory depending on kernel version; it's always simply
user cache + user anon + kernel reclaimable. And for debugging, we can
always add more specific subset counters later on if we need them.
