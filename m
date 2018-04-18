Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeDRNju (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:39:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:33532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753082AbeDRNjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:39:49 -0400
Date: Wed, 18 Apr 2018 15:39:47 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm:memcg: add __GFP_NOWARN in
 __memcg_schedule_kmem_cache_create
Message-ID: <20180418133947.GE17484@dhcp22.suse.cz>
References: <20180418022912.248417-1-minchan@kernel.org>
 <20180418133139.GB27475@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418133139.GB27475@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-04-18 06:31:39, Matthew Wilcox wrote:
> On Wed, Apr 18, 2018 at 11:29:12AM +0900, Minchan Kim wrote:
> > If there are heavy memory pressure, page allocation with __GFP_NOWAIT
> > fails easily although it's order-0 request.
> > I got below warning 9 times for normal boot.
> > 
> > Let's not make user scared.
> 
> Actually, can you explain why it's OK if this fails?  As I understand this
> code, we'll fail to create a kmalloc cache for this memcg.  What problems
> does that cause?

See http://lkml.kernel.org/r/20180418072002.GN17484@dhcp22.suse.cz

-- 
Michal Hocko
SUSE Labs
