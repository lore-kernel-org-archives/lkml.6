Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeDQVSY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:18:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45318 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeDQVSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:18:22 -0400
Subject: Re: [PATCH -mm 10/21] mm, THP, swap: Support to count THP swapin and
 its fallback
To: "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Tim Chen <tim.c.chen@intel.com>, Andi Kleen <ak@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Shaohua Li <shli@kernel.org>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
References: <20180417020230.26412-1-ying.huang@intel.com>
 <20180417020230.26412-11-ying.huang@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2d6c126d-eada-1791-4a31-fd0d806e3147@infradead.org>
Date: Tue, 17 Apr 2018 14:18:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417020230.26412-11-ying.huang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/18 19:02, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> 2 new /proc/vmstat fields are added, "thp_swapin" and
> "thp_swapin_fallback" to count swapin a THP from swap device as a
> whole and fallback to normal page swapin.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shaohua Li <shli@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Zi Yan <zi.yan@cs.rutgers.edu>
> ---
>  include/linux/vm_event_item.h |  2 ++
>  mm/huge_memory.c              |  4 +++-
>  mm/page_io.c                  | 15 ++++++++++++---
>  mm/vmstat.c                   |  2 ++
>  4 files changed, 19 insertions(+), 4 deletions(-)
> 

Hi,
Please also update Documentation/vm/transhuge.rst.

Thanks.

-- 
~Randy
