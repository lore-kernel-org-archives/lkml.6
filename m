Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF47C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9B420831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9B420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbeKUA4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:56:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbeKUA4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:56:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4A583084258;
        Tue, 20 Nov 2018 14:26:45 +0000 (UTC)
Received: from [10.36.117.138] (ovpn-117-138.ams2.redhat.com [10.36.117.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FEA52719A;
        Tue, 20 Nov 2018 14:26:44 +0000 (UTC)
Subject: Re: [RFC PATCH 2/3] mm, memory_hotplug: deobfuscate migration part of
 offlining
To:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20181120134323.13007-1-mhocko@kernel.org>
 <20181120134323.13007-3-mhocko@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <f25bfa30-96cf-799c-6885-86a3a537a977@redhat.com>
Date:   Tue, 20 Nov 2018 15:26:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120134323.13007-3-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 20 Nov 2018 14:26:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.18 14:43, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Memory migration might fail during offlining and we keep retrying in
> that case. This is currently obfuscate by goto retry loop. The code
> is hard to follow and as a result it is even suboptimal becase each
> retry round scans the full range from start_pfn even though we have
> successfully scanned/migrated [start_pfn, pfn] range already. This
> is all only because check_pages_isolated failure has to rescan the full
> range again.
> 
> De-obfuscate the migration retry loop by promoting it to a real for
> loop. In fact remove the goto altogether by making it a proper double
> loop (yeah, gotos are nasty in this specific case). In the end we
> will get a slightly more optimal code which is better readable.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/memory_hotplug.c | 60 +++++++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 6263c8cd4491..9cd161db3061 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1591,38 +1591,40 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  		goto failed_removal_isolated;
>  	}
>  
> -	pfn = start_pfn;
> -repeat:
> -	/* start memory hot removal */
> -	ret = -EINTR;
> -	if (signal_pending(current)) {
> -		reason = "signal backoff";
> -		goto failed_removal_isolated;
> -	}
> +	do {
> +		for (pfn = start_pfn; pfn;)
> +		{

{ on a new line looks weird.

> +			/* start memory hot removal */
> +			ret = -EINTR;

I think we can move that into the "if (signal_pending(current))"

(if my eyes are not wrong, this will not be touched otherwise)

> +			if (signal_pending(current)) {
> +				reason = "signal backoff";
> +				goto failed_removal_isolated;
> +			}
>  
> -	cond_resched();
> -	lru_add_drain_all();
> -	drain_all_pages(zone);
> +			cond_resched();
> +			lru_add_drain_all();
> +			drain_all_pages(zone);
>  
> -	pfn = scan_movable_pages(start_pfn, end_pfn);
> -	if (pfn) { /* We have movable pages */
> -		ret = do_migrate_range(pfn, end_pfn);
> -		goto repeat;
> -	}
> +			pfn = scan_movable_pages(pfn, end_pfn);
> +			if (pfn) {
> +				/* TODO fatal migration failures should bail out */
> +				do_migrate_range(pfn, end_pfn);

Right, that return value was always ignored.

> +			}
> +		}
> +
> +		/*
> +		 * dissolve free hugepages in the memory block before doing offlining
> +		 * actually in order to make hugetlbfs's object counting consistent.
> +		 */
> +		ret = dissolve_free_huge_pages(start_pfn, end_pfn);
> +		if (ret) {
> +			reason = "failure to dissolve huge pages";
> +			goto failed_removal_isolated;
> +		}
> +		/* check again */
> +		offlined_pages = check_pages_isolated(start_pfn, end_pfn);
> +	} while (offlined_pages < 0);
>  
> -	/*
> -	 * dissolve free hugepages in the memory block before doing offlining
> -	 * actually in order to make hugetlbfs's object counting consistent.
> -	 */
> -	ret = dissolve_free_huge_pages(start_pfn, end_pfn);
> -	if (ret) {
> -		reason = "failure to dissolve huge pages";
> -		goto failed_removal_isolated;
> -	}
> -	/* check again */
> -	offlined_pages = check_pages_isolated(start_pfn, end_pfn);
> -	if (offlined_pages < 0)
> -		goto repeat;
>  	pr_info("Offlined Pages %ld\n", offlined_pages);
>  	/* Ok, all of our target is isolated.
>  	   We cannot do rollback at this point. */
> 

Looks much better to me.


-- 

Thanks,

David / dhildenb
