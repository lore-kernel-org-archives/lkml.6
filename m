Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeBLUJl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:09:41 -0500
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:39164 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751021AbeBLUJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:09:40 -0500
Date: Mon, 12 Feb 2018 20:09:38 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Andreas Mohr <andi@lisas.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Do not migrate due to a sync wakeup on
 exit
Message-ID: <20180212200938.sfofuhztrsbvsriy@techsingularity.net>
References: <20180212145857.8056-1-mgorman@techsingularity.net>
 <20180212145857.8056-5-mgorman@techsingularity.net>
 <20180212200127.GA27522@rhlx01.hs-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180212200127.GA27522@rhlx01.hs-esslingen.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 09:01:27PM +0100, Andreas Mohr wrote:
> Hello,
> 
> On Mon, Feb 12, 2018 at 02:58:57PM +0000, Mel Gorman wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 28c8d9c91955..50442697b455 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5710,8 +5710,14 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
> >  	if (idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
> >  		return idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
> >  
> > -	if (sync && cpu_rq(this_cpu)->nr_running == 1)
> > +	if (sync && cpu_rq(this_cpu)->nr_running == 1) {
> > +		/* Avoid tasks exiting pulling parents to new nodes */
> 
> Semi-confusing wording (WTH are "pulling parents"? :) - possibly better variant?:
> Avoid having exiting tasks pull their parents to new nodes

That is better wording. If I don't replace the patch with Peter's
version, I'll update it.

> Good catch, it seems.
> 

Thanks.

-- 
Mel Gorman
SUSE Labs
