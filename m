Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB5CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE45020875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3B8OHJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE45020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeGXQfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:35:45 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53249 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeGXQfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:35:43 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so4280416itw.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lccaIhC7T9n6pgdGVt3ciPqkrhXDs5G/Xx0YB4NVu24=;
        b=n3B8OHJlSdXmtoNME/eAUyD/8Y5SB8IvpMwlg+BN0zIw8fWch5k27xThejKs6Mdt8+
         s0lot3ZYtZFd1wSswn3YCpuyALsv9RDB8CwVAzQhTs9FyamWf5ukI2qdHuCL1O7m6q34
         i8WLB6KkZC0SQzPkIYquYE8WZqKfwNzN8ckgumikGwsY33PDoSwu3qFaTG32W1BljvIC
         rvRXyZqoHun8PBGrKkEv65cFCa+KRPQQ09HoG6lwcSvOvPerqvPaQzJSk0P7dcZ19OVw
         iX3nZUKEdn/nrSi95aZKCU/lWSjaDvkahby7oACXgLnYyHEzJSBfxt+Q6DlQtT9gyuY6
         Ud/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lccaIhC7T9n6pgdGVt3ciPqkrhXDs5G/Xx0YB4NVu24=;
        b=sH1vyFQnlVyzQoRPKhEbRLxgVJNntr0lnLtLrH1Kb0AIHrGOoli6lbGeeyGfyBb5Hp
         YdRfmkhpYuVsMjknjG14ZgVRSdmbShs2TDJm3uW3TKiQwIri9HPKulQ+VQ6Say1GvY4V
         /zHDB7KrDU9IeY5iqYHZ6AKnnrozg1u7yzrm5GHmQuAuJclUIwz3ANoKzOBqj+eU2RTy
         UBcWkYPv3/V1D4ZHwgMyaLxIu4t0MY57xIAy4Eh8MUZdC2bjYTE3IqccD/Hwjm0AALwe
         ydY7yC2k0RPqhSLZmqK2P+jDuroXU0RPRuwO5Z5JQZtGkhJPPasHpJdVxsVSuKOM9vRc
         rVdA==
X-Gm-Message-State: AOUpUlHGGHVnWY84KTiGLe+faEgvuEhjRkzLtibCszK0q1+WNe2mDe+5
        RpSRVWsY+Gpd3a24iZqhxBpXoiZYmi42xFshSLvOAMQQPSM=
X-Google-Smtp-Source: AAOMgpf9F/DrbPSH+Fp0Ks+4HkkHoc4A7nzVQWJW3oczlbXAwmYlD+z0oscJDT1n+xRL2gOfMU9HKcWHRIsRv7anm0U=
X-Received: by 2002:a24:ecc6:: with SMTP id g189-v6mr2956027ith.21.1532446122291;
 Tue, 24 Jul 2018 08:28:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 08:28:41
 -0700 (PDT)
In-Reply-To: <20180724095550.GA3162@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-11-patrick.bellasi@arm.com> <CAJuCfpFnj2g3+ZpR4fP4yqfxs0zd=c-Zehr2XM7m_C+WdL9jNA@mail.gmail.com>
 <20180723154025.GF2683@e110439-lin> <CAJuCfpHJ=O1QVFZZ2dpaDDQe+dX1aGkzWdcd76c9zZpxw2fNtA@mail.gmail.com>
 <20180724095550.GA3162@e110439-lin>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 24 Jul 2018 08:28:41 -0700
Message-ID: <CAJuCfpEUsq=LPZgz20jn79CwymQGgfif8j8fzurUDmEJ3G9q5w@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] sched/core: uclamp: use TG's clamps to restrict
 Task's clamps
To:     Patrick Bellasi <patrick.bellasi@arm.com>
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
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick. Thanks for the explanation and links. No more questions
from me on this one :)

On Tue, Jul 24, 2018 at 2:56 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> On 23-Jul 10:11, Suren Baghdasaryan wrote:
>> On Mon, Jul 23, 2018 at 8:40 AM, Patrick Bellasi
>> <patrick.bellasi@arm.com> wrote:
>> > On 21-Jul 20:05, Suren Baghdasaryan wrote:
>> >> On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
>
> [...]
>
>> >> So to satisfy both TG and syscall requirements I think you would
>> >> need to choose the largest value for UCLAMP_MIN and the smallest one
>> >> for UCLAMP_MAX, meaning the most boosted and most clamped range.
>> >> Current implementation choses the least boosted value, so
>> >> effectively one of the UCLAMP_MIN requirements (either from TG or
>> >> from syscall) are being ignored...  Could you please clarify why
>> >> this choice is made?
>> >
>> > The TG values are always used to specify a _restriction_ on
>> > task-specific values.
>> >
>> > Thus, if you look or example at the CPU mask for a task, you can have
>> > a task with affinity to CPUs 0-1, currently running on a cgroup with
>> > cpuset.cpus=0... then the task can run only on CPU 0 (althought its
>> > affinity includes CPU1 too).
>> >
>> > Same we do here: if a task has util_min=10, but it's running in a
>> > cgroup with cpu.util_min=0, then it will not be boosted.
>> >
>> > IOW, this allows to implement a "nice" policy at task level, where a
>> > task (via syscall) can decide to be less boosted with respect to its
>> > group but never more boosted. The same task can also decide to be more
>> > clamped, but not less clamped then its current group.
>> >
>>
>> The fact that boost means "at least this much" to me seems like we can
>> safely choose higher CPU bandwidth (as long as it's lower than
>> UCLAMP_MAX)
>
> I understand your view point, which actually is matching my first
> implementation for util_min aggregation:
>
>    https://lore.kernel.org/lkml/20180409165615.2326-5-patrick.bellasi@arm.com/
>
>
>> but from your description sounds like TG's UCLAMP_MIN means "at most
>> this much boost" and it's not safe to use CPU bandwidth higher than
>> TG's UCLAMP_MIN.
>
> Indeed, after this discussion with Tejun:
>
>    https://lore.kernel.org/lkml/20180409222417.GK3126663@devbig577.frc2.facebook.com/
>
> I've convinced myself that for the cgroup interface we have to got for
> a "restrictive" interface where a parent value must set the upper
> bound for all its descendants values. AFAIU, that's one of the basic
> principles of the "delegation model" implemented by cgroups and the
> common behavior implemented by all controllers.
>
>> So instead of specifying min CPU bandwidth for a task it specifies
>> the max allowed boost. Seems like a discrepancy to me but maybe
>> there are compelling usecases when this behavior is necessary?
>
> I don't think it's strictly related to use-cases, you can always
> describe a give use-case in one model or the other.  It all depends on
> how you configure your hierarchy and where you place your tasks.
>
> For our Android use cases, we are still happy to say that all tasks of
> a CGroup can be boosted up to a certain value and then we can either:
> - don't configure tasks: and thus get the CG defined boost
> - configure a task: and explicitly give back what we don't need
>
> This model works quite well with containers, where the parent want to
> precisely control how much resources are (eventually) usable by a
> given container.
>
>> In that case would be good to spell them out to explain why this
>> choice is made.
>
> Yes, well... if I understand it correctly is really just the
> recommended way cgroups must be used to re-partition resources.
>
> I'll try to better explain this behavior in the changelog for this
> patch.
>
> [...]
>
> Best,
> Patrick
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
