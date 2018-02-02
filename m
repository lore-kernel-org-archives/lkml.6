Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754859AbeBBUEf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:04:35 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37206 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754717AbeBBUEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:04:05 -0500
Date: Fri, 2 Feb 2018 21:04:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
Message-ID: <20180202200401.GS2269@hirez.programming.kicks-ass.net>
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
 <20180202172153.GO2269@hirez.programming.kicks-ass.net>
 <ed78c502-c1f8-43b3-f3d4-e0256e4085ee@oracle.com>
 <5b9f0828-8d35-885b-3eba-d31ca46da642@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b9f0828-8d35-885b-3eba-d31ca46da642@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 01:34:58PM -0500, Steven Sistare wrote:
> Actually, I take back my take back.  I suspect the primary benefit
> of random selection is that it breaks up resonance states where
> CPUs that are busy tend to stay busy, and CPUs that are idle tend
> to stay idle, which is reinforced by starting the search at target =
> last cpu ran.

Which, according to there here patches:

  https://lkml.kernel.org/r/20180130104555.4125-1-mgorman@techsingularity.net

is a good thing, because of power management.
