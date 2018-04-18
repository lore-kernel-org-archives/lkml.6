Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeDRAjV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 20:39:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:45722 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753139AbeDRAjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 20:39:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="44118626"
From: "Huang\, Ying" <ying.huang@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@intel.com>, Andi Kleen <ak@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Shaohua Li <shli@kernel.org>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -mm 10/21] mm, THP, swap: Support to count THP swapin and its fallback
References: <20180417020230.26412-1-ying.huang@intel.com>
        <20180417020230.26412-11-ying.huang@intel.com>
        <2d6c126d-eada-1791-4a31-fd0d806e3147@infradead.org>
Date: Wed, 18 Apr 2018 08:39:15 +0800
In-Reply-To: <2d6c126d-eada-1791-4a31-fd0d806e3147@infradead.org> (Randy
        Dunlap's message of "Tue, 17 Apr 2018 14:18:08 -0700")
Message-ID: <87po2xz6to.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 04/16/18 19:02, Huang, Ying wrote:
>> From: Huang Ying <ying.huang@intel.com>
>> 
>> 2 new /proc/vmstat fields are added, "thp_swapin" and
>> "thp_swapin_fallback" to count swapin a THP from swap device as a
>> whole and fallback to normal page swapin.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Shaohua Li <shli@kernel.org>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Rik van Riel <riel@redhat.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>> Cc: Zi Yan <zi.yan@cs.rutgers.edu>
>> ---
>>  include/linux/vm_event_item.h |  2 ++
>>  mm/huge_memory.c              |  4 +++-
>>  mm/page_io.c                  | 15 ++++++++++++---
>>  mm/vmstat.c                   |  2 ++
>>  4 files changed, 19 insertions(+), 4 deletions(-)
>> 
>
> Hi,
> Please also update Documentation/vm/transhuge.rst.

Thanks for reminding!  Will do that.

Best Regards,
Huang, Ying
