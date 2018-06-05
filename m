Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeFEI6n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:58:43 -0400
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:36170 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751591AbeFEI6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:58:42 -0400
Date: Tue, 5 Jun 2018 09:58:40 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 09/19] sched/numa: Modify migrate_swap to accept
 additional params
Message-ID: <20180605085840.5film7evducjmirf@techsingularity.net>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-10-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1528106428-19992-10-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 03:30:18PM +0530, Srikar Dronamraju wrote:
> There are checks in migrate_swap_stop that check if the task/cpu
> combination is as per migrate_swap_arg before migrating.
> 
> However atleast one of the two tasks to be swapped by migrate_swap could
> have migrated to a completely different cpu before updating the
> migrate_swap_arg. The new cpu where the task is currently running could
> be a different node too. If the task has migrated, numa balancer might
> end up placing a task in a wrong node.  Instead of achieving node
> consolidation, it may end up spreading the load across nodes.
> 
> To avoid that pass the cpus as additional parameters.
> 
> While here, place migrate_swap under CONFIG_NUMA_BALANCING.
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
