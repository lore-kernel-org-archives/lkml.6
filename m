Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073F5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77522084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNW6nGOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77522084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbeLKBuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:50:16 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35451 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbeLKBuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:50:15 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so11197330edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 17:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3etDTCL7dY/hUhbivGijbCT1dtjfPqCovMeZEbFZ3pQ=;
        b=CNW6nGOebJT6o+PuNaIoLai9OuZzcPdquCdF1SjGmC5/luTcIs+fC84mM1pIACAeRM
         kKYetM7i4RzCkwrb5goc1MZWRWaEE5rnvJjSxNJCxvRMzr2WXbRdB1opWaSUCNVXLLc5
         Xb/gzRveFFa912SnJuD4hnZdlKTL8+lasy4Md8pe1P9qWNdE6HAxr5l9ha3FxBdtx0KQ
         mA3ACjZU/QNNPfGgg8Us36JBfFzSnA+DH8xiz6c9B3Lp+5nohNKtrlDNBfKFjKtEBApi
         Dvg3FwqkkDLlZg0hEAFAWsyCFpO5YLir0omYzK0V/UjsDxBrWF5Agt0Twr+yeTG63EpW
         St7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3etDTCL7dY/hUhbivGijbCT1dtjfPqCovMeZEbFZ3pQ=;
        b=VE+9sLAzNiT9rBtqeNgN7glb7H/NcRggt/QZZe6OJKsTfaxS39Yvw3TV7myXQgS+4T
         s/UsD+TuJ0bYpkayV5UPghJFvZlwXvLMS0JsfixJhtIZ8wsH6lPjxUfgx5WReFnfzl0t
         T9/iBIB0XdhV7sh+OJIj2BHHq1UfR3wCfwxWN04YGEDRkVU0KUj+JxW2Nlox4r77VDa5
         yBzXIAitVRLbdRFETGTMl6aMIrVuXB7XFMyZjEM/9OXo4kfUuVRjTfyUqr4tecl4L1Ag
         ArjBKpSZ70145FeSaYVLoBZRcJZ8q2Cr/PLsJ31/Zd1PiGY/10r7jZcDIcNFYPmGKUxC
         EkFw==
X-Gm-Message-State: AA+aEWaEDs2paBmSMAl4pJ+Y6YN4MkF/E6S5uyVF6XZMmn5JHelPDMXm
        yPJiSdpiOWAYnd4fTk5o8w9cLXUR
X-Google-Smtp-Source: AFSGD/V8jyxfBdY2BLNxEsPLJuD+XgKIkg43KPicutU8gCb5TNOj8DIHszg1vO0pLhprBGT8sr6X9w==
X-Received: by 2002:a17:906:5d10:: with SMTP id g16-v6mr11012898ejt.212.1544493013155;
        Mon, 10 Dec 2018 17:50:13 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a27sm3846747eda.65.2018.12.10.17.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 17:50:12 -0800 (PST)
Date:   Tue, 11 Dec 2018 01:50:11 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Zaslonko Mikhail <zaslonko@linux.bm.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org,
        Pavel.Tatashin@microsoft.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, gerald.schaefer@de.ibm.com
Subject: Re: [PATCH 1/1] mm, memory_hotplug: Initialize struct pages for the
 full memory section
Message-ID: <20181211015011.bcbugtm2v6j3ncpc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181210130712.30148-1-zaslonko@linux.ibm.com>
 <20181210130712.30148-2-zaslonko@linux.ibm.com>
 <20181210151005.xukiibwbb6ohqyex@master>
 <e515a37e-7510-12f3-d029-99ac147d93c6@linux.bm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e515a37e-7510-12f3-d029-99ac147d93c6@linux.bm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 05:14:36PM +0100, Zaslonko Mikhail wrote:
>Hello,
>
>On 10.12.2018 16:10, Wei Yang wrote:
>> On Mon, Dec 10, 2018 at 02:07:12PM +0100, Mikhail Zaslonko wrote:
>>> If memory end is not aligned with the sparse memory section boundary, the
>>> mapping of such a section is only partly initialized. This may lead to
>>> VM_BUG_ON due to uninitialized struct page access from
>>> is_mem_section_removable() or test_pages_in_a_zone() function triggered by
>>> memory_hotplug sysfs handlers:
>>>
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
>>> Fix the problem by initializing the last memory section of the highest zone
>>> in memmap_init_zone() till the very end, even if it goes beyond the zone
>>> end.
>>>
>>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>>> Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>> mm/page_alloc.c | 15 +++++++++++++++
>>> 1 file changed, 15 insertions(+)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 2ec9cc407216..41ef5508e5f1 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -5542,6 +5542,21 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>>> 			cond_resched();
>>> 		}
>>> 	}
>>> +#ifdef CONFIG_SPARSEMEM
>>> +	/*
>>> +	 * If there is no zone spanning the rest of the section
>>> +	 * then we should at least initialize those pages. Otherwise we
>>> +	 * could blow up on a poisoned page in some paths which depend
>>> +	 * on full sections being initialized (e.g. memory hotplug).
>>> +	 */
>>> +	if (end_pfn == max_pfn) {
>>> +		while (end_pfn % PAGES_PER_SECTION) {
>>> +			__init_single_page(pfn_to_page(end_pfn), end_pfn, zone,
>>> +					   nid);
>>> +			end_pfn++;
>>> +		}
>>> +	}
>>> +#endif
>> 
>> If my understanding is correct, end_pfn is not a valid range.
>> 
>> memmap_init_zone() initialize the range [start_pfn, start_pfn + size). I
>> am afraid this will break the syntax. 
>> 
>> And max_pfn is also not a valid one. For example, on x86,
>I used pfn_max here to check for the highest zone. What would be a better way? 
>
>> update_end_of_memory_vars() will update max_pfn, which is calculated by:
>> 
>>     end_pfn = PFN_UP(start + size);
>> 
>> BTW, as you mentioned this apply to hotplug case. And then why this couldn't
>> happen during boot up? What differ these two cases?
>
>Well, the pages left uninitialized during bootup (initial problem), but the panic itself takes 
>place when we try to process memory_hotplug sysfs attributes (thus triggering sysfs handlers). 
>You can find more details in the original thread:
>https://marc.info/?t=153658306400001&r=1&w=2
>

Thanks.

I took a look into the original thread and try to reproduce this on x86.

My step is:

  1. config page_poisoning
  2. use kernel parameter mem=3075M
  3. cat the last memory block device sysfs file removable
     eg. when mem is 3075, cat memory9/removable

I don't see the Call trace. Do I miss something to reproduce it?

>> 
>>> }
>>>
>>> #ifdef CONFIG_ZONE_DEVICE
>>> -- 
>>> 2.16.4
>> 
>
>Thanks,
>Mikhail Zaslonko

-- 
Wei Yang
Help you, Help me
