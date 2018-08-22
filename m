Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF25C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 01:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506D221798
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 01:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGR7xr5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506D221798
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeHVFBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 01:01:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42180 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeHVFBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 01:01:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so177762pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 18:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=KDaatQOKL+k3GFMbTp3QYIQpMV9YAFjl8R9ciOLh/Vw=;
        b=SGR7xr5UKuJA0K64AgxV4iQn3epG7PIwrGtdeLDPN/tCRRfliErQ+oRMrb3fbOoh1z
         ELiPd+7iSdW1nt/fNoyG9qt4G93c7hYQbcjRvBjoEVW/GDJ98KOJa5Ex6+9zEX+ZbPvQ
         LVFL47jJc5t0DZn/pW7tcNMkTqPZFlL+BD430NCpc0gRdTZDDWM8uMlRIVEHKO4JEsQU
         cPz+qfMY2gMz+E7voV3C/Q0YxOcj2vwPi82Fa2fa5xScnXum8xg+6LFjgn+l+ZTS9a3S
         BNIk66FU1mOgLKaKnXtiNa+t3vYjApoYdZfuhOuYXIGs3hh4JZk1KK5t9/rLSdIQlDDr
         2L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=KDaatQOKL+k3GFMbTp3QYIQpMV9YAFjl8R9ciOLh/Vw=;
        b=j90cWIgpeiHKeNFZjbaB3R2hBV3axqvNCNbt2KuqDQ/+r1l93uACcnkHHT0zlX6+vT
         ByQj3vqoQAdNh7oGcdPPRoWz1qZk6Lp67PsFWoH9FOS6gco0fEXZ5etD2IV2j51zl9Y4
         1IgK1RU7Qo5EA4TIBE0XUysF195zuxeA2sa2duRuhxLPh0iqt8x5hyWPuDBF9dfwRAnH
         ycG03gad9pz5baLfX1RJG3+dW/JIu4brPQeoYn4rnuOhUiU4d0gMDFP7JYWfFY/3EN4r
         RJCKzD/WYSn4zeCBYBxJ5HFN0+QpLN+U6cbKiIxgXpiuteCaj8s0YpFnSV/mi0DL///E
         2nCQ==
X-Gm-Message-State: APzg51BogX1MJf5R9GT6hkjDT6Wyh9Xm981xaoBLLHZqpzrbzgiu0e7W
        DMhEMqIZz0lKMGYiAqt+WrU=
X-Google-Smtp-Source: ANB0VdbG/KyzfYZdzS6P5CgGlInzc6uBBpZhgAkeR09QmZ4mqKHFlUYXsMCJR8jMDYSghivQe/e1Tw==
X-Received: by 2002:a62:1f11:: with SMTP id f17-v6mr5363634pff.168.1534901945000;
        Tue, 21 Aug 2018 18:39:05 -0700 (PDT)
Received: from [0.0.0.0] (96.45.178.72.16clouds.com. [96.45.178.72])
        by smtp.gmail.com with ESMTPSA id q7-v6sm286349pfq.43.2018.08.21.18.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 18:39:03 -0700 (PDT)
Subject: Re: [RESEND PATCH v10 3/6] mm: page_alloc: reduce unnecessary binary
 search in memblock_next_valid_pfn()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jia He <jia.he@hxt-semitech.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-4-git-send-email-hejianet@gmail.com>
 <61ca29b9-a985-cce0-03e9-d216791c802c@microsoft.com>
 <334337ca-811e-4a2e-09ff-65ebe37ef6df@gmail.com>
 <20180821140829.7d804678e9db8725f52180c2@linux-foundation.org>
From:   Jia He <hejianet@gmail.com>
Message-ID: <5b9ed490-9e17-70ac-6b03-7ae5c6ea7b87@gmail.com>
Date:   Wed, 22 Aug 2018 09:38:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821140829.7d804678e9db8725f52180c2@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

On 8/22/2018 5:08 AM, Andrew Morton Wrote:
> On Tue, 21 Aug 2018 14:14:30 +0800 Jia He <hejianet@gmail.com> wrote:
> 
>> Hi Pasha
>>
>> On 8/17/2018 9:08 AM, Pasha Tatashin Wrote:
>>>
>>>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>>>> ---
>>>>  mm/memblock.c | 37 +++++++++++++++++++++++++++++--------
>>>>  1 file changed, 29 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/mm/memblock.c b/mm/memblock.c
>>>> index ccad225..84f7fa7 100644
>>>> --- a/mm/memblock.c
>>>> +++ b/mm/memblock.c
>>>> @@ -1140,31 +1140,52 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
>>>>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>>>>  
>>>>  #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
>>>> +static int early_region_idx __init_memblock = -1;
>>>
>>> One comment:
>>>
>>> This should be __initdata, but even better bring it inside the function
>>> as local static variable.
>>>
>> Seems it should be __initdata_memblock instead of __initdata?
>>
> 
> Eh, it's 4 bytes.
> 
> It should however be local to the sole function which uses it.

Sorry, I am not clear for this comment^
early_region_idx records the *last* valid region idx in last
memblock_next_valid_pfn. So it should be static instead of local variable?

> 
> And what's this "ulong" thing?  mm/ uses unsigned long.

ok, will change it

-- 
Cheers,
Jia
> 
> --- a/mm/memblock.c~mm-page_alloc-reduce-unnecessary-binary-search-in-memblock_next_valid_pfn-fix
> +++ a/mm/memblock.c
> @@ -1232,15 +1232,15 @@ int __init_memblock memblock_set_node(ph
>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>  
>  #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
> -static int early_region_idx __init_memblock = -1;
> -ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
> +unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
>  {
>  	struct memblock_type *type = &memblock.memory;
>  	struct memblock_region *regions = type->regions;
>  	uint right = type->cnt;
>  	uint mid, left = 0;
> -	ulong start_pfn, end_pfn, next_start_pfn;
> +	unsigned long start_pfn, end_pfn, next_start_pfn;
>  	phys_addr_t addr = PFN_PHYS(++pfn);
> +	static int early_region_idx __initdata_memblock = -1;
>  
>  	/* fast path, return pfn+1 if next pfn is in the same region */
>  	if (early_region_idx != -1) {
> --- a/include/linux/mmzone.h~mm-page_alloc-reduce-unnecessary-binary-search-in-memblock_next_valid_pfn-fix
> +++ a/include/linux/mmzone.h
> @@ -1269,7 +1269,7 @@ static inline int pfn_present(unsigned l
>  
>  #define early_pfn_valid(pfn)	pfn_valid(pfn)
>  #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
> -extern ulong memblock_next_valid_pfn(ulong pfn);
> +extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
>  #define next_valid_pfn(pfn)	memblock_next_valid_pfn(pfn)
>  #endif
>  void sparse_init(void);
> _
> 
> 

