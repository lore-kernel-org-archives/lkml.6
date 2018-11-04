Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96E0C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813232081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xnNc+UUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813232081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeKDNDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 08:03:25 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:43401 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbeKDNDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 08:03:25 -0500
Received: by mail-pf1-f178.google.com with SMTP id g7-v6so536221pfo.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 20:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w35ChNayzh8JpmWFxxgfg0ClFLEkckY5dzSKn1bcjJI=;
        b=xnNc+UUF2c09mKRDjNDVgWFk63GMBS7/9GVmBDnIiWkPi0sz/hR0RPFgA2by76sfnS
         ilp8EUAFuK7xGAvC7hVePOQ/BOeT3+KiDvBGN5CyC+ikk4OWmjtvUEkRc80oWX7jU1c1
         CUtjcxi0Co4DLlhC4YAStuOP+zGBBYy5UJFpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w35ChNayzh8JpmWFxxgfg0ClFLEkckY5dzSKn1bcjJI=;
        b=r5KloaTxF6TP0pJBRz2ea572FBeF+SAnMrSrXpjrxbaM85d7OBMlBnGbsRe3jA6MHR
         NOLyCyuAg+Dt5Wrdsr9hPELN70mQ15jPT9viUHDGKiW5LR9dOjn0dUsmBuKZBX7Dr3h3
         grU5Iu/qQYnQ0WeQytb5qGxKOsu80MoOUqv2m9mouG+DG6S3Kf8Yd+sNpvBSwyB1SbzG
         xg0FYS4kSDaNMGVWdP3HP8THxFB8juxCnKQ2sowsc4S3LdB28H7si+fZCjg25VhqMJ48
         T+Re6c/hxPzRb3utzkMHFq2ryMLUiiRTxv+FN+mXXou9rkf/j8gd2/WgaTzWFtfbEs3s
         frnA==
X-Gm-Message-State: AGRZ1gIrlXIKe+Ucer+7CTNGILLi7+V37JndJtHkCgxN0tiS8gK3riPB
        YfhVhrB77iGFm4+AfLICiH6J3haw40w=
X-Google-Smtp-Source: AJdET5f00Jv8JXI+f812b6V9jIrkZfGLDtx9Hw2YKf9db6IzCTVDQWUtNC3N95BDF5gQGKeTF1515A==
X-Received: by 2002:a62:1e42:: with SMTP id e63-v6mr17356436pfe.149.1541303399173;
        Sat, 03 Nov 2018 20:49:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id i12-v6sm44241058pfe.7.2018.11.03.20.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 20:49:57 -0700 (PDT)
Date:   Sat, 3 Nov 2018 20:49:56 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] doc: rcu: remove note on smp_mb during synchronize_rcu
Message-ID: <20181104034956.GA112512@google.com>
References: <20181028043046.198403-1-joel@joelfernandes.org>
 <20181030222649.GA105735@joelaf.mtv.corp.google.com>
 <20181030234336.GW4170@linux.ibm.com>
 <20181031011119.GF224709@google.com>
 <20181031181748.GG4170@linux.ibm.com>
 <20181101050019.GA45865@google.com>
 <20181101161307.GO4170@linux.ibm.com>
 <20181103051226.GA18718@google.com>
 <20181103232259.GJ4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181103232259.GJ4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 04:22:59PM -0700, Paul E. McKenney wrote:
> On Fri, Nov 02, 2018 at 10:12:26PM -0700, Joel Fernandes wrote:
> > On Thu, Nov 01, 2018 at 09:13:07AM -0700, Paul E. McKenney wrote:
> > > On Wed, Oct 31, 2018 at 10:00:19PM -0700, Joel Fernandes wrote:
> > > > On Wed, Oct 31, 2018 at 11:17:48AM -0700, Paul E. McKenney wrote:
> > > > > On Tue, Oct 30, 2018 at 06:11:19PM -0700, Joel Fernandes wrote:
> > > > > > Hi Paul,
> > > > > > 
> > > > > > On Tue, Oct 30, 2018 at 04:43:36PM -0700, Paul E. McKenney wrote:
> > > > > > > On Tue, Oct 30, 2018 at 03:26:49PM -0700, Joel Fernandes wrote:
> > > > > > > > Hi Paul,
> > > > > > > > 
> > > > > > > > On Sat, Oct 27, 2018 at 09:30:46PM -0700, Joel Fernandes (Google) wrote:
> > > > > > > > > As per this thread [1], it seems this smp_mb isn't needed anymore:
> > > > > > > > > "So the smp_mb() that I was trying to add doesn't need to be there."
> > > > > > > > > 
> > > > > > > > > So let us remove this part from the memory ordering documentation.
> > > > > > > > > 
> > > > > > > > > [1] https://lkml.org/lkml/2017/10/6/707
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > > > 
> > > > > > > > I was just checking about this patch. Do you feel it is correct to remove
> > > > > > > > this part from the docs? Are you satisified that a barrier isn't needed there
> > > > > > > > now? Or did I miss something?
> > > > > > > 
> > > > > > > Apologies, it got lost in the shuffle.  I have now applied it with a
> > > > > > > bit of rework to the commit log, thank you!
> > > > > > 
> > > > > > No worries, thanks for taking it!
> > > > > > 
> > > > > > Just wanted to update you on my progress reading/correcting the docs. The
> > > > > > 'Memory Ordering' is taking a bit of time so I paused that and I'm focusing
> > > > > > on finishing all the other low hanging fruit. This activity is mostly during
> > > > > > night hours after the baby is asleep but some times I also manage to sneak it
> > > > > > into the day job ;-)
> > > > > 
> > > > > If there is anything I can do to make this a more sustainable task for
> > > > > you, please do not keep it a secret!!!
> > > > 
> > > > Thanks a lot, that means a lot to me! Will do!
> > > > 
> > > > > > BTW I do want to discuss about this smp_mb patch above with you at LPC if you
> > > > > > had time, even though we are removing it from the documentation. I thought
> > > > > > about it a few times, and I was not able to fully appreciate the need for the
> > > > > > barrier (that is even assuming that complete() etc did not do the right
> > > > > > thing).  Specifically I was wondering same thing Peter said in the above
> > > > > > thread I think that - if that rcu_read_unlock() triggered all the spin
> > > > > > locking up the tree of nodes, then why is that locking not sufficient to
> > > > > > prevent reads from the read-side section from bleeding out? That would
> > > > > > prevent the reader that just unlocked from seeing anything that happens
> > > > > > _after_ the synchronize_rcu.
> > > > > 
> > > > > Actually, I recall an smp_mb() being added, but am not seeing it anywhere
> > > > > relevant to wait_for_completion().  So I might need to add the smp_mb()
> > > > > to synchronize_rcu() and remove the patch (retaining the typo fix).  :-/
> > > > 
> > > > No problem, I'm glad atleast the patch resurfaced the topic of the potential
> > > > issue :-)
> > > 
> > > And an smp_mb() is needed in Tree RCU's __wait_rcu_gp().  This is
> > > because wait_for_completion() might get a "fly-by" wakeup, which would
> > > mean no ordering for code naively thinking that it was ordered after a
> > > grace period.
> > > 
> > > > > The short form answer is that anything before a grace period on any CPU
> > > > > must be seen by any CPU as being before anything on any CPU after that
> > > > > same grace period.  This guarantee requires a rather big hammer.
> > > > > 
> > > > > But yes, let's talk at LPC!
> > > > 
> > > > Sounds great, looking forward to discussing this.
> > > 
> > > Would it make sense to have an RCU-implementation BoF?
> > > 
> > > > > > Also about GP memory ordering and RCU-tree-locking, I think you mentioned to
> > > > > > me that the RCU reader-sections are virtually extended both forward and
> > > > > > backward and whereever it ends, those paths do heavy-weight synchronization
> > > > > > that should be sufficient to prevent memory ordering issues (such as those
> > > > > > you mentioned in the Requierments document). That is exactly why we don't
> > > > > > need explicit barriers during rcu_read_unlock. If I recall I asked you why
> > > > > > those are not needed. So that answer made sense, but then now on going
> > > > > > through the 'Memory Ordering' document, I see that you mentioned there is
> > > > > > reliance on the locking. Is that reliance on locking necessary to maintain
> > > > > > ordering then?
> > > > > 
> > > > > There is a "network" of locking augmented by smp_mb__after_unlock_lock()
> > > > > that implements the all-to-all memory ordering mentioned above.  But it
> > > > > also needs to handle all the possible complete()/wait_for_completion()
> > > > > races, even those assisted by hypervisor vCPU preemption.
> > > > 
> > > > I see, so it sounds like the lock network is just a partial solution. For
> > > > some reason I thought before that complete() was even called on the CPU
> > > > executing the callback, all the CPUs would have acquired and released a lock
> > > > in the "lock network" atleast once thus ensuring the ordering (due to the
> > > > fact that the quiescent state reporting has to travel up the tree starting
> > > > from the leaves), but I think that's not necessarily true so I see your point
> > > > now.
> > > 
> > > There is indeed a lock that is unconditionally acquired and released by
> > > wait_for_completion(), but it lacks the smp_mb__after_unlock_lock() that
> > > is required to get full-up any-to-any ordering.  And unfortunate timing
> > > (as well as spurious wakeups) allow the interaction to have only normal
> > > lock-release/acquire ordering, which does not suffice in all cases.
> > 
> > Sorry to be so persistent, but I did spend some time on this and I still
> > don't get why every CPU would _not_ have executed smp_mb__after_unlock_lock at least
> > once before the wait_for_completion() returns, because every CPU should have
> > atleast called rcu_report_qs_rdp() -> rcu_report_qs_rnp() atleast once to
> > report its QS up the tree right?. Before that procedure, the complete()
> > cannot happen because the complete() itself is in an RCU callback which is
> > executed only once all the QS(s) have been reported.
> > 
> > So I still couldn't see how the synchronize_rcu can return without the
> > rcu_report_qs_rnp called atleast once on the CPU reporting its QS during a
> > grace period.
> > 
> > Would it be possible to provide a small example showing this in least number
> > of steps? I appreciate your time and it would be really helpful. If you feel
> > its too complicated, then feel free to keep this for LPC discussion :)
> 
> The key point is that "at least once" does not suffice, other than for the
> CPU that detects the end of the grace period.  The rest of the CPUs must
> do at least -two- full barriers, which could of course be either smp_mb()
> on the one hand or smp_mb__after_unlock_lock() after a lock on the other.

I thought I'll atleast get an understanding of the "atleast two full
barriers" point and ask you any questions at LPC, because that's what I'm
missing I think. Trying to understand what can go wrong without two full
barriers. I'm sure an RCU implementation BoF could really in this regard.

I guess its also documented somewhere in Tree-RCU-Memory-Ordering.html but a
quick search through that document didn't show a mention of the two full
barriers need.. I think its also a great idea for us to document it there
and/or discuss it during the conference.

I went through the litmus test here for some hints on the two-barriers but
couldn't find any:
https://lkml.org/lkml/2017/10/5/636

Atleast this commit made me think no extra memory barrier is needed for
tree RCU:  :-\
https://lore.kernel.org/patchwork/patch/813386/

I'm sure your last email will be useful to me in the future once I can make
more sense of the ordering and the need for two full barriers, so thanks a
lot for writing it!

- Joel

