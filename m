Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A479AC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E69621A17
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gW5+3jEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E69621A17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeGEJ3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:29:48 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36270 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeGEJ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:29:46 -0400
Received: by mail-it0-f66.google.com with SMTP id j185-v6so11128522ite.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m89fABEqJZ/Hp5NPGBnJLkss6myRkmUmGEIMnT/ty68=;
        b=gW5+3jEUcIg54XT4Fm9Qw69yuze+gLo+Lb/Gt03H7ao7ubikSCa9gBStw2pg27IwMh
         Tb3XqGbEkOLEr9EWLu+KHTOA9N724qx423MIZKu7++eqXWbydPzPUS8EWQoa+fJmBd3B
         IU0kSu4sVjjPwFB+qJg63mfqISZj/zvc91oMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m89fABEqJZ/Hp5NPGBnJLkss6myRkmUmGEIMnT/ty68=;
        b=X8cIBdysvBZSGtbMpwB96YYbSfb90/fBNFeHrrzA9pR92GdjdbMzaF8ntwskHaTd3j
         zqb+Fx8pryY/XN3P03TdwSxxehx6oYKJX+wdr84AfgZBcDBv40rMl67Bq8NbjofJxAmH
         d280l/6sxmwygVCvmRclFkay+sDyCzh1VsPEjMX1uvYhwRd46VZRwMRr7niYeqRRP+jD
         SALIlwMnQc7zuhbAG6JG9WEHHu+NYajj4b8/YEdObGNResjoTHY3Vuz8h/sfpwpquq23
         Hk0wJKGABgKvgXlz02Lae/pBCAUBiIIKwRpt01TXsLfVFW1RXxSbh0fwjOw7EnHQBJyI
         PG6g==
X-Gm-Message-State: APt69E17dSdtHAe7cFinneGGtEvtr0p15f1aM1qxi1aGiJagwUAQJxDw
        eevUKUHm1ntZfjKWJYtFvXLQm2Qk8Vu411gF14BJcg==
X-Google-Smtp-Source: AAOMgpf4gdc8p4sNjPlo5Gq69hfbjdqUTRRDqcfZiVHy+tJ6UpaoAxV7ime5LKvO0CnYnn7fyrkiRR/KR+ikGpzrLbg=
X-Received: by 2002:a02:4187:: with SMTP id n7-v6mr4242145jad.86.1530782985886;
 Thu, 05 Jul 2018 02:29:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 02:29:45 -0700 (PDT)
In-Reply-To: <1530582654-25662-2-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1530582654-25662-1-git-send-email-sai.praneeth.prakhya@intel.com> <1530582654-25662-2-git-send-email-sai.praneeth.prakhya@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 5 Jul 2018 11:29:45 +0200
Message-ID: <CAKv+Gu8FjCojLTckLVcOq1z4e=pp4U8GQWVHpvHTewRgef6HDg@mail.gmail.com>
Subject: Re: [PATCH 1/6] efi: Introduce efi_memmap_free() to free memory
 allocated by efi_memmap_alloc()
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Dave Young <dyoung@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Laszlo Ersek <lersek@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Nicolai Stange <nicstange@gmail.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 July 2018 at 03:50, Sai Praneeth Prakhya
<sai.praneeth.prakhya@intel.com> wrote:
> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
>
> efi_memmap_alloc() allocates memory depending on whether mm_init() has
> already been invoked or not. Apart from memblock_alloc() memory and
> alloc_pages() memory, efi memory map could also have a third variant of
> memory allocation and that is memblock_reserved. This happens only for
> the memory map passed to kernel by firmware and thus can happen only
> once during boot process.
>
> In order to identify these three different types of allocations and thus
> to call the appropriate free() variant, introduce an enum named
> efi_memmap_type and also introduce a efi memmap API named
> efi_memmap_free() to free memory allocated by efi_memmap_alloc().
>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Lee Chun-Yi <jlee@suse.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: Nicolai Stange <nicstange@gmail.com>
> Cc: Naresh Bhat <naresh.bhat@linaro.org>
> Cc: Ricardo Neri <ricardo.neri@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> Cc: Ravi Shankar <ravi.v.shankar@intel.com>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Do you really think you should cc all these people?

> ---
>  drivers/firmware/efi/memmap.c | 28 ++++++++++++++++++++++++++++
>  include/linux/efi.h           |  8 ++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 5fc70520e04c..0686e063c644 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -12,6 +12,7 @@
>  #include <asm/early_ioremap.h>
>  #include <linux/memblock.h>
>  #include <linux/slab.h>
> +#include <linux/bootmem.h>
>
>  static phys_addr_t __init __efi_memmap_alloc_early(unsigned long size)
>  {
> @@ -50,6 +51,33 @@ phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
>  }
>
>  /**
> + * efi_memmap_free - Free memory allocated by efi_memmap_alloc()
> + * @mem: Physical address allocated by efi_memmap_alloc().
> + * @num_entries: Number of entries in the allocated map.
> + * @alloc_type: What type of allocation did efi_memmap_alloc() perform?
> + *
> + * Use this function to free memory allocated by efi_memmap_alloc().
> + * efi_memmap_alloc() allocates memory depending on whether mm_init()
> + * has already been invoked or not. It uses either memblock or "normal"
> + * page allocation, similarly, we free it in two different ways. Also
> + * note that there is a third type of memory used by memmap which is
> + * memblock_reserved() and is passed by EFI stub to kernel.
> + */
> +void __init efi_memmap_free(phys_addr_t mem, unsigned int num_entries,
> +                           enum efi_memmap_type alloc_type)
> +{
> +       unsigned long size = num_entries * efi.memmap.desc_size;
> +       unsigned int order = get_order(size);
> +
> +       if (alloc_type == BUDDY_ALLOCATOR)
> +               __free_pages(pfn_to_page(PHYS_PFN(mem)), order);
> +       else if (alloc_type == MEMBLOCK)
> +               memblock_free(mem, size);
> +       else
> +               free_bootmem(mem, size);
> +}
> +
> +/**
>   * __efi_memmap_init - Common code for mapping the EFI memory map
>   * @data: EFI memory map data
>   * @late: Use early or late mapping function?
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 56add823f190..455875c01ed1 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -765,6 +765,12 @@ struct efi_memory_map_data {
>         unsigned long desc_size;
>  };
>
> +enum efi_memmap_type {
> +       EFI_STUB,
> +       MEMBLOCK,
> +       BUDDY_ALLOCATOR,
> +};
> +
>  struct efi_memory_map {
>         phys_addr_t phys_map;
>         void *map;
> @@ -1016,6 +1022,8 @@ extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
>                                          struct range *range);
>  extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
>                                      void *buf, struct efi_mem_range *mem);
> +extern void __init efi_memmap_free(phys_addr_t mem, unsigned int num_entries,
> +                                  enum efi_memmap_type alloc_type);
>
>  extern int efi_config_init(efi_config_table_type_t *arch_tables);
>  #ifdef CONFIG_EFI_ESRT
> --
> 2.7.4
>

Sai,

Thanks a lot for respinning all of this.

I am now thinking we should perhaps hide the allocation type from the
callers rather than passing around implementation details of the
allocator, and have explicit alloc/free operations.

Could we instead have a single 'efi_realloc_memmap()' function that
takes care of all of this? We'd still need a free routine for error
handling, I suppose, but it would get rid of the need for obscure
enums or bools that the callers have to pass around.
