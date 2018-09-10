Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A771DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE0E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE0E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeIKBVG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:21:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51880 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726121AbeIKBVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:21:06 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8AKEjnD016312;
        Mon, 10 Sep 2018 22:24:48 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2md8d6nmb3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 10 Sep 2018 22:24:48 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8488F31;
        Mon, 10 Sep 2018 20:24:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node3.st.com [10.75.127.21])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C45AFA5C6;
        Mon, 10 Sep 2018 20:24:46 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG7NODE3.st.com
 (10.75.127.21) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 10 Sep
 2018 22:24:46 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Mon, 10 Sep 2018 22:24:46 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Wendy Liang <wendy.liang@xilinx.com>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rajan.vaja@xilinx.com" <rajan.vaja@xilinx.com>,
        "jollys@xilinx.com" <jollys@xilinx.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wendy Liang <jliang@xilinx.com>
Subject: RE: [PATCH 6/7] remoteproc: Add Xilinx ZynqMP R5 remoteproc
Thread-Topic: [PATCH 6/7] remoteproc: Add Xilinx ZynqMP R5 remoteproc
Thread-Index: AQHUNS/P0MO4/AmwIEG9Y6i34m7hB6TqEqbA
Date:   Mon, 10 Sep 2018 20:24:46 +0000
Message-ID: <0c0e49a9b3594799b572e539705f4f4b@SFHDAG7NODE2.st.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
 <1534403190-28523-7-git-send-email-jliang@xilinx.com>
In-Reply-To: <1534403190-28523-7-git-send-email-jliang@xilinx.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-10_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wendy,
Please find below few comments.

> -----Original Message-----
> From: linux-remoteproc-owner@vger.kernel.org <linux-remoteproc-
> owner@vger.kernel.org> On Behalf Of Wendy Liang
> Sent: Thursday, August 16, 2018 9:06 AM
> To: ohad@wizery.com; bjorn.andersson@linaro.org;
> michal.simek@xilinx.com; robh+dt@kernel.org; mark.rutland@arm.com;
> rajan.vaja@xilinx.com; jollys@xilinx.com
> Cc: linux-remoteproc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Wendy Liang <jliang@xilinx.com>
> Subject: [PATCH 6/7] remoteproc: Add Xilinx ZynqMP R5 remoteproc
> 
> There are cortex-r5 processors in Xilinx Zynq UltraScale+
> MPSoC platforms. This remoteproc driver is to manage the
> R5 processors.
> 
> Signed-off-by: Wendy Liang <jliang@xilinx.com>

Jason Wu' signed-off-by missing as he is mentioned as author of this driver?

> ---
>  drivers/remoteproc/Kconfig                |   9 +
>  drivers/remoteproc/Makefile               |   1 +
>  drivers/remoteproc/zynqmp_r5_remoteproc.c | 692
> ++++++++++++++++++++++++++++++
>  3 files changed, 702 insertions(+)
>  create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index cd1c168..83aac63 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -158,6 +158,15 @@ config ST_REMOTEPROC
>  config ST_SLIM_REMOTEPROC
>  	tristate
> 
> +config ZYNQMP_R5_REMOTEPROC
> +	tristate "ZynqMP_r5 remoteproc support"
> +	depends on ARM64 && PM && ARCH_ZYNQMP
> +	select RPMSG_VIRTIO
> +	select ZYNQMP_FIRMWARE
> +	help
> +	  Say y here to support ZynqMP R5 remote processors via the remote
> +	  processor framework.
> +
>  endif # REMOTEPROC
> 
>  endmenu
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 02627ed..147923c 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -23,3 +23,4 @@ qcom_wcnss_pil-y			+=
> qcom_wcnss.o
>  qcom_wcnss_pil-y			+= qcom_wcnss_iris.o
>  obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
>  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
> +obj-$(CONFIG_ZYNQMP_R5_REMOTEPROC)	+= zynqmp_r5_remoteproc.o
> diff --git a/drivers/remoteproc/zynqmp_r5_remoteproc.c
> b/drivers/remoteproc/zynqmp_r5_remoteproc.c
> new file mode 100644
> index 0000000..7fc3718
> --- /dev/null
> +++ b/drivers/remoteproc/zynqmp_r5_remoteproc.c
> @@ -0,0 +1,692 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Zynq R5 Remote Processor driver
> + *
> + * Copyright (C) 2015 Xilinx, Inc.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/remoteproc.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/slab.h>
> +#include <linux/cpu.h>
> +#include <linux/delay.h>
> +#include <linux/list.h>
> +#include <linux/genalloc.h>
> +#include <linux/pfn.h>
> +#include <linux/idr.h>
> +#include <linux/firmware/xlnx-zynqmp.h>

Includes to be classified in alphabetical order

> +
> +#include "remoteproc_internal.h"
> +
> +/* IPI reg offsets */
> +#define TRIG_OFFSET		0x00000000
> +#define OBS_OFFSET		0x00000004
> +#define ISR_OFFSET		0x00000010
> +#define IMR_OFFSET		0x00000014
> +#define IER_OFFSET		0x00000018
> +#define IDR_OFFSET		0x0000001C
> +#define IPI_ALL_MASK		0x0F0F0301
> +
> +/* RPU IPI mask */
> +#define RPU_IPI_INIT_MASK	0x00000100
> +#define RPU_IPI_MASK(n)		(RPU_IPI_INIT_MASK << (n))
> +#define RPU_0_IPI_MASK		RPU_IPI_MASK(0)
> +#define RPU_1_IPI_MASK		RPU_IPI_MASK(1)
> +
> +/* PM proc states */
> +#define PM_PROC_STATE_ACTIVE 1u
> +
> +/* Maximum TCM power nodes IDs */
> +#define MAX_TCM_PNODES 4
> +
> +/* Register access macros */
> +#define reg_read(base, reg) \
> +	readl(((void __iomem *)(base)) + (reg))
> +#define reg_write(base, reg, val) \
> +	writel((val), ((void __iomem *)(base)) + (reg))
> +
> +#define DEFAULT_FIRMWARE_NAME	"rproc-rpu-fw"
> +
> +static bool autoboot __read_mostly;
> +
> +struct zynqmp_r5_rproc_pdata;

This definition is not needed as complete definition just below.
> +
> +/**
> + * struct zynqmp_r5_rproc_pdata - zynqmp rpu remote processor instance
> state
> + * @rproc: rproc handle
> + * @workqueue: workqueue for the RPU remoteproc
> + * @ipi_base: virt ptr to IPI channel address registers for APU
> + * @rpu_mode: RPU core configuration
> + * @rpu_id: RPU CPU id
> + * @rpu_pnode_id: RPU CPU power domain id
> + * @mem_pools: list of gen_pool for firmware mmio_sram memory and
> their
> + *             power domain IDs
> + * @mems: list of rproc_mem_entries for firmware
> + * @irq: IRQ number
> + * @ipi_dest_mask: IPI destination mask for the IPI channel
> + */
> +struct zynqmp_r5_rproc_pdata {
> +	struct rproc *rproc;
> +	struct work_struct workqueue;
> +	void __iomem *ipi_base;
> +	enum rpu_oper_mode rpu_mode;
> +	struct list_head mems;
> +	u32 ipi_dest_mask;
> +	u32 rpu_id;
> +	u32 rpu_pnode_id;
> +	int irq;
> +	u32 tcm_pnode_id[MAX_TCM_PNODES];
> +};
> +
> +/**
> + * r5_boot_addr_config - configure the boot address of R5
> + * @pdata: platform data
> + * @bootmem: boot from LOVEC or HIVEC
> + *
> + * This function will set the RPU boot address
> + */
> +static void r5_boot_addr_config(struct zynqmp_r5_rproc_pdata *pdata,
> +				enum rpu_boot_mem bootmem)
> +{
> +	const struct zynqmp_eemi_ops *eemi =
> zynqmp_pm_get_eemi_ops();
> +
> +	pr_debug("%s: R5 ID: %d, boot_dev %d\n",
> +		 __func__, pdata->rpu_id, bootmem);
> +
> +	if (!eemi || !eemi->ioctl) {
> +		pr_err("%s: no eemi ioctl operation.\n", __func__);
> +		return;
> +	}
> +	eemi->ioctl(pdata->rpu_pnode_id,
> IOCTL_RPU_BOOT_ADDR_CONFIG,
> +		    bootmem, 0, NULL);
> +}
> +
> +/**
> + * r5_mode_config - configure R5 operation mode
> + * @pdata: platform data
> + *
> + * configure R5 to split mode or lockstep mode
> + * based on the platform data.
> + */
> +static void r5_mode_config(struct zynqmp_r5_rproc_pdata *pdata)
> +{
> +	const struct zynqmp_eemi_ops *eemi =
> zynqmp_pm_get_eemi_ops();
> +
> +	pr_debug("%s: mode: %d\n", __func__, pdata->rpu_mode);
> +
> +	if (!eemi || !eemi->ioctl) {
> +		pr_err("%s: no eemi ioctl operation.\n", __func__);
> +		return;
> +	}
> +	eemi->ioctl(pdata->rpu_pnode_id, IOCTL_SET_RPU_OPER_MODE,
> +		    pdata->rpu_mode, 0, NULL);
> +}
> +
> +/**
> + * r5_release_tcm() - release TCM
> + * @pdata: platform data
> + *
> + * Release TCM
> + */
> +static void r5_release_tcm(struct zynqmp_r5_rproc_pdata *pdata)
> +{
> +	const struct zynqmp_eemi_ops *eemi =
> zynqmp_pm_get_eemi_ops();
> +	int i;
> +
> +	if (!eemi || !eemi->release_node) {
> +		pr_err("Failed to release TCM\n");
> +		return;
> +	}
> +
> +	for (i = 0; i < MAX_TCM_PNODES; i++) {
> +		if (pdata->tcm_pnode_id[i] != 0)
> +			eemi->release_node(pdata->tcm_pnode_id[i]);
> +	}
> +}
> +
> +/**
> + * disable_ipi - disable IPI
> + * @pdata: platform data
> + *
> + * Disable IPI interrupt
> + */
> +static inline void disable_ipi(struct zynqmp_r5_rproc_pdata *pdata)
> +{
> +	/* Disable R5 IPI interrupt */
> +	if (pdata->ipi_base)
> +		reg_write(pdata->ipi_base, IDR_OFFSET, pdata-
> >ipi_dest_mask);
> +}

All IPI functions should go below mailbox framework as you use it as a doorbell.

> +
> +/**
> + * enable_ipi - enable IPI
> + * @pdata: platform data
> + *
> + * Enable IPI interrupt
> + */
> +static inline void enable_ipi(struct zynqmp_r5_rproc_pdata *pdata)
> +{
> +	/* Enable R5 IPI interrupt */
> +	if (pdata->ipi_base)
> +		reg_write(pdata->ipi_base, IER_OFFSET, pdata-
> >ipi_dest_mask);
> +}
> +
> +/**
> + * event_notified_idr_cb - event notified idr callback
> + * @id: idr id
> + * @ptr: pointer to idr private data
> + * @data: data passed to idr_for_each callback
> + *
> + * Pass notification to remoteproc virtio
> + *
> + * @return: 0. having return is to satisfy the idr_for_each() function
> + *          pointer input argument requirement.
> + */
> +static int event_notified_idr_cb(int id, void *ptr, void *data)
> +{
> +	struct rproc *rproc = data;
> +
> +	(void)rproc_vq_interrupt(rproc, id);
> +	return 0;
> +}
> +
> +static void handle_event_notified(struct work_struct *work)
> +{
> +	struct rproc *rproc;
> +	struct zynqmp_r5_rproc_pdata *local;
> +
> +	local = container_of(work, struct zynqmp_r5_rproc_pdata,
> workqueue);
> +	rproc = local->rproc;
> +	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
> +}
> +
> +static int zynqmp_r5_rproc_start(struct rproc *rproc)
> +{
> +	struct device *dev = rproc->dev.parent;
> +	struct zynqmp_r5_rproc_pdata *local = rproc->priv;
> +	enum rpu_boot_mem bootmem;
> +	const struct zynqmp_eemi_ops *eemi =
> zynqmp_pm_get_eemi_ops();
> +
> +	dev_dbg(dev, "%s\n", __func__);
> +
> +	if (!eemi || !eemi->force_powerdown ||
> +	    !eemi->request_wakeup) {
> +		pr_err("Failed to start R5\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Set up R5 */
> +	if ((rproc->bootaddr & 0xF0000000) == 0xF0000000)
> +		bootmem = PM_RPU_BOOTMEM_HIVEC;
> +	else
> +		bootmem = PM_RPU_BOOTMEM_LOVEC;
> +	dev_info(dev, "RPU boot from %s.",
> +		 bootmem == PM_RPU_BOOTMEM_HIVEC ? "OCM" :
> "TCM");
> +
> +	r5_mode_config(local);
> +	eemi->force_powerdown(local->rpu_pnode_id,
> +			      ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +	r5_boot_addr_config(local, bootmem);

Add some blank line to ease code reading. Some parts of the code are too compacted.

> +	/* Add delay before release from halt and reset */
> +	usleep_range(400, 500);
> +	eemi->request_wakeup(local->rpu_pnode_id,
> +			     1, bootmem,
> +			     ZYNQMP_PM_REQUEST_ACK_NO);
> +
> +	/* Make sure IPI is enabled */
> +	enable_ipi(local);
> +
> +	return 0;
> +}
> +
> +/* kick a firmware */
> +static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
> +{
> +	struct device *dev = rproc->dev.parent;
> +	struct zynqmp_r5_rproc_pdata *local = rproc->priv;
> +
> +	dev_dbg(dev, "KICK Firmware to start send messages vqid %d\n",
> vqid);
> +
> +	/*
> +	 * send irq to R5 firmware
> +	 * Currently vqid is not used because we only got one.
> +	 */
> +	if (local->ipi_base)
> +		reg_write(local->ipi_base, TRIG_OFFSET, local-
> >ipi_dest_mask);
> +}
> +
> +/* power off the remote processor */
> +static int zynqmp_r5_rproc_stop(struct rproc *rproc)
> +{
> +	struct device *dev = rproc->dev.parent;
> +	struct zynqmp_r5_rproc_pdata *local = rproc->priv;
> +	struct rproc_mem_entry *mem, *nmem;
> +	const struct zynqmp_eemi_ops *eemi =
> zynqmp_pm_get_eemi_ops();

Is it pointer on secure interface to control coprocessor?
As it is used in most of functions, maybe ops could be recovered and checked only once at probe time?

> +
> +	dev_dbg(dev, "%s\n", __func__);
> +
> +	if (!eemi || !eemi->force_powerdown) {
> +		pr_err("Failed to stop R5\n");
> +		return -ENXIO;
> +	}
> +
> +	disable_ipi(local);
> +	eemi->force_powerdown(local->rpu_pnode_id,
> +			      ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +
> +	return 0;
> +}
> +
> +static void *zynqmp_r5_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
> +{
> +	struct rproc_mem_entry *mem;
> +	void *va = NULL;
> +	struct zynqmp_r5_rproc_pdata *local = rproc->priv;
> +
> +	list_for_each_entry(mem, &local->mems, node) {
> +		int offset = da - mem->da;
> +
> +		/* try next carveout if da is too small */
> +		if (offset < 0)
> +			continue;
> +
> +		/* try next carveout if da is too large */
> +		if (offset + len > mem->len)
> +			continue;
> +
> +		va = mem->va + offset;
> +
> +		break;
> +	}
> +	return va;
> +}
> +
> +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware
> *fw)
> +{
> +	int ret;
> +
> +	ret = rproc_elf_load_rsc_table(rproc, fw);
> +	if (ret == -EINVAL)
> +		/* No resource table */
> +		return 0;
> +	else
> +		return ret;
> +}
> +
> +static struct rproc_ops zynqmp_r5_rproc_ops = {
> +	.start		= zynqmp_r5_rproc_start,
> +	.stop		= zynqmp_r5_rproc_stop,
> +	.kick		= zynqmp_r5_rproc_kick,
> +	.da_to_va       = zynqmp_r5_rproc_da_to_va,
> +};
> +
> +/* Release R5 from reset and make it halted.
> + * In case the firmware uses TCM, in order to load firmware to TCM,
> + * will need to release R5 from reset and stay in halted state.
> + */
> +static int zynqmp_r5_rproc_init(struct rproc *rproc)
> +{
> +	struct device *dev = rproc->dev.parent;
> +	struct zynqmp_r5_rproc_pdata *local = rproc->priv;
> +
> +	dev_dbg(dev, "%s\n", __func__);
> +	enable_ipi(local);
> +	return 0;
> +}

Comment not aligned with function content. Only IPI enable here.
> +
> +static irqreturn_t r5_remoteproc_interrupt(int irq, void *dev_id)
> +{
> +	struct device *dev = dev_id;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct rproc *rproc = platform_get_drvdata(pdev);
> +	struct zynqmp_r5_rproc_pdata *local = rproc->priv;
> +	u32 ipi_reg;
> +
> +	/* Check if there is a kick from R5 */
> +	ipi_reg = reg_read(local->ipi_base, ISR_OFFSET);
> +	if (!(ipi_reg & local->ipi_dest_mask))
> +		return IRQ_NONE;
> +
> +	dev_dbg(dev, "KICK Linux because of pending message(irq%d)\n",
> irq);
> +	reg_write(local->ipi_base, ISR_OFFSET, local->ipi_dest_mask);
> +	schedule_work(&local->workqueue);
> +
> +	return IRQ_HANDLED;
> +}

Should be part of IPI mailbox driver.

> +
> +/* zynqmp_r5_get_tcm_memories() - get tcm memories
> + * @pdev: pointer to the platform device
> + * @pdata: pointer to the remoteproc private data
> + *
> + * Function to create remoteproc memory entries for TCM memories.
> + */
> +static int zynqmp_r5_get_tcms(struct platform_device *pdev,
> +			      struct zynqmp_r5_rproc_pdata *pdata)
> +{
> +	static const char * const mem_names[] = {"tcm_a", "tcm_b"};
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	int num_mems = 0;
> +	int i, ret;
> +	struct property *prop;
> +	const __be32 *cur;
> +	u32 val;
> +	const struct zynqmp_eemi_ops *eemi =
> zynqmp_pm_get_eemi_ops();
> +
> +	/* Get TCM power node ids */
> +	i = 0;
> +	of_property_for_each_u32(np, "tcm-pnode-id", prop, cur, val)
> +		pdata->tcm_pnode_id[i++] = val;
> +
> +	/* Request TCMs */
> +	for (i = 0; i < MAX_TCM_PNODES; i++) {
> +		if (pdata->tcm_pnode_id[i] != 0) {
> +			ret = eemi->request_node(pdata->tcm_pnode_id[i],
> +
> ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> +
> ZYNQMP_PM_REQUEST_ACK_BLOCKING
> +						);
> +			if (ret < 0) {
> +				dev_err(dev, "failed to request TCM: %u\n",
> +					pdata->tcm_pnode_id[i]);
> +				return ret;
> +			}
> +			dev_dbg(dev, "request tcm pnode: %u\n",
> +				pdata->tcm_pnode_id[i]);
> +		} else {
> +			break;
> +		}
> +	}
> +	/* Create remoteproc memories entries for TCM memories */
> +	num_mems = ARRAY_SIZE(mem_names);
> +	for (i = 0; i < num_mems; i++) {
> +		struct resource *res;
> +		struct rproc_mem_entry *mem;
> +		dma_addr_t dma;
> +		resource_size_t size;
> +
> +		res = platform_get_resource_byname(pdev,
> IORESOURCE_MEM,
> +						   mem_names[i]);
> +		mem  = devm_kzalloc(dev, sizeof(struct rproc_mem_entry),
> +				    GFP_KERNEL);
> +		if (!mem)
> +			return -ENOMEM;
> +		/* Map it as normal memory */
> +		size = resource_size(res);
> +		mem->va = devm_ioremap_wc(dev, res->start, size);
> +		mem->len = size;
> +		dma = (dma_addr_t)res->start;
> +		mem->dma = dma;
> +		/* TCM memory:
> +		 *   TCM_0: da 0 <-> global addr 0xFFE00000
> +		 *   TCM_1: da 0 <-> global addr 0xFFE90000
> +		 */
> +		if ((dma & 0xFFF00000) == 0xFFE00000) {
> +			if ((dma & 0xFFF80000) == 0xFFE80000)
> +				mem->da -= 0x90000;
> +			else
> +				mem->da = (dma & 0x000FFFFF);
> +		}
> +		dev_dbg(dev, "%s: va = %p, da = 0x%x dma = 0x%llx\n",
> +			__func__, mem->va, mem->da, mem->dma);
> +		list_add_tail(&mem->node, &pdata->mems);

Looks like carevout patch series [1]. Did you try it? I think it is better to communalize code instead of duplicated it in each platform driver.
[1] https://lkml.org/lkml/2018/7/27/612

> +	}
> +	return 0;
> +}
> +
> +/* zynqmp_r5_get_reserved_mems() - get reserved memories
> + * @pdev: pointer to the platform device
> + * @pdata: pointer to the remoteproc private data
> + *
> + * Function to create remoteproc memory entries from memory-region
> + * property.
> + */
> +static int zynqmp_r5_get_reserved_mems(struct platform_device *pdev,
> +				       struct zynqmp_r5_rproc_pdata *pdata)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	int num_mems;
> +	int i;
> +
> +	num_mems = of_count_phandle_with_args(np, "memory-region",
> NULL);
> +	if (num_mems <= 0)
> +		return 0;
> +	for (i = 0; i < num_mems; i++) {
> +		struct device_node *node;
> +		struct resource res;
> +		resource_size_t size;
> +		struct rproc_mem_entry *mem;
> +		int ret;
> +
> +		node = of_parse_phandle(np, "memory-region", i);
> +		ret = of_device_is_compatible(node, "rproc-prog-memory");
> +		if (!ret) {
> +			/* it is DMA memory. */
> +			dev_info(dev, "%s, dma memory %d\n", __func__,
> i);
> +			ret = of_reserved_mem_device_init_by_idx(dev,
> +								 np, i);
> +			if (ret) {
> +				dev_err(dev, "unable to reserve DMA
> mem.\n");
> +				return ret;
> +			}
> +			continue;
> +		}
> +		ret = of_address_to_resource(node, 0, &res);
> +		if (ret) {
> +			dev_err(dev, "unable to resolve memory region.\n");
> +			return ret;
> +		}
> +		mem  = devm_kzalloc(dev, sizeof(struct rproc_mem_entry),
> +				    GFP_KERNEL);
> +		if (!mem)
> +			return -ENOMEM;
> +		/* Map it as normal memory */
> +		size = resource_size(&res);
> +		mem->va = devm_ioremap_wc(dev, res.start, size);
> +		mem->len = size;
> +		mem->dma = (dma_addr_t)res.start;
> +		mem->da = (u32)res.start;
> +		dev_dbg(dev, "%s: va = %p, da = 0x%x dma = 0x%llx\n",
> +			__func__, mem->va, mem->da, mem->dma);
> +		list_add_tail(&mem->node, &pdata->mems);
> +	}
> +	return 0;
> +}
> +
> +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
> +{
> +	const unsigned char *prop;
> +	struct resource *res;
> +	int ret = 0;
> +	struct zynqmp_r5_rproc_pdata *local;
> +	struct rproc *rproc;
> +
> +	rproc = rproc_alloc(&pdev->dev, dev_name(&pdev->dev),
> +			    &zynqmp_r5_rproc_ops, NULL,
> +		sizeof(struct zynqmp_r5_rproc_pdata));
> +	if (!rproc) {
> +		dev_err(&pdev->dev, "rproc allocation failed\n");
> +		return -ENOMEM;
> +	}
> +	local = rproc->priv;
> +	local->rproc = rproc;
> +
> +	platform_set_drvdata(pdev, rproc);
> +
> +	/* Override parse_fw op to allow no resource table firmware */
> +	rproc->ops->parse_fw = zynqmp_r5_parse_fw;
> +
> +	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(&pdev->dev, "dma_set_coherent_mask: %d\n",
> ret);
> +		goto rproc_fault;
> +	}
> +
> +	/* Get the RPU power domain id */
> +	ret = of_property_read_u32(pdev->dev.of_node, "rpu-pnode-id",
> +				   &local->rpu_pnode_id);
> +	if (ret) {
> +		dev_err(&pdev->dev, "No RPU power node ID is
> specified.\n");
> +		ret = -EINVAL;
> +		goto rproc_fault;
> +	}
> +	dev_dbg(&pdev->dev, "RPU[%d] pnode_id = %d.\n",
> +		local->rpu_id, local->rpu_pnode_id);
> +
> +	prop = of_get_property(pdev->dev.of_node, "core_conf", NULL);
> +	if (!prop) {
> +		dev_warn(&pdev->dev, "default core_conf used: lock-
> step\n");
> +		prop = "lock-step";
> +	}
> +
> +	dev_info(&pdev->dev, "RPU core_conf: %s\n", prop);
> +	if (!strcmp(prop, "split0")) {
> +		local->rpu_mode = PM_RPU_MODE_SPLIT;
> +		local->rpu_id = 0;
> +		local->ipi_dest_mask = RPU_0_IPI_MASK;
> +	} else if (!strcmp(prop, "split1")) {
> +		local->rpu_mode = PM_RPU_MODE_SPLIT;
> +		local->rpu_id = 1;
> +		local->ipi_dest_mask = RPU_1_IPI_MASK;
> +	} else if (!strcmp(prop, "lock-step")) {
> +		local->rpu_mode = PM_RPU_MODE_LOCKSTEP;
> +		local->rpu_id = 0;
> +		local->ipi_dest_mask = RPU_0_IPI_MASK;
> +	} else {
> +		dev_err(&pdev->dev, "Invalid core_conf mode provided - %s
> , %d\n",
> +			prop, local->rpu_mode);
> +		ret = -EINVAL;
> +		goto rproc_fault;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "ipi");
> +	if (res) {
> +		local->ipi_base = devm_ioremap(&pdev->dev, res->start,
> +					       resource_size(res));
> +		if (IS_ERR(local->ipi_base)) {
> +			pr_err("%s: Unable to map IPI\n", __func__);
> +			ret = PTR_ERR(local->ipi_base);
> +			goto rproc_fault;
> +		}
> +	} else {
> +		dev_info(&pdev->dev, "IPI resource is not specified.\n");
> +	}
> +	dev_dbg(&pdev->dev, "got ipi base address\n");
> +
> +	INIT_LIST_HEAD(&local->mems);
> +	/* Get TCM memories */
> +	ret = zynqmp_r5_get_tcms(pdev, local);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to get TCM memories.\n");
> +		goto rproc_fault;
> +	}
> +	dev_dbg(&pdev->dev, "got TCM memories\n");
> +	/* Get reserved memory regions for firmware */
> +	ret = zynqmp_r5_get_reserved_mems(pdev, local);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to get reserved memories.\n");
> +		goto rproc_fault;
> +	}
> +	dev_dbg(&pdev->dev, "got reserved memories.\n");
> +
> +	/* Disable IPI before requesting IPI IRQ */
> +	disable_ipi(local);
> +	INIT_WORK(&local->workqueue, handle_event_notified);
> +
> +	/* IPI IRQ */
> +	if (local->ipi_base) {
> +		ret = platform_get_irq(pdev, 0);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "unable to find IPI IRQ\n");
> +			goto rproc_fault;
> +		}
> +		local->irq = ret;
> +		ret = devm_request_irq(&pdev->dev, local->irq,
> +				       r5_remoteproc_interrupt, IRQF_SHARED,
> +				       dev_name(&pdev->dev), &pdev->dev);
> +		if (ret) {
> +			dev_err(&pdev->dev, "IRQ %d already allocated\n",
> +				local->irq);
> +			goto rproc_fault;
> +		}
> +		dev_dbg(&pdev->dev, "notification irq: %d\n", local->irq);
> +	}
> +
> +	ret = zynqmp_r5_rproc_init(local->rproc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to init ZynqMP R5 rproc\n");
> +		goto rproc_fault;
> +	}
> +
> +	rproc->auto_boot = autoboot;
> +
> +	ret = rproc_add(local->rproc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "rproc registration failed\n");
> +		goto rproc_fault;
> +	}
> +
> +	return ret;
> +
> +rproc_fault:
> +	rproc_free(local->rproc);
> +
> +	return ret;
> +}
> +
> +static int zynqmp_r5_remoteproc_remove(struct platform_device *pdev)
> +{
> +	struct rproc *rproc = platform_get_drvdata(pdev);
> +	struct zynqmp_r5_rproc_pdata *local = rproc->priv;
> +	struct rproc_mem_entry *mem;
> +
> +	dev_info(&pdev->dev, "%s\n", __func__);
> +
> +	rproc_del(rproc);
> +
> +	list_for_each_entry(mem, &local->mems, node) {
> +		if (mem->priv)
> +			gen_pool_free((struct gen_pool *)mem->priv,
> +				      (unsigned long)mem->va, mem->len);
> +	}
> +
> +	r5_release_tcm(local);
> +	of_reserved_mem_device_release(&pdev->dev);
> +	rproc_free(rproc);
> +
> +	return 0;
> +}
> +
> +/* Match table for OF platform binding */
> +static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
> +	{ .compatible = "xlnx,zynqmp-r5-remoteproc-1.0", },
> +	{ /* end of list */ },
> +};
> +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> +
> +static struct platform_driver zynqmp_r5_remoteproc_driver = {
> +	.probe = zynqmp_r5_remoteproc_probe,
> +	.remove = zynqmp_r5_remoteproc_remove,
> +	.driver = {
> +		.name = "zynqmp_r5_remoteproc",
> +		.of_match_table = zynqmp_r5_remoteproc_match,
> +	},
> +};
> +module_platform_driver(zynqmp_r5_remoteproc_driver);
> +
> +module_param_named(autoboot,  autoboot, bool, 0444);
> +MODULE_PARM_DESC(autoboot,
> +		 "enable | disable autoboot. (default: true)");
> +
> +MODULE_AUTHOR("Jason Wu <j.wu@xilinx.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ZynqMP R5 remote processor control driver");
> --
> 2.7.4

