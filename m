Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7C0C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409A02087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifO42s1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409A02087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeLMPMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:12:14 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42427 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:12:13 -0500
Received: by mail-ed1-f68.google.com with SMTP id j6so2290830edp.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l69N32jmQG2zGN93tkn7NJvUX29xf66d+hF+/Qin/d8=;
        b=ifO42s1SwvAZ39OUs/6duMDQkzexKmBgUl5UhVqJp2Yc2D3UP3PYijgXyqcG99hvit
         fvXkHTGUDjIn4r0eN3rcceZ16SPTRIBTI/brsTy2ehb1LcR/MGu7VFeQiZ87O9cnsJ5D
         UfPR35tGu9g9hJFekDgLHf0FuMKKCtkhzDxGjDJsOMSLQN/hjAhlTtTA4b0AoWCiaCdB
         CSwSdXr421dgP0Nzo2MSm7vDqnLZLm2Mne4lvq2lohnNPCQHnRopH1eaH5Z2+E5BdGXa
         jcroCtTTvwmRWzlpKmgIZX8XW5fe66NSVAICqsGw1pKPD7Y9uscofQAQBsltWwFcnx9D
         kRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l69N32jmQG2zGN93tkn7NJvUX29xf66d+hF+/Qin/d8=;
        b=laWpocd6/boj5BRVQOuIHONw09sxdAgnillmni/g3suTs6vp3kn1XgQDwmicJRQlbu
         PqOZ+iwpmjyGYCJcDfi5YZ3eXpuvt3C1OiE5vifzYkI7hXNmAY3PdSHlTYeNzAoUQoL3
         nvGzsjBL15iLw5VJ4u5f+s2lkVOaHTgH9FoPXg5Y4bifaMxyBySGwdmWjFeFngecWUPG
         QNQreV0Tho5A2kXQQxW3Vkif4sdqcQTZMou+6jWj9VqNQhHuHjJN9f3Q4ZoD/QfCrp7z
         8pL6hOebs7Q2B64frPmcW6Cg1s3jFp8+Az2meCa+KamMhcfbn6QGheT7+8TT4deNH7Aw
         mhcw==
X-Gm-Message-State: AA+aEWbK2L8lGOllzllkPmVD4JGxtDsnfvr+bePZOeTAO3o4nn6Drm3t
        gh4i+/696NjR3KJFy9WZ/PA=
X-Google-Smtp-Source: AFSGD/USy8N9p1bdi6RLTHnkkBby299W73REWFxbklgRRQ8QR+PsvFHhncCH1bjRbtHOc6iTWYnu8g==
X-Received: by 2002:a50:9f64:: with SMTP id b91mr22462900edf.235.1544713931234;
        Thu, 13 Dec 2018 07:12:11 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v14sm630587edq.74.2018.12.13.07.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 07:12:10 -0800 (PST)
Date:   Thu, 13 Dec 2018 15:12:09 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Zaslonko Mikhail <zaslonko@linux.bm.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org,
        Pavel.Tatashin@microsoft.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, gerald.schaefer@de.ibm.com
Subject: Re: [PATCH v2 1/1] mm, memory_hotplug: Initialize struct pages for
 the full memory section
Message-ID: <20181213151209.hmrhrr5gvb256bzm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181212172712.34019-1-zaslonko@linux.ibm.com>
 <20181212172712.34019-2-zaslonko@linux.ibm.com>
 <20181213034615.4ntpo4cl2oo5mcx4@master>
 <e4cebbae-3fcb-f03c-3d0e-a1a44ff0675a@linux.bm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4cebbae-3fcb-f03c-3d0e-a1a44ff0675a@linux.bm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 01:37:16PM +0100, Zaslonko Mikhail wrote:
>On 13.12.2018 04:46, Wei Yang wrote:
>> On Wed, Dec 12, 2018 at 06:27:12PM +0100, Mikhail Zaslonko wrote:
>>> If memory end is not aligned with the sparse memory section boundary, the
>>> mapping of such a section is only partly initialized. This may lead to
>>> VM_BUG_ON due to uninitialized struct page access from
>>> is_mem_section_removable() or test_pages_in_a_zone() function triggered by
>>> memory_hotplug sysfs handlers:
>>>
>>> Here are the the panic examples:
>>> CONFIG_DEBUG_VM=y
>>> CONFIG_DEBUG_VM_PGFLAGS=y
>>>
>>> kernel parameter mem=2050M
>>> --------------------------
>>> page:000003d082008000 is uninitialized and poisoned
>>> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>>> Call Trace:
>>> ([<0000000000385b26>] test_pages_in_a_zone+0xde/0x160)
>>>  [<00000000008f15c4>] show_valid_zones+0x5c/0x190
>>>  [<00000000008cf9c4>] dev_attr_show+0x34/0x70
>>>  [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
>>>  [<00000000003e4194>] seq_read+0x204/0x480
>>>  [<00000000003b53ea>] __vfs_read+0x32/0x178
>>>  [<00000000003b55b2>] vfs_read+0x82/0x138
>>>  [<00000000003b5be2>] ksys_read+0x5a/0xb0
>>>  [<0000000000b86ba0>] system_call+0xdc/0x2d8
>>> Last Breaking-Event-Address:
>>>  [<0000000000385b26>] test_pages_in_a_zone+0xde/0x160
>>> Kernel panic - not syncing: Fatal exception: panic_on_oops
>>>
>>> kernel parameter mem=3075M
>>> --------------------------
>>> page:000003d08300c000 is uninitialized and poisoned
>>> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>>> Call Trace:
>>> ([<000000000038596c>] is_mem_section_removable+0xb4/0x190)
>>>  [<00000000008f12fa>] show_mem_removable+0x9a/0xd8
>>>  [<00000000008cf9c4>] dev_attr_show+0x34/0x70
>>>  [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
>>>  [<00000000003e4194>] seq_read+0x204/0x480
>>>  [<00000000003b53ea>] __vfs_read+0x32/0x178
>>>  [<00000000003b55b2>] vfs_read+0x82/0x138
>>>  [<00000000003b5be2>] ksys_read+0x5a/0xb0
>>>  [<0000000000b86ba0>] system_call+0xdc/0x2d8
>>> Last Breaking-Event-Address:
>>>  [<000000000038596c>] is_mem_section_removable+0xb4/0x190
>>> Kernel panic - not syncing: Fatal exception: panic_on_oops
>>>
>>> Fix the problem by initializing the last memory section of each zone
>>> in memmap_init_zone() till the very end, even if it goes beyond the zone
>>> end.
>>>
>>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>>> Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>> mm/page_alloc.c | 12 ++++++++++++
>>> 1 file changed, 12 insertions(+)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 2ec9cc407216..e2afdb2dc2c5 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -5542,6 +5542,18 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>>> 			cond_resched();
>>> 		}
>>> 	}
>>> +#ifdef CONFIG_SPARSEMEM
>>> +	/*
>>> +	 * If the zone does not span the rest of the section then
>>> +	 * we should at least initialize those pages. Otherwise we
>>> +	 * could blow up on a poisoned page in some paths which depend
>>> +	 * on full sections being initialized (e.g. memory hotplug).
>>> +	 */
>>> +	while (end_pfn % PAGES_PER_SECTION) {
>>> +		__init_single_page(pfn_to_page(end_pfn), end_pfn, zone, nid);
>>> +		end_pfn++;
>>> +	}
>>> +#endif
>>> }
>> 
>> What will happen if the end_pfn is PAGES_PER_SECTION aligned, but there
>> is invalid pfn? For example, the page is skipped in the for loop of
>> memmap_init_zone()?
>> 
>
>If the end_pfn is PAGES_PER_SECTION aligned, we do not do any extra 
>initialization.
>If the page is skipped in the loop, it will remain uninitialized for 
>the reason (e.g. a memory hole). The behavior has not been changed here.
>

I may not describe my question clearly.

If the page is skipped, then it is uninitialized. Then would this page
trigger the call trace when read the removable sysfs?

>>>
>>> #ifdef CONFIG_ZONE_DEVICE
>>> -- 
>>> 2.16.4
>> 

-- 
Wei Yang
Help you, Help me
