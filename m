Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbeDMLf2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:35:28 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33133 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeDMLf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:35:27 -0400
X-Google-Smtp-Source: AIpwx4/V8xzxAC9251jngnOU1j+S+O4ZhZL6rt0w+pqGsPvhUKXs8KhzSGiauCDMEB/YDgeX6j74nDg5OA533H6AzQ8=
MIME-Version: 1.0
In-Reply-To: <20180412182211.GC4082@hirez.programming.kicks-ass.net>
References: <CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com>
 <74865492-d9a6-649d-d37c-a5a6a8c28f23@arm.com> <CAKfTPtDy2uUj4amA9MARUz9qS=+urwV2edyQn+fW70hkN+CgoQ@mail.gmail.com>
 <e8e6e7d0-7744-1dab-7b24-b7ff37df60c8@arm.com> <CAKfTPtCQayuu5-84931ZxzXV1-roV_CfRd_5wXG1oxOEUZmZgw@mail.gmail.com>
 <20180405154630.GS4589@e105550-lin.cambridge.arm.com> <CAKfTPtBv7BzAqZWTxU9HaCoNjQa2B8usk6dfO1qgofjGYG7S=w@mail.gmail.com>
 <20180406125825.GT4589@e105550-lin.cambridge.arm.com> <CAKfTPtCfCZzuBgdYzWW_KcT34VTgj6utUF+Q5zSpre+Ky2r4eA@mail.gmail.com>
 <20180410131950.GU4589@e105550-lin.cambridge.arm.com> <20180412182211.GC4082@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 13 Apr 2018 13:35:05 +0200
Message-ID: <CAKfTPtCXz69f0dCqnAQZtgrz4JjbSHcZfZoiHh8rkCX8Q2dHKQ@mail.gmail.com>
Subject: Re: [PATCH] sched: support dynamiQ cluster
To: Peter Zijlstra <peterz@infradead.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chris Redpath <chris.redpath@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 April 2018 at 20:22, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Apr 10, 2018 at 02:19:50PM +0100, Morten Rasmussen wrote:
>> As said above, I see your point about completion time might suffer in
>> some cases for low utilization tasks, but I don't see how you can fix
>> that automagically. ASYM_PACKING has a lot of problematic side-effects.
>> If use-space knows that completion time is important for a task, there
>> are already ways to improve that somewhat in mainline (task priority and
>> pinning), and more powerful solutions in the Android kernel which
>> Patrick is currently pushing upstream.
>
> So I tend to side with Morten on this one. I don't particularly like
> ASYM_PACKING much, but we already had it for PPC and it works for the
> small difference in performance ITMI has.
>
> At the time Morten already objected to using it for ITMI, and I just
> haven't had time to look into his proposal for using capacity.
>
> But I don't see it working right for big.litte/dynamiq, simply because
> it is a very strong always big preference, which is against the whole
> design premisis of big.little (as Morten has been trying to argue).

In fact, Little not only gives some better power efficiency but it
also handles far better some stuff like interrupt handling as an
example
Nevertheless, whatever the solution, it will never fit with
big.Little/dynamiQ system without some EAS as soon as the power
efficiency is involved in the equation.
I have planned to test more deeply how ASYM_PACKING works with EAS
when i will have finished others on going activity.

>
