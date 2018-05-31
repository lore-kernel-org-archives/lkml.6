Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754015AbeEaH0a (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:26:30 -0400
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:56451 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753846AbeEaH03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:26:29 -0400
Date: Thu, 31 May 2018 08:26:27 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, "Huang, Ying" <ying.huang@intel.com>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: fix the NULL mapping case in __isolate_lru_page()
Message-ID: <20180531072627.bdnclijtjkbpmxds@techsingularity.net>
References: <alpine.LSU.2.11.1805302014001.12558@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1805302014001.12558@eggly.anvils>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 08:23:16PM -0700, Hugh Dickins wrote:
> George Boole would have noticed a slight error in 4.16 commit 69d763fc6d3a
> ("mm: pin address_space before dereferencing it while isolating an LRU page").
> Fix it, to match both the comment above it, and the original behaviour.
> 
> Although anonymous pages are not marked PageDirty at first, we have an
> old habit of calling SetPageDirty when a page is removed from swap cache:
> so there's a category of ex-swap pages that are easily migratable, but
> were inadvertently excluded from compaction's async migration in 4.16.
> 
> Fixes: 69d763fc6d3a ("mm: pin address_space before dereferencing it while isolating an LRU page")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
