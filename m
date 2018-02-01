Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754871AbeBAT5W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:57:22 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36202 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753319AbeBAT5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:57:14 -0500
X-Google-Smtp-Source: AH8x2268Gku8zvoleRRSD6tgdVrDhPA2ZrIRyc2H49nEhTu+pdvt5ETCVbXm/XKQYFwU/ysAVY/suA==
Date: Thu, 1 Feb 2018 11:57:10 -0800
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v4.15-rc9] sched, cgroup: Don't reject lower cpu.max on
 ancestors
Message-ID: <20180201195710.GK1121507@devbig577.frc2.facebook.com>
References: <20180122192618.GA1771050@devbig577.frc2.facebook.com>
 <20180130102156.GS2249@hirez.programming.kicks-ass.net>
 <20180130145639.GD1121507@devbig577.frc2.facebook.com>
 <20180201164942.GC2249@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201164942.GC2249@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Feb 01, 2018 at 05:49:42PM +0100, Peter Zijlstra wrote:
> > Well, they're upper limits, not strict allocations.  The current
> > behavior implemented by cpu isn't either a strict allocation or upper
> > limits.  It disallows a child from having a value higher than the
> > parent (allocation-ish) but the sum of the children is allowed to
> > exceed the parent's (limit-ish).
> 
> True; but its still weird to have the parent 'promise' something and
> then retract that 'promise' later.

Yeah, depending on how you look at it, it can feel weird.  It's just
that viewing these absolute resource limits (cpu.max,
memory.{high,max}, io.max, pids.max) as upper bounds seems to be the
best abstraction in terms of capturing what they do and making uses of
them in a robust way.

> > We had this sort of input validations in different controllers all in
> > their own ways.  In most cases, these aren't well thought out and we
> > can't support things like delegation without aligning controller
> > behaviors.
> 
> I suppose.. 
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Will route it through cgroup fixes branch in a week or so.

Thanks a lot.

-- 
tejun
