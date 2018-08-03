Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05A9C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83800216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8RY2uLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83800216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeHCJLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:11:35 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:50691 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbeHCJLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:11:35 -0400
Received: by mail-it0-f51.google.com with SMTP id j81-v6so5368217ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 00:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zzp4ncsuj9rG5qACaSG3GJJvpeFSD00yenJ89qvmnuA=;
        b=e8RY2uLisnK2e4IgB3CpE+tAJm1aEs/XOACjgo/Oqpivu+F4EK50xR97+zSnBkcAfm
         uaW5z6PelFjorKa6MIfjomdXP7bDhZF+jJkBeIHbxUX0a3INf9NPrLciV+R9T7ZXVMkG
         X0FS9SG1L1EhfrsFSQewa1w05Lsj9YhuJIsEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zzp4ncsuj9rG5qACaSG3GJJvpeFSD00yenJ89qvmnuA=;
        b=D28/mDCdtf573PfRKRQO5ki4+2bcG8V+TJQILYqkA7w6FRiubqHmefi5UV5Q6vCdx3
         drlyNwVkB+KWd+FzmVN7hpmEzzgQqN8p7pVHbVVCbmJtoMoTdpvJ4P5bLR4jad+hKMsg
         GJoU+3QvUdARQiuXQYn1ewCwK/Dtht7TzK4EFmyjlK4P9eZFW1lwHGMYsRGoBTrb2j+R
         hWuxnwZRx5Q44JSesE1wkjt8z7LStKg7bQVgvLEOFtC2DtSE3i4nDjG8iKOnSW3WBnPd
         LWv0I1WIindzsfpJPuqoYAL2VpTGWxgeGg1eCOof0PV6TMEB0kHxa7qzHWUWTQFCgqql
         kPpA==
X-Gm-Message-State: AOUpUlGVHUcGwiz+GsEsdsDuKR/rgCU1ko62MDTjmbq1wdQrVCxX16uQ
        iHtcSgXbO1PiqNmKzuJ1BFx1TqT44y/PSGvI1fbqgg==
X-Google-Smtp-Source: AAOMgpcUst+QPtROiTpgs1MH3ibjxByaQtLv+fHVJyUrxM+CkoA+JYY1J51+XUdeBCXVjT3cSmvmoRnwn3p2ykSC23E=
X-Received: by 2002:a24:148c:: with SMTP id 134-v6mr5340613itg.50.1533280599786;
 Fri, 03 Aug 2018 00:16:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 00:16:39 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com> <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 3 Aug 2018 09:16:39 +0200
Message-ID: <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Matt Sealey <neko@bakuhatsu.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        libc-alpha@sourceware.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 August 2018 at 08:35, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
> On Thu, 2 Aug 2018, Matt Sealey wrote:
>
>> The easiest explanation for this would be that the memory isn?t mapped
>> correctly. You can?t use PCIe memory spaces with anything other than
>> Device-nGnRE or stricter mappings. That?s just differences between the
>> AMBA and PCIe (posted/unposted) memory models.

Whoa hold on there.

Are you saying we cannot have PCIe BAR windows with memory semantics on ARM?

Most accelerated graphics drivers rely heavily on the ability to map
the VRAM normal-non-cacheable (ioremap_wc, basically), and treat it as
ordinary memory.

>
> I've tried to use Device-nGnRE mapping and I've got unaligned access
> traps. Gcc have store-merging pass so that it generates unaligned accesses
> even in code that has none explicit unaligned accesses. Perhaps it would
> be possible to recompile the kernel without the store-merging pass, but
> recompiling all the userspace code is impossible.
>
> Should we catch the unaligned access traps in the kernel and emulate them?
> There are a lot of instructions that access memory in the ARMv8 ISA, so
> the emulator would be quite complicated.
>
>> Normal memory (cacheable or uncacheable, which Linux tends to call
>> ?memory? and ?writecombine? respectively) is not a good idea.
>>
>> There are two options; make sure Links maps it?s framebuffer as Device
>> memory, or the driver, or both - and make sure that only aligned
>> accesses happen (otherwise you?ll just get a synchronous exception) and
>> there isn?t a Normal memory alias.
>>
>> Alternatively, tell the PCIe driver that the framebuffer is in system
>> memory
>
> But how would the graphics card display from it? You'd have to
> periodically copy the framebuffer from the system memory to the real
> videoram. I'm not an expert in graphics drivers, I don't know if the
> graphics drivers have this possibility.
>
>> - you can map it however you like but there?ll be a performance
>> hit if you start to use GPU acceleration, but a significant performance
>> boost from the PoV of the CPU. Only memory accessed from the PCIe master
>> interface (i.e. reads and writes generated by the card itself - telling
>> the GPU to pull from system memory or other DMA) can be in Normal memory
>> and this allows PCIe to be cache coherent with the right interconnect.
>> The slave port on a PCIe root complex (i.e. CPU writes) can?t be used
>> with Normal, or reorderable, and therefore your 2GB of graphics memory
>> is going to be slow from the point of view of the CPU.
>>
>> To find the correct mapping you?ll need to know just how cache coherent
>> the PCIe RC is...
>>
>> Ta,
>> Matt
>
> Mikulas
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
