Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeCQD74 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 23:59:56 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9855 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbeCQD7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 23:59:55 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Mar 2018 20:59:55 -0700
Subject: Re: [PATCH 07/14] mm/hmm: use uint64_t for HMM pfn instead of
 defining hmm_pfn_t to ulong
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
 <20180316191414.3223-8-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <e20e4e55-c99b-03c2-0bcf-4167d583dcbe@nvidia.com>
Date: Fri, 16 Mar 2018 20:59:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316191414.3223-8-jglisse@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/2018 12:14 PM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 

Hi Jerome,

This one looks great. A couple of trivial typo fixes are listed below.

You can add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

> All device driver we care about are using 64bits page table entry. In
> order to match this and to avoid useless define convert all HMM pfn to
> directly use uint64_t. It is a first step on the road to allow driver
> to directly use pfn value return by HMM (saving memory and CPU cycles
> use for convertion between the two).

  used for conversion
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/hmm.h | 46 +++++++++++++++++++++-------------------------
>  mm/hmm.c            | 26 +++++++++++++-------------
>  2 files changed, 34 insertions(+), 38 deletions(-)
> 

<snip>

> @@ -104,14 +100,14 @@ typedef unsigned long hmm_pfn_t;
>  #define HMM_PFN_SHIFT 6
>  
>  /*
> - * hmm_pfn_t_to_page() - return struct page pointed to by a valid hmm_pfn_t
> - * @pfn: hmm_pfn_t to convert to struct page
> - * Returns: struct page pointer if pfn is a valid hmm_pfn_t, NULL otherwise
> + * hmm_pfn_to_page() - return struct page pointed to by a valid HMM pfn
> + * @pfn: HMM pfn value to get corresponding struct page from
> + * Returns: struct page pointer if pfn is a valid HMM pfn, NULL otherwise
>   *
> - * If the hmm_pfn_t is valid (ie valid flag set) then return the struct page
> - * matching the pfn value stored in the hmm_pfn_t. Otherwise return NULL.
> + * If the uint64_t is valid (ie valid flag set) then return the struct page

      If the HMM pfn is valid

<snip>

>  
> @@ -634,8 +634,8 @@ EXPORT_SYMBOL(hmm_vma_range_done);
>   * This is similar to a regular CPU page fault except that it will not trigger
>   * any memory migration if the memory being faulted is not accessible by CPUs.
>   *
> - * On error, for one virtual address in the range, the function will set the
> - * hmm_pfn_t error flag for the corresponding pfn entry.
> + * On error, for one virtual address in the range, the function will mark the
> + * correspond HMM pfn entry with error flag.

      corresponding HMM pfn entry with an error flag.

thanks,
-- 
John Hubbard
NVIDIA
