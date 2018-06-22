Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF85FC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BB324704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgPjat0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BB324704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933962AbeFVSBG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:01:06 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37347 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbeFVSBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:01:04 -0400
Received: by mail-it0-f67.google.com with SMTP id l6-v6so4070881iti.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KEdGV6+AyiWnfpT6r1DkrHtSM8ImMpvre4v8Ood9jXo=;
        b=fgPjat0SDn60HlGdEI8UoCVWZW3E3RhGF6v0e2Vv+HX8Viau/mTp2V1Udy1BRg/U+S
         uJu5NmwQwscE/lYBQyXfglJCPLYSm7z0Ohk/osx+qokyqM95oeO8kL15ldZcBDjAK2du
         Lxf3NwXVKgoeWv6pODixeisA1njbHBGwGlLdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KEdGV6+AyiWnfpT6r1DkrHtSM8ImMpvre4v8Ood9jXo=;
        b=oywSRwxtKlIzPeAHtdhFWBCnO9WuY5OuYG3icAYwScQKyOSyzFeeZ2/EtVm51vtu95
         CScPpRnKGDv47tVqPNJEw+R7KH0eLLnaxSMC+pAX4pYP+RHjrCl46V1KAyREal7h13Sq
         UCgyz8DWLzJCQsNeAryPhBL7hcS/svE/bfWLJ02qSzuvQpOvGRjqeeaWxrXNIB/Jt8td
         2q8XJE8E9Fxa713WcYTVbyTlXA4d3aOYzE92IEWbAIPDfFFNyWEKyWuxSjXxwanNCb2U
         gdDOtdrLz176+1jfR1U6w4DxZNBNgFWTbw57wbk7XpPRKxV9+hAi9BV1pTjZMclg5wOU
         481g==
X-Gm-Message-State: APt69E0QFIqsTVqZ7fllfEToFg1q95rOSQU8G2X94xe8ydPPukMZDA8A
        gzCuTszXpXc7pez08Fbq4vLSV8XGk084a5b8YiQ4Pg==
X-Google-Smtp-Source: ADUXVKKlGbTByzXRfV8QJ2aB27xy6PFC44nV+ZE3dDfK0z/27SjQXChy975zXfw0bN07dsntretZSs0M7pchxbyYq1Y=
X-Received: by 2002:a24:6196:: with SMTP id s144-v6mr142241itc.68.1529690463817;
 Fri, 22 Jun 2018 11:01:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 11:01:03
 -0700 (PDT)
In-Reply-To: <CAKv+Gu9HAJRHwjYLNjf+gg=1vFoFu3BJphifKKE-aR4o_MW84A@mail.gmail.com>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org> <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
 <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org> <CAKv+Gu9HAJRHwjYLNjf+gg=1vFoFu3BJphifKKE-aR4o_MW84A@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 22 Jun 2018 20:01:03 +0200
Message-ID: <CAKv+Gu-WXLXqHSmiS2MmAMXHLKK_kg+3EK6L2rvO0SzN-c0UMg@mail.gmail.com>
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

On 22 June 2018 at 15:55, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 22 June 2018 at 15:52, Sinan Kaya <okaya@codeaurora.org> wrote:
>> Hi Ard,
>>
>> On 6/22/2018 7:21 AM, Ard Biesheuvel wrote:
>>> Apologies for only bringing this up now, but I think this patch is
>>> wrong after all.
>>>
>>> screen_info.lfb_base is supposed to be a CPU address, and so
>>> translating it like this is wrong. If you end up with a PCI address
>>> here, you have made a mistake in hacking support for PCI outbound
>>> translations into UEFI. Other users such as UEFI itself or GRUB will
>>> treat this as a CPU physical address as well, so the kernel should not
>>> treat it any differently.
>>
>> The behavior I'm seeing is from a UEFI BIOS vendor. I did not write the
>> code for it...
>>
>> I was asked to debug it.
>>
>> I'd like to dive into your statement about UEFI and GRUB using this address
>> as physical addresses.
>>
>> AFAIK, all PCI outbound requests go through PCI IO protocol in UEFI and the
>> translation information is hidden inside the UEFI PCI Host Bridge driver.
>> Drivers are not allowed to access PCI resources directly especially as a
>> memory mapped address.
>>
>> This particular vendor is programming the BAR address into the GOP protocol.
>> Since the host bridge driver is doing a translation, we are hitting this
>> issue.
>>
>> Is there a UEFI spec reference about the definition of this field?
>>
>
> Yes, it is part of the PCI I/O protocol definition. FrameBufferBase is
> described as
>
> """
> Base address of graphics linear frame buffer. Info contains
> information required to allow software to draw directly to the
> frame buffer without using Blt().Offset zero in
> FrameBufferBase represents the upper left pixel of the
> display.
> """

I just tried AMD Radeon and NVidia graphics cards on a system with
non-1:1 mapped MMIO windows, and in both cases, the GOP protocol
structure is populated correctly, i.e., using the CPU address not the
PCIe address.

EDK2 only recently gained support for MMIO translation in the host
bridge driver, so I so wonder if this is a platform issue rather than
a driver issue. It may be worth a try to dump the results of
GetBarAttributes() of all PCI I/O protocol instances (either in UEFI
or in the stub), to double check that the correct values are returned.
