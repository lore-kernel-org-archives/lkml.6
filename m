Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEFBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7A820898
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jesVxtRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7A820898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeH0QSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:18:06 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41487 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeH0QSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:18:06 -0400
Received: by mail-qk0-f196.google.com with SMTP id h138-v6so10297861qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 05:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YHURWABRibobAW0SZi3fEy+5Um+ZI1JVbXd33B2YY0s=;
        b=jesVxtRMj4SMxBHrQ9/VwdfnHgyIGPCFmrlnEc3GcCOcdlMMO0iOTDANkn20FdNzPp
         zJlm6o/oo4sTf9TbvfHOWDwbsojygIBekLKcjzfWdnAdXJjOvsubf0PxTEezwgy94nbx
         aASPvXRj5+kzwmAYRvQjEPxLrMBIB69nXYzl50YR8c9kH3mU6epQkRujmrQMmWHtOH1S
         E9PHjnkUHvxmsmUiYihl4d9ZStkAniLiDa/OVfRH9v9uBieiw0Y4djtSC3e5njCHILa0
         VXNFvje0aEruW1jnBKu+L5RM3rrAwIqnpuVXt3YRunqfvu7nuhzg7z2nDlMn289qazze
         OS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YHURWABRibobAW0SZi3fEy+5Um+ZI1JVbXd33B2YY0s=;
        b=c9dek3evEHnYgha3W0uUt4LOFwV7X0nP6YNiIjnpdk70bOnxFLIYsSHz2WqMzBhN/7
         fRbSXIz0G9ufiWXXNqa0EER+wfZK8CqLVNGOY0G7cQufS/LDPXsTyBaESP1javNYRtL1
         OtZ81u6OkFBFqIoKBbgwWLOoYEfdeRa3wFuHCqC5Q9KVHxGdvZhGRUMTnSmInXwPL2hh
         nXrZS0iYXlXtmgm1ge4GdcnLpxb48inPIGx6gVdOC0CWkvriEovUf5uo1fckYJDEpJ8n
         DiqP1XgiUJz5kO4lCR4L9NRUWET4QvPf7IWGqdbz4b43N+i8wJXLAqoWKeSusc56ec5/
         y8zA==
X-Gm-Message-State: APzg51BI6sdANz/7PR+CNmY0wg720v8WwjR6FWgvW36cUiQRa3LtKMeW
        rRUlR53s3t+t5XuieeD/5g==
X-Google-Smtp-Source: ANB0VdaLzpvy6Fxj/fhgIM+q9vfs7F72CVykDxLgacpJ6nhd3VKGFNtStq4ZU7n2u2B2TSL97mSowA==
X-Received: by 2002:a37:6458:: with SMTP id y85-v6mr13030554qkb.59.1535373097163;
        Mon, 27 Aug 2018 05:31:37 -0700 (PDT)
Received: from [10.18.17.172] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p23-v6sm10692097qta.8.2018.08.27.05.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 05:31:36 -0700 (PDT)
Subject: Re: [PATCH 1/2] Revert "x86/e820: put !E820_TYPE_RAM regions into
 memblock.reserved"
To:     mhocko@kernel.org, n-horiguchi@ah.jp.nec.com,
        Pavel.Tatashin@microsoft.com
Cc:     linux-mm@kvack.org, m.mizuma@jp.fujitsu.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        osalvador@techadventures.net
References: <20180823182513.8801-1-msys.mizuma@gmail.com>
 <20180824000325.GA20143@hori1.linux.bs1.fc.nec.co.jp>
 <20180824082908.GC29735@dhcp22.suse.cz>
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
Message-ID: <ffce827a-c12e-591a-715e-ae3a152b1954@gmail.com>
Date:   Mon, 27 Aug 2018 08:31:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824082908.GC29735@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

I would appreciate if you could send the feedback for the patch.

Thanks!
Masa

On 08/24/2018 04:29 AM, Michal Hocko wrote:
> On Fri 24-08-18 00:03:25, Naoya Horiguchi wrote:
>> (CCed related people)
> 
> Fixup Pavel email.
> 
>>
>> Hi Mizuma-san,
>>
>> Thank you for the report.
>> The mentioned patch was created based on feedbacks from reviewers/maintainers,
>> so I'd like to hear from them about how we should handle the issue.
>>
>> And one note is that there is a follow-up patch for "x86/e820: put !E820_TYPE_RAM
>> regions into memblock.reserved" which might be affected by your changes.
>>
>>> commit e181ae0c5db9544de9c53239eb22bc012ce75033
>>> Author: Pavel Tatashin <pasha.tatashin@oracle.com>
>>> Date:   Sat Jul 14 09:15:07 2018 -0400
>>>
>>>     mm: zero unavailable pages before memmap init
>>
>> Thanks,
>> Naoya Horiguchi
>>
>> On Thu, Aug 23, 2018 at 02:25:12PM -0400, Masayoshi Mizuma wrote:
>>> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>>>
>>> commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into
>>> memblock.reserved") breaks movable_node kernel option because it
>>> changed the memory gap range to reserved memblock. So, the node
>>> is marked as Normal zone even if the SRAT has Hot plaggable affinity.
>>>
>>>     =====================================================================
>>>     kernel: BIOS-e820: [mem 0x0000180000000000-0x0000180fffffffff] usable
>>>     kernel: BIOS-e820: [mem 0x00001c0000000000-0x00001c0fffffffff] usable
>>>     ...
>>>     kernel: reserved[0x12]#011[0x0000181000000000-0x00001bffffffffff], 0x000003f000000000 bytes flags: 0x0
>>>     ...
>>>     kernel: ACPI: SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
>>>     kernel: ACPI: SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
>>>     ...
>>>     kernel: Movable zone start for each node
>>>     kernel:  Node 3: 0x00001c0000000000
>>>     kernel: Early memory node ranges
>>>     ...
>>>     =====================================================================
>>>
>>> Naoya's v1 patch [*] fixes the original issue and this movable_node
>>> issue doesn't occur.
>>> Let's revert commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM
>>> regions into memblock.reserved") and apply the v1 patch.
>>>
>>> [*] https://lkml.org/lkml/2018/6/13/27
>>>
>>> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>>> ---
>>>  arch/x86/kernel/e820.c | 15 +++------------
>>>  1 file changed, 3 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>>> index c88c23c658c1..d1f25c831447 100644
>>> --- a/arch/x86/kernel/e820.c
>>> +++ b/arch/x86/kernel/e820.c
>>> @@ -1248,7 +1248,6 @@ void __init e820__memblock_setup(void)
>>>  {
>>>  	int i;
>>>  	u64 end;
>>> -	u64 addr = 0;
>>>  
>>>  	/*
>>>  	 * The bootstrap memblock region count maximum is 128 entries
>>> @@ -1265,21 +1264,13 @@ void __init e820__memblock_setup(void)
>>>  		struct e820_entry *entry = &e820_table->entries[i];
>>>  
>>>  		end = entry->addr + entry->size;
>>> -		if (addr < entry->addr)
>>> -			memblock_reserve(addr, entry->addr - addr);
>>> -		addr = end;
>>>  		if (end != (resource_size_t)end)
>>>  			continue;
>>>  
>>> -		/*
>>> -		 * all !E820_TYPE_RAM ranges (including gap ranges) are put
>>> -		 * into memblock.reserved to make sure that struct pages in
>>> -		 * such regions are not left uninitialized after bootup.
>>> -		 */
>>>  		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
>>> -			memblock_reserve(entry->addr, entry->size);
>>> -		else
>>> -			memblock_add(entry->addr, entry->size);
>>> +			continue;
>>> +
>>> +		memblock_add(entry->addr, entry->size);
>>>  	}
>>>  
>>>  	/* Throw away partial pages: */
>>> -- 
>>> 2.18.0
>>>
>>>
> 
