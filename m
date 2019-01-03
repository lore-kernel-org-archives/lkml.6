Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9AAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C878220815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LisEPkzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbfACQig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:38:36 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45704 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfACQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:38:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id y78so19961475qka.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 08:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A4aQNIK++2OFjzVt2CQOMYWozqdUG8deKPHsV2CVouU=;
        b=LisEPkzPle9cP9gPNnD8SiFxWD5vORfaZZ9dYAj2ITTrPCjgwLcWzxSnyLNkFSWTag
         6ND4FuaHHQGNj87ZNjf5900I2aPsRE2L64AoOXI3METUFxzSn+ymy6HwO5fy8VWq16rd
         H4IBjdyGBHlG4i7/nZsNytNYFPK/KVjmuQIeSowErcEMbxkAk+EutBeN7N47luMvD1xY
         SmrqojVg1la4KymSJpTAVcRzH/e1xF2/ZxEWDJWjCnF6noenWeJve5ILEL6WJpbj4YxK
         G+mcQ5H5wf72CUvDFYilNI5wskSrWvo2JSapg/w7+2Oy5F5GDE0+7Y6DIKswAx6GQmjd
         +vtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A4aQNIK++2OFjzVt2CQOMYWozqdUG8deKPHsV2CVouU=;
        b=ZHj2hzFzSTjHQQxwQ8m3cmeZVg//L7WQFIrpUsiJ5XrcXAalr9kg7ePyqk7njFZK7b
         W7TekENl6GNbh80zJHNAfC6GuAsg2F4pNY1GSnPZOuYGLpFlsKs/iE8L7QI9vf3WKREN
         uCuiCYl8D/2bFB2TEehtE0jPHTUWJ6NFwd/WyTH9L9YQA5DXowTH2B+sR205P8Jcj85d
         Izok/zVu7jtzBNc/j0tNGZheh3T1U5ATDMCe87iq2RHyUJelH3zEThuYso2x/RQfS05r
         kVsnGzgVO/+caAc8NQYyqSUyg7CAVDOxxqW0lkgQVm/n5xWT0TAnxj9dW2pPvDeGjMke
         Ll/g==
X-Gm-Message-State: AJcUukcaCEZBlusvolUADlm7dbJjpDN9FwU/3ggzWSq0wlgztcTxNp2d
        zv+don02oNxIKfSAQkei2uC1K2hCzAniNg==
X-Google-Smtp-Source: ALg8bN54XBdvFb+IKxUGdmh0GL7y5FDHvl25/kff9Myi4hjBpsqcZpfwQ30W5dyAFFXCclhXkXYTMg==
X-Received: by 2002:a37:2cc2:: with SMTP id s185mr43606878qkh.74.1546533513568;
        Thu, 03 Jan 2019 08:38:33 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g23sm30605821qta.24.2019.01.03.08.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 08:38:33 -0800 (PST)
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, hpa@zytor.com, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, yang.shi@linaro.org, tglx@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20181220185031.43146-1-cai@lca.pw>
 <20181220203156.43441-1-cai@lca.pw> <20190103115114.GL31793@dhcp22.suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <e3ff1455-06cc-063e-24f0-3b525c345b84@lca.pw>
Date:   Thu, 3 Jan 2019 11:38:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190103115114.GL31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/19 6:51 AM, Michal Hocko wrote:
> On Thu 20-12-18 15:31:56, Qian Cai wrote:
>> When booting a system with "page_owner=on",
>>
>> start_kernel
>>   page_ext_init
>>     invoke_init_callbacks
>>       init_section_page_ext
>>         init_page_owner
>>           init_early_allocated_pages
>>             init_zones_in_node
>>               init_pages_in_zone
>>                 lookup_page_ext
>>                   page_to_nid
>>
>> The issue here is that page_to_nid() will not work since some page
>> flags have no node information until later in page_alloc_init_late() due
>> to DEFERRED_STRUCT_PAGE_INIT. Hence, it could trigger an out-of-bounds
>> access with an invalid nid.
>>
>> [    8.666047] UBSAN: Undefined behaviour in ./include/linux/mm.h:1104:50
>> [    8.672603] index 7 is out of range for type 'zone [5]'
>>
>> Also, kernel will panic since flags were poisoned earlier with,
>>
>> CONFIG_DEBUG_VM_PGFLAGS=y
>> CONFIG_NODE_NOT_IN_PAGE_FLAGS=n
>>
>> start_kernel
>>   setup_arch
>>     pagetable_init
>>       paging_init
>>         sparse_init
>>           sparse_init_nid
>>             memblock_alloc_try_nid_raw
>>
>> Although later it tries to set page flags for pages in reserved bootmem
>> regions,
>>
>> mm_init
>>   mem_init
>>     memblock_free_all
>>       free_low_memory_core_early
>>         reserve_bootmem_region
>>
>> there could still have some freed pages from the page allocator but yet
>> to be initialized due to DEFERRED_STRUCT_PAGE_INIT. It have already been
>> dealt with a bit in page_ext_init().
>>
>> * Take into account DEFERRED_STRUCT_PAGE_INIT.
>> */
>> if (early_pfn_to_nid(pfn) != nid)
>> 	continue;
>>
>> However, it did not handle it well in init_pages_in_zone() which end up
>> calling page_to_nid().
>>
>> [   11.917212] page:ffffea0004200000 is uninitialized and poisoned
>> [   11.917220] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
>> ffffffffffffffff
>> [   11.921745] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
>> ffffffffffffffff
>> [   11.924523] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>> [   11.926498] page_owner info is not active (free page?)
>> [   12.329560] kernel BUG at include/linux/mm.h:990!
>> [   12.337632] RIP: 0010:init_page_owner+0x486/0x520
>>
>> Since there is no other routines depend on page_ext_init() in
>> start_kernel(), just move it after page_alloc_init_late() to ensure that
>> there is no deferred pages need to de dealt with. If deselected
>> DEFERRED_STRUCT_PAGE_INIT, it is still better to call page_ext_init()
>> earlier, so page owner could catch more early page allocation call
>> sites. This gives us a good compromise between catching good and bad
>> call sites (See the v1 patch [1]) in case of DEFERRED_STRUCT_PAGE_INIT.
>>
>> [1] https://lore.kernel.org/lkml/20181220060303.38686-1-cai@lca.pw/
>>
>> Fixes: fe53ca54270 (mm: use early_pfn_to_nid in page_ext_init)
>> Suggested-by: Michal Hocko <mhocko@kernel.org>
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>>
>> v3: still call page_ext_init() earlier if DEFERRED_STRUCT_PAGE_INIT=n.
>>
>> v2: postpone page_ext_init() to after page_alloc_init_late().
>>
>>  init/main.c   | 5 +++++
>>  mm/page_ext.c | 3 +--
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/init/main.c b/init/main.c
>> index 2b7b7fe173c9..5d9904370f76 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -696,7 +696,9 @@ asmlinkage __visible void __init start_kernel(void)
>>  		initrd_start = 0;
>>  	}
>>  #endif
>> +#ifndef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>>  	page_ext_init();
>> +#endif
>>  	kmemleak_init();
>>  	setup_per_cpu_pageset();
>>  	numa_policy_init();
>> @@ -1147,6 +1149,9 @@ static noinline void __init kernel_init_freeable(void)
>>  	sched_init_smp();
>>  
>>  	page_alloc_init_late();
>> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>> +	page_ext_init();
>> +#endif
>>  
>>  	do_basic_setup();
> 
> Is this really necessary? Why cannot we simply postpone page_ext_init
> unconditioanally?

As mentioned above, "If deselected DEFERRED_STRUCT_PAGE_INIT, it is still better
to call page_ext_init() earlier, so page owner could catch more early page
allocation call sites."

> 
>>  
>> diff --git a/mm/page_ext.c b/mm/page_ext.c
>> index ae44f7adbe07..d76fd51e312a 100644
>> --- a/mm/page_ext.c
>> +++ b/mm/page_ext.c
>> @@ -399,9 +399,8 @@ void __init page_ext_init(void)
>>  			 * -------------pfn-------------->
>>  			 * N0 | N1 | N2 | N0 | N1 | N2|....
>>  			 *
>> -			 * Take into account DEFERRED_STRUCT_PAGE_INIT.
>>  			 */
>> -			if (early_pfn_to_nid(pfn) != nid)
>> +			if (pfn_to_nid(pfn) != nid)
>>  				continue;
>>  			if (init_section_page_ext(pfn, nid))
>>  				goto oom;
> 
> Also this doesn't seem to be related, right?

No, it is related. Because of this patch, page_ext_init() is called after all
the memory has already been initialized,
so no longer necessary to call early_pfn_to_nid().
