Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158F6C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29EF217B7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29EF217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbeHGOGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:06:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:41340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727048AbeHGOGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:06:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93440AF57;
        Tue,  7 Aug 2018 11:52:10 +0000 (UTC)
Subject: Re: [PATCH v2] resource: Merge resources on a node when hot-adding
 memory
To:     Rashmica Gupta <rashmica.g@gmail.com>, toshi.kani@hpe.com,
        tglx@linutronix.de, akpm@linux-foundation.org, bp@suse.de,
        brijesh.singh@amd.com, thomas.lendacky@amd.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
        dan.j.williams@intel.com, mhocko@suse.com, iamjoonsoo.kim@lge.com,
        malat@debian.org, pasha.tatashin@oracle.com, bhelgaas@google.com,
        osalvador@techadventures.net, yasu.isimatu@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20180806065224.31383-1-rashmica.g@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <5543a32a-20f9-18ff-dc13-73737257ed99@suse.cz>
Date:   Tue, 7 Aug 2018 13:52:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806065224.31383-1-rashmica.g@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 08:52 AM, Rashmica Gupta wrote:
> When hot-removing memory release_mem_region_adjustable() splits
> iomem resources if they are not the exact size of the memory being
> hot-deleted. Adding this memory back to the kernel adds a new
> resource.
> 
> Eg a node has memory 0x0 - 0xfffffffff. Offlining and hot-removing
> 1GB from 0xf40000000 results in the single resource 0x0-0xfffffffff being
> split into two resources: 0x0-0xf3fffffff and 0xf80000000-0xfffffffff.
> 
> When we hot-add the memory back we now have three resources:
> 0x0-0xf3fffffff, 0xf40000000-0xf7fffffff, and 0xf80000000-0xfffffffff.
> 
> Now if we try to remove a section of memory that overlaps these resources,
> like 2GB from 0xf40000000, release_mem_region_adjustable() fails as it
> expects the chunk of memory to be within the boundaries of a single
> resource.

Hi,

it's the first time I see the resource code, so I might be easily wrong.
How can it happen that the second remove is section aligned but the
first one not?

> This patch adds a function request_resource_and_merge(). This is called
> instead of request_resource_conflict() when registering a resource in
> add_memory(). It calls request_resource_conflict() and if hot-removing is
> enabled (if it isn't we won't get resource fragmentation) we attempt to
> merge contiguous resources on the node.
> 
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
...
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
...
> +/*
> + * Attempt to merge resources on the node
> + */
> +static void merge_node_resources(int nid, struct resource *parent)
> +{
> +	struct resource *res;
> +	uint64_t start_addr;
> +	uint64_t end_addr;
> +	int ret;
> +
> +	start_addr = node_start_pfn(nid) << PAGE_SHIFT;
> +	end_addr = node_end_pfn(nid) << PAGE_SHIFT;
> +
> +	write_lock(&resource_lock);
> +
> +	/* Get the first resource */
> +	res = parent->child;
> +
> +	while (res) {
> +		/* Check that the resource is within the node */
> +		if (res->start < start_addr) {
> +			res = res->sibling;
> +			continue;
> +		}
> +		/* Exit if resource is past end of node */
> +		if (res->sibling->end > end_addr)
> +			break;

IIUC, resource end is closed, so adjacent resources's start is end+1.
But node_end_pfn is open, so the comparison above should use '>='
instead of '>'?

> +
> +		ret = merge_resources(res);
> +		if (!ret)
> +			continue;
> +		res = res->sibling;

Should this rather use next_resource() to merge at all levels of the
hierarchy? Although memory seems to be flat under &iomem_resource so it
would be just future-proofing.

Thanks,
Vlastimil
