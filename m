Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F06C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE04214FA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUErg5lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE04214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeGDStf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:49:35 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39540 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752251AbeGDStd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:49:33 -0400
Received: by mail-it0-f66.google.com with SMTP id p185-v6so9150260itp.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YKOU0/mFLqrZnq8SaepcSuK2Sz2mIDx1GjuyHLrS4Zo=;
        b=bUErg5ljww71AUhFvoNLmtAwaPTEX1ZypMCs5rtWNpQWluPQn55n0WF1QQu4x0fSUw
         BoKeo70z1EtP2ypvDU5YHGpJgMx5+AVy4bgiOakO/pl2Ix0xCjdxMU2tc4/qKB+2z4B4
         lUtrggmvJInRy0Gq4zdAFNXfqmb+VWsGZNax0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YKOU0/mFLqrZnq8SaepcSuK2Sz2mIDx1GjuyHLrS4Zo=;
        b=lHAn7DfwVMF1yYrofAPjnr0wYCLosI5EEDortP4W1gpa125dJJCKjmoezOQqYNcwwH
         88BQtZxGQTZKMARkybMhI/J9suRcq60vTE55Hai6lZnru5Cfn+4fe0qrKVCtZMykV/Op
         C8kQox13hKsnv2FaSlRyHKzdD+KEg/IsuwaOY5zdNQnmJ022JGS3spjNau1GVm/tWyIe
         Y8O+K1KEQokUFVFGVlFC9W+lJEQASdDm2HY+QmN/SSjZZfiV31c6E4ZxjVQLs1mW0bdx
         +1aNrg47FBrYCWp6CRqZRuCVc1gLlDRy71cnAVGtavnQvjuvTh+7ZzyrIS9cbKDBRaTm
         elPg==
X-Gm-Message-State: APt69E1/bTlgcQTpPhVV0F0ac2wDNJK3Yyo/4HHlr4SrPdZbQBtuBqcG
        IjcyUil61k1NTciZH+3CbEvNl3SbAwDrQtTIudQYIQ==
X-Google-Smtp-Source: AAOMgpfxAKGaAyYDa/UxP7BDxue2P52EmyuUxe8G+y/M56Iuwv7FxwLwND+gs06glUBRFwRtuAoOYjAK8N9S8Mrq9+Y=
X-Received: by 2002:a24:d7c5:: with SMTP id y188-v6mr2577688itg.50.1530730173176;
 Wed, 04 Jul 2018 11:49:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 11:49:32 -0700 (PDT)
In-Reply-To: <20180704170655.GD8370@arm.com>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-4-takahiro.akashi@linaro.org> <20180704170655.GD8370@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Jul 2018 20:49:32 +0200
Message-ID: <CAKv+Gu9_rYYyQ+t89otz46DR0D4GDj-cCjhx9q=p+D8LWFRkgQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] efi/arm: map UEFI memory map earlier on boot
To:     Will Deacon <will.deacon@arm.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        James Morse <james.morse@arm.com>,
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

On 4 July 2018 at 19:06, Will Deacon <will.deacon@arm.com> wrote:
> Hi all,
>
> [Ard -- please can you look at the EFI parts of this patch]
>
> On Tue, Jun 19, 2018 at 03:44:23PM +0900, AKASHI Takahiro wrote:
>> Since arm_enter_runtime_services() was modified to always create a virtual
>> mapping of UEFI memory map in the previous patch, it is now renamed to
>> efi_enter_virtual_mode() and called earlier before acpi_load_tables()
>> in acpi_early_init().
>>
>> This will allow us to use UEFI memory map in acpi_os_ioremap() to create
>> mappings of ACPI tables using memory attributes described in UEFI memory
>> map.
>>
>> See a relevant commit:
>>     arm64: acpi: fix alignment fault in accessing ACPI tables
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>  drivers/firmware/efi/arm-runtime.c | 15 ++++++---------
>>  init/main.c                        |  3 +++
>>  2 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
>> index 30ac5c82051e..566ef0a9edb5 100644
>> --- a/drivers/firmware/efi/arm-runtime.c
>> +++ b/drivers/firmware/efi/arm-runtime.c
>> @@ -106,46 +106,43 @@ static bool __init efi_virtmap_init(void)
>>   * non-early mapping of the UEFI system table and virtual mappings for all
>>   * EFI_MEMORY_RUNTIME regions.
>>   */
>> -static int __init arm_enable_runtime_services(void)
>> +void __init efi_enter_virtual_mode(void)
>>  {
>>       u64 mapsize;
>>
>>       if (!efi_enabled(EFI_BOOT)) {
>>               pr_info("EFI services will not be available.\n");
>> -             return 0;
>> +             return;
>>       }
>>
>>       mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
>>
>>       if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
>>               pr_err("Failed to remap EFI memory map\n");
>> -             return 0;
>> +             return;
>>       }
>>
>>       if (efi_runtime_disabled()) {
>>               pr_info("EFI runtime services will be disabled.\n");
>> -             return 0;
>> +             return;
>>       }
>>
>>       if (efi_enabled(EFI_RUNTIME_SERVICES)) {
>>               pr_info("EFI runtime services access via paravirt.\n");
>> -             return 0;
>> +             return;
>>       }
>>
>>       pr_info("Remapping and enabling EFI services.\n");
>>
>>       if (!efi_virtmap_init()) {
>>               pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
>> -             return -ENOMEM;
>> +             return;
>>       }
>>
>>       /* Set up runtime services function pointers */
>>       efi_native_runtime_setup();
>>       set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
>> -
>> -     return 0;
>>  }
>> -early_initcall(arm_enable_runtime_services);
>>
>>  void efi_virtmap_load(void)
>>  {
>> diff --git a/init/main.c b/init/main.c
>> index 3b4ada11ed52..532fc0d02353 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -694,6 +694,9 @@ asmlinkage __visible void __init start_kernel(void)
>>       debug_objects_mem_init();
>>       setup_per_cpu_pageset();
>>       numa_policy_init();
>> +     if (IS_ENABLED(CONFIG_EFI) &&
>> +         (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_ARM)))
>> +             efi_enter_virtual_mode();
>
> Hmm, this is ugly as hell. Is there nothing else we can piggy-back off?
> It's also fairly jarring that, on x86, efi_enter_virtual_mode() is called
> a few lines later, *after* acpi_early_init() has been called.
>

Currently, there is a gap where we have already torn down the early
mapping and haven't created the definitive mapping of the UEFI memory
map. There are other reasons why this is an issue, and I recently
proposed [0] myself to address one of them (and I didn't remember this
particular series, or the fact that I actually suggested this approach
IIRC)

Akashi-san, could you please confirm whether the patch below would be
sufficient for you? Apologies for going back and forth on this, but I
agree with Will that we should try to avoid warts like the one above
in generic code.

[0] https://marc.info/?l=linux-efi&m=152930773507524&w=2

> The rest of the series looks fine to me, but I'm not comfortable taking
> changes like this via the arm64 tree.
>
> Will
