Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeDLAzA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 20:55:00 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44714 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeDLAy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 20:54:58 -0400
X-Google-Smtp-Source: AIpwx496WIkNm/a+zRrAhJKze3FWuRsQNM3zelgHkhMOVAzX1oJhUv7wvEg2EBry3D7bpGnwI4PmtQ==
Date: Thu, 12 Apr 2018 09:54:51 +0900
From: Minchan Kim <minchan@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20180412005451.GB253442@rodete-desktop-imager.corp.google.com>
References: <20180411060320.14458-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411060320.14458-1-willy@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew,

Please Cced relevant people so they know what's going on the problem
they spent on much time. Everyone doesn't keep an eye on mailing list.

On Tue, Apr 10, 2018 at 11:03:18PM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> v1->v2:
>  - Added review/ack tags (thanks!)
>  - Switched the order of the patches
>  - Reworded commit message of the patch which actually fixes the bug
>  - Moved slab debug patches under CONFIG_DEBUG_VM to check _every_
>    allocation and added checks in the slowpath for the allocations which
>    end up allocating a page.
> 
> Matthew Wilcox (2):
>   Fix NULL pointer in page_cache_tree_insert
>   slab: __GFP_ZERO is incompatible with a constructor
> 
>  mm/filemap.c | 9 ++++-----
>  mm/slab.c    | 7 ++++---
>  mm/slab.h    | 7 +++++++
>  mm/slob.c    | 4 +++-
>  mm/slub.c    | 5 +++--
>  5 files changed, 21 insertions(+), 11 deletions(-)
> 
> -- 
> 2.16.3
> 
