Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0EDECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AF120C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AF120C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbeGQOOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:14:37 -0400
Received: from foss.arm.com ([217.140.101.70]:46854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731551AbeGQOOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:14:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B55318A;
        Tue, 17 Jul 2018 06:41:54 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.210.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D71F3F5B1;
        Tue, 17 Jul 2018 06:41:51 -0700 (PDT)
Date:   Tue, 17 Jul 2018 14:41:48 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Subject: Re: [PATCH v2 00/12] Add utilization clamping support
Message-ID: <20180717134148.GH32302@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180717130357.GA17824@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717130357.GA17824@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-Jul 06:03, Joel Fernandes wrote:
> On Mon, Jul 16, 2018 at 09:28:54AM +0100, Patrick Bellasi wrote:
> >  Documentation/admin-guide/cgroup-v2.rst |  25 +
> >  include/linux/sched.h                   |  53 ++
> >  include/uapi/linux/sched.h              |   4 +-
> >  include/uapi/linux/sched/types.h        |  66 +-
> >  init/Kconfig                            |  63 ++
> >  kernel/sched/core.c                     | 876 ++++++++++++++++++++++++
> 
> While I'm reviewing these patches, I had a quick thought. core.c is already
> 7k+ lines. Based on this diffstat, does it make sense for uclamp to be in its
> own kernel/sched/uclamp.c file?

Good point.

I've added it to core.c because it's logically part of the core
scheduler and we have some calls which are part of the fast path and
thus we want to avoid function calls.

I guess that, provided we can rely on LTOs, we can try to move it into
a separate file. Let see what Ingo and Peter thing about this.

> thanks,
> 
> - Joel

-- 
#include <best/regards.h>

Patrick Bellasi
