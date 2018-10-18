Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBC6C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B954C2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FPK0yQhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B954C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeJSFH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:07:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39150 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeJSFH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:07:26 -0400
Received: by mail-io1-f65.google.com with SMTP id z16-v6so21855260iol.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UPpq9B1w8ZsqzoZ8HzNWkzpfAK+a81Hm5UUEeRBFpwM=;
        b=FPK0yQheLtQfLjxy3UQb3dA9vnCnD3PHZzZ228t1ivcNqeEccrYiF6tpujLk38g0oJ
         Qa5sD3N5hwFpQCe7vkYkWcuIS99Y0IMsayZcOL2NkWpSlLfzi0ctFDvVSkX9MyAiSEQc
         jRI6/FEvxJehB8/hhE+o7DB8jpq6zAJL68kfLpWxHPzfLDynBS5hKW6KwXrIMf9fho2B
         lxFz4LMn79PfR0pjaS35h9JR6BBG37aFBx0RMY/C9P327AmEJPgxAPiDh6jIj40uRByv
         dY2MOfpXX35W6JCdcU+QaOzZ+lWh9Tc/nvxfQSdK+XsEVKbKUK62MMpd0NWEfaYAsCh9
         ryBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UPpq9B1w8ZsqzoZ8HzNWkzpfAK+a81Hm5UUEeRBFpwM=;
        b=UUvBucrF6llMJim0fCAfCvp8LUqbKRnIkyjSN0htS0qxwKz7nFC4tir2powxigRRMQ
         9ob5vV/2WsbtE3Ljn83cFyIDPYVJNXIg3Q/i3IvciyEHXBlhrac/U8h2DdFm1n2TayDi
         Sr3XvmGc1hSh1s0jlQ5zlaQr2dfN8pvMu5uguYvVkSDvHb3aHtqDVS9uC88eLwibzSxa
         pqL12EmBsz8JbWNW2O9ohfyBKCvyud8EgOfLgNfrYsUvJoQtJKlVRkEPY3vAlanlcQGK
         dg93zFkwLxrlecY/bOLMPcJqY8OTYIuGY9PNkstri1Kr3vYkA+lDURAMk+tU8cpx/Q4Q
         X6PQ==
X-Gm-Message-State: AGRZ1gIsyBKlLQucwAM9SXYCtjfOBl9sW46HpuyHDgrO3ndx4VoqQOtv
        nG5ljoy+TkjaVgA9+lLPDJxM6PqI/04=
X-Google-Smtp-Source: AJdET5dYBlIQv56AU8Q+L0BGPXLGaPuJpgfJ7t09Igudg14v/Ht1moOrLuZC/Ya3KIHeKHU702+Ajw==
X-Received: by 2002:a6b:760e:: with SMTP id g14-v6mr1364115iom.46.1539896673394;
        Thu, 18 Oct 2018 14:04:33 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t199-v6sm534492itb.2.2018.10.18.14.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 14:04:32 -0700 (PDT)
Subject: Re: bioset changes in 4.18 broke aha1542
To:     Ondrej Zary <linux@rainbow-software.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <201810182034.51724.linux@rainbow-software.org>
 <201810182222.41789.linux@rainbow-software.org>
 <2baee56c-8e56-3dba-0000-1af1392a89f7@kernel.dk>
 <201810182258.49710.linux@rainbow-software.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e5518cfa-6111-c167-1b29-27e9166041df@kernel.dk>
Date:   Thu, 18 Oct 2018 15:04:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <201810182258.49710.linux@rainbow-software.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 2:58 PM, Ondrej Zary wrote:
> On Thursday 18 October 2018 22:28:35 Jens Axboe wrote:
>> On 10/18/18 2:22 PM, Ondrej Zary wrote:
>>> On Thursday 18 October 2018 22:10:31 Jens Axboe wrote:
>>>> On 10/18/18 2:04 PM, Ondrej Zary wrote:
>>>>> On Thursday 18 October 2018 21:59:09 Jens Axboe wrote:
>>>>>> On 10/18/18 1:55 PM, Ondrej Zary wrote:
>>>>>>> On Thursday 18 October 2018 20:58:57 Jens Axboe wrote:
>>>>>>>> On 10/18/18 12:34 PM, Ondrej Zary wrote:
>>>>>>>>> Hello,
>>>>>>>>> aha1542 works fine in 4.17 but crashes in 4.18. It's hard to bisect because
>>>>>>>>> of many commits that don't compile.
>>>>>>>>> # only skipped commits left to test
>>>>>>>>> # possible first bad commit: [52190f8abe7f2bf2b4e5f9760cbcc1427ca2136b] fs: convert block_dev.c to bioset_init()
>>>>>>>>> # possible first bad commit: [a47a28b74a5c7c27bf621276b85ad6c124651236] target: convert to bioset_init()/mempool_init()
>>>>>>>>> # possible first bad commit: [6f1c819c219f7841079f0f43ab62727a55b0d849] dm: convert to bioset_init()/mempool_init()
>>>>>>>>> # possible first bad commit: [afeee514ce7f4cab605beedd03be71ebaf0c5fc8] md: convert to bioset_init()/mempool_init()
>>>>>>>>> # possible first bad commit: [d19936a26658a7a53edd5619d631ee2c2c3151a2] bcache: convert to bioset_init()/mempool_init()
>>>>>>>>> # possible first bad commit: [b906bbb6997785d9ea0bd3f5585537afa6257c43] lightnvm: convert to bioset_init()/mempool_init()
>>>>>>>>>
>>>>>>>>> Testing manually, a47a28b74a5c7c27bf621276b85ad6c124651236 works.
>>>>>>>>> 52190f8abe7f2bf2b4e5f9760cbcc1427ca2136b does not compile
>>>>>>>>> 8ac9f7c1fd1d342e82ddf078425423b050652ba0 does not compile
>>>>>>>>> e292d7bc63c8f2adb3dfda27910e805f1b6557f9 does not compile
>>>>>>>>> dad08527525f9a8ac9c7f278864c65f94bc5e9b3 does not compile
>>>>>>>>> 943cf9f3ca16133dbd00f9a4cbfea46512fcb0e8 works
>>>>>>>>> ..
>>>>>>>>> fedc3abe7bd2dcc4c80bcf3cff8708a3908d8219 works
>>>>>>>>> 04c4950d5b373ba712d928592e05e73510785bca crashes
>>>>>>>>
>>>>>>>> It looks like the ISA bioset pool isn't being initialized. You should
>>>>>>>> have messages like this in your dmesg:
>>>>>>>>
>>>>>>>> isa pool size: 16 pages
>>>>>>>>
>>>>>>>> (which you do), but also something on the bioset section. Do you have
>>>>>>>> this one:
>>>>>>>>
>>>>>>>> pool size: 64 pages
>>>>>>>>
>>>>>>>> as well?
>>>>>>>>
>>>>>>>
>>>>>>> No, it's not there.
>>>>>>
>>>>>> Can you attach your .config? I'm guessing CONFIG_HIGHMEM* isn't set.
>>>>>>
>>>>>
>>>>> It is.
>>>>
>>>> Puzzled... Does this work?
>>>>
>>>>
>>>> diff --git a/block/bounce.c b/block/bounce.c
>>>> index b30071ac4ec6..49564a1bfd22 100644
>>>> --- a/block/bounce.c
>>>> +++ b/block/bounce.c
>>>> @@ -35,10 +35,6 @@ static mempool_t page_pool, isa_page_pool;
>>>>  static __init int init_emergency_pool(void)
>>>>  {
>>>>  	int ret;
>>>> -#if defined(CONFIG_HIGHMEM) && !defined(CONFIG_MEMORY_HOTPLUG)
>>>> -	if (max_pfn <= max_low_pfn)
>>>> -		return 0;
>>>> -#endif
>>>>  
>>>>  	ret = mempool_init_page_pool(&page_pool, POOL_SIZE, 0);
>>>>  	BUG_ON(ret);
>>>>
>>>
>>> Yes, it does! 
>>> bounce: pool size: 64 pages
>>> and aha1542 works.
>>>
>>> Also added printks for pfn:
>>> max_pfn=65520, max_low_pfn=65520
>>
>> This should be a better fix, though I'm still puzzled why we need
>> it now. Can you test this one?
>>
>>
>> diff --git a/block/bounce.c b/block/bounce.c
>> index b30071ac4ec6..1356a2f4aae2 100644
>> --- a/block/bounce.c
>> +++ b/block/bounce.c
>> @@ -31,6 +31,24 @@
>>  static struct bio_set bounce_bio_set, bounce_bio_split;
>>  static mempool_t page_pool, isa_page_pool;
>>  
>> +static __init void init_bounce_bioset(void)
>> +{
>> +	static bool bounce_bs_setup;
>> +	int ret;
>> +
>> +	if (bounce_bs_setup)
>> +		return;
>> +
>> +	ret = bioset_init(&bounce_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
>> +	BUG_ON(ret);
>> +	if (bioset_integrity_create(&bounce_bio_set, BIO_POOL_SIZE))
>> +		BUG_ON(1);
>> +
>> +	ret = bioset_init(&bounce_bio_split, BIO_POOL_SIZE, 0, 0);
>> +	BUG_ON(ret);
>> +	bounce_bs_setup = true;
>> +}
>> +
>>  #if defined(CONFIG_HIGHMEM)
>>  static __init int init_emergency_pool(void)
>>  {
>> @@ -44,14 +62,7 @@ static __init int init_emergency_pool(void)
>>  	BUG_ON(ret);
>>  	pr_info("pool size: %d pages\n", POOL_SIZE);
>>  
>> -	ret = bioset_init(&bounce_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
>> -	BUG_ON(ret);
>> -	if (bioset_integrity_create(&bounce_bio_set, BIO_POOL_SIZE))
>> -		BUG_ON(1);
>> -
>> -	ret = bioset_init(&bounce_bio_split, BIO_POOL_SIZE, 0, 0);
>> -	BUG_ON(ret);
>> -
>> +	init_bounce_bioset();
>>  	return 0;
>>  }
>>  
>> @@ -102,6 +113,7 @@ int init_emergency_isa_pool(void)
>>  	BUG_ON(ret);
>>  
>>  	pr_info("isa pool size: %d pages\n", ISA_POOL_SIZE);
>> +	init_bounce_bioset();
>>  	return 0;
>>  }
>>  
>>
> 
> WARNING: vmlinux.o(.text+0x1a5ad7): Section mismatch in reference from the function init_emergency_isa_pool() to the function .init.text:init_bounce_bioset()
> The function init_emergency_isa_pool() references
> the function __init init_bounce_bioset().
> This is often because init_emergency_isa_pool lacks a __init
> annotation or the annotation of init_bounce_bioset is wrong.
> 
> And it does not work:
> [  122.395558] scsi host2: Adaptec AHA-1542 (SCSI-ID 7) at IO 0x330, IRQ 11, DMA 7
> [  122.471853] scsi host2: Adaptec 1542
> [  122.484207] bounce: isa pool size: 16 pages
> [  122.488722] BUG: unable to handle kernel NULL pointer dereference at 00000fff
> [  122.492501] *pde = 00000000
> [  122.492501] Oops: 0000 [#1] SMP
> [  122.492501] CPU: 0 PID: 51 Comm: kworker/u2:1 Not tainted 4.19.0-rc7+ #296
> [  122.492501] Hardware name:  /i440ZX-W977TF, BIOS 4.51 PG 07/12/00
> [  122.492501] Workqueue: events_unbound async_run_entry_fn
> [  122.492501] EIP: init_bounce_bioset+0x2/0x63
> 
> Removing __init from init_bounce_bioset() makes it work.

Thanks, I missed that the isa part wasn't __init.

-- 
Jens Axboe

