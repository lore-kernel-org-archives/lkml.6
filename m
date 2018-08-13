Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE37C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C93216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C93216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbeHMM7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:59:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56530 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbeHMM7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:59:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD52E7A9;
        Mon, 13 Aug 2018 03:17:29 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEF8E3F5D0;
        Mon, 13 Aug 2018 03:17:26 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:17:24 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Message-ID: <20180813101724.GB2605@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
 <20180807135403.s7jktvxmhycujeht@queper01-lin>
 <20180809154156.gdsx2vacjmp6p6dp@darkstar>
 <20180809155551.bp46sixk4u3ilcnh@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809155551.bp46sixk4u3ilcnh@queper01-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin!

On 09-Aug 16:55, Quentin Perret wrote:
> Hi Patrick,
> 
> On Thursday 09 Aug 2018 at 16:41:56 (+0100), Patrick Bellasi wrote:
> > > IIUC, not far below this you should still have something like:
> > > 
> > > 	if (rt_rq_is_runnable(&rq->rt))
> > > 		return max;
> > 
> > Do you mean that when RT tasks are RUNNABLE we still want to got to
> > MAX? Not sure to understand... since this patch is actually to clamp
> > the RT class...
> 
> Argh, reading my message again it wasn't very clear indeed. Sorry about
> that ...
> 
> What I'm try to say is that your patch does _not_ remove the snippet of code
> above from sugov_get_util(). So I think that when a RT task is runnable,
> you will not reach the end of the function where the clamping is done.
> And this is not what you want AFAICT.
> 
> Does that make any sense ?

Oh gotcha... you right, I've missed that bit when I rebased on tip.
Will fix on the next iteration!

-- 
#include <best/regards.h>

Patrick Bellasi
