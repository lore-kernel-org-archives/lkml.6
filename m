Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8FFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8BB2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Eu2nNt19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8BB2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeHaWED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:04:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38136 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeHaWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:04:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so6101798wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l9+UeNtS7la9WoqV1GxEFoPXF/KlYJquyqTSE1HhhRg=;
        b=Eu2nNt19eWRZP35klLM0iSYNHLvhE7zOeuCba6zNSNRBd+5XcENjGMWpE7bDFruqG/
         r450maY9AOCaMvxhNW9tazqfXqZ8xIOi9d4DaqrzOSDBeg5KozJvan+Z5ZdHFiV6zpjA
         GtWPiO0chX5wtKKk8tT3WKLN5KkDEygAwIw24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l9+UeNtS7la9WoqV1GxEFoPXF/KlYJquyqTSE1HhhRg=;
        b=mQds2UMphY9qHYx8XV7O2yXveO18wfX+Kw2MLgJ9BIDmA81h+GwPf2Fx3gUgUQG1m0
         M3KZsjD/aXuxDuAgULgRc3xh5opAliLGAL5uyiyCIyc8VAzcjgJklz0QfQGVpds3U1I7
         jRynQo+n1o/c0Sj4aAFSIn3CkNyN7ju9K0hfXGnR4nlM+hRhY23jvVZGHDbIpig2ZCkN
         aziehZCaiQQsTopn+ic+wItj5vm/R/RX5X4KD7K7onT9THCOtTRrFIwzJxObKzuph5GP
         Qr2vyXNlE+p2SnR7Vtv4ZXTK9QNe2UC5qJYPaWyDbGGDGAPdnESU9uAXqLK5LOtAet/q
         TG+A==
X-Gm-Message-State: APzg51Cl81boOsxutBhzYqhpzeYNB01JRA2qUotrRIwBhLv1bD8y+pou
        y9EcB/ScDRUTpxBKyy4xZGRmZg==
X-Google-Smtp-Source: ANB0VdZEL7b7Y2U9cP19quoEbH9Ia6RoMcpX2ucJfVu56Zho1/r5OT40BAWnywpgC5ecgsSQVUjziA==
X-Received: by 2002:a1c:ae94:: with SMTP id x142-v6mr5749528wme.125.1535738125215;
        Fri, 31 Aug 2018 10:55:25 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id e141-v6sm6173716wmd.32.2018.08.31.10.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 10:55:24 -0700 (PDT)
Date:   Fri, 31 Aug 2018 19:55:12 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180831175512.GA3121@andrea>
References: <20180831091641.GA3634@andrea>
 <Pine.LNX.4.44L0.1808311042340.4901-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1808311042340.4901-100000@netrider.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 10:52:54AM -0400, Alan Stern wrote:
> On Fri, 31 Aug 2018, Andrea Parri wrote:
> 
> > On Thu, Aug 30, 2018 at 05:31:32PM -0400, Alan Stern wrote:
> > > On Thu, 30 Aug 2018, Andrea Parri wrote:
> > > 
> > > > > All the architectures supported by the Linux kernel (including RISC-V)
> > > > > do provide this ordering for locks, albeit for varying reasons.
> > > > > Therefore this patch changes the model in accordance with the
> > > > > developers' wishes.
> > > > > 
> > > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > Reviewed-by: Will Deacon <will.deacon@arm.com>
> > > > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > 
> > > > Round 2 ;-), I guess...  Let me start from the uncontroversial points:
> > > > 
> > > >   1) being able to use the LKMM to reason about generic locking code
> > > >      is useful and desirable (paraphrasing Peter in [1]);
> > > > 
> > > >   2) strengthening the ordering requirements of such code isn't going
> > > >      to boost performance (that's "real maths").
> > > > 
> > > > This patch is taking (1) away from us and it is formalizing (2), with
> > > > almost _no_ reason (no reason at all, if we stick to the commit msg.).
> > > 
> > > That's not quite fair.  Generic code isn't always universally
> > > applicable; some of it is opt-in -- meant only for the architectures
> > > that can support it.  In general, the LKMM allows us to reason about
> > > higher abstractions (such as locking) at a higher level, without
> > > necessarily being able to verify the architecture-specific details of
> > > the implementations.
> > 
> > No, generic code is "universally applicable" by definition; see below
> > for more on this point.
> 
> Then perhaps we should be talking about "partially generic" code; i.e., 
> code that applies to many but not all architectures.

Perhaps.  I call this  "non-generic". ;-)


> 
> > > > In [2], Will wrote:
> > > > 
> > > >   "[...] having them [the RMWs] closer to RCsc[/to the semantics of
> > > >    locks] would make it easier to implement and reason about generic
> > > >    locking implementations (i.e. reduce the number of special ordering
> > > >    cases and/or magic barrier macros)"
> > > > 
> > > > "magic barrier macros" as in "mmh, if we accept this patch, we _should_
> > > > be auditing the various implementations/code to decide where to place a
> > > > 
> > > >   smp_barrier_promote_ordinary_release_acquire_to_unlock_lock()" ;-)
> > > > 
> > > > or the like, and "special ordering cases" as in "arrgh, (otherwise) we
> > > > are forced to reason on a per-arch basis while looking at generic code".
> > > 
> > > Currently the LKMM does not permit architecture-specific reasoning.  It 
> > > would have to be extended (in a different way for each architecture) 
> > > first.
> > 
> > Completely agreed; that's why I said that this patch is detrimental to
> > the applicability of the LKMM...
> 
> This ignores the attitude of the kernel developers who want locking to 
> have the stronger RCtso semantics.  From their point of view, the patch 
> enhances the LKMM's applicability.

Please stop.  We spent weeks discussing how to make such a transition
properly, and I suggested ways to do this above and in other threads.
(Again, your commit message says nothing about that "enhancement"...)


> 
> > > For example, one could use herd's POWER model combined with the POWER 
> > > compilation scheme and the POWER-specific implementation of spinlocks 
> > > for such reasoning.  The LKMM alone is not sufficient.
> > > 
> > > Sure, programming and reasoning about the kernel would be easier if all
> > > architectures were the same.  Unfortunately, we (and the kernel) have
> > > to live in the real world.
> > > 
> > > > (Remark: ordinary release/acquire are building blocks for code such as
> > > >  qspinlock, (q)rwlock, mutex, rwsem, ... and what else??).
> > > 
> > > But are these building blocks used the same way for all architectures?
> > 
> > The more, the better! (because then we have the LKMM tools) 
> > 
> > We already discussed the "fast path" example: the fast paths of the
> > above all resemble:
> > 
> >   *_lock(s):  atomic_cmpxchg_acquire(&s->val, UNLOCKED_VAL, LOCKED_VAL) ...
> >   *_unlock(s): ...  atomic_set_release(&s->val, UNLOCKED_VAL)
> > 
> > When I read this code, I think "Of course." (unless some arch. has
> > messed the implementation of cmpxchg_* up, which can happen...); but
> > then I read the subject line of this patch and I think "Wait, what?".
> > 
> > You can argue that this is not generic code, sure; but why on Earth
> > would you like to do so?!
> 
> Because the code might not work!  On RISC-V, for example, the
> implementation of ordinary release/acquire is currently not as strong
> as atomic release/acquire.

No doubt it "might not work". ;-)  Concerning the RISC-V implementation,
I almost (re)did that, so at least you know who to blame if what you are
saying turned out to be correct.


> 
> Yes, it's true that implementing locks with atomic_cmpxchg_acquire 
> should be correct on all existing architectures.  And Paul has invited 
> a patch to modify the LKMM accordingly.  If you feel that such a change 
> would be a useful enhancement to the LKMM's applicability, please write 
> it.

Hey, it's your patch that is introducing concerns!  "my patch" would
partially _but_ substantially revert yours (see earlier discussions):
I'm still hoping that we'll be able to find an agreement...

  Andrea


> 
> Alan
> 
