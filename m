Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371B8C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075222081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075222081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbeKGXVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:21:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51188 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbeKGXVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:21:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8F81A78;
        Wed,  7 Nov 2018 05:50:44 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADAC13F5CF;
        Wed,  7 Nov 2018 05:50:41 -0800 (PST)
Date:   Wed, 7 Nov 2018 13:50:39 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v5 02/15] sched/core: make sched_setattr able to tune the
 current policy
Message-ID: <20181107135039.GD14309@e110439-lin>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-3-patrick.bellasi@arm.com>
 <20181107121126.GN9781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107121126.GN9781@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Nov 13:11, Peter Zijlstra wrote:
> On Mon, Oct 29, 2018 at 06:32:56PM +0000, Patrick Bellasi wrote:
> 
> > @@ -50,11 +52,13 @@
> >  #define SCHED_FLAG_RESET_ON_FORK	0x01
> >  #define SCHED_FLAG_RECLAIM		0x02
> >  #define SCHED_FLAG_DL_OVERRUN		0x04
> > -#define SCHED_FLAG_UTIL_CLAMP		0x08
> > +#define SCHED_FLAG_TUNE_POLICY		0x08
> > +#define SCHED_FLAG_UTIL_CLAMP		0x10
> 
> That seems to suggest you want to do this patch first, but you didn't..

I've kept it here just to better highlight this change, suggested by
Juri, since we was not entirely sure you are fine with it...

If you think it's ok adding a SCHED_FLAG_TUNE_POLICY behavior to the
sched_setattr syscall, I can certainly squash into the previous patch,
which gives more context on why we need it.

Otherwise, if we want to keep these bits better isolated for possible
future bisects, I can also move it at the beginning of the series.

What do you like best ?

Since we are at that, are we supposed to document some{where,how}
these API changes ?

-- 
#include <best/regards.h>

Patrick Bellasi
