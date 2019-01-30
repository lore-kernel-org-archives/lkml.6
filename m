Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30E8C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6456720815
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lbguf23I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfA3KdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:33:06 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43725 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbfA3KdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:33:06 -0500
Received: by mail-ua1-f68.google.com with SMTP id z11so7869339uaa.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 02:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOYEa1uGhnGbGrKtGX9TM2YlM3ZvcBe6/zv/6oGKCv0=;
        b=Lbguf23IMsVHJ71w+vahku30s+XqZ+bpODw3a0TGzoy5/lG6VBQakGMEIa92s4X85/
         Khbr2VOeZMek9ZUxAA6/nofNDnXAocJhCueCLrF8ghAu2PW6TW6JzJ01JdWVHW3hIXKQ
         upnWZa8IFtUuKwt353Ap2vwWHO0b6q2mgPy7WRbIxO7Y+uOD6FRPZQ9vZ/lPVl/a8CbY
         kZfGKybyBV4qNY21eA0BSPMGkOEAGLXc3CVyByH1uH0Nlk2zSm0Myq2/ZWXQjhMpSMgb
         OLQkkZEjRn5fyC+zBsALwM//1QPo3d3CsAuz2NLWRcl/TYAi1azwuh7PZshtnJwF706I
         BuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOYEa1uGhnGbGrKtGX9TM2YlM3ZvcBe6/zv/6oGKCv0=;
        b=qpZ7A00TLHeAT88hxUzkdq5U5QJ9IAdUIG8JvowLFrs7XV35/d4K7F/dcIfKngMw/k
         IbpHkr7mNffJYOx+0SqZ0rHTc8TfcLQl3k1AmLs2neNPc/3po5OJFkcPXu5jUv3ItW2b
         x96geRW9N3E4ifYN7uPBfqXejw64/+g36CJAbRuPa8MrIEHC05NBj4mGIEe28z9Pj42b
         thDdzxg/wQEke5hKAuE4pF5bc9JWd1vUPXR37bc8OYDCAkyngb5tFcnxYr5S4B/vD7px
         qNgpRSNpaMmSZtK1KaOt+5+LqOQAr78IJpz0OaPnbFSixycOzU5C+x5z6HX4jQElTxQS
         lPQQ==
X-Gm-Message-State: AJcUuke41kmE/UlTYapvgKZjeQDRzpIY1VrhOfdUsN8EbTB+ctlZzbRe
        7ZMgdCMhuujKlZ19mtVBsfv/uMe4R4XqG74aHDeXSQ==
X-Google-Smtp-Source: ALg8bN45g0mv0lphmE62HQtDvFLdlyG9CWrXyVDzD3/y8OtGPaj+MYBc4L2j9Dq2c+DeEsrlyk6wY7nZvx85vPCq1hw=
X-Received: by 2002:ab0:4e23:: with SMTP id g35mr12574253uah.8.1548844384358;
 Wed, 30 Jan 2019 02:33:04 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <20190123000057.31477-13-oded.gabbay@gmail.com>
 <20190127161256.GA985@rapoport-lnx>
In-Reply-To: <20190127161256.GA985@rapoport-lnx>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 30 Jan 2019 12:34:37 +0200
Message-ID: <CAFCwf11zwG5PCwhkgfp21JM2LY8xPJkakX8JW6Q4jqQvVkusBQ@mail.gmail.com>
Subject: Re: [PATCH 12/15] habanalabs: add virtual memory and MMU modules
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai, Omer Shpigelman <oshpigelman@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 6:13 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Wed, Jan 23, 2019 at 02:00:54AM +0200, Oded Gabbay wrote:
> > From: Omer Shpigelman <oshpigelman@habana.ai>
> >
> > This patch adds the Virtual Memory and MMU modules.
> >
> > Goya has an internal MMU which provides process isolation on the internal
> > DDR. The internal MMU also performs translations for transactions that go
> > from Goya to the Host.
> >
> > The driver is responsible for allocating and freeing memory on the DDR
> > upon user request. It also provides an interface to map and unmap DDR and
> > Host memory to the device address space.
> >
> > Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> >  drivers/misc/habanalabs/Makefile              |    2 +-
> >  drivers/misc/habanalabs/context.c             |   19 +-
> >  drivers/misc/habanalabs/device.c              |   20 +-
> >  drivers/misc/habanalabs/goya/goya.c           |  391 +++++
> >  drivers/misc/habanalabs/habanalabs.h          |  195 +++
> >  drivers/misc/habanalabs/habanalabs_drv.c      |    2 +-
> >  drivers/misc/habanalabs/habanalabs_ioctl.c    |    3 +-
> >  drivers/misc/habanalabs/include/goya/goya.h   |    6 +-
> >  .../include/hw_ip/mmu/mmu_general.h           |   45 +
> >  .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
> >  drivers/misc/habanalabs/memory.c              | 1506 +++++++++++++++++
> >  drivers/misc/habanalabs/mmu.c                 |  604 +++++++
> >  include/uapi/misc/habanalabs.h                |  122 +-
> >  13 files changed, 2922 insertions(+), 8 deletions(-)
> >  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
> >  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
> >  create mode 100644 drivers/misc/habanalabs/mmu.c
>
> [ ... ]
>
> > diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> > index e3867615b974..94ee4cb00a49 100644
> > --- a/drivers/misc/habanalabs/goya/goya.c
> > +++ b/drivers/misc/habanalabs/goya/goya.c
>
> [ ... ]
>
> > @@ -265,6 +332,10 @@ static u32 goya_non_fatal_events[GOYA_ASYC_EVENT_GROUP_NON_FATAL_SIZE] = {
> >  };
> >
> >  static int goya_armcp_info_get(struct hl_device *hdev);
> > +static void goya_mmu_prepare(struct hl_device *hdev, u32 asid);
> > +static int goya_mmu_clear_pgt_range(struct hl_device *hdev);
> > +static int goya_mmu_update_asid_hop0_addr(struct hl_device *hdev, u32 asid,
> > +                                     u64 phys_addr);
>
> Nit: are the static declarations are necessary? Or it's a matter of moving
> code around?
Honestly, it's a bit of an issue moving them now. Those function call
other functions and if I will need to move the first ones I will need
to move the others as well and may end in some circular dependency.

>
> >
> >  static void goya_get_fixed_properties(struct hl_device *hdev)
> >  {
> > @@ -303,6 +374,16 @@ static void goya_get_fixed_properties(struct hl_device *hdev)
> >       prop->sram_user_base_address = prop->sram_base_address +
> >                                               SRAM_USER_BASE_OFFSET;
> >
> > +     prop->mmu_pgt_addr = MMU_PAGE_TABLES_ADDR;
> > +     if (hdev->pldm)
> > +             prop->mmu_pgt_size = 0x800000; /* 8MB */
> > +     else
> > +             prop->mmu_pgt_size = MMU_PAGE_TABLES_SIZE;
> > +     prop->mmu_pte_size = PTE_SIZE;
> > +     prop->mmu_hop_table_size = HOP_TABLE_SIZE;
> > +     prop->mmu_hop0_tables_total_size = HOP0_TABLES_TOTAL_SIZE;
> > +     prop->dram_page_size = PAGE_SIZE_2MB;
> > +
> >       prop->host_phys_base_address = HOST_PHYS_BASE;
> >       prop->va_space_host_start_address = VA_HOST_SPACE_START;
> >       prop->va_space_host_end_address = VA_HOST_SPACE_END;
>
> [ ... ]
>
> > diff --git a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
> > new file mode 100644
> > index 000000000000..8d61ee4f2d17
> > --- /dev/null
> > +++ b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
> > @@ -0,0 +1,45 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * Copyright 2016-2018 HabanaLabs, Ltd.
> > + * All Rights Reserved.
> > + *
> > + */
> > +
> > +#ifndef INCLUDE_MMU_GENERAL_H_
> > +#define INCLUDE_MMU_GENERAL_H_
> > +
> > +#define PAGE_SHIFT_4KB                       12
> > +#define PAGE_SHIFT_2MB                       21
> > +#define PAGE_SIZE_2MB                        (_AC(1, UL) << PAGE_SHIFT_2MB)
> > +#define PAGE_SIZE_4KB                        (_AC(1, UL) << PAGE_SHIFT_4KB)
> > +
> > +#define PAGE_PRESENT_MASK            0x0000000000001
> > +#define SWAP_OUT_MASK                        0x0000000000004
> > +#define LAST_MASK                    0x0000000000800
> > +#define PHYS_ADDR_MASK                       0x3FFFFFFFFF000ull
> > +#define HOP0_MASK                    0x3000000000000ull
> > +#define HOP1_MASK                    0x0FF8000000000ull
> > +#define HOP2_MASK                    0x0007FC0000000ull
> > +#define HOP3_MASK                    0x000003FE00000
> > +#define HOP4_MASK                    0x00000001FF000
> > +#define OFFSET_MASK                  0x0000000000FFF
> > +
> > +#define HOP0_SHIFT                   48
> > +#define HOP1_SHIFT                   39
> > +#define HOP2_SHIFT                   30
> > +#define HOP3_SHIFT                   21
> > +#define HOP4_SHIFT                   12
> > +
> > +#define PTE_PHYS_ADDR_SHIFT          12
> > +#define PTE_PHYS_ADDR_MASK           ~0xFFF
> > +
> > +#define PTE_SIZE                     sizeof(u64)
>
> I suspect some architectures define PTE_SIZE in arch/*/include/asm
> Probably you'd want to namespace this.
>
Fixed


> > +#define HOP_TABLE_SIZE                       PAGE_SIZE_4KB
> > +#define HOP0_TABLES_TOTAL_SIZE               (HOP_TABLE_SIZE * MAX_ASID)
> > +
> > +#define MMU_HOP0_PA43_12_SHIFT               12
> > +#define MMU_HOP0_PA49_44_SHIFT               (12 + 32)
> > +
> > +#define MMU_CONFIG_TIMEOUT_USEC              2000 /* 2 ms */
> > +
> > +#endif /* INCLUDE_MMU_GENERAL_H_ */
> > diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> > index 94cbb252656d..c41ea19502e5 100644
> > --- a/drivers/misc/habanalabs/memory.c
> > +++ b/drivers/misc/habanalabs/memory.c
> > @@ -5,12 +5,1193 @@
> >   * All Rights Reserved.
> >   */
> >
> > +#include <uapi/misc/habanalabs.h>
> >  #include "habanalabs.h"
> > +#include "include/hw_ip/mmu/mmu_general.h"
> >
> >  #include <linux/sched.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/genalloc.h>
> >
> > +#define HL_MMU_DEBUG 0
> > +
> > +/*
> > + * The va ranges in context object contain a list with the available chunks of
> > + * device virtual memory.
> > + * There is one range for host allocations and one for DRAM allocations.
> > + *
> > + * On initialization each range contains one chunk of all of its available
> > + * virtual range which is a half of the total device virtual range.
> > + *
> > + * On each mapping of physical pages, a suitable virtual range chunk (with a
> > + * minimum size) is selected from the list. If the chunk size equals the
> > + * requested size, the chunk is returned. Otherwise, the chunk is split into
> > + * two chunks - one to return as result and a remainder to stay in the list.
> > + *
> > + * On each Unmapping of a virtual address, the relevant virtual chunk is
> > + * returned to the list. The chunk is added to the list and if its edges match
> > + * the edges of the adjacent chunks (means a contiguous chunk can be created),
> > + * the chunks are merged.
> > + *
> > + * On finish, the list is checked to have only one chunk of all the relevant
> > + * virtual range (which is a half of the device total virtual range).
> > + * If not (means not all mappings were unmapped), a warning is printed.
> > + */
> > +
> > +/**
> > + * alloc_device_memory - allocate device memory
> > + *
> > + * @ctx                 : current context
> > + * @args                : host parameters containing the requested size
> > + * @ret_handle          : result handle
> > + *
> > + * This function does the following:
> > + * - Allocate the requested size rounded up to 2MB pages
> > + * - Return unique handle
> > + */
> > +static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> > +                             u32 *ret_handle)
> > +{
> > +     struct hl_device *hdev = ctx->hdev;
> > +     struct hl_vm *vm = &hdev->vm;
> > +     struct hl_vm_phys_pg_list *phys_pg_list;
> > +     struct hl_vm_phys_pg *phys_pg, *tmp;
> > +     u64 paddr = 0;
> > +     u32 total_size, num_pgs, page_size, page_shift;
> > +     int handle, rc, i;
> > +     bool contiguous;
> > +
> > +     page_size = hdev->asic_prop.dram_page_size;
> > +     page_shift = __ffs(page_size);
>
> Maybe it's worth storing page_shift in the asi_prop and calculating
> page_size.
>
> > +     num_pgs = (args->alloc.mem_size + (page_size - 1)) >> page_shift;
> > +     total_size = num_pgs << page_shift;
> > +
> > +     contiguous = args->flags & HL_MEM_CONTIGUOUS;
> > +
> > +     if (contiguous) {
> > +             paddr = (u64) gen_pool_alloc(vm->dram_pg_pool, total_size);
> > +             if (!paddr) {
> > +                     dev_err(hdev->dev,
> > +                             "failed to allocate %u huge contiguous pages\n",
> > +                             num_pgs);
> > +                     return -ENOMEM;
> > +             }
> > +     }
> > +
> > +     phys_pg_list = kzalloc(sizeof(*phys_pg_list), GFP_KERNEL);
> > +     if (!phys_pg_list) {
> > +             rc = -ENOMEM;
> > +             goto page_list_err;
> > +     }
> > +
> > +     phys_pg_list->vm_type = VM_TYPE_PHYS_LIST;
> > +     phys_pg_list->asid = ctx->asid;
> > +     phys_pg_list->total_size = total_size;
> > +     phys_pg_list->flags = args->flags;
> > +     phys_pg_list->contiguous = contiguous;
> > +     INIT_LIST_HEAD(&phys_pg_list->list);
> > +
> > +     for (i = 0 ; i < num_pgs ; i++) {
> > +             phys_pg = kzalloc(sizeof(*phys_pg), GFP_KERNEL);
>
> Consider adding *phys_pgs to phys_pg_list using kcalloc() before the loop.
Fixed in a re-factor to make it array
>
> > +             if (!phys_pg) {
> > +                     rc = -ENOMEM;
> > +                     goto pb_err;
> > +             }
> > +
> > +             phys_pg->page_size = page_size;
> > +
> > +             if (phys_pg_list->contiguous) {
> > +                     phys_pg->paddr = paddr + i * phys_pg->page_size;
> > +             } else {
> > +                     phys_pg->paddr =
> > +                             (u64) gen_pool_alloc(vm->dram_pg_pool,
> > +                                                     phys_pg->page_size);
> > +                     if (!phys_pg->paddr) {
> > +                             dev_err(hdev->dev, "ioctl failed to allocate page\n");
> > +                             kfree(phys_pg);
> > +                             rc = -ENOMEM;
> > +                             goto pb_err;
> > +                     }
> > +             }
> > +
> > +             list_add_tail(&phys_pg->node, &phys_pg_list->list);
> > +     }
> > +
> > +     spin_lock(&vm->idr_lock);
> > +     handle = idr_alloc(&vm->phys_pg_list_handles, phys_pg_list, 1, 0,
> > +                             GFP_ATOMIC);
> > +     spin_unlock(&vm->idr_lock);
> > +
> > +     if (handle < 0) {
> > +             dev_err(hdev->dev, "Failed to get handle for page\n");
> > +             rc = -EFAULT;
> > +             goto idr_err;
> > +     }
> > +
> > +     for (i = 0; i < num_pgs ; i++)
> > +             kref_get(&vm->dram_pg_pool_refcount);
> > +
> > +     phys_pg_list->handle = handle;
> > +
> > +     atomic64_add(phys_pg_list->total_size, &ctx->dram_phys_mem);
> > +     atomic64_add(phys_pg_list->total_size, &hdev->dram_used_mem);
> > +
> > +     *ret_handle = handle;
> > +
> > +     return 0;
> > +
> > +idr_err:
> > +pb_err:
> > +     list_for_each_entry_safe(phys_pg, tmp, &phys_pg_list->list, node) {
> > +             if (!phys_pg_list->contiguous)
> > +                     gen_pool_free(vm->dram_pg_pool, phys_pg->paddr,
> > +                                     phys_pg->page_size);
> > +
> > +             list_del(&phys_pg->node);
> > +             kfree(phys_pg);
> > +     }
> > +
> > +     kfree(phys_pg_list);
> > +page_list_err:
> > +     if (contiguous)
> > +             gen_pool_free(vm->dram_pg_pool, paddr, total_size);
> > +
> > +     return rc;
> > +}
>
> [ ... ]
>
> > +/**
> > + * free_phys_pg_list    - free physical page list
> > + *
> > + * @hdev                : habanalabs device structure
> > + * @phys_pg_list        : physical page list to free
> > + *
> > + * This function does the following:
> > + * - Iterate over the list and free each physical block structure
> > + * - In case of allocated memory, return the physical memory to the general pool
> > + * - Free the hl_vm_phys_pg_list structure
> > + */
> > +static void free_phys_pg_list(struct hl_device *hdev,
> > +             struct hl_vm_phys_pg_list *phys_pg_list)
> > +{
> > +     struct hl_vm *vm = &hdev->vm;
> > +     struct hl_vm_phys_pg *phys_pg, *tmp;
> > +     u32 num_pgs;
> > +     bool first = true;
> > +     int i;
> > +
> > +     list_for_each_entry_safe(phys_pg, tmp, &phys_pg_list->list, node) {
> > +             /*
> > +              * this if statement is relevant only when called from
> > +              * hl_vm_ctx_fini() and free_device_memory()
> > +              */
> > +             if (!phys_pg_list->created_from_userptr) {
> > +                     if ((phys_pg_list->contiguous) && (first)) {
> > +                             first = false;
> > +                             gen_pool_free(vm->dram_pg_pool,
> > +                                             phys_pg->paddr,
> > +                                             phys_pg_list->total_size);
> > +
> > +                             num_pgs = phys_pg_list->total_size >>
> > +                                     __ffs(hdev->asic_prop.dram_page_size);
> > +
> > +                             for (i = 0; i < num_pgs ; i++)
> > +                                     kref_put(&vm->dram_pg_pool_refcount,
> > +                                             dram_pg_pool_do_release);
> > +
> > +                     } else if (!phys_pg_list->contiguous) {
> > +                             gen_pool_free(vm->dram_pg_pool, phys_pg->paddr,
> > +                                             phys_pg->page_size);
> > +                             kref_put(&vm->dram_pg_pool_refcount,
> > +                                             dram_pg_pool_do_release);
> > +                     }
> > +             }
> > +
> > +             list_del(&phys_pg->node);
> > +             kfree(phys_pg);
> > +     }
>
> Unless I'm missing something this can be simplified a bit:
>
> if (!phys_pg_list->created_from_userptr) {
>         for (i = 0; i < num_pgs ; i++)
>                 kref_put(&vm->dram_pg_pool_refcount,
>                          dram_pg_pool_do_release);
>         if (phys_pg_list->contiguous)
>                 gen_pool_free(vm->dram_pg_pool, phys_pg->paddr,
>                               phys_pg_list->total_size);
> }
>
> list_for_each_entry_safe(phys_pg, tmp, &phys_pg_list->list, node) {
>         if (!phys_pg_list->created_from_userptr &&
>             !phys_pg_list->contiguous)
>                 gen_pool_free(vm->dram_pg_pool, phys_pg->paddr,
>                               phys_pg->page_size);
>         list_del(&phys_pg->node);
>         kfree(phys_pg);
> }
>
> nd with phys_pg's array hanging from phys_pg_list it would be even simpler
> ;-)
Definitely agree. Fixed with a refactor to make it array instead of
list, as there is no real need for list here.

>
> > +
> > +     kfree(phys_pg_list);
> > +}
> > +
>
> --
> Sincerely yours,
> Mike.
>
