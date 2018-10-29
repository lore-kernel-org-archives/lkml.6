Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4CAC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD2A2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upF7BxUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD2A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeJ3GnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:43:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45849 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbeJ3GnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:43:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id u4-v6so2327460pfh.12;
        Mon, 29 Oct 2018 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vqXkZVjCR76MjGe9H9yb1nOPGRtH4NPJel+OWXHMPko=;
        b=upF7BxUy64zzkGDPFzjcWaiU3kEyaYXy13FCPiAH5PIYdAbl2UJzdRsFiPH+PsoEh2
         ql970BBDQa/IjvG7+rpR+clt4X1O2scoRvOI3kB38JIY3GdSIY81tkEKldYkYDUddbJ/
         1YzQmE8PAs2Cc3yFznHJxHqztYU39BhEHHq5024tHLOVzj9N9fYJk7lalFTLV4WPkjtq
         VJy52jIL6AzqI/C9akywSYbwt2ise26MpKv79rtP7NK6G8dbD8Ai1uMaFIrthctSZjHk
         ZFhF3Gyalo8Ftvry/4SGTJmhD7gIkLgwIflnvpqZw27zgGg6ZMO/+/iv4js+7LLyoGu3
         Js6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vqXkZVjCR76MjGe9H9yb1nOPGRtH4NPJel+OWXHMPko=;
        b=o5xXm0kbPcVyY5eJHS86fD7Viw5dROXnydIiV5EYflC0pqODS1Rsffm7CyUDE3mJmX
         EGT/bW5zQcVcgyTtFPE+gNCGU7/BS2tih6DdB2CyvXb0NdWRFoHFHHwaBisUMqlm23yo
         RU43Hdy2zO4PEWSmI/UfIypMicXbraKo+IhmmevgrxcirS959kDFkX04Lu2TF0rSqmON
         5ZB7VUsRwPkmuk0lP/xHmPzPwxvu4g1YHOqof60D+16F8kAN9IDxUVMG9i2fVfPMBq/f
         o1mVj8XquLnNm87fOaiSgKYHajh9WjTPLw5KL/iJ2vedTLhUkYgcQGSWjRS8tihG+6/f
         9paQ==
X-Gm-Message-State: AGRZ1gI5uCnXgVLwlWgGw8KaR2qLUFE3s1JamvfRofY6/e4jr2dCaYE7
        0af3nqXymHl1dsTisVhHwRo=
X-Google-Smtp-Source: AJdET5duuBdgojQAydHrdwyHthDT/GW1VUpF9jcD6jv2fW+vN51XEVk7pNo5D6+5tSd9XLYDPNIk5A==
X-Received: by 2002:a63:3dcb:: with SMTP id k194-v6mr15354991pga.191.1540849966298;
        Mon, 29 Oct 2018 14:52:46 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id r6-v6sm17026636pgn.70.2018.10.29.14.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 14:52:45 -0700 (PDT)
Subject: Re: [PATCH 1/2 v5] arm64: Get rid of __early_init_dt_declare_initrd()
To:     Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rppt@linux.ibm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        aryabinin@virtuozzo.com, Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>, ghackmann@android.com,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        chandan.vn@samsung.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
References: <20181029190014.6455-1-f.fainelli@gmail.com>
 <20181029190014.6455-2-f.fainelli@gmail.com>
 <CAL_JsqL2g69Duhkqd=f09BStoAKeakJz8Wgz3is37YU0+fc80A@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <e3033413-555e-72ca-be75-e4b566b62480@gmail.com>
Date:   Mon, 29 Oct 2018 14:52:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL2g69Duhkqd=f09BStoAKeakJz8Wgz3is37YU0+fc80A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18 12:59 PM, Rob Herring wrote:
> +Ard who last touched this.
> 
> On Mon, Oct 29, 2018 at 2:23 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> ARM64 is the only architecture that re-defines
>> __early_init_dt_declare_initrd() in order for that function to populate
>> initrd_start/initrd_end with physical addresses instead of virtual
>> addresses. Instead of having an override, just get rid of that
>> implementation and perform the virtual to physical conversion of these
>> addresses in arm64_memblock_init() where relevant.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>> ---
>>  arch/arm64/include/asm/memory.h |  8 -------
>>  arch/arm64/mm/init.c            | 42 +++++++++++++++++++++------------
>>  2 files changed, 27 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index b96442960aea..dc3ca21ba240 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -168,14 +168,6 @@
>>  #define IOREMAP_MAX_ORDER      (PMD_SHIFT)
>>  #endif
>>
>> -#ifdef CONFIG_BLK_DEV_INITRD
>> -#define __early_init_dt_declare_initrd(__start, __end)                 \
>> -       do {                                                            \
>> -               initrd_start = (__start);                               \
>> -               initrd_end = (__end);                                   \
>> -       } while (0)
>> -#endif
>> -
>>  #ifndef __ASSEMBLY__
>>
>>  #include <linux/bitops.h>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 3cf87341859f..292570b08f85 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -62,6 +62,8 @@
>>  s64 memstart_addr __ro_after_init = -1;
>>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>
>> +static phys_addr_t phys_initrd_start, phys_initrd_end;
>> +
>>  #ifdef CONFIG_BLK_DEV_INITRD
>>  static int __init early_initrd(char *p)
>>  {
>> @@ -72,8 +74,8 @@ static int __init early_initrd(char *p)
>>         if (*endp == ',') {
>>                 size = memparse(endp + 1, NULL);
>>
>> -               initrd_start = start;
>> -               initrd_end = start + size;
>> +               phys_initrd_start = start;
>> +               phys_initrd_end = start + size;
>>         }
>>         return 0;
>>  }
>> @@ -364,6 +366,7 @@ static void __init fdt_enforce_memory_region(void)
>>  void __init arm64_memblock_init(void)
>>  {
>>         const s64 linear_region_size = -(s64)PAGE_OFFSET;
>> +       u64 __maybe_unused base, size;
>>
>>         /* Handle linux,usable-memory-range property */
>>         fdt_enforce_memory_region();
>> @@ -408,14 +411,25 @@ void __init arm64_memblock_init(void)
>>                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>>         }
>>
>> -       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
>> +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
>> +           (initrd_start || phys_initrd_start)) {
> 
> I've tried to explain already that this is broken. The problem is
> __early_init_dt_declare_initrd using __va() which happens before this
> function is called. __va() uses PHYS_OFFSET which in turn is defined
> as memstart_addr. However, memstart_addr may be changed just above
> this hunk, so the earlier conversion to a VA may not be valid at this
> point. This is explained if you read Ard's commit that added all this
> mess.

Thanks for explaining this again, looks like I had overlooked that
explanation in the "other branch" of the thread last time I read it.

> 
> You could fix this by converting back to a PA before adjusting
> memstart_addr, but that's 2 wrongs making a right and fragile. The
> better solution is the other proposal making the DT code set
> phys_initrd_* (whatever the ARM code calls them).

OK, that sounds reasonable, will cook something doing that. Thanks!

> 
>>                 /*
>>                  * Add back the memory we just removed if it results in the
>>                  * initrd to become inaccessible via the linear mapping.
>>                  * Otherwise, this is a no-op
>>                  */
>> -               u64 base = initrd_start & PAGE_MASK;
>> -               u64 size = PAGE_ALIGN(initrd_end) - base;
>> +               if (phys_initrd_start) {
>> +                       /* Command line specified the initrd location */
>> +                       initrd_start = __phys_to_virt(phys_initrd_start);
>> +                       initrd_end = __phys_to_virt(phys_initrd_end);
>> +               } else if (initrd_start) {
>> +                       /* FDT specified the initrd location */
>> +                       phys_initrd_start = __pa(initrd_start);
>> +                       phys_initrd_end = __pa(initrd_end);
> 
> Kind of inconsistent to mix __phys_to_virt and __pa flavors.
> 
> Rob
> 


-- 
Florian
