Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeDMOfy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:35:54 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:51368 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753103AbeDMOfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:35:52 -0400
Date: Fri, 13 Apr 2018 10:37:16 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 3/3] dcache: account external names as indirectly
 reclaimable memory
Message-ID: <20180413143716.GA5378@cmpxchg.org>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-5-guro@fb.com>
 <20180413133519.GA213834@rodete-laptop-imager.corp.google.com>
 <20180413135923.GT17484@dhcp22.suse.cz>
 <13f1f5b5-f3f8-956c-145a-4641fb996048@suse.cz>
 <20180413142821.GW17484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413142821.GW17484@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 04:28:21PM +0200, Michal Hocko wrote:
> On Fri 13-04-18 16:20:00, Vlastimil Babka wrote:
> > We would need kmalloc-reclaimable-X variants. It could be worth it,
> > especially if we find more similar usages. I suspect they would be more
> > useful than the existing dma-kmalloc-X :)
> 
> I am still not sure why __GFP_RECLAIMABLE cannot be made work as
> expected and account slab pages as SLAB_RECLAIMABLE

Can you outline how this would work without separate caches?
