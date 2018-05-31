Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754270AbeEaJ0m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:26:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37234 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754112AbeEaJ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:26:40 -0400
Date: Thu, 31 May 2018 11:26:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH 1/3] sched: remove select_idle_core() for scalability
Message-ID: <20180531092619.GS12198@hirez.programming.kicks-ass.net>
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-2-subhra.mazumdar@oracle.com>
 <20180424124621.GQ4082@hirez.programming.kicks-ass.net>
 <df8f4982-908a-23e6-5148-4d4e91d38be4@oracle.com>
 <20180425174909.GB4043@hirez.programming.kicks-ass.net>
 <e2011797-382b-0ac9-79eb-e17109ef4c96@oracle.com>
 <20180501180348.GI12217@hirez.programming.kicks-ass.net>
 <1ea04602-041a-5b90-eba9-c20c7e98c92e@oracle.com>
 <20180529213600.GC12180@hirez.programming.kicks-ass.net>
 <b2157df2-53d4-79e1-d307-7634fbc844d6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2157df2-53d4-79e1-d307-7634fbc844d6@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 03:08:21PM -0700, Subhra Mazumdar wrote:
> I tested with FOLD+AGE+ONCE+PONIES+PONIES2 shift=0 vs baseline but see some
> regression for hackbench and uperf:

I'm not seeing a hackbench regression myself, but I let it run a whole
lot of stuff over-night and I do indeed see some pain points, including
sysbench-mysql and some schbench results.

> I have a patch which is much smaller but seems to work well so far for both
> x86 and SPARC across benchmarks I have run so far. It keeps the idle cpu
> search between 1 core and 2 core amount of cpus and also puts a new
> sched feature of doing idle core search or not. It can be on by default but
> for workloads (like Oracle DB on x86) we can turn it off. I plan to send
> that after some more testing.

Sure thing..
