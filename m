Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B68C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4081F24C8D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qgy8Qi9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4081F24C8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeFWSJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 14:09:22 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46762 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbeFWSJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 14:09:21 -0400
Received: by mail-io0-f195.google.com with SMTP id u23-v6so5184828ioc.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kcuemrlYkhAZbDeo04gVaJTteSCeXmOjRKFr5CbMiU4=;
        b=Qgy8Qi9p7SaEiYsitwBXB7trWbaLpfEQhwIodrAL7dQHv2zL0kSen5FX18q7hwuLsQ
         zw5HFtjZzcSCQivuCxruujp0Mb0+b9B6g4Y1YA+bhdMbCeQsBsKOLnck1n5gRU8tXmS2
         dTtl2n9D/FUuiXyKqkebos0zZYdlVwAoR5qek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kcuemrlYkhAZbDeo04gVaJTteSCeXmOjRKFr5CbMiU4=;
        b=PCr7LEozDgv/t94WEaFyfWQ7dj+SUy83C10rSnUFbt4S+DI1gcCrv+JlAGT9ovn6L1
         dHrC2aTGSoSo7LjMBDGls8pJNg3g6q03cNiB5hZq7N8F9VsE8NUHG8pzF64NnuyetiW2
         Degn1LZGhUmcXYAQLyuX18e8Jtda949DT1QC8/QtaJNol8j8aAxvhOCkkxq6isDOv6zM
         F99DUE1J6WNFl++NRWV5p96a9dUc6dzBvzvrobZCheenq8xrBXtOcUj8ltSy5EeHR2rz
         RaVSos9D04KFxFTBYSS4VVJ4FwzmmmJchVZGgHN/uPF4ZjK3y3KdNxRD+RAeerCv4N5H
         8iHA==
X-Gm-Message-State: APt69E3sGKkW3AiDcamavkEPGSfuCiAqZ6kIAN5Oxk80lvNwpECPVWoI
        ftDkSKvZ5IUhnzbuGfeKgbvY9pV4eETENweXP+dXwQ==
X-Google-Smtp-Source: AAOMgpdL1l10Atb9OPQkw8iAzDXPmpxx5GzbPCLqAMPpQba9DULbAsgGTa9PEcQxIYeuqAwHa5/G5Orn2Xwd33lVpfQ=
X-Received: by 2002:a6b:520d:: with SMTP id g13-v6mr5509810iob.60.1529777360279;
 Sat, 23 Jun 2018 11:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 11:09:19
 -0700 (PDT)
In-Reply-To: <20180623174258.GA15904@chaos.in-kiel.de>
References: <20180623174258.GA15904@chaos.in-kiel.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 23 Jun 2018 20:09:19 +0200
Message-ID: <CAKv+Gu8yA1L6P=W70gm1u_uuF9xJ+XVWeWB0MxC3Fur=_DeVmw@mail.gmail.com>
Subject: Re: [PATCH] make radeon driver find ATOM BIOS again on 64-bit EFI systems
To:     Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Hans, who may be able to test this on 32-bit h/w)

On 23 June 2018 at 19:43, Wilfried Klaebe
<linux-kernel@lebenslange-mailadresse.de> wrote:
> make radeon driver find ATOM BIOS again on 64-bit EFI systems
>
> Commit 2c3625cb9fa2c477d5877a1819e29d6a902e5fef ("efi/x86: Fold
> __setup_efi_pci32() and __setup_efi_pci64() into one function")
> broke finding radeon's BIOS ROM on Apple MacBook Pro 8,2. Fix.
>
>
> On my Apple MacBook Pro 8,2, Linux 4.18-rc1 was unable to locate a BIOS
> ROM for the radeon GPU. Comparing Linux 4.17 and 4.18-rc1 dmesg:
>
>  radeon 0000:01:00.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x0000
>  radeon 0000:01:00.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x0000
> -ATOM BIOS: Apple
> +[drm:radeon_get_bios [radeon]] *ERROR* Unable to locate a BIOS ROM
>
> Bisecting found 2c3625cb9fa2c477d5877a1819e29d6a902e5fef.
>
> Comparing the old __setup_efi_pci32 and __setup_efi_pci64, and looking
> at what the new __setup_efi_pci does, I noticed that the first does
>
>         status = efi_early->call(pci->attributes, pci,
>                                  EfiPciIoAttributeOperationGet, 0, 0,
>                                  &attributes);
>
> while the second does
>
>         status = efi_early->call(pci->attributes, pci,
>                                  EfiPciIoAttributeOperationGet, 0,
>                                  &attributes);
>
> (note the difference of one "0, "), while the third has two occurences
> of "0, " too in it's EfiPciIoAttributeOperationGet call construct.
>
> Testing confirmed my machine works as expected with the variant with
> just one "0, "; I cannot test if this is true for other 64-bit EFI
> machines or maybe even 32-bit EFI machines.
>
>
> Signed-off-by: Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
> Fixes: 2c3625cb9fa2 ("efi/x86: Fold __setup_efi_pci32() and __setup_efi_pci64() into one function")
>

Hello Wilfried,

Thanks for tracking down this issue.

It seems the two 0s in the 32-bit version are there because the type
of the argument is UINT64. So instead, I'd like to apply this change:

>         void *romimage;
>
>         status = efi_call_proto(efi_pci_io_protocol, attributes, pci,
> -                               EfiPciIoAttributeOperationGet, 0, 0,
> +                               EfiPciIoAttributeOperationGet, 0ULL,
>                                 &attributes);
>         if (status != EFI_SUCCESS)
>

unless anyone objects?

Thanks,
Ard.

> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index a8a8642d2b0b..1b348610bd86 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -117,9 +117,14 @@ __setup_efi_pci(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
>         uint64_t attributes, romsize;
>         void *romimage;
>
> -       status = efi_call_proto(efi_pci_io_protocol, attributes, pci,
> -                               EfiPciIoAttributeOperationGet, 0, 0,
> -                               &attributes);
> +       if (efi_early->is64)
> +               status = efi_call_proto(efi_pci_io_protocol, attributes, pci,
> +                                       EfiPciIoAttributeOperationGet, 0,
> +                                       &attributes);
> +       else
> +               status = efi_call_proto(efi_pci_io_protocol, attributes, pci,
> +                                       EfiPciIoAttributeOperationGet, 0, 0,
> +                                       &attributes);
>         if (status != EFI_SUCCESS)
>                 return status;
>
