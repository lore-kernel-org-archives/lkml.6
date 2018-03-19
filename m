Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934086AbeCSXMN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:12:13 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12313 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933619AbeCSXMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:12:12 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 19 Mar 2018 16:12:11 -0700
Subject: Re: [PATCH 11/14] mm/hmm: move hmm_pfns_clear() closer to where it is
 use
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180316203552.4155-1-jglisse@redhat.com>
 <20180316203552.4155-2-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <80d6ed4e-3e7a-ef22-c931-79491eeedbe7@nvidia.com>
Date: Mon, 19 Mar 2018 16:12:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316203552.4155-2-jglisse@redhat.com>
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
> Move hmm_pfns_clear() closer to where it is use to make it clear it
> is not use by page table walkers.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/hmm.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 857eec622c98..3a708f500b80 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -297,14 +297,6 @@ static int hmm_pfns_bad(unsigned long addr,
>  	return 0;
>  }
>  
> -static void hmm_pfns_clear(uint64_t *pfns,
> -			   unsigned long addr,
> -			   unsigned long end)
> -{
> -	for (; addr < end; addr += PAGE_SIZE, pfns++)
> -		*pfns = 0;
> -}
> -
>  /*
>   * hmm_vma_walk_hole() - handle a range back by no pmd or no pte
>   * @start: range virtual start address (inclusive)
> @@ -463,6 +455,14 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  	return 0;
>  }
>  
> +static void hmm_pfns_clear(uint64_t *pfns,
> +			   unsigned long addr,
> +			   unsigned long end)
> +{
> +	for (; addr < end; addr += PAGE_SIZE, pfns++)
> +		*pfns = 0;
> +}
> +

Yep, identical, so no functional changes.

>  static void hmm_pfns_special(struct hmm_range *range)
>  {
>  	unsigned long addr = range->start, i = 0;

thanks,
-- 
John Hubbard
NVIDIA
