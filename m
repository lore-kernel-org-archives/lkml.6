Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72235C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC43216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC43216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbeHCPOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:14:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:46336 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730601AbeHCPOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:14:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56F61AE11;
        Fri,  3 Aug 2018 13:18:28 +0000 (UTC)
Subject: Re: [PATCH v6 5/5] mm/page_alloc: Introduce
 free_area_init_core_hotplug
To:     osalvador@techadventures.net, akpm@linux-foundation.org
Cc:     mhocko@suse.com, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        david@redhat.com, Oscar Salvador <osalvador@suse.de>
References: <20180801122348.21588-1-osalvador@techadventures.net>
 <20180801122348.21588-6-osalvador@techadventures.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <3806484c-fc4d-78a4-cc9c-b877e4397670@suse.cz>
Date:   Fri, 3 Aug 2018 15:18:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801122348.21588-6-osalvador@techadventures.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 02:23 PM, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> Currently, whenever a new node is created/re-used from the memhotplug path,
> we call free_area_init_node()->free_area_init_core().
> But there is some code that we do not really need to run when we are coming
> from such path.
> 
> free_area_init_core() performs the following actions:
> 
> 1) Initializes pgdat internals, such as spinlock, waitqueues and more.
> 2) Account # nr_all_pages and # nr_kernel_pages. These values are used later on
>    when creating hash tables.
> 3) Account number of managed_pages per zone, substracting dma_reserved and memmap pages.
> 4) Initializes some fields of the zone structure data
> 5) Calls init_currently_empty_zone to initialize all the freelists
> 6) Calls memmap_init to initialize all pages belonging to certain zone
> 
> When called from memhotplug path, free_area_init_core() only performs actions #1 and #4.
> 
> Action #2 is pointless as the zones do not have any pages since either the node was freed,
> or we are re-using it, eitherway all zones belonging to this node should have 0 pages.
> For the same reason, action #3 results always in manages_pages being 0.
> 
> Action #5 and #6 are performed later on when onlining the pages:
>  online_pages()->move_pfn_range_to_zone()->init_currently_empty_zone()
>  online_pages()->move_pfn_range_to_zone()->memmap_init_zone()
> 
> This patch does two things:
> 
> First, moves the node/zone initializtion to their own function, so it allows us
> to create a small version of free_area_init_core, where we only perform:
> 
> 1) Initialization of pgdat internals, such as spinlock, waitqueues and more
> 4) Initialization of some fields of the zone structure data
> 
> These two functions are: pgdat_init_internals() and zone_init_internals().
> 
> The second thing this patch does, is to introduce free_area_init_core_hotplug(),
> the memhotplug version of free_area_init_core():
> 
> Currently, we call free_area_init_node() from the memhotplug path.
> In there, we set some pgdat's fields, and call calculate_node_totalpages().
> calculate_node_totalpages() calculates the # of pages the node has.
> 
> Since the node is either new, or we are re-using it, the zones belonging to
> this node should not have any pages, so there is no point to calculate this now.
> 
> Actually, we re-set these values to 0 later on with the calls to:
> 
> reset_node_managed_pages()
> reset_node_present_pages()
> 
> The # of pages per node and the # of pages per zone will be calculated when
> onlining the pages:
> 
> online_pages()->move_pfn_range()->move_pfn_range_to_zone()->resize_zone_range()
> online_pages()->move_pfn_range()->move_pfn_range_to_zone()->resize_pgdat_range()
> 
> Also, with this change, only pgdat_init_internals() and zone_init_internals() should
> be kept around after initialization, since they can be called from memory-hotplug
> code.
> So let us reconvert all the other functions from __meminit to __init, as we do not need
> them after initialization:
> 
> zero_resv_unavail
> set_pageblock_order
> calc_memmap_size
> free_area_init_core
> free_area_init_node
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Yep, it's safer to only do the actions relevant to hotplug during hotplug.

Acked-by: Vlastimil Babka <vbabka@suse.cz>


