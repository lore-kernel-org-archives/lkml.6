Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F566C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D5621566
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2TDMlJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D5621566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeHFKSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:18:17 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36145 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeHFKSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:18:16 -0400
Received: by mail-it0-f67.google.com with SMTP id p81-v6so16950043itp.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TcZmq5IIRJPxefKxlqnR0Uf+yS6l8Knm7KUwDdoIH4U=;
        b=V2TDMlJ1n9brYekclqJGPgg4ovKQu0xxMJdrd4Kqblrot9qNjOPj2IhA9C3FXYGFvL
         VwFllcXmh0W7xvUNJCPCehuivQkJrVTs5FOzjwGlO4H6AWitjJ5EyAVYv+7MOB5G70rV
         bWPkulTMQs99XKHE8XeQCTaRJrKNwpF3eHbUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TcZmq5IIRJPxefKxlqnR0Uf+yS6l8Knm7KUwDdoIH4U=;
        b=KX9us5mB+8RsJLnxFS5dP1ZBS770t5MB7QI6fwE8bgzeluz2XMAZbxK3O2mpSr4g4R
         NxNVtmeMc+NbbP3y4Rpka59psGFAW1pAq9Gw+Py9F9wvN154oVR3IPHIXSwrvH2jUcek
         qB1xwYpgDE0KHw4ySrhilG1oXrJHRi6WRMptwtNS9K/2aesiyd4BBS8QFar5+qCjvk5+
         skNFbMlqOYTG9wmpNkxCa7U8DmJfBwBBmpu+h+D2KvofWeLP/pSmo6LKCntRa+sEHY+j
         XLKjIOs1iaYHq73IRiINvuA+25fjU6d1Wdmo151amhx362g0OdAt40tmjxlOohizJct7
         MOVw==
X-Gm-Message-State: AOUpUlG1J8a5pgLRRpl9cOFzx4V7HXclBx36uC0vIE7CqBbZWjbiHiL3
        HPlboNwsXuuvVaB8qEM1UqfFa61fT+oPlCrxMETXdg==
X-Google-Smtp-Source: AAOMgpcrybtIxDWqqxObRWcEc3qEFAUTYKSSKLK6YdYWjAyxFkc/upeygSxrpqpyVNB5QYqrVM/rElSFd7mSfPDVdto=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr14507155itc.68.1533543023514;
 Mon, 06 Aug 2018 01:10:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 01:10:22 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.02.1808060325110.3756@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com> <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com> <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
 <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com> <alpine.LRH.2.02.1808060325110.3756@file01.intranet.prod.int.rdu2.redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 6 Aug 2018 10:10:22 +0200
Message-ID: <CAKv+Gu_y6La77sWOSROrwfRy65jrFVYVvRZt+ewNheYhdhHCkQ@mail.gmail.com>
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

On 6 August 2018 at 10:02, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
> On Sun, 5 Aug 2018, Florian Weimer wrote:
>
>> On 08/04/2018 01:04 PM, Mikulas Patocka wrote:
>> > There's plenty of memcpy's in the graphics stack. No one will be rewriting
>> > all the graphics drivers because of tiny market share that ARM has in
>> > desktop computers. So if you refuse to fix things and blame everyone else,
>> > you can as well announce that you don't want to have PCIe graphics on ARM
>> > at all.
>>
>> The POWER toolchain maintainers said pretty much the same thing not too
>> long ago. I wonder how many architectures need to fail until the
>> graphics stack is finally fixed.
>>
>> Thanks,
>> Florian
>
> If you say that your architecture doesn't support unaligned accesses at
> all, there's no problem - the compiler won't generate them and the libc
> won't contain them.
>
> But if you say that your architecture supports unaligned accesses except
> for the framebuffer, then you have a problem - the compiler can't know
> which pointers point to the framebuffer and libc can't know either - you
> caused this problem by your architectural decision.
>
> You can use 'volatile' to suppress memory optimizations, but it's
> impossible to go through the whole Linux graphics stack and add volatile
> to every pointer that may point to videoram. Even if you succeesed, new
> videoram accesses without volatile will appear after a year of
> development.
>
> See for example the macros READ_ONCE and WRITE_ONCE in Linux kernel - they
> should be used when there's concurrent access to the particular variable,
> but mainstream architectures don't require them, so many kernel developers
> are omitting them in their code.
>
> If you are building a supercomputer with a particular GPU, you can force
> the GPU vendor to provide POWER-compliant drivers. If you are building a
> workstation where the user can plug any GPU, forcing developers will go
> nowhere. You have to emulate the unaligned accesses and make sure that the
> next versions of your architecture support them in hardware.
>

I have the feeling this discussion is going off the rails again.

The original report is about corruption when doing overlapping writes.
Matt Sealey said you cannot have PCI outbound windows with memory
semantics on ARM, and so you should be using device mappings (which do
not tolerate unaligned accesses)

In this context, 'device mapping' does not mean 'any non-DRAM region',
but it refers to a particular type of MMU mapping attribute defined by
the ARM architecture.

I think we can all agree that memcpy() should be usable on any region
of memory that has true memory semantics, even if it is backed by VRAM
on a graphics card.

The question is if PCIe can provide such regions on ARM.
