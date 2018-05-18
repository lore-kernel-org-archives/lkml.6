Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3810906-1526641431-2-667816158841259354
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526641431; b=Va4vMT9omL2lypTrmPtB0X0ewIelSf8btx8PTWIoET1m35FgmE
    Th9Fsg/9i9P44Q3AdUyxGzWC8LBzzXb3EMsy3RBUpJujj8CPslkfZSNf5JhVWfMf
    1LeJVvAa2RAWkyUIfF44QgPc5jD2utv5l6dZ0XaA0p3yhePr7OHjPMECzBjKgxYK
    YiLuHF7Rq2sWLkX1nWQQx9SQp/xwr9v2mYvvF+dFcQgCuw/hI0DLPNqokr6vr78L
    FTg3AHKCfbHdgtiCQBpDdYYh+4gn3AkHjzcjmB3sSciYPW0DSeLiL0q5UgDiePcS
    vEkV5RchUxU9NbFcsZD562JCUB9+VUGWADDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526641431; bh=Bff/CV9RjpGaONGsbsCoQpAXWlka2O
    wCUrwZpasJBlE=; b=dRSjUYqGjPDdPiDNFTxabqiXRm5prY/48kXUTnGuX4Pwtc
    K+Dw3aw0cnrs+pCfTLRS3QLBhVSbZFzY6uyEyVk+7YO1DcPEW42MhcQqJZY2Gg57
    JKYdRfW76TO9IjjHZe31T4x6A53O94dpHoiIhk2gfYGsCmy+UrN14R22v3pPY8EZ
    w8Mkmw/uw1LyzjZa83aYR6/z44z67v4HwjeqDuTCd8owXQAcTch1S+1IFjF+SQZa
    buHCgg5sxHDG64ZNvwHbaizpsoa4S0tgl9QXX3HsfbgtfOcpM6LSfMRWs71WgcIT
    YaFGlDE/I+N5+8nbSANzwo0hF7oYuh6CLUOB8Z+g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=Bj2U+lhx
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=Bj2U+lhx
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
X-CM-Envelope: MS4wfAQXe7Tfobr38C+CjkzICI44Yq/mBaGBdolZgJhPTLoh8BR0FEdwW9MOoo/h76K5dazRhu2Z3S80vCZIaAboxgthhHO6dT8Ld6t8c/Tc8Rj6CMTdkoUS
    GuMjfGtxNERyHNg0UgLSxJ9buyFHB9FNmNFJDmwi2XpaRF9U4TWJhWogyuCmDdabLd343U8PkwkOhq2V/i00hk/4znM/sZt5o3lErxy9Ga+LC7tFL5Y743/X
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=V70b4EMvaU4CbwgBR5UA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbeERLDs (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 07:03:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERLDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 07:03:47 -0400
Date: Fri, 18 May 2018 13:03:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com,
        jbacik@fb.com, viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 03/10] locking: bring back lglocks
Message-ID: <20180518110339.GG12217@hirez.programming.kicks-ass.net>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-7-kent.overstreet@gmail.com>
 <20180518095102.GE12217@hirez.programming.kicks-ass.net>
 <20180518101353.GA15403@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518101353.GA15403@kmo-pixel>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 06:13:53AM -0400, Kent Overstreet wrote:
> On Fri, May 18, 2018 at 11:51:02AM +0200, Peter Zijlstra wrote:
> > On Fri, May 18, 2018 at 03:49:04AM -0400, Kent Overstreet wrote:
> > > bcachefs makes use of them - also, add a proper lg_lock_init()
> > 
> > Why?! lglocks are horrid things, we got rid of them for a reason. They
> > have terrifying worst case preemption off latencies.
> 
> Ah. That was missing from your commit message.

Yeah, sorry, sometimes it's hard to state what is obvious to oneself :/

> > Why can't you use something like per-cpu rwsems?
> 
> Well,
> 
>  a) in my use case, lg_global_lock() pretty much isn't used in normal operation,
>     it's only called when starting mark and sweep gc (which is not needed
>     anymore and disabled by default, it'll eventually get rolled into online
>     fsck) and for device resize
> 
>  b) I'm using it in conjection with percpu counters, and technically yes I
>     certainly _could_ use per-cpu sleepable locks (mutexes would make more sense
>     for me than rwsems), there's a bit of a clash there and it's going to be a
>     bit ugly and messy and it's more work for me. (this_cpu_ptr() no longer
>     makes any sense in that case, so it'd mean auditing and converting all the
>     code that touches the relevant data structures).

Well, lg is a reader-writer style lock per definition, as you want
concurrency on the local and full exclusion against the global, so I'm
not sure how mutexes fit into this.

In any case, have a look at percpu_down_read_preempt_disable() and
percpu_up_read_preempt_enable(); they're a bit of a hack but they should
work for you I think.

They will sleep at down_read, but the entire actual critical section
will be with preemption disabled -- therefore it had better be short and
bounded, and the RT guys will thank you for not using spinlock_t under
it (use raw_spinlock_t if you have to).

The (global) writer side will block and be preemptible like normal.

> If you're really that dead set against lglocks I might just come up with a new
> lock with similar semantics, that doesn't break this_cpu_ptr() but sleeps if the
> global lock is held...

See above, we already have this ;-)
