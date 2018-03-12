Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeCLLqz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:46:55 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:44497 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeCLLqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:46:53 -0400
X-Google-Smtp-Source: AG47ELt+3rjh6b6rYThMLB5uhpGjIcuhI5a0EyoJ37Rk6Yk0zPAvLPc8T4i5BmHTcNSvdCGx4Kqa9mw3gXBEoREEAY0=
MIME-Version: 1.0
In-Reply-To: <20180312075307.iut52znscixqcpag@gmail.com>
References: <20180306093637.28247-1-linxiulei@gmail.com> <20180312075307.iut52znscixqcpag@gmail.com>
From: Lin Xiulei <linxiulei@gmail.com>
Date: Mon, 12 Mar 2018 19:46:52 +0800
Message-ID: <CALPjY3mx37seF_=S90B_2=zq_UjEiQSZSKuyjSDQ0ci7ytc0LQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] perf/core: Fix installing arbitrary cgroup
 event into cpu
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@redhat.com>,
        mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Stephane Eranian <eranian@gmail.com>, torvalds@linux-foundation.org,
        linux-perf-users@vger.kernel.org,
        Brendan Gregg <brendan.d.gregg@gmail.com>, yang_oliver@hotmail.com,
        "leilei.lin" <leilei.lin@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-12 15:53 GMT+08:00 Ingo Molnar <mingo@kernel.org>:
>
> * linxiulei@gmail.com <linxiulei@gmail.com> wrote:
>
>>       /*
>>        * Because cgroup events are always per-cpu events,
>>        * this will always be called from the right CPU.
>>        */
>
>> +     /*
>> +      * if only the cgroup is running on this cpu
>> +      * and cpuctx->cgrp == NULL (otherwise it would've
>> +      * been set with running cgroup), we put this cgroup
>> +      * into cpu context. Or it would case mismatch in
>> +      * following cgroup events at event_filter_match()
>> +      */
>
> Beyond making sure that what you comment on makes sense, please also follow
> existing comment style, which I quoted above.
>
> There's 3 separate mistakes in that paragraph alone.
>
> Thanks,
>
>         Ingo

Thank Ingo for pointing it out. though I'd try to follow it as
possible as I could. I wish I have somewhere to check style with
specific documents : )

+       /*
+        * We will set cpuctx->cgrp only if:
+        *   1) cpuctx->cgrp is NULL. Because cpuctx->cgrp was set
+        *      correctly by sched_in(). We don't need to set it again.
+        *   2) cgroup related to this event is running on this CPU.
+        *      Otherwise it will fail in event_filter_match()
+        */

Peter, did I explain that logic clearly and prove it right?

Regards
