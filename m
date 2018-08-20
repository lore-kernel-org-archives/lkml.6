Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E27C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0656D2152D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCTZ70Do"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0656D2152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbeHTJlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 05:41:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46105 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeHTJlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 05:41:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so6222778pfn.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 23:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Yz7wEo21KDl6XZd/7JFQg+qH9llCO8Z+FykYVokknew=;
        b=aCTZ70DolZsekwa4Cxhiyldi/pFVyL45ZPqx5WCM85qNmTCVxe1uZwl4Fte7ZnvWEu
         81l/JbqPibuv09mKroyb0+tcWruOEtOI1w+ONMByYzhpGMPQQeUKT7+PNz9i9CvCObl2
         nJIC2SrEenYNYBQXwpJuK2V5GOqxUqBIya6cpU6uN8IyOkVNVjiXN2/OSwDt+7algB9a
         A9IEWZ8Gm2UVZNO8//jk/rRgZ9WXaWkrgcRexQrQsK/gxh3kT/qiA4e8CoNxhMY7UbfE
         XCyw78TLl+sxe4pTh6fdvzQrNI6lXQf4vIwl/MpKR0DEMQjfLtinFuQGiT76u83LbHSk
         4X/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Yz7wEo21KDl6XZd/7JFQg+qH9llCO8Z+FykYVokknew=;
        b=PRh5OsyY2KQwMpaHlyVLdBa6npbCGSvgYU72Wqs3L5W3wTIz9fr4KzAj3QljJwkaHj
         pINgFMibEMQ19d6wrbrSzTTGxQWvca0rSU+UrYRMXNRyznExC8+CpGnaKn/h0Zugisb9
         rRFkRxL+W7xMn/001jD8pFIiZI73d0ihNezX5xwno04R309lWQhK4wVLVoE1oppIJhw5
         W4AN6BAhy9UJk7J/+te8fEBatyfk6EFgtFsfTk1CeCPHUEwuqut+D0MgiGxb8s8uT8SR
         mWQWfPmwACe6aK1+qyiKr+YNeWuvzb1Yv+fDzREWj+ZLGnEwAcVYVKPP03N6M87BlLHm
         JfOQ==
X-Gm-Message-State: AOUpUlEwSqOPMLpqCJcT1jxF3EEm4VRc2zpYLhQyr8tckMojcWwSNLBL
        6tVgv9GE/oWQm06ERahHXuo=
X-Google-Smtp-Source: AA+uWPwYSJ2vGNPB7H6EYFKEFZqfeWoIZfUY8X0XXBEQvcVLGAIBytgKybx45HghwSHLUkgksEt6hA==
X-Received: by 2002:a63:4104:: with SMTP id o4-v6mr9980634pga.146.1534746453827;
        Sun, 19 Aug 2018 23:27:33 -0700 (PDT)
Received: from [0.0.0.0] (96.45.178.72.16clouds.com. [96.45.178.72])
        by smtp.gmail.com with ESMTPSA id o10-v6sm20917343pfk.76.2018.08.19.23.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 23:27:32 -0700 (PDT)
Subject: Re: [RESEND PATCH v10 1/6] arm: arm64: introduce
 CONFIG_HAVE_MEMBLOCK_PFN_VALID
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Petr Tesarik <ptesarik@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Vacek <neelx@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Philip Derrin <philip@cog.systems>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Jia He <jia.he@hxt-semitech.com>,
        Kemi Wang <kemi.wang@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Steve Capper <steve.capper@arm.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-2-git-send-email-hejianet@gmail.com>
 <20180817145052.aizhi6n66vxblriq@armageddon.cambridge.arm.com>
From:   Jia He <hejianet@gmail.com>
Message-ID: <73e1f356-2b6c-a7fd-2f04-e5b58ae79884@gmail.com>
Date:   Mon, 20 Aug 2018 14:27:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180817145052.aizhi6n66vxblriq@armageddon.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/2018 10:50 PM, Catalin Marinas Wrote:
> On Fri, Jul 06, 2018 at 05:01:10PM +0800, Jia He wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 42c090c..26d75f4 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -778,6 +778,10 @@ config ARCH_SELECT_MEMORY_MODEL
>>  config HAVE_ARCH_PFN_VALID
>>  	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
>>  
>> +config HAVE_MEMBLOCK_PFN_VALID
>> +	def_bool y
>> +	depends on HAVE_ARCH_PFN_VALID
>> +
>>  config HW_PERF_EVENTS
>>  	def_bool y
>>  	depends on ARM_PMU
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 94af022..28fcf54 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -137,6 +137,9 @@ config HAVE_MEMBLOCK_NODE_MAP
>>  config HAVE_MEMBLOCK_PHYS_MAP
>>  	bool
>>  
>> +config HAVE_MEMBLOCK_PFN_VALID
>> +	bool
> 
> Since you defined HAVE_MEMBLOCK_PFN_VALID here, do we need to define it
> in the arch code as well? If kept it in the mm/Kconfig only, you could
> just select it in the arch HAVE_ARCH_PFN_VALID entry:
> 

Ok, thanks for the comments
It makes it more clean.
-- 
Cheers,
Jia

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index d0a53cc6293a..cd230c77e122 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -787,6 +787,7 @@ config ARCH_FLATMEM_ENABLE
>  
>  config HAVE_ARCH_PFN_VALID
>  	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
> +	select HAVE_MEMBLOCK_PFN_VALID
>  
>  config HW_PERF_EVENTS
>  	def_bool y
> 
> (similarly for arch/arm)
> 

