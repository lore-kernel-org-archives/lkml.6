Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1236BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AC62075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AYCgIe4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AC62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeIGPXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:23:14 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39246 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIGPXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:23:13 -0400
Received: by mail-io1-f65.google.com with SMTP id l7-v6so1172255iok.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+pdgGxpNt76Ff97dz/GB4hRiYCEs6CJ/RGMqyekc/Og=;
        b=AYCgIe4cxkQdzKL8fC8K3Rik/V6ZYJTEWaL9n40P/0D7NeQYZ5PcuHNDBXQG4DpeKw
         n7IWRvwUsRQXSE2Ic1UrQ4RbHnU7cAOC3lQc86iXXJvK6ASr6/259/5pJirUpfHUVNMJ
         pjrA6UMb6enwq1pDYE4fL8Mt1ztX++4m1mN2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+pdgGxpNt76Ff97dz/GB4hRiYCEs6CJ/RGMqyekc/Og=;
        b=KpNwVKOUZntERx0eI/BJeyOl6MIFwGfORldr3OgjNvJvSYjqdusqiHxbbL13hRv144
         zG+FtSTIakjo36j7YwF1A0SdBsdcJkY4GxQfnATU08ataP2zPYaBoNQdLYXt69CnBkRz
         syeS5M4ASAWTaUrANTsJt2WjCErnsKaF4Kxwx1PzpPLHyPGWkSrwI/s51wFQtMlquZkV
         QBCT9MYfJlikzTi281OyrtBRxSSDKFcfDFrUtHjnfw/s7zyaMVC6ffshlMlYl8cEXZem
         C5NL6TgN8naWrKztL2UlfwfTGafK6raWsbveHt2yJ6WmfTZnxlzf6dHTeBNBzjOsmLL2
         LuXQ==
X-Gm-Message-State: APzg51ACnYAktjQS5MzUAX9vXEg8a0fGJu3VfgMKXJLXF3ahyCRuUDFd
        9hmk15R/CF/tzW0hjGAkYk5o61+Yf2yvgfIK7tLFgg==
X-Google-Smtp-Source: ANB0VdaK6ibMVHQ3dk/7WjTjGS+LeOsoKgNOeleW/ICpjglM33zSqed5SHgfGIWKy+aDcZMxU7wjxWQmsJULVXzvOOQ=
X-Received: by 2002:a6b:4516:: with SMTP id s22-v6mr5856688ioa.60.1536316971412;
 Fri, 07 Sep 2018 03:42:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1c06:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 03:42:51 -0700 (PDT)
In-Reply-To: <1536276468-28499-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1536276468-28499-1-git-send-email-sai.praneeth.prakhya@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Sep 2018 12:42:51 +0200
Message-ID: <CAKv+Gu8F76ngzr_zgAXZhDPNb2SobYc4A8L3Rq-h1kMrbFqK+A@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] Add efi page fault handler to recover from page
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 September 2018 at 01:27, Sai Praneeth Prakhya
<sai.praneeth.prakhya@intel.com> wrote:
> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
>
> There may exist some buggy UEFI firmware implementations that access efi
> memory regions other than EFI_RUNTIME_SERVICES_<CODE/DATA> even after
> the kernel has assumed control of the platform. This violates UEFI
> specification. Hence, provide a debug config option which when enabled
> recovers from page faults caused by buggy firmware.
>
> Page faults triggered by firmware happen at ring 0 and if unhandled,
> hangs the kernel. So, provide an efi specific page fault handler to:
> 1. Avoid panics/hangs caused by buggy firmware.
> 2. Shout loud that the firmware is buggy and hence is not a kernel bug.
>
> The efi page fault handler will check if the access is by
> efi_reset_system().
> 1. If so, then the efi page fault handler will reboot the machine
>    through BIOS and not through efi_reset_system().
> 2. If not, then the efi page fault handler will freeze efi_rts_wq and
>    schedules a new process.
>

Thanks Sai! I am pretty happy how this patch set turned out. It still
requires the blessing of the x86 maintainers, of course, but from my
pov, this is good to go (but I will fold patch #3 into #2)

Thomas, Ingo, Peter, Andy, Boris: any remaining concerns?


> This issue was reported by Al Stone when he saw that reboot via EFI hangs
> the machine. Upon debugging, I found that it's efi_reset_system() that's
> touching memory regions which it shouldn't. To reproduce the same
> behavior, I have hacked OVMF and made efi_reset_system() buggy. Along
> with efi_reset_system(), I have also modified get_next_high_mono_count()
> and set_virtual_address_map(). They illegally access both boot time and
> other efi regions.
>
> Testing the patch set:
> ----------------------
> 1. Download buggy firmware from here [1].
> 2. Run a qemu instance with this buggy BIOS and boot mainline kernel.
> Add reboot=efi to the kernel command line arguments and after the kernel
> is up and running, type "reboot". The kernel should hang while rebooting.
> 3. With the same setup, boot kernel after applying patches and the
> reboot should work fine. Also please notice warning/error messages
> printed by kernel.
>
> Changes from RFC to V1:
> -----------------------
> 1. Drop "long jump" technique of dealing with illegal access and instead
>    use scheduling away from efi_rts_wq.
>
> Changes from V1 to V2:
> ----------------------
> 1. Shortened config name to CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS from
>    CONFIG_EFI_WARN_ON_ILLEGAL_ACCESSES.
> 2. Made the config option available only to expert users.
> 3. efi_free_boot_services() should be called only when
>    CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS is not enabled. Previously, this
>    was part of init/main.c file. As it is an architecture agnostic code,
>    moved the change to arch/x86/platform/efi/quirks.c file.
>
> Changes from V2 to V3:
> ----------------------
> 1. Drop treating illegal access to EFI_BOOT_SERVICES_<CODE/DATA> regions
>    separatley from illegal accesses to other regions like
>    EFI_CONVENTIONAL_MEMORY or EFI_LOADER_<CODE/DATA>.
>    In previous versions, illegal access to EFI_BOOT_SERVICES_<CODE/DATA>
>    regions were handled by mapping requested region to efi_pgd but from
>    V3 they are handled similar to illegal access to other regions i.e by
>    freezing efi_rts_wq and scheduling new process.
> 2. Change __efi_init_fixup attribute to __efi_init.
>
> Changes from V3 to V4:
> ----------------------
> 1. Drop saving original memory map passed by kernel. It also means less
>    checks in efi page fault handler.
> 2. Change the config name to EFI_PAGE_FAULT_HANDLER to reflect it's
>    functionality more appropriatley.
>
> Note:
> -----
> Patch set based on "next" branch in efi tree.
>
> [1] https://drive.google.com/drive/folders/1VozKTms92ifyVHAT0ZDQe55ZYL1UE5wt
>
> Sai Praneeth (3):
>   efi: Make efi_rts_work accessible to efi page fault handler
>   x86/efi: Add efi page fault handler to recover from page faults caused
>         by the firmware
>   x86/efi: Introduce EFI_PAGE_FAULT_HANDLER
>
>  arch/x86/Kconfig                        | 18 +++++++++
>  arch/x86/include/asm/efi.h              |  9 +++++
>  arch/x86/mm/fault.c                     |  9 +++++
>  arch/x86/platform/efi/quirks.c          | 70 +++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/runtime-wrappers.c | 60 ++++++++--------------------
>  include/linux/efi.h                     | 37 +++++++++++++++++
>  6 files changed, 159 insertions(+), 44 deletions(-)
>
> Suggested-by: Matt Fleming <matt@codeblueprint.co.uk>
> Based-on-code-from: Ricardo Neri <ricardo.neri@intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Cc: Al Stone <astone@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> --
> 2.7.4
>
