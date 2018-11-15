Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09CDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D059223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMPnm1+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D059223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbeKPFol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:44:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39863 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbeKPFol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:44:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so9453870pgv.6;
        Thu, 15 Nov 2018 11:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SSh7/0lCGYAgQENJDWVXQysEw23TJaZDK2DamSRU1mo=;
        b=mMPnm1+e3gCGqLymvcxmqT36cFOU0P9z6lB6QAzEq7I+mkRvAIXzNpd5Mo9nYy4iBM
         etjP7w3VulK2Gy5dLJkzgy1K2/1rBey5byuwnjo1jqf45xZSap9mFqSZ4hotUoL5I/gF
         P4LWLcWpiN6JiUEHF4mtC3d+IjU2Li53pdJ51LKNpgM93G9m+IFEn1ZM0HU/zjU7K82x
         YtAxd8yLs2UfbqElbaIOgZTV2u3Z+JxnGCyra8Uv0rm/bCyGxUyn+cy5CiJ8EhW2pu6A
         xTkKXiur3Ly+iTOczkC5a3Px+/b7g13klDKMDa4dX9P27si3pj5wlLTsmvM7t6/RSpRS
         Gejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SSh7/0lCGYAgQENJDWVXQysEw23TJaZDK2DamSRU1mo=;
        b=P4Gn4HEYCmwdjyD0oZpTihoo5uArgEsWvptDa9AnixhHSbEN9vqxCte7Yt4WzO/NKn
         nSbUL/IKHccpJNvbXggYkIZCHy9w17/LkavN0gslk4lcLiUWVwUlqUBS8l7hSQ8IRlub
         JvL9UsaGCoqmYiYFhoXlHMEIWRyODkurVXWUK9hPDa74sb4UBxrAUQPhxa1q7t057BCa
         QtRB1tRFA7DqJM0ObNFGVjlBPPeUzn9u02lFiF9FprbyhFgMQ8V7Iqs+3HHazkb0UO6u
         VgMMWjQH0HwNo55jUlXXTrCH4bWUYcJ4yNJn9gYbO8BSMI+AtlLia+ZQ0mzEmKVFfpH5
         lBqw==
X-Gm-Message-State: AGRZ1gIA9UIPaMtz0KgxOc1GV6yhEakzcYDYjes+ZAiS6y1iUvtQ8PV8
        LR8gcFwJHLFtJPJn8POOFz0=
X-Google-Smtp-Source: AJdET5ckS9n0J9QfVPzLts781MmvKU2JMXF0WXo+RnqIi9A5Te9T+bQDBFjozGBgrRAT6V4ki3/C/Q==
X-Received: by 2002:a63:d34a:: with SMTP id u10mr7134748pgi.301.1542310532529;
        Thu, 15 Nov 2018 11:35:32 -0800 (PST)
Received: from [10.67.49.62] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id b27sm18863428pfh.113.2018.11.15.11.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:35:31 -0800 (PST)
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
 <05f56763-1530-933d-2ce3-3653ad4c685f@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA23075013A592A0B@us01wembx1.internal.synopsys.com>
 <04d6d0cb-8e60-88a0-061e-62c7c70024c5@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA23075013A592A33@us01wembx1.internal.synopsys.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <d4ac19a2-437e-484c-b44f-6c5ba434e364@gmail.com>
Date:   Thu, 15 Nov 2018 11:35:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075013A592A33@us01wembx1.internal.synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 4:57 PM, Vineet Gupta wrote:
> On 11/12/18 4:52 PM, Florian Fainelli wrote:
>> On 11/12/18 4:40 PM, Vineet Gupta wrote:
>>> On 11/12/18 4:38 PM, Florian Fainelli wrote:
>>>>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>>>>> -	if (initrd_start)
>>>>>> -		memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);
>>>>>> +	if (phys_initrd_size) {
>>>>>> +		memblock_reserve(phys_initrd_start, phys_initrd_size);
>>>>>> +		initrd_start = (unsigned long)__va(phys_initrd_start);
>>>>>> +		initrd_end = initrd_start + phys_initrd_size;
>>>>>> +	}
>>>>>>  #endif
>>>>> The common code now uses phys_initrd*, and you also use the same in ARC code, do
>>>>> we still need the initrd_* setting here ?
>>>>> ARC semantics was using them as PA anyways.
>>>> Yes, the generic initrd code expects initrd_start/end to be virtual
>>>> addresses, which we now directly derive from phys_initrd_start, that
>>>> should really be equivalent.
>>> So we can skip this explicit setting above - ARC arch code doesn't access the virt
>>> initrd_start
>> OK, you are saying we could just have the generic initrd code do this
>> assignment instead of having each architecture do it, is that a correct
>> understanding? 
> 
> Correct !
> 
>> If so, I suppose it could be done, whether as of this
>> patch series or as a follow-up, either way is fine with me.
> 
> If it is not too much trouble, I'd prefer this now. I should have chimed earlier.
> 
>> One possible caveat is if __va() and __phys_to_virt() behave differently
>> (e.g: because of CONFIG_DEBUG_VIRTUAL or other things).
> 
> 
> Thing is, after your patches, we don't use the vanilla initrd_xxx in arch code any
> longer. So this becomes just an implementation detail, which core code may or
> maynot need and if it does, this needs to work already w/o having to set anything
> in arch code. Agree ?

If you do not mind, I would prefer this series to go in, as-is, and
clean up the initrd_start/initrd_end assignment as a follow up patch
series. The reason is mostly that I am not yet clear on the timing of
these operations between the architecture resolving the virtual address
and the initrd code starting to use it.

Would that sound reasonable to you?
-- 
Florian
