Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16713C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 16:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D125B20882
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 16:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfA0QNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 11:13:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbfA0QNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 11:13:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0RG4x2w140328
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 11:13:10 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q95qj7amq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 11:13:10 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 27 Jan 2019 16:13:08 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 27 Jan 2019 16:13:04 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0RGD3uF55967922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 27 Jan 2019 16:13:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BDC211C050;
        Sun, 27 Jan 2019 16:13:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 968B911C05B;
        Sun, 27 Jan 2019 16:13:02 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.102])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 27 Jan 2019 16:13:02 +0000 (GMT)
Date:   Sun, 27 Jan 2019 18:13:00 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ogabbay@habana.ai, Omer Shpigelman <oshpigelman@habana.ai>
Subject: Re: [PATCH 12/15] habanalabs: add virtual memory and MMU modules
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
 <20190123000057.31477-13-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123000057.31477-13-oded.gabbay@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012716-0028-0000-0000-0000033EC340
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012716-0029-0000-0000-000023FC0CBF
Message-Id: <20190127161256.GA985@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-27_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901270131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:00:54AM +0200, Oded Gabbay wrote:
> From: Omer Shpigelman <oshpigelman@habana.ai>
> 
> This patch adds the Virtual Memory and MMU modules.
> 
> Goya has an internal MMU which provides process isolation on the internal
> DDR. The internal MMU also performs translations for transactions that go
> from Goya to the Host.
> 
> The driver is responsible for allocating and freeing memory on the DDR
> upon user request. It also provides an interface to map and unmap DDR and
> Host memory to the device address space.
> 
> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  drivers/misc/habanalabs/Makefile              |    2 +-
>  drivers/misc/habanalabs/context.c             |   19 +-
>  drivers/misc/habanalabs/device.c              |   20 +-
>  drivers/misc/habanalabs/goya/goya.c           |  391 +++++
>  drivers/misc/habanalabs/habanalabs.h          |  195 +++
>  drivers/misc/habanalabs/habanalabs_drv.c      |    2 +-
>  drivers/misc/habanalabs/habanalabs_ioctl.c    |    3 +-
>  drivers/misc/habanalabs/include/goya/goya.h   |    6 +-
>  .../include/hw_ip/mmu/mmu_general.h           |   45 +
>  .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
>  drivers/misc/habanalabs/memory.c              | 1506 +++++++++++++++++
>  drivers/misc/habanalabs/mmu.c                 |  604 +++++++
>  include/uapi/misc/habanalabs.h                |  122 +-
>  13 files changed, 2922 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
>  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
>  create mode 100644 drivers/misc/habanalabs/mmu.c
 
[ ... ]

> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index e3867615b974..94ee4cb00a49 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c

[ ... ]

> @@ -265,6 +332,10 @@ static u32 goya_non_fatal_events[GOYA_ASYC_EVENT_GROUP_NON_FATAL_SIZE] = {
>  };
>  
>  static int goya_armcp_info_get(struct hl_device *hdev);
> +static void goya_mmu_prepare(struct hl_device *hdev, u32 asid);
> +static int goya_mmu_clear_pgt_range(struct hl_device *hdev);
> +static int goya_mmu_update_asid_hop0_addr(struct hl_device *hdev, u32 asid,
> +					u64 phys_addr);

Nit: are the static declarations are necessary? Or it's a matter of moving
code around?

>  
>  static void goya_get_fixed_properties(struct hl_device *hdev)
>  {
> @@ -303,6 +374,16 @@ static void goya_get_fixed_properties(struct hl_device *hdev)
>  	prop->sram_user_base_address = prop->sram_base_address +
>  						SRAM_USER_BASE_OFFSET;
>  
> +	prop->mmu_pgt_addr = MMU_PAGE_TABLES_ADDR;
> +	if (hdev->pldm)
> +		prop->mmu_pgt_size = 0x800000; /* 8MB */
> +	else
> +		prop->mmu_pgt_size = MMU_PAGE_TABLES_SIZE;
> +	prop->mmu_pte_size = PTE_SIZE;
> +	prop->mmu_hop_table_size = HOP_TABLE_SIZE;
> +	prop->mmu_hop0_tables_total_size = HOP0_TABLES_TOTAL_SIZE;
> +	prop->dram_page_size = PAGE_SIZE_2MB;
> +
>  	prop->host_phys_base_address = HOST_PHYS_BASE;
>  	prop->va_space_host_start_address = VA_HOST_SPACE_START;
>  	prop->va_space_host_end_address = VA_HOST_SPACE_END;

[ ... ]

> diff --git a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
> new file mode 100644
> index 000000000000..8d61ee4f2d17
> --- /dev/null
> +++ b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright 2016-2018 HabanaLabs, Ltd.
> + * All Rights Reserved.
> + *
> + */
> +
> +#ifndef INCLUDE_MMU_GENERAL_H_
> +#define INCLUDE_MMU_GENERAL_H_
> +
> +#define PAGE_SHIFT_4KB			12
> +#define PAGE_SHIFT_2MB			21
> +#define PAGE_SIZE_2MB			(_AC(1, UL) << PAGE_SHIFT_2MB)
> +#define PAGE_SIZE_4KB			(_AC(1, UL) << PAGE_SHIFT_4KB)
> +
> +#define PAGE_PRESENT_MASK		0x0000000000001
> +#define SWAP_OUT_MASK			0x0000000000004
> +#define LAST_MASK			0x0000000000800
> +#define PHYS_ADDR_MASK			0x3FFFFFFFFF000ull
> +#define HOP0_MASK			0x3000000000000ull
> +#define HOP1_MASK			0x0FF8000000000ull
> +#define HOP2_MASK			0x0007FC0000000ull
> +#define HOP3_MASK			0x000003FE00000
> +#define HOP4_MASK			0x00000001FF000
> +#define OFFSET_MASK			0x0000000000FFF
> +
> +#define HOP0_SHIFT			48
> +#define HOP1_SHIFT			39
> +#define HOP2_SHIFT			30
> +#define HOP3_SHIFT			21
> +#define HOP4_SHIFT			12
> +
> +#define PTE_PHYS_ADDR_SHIFT		12
> +#define PTE_PHYS_ADDR_MASK		~0xFFF
> +
> +#define PTE_SIZE			sizeof(u64)

I suspect some architectures define PTE_SIZE in arch/*/include/asm
Probably you'd want to namespace this.

> +#define HOP_TABLE_SIZE			PAGE_SIZE_4KB
> +#define HOP0_TABLES_TOTAL_SIZE		(HOP_TABLE_SIZE * MAX_ASID)
> +
> +#define MMU_HOP0_PA43_12_SHIFT		12
> +#define MMU_HOP0_PA49_44_SHIFT		(12 + 32)
> +
> +#define MMU_CONFIG_TIMEOUT_USEC		2000 /* 2 ms */
> +
> +#endif /* INCLUDE_MMU_GENERAL_H_ */
> diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> index 94cbb252656d..c41ea19502e5 100644
> --- a/drivers/misc/habanalabs/memory.c
> +++ b/drivers/misc/habanalabs/memory.c
> @@ -5,12 +5,1193 @@
>   * All Rights Reserved.
>   */
>  
> +#include <uapi/misc/habanalabs.h>
>  #include "habanalabs.h"
> +#include "include/hw_ip/mmu/mmu_general.h"
>  
>  #include <linux/sched.h>
>  #include <linux/uaccess.h>
>  #include <linux/genalloc.h>
>  
> +#define HL_MMU_DEBUG	0
> +
> +/*
> + * The va ranges in context object contain a list with the available chunks of
> + * device virtual memory.
> + * There is one range for host allocations and one for DRAM allocations.
> + *
> + * On initialization each range contains one chunk of all of its available
> + * virtual range which is a half of the total device virtual range.
> + *
> + * On each mapping of physical pages, a suitable virtual range chunk (with a
> + * minimum size) is selected from the list. If the chunk size equals the
> + * requested size, the chunk is returned. Otherwise, the chunk is split into
> + * two chunks - one to return as result and a remainder to stay in the list.
> + *
> + * On each Unmapping of a virtual address, the relevant virtual chunk is
> + * returned to the list. The chunk is added to the list and if its edges match
> + * the edges of the adjacent chunks (means a contiguous chunk can be created),
> + * the chunks are merged.
> + *
> + * On finish, the list is checked to have only one chunk of all the relevant
> + * virtual range (which is a half of the device total virtual range).
> + * If not (means not all mappings were unmapped), a warning is printed.
> + */
> +
> +/**
> + * alloc_device_memory - allocate device memory
> + *
> + * @ctx                 : current context
> + * @args                : host parameters containing the requested size
> + * @ret_handle          : result handle
> + *
> + * This function does the following:
> + * - Allocate the requested size rounded up to 2MB pages
> + * - Return unique handle
> + */
> +static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> +				u32 *ret_handle)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	struct hl_vm *vm = &hdev->vm;
> +	struct hl_vm_phys_pg_list *phys_pg_list;
> +	struct hl_vm_phys_pg *phys_pg, *tmp;
> +	u64 paddr = 0;
> +	u32 total_size, num_pgs, page_size, page_shift;
> +	int handle, rc, i;
> +	bool contiguous;
> +
> +	page_size = hdev->asic_prop.dram_page_size;
> +	page_shift = __ffs(page_size);

Maybe it's worth storing page_shift in the asi_prop and calculating
page_size.

> +	num_pgs = (args->alloc.mem_size + (page_size - 1)) >> page_shift;
> +	total_size = num_pgs << page_shift;
> +
> +	contiguous = args->flags & HL_MEM_CONTIGUOUS;
> +
> +	if (contiguous) {
> +		paddr = (u64) gen_pool_alloc(vm->dram_pg_pool, total_size);
> +		if (!paddr) {
> +			dev_err(hdev->dev,
> +				"failed to allocate %u huge contiguous pages\n",
> +				num_pgs);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	phys_pg_list = kzalloc(sizeof(*phys_pg_list), GFP_KERNEL);
> +	if (!phys_pg_list) {
> +		rc = -ENOMEM;
> +		goto page_list_err;
> +	}
> +
> +	phys_pg_list->vm_type = VM_TYPE_PHYS_LIST;
> +	phys_pg_list->asid = ctx->asid;
> +	phys_pg_list->total_size = total_size;
> +	phys_pg_list->flags = args->flags;
> +	phys_pg_list->contiguous = contiguous;
> +	INIT_LIST_HEAD(&phys_pg_list->list);
> +
> +	for (i = 0 ; i < num_pgs ; i++) {
> +		phys_pg = kzalloc(sizeof(*phys_pg), GFP_KERNEL);

Consider adding *phys_pgs to phys_pg_list using kcalloc() before the loop.

> +		if (!phys_pg) {
> +			rc = -ENOMEM;
> +			goto pb_err;
> +		}
> +
> +		phys_pg->page_size = page_size;
> +
> +		if (phys_pg_list->contiguous) {
> +			phys_pg->paddr = paddr + i * phys_pg->page_size;
> +		} else {
> +			phys_pg->paddr =
> +				(u64) gen_pool_alloc(vm->dram_pg_pool,
> +							phys_pg->page_size);
> +			if (!phys_pg->paddr) {
> +				dev_err(hdev->dev, "ioctl failed to allocate page\n");
> +				kfree(phys_pg);
> +				rc = -ENOMEM;
> +				goto pb_err;
> +			}
> +		}
> +
> +		list_add_tail(&phys_pg->node, &phys_pg_list->list);
> +	}
> +
> +	spin_lock(&vm->idr_lock);
> +	handle = idr_alloc(&vm->phys_pg_list_handles, phys_pg_list, 1, 0,
> +				GFP_ATOMIC);
> +	spin_unlock(&vm->idr_lock);
> +
> +	if (handle < 0) {
> +		dev_err(hdev->dev, "Failed to get handle for page\n");
> +		rc = -EFAULT;
> +		goto idr_err;
> +	}
> +
> +	for (i = 0; i < num_pgs ; i++)
> +		kref_get(&vm->dram_pg_pool_refcount);
> +
> +	phys_pg_list->handle = handle;
> +
> +	atomic64_add(phys_pg_list->total_size, &ctx->dram_phys_mem);
> +	atomic64_add(phys_pg_list->total_size, &hdev->dram_used_mem);
> +
> +	*ret_handle = handle;
> +
> +	return 0;
> +
> +idr_err:
> +pb_err:
> +	list_for_each_entry_safe(phys_pg, tmp, &phys_pg_list->list, node) {
> +		if (!phys_pg_list->contiguous)
> +			gen_pool_free(vm->dram_pg_pool, phys_pg->paddr,
> +					phys_pg->page_size);
> +
> +		list_del(&phys_pg->node);
> +		kfree(phys_pg);
> +	}
> +
> +	kfree(phys_pg_list);
> +page_list_err:
> +	if (contiguous)
> +		gen_pool_free(vm->dram_pg_pool, paddr, total_size);
> +
> +	return rc;
> +}

[ ... ]

> +/**
> + * free_phys_pg_list    - free physical page list
> + *
> + * @hdev                : habanalabs device structure
> + * @phys_pg_list        : physical page list to free
> + *
> + * This function does the following:
> + * - Iterate over the list and free each physical block structure
> + * - In case of allocated memory, return the physical memory to the general pool
> + * - Free the hl_vm_phys_pg_list structure
> + */
> +static void free_phys_pg_list(struct hl_device *hdev,
> +		struct hl_vm_phys_pg_list *phys_pg_list)
> +{
> +	struct hl_vm *vm = &hdev->vm;
> +	struct hl_vm_phys_pg *phys_pg, *tmp;
> +	u32 num_pgs;
> +	bool first = true;
> +	int i;
> +
> +	list_for_each_entry_safe(phys_pg, tmp, &phys_pg_list->list, node) {
> +		/*
> +		 * this if statement is relevant only when called from
> +		 * hl_vm_ctx_fini() and free_device_memory()
> +		 */
> +		if (!phys_pg_list->created_from_userptr) {
> +			if ((phys_pg_list->contiguous) && (first)) {
> +				first = false;
> +				gen_pool_free(vm->dram_pg_pool,
> +						phys_pg->paddr,
> +						phys_pg_list->total_size);
> +
> +				num_pgs = phys_pg_list->total_size >>
> +					__ffs(hdev->asic_prop.dram_page_size);
> +
> +				for (i = 0; i < num_pgs ; i++)
> +					kref_put(&vm->dram_pg_pool_refcount,
> +						dram_pg_pool_do_release);
> +
> +			} else if (!phys_pg_list->contiguous) {
> +				gen_pool_free(vm->dram_pg_pool, phys_pg->paddr,
> +						phys_pg->page_size);
> +				kref_put(&vm->dram_pg_pool_refcount,
> +						dram_pg_pool_do_release);
> +			}
> +		}
> +
> +		list_del(&phys_pg->node);
> +		kfree(phys_pg);
> +	}

Unless I'm missing something this can be simplified a bit:

if (!phys_pg_list->created_from_userptr) {
	for (i = 0; i < num_pgs ; i++)
		kref_put(&vm->dram_pg_pool_refcount,
			 dram_pg_pool_do_release);
	if (phys_pg_list->contiguous)
		gen_pool_free(vm->dram_pg_pool, phys_pg->paddr,
			      phys_pg_list->total_size);
}

list_for_each_entry_safe(phys_pg, tmp, &phys_pg_list->list, node) {
	if (!phys_pg_list->created_from_userptr &&
	    !phys_pg_list->contiguous)
		gen_pool_free(vm->dram_pg_pool, phys_pg->paddr,
			      phys_pg->page_size);
	list_del(&phys_pg->node);
	kfree(phys_pg);
}

nd with phys_pg's array hanging from phys_pg_list it would be even simpler
;-)

> +
> +	kfree(phys_pg_list);
> +}
> +

-- 
Sincerely yours,
Mike.

