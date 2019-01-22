Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9203BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D012217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfAVPOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:14:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55502 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729015AbfAVPOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:14:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A137A78;
        Tue, 22 Jan 2019 07:14:11 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 439CD3F589;
        Tue, 22 Jan 2019 07:14:08 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:14:06 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 11/16] sched/fair: Add uclamp support to
 energy_compute()
Message-ID: <20190122151404.5rtosic6puixado3@queper01-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-12-patrick.bellasi@arm.com>
 <20190122121321.r6mv23ao57uut3t7@queper01-lin>
 <20190122124546.njrpmykzbjpztd6u@e110439-lin>
 <20190122132944.sfxlnpc3xeft4rqd@queper01-lin>
 <20190122142606.gc5hnc5pzefblegw@e110439-lin>
 <20190122143909.pmlqyhcjshyomrbw@queper01-lin>
 <20190122150137.fp4g4kdng2qpy6qx@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122150137.fp4g4kdng2qpy6qx@e110439-lin>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 Jan 2019 at 15:01:37 (+0000), Patrick Bellasi wrote:
> > I'm not saying it's useful, I'm saying userspace can decide to do that
> > if it thinks it is a good idea. The default should be min_cap = 1024 for
> > RT, no questions. But you _can_ change it at runtime if you want to.
> > That's my point. And doing that basically provides the same behaviour as
> > what we have right now in terms of EAS calculation (but it changes the
> > freq selection obviously) which is why I'm not fundamentally opposed to
> > your patch.
> 
> Well, I think it's tricky to say whether the current or new approach
> is better... it probably depends on the use-case.

Agreed.

> > So in short, I'm fine with the behavioural change, but please at least
> > mention it somewhere :-)
> 
> Anyway... agree, it's just that to add some documentation I need to
> get what you are pointing out ;)
> 
> Will come up with some additional text to be added to the changelog

Sounds good.

> Maybe we can add a more detailed explanation of the different
> behaviors you can get in the EAS documentation which is coming to
> mainline ?

Yeah, if you feel like it, I guess that won't hurt :-)

Thanks,
Quentin
