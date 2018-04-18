Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753059AbeDRHym (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:54:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:39033 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752256AbeDRHyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:54:39 -0400
Date: Wed, 18 Apr 2018 09:54:37 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm:memcg: add __GFP_NOWARN in
 __memcg_schedule_kmem_cache_create
Message-ID: <20180418075437.GP17484@dhcp22.suse.cz>
References: <20180418022912.248417-1-minchan@kernel.org>
 <20180418072002.GN17484@dhcp22.suse.cz>
 <20180418074117.GA210164@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418074117.GA210164@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-04-18 16:41:17, Minchan Kim wrote:
> On Wed, Apr 18, 2018 at 09:20:02AM +0200, Michal Hocko wrote:
> > On Wed 18-04-18 11:29:12, Minchan Kim wrote:
[...]
> > > Let's not make user scared.
> > 
> > This is not a proper explanation. So what exactly happens when this
> > allocation fails? I would suggest something like the following
> > "
> > __memcg_schedule_kmem_cache_create tries to create a shadow slab cache
> > and the worker allocation failure is not really critical because we will
> > retry on the next kmem charge. We might miss some charges but that
> > shouldn't be critical. The excessive allocation failure report is not
> > very much helpful. Replace it with a rate limited single line output so
> > that we know that there is a lot of these failures and that we need to
> > do something about it in future.
> > "
> > 
> > With the last part to be implemented of course.
> 
> If you want to see warning and catch on it in future, I don't see any reason
> to change it. Because I didn't see any excessive warning output that it could
> make system slow unless we did ratelimiting.

Yeah, but a single line would be as much informative and less scary to
users.

> It was a just report from non-MM guys who have a concern that somethings
> might go wrong on the system. I just wanted them relax since it's not
> critical.

I do agree with __GFP_NOWARN but I think a single line warning is due
and helpful for further debugging.

-- 
Michal Hocko
SUSE Labs
