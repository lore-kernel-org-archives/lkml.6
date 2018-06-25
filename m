Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52833C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FB3259D4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BrIjbdD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FB3259D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755515AbeFYNBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:01:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755411AbeFYNBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vZX8jYOWO3a90wCemC9ahigb6/SmMgNRcEPmtmnRURA=; b=BrIjbdD0n6DazM0FFELolQaJK
        UaThofzbBDfyhs8G4Y2GcOy0M6UZshi2mResO8ysfJRYnnXHhtJ2uGSROhq0K4irQtyqGg041BH6A
        ovobXxSSva84nB2yTNmkANVzHlExmg/gYUsY2bW2Nn7lpl7v6CqvaacYcl1e3tq2Cr+I6xdbp5CMD
        JTScTXz/JZBnOH1IBgY5bIpz2Xe8HLtWJYAbSo87GN9BoYSQCXsu3V+G6rxHOB6vYksjJwsEOStMq
        MRs0gUWb9j4IBN0VlggU6iY+oKPXeT90eIMI6rKnBLKh2PwRLVFQJQmFH+54NbWUcSmPjxOQL1Ago
        VTtMwMEgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXR6z-0000CJ-6F; Mon, 25 Jun 2018 13:00:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A72F92029F1DB; Mon, 25 Jun 2018 15:00:51 +0200 (CEST)
Date:   Mon, 25 Jun 2018 15:00:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] doc: Update wake_up() & co. memory-barrier guarantees
Message-ID: <20180625130051.GA2494@hirez.programming.kicks-ass.net>
References: <20180625095031.GX2494@hirez.programming.kicks-ass.net>
 <1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com>
 <2779.1529928765@warthog.procyon.org.uk>
 <20180625122850.GA14561@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625122850.GA14561@andrea>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 02:28:50PM +0200, Andrea Parri wrote:
> On Mon, Jun 25, 2018 at 01:12:45PM +0100, David Howells wrote:
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > So yes, I suppose we're entirely suck with the full memory barrier
> > > semantics like that. But I still find it easier to think of it like a
> > > RELEASE that pairs with the ACQUIRE of waking up, such that the task
> > > is guaranteed to observe it's own wake condition.
> > > 
> > > And maybe that is the thing I'm missing here. These comments only state
> > > that it does in fact imply a full memory barrier, but do not explain
> > > why, should it?
> > 
> > I think because RELEASE and ACQUIRE concepts didn't really exist in Linux at
> > the time I wrote the doc, so the choices were read/readdep, write or full.
> > 
> > Since this document defines the *minimum* you can expect rather than what the
> > kernel actually gives you, I think it probably makes sense to switch to
> > RELEASE and ACQUIRE here.
> 
> RELEASE and ACQUIRE are not enough in SB.  Can you elaborate?

I prefer RELEASE vs wait-condition and treat task->state as an internal
matter. Also note how the set_current_task() comment is fairly vague on
what exact barriers are used. It just states 'sufficient'.

Maybe I should just give up and accept smp_mb(), but strictly speaking
that is overkill, but it is the only sufficient barrier we currently
have.

