Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeB0X3u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:29:50 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44837 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeB0X3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:29:49 -0500
X-Google-Smtp-Source: AG47ELs+iM9iZC5aFRDAYZLNK+na/wivxh7+0AJRojyM7tEnlD5dXm6/xuA8o1rnQfoeenFyaCZR1Q==
Date: Wed, 28 Feb 2018 08:29:43 +0900
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>, "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] mm:swap: do not check readahead flag with THP anon
Message-ID: <20180227232943.GC168047@rodete-desktop-imager.corp.google.com>
References: <20180227232611.169883-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227232611.169883-1-minchan@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 08:26:11AM +0900, Minchan Kim wrote:
> Huang reported PG_readahead flag marked PF_NO_COMPOUND so that
> we cannot use the flag for THP page. So, we need to check first
> whether page is THP or not before using TestClearPageReadahead
> in lookup_swap_cache.
> 
> This patch fixes it.
> 
> Furthermore, swap_[cluster|vma]_readahead cannot mark PG_readahead
> for newly allocated page because the allocated page is always a
> normal page, not THP at this moment. So let's clean it up, too.
> 
> Cc: Hugh Dickins <hughd@google.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

 Link:http://lkml.kernel.org/r/874lm83zho.fsf@yhuang-dev.intel.com
