Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF490C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F1C2190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brPdGaVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfBGNQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:16:08 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42200 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfBGNQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:16:07 -0500
Received: by mail-vs1-f65.google.com with SMTP id b74so6608923vsd.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 05:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5WhmOMvqRPdm1YbOQRWHHwE+63VqR7o0u34nJMbFWU=;
        b=brPdGaVNdWuiC1dowQyFzjq1zlgboin1Ce7S3RWynCSY6PfnbQewXHijEESgctbqyr
         fUM5M3Nu5dZOyAuLwOfJe4c4U2vkl4GM2FURI19aXyABOnA85wlHnlRL8mBvR1GiIz4w
         behpZkTSjnqEfkqIH+gQ1+CML3Uu7Vz1jMQ2+m8Q9PviGrDLWzx+AHBkFtjbG0qLWMo1
         N+TNO/i6yyxzs2v5yf0RfAAR17WHppLwOhkYZedyY5I/uTPagkpS8GhJUX1Vbb8VKVUl
         NQlKDBGBHbQIFTDSDWMlMwQdPTtqliHCs9KxbwIPW5sxPkOxIeewx6NSy6GQ3WACuTla
         1uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5WhmOMvqRPdm1YbOQRWHHwE+63VqR7o0u34nJMbFWU=;
        b=U378k2DD6/NLEefB/+n+l6nNELuQKuARNnzjYBaoKjilWeC1XMUa6Wqn5Y7VplFEpZ
         dOnv9TIM4VLmt0YFuxPQqCg8xLeofo9iwzpSAcPm1tt2oIW2e38oK9ZjbhLtw0kPmCKp
         wlxr+XbFSQdfaVnfs8og3EgLz6w0/ImKk0KzrkxIGxfG9cp7+F3XEpjc20jFouBueEXH
         UYceZDNbwMT1qEbc6xweEP2/tsFl191BpQuL7Su9uIYO9h9z5vBbborFTJQ3RrYVUj28
         U8o/G10MyZQHY0JuoOhWe68twFlV94LdVZeAncLpr62pM9HjYShpsJryIjZQ7Nu/pngj
         W9Iw==
X-Gm-Message-State: AHQUAubozaphjZWeNaFLFiOWMEnV3vAKAOtWgOHAYhGsSy0D3VImW3HI
        cYe8lxxSIVr6wEq+dj8cWX+Wh05nk0yx4kcA+41lAQ==
X-Google-Smtp-Source: AHgI3IaedcLEupvYovSV7sm/IkoQNdUaRewiUINotmC6PVn222v1gvYQo8psuWLdB8qmcom4PHu6RSBMjQP9kevZAIQ=
X-Received: by 2002:a67:d20d:: with SMTP id y13mr6717391vsi.163.1549545364917;
 Thu, 07 Feb 2019 05:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20190204203254.4026-1-oded.gabbay@gmail.com> <20190204203254.4026-13-oded.gabbay@gmail.com>
 <20190206151445.GA22612@rapoport-lnx>
In-Reply-To: <20190206151445.GA22612@rapoport-lnx>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 7 Feb 2019 15:15:37 +0200
Message-ID: <CAFCwf11CY1BTFqqaLNO622BXhQcdp1ONJajfR61BLB1F6jPy7Q@mail.gmail.com>
Subject: Re: [PATCH v3 12/15] habanalabs: add virtual memory and MMU modules
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Omer Shpigelman <oshpigelman@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 5:14 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Mon, Feb 04, 2019 at 10:32:51PM +0200, Oded Gabbay wrote:
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
> > Changes in v3:
> >   - Remove use of three exclamation marks
> >   - Add optimization - support mapping for huge page host memory
> >   - Minor bug fixes
> >
> >  drivers/misc/habanalabs/Makefile              |    2 +-
> >  drivers/misc/habanalabs/context.c             |   19 +-
> >  drivers/misc/habanalabs/device.c              |   20 +-
> >  drivers/misc/habanalabs/goya/goya.c           |  393 +++++
> >  drivers/misc/habanalabs/habanalabs.h          |  188 +-
> >  drivers/misc/habanalabs/habanalabs_drv.c      |    2 +-
> >  drivers/misc/habanalabs/habanalabs_ioctl.c    |    3 +-
> >  .../include/hw_ip/mmu/mmu_general.h           |   45 +
> >  .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
> >  drivers/misc/habanalabs/memory.c              | 1514 +++++++++++++++++
> >  drivers/misc/habanalabs/mmu.c                 |  604 +++++++
> >  include/uapi/misc/habanalabs.h                |  122 +-
> >  12 files changed, 2919 insertions(+), 8 deletions(-)
> >  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
> >  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
> >  create mode 100644 drivers/misc/habanalabs/mmu.c
> >
> > diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
> > index 5167699701b9..2698bb6a2355 100644
> > --- a/drivers/misc/habanalabs/Makefile
> > +++ b/drivers/misc/habanalabs/Makefile
> > @@ -6,7 +6,7 @@ obj-m := habanalabs.o
> >
> >  habanalabs-y := habanalabs_drv.o device.o context.o asid.o habanalabs_ioctl.o \
> >               command_buffer.o hw_queue.o irq.o sysfs.o hwmon.o memory.o \
> > -             command_submission.o
> > +             command_submission.o mmu.o
> >
> >  include $(src)/goya/Makefile
> >  habanalabs-y += $(HL_GOYA_FILES)
>
> [ ... ]
>
> > diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> > index 6536b40c63e0..cf0be4f254e0 100644
> > --- a/drivers/misc/habanalabs/memory.c
> > +++ b/drivers/misc/habanalabs/memory.c
> > @@ -5,12 +5,1198 @@
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
> > +#define PGS_IN_HPAGE   (HPAGE_SIZE >> PAGE_SHIFT)
> > +#define HL_MMU_DEBUG 0
>
> [ ... ]
>
> > +/*
> > + * init_phys_pg_pack_from_userptr - initialize physical page pack from host
> > + *                                   memory
> > + *
> > + * @ctx                : current context
> > + * @userptr            : userptr to initialize from
> > + * @pphys_pg_pack      : res pointer
> > + *
> > + * This function does the following:
> > + * - Pin the physical pages related to the given virtual block
> > + * - Create a physical page pack from the physical pages related to the given
> > + *   virtual block
> > + */
> > +static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
> > +             struct hl_userptr *userptr,
> > +             struct hl_vm_phys_pg_pack **pphys_pg_pack)
> > +{
> > +     struct hl_vm_phys_pg_pack *phys_pg_pack;
> > +     struct scatterlist *sg;
> > +     dma_addr_t dma_addr;
> > +     u64 page_mask;
> > +     u32 npages, total_npages, page_size = PAGE_SIZE;
> > +     bool first = true, is_2mb_opt = true;
>
> Now you've mentioned 2M pages, I've started to wonder what would happen if
> PAGE_SIZE != 4k and HPAGE_SIZE != 2M?
>
> There are architectures that may have different sizes for both...
>
Will be fixed but we currently don't have any H/W that we can check this on.

> > +     int rc, i, j;
> > +
> > +     phys_pg_pack = kzalloc(sizeof(*phys_pg_pack), GFP_KERNEL);
> > +     if (!phys_pg_pack)
> > +             return -ENOMEM;
> > +
> > +     phys_pg_pack->vm_type = userptr->vm_type;
> > +     phys_pg_pack->created_from_userptr = true;
> > +     phys_pg_pack->asid = ctx->asid;
> > +     atomic_set(&phys_pg_pack->mapping_cnt, 1);
> > +
> > +     /* Only if all dma_addrs are aligned to 2MB and their
> > +      * sizes is at least 2MB, we can use huge page mapping.
> > +      * We limit the 2MB optimization to this condition,
> > +      * since later on we acquire the related VA range as one
> > +      * consecutive block.
> > +      */
> > +     total_npages = 0;
> > +     for_each_sg(userptr->sgt->sgl, sg, userptr->sgt->nents, i) {
> > +             npages = get_sg_info(sg, &dma_addr);
> > +
> > +             total_npages += npages;
> > +
> > +             if (first) {
> > +                     first = false;
> > +                     dma_addr &= HPAGE_MASK;
> > +             }
> > +
> > +             if ((npages % PGS_IN_HPAGE) || (dma_addr & (HPAGE_SIZE - 1)))
> > +                     is_2mb_opt = false;
> > +     }
> > +
> > +     if (is_2mb_opt) {
> > +             page_size = HPAGE_SIZE;
> > +             total_npages /= PGS_IN_HPAGE;
> > +     }
> > +
> > +     page_mask = ~(((u64) page_size) - 1);
> > +
> > +     phys_pg_pack->pages = kcalloc(total_npages, sizeof(u64), GFP_KERNEL);
> > +     if (!phys_pg_pack->pages) {
> > +             rc = -ENOMEM;
> > +             goto page_pack_arr_mem_err;
> > +     }
> > +
> > +     phys_pg_pack->npages = total_npages;
> > +     phys_pg_pack->page_size = page_size;
> > +     phys_pg_pack->total_size = total_npages * page_size;
> > +
> > +     j = 0;
> > +     first = true;
> > +     for_each_sg(userptr->sgt->sgl, sg, userptr->sgt->nents, i) {
> > +             npages = get_sg_info(sg, &dma_addr);
> > +
> > +             /* align down to physical page size and save the offset */
> > +             if (first) {
> > +                     first = false;
> > +                     phys_pg_pack->offset = dma_addr & (page_size - 1);
> > +                     dma_addr &= page_mask;
> > +             }
> > +
> > +             while (npages) {
> > +                     phys_pg_pack->pages[j++] = dma_addr;
> > +                     dma_addr += page_size;
> > +
> > +                     if (is_2mb_opt)
> > +                             npages -= PGS_IN_HPAGE;
> > +                     else
> > +                             npages--;
> > +             }
> > +     }
> > +
> > +     *pphys_pg_pack = phys_pg_pack;
> > +
> > +     return 0;
> > +
> > +page_pack_arr_mem_err:
> > +     kfree(phys_pg_pack);
> > +
> > +     return rc;
> > +}
> > +
>
> [ ... ]
>
> > diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
> > new file mode 100644
> > index 000000000000..054b72e48a49
> > --- /dev/null
> > +++ b/drivers/misc/habanalabs/mmu.c
> > @@ -0,0 +1,604 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright 2016-2018 HabanaLabs, Ltd.
> > + * All Rights Reserved.
> > + */
> > +
> > +#include "habanalabs.h"
> > +#include "include/hw_ip/mmu/mmu_general.h"
> > +
> > +#include <linux/genalloc.h>
> > +
> > +#define HOP_NOT_FREED        0
> > +#define HOP_FREED    1
> > +
> > +static struct pgt_info *get_pgt_info(struct hl_ctx *ctx, u64 addr)
> > +{
> > +     struct pgt_info *pgt_info = NULL;
> > +
> > +     hash_for_each_possible(ctx->mmu_hash, pgt_info, node,
> > +                             (unsigned long) addr)
> > +             if (addr == pgt_info->addr)
> > +                     break;
> > +
> > +     return pgt_info;
> > +}
> > +
> > +static void free_hop(struct hl_ctx *ctx, u64 hop_addr)
> > +{
> > +     struct pgt_info *pgt_info = get_pgt_info(ctx, hop_addr);
> > +
> > +     gen_pool_free(pgt_info->ctx->hdev->mmu_pgt_pool, pgt_info->addr,
> > +                     ctx->hdev->asic_prop.mmu_hop_table_size);
> > +     hash_del(&pgt_info->node);
> > +
> > +     kfree(pgt_info);
> > +}
> > +
> > +static u64 alloc_hop(struct hl_ctx *ctx)
> > +{
> > +     struct hl_device *hdev = ctx->hdev;
> > +     struct pgt_info *pgt_info;
> > +     u64 addr;
> > +
> > +     pgt_info = kmalloc(sizeof(*pgt_info), GFP_KERNEL);
> > +     if (!pgt_info)
> > +             return ULLONG_MAX;
> > +
> > +     addr = (u64) gen_pool_alloc(hdev->mmu_pgt_pool,
> > +                     hdev->asic_prop.mmu_hop_table_size);
> > +     if (!addr) {
> > +             dev_err(hdev->dev, "failed to allocate page\n");
> > +             kfree(pgt_info);
> > +             return ULLONG_MAX;
> > +     }
> > +
> > +     pgt_info->addr = addr;
> > +     pgt_info->ctx = ctx;
> > +     pgt_info->num_of_ptes = 0;
> > +     hash_add(ctx->mmu_hash, &pgt_info->node, addr);
> > +
> > +     return addr;
> > +}
> > +
> > +static inline void clear_pte(struct hl_device *hdev, u64 pte_addr)
> > +{
> > +     /* clear the last and present bits */
> > +     hdev->asic_funcs->write_pte(hdev, pte_addr, 0);
> > +}
> > +
> > +static inline void inc_num_of_ptes(struct hl_ctx *ctx, u64 hop_addr)
> > +{
> > +     get_pgt_info(ctx, hop_addr)->num_of_ptes++;
> > +}
> > +
> > +/*
> > + * dec_num_of_ptes - decrement the num of ptes and free the hop if possible
> > + *
> > + * @ctx: pointer to the context structure
> > + * @hop_addr: addr of the hop
> > + *
> > + * This function returns HOP_FREED if the hop was freed or HOP_NOT_FREED if the
> > + * num of ptes was decremented without freeing the hop.
> > + */
> > +static inline int dec_num_of_ptes(struct hl_ctx *ctx, u64 hop_addr)
>
> I think it's worth emphasizing that this function may free a pte. Maybe
> even use {get,put}_pte instead of {inc,dec}_num_of_ptes.
>
Agreed, will be fixed.

> > +{
> > +     struct pgt_info *pgt_info = get_pgt_info(ctx, hop_addr);
> > +
> > +     pgt_info->num_of_ptes--;
> > +
> > +     if (pgt_info->num_of_ptes == 0) {
> > +             free_hop(ctx, hop_addr);
> > +             return HOP_FREED;
> > +     }
> > +
> > +     return HOP_NOT_FREED;
>
> Why not simply return pgt_info->num_of_ptes?
Fixed

>
> > +}
> > +
> > +static inline u64 get_hop0_addr(struct hl_ctx *ctx)
> > +{
> > +     return ctx->hdev->asic_prop.mmu_pgt_addr +
> > +                     (ctx->asid * ctx->hdev->asic_prop.mmu_hop_table_size);
> > +}
> > +
> > +static inline u64 get_hop0_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
> > +                                     u64 virt_addr)
> > +{
> > +     return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
> > +                     ((virt_addr & HOP0_MASK) >> HOP0_SHIFT);
> > +}
> > +
> > +static inline u64 get_hop1_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
> > +                                     u64 virt_addr)
> > +{
> > +     return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
> > +                     ((virt_addr & HOP1_MASK) >> HOP1_SHIFT);
> > +}
> > +
> > +static inline u64 get_hop2_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
> > +                                     u64 virt_addr)
> > +{
> > +     return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
> > +                     ((virt_addr & HOP2_MASK) >> HOP2_SHIFT);
> > +}
> > +
> > +static inline u64 get_hop3_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
> > +                                     u64 virt_addr)
> > +{
> > +     return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
> > +                     ((virt_addr & HOP3_MASK) >> HOP3_SHIFT);
> > +}
> > +
> > +static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
> > +                                     u64 virt_addr)
> > +{
> > +     return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
> > +                     ((virt_addr & HOP4_MASK) >> HOP4_SHIFT);
> > +}
>
> These are almost clones of each other. I'd factor out
>
> static inline u64 get_hopN_pte(struct hl_ctx *ctx, u64 hop_addr,
>                                 u64 vaddr, u64 mask, u64 shift);
>
> and alias it for each level.
>
Fixed, but I'm aliasing them using inline functions, which I prefer to macros.

> > +static inline u64 get_next_hop_addr(u64 curr_pte)
> > +{
> > +     if (curr_pte & PAGE_PRESENT_MASK)
> > +             return curr_pte & PHYS_ADDR_MASK;
> > +     else
> > +             return ULLONG_MAX;
> > +}
> > +
> > +/*
> > + * hl_mmu_init - init the mmu module
> > + *
> > + * @hdev: pointer to the habanalabs device structure
> > + *
> > + * This function does the following:
> > + * - Allocate max_asid zeroed hop0 pgts so no mapping is available
> > + * - Enable mmu in hw
> > + * - Invalidate the mmu cache
> > + * - Create a pool of pages for pgts
> > + * - Returns 0 on success
> > + *
> > + * This function depends on DMA QMAN to be working!
> > + */
> > +int hl_mmu_init(struct hl_device *hdev)
> > +{
> > +     struct asic_fixed_properties *prop = &hdev->asic_prop;
> > +     int rc;
> > +
> > +     if (!hdev->mmu_enable)
> > +             return 0;
> > +
> > +     /* MMU HW init was already done in device hw_init() */
> > +
> > +     mutex_init(&hdev->mmu_cache_lock);
> > +
> > +     hdev->mmu_pgt_pool =
> > +                     gen_pool_create(__ffs(prop->mmu_hop_table_size), -1);
> > +
> > +     if (!hdev->mmu_pgt_pool) {
> > +             dev_err(hdev->dev, "Failed to create page gen pool\n");
> > +             rc = -ENOMEM;
> > +             goto err_pool_create;
> > +     }
> > +
> > +     rc = gen_pool_add(hdev->mmu_pgt_pool, prop->mmu_pgt_addr +
> > +                     prop->mmu_hop0_tables_total_size,
> > +                     prop->mmu_pgt_size - prop->mmu_hop0_tables_total_size,
> > +                     -1);
> > +     if (rc) {
> > +             dev_err(hdev->dev, "Failed to add memory to page gen pool\n");
> > +             goto err_pool_add;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_pool_add:
> > +     gen_pool_destroy(hdev->mmu_pgt_pool);
> > +err_pool_create:
> > +     mutex_destroy(&hdev->mmu_cache_lock);
> > +
> > +     return rc;
> > +}
> > +
> > +/*
> > + * hl_mmu_fini - release the mmu module.
> > + *
> > + * @hdev: pointer to the habanalabs device structure
> > + *
> > + * This function does the following:
> > + * - Disable mmu in hw
> > + * - free the pgts pool
> > + *
> > + * All ctxs should be freed before calling this func
> > + */
> > +void hl_mmu_fini(struct hl_device *hdev)
> > +{
> > +     if (!hdev->mmu_enable)
> > +             return;
> > +
> > +     gen_pool_destroy(hdev->mmu_pgt_pool);
> > +
> > +     mutex_destroy(&hdev->mmu_cache_lock);
> > +
> > +     /* MMU HW fini will be done in device hw_fini() */
> > +}
> > +
> > +/*
> > + * hl_mmu_ctx_init - init a ctx for using the mmu module
> > + *
> > + * @ctx: pointer to the context structure
> > + *
> > + * This function does the following:
> > + * - Init a mutex to protect the concurrent mapping flow
> > + * - Init a hash to hold all pgts related to this ctx
> > + */
> > +void hl_mmu_ctx_init(struct hl_ctx *ctx)
> > +{
> > +     if (!ctx->hdev->mmu_enable)
> > +             return;
> > +
> > +     mutex_init(&ctx->mmu_lock);
> > +     hash_init(ctx->mmu_hash);
> > +}
> > +
> > +/*
> > + * hl_mmu_ctx_fini - disable a ctx from using the mmu module
> > + *
> > + * @ctx: pointer to the context structure
> > + *
> > + * This function does the following:
> > + * - Free any pgts which were not freed yet
> > + * - Free the mutex
> > + */
> > +void hl_mmu_ctx_fini(struct hl_ctx *ctx)
> > +{
> > +     struct pgt_info *pgt_info;
> > +     struct hlist_node *tmp;
> > +     int i;
> > +
> > +     if (!ctx->hdev->mmu_enable)
> > +             return;
> > +
> > +     if (!hash_empty(ctx->mmu_hash))
> > +             dev_err(ctx->hdev->dev,
> > +                             "ctx is freed while it has pgts in use\n");
> > +
> > +     hash_for_each_safe(ctx->mmu_hash, i, tmp, pgt_info, node) {
> > +             dev_err(ctx->hdev->dev,
> > +                     "pgt_info of addr 0x%llx of asid %d was not destroyed, num_ptes: %d\n",
> > +                     pgt_info->addr, ctx->asid, pgt_info->num_of_ptes);
> > +             free_hop(ctx, pgt_info->addr);
> > +     }
> > +
> > +     mutex_destroy(&ctx->mmu_lock);
> > +}
> > +
> > +/*
> > + * hl_mmu_map - maps a virtual addr to physical addr
> > + *
> > + * @ctx: pointer to the context structure
> > + * @virt_addr: virt addr to map from
> > + * @phys_addr: phys addr to map to
> > + * @page_size: physical page size
> > + *
> > + * This function does the following:
> > + * - Check that the virt addr is not mapped
> > + * - Allocate pgts as necessary in order to map the virt addr to the phys
> > + * - Returns 0 on success, -EINVAL if addr is already mapped, or -ENOMEM.
> > + *
> > + * Because this function changes the page tables in the device and because it
> > + * changes the MMU hash, it must be protected by a lock.
> > + * However, because it maps only a single page, the lock should be implemented
> > + * in a higher level in order to protect the entire mapping of the memory area
> > + */
> > +int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size)
> > +{
> > +     struct hl_device *hdev = ctx->hdev;
> > +     u64 hop0_addr = 0, hop0_pte_addr = 0,
> > +             hop1_addr = 0, hop1_pte_addr = 0,
> > +             hop2_addr = 0, hop2_pte_addr = 0,
> > +             hop3_addr = 0, hop3_pte_addr = 0,
> > +             hop4_addr = 0, hop4_pte_addr = 0,
> > +             curr_pte = 0;
> > +     int hop1_new = 0, hop2_new = 0, hop3_new = 0, hop4_new = 0,
> > +                     rc = -ENOMEM;
> > +     bool is_huge;
> > +
> > +     if (!hdev->mmu_enable)
> > +             return 0;
> > +
> > +     /*
> > +      * This mapping function can map a 4KB/2MB page. For 2MB page there are
> > +      * only 3 hops rather than 4. Currently the DRAM allocation uses 2MB
> > +      * pages only but user memory could have been allocated with one of the
> > +      * two page sizes. Since this is a common code for all the three cases,
> > +      * we need this hugs page check.
> > +      */
> > +     is_huge = page_size == PAGE_SIZE_2MB;
> > +
> > +     hop0_addr = get_hop0_addr(ctx);
> > +
> > +     hop0_pte_addr = get_hop0_pte_addr(ctx, hop0_addr, virt_addr);
> > +
> > +     curr_pte = hdev->asic_funcs->read_pte(hdev, hop0_pte_addr);
> > +
> > +     hop1_addr = get_next_hop_addr(curr_pte);
> > +
> > +     if (hop1_addr == ULLONG_MAX) {
> > +             hop1_addr = alloc_hop(ctx);
> > +             if (hop1_addr == ULLONG_MAX)
> > +                     goto err;
> > +             else
> > +                     hop1_new = 1;
> > +     }
>
> The allocation can be folded into get_alloc_next_hop_addr() along with
> get_next_hop_addr().
>
Fixed
> > +
> > +     hop1_pte_addr = get_hop1_pte_addr(ctx, hop1_addr, virt_addr);
> > +
> > +     curr_pte = hdev->asic_funcs->read_pte(hdev, hop1_pte_addr);
> > +
> > +     hop2_addr = get_next_hop_addr(curr_pte);
> > +
> > +     if (hop2_addr == ULLONG_MAX) {
> > +             hop2_addr = alloc_hop(ctx);
> > +             if (hop2_addr == ULLONG_MAX)
> > +                     goto err;
> > +             else
> > +                     hop2_new = 1;
> > +     }
> > +
> > +     hop2_pte_addr = get_hop2_pte_addr(ctx, hop2_addr, virt_addr);
> > +
> > +     curr_pte = hdev->asic_funcs->read_pte(hdev, hop2_pte_addr);
> > +
> > +     hop3_addr = get_next_hop_addr(curr_pte);
> > +
> > +     if (hop3_addr == ULLONG_MAX) {
> > +             hop3_addr = alloc_hop(ctx);
> > +             if (hop3_addr == ULLONG_MAX)
> > +                     goto err;
> > +             else
> > +                     hop3_new = 1;
> > +     }
> > +
> > +     hop3_pte_addr = get_hop3_pte_addr(ctx, hop3_addr, virt_addr);
> > +
> > +     curr_pte = hdev->asic_funcs->read_pte(hdev, hop3_pte_addr);
> > +
> > +     if (!is_huge) {
> > +             hop4_addr = get_next_hop_addr(curr_pte);
> > +
> > +             if (hop4_addr == ULLONG_MAX) {
> > +                     hop4_addr = alloc_hop(ctx);
> > +                     if (hop4_addr == ULLONG_MAX)
> > +                             goto err;
> > +                     else
> > +                             hop4_new = 1;
> > +             }
> > +
> > +             hop4_pte_addr = get_hop4_pte_addr(ctx, hop4_addr, virt_addr);
> > +
> > +             curr_pte = hdev->asic_funcs->read_pte(hdev, hop4_pte_addr);
> > +     }
> > +
> > +     if (curr_pte & PAGE_PRESENT_MASK) {
> > +             dev_err(hdev->dev,
> > +                             "mapping already exists for virt_addr 0x%llx\n",
> > +                                     virt_addr);
> > +
> > +             dev_dbg(hdev->dev, "hop0 pte: 0x%llx (0x%llx)\n",
> > +                             hdev->asic_funcs->read_pte(hdev, hop0_pte_addr),
> > +                             hop0_pte_addr);
> > +             dev_dbg(hdev->dev, "hop1 pte: 0x%llx (0x%llx)\n",
> > +                             hdev->asic_funcs->read_pte(hdev, hop1_pte_addr),
> > +                             hop1_pte_addr);
> > +             dev_dbg(hdev->dev, "hop2 pte: 0x%llx (0x%llx)\n",
> > +                             hdev->asic_funcs->read_pte(hdev, hop2_pte_addr),
> > +                             hop2_pte_addr);
> > +             dev_dbg(hdev->dev, "hop3 pte: 0x%llx (0x%llx)\n",
> > +                             hdev->asic_funcs->read_pte(hdev, hop3_pte_addr),
> > +                             hop3_pte_addr);
> > +
> > +             if (!is_huge)
> > +                     dev_dbg(hdev->dev, "hop4 pte: 0x%llx (0x%llx)\n",
> > +                             hdev->asic_funcs->read_pte(hdev,
> > +                                                     hop4_pte_addr),
> > +                                                     hop4_pte_addr);
> > +
> > +             rc = EINVAL;
> > +             goto err;
> > +     }
> > +
> > +     curr_pte = (phys_addr & PTE_PHYS_ADDR_MASK) | LAST_MASK
> > +                     | PAGE_PRESENT_MASK;
> > +
> > +     hdev->asic_funcs->write_pte(hdev,
> > +                             is_huge ? hop3_pte_addr : hop4_pte_addr,
> > +                             curr_pte);
> > +
> > +     if (hop1_new) {
> > +             curr_pte = (hop1_addr & PTE_PHYS_ADDR_MASK) |
> > +                             PAGE_PRESENT_MASK;
> > +             ctx->hdev->asic_funcs->write_pte(ctx->hdev, hop0_pte_addr,
> > +                             curr_pte);
> > +     }
> > +     if (hop2_new) {
> > +             curr_pte = (hop2_addr & PTE_PHYS_ADDR_MASK) |
> > +                             PAGE_PRESENT_MASK;
> > +             ctx->hdev->asic_funcs->write_pte(ctx->hdev, hop1_pte_addr,
> > +                             curr_pte);
> > +             inc_num_of_ptes(ctx, hop1_addr);
> > +     }
> > +     if (hop3_new) {
> > +             curr_pte = (hop3_addr & PTE_PHYS_ADDR_MASK) |
> > +                             PAGE_PRESENT_MASK;
> > +             ctx->hdev->asic_funcs->write_pte(ctx->hdev, hop2_pte_addr,
> > +                             curr_pte);
> > +             inc_num_of_ptes(ctx, hop2_addr);
> > +     }
> > +
> > +     if (!is_huge) {
> > +             if (hop4_new) {
> > +                     curr_pte = (hop4_addr & PTE_PHYS_ADDR_MASK) |
> > +                                     PAGE_PRESENT_MASK;
> > +                     ctx->hdev->asic_funcs->write_pte(ctx->hdev,
> > +                                     hop3_pte_addr, curr_pte);
> > +                     inc_num_of_ptes(ctx, hop3_addr);
> > +             }
> > +
> > +             inc_num_of_ptes(ctx, hop4_addr);
> > +     } else
> > +             inc_num_of_ptes(ctx, hop3_addr);
>
> Isn't hop3 would be incremented twice for 2M pages?
>
Why ? 2M pages means is_huge, so you will go to the else part of the
if above and inc the ptes of hop3 only once there.
The other inc happens if !is_huge, which is for 4K pages.

> > +
> > +     /* flush all writes from all cores to reach PCI */
> > +     mb();
> > +
> > +     hdev->asic_funcs->read_pte(hdev,
> > +                             is_huge ? hop3_pte_addr : hop4_pte_addr);
> > +
> > +     return 0;
> > +
> > +err:
> > +     if (hop4_new)
> > +             free_hop(ctx, hop4_addr);
> > +     if (hop3_new)
> > +             free_hop(ctx, hop3_addr);
> > +     if (hop2_new)
> > +             free_hop(ctx, hop2_addr);
> > +     if (hop1_new)
> > +             free_hop(ctx, hop1_addr);
> > +
> > +     return rc;
> > +}
> > +
> > +/*
> > + * hl_mmu_unmap - unmaps a virtual addr
> > + *
> > + * @ctx: pointer to the context structure
> > + * @virt_addr: virt addr to map from
> > + *
> > + * This function does the following:
> > + * - Check that the virt addr is mapped
> > + * - Unmap the vurt addr and frees pgts if possible
> > + * - Returns 0 on success, -EINVAL if the given addr is not mapped
> > + *
> > + * Because this function changes the page tables in the device and because it
> > + * changes the MMU hash, it must be protected by a lock.
> > + * However, because it maps only a single page, the lock should be implemented
> > + * in a higher level in order to protect the entire mapping of the memory area
> > + */
> > +int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr)
> > +{
> > +     struct hl_device *hdev = ctx->hdev;
> > +     u64 hop0_addr = 0, hop0_pte_addr = 0,
> > +             hop1_addr = 0, hop1_pte_addr = 0,
> > +             hop2_addr = 0, hop2_pte_addr = 0,
> > +             hop3_addr = 0, hop3_pte_addr = 0,
> > +             hop4_addr = 0, hop4_pte_addr = 0,
> > +             curr_pte;
> > +     int clear_hop3 = 1;
> > +
> > +     if (!hdev->mmu_enable)
> > +             return 0;
> > +
> > +     hop0_addr = get_hop0_addr(ctx);
> > +
> > +     hop0_pte_addr = get_hop0_pte_addr(ctx, hop0_addr, virt_addr);
> > +
> > +     curr_pte = hdev->asic_funcs->read_pte(hdev, hop0_pte_addr);
> > +
> > +     hop1_addr = get_next_hop_addr(curr_pte);
> > +
> > +     if (hop1_addr == ULLONG_MAX)
> > +             goto not_mapped;
> > +
> > +     hop1_pte_addr = get_hop1_pte_addr(ctx, hop1_addr, virt_addr);
> > +
> > +     curr_pte = hdev->asic_funcs->read_pte(hdev, hop1_pte_addr);
> > +
> > +     hop2_addr = get_next_hop_addr(curr_pte);
> > +
> > +     if (hop2_addr == ULLONG_MAX)
> > +             goto not_mapped;
> > +
> > +     hop2_pte_addr = get_hop2_pte_addr(ctx, hop2_addr, virt_addr);
> > +
> > +     curr_pte = hdev->asic_funcs->read_pte(hdev, hop2_pte_addr);
> > +
> > +     hop3_addr = get_next_hop_addr(curr_pte);
> > +
> > +     if (hop3_addr == ULLONG_MAX)
> > +             goto not_mapped;
> > +
> > +     hop3_pte_addr = get_hop3_pte_addr(ctx, hop3_addr, virt_addr);
> > +
> > +     curr_pte = hdev->asic_funcs->read_pte(hdev, hop3_pte_addr);
> > +
> > +     if (!(curr_pte & LAST_MASK)) {
> > +             hop4_addr = get_next_hop_addr(curr_pte);
> > +
> > +             if (hop4_addr == ULLONG_MAX)
> > +                     goto not_mapped;
> > +
> > +             hop4_pte_addr = get_hop4_pte_addr(ctx, hop4_addr, virt_addr);
> > +
> > +             curr_pte = hdev->asic_funcs->read_pte(hdev, hop4_pte_addr);
> > +
> > +             clear_hop3 = 0;
> > +     }
> > +
> > +     if (!(curr_pte & PAGE_PRESENT_MASK))
> > +             goto not_mapped;
> > +
> > +     clear_pte(hdev, hop4_addr ? hop4_pte_addr : hop3_pte_addr);
> > +
> > +     if (hop4_addr && dec_num_of_ptes(ctx, hop4_addr) == HOP_FREED)
> > +             clear_hop3 = 1;
> > +
> > +     if (clear_hop3) {
> > +             clear_pte(hdev, hop3_pte_addr);
> > +             if (dec_num_of_ptes(ctx, hop3_addr) == HOP_FREED) {
> > +                     clear_pte(hdev, hop2_pte_addr);
> > +                     if (dec_num_of_ptes(ctx, hop2_addr) == HOP_FREED) {
> > +                             clear_pte(hdev, hop1_pte_addr);
> > +                             if (dec_num_of_ptes(ctx, hop1_addr) ==
> > +                                             HOP_FREED)
> > +                                     clear_pte(hdev, hop0_pte_addr);
> > +                     }
> > +             }
> > +     }
>
> Consider inverting the logic and doing something like
>
>         if (dec_num_of_ptes() != HOP_FREED)
>                 goto flush;
>         clear_pte(...)
>         if (...)
>                 goto flush;
> flush:
>
Yes, it does look more neat that way. Fixed



> > +
> > +     /* flush all writes from all cores to reach PCI */
> > +     mb();
> > +
> > +     hdev->asic_funcs->read_pte(hdev,
> > +                             hop4_addr ? hop4_pte_addr : hop3_pte_addr);
> > +
> > +     return 0;
> > +
> > +not_mapped:
> > +     dev_err(hdev->dev, "virt addr 0x%llx is not mapped to phys addr\n",
> > +             virt_addr);
> > +
> > +     return -EINVAL;
> > +}
>
> [ ... ]
>
> > --
> > 2.17.1
> >
>
> --
> Sincerely yours,
> Mike.
>
