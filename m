Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBABC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0325721571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0325721571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeI0QST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:18:19 -0400
Received: from foss.arm.com ([217.140.101.70]:60306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbeI0QSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:18:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F47415AD;
        Thu, 27 Sep 2018 03:00:49 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82C793F5B7;
        Thu, 27 Sep 2018 03:00:46 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:00:40 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Message-ID: <20180927100021.kpdyol44qpzassup@queper01-lin>
References: <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
 <20180914142813.GM24124@hirez.programming.kicks-ass.net>
 <20180917122723.GS1413@e110439-lin>
 <20180921091308.GD24082@hirez.programming.kicks-ass.net>
 <20180924151400.GT1413@e110439-lin>
 <20180925154956.GA30146@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925154956.GA30146@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 Sep 2018 at 17:49:56 (+0200), Peter Zijlstra wrote:
> I really don't see how changing the unit changes anything. Either you
> want to relate to OPPs and those are exposed in 1/1024 unit capacity
> through the EAS files, or you don't and then the knob has no meaning.

FWIW, with the latest versions of the EAS series, we don't expose the
capacity of the various OPPs directly any more. You have 'frequency',
'power' and a more abstract thing called 'cost' (which is useful for
energy computations) in the sysfs files of the EM.

We decided to remove the 'capacity' file to simplify things quite a bit,
and because it wasn't helping much. I'm talking about this discussion w/
Dietmar on v4:

https://lore.kernel.org/lkml/20180717141955.GA4496@e108498-lin.cambridge.arm.com/

But it is also true that we could add back that 'capacity' file if it
makes sense for uclamp. It's just an additional show() function in
energy_model.c, so no problem on that side per se.

The only problem is if you want to use uclamp w/o EAS, I guess ...

Thanks,
Quentin
