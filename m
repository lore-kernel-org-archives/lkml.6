Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2363342-1527187749-5-18132923248922062897
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
    1527187749; b=lvEZxA3WTceS0aVfNnzeF7ofBgu6fev2w2rMSt9JBdqSadB/Nx
    2t6vj8NgOQRFiCru3YpQY0yKSc0dD3NaVSGZW7Pvg8x/QihNjZchfG28aPJp07xC
    ViWJG6Qpw90xvqN2KAGaipExG3B1CjYKoAmVQON9Ts8oVfJmLDw9cg3CpYPRM5dN
    TcdXJ7iQMxZSfGMXYsr7g0CkV0V+NYXn4U9fvaobAo1YwNqW6R6BcFJ9E+2lIuph
    FfVzQklVFbnzIHuFTm13/BXF7jx+e2F9AhsCm/J6bA9QwCh8HO4UvcFP4fyJbNgg
    eUSDMP9hKxhILr2IgSx8D5kRrh361p/As7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527187749; bh=7m+gXG6jGdu3yAYTY0UCoT9T6edUBu
    AqmbvoTgcXDqE=; b=G4OoLpMyzuGEDbeIGXzdDRQqvFoiE3IAlWdF5Rhjyn6jcn
    dBG47MNLJwswBPA502O5oVsOEnWOL9SMKmGaLwq0vKnyUfgk4nYxKnTff+nSNNBE
    TAmagnQucm23Av+BK23D5PKtxu8KoC02RlCCxaobm7BzddnVRs5LwqhHn8UK/nKW
    lcdTAzxnqafdZH1/MSUy5RUS7w3bapwsku//xgZzyg9xeShpblTG5wYJWXQ1oJED
    l0bGIwj4vXPGpe0G4YvKOdn/qCJKjRfvkb3wlEwpqBigRef3cCO5oXOvNF7rigaA
    EqVskZVJOlxmvemdgMzsuHj4K0pUr4Lu390lIPzw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=k7U0mTUV
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=k7U0mTUV
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
X-CM-Envelope: MS4wfGE3/u7/5wY0jO7HjhcRCvkuAnODttezA+5Rf1n82+xbrZ2qSmb6CZLf8UCSqri3edsTsuV222KMSeoFA935uZQ1yWP4od5dChxsnZbh98/xco1AYEvp
    mrNKWFgnW7GG/7uzNS3ndVKBR+ZrMua/nK95V6g93UnimkYKx8OnvjSZMxvmYjifuOLGCK5Do6pWDfXDRMJJyJEmCtMtXc4HQFS9svQSwaoRl/9D5LWJIyXI
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032904AbeEXStG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 14:49:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034342AbeEXSsx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 May 2018 14:48:53 -0400
Date: Thu, 24 May 2018 11:48:46 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [RFC PATCH 0/5] kmalloc-reclaimable caches
Message-ID: <20180524184846.GA5459@bombadil.infradead.org>
References: <20180524110011.1940-1-vbabka@suse.cz>
 <20180524114350.GA10323@bombadil.infradead.org>
 <0944e1ed-60fe-36ce-ea06-936b3f595d5f@infradead.org>
 <cfb7c8df-2a6a-bf84-8a30-df97c58c9c47@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfb7c8df-2a6a-bf84-8a30-df97c58c9c47@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 11:40:59AM -0700, Randy Dunlap wrote:
> >> 	while (size > 1024) {
> 
> I would use   (size >= 1024)
> so that 1M is printed instead of 1024K.

Yes; that's what I meant to type.  Thanks!
