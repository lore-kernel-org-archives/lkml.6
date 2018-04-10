Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-232218-1523382621-2-2366632031577556850
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
    1523382621; b=YKYRoFkr0+455tJnOLgm4YOf4Tyclo/P2T+OSl3AQ5+6W54Fnz
    hGIDIZX3+8Z0LDb0a9CZofDczSUbent0FL84wXHiqb9yPrT4PhgSU/HNyZolYXeH
    YjTBf+N76TxrsoKxrthj7U42s5W24rGK2KHc3j5w3Q/Hehkq73WMqcIP9TkJeX2b
    +zSFzwD4OzisKl62Sx5RqNgFNdF68PGUOqJoCdywHeFBIWMLnOl1Z/Yj4qweirza
    7loyodo5BiOmUwXcRkAvMBjCYaaG4lyt14j9+k+qwtieb8bVQOqL99qpEaQvjY8j
    g0/Ia0/MS/Mtbert5+qy/O5hRYbkE1izwcVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523382621; bh=NUNO9Otb8hTTOGCRIST+KcbjG1LhiR
    J0GxSg3C2vGh8=; b=O+qrzyVenPOLHkcC9+lKvHpkHSa1i4R3ePY19plCLV7tKh
    jLY3br3UnBjgsvJjbV86Lqu9cImzy+TUm3hfy4YhOLp5ddzRM7fOUgrSEqa2v8Me
    coO86INA6BOD+C92KGCkYwb9bIHwTb9odEsLlLkkFKXFFOeAblIVFvG8KEzut/so
    +g6GKIzP2jSGxrax0isoKrlmezAY0S5iw3Y1dg5KnOUkxOYCWLUEIaCyCRXL9RaU
    W24Gzg0bbr987t0Ou41bXHOdL5mDKVVEwCSNIvxjOS4J+BZFatc0mwtZ8zYHWUvs
    9WkazjFuG+W9Etg8oMNjC6IaDruIdCfPsMtWuBNA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=uBBc/TlQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=uBBc/TlQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLqsMHTF0ZgfcEX8XpjSKHVQ/Bwio6uCdfOs+KD2krEEvg0ixMe2dC8zExDZ2/uBToi6rqexCy6ccDSqkVCzVBnrMkO8LJetM5m15r9K/PpgyebiFx81
    tMOghRBPVtAHLBBumPg4m6ePe4P8rWMxur5P4y4F1ZllYdb1Tzh03jSlgA+WUQRBzrUuF8yAnwNpVoyuUcrE8PaL9LxfU3W11vlAPGc4JtYhmo+YS7hCYCGg
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=xN8ltio-l2Sfhr8kte8A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeDJRuU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 13:50:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbeDJRuT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 13:50:19 -0400
Date: Tue, 10 Apr 2018 10:50:12 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Christopher Lameter <cl@linux.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, linux-mm@kvack.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] slab: __GFP_ZERO is incompatible with a constructor
Message-ID: <20180410175011.GE3614@bombadil.infradead.org>
References: <20180410125351.15837-1-willy@infradead.org>
 <fee8a8bc-3db5-a66a-33cb-0729143ba615@gmail.com>
 <20180410165054.GC3614@bombadil.infradead.org>
 <alpine.DEB.2.20.1804101228170.29384@nuc-kabylake>
 <20180410173841.GD3614@bombadil.infradead.org>
 <alpine.DEB.2.20.1804101244290.29559@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1804101244290.29559@nuc-kabylake>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 12:45:56PM -0500, Christopher Lameter wrote:
> On Tue, 10 Apr 2018, Matthew Wilcox wrote:
> 
> > > How do you envision dealing with the SLAB_TYPESAFE_BY_RCU slab caches?
> > > Those must have a defined state of the objects at all times and a constructor is
> > > required for that. And their use of RCU is required for numerous lockless
> > > lookup algorithms in the kernhel.
> >
> > Not at all times.  Only once they've been used.  Re-constructing them
> > once they've been used might break the rcu typesafety, I suppose ...
> > would need to examine the callers.
> 
> Objects can be freed and reused and still be accessed from code that
> thinks the object is the old and not the new object....

Yes, I know, that's the point of RCU typesafety.  My point is that an
object *which has never been used* can't be accessed.  So you don't *need*
a constructor.
