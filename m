Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeBLRfW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:35:22 -0500
Received: from casper.infradead.org ([85.118.1.10]:58296 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbeBLRfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:35:19 -0500
Date: Mon, 12 Feb 2018 18:34:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/numa: Delay retrying placement for automatic
 NUMA balance after wake_affine
Message-ID: <20180212173449.GA25201@hirez.programming.kicks-ass.net>
References: <20180212171131.26139-1-mgorman@techsingularity.net>
 <20180212171131.26139-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212171131.26139-3-mgorman@techsingularity.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 05:11:31PM +0000, Mel Gorman wrote:

> However, the benefit in other cases is large. This is the result for NAS
> with the D class sizing on a 4-socket machine
> 
>                           4.15.0                 4.15.0
>                     sdnuma-v1r23       delayretry-v1r23
> Time cg.D      557.00 (   0.00%)      431.82 (  22.47%)
> Time ep.D       77.83 (   0.00%)       79.01 (  -1.52%)
> Time is.D       26.46 (   0.00%)       26.64 (  -0.68%)
> Time lu.D      727.14 (   0.00%)      597.94 (  17.77%)
> Time mg.D      191.35 (   0.00%)      146.85 (  23.26%)

Last time I checked, we were some ~25% from OMP_PROC_BIND with NAS, this
seems to close that hole significantly. Do you happen to have
OMP_PROC_BIND numbers handy to see how far away we are from manual
affinity?
