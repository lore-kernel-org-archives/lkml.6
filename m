Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B07ECDFC1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0553D20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpoJ6kj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0553D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeILTmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:42:40 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36176 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeILTmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:42:39 -0400
Received: by mail-it0-f65.google.com with SMTP id u13-v6so3350072iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t2AkKMW3uG9PmM8uWvE13AYW8LWT09XOFJXk8rE9+rs=;
        b=LpoJ6kj1MZIAj4RWDpJO7wmdULde5QkARDY2VqMWixEU6WA2NR0Scr5Z/rN3Jrvu89
         Px0nKa2u2p3vgpVKKG8El/ippR0qxbWQQE67S0KPoC1IfVRxwyeE78CVcpUR0CGfwj0v
         fE9s4Hu30MAX2E5dZZ4eE9/e6U+1ykq32kQek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t2AkKMW3uG9PmM8uWvE13AYW8LWT09XOFJXk8rE9+rs=;
        b=eNn2ciy6MyePhR77xryuw2xFUyx5NkEZTpz0Vd0mbm334RjV5zJ+KEBmBp/fSRkb+c
         JcOxN+BWEFNGeS6oQ62AM1C26IxxOlXnr+5ty4FaRxAAS84LmnqKLTAEfW0+ebillfRo
         DV7Ykb3K9qbrc8r+LrckV2QH85QslB8RutQiRY1CLQarPzGLXCb9ioByNWqLNsxxpDkB
         lfO6OC5QpPoEWA2CPEi+Bu9uXQFTmDfwwMpc6+zLb4KFcD9euO1/38k6XZdsoa7EU0mD
         yWx40MscAJSMj37xvppeUpucABhGZwsa+Ild9hZLm2jdhOeULOSx92s+ZpWy5/myvdUc
         nsCg==
X-Gm-Message-State: APzg51BAz1fz5ArLih/waBJGc7ODoZwKK1glXNI0YF97eP9fi9lYbcj3
        DfBtnKYCZ/1YtvhSWFatkVvYSE+f0dP1OvajsRhLpA==
X-Google-Smtp-Source: ANB0VdbveI6Zbkez4xmT5NB+MEZCUa9O4OSZhL3Fxa6r1teWR8rAvysGfbYdxMtfxUtTkX98o8Xn8RpctVR1SnGzxuM=
X-Received: by 2002:a24:57cb:: with SMTP id u194-v6mr2182935ita.148.1536763071344;
 Wed, 12 Sep 2018 07:37:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 07:37:50
 -0700 (PDT)
In-Reply-To: <1536693322-8335-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1536693322-8335-1-git-send-email-sai.praneeth.prakhya@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 12 Sep 2018 16:37:50 +0200
Message-ID: <CAKv+Gu8zfM_iZ7T7P=5+1aXEHPaL3E2yQ_eWEsXCJA3zaAA6Yw@mail.gmail.com>
Subject: Re: [PATCH V6 0/2] Add efi page fault handler to recover from page
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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

On 11 September 2018 at 21:15, Sai Praneeth Prakhya
<sai.praneeth.prakhya@intel.com> wrote:
> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
>
> There may exist some buggy UEFI firmware implementations that access efi
> memory regions other than EFI_RUNTIME_SERVICES_<CODE/DATA> even after
> the kernel has assumed control of the platform. This violates UEFI
> specification. Hence, provide a efi specific page fault handler which
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

Did you test these patches with other buggy runtime services?

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
>    separately from illegal accesses to other regions like
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
>    functionality more appropriately.
>
> Changes from V4 to V5:
> ----------------------
> 1. Drop config option that enables efi page fault handler, instead make
>    it default.
> 2. Call schedule() in an infinite loop to account for spurious wake ups.
> 3. Introduce "NONE" as an efi runtime service function identifier so that
>    it could be used in efi_recover_from_page_fault() to check if the page
>    fault was indeed triggered by an efi runtime service.
>
> Changes from V5 to V6:
> ----------------------
> 1. Thanks to 0-day for reporting build error when CONFIG_EFI is not
>    enabled. Fixed it by calling efi page fault handler only when
>    CONFIG_EFI is enabled.
> 2. Change return type of efi page fault handler from int to void. void
>    return type should do (and int is not needed) because the efi page
>    fault handler returns only upon a failure to handle page fault.
>
> Note:
> -----
> Patch set based on "next" branch in efi tree.
>
> [1] https://drive.google.com/drive/folders/1VozKTms92ifyVHAT0ZDQe55ZYL1UE5wt
>
> Sai Praneeth (2):
>   efi: Make efi_rts_work accessible to efi page fault handler
>   x86/efi: Add efi page fault handler to recover from page faults caused
>         by the firmware
>
>  arch/x86/include/asm/efi.h              |  1 +
>  arch/x86/mm/fault.c                     |  9 ++++
>  arch/x86/platform/efi/quirks.c          | 78 +++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/runtime-wrappers.c | 61 +++++++-------------------
>  include/linux/efi.h                     | 42 ++++++++++++++++++
>  5 files changed, 147 insertions(+), 44 deletions(-)
>
> Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
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
