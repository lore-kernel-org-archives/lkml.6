Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbeBLUJx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:09:53 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:50074 "EHLO
        rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeBLUJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:09:52 -0500
Date: Mon, 12 Feb 2018 21:01:27 +0100
From: Andreas Mohr <andi@lisas.de>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Do not migrate due to a sync wakeup on
 exit
Message-ID: <20180212200127.GA27522@rhlx01.hs-esslingen.de>
References: <20180212145857.8056-1-mgorman@techsingularity.net>
 <20180212145857.8056-5-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212145857.8056-5-mgorman@techsingularity.net>
X-Priority: none
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Feb 12, 2018 at 02:58:57PM +0000, Mel Gorman wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 28c8d9c91955..50442697b455 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5710,8 +5710,14 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>  	if (idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
>  		return idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
>  
> -	if (sync && cpu_rq(this_cpu)->nr_running == 1)
> +	if (sync && cpu_rq(this_cpu)->nr_running == 1) {
> +		/* Avoid tasks exiting pulling parents to new nodes */

Semi-confusing wording (WTH are "pulling parents"? :) - possibly better variant?:
Avoid having exiting tasks pull their parents to new nodes


Good catch, it seems.

HTH,

Andreas Mohr

-- 
GNU/Linux. It's not the software that's free, it's you.
