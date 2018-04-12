Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeDLGTD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 02:19:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:49878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750743AbeDLGTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 02:19:02 -0400
Date: Thu, 12 Apr 2018 08:18:59 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: linux-mm@kvack.org, Zi Yan <zi.yan@sent.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] mm: migrate: vm event counter for hugepage
 migration
Message-ID: <20180412061859.GR23400@dhcp22.suse.cz>
References: <1523434167-19995-1-git-send-email-n-horiguchi@ah.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523434167-19995-1-git-send-email-n-horiguchi@ah.jp.nec.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-04-18 17:09:25, Naoya Horiguchi wrote:
> Hi everyone,
> 
> I wrote patches introducing separate vm event counters for hugepage migration
> (both for hugetlb and thp.)
> Hugepage migration is different from normal page migration in event frequency
> and/or how likely it succeeds, so maintaining statistics for them in mixed
> counters might not be helpful both for develors and users.

This is quite a lot of code to be added se we should better document
what it is intended for. Sure I understand your reasonaning about huge
pages are more likely to fail but is this really worth a separate
counter? Do you have an example of how this would be useful?

If we are there then what about different huge page sizes (for hugetlb)?
Do we need per-hstate stats?

In other words, is this really worth it?

>  include/linux/vm_event_item.h |   7 +++
>  mm/migrate.c                  | 103 +++++++++++++++++++++++++++++++++++-------
>  mm/vmstat.c                   |   8 ++++
>  3 files changed, 102 insertions(+), 16 deletions(-)

-- 
Michal Hocko
SUSE Labs
