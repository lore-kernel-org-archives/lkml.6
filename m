Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeFDM35 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:29:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:51882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbeFDM34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:29:56 -0400
Date: Mon, 4 Jun 2018 14:29:53 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] mm: don't skip memory guarantee calculations
Message-ID: <20180604122953.GN19202@dhcp22.suse.cz>
References: <20180522132528.23769-1-guro@fb.com>
 <20180522132528.23769-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522132528.23769-2-guro@fb.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-05-18 14:25:28, Roman Gushchin wrote:
> There are two cases when effective memory guarantee calculation
> is mistakenly skipped:
> 
> 1) If memcg is a child of the root cgroup, and the root
> cgroup is not root_mem_cgroup (in other words, if the reclaim
> is targeted). Top-level memory cgroups are handled specially
> in mem_cgroup_protected(), because the root memory cgroup doesn't
> have memory guarantee and can't limit its children guarantees.
> So, all effective guarantee calculation is skipped.
> But in case of targeted reclaim things are different:
> cgroups, which parent exceeded its memory limit aren't special.
> 
> 2) If memcg has no charged memory (memory usage is 0). In this
> case mem_cgroup_protected() always returns MEMCG_PROT_NONE, which
> is correct and prevents to generate fake memory low events for
> empty cgroups. But skipping memory emin/elow calculation is wrong:
> if there is no global memory pressure there might be no good
> chance again, so we can end up with effective guarantees set to 0
> without any reason.

Roman, so these two patches are on top of the min limit patches, right?
The fact that they come after just makes me feel this whole thing is not
completely thought through and I would like to see all 4 patch in one
series describing the whole design. We are getting really close to the
merge window and last minute updates makes me really nervouse. Can you
please repost the whole thing after the merge window, please?

As I've said earlier I am not even sure we really want to have a hard
guarantee once we decided to go with low limit. So a very good reasoning
should be added for the whole thing.

Thanks!
-- 
Michal Hocko
SUSE Labs
