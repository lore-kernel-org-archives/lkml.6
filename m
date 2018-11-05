Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D7FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D2620862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4iudnDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D2620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbeKEWHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:07:34 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54980 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeKEWHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:07:34 -0500
Received: by mail-it1-f196.google.com with SMTP id d6so12435596itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nw0LFhAmj1A2SrLhkOFAVFIsfZ+p2NW1VDzJbHVe+MM=;
        b=h4iudnDBjbDhke0fht4GIO1Gh1wmE8/p3xSL7d4X3gaOK8Yf+I7n3RdCzyt6TMKyOs
         lbAzRdogbKJsfKgNDFcTDCLKOYbTSB4QSxcWZ5sWC+ZayXeuNEWYSLcbKRvqpKZIyOF6
         V5StPtDQgX4GC4GzEohdhsptwxscVhe4bpY/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nw0LFhAmj1A2SrLhkOFAVFIsfZ+p2NW1VDzJbHVe+MM=;
        b=CS7LCloDNFMWQlR0SdGEFfZV98xvL0+1BrY0WbUe2JLC5nfn74TkHGH4L83Ka9CV3F
         yeyiebgbq9nRSbJvzJK8OOwxZwtx261aeqwmwukB+o3mt0OiAW/onF0T5oBKH4+qLygJ
         CHZHuE6LgKsgdXyhi82YZLk9ec6OPzOA1hHoE1XNoE534+wNrZ+2Bi7viFTvJ/pxAHxm
         Nr7QhDMTvrCck8LHhOryucXxaRaKpzjSTAtXnKHpO2dPjB17wieeGbdagSx4hasW4NH8
         PPlcZJfOyTaDL0gyyY5bXy0Iu9Td9+REPnLpnS9KkChyfukJbNCdyBQMJaV8LonNwtmZ
         89VA==
X-Gm-Message-State: AGRZ1gKmX31lkI4ltFa6u0uQ33xUz0jdv1kSeMboistN9+72iXoCzQ4M
        QN01l25yccSR1pVPrQWrxxbjICr03/YRZUNXEPJFuw==
X-Google-Smtp-Source: AJdET5diy9iQo+EXbgwBoZirHVSuNCt78i9k7ylFG8mhjza7Xuvk8zFjIUXr1tU/BM6Irbdz5F/YCOxPLTvpOXX79Bc=
X-Received: by 2002:a24:8347:: with SMTP id d68-v6mr7128838ite.158.1541422077880;
 Mon, 05 Nov 2018 04:47:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 04:47:57 -0800 (PST)
In-Reply-To: <20181104201019.26142-1-sai.praneeth.prakhya@intel.com>
References: <20181104201019.26142-1-sai.praneeth.prakhya@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 13:47:57 +0100
Message-ID: <CAKv+Gu_2cPZ5HKo2oDeYsLGAXgnENzWskZOcT_Z509Shbct+2Q@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] Unmap EFI boot services code/data regions after boot.
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 November 2018 at 21:10, Sai Praneeth Prakhya
<sai.praneeth.prakhya@intel.com> wrote:
> CC'ing x86 folks because this patch set touches x86/mm which I am no expert of.
>
> Ideally, after kernel assumes control of the platform, firmware shouldn't access
> EFI boot services code/data regions. But, it's noticed that this is not so true
> in many x86 platforms. Hence, during boot, kernel reserves EFI boot services
> code/data regions [1] and maps [2] them to efi_pgd so that call to
> set_virtual_address_map() doesn't fail. After returning from
> set_virtual_address_map(), kernel frees the reserved regions [3] but they still
> remain mapped.
>
> This means that any code that's running in efi_pgd address space (e.g: any EFI
> runtime service) would still be able to access EFI boot services code/data
> regions but the contents of these regions would have long been over written by
> someone else as they are freed by efi_free_boot_services(). So, it's important
> to unmap these regions. After unmapping EFI boot services code/data regions, any
> illegal access by buggy firmware to these regions would result in page fault
> which will be handled by efi specific fault handler.
>
> Unmapping EFI boot services code/data regions will result in clearing
> PAGE_PRESENT bit and it shouldn't bother L1TF cases because it's already handled
> by protnone_mask() at arch/x86/include/asm/pgtable-invert.h.
>
> [1] Please see efi_reserve_boot_services()
> [2] Please see efi_map_region() -> __map_region() -> kernel_map_pages_in_pgd()
> [3] Please see efi_free_boot_services()
>
> Testing the patch set:
> ----------------------
> 1. Download buggy firmware (which accesses boot regions even after kernel has
> booted) from here [1].
> 2. Without the patch set, you shouldn't see any kernel warning/error messages
> (i.e. kernel allows accesses to EFI boot services code/data regions even after
> call to set_virtual_address_map()).
> 3. With the patch set, you should see a kernel warning about buggy firmware,
> efi_rts_wq beeing freezed and disabling runtime services forever.
>
> Please note that this patch will change kernel's existing behavior for some EFI
> runtime services but I think it's OK because kernel should have never allowed
> those accesses in the first place.
>
> Also please note that this patch set needs lot of real time trashing as I just
> tested it out with OVMF.
>
> Note:
> -----
> Patch set based on "next" branch in efi tree.
>
> Changes from V2 -> V3:
> ----------------------
> 1. Expliclty set pfn to 0 in kernel_unmap_pages_in_pgd().
> 2. Add __init modifier to kernel_<map/unmap>_pages_in_pgd().
> 3. Warn if kernel_<map/unmap>_pages_in_pgd() are called after smp_init().
> 4. Split efi_unmap_pages() into a separate patch.
>
> Changes from V1 -> V2:
> ----------------------
> 1. Rewrite the cpa initializer in a more readable fashion.
> 2. Don't use cpa->pfn while unmapping, as it's not useful.
> 3. Unmap regions before freeing them up.
> 4. Fix spelling nits.
>
> Sai Praneeth (3):
>   x86/mm/pageattr: Introduce helper function to unmap EFI boot services
>   x86/efi: Unmap EFI boot services code/data regions from efi_pgd
>   x86/efi: Move efi_<reserve/free>_boot_services() to arch/x86
>
>  arch/x86/include/asm/efi.h           |  2 ++
>  arch/x86/include/asm/pgtable_types.h |  8 ++++++--
>  arch/x86/mm/pageattr.c               | 40 ++++++++++++++++++++++++++++++++++--
>  arch/x86/platform/efi/efi.c          |  2 ++
>  arch/x86/platform/efi/quirks.c       | 25 ++++++++++++++++++++++
>  include/linux/efi.h                  |  3 ---
>  init/main.c                          |  4 ----
>  7 files changed, 73 insertions(+), 11 deletions(-)
>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>

Thanks Sai.

I have queued these up in efi/next for now, but I'd still like a fresh
ack from the x86 maintainers.
