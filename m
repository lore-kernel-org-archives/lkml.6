Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122452-1523375693-2-6214689831831719446
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
    1523375693; b=ZHA1L3VCf7pFvIHp/rqybgZLG6yMXG9X01bvGyWi/YlEdVV4i/
    MzTYRN0NfP17vw9EppYz8GSEvjv0J2Uv1vr3+WhPzagCOl8xR869rgVOsETl3nQK
    p1Mxc+YADWlJinQBjZuha4E6k5sJhszH/04C8W5OVwLyfFEZnWa18M6T2ukWAz0X
    16dGEgu+EM/9tElCcQIJomuNSOUTo873My1hA3V6z8n+5A7zEdrxgp7u87CbvF2l
    eXt6x09a74yFr4G+J0DGK+BF7PdSTsMhi9ABHSoXN4DsalQnpnySpfufNtlnIFv9
    DQfJQM6i0GMgnNK98FrpO3Jab6eGCYL0QgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523375693; bh=ww9jeD0SPfkLHAkVXFjk0yNzna8M24
    +owQ7cUnT0cAM=; b=npG8S+gpZWjAuKe+yOD0pd0J1uOJZ51QWyjxJUdqcH8VAj
    CUX9IQPPg3JvbL323XpSdlrxftSlm2bVNlK7PaZfx83AsARz9HnicNa1IhkBXzTc
    Hc2Ma+C655UTYNC7jdlsEMflbdNfTZrTQorRUVBURicNvKoJ7x4di9D6Op+C2Qab
    OkNKsVKP/Tmkg7vZqS32D8hHEZGtXx35yhRCGT7I/0INrckJzXzNEIfvAVQR5C7o
    BSijgh6TtwzTin6rwEtnemLGZBhdUaOcTb31kevk5pbsoWVaZqqGEGRjYawldAmP
    U37cv19m5tguclIrcqu5YJi/f/Vbt8F625Hz6klg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=YxJXmA3j x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=YxJXmA3j x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPeM01usgjKZpnd1VHeixGorvO+PfuFVgHglXqPx+A9sTvGI71Ks2gv0TvYNzptabWq2Z2AHEx1CJbk7P1pu5ezstQqzQeqD6Yagyt1dWkoqtwplYpor
    34b0M/cyr+ZJKUnkQulYCw8ZF+k+HhTmizpqxl/56vBT2Z+InHWzqN/QmOZI+lyGez7qZXEOdjjPr9wSxfeVqt8n0JN1ZxK1JGw7IaveADWVDMlk7UbC4FCu
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=iAy7VxL0fzUZG5eXi50A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeDJPyu (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 11:54:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbeDJPyt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 11:54:49 -0400
Date: Tue, 10 Apr 2018 08:54:42 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Christopher Lameter <cl@linux.com>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] slab: __GFP_ZERO is incompatible with a constructor
Message-ID: <20180410155442.GA3614@bombadil.infradead.org>
References: <20180410125351.15837-1-willy@infradead.org>
 <alpine.DEB.2.20.1804100920110.27333@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1804100920110.27333@nuc-kabylake>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 09:21:20AM -0500, Christopher Lameter wrote:
> On Tue, 10 Apr 2018, Matthew Wilcox wrote:
> 
> > __GFP_ZERO requests that the object be initialised to all-zeroes,
> > while the purpose of a constructor is to initialise an object to a
> > particular pattern.  We cannot do both.  Add a warning to catch any
> > users who mistakenly pass a __GFP_ZERO flag when allocating a slab with
> > a constructor.
> 
> Can we move this check out of the critical paths and check for
> a ctor and GFP_ZERO when calling the page allocator? F.e. in
> allocate_slab()?

Are you willing to have this kind of bug go uncaught for a while?
In this specific case, __GFP_ZERO was only being passed on a few of the
calls to kmem_cache_alloc.  So we'd happily trash the constructed object
any time we didn't allocate a page.

I appreciate it's a tradeoff, and we don't want to clutter the critical
path unnecessarily.
