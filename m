Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377F6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB78620C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHMpoFyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB78620C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbeGQKOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:14:45 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34214 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbeGQKOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:14:45 -0400
Received: by mail-io0-f194.google.com with SMTP id l7-v6so401064ioj.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=p7k6TczFfiDNFF7gIKB3YxOy9DFD5OsweM0oApLg7tI=;
        b=MHMpoFyhJPq2zoHF4cf+LgaAoDhAtdeNwe79AyCwjLjIvEA9MeoIgr4liXoawOv03T
         IgCeSEunXfCIsEVJSzJntT/L8FkQr+kRIPv+yde6a4utw+Frh7ZSROOIaqAyd1R7VsO6
         3txXwhtg6vNge6Wb8NneVQ8IZCDnnJu+AEmek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=p7k6TczFfiDNFF7gIKB3YxOy9DFD5OsweM0oApLg7tI=;
        b=ZYezBkHNOVKQh+/GwLWXjiREz8WRJOrZ1T9KAls6hZgIJv0Ex7dj14QxHaFvI+N8cg
         C1pUYDUrWX+XRG/p/in2j8AbYAjpNATYM6uRrSIS/Ehk14Hbz26Pw8Tx1UZ/pKA/36Uc
         Me9XPJnMgdA3zGs4WfUKuq3gQmstbDrxmdSbu0tGdVTWaPzD2elvgmMBADeXAplSTN9W
         KgznYTmZRI2m3lP/7ImzAQj1rFFtflBWHGWsWUVRy0mOfR8wi3EtBiOHBYG2ZuDv12Dt
         bhzTUCBZYs2ouyCv2bgtZDWtz74fbsvcYwUdAZvpt/8jRhn7GsLjEM+md9X0aT/YCawf
         48xQ==
X-Gm-Message-State: AOUpUlGrybVGIrPnLgKTLPLYL/pOwFl/uf2hmRErHc/jNHLW7/ueHYEy
        yoTdChleku9/PylJiRkGfESmtVLEWLgC/IvdL0P7isnu
X-Google-Smtp-Source: AAOMgpcwTHgyWrgIjBs/tLQp/tEE3oDAbmuYW4cPDR489rzkF/0o0+TbFww6WfkIRgc56mTvK0RFZaWN93lle+6vjX8=
X-Received: by 2002:a6b:5208:: with SMTP id g8-v6mr762556iob.60.1531820580012;
 Tue, 17 Jul 2018 02:43:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 02:42:59
 -0700 (PDT)
In-Reply-To: <tip-61f0d55569463a1af897117ff47d202b0ccb2e24@git.kernel.org>
References: <tip-61f0d55569463a1af897117ff47d202b0ccb2e24@git.kernel.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 17 Jul 2018 17:42:59 +0800
Message-ID: <CAKv+Gu_iy1EkfWEzDE4zbkydU7EqXv+mQx9PTrYKpJWfXHSVig@mail.gmail.com>
Subject: Re: [tip:efi/core] efi/esrt: Only call efi_mem_reserve() for boot
 services memory
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo,

Thanks for pulling this directly. I will have another batch for
efi/core by the end of the week (and another urgent patch as well).

There is one remaining issue with mixed mode that I cc'ed you and
Kirill on, but since that seems to be a v4.17 regression, I will keep
that as a separate thing.

-- 
Ard.


On 17 July 2018 at 17:24, tip-bot for Ard Biesheuvel <tipbot@zytor.com> wrote:
> Commit-ID:  61f0d55569463a1af897117ff47d202b0ccb2e24
> Gitweb:     https://git.kernel.org/tip/61f0d55569463a1af897117ff47d202b0ccb2e24
> Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
> AuthorDate: Mon, 16 Jul 2018 23:25:07 +0800
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 17 Jul 2018 09:15:05 +0200
>
> efi/esrt: Only call efi_mem_reserve() for boot services memory
>
> The following commit:
>
>   7e1550b8f208 ("efi: Drop type and attribute checks in efi_mem_desc_lookup()")
>
> refactored the implementation of efi_mem_desc_lookup() so that the type
> check is moved to the callers, one of which is the x86 version of
> efi_arch_mem_reserve(), where we added a modified check that only takes
> EFI_BOOT_SERVICES_DATA regions into account.
>
> This is reasonable, since it is the only memory type that requires this,
> but doing so uncovered some unexpected behavior in the ESRT code, which
> permits the ESRT table to reside in other types of memory than what the
> UEFI spec mandates (i.e., EFI_BOOT_SERVICES_DATA), and unconditionally
> calls efi_mem_reserve() on the region in question. This may result in
> errors such as
>
>   esrt: Reserving ESRT space from 0x000000009c810318 to 0x000000009c810350.
>   efi: Failed to lookup EFI memory descriptor for 0x000000009c810318
>
> when the ESRT table is not in EFI_BOOT_SERVICES_DATA memory, but we try
> to reserve it nonetheless.
>
> So make the call to efi_mem_reserve() conditional on the memory type.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-efi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/firmware/efi/esrt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> index 375a77c1c6e5..5d06bd247d07 100644
> --- a/drivers/firmware/efi/esrt.c
> +++ b/drivers/firmware/efi/esrt.c
> @@ -329,7 +329,8 @@ void __init efi_esrt_init(void)
>
>         end = esrt_data + size;
>         pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &end);
> -       efi_mem_reserve(esrt_data, esrt_data_size);
> +       if (md.type == EFI_BOOT_SERVICES_DATA)
> +               efi_mem_reserve(esrt_data, esrt_data_size);
>
>         pr_debug("esrt-init: loaded.\n");
>  }
