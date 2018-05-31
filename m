Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753836AbeEaFDJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 01:03:09 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43682 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeEaFDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 01:03:08 -0400
X-Google-Smtp-Source: ADUXVKIdU3I4xybiF/Wi5jk0cV0473gWmXj/CyviAmSfh6hpyToFdQQ0P7YIhMbl2LhlB5yjQzV3bQ==
Date: Thu, 31 May 2018 14:03:02 +0900
From: Minchan Kim <minchan@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Huang, Ying" <ying.huang@intel.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: fix the NULL mapping case in __isolate_lru_page()
Message-ID: <20180531050302.GA24220@rodete-desktop-imager.corp.google.com>
References: <alpine.LSU.2.11.1805302014001.12558@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1805302014001.12558@eggly.anvils>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks, Hugh.
