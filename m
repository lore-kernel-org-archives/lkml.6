Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbeEXElJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 00:41:09 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34388 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeEXElI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 00:41:08 -0400
X-Google-Smtp-Source: AB8JxZr0VL5T0XTpQjWe6DCcI424yEltlbOoqmT2VemlngRZbdvM+YJ+atJC8krcqCOnMj9jPE9coS2keyVUy3IyOTc=
MIME-Version: 1.0
In-Reply-To: <20180523090944.GV12217@hirez.programming.kicks-ass.net>
References: <20180522062017.5193-1-xiyou.wangcong@gmail.com>
 <20180522062017.5193-4-xiyou.wangcong@gmail.com> <CANWdNRCQCteO7L+Of7T2vWBW7GbMHyvyF5aSQMVYNGg_afxNhg@mail.gmail.com>
 <20180523090944.GV12217@hirez.programming.kicks-ass.net>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 23 May 2018 21:40:47 -0700
Message-ID: <CAM_iQpUEvWrMPWQussA31kEAiutLR4WUVOtsohHm5hg4wt59Hw@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/fair: add tracepoints for cfs throttle
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ivan Babrou <ibobrik@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 2:09 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, May 21, 2018 at 11:35:38PM -0700, Ivan Babrou wrote:
>> > +       TP_printk("path=%s cpu=%d runtime_remaining=%lld",
>> > __get_str(cfs_path),
>> > +                 __entry->cpu, __entry->runtime_remaining)
>> >
>>
>> Can you add "[ns]" as the unit to runtime_remaining? We have it in
>> "sched:sched_stat_runtime".
>
> Yeah, don't worry. I hate tracepoints, I regret the existing ones, no
> new ones will happen.

No matter you hate them or not, they are useful:

https://github.com/iovisor/bcc/blob/master/tools/runqlat.py

Unlike in sched, tracepoints are welcome in networking:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/include/trace/events/tcp.h

I don't want to change your mind, just want to show the facts.
