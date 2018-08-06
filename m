Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48D6C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F419121A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JrOQv4d2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F419121A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeHFMpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:45:54 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33604 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeHFMpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:45:54 -0400
Received: by mail-io0-f196.google.com with SMTP id z20-v6so10610935iol.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OVABg6LaOGynj3/U/gZiqgbenToN7RJcWa5nPWA9ZlQ=;
        b=JrOQv4d23+IqR7/mUVSjIFga6Uz5pG5+SjXkOzxyBGIP6NK9VF/QvYpLuTjPiz2Qg2
         RFih8uTdKUI7Y4qq7YMsHmbg3w1Ag5Su664a4URp5pGQxsMu0cQf8ziBvGpeUZQmzW3a
         WMRHJKOy6g89hljLT+JWxTCzT4xdtEi9rH3nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OVABg6LaOGynj3/U/gZiqgbenToN7RJcWa5nPWA9ZlQ=;
        b=Mpjhbh6ps/w/hOOxGpwbuWh9YgkMlQ94meug5ekDwfuo2zMYXj2/ElUg6TyCnoLjdB
         CqkWpw6eVCvLJWBkx0Wpc5gqY1PenA/Jj+hTrySmOOYJRX8+WcajxsQrFJvLjMyGcPJF
         1CvvjMB7eGiVtGPwP3qEpbdxmSh5mRq9Qcl8q7/2CowpNY4WMlA0oyDrgdJZV5mlWA25
         VUtAFE8B3ss811qpsdgFjBZUAVH5VJAuZ/q1g6rXAtn9hq5yqkFToDxylp8+u2smKPwV
         XIcVtu3CEjnTmFh73/Pl2nEVxO4w2AYmK/GJG3Pvo0AFcDCxE9ahaPYBIUUxluEsP7/f
         0HbQ==
X-Gm-Message-State: AOUpUlESK/U6WIIG9kXc+hduXe26aHib4wEZSLNM2KlQEDmyEaiqWBZs
        Mmyto/Zua5mA56PC+Z6T+40w8whkzVOeXsQ3qLNVIw==
X-Google-Smtp-Source: AA+uWPzofA1qpWj0A5kM9iKj5B0Ra751E/X9jnpHBMo6XNW4VRAiWm1wnnggMXKUOU/rQWN4iqKcMoNOMpclSamUmWA=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr14479342iof.173.1533551847581;
 Mon, 06 Aug 2018 03:37:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 03:37:26 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.02.1808060626060.2986@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com> <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com> <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
 <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com> <alpine.LRH.2.02.1808060325110.3756@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_y6La77sWOSROrwfRy65jrFVYVvRZt+ewNheYhdhHCkQ@mail.gmail.com> <alpine.LRH.2.02.1808060626060.2986@file01.intranet.prod.int.rdu2.redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 6 Aug 2018 12:37:26 +0200
Message-ID: <CAKv+Gu87YqLM=FFZ6V8rHhuhskDdsBUuXFpqNKVbXWqdnuNEyA@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Andrew Pinski <pinskia@gmail.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 August 2018 at 12:31, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
> On Mon, 6 Aug 2018, Ard Biesheuvel wrote:
>
>> On 6 August 2018 at 10:02, Mikulas Patocka <mpatocka@redhat.com> wrote:
>> >
>> >
>> > On Sun, 5 Aug 2018, Florian Weimer wrote:
>> >
>> >> On 08/04/2018 01:04 PM, Mikulas Patocka wrote:
>> >> > There's plenty of memcpy's in the graphics stack. No one will be rewriting
>> >> > all the graphics drivers because of tiny market share that ARM has in
>> >> > desktop computers. So if you refuse to fix things and blame everyone else,
>> >> > you can as well announce that you don't want to have PCIe graphics on ARM
>> >> > at all.
>> >>
>> >> The POWER toolchain maintainers said pretty much the same thing not too
>> >> long ago. I wonder how many architectures need to fail until the
>> >> graphics stack is finally fixed.
>> >>
>> >> Thanks,
>> >> Florian
>> >
>> > If you say that your architecture doesn't support unaligned accesses at
>> > all, there's no problem - the compiler won't generate them and the libc
>> > won't contain them.
>> >
>> > But if you say that your architecture supports unaligned accesses except
>> > for the framebuffer, then you have a problem - the compiler can't know
>> > which pointers point to the framebuffer and libc can't know either - you
>> > caused this problem by your architectural decision.
>> >
>> > You can use 'volatile' to suppress memory optimizations, but it's
>> > impossible to go through the whole Linux graphics stack and add volatile
>> > to every pointer that may point to videoram. Even if you succeesed, new
>> > videoram accesses without volatile will appear after a year of
>> > development.
>> >
>> > See for example the macros READ_ONCE and WRITE_ONCE in Linux kernel - they
>> > should be used when there's concurrent access to the particular variable,
>> > but mainstream architectures don't require them, so many kernel developers
>> > are omitting them in their code.
>> >
>> > If you are building a supercomputer with a particular GPU, you can force
>> > the GPU vendor to provide POWER-compliant drivers. If you are building a
>> > workstation where the user can plug any GPU, forcing developers will go
>> > nowhere. You have to emulate the unaligned accesses and make sure that the
>> > next versions of your architecture support them in hardware.
>> >
>>
>> I have the feeling this discussion is going off the rails again.
>>
>> The original report is about corruption when doing overlapping writes.
>> Matt Sealey said you cannot have PCI outbound windows with memory
>> semantics on ARM, and so you should be using device mappings (which do
>> not tolerate unaligned accesses)
>>
>> In this context, 'device mapping' does not mean 'any non-DRAM region',
>> but it refers to a particular type of MMU mapping attribute defined by
>> the ARM architecture.
>>
>> I think we can all agree that memcpy() should be usable on any region
>> of memory that has true memory semantics, even if it is backed by VRAM
>> on a graphics card.
>>
>> The question is if PCIe can provide such regions on ARM.
>
> I think there are three possible solutions:
>
> 1. provide an alternative memcpy implementation that doesn't do unaligned
> accesses and recompile the graphics software with -mstrict-align
>
> 2. map the PCI BAR as device memory and emulate the unaligned instructions
>
> 3. find some hardware workaround that could insert delays between the PCIe
> accesses (but the hardware engineers need to cooperate on this instead of
> asserting that they refuse tu support it)
>

Are we talking about a quirk for the Armada 8040 or about PCIe on ARM
in general?

If the latter, I still haven't seen an explanation why the particulars
of AMBA justify overlapped writes being dropped at will by the
interconnect.
