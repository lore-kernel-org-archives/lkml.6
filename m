Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754979AbeEHMUp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:20:45 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34432 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754005AbeEHMUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:20:43 -0400
X-Google-Smtp-Source: AB8JxZp9xjiyZM6S2TPmz6uE8fNKVrKZmpHN/tl6jyAV/xT+5g0aeHIFw33j4AlilfMmHM+WiE/iXg==
Date: Tue, 8 May 2018 14:20:40 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Joel Fernandes <joelaf@google.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] Revert "cpufreq: schedutil: Don't restrict kthread to
 related_cpus unnecessarily"
Message-ID: <20180508122040.GE19168@localhost.localdomain>
References: <20180508073340.13114-1-dietmar.eggemann@arm.com>
 <20180508082242.bre6sjfvefhz6xc3@vireshk-i7>
 <8cf21b1a-ca6e-fed7-43c5-94c66ff5986b@arm.com>
 <20180508094526.ajyjrwytguhv4xpe@vireshk-i7>
 <20180508100227.GB3752@e108498-lin.cambridge.arm.com>
 <20180508103427.w2rq3vz3f66y4cxh@vireshk-i7>
 <20180508110003.GC3752@e108498-lin.cambridge.arm.com>
 <20180508111451.rmoi2rk3md6lhbvl@vireshk-i7>
 <20180508112424.GA463@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508112424.GA463@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/18 12:24, Quentin Perret wrote:
> On Tuesday 08 May 2018 at 16:44:51 (+0530), Viresh Kumar wrote:
> > On 08-05-18, 12:00, Quentin Perret wrote:
> > > Right, I see your point. Now, with the current implementation, why should
> > > we randomly force a CPU to manage the kthread of another ? IIUC deadline
> > > should assign the kthreads to CPUs depending on the state of the system
> > > when the task is created. So, from one boot to another, you could
> > > theoretically end up with varying configurations, and varying power/perf
> > > numbers.
> > 
> > Yeah, if it is fixed at boot then there is no good reason to push it
> > to any other CPU. I agree.
> > 
> 
> To be fair, I think that DL tasks _can_ migrate, but only in special
> conditions (hotplug, or if a DL task wakes up when another DL task is
> running and things like that IIRC) but that probably doesn't matter much
> for our discussion here.

More than "special" I'd say "different" (w.r.t. CFS). DL looks at tasks
deadlines and use that info to migrate tasks around. So, it's correct
that they will currently stay on first CPU they run on if no other DL
tasks are around.

Luca's capacity(/energy) awareness stuff should change that in the
future. But that might take a while I guess. :/
