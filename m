Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A06CC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7E421470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+7Cwfr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7E421470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJQEZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:25:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33692 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJQEZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:25:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id q40-v6so27465279qte.0;
        Tue, 16 Oct 2018 13:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JX4Bo2V4gq4gZ9OYbM9Z2TCrR6l12rjXU9E7NWZTsjE=;
        b=a+7Cwfr/afFEfZDg/IyCPaQtaZ0/dwHcW5jLs4Rxtit21GWNzmeFfipadh62so9/n9
         xzabnT8Hrt4Emd69PkfOF1+nV0O8/SoHY5kquu+3PsSAoOj2T2v834x+UWXNCIN4Kpwb
         46sPnNnc5gAC4i6QFpCzteDFp9o4eBbVQZnyaUYk4rjoTr+LPU3foYokPJDxCoi1W4dW
         ufz2uWqljFyCDHDZfq1rL3jkwG5rRTtLUC6Z7jHPu7x1Xg71ZHjD2nM2tBKeWA+6i//R
         tbA7ArwIYpSpPLsnrP3nQiR8S1X+zSxihrJzq46JabuE9NniTJK/A6xhrAlWomSVPEAi
         RxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JX4Bo2V4gq4gZ9OYbM9Z2TCrR6l12rjXU9E7NWZTsjE=;
        b=Zwqjt0ydCtVV3vxcEBi7JcWXgaKFX4gO62Z2ooubIG4XSEIszU0W/Y37I+KxyLtt22
         uKUwlteYruivy/W3q3q3RssQz9/x12rg/avc7yqeR8gJ45Px+P6PWHOneJPZHbZxNVp5
         P2QR2qEi9F6025/QtMjjaM2W8DWKcwZ8a4yWZ/f3uMZKv33j24z7mRgN/9MQUDAnK8Ch
         sindMfJmNSBfX6Bvj2E0khmccmRiJ35Wcko0LKH5S+zidCLHVLDHVvKXbPz6u9gjXEzY
         vYpV6X6zA5eYo0ZBDgWzdnPfaR87VkjnthS9MetEsqeGXenNDGgm50h1Zt5UKZvKT7E3
         W7vw==
X-Gm-Message-State: ABuFfohke9BKonAQTHTmaE8HhrxhNrQEdk3e37EdRbMeo5HmPOM0+uKg
        Jnmsn9XucY432zbF12x4XIo=
X-Google-Smtp-Source: ACcGV61cIxxDtOe2ztziDT5MA/R0Nl2wNKYEQyEf4WL6FAPkHwXwwQocxVZvSaQnyVXYa1XQVL0chw==
X-Received: by 2002:a0c:b510:: with SMTP id d16-v6mr22935340qve.34.1539721992601;
        Tue, 16 Oct 2018 13:33:12 -0700 (PDT)
Received: from [192.168.1.10] (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id b134-v6sm9892949qka.45.2018.10.16.13.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 13:33:11 -0700 (PDT)
Subject: Re: [mm PATCH v3 2/6] mm: Drop meminit_pfn_in_nid as it is redundant
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, davem@davemloft.net,
        yi.z.zhang@linux.intel.com, khalid.aziz@oracle.com,
        rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
References: <20181015202456.2171.88406.stgit@localhost.localdomain>
 <20181015202703.2171.40829.stgit@localhost.localdomain>
From:   Pavel Tatashin <pasha.tatashin@gmail.com>
Message-ID: <a21c1827-10ad-8ff5-c8b6-e34a3f1e8b80@gmail.com>
Date:   Tue, 16 Oct 2018 16:33:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181015202703.2171.40829.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/18 4:27 PM, Alexander Duyck wrote:
> As best as I can tell the meminit_pfn_in_nid call is completely redundant.
> The deferred memory initialization is already making use of
> for_each_free_mem_range which in turn will call into __next_mem_range which
> will only return a memory range if it matches the node ID provided assuming
> it is not NUMA_NO_NODE.
> 
> I am operating on the assumption that there are no zones or pgdata_t
> structures that have a NUMA node of NUMA_NO_NODE associated with them. If
> that is the case then __next_mem_range will never return a memory range
> that doesn't match the zone's node ID and as such the check is redundant.
> 
> So one piece I would like to verfy on this is if this works for ia64.
> Technically it was using a different approach to get the node ID, but it
> seems to have the node ID also encoded into the memblock. So I am
> assuming this is okay, but would like to get confirmation on that.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

If I am not mistaken, this code is for systems with memory interleaving.
Quick looks shows that x86, powerpc, s390, and sparc have it set.

I am not sure about other arches, but at least on SPARC, there are some
processors with memory interleaving feature:

http://www.fujitsu.com/global/products/computing/servers/unix/sparc-enterprise/technology/performance/memory.html

Pavel


> ---
>  mm/page_alloc.c |   50 ++++++++++++++------------------------------------
>  1 file changed, 14 insertions(+), 36 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4bd858d1c3ba..a766a15fad81 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1301,36 +1301,22 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
>  #endif
>  
>  #ifdef CONFIG_NODES_SPAN_OTHER_NODES
> -static inline bool __meminit __maybe_unused
> -meminit_pfn_in_nid(unsigned long pfn, int node,
> -		   struct mminit_pfnnid_cache *state)
> +/* Only safe to use early in boot when initialisation is single-threaded */
> +static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int node)
>  {
>  	int nid;
>  
> -	nid = __early_pfn_to_nid(pfn, state);
> +	nid = __early_pfn_to_nid(pfn, &early_pfnnid_cache);
>  	if (nid >= 0 && nid != node)
>  		return false;
>  	return true;
>  }
>  
> -/* Only safe to use early in boot when initialisation is single-threaded */
> -static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int node)
> -{
> -	return meminit_pfn_in_nid(pfn, node, &early_pfnnid_cache);
> -}
> -
>  #else
> -
>  static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int node)
>  {
>  	return true;
>  }
> -static inline bool __meminit  __maybe_unused
> -meminit_pfn_in_nid(unsigned long pfn, int node,
> -		   struct mminit_pfnnid_cache *state)
> -{
> -	return true;
> -}
>  #endif
>  
>  
> @@ -1459,21 +1445,13 @@ static inline void __init pgdat_init_report_one_done(void)
>   *
>   * Then, we check if a current large page is valid by only checking the validity
>   * of the head pfn.
> - *
> - * Finally, meminit_pfn_in_nid is checked on systems where pfns can interleave
> - * within a node: a pfn is between start and end of a node, but does not belong
> - * to this memory node.
>   */
> -static inline bool __init
> -deferred_pfn_valid(int nid, unsigned long pfn,
> -		   struct mminit_pfnnid_cache *nid_init_state)
> +static inline bool __init deferred_pfn_valid(unsigned long pfn)
>  {
>  	if (!pfn_valid_within(pfn))
>  		return false;
>  	if (!(pfn & (pageblock_nr_pages - 1)) && !pfn_valid(pfn))
>  		return false;
> -	if (!meminit_pfn_in_nid(pfn, nid, nid_init_state))
> -		return false;
>  	return true;
>  }
>  
> @@ -1481,15 +1459,14 @@ static inline void __init pgdat_init_report_one_done(void)
>   * Free pages to buddy allocator. Try to free aligned pages in
>   * pageblock_nr_pages sizes.
>   */
> -static void __init deferred_free_pages(int nid, int zid, unsigned long pfn,
> +static void __init deferred_free_pages(unsigned long pfn,
>  				       unsigned long end_pfn)
>  {
> -	struct mminit_pfnnid_cache nid_init_state = { };
>  	unsigned long nr_pgmask = pageblock_nr_pages - 1;
>  	unsigned long nr_free = 0;
>  
>  	for (; pfn < end_pfn; pfn++) {
> -		if (!deferred_pfn_valid(nid, pfn, &nid_init_state)) {
> +		if (!deferred_pfn_valid(pfn)) {
>  			deferred_free_range(pfn - nr_free, nr_free);
>  			nr_free = 0;
>  		} else if (!(pfn & nr_pgmask)) {
> @@ -1509,17 +1486,18 @@ static void __init deferred_free_pages(int nid, int zid, unsigned long pfn,
>   * by performing it only once every pageblock_nr_pages.
>   * Return number of pages initialized.
>   */
> -static unsigned long  __init deferred_init_pages(int nid, int zid,
> +static unsigned long  __init deferred_init_pages(struct zone *zone,
>  						 unsigned long pfn,
>  						 unsigned long end_pfn)
>  {
> -	struct mminit_pfnnid_cache nid_init_state = { };
>  	unsigned long nr_pgmask = pageblock_nr_pages - 1;
> +	int nid = zone_to_nid(zone);
>  	unsigned long nr_pages = 0;
> +	int zid = zone_idx(zone);
>  	struct page *page = NULL;
>  
>  	for (; pfn < end_pfn; pfn++) {
> -		if (!deferred_pfn_valid(nid, pfn, &nid_init_state)) {
> +		if (!deferred_pfn_valid(pfn)) {
>  			page = NULL;
>  			continue;
>  		} else if (!page || !(pfn & nr_pgmask)) {
> @@ -1582,12 +1560,12 @@ static int __init deferred_init_memmap(void *data)
>  	for_each_free_mem_range(i, nid, MEMBLOCK_NONE, &spa, &epa, NULL) {
>  		spfn = max_t(unsigned long, first_init_pfn, PFN_UP(spa));
>  		epfn = min_t(unsigned long, zone_end_pfn(zone), PFN_DOWN(epa));
> -		nr_pages += deferred_init_pages(nid, zid, spfn, epfn);
> +		nr_pages += deferred_init_pages(zone, spfn, epfn);
>  	}
>  	for_each_free_mem_range(i, nid, MEMBLOCK_NONE, &spa, &epa, NULL) {
>  		spfn = max_t(unsigned long, first_init_pfn, PFN_UP(spa));
>  		epfn = min_t(unsigned long, zone_end_pfn(zone), PFN_DOWN(epa));
> -		deferred_free_pages(nid, zid, spfn, epfn);
> +		deferred_free_pages(spfn, epfn);
>  	}
>  	pgdat_resize_unlock(pgdat, &flags);
>  
> @@ -1676,7 +1654,7 @@ static int __init deferred_init_memmap(void *data)
>  		while (spfn < epfn && nr_pages < nr_pages_needed) {
>  			t = ALIGN(spfn + PAGES_PER_SECTION, PAGES_PER_SECTION);
>  			first_deferred_pfn = min(t, epfn);
> -			nr_pages += deferred_init_pages(nid, zid, spfn,
> +			nr_pages += deferred_init_pages(zone, spfn,
>  							first_deferred_pfn);
>  			spfn = first_deferred_pfn;
>  		}
> @@ -1688,7 +1666,7 @@ static int __init deferred_init_memmap(void *data)
>  	for_each_free_mem_range(i, nid, MEMBLOCK_NONE, &spa, &epa, NULL) {
>  		spfn = max_t(unsigned long, first_init_pfn, PFN_UP(spa));
>  		epfn = min_t(unsigned long, first_deferred_pfn, PFN_DOWN(epa));
> -		deferred_free_pages(nid, zid, spfn, epfn);
> +		deferred_free_pages(spfn, epfn);
>  
>  		if (first_deferred_pfn == epfn)
>  			break;
> 
