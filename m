Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C799C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EEE204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPmPSqDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EEE204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966388AbeFSNfK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:35:10 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35691 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965952AbeFSNfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:35:08 -0400
Received: by mail-io0-f196.google.com with SMTP id u4-v6so227969iof.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 06:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HQ2HmJP+ZrngJm5BDh5lrsvl2yVPl0RmjWo0X4XmFfM=;
        b=bPmPSqDdr4NU9kRUXH0UtUIMPKy3jORN8IaBSK+baxhrJirVFqoXWhaVRqQs188gdG
         Uk5Lhj2dtz9lkv6trfd6o6qEQb35pCTR7IQvpc10m8z3KCmHiJxt47KoTG4Vbmb8qclI
         6cp7RhGudf2Mg4EiTUsphncaxJ3Yjl/uYs/ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HQ2HmJP+ZrngJm5BDh5lrsvl2yVPl0RmjWo0X4XmFfM=;
        b=U5vg7QJGuQdnsYNi4AdqPKGpyzp4WLrzxUL0NXb7Vq0EyGyyj18tUv8IvcE2n25bnS
         LvoCrDGhWRD7K23aAbdX3tzy+eE7nMZ2p5P3Bj7lKn3y9LDwGEH5Hx/vGPWppivV7oWr
         eR06RhSSMw5VpXhkDpqSZ5tQImFfO1bYy+acrHgX1eb5AcSfWMb/2SG5wIQjPJsy23h3
         HzCLk77cWMsGLziTkcJhh2aHP0d0LD9i3YJxJ1noK3DExB2VJHwF4/l6UlKz+bJm+XpV
         vT8rERrlkzYMhwBt5QDgI7Ihb+yKAK5H3YzFN6W5zluDddkPF3difwFdJkE/IxJxpC7x
         lTHg==
X-Gm-Message-State: APt69E2cbqzWNIonqgWnz6N/IStEhfbwSP4Zfzi/hhZekT7daRWx9/Wr
        TNpqZV5boPh7z0INPsVwT9FURwtydSnw9tk7fEEbKQ==
X-Google-Smtp-Source: ADUXVKIsisWwQN1LXYmMA/1lVu/q+jFk1NgyMZRwU/TF2RX48qvfy5EQ/PQiTvyNy4xxgSe1iDOvOkv1Mo5+gEI+0oo=
X-Received: by 2002:a6b:dd0b:: with SMTP id f11-v6mr13383298ioc.173.1529415308018;
 Tue, 19 Jun 2018 06:35:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 06:35:07
 -0700 (PDT)
In-Reply-To: <b8bff03d-91a7-0e53-a44e-d1924beb382d@roeck-us.net>
References: <1529384828-2452-1-git-send-email-linux@roeck-us.net>
 <CAKv+Gu8Byj7G3Awnq4Y90Wot=GJTx0gO5A7-960au9ZkBBL2=A@mail.gmail.com> <b8bff03d-91a7-0e53-a44e-d1924beb382d@roeck-us.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 19 Jun 2018 15:35:07 +0200
Message-ID: <CAKv+Gu-T8Fx3Nry7pUdOoOeRU-Ns89w3oo4itmu1q4FzYF5Rag@mail.gmail.com>
Subject: Re: [RFC PATCH] ARM: Use logical or instead of addition for badr
 address calculation
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 June 2018 at 15:29, Guenter Roeck <linux@roeck-us.net> wrote:
> Hi Ard,
>
>
> On 06/19/2018 12:48 AM, Ard Biesheuvel wrote:
>>
>> On 19 June 2018 at 07:07, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> Modern assemblers may take the ISA into account when resolving local
>>> symbols. This can result in bad address calculations when using badr
>>> in the wrong location since the offset + 1 may be added twice, resulting
>>> in an even address target for THUMB instructions. This in turn results
>>> in an exception at (destination address + 2).
>>>
>>> Unhandled exception: IPSR = 00000006 LR = fffffff1
>>> CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00026-gf773e5bdf0c9 #15
>>> Hardware name: MPS2 (Device Tree Support)
>>> PC is at ret_fast_syscall+0x2/0x58
>>> LR is at tty_ioctl+0x2a5/0x528
>>> pc : [<21009002>]    lr : [<210d1535>]    psr: 4000000b
>>> sp : 21825fa8  ip : 0000001c  fp : 21a95892
>>> r10: 00000000  r9 : 21824000  r8 : 210091c0
>>> r7 : 00000036  r6 : 21ae1ee0  r5 : 00000000  r4 : 21ae1f3c
>>> r3 : 00000000  r2 : 3d9adc25  r1 : 00000000  r0 : 00000000
>>> xPSR: 4000000b
>>> CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00026-gf773e5bdf0c9 #15
>>> Hardware name: MPS2 (Device Tree Support)
>>> [<2100bd8d>] (unwind_backtrace) from [<2100b13b>] (show_stack+0xb/0xc)
>>> [<2100b13b>] (show_stack) from [<2100b87b>] (__invalid_entry+0x4b/0x4c)
>>>
>>> Fix the problem by using a logical or instead of an addition. This is
>>> less efficient but guaranteed to work.
>>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> RFC: I don't really like this, but my ARM assembler knowledge is quite
>>> limited. Just dropping the "+ 1" from badr doesn't work because some
>>> other code needs it (the image hangs completely if I try that).
>>> Ultimately I don't even know if the invoke_syscall macro should just
>>> have used adr instead of badr (but then how did this ever work ?).
>>>
>>> Seen with various toolchains based on gcc 7.x and binutils 2.30 when
>>> building and testing MPS2 images.
>>>
>>
>> Hello Guenter,
>>
>> This issue has been discussed before. It appears the binutils people
>> suddenly started caring about the thumb annotation of local function
>> symbols, resulting in behavior that is not backwards compatible.
>>
>> https://marc.info/?l=linux-arm-kernel&m=151143776213636&w=2
>> https://sourceware.org/bugzilla/show_bug.cgi?id=21458
>>
>> Can you try the fix below please?
>>
>>>   arch/arm/include/asm/assembler.h | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/include/asm/assembler.h
>>> b/arch/arm/include/asm/assembler.h
>>> index 0cd4dccbae78..24c87ff2060f 100644
>>> --- a/arch/arm/include/asm/assembler.h
>>> +++ b/arch/arm/include/asm/assembler.h
>>> @@ -195,7 +195,8 @@
>>>          .irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
>>>          .macro  badr\c, rd, sym
>>>   #ifdef CONFIG_THUMB2_KERNEL
>>> -       adr\c   \rd, \sym + 1
>>> +       adr\c   \rd, \sym
>>> +       orr     \rd, #1
>>>   #else
>>>          adr\c   \rd, \sym
>>>   #endif
>>> --
>>> 2.7.4
>>
>>
>> ----------8<------------
>> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Date: Tue, 16 Jan 2018 12:12:45 +0000
>> Subject: [PATCH] ARM: assembler: prevent ADR from setting the Thumb bit
>> twice
>>
>> To work around recent issues where ADR references to Thumb function
>> symbols may or may not have the Thumb bit set already when they are
>> resolved by GAS, reference the symbol indirectly via a local symbol
>> typed as 'object', stripping the ARM/Thumb annotation.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> diff --git a/arch/arm/include/asm/assembler.h
>> b/arch/arm/include/asm/assembler.h
>> index 6ae42ad29518..dd2ff94ad90b 100644
>> --- a/arch/arm/include/asm/assembler.h
>> +++ b/arch/arm/include/asm/assembler.h
>> @@ -195,13 +195,19 @@
>>          .irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
>>          .macro  badr\c, rd, sym
>>   #ifdef CONFIG_THUMB2_KERNEL
>> -       adr\c   \rd, \sym + 1
>> +       __badr  \c, \rd, \sym
>>   #else
>>          adr\c   \rd, \sym
>>   #endif
>>          .endm
>>          .endr
>>
>> +       /* this needs to be a separate macro or \@ does not work correctly
>> */
>> +       .macro  __badr, c, rd, sym
>> +       .eqv    .Lsym\@, \sym
>> +       adr\c   \rd, .Lsym\@ + 1
>
>
> Wild shot, but the following works for me.
>
>         .eqv    .Lsym\@, \sym + 1
>         adr\c   \rd, .Lsym\@
>
> Does it make sense ?
>

Interesting. Do you mean this works with your 2.30 binutils that
triggers the original issue?

If so, then yes, it makes sense, although it still seems fragile,
since we are relying on \sym being resolved without the Thumb bit in
the context of the .eqv pseudo op. But if this works across all
implementations we care about, I would be fine with it.

Russell?
