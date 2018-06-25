Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6043C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E025255C7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PFxw0Fam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E025255C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeFYIUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:20:05 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46942 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeFYIUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:20:02 -0400
Received: by mail-io0-f194.google.com with SMTP id u23-v6so7988600ioc.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nl12Q5LyAVnf2BhIvNfksaMY8vOaS5gjiUonbnvOTt0=;
        b=PFxw0FamIxLT7TOf4C2WD4ZS94yt0UHV8tjS7CgQdT5Zm6Jx52jCjHOVz62+co47BY
         /SVy8r14qBR/heri/fDN4cMgN12i8A+5kPep0/2/yElPF1mYSisNLYJewTtsgh6BdbO2
         yjFJQfor8UzjFYLsoa8BteoLttiWBHMPy4Ktg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nl12Q5LyAVnf2BhIvNfksaMY8vOaS5gjiUonbnvOTt0=;
        b=MxhHKvGPbJ0i1+LgFLMoF/ldWOd5nrt9UGNSCMzrhBvYfBs8xoLGVQUnLM6hExBVV1
         29pKlfgUBoMlz76qGxnKUHEPAaPh/wTaejE2jfeU4V6FPNEIFcpAfk1DARzQkqAeHlvD
         +1OxR+bT3zTU6KNPKb6HYNiaUdWaAI3Pgzrw0D+RTC07xdEf2IIN/MJbJk9u3NN0MVn7
         +tJKgWbEZkqObnyT33SZt+KBcZO7WouIMNvRxAWhUWp882XmCMBOPS1GKdWGFXLWrqBE
         bIVFGEenUrHn5IsnElpVuYL77yu8Vppk3JtYhfz9julqECXmNPL7nvNWSk17n2YBz5Oi
         76HQ==
X-Gm-Message-State: APt69E04FLo9VMmxv1TAguCWv6V4LQtgLVB5rlVJXX2t1G2vVFy0FuTX
        nLtLbPUvlLhNIDoBsfY+sDVlTcmFrRzUsPi4zSQXag==
X-Google-Smtp-Source: AAOMgpf0rReLCl64Edh0ySmVYGf6aFktvAAM9iK/xkHKUYl1eKpIaErzi3gKK3bHlchW4reeV0T8zgmjIASdATN+U2Q=
X-Received: by 2002:a6b:dd0b:: with SMTP id f11-v6mr9277000ioc.173.1529914802079;
 Mon, 25 Jun 2018 01:20:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 01:20:01
 -0700 (PDT)
In-Reply-To: <CAKv+Gu-bwCFhCKiA7P1amMLeBaSxsjk0d6aPjAr9nCvOBPJA6w@mail.gmail.com>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org> <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
 <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org> <CAKv+Gu9HAJRHwjYLNjf+gg=1vFoFu3BJphifKKE-aR4o_MW84A@mail.gmail.com>
 <CAKv+Gu-WXLXqHSmiS2MmAMXHLKK_kg+3EK6L2rvO0SzN-c0UMg@mail.gmail.com>
 <37289a27-eb99-6a73-4d32-4a75edd11dcd@codeaurora.org> <CAKv+Gu-bwCFhCKiA7P1amMLeBaSxsjk0d6aPjAr9nCvOBPJA6w@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 25 Jun 2018 10:20:01 +0200
Message-ID: <CAKv+Gu96HQf0oJ1RC+wVU34FqqcCWrnDGag48vjNP_z86HhLBQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 June 2018 at 21:29, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 22 June 2018 at 20:30, Sinan Kaya <okaya@codeaurora.org> wrote:
>> On 6/22/2018 2:01 PM, Ard Biesheuvel wrote:
>>>> Yes, it is part of the PCI I/O protocol definition. FrameBufferBase is
>>>> described as
>>>>
>>>> """
>>>> Base address of graphics linear frame buffer. Info contains
>>>> information required to allow software to draw directly to the
>>>> frame buffer without using Blt().Offset zero in
>>>> FrameBufferBase represents the upper left pixel of the
>>>> display.
>>>> """
>>> I just tried AMD Radeon and NVidia graphics cards on a system with
>>> non-1:1 mapped MMIO windows, and in both cases, the GOP protocol
>>> structure is populated correctly, i.e., using the CPU address not the
>>> PCIe address.
>>>
>>> EDK2 only recently gained support for MMIO translation in the host
>>> bridge driver, so I so wonder if this is a platform issue rather than
>>> a driver issue. It may be worth a try to dump the results of
>>> GetBarAttributes() of all PCI I/O protocol instances (either in UEFI
>>> or in the stub), to double check that the correct values are returned.
>>>
>>
>> Thanks for checking out other platforms. I'll mark the issue as a BIOS
>> issue and bounce your feedback to the BIOS provider.
>>
>
> I screwed up my testing, unfortunately. Both the public AMD GOP driver
> I tried, and the Nvidia GT218 under x86 emulation break when using
> MMIO translation. However, GraphicsOutputDxe in the EDK2 tree gets it
> right, and uses PciIo->GetBarAttributes() to get the address of the
> framebuffer region, which will return the CPU address not the PCI
> address.
>
>> Let's hold onto this patch for the moment.
>>
>
> Yes. I'd like to get this resolved as well, but if the drivers are
> dereferencing BAR values as CPU addresses, this is unlikely to be the
> only thing that is broken under outbound translation.

Note that this was fixed fairly recently in EDK2, so BIOS vendors
providing UEFI firmware for ARM platforms with outbound MMIO
translation should probably incorporate this EDK2 patch

commit dc080d3b61e570e7a3163fc24afa6f8388d0c0bf
Author: Heyi Guo <heyi.guo@linaro.org>
Date:   Thu Feb 8 11:13:27 2018 +0800

    MdeModulePkg/PciBus: return CPU address for GetBarAttributes

    According to UEFI spec 2.7, PciIo->GetBarAttributes should return host
    address (CPU view ddress) rather than device address (PCI view
    address), and
    device address = host address + address translation offset,
    so we subtract translation from device address before returning.

Note that this is not the only MMIO translation related change made by
Heyi Guo to the generic PCI host bridge and bus drivers, but given
that those did not support MMIO translation at all, I take it your
affected platforms will already have their own changes to accommodate
this.
