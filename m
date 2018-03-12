Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbeCLD5R (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 23:57:17 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:18249 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932532AbeCLD5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 23:57:15 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w2C3v9Mu003590
X-Nifty-SrcIP: [209.85.213.44]
X-Google-Smtp-Source: AG47ELtr9GVmpmncFd5ER62Qs8U8t6op3ilIQUrjNR81DpdJ7zalO0cH3gG6j0kaq8dzpRCodrN3ACLoTqh43j5+azw=
MIME-Version: 1.0
In-Reply-To: <CAK7LNATktPPTHDDhS0i=3o8p=XoVXBJ1KB+3VmDp_iqn239Z8g@mail.gmail.com>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com> <CAK7LNATktPPTHDDhS0i=3o8p=XoVXBJ1KB+3VmDp_iqn239Z8g@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 12 Mar 2018 12:56:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT+DVCJ8CbxKYX0yEUdsp-vYU1J+az+yfM9h3-DzoWGgQ@mail.gmail.com>
Message-ID: <CAK7LNAT+DVCJ8CbxKYX0yEUdsp-vYU1J+az+yfM9h3-DzoWGgQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/12] Rewrite asm-generic/bitops/{atomic,lock}.h
 and use on arm64
To: Will Deacon <will.deacon@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,


2018-03-01 16:16 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2018-02-27 0:04 GMT+09:00 Will Deacon <will.deacon@arm.com>:
>> Hi everyone,
>>
>> This is version two of the RFC I previously posted here:
>>
>>   https://www.spinics.net/lists/arm-kernel/msg634719.html
>>
>> Changes since v1 include:
>>
>>   * Fixed __clear_bit_unlock to work on archs with lock-based atomics
>>   * Moved lock ops into bitops/lock.h
>>   * Fixed build breakage on lesser-spotted architectures
>>
>> Trying to fix the circular #includes introduced by pulling atomic.h
>> into btops/lock.h has been driving me insane. I've ended up moving some
>> basic BIT definitions into bits.h, but this might all be better in
>> const.h which is being proposed by Masahiro. Feedback is especially
>> welcome on this part.
>
>
> Info for reviewers:
>
> You can see my patches at the following:
>
> 1/5: https://patchwork.kernel.org/patch/10235457/
> 2/5: https://patchwork.kernel.org/patch/10235461/
> 3/5: https://patchwork.kernel.org/patch/10235463/
> 4/5: https://patchwork.kernel.org/patch/10235469/
> 5/5: https://patchwork.kernel.org/patch/10235471/
>
>
> 5/5 has conflict with Will's 2/12.
>
> Fortunately, it is at the tail of the series.
> It is easy to pick/drop/change
> when we decide how to organize it.


No comments so far about this part.

I think your approach is better
since putting BIT* macros into a single header
is more consistent.

So, I will ask Andrew to drop mine.


However, I think <linux/bits.h> will make more sense
than <asm-generic/bits.h>

These macros are really arch-agnostic.
So, we would not expect to have <asm/bits.h>
that could fall back to <asm-generic/bits.h>, right?




-- 
Best Regards
Masahiro Yamada
