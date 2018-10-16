Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4F5C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10552098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBO6w1/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10552098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeJQE7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:59:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33883 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQE7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:59:05 -0400
Received: by mail-qk1-f194.google.com with SMTP id p6-v6so15150726qkg.1;
        Tue, 16 Oct 2018 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aI/Kg4X8Nj1i2a2fyNQii/DKiJ0iopA4cJy+6JFDwVM=;
        b=OBO6w1/OeJTwv8yIKchKYhURS+rEc5IpG43AscvPYcGA4X870iFLyWe1LUOS1NzXTL
         arGSaaAsYEOfYm3A3zCUOsaa42z5lK5yEuvnIRaECSLWl205qzN0GsDu8sVzyns5L3Uo
         6GRYGsYqoOa2aKuTpavdEFSzDBsOg5JXAWlCOdhUqOsyluwta0s9YcSf1N6NqXNtdcZJ
         B28ueZp78dHM1fSxVbyj7FaPIEQjFta7PXimGzoQB6sSBi2TM3ksSS5chG1jSvjoIgTa
         hQIICO4nRzeOewNpJxITVWvX5HaUHD5nQ+GZHBd2B0jRlb7gfASEYwxgqufRuk8K9Hw3
         yRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aI/Kg4X8Nj1i2a2fyNQii/DKiJ0iopA4cJy+6JFDwVM=;
        b=shyakuHVX6gETMqHQ9JGvWbjl0Mv2Umdx2lOQnxGpf/C0BJIVVlSEQl69T6YGwwA5+
         VT20OjUP3nkOgAP6y13VaCo/lF+4uW13SefgQWVzfDSwvKcpOy0bRE17BAghUngpzkJ4
         z9ZMoiGt5htPE0dikg3Ls05NVtZLzaOZZM9adz4cL9MxF73yx+PYl8nURk3aR9aEJBBw
         bZIRaU4XHFWzxwQh6B0DmqtQNCulACrL98/In3Z63zLahJRksT86TWfFr8gVtRVywjJ1
         us1bEDqhYVl364KLh2Hqndcy5zONcjg+eCD9yrqIfkyGw1PM+SGWQNvkQUom5nC0xTa2
         hg2g==
X-Gm-Message-State: ABuFfohbBIulLfUVNiNCLU4ayPfTaVtmoH2zyfXJksmArPgBXP+CG+Fy
        4DkAPZasXZnavSTWvVdE3Sg=
X-Google-Smtp-Source: ACcGV62Xgc6wiegCRkF8K0vC9g/UCyrHoqj++yqCUYojl+wlVkgzie8ct6O9j86yoEmuhM41SHJGMA==
X-Received: by 2002:a37:5c81:: with SMTP id q123-v6mr22897586qkb.156.1539724009985;
        Tue, 16 Oct 2018 14:06:49 -0700 (PDT)
Received: from [192.168.1.10] (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id v10-v6sm9208266qkv.90.2018.10.16.14.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 14:06:49 -0700 (PDT)
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
 <a21c1827-10ad-8ff5-c8b6-e34a3f1e8b80@gmail.com>
 <e4f806d4-2527-07c2-56bc-9c41789d669c@linux.intel.com>
From:   Pavel Tatashin <pasha.tatashin@gmail.com>
Message-ID: <06e4428b-860e-1e66-defd-77666fcfa0c5@gmail.com>
Date:   Tue, 16 Oct 2018 17:06:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e4f806d4-2527-07c2-56bc-9c41789d669c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/18 4:49 PM, Alexander Duyck wrote:
> On 10/16/2018 1:33 PM, Pavel Tatashin wrote:
>>
>>
>> On 10/15/18 4:27 PM, Alexander Duyck wrote:
>>> As best as I can tell the meminit_pfn_in_nid call is completely
>>> redundant.
>>> The deferred memory initialization is already making use of
>>> for_each_free_mem_range which in turn will call into __next_mem_range
>>> which
>>> will only return a memory range if it matches the node ID provided
>>> assuming
>>> it is not NUMA_NO_NODE.
>>>
>>> I am operating on the assumption that there are no zones or pgdata_t
>>> structures that have a NUMA node of NUMA_NO_NODE associated with
>>> them. If
>>> that is the case then __next_mem_range will never return a memory range
>>> that doesn't match the zone's node ID and as such the check is
>>> redundant.
>>>
>>> So one piece I would like to verfy on this is if this works for ia64.
>>> Technically it was using a different approach to get the node ID, but it
>>> seems to have the node ID also encoded into the memblock. So I am
>>> assuming this is okay, but would like to get confirmation on that.
>>>
>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>
>> If I am not mistaken, this code is for systems with memory interleaving.
>> Quick looks shows that x86, powerpc, s390, and sparc have it set.
>>
>> I am not sure about other arches, but at least on SPARC, there are some
>> processors with memory interleaving feature:
>>
>> http://www.fujitsu.com/global/products/computing/servers/unix/sparc-enterprise/technology/performance/memory.html
>>
>>
>> Pavel
> 
> I get what it is for. However as best I can tell the check is actually
> redundant. In the case of the deferred page initialization we are
> already pulling the memory regions via "for_each_free_mem_range". That
> function is already passed a NUMA node ID. Because of that we are
> already checking the memory range to determine if it is in the node or
> not. As such it doesn't really make sense to go through for each PFN and
> then go back to the memory range and see if the node matches or not.
> 

Agree, it looks redundant, nice clean-up, I like it.

Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>

Thank you,
Pavel


> You can take a look at __next_mem_range which is called by
> for_each_free_mem_range and passed &memblock.memory and
> &memblock.reserved to avoid:
> https://elixir.bootlin.com/linux/latest/source/mm/memblock.c#L899
> 
> Then you can work your way through:
> meminit_pfn_in_nid(pfn, node, state)
>  __early_pfn_to_nid(pfn, state)
>   memblock_search_pfn_nid(pfn, &start_pfn, &end_pfn)
>    memblock_search(&memblock.memory, pfn)
> 
> From what I can tell the deferred init is going back through the
> memblock.memory list we pulled this range from and just validating it
> against itself. This makes sense for the standard init as that is just
> going from start_pfn->end_pfn, but for the deferred init we are pulling
> the memory ranges ahead of time so we shouldn't need to re-validate the
> memory that is contained within that range.
