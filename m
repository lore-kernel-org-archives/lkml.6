Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9193C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8881F25E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qb9TX39S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8881F25E5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933647AbeFYQhZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:37:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932438AbeFYQhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eMnUeejIFi+eaZLwGbCxGh0dPP1cnNKWEKY7p6Mk9+8=; b=Qb9TX39SdDViDOEIz548EQ8XH
        WzdWHUDPlWOI10jdd9jInWpp9yRsp9L1jDzt+oGQsIX3bFBcapmJhfVNXSwyjaK5bXgIooN2S1CyU
        yHBicuKCTeCJRC9cUKflotSWpX98AteLrRmHAf4o+hgs8dxv+WOiFMlqnyBMBr2apG5KPjN78QdMd
        gYklW2wIPgoaKnd3hYQNmowxpXVSKmJwJQAGiZs51gnqzqFg6Og4dU/xT3F0XUYcpVCCLGr14jvUQ
        umVyGabIBX91wxtrwCg/Nb+zCgnianfyvjVERiERzpSTVVY8oX/f8/SQoCA8w4W748C4I5Z53LAPH
        hN7ASS5hA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXUUF-0003aq-LI; Mon, 25 Jun 2018 16:37:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 621C42029FA0A; Mon, 25 Jun 2018 18:37:05 +0200 (CEST)
Date:   Mon, 25 Jun 2018 18:37:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] doc: Update wake_up() & co. memory-barrier guarantees
Message-ID: <20180625163705.GE2494@hirez.programming.kicks-ass.net>
References: <1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180625095031.GX2494@hirez.programming.kicks-ass.net>
 <20180625105618.GA12676@andrea>
 <20180625123121.GY2494@hirez.programming.kicks-ass.net>
 <20180625131643.GA15126@andrea>
 <20180625141830.GC2494@hirez.programming.kicks-ass.net>
 <20180625145611.GA16333@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625145611.GA16333@andrea>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 04:56:11PM +0200, Andrea Parri wrote:

> Ah, before sending v2, I'd really appreciate some comments on the XXXs
> I've added to wait_woken() as I'm not sure I understand the pattern in
> questions.

Oh man, lemme see if I can remember how all that was supposed to work.

So the basic idea was that we cannot rely on the normal task->state
rules because testing @condition can schedule itself. So instead we add
more state. But then we need to ensure that if we either don't loose a
wake or loose the wakeup state.

> For example, the second comment says:
> 
>   /*
>    * The below implies an smp_mb(), it too pairs with the smp_wmb() from
>    * woken_wake_function() such that we must either observe the wait
>    * condition being true _OR_ WQ_FLAG_WOKEN such that we will not miss
>    * an event.
>    */
> 
> From this I understand:
> 
>    wq_entry->flags &= ~WQ_FLAG_WOKEN;      condition = true;
>    smp_mb() // B                           smp_wmb(); // C
>    [next iteration of the loop]            wq_entry->flags |= WQ_FLAG_WOKEN;
>    if (condition)
>       break;
> 
>    BUG_ON(!condition && !(wq_entry->flags & WQ_FLAG_WOKEN))

Right, basically if we get a spurious wakeup and our ttwu() 'fails', we
must either see condition on the next iteration, or ensure the next
iteration doesn't sleep, so we'll loop around and test condition yet
again.

> IOW, this is an R-like pattern: if this is the case, the smp_wmb() does
> _not_ prevent the BUG_ON() from firing; according to LKMM (and powerpc)
> a full barrier would be needed.

Hmmm, how come? store-store collision? Yes I suppose you're right.

> Same RFC for the first comment:
> 
>   /*
>    * The above implies an smp_mb(), which matches with the smp_wmb() from
>    * woken_wake_function() such that if we observe WQ_FLAG_WOKEN we must
>    * also observe all state before the wakeup.
>    */
> 
> What is the corresponding snippet & BUG_ON()?

The comment there suggest:

	if (condition)
		break;

	set_current_state(UNINTERRUPTIBLE);		condition = true;
	/* smp_mb() */					smp_wmb();
							wq_entry->flags |= WQ_FLAG_WOKEN;
	if (!wq_entry->flags & WQ_FLAG_WOKEN)
		schedule();


	BUG_ON((wq_entry->flags & WQ_FLAG_WOKEN) && !condition);


But looking at that now, I think that's wrong. Because the the purpose
was that, if we don't do the try_to_wake_up(), our task still needs to
observe the condition store.

But for that we need a barrier between the wq_entry->flags load and the
second condition test, which would (again) be B, not A.
