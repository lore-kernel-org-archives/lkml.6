Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4C8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC2620857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2dxgezl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC2620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeIEQ5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:57:53 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53898 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeIEQ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:57:53 -0400
Received: by mail-it0-f68.google.com with SMTP id p79-v6so9573668itp.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pe7VZjjLvycpJGBQno6LjcgBfzQHhNQqWM49CK1lMCE=;
        b=Z2dxgezlvGVvQIXlKW7ZX9IBbENy+tKTH3CZRwD5+Ie7TKZ6l8DJlhEAnU0ahprNBA
         h4Q8G9avmg/xsP3cOuGh/CYjaQbOopD+7AO9cAbXemPPlJXBpUklF/XbhvcVtrstRDCp
         boB1m41HnyyOV7vzjT8sXwNZAXNdcc9Ztpn98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pe7VZjjLvycpJGBQno6LjcgBfzQHhNQqWM49CK1lMCE=;
        b=jeeMwmN3wK8lN4Cgcz/GVumb5WBa8mQ5gql21iEuuf1CAF+l+OrGZPZSepDlvz3P4S
         wF7RZ5vJfsI8sYLsab0GcPGKF/Jb7ZtI0uOhrtXVY/yShsR1Dqq4npVyoPeAamSxaCrc
         nD2ECOpKVJXXlPP5R/4b5oTWkJvcwnUGJu+vOImKFRTV4+FdAYjo+8EWIUitMBj2WfHb
         Ii9LGOQrFRtQ4Vs6pxw7T1BkHwpM4SnU/uWe7PecmnwqBcX+EfKal1pRst8DJr8rGI1A
         Et0okwORhtXWeK4mMHi5AC+Ux4UewH6SflSH8gwq5kVqSG7OhskQgyhSsJVRQQ0+5quq
         fN/Q==
X-Gm-Message-State: APzg51CGPgcEnboTOukLTJv6vQMBkIlWjirWuj78stTa4xrtNEhvbhr8
        1PsR0cMPd6jPdQ9VufQTyjfA8Ky0+QXf5TEPU+Mi7w==
X-Google-Smtp-Source: ANB0VdaC/nJ6iev0R82DR10HmjdA5QE6lvjcjcAgbkGw8EwWbkIjEn4eKczbmCo9VIoX12tnU7BYNup8ek2w0v2vuw0=
X-Received: by 2002:a02:1515:: with SMTP id j21-v6mr26390389jad.2.1536150470602;
 Wed, 05 Sep 2018 05:27:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1c06:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 05:27:49 -0700 (PDT)
In-Reply-To: <1536099149-12564-4-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1536099149-12564-1-git-send-email-sai.praneeth.prakhya@intel.com> <1536099149-12564-4-git-send-email-sai.praneeth.prakhya@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 5 Sep 2018 14:27:49 +0200
Message-ID: <CAKv+Gu9mfWYww49OmBETutSsaTDfE6VFJjbf+LWAoXF=mNmDBA@mail.gmail.com>
Subject: Re: [PATCH V3 3/5] x86/efi: Permanently save the EFI_MEMORY_MAP
 passed by the firmware
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

On 5 September 2018 at 00:12, Sai Praneeth Prakhya
<sai.praneeth.prakhya@intel.com> wrote:
> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
>
> The efi page fault handler that recovers from page faults caused by the
> firmware needs the original memory map passed by the firmware. It looks
> up this memory map to find the type of the memory region at which the
> page fault occurred. Presently, EFI subsystem discards the original
> memory map passed by the firmware and replaces it with a new memory map
> that has only EFI_RUNTIME_SERVICES_<CODE/DATA> regions. But illegal
> accesses by firmware can occur at any region. Hence, _only_ if
> CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS is defined, create a backup of the
> original memory map passed by the firmware, so that efi page fault
> handler could detect/recover from illegal accesses to *any* efi region.
>

Why do we care about the memory map at all when a fault occurs during
the invocation of a EFI runtime service?

I think reasoning about what went wrong and why, and distinguishing
between allowable and non-allowable faults is a slippery slope, so
[taking Thomas's feedback into account], I think we can simplify this
series further and just block all subsequent EFI runtime services
calls if any permission or page fault occurs while executing them.

Would we still need to preserve the old memory map in that case?

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
> ---
>  arch/x86/include/asm/efi.h     |  6 ++++++
>  arch/x86/platform/efi/efi.c    |  2 ++
>  arch/x86/platform/efi/quirks.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
>
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index cec5fae23eb3..788ed4cbce22 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -141,6 +141,12 @@ extern int __init efi_reuse_config(u64 tables, int nr_tables);
>  extern void efi_delete_dummy_variable(void);
>  extern void efi_switch_mm(struct mm_struct *mm);
>
> +#ifdef CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS
> +extern void __init efi_save_original_memmap(void);
> +#else
> +static inline void __init efi_save_original_memmap(void) { }
> +#endif /* CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS */
> +
>  struct efi_setup_data {
>         u64 fw_vendor;
>         u64 runtime;
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 9061babfbc83..7a3ea4cd5939 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -946,6 +946,8 @@ static void __init __efi_enter_virtual_mode(void)
>
>         pa = __pa(new_memmap);
>
> +       efi_save_original_memmap();
> +
>         /*
>          * Unregister the early EFI memmap from efi_init() and install
>          * the new EFI memory map that we are about to pass to the
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 844d31cb8a0c..36b0b042ba56 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -654,3 +654,51 @@ int efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
>  }
>
>  #endif
> +
> +#ifdef CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS
> +
> +static bool original_memory_map_present;
> +static struct efi_memory_map original_memory_map;
> +
> +/*
> + * The efi page fault handler that recovers from page faults caused by
> + * buggy firmware needs original memory map passed by firmware. Hence,
> + * build a new EFI memmap that has all entries and save it for later use.
> + */
> +void __init efi_save_original_memmap(void)
> +{
> +       efi_memory_desc_t *md;
> +       void *remapped_phys, *new_md;
> +       phys_addr_t new_phys, new_size;
> +
> +       new_size = efi.memmap.desc_size * efi.memmap.nr_map;
> +       new_phys = efi_memmap_alloc(efi.memmap.nr_map);
> +       if (!new_phys) {
> +               pr_err("Failed to allocate new EFI memmap\n");
> +               return;
> +       }
> +
> +       remapped_phys = memremap(new_phys, new_size, MEMREMAP_WB);
> +       if (!remapped_phys) {
> +               pr_err("Failed to remap new EFI memmap\n");
> +               __free_pages(pfn_to_page(PHYS_PFN(new_phys)), get_order(new_size));
> +               return;
> +       }
> +
> +       new_md = remapped_phys;
> +       for_each_efi_memory_desc(md) {
> +               memcpy(new_md, md, efi.memmap.desc_size);
> +               new_md += efi.memmap.desc_size;
> +       }
> +
> +       original_memory_map.late = 1;
> +       original_memory_map.phys_map = new_phys;
> +       original_memory_map.map = remapped_phys;
> +       original_memory_map.nr_map = efi.memmap.nr_map;
> +       original_memory_map.desc_size = efi.memmap.desc_size;
> +       original_memory_map.map_end = remapped_phys + new_size;
> +       original_memory_map.desc_version = efi.memmap.desc_version;
> +
> +       original_memory_map_present = true;
> +}
> +#endif /* CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS */
> --
> 2.7.4
>
