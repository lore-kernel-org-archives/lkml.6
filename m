Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1550609-1522351984-2-16227268756068791279
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522351984; b=cRdz3NiuvRIMG+k51iETyVWe3G4MQRQsa84Zqok6LTGs9QXmTo
    2j/qw5laOVguPckFUcLOXop1o5p56yKnqTRvD1TOjV4cvzr6bA88amaMY1uFu1Qb
    UfJ6YMG1D/Exv7+WluPmKVV1jQk5zndKkNVEiCAdg+Wfs9N9ANocvSyYRJWuMRP+
    voEbsodFQdTK8bExLv3njWWGa5x3ATNzS7nGrircW3URx86VhPncQj6O3eIIXK2N
    Ch1xNYE43E51gf1lsYXYurb8LwWPySlC2/CQ6LQZzQkC3U2yvaTg84h3MneKwVir
    eAb43M1VPWqZRdelcUOE0sBrE9Kl8ZDpk9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522351984; bh=rPmkdGy1oh82KjyNjNPl6phHp5HxgL
    xl47xbeqhEudE=; b=Cjy8+5zQuV3sHTvzv8hyPJc1Pm0oftBt8/K2R1IvmEnDTj
    vxHboczfsnohVLzXvS0yk5a3yCvvr64livqqGoyyhws5ZQjEaLINnuQTArrNMqe0
    q2z6lPg7skwYfsAOaJlCLS96gLIsMtnA/VHGKE//2987EfaeF4LAhtuUyHmPeb/2
    GdST8sMMJAEn4PSjNWuI5JFTj78CpfKdXVrIId7M620YaQ1K9se70UlqjrVMdhQr
    VQcGpCMi389XBoiZald1ddwpY/5mgnw1TCW6tq6ps297ch5bP279CV96HTMzUdYL
    48XNAVV5tPVxFXKc0VwzcjEXsdphkvx8TrhvKT0Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=YI5qilYK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=YI5qilYK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG8QFJuRnv9mW/VMs7MhwWFsESWHicrpilO+DW6x9fJ2FVJeF0cMDKXdXTT6nGCN6d5Kd6iWqMREuXTjABFgs3NMRAjBmueg9loKfbcZ4utfWM8a7JKA
    0psixjvXOHv8eD8gx7eSljr6zfu3DsDNRyJe4thG7+Ap5mJGif07YjDPIbk0AjCUE8pbm/Do2WSLcVwnhaeVN7GUSi1DBAJGKdXfnGFizBfobi1iLIhT0J7P
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=LjLFRuAdDJtPO8uKffwA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbeC2TdB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 15:33:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC2TdA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 15:33:00 -0400
Date: Thu, 29 Mar 2018 12:32:54 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stanislav Kinsbursky <skinsbursky@parallels.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH] ipc: Remove IPCMNI
Message-ID: <20180329193254.GA22300@bombadil.infradead.org>
References: <87o9jru3bf.fsf@xmission.com>
 <935a7c50-50cc-2dc0-33bb-92c000d039bc@redhat.com>
 <87woyego2u.fsf_-_@xmission.com>
 <047c6ed6-6581-b543-ba3d-cadc543d3d25@redhat.com>
 <87h8ph6u67.fsf@xmission.com>
 <7d3a1f93-f8e5-5325-f9a7-0079f7777b6f@redhat.com>
 <20180329021409.gcjjrmviw2lckbfk@linux-n805>
 <3e201de2-bed2-6f7d-0783-700d095142e0@colorfullife.com>
 <20180329105601.GA597@bombadil.infradead.org>
 <05772f83-d680-aea1-b222-cef2430dcc83@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05772f83-d680-aea1-b222-cef2430dcc83@colorfullife.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 08:07:44PM +0200, Manfred Spraul wrote:
> Hello Mathew,
> 
> On 03/29/2018 12:56 PM, Matthew Wilcox wrote:
> > On Thu, Mar 29, 2018 at 10:47:45AM +0200, Manfred Spraul wrote:
> > > > > > > > This can be implemented trivially with the current code
> > > > > > > > using idr_alloc_cyclic.
> > > Is there a performance impact?
> > > Right now, the idr tree is only large if there are lots of objects.
> > > What happens if we have only 1 object, with id=INT_MAX-1?
> > The radix tree uses a branching factor of 64 entries (6 bits) per level.
> > The maximum ID is 31 bits (positive signed 32-bit integer).  So the
> > worst case for a single object is 6 pointer dereferences to find the
> > object anywhere in the range (INT_MAX/2 - INT_MAX].  That will read 12
> > cachelines.  If we were to constrain ourselves to a maximum of INT_MAX/2
> > (30 bits), we'd reduce that to 5 pointer dereferences and 10 cachelines.
> I'm concerned about the up to 6 branches.
> But this is just guessing, we need a test with a realistic workload.

Yes, and once there's a realistic workload, I'll be happy to prioritise
adapting the data structure to reduce the pointer chases.

FWIW, the plan is this:

There's currently an unused 32-bit field (on 64-bit machines) which I plan
to make the 'base' field.  So at each step down the tree, one subtracts
that field from the index in order to decide which slot to look at next.
Something like this:

index=0x3000'0000
(root) -> order=24
          offset=48 -> order=18
                       offset=0 -> order=12
                                   offset=0 -> order=6
                                               offset=0 -> order=0
                                                           offset=0 -> data

compresses to a single node:
(root) -> order=0
          base=3000'0000
          offset=0 -> data

If one has one entry at 5 and another entry at 0x3000'0000, the tree
looks like this (three nodes):

(root) -> order=24
          base=0
          offset=0  -> order=0
                       base=0
                       offset=5 -> entry1
          offset=48 -> order=0
                       base=0
                       offset=0 -> entry2

The trick is making sure that looking up offset 0x300'1000 returns NULL
and not entry2, but I can make that work.

An alternative is to go to something a little more libJudy and have
mutating internal nodes in the tree that can represent this kind of
situation in a more compact form.  There's a tradeoff to be made between
simplicity of implementation, cost of insertion, cost of lookup and
memory consumption.  I don't know where the right balance point is yet.
