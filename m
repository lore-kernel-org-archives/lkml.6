Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9102C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594A92064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAJk79yi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594A92064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeJ3BlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:41:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45539 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbeJ3BlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:41:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id o19-v6so4080963pll.12;
        Mon, 29 Oct 2018 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QVX478pbXLKP/bL3Vc5yqCokhu06K8Kob9lnS5v7NqA=;
        b=KAJk79yi3I7wK91ngpoFEiLoW55mK3Fh2HjE3k+afumtEkYozhPY6gE8DF6arKBXTu
         0UN4II3Le8ieLz30ol0wShYxJYSZe1vuxwi9YlAuAk3EU77sDfnXA5hU+/T/3TMLsWIg
         FOtU84YSSGGcZIbKkVk40uxIEqPblpu4Q0F0TCTwNrmrA30+XnvquJAm7dgvsj7yOvOW
         3qp+0Fo+sxVjAQoVrM12nmiBACvvPbFewCFfsQHJaKyOvKNF3EgyrcC0OjnKcWUQ2N8R
         nQYOcwqz1wpgeJs3YE0lwQG6KeyEqwD71AIeNxD2p8egZrryvyjOqa35BnAZL0VOO3oc
         uH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QVX478pbXLKP/bL3Vc5yqCokhu06K8Kob9lnS5v7NqA=;
        b=Ro5HhGQAwG9IFpFF4V/OAPWu533zBQWr0n5DC1A/rR/wMVCAATa+N5BQqe/40Yhzqz
         Iul+jl9FjDr7ubGfh7kcQwZ3bVRxSN8CwnKUdY0oG7EnO7ZCS7ziIdjsOzaAB1HmeUVN
         r4O/O11692+16+kpysKy40ervd+pMCah7NFUQQyd5eRdPC+ac3t+pNFInBcYGLYC3GnM
         1wNYaY6fhqGVt+ExuRM17oFDDF69GoM6Mea5TE0NaQ+FiAi0ZaS7MjTzPkKFJs27a07B
         QOxREhkf3M2lmJKCYFwk2Y91KNdBQH0rzAqU7ULUZy+dIpMPdxPShIYQShm+JM0awFfj
         nD2Q==
X-Gm-Message-State: AGRZ1gIc/nKzdY/sDRZZ2G/U6QcI4ip656NXO05+QgtlIWz1a+rSs4dG
        oX7RHwzweBYpclBAvlsO06I=
X-Google-Smtp-Source: AJdET5f9whF82441yxwfNK2K4Qinwa8bTyNXVLDfiZ2YD78Dieg1k7Wz3pyfNKHL22X3oz8BKqSmgg==
X-Received: by 2002:a17:902:107:: with SMTP id 7-v6mr729801plb.267.1540831909086;
        Mon, 29 Oct 2018 09:51:49 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id f6-v6sm1317894pfg.128.2018.10.29.09.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:51:47 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] arm64: Get rid of __early_init_dt_declare_initrd()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, linux@armlinux.org.uk
References: <20181026223951.30936-1-f.fainelli@gmail.com>
 <20181026223951.30936-2-f.fainelli@gmail.com>
 <20181027091341.GB6770@rapoport-lnx>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <ec8779de-cf87-3924-3a86-fc6c85c31279@gmail.com>
Date:   Mon, 29 Oct 2018 09:51:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181027091341.GB6770@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 10/27/18 2:13 AM, Mike Rapoport wrote:
> Hi Florian,
> 
> On Fri, Oct 26, 2018 at 03:39:50PM -0700, Florian Fainelli wrote:
>> ARM64 is the only architecture that re-defines
>> __early_init_dt_declare_initrd() in order for that function to populate
>> initrd_start/initrd_end with physical addresses instead of virtual
>> addresses. Instead of having an override, just get rid of that
>> implementation and perform the virtual to physical conversion of these
>> addresses in arm64_memblock_init() where relevant.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/arm64/include/asm/memory.h |  8 --------
>>  arch/arm64/mm/init.c            | 26 ++++++++++++++++----------
>>  2 files changed, 16 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index b96442960aea..dc3ca21ba240 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -168,14 +168,6 @@
>>  #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
>>  #endif
>>  
>> -#ifdef CONFIG_BLK_DEV_INITRD
>> -#define __early_init_dt_declare_initrd(__start, __end)			\
>> -	do {								\
>> -		initrd_start = (__start);				\
>> -		initrd_end = (__end);					\
>> -	} while (0)
>> -#endif
>> -
>>  #ifndef __ASSEMBLY__
>>  
>>  #include <linux/bitops.h>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 3cf87341859f..98ff0f7a0f7a 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -364,6 +364,9 @@ static void __init fdt_enforce_memory_region(void)
>>  void __init arm64_memblock_init(void)
>>  {
>>  	const s64 linear_region_size = -(s64)PAGE_OFFSET;
>> +	unsigned long __maybe_unused phys_initrd_size;
>> +	u64 __maybe_unused phys_initrd_start;
>> +	u64 __maybe_unused base, size;
>>  
>>  	/* Handle linux,usable-memory-range property */
>>  	fdt_enforce_memory_region();
>> @@ -414,8 +417,11 @@ void __init arm64_memblock_init(void)
>>  		 * initrd to become inaccessible via the linear mapping.
>>  		 * Otherwise, this is a no-op
>>  		 */
>> -		u64 base = initrd_start & PAGE_MASK;
>> -		u64 size = PAGE_ALIGN(initrd_end) - base;
>> +		phys_initrd_start = __pa(initrd_start);
>> +		phys_initrd_size = __pa(initrd_end) - phys_initrd_start;
> 
> If initrd_{start,end} are defined by the command line they already would be
> physical addresses.

Yes indeed.

> 
>> +
>> +		base = phys_initrd_start & PAGE_MASK;
>> +		size = PAGE_ALIGN(phys_initrd_size);
>>  
>>  		/*
>>  		 * We can only add back the initrd memory if we don't end up
>> @@ -459,15 +465,15 @@ void __init arm64_memblock_init(void)
>>  	 * pagetables with memblock.
>>  	 */
>>  	memblock_reserve(__pa_symbol(_text), _end - _text);
>> -#ifdef CONFIG_BLK_DEV_INITRD
>> -	if (initrd_start) {
>> -		memblock_reserve(initrd_start, initrd_end - initrd_start);
>> -
>> -		/* the generic initrd code expects virtual addresses */
>> -		initrd_start = __phys_to_virt(initrd_start);
>> -		initrd_end = __phys_to_virt(initrd_end);
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
>> +		memblock_reserve(phys_initrd_start, phys_initrd_size);
> 
> this is not needed, as we do memblock_reserve() for the same area earlier.

Humm, yes, actually we made sure before that we called
memblock_reserve() against a properly page aligned region, unlike the
one below.

> 
> What do you think of my version (below)?

Looks good to me, thanks for making those fixes, I will send that
shortly along with patch #2 if that sounds reasonable to you.

> 
>> +		/*
>> +		 * initrd_below_start_ok can be changed by
>> +		 * __early_init_dt_declare_initrd(), set it back to what
>> +		 * we want here.
>> +		 */
>> +		initrd_below_start_ok = 0;
>>  	}
>> -#endif
>>  
>>  	early_init_fdt_scan_reserved_mem();
>>  
>> -- 
>> 2.17.1
>>
> 
> From 0e5661c6f1ac2d4b08a55d38c6bc224c187af14f Mon Sep 17 00:00:00 2001
> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Sat, 27 Oct 2018 12:04:58 +0300
> Subject: [PATCH] arm64: Get rid of __early_init_dt_declare_initrd()
> 
> ARM64 is the only architecture that re-defines
> __early_init_dt_declare_initrd() in order for that function to populate
> initrd_start/initrd_end with physical addresses instead of virtual
> addresses. Instead of having an override, just get rid of that
> implementation and perform the virtual to physical conversion of these
> addresses in arm64_memblock_init() where relevant.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm64/include/asm/memory.h |  8 --------
>  arch/arm64/mm/init.c            | 40 +++++++++++++++++++++++++---------------
>  2 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b9644296..dc3ca21 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -168,14 +168,6 @@
>  #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
>  #endif
>  
> -#ifdef CONFIG_BLK_DEV_INITRD
> -#define __early_init_dt_declare_initrd(__start, __end)			\
> -	do {								\
> -		initrd_start = (__start);				\
> -		initrd_end = (__end);					\
> -	} while (0)
> -#endif
> -
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/bitops.h>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9d9582c..dd665be3 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -61,6 +61,8 @@
>  s64 memstart_addr __ro_after_init = -1;
>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>  
> +static phys_addr_t phys_initrd_start, phys_initrd_end;
> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>  static int __init early_initrd(char *p)
>  {
> @@ -71,8 +73,8 @@ static int __init early_initrd(char *p)
>  	if (*endp == ',') {
>  		size = memparse(endp + 1, NULL);
>  
> -		initrd_start = start;
> -		initrd_end = start + size;
> +		phys_initrd_start = start;
> +		phys_initrd_end = start + size;
>  	}
>  	return 0;
>  }
> @@ -363,6 +365,7 @@ static void __init fdt_enforce_memory_region(void)
>  void __init arm64_memblock_init(void)
>  {
>  	const s64 linear_region_size = -(s64)PAGE_OFFSET;
> +	u64 __maybe_unused base, size;
>  
>  	/* Handle linux,usable-memory-range property */
>  	fdt_enforce_memory_region();
> @@ -407,14 +410,23 @@ void __init arm64_memblock_init(void)
>  		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>  	}
>  
> -	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
> +	    (initrd_start || phys_initrd_start)) {
>  		/*
>  		 * Add back the memory we just removed if it results in the
>  		 * initrd to become inaccessible via the linear mapping.
>  		 * Otherwise, this is a no-op
>  		 */
> -		u64 base = initrd_start & PAGE_MASK;
> -		u64 size = PAGE_ALIGN(initrd_end) - base;
> +		if (phys_initrd_start) {
> +			initrd_start = __phys_to_virt(phys_initrd_start);
> +			initrd_end = __phys_to_virt(phys_initrd_end);
> +		} else if (initrd_start) {
> +			phys_initrd_start = __pa(initrd_start);
> +			phys_initrd_end = __pa(initrd_end);
> +		}
> +
> +		base = phys_initrd_start & PAGE_MASK;
> +		size = PAGE_ALIGN(phys_initrd_end - phys_initrd_start);
>  
>  		/*
>  		 * We can only add back the initrd memory if we don't end up
> @@ -433,6 +445,13 @@ void __init arm64_memblock_init(void)
>  			memblock_remove(base, size); /* clear MEMBLOCK_ flags */
>  			memblock_add(base, size);
>  			memblock_reserve(base, size);
> +
> +			/*
> +			 * initrd_below_start_ok can be changed by
> +			 * __early_init_dt_declare_initrd(), set it back to what
> +			 * we want here.
> +			 */
> +			initrd_below_start_ok = 0;
>  		}
>  	}
>  
> @@ -454,19 +473,10 @@ void __init arm64_memblock_init(void)
>  	}
>  
>  	/*
> -	 * Register the kernel text, kernel data, initrd, and initial
> +	 * Register the kernel text, kernel data and initial
>  	 * pagetables with memblock.
>  	 */
>  	memblock_reserve(__pa_symbol(_text), _end - _text);
> -#ifdef CONFIG_BLK_DEV_INITRD
> -	if (initrd_start) {
> -		memblock_reserve(initrd_start, initrd_end - initrd_start);
> -
> -		/* the generic initrd code expects virtual addresses */
> -		initrd_start = __phys_to_virt(initrd_start);
> -		initrd_end = __phys_to_virt(initrd_end);
> -	}
> -#endif
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> 


-- 
Florian
