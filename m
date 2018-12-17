Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295CEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF86206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732790AbeLQM1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:27:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:60866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbeLQM1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:27:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9FE8ACA4;
        Mon, 17 Dec 2018 12:27:21 +0000 (UTC)
Subject: Re: [PATCH 01/14] mm, compaction: Shrink compact_control
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20181214230310.572-1-mgorman@techsingularity.net>
 <20181214230310.572-2-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <f1bb7787-3626-1212-5d6d-a6c6aec81fa4@suse.cz>
Date:   Mon, 17 Dec 2018 13:27:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181214230310.572-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/18 12:02 AM, Mel Gorman wrote:
> The isolate and migrate scanners should never isolate more than a pageblock
> of pages so unsigned int is sufficient saving 8 bytes on a 64-bit build.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/internal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 536bc2a839b9..5564841fce36 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -185,8 +185,8 @@ struct compact_control {
>  	struct list_head freepages;	/* List of free pages to migrate to */
>  	struct list_head migratepages;	/* List of pages being migrated */
>  	struct zone *zone;
> -	unsigned long nr_freepages;	/* Number of isolated free pages */
> -	unsigned long nr_migratepages;	/* Number of pages to migrate */
> +	unsigned int nr_freepages;	/* Number of isolated free pages */
> +	unsigned int nr_migratepages;	/* Number of pages to migrate */
>  	unsigned long total_migrate_scanned;
>  	unsigned long total_free_scanned;
>  	unsigned long free_pfn;		/* isolate_freepages search base */
> 

