Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FACBC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A5621B32
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A5621B32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbeHILDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:03:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50198 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbeHILDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:03:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07CC018A;
        Thu,  9 Aug 2018 01:39:59 -0700 (PDT)
Received: from darkstar (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B7EE3F5D0;
        Thu,  9 Aug 2018 01:39:54 -0700 (PDT)
Date:   Thu, 9 Aug 2018 09:39:47 +0100
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
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Message-ID: <20180809083947.2ogkudkpg6d52roc@darkstar>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
 <d8a3d533-84df-bfc7-96ae-790141be4926@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8a3d533-84df-bfc7-96ae-790141be4926@infradead.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Aug 09:50, Randy Dunlap wrote:
> Hi,

Hi Randy,

> On 08/06/2018 09:39 AM, Patrick Bellasi wrote:
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 041f3a022122..1d45a6877d6f 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -583,6 +583,25 @@ config HAVE_UNSTABLE_SCHED_CLOCK
> >  config GENERIC_SCHED_CLOCK
> >  	bool
> >  
> > +menu "Scheduler features"
> > +
> > +config UCLAMP_TASK
> > +	bool "Enable utilization clamping for RT/FAIR tasks"
> > +	depends on CPU_FREQ_GOV_SCHEDUTIL
> > +	default false
> 
> 	default n
> but just omit the line completely since "n" is already the default.


Right, will update for next posting!
Is there a strict rule to omit this line when it's already the
default?
> 
> > +	help
> > +	  This feature enables the scheduler to track the clamped utilization
> > +	  of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
> > +
> > +	  When this option is enabled, the user can specify a min and max CPU
> > +          bandwidth which is allowed for a task.
> > +	  The max bandwidth allows to clamp the maximum frequency a task can
> > +	  use, while the min bandwidth allows to define a minimum frequency a
> > +          task will always use.
> 
> Please clean up the indentation above to use one tab + 2 spaces on all lines.

Sure, my bad I did not notice it... although I'm quite sure the patch
passed a checkpatch... will check better next time.

> > +
> > +	  If in doubt, say N.
> > +
> > +endmenu

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
