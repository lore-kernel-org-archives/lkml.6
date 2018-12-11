Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134D2C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C133A2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLr4TtPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C133A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeLKWO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:14:26 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41631 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbeLKWOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:14:24 -0500
Received: by mail-ed1-f65.google.com with SMTP id z28so13886844edi.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sYUfcCAqO3n3tcQ8AkrT2nVlKtFaQmU45N+XFlUFYS8=;
        b=FLr4TtPAJTRXbECH0Zbq7no+gzCR94GuE/B2L/11HHd0KvyJ6agTAvXkMFxtQ/SB+M
         LvJYFY6ezFIG8FtmTgptu/Q3Capu1SOQlR2oQ7YF8VoPanbWFjckICQEwTlqMrP01W9Q
         Q2+4dDg3rjxjjCYN7tYwjSmWsgIwIItMYd7rPkpmaLyYqkEMhNBKclr+38fF5jAPyTT6
         pmy7k7PPhglrYiydhG7hoDSToK4eqzcUi1Dmqt0sMOlTqyGXAeU6Ot2UWGyD5YGTLXEy
         axKhjmHifIxtdrHB+0JfOCPA9u4avSmMCPrSUu+AWZdxWykXRMcYJ+TZuM20UoklLUu8
         XJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sYUfcCAqO3n3tcQ8AkrT2nVlKtFaQmU45N+XFlUFYS8=;
        b=fvLZycKqoixBtCQRad2i17lJxk8CG2siypRoRSpqtu6VgnD1ccSMULhcMBPZq83FVo
         wkSwee9Ehg8J14L+HM/0XGI2PsHw9FdZQf46lkV95b0Xvo/9DtnGWeo7YyUFDlAVsnZT
         6uqaSYIp0UqHFO35zAySfC6AllLZLDBRSo5jDjZ5T0QwfKaPYb/JiEw1plUhDPsO8uUN
         HaWud4STwtN0OCzP8mihoE8zfsDeSWkctljrrmSRyFRb+ipt1UXqcIeUcxQoj5s5L2Jn
         1IwxFpyX/3V4EmE8KJW+hiETEoNsj3s7NW9TZm/x3dDBYH8TQF0iPWXNdrepZlwn/Oc6
         H0wA==
X-Gm-Message-State: AA+aEWY03wrKO+AWafJMgknFf5mesrh6G+jBRmkBib6A3SKENGnfyf2W
        MpYg1o9n5rpastDXygXlZiY=
X-Google-Smtp-Source: AFSGD/VOYuY8nF7YNVC1fnENwIhcuCUT9hWO2AZVFs2ryRzuZECMywu8D4gkC7P7NNE+PboAsfg6GA==
X-Received: by 2002:a50:d643:: with SMTP id c3mr15865561edj.178.1544566461204;
        Tue, 11 Dec 2018 14:14:21 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id r8sm4213736edo.11.2018.12.11.14.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:14:20 -0800 (PST)
Date:   Tue, 11 Dec 2018 22:14:19 +0000
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
Message-ID: <20181211221419.wr7p72u235dosb5u@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181210130712.30148-1-zaslonko@linux.ibm.com>
 <20181210130712.30148-2-zaslonko@linux.ibm.com>
 <20181210151005.xukiibwbb6ohqyex@master>
 <e515a37e-7510-12f3-d029-99ac147d93c6@linux.bm.com>
 <20181211015011.bcbugtm2v6j3ncpc@master>
 <3dbbb746-d4b4-ea17-643a-5d63d4f7e239@linux.bm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dbbb746-d4b4-ea17-643a-5d63d4f7e239@linux.bm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 04:23:05PM +0100, Zaslonko Mikhail wrote:
>Hello,
>
>On 11.12.2018 02:50, Wei Yang wrote:
>> On Mon, Dec 10, 2018 at 05:14:36PM +0100, Zaslonko Mikhail wrote:
>>> Hello,
>>>
>>> On 10.12.2018 16:10, Wei Yang wrote:
>>>> On Mon, Dec 10, 2018 at 02:07:12PM +0100, Mikhail Zaslonko wrote:
>>>>> If memory end is not aligned with the sparse memory section boundary, the
>>>>> mapping of such a section is only partly initialized. This may lead to
>>>>> VM_BUG_ON due to uninitialized struct page access from
>>>>> is_mem_section_removable() or test_pages_in_a_zone() function triggered by
>>>>> memory_hotplug sysfs handlers:
>>>>>
>>>>> page:000003d082008000 is uninitialized and poisoned
>>>>> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>>>>> Call Trace:
>>>>> ([<0000000000385b26>] test_pages_in_a_zone+0xde/0x160)
>>>>>  [<00000000008f15c4>] show_valid_zones+0x5c/0x190
>>>>>  [<00000000008cf9c4>] dev_attr_show+0x34/0x70
>>>>>  [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
>>>>>  [<00000000003e4194>] seq_read+0x204/0x480
>>>>>  [<00000000003b53ea>] __vfs_read+0x32/0x178
>>>>>  [<00000000003b55b2>] vfs_read+0x82/0x138
>>>>>  [<00000000003b5be2>] ksys_read+0x5a/0xb0
>>>>>  [<0000000000b86ba0>] system_call+0xdc/0x2d8
>>>>> Last Breaking-Event-Address:
>>>>>  [<0000000000385b26>] test_pages_in_a_zone+0xde/0x160
>>>>> Kernel panic - not syncing: Fatal exception: panic_on_oops
>>>>>
>>>>> Fix the problem by initializing the last memory section of the highest zone
>>>>> in memmap_init_zone() till the very end, even if it goes beyond the zone
>>>>> end.
>>>>>
>>>>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>>>>> Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
>>>>> Cc: <stable@vger.kernel.org>
>>>>> ---
>>>>> mm/page_alloc.c | 15 +++++++++++++++
>>>>> 1 file changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index 2ec9cc407216..41ef5508e5f1 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -5542,6 +5542,21 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>>>>> 			cond_resched();
>>>>> 		}
>>>>> 	}
>>>>> +#ifdef CONFIG_SPARSEMEM
>>>>> +	/*
>>>>> +	 * If there is no zone spanning the rest of the section
>>>>> +	 * then we should at least initialize those pages. Otherwise we
>>>>> +	 * could blow up on a poisoned page in some paths which depend
>>>>> +	 * on full sections being initialized (e.g. memory hotplug).
>>>>> +	 */
>>>>> +	if (end_pfn == max_pfn) {
>>>>> +		while (end_pfn % PAGES_PER_SECTION) {
>>>>> +			__init_single_page(pfn_to_page(end_pfn), end_pfn, zone,
>>>>> +					   nid);
>>>>> +			end_pfn++;
>>>>> +		}
>>>>> +	}
>>>>> +#endif
>>>>
>>>> If my understanding is correct, end_pfn is not a valid range.
>>>>
>>>> memmap_init_zone() initialize the range [start_pfn, start_pfn + size). I
>>>> am afraid this will break the syntax. 
>>>>
>>>> And max_pfn is also not a valid one. For example, on x86,
>>> I used pfn_max here to check for the highest zone. What would be a better way? 
>>>
>>>> update_end_of_memory_vars() will update max_pfn, which is calculated by:
>>>>
>>>>     end_pfn = PFN_UP(start + size);
>>>>
>>>> BTW, as you mentioned this apply to hotplug case. And then why this couldn't
>>>> happen during boot up? What differ these two cases?
>>>
>>> Well, the pages left uninitialized during bootup (initial problem), but the panic itself takes 
>>> place when we try to process memory_hotplug sysfs attributes (thus triggering sysfs handlers). 
>>> You can find more details in the original thread:
>>> https://marc.info/?t=153658306400001&r=1&w=2
>>>
>> 
>> Thanks.
>> 
>> I took a look into the original thread and try to reproduce this on x86.
>> 
>> My step is:
>> 
>>   1. config page_poisoning
>>   2. use kernel parameter mem=3075M
>>   3. cat the last memory block device sysfs file removable
>>      eg. when mem is 3075, cat memory9/removable
>> 
>> I don't see the Call trace. Do I miss something to reproduce it?
>> 
>
>No you don't. I guess there might be deviations depending on the architecture (I am on s390).
>As I understand, memory block size is 384 Mb on your system and memory9 is the last block on the list?

Sorry, my calculation is not correct. The last memory_block is 23
instead of 9.

>BTW, do you have CONFIG_DEBUG_VM and CONFIG_DEBUG_VM_PGFLAGS on? 
>

Yes, I have set it:

CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_PGFLAGS=y

And the kernel cmdline is:

BOOT_IMAGE=/vmlinuz-4.20.0-rc5+ root=UUID=98aa84d6-9ba6-4033-ab91-9ca6fe3dd74f ro \
resume=UUID=b7c21053-d9c1-4e58-8488-7d385f8ee107 console=ttyS0 \
LANG=en_US.UTF-8 mem=3075M

>
>>>>
>>>>> }
>>>>>
>>>>> #ifdef CONFIG_ZONE_DEVICE
>>>>> -- 
>>>>> 2.16.4
>>>>
>>>
>>> Thanks,
>>> Mikhail Zaslonko
>> 

-- 
Wei Yang
Help you, Help me
