Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01856C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA562177F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjBEvF6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA562177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeHUTYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:24:45 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39828 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeHUTYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:24:44 -0400
Received: by mail-qk0-f193.google.com with SMTP id b19-v6so4753487qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0pEqpXauKOzaJXgoufWbsysuhksPVJ5WILCiDjD6Aa0=;
        b=gjBEvF6Pqa9stn12ikev0F91Pd16pOOnc9i8Q564YB6REj5O/dqJPaVX/igidkZowt
         H0M4NtCgkTnGEj5nq4UmnJRXIWrITaCotgsQfxN1D8Pr7yYHywzcijhvQ9rBo4vQ14GF
         KCA1JMjWBVQqfBSO6OixGpQua9QeFJV1Xmf4U56p4OryKa4yx0czTi9IHXeng2WoDfjP
         8NR0VeCFjfMJacr7KSO/yrM2q6wWuwfBGFBcqZcfSFDNG1JCpkDx46DlPWBfyUhylNPU
         CuoFJZlci+W1LJxUlFHyQFGarUgGppfLtGq28UWZZqtGoTy6huO+5uGYP+VVnvSxyd9R
         mllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0pEqpXauKOzaJXgoufWbsysuhksPVJ5WILCiDjD6Aa0=;
        b=cFIYZ0BQKkubmXthW4Fg6CSQL3YZSkgFbmaK1aLv2abAC0yW/zD0XIJkxJVHbYBGwT
         DHsn6XBi1l1xgAizu9E9zpoyx6DZUWIGI0hFyb3CaF2zaMfNweue+uhtoGYk1krJjIyR
         VrFYmMOj87/qLEUFwWEAwxPaH1PHqyBXL2dEIMvk1VgE7//OCUrM/WjMNjlK4kD9Fdgl
         w5Nuh2Q7G8T4WVhHLdvG0qP3N4Q1EPlUwaDXP5XKAa2IpYlYEVapK69n6gOPszMGhU4j
         ZPB8NrvnU/vGXlMUHZ+L8gjWmqnwimD+RDdc9Yx7S+tD9B9DOs23uEBZ/0ISwXaJ/L0H
         Zx8Q==
X-Gm-Message-State: AOUpUlGKJvPYnZOhvNVONbIS801//j3DsgWxIPx8F7i8NaeBxzh18Dy2
        lZfg1M/Us059PTnbwrxY6U0Trcg=
X-Google-Smtp-Source: AA+uWPzdEtQ5b73VdYy2U5UUUSv7PuV6XX7+DMyJhR6CrLO1of2DguLRDkyfuUV+76SnBneFjCxxog==
X-Received: by 2002:a37:4707:: with SMTP id u7-v6mr44720476qka.229.1534867440257;
        Tue, 21 Aug 2018 09:04:00 -0700 (PDT)
Received: from [10.18.17.172] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w79-v6sm8692194qkw.35.2018.08.21.09.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 09:03:59 -0700 (PDT)
Subject: Re: [RESEND] [PATCH 1/2] x86/mm: Add an option to change the padding
 used for the physical memory mapping.
To:     bhe@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, m.mizuma@jp.fujitsu.com,
        linux-kernel@vger.kernel.org
References: <20180821132401.14563-1-msys.mizuma@gmail.com>
 <20180821145140.GD29313@MiWiFi-R3L-srv>
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
Message-ID: <c9f2ea67-7b8a-6f34-e387-40abfbfcddfb@gmail.com>
Date:   Tue, 21 Aug 2018 12:03:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821145140.GD29313@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

On 08/21/2018 10:51 AM, Baoquan He wrote:
> Hi Masa,
> 
> On 08/21/18 at 09:24am, Masayoshi Mizuma wrote:
>> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>>
>> There are some exceptional cases that the padding used for the physical
>> memory mapping section is not enough.
>>
>> For example of the cases:
>> - As Baoquan reported in the following, SGI UV system.
>>   https://lkml.org/lkml/2017/9/7/87
>> - Each node of physical memory layout has huge space for hotplug.
>>   For exapmle of the layout:
>>     SRAT: Node 6 PXM 4 [mem 0x100000000000-0x13ffffffffff] hotplug
>>     SRAT: Node 7 PXM 5 [mem 0x140000000000-0x17ffffffffff] hotplug
>>     SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
>>     SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
>>
>> We can increase the padding by CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
>> however, the available entropy is decreased if the padding is increased.
>> So the config change is not very good for the other most of systems.
>> And, the needed padding size depends on the system environment, for
>> example physical memory layout, so the kernel option is better than
>> changing the config.
>>
>> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>> ---
>>  arch/x86/mm/kaslr.c | 20 +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
>> index 61db77b..8c7b4f6 100644
>> --- a/arch/x86/mm/kaslr.c
>> +++ b/arch/x86/mm/kaslr.c
>> @@ -33,6 +33,9 @@
>>  
>>  #define TB_SHIFT 40
> 
> I think this fix makes sense. Since we usually compiled in hotplug code
> by default, while may not really hot plug a memory board on most of
> systems. However on those systems which really need do hot plug, and
> might plug memory board onto physical position above 10TB, this will
> cause issues.
> 
> One tiny concern is that we have below definition for 5-level, means we
> can only have 4PB of system RAM for now. Not sure if one day it will be
> enlarged to 32PB as Documentation/x86/x86_64/mm.txt tell.
> 
> # define MAX_PHYSMEM_BITS       (pgtable_l5_enabled() ? 52 : 46)

Thank you for pointing it out.
I will change the max padding as follows and post v2 patch.

static int __init rand_mem_physical_padding_setup(char *str)
{
       int max_padding = (1 <<(MAX_PHYSMEM_BITS - TB_SHIFT)) - 1;

> Otherwise this patchset looks good to me.

Thank you for your review!

- Masa

> 
> Thanks
> Baoquan
> 
>>  
>> +#define MAX_PADDING_L4 63
>> +#define MAX_PADDING_L5 32767
>> +
>>  /*
>>   * The end address could depend on more configuration options to make the
>>   * highest amount of space for randomization available, but that's too hard
>> @@ -40,6 +43,7 @@
>>   */
>>  static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
>>  
>> +static int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
>>  /*
>>   * Memory regions randomized by KASLR (except modules that use a separate logic
>>   * earlier during boot). The list is ordered based on virtual addresses. This
>> @@ -69,6 +73,20 @@ static inline bool kaslr_memory_enabled(void)
>>  	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
>>  }
>>  
>> +static int __init rand_mem_physical_padding_setup(char *str)
>> +{
>> +	int max_padding = pgtable_l5_enabled() ? MAX_PADDING_L5 : MAX_PADDING_L4;
>> +
>> +	get_option(&str, &rand_mem_physical_padding);
>> +	if (rand_mem_physical_padding < 0)
>> +		rand_mem_physical_padding = 0;
>> +	else if (rand_mem_physical_padding > max_padding)
>> +		rand_mem_physical_padding = max_padding;
>> +
>> +	return 0;
>> +}
>> +early_param("rand_mem_physical_padding", rand_mem_physical_padding_setup);
>> +
>>  /* Initialize base and padding for each memory region randomized with KASLR */
>>  void __init kernel_randomize_memory(void)
>>  {
>> @@ -102,7 +120,7 @@ void __init kernel_randomize_memory(void)
>>  	 */
>>  	BUG_ON(kaslr_regions[0].base != &page_offset_base);
>>  	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
>> -		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
>> +		rand_mem_physical_padding;
>>  
>>  	/* Adapt phyiscal memory region size based on available memory */
>>  	if (memory_tb < kaslr_regions[0].size_tb)
>> -- 
>> 2.18.0
>>
