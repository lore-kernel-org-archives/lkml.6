Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC7DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05C0208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VbEO0wA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05C0208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbeGJSjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:39:33 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36715 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732557AbeGJSjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:39:32 -0400
Received: by mail-it0-f65.google.com with SMTP id j185-v6so81222ite.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b/qh4MmnxtcchGDhc6TQCa9qodaj+wt1P6Lw841CQsE=;
        b=VbEO0wA4MRaXUdYoFuQOdzSE6m4MyPMKxKp7oOLgz3MFnAatXJA+Zu0C3q7q0Z/6NI
         juw6JriPwlFo8DwKJSzTD9ZWe4lvJT9LkB5d9SwrdB39G9GV8gN+BlJYdFKb3Af0sS8Q
         +wK3rbTZu7XOVMcktCc1MCU7G4SEmFFr2tVdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b/qh4MmnxtcchGDhc6TQCa9qodaj+wt1P6Lw841CQsE=;
        b=PPEApLLmz20ynJ3Pqj/bqixvg9ClzFpUXqPdRE1wZ+FqDch/KMnCGWb6aq8qHRFyxh
         6x5aavmWLpZv5B+Gyvjxk34ToPfAKpHQ6q8VaMgxKwQ3PO4cz8W/82XxbeS16MoGthdN
         dzL648btTuZWlrHs1epPzrT9Htxou7leNwqBv2/ff6BFKVJtxMGRF7RNl2IjCFGGDWG6
         v1uf0ITQ8hMKdsms0BH3GVQXOgy1I0gVfOAfB7nHwAkOXRB2mLXyM+bFd6Lu/btx64lD
         vuVRO9zGqV3l95dVXG7ngyc/RU6hD/ap+VfdZv5cnEHASqu5Sjapx8NpOG565zaUMSt4
         1imQ==
X-Gm-Message-State: APt69E22Jb5HJ7T/eOKsXQGabT07aSHE9yOyRoPMatrRAa2CMBmMNL0n
        fFAFrSMPSNQ72W9FEqcnwE9h8dxwNfH4kkYmliwGPA==
X-Google-Smtp-Source: AAOMgpc4/PFXdqst0QdZGWowAXs9bbGpKnd1AYmF1To5SAZzkLovUWiRXPKKKmCY2mB09wP0W6yqShmBmLPKq5zpHEw=
X-Received: by 2002:a24:64d6:: with SMTP id t205-v6mr20544353itc.138.1531247957366;
 Tue, 10 Jul 2018 11:39:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 11:39:16
 -0700 (PDT)
In-Reply-To: <93c42065-bece-a4c7-ed99-5e98f91315a6@arm.com>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180709234229.20181-3-takahiro.akashi@linaro.org> <93c42065-bece-a4c7-ed99-5e98f91315a6@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 10 Jul 2018 20:39:16 +0200
Message-ID: <CAKv+Gu_fajf3_P0wKpdV34Ungu=fn0=WG1U_MSQ9WF_2GFRfDA@mail.gmail.com>
Subject: Re: [PATCH v3.1 2/4] efi/arm: preserve early mapping of UEFI memory
 map longer for BGRT
To:     James Morse <james.morse@arm.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 July 2018 at 19:57, James Morse <james.morse@arm.com> wrote:
> Hi Ard,
>
> On 10/07/18 00:42, AKASHI Takahiro wrote:
>> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> The BGRT code validates the contents of the table against the UEFI
>> memory map, and so it expects it to be mapped when the code runs.
>>
>> On ARM, this is currently not the case, since we tear down the early
>> mapping after efi_init() completes, and only create the permanent
>> mapping in arm_enable_runtime_services(), which executes as an early
>> initcall, but still leaves a window where the UEFI memory map is not
>> mapped.
>>
>> So move the call to efi_memmap_unmap() from efi_init() to
>> arm_enable_runtime_services().
>
> I don't have a machine that generates a BGRT, but I can see that efi_mem_type()
> call in efi_bgrt_init() would cause the same problems we have with kexec and acpi.
>

I'm not sure I follow. The BGRT table only contains natively aligned
fields, so the alignment faults should not occur when accessing this
table after kexec. The issue addressed by this patch is that
efi_mem_type() bails when called while EFI_MEMMAP is cleared.

>
>> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
>> index b5214c143fee..388a929baf95 100644
>> --- a/drivers/firmware/efi/arm-init.c
>> +++ b/drivers/firmware/efi/arm-init.c
>> @@ -259,7 +259,6 @@ void __init efi_init(void)
>>
>>       reserve_regions();
>>       efi_esrt_init();
>> -     efi_memmap_unmap();
>>
>>       memblock_reserve(params.mmap & PAGE_MASK,
>>                        PAGE_ALIGN(params.mmap_size +
>> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
>> index 5889cbea60b8..59a8c0ec94d5 100644
>> --- a/drivers/firmware/efi/arm-runtime.c
>> +++ b/drivers/firmware/efi/arm-runtime.c
>> @@ -115,6 +115,8 @@ static int __init arm_enable_runtime_services(void)
>>               return 0;
>>       }
>>
>> +     efi_memmap_unmap();
>
> This can get called twice if uefi_init() fails after setting the EFI_BOOT flag,
> but this can only happen if the system table signature is wrong, (or we're out
> of memory really early).
>

I guess we should check the EFI_MEMMAP attribute here as well then.

> I think this is harmless as we end up passing NULL to early_memunmap() which
> WARN()s and returns as its outside the fixmap range. Its just more noise on
> systems with a corrupt efi system table.
>
> Acked-by: James Morse <james.morse@arm.com>
>

Thanks James
