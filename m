Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965513AbeEIQeO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:34:14 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:40197 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935232AbeEIQeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:34:12 -0400
Date: Wed, 9 May 2018 17:34:10 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: torvalds@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, efault@gmx.de, linux-kernel@vger.kernel.org,
        matt@codeblueprint.co.uk, peterz@infradead.org, ggherdovich@suse.cz,
        linux-tip-commits@vger.kernel.org, mpe@ellerman.id.au
Subject: Re: [tip:sched/core] sched/numa: Delay retrying placement for
 automatic NUMA balance after wake_affine()
Message-ID: <20180509163410.trju4eyrtslb3sk5@techsingularity.net>
References: <20180213133730.24064-7-mgorman@techsingularity.net>
 <tip-7347fc87dfe6b7315e74310ee1243dc222c68086@git.kernel.org>
 <20180507110607.GA3828@linux.vnet.ibm.com>
 <20180509084148.qzpsetz74pkg7g33@techsingularity.net>
 <20180509105814.GA41120@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180509105814.GA41120@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 03:58:14AM -0700, Srikar Dronamraju wrote:
> In the other scenario, where wake_affine set p->numa_migrate_preferred to a
> bigger value, the task calls numa_migrate_preferred(),
> numa_migrate_preferred  could be before p->numa_migrate_preferred. In
> such a case, we should have stopped the task from migration.
> However we overwrite p->numa_migrate_preferred and do the
> task_numa_migrate(). Somehow this doesn't seem to achieve what the
> commit intended.
> 
> Or did I misunderstand?
> 

Nope, the logic is broken. While it can be "fixed", the end result adds
complexity for very little gain. I believe the right path for the moment
is a revert and retry at a future date.

Thanks.

-- 
Mel Gorman
SUSE Labs
