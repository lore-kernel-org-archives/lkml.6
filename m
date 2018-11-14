Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6BCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADD222360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UhfwkhJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADD222360
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbeKOF2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:28:23 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33999 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeKOF2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:28:21 -0500
Received: by mail-io1-f65.google.com with SMTP id f6so9573088iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 11:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UIypac4ruDkdL3VYH/D4DbUQPZdrBjhLGF9jWBRcd+E=;
        b=UhfwkhJ0MLEDXZfrgYDYr0qYlDs34flhmy6j/n8egOKueqFTnjm8LTvXy5zmbNuzZW
         595JYsms5DC9MoiadOQcG+t4Re+oCHGmT0jUGRY1APD1qO/IVtSQvkpoXd+hsfeCvPXO
         sSqE2KvTpwsHUSJ8m/TCY3c5xgCA3fzSa0lXZz7mNI7amLmwa+H9d3AFgf+a0nwDqnCH
         Hk77Hd0S3CPzKl8wqUfzFWUXDP41Z73mpeY6lw/dRDq1dpNlu+NZxtUzo1iHJ46iWhvX
         P0kjFtOc0L7STP8JjTEVP+Fflk4CubNn55vc5Hl5dkSb5OMLFKWlqTsUb560LxkoL7op
         Fjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UIypac4ruDkdL3VYH/D4DbUQPZdrBjhLGF9jWBRcd+E=;
        b=K+TelZQiL0tbqtMheRkLq4aPPUMASQp+JGBSR8UdOPdRziM+Y+reJIk2hZ785YCw0/
         WC/s1iT0BGWOzQ/ocWYtGkO6ACdPg8+K8oeOuroji0h4KviFhgK0OuDxObp+scSBzn6F
         0/7/LYVCYqqr6L7BJNSDhhPAevbta1RSZPCDn2BLXYF79KzbxyXYPCCcEQWeLxLNSlPf
         pfD9OROqqUjilyWTOFCe8EoQSCVudBS1vZDLSp8X+Uq30eBP5QbPxbAlJOpoxuVFRmEy
         BGKiDaPzHkBPCfLnX2k/SC86UV5Z2twlPTRxbHDAUhcQ/CA0fiz1SLp/5v1AgsBxBKbt
         fL5w==
X-Gm-Message-State: AA+aEWb/XL+eMuFyGlGy8ImPFrE9LJjFHt9QXiCZdE2qb20DJDNWXMFy
        n3AZwtlYjWc6bQsp39Y+QvrzfGgI9srSJ75JWgU+Xw==
X-Google-Smtp-Source: AFSGD/XZMONoeGiABjx40NHOI1Wyk1KqyUGd5QioHZNkjeYYrG3oQJMONgNZF1m6qv5Kk55V7tIoktJIKbYzLT75Tjk=
X-Received: by 2002:a6b:c0c6:: with SMTP id q189-v6mr2726537iof.31.1542223431211;
 Wed, 14 Nov 2018 11:23:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:7050:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 11:23:50
 -0800 (PST)
In-Reply-To: <20181107165200.oaou6cx2lmjzmjyl@lakrids.cambridge.arm.com>
References: <cover.1541525354.git.andreyknvl@google.com> <b2aa056b65b8f1a410379bf2f6ef439d5d99e8eb.1541525354.git.andreyknvl@google.com>
 <20181107165200.oaou6cx2lmjzmjyl@lakrids.cambridge.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 14 Nov 2018 20:23:50 +0100
Message-ID: <CAAeHK+yAve4fBg_UZQsNdVJ5W-7v8tQnRa=amQMyBeE_yHcq5g@mail.gmail.com>
Subject: Re: [PATCH v10 08/22] kasan, arm64: untag address in __kimg_to_phys
 and _virt_addr_is_linear
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 5:52 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Andrey,
>
> On Tue, Nov 06, 2018 at 06:30:23PM +0100, Andrey Konovalov wrote:
>> __kimg_to_phys (which is used by virt_to_phys) and _virt_addr_is_linear
>> (which is used by virt_addr_valid) assume that the top byte of the address
>> is 0xff, which isn't always the case with tag-based KASAN.
>
> I'm confused by this. Why/when do kimg address have a non-default tag?
>
> Any kimg address is part of the static kernel image, so it's not obvious
> to me how a kimg address would gain a tag. Could you please explain how
> this happens in the commit message?

If kimg address always points into the kernel image, then it shouldn't
be tagged, and this can be removed.

>
>> This patch resets the tag in those macros.
>>
>> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> ---
>>  arch/arm64/include/asm/memory.h | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 0f1e024a951f..3226a0218b0b 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -92,6 +92,15 @@
>>  #define KASAN_THREAD_SHIFT   0
>>  #endif
>>
>> +#ifdef CONFIG_KASAN_SW_TAGS
>> +#define KASAN_TAG_SHIFTED(tag)               ((unsigned long)(tag) << 56)
>> +#define KASAN_SET_TAG(addr, tag)     (((addr) & ~KASAN_TAG_SHIFTED(0xff)) | \
>> +                                             KASAN_TAG_SHIFTED(tag))
>> +#define KASAN_RESET_TAG(addr)                KASAN_SET_TAG(addr, 0xff)
>> +#else
>> +#define KASAN_RESET_TAG(addr)                addr
>> +#endif
>
> Nit: the rest of the helper macros in this file are lower-case, with
> specialised helpers prefixed with several underscores. Could we please
> stick with that convention?
>
> e.g. have __tag_set() and __tag_reset() helpers.

Will do in v11.

>
>> +
>>  #define MIN_THREAD_SHIFT     (14 + KASAN_THREAD_SHIFT)
>>
>>  /*
>> @@ -232,7 +241,7 @@ static inline unsigned long kaslr_offset(void)
>>  #define __is_lm_address(addr)        (!!((addr) & BIT(VA_BITS - 1)))
>>
>>  #define __lm_to_phys(addr)   (((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
>> -#define __kimg_to_phys(addr) ((addr) - kimage_voffset)
>> +#define __kimg_to_phys(addr) (KASAN_RESET_TAG(addr) - kimage_voffset)
>
> IIUC You need to adjust __lm_to_phys() too, since that could be passed
> an address from SLAB.
>
> Maybe that's done in a later patch, but if so it's confusing to split it
> out that way. It would be nicer to fix all the *_to_*() helpers in one
> go.

__lm_to_phys() does & ~PAGE_OFFSET, so it resets the tag by itself. I
can add an explicit __tag_reset() if you think it makes sense.

>
>>
>>  #define __virt_to_phys_nodebug(x) ({                                 \
>>       phys_addr_t __x = (phys_addr_t)(x);                             \
>> @@ -308,7 +317,8 @@ static inline void *phys_to_virt(phys_addr_t x)
>>  #endif
>>  #endif
>>
>> -#define _virt_addr_is_linear(kaddr)  (((u64)(kaddr)) >= PAGE_OFFSET)
>> +#define _virt_addr_is_linear(kaddr)  (KASAN_RESET_TAG((u64)(kaddr)) >= \
>> +                                             PAGE_OFFSET)
>
> This is painful to read. Could you please split this like:
>
> #define _virt_addr_is_linear(kaddr) \
>         (__tag_reset((u64)(kaddr)) >= PAGE_OFFSET)
>
> ... and we could reformat virt_addr_valid() in the same way while we're
> at it.

Will do in v11.

Thanks!
