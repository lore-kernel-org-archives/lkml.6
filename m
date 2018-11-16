Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDFFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DBC208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DBC208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389620AbeKPWIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:08:49 -0500
Received: from foss.arm.com ([217.140.101.70]:50294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbeKPWIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:08:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C17D080D;
        Fri, 16 Nov 2018 03:56:45 -0800 (PST)
Received: from [10.163.1.125] (unknown [10.163.1.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6B203F718;
        Fri, 16 Nov 2018 03:56:43 -0800 (PST)
Subject: Re: [PATCH 3/5] mm, memory_hotplug: drop pointless block alignment
 checks from __offline_pages
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <OSalvador@suse.com>, Baoquan He <bhe@redhat.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20181116083020.20260-1-mhocko@kernel.org>
 <20181116083020.20260-4-mhocko@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <50a2cbeb-9d1b-d629-6390-c0b3d26f2d72@arm.com>
Date:   Fri, 16 Nov 2018 17:26:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181116083020.20260-4-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2018 02:00 PM, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> This function is never called from a context which would provide
> misaligned pfn range so drop the pointless check.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/memory_hotplug.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2b2b3ccbbfb5..a92b1b8f6218 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1554,12 +1554,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  	struct zone *zone;
>  	struct memory_notify arg;
>  
> -	/* at least, alignment against pageblock is necessary */
> -	if (!IS_ALIGNED(start_pfn, pageblock_nr_pages))
> -		return -EINVAL;
> -	if (!IS_ALIGNED(end_pfn, pageblock_nr_pages))
> -		return -EINVAL;
> -
>  	mem_hotplug_begin();
>  
>  	/* This makes hotplug much easier...and readable.
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
