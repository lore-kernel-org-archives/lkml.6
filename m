Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3300C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760152087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDQAjq2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760152087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeH1Wgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:36:32 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41606 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1Wgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:36:32 -0400
Received: by mail-io0-f193.google.com with SMTP id q4-v6so2327844iob.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 11:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WXbadlXSixBG7bvwOGX1+o9Sbaxov+xhj3QW7icdiAg=;
        b=FDQAjq2aQ8MPtXnGZQG5lts8PYB4EYNjcWwf2SVwik3qJRoKkLNwizOkNQyi5h8REe
         vg7rCgw4R+gKRQVttPEfMxUbjzvGXVRY8eXiPWNfpAZkGxU49otxE056VHdBTVc7pl2X
         nMmyYFLTjD/YCMnnrwbp/JfUODQkvQPpmmbBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WXbadlXSixBG7bvwOGX1+o9Sbaxov+xhj3QW7icdiAg=;
        b=pZPuMRrbaRZUcqQhpG2sUU2p6HzfItWfvpShon1Re6ldAVbwpNKpiglshBldd0PvJ9
         hJTHclPkv16911MjJoPWd2LUPB5Za/vj3rdkNPj9/LsacB6TMTeswQVj1qijMgVdlWCh
         bPgRK3HcQ8QKP943GT9RS9j9WQ0VXwAuzmgGoWI003mtZ4gTfqxHw/qkCqY2ioiFhOXV
         tPWLn/i0ga+3bfHrozf/Pn6UBHupp8eUES08SAdNoNZfplH3wU/147EPeo+75CCz8Xqi
         q2RoVWa2FzWSCrIeC76OIw7cCT3xEFTBkyxNVnMYl4qc8bRvr2KqYnR+8/Pz3rtxgyou
         2+jw==
X-Gm-Message-State: APzg51CcjUIpU53m8/vEMTxnEwCD15IV290L7dLvr+SxNUNm59JVWS1x
        2zYuLe9XJUJIOA29/zr/rYAMhePvmgtoshQMQXvc1Q==
X-Google-Smtp-Source: ANB0VdY8QQQ1uvSdJHrbNDMxi55Orpk83XB5iiGk0LPD5isx5QSpamT9jnmy11EpES/Ho5BJ8aqvV3NJNV3mna4LNGA=
X-Received: by 2002:a6b:ba86:: with SMTP id k128-v6mr2511132iof.170.1535481815580;
 Tue, 28 Aug 2018 11:43:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 11:43:35
 -0700 (PDT)
In-Reply-To: <20180828170135.GC19825@arm.com>
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
 <20180827110245.14812-3-ard.biesheuvel@linaro.org> <20180828170135.GC19825@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 28 Aug 2018 20:43:35 +0200
Message-ID: <CAKv+Gu-tM9aKZJ3ppt9yLVP_V5YA_yN8D1j_-NtM+qQCdnc6JA@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: cpufeature: add feature for CRC32 instructions
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 August 2018 at 19:01, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Aug 27, 2018 at 01:02:43PM +0200, Ard Biesheuvel wrote:
>> Add a CRC32 feature bit and wire it up to the CPU id register so we
>> will be able to use alternatives patching for CRC32 operations.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/include/asm/cpucaps.h | 3 ++-
>>  arch/arm64/kernel/cpufeature.c   | 9 +++++++++
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>
> With the minor caveat below...
>
>> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
>> index ae1f70450fb2..9932aca9704b 100644
>> --- a/arch/arm64/include/asm/cpucaps.h
>> +++ b/arch/arm64/include/asm/cpucaps.h
>> @@ -51,7 +51,8 @@
>>  #define ARM64_SSBD                           30
>>  #define ARM64_MISMATCHED_CACHE_TYPE          31
>>  #define ARM64_HAS_STAGE2_FWB                 32
>> +#define ARM64_HAS_CRC32                              33
>>
>> -#define ARM64_NCAPS                          33
>> +#define ARM64_NCAPS                          34
>
>
> ... if this goes via crypto, you'll almost certainly get a (trivial)
> conflict with arm64, since these numbers get bumped all the time.
>

I think the first three patches should go through the arm64 tree. The
last one just removes the now redundant crc32 SIMD driver, and Herbert
could pick that up separately, i.e., it should be totally independent.


>>  #endif /* __ASM_CPUCAPS_H */
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index e238b7932096..7626b80128f5 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1222,6 +1222,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>               .cpu_enable = cpu_enable_hw_dbm,
>>       },
>>  #endif
>> +     {
>> +             .desc = "CRC32 instructions",
>> +             .capability = ARM64_HAS_CRC32,
>> +             .type = ARM64_CPUCAP_SYSTEM_FEATURE,
>> +             .matches = has_cpuid_feature,
>> +             .sys_reg = SYS_ID_AA64ISAR0_EL1,
>> +             .field_pos = ID_AA64ISAR0_CRC32_SHIFT,
>> +             .min_field_value = 1,
>> +     },
>>       {},
>>  };
>>
>> --
>> 2.18.0
>>
