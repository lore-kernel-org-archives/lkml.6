Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933787AbeCSXJM convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:09:12 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16975 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933347AbeCSXJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:09:10 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 19 Mar 2018 16:09:05 -0700
Subject: Re: [PATCH 10/14] mm/hmm: rename HMM_PFN_DEVICE_UNADDRESSABLE to
 HMM_PFN_DEVICE_PRIVATE
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180316203552.4155-1-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <56e72cd2-9730-f031-ae75-915b94103588@nvidia.com>
Date: Mon, 19 Mar 2018 16:09:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316203552.4155-1-jglisse@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL102.nvidia.com (172.18.146.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/2018 01:35 PM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> Make naming consistent accross code, DEVICE_PRIVATE is the name use
> outside HMM code so use that one.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/hmm.h | 4 ++--
>  mm/hmm.c            | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Seems entirely harmless. :)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 6d2b6bf6da4b..78018b3e7a9f 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -88,13 +88,13 @@ struct hmm;
>   *      result of vm_insert_pfn() or vm_insert_page(). Therefore, it should not
>   *      be mirrored by a device, because the entry will never have HMM_PFN_VALID
>   *      set and the pfn value is undefined.
> - * HMM_PFN_DEVICE_UNADDRESSABLE: unaddressable device memory (ZONE_DEVICE)
> + * HMM_PFN_DEVICE_PRIVATE: unaddressable device memory (ZONE_DEVICE)
>   */
>  #define HMM_PFN_VALID (1 << 0)
>  #define HMM_PFN_WRITE (1 << 1)
>  #define HMM_PFN_ERROR (1 << 2)
>  #define HMM_PFN_SPECIAL (1 << 3)
> -#define HMM_PFN_DEVICE_UNADDRESSABLE (1 << 4)
> +#define HMM_PFN_DEVICE_PRIVATE (1 << 4)
>  #define HMM_PFN_SHIFT 5
>  
>  /*
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 2118e42cb838..857eec622c98 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -429,7 +429,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  					pfns[i] |= HMM_PFN_WRITE;
>  				} else if (write_fault)
>  					goto fault;
> -				pfns[i] |= HMM_PFN_DEVICE_UNADDRESSABLE;
> +				pfns[i] |= HMM_PFN_DEVICE_PRIVATE;
>  			} else if (is_migration_entry(entry)) {
>  				if (hmm_vma_walk->fault) {
>  					pte_unmap(ptep);
> 

thanks,
-- 
John Hubbard
NVIDIA
