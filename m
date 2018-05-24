Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162272-2-1716791046784710917
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
    1527162272; b=DFo/83kNbGT5R45Fbm2Cit9NZ8R/HBqq+ONhbTbnVunWc+Yd8z
    oR4j8I48cQeGqNtKCxP4BNFJBaQZuqXmBUuhodST4Gliklj5d5MCvbes/+V1aB2C
    GJuy5JWgEB6OR5WbaIY75HFYGf6rg+jmWa9gMWjOR1BzV6ficfgN98IaUA5Z91qI
    bTmovFEW0/VSXuHPKRJnGKPEtRdzZhd9/IxcKpis9FgxGoxx2KD1QyzeeqwBjhdQ
    BFtxP/i1x4MlrdAK1VvQAtbHwqTVfgY/fbgzl8sKoUZAnLIIEF3gybNBZHQm6+M2
    a/OXIg6tv1RISd6nvMudB5AHlHzYC0rwJyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527162272; bh=4gX1zKWTEoIcJeAH4TeGwuuLnTRFus
    pzXLTk7L9LenI=; b=TvLhM8WJYOEZi2NiInJB8RRJvYMUTqyZ6NxV4/N7QxvowM
    GKGe5rZHKkLKBf+y832UmHllz25Vy5zB+T+pH/Cr7kAFvhXDjsXzRfJOCnMdzTTb
    aCn2BqYe47Zr60vGyDYoENyaXhWiVijMUl54cgO8/Lu7p+aX5BZ7kOlYbUpIRNzQ
    Uyo9L1082jzbwCnDEdwsA1nDyRJgPSbahVoPemcCj6ULBT+hLfs1SRs/7xXDbhoC
    FvRy5bdHr8wGAE0f/Fo3I8n9bWJ841TaTLX8d7lMLKkFW/FlYioDihj6D67u2wZn
    waZycYPAOJZQkbC75XakEKVd7Uh3PFAWNtilp4MQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=PwrtGmOl
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=PwrtGmOl
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
X-CM-Envelope: MS4wfEEDTzCahH5Ygy/FJJlfgsxf7SvRsMxmu8t5WPRW0OLTZruQK+ywO4j9Wo4pY6c0rMqBaofrgT14TkPcrS3D9zQhB+tyKvTAGuYwPOF4pC1d22MVebAn
    +DXFPM3cEq588jGvkA5AD9xtzYKTFaDN4c3VFpEB40Xv8Z2RmZW1ITpFa6da8i7ted986OglonE0tYqYqp3iGX4EX3pKC+x0wATZbVTyVKrCUNAe4R++T84r
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=wRUPlWvYR1ZCSrVlJS0A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967221AbeEXLoO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:44:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967191AbeEXLnz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 May 2018 07:43:55 -0400
Date: Thu, 24 May 2018 04:43:50 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [RFC PATCH 0/5] kmalloc-reclaimable caches
Message-ID: <20180524114350.GA10323@bombadil.infradead.org>
References: <20180524110011.1940-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524110011.1940-1-vbabka@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 01:00:06PM +0200, Vlastimil Babka wrote:
> Now for the issues a.k.a. why RFC:
> 
> - I haven't find any other obvious users for reclaimable kmalloc (yet)

Is that a problem?  This sounds like it's enough to solve Facebook's
problem.

> - the name of caches kmalloc-reclaimable-X is rather long

Yes; Christoph and I were talking about restricting slab names to 16 bytes
just to make /proc/slabinfo easier to read.  How about

kmalloc-rec-128k
1234567890123456

Just makes it ;-)

Of course, somebody needs to do the work to use k/M instead of 4194304.
We also need to bikeshed about when to switch; should it be:

kmalloc-rec-512
kmalloc-rec-1024
kmalloc-rec-2048
kmalloc-rec-4096
kmalloc-rec-8192
kmalloc-rec-16k

or should it be

kmalloc-rec-512
kmalloc-rec-1k
kmalloc-rec-2k
kmalloc-rec-4k
kmalloc-rec-8k
kmalloc-rec-16k

I slightly favour the latter as it'll be easier to implement.  Something like

	static const char suffixes[3] = ' kM';
	int idx = 0;

	while (size > 1024) {
		size /= 1024;
		idx++;
	}

	sprintf("%d%c", size, suffices[idx]);

