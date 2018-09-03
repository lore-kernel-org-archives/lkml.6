Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE927C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8091320843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNUWCB1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8091320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeICNde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:33:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35967 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeICNdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:33:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1-v6so8333345pgo.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 02:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t++vTVhu9ygKCY2NSZpL+hZ41FR2WUk/Lah+sgjU5so=;
        b=uNUWCB1ydX2/sZ6Jlyd/oYX62bdfU7Au5zcBEYQy5GjFc6PYiEVHdZr1B7JAOegWoE
         2epaD0zKzOJQbGhSRoAzUIHkL6SZdAZV4vpCUCeQTxvYe0xdEzojMXoHzgfW/Dkm3cXV
         ucJw2Dx4/fpReg+4T5Jhq3nhnMoBZnAG4+HU7MAJkj9cx3G22FzmPxvosMdwc799nfyL
         pqJf6MsepMFe82Krtlxd2V1kNwJbdbL5ly3R5jr2O1uFfjwG08LWPeEcOwbzuTPzzOx3
         AsZz3p9wNP6y+MKBsch9Z/+CYtZ3CY9JqY7lM847uH1NU2klBk+y1kKWDdmyHQi8rVvH
         M9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t++vTVhu9ygKCY2NSZpL+hZ41FR2WUk/Lah+sgjU5so=;
        b=iAi5qnXLnAy82Plo3nm+Ga6nFq8leOdjbyAZd9lw+YNlHmA+LS8YycKuDkwwWVojpX
         7SvepaW5dMyuEhBYUsOQUhZj9DYwx2UxDq/8HZ7Kco1mc1tn1PlJ1P7dkdDEedBdlO/X
         QJTIBq/MZP6jq7p+2yZjPvwocWO9bRRPYwyz/IHC8CMLEf/1gUBawGh+byiNoZFo33N5
         3N4sXhpPvtVx9TqUxLLolD/FjRW3yGEWsoLqpvhsFTd+2UoWc7lYjui50cu1cWiDRw8c
         x5R+Oxtil4+felqEZIwXF2XW5GycxdzC7fC25K8MpxFRmeKa5xoO4TLBtk3Je9by82Iw
         uzpg==
X-Gm-Message-State: APzg51BE4iIsAvloEBhqITBU+fXlcuMuuf0kw6+2+hSdqcY/j9lz75X6
        kr571pg//giQUBzfpSEXYBXyseCEDHgQnXrCznA6aQ==
X-Google-Smtp-Source: ANB0Vdbt45TH02EJ3lR8PsCrm6TfoeSgivj1JW1ba8xlqpKqT1+2ybrynjB5nlFly0hPnr0Hbj/+hXvkR0CM/GC6qbk=
X-Received: by 2002:a63:6183:: with SMTP id v125-v6mr25876201pgb.242.1535966058571;
 Mon, 03 Sep 2018 02:14:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 3 Sep 2018 02:13:58
 -0700 (PDT)
In-Reply-To: <7387f67e-1ac5-12e1-c9be-060e9c403bf7@lge.com>
References: <1535014606-176525-1-git-send-email-kyeongdon.kim@lge.com> <7387f67e-1ac5-12e1-c9be-060e9c403bf7@lge.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Sep 2018 11:13:58 +0200
Message-ID: <CACT4Y+YGa5riLQavMw4vQ55CeYzakQHSLgEE29RRKi47=J21Ow@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: kasan: add interceptors for strcmp/strncmp functions
To:     Kyeongdon Kim <kyeongdon.kim@lge.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Potapenko <glider@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rob Herring <robh@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 11:02 AM, Kyeongdon Kim <kyeongdon.kim@lge.com> wrot=
e:
> Dear all,
>
> Could anyone review this and provide me appropriate approach ?
> I think str[n]cmp are frequently used functions so I believe very useful =
w/
> arm64 KASAN.

Hi Kyeongdon,

Please add tests for this to lib/test_kasan.c.

> On 2018-08-23 =EC=98=A4=ED=9B=84 5:56, Kyeongdon Kim wrote:
>>
>> This patch declares strcmp/strncmp as weak symbols.
>> (2 of them are the most used string operations)
>>
>> Original functions declared as weak and
>> strong ones in mm/kasan/kasan.c could replace them.
>>
>> Assembly optimized strcmp/strncmp functions cannot detect KASan bug.
>> But, now we can detect them like the call trace below.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> BUG: KASAN: use-after-free in platform_match+0x1c/0x5c at addr
>> ffffffc0ad313500
>> Read of size 1 by task swapper/0/1
>> CPU: 3 PID: 1 Comm: swapper/0 Tainted: G B 4.9.77+ #1
>> Hardware name: Generic (DT) based system
>> Call trace:
>> dump_backtrace+0x0/0x2e0
>> show_stack+0x14/0x1c
>> dump_stack+0x88/0xb0
>> kasan_object_err+0x24/0x7c
>> kasan_report+0x2f0/0x484
>> check_memory_region+0x20/0x14c
>> strcmp+0x1c/0x5c
>> platform_match+0x40/0xe4
>> __driver_attach+0x40/0x130
>> bus_for_each_dev+0xc4/0xe0
>> driver_attach+0x30/0x3c
>> bus_add_driver+0x2dc/0x328
>> driver_register+0x118/0x160
>> __platform_driver_register+0x7c/0x88
>> alarmtimer_init+0x154/0x1e4
>> do_one_initcall+0x184/0x1a4
>> kernel_init_freeable+0x2ec/0x2f0
>> kernel_init+0x18/0x10c
>> ret_from_fork+0x10/0x50
>>
>> In case of xtensa and x86_64 kasan, no need to use this patch now.
>>
>> Signed-off-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
>> ---
>> arch/arm64/include/asm/string.h | 5 +++++
>> arch/arm64/kernel/arm64ksyms.c | 2 ++
>> arch/arm64/kernel/image.h | 2 ++
>> arch/arm64/lib/strcmp.S | 3 +++
>> arch/arm64/lib/strncmp.S | 3 +++
>> mm/kasan/kasan.c | 23 +++++++++++++++++++++++
>> 6 files changed, 38 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/string.h
>> b/arch/arm64/include/asm/string.h
>> index dd95d33..ab60349 100644
>> --- a/arch/arm64/include/asm/string.h
>> +++ b/arch/arm64/include/asm/string.h
>> @@ -24,9 +24,11 @@ extern char *strchr(const char *, int c);
>>
>> #define __HAVE_ARCH_STRCMP
>> extern int strcmp(const char *, const char *);
>> +extern int __strcmp(const char *, const char *);
>>
>> #define __HAVE_ARCH_STRNCMP
>> extern int strncmp(const char *, const char *, __kernel_size_t);
>> +extern int __strncmp(const char *, const char *, __kernel_size_t);
>>
>> #define __HAVE_ARCH_STRLEN
>> extern __kernel_size_t strlen(const char *);
>> @@ -68,6 +70,9 @@ void memcpy_flushcache(void *dst, const void *src,
>> size_t cnt);
>> #define memmove(dst, src, len) __memmove(dst, src, len)
>> #define memset(s, c, n) __memset(s, c, n)
>>
>> +#define strcmp(cs, ct) __strcmp(cs, ct)
>> +#define strncmp(cs, ct, n) __strncmp(cs, ct, n)
>> +
>> #ifndef __NO_FORTIFY
>> #define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
>> #endif
>> diff --git a/arch/arm64/kernel/arm64ksyms.c
>> b/arch/arm64/kernel/arm64ksyms.c
>> index d894a20..10b1164 100644
>> --- a/arch/arm64/kernel/arm64ksyms.c
>> +++ b/arch/arm64/kernel/arm64ksyms.c
>> @@ -50,6 +50,8 @@ EXPORT_SYMBOL(strcmp);
>> EXPORT_SYMBOL(strncmp);
>> EXPORT_SYMBOL(strlen);
>> EXPORT_SYMBOL(strnlen);
>> +EXPORT_SYMBOL(__strcmp);
>> +EXPORT_SYMBOL(__strncmp);
>> EXPORT_SYMBOL(memset);
>> EXPORT_SYMBOL(memcpy);
>> EXPORT_SYMBOL(memmove);
>> diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
>> index a820ed0..5ef7a57 100644
>> --- a/arch/arm64/kernel/image.h
>> +++ b/arch/arm64/kernel/image.h
>> @@ -110,6 +110,8 @@ __efistub___flush_dcache_area =3D
>> KALLSYMS_HIDE(__pi___flush_dcache_area);
>> __efistub___memcpy =3D KALLSYMS_HIDE(__pi_memcpy);
>> __efistub___memmove =3D KALLSYMS_HIDE(__pi_memmove);
>> __efistub___memset =3D KALLSYMS_HIDE(__pi_memset);
>> +__efistub___strcmp =3D KALLSYMS_HIDE(__pi_strcmp);
>> +__efistub___strncmp =3D KALLSYMS_HIDE(__pi_strncmp);
>> #endif
>>
>> __efistub__text =3D KALLSYMS_HIDE(_text);
>> diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
>> index 471fe61..0dffef7 100644
>> --- a/arch/arm64/lib/strcmp.S
>> +++ b/arch/arm64/lib/strcmp.S
>> @@ -60,6 +60,8 @@ tmp3 .req x9
>> zeroones .req x10
>> pos .req x11
>>
>> +.weak strcmp
>> +ENTRY(__strcmp)
>> ENTRY(strcmp)
>> eor tmp1, src1, src2
>> mov zeroones, #REP8_01
>> @@ -232,3 +234,4 @@ CPU_BE( orr syndrome, diff, has_nul )
>> sub result, data1, data2, lsr #56
>> ret
>> ENDPIPROC(strcmp)
>> +ENDPROC(__strcmp)
>> diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
>> index e267044..b2648c7 100644
>> --- a/arch/arm64/lib/strncmp.S
>> +++ b/arch/arm64/lib/strncmp.S
>> @@ -64,6 +64,8 @@ limit_wd .req x13
>> mask .req x14
>> endloop .req x15
>>
>> +.weak strncmp
>> +ENTRY(__strncmp)
>> ENTRY(strncmp)
>> cbz limit, .Lret0
>> eor tmp1, src1, src2
>> @@ -308,3 +310,4 @@ CPU_BE( orr syndrome, diff, has_nul )
>> mov result, #0
>> ret
>> ENDPIPROC(strncmp)
>> +ENDPROC(__strncmp)
>> diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
>> index c3bd520..61ad7f1 100644
>> --- a/mm/kasan/kasan.c
>> +++ b/mm/kasan/kasan.c
>> @@ -304,6 +304,29 @@ void *memcpy(void *dest, const void *src, size_t le=
n)
>>
>> return __memcpy(dest, src, len);
>> }
>> +#ifdef CONFIG_ARM64
>> +/*
>> + * Arch arm64 use assembly variant for strcmp/strncmp,
>> + * xtensa use inline asm operations and x86_64 use c one,
>> + * so now this interceptors only for arm64 kasan.
>> + */
>> +#undef strcmp
>> +int strcmp(const char *cs, const char *ct)
>> +{
>> + check_memory_region((unsigned long)cs, 1, false, _RET_IP_);
>> + check_memory_region((unsigned long)ct, 1, false, _RET_IP_);
>> +
>> + return __strcmp(cs, ct);
>> +}
>> +#undef strncmp
>> +int strncmp(const char *cs, const char *ct, size_t len)
>> +{
>> + check_memory_region((unsigned long)cs, len, false, _RET_IP_);
>> + check_memory_region((unsigned long)ct, len, false, _RET_IP_);
>> +
>> + return __strncmp(cs, ct, len);
>> +}
>> +#endif
>>
>> void kasan_alloc_pages(struct page *page, unsigned int order)
>> {
>> --
>> 2.6.2
>
>
