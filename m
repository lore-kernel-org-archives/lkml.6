Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755815AbeDWQrs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:47:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:58214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755177AbeDWQro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:47:44 -0400
Date: Mon, 23 Apr 2018 10:47:40 -0600
From: Michal Hocko <mhocko@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        dan.j.williams@intel.com, torvalds@linux-foundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 0/7] Various Spectre-v1 fixes
Message-ID: <20180423164740.GY17484@dhcp22.suse.cz>
References: <20180420131407.721875616@infradead.org>
 <20180423010343.GG16083@dhcp22.suse.cz>
 <20180423093321.GV4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423093321.GV4064@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-04-18 11:33:21, Peter Zijlstra wrote:
> On Sun, Apr 22, 2018 at 07:03:44PM -0600, Michal Hocko wrote:
> > On Fri 20-04-18 15:14:07, Peter Zijlstra wrote:
> > > These fix a number of perf, x86 and sched cases where we have user controlled
> > > array dereferences.  All were found by Dan's recent Smatch update.
> > 
> > Do we want to mark all of these for stable?
> 
> If we all agree that any (speculative) user-controlled array index --
> irrespective of the existence of the second load/store that would
> complete the gadget -- needs fixing and thus all these patches are
> 'good', then yes, that makes sense.

Well, I would rather be on the safe side (have I heard security by
fear?). So if those patches are landing in upstream then I would vote to
mark them for stable. They should be trivial to backport and shouldn't
cause regressions that makes them more suitable stable candidates than
many I have seen recently...

-- 
Michal Hocko
SUSE Labs
