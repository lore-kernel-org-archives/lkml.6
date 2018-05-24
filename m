Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969811AbeEXWXv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:23:51 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39298 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966031AbeEXWXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:23:49 -0400
X-Google-Smtp-Source: AB8JxZoGZKGCDamGWM6qz4Jcmz7oNPIOwTS8hQAv23k76g3CNxsYOfsBkYMwB20e3SHh171VrCtCfvXTylNiz/elq88=
MIME-Version: 1.0
In-Reply-To: <20180524071152.GB12198@hirez.programming.kicks-ass.net>
References: <20180522062017.5193-1-xiyou.wangcong@gmail.com>
 <20180522062017.5193-4-xiyou.wangcong@gmail.com> <CANWdNRCQCteO7L+Of7T2vWBW7GbMHyvyF5aSQMVYNGg_afxNhg@mail.gmail.com>
 <20180523090944.GV12217@hirez.programming.kicks-ass.net> <CAM_iQpUEvWrMPWQussA31kEAiutLR4WUVOtsohHm5hg4wt59Hw@mail.gmail.com>
 <20180524071152.GB12198@hirez.programming.kicks-ass.net>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Thu, 24 May 2018 15:23:28 -0700
Message-ID: <CAM_iQpUKTbk0Gfv5ZXWtXDF_OdJQEP8nWacAdwdv0EBCcZ+c=g@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/fair: add tracepoints for cfs throttle
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ivan Babrou <ibobrik@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 12:11 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> The problem with tracepoints is that they can become ABI and you cannot
> change them without breaking tools. This is a crap situation and I'm fed
> up with it.

Yeah, I once used perf_event_open() to parse the trace events, I
understand how painful it is. Fortunately tools like bcc mostly hides
the ABI from end user. To be fair, kprobe has the same problem if not
worse, different compilers could inline different kernel functions, not
to mention kernel functions could change at any time.

OTOH, the tracepoint text interface is sufficient to help people to inspect
kernel internals, like in this case I can observe when a cpu cgroup is
throttled or unthrottled. Of course they are not friendly for programming.

Thanks.
