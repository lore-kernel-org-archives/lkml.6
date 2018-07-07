Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E06C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF8B223D6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i821K602"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF8B223D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753633AbeGGHu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:50:26 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35985 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeGGHuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:50:25 -0400
Received: by mail-it0-f65.google.com with SMTP id j185-v6so19916722ite.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 00:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dNSKmICsd6OFzn7jpHXw8XSN4FXVTue40m4dAMc1tSM=;
        b=i821K602WfgkwcnWDjCcmAMFTiY81NgvB0h5t02XtmA4w5z4fpEV3pLUKJPnpqBKIp
         yipRtMq54Ct2tPv0D+zTbNaDX1sD3NLMJrLfN1cWtWPnMJQoLEe8BI9ai5elq+P2nIzx
         JfiCJzSYI9jEKcmr7abH5nTY7mluICW0quHLiGIqJbpSognjq3wfcb7Vy2q4INhf7uLG
         cufpvmK7qL7kDu0OTjOC28UBzWYwVH51HzZoq/8A8YZAcbxTxihZT7AgsvVfLXcpEbDm
         1CNUp64X1HP4nl3iYdQJfilRfNr8Q90dfliKST5vEwTDSaPjY7UE0qti6KwsyS1QGlK6
         T0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dNSKmICsd6OFzn7jpHXw8XSN4FXVTue40m4dAMc1tSM=;
        b=jnn7NKrBA1WwPlhEwyINRHEXgisy/dxh0zezcxYkMTGn9dd2TKzdQ+W1MTKugzBrrl
         xjUprsPw23vzpEZqX4hLoKkGjOtjbUszdnZ5TTTMCoFjUlkLyciMESWe4xdUwBrpERk5
         c4nklh4XB2Gv6fLuoLujpzwQ+qv0ZYQjroSKIW2AEvvNiSOTIq4698SJoZWGO/v2T2wm
         j1K3aBoOr8N7PqSVour7JjCTIAao2ugemousjjRpAKFCzUAWC/HcuGhebbDRh6D4bcQN
         TiFOi7prCTImbwo+PY/N0xlmfCyLIGCOgYLqxS5D5Ap2NG3Ymz1Ayb6bs6t5TcoatnA0
         CNJg==
X-Gm-Message-State: APt69E18l0HVTMuLUJUbwH8pVX9KlOBzUXS2IrzY6bNaACKggcFHCc8U
        b/3GUXEXhwSCRGu/uULnS2CRlAChVdJhhDXCji8=
X-Google-Smtp-Source: AAOMgpf7z+n075aYpv9COo+RS2g92700Mp7+vCkDtkV5c0xcuTx8GEI9dY/Q2J33pTa0JQKJU6JBAGEluhHq8tiGDlI=
X-Received: by 2002:a24:3d81:: with SMTP id n123-v6mr10931408itn.40.1530949824278;
 Sat, 07 Jul 2018 00:50:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:c3cc:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 00:50:23 -0700 (PDT)
In-Reply-To: <20180706082911.13405-2-aneesh.kumar@linux.ibm.com>
References: <20180706082911.13405-1-aneesh.kumar@linux.ibm.com> <20180706082911.13405-2-aneesh.kumar@linux.ibm.com>
From:   Oliver <oohall@gmail.com>
Date:   Sat, 7 Jul 2018 17:50:23 +1000
Message-ID: <CAOSf1CH2c2MBU2TofY_TRx1jn73C75-ksR=a=H1AuSh1zxa9OA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm/pmem: Add memblock based e820 platform driver
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 6:29 PM, Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
> This patch steal system RAM and use that to emulate pmem device using the
> e820 platform driver.
>
> This adds a new kernel command line 'pmemmap' which takes the format <size[KMG]>
> to allocate memory early in the boot. This memory is later registered as
> persistent memory range.
>
> Based on original patch from Oliver OHalloran <oliveroh@au1.ibm.com>

I use this account rather than my internal address for community
facing stuff since
no one deserves to have IBM email inflicted upon them. Also you left out the
apostrophe, you monster!

> Not-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/nvdimm/Kconfig        |  13 ++++
>  drivers/nvdimm/Makefile       |   1 +
>  drivers/nvdimm/memblockpmem.c | 115 ++++++++++++++++++++++++++++++++++
>  3 files changed, 129 insertions(+)
>  create mode 100644 drivers/nvdimm/memblockpmem.c
>
> diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
> index 50d2a33de441..cbbbcbd4506b 100644
> --- a/drivers/nvdimm/Kconfig
> +++ b/drivers/nvdimm/Kconfig
> @@ -115,4 +115,17 @@ config OF_PMEM
>  config PMEM_PLATFORM_DEVICE
>         bool
>
> +config MEMBLOCK_PMEM
> +       bool "pmemmap= parameter support"
> +       default y
> +       depends on HAVE_MEMBLOCK
> +       select PMEM_PLATFORM_DEVICE
> +       help
> +         Add support for the pmemmap= kernel command line parameter. This is similar
> +         to the memmap= parameter available on ACPI platforms, but it uses generic
> +         kernel facilities (the memblock allocator) to reserve memory rather than adding
> +         to the e820 table.
> +
> +         Select Y if unsure.
> +
>  endif
> diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
> index 94f7f29146ce..0215ce0182e9 100644
> --- a/drivers/nvdimm/Makefile
> +++ b/drivers/nvdimm/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_ND_BTT) += nd_btt.o
>  obj-$(CONFIG_ND_BLK) += nd_blk.o
>  obj-$(CONFIG_PMEM_PLATFORM_DEVICE) += nd_e820.o
>  obj-$(CONFIG_OF_PMEM) += of_pmem.o
> +obj-$(CONFIG_MEMBLOCK_PMEM) += memblockpmem.o

Does this work when libnvdimm is built as a module? I remember doing
something like
this and discovering that the early_param() stuff didn't get included
in the vmlinux
when libnvdimm was built as a module due to how the makefiles worked.
It might have
been a bug in the RHEL7 tree I was using that has since been fixed upstream.

>  nd_pmem-y := pmem.o
>
> diff --git a/drivers/nvdimm/memblockpmem.c b/drivers/nvdimm/memblockpmem.c
> new file mode 100644
> index 000000000000..d39772b75fcd
> --- /dev/null
> +++ b/drivers/nvdimm/memblockpmem.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2018 IBM Corporation
> + */
> +
> +#define pr_fmt(fmt) "memblock pmem: " fmt
> +
> +#include <linux/libnvdimm.h>
> +#include <linux/bootmem.h>
> +#include <linux/memblock.h>
> +#include <linux/mmzone.h>
> +#include <linux/cpu.h>
> +#include <linux/platform_device.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/ctype.h>
> +#include <linux/slab.h>
> +
> +/*
> + * Align pmem reservations to the section size so we don't have issues with
> + * memory hotplug
> + */
> +#ifdef CONFIG_SPARSEMEM
> +#define BOOTPMEM_ALIGN (1UL << SECTION_SIZE_BITS)
> +#else
> +#define BOOTPMEM_ALIGN PFN_DEFAULT_ALIGNMENT
> +#endif

Is aligning to the section size sufficient? IIRC I had to align it to
the memory block
size on some systems. Of course, that might have been a RHEL bug that has
since been fixed upstream.

> +
> +static __initdata u64 pmem_size;
> +static __initdata phys_addr_t pmem_stolen_memory;
> +
> +static void alloc_pmem_from_memblock(void)
> +{
> +
> +       pmem_stolen_memory = memblock_alloc_base(pmem_size,
> +                                                BOOTPMEM_ALIGN,
> +                                                MEMBLOCK_ALLOC_ACCESSIBLE);
> +       if (!pmem_stolen_memory) {
> +               pr_err("Failed to allocate memory for PMEM from memblock\n");
> +               return;
> +       }
> +
> +       /*
> +        * Remove from the memblock reserved range
> +        */
> +       memblock_free(pmem_stolen_memory, pmem_size);
> +
> +       /*
> +        * Remove from the memblock memory range.
> +        */
> +       memblock_remove(pmem_stolen_memory, pmem_size);
> +       pr_info("Allocated %ld memory at 0x%lx\n", (unsigned long)pmem_size,
> +               (unsigned long)pmem_stolen_memory);
> +       return;
> +}
> +
> +/*
> + * pmemmap=ss[KMG]
> + *
> + * This is similar to the memremap=offset[KMG]!size[KMG] paramater
> + * for adding a legacy pmem range to the e820 map on x86, but it's
> + * platform agnostic.
> + *
> + * e.g. pmemmap=16G allocates 16G pmem region

I'm not really thrilled with this and I'd rather we kept the <size>@<node id>
format and the ability to reserve multiple regions that I had in the
old version.

I know getting the nid allocations working is a pain in the ass since
HAVE_MEMBLOCK_NODE_MAP doesn't specify *when* in the boot process
the node map information is actually available, but it's useful
functionality and
I think the problems are resolvable.

It's also possible that the whole memblock approach to this is wrong and we
should look at doing something similar to how gigantic pages are allocated
at runtime.

> + */
> +static int __init parse_pmemmap(char *p)
> +{
> +       char *old_p = p;
> +
> +       if (!p)
> +               return -EINVAL;
> +
> +       pmem_size = memparse(p, &p);
> +       if (p == old_p)
> +               return -EINVAL;
> +
> +       alloc_pmem_from_memblock();
> +       return 0;
> +}
> +early_param("pmemmap", parse_pmemmap);
> +
> +static __init int register_e820_pmem(void)
> +{
> +       struct resource *res, *conflict;
> +        struct platform_device *pdev;
> +
> +       if (!pmem_stolen_memory)
> +               return 0;
> +
> +       res = kzalloc(sizeof(*res), GFP_KERNEL);
> +       if (!res)
> +               return -1;
> +
> +       memset(res, 0, sizeof(*res));
> +       res->start = pmem_stolen_memory;
> +       res->end = pmem_stolen_memory + pmem_size - 1;
> +       res->name = "Persistent Memory (legacy)";
> +       res->desc = IORES_DESC_PERSISTENT_MEMORY_LEGACY;
> +       res->flags = IORESOURCE_MEM;
> +
> +       conflict = insert_resource_conflict(&iomem_resource, res);
> +       if (conflict) {
> +               pr_err("%pR conflicts, try insert below %pR\n", res, conflict);
> +               kfree(res);
> +               return -1;
> +       }
> +       /*
> +        * See drivers/nvdimm/e820.c for the implementation, this is
> +        * simply here to trigger the module to load on demand.
> +        */
> +       pdev = platform_device_alloc("e820_pmem", -1);
> +
> +       return platform_device_add(pdev);
> +}
> +device_initcall(register_e820_pmem);
> --
> 2.17.1
>
