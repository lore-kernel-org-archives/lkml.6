Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3961DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39A3216FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39A3216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeI1GnP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 02:43:15 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:53321 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeI1GnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 02:43:15 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w8S0M8kE027119
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 28 Sep 2018 09:22:08 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w8S0M87b002523;
        Fri, 28 Sep 2018 09:22:08 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w8S0M8ea007255;
        Fri, 28 Sep 2018 09:22:08 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-4045469; Fri, 28 Sep 2018 09:19:46 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Fri,
 28 Sep 2018 09:19:45 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 3/3] mm: return zero_resv_unavail optimization
Thread-Topic: [PATCH v2 3/3] mm: return zero_resv_unavail optimization
Thread-Index: AQHUVOV2twFtLyKByUeUtjALly2L9aUEQT4A
Date:   Fri, 28 Sep 2018 00:19:44 +0000
Message-ID: <20180928001944.GA9242@hori1.linux.bs1.fc.nec.co.jp>
References: <20180925153532.6206-1-msys.mizuma@gmail.com>
 <20180925153532.6206-4-msys.mizuma@gmail.com>
In-Reply-To: <20180925153532.6206-4-msys.mizuma@gmail.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <3A91CF9D70C2E0439334BF262801CB9F@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:35:32AM -0400, Masayoshi Mizuma wrote:
> From: Pavel Tatashin <pavel.tatashin@microsoft.com>
> 
> When checking for valid pfns in zero_resv_unavail(), it is not necessary to
> verify that pfns within pageblock_nr_pages ranges are valid, only the first
> one needs to be checked. This is because memory for pages are allocated in
> contiguous chunks that contain pageblock_nr_pages struct pages.
> 
> Signed-off-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Reviewed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

According to convention, review tag is formatted like "Reviewed-by: ...",
Otherwise, looks good to me.

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

> ---
>  mm/page_alloc.c | 46 ++++++++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3b9d89e..bd5b7e4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6440,6 +6440,29 @@ void __init free_area_init_node(int nid, unsigned long *zones_size,
>  }
>  
>  #if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_FLAT_NODE_MEM_MAP)
> +
> +/*
> + * Zero all valid struct pages in range [spfn, epfn), return number of struct
> + * pages zeroed
> + */
> +static u64 zero_pfn_range(unsigned long spfn, unsigned long epfn)
> +{
> +	unsigned long pfn;
> +	u64 pgcnt = 0;
> +
> +	for (pfn = spfn; pfn < epfn; pfn++) {
> +		if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
> +			pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
> +				+ pageblock_nr_pages - 1;
> +			continue;
> +		}
> +		mm_zero_struct_page(pfn_to_page(pfn));
> +		pgcnt++;
> +	}
> +
> +	return pgcnt;
> +}
> +
>  /*
>   * Only struct pages that are backed by physical memory are zeroed and
>   * initialized by going through __init_single_page(). But, there are some
> @@ -6455,7 +6478,6 @@ void __init free_area_init_node(int nid, unsigned long *zones_size,
>  void __init zero_resv_unavail(void)
>  {
>  	phys_addr_t start, end;
> -	unsigned long pfn;
>  	u64 i, pgcnt;
>  	phys_addr_t next = 0;
>  
> @@ -6465,34 +6487,18 @@ void __init zero_resv_unavail(void)
>  	pgcnt = 0;
>  	for_each_mem_range(i, &memblock.memory, NULL,
>  			NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL) {
> -		if (next < start) {
> -			for (pfn = PFN_DOWN(next); pfn < PFN_UP(start); pfn++) {
> -				if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
> -					continue;
> -				mm_zero_struct_page(pfn_to_page(pfn));
> -				pgcnt++;
> -			}
> -		}
> +		if (next < start)
> +			pgcnt += zero_pfn_range(PFN_DOWN(next), PFN_UP(start));
>  		next = end;
>  	}
> -	for (pfn = PFN_DOWN(next); pfn < max_pfn; pfn++) {
> -		if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
> -			continue;
> -		mm_zero_struct_page(pfn_to_page(pfn));
> -		pgcnt++;
> -	}
> -
> +	pgcnt += zero_pfn_range(PFN_DOWN(next), max_pfn);
>  
>  	/*
>  	 * Struct pages that do not have backing memory. This could be because
>  	 * firmware is using some of this memory, or for some other reasons.
> -	 * Once memblock is changed so such behaviour is not allowed: i.e.
> -	 * list of "reserved" memory must be a subset of list of "memory", then
> -	 * this code can be removed.
>  	 */
>  	if (pgcnt)
>  		pr_info("Zeroed struct page in unavailable ranges: %lld pages", pgcnt);
> -
>  }
>  #endif /* CONFIG_HAVE_MEMBLOCK && !CONFIG_FLAT_NODE_MEM_MAP */
>  
> -- 
> 2.18.0
> 
> 
