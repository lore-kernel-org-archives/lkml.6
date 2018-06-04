Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753775AbeFDHPT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:15:19 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52826 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbeFDHPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:15:16 -0400
X-Google-Smtp-Source: ADUXVKJnU4BlCY5ip0cPb6Kqhv1Lwh7dRb/7PCWQy2/G/rAClq3ZvGoeqKqf3ka5s7LjhEn/8pnkoH+qUZALuFIe5No=
MIME-Version: 1.0
In-Reply-To: <20180604070438.GA2731@localhost.localdomain>
References: <1527253951-22709-6-git-send-email-vincent.guittot@linaro.org>
 <20180528101234.GA1293@localhost.localdomain> <CAKfTPtDCkzPMt6XrXRcURXm=53LABiwbFd3JMQkJDWpTprycRQ@mail.gmail.com>
 <20180528152243.GD1293@localhost.localdomain> <CAKfTPtAY26HZ00R02RuW2kvZLvZxHGvh-kbfrqv-hPumdknvWg@mail.gmail.com>
 <20180531102735.GM30654@e110439-lin> <CAKfTPtCeoimTehLktVk4WiTEM5h9KW_4yvuxGof8p6ZOgsRE2Q@mail.gmail.com>
 <20180601135307.GA28550@linaro.org> <20180601174526.GA105687@joelaf.mtv.corp.google.com>
 <CAKfTPtBu5D=P3ib6fqfVLz9yQXN19ipRQAz5L6s1+ewnVTrHmg@mail.gmail.com> <20180604070438.GA2731@localhost.localdomain>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 4 Jun 2018 09:14:55 +0200
Message-ID: <CAKfTPtD9KQTeeP0BNyhnqh=UXL0T_jK0PcvWWBjoyj0VC8TkRg@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] cpufreq/schedutil: get max utilization
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Joel Fernandes <joelaf@google.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Alessio Balsini <alessio.balsini@santannapisa.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 June 2018 at 09:04, Juri Lelli <juri.lelli@redhat.com> wrote:
> Hi Vincent,
>
> On 04/06/18 08:41, Vincent Guittot wrote:
>> On 1 June 2018 at 19:45, Joel Fernandes <joelaf@google.com> wrote:
>> > On Fri, Jun 01, 2018 at 03:53:07PM +0200, Vincent Guittot wrote:
>
> [...]
>
>> > IMO I feel its overkill to account dl_avg when we already have DL's running
>> > bandwidth we can use. I understand it may be too instanenous, but perhaps we
>>
>> We keep using dl bandwidth which is quite correct for dl needs but
>> doesn't reflect how it has disturbed other classes
>>
>> > can fix CFS's problems within CFS itself and not have to do this kind of
>> > extra external accounting ?
>
> I would also keep accounting for waiting time due to higher prio classes
> all inside CFS. My impression, when discussing it with you on IRC, was
> that we should be able to do that by not decaying cfs.util_avg when CFS
> is preempted (creating a new signal for it). Is not this enough?

We don't just want to not decay a signal but increase the signal to
reflect the amount of preemption
Then, we can't do that in a current signal. So you would like to add
another metrics in cfs_rq ?
The place doesn't really matter to be honest in cfs_rq or in dl_rq but
you will not prevent to add call in dl class to start/stop the
accounting of the preemption

>
> I feel we should try to keep cross-class accounting/interaction at a
> minimum.

accounting for cross class preemption can't be done without
cross-class accounting

Regards,
Vincent

>
> Thanks,
>
> - Juri
