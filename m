Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3417C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F048223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oG6/CElN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F048223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbeKMKda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:33:30 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:32863 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:33:30 -0500
Received: by mail-yw1-f68.google.com with SMTP id z72-v6so5155765ywa.0;
        Mon, 12 Nov 2018 16:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8viCshgQjtcT4yWer4NxxTHZgWPkKC1LVZZh6ujpfZI=;
        b=oG6/CElNQaxIHtY9kXm5A+BHciSGwSxBG3F8Gsdykt1dkICuvSyz1FyAnZdgunyFZM
         y4yKjiFj79EpEcJ3b6LKLkPvyfSbA5lsbIVr5ei5geC1R9dktXNo0M+h7BHeO4QCo9Tt
         CbtOZUG+QS2nbdTX2leLhCyfrkFNuS8u3ngqc7Czf0y4A1+TmbT2OrgwVUurhbXpsZZM
         Mdz37ifze5wI+kbRXC62GLXPwq7FMlo22iiOZfnvNZWfYM7Ajt7zg6L3pDX4jVV5pXL+
         YfTvh15WUq9HTgHfT6oV1iRk8qDKuvCJTHjLdFQmd0xpbcscpZKFP0Zbe8P1iYeZzdLf
         MtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8viCshgQjtcT4yWer4NxxTHZgWPkKC1LVZZh6ujpfZI=;
        b=VpVK0iTq0Xj0ESStISUMHbbhYHAU3N3UcRMhnbK7pHc0Q6BAJSK7YqE2U0Xm13P3YM
         gC1JEcgGbrX3Pf/GCGRWLl/JC8pKaTf5N6BxbU5r1e7K5YB0j3JRVhX3DSja6i+K+PAA
         y8fPolRqBOV1G2umB5y3CF5JQ8HVNiLXXpOPNQmQocFrLaHypgkccf1lc65PPa+HBEa1
         3Elqy80KWQEXCddn4ULGOgFdUapT/3LfywDad1QzardgpNWcaUUEAS+vOSn6roo/uWD6
         qZ2TssbzgEKa7nlyD7WazPijAaJ8oRkEVYJnQ5NnwedgA1iJjJj8g8ythKZcbAw18HVx
         YTMw==
X-Gm-Message-State: AGRZ1gJ29xjW3DhP/hzjJeBmPZf1i7pDS6d68vr7TEz2o1l3adxMDOLo
        oSh+0WimeUlLota55I/FZNc=
X-Google-Smtp-Source: AJdET5cZOe9P5ZjXr0p/MiDh1QBug8T5w9Ew8VbJs/ckSFydkxTdlUhfHx/nYCt5wjosJ9H4ASzdmA==
X-Received: by 2002:a81:256:: with SMTP id 83-v6mr3039035ywc.344.1542069474540;
        Mon, 12 Nov 2018 16:37:54 -0800 (PST)
Received: from [10.67.49.62] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id h145sm2001540ywc.72.2018.11.12.16.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 16:37:53 -0800 (PST)
Subject: Re: [PATCH v4 6/6] arch: Move initrd= parsing into do_mounts_initrd.c
To:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        <devicetree@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "gxt@pku.edu.cn" <gxt@pku.edu.cn>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
 <20181105225431.24485-7-f.fainelli@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA23075013A5929ED@us01wembx1.internal.synopsys.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <05f56763-1530-933d-2ce3-3653ad4c685f@gmail.com>
Date:   Mon, 12 Nov 2018 16:37:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075013A5929ED@us01wembx1.internal.synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 4:34 PM, Vineet Gupta wrote:
> On 11/5/18 2:58 PM, Florian Fainelli wrote:
>> ARC, ARM, ARM64 and Unicore32 are all capable of parsing the "initrd="
>> command line parameter to allow specifying the physical address and size
>> of an initrd. Move that parsing into init/do_mounts_initrd.c such that
>> we no longer duplicate that logic.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/arc/mm/init.c       | 25 +++++--------------------
>>  arch/arm/mm/init.c       | 17 -----------------
>>  arch/arm64/mm/init.c     | 18 ------------------
>>  arch/unicore32/mm/init.c | 18 ------------------
>>  init/do_mounts_initrd.c  | 17 +++++++++++++++++
>>  5 files changed, 22 insertions(+), 73 deletions(-)
>>
>> diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
>> index f8fe5668b30f..43bf4c3a1290 100644
>> --- a/arch/arc/mm/init.c
>> +++ b/arch/arc/mm/init.c
>> @@ -78,24 +78,6 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>>  		base, TO_MB(size), !in_use ? "Not used":"");
>>  }
>>  
>> -#ifdef CONFIG_BLK_DEV_INITRD
>> -static int __init early_initrd(char *p)
>> -{
>> -	unsigned long start, size;
>> -	char *endp;
>> -
>> -	start = memparse(p, &endp);
>> -	if (*endp == ',') {
>> -		size = memparse(endp + 1, NULL);
>> -
>> -		initrd_start = (unsigned long)__va(start);
>> -		initrd_end = (unsigned long)__va(start + size);
>> -	}
>> -	return 0;
>> -}
>> -early_param("initrd", early_initrd);
>> -#endif
>> -
>>  /*
>>   * First memory setup routine called from setup_arch()
>>   * 1. setup swapper's mm @init_mm
>> @@ -140,8 +122,11 @@ void __init setup_arch_memory(void)
>>  	memblock_reserve(low_mem_start, __pa(_end) - low_mem_start);
>>  
>>  #ifdef CONFIG_BLK_DEV_INITRD
>> -	if (initrd_start)
>> -		memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);
>> +	if (phys_initrd_size) {
>> +		memblock_reserve(phys_initrd_start, phys_initrd_size);
>> +		initrd_start = (unsigned long)__va(phys_initrd_start);
>> +		initrd_end = initrd_start + phys_initrd_size;
>> +	}
>>  #endif
> 
> The common code now uses phys_initrd*, and you also use the same in ARC code, do
> we still need the initrd_* setting here ?
> ARC semantics was using them as PA anyways.

Yes, the generic initrd code expects initrd_start/end to be virtual
addresses, which we now directly derive from phys_initrd_start, that
should really be equivalent.
-- 
Florian
