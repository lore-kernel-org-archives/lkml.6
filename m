Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754983AbeDPLls (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:41:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:37182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753592AbeDPLlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:41:47 -0400
Date: Mon, 16 Apr 2018 13:41:44 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 3/3] dcache: account external names as indirectly
 reclaimable memory
Message-ID: <20180416114144.GK17484@dhcp22.suse.cz>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-5-guro@fb.com>
 <20180413133519.GA213834@rodete-laptop-imager.corp.google.com>
 <20180413135923.GT17484@dhcp22.suse.cz>
 <13f1f5b5-f3f8-956c-145a-4641fb996048@suse.cz>
 <20180413142821.GW17484@dhcp22.suse.cz>
 <20180413143716.GA5378@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413143716.GA5378@cmpxchg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 13-04-18 10:37:16, Johannes Weiner wrote:
> On Fri, Apr 13, 2018 at 04:28:21PM +0200, Michal Hocko wrote:
> > On Fri 13-04-18 16:20:00, Vlastimil Babka wrote:
> > > We would need kmalloc-reclaimable-X variants. It could be worth it,
> > > especially if we find more similar usages. I suspect they would be more
> > > useful than the existing dma-kmalloc-X :)
> > 
> > I am still not sure why __GFP_RECLAIMABLE cannot be made work as
> > expected and account slab pages as SLAB_RECLAIMABLE
> 
> Can you outline how this would work without separate caches?

I thought that the cache would only maintain two sets of slab pages
depending on the allocation reuquests. I am pretty sure there will be
other details to iron out and maybe it will turn out that such a large
portion of the chache would need to duplicate the state that a
completely new cache would be more reasonable. Is this worth exploring
at least? I mean something like this should help with the fragmentation
already AFAIU. Accounting would be just free on top.

-- 
Michal Hocko
SUSE Labs
