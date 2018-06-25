Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC26C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171942584A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsHxo+nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171942584A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932523AbeFYLr5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:47:57 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45890 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932211AbeFYLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:47:56 -0400
Received: by mail-pg0-f66.google.com with SMTP id z1-v6so5940302pgv.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 04:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OShQhXGM9hvO/OWItHEH/OQ5jP9s+e+JTj0nTxHbA1A=;
        b=tsHxo+nkk2peXXLWKjEXomCdOEdB3ENZarMbzbgJ0tIouxfVC2IQBsRKfZwxkN2ZP3
         XDt9XkJ5ZuKh39GveaVUZ1/ktlw1crTFHT0AvZBaLhYVQAzkiiDUvUfR2goDe83OXn9P
         UswOcwaSEDQWYBqQ0pxkCfOpEIxehQR1j+3BZodIAjH86NwD5SDng8TdRTjhq3hEYMq/
         6uvHCZfT3WuiTaB4gnBbWB5ra+dId3jto8i8th3TzcldsYHYDDcVWL2F68lDxHG8IhXK
         Glenpv33d7xVkhU76vOXu2jGKNXqr01+9s4MzawI4K3Og3AdbQeaTysOzIt9orUGeI6G
         D9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OShQhXGM9hvO/OWItHEH/OQ5jP9s+e+JTj0nTxHbA1A=;
        b=HG0ILUIR1zG/26OuhOVU4yBqz9gjRYj2ByxTOgyA59IIU3NPTT6c4ni8tk07klnmeh
         OZ7CJuj4ovv06lYJ6FIY1xqjgsr6g3lmnr7cMUbiXyp99rsxth2XDoN7AjCHnuMMxES1
         7xkgN/o/AqRYKxwRVUIDnqd31XtDdT/QAFNrrorR5H6TdsyZubD9p0iwRJUCqgWy80Sw
         LAZKwZ/1r6xa7T8vAlgWWE07vrn4Y9ZEaP3X650FwuitpLrOq8Pl69/wGp520JterN1p
         Bi4rPjIZtYyIXtux3QsFyE6rg5PWR4BifAkmICpQ5uN+0yGwM+E78TYn6Ni7fzHhVtCf
         Nibw==
X-Gm-Message-State: APt69E36t0GdJ/e3IZocRGI/EUC8J5enXp3/VLjtKVd7CfQOSWDtBVWz
        5xPaa7Zns61qi1yGgZQold3ZCum6Fb1MkTxAdaT5hw==
X-Google-Smtp-Source: ADUXVKLQyDN3BQbKuHpQulh5MpnJgbSQZ5Yc8gxZjdCjV/MwhJrKGO2ptOByH1f5HLbVB2lWDm/PDOyi2Xmp1zDmlr4=
X-Received: by 2002:a65:4bcd:: with SMTP id p13-v6mr10524995pgr.114.1529927275712;
 Mon, 25 Jun 2018 04:47:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 25 Jun 2018 04:47:35
 -0700 (PDT)
In-Reply-To: <20180625113803.GA13628@andrea>
References: <20180625105952.3756-1-mark.rutland@arm.com> <20180625105952.3756-4-mark.rutland@arm.com>
 <20180625113803.GA13628@andrea>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 Jun 2018 13:47:35 +0200
Message-ID: <CACT4Y+ZjFDt=-1DdWpNsuE68SYXbjki6UHPTzB6+Rv3h=CpbRw@mail.gmail.com>
Subject: Re: [PATCHv2 03/11] atomics: simplify cmpxchg() instrumentation
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 1:38 PM, Andrea Parri
<andrea.parri@amarulasolutions.com> wrote:
> On Mon, Jun 25, 2018 at 11:59:44AM +0100, Mark Rutland wrote:
>> Currently we define some fairly verbose wrappers for the cmpxchg()
>> family so that we can pass a pointer and size into kasan_check_write().
>>
>> The wrapper duplicate the size-switching logic necessary in arch code,
>> and only work for scalar types. On some architectures, (cmp)xchg are
>> used on non-scalar types, and thus the instrumented wrappers need to be
>> able to handle this.
>>
>> We could take the type-punning logic form {READ,WRITE}_ONCE(), but this
>> makes the wrappers even more verbose, and requires several local
>> variables in the macros.
>>
>> Instead, let's simplify the wrappers into simple macros which:
>>
>>  * snapshot the pointer into a single local variable, called __ai_ptr to
>>    avoid conflicts with variables in the scope of the caller.
>>
>>  * call kasan_check_read() on __ai_ptr.
>
> Maybe I'm misreading the diff: aren't you calling kasan_check_write()?
> (not sure if it makes a difference in this case/for KTSan, but CMPXCHG
> does not necessarily perform a write...)


KTSan will most likely use own instrumentation. For KTSan we need some
operations on metadata be atomic with the atomic operation itself, and
potentially KTSan will even alter the returned value (to produce more
artifacts of relaxed memory models). But what we need from this effort
is a clear single place to insert such instrumentation.


>>  * invoke the arch_ function, passing the original arguments, bar
>>    __ai_ptr being substituted for ptr.
>>
>> There should be no functional change as a result of this patch.
>>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>  include/asm-generic/atomic-instrumented.h | 100 +++++-------------------------
>>  1 file changed, 15 insertions(+), 85 deletions(-)
>>
>> diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
>> index 3c64e95d5ed0..c7c3e4cdd942 100644
>> --- a/include/asm-generic/atomic-instrumented.h
>> +++ b/include/asm-generic/atomic-instrumented.h
>> @@ -408,109 +408,39 @@ static __always_inline bool atomic64_add_negative(s64 i, atomic64_t *v)
>>  }
>>  #endif
>>
>> -static __always_inline unsigned long
>> -cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new, int size)
>> -{
>> -     kasan_check_write(ptr, size);
>> -     switch (size) {
>> -     case 1:
>> -             return arch_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
>> -     case 2:
>> -             return arch_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
>> -     case 4:
>> -             return arch_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
>> -     case 8:
>> -             BUILD_BUG_ON(sizeof(unsigned long) != 8);
>> -             return arch_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
>> -     }
>> -     BUILD_BUG();
>> -     return 0;
>> -}
>> -
>>  #define cmpxchg(ptr, old, new)                                               \
>>  ({                                                                   \
>> -     ((__typeof__(*(ptr)))cmpxchg_size((ptr), (unsigned long)(old),  \
>> -             (unsigned long)(new), sizeof(*(ptr))));                 \
>> +     typeof(ptr) __ai_ptr = (ptr);                                   \
>> +     kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));                 \
>> +     arch_cmpxchg(__ai_ptr, (old), (new));                           \
>>  })
>>
>> -static __always_inline unsigned long
>> -sync_cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new,
>> -               int size)
>> -{
>> -     kasan_check_write(ptr, size);
>> -     switch (size) {
>> -     case 1:
>> -             return arch_sync_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
>> -     case 2:
>> -             return arch_sync_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
>> -     case 4:
>> -             return arch_sync_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
>> -     case 8:
>> -             BUILD_BUG_ON(sizeof(unsigned long) != 8);
>> -             return arch_sync_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
>> -     }
>> -     BUILD_BUG();
>> -     return 0;
>> -}
>> -
>>  #define sync_cmpxchg(ptr, old, new)                                  \
>>  ({                                                                   \
>> -     ((__typeof__(*(ptr)))sync_cmpxchg_size((ptr),                   \
>> -             (unsigned long)(old), (unsigned long)(new),             \
>> -             sizeof(*(ptr))));                                       \
>> +     typeof(ptr) __ai_ptr = (ptr);                                   \
>> +     kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));                 \
>> +     arch_sync_cmpxchg(__ai_ptr, (old), (new));                      \
>>  })
>>
>> -static __always_inline unsigned long
>> -cmpxchg_local_size(volatile void *ptr, unsigned long old, unsigned long new,
>> -                int size)
>> -{
>> -     kasan_check_write(ptr, size);
>> -     switch (size) {
>> -     case 1:
>> -             return arch_cmpxchg_local((u8 *)ptr, (u8)old, (u8)new);
>> -     case 2:
>> -             return arch_cmpxchg_local((u16 *)ptr, (u16)old, (u16)new);
>> -     case 4:
>> -             return arch_cmpxchg_local((u32 *)ptr, (u32)old, (u32)new);
>> -     case 8:
>> -             BUILD_BUG_ON(sizeof(unsigned long) != 8);
>> -             return arch_cmpxchg_local((u64 *)ptr, (u64)old, (u64)new);
>> -     }
>> -     BUILD_BUG();
>> -     return 0;
>> -}
>> -
>>  #define cmpxchg_local(ptr, old, new)                                 \
>>  ({                                                                   \
>> -     ((__typeof__(*(ptr)))cmpxchg_local_size((ptr),                  \
>> -             (unsigned long)(old), (unsigned long)(new),             \
>> -             sizeof(*(ptr))));                                       \
>> +     typeof(ptr) __ai_ptr = (ptr);                                   \
>> +     kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));                 \
>> +     arch_cmpxchg_local(__ai_ptr, (old), (new));                     \
>>  })
>>
>> -static __always_inline u64
>> -cmpxchg64_size(volatile u64 *ptr, u64 old, u64 new)
>> -{
>> -     kasan_check_write(ptr, sizeof(*ptr));
>> -     return arch_cmpxchg64(ptr, old, new);
>> -}
>> -
>>  #define cmpxchg64(ptr, old, new)                                     \
>>  ({                                                                   \
>> -     ((__typeof__(*(ptr)))cmpxchg64_size((ptr), (u64)(old),          \
>> -             (u64)(new)));                                           \
>> +     typeof(ptr) __ai_ptr = (ptr);                                   \
>> +     kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));                 \
>> +     arch_cmpxchg64(__ai_ptr, (old), (new));                         \
>>  })
>>
>> -static __always_inline u64
>> -cmpxchg64_local_size(volatile u64 *ptr, u64 old, u64 new)
>> -{
>> -     kasan_check_write(ptr, sizeof(*ptr));
>> -     return arch_cmpxchg64_local(ptr, old, new);
>> -}
>> -
>>  #define cmpxchg64_local(ptr, old, new)                                       \
>>  ({                                                                   \
>> -     ((__typeof__(*(ptr)))cmpxchg64_local_size((ptr), (u64)(old),    \
>> -             (u64)(new)));                                           \
>> +     typeof(ptr) __ai_ptr = (ptr);                                   \
>> +     kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));                 \
>> +     arch_cmpxchg64_local(__ai_ptr, (old), (new));                   \
>>  })
>>
>>  /*
>> --
>> 2.11.0
>>
