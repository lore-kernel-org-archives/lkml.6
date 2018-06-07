Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UNfaKUVdGVuZKQAAmS7hNA
	; Thu, 07 Jun 2018 16:29:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2B9C7608B8; Thu,  7 Jun 2018 16:29:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8CE216074D;
	Thu,  7 Jun 2018 16:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CE216074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932744AbeFGQ3S (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:29:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34757 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753750AbeFGQ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:29:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id q4-v6so3851003wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nqlO5w2tjEIZY7Ebl3CH/ChhTZ4vcqk9K6prvXRyZO4=;
        b=UkB+ro+YfpUKjtIx8EP+4NJ2Ag4xJacVBzNfzPh2DhP1Yo4rKDjTvImgJPIEYn4I7/
         3zr0blvGDnXa4Xf+XGUM6AYarxUl6kprYT3e+Hppi+BjDK5AqSuc11K7YY++fMWyoUZa
         se2a0T4LSGBKbHv9OU5C1LRXj2ZZZz5vmrdZLTy83apKeVixsgkyGoXDj5yJ5pHHDMWs
         WsoZ9zNcG0+fT8fNETZmo0K++uCnE5GUC8KEvwystgl1yvNw0Letuh2RdQpLusZAiHZd
         Gtlw96SRVjrhcTFoltWjO/THK1KTbQYxDy4Mt3/ckgke35WAkjvYPo9BIi0lfIYNxpRF
         7dZQ==
X-Gm-Message-State: APt69E1oEBVcUdnuZxJCPMmOkGFYUD4EVdfa9iFPt1bjCd/JuhhomiPC
        vK+Idso3z2myDcvlFGH0MfVbAQ==
X-Google-Smtp-Source: ADUXVKLRoX9KDQbcmGDU/zxB7uBCkiC0GqY23bPrIjU63EuLiJivpOhmRMTVNnvnTWMDSZHC0F46qg==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14-v6mr1936421wmg.87.1528388954408;
        Thu, 07 Jun 2018 09:29:14 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id o9-v6sm10944505wrn.73.2018.06.07.09.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 09:29:13 -0700 (PDT)
Date: Thu, 7 Jun 2018 18:29:10 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joelaf@google.com, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model
 of CPUs when available
Message-ID: <20180607162910.GE3311@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
 <20180607144422.GA17216@localhost.localdomain>
 <20180607160200.GB3597@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607160200.GB3597@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/18 17:02, Quentin Perret wrote:
> On Thursday 07 Jun 2018 at 16:44:22 (+0200), Juri Lelli wrote:
> > Hi,
> > 
> > On 21/05/18 15:25, Quentin Perret wrote:
> > > In order to use EAS, the task scheduler has to know about the Energy
> > > Model (EM) of the platform. This commit extends the scheduler topology
> > > code to take references on the frequency domains objects of the EM
> > > framework for all online CPUs. Hence, the availability of the EM for
> > > those CPUs is guaranteed to the scheduler at runtime without further
> > > checks in latency sensitive code paths (i.e. task wake-up).
> > > 
> > > A (RCU-protected) private list of online frequency domains is maintained
> > > by the scheduler to enable fast iterations. Furthermore, the availability
> > > of an EM is notified to the rest of the scheduler with a static key,
> > > which ensures a low impact on non-EAS systems.
> > > 
> > > Energy Aware Scheduling can be started if and only if:
> > >    1. all online CPUs are covered by the EM;
> > >    2. the EM complexity is low enough to keep scheduling overheads low;
> > >    3. the platform has an asymmetric CPU capacity topology (detected by
> > >       looking for the SD_ASYM_CPUCAPACITY flag in the sched_domain
> > >       hierarchy).
> > 
> > Not sure about this. How about multi-freq domain same max capacity
> > systems. I understand that most of the energy saving come from selecting
> > the right (big/LITTLE) cluster, but EM should still be useful to drive
> > OPP selection (that was one of the use-cases we discussed lately IIRC)
> > and also to decide between packing or spreading, no?
> 
> So, let's discuss the usage of the EM for frequency selection first,
> and its usage for task placement after.
> 
> For frequency selection, schedutil could definitely use the EM as
> provided by the framework introduced in patch 03/10. We could definitely
> use that to make policy decisions (jump faster to the so called "knee"
> if there is one for ex). This is true for symmetric and asymmetric
> system. And I consider that independent from this patch. This patch is
> about providing the scheduler with an EM to biais _task placement_.
> 
> So, about the task placement ... There are cases (at least theoretical
> ones) where EAS _could_ help on symmetric systems, but I have never
> been able to measure any real benefits in practice. Most of the time,
> it's a good idea from an energy standpoint to just spread the tasks
> and to keep the OPPs as low as possible on symmetric systems, which is
> already what CFS does. Of course you can come-up with specific counter
> examples, but the question is whether or not these (corner) cases are
> that important. They might or might not, it's not so easy to tell.
> 
> On asymmetric systems, it is pretty clear that there is a massive
> potential for saving energy with a different task placement strategy.
> So, since the big savings are there, our idea was basically to address
> that first, while we minimize the risk of hurting others (server folks
> for ex). I guess that enabling EAS for asymmetric systems can be seen as
> an incremental step. We should be able to extend the scope of EAS to
> symmetric systems later, if proven useful.
> 
> Another thing is that, if you are using an asymmetric system (e.g.
> big.LITTLE), it is a good indication that energy/battery life is probably
> important for your use-case, and that you might be ready to "pay" the
> cost of EAS to save energy. This isn't that obvious for symmetric
> systems.

Ok, I buy the step by step approach starting from the use case that
seems to fit most. But I still feel that having something like 3. stated
(or in the code) might stop people from trying to see if having an EM
around might help other cases (freq, sym, etc.).

Also, if no EM data is present should equally result in disabling the
whole thing, so not much (at all?) overhead for who is simply not
providing data, no?

[...]

> > > +	list_for_each_entry_safe(sfd, tmp, &sched_energy_fd_list, next) {
> > > +		if (cpumask_intersects(freq_domain_span(sfd),
> > > +							cpu_online_mask)) {
> > > +			nr_opp += em_fd_nr_cap_states(sfd->fd);
> > > +			nr_fd++;
> > > +			continue;
> > > +		}
> > > +
> > > +		/* Remove the unused frequency domains */
> > > +		list_del_rcu(&sfd->next);
> > > +		call_rcu(&sfd->rcu, free_sched_energy_fd);
> > 
> > Unused because of? Hotplug?
> 
> Yes. The list of frequency domains is just convenient because we need to
> iterate over them in the wake-up path. Now, if you hotplug out all the
> CPUs of a frequency domain, it is safe to remove it from the list
> because the scheduler shouldn't migrate task to/from those CPUs while
> they're offline. And that's one less element in the list, so iterating
> over the entire list is faster.

OK, I mainly asked to be sure that I understood the comment. I guess
some stress test involving hotplug and iterating over the list would
best answer which way is the safest. :)
