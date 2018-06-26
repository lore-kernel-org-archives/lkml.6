Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47022C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BC8267C8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nN6IzVN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BC8267C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeFZPak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:30:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbeFZPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4CCX95g5OocRVXIYw8EEcqFqu4FWgLlxdZJrizsnFvs=; b=nN6IzVN4Fw1x6g8XJkUHPxU3C
        PIs4xKtlQYqCnWQ9lr0vJg7/1A8dvXWAMShldTiBJNgHw2h5LOBfIVWx3ebFWnmB/fY4uTY0qIEof
        p+RIHHQOOLZfYaJnfmn4s7LHw3Ynw18fIn9ESZvlQKJRlP2Y2DFXKmR2gsL3vxkupIcuwxGP8wK2e
        M/6bBPC/uj54ZXMW0qBdnAestoUk7IXqYOIZwQa689VZcDi91xy9NEvUmmwNdRAmpja4NlZK16nZX
        WothseLcTWTx5XO+Bl46PlyAJkwr4Cn/rdDXzz0CUs4hL7QNn7Ep6m5JyzivTKBdx95lQQMcb7JFO
        zcSUhWsBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXpvH-0008Lo-Bd; Tue, 26 Jun 2018 15:30:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF4C82029F1D7; Tue, 26 Jun 2018 17:30:25 +0200 (CEST)
Date:   Tue, 26 Jun 2018 17:30:25 +0200
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
Message-ID: <20180626153025.GD2458@hirez.programming.kicks-ass.net>
References: <1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180625095031.GX2494@hirez.programming.kicks-ass.net>
 <20180625105618.GA12676@andrea>
 <20180625123121.GY2494@hirez.programming.kicks-ass.net>
 <20180625131643.GA15126@andrea>
 <20180625141830.GC2494@hirez.programming.kicks-ass.net>
 <20180625145611.GA16333@andrea>
 <20180625163705.GE2494@hirez.programming.kicks-ass.net>
 <20180626100942.GA8295@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626100942.GA8295@andrea>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 12:09:42PM +0200, Andrea Parri wrote:
> > > Same RFC for the first comment:
> > > 
> > >   /*
> > >    * The above implies an smp_mb(), which matches with the smp_wmb() from
> > >    * woken_wake_function() such that if we observe WQ_FLAG_WOKEN we must
> > >    * also observe all state before the wakeup.
> > >    */
> > > 
> > > What is the corresponding snippet & BUG_ON()?
> > 
> > The comment there suggest:
> > 
> > 	if (condition)
> > 		break;
> > 
> > 	set_current_state(UNINTERRUPTIBLE);		condition = true;
> > 	/* smp_mb() */					smp_wmb();
> > 							wq_entry->flags |= WQ_FLAG_WOKEN;
> > 	if (!wq_entry->flags & WQ_FLAG_WOKEN)
> > 		schedule();
> > 
> > 
> > 	BUG_ON((wq_entry->flags & WQ_FLAG_WOKEN) && !condition);
> > 
> > 
> > But looking at that now, I think that's wrong. Because the the purpose
> > was that, if we don't do the try_to_wake_up(), our task still needs to
> > observe the condition store.
> > 
> > But for that we need a barrier between the wq_entry->flags load and the
> > second condition test, which would (again) be B, not A.
> 
> Agreed.  Now that I stared at the code a bit more, I think that (A) is
> still needed for the synchronization on "->state" and "->flags" (an SB
> pattern seems again to be hidden in the call to try_to_wake_up()):
> 
>   p->state = mode;                           wq_entry->flags |= WQ_FLAG_WOKEN;
>   smp_mb(); // A                             try_to_wake_up():
>   if (!(wq_entry->flags & WQ_FLAG_WOKEN))      <full barrier>
>      schedule()                                if (!(p->state & mode))
>                                                  goto out;
> 
>   BUG_ON(!(wq_entry->flags & WQ_FLAG_WOKEN) && !(p->state & mode))
> 
> So, I think that we should keep (A).

Yes, very much so. Once we actually get to use ttwu() that barrier is
required.

> I am planning to send these changes (smp_mb() in woken_wake_function()
> and fixes to the comments) as a separate patch.

Probably makes sense. Thanks for looking at this, I have vague memories
of being slightly confused when I wrote all that :-)
