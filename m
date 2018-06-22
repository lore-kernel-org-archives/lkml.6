Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEBAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD4F24120
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hNJaMA+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD4F24120
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeFVLVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:21:34 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53619 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeFVLVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:21:30 -0400
Received: by mail-it0-f67.google.com with SMTP id a195-v6so2365942itd.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 04:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0silnt5jmYbdp8PBts+IrGrVbdLRdxecd3/+a300SaY=;
        b=hNJaMA+9vOjoN/ritplV8eIgWRjIinEBUhKt3ZXVz7Wqp3jvvq8pzD9brTkSGNXd1F
         gZd+VVww6xRUpId7+sQ4Zr8gS62fruTKWR2z2wMQ9gWNT56sJzxPxGthTFWDVsKW7BdF
         cWRARny17Bnsz4MNcepEG9BPrk/B2+RpqXj7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0silnt5jmYbdp8PBts+IrGrVbdLRdxecd3/+a300SaY=;
        b=OFjgPA5Gsp6BP16OVT6rlAEK18Xo0woxTO+9w7lODhQOK7DC5Sh2SusyUcp7E/DwWy
         YOqlPXoYH7RVSeQds/u1D7Qin3gMkJETI6mXVRWQxUCPgWNZ3SbztNirfmrzBomaqkFI
         oMN9o9gKmTe6N7xzCxSltaxKF9bkAu6CzD9aorLrDSc/NgKafkcqzOTecN/Y/cxYjtBd
         bEM6pvVuPFl7EiwTOP/amwp7qbuZZHHyJcYNU1itgel0OB8SpIlLLC3UbYt8RoIaI7au
         //O0fLFmAXIah4nbwlj1okuaEBEH9zilfIpIuqG99dt0bbTJaA1bVGrxvGmdEorOAP+1
         sz5g==
X-Gm-Message-State: APt69E3ZGBNxWEYccTXysC2HCc0/7mWozA8SFrhFav6MKcuXKmLQlGcv
        R2oO9kkXcnpwRBbN2GccKSMvfu7BHmGwP9+SFe910w==
X-Google-Smtp-Source: ADUXVKJoD3Edk7hKrHPNibSmNohEkMCxqwUb/RnLuuQ/jrXpLhpiXsz6W3RfIY8v2PKE8Z3iZQkncJVLLiCpi9EuDb0=
X-Received: by 2002:a02:4187:: with SMTP id n7-v6mr928677jad.86.1529666489751;
 Fri, 22 Jun 2018 04:21:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 04:21:29
 -0700 (PDT)
In-Reply-To: <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org> <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 22 Jun 2018 13:21:29 +0200
Message-ID: <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sinan Kaya <okaya@codeaurora.org>,
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

On 20 June 2018 at 00:29, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Minor subject nit: From the caller's point of view, we must convert a bus
> address to a resource *always* (the caller has no knowledge of "whether it
> is translated by the host bridge").
>
> On Fri, May 18, 2018 at 10:17:51AM -0400, Sinan Kaya wrote:
>> A host bridge is allowed to remap BAR addresses using _TRA attribute in
>> _CRS windows.
>
> Also, _TRA/_CRS are ACPI-specific terms and non-ACPI host bridges can
> also do the same sort of translation.  Another trivial nit.
>
>> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
>> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
>>
>> When a VGA device is behind such a host bridge and the resource is
>> translated efifb driver is trying to do ioremap against bus address
>> rather than the resource address and is failing to probe.
>>
>> efifb: probing for efifb
>> efifb: cannot reserve video memory at 0x1e000000
>> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
>> efifb: mode is 800x600x32, linelength=3200, pages=1
>> efifb: scrolling: redraw
>> efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
>>
>> Use the host bridge offset information to convert bus address to
>> resource address in the fixup.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Thanks a lot for fixing this!
>

Apologies for only bringing this up now, but I think this patch is
wrong after all.

screen_info.lfb_base is supposed to be a CPU address, and so
translating it like this is wrong. If you end up with a PCI address
here, you have made a mistake in hacking support for PCI outbound
translations into UEFI. Other users such as UEFI itself or GRUB will
treat this as a CPU physical address as well, so the kernel should not
treat it any differently.


>> ---
>>  drivers/video/fbdev/efifb.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
>> index 6daac8d..429cc85 100644
>> --- a/drivers/video/fbdev/efifb.c
>> +++ b/drivers/video/fbdev/efifb.c
>> @@ -431,6 +431,7 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>>               .end = screen_info.lfb_base + screen_info.lfb_size - 1,
>>               .flags = IORESOURCE_MEM,
>>       };
>> +     struct pci_bus_region region;
>>       int i;
>>
>>       if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
>> @@ -442,6 +443,10 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>>       if (!screen_res.start)
>>               return;
>>
>> +     region.start = screen_res.start;
>> +     region.end = screen_res.end;
>> +     pcibios_bus_to_resource(dev->bus, &screen_res, &region);
>> +
>>       for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
>>               struct resource *res = &dev->resource[i];
>>
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
