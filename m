Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F71DC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59B2247D8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXRTsUra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59B2247D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934401AbeFVT3j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:29:39 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34156 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934096AbeFVT3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:29:37 -0400
Received: by mail-io0-f193.google.com with SMTP id e15-v6so7102526iog.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WMDq+L0tubcQXI1TGHGYC+SxhWjyO8vN9496uuCbCZY=;
        b=FXRTsUra5ec6Ev4HqrTmjjQGbtJrJxJyfsDjGRffu7u1jhsqJB+HWctxhM99vQkUbN
         lVUzW9X0iHX4bzzChTpmuMc0yKM5pL0d1aFx2qQqjjCFELNVXm9ZA1LM1yl4NpPmj2JT
         XD1qUDY4GcSqLtFLEvVCaUUoyF9leFaNB5s+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WMDq+L0tubcQXI1TGHGYC+SxhWjyO8vN9496uuCbCZY=;
        b=lRK+yNMVSl2AcRLx2xrVacWusDRGUCuJi3K0O+oqtHxoWo0/VNbFOp63BIgCwlNnvX
         2Uu5jg9m17UhHghJ62oWh8kvpfIM9A/mI69JrjI6lZewXjPA8lJYH7+tclwC4AFdC7q5
         4XtQ+FMuXiR/wDC2Abxdnc8TH5BZ/bGQ8PbjXLASHjgLIpO+Sco3+rrd6zBWnjKAbgn4
         TuimfTyH6Je3biPC5IkrkGFVPfR8dXcHFpsegcGUhj5oxfBcNTz1JyuX1q6Dt6awjBxZ
         rI35D24vtYn2tgxbnIQPg1TL0f4scG6ROuC3D5fxErNxubA6DGBdFqgip+4rlREpZVJm
         q2yQ==
X-Gm-Message-State: APt69E3s2lEw+HU/Umi43MWxYUERHY8iXdcK/vtXSXbZpz2Am9bu5CcP
        TT6vZMZOqk5htTmKLCzSS0v1M9t+xIanICM6WNvl2Q==
X-Google-Smtp-Source: AAOMgpenu0J45c/P2tp93FoF13d/siBMQsuolRZH2XfAGB1+fVWWS+GXoj2cIIp5cl+HZT7Wq2WNr/FY9h4Xv76kRwc=
X-Received: by 2002:a6b:520d:: with SMTP id g13-v6mr2548353iob.60.1529695776796;
 Fri, 22 Jun 2018 12:29:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 12:29:36
 -0700 (PDT)
In-Reply-To: <37289a27-eb99-6a73-4d32-4a75edd11dcd@codeaurora.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org> <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
 <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org> <CAKv+Gu9HAJRHwjYLNjf+gg=1vFoFu3BJphifKKE-aR4o_MW84A@mail.gmail.com>
 <CAKv+Gu-WXLXqHSmiS2MmAMXHLKK_kg+3EK6L2rvO0SzN-c0UMg@mail.gmail.com> <37289a27-eb99-6a73-4d32-4a75edd11dcd@codeaurora.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 22 Jun 2018 21:29:36 +0200
Message-ID: <CAKv+Gu-bwCFhCKiA7P1amMLeBaSxsjk0d6aPjAr9nCvOBPJA6w@mail.gmail.com>
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

On 22 June 2018 at 20:30, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 6/22/2018 2:01 PM, Ard Biesheuvel wrote:
>>> Yes, it is part of the PCI I/O protocol definition. FrameBufferBase is
>>> described as
>>>
>>> """
>>> Base address of graphics linear frame buffer. Info contains
>>> information required to allow software to draw directly to the
>>> frame buffer without using Blt().Offset zero in
>>> FrameBufferBase represents the upper left pixel of the
>>> display.
>>> """
>> I just tried AMD Radeon and NVidia graphics cards on a system with
>> non-1:1 mapped MMIO windows, and in both cases, the GOP protocol
>> structure is populated correctly, i.e., using the CPU address not the
>> PCIe address.
>>
>> EDK2 only recently gained support for MMIO translation in the host
>> bridge driver, so I so wonder if this is a platform issue rather than
>> a driver issue. It may be worth a try to dump the results of
>> GetBarAttributes() of all PCI I/O protocol instances (either in UEFI
>> or in the stub), to double check that the correct values are returned.
>>
>
> Thanks for checking out other platforms. I'll mark the issue as a BIOS
> issue and bounce your feedback to the BIOS provider.
>

I screwed up my testing, unfortunately. Both the public AMD GOP driver
I tried, and the Nvidia GT218 under x86 emulation break when using
MMIO translation. However, GraphicsOutputDxe in the EDK2 tree gets it
right, and uses PciIo->GetBarAttributes() to get the address of the
framebuffer region, which will return the CPU address not the PCI
address.

> Let's hold onto this patch for the moment.
>

Yes. I'd like to get this resolved as well, but if the drivers are
dereferencing BAR values as CPU addresses, this is unlikely to be the
only thing that is broken under outbound translation.
