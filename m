Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754856AbeDCH7b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:59:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:54931 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752307AbeDCH7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:59:30 -0400
Date: Tue, 3 Apr 2018 09:59:28 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: consider non-anonymous thp as unmovable page
Message-ID: <20180403075928.GC5501@dhcp22.suse.cz>
References: <1522730788-24530-1-git-send-email-n-horiguchi@ah.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522730788-24530-1-git-send-email-n-horiguchi@ah.jp.nec.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-04-18 13:46:28, Naoya Horiguchi wrote:
> My testing for the latest kernel supporting thp migration found out an
> infinite loop in offlining the memory block that is filled with shmem
> thps.  We can get out of the loop with a signal, but kernel should
> return with failure in this case.
> 
> What happens in the loop is that scan_movable_pages() repeats returning
> the same pfn without any progress. That's because page migration always
> fails for shmem thps.

Why does it fail? Shmem pages should be movable without any issues.

-- 
Michal Hocko
SUSE Labs
