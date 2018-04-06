Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeDFQem (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:34:42 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:50422 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbeDFQel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:34:41 -0400
Date: Fri, 6 Apr 2018 12:36:05 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH]
 mm-vmscan-dont-mess-with-pgdat-flags-in-memcg-reclaim-v2-fix
Message-ID: <20180406163605.GE20806@cmpxchg.org>
References: <CALvZod7P7cE38fDrWd=0caA2J6ZOmSzEuLGQH9VSaagCbo5O+A@mail.gmail.com>
 <20180406135215.10057-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406135215.10057-1-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 04:52:15PM +0300, Andrey Ryabinin wrote:
> On 04/06/2018 05:13 AM, Shakeel Butt wrote:
> > Question: Should this 'flags' be per-node? Is it ok for a congested
> > memcg to call wait_iff_congested for all nodes?
> 
> Indeed, congestion state should be pre-node. If memcg on node A is
> congested, there is no point is stalling memcg reclaim from node B.
> 
> Make congestion state per-cgroup-per-node and record it in
> 'struct mem_cgroup_per_node'.
> 
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

Thanks for fixing this, Andrey. This is great.

For the combined patch and this fix:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
