Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754513AbeDWJd3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:33:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754190AbeDWJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:33:28 -0400
Date: Mon, 23 Apr 2018 11:33:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        dan.j.williams@intel.com, torvalds@linux-foundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 0/7] Various Spectre-v1 fixes
Message-ID: <20180423093321.GV4064@hirez.programming.kicks-ass.net>
References: <20180420131407.721875616@infradead.org>
 <20180423010343.GG16083@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423010343.GG16083@dhcp22.suse.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 07:03:44PM -0600, Michal Hocko wrote:
> On Fri 20-04-18 15:14:07, Peter Zijlstra wrote:
> > These fix a number of perf, x86 and sched cases where we have user controlled
> > array dereferences.  All were found by Dan's recent Smatch update.
> 
> Do we want to mark all of these for stable?

If we all agree that any (speculative) user-controlled array index --
irrespective of the existence of the second load/store that would
complete the gadget -- needs fixing and thus all these patches are
'good', then yes, that makes sense.

Given yours is the only response so far, I suspect we're good on all
that :-)
