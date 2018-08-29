Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E118C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FE22084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FE22084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeH2Mt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:49:56 -0400
Received: from foss.arm.com ([217.140.101.70]:50532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbeH2Mtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:49:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0A9918A;
        Wed, 29 Aug 2018 01:54:03 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFF7E3F5BC;
        Wed, 29 Aug 2018 01:54:00 -0700 (PDT)
Date:   Wed, 29 Aug 2018 09:53:58 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 07/16] sched/core: uclamp: extend cpu's cgroup
 controller
Message-ID: <20180829085358.GO2960@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-8-patrick.bellasi@arm.com>
 <ad7a1f15-d1ad-84f2-6b4d-cbfc4560a7a4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad7a1f15-d1ad-84f2-6b4d-cbfc4560a7a4@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-Aug 11:29, Randy Dunlap wrote:
> On 08/28/2018 06:53 AM, Patrick Bellasi wrote:
> > +config UCLAMP_TASK_GROUP
> > +	bool "Utilization clamping per group of tasks"
> > +	depends on CGROUP_SCHED
> > +	depends on UCLAMP_TASK
> > +	default n
> > +	help
> > +	  This feature enables the scheduler to track the clamped utilization
> > +	  of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
> > +
> > +	  When this option is enabled, the user can specify a min and max
> > +	  CPU bandwidth which is allowed for each single task in a group.
> > +	  The max bandwidth allows to clamp the maximum frequency a task
> > +	  can use, while the min bandwidth allows to define a minimum
> > +	  frequency a task will always use.
> > +
> > +	  When task group based utilization clamping is enabled, an eventually
> > +          specified task-specific clamp value is constrained by the cgroup
> > +	  specified clamp value. Both minimum and maximum task clamping cannot
> > +          be bigger than the corresponding clamping defined at task group level.
> 
> The 4 lines above should all be indented the same (one tab + 2 spaces).

Right... then there's definitively something broken with my vim
reformat shortcut, which sometimes uses spaces instead of tabs :(

Unfortunately this pattern is not covered by checkpatch, which
returns not errors/warnings on this patch.

> > +
> > +	  If in doubt, say N.
> > +

Anyway, thanks for spotting it... easy fix for the next respin.

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
