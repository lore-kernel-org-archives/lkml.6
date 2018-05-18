Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3810906-1526643669-2-2566225593706042131
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526643669; b=BUuZbPK0JdQL/Ipgb8zfErA4M4UjC+ReTs6tokdbot54kfKq6+
    8U/HE5xJ2OcWBwkM0R1iUqv+Hs6sybcK89C3Gj4LNKZq7ovKqFzZEf6cuiw+RPi0
    VIATfPg70NRQoOizCVAUz2Q6vwAZrewAL7KDdM6kPwR3TWMoUn2/PN3aST3F5PCi
    Fbz0vYyPIjC/1VHEc+wUVNlQ94/SqCwOddmcCpGSIdlzKOhoK5MxLUQacba435OS
    QoZR7q3SEXqelGBSLBzp4gkrkVktsi+Aq8AiR7jxH2rRPA27UJVxBuVi7WT6KqeJ
    qgC7G0PsfUbcsIdsc+LOyJqrN73tWPBy6Wgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526643669; bh=74FyZLfaJ0LtW4Kj84F4pg2eThHoOX
    xrgDOrh0yeMzE=; b=BzRooDyyHXN14oLoKKXv5QIbbSm/WodYbaJ1Aa+xL9vTxX
    t0LReCTMsLB5wfTMuzfr9omDMEUcj74YF7SncASQ5PRSDcPjm/VYvP4oDpNVJ+hx
    BI4le0sXJYQpwV+A4rbMC4TlnF8D4/Lsz08hRLSVtBnZaTvTQAJD/6sPQnJS5a0Y
    y7qMdr5QsM8yQRLUVU4zzmJh2egG0BtrX24vTiE+EWufqxTXSgMfy6WBqoDl+Alv
    weX+9GhRzvkeIjDkfWdddpxSdErciuIM7YUfbtY4Wu/+2SfWWC3AHH2rhuHxMC5u
    JO2Fd3btIHCYApI2WeR48BO+omF33jbuCAGmkLhQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=K0y0rIid
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
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
      header.d=infradead.org header.i=@infradead.org header.b=K0y0rIid
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
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
X-CM-Envelope: MS4wfLxgqIWuZBQm2XXG5TL9o+fhd5Cq/quNwlPn8cHC+I9ev5RDkeIuMj6SOEPSOeqSODLT70JG4+IsoT0FMPrPwcUsxZBoZH+a1uMcMZB3Im6MR39cvN2k
    a4oIu/eCM7fcpQ8OUciIBNn9kN5RvPwRHcMNePYfSY/mgWnlbws+KIQOES8krq2wamC5niLsLM6Oth9zEGX2Hr4kjc3OkaYpBz1ZLXDOmhMA8AX9pI5JAfA8
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=FLlGziuUmqVkNfK-0q8A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeERLlG (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 07:41:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeERLlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 07:41:05 -0400
Date: Fri, 18 May 2018 13:40:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com,
        jbacik@fb.com, viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 04/10] locking: export osq_lock()/osq_unlock()
Message-ID: <20180518114054.GJ12217@hirez.programming.kicks-ass.net>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-9-kent.overstreet@gmail.com>
 <20180518095204.GF12217@hirez.programming.kicks-ass.net>
 <20180518101804.GB15403@kmo-pixel>
 <20180518110808.GH12217@hirez.programming.kicks-ass.net>
 <20180518113205.GA16943@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518113205.GA16943@kmo-pixel>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 07:32:05AM -0400, Kent Overstreet wrote:
> It does strike me that the whole optimistic spin algorithm
> (mutex_optimistic_spin() and rwsem_optimistic_spin()) are ripe for factoring
> out. They've been growing more optimizations I see, and the optimizations mostly
> aren't specific to either locks.

There's a few unfortunate differences between the two; but yes it would
be good if we could reduce some of the duplication found there.

One of the distinct differences is that mutex (now) has the lock state
and owner in a single atomic word, while rwsem still tracks the owner in
a separate word and thus needs to account for 'inconsistent' owner
state.

And then there's warts such as ww_mutex and rwsem_owner_is_reader and
similar.
