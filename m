Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE45C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A2120840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dLHDzXj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A2120840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeKJKpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:45:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45962 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbeKJKpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 05:45:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id d135so4889496qkc.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 17:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=di34gN84YeSBOZ4YfLsLtDspFBk81kHvLwL/FB85pR4=;
        b=dLHDzXj69culbINat3TL30kYZhkRdBC1Ej0UNxeNUJK3oznxFT39A/K/CJyLC/JZVZ
         9misdGQv76dOGQFiusJs8czWwV/ubRLs6E45L3xqnIlwsrI/r+f8/TkMUmIxWsa8LB9I
         j1i//wXgM5Rxag7gHGN4tYHZf1PQ/Nb0AVg0bUwRm5JojML0feRKuWzJHzuIyC1QSTD1
         wh5ZhcfvSwxuXYg2TNzl7mJVAFP2g9FDRFB596erEU3vZ64Q3xp6qJ1nWhqVvvGFQkBB
         QzCuyCQ5vBmA0CxqPub3OLzHQCdf0UNQG84NyFv+ssQaPQ2S/AbwxVpwWTRlFYR1aYV4
         f9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=di34gN84YeSBOZ4YfLsLtDspFBk81kHvLwL/FB85pR4=;
        b=J5TZyPlYtNGFZA6XzcVmf18iTIvYNhNuHAsu7Hr1fR2KfdQVmV2Dmf0idUQud+vv6c
         zW5DKV0mCQ9XnCFkfPC5HC512HTWMTm/WmGBqTqG+wE4SGP+aWvmjAD837xTFrswB36l
         Ed8uY1JbhheEY8Sx7aCvJObHhUkk7CPln0HSjrur+LG/YzJPMQqGgMYE64AlexazwnNK
         OkvvZb3zf4cP7ZyMI88w3DpEO2ChcqBGQj/6a79KUgRDF1TiuMGSL7c52PqRQdsAif8F
         ognAOV8Mv3pJHRcIqMBc/7vscOBlbN10nl5QbpIySqywGew1RgZP7bPV8t8x9OxT5Om4
         MbYQ==
X-Gm-Message-State: AGRZ1gImeqMHqiZK+Xn15po1TOhyViMzbM7ieO0nTn61L22ca9Twfjzq
        Rb6GYt16HHKpOp6BfmDeOd7y2g==
X-Google-Smtp-Source: AJdET5cZSSKqMDq9RNc2AAwOt4SCAljVAySfQFo9plAtTIYsp76wjPXpDTpIg0S4TyITsXYOZZ05Wg==
X-Received: by 2002:a0c:e105:: with SMTP id w5mr11014756qvk.234.1541811760487;
        Fri, 09 Nov 2018 17:02:40 -0800 (PST)
Received: from xakep.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id p31sm6596743qkh.86.2018.11.09.17.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 17:02:39 -0800 (PST)
Date:   Fri, 9 Nov 2018 20:02:38 -0500
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mhocko@suse.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v5 4/7] mm: Initialize MAX_ORDER_NR_PAGES at a time
 instead of doing larger sections
Message-ID: <20181110010238.jnabddtfpr5kjhdz@xakep.localdomain>
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
 <154145278583.30046.4918131143612801028.stgit@ahduyck-desk1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154145278583.30046.4918131143612801028.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-05 13:19:45, Alexander Duyck wrote:
>  	}
> -	first_init_pfn = max(zone->zone_start_pfn, first_init_pfn);
> +
> +	/* If the zone is empty somebody else may have cleared out the zone */
> +	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
> +						 first_init_pfn)) {
> +		pgdat_resize_unlock(pgdat, &flags);
> +		pgdat_init_report_one_done();
> +		return 0;

It would make more sense to add goto to the end of this function and report
that in Node X had 0 pages initialized. Otherwise, it will be confusing
why some nodes are not initialized during boot. It is simply because
they do not have deferred pages left to be initialized.


> +	}
>  
>  	/*
> -	 * Initialize and free pages. We do it in two loops: first we initialize
> -	 * struct page, than free to buddy allocator, because while we are
> -	 * freeing pages we can access pages that are ahead (computing buddy
> -	 * page in __free_one_page()).
> +	 * Initialize and free pages in MAX_ORDER sized increments so
> +	 * that we can avoid introducing any issues with the buddy
> +	 * allocator.
>  	 */
> -	for_each_free_mem_pfn_range_in_zone(i, zone, &spfn, &epfn) {
> -		spfn = max_t(unsigned long, first_init_pfn, spfn);
> -		nr_pages += deferred_init_pages(zone, spfn, epfn);
> -	}
> -	for_each_free_mem_pfn_range_in_zone(i, zone, &spfn, &epfn) {
> -		spfn = max_t(unsigned long, first_init_pfn, spfn);
> -		deferred_free_pages(spfn, epfn);
> -	}
> +	while (spfn < epfn)
> +		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> +
>  	pgdat_resize_unlock(pgdat, &flags);
>  
>  	/* Sanity check that the next zone really is unpopulated */
> @@ -1602,9 +1689,9 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
>  {

How about order = max(order, max_order)?

>  	unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);


> -	first_init_pfn = max(zone->zone_start_pfn, first_deferred_pfn);
> -
> -	if (first_init_pfn >= pgdat_end_pfn(pgdat)) {
> +	/* If the zone is empty somebody else may have cleared out the zone */
> +	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
> +						 first_deferred_pfn)) {
>  		pgdat_resize_unlock(pgdat, &flags);
> -		return false;
> +		return true;

I am OK to change to true here, please also set
pgdat->first_deferred_pfn to ULONG_MAX to indicate that there are no
more deferred pages in this node.


Overall, I like this patch, makes things a lot easier, assuming the
above is addressed:

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha
