Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeC0VJi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:09:38 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:39235 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeC0VJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:09:36 -0400
X-Google-Smtp-Source: AIpwx4+lPPvpYZnlL/GOPOIAp8EJI/RRPMoLmWf41JWGG+XhUPh5wDLtSpvVINAIUoQhY8oy7ZqxdwabXZaLfpAKYV4=
MIME-Version: 1.0
In-Reply-To: <1522173764.6308.68.camel@surriel.com>
References: <4137867.C4jYrWdt8n@aspire.rjw.lan> <20180314120450.GT4043@hirez.programming.kicks-ass.net>
 <1521736338.6308.24.camel@surriel.com> <CAJZ5v0ikayycQs1m2rTa8WRLZ5sQ5q2SQVZkDuuy6GOE=dJFQQ@mail.gmail.com>
 <1522173764.6308.68.camel@surriel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Mar 2018 23:09:35 +0200
X-Google-Sender-Auth: -4pG_MyAtkZVchbtzU2-Om1Nj-M
Message-ID: <CAJZ5v0ggZfDkO8hR5iwCcyHvMzxe5R0_T3jYyOGmTuHMC2N-9Q@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: poll_state: Add time limit to poll_idle()
To: Rik van Riel <riel@surriel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 8:02 PM, Rik van Riel <riel@surriel.com> wrote:
> On Tue, 2018-03-27 at 18:42 +0200, Rafael J. Wysocki wrote:
>> On Thu, Mar 22, 2018 at 5:32 PM, Rik van Riel <riel@surriel.com>
>> wrote:
>> > On Wed, 2018-03-14 at 13:04 +0100, Peter Zijlstra wrote:
>> >
>> > > On x86 we don't have to use that time_check_counter thing,
>> > > sched_clock()
>> > > is really cheap, not sure if it makes sense on other platforms.
>> >
>> > Are you sure? I saw a 5-10% increase in CPU use,
>> > for a constant query rate to a memcache style
>> > workload, with v3 of this patch.
>>
>> I think I know what's going on.
>
> I ran my tests wrong, and the script never propagated
> errors back to me. Sigh.

Again, no worries. :-)

> However, the poll_idle() that reads the TSC at a
> reduced rate seems to perform better than the one
> that reads the TSC every time it goes around the
> loop.

OK

> The size of the idle loop seems to make a slight
> difference, too. Having just one cpu_relax() in
> the entire loop seems to be better than having
> them all over the place.

OK

Thanks for the above observations, they match my understanding of
what's happening.

I'll resend the patch to read the TSC at a reduced rate with a proper
changelog and I'll tentatively add it to my pm-cpuidle branch.

Thanks!
