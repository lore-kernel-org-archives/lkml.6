Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA912C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A5A218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfBKRE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:04:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728106AbfBKRE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:04:26 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BH0L3L011837
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:04:15 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qkcsd9s15-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:04:13 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 11 Feb 2019 17:04:11 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Feb 2019 17:04:07 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1BH46l649545240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Feb 2019 17:04:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E91F7A4062;
        Mon, 11 Feb 2019 17:04:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FAB1A405B;
        Mon, 11 Feb 2019 17:04:02 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.211])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Feb 2019 17:04:02 +0000 (GMT)
Date:   Mon, 11 Feb 2019 19:03:59 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, ogabbay@habana.ai, arnd@arndb.de, joe@perches.com,
        Omer Shpigelman <oshpigelman@habana.ai>
Subject: Re: [PATCH v4 12/15] habanalabs: add virtual memory and MMU modules
References: <20190211151751.12336-1-oded.gabbay@gmail.com>
 <20190211151751.12336-13-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211151751.12336-13-oded.gabbay@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19021117-0016-0000-0000-0000025521EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021117-0017-0000-0000-000032AF3F9A
Message-Id: <20190211170354.GA23235@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 05:17:48PM +0200, Oded Gabbay wrote:
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

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> Changes in v4:
>   - Return number of ptes in dec pte
>   - Rename dec/inc_num_of_ptes to put/get_pte
>   - Use common function to get next hop address
>   - Fold alloc of new hop with finding next hop
>   - Invert logic for freeing ptes
>   - Support more pages sizes in MMU
>   - Use -ENOTTY to signal bad ioctl parameter in memory ioctl
>  
>  drivers/misc/habanalabs/Makefile              |    2 +-
>  drivers/misc/habanalabs/context.c             |   19 +-
>  drivers/misc/habanalabs/device.c              |   20 +-
>  drivers/misc/habanalabs/goya/goya.c           |  393 +++++
>  drivers/misc/habanalabs/habanalabs.h          |  188 +-
>  drivers/misc/habanalabs/habanalabs_drv.c      |    2 +-
>  drivers/misc/habanalabs/habanalabs_ioctl.c    |    3 +-
>  .../include/hw_ip/mmu/mmu_general.h           |   45 +
>  .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
>  drivers/misc/habanalabs/memory.c              | 1515 +++++++++++++++++
>  drivers/misc/habanalabs/mmu.c                 |  690 ++++++++
>  include/uapi/misc/habanalabs.h                |  122 +-
>  12 files changed, 3006 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
>  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
>  create mode 100644 drivers/misc/habanalabs/mmu.c
> 
> diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
> index d2fd0e18b1eb..fd46f8b48bab 100644
> --- a/drivers/misc/habanalabs/Makefile
> +++ b/drivers/misc/habanalabs/Makefile
> @@ -6,7 +6,7 @@ obj-m	:= habanalabs.o
>  
>  habanalabs-y := habanalabs_drv.o device.o context.o asid.o habanalabs_ioctl.o \
>  		command_buffer.o hw_queue.o irq.o sysfs.o hwmon.o memory.o \
> -		command_submission.o
> +		command_submission.o mmu.o
>  
>  include $(src)/goya/Makefile
>  habanalabs-y += $(HL_GOYA_FILES)
> diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
> index 98710646de6c..6ff0f2103d8d 100644
> --- a/drivers/misc/habanalabs/context.c
> +++ b/drivers/misc/habanalabs/context.c
> @@ -26,8 +26,10 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
>  	for (i = 0 ; i < HL_MAX_PENDING_CS ; i++)
>  		dma_fence_put(ctx->cs_pending[i]);
>  
> -	if (ctx->asid != HL_KERNEL_ASID_ID)
> +	if (ctx->asid != HL_KERNEL_ASID_ID) {
> +		hl_vm_ctx_fini(ctx);
>  		hl_asid_free(hdev, ctx->asid);
> +	}
>  }
>  
>  void hl_ctx_do_release(struct kref *ref)
> @@ -97,6 +99,8 @@ void hl_ctx_free(struct hl_device *hdev, struct hl_ctx *ctx)
>  
>  int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
>  {
> +	int rc = 0;
> +
>  	ctx->hdev = hdev;
>  
>  	kref_init(&ctx->refcount);
> @@ -114,9 +118,22 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
>  			dev_err(hdev->dev, "No free ASID, failed to create context\n");
>  			return -ENOMEM;
>  		}
> +
> +		rc = hl_vm_ctx_init(ctx);
> +		if (rc) {
> +			dev_err(hdev->dev, "Failed to init mem ctx module\n");
> +			rc = -ENOMEM;
> +			goto mem_ctx_err;
> +		}
>  	}
>  
>  	return 0;
> +
> +mem_ctx_err:
> +	if (ctx->asid != HL_KERNEL_ASID_ID)
> +		hl_asid_free(hdev, ctx->asid);
> +
> +	return rc;
>  }
>  
>  void hl_ctx_get(struct hl_device *hdev, struct hl_ctx *ctx)
> diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> index 21496882be3a..5c850d3574eb 100644
> --- a/drivers/misc/habanalabs/device.c
> +++ b/drivers/misc/habanalabs/device.c
> @@ -604,8 +604,10 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
>  	/* Reset the H/W. It will be in idle state after this returns */
>  	hdev->asic_funcs->hw_fini(hdev, hard_reset);
>  
> -	if (hard_reset)
> +	if (hard_reset) {
> +		hl_vm_fini(hdev);
>  		hl_eq_reset(hdev, &hdev->event_queue);
> +	}
>  
>  	/* Re-initialize PI,CI to 0 in all queues (hw queue, cq) */
>  	hl_hw_queue_reset(hdev, hard_reset);
> @@ -666,6 +668,13 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
>  			goto out_err;
>  		}
>  
> +		rc = hl_vm_init(hdev);
> +		if (rc) {
> +			dev_err(hdev->dev,
> +				"Failed to init memory module after hard reset\n");
> +			goto out_err;
> +		}
> +
>  		hl_set_max_power(hdev, hdev->max_power);
>  
>  		hdev->hard_reset_pending = false;
> @@ -850,6 +859,13 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
>  		hdev->asic_name,
>  		hdev->asic_prop.dram_size / 1024 / 1024 / 1024);
>  
> +	rc = hl_vm_init(hdev);
> +	if (rc) {
> +		dev_err(hdev->dev, "Failed to initialize memory module\n");
> +		rc = 0;
> +		goto out_disabled;
> +	}
> +
>  	rc = hl_hwmon_init(hdev);
>  	if (rc) {
>  		dev_err(hdev->dev, "Failed to initialize hwmon\n");
> @@ -961,6 +977,8 @@ void hl_device_fini(struct hl_device *hdev)
>  	/* Reset the H/W. It will be in idle state after this returns */
>  	hdev->asic_funcs->hw_fini(hdev, true);
>  
> +	hl_vm_fini(hdev);
> +
>  	hl_eq_fini(hdev, &hdev->event_queue);
>  
>  	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index 9fda232139ea..bba159fd7755 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -6,6 +6,8 @@
>   */
>  
>  #include "goyaP.h"
> +#include "include/hw_ip/mmu/mmu_general.h"
> +#include "include/hw_ip/mmu/mmu_v1_0.h"
>  #include "include/goya/asic_reg/goya_masks.h"
>  
>  #include <linux/fs.h>
> @@ -87,6 +89,7 @@
>  #define GOYA_PLDM_RESET_WAIT_MSEC	1000		/* 1s */
>  #define GOYA_CPU_TIMEOUT_USEC		10000000	/* 10s */
>  #define GOYA_TEST_QUEUE_WAIT_USEC	100000		/* 100ms */
> +#define GOYA_PLDM_MMU_TIMEOUT_USEC	(MMU_CONFIG_TIMEOUT_USEC * 100)
>  
>  #define GOYA_QMAN0_FENCE_VAL		0xD169B243
>  
> @@ -138,6 +141,70 @@ static const char *goya_axi_name[GOYA_MAX_INITIATORS] = {
>  	"MMU"
>  };
>  
> +static u64 goya_mmu_regs[GOYA_MMU_REGS_NUM] = {
> +	mmDMA_QM_0_GLBL_NON_SECURE_PROPS,
> +	mmDMA_QM_1_GLBL_NON_SECURE_PROPS,
> +	mmDMA_QM_2_GLBL_NON_SECURE_PROPS,
> +	mmDMA_QM_3_GLBL_NON_SECURE_PROPS,
> +	mmDMA_QM_4_GLBL_NON_SECURE_PROPS,
> +	mmTPC0_QM_GLBL_SECURE_PROPS,
> +	mmTPC0_QM_GLBL_NON_SECURE_PROPS,
> +	mmTPC0_CMDQ_GLBL_SECURE_PROPS,
> +	mmTPC0_CMDQ_GLBL_NON_SECURE_PROPS,
> +	mmTPC0_CFG_ARUSER,
> +	mmTPC0_CFG_AWUSER,
> +	mmTPC1_QM_GLBL_SECURE_PROPS,
> +	mmTPC1_QM_GLBL_NON_SECURE_PROPS,
> +	mmTPC1_CMDQ_GLBL_SECURE_PROPS,
> +	mmTPC1_CMDQ_GLBL_NON_SECURE_PROPS,
> +	mmTPC1_CFG_ARUSER,
> +	mmTPC1_CFG_AWUSER,
> +	mmTPC2_QM_GLBL_SECURE_PROPS,
> +	mmTPC2_QM_GLBL_NON_SECURE_PROPS,
> +	mmTPC2_CMDQ_GLBL_SECURE_PROPS,
> +	mmTPC2_CMDQ_GLBL_NON_SECURE_PROPS,
> +	mmTPC2_CFG_ARUSER,
> +	mmTPC2_CFG_AWUSER,
> +	mmTPC3_QM_GLBL_SECURE_PROPS,
> +	mmTPC3_QM_GLBL_NON_SECURE_PROPS,
> +	mmTPC3_CMDQ_GLBL_SECURE_PROPS,
> +	mmTPC3_CMDQ_GLBL_NON_SECURE_PROPS,
> +	mmTPC3_CFG_ARUSER,
> +	mmTPC3_CFG_AWUSER,
> +	mmTPC4_QM_GLBL_SECURE_PROPS,
> +	mmTPC4_QM_GLBL_NON_SECURE_PROPS,
> +	mmTPC4_CMDQ_GLBL_SECURE_PROPS,
> +	mmTPC4_CMDQ_GLBL_NON_SECURE_PROPS,
> +	mmTPC4_CFG_ARUSER,
> +	mmTPC4_CFG_AWUSER,
> +	mmTPC5_QM_GLBL_SECURE_PROPS,
> +	mmTPC5_QM_GLBL_NON_SECURE_PROPS,
> +	mmTPC5_CMDQ_GLBL_SECURE_PROPS,
> +	mmTPC5_CMDQ_GLBL_NON_SECURE_PROPS,
> +	mmTPC5_CFG_ARUSER,
> +	mmTPC5_CFG_AWUSER,
> +	mmTPC6_QM_GLBL_SECURE_PROPS,
> +	mmTPC6_QM_GLBL_NON_SECURE_PROPS,
> +	mmTPC6_CMDQ_GLBL_SECURE_PROPS,
> +	mmTPC6_CMDQ_GLBL_NON_SECURE_PROPS,
> +	mmTPC6_CFG_ARUSER,
> +	mmTPC6_CFG_AWUSER,
> +	mmTPC7_QM_GLBL_SECURE_PROPS,
> +	mmTPC7_QM_GLBL_NON_SECURE_PROPS,
> +	mmTPC7_CMDQ_GLBL_SECURE_PROPS,
> +	mmTPC7_CMDQ_GLBL_NON_SECURE_PROPS,
> +	mmTPC7_CFG_ARUSER,
> +	mmTPC7_CFG_AWUSER,
> +	mmMME_QM_GLBL_SECURE_PROPS,
> +	mmMME_QM_GLBL_NON_SECURE_PROPS,
> +	mmMME_CMDQ_GLBL_SECURE_PROPS,
> +	mmMME_CMDQ_GLBL_NON_SECURE_PROPS,
> +	mmMME_SBA_CONTROL_DATA,
> +	mmMME_SBB_CONTROL_DATA,
> +	mmMME_SBC_CONTROL_DATA,
> +	mmMME_WBC_CONTROL_DATA
> +};
> +
>  #define GOYA_ASYC_EVENT_GROUP_NON_FATAL_SIZE 121
>  
>  static u32 goya_non_fatal_events[GOYA_ASYC_EVENT_GROUP_NON_FATAL_SIZE] = {
> @@ -265,6 +332,10 @@ static u32 goya_non_fatal_events[GOYA_ASYC_EVENT_GROUP_NON_FATAL_SIZE] = {
>  };
>  
>  static int goya_armcp_info_get(struct hl_device *hdev);
> +static void goya_mmu_prepare(struct hl_device *hdev, u32 asid);
> +static int goya_mmu_clear_pgt_range(struct hl_device *hdev);
> +static int goya_mmu_update_asid_hop0_addr(struct hl_device *hdev, u32 asid,
> +					u64 phys_addr);
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
> +	prop->mmu_pte_size = HL_PTE_SIZE;
> +	prop->mmu_hop_table_size = HOP_TABLE_SIZE;
> +	prop->mmu_hop0_tables_total_size = HOP0_TABLES_TOTAL_SIZE;
> +	prop->dram_page_size = PAGE_SIZE_2MB;
> +
>  	prop->host_phys_base_address = HOST_PHYS_BASE;
>  	prop->va_space_host_start_address = VA_HOST_SPACE_START;
>  	prop->va_space_host_end_address = VA_HOST_SPACE_END;
> @@ -756,7 +837,18 @@ static int goya_late_init(struct hl_device *hdev)
>  
>  	goya_fetch_psoc_frequency(hdev);
>  
> +	rc = goya_mmu_clear_pgt_range(hdev);
> +	if (rc) {
> +		dev_err(hdev->dev, "Failed to clear MMU page tables range\n");
> +		goto disable_pci_access;
> +	}
> +
>  	return 0;
> +
> +disable_pci_access:
> +	goya_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
> +
> +	return rc;
>  }
>  
>  /*
> @@ -2569,6 +2661,54 @@ static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
>  	return 0;
>  }
>  
> +static int goya_mmu_init(struct hl_device *hdev)
> +{
> +	struct asic_fixed_properties *prop = &hdev->asic_prop;
> +	struct goya_device *goya = hdev->asic_specific;
> +	u64 hop0_addr;
> +	int rc, i;
> +
> +	if (!hdev->mmu_enable)
> +		return 0;
> +
> +	if (goya->hw_cap_initialized & HW_CAP_MMU)
> +		return 0;
> +
> +	hdev->dram_supports_virtual_memory = true;
> +
> +	for (i = 0 ; i < prop->max_asid ; i++) {
> +		hop0_addr = prop->mmu_pgt_addr +
> +				(i * prop->mmu_hop_table_size);
> +
> +		rc = goya_mmu_update_asid_hop0_addr(hdev, i, hop0_addr);
> +		if (rc) {
> +			dev_err(hdev->dev,
> +				"failed to set hop0 addr for asid %d\n", i);
> +			goto err;
> +		}
> +	}
> +
> +	goya->hw_cap_initialized |= HW_CAP_MMU;
> +
> +	/* init MMU cache manage page */
> +	WREG32(mmSTLB_CACHE_INV_BASE_39_8, MMU_CACHE_MNG_ADDR >> 8);
> +	WREG32(mmSTLB_CACHE_INV_BASE_49_40, MMU_CACHE_MNG_ADDR << 40);
> +
> +	/* Remove follower feature due to performance bug */
> +	WREG32_AND(mmSTLB_STLB_FEATURE_EN,
> +			(~STLB_STLB_FEATURE_EN_FOLLOWER_EN_MASK));
> +
> +	hdev->asic_funcs->mmu_invalidate_cache(hdev, true);
> +
> +	WREG32(mmMMU_MMU_ENABLE, 1);
> +	WREG32(mmMMU_SPI_MASK, 0xF);
> +
> +	return 0;
> +
> +err:
> +	return rc;
> +}
> +
>  /*
>   * goya_hw_init - Goya hardware initialization code
>   *
> @@ -2618,6 +2758,10 @@ static int goya_hw_init(struct hl_device *hdev)
>  		return rc;
>  	}
>  
> +	rc = goya_mmu_init(hdev);
> +	if (rc)
> +		return rc;
> +
>  	goya_init_security(hdev);
>  
>  	goya_init_dma_qmans(hdev);
> @@ -4247,6 +4391,10 @@ int goya_context_switch(struct hl_device *hdev, u32 asid)
>  
>  	rc = goya_send_job_on_qman0(hdev, job);
>  
> +	/* no point in setting the asid in case of failure */
> +	if (!rc)
> +		goya_mmu_prepare(hdev, asid);
> +
>  	job->patched_cb->cs_cnt--;
>  	hl_cb_put(job->patched_cb);
>  
> @@ -4282,6 +4430,22 @@ void goya_restore_phase_topology(struct hl_device *hdev)
>  	i = RREG32(mmSYNC_MNGR_SOB_OBJ_0);
>  }
>  
> +static u64 goya_read_pte(struct hl_device *hdev, u64 addr)
> +{
> +	struct goya_device *goya = hdev->asic_specific;
> +
> +	return readq(hdev->pcie_bar[DDR_BAR_ID] +
> +			(addr - goya->ddr_bar_cur_addr));
> +}
> +
> +static void goya_write_pte(struct hl_device *hdev, u64 addr, u64 val)
> +{
> +	struct goya_device *goya = hdev->asic_specific;
> +
> +	writeq(val, hdev->pcie_bar[DDR_BAR_ID] +
> +			(addr - goya->ddr_bar_cur_addr));
> +}
> +
>  static void goya_get_axi_name(struct hl_device *hdev, u32 agent_id,
>  		u16 event_type, char *axi_name, int len)
>  {
> @@ -4565,6 +4729,231 @@ void *goya_get_events_stat(struct hl_device *hdev, u32 *size)
>  	return goya->events_stat;
>  }
>  
> +static int goya_mmu_clear_pgt_range(struct hl_device *hdev)
> +{
> +	struct asic_fixed_properties *prop = &hdev->asic_prop;
> +	struct goya_device *goya = hdev->asic_specific;
> +	struct packet_lin_dma *clear_pgt_range_pkt;
> +	struct hl_cs_parser parser;
> +	struct hl_cs_job *job;
> +	u32 cb_size;
> +	struct hl_cb *cb;
> +	int rc;
> +
> +	if (!(goya->hw_cap_initialized & HW_CAP_MMU))
> +		return 0;
> +
> +	cb = hl_cb_kernel_create(hdev, PAGE_SIZE);
> +	if (!cb)
> +		return -EFAULT;
> +
> +	clear_pgt_range_pkt = (struct packet_lin_dma *) cb->kernel_address;
> +	memset(clear_pgt_range_pkt, 0, sizeof(*clear_pgt_range_pkt));
> +	cb_size = sizeof(*clear_pgt_range_pkt);
> +
> +	clear_pgt_range_pkt->ctl =
> +		((PACKET_LIN_DMA << GOYA_PKT_CTL_OPCODE_SHIFT) |
> +		(DMA_HOST_TO_DRAM << GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT) |
> +		(1 << GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT) |
> +		(1 << GOYA_PKT_LIN_DMA_CTL_WO_SHIFT) |
> +		(1 << GOYA_PKT_CTL_RB_SHIFT) |
> +		(1 << GOYA_PKT_CTL_MB_SHIFT));
> +
> +	clear_pgt_range_pkt->src_addr = 0;
> +	clear_pgt_range_pkt->dst_addr = prop->mmu_pgt_addr;
> +	clear_pgt_range_pkt->tsize = prop->mmu_pgt_size + MMU_CACHE_MNG_SIZE;
> +
> +	job = hl_cs_allocate_job(hdev, true);
> +	if (!job) {
> +		dev_err(hdev->dev, "Failed to allocate a new job\n");
> +		rc = -ENOMEM;
> +		goto release_cb;
> +	}
> +
> +	job->id = 0;
> +	job->user_cb = cb;
> +	job->user_cb->cs_cnt++;
> +	job->user_cb_size = cb_size;
> +	job->hw_queue_id = GOYA_QUEUE_ID_DMA_0;
> +
> +	parser.ctx_id = HL_KERNEL_ASID_ID;
> +	parser.cs_sequence = 0;
> +	parser.job_id = job->id;
> +	parser.hw_queue_id = job->hw_queue_id;
> +	parser.job_userptr_list = &job->userptr_list;
> +	parser.user_cb = job->user_cb;
> +	parser.user_cb_size = job->user_cb_size;
> +	parser.ext_queue = job->ext_queue;
> +	parser.use_virt_addr = hdev->mmu_enable;
> +
> +	rc = hdev->asic_funcs->cs_parser(hdev, &parser);
> +	if (rc) {
> +		dev_err(hdev->dev,
> +			"Failed to parse kernel CB when clearing pgt\n");
> +		goto free_job;
> +	}
> +
> +	job->patched_cb = parser.patched_cb;
> +	job->job_cb_size = parser.patched_cb_size;
> +	job->patched_cb->cs_cnt++;
> +
> +	rc = goya_send_job_on_qman0(hdev, job);
> +
> +	job->patched_cb->cs_cnt--;
> +	hl_cb_put(job->patched_cb);
> +
> +free_job:
> +	hl_userptr_delete_list(hdev, &job->userptr_list);
> +	kfree(job);
> +	cb->cs_cnt--;
> +
> +release_cb:
> +	hl_cb_put(cb);
> +	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
> +
> +	return rc;
> +}
> +
> +static void goya_mmu_prepare(struct hl_device *hdev, u32 asid)
> +{
> +	struct goya_device *goya = hdev->asic_specific;
> +	int i;
> +
> +	if (!(goya->hw_cap_initialized & HW_CAP_MMU))
> +		return;
> +
> +	if (asid & ~MME_QM_GLBL_SECURE_PROPS_ASID_MASK) {
> +		WARN(1, "asid %u is too big\n", asid);
> +		return;
> +	}
> +
> +	/* zero the MMBP and ASID bits and then set the ASID */
> +	for (i = 0 ; i < GOYA_MMU_REGS_NUM ; i++) {
> +		WREG32_AND(goya_mmu_regs[i], ~0x7FF);
> +		WREG32_OR(goya_mmu_regs[i], asid);
> +	}
> +}
> +
> +static void goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard)
> +{
> +	struct goya_device *goya = hdev->asic_specific;
> +	u32 status, timeout_usec;
> +	int rc;
> +
> +	if (!(goya->hw_cap_initialized & HW_CAP_MMU))
> +		return;
> +
> +	/* no need in L1 only invalidation in Goya */
> +	if (!is_hard)
> +		return;
> +
> +	if (hdev->pldm)
> +		timeout_usec = GOYA_PLDM_MMU_TIMEOUT_USEC;
> +	else
> +		timeout_usec = MMU_CONFIG_TIMEOUT_USEC;
> +
> +	mutex_lock(&hdev->mmu_cache_lock);
> +
> +	/* L0 & L1 invalidation */
> +	WREG32(mmSTLB_INV_ALL_START, 1);
> +
> +	rc = hl_poll_timeout(
> +		hdev,
> +		mmSTLB_INV_ALL_START,
> +		status,
> +		!status,
> +		1000,
> +		timeout_usec);
> +
> +	mutex_unlock(&hdev->mmu_cache_lock);
> +
> +	if (rc)
> +		dev_notice_ratelimited(hdev->dev,
> +			"Timeout when waiting for MMU cache invalidation\n");
> +}
> +
> +static void goya_mmu_invalidate_cache_range(struct hl_device *hdev,
> +		bool is_hard, u32 asid, u64 va, u64 size)
> +{
> +	struct goya_device *goya = hdev->asic_specific;
> +	u32 status, timeout_usec, inv_data, pi;
> +	int rc;
> +
> +	if (!(goya->hw_cap_initialized & HW_CAP_MMU))
> +		return;
> +
> +	/* no need in L1 only invalidation in Goya */
> +	if (!is_hard)
> +		return;
> +
> +	if (hdev->pldm)
> +		timeout_usec = GOYA_PLDM_MMU_TIMEOUT_USEC;
> +	else
> +		timeout_usec = MMU_CONFIG_TIMEOUT_USEC;
> +
> +	mutex_lock(&hdev->mmu_cache_lock);
> +
> +	/*
> +	 * TODO: currently invalidate entire L0 & L1 as in regular hard
> +	 * invalidation. Need to apply invalidation of specific cache lines with
> +	 * mask of ASID & VA & size.
> +	 * Note that L1 with be flushed entirely in any case.
> +	 */
> +
> +	/* L0 & L1 invalidation */
> +	inv_data = RREG32(mmSTLB_CACHE_INV);
> +	/* PI is 8 bit */
> +	pi = ((inv_data & STLB_CACHE_INV_PRODUCER_INDEX_MASK) + 1) & 0xFF;
> +	WREG32(mmSTLB_CACHE_INV,
> +			(inv_data & STLB_CACHE_INV_INDEX_MASK_MASK) | pi);
> +
> +	rc = hl_poll_timeout(
> +		hdev,
> +		mmSTLB_INV_CONSUMER_INDEX,
> +		status,
> +		status == pi,
> +		1000,
> +		timeout_usec);
> +
> +	mutex_unlock(&hdev->mmu_cache_lock);
> +
> +	if (rc)
> +		dev_notice_ratelimited(hdev->dev,
> +			"Timeout when waiting for MMU cache invalidation\n");
> +}
> +
> +static int goya_mmu_update_asid_hop0_addr(struct hl_device *hdev, u32 asid,
> +						u64 phys_addr)
> +{
> +	u32 status, timeout_usec;
> +	int rc;
> +
> +	if (hdev->pldm)
> +		timeout_usec = GOYA_PLDM_MMU_TIMEOUT_USEC;
> +	else
> +		timeout_usec = MMU_CONFIG_TIMEOUT_USEC;
> +
> +	WREG32(MMU_HOP0_PA43_12, phys_addr >> MMU_HOP0_PA43_12_SHIFT);
> +	WREG32(MMU_HOP0_PA49_44, phys_addr >> MMU_HOP0_PA49_44_SHIFT);
> +	WREG32(MMU_ASID_BUSY, 0x80000000 | asid);
> +
> +	rc = hl_poll_timeout(
> +		hdev,
> +		MMU_ASID_BUSY,
> +		status,
> +		!(status & 0x80000000),
> +		1000,
> +		timeout_usec);
> +
> +	if (rc) {
> +		dev_err(hdev->dev,
> +			"Timeout during MMU hop0 config of asid %d\n", asid);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
>  int goya_send_heartbeat(struct hl_device *hdev)
>  {
>  	struct goya_device *goya = hdev->asic_specific;
> @@ -4828,6 +5217,10 @@ static const struct hl_asic_funcs goya_funcs = {
>  	.handle_eqe = goya_handle_eqe,
>  	.set_pll_profile = goya_set_pll_profile,
>  	.get_events_stat = goya_get_events_stat,
> +	.read_pte = goya_read_pte,
> +	.write_pte = goya_write_pte,
> +	.mmu_invalidate_cache = goya_mmu_invalidate_cache,
> +	.mmu_invalidate_cache_range = goya_mmu_invalidate_cache_range,
>  	.send_heartbeat = goya_send_heartbeat,
>  	.enable_clock_gating = goya_init_clock_gating,
>  	.disable_clock_gating = goya_disable_clock_gating,
> diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
> index e8f71f6c8fb4..bf2d5cba6148 100644
> --- a/drivers/misc/habanalabs/habanalabs.h
> +++ b/drivers/misc/habanalabs/habanalabs.h
> @@ -41,6 +41,31 @@
>  /* MUST BE POWER OF 2 and larger than 1 */
>  #define HL_MAX_PENDING_CS		64
>  
> +/* Memory */
> +#define MEM_HASH_TABLE_BITS		7 /* 1 << 7 buckets */
> +
> +/* MMU */
> +#define MMU_HASH_TABLE_BITS		7 /* 1 << 7 buckets */
> +
> +/**
> + * struct pgt_info - MMU hop page info.
> + * @node: hash linked-list node for the pgts hash of pgts.
> + * @addr: physical address of the pgt.
> + * @ctx: pointer to the owner ctx.
> + * @num_of_ptes: indicates how many ptes are used in the pgt.
> + *
> + * The MMU page tables hierarchy is placed on the DRAM. When a new level (hop)
> + * is needed during mapping, a new page is allocated and this structure holds
> + * its essential information. During unmapping, if no valid PTEs remained in the
> + * page, it is freed with its pgt_info structure.
> + */
> +struct pgt_info {
> +	struct hlist_node node;
> +	u64 addr;
> +	struct hl_ctx *ctx;
> +	int num_of_ptes;
> +};
> +
>  struct hl_device;
>  struct hl_fpriv;
>  
> @@ -74,11 +99,11 @@ struct hw_queue_properties {
>  /**
>   * enum vm_type_t - virtual memory mapping request information.
>   * @VM_TYPE_USERPTR: mapping of user memory to device virtual address.
> - * @VM_TYPE_PHYS_LIST: mapping of DRAM memory to device virtual address.
> + * @VM_TYPE_PHYS_PACK: mapping of DRAM memory to device virtual address.
>   */
>  enum vm_type_t {
>  	VM_TYPE_USERPTR,
> -	VM_TYPE_PHYS_LIST
> +	VM_TYPE_PHYS_PACK
>  };
>  
>  /**
> @@ -119,6 +144,12 @@ enum hl_device_hw_state {
>   *                               mapping DRAM memory.
>   * @va_space_dram_end_address: end address of virtual memory range for
>   *                             mapping DRAM memory.
> + * @mmu_pgt_addr: base physical address in DRAM of MMU page tables.
> + * @mmu_pgt_size: MMU page tables total size.
> + * @mmu_pte_size: PTE size in MMU page tables.
> + * @mmu_hop_table_size: MMU hop table size.
> + * @mmu_hop0_tables_total_size: total size of MMU hop0 tables.
> + * @dram_page_size: page size for MMU DRAM allocation.
>   * @cfg_size: configuration space size on SRAM.
>   * @sram_size: total size of SRAM.
>   * @max_asid: maximum number of open contexts (ASIDs).
> @@ -152,6 +183,12 @@ struct asic_fixed_properties {
>  	u64			va_space_host_end_address;
>  	u64			va_space_dram_start_address;
>  	u64			va_space_dram_end_address;
> +	u64			mmu_pgt_addr;
> +	u32			mmu_pgt_size;
> +	u32			mmu_pte_size;
> +	u32			mmu_hop_table_size;
> +	u32			mmu_hop0_tables_total_size;
> +	u32			dram_page_size;
>  	u32			cfg_size;
>  	u32			sram_size;
>  	u32			max_asid;
> @@ -421,6 +458,12 @@ enum hl_pll_frequency {
>   * @handle_eqe: handle event queue entry (IRQ) from ArmCP.
>   * @set_pll_profile: change PLL profile (manual/automatic).
>   * @get_events_stat: retrieve event queue entries histogram.
> + * @read_pte: read MMU page table entry from DRAM.
> + * @write_pte: write MMU page table entry to DRAM.
> + * @mmu_invalidate_cache: flush MMU STLB cache, either with soft (L1 only) or
> + *                        hard (L0 & L1) flush.
> + * @mmu_invalidate_cache_range: flush specific MMU STLB cache lines with
> + *                              ASID-VA-size mask.
>   * @send_heartbeat: send is-alive packet to ArmCP and verify response.
>   * @enable_clock_gating: enable clock gating for reducing power consumption.
>   * @disable_clock_gating: disable clock for accessing registers on HBW.
> @@ -485,6 +528,11 @@ struct hl_asic_funcs {
>  	void (*set_pll_profile)(struct hl_device *hdev,
>  			enum hl_pll_frequency freq);
>  	void* (*get_events_stat)(struct hl_device *hdev, u32 *size);
> +	u64 (*read_pte)(struct hl_device *hdev, u64 addr);
> +	void (*write_pte)(struct hl_device *hdev, u64 addr, u64 val);
> +	void (*mmu_invalidate_cache)(struct hl_device *hdev, bool is_hard);
> +	void (*mmu_invalidate_cache_range)(struct hl_device *hdev, bool is_hard,
> +			u32 asid, u64 va, u64 size);
>  	int (*send_heartbeat)(struct hl_device *hdev);
>  	void (*enable_clock_gating)(struct hl_device *hdev);
>  	void (*disable_clock_gating)(struct hl_device *hdev);
> @@ -506,17 +554,40 @@ struct hl_asic_funcs {
>  
>  #define HL_KERNEL_ASID_ID	0
>  
> +/**
> + * struct hl_va_range - virtual addresses range.
> + * @lock: protects the virtual addresses list.
> + * @list: list of virtual addresses blocks available for mappings.
> + * @start_addr: range start address.
> + * @end_addr: range end address.
> + */
> +struct hl_va_range {
> +	struct mutex		lock;
> +	struct list_head	list;
> +	u64			start_addr;
> +	u64			end_addr;
> +};
> +
>  /**
>   * struct hl_ctx - user/kernel context.
> + * @mem_hash: holds mapping from virtual address to virtual memory area
> + *		descriptor (hl_vm_phys_pg_list or hl_userptr).
> + * @mmu_hash: holds a mapping from virtual address to pgt_info structure.
>   * @hpriv: pointer to the private (KMD) data of the process (fd).
>   * @hdev: pointer to the device structure.
>   * @refcount: reference counter for the context. Context is released only when
>   *		this hits 0l. It is incremented on CS and CS_WAIT.
>   * @cs_pending: array of DMA fence objects representing pending CS.
> + * @host_va_range: holds available virtual addresses for host mappings.
> + * @dram_va_range: holds available virtual addresses for DRAM mappings.
> + * @mem_hash_lock: protects the mem_hash.
> + * @mmu_lock: protects the MMU page tables. Any change to the PGT, modifing the
> + *            MMU hash or walking the PGT requires talking this lock
>   * @cs_sequence: sequence number for CS. Value is assigned to a CS and passed
>   *			to user so user could inquire about CS. It is used as
>   *			index to cs_pending array.
>   * @cs_lock: spinlock to protect cs_sequence.
> + * @dram_phys_mem: amount of used physical DRAM memory by this context.
>   * @thread_restore_token: token to prevent multiple threads of the same context
>   *				from running the restore phase. Only one thread
>   *				should run it.
> @@ -526,12 +597,19 @@ struct hl_asic_funcs {
>   * @asid: context's unique address space ID in the device's MMU.
>   */
>  struct hl_ctx {
> +	DECLARE_HASHTABLE(mem_hash, MEM_HASH_TABLE_BITS);
> +	DECLARE_HASHTABLE(mmu_hash, MMU_HASH_TABLE_BITS);
>  	struct hl_fpriv		*hpriv;
>  	struct hl_device	*hdev;
>  	struct kref		refcount;
>  	struct dma_fence	*cs_pending[HL_MAX_PENDING_CS];
> +	struct hl_va_range	host_va_range;
> +	struct hl_va_range	dram_va_range;
> +	struct mutex		mem_hash_lock;
> +	struct mutex		mmu_lock;
>  	u64			cs_sequence;
>  	spinlock_t		cs_lock;
> +	atomic64_t		dram_phys_mem;
>  	atomic_t		thread_restore_token;
>  	u32			thread_restore_wait_token;
>  	u32			asid;
> @@ -674,6 +752,85 @@ struct hl_cs_parser {
>  };
>  
>  
> +/*
> + * MEMORY STRUCTURE
> + */
> +
> +/**
> + * struct hl_vm_hash_node - hash element from virtual address to virtual
> + *				memory area descriptor (hl_vm_phys_pg_list or
> + *				hl_userptr).
> + * @node: node to hang on the hash table in context object.
> + * @vaddr: key virtual address.
> + * @ptr: value pointer (hl_vm_phys_pg_list or hl_userptr).
> + */
> +struct hl_vm_hash_node {
> +	struct hlist_node	node;
> +	u64			vaddr;
> +	void			*ptr;
> +};
> +
> +/**
> + * struct hl_vm_phys_pg_pack - physical page pack.
> + * @vm_type: describes the type of the virtual area descriptor.
> + * @pages: the physical page array.
> + * @mapping_cnt: number of shared mappings.
> + * @asid: the context related to this list.
> + * @npages: num physical pages in the pack.
> + * @page_size: size of each page in the pack.
> + * @total_size: total size of all the pages in this list.
> + * @flags: HL_MEM_* flags related to this list.
> + * @handle: the provided handle related to this list.
> + * @offset: offset from the first page.
> + * @contiguous: is contiguous physical memory.
> + * @created_from_userptr: is product of host virtual address.
> + */
> +struct hl_vm_phys_pg_pack {
> +	enum vm_type_t		vm_type; /* must be first */
> +	u64			*pages;
> +	atomic_t		mapping_cnt;
> +	u32			asid;
> +	u32			npages;
> +	u32			page_size;
> +	u32			total_size;
> +	u32			flags;
> +	u32			handle;
> +	u32			offset;
> +	u8			contiguous;
> +	u8			created_from_userptr;
> +};
> +
> +/**
> + * struct hl_vm_va_block - virtual range block information.
> + * @node: node to hang on the virtual range list in context object.
> + * @start: virtual range start address.
> + * @end: virtual range end address.
> + * @size: virtual range size.
> + */
> +struct hl_vm_va_block {
> +	struct list_head	node;
> +	u64			start;
> +	u64			end;
> +	u64			size;
> +};
> +
> +/**
> + * struct hl_vm - virtual memory manager for MMU.
> + * @dram_pg_pool: pool for DRAM physical pages of 2MB.
> + * @dram_pg_pool_refcount: reference counter for the pool usage.
> + * @idr_lock: protects the phys_pg_list_handles.
> + * @phys_pg_pack_handles: idr to hold all device allocations handles.
> + * @init_done: whether initialization was done. We need this because VM
> + *		initialization might be skipped during device initialization.
> + */
> +struct hl_vm {
> +	struct gen_pool		*dram_pg_pool;
> +	struct kref		dram_pg_pool_refcount;
> +	spinlock_t		idr_lock;
> +	struct idr		phys_pg_pack_handles;
> +	u8			init_done;
> +};
> +
>  /*
>   * FILE PRIVATE STRUCTURE
>   */
> @@ -787,12 +944,16 @@ struct hl_device_reset_work {
>   * @asic_prop: ASIC specific immutable properties.
>   * @asic_funcs: ASIC specific functions.
>   * @asic_specific: ASIC specific information to use only from ASIC files.
> + * @mmu_pgt_pool: pool of available MMU hops.
> + * @vm: virtual memory manager for MMU.
> + * @mmu_cache_lock: protects MMU cache invalidation as it can serve one context
>   * @hwmon_dev: H/W monitor device.
>   * @pm_mng_profile: current power management profile.
>   * @hl_chip_info: ASIC's sensors information.
>   * @cb_pool: list of preallocated CBs.
>   * @cb_pool_lock: protects the CB pool.
>   * @user_ctx: current user context executing.
> + * @dram_used_mem: current DRAM memory consumption.
>   * @in_reset: is device in reset flow.
>   * @curr_pll_profile: current PLL profile.
>   * @fd_open_cnt: number of open user processes.
> @@ -812,6 +973,7 @@ struct hl_device_reset_work {
>   * @heartbeat: is heartbeat sanity check towards ArmCP enabled.
>   * @reset_on_lockup: true if a reset should be done in case of stuck CS, false
>   *                   otherwise.
> + * @dram_supports_virtual_memory: is MMU enabled towards DRAM.
>   * @init_done: is the initialization of the device done.
>   * @mmu_enable: is MMU enabled.
>   */
> @@ -846,6 +1008,9 @@ struct hl_device {
>  	struct asic_fixed_properties	asic_prop;
>  	const struct hl_asic_funcs	*asic_funcs;
>  	void				*asic_specific;
> +	struct gen_pool			*mmu_pgt_pool;
> +	struct hl_vm			vm;
> +	struct mutex			mmu_cache_lock;
>  	struct device			*hwmon_dev;
>  	enum hl_pm_mng_profile		pm_mng_profile;
>  	struct hwmon_chip_info		hl_chip_info;
> @@ -856,6 +1021,7 @@ struct hl_device {
>  	/* TODO: remove user_ctx for multiple process support */
>  	struct hl_ctx			*user_ctx;
>  
> +	atomic64_t			dram_used_mem;
>  	atomic_t			in_reset;
>  	atomic_t			curr_pll_profile;
>  	atomic_t			fd_open_cnt;
> @@ -872,6 +1038,7 @@ struct hl_device {
>  	u8				hard_reset_pending;
>  	u8				heartbeat;
>  	u8				reset_on_lockup;
> +	u8				dram_supports_virtual_memory;
>  	u8				init_done;
>  
>  	/* Parameters for bring-up */
> @@ -1021,6 +1188,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
>  void hl_hpriv_get(struct hl_fpriv *hpriv);
>  void hl_hpriv_put(struct hl_fpriv *hpriv);
>  int hl_device_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq);
> +
>  int hl_build_hwmon_channel_info(struct hl_device *hdev,
>  		struct armcp_sensor *sensors_arr);
>  
> @@ -1048,6 +1216,12 @@ struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev, bool ext_queue);
>  
>  void goya_set_asic_funcs(struct hl_device *hdev);
>  
> +int hl_vm_ctx_init(struct hl_ctx *ctx);
> +void hl_vm_ctx_fini(struct hl_ctx *ctx);
> +
> +int hl_vm_init(struct hl_device *hdev);
> +void hl_vm_fini(struct hl_device *hdev);
> +
>  int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u32 size,
>  			struct hl_userptr *userptr);
>  int hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userptr);
> @@ -1057,6 +1231,15 @@ bool hl_userptr_is_pinned(struct hl_device *hdev, u64 addr, u32 size,
>  				struct list_head *userptr_list,
>  				struct hl_userptr **userptr);
>  
> +int hl_mmu_init(struct hl_device *hdev);
> +void hl_mmu_fini(struct hl_device *hdev);
> +void hl_mmu_ctx_init(struct hl_ctx *ctx);
> +void hl_mmu_ctx_fini(struct hl_ctx *ctx);
> +int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size);
> +int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size);
> +void hl_mmu_swap_out(struct hl_ctx *ctx);
> +void hl_mmu_swap_in(struct hl_ctx *ctx);
> +
>  long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
>  void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq);
>  long hl_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr);
> @@ -1074,5 +1257,6 @@ long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
>  int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data);
>  int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data);
>  int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data);
> +int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data);
>  
>  #endif /* HABANALABSP_H_ */
> diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
> index dbc0c9c2c99a..658dc4588a36 100644
> --- a/drivers/misc/habanalabs/habanalabs_drv.c
> +++ b/drivers/misc/habanalabs/habanalabs_drv.c
> @@ -192,7 +192,7 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
>  	hdev->reset_on_lockup = reset_on_lockup;
>  
>  	/* Parameters for bring-up - set them to defaults */
> -	hdev->mmu_enable = 0;
> +	hdev->mmu_enable = 1;
>  	hdev->cpu_enable = 1;
>  	hdev->reset_pcilink = 0;
>  	hdev->cpu_queues_enable = 1;
> diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
> index f93649a63a9e..71ef0c91668b 100644
> --- a/drivers/misc/habanalabs/habanalabs_ioctl.c
> +++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
> @@ -18,7 +18,8 @@
>  static const struct hl_ioctl_desc hl_ioctls[] = {
>  	HL_IOCTL_DEF(HL_IOCTL_CB, hl_cb_ioctl),
>  	HL_IOCTL_DEF(HL_IOCTL_CS, hl_cs_ioctl),
> -	HL_IOCTL_DEF(HL_IOCTL_WAIT_CS, hl_cs_wait_ioctl)
> +	HL_IOCTL_DEF(HL_IOCTL_WAIT_CS, hl_cs_wait_ioctl),
> +	HL_IOCTL_DEF(HL_IOCTL_MEMORY, hl_mem_ioctl)
>  };
>  
>  #define HL_CORE_IOCTL_COUNT	ARRAY_SIZE(hl_ioctls)
> diff --git a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
> new file mode 100644
> index 000000000000..01483a581561
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
> +#define HL_PTE_SIZE			sizeof(u64)
> +#define HOP_TABLE_SIZE			PAGE_SIZE_4KB
> +#define HOP0_TABLES_TOTAL_SIZE		(HOP_TABLE_SIZE * MAX_ASID)
> +
> +#define MMU_HOP0_PA43_12_SHIFT		12
> +#define MMU_HOP0_PA49_44_SHIFT		(12 + 32)
> +
> +#define MMU_CONFIG_TIMEOUT_USEC		2000 /* 2 ms */
> +
> +#endif /* INCLUDE_MMU_GENERAL_H_ */
> diff --git a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
> new file mode 100644
> index 000000000000..8539dd041f2c
> --- /dev/null
> +++ b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright 2016-2018 HabanaLabs, Ltd.
> + * All Rights Reserved.
> + *
> + */
> +
> +#ifndef INCLUDE_MMU_V1_0_H_
> +#define INCLUDE_MMU_V1_0_H_
> +
> +#define MMU_HOP0_PA43_12	0x490004
> +#define MMU_HOP0_PA49_44	0x490008
> +#define MMU_ASID_BUSY		0x490000
> +
> +#endif /* INCLUDE_MMU_V1_0_H_ */
> diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> index 47e110b4f76e..98a7cc700fd5 100644
> --- a/drivers/misc/habanalabs/memory.c
> +++ b/drivers/misc/habanalabs/memory.c
> @@ -5,12 +5,1198 @@
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
> +#define PGS_IN_HPAGE   (HPAGE_SIZE >> PAGE_SHIFT)
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
> +/*
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
> +	struct hl_vm_phys_pg_pack *phys_pg_pack;
> +	u64 paddr = 0;
> +	u32 total_size, num_pgs, num_curr_pgs, page_size, page_shift;
> +	int handle, rc, i;
> +	bool contiguous;
> +
> +	num_curr_pgs = 0;
> +	page_size = hdev->asic_prop.dram_page_size;
> +	page_shift = __ffs(page_size);
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
> +	phys_pg_pack = kzalloc(sizeof(*phys_pg_pack), GFP_KERNEL);
> +	if (!phys_pg_pack) {
> +		rc = -ENOMEM;
> +		goto pages_pack_err;
> +	}
> +
> +	phys_pg_pack->vm_type = VM_TYPE_PHYS_PACK;
> +	phys_pg_pack->asid = ctx->asid;
> +	phys_pg_pack->npages = num_pgs;
> +	phys_pg_pack->page_size = page_size;
> +	phys_pg_pack->total_size = total_size;
> +	phys_pg_pack->flags = args->flags;
> +	phys_pg_pack->contiguous = contiguous;
> +
> +	phys_pg_pack->pages = kcalloc(num_pgs, sizeof(u64), GFP_KERNEL);
> +	if (!phys_pg_pack->pages) {
> +		rc = -ENOMEM;
> +		goto pages_arr_err;
> +	}
> +
> +	if (phys_pg_pack->contiguous) {
> +		for (i = 0 ; i < num_pgs ; i++)
> +			phys_pg_pack->pages[i] = paddr + i * page_size;
> +	} else {
> +		for (i = 0 ; i < num_pgs ; i++) {
> +			phys_pg_pack->pages[i] = (u64) gen_pool_alloc(
> +							vm->dram_pg_pool,
> +							page_size);
> +			if (!phys_pg_pack->pages[i]) {
> +				dev_err(hdev->dev,
> +					"ioctl failed to allocate page\n");
> +				rc = -ENOMEM;
> +				goto page_err;
> +			}
> +
> +			num_curr_pgs++;
> +		}
> +	}
> +
> +	spin_lock(&vm->idr_lock);
> +	handle = idr_alloc(&vm->phys_pg_pack_handles, phys_pg_pack, 1, 0,
> +				GFP_KERNEL);
> +	spin_unlock(&vm->idr_lock);
> +
> +	if (handle < 0) {
> +		dev_err(hdev->dev, "Failed to get handle for page\n");
> +		rc = -EFAULT;
> +		goto idr_err;
> +	}
> +
> +	for (i = 0 ; i < num_pgs ; i++)
> +		kref_get(&vm->dram_pg_pool_refcount);
> +
> +	phys_pg_pack->handle = handle;
> +
> +	atomic64_add(phys_pg_pack->total_size, &ctx->dram_phys_mem);
> +	atomic64_add(phys_pg_pack->total_size, &hdev->dram_used_mem);
> +
> +	*ret_handle = handle;
> +
> +	return 0;
> +
> +idr_err:
> +page_err:
> +	if (!phys_pg_pack->contiguous)
> +		for (i = 0 ; i < num_curr_pgs ; i++)
> +			gen_pool_free(vm->dram_pg_pool, phys_pg_pack->pages[i],
> +					page_size);
> +
> +	kfree(phys_pg_pack->pages);
> +pages_arr_err:
> +	kfree(phys_pg_pack);
> +pages_pack_err:
> +	if (contiguous)
> +		gen_pool_free(vm->dram_pg_pool, paddr, total_size);
> +
> +	return rc;
> +}
> +
> +/*
> + * get_userptr_from_host_va - initialize userptr structure from given host
> + *                            virtual address
> + *
> + * @hdev                : habanalabs device structure
> + * @args                : parameters containing the virtual address and size
> + * @p_userptr           : pointer to result userptr structure
> + *
> + * This function does the following:
> + * - Allocate userptr structure
> + * - Pin the given host memory using the userptr structure
> + * - Perform DMA mapping to have the DMA addresses of the pages
> + */
> +static int get_userptr_from_host_va(struct hl_device *hdev,
> +		struct hl_mem_in *args, struct hl_userptr **p_userptr)
> +{
> +	struct hl_userptr *userptr;
> +	int rc;
> +
> +	userptr = kzalloc(sizeof(*userptr), GFP_KERNEL);
> +	if (!userptr) {
> +		rc = -ENOMEM;
> +		goto userptr_err;
> +	}
> +
> +	rc = hl_pin_host_memory(hdev, args->map_host.host_virt_addr,
> +			args->map_host.mem_size, userptr);
> +	if (rc) {
> +		dev_err(hdev->dev, "Failed to pin host memory\n");
> +		goto pin_err;
> +	}
> +
> +	rc = hdev->asic_funcs->asic_dma_map_sg(hdev, userptr->sgt->sgl,
> +					userptr->sgt->nents, DMA_BIDIRECTIONAL);
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to map sgt with DMA region\n");
> +		goto dma_map_err;
> +	}
> +
> +	userptr->dma_mapped = true;
> +	userptr->dir = DMA_BIDIRECTIONAL;
> +	userptr->vm_type = VM_TYPE_USERPTR;
> +
> +	*p_userptr = userptr;
> +
> +	return 0;
> +
> +dma_map_err:
> +	hl_unpin_host_memory(hdev, userptr);
> +pin_err:
> +	kfree(userptr);
> +userptr_err:
> +
> +	return rc;
> +}
> +
> +/*
> + * free_userptr - free userptr structure
> + *
> + * @hdev                : habanalabs device structure
> + * @userptr             : userptr to free
> + *
> + * This function does the following:
> + * - Unpins the physical pages
> + * - Frees the userptr structure
> + */
> +static void free_userptr(struct hl_device *hdev, struct hl_userptr *userptr)
> +{
> +	hl_unpin_host_memory(hdev, userptr);
> +	kfree(userptr);
> +}
> +
> +/*
> + * dram_pg_pool_do_release - free DRAM pages pool
> + *
> + * @ref                 : pointer to reference object
> + *
> + * This function does the following:
> + * - Frees the idr structure of physical pages handles
> + * - Frees the generic pool of DRAM physical pages
> + */
> +static void dram_pg_pool_do_release(struct kref *ref)
> +{
> +	struct hl_vm *vm = container_of(ref, struct hl_vm,
> +			dram_pg_pool_refcount);
> +
> +	/*
> +	 * free the idr here as only here we know for sure that there are no
> +	 * allocated physical pages and hence there are no handles in use
> +	 */
> +	idr_destroy(&vm->phys_pg_pack_handles);
> +	gen_pool_destroy(vm->dram_pg_pool);
> +}
> +
> +/*
> + * free_phys_pg_pack   - free physical page pack
> + *
> + * @hdev               : habanalabs device structure
> + * @phys_pg_pack       : physical page pack to free
> + *
> + * This function does the following:
> + * - For DRAM memory only, iterate over the pack and free each physical block
> + *   structure by returning it to the general pool
> + * - Free the hl_vm_phys_pg_pack structure
> + */
> +static void free_phys_pg_pack(struct hl_device *hdev,
> +		struct hl_vm_phys_pg_pack *phys_pg_pack)
> +{
> +	struct hl_vm *vm = &hdev->vm;
> +	int i;
> +
> +	if (!phys_pg_pack->created_from_userptr) {
> +		if (phys_pg_pack->contiguous) {
> +			gen_pool_free(vm->dram_pg_pool, phys_pg_pack->pages[0],
> +					phys_pg_pack->total_size);
> +
> +			for (i = 0; i < phys_pg_pack->npages ; i++)
> +				kref_put(&vm->dram_pg_pool_refcount,
> +					dram_pg_pool_do_release);
> +		} else {
> +			for (i = 0 ; i < phys_pg_pack->npages ; i++) {
> +				gen_pool_free(vm->dram_pg_pool,
> +						phys_pg_pack->pages[i],
> +						phys_pg_pack->page_size);
> +				kref_put(&vm->dram_pg_pool_refcount,
> +					dram_pg_pool_do_release);
> +			}
> +		}
> +	}
> +
> +	kfree(phys_pg_pack->pages);
> +	kfree(phys_pg_pack);
> +}
> +
> +/*
> + * free_device_memory - free device memory
> + *
> + * @ctx                  : current context
> + * @handle              : handle of the memory chunk to free
> + *
> + * This function does the following:
> + * - Free the device memory related to the given handle
> + */
> +static int free_device_memory(struct hl_ctx *ctx, u32 handle)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	struct hl_vm *vm = &hdev->vm;
> +	struct hl_vm_phys_pg_pack *phys_pg_pack;
> +
> +	spin_lock(&vm->idr_lock);
> +	phys_pg_pack = idr_find(&vm->phys_pg_pack_handles, handle);
> +	if (phys_pg_pack) {
> +		if (atomic_read(&phys_pg_pack->mapping_cnt) > 0) {
> +			dev_err(hdev->dev, "handle %u is mapped, cannot free\n",
> +				handle);
> +			spin_unlock(&vm->idr_lock);
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * must remove from idr before the freeing of the physical
> +		 * pages as the refcount of the pool is also the trigger of the
> +		 * idr destroy
> +		 */
> +		idr_remove(&vm->phys_pg_pack_handles, handle);
> +		spin_unlock(&vm->idr_lock);
> +
> +		atomic64_sub(phys_pg_pack->total_size, &ctx->dram_phys_mem);
> +		atomic64_sub(phys_pg_pack->total_size, &hdev->dram_used_mem);
> +
> +		free_phys_pg_pack(hdev, phys_pg_pack);
> +	} else {
> +		spin_unlock(&vm->idr_lock);
> +		dev_err(hdev->dev,
> +			"free device memory failed, no match for handle %u\n",
> +			handle);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * clear_va_list_locked - free virtual addresses list
> + *
> + * @hdev                : habanalabs device structure
> + * @va_list             : list of virtual addresses to free
> + *
> + * This function does the following:
> + * - Iterate over the list and free each virtual addresses block
> + *
> + * This function should be called only when va_list lock is taken
> + */
> +static void clear_va_list_locked(struct hl_device *hdev,
> +		struct list_head *va_list)
> +{
> +	struct hl_vm_va_block *va_block, *tmp;
> +
> +	list_for_each_entry_safe(va_block, tmp, va_list, node) {
> +		list_del(&va_block->node);
> +		kfree(va_block);
> +	}
> +}
> +
> +/*
> + * print_va_list_locked    - print virtual addresses list
> + *
> + * @hdev                : habanalabs device structure
> + * @va_list             : list of virtual addresses to print
> + *
> + * This function does the following:
> + * - Iterate over the list and print each virtual addresses block
> + *
> + * This function should be called only when va_list lock is taken
> + */
> +static void print_va_list_locked(struct hl_device *hdev,
> +		struct list_head *va_list)
> +{
> +#if HL_MMU_DEBUG
> +	struct hl_vm_va_block *va_block;
> +
> +	dev_dbg(hdev->dev, "print va list:\n");
> +
> +	list_for_each_entry(va_block, va_list, node)
> +		dev_dbg(hdev->dev,
> +			"va block, start: 0x%llx, end: 0x%llx, size: %llu\n",
> +			va_block->start, va_block->end, va_block->size);
> +#endif
> +}
> +
> +/*
> + * merge_va_blocks_locked - merge a virtual block if possible
> + *
> + * @hdev                : pointer to the habanalabs device structure
> + * @va_list             : pointer to the virtual addresses block list
> + * @va_block            : virtual block to merge with adjacent blocks
> + *
> + * This function does the following:
> + * - Merge the given blocks with the adjacent blocks if their virtual ranges
> + *   create a contiguous virtual range
> + *
> + * This Function should be called only when va_list lock is taken
> + */
> +static void merge_va_blocks_locked(struct hl_device *hdev,
> +		struct list_head *va_list, struct hl_vm_va_block *va_block)
> +{
> +	struct hl_vm_va_block *prev, *next;
> +
> +	prev = list_prev_entry(va_block, node);
> +	if (&prev->node != va_list && prev->end + 1 == va_block->start) {
> +		prev->end = va_block->end;
> +		prev->size = prev->end - prev->start;
> +		list_del(&va_block->node);
> +		kfree(va_block);
> +		va_block = prev;
> +	}
> +
> +	next = list_next_entry(va_block, node);
> +	if (&next->node != va_list && va_block->end + 1 == next->start) {
> +		next->start = va_block->start;
> +		next->size = next->end - next->start;
> +		list_del(&va_block->node);
> +		kfree(va_block);
> +	}
> +}
> +
> +/*
> + * add_va_block_locked - add a virtual block to the virtual addresses list
> + *
> + * @hdev                : pointer to the habanalabs device structure
> + * @va_list             : pointer to the virtual addresses block list
> + * @start               : start virtual address
> + * @end                 : end virtual address
> + *
> + * This function does the following:
> + * - Add the given block to the virtual blocks list and merge with other
> + * blocks if a contiguous virtual block can be created
> + *
> + * This Function should be called only when va_list lock is taken
> + */
> +static int add_va_block_locked(struct hl_device *hdev,
> +		struct list_head *va_list, u64 start, u64 end)
> +{
> +	struct hl_vm_va_block *va_block, *res = NULL;
> +	u64 size = end - start;
> +
> +	print_va_list_locked(hdev, va_list);
> +
> +	list_for_each_entry(va_block, va_list, node) {
> +		/* TODO: remove upon matureness */
> +		if (hl_mem_area_crosses_range(start, size, va_block->start,
> +				va_block->end)) {
> +			dev_err(hdev->dev,
> +				"block crossing ranges at start 0x%llx, end 0x%llx\n",
> +				va_block->start, va_block->end);
> +			return -EINVAL;
> +		}
> +
> +		if (va_block->end < start)
> +			res = va_block;
> +	}
> +
> +	va_block = kmalloc(sizeof(*va_block), GFP_KERNEL);
> +	if (!va_block)
> +		return -ENOMEM;
> +
> +	va_block->start = start;
> +	va_block->end = end;
> +	va_block->size = size;
> +
> +	if (!res)
> +		list_add(&va_block->node, va_list);
> +	else
> +		list_add(&va_block->node, &res->node);
> +
> +	merge_va_blocks_locked(hdev, va_list, va_block);
> +
> +	print_va_list_locked(hdev, va_list);
> +
> +	return 0;
> +}
> +
> +/*
> + * add_va_block - wrapper for add_va_block_locked
> + *
> + * @hdev                : pointer to the habanalabs device structure
> + * @va_list             : pointer to the virtual addresses block list
> + * @start               : start virtual address
> + * @end                 : end virtual address
> + *
> + * This function does the following:
> + * - Takes the list lock and calls add_va_block_locked
> + */
> +static inline int add_va_block(struct hl_device *hdev,
> +		struct hl_va_range *va_range, u64 start, u64 end)
> +{
> +	int rc;
> +
> +	mutex_lock(&va_range->lock);
> +	rc = add_va_block_locked(hdev, &va_range->list, start, end);
> +	mutex_unlock(&va_range->lock);
> +
> +	return rc;
> +}
> +
> +/*
> + * get_va_block - get a virtual block with the requested size
> + *
> + * @hdev            : pointer to the habanalabs device structure
> + * @va_range        : pointer to the virtual addresses range
> + * @size            : requested block size
> + * @hint_addr       : hint for request address by the user
> + * @is_userptr      : is host or DRAM memory
> + *
> + * This function does the following:
> + * - Iterate on the virtual block list to find a suitable virtual block for the
> + *   requested size
> + * - Reserve the requested block and update the list
> + * - Return the start address of the virtual block
> + */
> +static u64 get_va_block(struct hl_device *hdev,
> +		struct hl_va_range *va_range, u32 size, u64 hint_addr,
> +		bool is_userptr)
> +{
> +	struct hl_vm_va_block *va_block, *new_va_block = NULL;
> +	u64 valid_start, valid_size, prev_start, prev_end, page_mask,
> +		res_valid_start = 0, res_valid_size = 0;
> +	u32 page_size;
> +	bool add_prev = false;
> +
> +	if (is_userptr) {
> +		/*
> +		 * We cannot know if the user allocated memory with huge pages
> +		 * or not, hence we continue with the biggest possible
> +		 * granularity.
> +		 */
> +		page_size = HPAGE_SIZE;
> +		page_mask = HPAGE_MASK;
> +	} else {
> +		page_size = hdev->asic_prop.dram_page_size;
> +		page_mask = ~((u64)page_size - 1);
> +	}
> +
> +	mutex_lock(&va_range->lock);
> +
> +	print_va_list_locked(hdev, &va_range->list);
> +
> +	list_for_each_entry(va_block, &va_range->list, node) {
> +		/* calc the first possible aligned addr */
> +		valid_start = va_block->start;
> +
> +
> +		if (valid_start & (page_size - 1)) {
> +			valid_start &= page_mask;
> +			valid_start += page_size;
> +			if (valid_start > va_block->end)
> +				continue;
> +		}
> +
> +		valid_size = va_block->end - valid_start;
> +
> +		if (valid_size >= size &&
> +			(!new_va_block || valid_size < res_valid_size)) {
> +
> +			new_va_block = va_block;
> +			res_valid_start = valid_start;
> +			res_valid_size = valid_size;
> +		}
> +
> +		if (hint_addr && hint_addr >= valid_start &&
> +				((hint_addr + size) <= va_block->end)) {
> +			new_va_block = va_block;
> +			res_valid_start = hint_addr;
> +			res_valid_size = valid_size;
> +			break;
> +		}
> +	}
> +
> +	if (!new_va_block) {
> +		dev_err(hdev->dev, "no available va block for size %u\n", size);
> +		goto out;
> +	}
> +
> +	if (res_valid_start > new_va_block->start) {
> +		prev_start = new_va_block->start;
> +		prev_end = res_valid_start - 1;
> +
> +		new_va_block->start = res_valid_start;
> +		new_va_block->size = res_valid_size;
> +
> +		add_prev = true;
> +	}
> +
> +	if (new_va_block->size > size) {
> +		new_va_block->start += size;
> +		new_va_block->size = new_va_block->end - new_va_block->start;
> +	} else {
> +		list_del(&new_va_block->node);
> +		kfree(new_va_block);
> +	}
> +
> +	if (add_prev)
> +		add_va_block_locked(hdev, &va_range->list, prev_start,
> +				prev_end);
> +
> +	print_va_list_locked(hdev, &va_range->list);
> +out:
> +	mutex_unlock(&va_range->lock);
> +
> +	return res_valid_start;
> +}
> +
> +/*
> + * get_sg_info - get number of pages and the DMA address from SG list
> + *
> + * @sg                 : the SG list
> + * @dma_addr           : pointer to DMA address to return
> + *
> + * Calculate the number of consecutive pages described by the SG list. Take the
> + * offset of the address in the first page, add to it the length and round it up
> + * to the number of needed pages.
> + */
> +static u32 get_sg_info(struct scatterlist *sg, dma_addr_t *dma_addr)
> +{
> +	*dma_addr = sg_dma_address(sg);
> +
> +	return ((((*dma_addr) & (PAGE_SIZE - 1)) + sg_dma_len(sg)) +
> +			(PAGE_SIZE - 1)) >> PAGE_SHIFT;
> +}
> +
> +/*
> + * init_phys_pg_pack_from_userptr - initialize physical page pack from host
> + *                                   memory
> + *
> + * @ctx                : current context
> + * @userptr            : userptr to initialize from
> + * @pphys_pg_pack      : res pointer
> + *
> + * This function does the following:
> + * - Pin the physical pages related to the given virtual block
> + * - Create a physical page pack from the physical pages related to the given
> + *   virtual block
> + */
> +static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
> +		struct hl_userptr *userptr,
> +		struct hl_vm_phys_pg_pack **pphys_pg_pack)
> +{
> +	struct hl_vm_phys_pg_pack *phys_pg_pack;
> +	struct scatterlist *sg;
> +	dma_addr_t dma_addr;
> +	u64 page_mask;
> +	u32 npages, total_npages, page_size = PAGE_SIZE;
> +	bool first = true, is_huge_page_opt = true;
> +	int rc, i, j;
> +
> +	phys_pg_pack = kzalloc(sizeof(*phys_pg_pack), GFP_KERNEL);
> +	if (!phys_pg_pack)
> +		return -ENOMEM;
> +
> +	phys_pg_pack->vm_type = userptr->vm_type;
> +	phys_pg_pack->created_from_userptr = true;
> +	phys_pg_pack->asid = ctx->asid;
> +	atomic_set(&phys_pg_pack->mapping_cnt, 1);
> +
> +	/* Only if all dma_addrs are aligned to 2MB and their
> +	 * sizes is at least 2MB, we can use huge page mapping.
> +	 * We limit the 2MB optimization to this condition,
> +	 * since later on we acquire the related VA range as one
> +	 * consecutive block.
> +	 */
> +	total_npages = 0;
> +	for_each_sg(userptr->sgt->sgl, sg, userptr->sgt->nents, i) {
> +		npages = get_sg_info(sg, &dma_addr);
> +
> +		total_npages += npages;
> +
> +		if (first) {
> +			first = false;
> +			dma_addr &= HPAGE_MASK;
> +		}
> +
> +		if ((npages % PGS_IN_HPAGE) || (dma_addr & (HPAGE_SIZE - 1)))
> +			is_huge_page_opt = false;
> +	}
> +
> +	if (is_huge_page_opt) {
> +		page_size = HPAGE_SIZE;
> +		total_npages /= PGS_IN_HPAGE;
> +	}
> +
> +	page_mask = ~(((u64) page_size) - 1);
> +
> +	phys_pg_pack->pages = kcalloc(total_npages, sizeof(u64), GFP_KERNEL);
> +	if (!phys_pg_pack->pages) {
> +		rc = -ENOMEM;
> +		goto page_pack_arr_mem_err;
> +	}
> +
> +	phys_pg_pack->npages = total_npages;
> +	phys_pg_pack->page_size = page_size;
> +	phys_pg_pack->total_size = total_npages * page_size;
> +
> +	j = 0;
> +	first = true;
> +	for_each_sg(userptr->sgt->sgl, sg, userptr->sgt->nents, i) {
> +		npages = get_sg_info(sg, &dma_addr);
> +
> +		/* align down to physical page size and save the offset */
> +		if (first) {
> +			first = false;
> +			phys_pg_pack->offset = dma_addr & (page_size - 1);
> +			dma_addr &= page_mask;
> +		}
> +
> +		while (npages) {
> +			phys_pg_pack->pages[j++] = dma_addr;
> +			dma_addr += page_size;
> +
> +			if (is_huge_page_opt)
> +				npages -= PGS_IN_HPAGE;
> +			else
> +				npages--;
> +		}
> +	}
> +
> +	*pphys_pg_pack = phys_pg_pack;
> +
> +	return 0;
> +
> +page_pack_arr_mem_err:
> +	kfree(phys_pg_pack);
> +
> +	return rc;
> +}
> +
> +/*
> + * map_phys_page_pack - maps the physical page pack
> + *
> + * @ctx                : current context
> + * @vaddr              : start address of the virtual area to map from
> + * @phys_pg_pack       : the pack of physical pages to map to
> + *
> + * This function does the following:
> + * - Maps each chunk of virtual memory to matching physical chunk
> + * - Stores number of successful mappings in the given argument
> + * - Returns 0 on success, error code otherwise.
> + */
> +static int map_phys_page_pack(struct hl_ctx *ctx, u64 vaddr,
> +		struct hl_vm_phys_pg_pack *phys_pg_pack)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	u64 next_vaddr = vaddr, paddr;
> +	u32 page_size = phys_pg_pack->page_size;
> +	int i, rc = 0, mapped_pg_cnt = 0;
> +
> +	for (i = 0 ; i < phys_pg_pack->npages ; i++) {
> +		paddr = phys_pg_pack->pages[i];
> +
> +		/* For accessing the host we need to turn on bit 39 */
> +		if (phys_pg_pack->created_from_userptr)
> +			paddr += hdev->asic_prop.host_phys_base_address;
> +
> +		rc = hl_mmu_map(ctx, next_vaddr, paddr, page_size);
> +		if (rc) {
> +			dev_err(hdev->dev,
> +				"map failed for handle %u, npages: %d, mapped: %d",
> +				phys_pg_pack->handle, phys_pg_pack->npages,
> +				mapped_pg_cnt);
> +			goto err;
> +		}
> +
> +		mapped_pg_cnt++;
> +		next_vaddr += page_size;
> +	}
> +
> +	return 0;
> +
> +err:
> +	next_vaddr = vaddr;
> +	for (i = 0 ; i < mapped_pg_cnt ; i++) {
> +		if (hl_mmu_unmap(ctx, next_vaddr, page_size))
> +			dev_warn_ratelimited(hdev->dev,
> +				"failed to unmap handle %u, va: 0x%llx, pa: 0x%llx, page size: %u\n",
> +					phys_pg_pack->handle, next_vaddr,
> +					phys_pg_pack->pages[i], page_size);
> +
> +		next_vaddr += page_size;
> +	}
> +
> +	return rc;
> +}
> +
> +static int get_paddr_from_handle(struct hl_ctx *ctx, struct hl_mem_in *args,
> +				u64 *paddr)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	struct hl_vm *vm = &hdev->vm;
> +	struct hl_vm_phys_pg_pack *phys_pg_pack;
> +	u32 handle;
> +
> +	handle = lower_32_bits(args->map_device.handle);
> +	spin_lock(&vm->idr_lock);
> +	phys_pg_pack = idr_find(&vm->phys_pg_pack_handles, handle);
> +	if (!phys_pg_pack) {
> +		spin_unlock(&vm->idr_lock);
> +		dev_err(hdev->dev, "no match for handle %u\n", handle);
> +		return -EINVAL;
> +	}
> +
> +	*paddr = phys_pg_pack->pages[0];
> +
> +	spin_unlock(&vm->idr_lock);
> +
> +	return 0;
> +}
> +
> +/*
> + * map_device_va - map the given memory
> + *
> + * @ctx	         : current context
> + * @args         : host parameters with handle/host virtual address
> + * @device_addr	 : pointer to result device virtual address
> + *
> + * This function does the following:
> + * - If given a physical device memory handle, map to a device virtual block
> + *   and return the start address of this block
> + * - If given a host virtual address and size, find the related physical pages,
> + *   map a device virtual block to this pages and return the start address of
> + *   this block
> + */
> +static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
> +		u64 *device_addr)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	struct hl_vm *vm = &hdev->vm;
> +	struct hl_vm_phys_pg_pack *phys_pg_pack;
> +	struct hl_userptr *userptr = NULL;
> +	struct hl_vm_hash_node *hnode;
> +	enum vm_type_t *vm_type;
> +	u64 ret_vaddr, hint_addr;
> +	u32 handle = 0;
> +	int rc;
> +	bool is_userptr = args->flags & HL_MEM_USERPTR;
> +
> +	/* Assume failure */
> +	*device_addr = 0;
> +
> +	if (is_userptr) {
> +		rc = get_userptr_from_host_va(hdev, args, &userptr);
> +		if (rc) {
> +			dev_err(hdev->dev, "failed to get userptr from va\n");
> +			return rc;
> +		}
> +
> +		rc = init_phys_pg_pack_from_userptr(ctx, userptr,
> +				&phys_pg_pack);
> +		if (rc) {
> +			dev_err(hdev->dev,
> +				"unable to init page pack for vaddr 0x%llx\n",
> +				args->map_host.host_virt_addr);
> +			goto init_page_pack_err;
> +		}
> +
> +		vm_type = (enum vm_type_t *) userptr;
> +		hint_addr = args->map_host.hint_addr;
> +	} else {
> +		handle = lower_32_bits(args->map_device.handle);
> +
> +		spin_lock(&vm->idr_lock);
> +		phys_pg_pack = idr_find(&vm->phys_pg_pack_handles, handle);
> +		if (!phys_pg_pack) {
> +			spin_unlock(&vm->idr_lock);
> +			dev_err(hdev->dev,
> +				"no match for handle %u\n", handle);
> +			return -EINVAL;
> +		}
> +
> +		/* increment now to avoid freeing device memory while mapping */
> +		atomic_inc(&phys_pg_pack->mapping_cnt);
> +
> +		spin_unlock(&vm->idr_lock);
> +
> +		vm_type = (enum vm_type_t *) phys_pg_pack;
> +
> +		hint_addr = args->map_device.hint_addr;
> +	}
> +
> +	/*
> +	 * relevant for mapping device physical memory only, as host memory is
> +	 * implicitly shared
> +	 */
> +	if (!is_userptr && !(phys_pg_pack->flags & HL_MEM_SHARED) &&
> +			phys_pg_pack->asid != ctx->asid) {
> +		dev_err(hdev->dev,
> +			"Failed to map memory, handle %u is not shared\n",
> +			handle);
> +		rc = -EPERM;
> +		goto shared_err;
> +	}
> +
> +	hnode = kzalloc(sizeof(*hnode), GFP_KERNEL);
> +	if (!hnode) {
> +		rc = -ENOMEM;
> +		goto hnode_err;
> +	}
> +
> +	ret_vaddr = get_va_block(hdev,
> +			is_userptr ? &ctx->host_va_range : &ctx->dram_va_range,
> +			phys_pg_pack->total_size, hint_addr, is_userptr);
> +	if (!ret_vaddr) {
> +		dev_err(hdev->dev, "no available va block for handle %u\n",
> +				handle);
> +		rc = -ENOMEM;
> +		goto va_block_err;
> +	}
> +
> +	mutex_lock(&ctx->mmu_lock);
> +
> +	rc = map_phys_page_pack(ctx, ret_vaddr, phys_pg_pack);
> +	if (rc) {
> +		mutex_unlock(&ctx->mmu_lock);
> +		dev_err(hdev->dev, "mapping page pack failed for handle %u\n",
> +				handle);
> +		goto map_err;
> +	}
> +
> +	hdev->asic_funcs->mmu_invalidate_cache_range(hdev, false, ctx->asid,
> +			ret_vaddr, phys_pg_pack->total_size);
> +
> +	mutex_unlock(&ctx->mmu_lock);
> +
> +	ret_vaddr += phys_pg_pack->offset;
> +
> +	hnode->ptr = vm_type;
> +	hnode->vaddr = ret_vaddr;
> +
> +	mutex_lock(&ctx->mem_hash_lock);
> +	hash_add(ctx->mem_hash, &hnode->node, ret_vaddr);
> +	mutex_unlock(&ctx->mem_hash_lock);
> +
> +	*device_addr = ret_vaddr;
> +
> +	if (is_userptr)
> +		free_phys_pg_pack(hdev, phys_pg_pack);
> +
> +	return 0;
> +
> +map_err:
> +	if (add_va_block(hdev,
> +			is_userptr ? &ctx->host_va_range : &ctx->dram_va_range,
> +			ret_vaddr,
> +			ret_vaddr + phys_pg_pack->total_size - 1))
> +		dev_warn(hdev->dev,
> +			"release va block failed for handle 0x%x, vaddr: 0x%llx\n",
> +				handle, ret_vaddr);
> +
> +va_block_err:
> +	kfree(hnode);
> +hnode_err:
> +shared_err:
> +	atomic_dec(&phys_pg_pack->mapping_cnt);
> +	if (is_userptr)
> +		free_phys_pg_pack(hdev, phys_pg_pack);
> +init_page_pack_err:
> +	if (is_userptr)
> +		free_userptr(hdev, userptr);
> +
> +	return rc;
> +}
> +
> +/*
> + * unmap_device_va      - unmap the given device virtual address
> + *
> + * @ctx                 : current context
> + * @vaddr               : device virtual address to unmap
> + *
> + * This function does the following:
> + * - Unmap the physical pages related to the given virtual address
> + * - return the device virtual block to the virtual block list
> + */
> +static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	struct hl_vm_phys_pg_pack *phys_pg_pack = NULL;
> +	struct hl_vm_hash_node *hnode = NULL;
> +	struct hl_userptr *userptr = NULL;
> +	enum vm_type_t *vm_type;
> +	u64 next_vaddr;
> +	u32 page_size;
> +	bool is_userptr;
> +	int i, rc;
> +
> +	/* protect from double entrance */
> +	mutex_lock(&ctx->mem_hash_lock);
> +	hash_for_each_possible(ctx->mem_hash, hnode, node, (unsigned long)vaddr)
> +		if (vaddr == hnode->vaddr)
> +			break;
> +
> +	if (!hnode) {
> +		mutex_unlock(&ctx->mem_hash_lock);
> +		dev_err(hdev->dev,
> +			"unmap failed, no mem hnode for vaddr 0x%llx\n",
> +			vaddr);
> +		return -EINVAL;
> +	}
> +
> +	hash_del(&hnode->node);
> +	mutex_unlock(&ctx->mem_hash_lock);
> +
> +	vm_type = hnode->ptr;
> +
> +	if (*vm_type == VM_TYPE_USERPTR) {
> +		is_userptr = true;
> +		userptr = hnode->ptr;
> +		rc = init_phys_pg_pack_from_userptr(ctx, userptr,
> +				&phys_pg_pack);
> +		if (rc) {
> +			dev_err(hdev->dev,
> +				"unable to init page pack for vaddr 0x%llx\n",
> +				vaddr);
> +			goto vm_type_err;
> +		}
> +	} else if (*vm_type == VM_TYPE_PHYS_PACK) {
> +		is_userptr = false;
> +		phys_pg_pack = hnode->ptr;
> +	} else {
> +		dev_warn(hdev->dev,
> +			"unmap failed, unknown vm desc for vaddr 0x%llx\n",
> +				vaddr);
> +		rc = -EFAULT;
> +		goto vm_type_err;
> +	}
> +
> +	if (atomic_read(&phys_pg_pack->mapping_cnt) == 0) {
> +		dev_err(hdev->dev, "vaddr 0x%llx is not mapped\n", vaddr);
> +		rc = -EINVAL;
> +		goto mapping_cnt_err;
> +	}
> +
> +	page_size = phys_pg_pack->page_size;
> +	vaddr &= ~(((u64) page_size) - 1);
> +
> +	next_vaddr = vaddr;
> +
> +	mutex_lock(&ctx->mmu_lock);
> +
> +	for (i = 0 ; i < phys_pg_pack->npages ; i++, next_vaddr += page_size)
> +		if (hl_mmu_unmap(ctx, next_vaddr, page_size))
> +			dev_warn_ratelimited(hdev->dev,
> +				"unmap failed for vaddr: 0x%llx\n", next_vaddr);
> +
> +	hdev->asic_funcs->mmu_invalidate_cache_range(hdev, true, ctx->asid,
> +			vaddr, phys_pg_pack->total_size);
> +
> +	mutex_unlock(&ctx->mmu_lock);
> +
> +	if (add_va_block(hdev,
> +			is_userptr ? &ctx->host_va_range : &ctx->dram_va_range,
> +			vaddr,
> +			vaddr + phys_pg_pack->total_size - 1))
> +		dev_warn(hdev->dev, "add va block failed for vaddr: 0x%llx\n",
> +				vaddr);
> +
> +	atomic_dec(&phys_pg_pack->mapping_cnt);
> +	kfree(hnode);
> +
> +	if (is_userptr) {
> +		free_phys_pg_pack(hdev, phys_pg_pack);
> +		free_userptr(hdev, userptr);
> +	}
> +
> +	return 0;
> +
> +mapping_cnt_err:
> +	if (is_userptr)
> +		free_phys_pg_pack(hdev, phys_pg_pack);
> +vm_type_err:
> +	mutex_lock(&ctx->mem_hash_lock);
> +	hash_add(ctx->mem_hash, &hnode->node, vaddr);
> +	mutex_unlock(&ctx->mem_hash_lock);
> +
> +	return rc;
> +}
> +
> +int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
> +{
> +	union hl_mem_args *args = data;
> +	struct hl_device *hdev = hpriv->hdev;
> +	struct hl_ctx *ctx = hpriv->ctx;
> +	u64 device_addr = 0;
> +	u32 handle = 0;
> +	int rc;
> +
> +	if (hl_device_disabled_or_in_reset(hdev)) {
> +		dev_warn_ratelimited(hdev->dev,
> +			"Device is disabled or in reset. Can't execute memory IOCTL\n");
> +		return -EBUSY;
> +	}
> +
> +	if (hdev->mmu_enable) {
> +		switch (args->in.op) {
> +		case HL_MEM_OP_ALLOC:
> +			if (!hdev->dram_supports_virtual_memory) {
> +				dev_err(hdev->dev,
> +					"DRAM alloc is not supported\n");
> +				rc = -EINVAL;
> +				goto out;
> +			}
> +			if (args->in.alloc.mem_size == 0) {
> +				dev_err(hdev->dev,
> +					"alloc size must be larger than 0\n");
> +				rc = -EINVAL;
> +				goto out;
> +			}
> +			rc = alloc_device_memory(ctx, &args->in, &handle);
> +
> +			memset(args, 0, sizeof(*args));
> +			args->out.handle = (__u64) handle;
> +			break;
> +
> +		case HL_MEM_OP_FREE:
> +			if (!hdev->dram_supports_virtual_memory) {
> +				dev_err(hdev->dev,
> +					"DRAM free is not supported\n");
> +				rc = -EINVAL;
> +				goto out;
> +			}
> +			rc = free_device_memory(ctx, args->in.free.handle);
> +			break;
> +
> +		case HL_MEM_OP_MAP:
> +			rc = map_device_va(ctx, &args->in, &device_addr);
> +
> +			memset(args, 0, sizeof(*args));
> +			args->out.device_virt_addr = device_addr;
> +			break;
> +
> +		case HL_MEM_OP_UNMAP:
> +			rc = unmap_device_va(ctx,
> +					args->in.unmap.device_virt_addr);
> +			break;
> +
> +		default:
> +			dev_err(hdev->dev, "Unknown opcode for memory IOCTL\n");
> +			rc = -ENOTTY;
> +			break;
> +		}
> +	} else {
> +		switch (args->in.op) {
> +		case HL_MEM_OP_ALLOC:
> +			if (args->in.alloc.mem_size == 0) {
> +				dev_err(hdev->dev,
> +					"alloc size must be larger than 0\n");
> +				rc = -EINVAL;
> +				goto out;
> +			}
> +
> +			/* Force contiguous as there are no real MMU
> +			 * translations to overcome physical memory gaps
> +			 */
> +			args->in.flags |= HL_MEM_CONTIGUOUS;
> +			rc = alloc_device_memory(ctx, &args->in, &handle);
> +
> +			memset(args, 0, sizeof(*args));
> +			args->out.handle = (__u64) handle;
> +			break;
> +
> +		case HL_MEM_OP_FREE:
> +			rc = free_device_memory(ctx, args->in.free.handle);
> +			break;
> +
> +		case HL_MEM_OP_MAP:
> +			if (args->in.flags & HL_MEM_USERPTR) {
> +				device_addr = args->in.map_host.host_virt_addr;
> +				rc = 0;
> +			} else {
> +				rc = get_paddr_from_handle(ctx, &args->in,
> +						&device_addr);
> +			}
> +
> +			memset(args, 0, sizeof(*args));
> +			args->out.device_virt_addr = device_addr;
> +			break;
> +
> +		case HL_MEM_OP_UNMAP:
> +			rc = 0;
> +			break;
> +
> +		default:
> +			dev_err(hdev->dev, "Unknown opcode for memory IOCTL\n");
> +			rc = -ENOTTY;
> +			break;
> +		}
> +	}
> +
> +out:
> +	return rc;
> +}
> +
>  /*
>   * hl_pin_host_memory - pins a chunk of host memory
>   *
> @@ -197,3 +1383,332 @@ bool hl_userptr_is_pinned(struct hl_device *hdev, u64 addr,
>  
>  	return false;
>  }
> +
> +/*
> + * hl_va_range_init - initialize virtual addresses range
> + *
> + * @hdev                : pointer to the habanalabs device structure
> + * @va_range            : pointer to the range to initialize
> + * @start               : range start address
> + * @end                 : range end address
> + *
> + * This function does the following:
> + * - Initializes the virtual addresses list of the given range with the given
> + *   addresses.
> + */
> +static int hl_va_range_init(struct hl_device *hdev,
> +		struct hl_va_range *va_range, u64 start, u64 end)
> +{
> +	int rc;
> +
> +	INIT_LIST_HEAD(&va_range->list);
> +
> +	/* PAGE_SIZE alignment */
> +
> +	if (start & (PAGE_SIZE - 1)) {
> +		start &= PAGE_MASK;
> +		start += PAGE_SIZE;
> +	}
> +
> +	if (end & (PAGE_SIZE - 1))
> +		end &= PAGE_MASK;
> +
> +	if (start >= end) {
> +		dev_err(hdev->dev, "too small vm range for va list\n");
> +		return -EFAULT;
> +	}
> +
> +	rc = add_va_block(hdev, va_range, start, end);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "Failed to init host va list\n");
> +		return rc;
> +	}
> +
> +	va_range->start_addr = start;
> +	va_range->end_addr = end;
> +
> +	return 0;
> +}
> +
> +/*
> + * hl_vm_ctx_init_with_ranges - initialize virtual memory for context
> + *
> + * @ctx                 : pointer to the habanalabs context structure
> + * @host_range_start    : host virtual addresses range start
> + * @host_range_end      : host virtual addresses range end
> + * @dram_range_start    : dram virtual addresses range start
> + * @dram_range_end      : dram virtual addresses range end
> + *
> + * This function initializes the following:
> + * - MMU for context
> + * - Virtual address to area descriptor hashtable
> + * - Virtual block list of available virtual memory
> + */
> +int hl_vm_ctx_init_with_ranges(struct hl_ctx *ctx, u64 host_range_start,
> +				u64 host_range_end, u64 dram_range_start,
> +				u64 dram_range_end)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	int rc;
> +
> +	hl_mmu_ctx_init(ctx);
> +
> +	mutex_init(&ctx->mem_hash_lock);
> +	hash_init(ctx->mem_hash);
> +
> +	mutex_init(&ctx->host_va_range.lock);
> +
> +	rc = hl_va_range_init(hdev, &ctx->host_va_range, host_range_start,
> +			host_range_end);
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to init host vm range\n");
> +		goto host_vm_err;
> +	}
> +
> +	mutex_init(&ctx->dram_va_range.lock);
> +
> +	rc = hl_va_range_init(hdev, &ctx->dram_va_range, dram_range_start,
> +			dram_range_end);
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to init dram vm range\n");
> +		goto dram_vm_err;
> +	}
> +
> +	return 0;
> +
> +dram_vm_err:
> +	mutex_destroy(&ctx->dram_va_range.lock);
> +
> +	mutex_lock(&ctx->host_va_range.lock);
> +	clear_va_list_locked(hdev, &ctx->host_va_range.list);
> +	mutex_unlock(&ctx->host_va_range.lock);
> +host_vm_err:
> +	mutex_destroy(&ctx->host_va_range.lock);
> +	mutex_destroy(&ctx->mem_hash_lock);
> +	hl_mmu_ctx_fini(ctx);
> +
> +	return rc;
> +}
> +
> +int hl_vm_ctx_init(struct hl_ctx *ctx)
> +{
> +	struct asic_fixed_properties *prop = &ctx->hdev->asic_prop;
> +	u64 host_range_start, host_range_end, dram_range_start,
> +		dram_range_end;
> +
> +	atomic64_set(&ctx->dram_phys_mem, 0);
> +
> +	/*
> +	 * - If MMU is enabled, init the ranges as usual.
> +	 * - If MMU is disabled, in case of host mapping, the returned address
> +	 *   is the given one.
> +	 *   In case of DRAM mapping, the returned address is the physical
> +	 *   address of the memory related to the given handle.
> +	 */
> +	if (ctx->hdev->mmu_enable) {
> +		dram_range_start = prop->va_space_dram_start_address;
> +		dram_range_end = prop->va_space_dram_end_address;
> +		host_range_start = prop->va_space_host_start_address;
> +		host_range_end = prop->va_space_host_end_address;
> +	} else {
> +		dram_range_start = prop->dram_user_base_address;
> +		dram_range_end = prop->dram_end_address;
> +		host_range_start = prop->dram_user_base_address;
> +		host_range_end = prop->dram_end_address;
> +	}
> +
> +	return hl_vm_ctx_init_with_ranges(ctx, host_range_start, host_range_end,
> +			dram_range_start, dram_range_end);
> +}
> +
> +/*
> + * hl_va_range_fini     - clear a virtual addresses range
> + *
> + * @hdev                : pointer to the habanalabs structure
> + * va_range             : pointer to virtual addresses range
> + *
> + * This function initializes the following:
> + * - Checks that the given range contains the whole initial range
> + * - Frees the virtual addresses block list and its lock
> + */
> +static void hl_va_range_fini(struct hl_device *hdev,
> +		struct hl_va_range *va_range)
> +{
> +	struct hl_vm_va_block *va_block;
> +
> +	if (list_empty(&va_range->list)) {
> +		dev_warn(hdev->dev,
> +				"va list should not be empty on cleanup!\n");
> +		goto out;
> +	}
> +
> +	if (!list_is_singular(&va_range->list)) {
> +		dev_warn(hdev->dev,
> +			"va list should not contain multiple blocks on cleanup!\n");
> +		goto free_va_list;
> +	}
> +
> +	va_block = list_first_entry(&va_range->list, typeof(*va_block), node);
> +
> +	if (va_block->start != va_range->start_addr ||
> +		va_block->end != va_range->end_addr) {
> +		dev_warn(hdev->dev,
> +			"wrong va block on cleanup, from 0x%llx to 0x%llx\n",
> +				va_block->start, va_block->end);
> +		goto free_va_list;
> +	}
> +
> +free_va_list:
> +	mutex_lock(&va_range->lock);
> +	clear_va_list_locked(hdev, &va_range->list);
> +	mutex_unlock(&va_range->lock);
> +
> +out:
> +	mutex_destroy(&va_range->lock);
> +}
> +
> +/*
> + * hl_vm_ctx_fini       - virtual memory teardown of context
> + *
> + * @ctx                 : pointer to the habanalabs context structure
> + *
> + * This function perform teardown the following:
> + * - Virtual block list of available virtual memory
> + * - Virtual address to area descriptor hashtable
> + * - MMU for context
> + *
> + * In addition this function does the following:
> + * - Unmaps the existing hashtable nodes if the hashtable is not empty. The
> + *   hashtable should be empty as no valid mappings should exist at this
> + *   point.
> + * - Frees any existing physical page list from the idr which relates to the
> + *   current context asid.
> + * - This function checks the virtual block list for correctness. At this point
> + *   the list should contain one element which describes the whole virtual
> + *   memory range of the context. Otherwise, a warning is printed.
> + */
> +void hl_vm_ctx_fini(struct hl_ctx *ctx)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	struct hl_vm *vm = &hdev->vm;
> +	struct hl_vm_phys_pg_pack *phys_pg_list;
> +	struct hl_vm_hash_node *hnode;
> +	struct hlist_node *tmp_node;
> +	int i;
> +
> +	if (!hash_empty(ctx->mem_hash))
> +		dev_notice(hdev->dev, "ctx is freed while it has va in use\n");
> +
> +	hash_for_each_safe(ctx->mem_hash, i, tmp_node, hnode, node) {
> +		dev_dbg(hdev->dev,
> +			"hl_mem_hash_node of vaddr 0x%llx of asid %d is still alive\n",
> +			hnode->vaddr, ctx->asid);
> +		unmap_device_va(ctx, hnode->vaddr);
> +	}
> +
> +	spin_lock(&vm->idr_lock);
> +	idr_for_each_entry(&vm->phys_pg_pack_handles, phys_pg_list, i)
> +		if (phys_pg_list->asid == ctx->asid) {
> +			dev_dbg(hdev->dev,
> +				"page list 0x%p of asid %d is still alive\n",
> +				phys_pg_list, ctx->asid);
> +			free_phys_pg_pack(hdev, phys_pg_list);
> +			idr_remove(&vm->phys_pg_pack_handles, i);
> +		}
> +	spin_unlock(&vm->idr_lock);
> +
> +	hl_va_range_fini(hdev, &ctx->dram_va_range);
> +	hl_va_range_fini(hdev, &ctx->host_va_range);
> +
> +	mutex_destroy(&ctx->mem_hash_lock);
> +	hl_mmu_ctx_fini(ctx);
> +}
> +
> +/*
> + * hl_vm_init           - initialize virtual memory module
> + *
> + * @hdev                : pointer to the habanalabs device structure
> + *
> + * This function initializes the following:
> + * - MMU module
> + * - DRAM physical pages pool of 2MB
> + * - Idr for device memory allocation handles
> + */
> +int hl_vm_init(struct hl_device *hdev)
> +{
> +	struct asic_fixed_properties *prop = &hdev->asic_prop;
> +	struct hl_vm *vm = &hdev->vm;
> +	int rc;
> +
> +	rc = hl_mmu_init(hdev);
> +	if (rc) {
> +		dev_err(hdev->dev, "Failed to init MMU\n");
> +		return rc;
> +	}
> +
> +	vm->dram_pg_pool = gen_pool_create(__ffs(prop->dram_page_size), -1);
> +	if (!vm->dram_pg_pool) {
> +		dev_err(hdev->dev, "Failed to create dram page pool\n");
> +		rc = -ENOMEM;
> +		goto pool_create_err;
> +	}
> +
> +	kref_init(&vm->dram_pg_pool_refcount);
> +
> +	rc = gen_pool_add(vm->dram_pg_pool, prop->dram_user_base_address,
> +			prop->dram_end_address - prop->dram_user_base_address,
> +			-1);
> +
> +	if (rc) {
> +		dev_err(hdev->dev,
> +			"Failed to add memory to dram page pool %d\n", rc);
> +		goto pool_add_err;
> +	}
> +
> +	spin_lock_init(&vm->idr_lock);
> +	idr_init(&vm->phys_pg_pack_handles);
> +
> +	atomic64_set(&hdev->dram_used_mem, 0);
> +
> +	vm->init_done = true;
> +
> +	return 0;
> +
> +pool_add_err:
> +	gen_pool_destroy(vm->dram_pg_pool);
> +pool_create_err:
> +	hl_mmu_fini(hdev);
> +
> +	return rc;
> +}
> +
> +/*
> + * hl_vm_fini           - virtual memory module teardown
> + *
> + * @hdev                : pointer to the habanalabs device structure
> + *
> + * This function perform teardown to the following:
> + * - Idr for device memory allocation handles
> + * - DRAM physical pages pool of 2MB
> + * - MMU module
> + */
> +void hl_vm_fini(struct hl_device *hdev)
> +{
> +	struct hl_vm *vm = &hdev->vm;
> +
> +	if (!vm->init_done)
> +		return;
> +
> +	/*
> +	 * At this point all the contexts should be freed and hence no DRAM
> +	 * memory should be in use. Hence the DRAM pool should be freed here.
> +	 */
> +	if (kref_put(&vm->dram_pg_pool_refcount, dram_pg_pool_do_release) != 1)
> +		dev_warn(hdev->dev, "dram_pg_pool was not destroyed on %s\n",
> +				__func__);
> +
> +	hl_mmu_fini(hdev);
> +
> +	vm->init_done = false;
> +}
> diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
> new file mode 100644
> index 000000000000..e6fa9d81933b
> --- /dev/null
> +++ b/drivers/misc/habanalabs/mmu.c
> @@ -0,0 +1,690 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2016-2018 HabanaLabs, Ltd.
> + * All Rights Reserved.
> + */
> +
> +#include "habanalabs.h"
> +#include "include/hw_ip/mmu/mmu_general.h"
> +
> +#include <linux/genalloc.h>
> +
> +static struct pgt_info *get_pgt_info(struct hl_ctx *ctx, u64 addr)
> +{
> +	struct pgt_info *pgt_info = NULL;
> +
> +	hash_for_each_possible(ctx->mmu_hash, pgt_info, node,
> +				(unsigned long) addr)
> +		if (addr == pgt_info->addr)
> +			break;
> +
> +	return pgt_info;
> +}
> +
> +static void free_hop(struct hl_ctx *ctx, u64 hop_addr)
> +{
> +	struct pgt_info *pgt_info = get_pgt_info(ctx, hop_addr);
> +
> +	gen_pool_free(pgt_info->ctx->hdev->mmu_pgt_pool, pgt_info->addr,
> +			ctx->hdev->asic_prop.mmu_hop_table_size);
> +	hash_del(&pgt_info->node);
> +
> +	kfree(pgt_info);
> +}
> +
> +static u64 alloc_hop(struct hl_ctx *ctx)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	struct pgt_info *pgt_info;
> +	u64 addr;
> +
> +	pgt_info = kmalloc(sizeof(*pgt_info), GFP_KERNEL);
> +	if (!pgt_info)
> +		return ULLONG_MAX;
> +
> +	addr = (u64) gen_pool_alloc(hdev->mmu_pgt_pool,
> +			hdev->asic_prop.mmu_hop_table_size);
> +	if (!addr) {
> +		dev_err(hdev->dev, "failed to allocate page\n");
> +		kfree(pgt_info);
> +		return ULLONG_MAX;
> +	}
> +
> +	pgt_info->addr = addr;
> +	pgt_info->ctx = ctx;
> +	pgt_info->num_of_ptes = 0;
> +	hash_add(ctx->mmu_hash, &pgt_info->node, addr);
> +
> +	return addr;
> +}
> +
> +static inline void clear_pte(struct hl_device *hdev, u64 pte_addr)
> +{
> +	/* clear the last and present bits */
> +	hdev->asic_funcs->write_pte(hdev, pte_addr, 0);
> +}
> +
> +static inline void get_pte(struct hl_ctx *ctx, u64 hop_addr)
> +{
> +	get_pgt_info(ctx, hop_addr)->num_of_ptes++;
> +}
> +
> +/*
> + * put_pte - decrement the num of ptes and free the hop if possible
> + *
> + * @ctx: pointer to the context structure
> + * @hop_addr: addr of the hop
> + *
> + * This function returns the number of ptes left on this hop. If the number is
> + * 0, it means the pte was freed.
> + */
> +static inline int put_pte(struct hl_ctx *ctx, u64 hop_addr)
> +{
> +	struct pgt_info *pgt_info = get_pgt_info(ctx, hop_addr);
> +	int num_of_ptes_left;
> +
> +	pgt_info->num_of_ptes--;
> +
> +	/*
> +	 * Need to save the number of ptes left because free_hop might free
> +	 * the pgt_info
> +	 */
> +	num_of_ptes_left = pgt_info->num_of_ptes;
> +	if (!num_of_ptes_left)
> +		free_hop(ctx, hop_addr);
> +
> +	return num_of_ptes_left;
> +}
> +
> +static inline u64 get_hop0_addr(struct hl_ctx *ctx)
> +{
> +	return ctx->hdev->asic_prop.mmu_pgt_addr +
> +			(ctx->asid * ctx->hdev->asic_prop.mmu_hop_table_size);
> +}
> +
> +static inline u64 get_hopN_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
> +					u64 virt_addr, u64 mask, u64 shift)
> +{
> +	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
> +			((virt_addr & mask) >> shift);
> +}
> +
> +static inline u64 get_hop0_pte_addr(struct hl_ctx *ctx, u64 hop_addr, u64 vaddr)
> +{
> +	return get_hopN_pte_addr(ctx, hop_addr, vaddr, HOP0_MASK, HOP0_SHIFT);
> +}
> +
> +static inline u64 get_hop1_pte_addr(struct hl_ctx *ctx, u64 hop_addr, u64 vaddr)
> +{
> +	return get_hopN_pte_addr(ctx, hop_addr, vaddr, HOP1_MASK, HOP1_SHIFT);
> +}
> +
> +static inline u64 get_hop2_pte_addr(struct hl_ctx *ctx, u64 hop_addr, u64 vaddr)
> +{
> +	return get_hopN_pte_addr(ctx, hop_addr, vaddr, HOP2_MASK, HOP2_SHIFT);
> +}
> +
> +static inline u64 get_hop3_pte_addr(struct hl_ctx *ctx, u64 hop_addr, u64 vaddr)
> +{
> +	return get_hopN_pte_addr(ctx, hop_addr, vaddr, HOP3_MASK, HOP3_SHIFT);
> +}
> +
> +static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx, u64 hop_addr, u64 vaddr)
> +{
> +	return get_hopN_pte_addr(ctx, hop_addr, vaddr, HOP4_MASK, HOP4_SHIFT);
> +}
> +
> +static inline u64 get_next_hop_addr(u64 curr_pte)
> +{
> +	if (curr_pte & PAGE_PRESENT_MASK)
> +		return curr_pte & PHYS_ADDR_MASK;
> +	else
> +		return ULLONG_MAX;
> +}
> +
> +static inline u64 get_alloc_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte,
> +						bool *is_new_hop)
> +{
> +	u64 hop_addr = get_next_hop_addr(curr_pte);
> +
> +	if (hop_addr == ULLONG_MAX) {
> +		hop_addr = alloc_hop(ctx);
> +		*is_new_hop = true;
> +	}
> +
> +	return hop_addr;
> +}
> +
> +/*
> + * hl_mmu_init - init the mmu module
> + *
> + * @hdev: pointer to the habanalabs device structure
> + *
> + * This function does the following:
> + * - Allocate max_asid zeroed hop0 pgts so no mapping is available
> + * - Enable mmu in hw
> + * - Invalidate the mmu cache
> + * - Create a pool of pages for pgts
> + * - Returns 0 on success
> + *
> + * This function depends on DMA QMAN to be working!
> + */
> +int hl_mmu_init(struct hl_device *hdev)
> +{
> +	struct asic_fixed_properties *prop = &hdev->asic_prop;
> +	int rc;
> +
> +	if (!hdev->mmu_enable)
> +		return 0;
> +
> +	/* MMU HW init was already done in device hw_init() */
> +
> +	mutex_init(&hdev->mmu_cache_lock);
> +
> +	hdev->mmu_pgt_pool =
> +			gen_pool_create(__ffs(prop->mmu_hop_table_size), -1);
> +
> +	if (!hdev->mmu_pgt_pool) {
> +		dev_err(hdev->dev, "Failed to create page gen pool\n");
> +		rc = -ENOMEM;
> +		goto err_pool_create;
> +	}
> +
> +	rc = gen_pool_add(hdev->mmu_pgt_pool, prop->mmu_pgt_addr +
> +			prop->mmu_hop0_tables_total_size,
> +			prop->mmu_pgt_size - prop->mmu_hop0_tables_total_size,
> +			-1);
> +	if (rc) {
> +		dev_err(hdev->dev, "Failed to add memory to page gen pool\n");
> +		goto err_pool_add;
> +	}
> +
> +	return 0;
> +
> +err_pool_add:
> +	gen_pool_destroy(hdev->mmu_pgt_pool);
> +err_pool_create:
> +	mutex_destroy(&hdev->mmu_cache_lock);
> +
> +	return rc;
> +}
> +
> +/*
> + * hl_mmu_fini - release the mmu module.
> + *
> + * @hdev: pointer to the habanalabs device structure
> + *
> + * This function does the following:
> + * - Disable mmu in hw
> + * - free the pgts pool
> + *
> + * All ctxs should be freed before calling this func
> + */
> +void hl_mmu_fini(struct hl_device *hdev)
> +{
> +	if (!hdev->mmu_enable)
> +		return;
> +
> +	gen_pool_destroy(hdev->mmu_pgt_pool);
> +
> +	mutex_destroy(&hdev->mmu_cache_lock);
> +
> +	/* MMU HW fini will be done in device hw_fini() */
> +}
> +
> +/*
> + * hl_mmu_ctx_init - init a ctx for using the mmu module
> + *
> + * @ctx: pointer to the context structure
> + *
> + * This function does the following:
> + * - Init a mutex to protect the concurrent mapping flow
> + * - Init a hash to hold all pgts related to this ctx
> + */
> +void hl_mmu_ctx_init(struct hl_ctx *ctx)
> +{
> +	if (!ctx->hdev->mmu_enable)
> +		return;
> +
> +	mutex_init(&ctx->mmu_lock);
> +	hash_init(ctx->mmu_hash);
> +}
> +
> +/*
> + * hl_mmu_ctx_fini - disable a ctx from using the mmu module
> + *
> + * @ctx: pointer to the context structure
> + *
> + * This function does the following:
> + * - Free any pgts which were not freed yet
> + * - Free the mutex
> + */
> +void hl_mmu_ctx_fini(struct hl_ctx *ctx)
> +{
> +	struct pgt_info *pgt_info;
> +	struct hlist_node *tmp;
> +	int i;
> +
> +	if (!ctx->hdev->mmu_enable)
> +		return;
> +
> +	if (!hash_empty(ctx->mmu_hash))
> +		dev_err(ctx->hdev->dev,
> +				"ctx is freed while it has pgts in use\n");
> +
> +	hash_for_each_safe(ctx->mmu_hash, i, tmp, pgt_info, node) {
> +		dev_err(ctx->hdev->dev,
> +			"pgt_info of addr 0x%llx of asid %d was not destroyed, num_ptes: %d\n",
> +			pgt_info->addr, ctx->asid, pgt_info->num_of_ptes);
> +		free_hop(ctx, pgt_info->addr);
> +	}
> +
> +	mutex_destroy(&ctx->mmu_lock);
> +}
> +
> +static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	u64 hop0_addr = 0, hop0_pte_addr = 0,
> +		hop1_addr = 0, hop1_pte_addr = 0,
> +		hop2_addr = 0, hop2_pte_addr = 0,
> +		hop3_addr = 0, hop3_pte_addr = 0,
> +		hop4_addr = 0, hop4_pte_addr = 0,
> +		curr_pte;
> +	int clear_hop3 = 1;
> +
> +	hop0_addr = get_hop0_addr(ctx);
> +
> +	hop0_pte_addr = get_hop0_pte_addr(ctx, hop0_addr, virt_addr);
> +
> +	curr_pte = hdev->asic_funcs->read_pte(hdev, hop0_pte_addr);
> +
> +	hop1_addr = get_next_hop_addr(curr_pte);
> +
> +	if (hop1_addr == ULLONG_MAX)
> +		goto not_mapped;
> +
> +	hop1_pte_addr = get_hop1_pte_addr(ctx, hop1_addr, virt_addr);
> +
> +	curr_pte = hdev->asic_funcs->read_pte(hdev, hop1_pte_addr);
> +
> +	hop2_addr = get_next_hop_addr(curr_pte);
> +
> +	if (hop2_addr == ULLONG_MAX)
> +		goto not_mapped;
> +
> +	hop2_pte_addr = get_hop2_pte_addr(ctx, hop2_addr, virt_addr);
> +
> +	curr_pte = hdev->asic_funcs->read_pte(hdev, hop2_pte_addr);
> +
> +	hop3_addr = get_next_hop_addr(curr_pte);
> +
> +	if (hop3_addr == ULLONG_MAX)
> +		goto not_mapped;
> +
> +	hop3_pte_addr = get_hop3_pte_addr(ctx, hop3_addr, virt_addr);
> +
> +	curr_pte = hdev->asic_funcs->read_pte(hdev, hop3_pte_addr);
> +
> +	if (!(curr_pte & LAST_MASK)) {
> +		hop4_addr = get_next_hop_addr(curr_pte);
> +
> +		if (hop4_addr == ULLONG_MAX)
> +			goto not_mapped;
> +
> +		hop4_pte_addr = get_hop4_pte_addr(ctx, hop4_addr, virt_addr);
> +
> +		curr_pte = hdev->asic_funcs->read_pte(hdev, hop4_pte_addr);
> +
> +		clear_hop3 = 0;
> +	}
> +
> +	if (!(curr_pte & PAGE_PRESENT_MASK))
> +		goto not_mapped;
> +
> +	clear_pte(hdev, hop4_addr ? hop4_pte_addr : hop3_pte_addr);
> +
> +	if (hop4_addr && !put_pte(ctx, hop4_addr))
> +		clear_hop3 = 1;
> +
> +	if (!clear_hop3)
> +		goto flush;
> +	clear_pte(hdev, hop3_pte_addr);
> +
> +	if (put_pte(ctx, hop3_addr))
> +		goto flush;
> +	clear_pte(hdev, hop2_pte_addr);
> +
> +	if (put_pte(ctx, hop2_addr))
> +		goto flush;
> +	clear_pte(hdev, hop1_pte_addr);
> +
> +	if (put_pte(ctx, hop1_addr))
> +		goto flush;
> +	clear_pte(hdev, hop0_pte_addr);
> +
> +flush:
> +	/* flush all writes from all cores to reach PCI */
> +	mb();
> +
> +	hdev->asic_funcs->read_pte(hdev,
> +				hop4_addr ? hop4_pte_addr : hop3_pte_addr);
> +
> +	return 0;
> +
> +not_mapped:
> +	dev_err(hdev->dev, "virt addr 0x%llx is not mapped to phys addr\n",
> +		virt_addr);
> +
> +	return -EINVAL;
> +}
> +
> +/*
> + * hl_mmu_unmap - unmaps a virtual addr
> + *
> + * @ctx: pointer to the context structure
> + * @virt_addr: virt addr to map from
> + * @page_size: size of the page to unmap
> + *
> + * This function does the following:
> + * - Check that the virt addr is mapped
> + * - Unmap the virt addr and frees pgts if possible
> + * - Returns 0 on success, -EINVAL if the given addr is not mapped
> + *
> + * Because this function changes the page tables in the device and because it
> + * changes the MMU hash, it must be protected by a lock.
> + * However, because it maps only a single page, the lock should be implemented
> + * in a higher level in order to protect the entire mapping of the memory area
> + */
> +int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	u64 real_virt_addr;
> +	u32 real_page_size, npages;
> +	int i, rc;
> +
> +	if (!hdev->mmu_enable)
> +		return 0;
> +
> +	/*
> +	 * The H/W handles mapping of 4KB/2MB page. Hence if the host page size
> +	 * is bigger, we break it to sub-pages and unmap them separately.
> +	 */
> +	if ((page_size % PAGE_SIZE_2MB) == 0) {
> +		real_page_size = PAGE_SIZE_2MB;
> +	} else if ((page_size % PAGE_SIZE_4KB) == 0) {
> +		real_page_size = PAGE_SIZE_4KB;
> +	} else {
> +		dev_err(hdev->dev,
> +			"page size of %u is not 4KB nor 2MB aligned, can't unmap\n",
> +				page_size);
> +
> +		return -EFAULT;
> +	}
> +
> +	npages = page_size / real_page_size;
> +	real_virt_addr = virt_addr;
> +
> +	for (i = 0 ; i < npages ; i++) {
> +		rc = _hl_mmu_unmap(ctx, real_virt_addr);
> +		if (rc)
> +			return rc;
> +
> +		real_virt_addr += real_page_size;
> +	}
> +
> +	return 0;
> +}
> +
> +static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
> +		u32 page_size)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	u64 hop0_addr = 0, hop0_pte_addr = 0,
> +		hop1_addr = 0, hop1_pte_addr = 0,
> +		hop2_addr = 0, hop2_pte_addr = 0,
> +		hop3_addr = 0, hop3_pte_addr = 0,
> +		hop4_addr = 0, hop4_pte_addr = 0,
> +		curr_pte = 0;
> +	bool hop1_new = false, hop2_new = false, hop3_new = false,
> +		hop4_new = false, is_huge;
> +	int rc = -ENOMEM;
> +
> +	/*
> +	 * This mapping function can map a 4KB/2MB page. For 2MB page there are
> +	 * only 3 hops rather than 4. Currently the DRAM allocation uses 2MB
> +	 * pages only but user memory could have been allocated with one of the
> +	 * two page sizes. Since this is a common code for all the three cases,
> +	 * we need this hugs page check.
> +	 */
> +	is_huge = page_size == PAGE_SIZE_2MB;
> +
> +	hop0_addr = get_hop0_addr(ctx);
> +
> +	hop0_pte_addr = get_hop0_pte_addr(ctx, hop0_addr, virt_addr);
> +
> +	curr_pte = hdev->asic_funcs->read_pte(hdev, hop0_pte_addr);
> +
> +	hop1_addr = get_alloc_next_hop_addr(ctx, curr_pte, &hop1_new);
> +
> +	if (hop1_addr == ULLONG_MAX)
> +		goto err;
> +
> +	hop1_pte_addr = get_hop1_pte_addr(ctx, hop1_addr, virt_addr);
> +
> +	curr_pte = hdev->asic_funcs->read_pte(hdev, hop1_pte_addr);
> +
> +	hop2_addr = get_alloc_next_hop_addr(ctx, curr_pte, &hop2_new);
> +
> +	if (hop2_addr == ULLONG_MAX)
> +		goto err;
> +
> +	hop2_pte_addr = get_hop2_pte_addr(ctx, hop2_addr, virt_addr);
> +
> +	curr_pte = hdev->asic_funcs->read_pte(hdev, hop2_pte_addr);
> +
> +	hop3_addr = get_alloc_next_hop_addr(ctx, curr_pte, &hop3_new);
> +
> +	if (hop3_addr == ULLONG_MAX)
> +		goto err;
> +
> +	hop3_pte_addr = get_hop3_pte_addr(ctx, hop3_addr, virt_addr);
> +
> +	curr_pte = hdev->asic_funcs->read_pte(hdev, hop3_pte_addr);
> +
> +	if (!is_huge) {
> +		hop4_addr = get_alloc_next_hop_addr(ctx, curr_pte, &hop4_new);
> +
> +		if (hop4_addr == ULLONG_MAX)
> +			goto err;
> +
> +		hop4_pte_addr = get_hop4_pte_addr(ctx, hop4_addr, virt_addr);
> +
> +		curr_pte = hdev->asic_funcs->read_pte(hdev, hop4_pte_addr);
> +	}
> +
> +	if (curr_pte & PAGE_PRESENT_MASK) {
> +		dev_err(hdev->dev,
> +				"mapping already exists for virt_addr 0x%llx\n",
> +					virt_addr);
> +
> +		dev_dbg(hdev->dev, "hop0 pte: 0x%llx (0x%llx)\n",
> +				hdev->asic_funcs->read_pte(hdev, hop0_pte_addr),
> +				hop0_pte_addr);
> +		dev_dbg(hdev->dev, "hop1 pte: 0x%llx (0x%llx)\n",
> +				hdev->asic_funcs->read_pte(hdev, hop1_pte_addr),
> +				hop1_pte_addr);
> +		dev_dbg(hdev->dev, "hop2 pte: 0x%llx (0x%llx)\n",
> +				hdev->asic_funcs->read_pte(hdev, hop2_pte_addr),
> +				hop2_pte_addr);
> +		dev_dbg(hdev->dev, "hop3 pte: 0x%llx (0x%llx)\n",
> +				hdev->asic_funcs->read_pte(hdev, hop3_pte_addr),
> +				hop3_pte_addr);
> +
> +		if (!is_huge)
> +			dev_dbg(hdev->dev, "hop4 pte: 0x%llx (0x%llx)\n",
> +				hdev->asic_funcs->read_pte(hdev,
> +							hop4_pte_addr),
> +							hop4_pte_addr);
> +
> +		rc = EINVAL;
> +		goto err;
> +	}
> +
> +	curr_pte = (phys_addr & PTE_PHYS_ADDR_MASK) | LAST_MASK
> +			| PAGE_PRESENT_MASK;
> +
> +	hdev->asic_funcs->write_pte(hdev,
> +				is_huge ? hop3_pte_addr : hop4_pte_addr,
> +				curr_pte);
> +
> +	if (hop1_new) {
> +		curr_pte = (hop1_addr & PTE_PHYS_ADDR_MASK) |
> +				PAGE_PRESENT_MASK;
> +		ctx->hdev->asic_funcs->write_pte(ctx->hdev, hop0_pte_addr,
> +				curr_pte);
> +	}
> +	if (hop2_new) {
> +		curr_pte = (hop2_addr & PTE_PHYS_ADDR_MASK) |
> +				PAGE_PRESENT_MASK;
> +		ctx->hdev->asic_funcs->write_pte(ctx->hdev, hop1_pte_addr,
> +				curr_pte);
> +		get_pte(ctx, hop1_addr);
> +	}
> +	if (hop3_new) {
> +		curr_pte = (hop3_addr & PTE_PHYS_ADDR_MASK) |
> +				PAGE_PRESENT_MASK;
> +		ctx->hdev->asic_funcs->write_pte(ctx->hdev, hop2_pte_addr,
> +				curr_pte);
> +		get_pte(ctx, hop2_addr);
> +	}
> +
> +	if (!is_huge) {
> +		if (hop4_new) {
> +			curr_pte = (hop4_addr & PTE_PHYS_ADDR_MASK) |
> +					PAGE_PRESENT_MASK;
> +			ctx->hdev->asic_funcs->write_pte(ctx->hdev,
> +					hop3_pte_addr, curr_pte);
> +			get_pte(ctx, hop3_addr);
> +		}
> +
> +		get_pte(ctx, hop4_addr);
> +	} else {
> +		get_pte(ctx, hop3_addr);
> +	}
> +
> +	/* flush all writes from all cores to reach PCI */
> +	mb();
> +
> +	hdev->asic_funcs->read_pte(hdev,
> +				is_huge ? hop3_pte_addr : hop4_pte_addr);
> +
> +	return 0;
> +
> +err:
> +	if (hop4_new)
> +		free_hop(ctx, hop4_addr);
> +	if (hop3_new)
> +		free_hop(ctx, hop3_addr);
> +	if (hop2_new)
> +		free_hop(ctx, hop2_addr);
> +	if (hop1_new)
> +		free_hop(ctx, hop1_addr);
> +
> +	return rc;
> +}
> +
> +/*
> + * hl_mmu_map - maps a virtual addr to physical addr
> + *
> + * @ctx: pointer to the context structure
> + * @virt_addr: virt addr to map from
> + * @phys_addr: phys addr to map to
> + * @page_size: physical page size
> + *
> + * This function does the following:
> + * - Check that the virt addr is not mapped
> + * - Allocate pgts as necessary in order to map the virt addr to the phys
> + * - Returns 0 on success, -EINVAL if addr is already mapped, or -ENOMEM.
> + *
> + * Because this function changes the page tables in the device and because it
> + * changes the MMU hash, it must be protected by a lock.
> + * However, because it maps only a single page, the lock should be implemented
> + * in a higher level in order to protect the entire mapping of the memory area
> + */
> +int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +	u64 real_virt_addr;
> +	u32 real_page_size, npages;
> +	int i, rc, mapped_cnt = 0;
> +
> +	if (!hdev->mmu_enable)
> +		return 0;
> +
> +	/*
> +	 * The H/W handles mapping of 4KB/2MB page. Hence if the host page size
> +	 * is bigger, we break it to sub-pages and map them separately.
> +	 */
> +	if ((page_size % PAGE_SIZE_2MB) == 0) {
> +		real_page_size = PAGE_SIZE_2MB;
> +	} else if ((page_size % PAGE_SIZE_4KB) == 0) {
> +		real_page_size = PAGE_SIZE_4KB;
> +	} else {
> +		dev_err(hdev->dev,
> +			"page size of %u is not 4KB nor 2MB aligned, can't map\n",
> +				page_size);
> +
> +		return -EFAULT;
> +	}
> +
> +	npages = page_size / real_page_size;
> +	real_virt_addr = virt_addr;
> +
> +	for (i = 0 ; i < npages ; i++) {
> +		rc = _hl_mmu_map(ctx, real_virt_addr, phys_addr,
> +				real_page_size);
> +		if (rc)
> +			goto err;
> +
> +		real_virt_addr += real_page_size;
> +		mapped_cnt++;
> +	}
> +
> +	return 0;
> +
> +err:
> +	real_virt_addr = virt_addr;
> +	for (i = 0 ; i < mapped_cnt ; i++) {
> +		if (_hl_mmu_unmap(ctx, real_virt_addr))
> +			dev_warn_ratelimited(hdev->dev,
> +				"failed to unmap va: 0x%llx\n", real_virt_addr);
> +
> +		real_virt_addr += real_page_size;
> +	}
> +
> +	return rc;
> +}
> +
> +/*
> + * hl_mmu_swap_out - marks all mapping of the given ctx as swapped out
> + *
> + * @ctx: pointer to the context structure
> + *
> + */
> +void hl_mmu_swap_out(struct hl_ctx *ctx)
> +{
> +
> +}
> +
> +/*
> + * hl_mmu_swap_in - marks all mapping of the given ctx as swapped in
> + *
> + * @ctx: pointer to the context structure
> + *
> + */
> +void hl_mmu_swap_in(struct hl_ctx *ctx)
> +{
> +
> +}
> diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
> index fba49417f607..9015043887d1 100644
> --- a/include/uapi/misc/habanalabs.h
> +++ b/include/uapi/misc/habanalabs.h
> @@ -162,6 +162,108 @@ union hl_wait_cs_args {
>  	struct hl_wait_cs_out out;
>  };
>  
> +/* Opcode to alloc device memory */
> +#define HL_MEM_OP_ALLOC			0
> +/* Opcode to free previously allocated device memory */
> +#define HL_MEM_OP_FREE			1
> +/* Opcode to map host memory */
> +#define HL_MEM_OP_MAP			2
> +/* Opcode to unmap previously mapped host memory */
> +#define HL_MEM_OP_UNMAP			3
> +
> +/* Memory flags */
> +#define HL_MEM_CONTIGUOUS	0x1
> +#define HL_MEM_SHARED		0x2
> +#define HL_MEM_USERPTR		0x4
> +
> +struct hl_mem_in {
> +	union {
> +		/* HL_MEM_OP_ALLOC- allocate device memory */
> +		struct {
> +			/* Size to alloc */
> +			__u32 mem_size;
> +			__u32 pad;
> +		} alloc;
> +
> +		/* HL_MEM_OP_FREE - free device memory */
> +		struct {
> +			/* Handle returned from HL_MEM_OP_ALLOC */
> +			__u64 handle;
> +		} free;
> +
> +		/* HL_MEM_OP_MAP - map device memory */
> +		struct {
> +			/*
> +			 * Requested virtual address of mapped memory.
> +			 * KMD will try to map the requested region to this
> +			 * hint address, as long as the address is valid and
> +			 * not already mapped. The user should check the
> +			 * returned address of the IOCTL to make sure he got
> +			 * the hint address. Passing 0 here means that KMD
> +			 * will choose the address itself.
> +			 */
> +			__u64 hint_addr;
> +			/* Handle returned from HL_MEM_OP_ALLOC */
> +			__u64 handle;
> +		} map_device;
> +
> +		/* HL_MEM_OP_MAP - map host memory */
> +		struct {
> +			/* Address of allocated host memory */
> +			__u64 host_virt_addr;
> +			/*
> +			 * Requested virtual address of mapped memory.
> +			 * KMD will try to map the requested region to this
> +			 * hint address, as long as the address is valid and
> +			 * not already mapped. The user should check the
> +			 * returned address of the IOCTL to make sure he got
> +			 * the hint address. Passing 0 here means that KMD
> +			 * will choose the address itself.
> +			 */
> +			__u64 hint_addr;
> +			/* Size of allocated host memory */
> +			__u32 mem_size;
> +			__u32 pad;
> +		} map_host;
> +
> +		/* HL_MEM_OP_UNMAP - unmap host memory */
> +		struct {
> +			/* Virtual address returned from HL_MEM_OP_MAP */
> +			__u64 device_virt_addr;
> +		} unmap;
> +	};
> +
> +	/* HL_MEM_OP_* */
> +	__u32 op;
> +	/* HL_MEM_* flags */
> +	__u32 flags;
> +	/* Context ID - Currently not in use */
> +	__u32 ctx_id;
> +	__u32 pad;
> +};
> +
> +struct hl_mem_out {
> +	union {
> +		/*
> +		 * Used for HL_MEM_OP_MAP as the virtual address that was
> +		 * assigned in the device VA space.
> +		 * A value of 0 means the requested operation failed.
> +		 */
> +		__u64 device_virt_addr;
> +
> +		/*
> +		 * Used for HL_MEM_OP_ALLOC. This is the assigned
> +		 * handle for the allocated memory
> +		 */
> +		__u64 handle;
> +	};
> +};
> +
> +union hl_mem_args {
> +	struct hl_mem_in in;
> +	struct hl_mem_out out;
> +};
> +
>  /*
>   * Command Buffer
>   * - Request a Command Buffer
> @@ -245,7 +347,25 @@ union hl_wait_cs_args {
>  #define HL_IOCTL_WAIT_CS			\
>  		_IOWR('H', 0x04, union hl_wait_cs_args)
>  
> +/*
> + * Memory
> + * - Map host memory to device MMU
> + * - Unmap host memory from device MMU
> + *
> + * This IOCTL allows the user to map host memory to the device MMU
> + *
> + * For host memory, the IOCTL doesn't allocate memory. The user is supposed
> + * to allocate the memory in user-space (malloc/new). The driver pins the
> + * physical pages (up to the allowed limit by the OS), assigns a virtual
> + * address in the device VA space and initializes the device MMU.
> + *
> + * There is an option for the user to specify the requested virtual address.
> + *
> + */
> +#define HL_IOCTL_MEMORY		\
> +		_IOWR('H', 0x05, union hl_mem_args)
> +
>  #define HL_COMMAND_START	0x02
> -#define HL_COMMAND_END		0x05
> +#define HL_COMMAND_END		0x06
>  
>  #endif /* HABANALABS_H_ */
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

