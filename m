Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3C4C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B85E21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfAWM2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:28:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725995AbfAWM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:28:50 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NCOTSa133654
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:28:45 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q6qwas996-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:28:45 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 23 Jan 2019 12:28:43 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Jan 2019 12:28:40 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0NCSd5R3014942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 12:28:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBE6C4C04A;
        Wed, 23 Jan 2019 12:28:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 726B94C052;
        Wed, 23 Jan 2019 12:28:38 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.208])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Jan 2019 12:28:38 +0000 (GMT)
Date:   Wed, 23 Jan 2019 14:28:36 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ogabbay@habana.ai
Subject: Re: [PATCH 04/15] habanalabs: add context and ASID modules
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
 <20190123000057.31477-5-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123000057.31477-5-oded.gabbay@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012312-0008-0000-0000-000002B4DFE8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012312-0009-0000-0000-000022210FDC
Message-Id: <20190123122836.GD4747@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:00:46AM +0200, Oded Gabbay wrote:
> This patch adds two modules - ASID and context.
> 
> Each user process the opens a device's file must have at least one context

                   ^that

> before it is able to "work" with the device. Each context has its own
> device address-space and contains information about its runtime state (its
> active command submissions).
> 
> To have address-space separation between contexts, each context is assigned
> a unique ASID, which stands for "address-space id". Goya supports up to
> 1024 ASIDs.
> 
> Currently, the driver doesn't support multiple contexts. Therefore, the
> user doesn't need to actively create a context. A "primary context" is
> created automatically when the user opens the device's file.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  drivers/misc/habanalabs/Makefile         |   2 +-
>  drivers/misc/habanalabs/asid.c           |  58 +++++++++
>  drivers/misc/habanalabs/context.c        | 155 +++++++++++++++++++++++
>  drivers/misc/habanalabs/device.c         |  47 +++++++
>  drivers/misc/habanalabs/habanalabs.h     |  70 ++++++++++
>  drivers/misc/habanalabs/habanalabs_drv.c |  46 ++++++-
>  6 files changed, 375 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/misc/habanalabs/asid.c
>  create mode 100644 drivers/misc/habanalabs/context.c
> 
> diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
> index 6f1ead69bd77..3ffbadc2ca01 100644
> --- a/drivers/misc/habanalabs/Makefile
> +++ b/drivers/misc/habanalabs/Makefile
> @@ -4,7 +4,7 @@
>  
>  obj-m	:= habanalabs.o
>  
> -habanalabs-y := habanalabs_drv.o device.o
> +habanalabs-y := habanalabs_drv.o device.o context.o asid.o
>  
>  include $(src)/goya/Makefile
>  habanalabs-y += $(HL_GOYA_FILES)
> diff --git a/drivers/misc/habanalabs/asid.c b/drivers/misc/habanalabs/asid.c
> new file mode 100644
> index 000000000000..0ce84c8f5a47
> --- /dev/null
> +++ b/drivers/misc/habanalabs/asid.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2016-2018 HabanaLabs, Ltd.
> + * All Rights Reserved.
> + */
> +
> +#include "habanalabs.h"
> +
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +int hl_asid_init(struct hl_device *hdev)
> +{
> +	hdev->asid_bitmap = kcalloc(BITS_TO_LONGS(hdev->asic_prop.max_asid),
> +					sizeof(*hdev->asid_bitmap), GFP_KERNEL);
> +	if (!hdev->asid_bitmap)
> +		return -ENOMEM;
> +
> +	mutex_init(&hdev->asid_mutex);
> +
> +	/* ASID 0 is reserved for KMD */
> +	set_bit(0, hdev->asid_bitmap);
> +
> +	return 0;
> +}
> +
> +void hl_asid_fini(struct hl_device *hdev)
> +{
> +	mutex_destroy(&hdev->asid_mutex);
> +	kfree(hdev->asid_bitmap);
> +}
> +
> +unsigned long hl_asid_alloc(struct hl_device *hdev)
> +{
> +	unsigned long found;
> +
> +	mutex_lock(&hdev->asid_mutex);
> +
> +	found = find_first_zero_bit(hdev->asid_bitmap,
> +					hdev->asic_prop.max_asid);
> +	if (found == hdev->asic_prop.max_asid)
> +		found = 0;
> +	else
> +		set_bit(found, hdev->asid_bitmap);
> +
> +	mutex_unlock(&hdev->asid_mutex);
> +
> +	return found;
> +}
> +
> +void hl_asid_free(struct hl_device *hdev, unsigned long asid)
> +{
> +	if (WARN((asid == 0 || asid >= hdev->asic_prop.max_asid),
> +						"Invalid ASID %lu", asid))
> +		return;
> +	clear_bit(asid, hdev->asid_bitmap);
> +}
> diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
> new file mode 100644
> index 000000000000..cdcad077e5cf
> --- /dev/null
> +++ b/drivers/misc/habanalabs/context.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2016-2018 HabanaLabs, Ltd.
> + * All Rights Reserved.
> + */
> +
> +#include "habanalabs.h"
> +
> +#include <linux/sched.h>
> +#include <linux/delay.h>
> +
> +static void hl_ctx_fini(struct hl_ctx *ctx)
> +{
> +	struct hl_device *hdev = ctx->hdev;
> +
> +	if (ctx->asid != HL_KERNEL_ASID_ID)
> +		hl_asid_free(hdev, ctx->asid);
> +}
> +
> +void hl_ctx_do_release(struct kref *ref)
> +{
> +	struct hl_ctx *ctx;
> +
> +	ctx = container_of(ref, struct hl_ctx, refcount);
> +
> +	dev_dbg(ctx->hdev->dev, "Now really releasing context %d\n", ctx->asid);
> +
> +	hl_ctx_fini(ctx);
> +
> +	if (ctx->hpriv)
> +		hl_hpriv_put(ctx->hpriv);
> +
> +	kfree(ctx);
> +}
> +
> +int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
> +{
> +	struct hl_ctx_mgr *mgr = &hpriv->ctx_mgr;
> +	struct hl_ctx *ctx;
> +	int rc;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx) {
> +		rc = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	rc = hl_ctx_init(hdev, ctx, false);
> +	if (rc)
> +		goto free_ctx;
> +
> +	hl_hpriv_get(hpriv);
> +	ctx->hpriv = hpriv;
> +
> +	/* TODO: remove for multiple contexts */
> +	hpriv->ctx = ctx;
> +	hdev->user_ctx = ctx;
> +
> +	mutex_lock(&mgr->ctx_lock);
> +	rc = idr_alloc(&mgr->ctx_handles, ctx, 1, 0, GFP_KERNEL);
> +	mutex_unlock(&mgr->ctx_lock);
> +
> +	if (rc < 0) {
> +		dev_err(hdev->dev, "Failed to allocate IDR for a new CTX\n");
> +		hl_ctx_free(hdev, ctx);
> +		goto out_err;
> +	}
> +
> +	return 0;
> +
> +free_ctx:
> +	kfree(ctx);
> +out_err:
> +	return rc;
> +}
> +
> +void hl_ctx_free(struct hl_device *hdev, struct hl_ctx *ctx)
> +{
> +	if (kref_put(&ctx->refcount, hl_ctx_do_release) == 1)
> +		return;
> +
> +	dev_warn(hdev->dev,
> +		"Context %d closed or terminated but its CS are executing\n",
> +		ctx->asid);
> +}
> +
> +int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
> +{
> +	ctx->hdev = hdev;
> +
> +	kref_init(&ctx->refcount);
> +
> +	if (is_kernel_ctx) {
> +		ctx->asid = HL_KERNEL_ASID_ID; /* KMD gets ASID 0 */
> +	} else {
> +		ctx->asid = hl_asid_alloc(hdev);
> +		if (!ctx->asid) {
> +			dev_err(hdev->dev, "No free ASID, failed to create context\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	dev_dbg(hdev->dev, "Created context with ASID %u\n", ctx->asid);
> +
> +	return 0;
> +}
> +
> +void hl_ctx_get(struct hl_device *hdev, struct hl_ctx *ctx)
> +{
> +	kref_get(&ctx->refcount);
> +}
> +
> +int hl_ctx_put(struct hl_ctx *ctx)
> +{
> +	return kref_put(&ctx->refcount, hl_ctx_do_release);
> +}
> +
> +/**
> + * hl_ctx_mgr_init - initialize the context manager
> + *
> + * @mgr: pointer to context manager structure
> + *
> + * This manager is an object inside the hpriv object of the user process.
> + * The function is called when a user process opens the FD.
> + */
> +void hl_ctx_mgr_init(struct hl_ctx_mgr *mgr)
> +{
> +	mutex_init(&mgr->ctx_lock);
> +	idr_init(&mgr->ctx_handles);
> +}
> +
> +/**
> + * hl_ctx_mgr_fini - finalize the context manager
> + *
> + * @hdev: pointer to device structure
> + * @mgr: pointer to context manager structure
> + *
> + * This function goes over all the contexts in the manager and frees them.
> + * It is called when a process closes the FD.
> + */
> +void hl_ctx_mgr_fini(struct hl_device *hdev, struct hl_ctx_mgr *mgr)
> +{
> +	struct hl_ctx *ctx;
> +	struct idr *idp;
> +	u32 id;
> +
> +	idp = &mgr->ctx_handles;
> +
> +	idr_for_each_entry(idp, ctx, id)
> +		hl_ctx_free(hdev, ctx);
> +
> +	idr_destroy(&mgr->ctx_handles);
> +	mutex_destroy(&mgr->ctx_lock);
> +}
> diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> index a4276ef559b3..84ce9fcb52da 100644
> --- a/drivers/misc/habanalabs/device.c
> +++ b/drivers/misc/habanalabs/device.c
> @@ -23,6 +23,12 @@ static void hpriv_release(struct kref *ref)
>  	put_pid(hpriv->taskpid);
>  
>  	kfree(hpriv);
> +
> +	/* Now the FD is really closed */
> +	atomic_dec(&hdev->fd_open_cnt);
> +
> +	/* This allows a new user context to open the device */
> +	hdev->user_ctx = NULL;
>  }
>  
>  void hl_hpriv_get(struct hl_fpriv *hpriv)
> @@ -47,6 +53,8 @@ static int hl_device_release(struct inode *inode, struct file *filp)
>  {
>  	struct hl_fpriv *hpriv = filp->private_data;
>  
> +	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
> +
>  	filp->private_data = NULL;
>  
>  	hl_hpriv_put(hpriv);
> @@ -133,7 +141,20 @@ static int device_early_init(struct hl_device *hdev)
>  	if (rc)
>  		return rc;
>  
> +	rc = hl_asid_init(hdev);
> +	if (rc)
> +		goto early_fini;
> +
> +	mutex_init(&hdev->device_open);
> +	atomic_set(&hdev->fd_open_cnt, 0);
> +
>  	return 0;
> +
> +early_fini:
> +	if (hdev->asic_funcs->early_fini)
> +		hdev->asic_funcs->early_fini(hdev);
> +
> +	return rc;
>  }
>  
>  /**
> @@ -145,9 +166,12 @@ static int device_early_init(struct hl_device *hdev)
>  static void device_early_fini(struct hl_device *hdev)
>  {
>  
> +	hl_asid_fini(hdev);
> +
>  	if (hdev->asic_funcs->early_fini)
>  		hdev->asic_funcs->early_fini(hdev);
>  
> +	mutex_destroy(&hdev->device_open);
>  }
>  
>  /**
> @@ -241,11 +265,30 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
>  	if (rc)
>  		goto early_fini;
>  
> +	/* Allocate the kernel context */
> +	hdev->kernel_ctx = kzalloc(sizeof(*hdev->kernel_ctx), GFP_KERNEL);
> +	if (!hdev->kernel_ctx) {
> +		rc = -ENOMEM;
> +		goto sw_fini;
> +	}
> +
> +	hdev->user_ctx = NULL;
> +
> +	rc = hl_ctx_init(hdev, hdev->kernel_ctx, true);
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to initialize kernel context\n");
> +		goto free_ctx;
> +	}
> +
>  	dev_notice(hdev->dev,
>  		"Successfully added device to habanalabs driver\n");
>  
>  	return 0;
>  
> +free_ctx:
> +	kfree(hdev->kernel_ctx);
> +sw_fini:
> +	hdev->asic_funcs->sw_fini(hdev);
>  early_fini:
>  	device_early_fini(hdev);
>  release_device:
> @@ -278,6 +321,10 @@ void hl_device_fini(struct hl_device *hdev)
>  	/* Mark device as disabled */
>  	hdev->disabled = true;
>  
> +	/* Release kernel context */
> +	if ((hdev->kernel_ctx) && (hl_ctx_put(hdev->kernel_ctx) != 1))
> +		dev_err(hdev->dev, "kernel ctx is still alive\n");
> +
>  	/* Call ASIC S/W finalize function */
>  	hdev->asic_funcs->sw_fini(hdev);
>  
> diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
> index 97844825f7a8..d003a6af2131 100644
> --- a/drivers/misc/habanalabs/habanalabs.h
> +++ b/drivers/misc/habanalabs/habanalabs.h
> @@ -125,6 +125,45 @@ struct hl_asic_funcs {
>  					void *cpu_addr, dma_addr_t dma_handle);
>  };
>  
> +
> +
> +
> +
> +/*
> + * CONTEXTS
> + */
> +
> +#define HL_KERNEL_ASID_ID	0
> +
> +/**
> + * struct hl_ctx - user/kernel context.
> + * @hpriv: pointer to the private (KMD) data of the process (fd).
> + * @hdev: pointer to the device structure.
> + * @refcount: reference counter for the context. Context is released only when
> + *		this hits 0l. It is incremented on CS and CS_WAIT.
> + * @asid: context's unique address space ID in the device's MMU.
> + */
> +struct hl_ctx {
> +	struct hl_fpriv		*hpriv;
> +	struct hl_device	*hdev;
> +	struct kref		refcount;
> +	u32			asid;
> +};
> +
> +/**
> + * struct hl_ctx_mgr - for handling multiple contexts.
> + * @ctx_lock: protects ctx_handles.
> + * @ctx_handles: idr to hold all ctx handles.
> + */
> +struct hl_ctx_mgr {
> +	struct mutex		ctx_lock;
> +	struct idr		ctx_handles;
> +};
> +
> +
> +
> +
> +
>  /*
>   * FILE PRIVATE STRUCTURE
>   */
> @@ -134,12 +173,16 @@ struct hl_asic_funcs {
>   * @hdev: habanalabs device structure.
>   * @filp: pointer to the given file structure.
>   * @taskpid: current process ID.
> + * @ctx: current executing context.
> + * @ctx_mgr: context manager to handle multiple context for this FD.
>   * @refcount: number of related contexts.
>   */
>  struct hl_fpriv {
>  	struct hl_device	*hdev;
>  	struct file		*filp;
>  	struct pid		*taskpid;
> +	struct hl_ctx		*ctx; /* TODO: remove for multiple ctx */
> +	struct hl_ctx_mgr	ctx_mgr;
>  	struct kref		refcount;
>  };
>  
> @@ -195,13 +238,19 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
>   * @dev: realted kernel basic device structure.
>   * @asic_name: ASIC specific nmae.
>   * @asic_type: ASIC specific type.
> + * @kernel_ctx: KMD context structure.
>   * @dma_pool: DMA pool for small allocations.
>   * @cpu_accessible_dma_mem: KMD <-> ArmCP shared memory CPU address.
>   * @cpu_accessible_dma_address: KMD <-> ArmCP shared memory DMA address.
>   * @cpu_accessible_dma_pool: KMD <-> ArmCP shared memory pool.
> + * @asid_bitmap: holds used/available ASIDs.
> + * @asid_mutex: protects asid_bitmap.
> + * @device_open: lock for sanity checks upon FD open.

device_open is an ambiguous name for a lock

>   * @asic_prop: ASIC specific immutable properties.
>   * @asic_funcs: ASIC specific functions.
>   * @asic_specific: ASIC specific information to use only from ASIC files.
> + * @user_ctx: current user context executing.
> + * @fd_open_cnt: number of open context executing.
>   * @major: habanalabs KMD major.
>   * @id: device minor.
>   * @disabled: is device disabled.
> @@ -214,13 +263,21 @@ struct hl_device {
>  	struct device			*dev;
>  	char				asic_name[16];
>  	enum hl_asic_type		asic_type;
> +	struct hl_ctx			*kernel_ctx;
>  	struct dma_pool			*dma_pool;
>  	void				*cpu_accessible_dma_mem;
>  	dma_addr_t			cpu_accessible_dma_address;
>  	struct gen_pool			*cpu_accessible_dma_pool;
> +	unsigned long			*asid_bitmap;
> +	struct mutex			asid_mutex;
> +	/* TODO: change to rw_sem for multiple contexts (same as other IOCTL) */
> +	struct mutex			device_open;
>  	struct asic_fixed_properties	asic_prop;
>  	const struct hl_asic_funcs	*asic_funcs;
>  	void				*asic_specific;
> +	/* TODO: The following fields should be moved for multi-context */
> +	struct hl_ctx			*user_ctx;
> +	atomic_t			fd_open_cnt;
>  	u32				major;
>  	u16				id;
>  	u8				disabled;
> @@ -270,10 +327,23 @@ int hl_poll_timeout_memory(struct hl_device *hdev, u64 addr, u32 timeout_us,
>  int hl_poll_timeout_device_memory(struct hl_device *hdev, void __iomem *addr,
>  				u32 timeout_us, u32 *val);
>  
> +int hl_asid_init(struct hl_device *hdev);
> +void hl_asid_fini(struct hl_device *hdev);
> +unsigned long hl_asid_alloc(struct hl_device *hdev);
> +void hl_asid_free(struct hl_device *hdev, unsigned long asid);
> +
> +int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv);
> +void hl_ctx_free(struct hl_device *hdev, struct hl_ctx *ctx);
> +int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx);
> +int hl_ctx_put(struct hl_ctx *ctx);
> +void hl_ctx_mgr_init(struct hl_ctx_mgr *mgr);
> +void hl_ctx_mgr_fini(struct hl_device *hdev, struct hl_ctx_mgr *mgr);
>  int hl_device_init(struct hl_device *hdev, struct class *hclass);
>  void hl_device_fini(struct hl_device *hdev);
>  int hl_device_suspend(struct hl_device *hdev);
>  int hl_device_resume(struct hl_device *hdev);
> +void hl_hpriv_get(struct hl_fpriv *hpriv);
> +void hl_hpriv_put(struct hl_fpriv *hpriv);
>  
>  void goya_set_asic_funcs(struct hl_device *hdev);
>  
> diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
> index 79545003b7c2..0646da83eb53 100644
> --- a/drivers/misc/habanalabs/habanalabs_drv.c
> +++ b/drivers/misc/habanalabs/habanalabs_drv.c
> @@ -77,6 +77,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
>  {
>  	struct hl_device *hdev;
>  	struct hl_fpriv *hpriv;
> +	int rc;
>  
>  	mutex_lock(&hl_devs_idr_lock);
>  	hdev = idr_find(&hl_devs_idr, iminor(inode));
> @@ -88,9 +89,33 @@ int hl_device_open(struct inode *inode, struct file *filp)
>  		return -ENXIO;
>  	}
>  
> +	mutex_lock(&hdev->device_open);
> +
> +	if (hdev->disabled) {
> +		dev_err_ratelimited(hdev->dev,
> +			"Can't open %s because it is disabled\n",
> +			dev_name(hdev->dev));
> +		mutex_unlock(&hdev->device_open);
> +		return -EPERM;
> +	}
> +
> +	if (hdev->user_ctx) {
> +		dev_info_ratelimited(hdev->dev,
> +			"Device %s is already attached to application\n",
> +			dev_name(hdev->dev));
> +		mutex_unlock(&hdev->device_open);
> +		return -EBUSY;
> +	}
> +
> +	atomic_inc(&hdev->fd_open_cnt);
> +
> +	mutex_unlock(&hdev->device_open);
> +
>  	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
> -	if (!hpriv)
> -		return -ENOMEM;
> +	if (!hpriv) {
> +		rc = -ENOMEM;
> +		goto close_device;
> +	}
>  
>  	hpriv->hdev = hdev;
>  	filp->private_data = hpriv;
> @@ -98,9 +123,26 @@ int hl_device_open(struct inode *inode, struct file *filp)
>  	kref_init(&hpriv->refcount);
>  	nonseekable_open(inode, filp);
>  
> +	hl_ctx_mgr_init(&hpriv->ctx_mgr);
> +
> +	rc = hl_ctx_create(hdev, hpriv);
> +	if (rc) {
> +		dev_err(hdev->dev, "Failed to open FD (CTX fail)\n");
> +		goto out_err;
> +	}
> +
>  	hpriv->taskpid = find_get_pid(current->pid);
>  
>  	return 0;
> +
> +out_err:
> +	filp->private_data = NULL;
> +	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
> +	kfree(hpriv);
> +
> +close_device:
> +	atomic_dec(&hdev->fd_open_cnt);
> +	return rc;
>  }
>  
>  /**
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

