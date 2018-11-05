Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA083C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661DF20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEGLJNyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661DF20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbeKFGNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:13:07 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35837 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeKFGNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:13:06 -0500
Received: by mail-yw1-f65.google.com with SMTP id w135-v6so4256744ywd.2;
        Mon, 05 Nov 2018 12:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J722CbREYwyC7UJWtthlxtbRr0OyZ0CtR90JxIhx+NY=;
        b=aEGLJNyyKIVSt4K84R/xYZXvHnALbY5wsP7/ZQZK355vAHkWJ1tswMzVNeBRNmkONY
         Z+4aD0xDZGLRimT3ZoI1zVmMnVjog+aKLB4OkpYOgMrHpVdxsAc1kRzHxx7JPXNJ3oVr
         xCmV+FQZdDLR9ImZ10UZhKaLde0h4tpvsj+QnPoym5UdMFKO6BDBvC9Zv4CmMncXCYX4
         aBiCw+mLAm6fzo5F8cZyhL8baDqmWX+mEEKs8jq4tD10hMhDqWTVm/YbYnAVefmmexei
         TqMMApT1YZSX9gZ9tiVcH/zsIeS0J9ifmMfWpw0C91TkDV+oGnTblJgw3dxUslOUzjy9
         pHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J722CbREYwyC7UJWtthlxtbRr0OyZ0CtR90JxIhx+NY=;
        b=smqTFIKHWzeOp5/gj4bfhlKDWtbeHSZR0qGKLzXeLwdFNDKiG26d8CVspzTjFG6r39
         /yg23K04iUW9XT1s9mubtruzV/x7Z18+XBn1hFsdqAMqZq9oCwIsKJTwLBjdlrf660cl
         fq7lwXnpD8nVtAh3FoqaLtNNQXUHPWJvl7rLZ0zRq+wd4+nJv3ZxfAejqnaQYXPvGpdw
         CkgJJoisH2eqKjHWZOFPK2TpfWBSOUFzUY++kh1EaRI6OcZ7i18pp0Yd1KuLMd8CUBCf
         5JCAGkCsDrtI5aWYgGc/hKNpstVb0693JBVTs8cAVZIpVodAt1L/+2aDShjsZoAupfil
         uyLQ==
X-Gm-Message-State: AGRZ1gLzjGyK0LwINzIZFWe/CDoko84e+glbQfx41D3hagA2uoLxtOV/
        BdAdj0vIGNhQJTqbZ/xYmWI=
X-Google-Smtp-Source: AJdET5f6EknKQZiPXR7cKH3XcWzSVSTb6kAdRNfVEfLviO28F1qH/o4xh0/FIW0IZUAFMmwO+CELuQ==
X-Received: by 2002:a81:4415:: with SMTP id r21-v6mr22624079ywa.393.1541451092912;
        Mon, 05 Nov 2018 12:51:32 -0800 (PST)
Received: from [10.67.48.214] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id k192-v6sm2608714ywk.99.2018.11.05.12.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:51:32 -0800 (PST)
Subject: Re: [PATCH v3 4/6] arm64: Utilize phys_initrd_start/phys_initrd_size
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        <devicetree@vger.kernel.org>, rppt@linux.ibm.com,
        Russell King <linux@armlinux.org.uk>, green.hu@gmail.com,
        deanbo422@gmail.com, gxt@pku.edu.cn,
        linux-snps-arc@lists.infradead.org, vgupta@synopsys.com
References: <20181031192843.13230-1-f.fainelli@gmail.com>
 <20181031192843.13230-5-f.fainelli@gmail.com>
 <CAKv+Gu85kRVos-z+1WuV5J8bTHpLDDdUu0hVD2NmZ-w-ry5f4g@mail.gmail.com>
 <537b8384-629a-770b-e506-f4d49b92e758@gmail.com>
 <CAKv+Gu88HHe-ZpVS3w+0Eu+Q-zYaN3sKDK4uaG+eecVtr-C9PA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <0257ee07-8b85-5295-1490-72c7aa14943d@gmail.com>
Date:   Mon, 5 Nov 2018 12:51:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu88HHe-ZpVS3w+0Eu+Q-zYaN3sKDK4uaG+eecVtr-C9PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18 12:44 PM, Ard Biesheuvel wrote:
> On 5 November 2018 at 21:41, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 11/5/18 12:39 PM, Ard Biesheuvel wrote:
>>> Hi Florian,
>>>
>>> On 31 October 2018 at 20:28, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>> ARM64 is the only architecture that re-defines
>>>> __early_init_dt_declare_initrd() in order for that function to populate
>>>> initrd_start/initrd_end with physical addresses instead of virtual
>>>> addresses. Instead of having an override we can leverage
>>>> drivers/of/fdt.c populating phys_initrd_start/phys_initrd_size to
>>>> populate those variables for us.
>>>>
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> ---
>>>>  arch/arm64/mm/init.c | 19 +++++++++----------
>>>>  1 file changed, 9 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>>> index 3cf87341859f..00ef2166bb73 100644
>>>> --- a/arch/arm64/mm/init.c
>>>> +++ b/arch/arm64/mm/init.c
>>>> @@ -72,8 +72,8 @@ static int __init early_initrd(char *p)
>>>>         if (*endp == ',') {
>>>>                 size = memparse(endp + 1, NULL);
>>>>
>>>> -               initrd_start = start;
>>>> -               initrd_end = start + size;
>>>> +               phys_initrd_start = start;
>>>> +               phys_initrd_size = size;
>>>>         }
>>>>         return 0;
>>>>  }
>>>> @@ -408,14 +408,14 @@ void __init arm64_memblock_init(void)
>>>>                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>>>>         }
>>>>
>>>> -       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
>>>> +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
>>>>                 /*
>>>>                  * Add back the memory we just removed if it results in the
>>>>                  * initrd to become inaccessible via the linear mapping.
>>>>                  * Otherwise, this is a no-op
>>>>                  */
>>>> -               u64 base = initrd_start & PAGE_MASK;
>>>> -               u64 size = PAGE_ALIGN(initrd_end) - base;
>>>> +               u64 base = phys_initrd_start & PAGE_MASK;
>>>> +               u64 size = PAGE_ALIGN(phys_initrd_size);
>>>>
>>>>                 /*
>>>>                  * We can only add back the initrd memory if we don't end up
>>>> @@ -460,12 +460,11 @@ void __init arm64_memblock_init(void)
>>>>          */
>>>>         memblock_reserve(__pa_symbol(_text), _end - _text);
>>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>>> -       if (initrd_start) {
>>>> -               memblock_reserve(initrd_start, initrd_end - initrd_start);
>>>> -
>>>> +       if (phys_initrd_size) {
>>>>                 /* the generic initrd code expects virtual addresses */
>>>> -               initrd_start = __phys_to_virt(initrd_start);
>>>> -               initrd_end = __phys_to_virt(initrd_end);
>>>> +               initrd_start = __phys_to_virt(phys_initrd_start);
>>>> +               initrd_end = initrd_start + phys_initrd_size;
>>>> +               initrd_below_start_ok = 0;
>>>
>>> Where is this assignment coming from?
>>
>> __early_init_dt_declare_initrd() sets initrd_below_start_ok to 1 though
>> after patch #5 this is not necessary any more.
> 
> Yes, but why? The original arm64 version of
> __early_init_dt_declare_initrd() does not set it but now you set to 1
> in the IS_ENABLED(CONFIG_ARM64) section in the generic code and set it
> back to 0 here.

Humm, it is an if (!IS_ENABLED(CONFIG_ARM64)) condition, so we would not
be taking that branch on an ARM64 kernel.

If you are saying the assignment is not necessary anymore after patch #5
, that is true, though this can only be done a part of part #5, not as
part of patch #4 in order not to break initrd functionality in-between
patches.

> 
> Or am I missing something?
> 

Not sure, I could be too, it's Monday after all :)
-- 
Florian
