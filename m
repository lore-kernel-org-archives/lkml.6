Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753258AbeDLTYb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 15:24:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752833AbeDLTYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 15:24:30 -0400
Date: Thu, 12 Apr 2018 12:24:24 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Minchan Kim <minchan@kernel.org>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Chris Fries <cfries@google.com>, jaegeuk@kernel.org
Subject: Re: [PATCH v2 0/2] Fix __GFP_ZERO vs constructor
Message-ID: <20180412192424.GB21205@bombadil.infradead.org>
References: <20180411060320.14458-1-willy@infradead.org>
 <20180412005451.GB253442@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412005451.GB253442@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 09:54:51AM +0900, Minchan Kim wrote:
> Matthew,
> 
> Please Cced relevant people so they know what's going on the problem
> they spent on much time. Everyone doesn't keep an eye on mailing list.

My apologies; I assumed that git send-email would pick up the people
named in the changelog.  I have now read the source code and discovered
it only picks up the people listed in Signed-off-by: and Cc:.  That
surprises me; I'll submit a patch.

> On Tue, Apr 10, 2018 at 11:03:18PM -0700, Matthew Wilcox wrote:
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> > 
> > v1->v2:
> >  - Added review/ack tags (thanks!)
> >  - Switched the order of the patches
> >  - Reworded commit message of the patch which actually fixes the bug
> >  - Moved slab debug patches under CONFIG_DEBUG_VM to check _every_
> >    allocation and added checks in the slowpath for the allocations which
> >    end up allocating a page.
> > 
> > Matthew Wilcox (2):
> >   Fix NULL pointer in page_cache_tree_insert
> >   slab: __GFP_ZERO is incompatible with a constructor
> > 
> >  mm/filemap.c | 9 ++++-----
> >  mm/slab.c    | 7 ++++---
> >  mm/slab.h    | 7 +++++++
> >  mm/slob.c    | 4 +++-
> >  mm/slub.c    | 5 +++--
> >  5 files changed, 21 insertions(+), 11 deletions(-)
> > 
> > -- 
> > 2.16.3
> > 
> 
