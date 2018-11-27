Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECE2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D04021104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ukloI+yI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D04021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeK1DCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:02:48 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52230 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbeK1DCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:02:48 -0500
Received: by mail-it1-f196.google.com with SMTP id i7so35005035iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=33GOBKEvyV4rGfBRlWYpwFsQUZViulrxDDjf9gGtxiw=;
        b=ukloI+yIJMcyVZEoRVubH18W6bwzEBUFRAzzATYrs5hHYwgXKotyACivDOUQikDqtV
         GdSxMe6shQzd98cd0qYGTQcG60anvLjOfwdRVyULaDpryjm1nlesPC6Q/4JOeHvSPgM3
         8qREBKXyDOVsuM9ci0XQRmQ5BvXbO8ILkq9QRVjgDFCtCDKb4ErjxTTjtU2CObZCVBxn
         u5vXqEooPTn0Xu8yxXeyFiYoOQDNs60NHz5lV19t9ie1VNZXTamMzETd283zwsiBfweX
         WIvValxJoABHuikAGW2eH8yf8ZLOTNMPyzuS26IdcWOGDsg+TK9df2yDXg/TBj5TSV4u
         yK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=33GOBKEvyV4rGfBRlWYpwFsQUZViulrxDDjf9gGtxiw=;
        b=EhwAQ4RtAa0EY3yTZ9bKQcxjY1KLnJ8X1j81H+UxJe8LARuiC6wIf2QHcc9xC0+BbJ
         NF1LHcftkJn+s4Bsygq38GOjQgrrNA/aP1bCKfCrUwAJZLjnb2ZNq6eBv9EPu5w5a2XC
         1EKCcRKExsq7sUFtC7M5s8xoPvD/FObe+4RKkbECMBpvRvKhe/EzWq8mIigJ+kgXqNzy
         bc+R+nr3Sc26+5DfP7eNcK1ihXBUDDP4Ap9rkP9XkDYD/RrQMzbI7RWMB5XEl4YaLZqX
         wc8n13jr2zif+VGdqsiwJq5+7IKVyHrsp1Cspssm/sCBkdOTj4plii3AjxdVx2oe9JyN
         Xvdg==
X-Gm-Message-State: AGRZ1gKucsSfa+5Bcqhab6JwngW8oq+no769RwI+ctub02GSiD9i4KZv
        y8DHHa1panXNQCDpXlWsFNB+5yyJzQdwCL6QLgoDgA==
X-Google-Smtp-Source: AFSGD/XS/kSgoWsACK49X5irY5p0dFNv/k9IN4hZeu0XKD0E3A0LlTEngS5zb2qpn/9R8JsVpd+5gC2kx4LiUqY2Xzc=
X-Received: by 2002:a02:4f88:: with SMTP id r8mr29584514jad.69.1543334665077;
 Tue, 27 Nov 2018 08:04:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:7050:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 08:04:24
 -0800 (PST)
In-Reply-To: <20181123173739.osgvnnhmptdgtlnl@lakrids.cambridge.arm.com>
References: <cover.1542648335.git.andreyknvl@google.com> <0288334225edc99d98d70c896494e19c3bd9361a.1542648335.git.andreyknvl@google.com>
 <20181123173739.osgvnnhmptdgtlnl@lakrids.cambridge.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 27 Nov 2018 17:04:24 +0100
Message-ID: <CAAeHK+xgmM9Fs2Yw8Cv8zGhz_hg6G31uhHabudibj7wszmCVAw@mail.gmail.com>
Subject: Re: [PATCH v11 09/24] arm64: move untagged_addr macro from uaccess.h
 to memory.h
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

On Fri, Nov 23, 2018 at 6:37 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Nov 19, 2018 at 06:26:25PM +0100, Andrey Konovalov wrote:
>> Move the untagged_addr() macro from arch/arm64/include/asm/uaccess.h
>> to arch/arm64/include/asm/memory.h to be later reused by KASAN.
>>
>> Also make the untagged_addr() macro accept all kinds of address types
>> (void *, unsigned long, etc.). This allows not to specify type casts in
>> each place where the macro is used. This is done by using __typeof__.
>>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> ---
>>  arch/arm64/include/asm/memory.h  | 8 ++++++++
>>  arch/arm64/include/asm/uaccess.h | 7 -------
>>  2 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 05fbc7ffcd31..deb95be44392 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -73,6 +73,14 @@
>>  #define KERNEL_START      _text
>>  #define KERNEL_END        _end
>>
>> +/*
>> + * When dealing with data aborts, watchpoints, or instruction traps we may end
>> + * up with a tagged userland pointer. Clear the tag to get a sane pointer to
>> + * pass on to access_ok(), for instance.
>> + */
>> +#define untagged_addr(addr)  \
>> +     (__typeof__(addr))sign_extend64((__u64)(addr), 55)
>
> Minor nits:
>
> * s/__u64/u64/ (or s/__u64/unsigned long/), since this isn't a UAPI
>   header.
>
> * Please move this down into the #ifndef __ASSEMBLY__ block, after we
>   include <linux/bitops.h>, which is necessary for sign_extend64().
>
> With those fixed up, this patch looks sound to me:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Thanks,
> Mark.

Will do in v12, thanks!

>
>> +
>>  /*
>>   * Generic and tag-based KASAN require 1/8th and 1/16th of the kernel virtual
>>   * address space for the shadow region respectively. They can bloat the stack
>> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
>> index 07c34087bd5e..281a1e47263d 100644
>> --- a/arch/arm64/include/asm/uaccess.h
>> +++ b/arch/arm64/include/asm/uaccess.h
>> @@ -96,13 +96,6 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>>       return ret;
>>  }
>>
>> -/*
>> - * When dealing with data aborts, watchpoints, or instruction traps we may end
>> - * up with a tagged userland pointer. Clear the tag to get a sane pointer to
>> - * pass on to access_ok(), for instance.
>> - */
>> -#define untagged_addr(addr)          sign_extend64(addr, 55)
>> -
>>  #define access_ok(type, addr, size)  __range_ok(addr, size)
>>  #define user_addr_max                        get_fs
>>
>> --
>> 2.19.1.1215.g8438c0b245-goog
>>
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20181123173739.osgvnnhmptdgtlnl%40lakrids.cambridge.arm.com.
> For more options, visit https://groups.google.com/d/optout.
