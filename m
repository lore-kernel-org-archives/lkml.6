Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A23C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7612084A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vp3RDELG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfBBBDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:03:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44534 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfBBBDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:03:49 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so4050056pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 17:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aJvwOyMBO3m5OzV+lQgu/XoEgkNx/21w2GUI8nuQi/c=;
        b=Vp3RDELG4WHN5dObISu28AAAIhIc4tkRZYi/oz2dOz8zkYLJ8XFNiuuiAWMNovgH7H
         /TIqI/sztVLXmMAiowKC8IUY+F8AOI6EdCJzQ0cnNJc2fdTzGzx8Dyq83U2ys2NRTodG
         9I0j9O06WMsdTXPGUHyulf1Ik1l3/cj2KAAaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aJvwOyMBO3m5OzV+lQgu/XoEgkNx/21w2GUI8nuQi/c=;
        b=YCfgGqE6mDvQDtwA7EGKAwPnHRx5NVtyVgxUR6ncTeVoVvbhuthVf8gcRZpPiKcZQf
         /bO8cnFM6nTZucefKZomCEi4KbYgSW5NN1QfjNUbuY0W7jKjHUnFJwTfCkCYX3nE7k5R
         2YXKO/OY32aNiAQbkOGcvBcLTdG03QIjb0dw0zDv6vKtZbC4dW83R4ONiOoIzfl/38BL
         cu1cBVlzMQgJm/NtwIRX1YwxGOxqF3g93Hu+P7MFSzQcuwcRg6tWm9wbhBAcP9llih/2
         3K+lcdOFOuIuVoggU5VVMnCL1B2fEKzI3RiA6U4FR8eyCeyxFSxHDnJseZcVwouhFmFR
         Tenw==
X-Gm-Message-State: AJcUukddwfUSumwwLNX/sWGyLGuf86ogHef+judC7olkxz//zZnkSwxy
        rXSHPawVRU/4rGRQZvwqymjQTQ==
X-Google-Smtp-Source: ALg8bN7KKM35n4VspvZoJVCyJdgdf7H6tuZxR6CtF3e7kwc3Fv3MNHETP9C6270IWR6pbozfnJP88Q==
X-Received: by 2002:a62:a1a:: with SMTP id s26mr42066578pfi.31.1549069427775;
        Fri, 01 Feb 2019 17:03:47 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d21sm10130248pgv.37.2019.02.01.17.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 17:03:46 -0800 (PST)
Date:   Fri, 1 Feb 2019 17:03:46 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Erin Lo <erin.lo@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v4 2/6] remoteproc/mediatek: add SCP support for mt8183
Message-ID: <20190202010346.GA117604@google.com>
References: <20190131093131.245531-1-pihsun@chromium.org>
 <20190131093131.245531-3-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190131093131.245531-3-pihsun@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pi-Hsun Shih,

[excuses if you receive this mail twice, mutt garbled up the headers
and it didn't make it to all recipients/lists]

a few comments inline.

It's the first time I dabble into remoteproc, I don't claim to have a
complete understanding of the driver at this point ;-)

On Thu, Jan 31, 2019 at 05:31:27PM +0800, Pi-Hsun Shih wrote:
> From: Erin Lo <erin.lo@mediatek.com>
> 
> Provide a basic driver to control Cortex M4 co-processor
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> Changes from v3:
>  - Fix some issue found by checkpatch.
>  - Make writes aligned in scp_ipi_send.
> 
> Changes from v2:
>  - Squash patch 3 from v2 (separate the ipi interface) into this patch.
>  - Remove unused name argument from scp_ipi_register.
>  - Add scp_ipi_unregister for proper cleanup.
>  - Move IPI ids in sync with firmware.
>  - Add mb() in proper place, and correctly clear the run->signaled.
> 
> Changes from v1:
>  - Extract functions and rename variables in mtk_scp.c.
> ---
>  drivers/remoteproc/Kconfig            |   9 +
>  drivers/remoteproc/Makefile           |   1 +
>  drivers/remoteproc/mtk_common.h       |  73 +++++
>  drivers/remoteproc/mtk_scp.c          | 441 ++++++++++++++++++++++++++
>  drivers/remoteproc/mtk_scp_ipi.c      | 157 +++++++++
>  include/linux/platform_data/mtk_scp.h | 135 ++++++++
>  6 files changed, 816 insertions(+)
>  create mode 100644 drivers/remoteproc/mtk_common.h
>  create mode 100644 drivers/remoteproc/mtk_scp.c
>  create mode 100644 drivers/remoteproc/mtk_scp_ipi.c
>  create mode 100644 include/linux/platform_data/mtk_scp.h
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index f0abd260804473..ee0bda23768938 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -22,6 +22,15 @@ config IMX_REMOTEPROC
>  
>  	  It's safe to say N here.
>  
> +config MTK_SCP
> +        tristate "Mediatek SCP support"
> +        depends on ARCH_MEDIATEK
> +        help
> +          Say y here to support Mediatek's SCP (Cortex M4
> +          on MT8183) via the remote processor framework.

It would be good to spell out SCP somewhere, e.g.

"... support Mediatek's system companion processor (SCP) via ..."

the example is less important IMO, though it's prefectly fine if you
can still squeeze it in ;-)

> +
> +          It's safe to say N here.
> +
>  config OMAP_REMOTEPROC
>  	tristate "OMAP remoteproc support"
>  	depends on ARCH_OMAP4 || SOC_OMAP5
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index ce5d061e92be52..16b3e5e7a81c8e 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -10,6 +10,7 @@ remoteproc-y				+= remoteproc_sysfs.o
>  remoteproc-y				+= remoteproc_virtio.o
>  remoteproc-y				+= remoteproc_elf_loader.o
>  obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
> +obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
>  obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>  obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
>  obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> new file mode 100644
> index 00000000000000..162798c44ad7f1
> --- /dev/null
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + */
> +
> +#ifndef __RPROC_MTK_COMMON_H
> +#define __RPROC_MTK_COMMON_H
> +
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +
> +#define MT8183_SW_RSTN			0x0
> +#define MT8183_SW_RSTN_BIT		BIT(0)
> +#define MT8183_SCP_TO_HOST		0x1C
> +#define MT8183_SCP_IPC_INT_BIT		BIT(0)
> +#define MT8183_SCP_WDT_INT_BIT		BIT(8)
> +#define MT8183_HOST_TO_SCP		0x28
> +#define MT8183_HOST_IPC_INT_BIT		BIT(0)
> +#define MT8183_SCP_SRAM_PDN		0x402C
> +
> +#define SCP_FW_VER_LEN		32
> +
> +struct scp_run {
> +	u32 signaled;
> +	s8 fw_ver[SCP_FW_VER_LEN];
> +	u32 dec_capability;
> +	u32 enc_capability;
> +	wait_queue_head_t wq;
> +};
> +
> +struct scp_ipi_desc {
> +	scp_ipi_handler_t handler;
> +	void *priv;
> +};
> +
> +struct mtk_scp {
> +	struct device *dev;
> +	struct rproc *rproc;
> +	struct clk *clk;
> +	void __iomem *reg_base;
> +	void __iomem *sram_base;
> +	size_t sram_size;
> +
> +	struct share_obj *recv_buf;
> +	struct share_obj *send_buf;
> +	struct scp_run run;
> +	struct mutex scp_mutex; /* for protecting mtk_scp data structure */

nit: the scp_ prefix in the name is a bit redundant, maybe just call
it 'lock'?

> +	struct scp_ipi_desc ipi_desc[SCP_IPI_MAX];
> +	bool ipi_id_ack[SCP_IPI_MAX];
> +	wait_queue_head_t ack_wq;
> +
> +	void __iomem *cpu_addr;
> +	phys_addr_t phys_addr;
> +	size_t dram_size;
> +};
> +
> +/**
> + * struct share_obj - SRAM buffer shared with
> + *		      AP and SCP
> + *
> + * @id:		IPI id
> + * @len:	share buffer length
> + * @share_buf:	share buffer data
> + */
> +struct share_obj {
> +	s32 id;
> +	u32 len;
> +	u8 share_buf[288];
> +};
> +
> +#endif
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> new file mode 100644
> index 00000000000000..920c81c3525c2a
> --- /dev/null
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -0,0 +1,441 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2018 MediaTek Inc.
> +
> +#include <asm/barrier.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_data/mtk_scp.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +
> +#include "mtk_common.h"
> +#include "remoteproc_internal.h"
> +
> +#define MAX_CODE_SIZE 0x500000
> +
> +struct platform_device *scp_get_plat_device(struct platform_device *pdev)

nit: _get_pdev()?

plat_device is a custom abbreviation, pdev is commonly understood.

> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *scp_node;
> +	struct platform_device *scp_pdev;
> +
> +	scp_node = of_parse_phandle(dev->of_node, "mediatek,scp", 0);
> +	if (!scp_node) {
> +		dev_err(dev, "can't get scp node\n");
> +		return NULL;
> +	}
> +
> +	scp_pdev = of_find_device_by_node(scp_node);
> +	if (WARN_ON(!scp_pdev)) {
> +		dev_err(dev, "scp pdev failed\n");

nit: use uppercase for acronyms (SCP, IPI, ...) in messages and comments?

> +		of_node_put(scp_node);
> +		return NULL;
> +	}
> +
> +	return scp_pdev;
> +}
> +EXPORT_SYMBOL_GPL(scp_get_plat_device);
> +
> +static void scp_wdt_handler(struct mtk_scp *scp)
> +{
> +	rproc_report_crash(scp->rproc, RPROC_WATCHDOG);
> +}
> +
> +static void scp_init_ipi_handler(void *data, unsigned int len, void *priv)
> +{
> +	struct mtk_scp *scp = (struct mtk_scp *)priv;
> +	struct scp_run *run = (struct scp_run *)data;
> +
> +	scp->run.signaled = run->signaled;
> +	strncpy(scp->run.fw_ver, run->fw_ver, SCP_FW_VER_LEN);
> +	scp->run.dec_capability = run->dec_capability;
> +	scp->run.enc_capability = run->enc_capability;
> +	wake_up_interruptible(&scp->run.wq);
> +}
> +
> +static void scp_ipi_handler(struct mtk_scp *scp)
> +{
> +	struct share_obj *rcv_obj = scp->recv_buf;
> +	struct scp_ipi_desc *ipi_desc = scp->ipi_desc;
> +	u8 tmp_data[288];
> +
> +	if (rcv_obj->id < SCP_IPI_MAX && ipi_desc[rcv_obj->id].handler) {
> +		memcpy_fromio(tmp_data, &rcv_obj->share_buf, rcv_obj->len);
> +		ipi_desc[rcv_obj->id].handler(&tmp_data[0],
> +					      rcv_obj->len,
> +					      ipi_desc[rcv_obj->id].priv);
> +		scp->ipi_id_ack[rcv_obj->id] = true;
> +		wake_up(&scp->ack_wq);
> +	} else {
> +		dev_err(scp->dev, "No such ipi id = %d\n", rcv_obj->id);
> +	}

You could consider to change this to:

        if (rcv_obj->id >= SCP_IPI_MAX || !ipi_desc[rcv_obj->id].handler) {
                dev_err(scp->dev, "No such ipi id = %d\n", rcv_obj->id);
                return;
        }

        memcpy_fromio(tmp_data, &rcv_obj->share_buf, rcv_obj->len);
        ...

Feel free to leave as is if you prefer.

> +}
> +
> +static int scp_ipi_init(struct mtk_scp *scp)
> +{
> +	size_t send_offset = 0x800 - sizeof(struct share_obj);

should there be a define for 0x800?

> +	size_t recv_offset = send_offset - sizeof(struct share_obj);
> +
> +	/* Disable SCP to host interrupt */
> +	writel(MT8183_SCP_IPC_INT_BIT, scp->reg_base + MT8183_SCP_TO_HOST);
> +
> +	/* shared buffer initialization */
> +	scp->recv_buf = (__force struct share_obj *)(scp->sram_base +
> +						recv_offset);
> +	scp->send_buf = (__force struct share_obj *)(scp->sram_base +
> +						send_offset);
> +	memset_io(scp->recv_buf, 0, sizeof(scp->recv_buf));
> +	memset_io(scp->send_buf, 0, sizeof(scp->send_buf));
> +
> +	return 0;
> +}
> +
> +static void mtk_scp_reset_assert(const struct mtk_scp *scp)
> +{
> +	u32 val;
> +
> +	val = readl(scp->reg_base + MT8183_SW_RSTN);
> +	val &= ~MT8183_SW_RSTN_BIT;
> +	writel(val, scp->reg_base + MT8183_SW_RSTN);
> +}
> +
> +static void mtk_scp_reset_deassert(const struct mtk_scp *scp)
> +{
> +	u32 val;
> +
> +	val = readl(scp->reg_base + MT8183_SW_RSTN);
> +	val |= MT8183_SW_RSTN_BIT;
> +	writel(val, scp->reg_base + MT8183_SW_RSTN);
> +}
> +
> +static irqreturn_t scp_irq_handler(int irq, void *priv)

nit: some function use the prefix 'scp_' others 'mtk_scp_', I couldn't
identify a clear pattern. Should we just stick to a single prefix? I
don't have a strong opinion on which, 'scp_' should be good for static
functions, you might want to add 'mtk_' to global ones to avoid
possible clashes in the future.

> +{
> +	struct mtk_scp *scp = priv;
> +	u32 scp_to_host;
> +
> +	scp_to_host = readl(scp->reg_base + MT8183_SCP_TO_HOST);
> +	if (scp_to_host & MT8183_SCP_IPC_INT_BIT) {
> +		scp_ipi_handler(scp);
> +	} else {
> +		dev_err(scp->dev, "scp watchdog timeout! 0x%x", scp_to_host);
> +		scp_wdt_handler(scp);
> +	}
> +
> +	/*
> +	 * Ensure that all write to SRAM are committed before another

s/write/writes/

> +	 * interrupt.
> +	 */
> +	mb();
> +	/* SCP won't send another interrupt until we set SCP_TO_HOST to 0. */
> +	writel(MT8183_SCP_IPC_INT_BIT | MT8183_SCP_WDT_INT_BIT,
> +	       scp->reg_base + MT8183_SCP_TO_HOST);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mtk_scp_load(struct rproc *rproc, const struct firmware *fw)
> +{
> +	const struct mtk_scp *scp = rproc->priv;
> +	struct device *dev = scp->dev;
> +	int ret;
> +
> +	/* Hold SCP in reset while loading FW. */
> +	mtk_scp_reset_assert(scp);
> +
> +	ret = clk_prepare_enable(scp->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clocks\n");

should this deassert the reset to leave things as they were?

> +		return ret;
> +	}
> +
> +	writel(0x0, scp->reg_base + MT8183_SCP_SRAM_PDN);

what is the purpose of this write?

> +
> +	memcpy(scp->sram_base, fw->data, fw->size);
> +	return ret;
> +}
> +
> +static int mtk_scp_start(struct rproc *rproc)
> +{
> +	struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
> +	struct device *dev = scp->dev;
> +	struct scp_run *run;
> +	int ret;
> +
> +	ret = clk_prepare_enable(scp->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clocks\n");
> +		return ret;
> +	}
> +
> +	run = &scp->run;
> +	run->signaled = false;
> +
> +	mtk_scp_reset_deassert(scp);
> +
> +	ret = wait_event_interruptible_timeout(
> +					run->wq,
> +					run->signaled,
> +					msecs_to_jiffies(2000));
> +
> +	if (ret == 0) {
> +		dev_err(dev, "wait scp initialization timeout!\n");
> +		ret = -ETIME;
> +		goto stop;
> +	}
> +	if (ret == -ERESTARTSYS) {
> +		dev_err(dev, "wait scp interrupted by a signal!\n");
> +		goto stop;
> +	}
> +	dev_info(dev, "scp is ready. Fw version %s\n", run->fw_ver);

s/Fw/FW/

> +
> +	return 0;
> +
> +stop:
> +	mtk_scp_reset_assert(scp);
> +	clk_disable_unprepare(scp->clk);
> +	return ret;
> +}
> +
> +static void *mtk_scp_da_to_va(struct rproc *rproc, u64 da, int len)
> +{
> +	struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
> +	int offset;
> +
> +	if (da < scp->sram_size) {
> +		offset = da;
> +		if (offset >= 0 && ((offset + len) < scp->sram_size))
> +			return (__force void *)(scp->sram_base + offset);
> +	} else if (da >= scp->sram_size &&
> +		   da < (scp->sram_size + MAX_CODE_SIZE)) {
> +		offset = da - scp->sram_size;
> +		if (offset >= 0 && (offset + len) < MAX_CODE_SIZE)
> +			return scp->cpu_addr + offset;
> +	} else {
> +		offset = da - scp->phys_addr;
> +		if (offset >= 0 &&
> +		    (offset + len) < (scp->dram_size - MAX_CODE_SIZE))
> +			return scp->cpu_addr + offset;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int mtk_scp_stop(struct rproc *rproc)
> +{
> +	struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
> +
> +	mtk_scp_reset_assert(scp);
> +	clk_disable_unprepare(scp->clk);
> +
> +	return 0;
> +}
> +
> +static const struct rproc_ops mtk_scp_ops = {
> +	.start		= mtk_scp_start,
> +	.stop		= mtk_scp_stop,
> +	.load		= mtk_scp_load,
> +	.da_to_va	= mtk_scp_da_to_va,
> +};
> +
> +unsigned int scp_get_vdec_hw_capa(struct platform_device *pdev)
> +{
> +	struct mtk_scp *scp = platform_get_drvdata(pdev);
> +
> +	return scp->run.dec_capability;
> +}
> +EXPORT_SYMBOL_GPL(scp_get_vdec_hw_capa);
> +
> +unsigned int scp_get_venc_hw_capa(struct platform_device *pdev)
> +{
> +	struct mtk_scp *scp = platform_get_drvdata(pdev);
> +
> +	return scp->run.enc_capability;
> +}
> +EXPORT_SYMBOL_GPL(scp_get_venc_hw_capa);
> +
> +void *scp_mapping_dm_addr(struct platform_device *pdev, u32 mem_addr)
> +{
> +	struct mtk_scp *scp = platform_get_drvdata(pdev);
> +	void *ptr = NULL;

initialization is unnecessary

> +
> +	ptr = mtk_scp_da_to_va(scp->rproc, mem_addr, 0);
> +
> +	if (ptr)
> +		return ptr;
> +	else
> +		return ERR_PTR(-EINVAL);

possible readability tweak:

        if (!ptr)
                return ERR_PTR(-EINVAL);

        return ptr;

> +}
> +EXPORT_SYMBOL_GPL(scp_mapping_dm_addr);
> +
> +static int scp_map_memory_region(struct mtk_scp *scp)
> +{
> +	struct device_node *node;
> +	struct resource r;
> +	int ret;
> +
> +	node = of_parse_phandle(scp->dev->of_node, "memory-region", 0);
> +	if (!node) {
> +		dev_err(scp->dev, "no memory-region specified\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_address_to_resource(node, 0, &r);
> +	if (ret)
> +		return ret;
> +
> +	scp->phys_addr = r.start;
> +	scp->dram_size = resource_size(&r);
> +	scp->cpu_addr =
> +		devm_ioremap_wc(scp->dev, scp->phys_addr, scp->dram_size);
> +
> +	if (!scp->cpu_addr) {
> +		dev_err(scp->dev, "unable to map memory region: %pa+%zx\n",
> +			&r.start, scp->dram_size);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_scp_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct mtk_scp *scp;
> +	struct rproc *rproc;
> +	struct resource *res;
> +	char *fw_name = "scp.img";
> +	int ret;
> +
> +	rproc = rproc_alloc(dev,
> +			    np->name,
> +			    &mtk_scp_ops,
> +			    fw_name,
> +			    sizeof(*scp));
> +	if (!rproc) {
> +		dev_err(dev, "unable to allocate remoteproc\n");
> +		return -ENOMEM;
> +	}
> +
> +	scp = (struct mtk_scp *)rproc->priv;
> +	scp->rproc = rproc;
> +	scp->dev = dev;
> +	platform_set_drvdata(pdev, scp);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");

I assume you don't check 'res', since devm_ioremap_resource() will fail
if it is NULL.

> +	scp->sram_base = devm_ioremap_resource(dev, res);
> +	scp->sram_size = resource_size(res);

However resource_size() will result in a crash if 'res' is NULL. So you
either add a check for 'res' or do resource_size() after the check of
'scp->sram_base' below.

> +	if (IS_ERR((__force void *)scp->sram_base)) {
> +		dev_err(dev, "Failed to parse and map sram memory\n");
> +		ret = PTR_ERR((__force void *)scp->sram_base);
> +		goto free_rproc;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	scp->reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR((__force void *)scp->reg_base)) {
> +		dev_err(dev, "Failed to parse and map cfg memory\n");
> +		ret = PTR_ERR((__force void *)scp->reg_base);
> +		goto free_rproc;
> +	}
> +
> +	ret = scp_map_memory_region(scp);
> +	if (ret)
> +		goto free_rproc;
> +
> +	scp->clk = devm_clk_get(dev, "main");
> +	if (IS_ERR(scp->clk)) {
> +		dev_err(dev, "Failed to get clock\n");
> +		ret = PTR_ERR(scp->clk);
> +		goto free_rproc;
> +	}
> +
> +	ret = clk_prepare_enable(scp->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clocks\n");
> +		goto free_rproc;
> +	}
> +
> +	ret = scp_ipi_init(scp);
> +	clk_disable_unprepare(scp->clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to init ipi\n");
> +		goto free_rproc;
> +	}
> +
> +	/* register scp initialization IPI */
> +	ret = scp_ipi_register(pdev,
> +			       SCP_IPI_INIT,
> +			       scp_init_ipi_handler,
> +			       scp);
> +	if (ret) {
> +		dev_err(dev, "Failed to register IPI_SCP_INIT\n");
> +		goto free_rproc;
> +	}
> +
> +	ret = devm_request_irq(dev,
> +			       platform_get_irq(pdev, 0),
> +			       scp_irq_handler,
> +			       0,
> +			       pdev->name,
> +			       scp);

shouldn't the interrupt be requested after initializing the mutex and
the waitqueues?

> +
> +	if (ret) {
> +		dev_err(dev, "failed to request irq\n");
> +		goto free_rproc;
> +	}
> +
> +	mutex_init(&scp->scp_mutex);
> +
> +	init_waitqueue_head(&scp->run.wq);
> +	init_waitqueue_head(&scp->ack_wq);
> +
> +	ret = rproc_add(rproc);
> +	if (ret)
> +		goto destroy_mutex;
> +
> +	return ret;
> +
> +destroy_mutex:
> +	mutex_destroy(&scp->scp_mutex);
> +free_rproc:
> +	rproc_free(rproc);
> +
> +	return ret;
> +}
> +
> +static int mtk_scp_remove(struct platform_device *pdev)
> +{
> +	struct mtk_scp *scp = platform_get_drvdata(pdev);
> +
> +	rproc_del(scp->rproc);
> +	rproc_free(scp->rproc);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mtk_scp_of_match[] = {
> +	{ .compatible = "mediatek,mt8183-scp"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_scp_of_match);
> +
> +static struct platform_driver mtk_scp_driver = {
> +	.probe = mtk_scp_probe,
> +	.remove = mtk_scp_remove,
> +	.driver = {
> +		.name = "mtk-scp",
> +		.of_match_table = of_match_ptr(mtk_scp_of_match),
> +	},
> +};
> +
> +module_platform_driver(mtk_scp_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("MediaTek scp control driver");
> diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
> new file mode 100644
> index 00000000000000..51b8449a692970
> --- /dev/null
> +++ b/drivers/remoteproc/mtk_scp_ipi.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2018 MediaTek Inc.
> +
> +#include <asm/barrier.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/mtk_scp.h>
> +#include <linux/platform_device.h>
> +
> +#include "mtk_common.h"
> +
> +int scp_ipi_register(struct platform_device *pdev,
> +		     enum scp_ipi_id id,
> +		     scp_ipi_handler_t handler,
> +		     void *priv)
> +{
> +	struct mtk_scp *scp = platform_get_drvdata(pdev);
> +	struct scp_ipi_desc *ipi_desc;
> +
> +	if (!scp) {
> +		dev_err(&pdev->dev, "scp device is not ready\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	if (WARN(id < 0 ||  id >= SCP_IPI_MAX || handler == NULL,
> +	    "register scp ipi id %d with invalid arguments\n", id))

I think you'd get more useful information with this:

        if (WARN_ON(id < 0) || WARN_ON(id >= SCP_IPI_MAX) || WARN_ON(!handler))
                return -EINVAL;

> +		return -EINVAL;
> +
> +	ipi_desc = scp->ipi_desc;
> +	ipi_desc[id].handler = handler;
> +	ipi_desc[id].priv = priv;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(scp_ipi_register);
> +
> +void scp_ipi_unregister(struct platform_device *pdev, enum scp_ipi_id id)
> +{
> +	struct mtk_scp *scp = platform_get_drvdata(pdev);
> +	struct scp_ipi_desc *ipi_desc;
> +
> +	if (!scp)
> +		return;
> +
> +	if (WARN(id < 0 || id >= SCP_IPI_MAX,
> +		 "unregister scp ipi id %d with invalid arguments\n", id))
> +		return;
> +
> +	ipi_desc = scp->ipi_desc;
> +	ipi_desc[id].handler = NULL;
> +	ipi_desc[id].priv = NULL;
> +}
> +EXPORT_SYMBOL_GPL(scp_ipi_unregister);
> +
> +static void memcpy_aligned(void *dst, const void *src, unsigned int len)
> +{
> +	void *ptr;
> +	u32 val;
> +	unsigned int i = 0;
> +
> +	if (!IS_ALIGNED((unsigned long)dst, 4)) {
> +		ptr = (void *)ALIGN_DOWN((unsigned long)dst, 4);
> +		i = 4 - (dst - ptr);
> +		val = readl_relaxed(ptr);
> +		memcpy((u8 *)&val + (4 - i), src, i);
> +		writel_relaxed(val, ptr);
> +	}
> +
> +	while (i + 4 <= len) {
> +		val = *((u32 *)(src + i));
> +		writel_relaxed(val, dst + i);
> +		i += 4;
> +	}
> +	if (i < len) {
> +		val = readl_relaxed(dst + i);
> +		memcpy(&val, src + i, len - i);
> +		writel_relaxed(val, dst + i);
> +	}
> +}
> +
> +int scp_ipi_send(struct platform_device *pdev,
> +		 enum scp_ipi_id id,
> +		 void *buf,
> +		 unsigned int len,
> +		 unsigned int wait)
> +{
> +	struct mtk_scp *scp = platform_get_drvdata(pdev);
> +	struct share_obj *send_obj = scp->send_buf;
> +	unsigned long timeout;
> +	int ret;
> +
> +	if (WARN(id <= SCP_IPI_INIT || id >= SCP_IPI_MAX ||
> +	    len > sizeof(send_obj->share_buf) || !buf,

similar as above, consider a combination of WARN_ONs

> +	    "failed to send ipi message\n"))
> +		return -EINVAL;
> +
> +	ret = clk_prepare_enable(scp->clk);
> +	if (ret) {
> +		dev_err(scp->dev, "failed to enable clock\n");
> +		return ret;
> +	}

With the clk_enable/disable() outside of the lock the following could happen:

proc 1> clk_prepare_enable()
proc 1> mutex_lock()
proc 1> send data
proc 1> mutex_unlock()
proc 2> clk_prepare_enable()
proc 1> clk_unprepare_disable()
proc 2> mutex_lock()
proc 2> send data => BOOM

> +	mutex_lock(&scp->scp_mutex);
> +
> +	 /* Wait until SCP receives the last command */
> +	timeout = jiffies + msecs_to_jiffies(2000);
> +	do {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(scp->dev, "%s: IPI timeout!\n", __func__);
> +			ret = -EIO;
> +			mutex_unlock(&scp->scp_mutex);
> +			goto clock_disable;
> +		}
> +	} while (readl(scp->reg_base + MT8183_HOST_TO_SCP));
> +
> +	memcpy_aligned(send_obj->share_buf, buf, len);
> +
> +	send_obj->len = len;
> +	send_obj->id = id;
> +
> +	scp->ipi_id_ack[id] = false;
> +	/*
> +	 * Ensure that all write to SRAM are committed before sending the
> +	 * interrupt to SCP.
> +	 */
> +	mb();
> +	/* send the command to SCP */
> +	writel(MT8183_HOST_IPC_INT_BIT, scp->reg_base + MT8183_HOST_TO_SCP);
> +
> +	mutex_unlock(&scp->scp_mutex);
> +
> +	if (wait) {
> +		/* wait for SCP's ACK */
> +		timeout = msecs_to_jiffies(wait);
> +		ret = wait_event_timeout(scp->ack_wq,
> +					 scp->ipi_id_ack[id],
> +					 timeout);
> +		scp->ipi_id_ack[id] = false;
> +		if (WARN(!ret,
> +			 "scp ipi %d ack time out !", id))
> +			ret = -EIO;
> +		else
> +			ret = 0;
> +	}
> +
> +clock_disable:
> +	clk_disable_unprepare(scp->clk);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(scp_ipi_send);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("MediaTek scp IPI interface");
> diff --git a/include/linux/platform_data/mtk_scp.h b/include/linux/platform_data/mtk_scp.h
> new file mode 100644
> index 00000000000000..0e999ec319446b
> --- /dev/null
> +++ b/include/linux/platform_data/mtk_scp.h
> @@ -0,0 +1,135 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + */
> +
> +#ifndef _MTK_SCP_H
> +#define _MTK_SCP_H
> +
> +#include <linux/platform_device.h>
> +
> +typedef void (*scp_ipi_handler_t) (void *data,
> +				   unsigned int len,
> +				   void *priv);
> +
> +/**
> + * enum ipi_id - the id of inter-processor interrupt
> + *
> + * @SCP_IPI_INIT:	 The interrupt from scp is to notfiy kernel
> + *			 SCP initialization completed.
> + *			 IPI_SCP_INIT is sent from SCP when firmware is
> + *			 loaded. AP doesn't need to send IPI_SCP_INIT
> + *			 command to SCP.
> + *			 For other IPI below, AP should send the request
> + *			 to SCP to trigger the interrupt.
> + * @IPI_MAX:		 The maximum IPI number
> + */
> +
> +enum scp_ipi_id {
> +	SCP_IPI_INIT = 0,
> +	SCP_IPI_VDEC_H264,
> +	SCP_IPI_VDEC_VP8,
> +	SCP_IPI_VDEC_VP9,
> +	SCP_IPI_VENC_H264,
> +	SCP_IPI_VENC_VP8,
> +	SCP_IPI_MDP,
> +	SCP_IPI_CROS_HOST_CMD,
> +	SCP_IPI_MAX,
> +};
> +
> +/**
> + * scp_ipi_register - register an ipi function
> + *
> + * @pdev:	SCP platform device
> + * @id:		IPI ID
> + * @handler:	IPI handler
> + * @priv:	private data for IPI handler
> + *
> + * Register an ipi function to receive ipi interrupt from SCP.
> + *
> + * Return: Return 0 if ipi registers successfully, otherwise it is failed.
> + */
> +int scp_ipi_register(struct platform_device *pdev,
> +		     enum scp_ipi_id id,
> +		     scp_ipi_handler_t handler,
> +		     void *priv);
> +
> +/**
> + * scp_ipi_unregister - unregister an ipi function
> + *
> + * @pdev:	SCP platform device
> + * @id:		IPI ID
> + *
> + * Unregister an ipi function to receive ipi interrupt from SCP.
> + */
> +void scp_ipi_unregister(struct platform_device *pdev, enum scp_ipi_id id);
> +
> +/**
> + * scp_ipi_send - send data from AP to scp.
> + *
> + * @pdev:	SCP platform device
> + * @id:		IPI ID
> + * @buf:	the data buffer
> + * @len:	the data buffer length
> + * @wait:	1: need ack
> + *
> + * This function is thread-safe. When this function returns,
> + * SCP has received the data and starts the processing.
> + * When the processing completes, IPI handler registered
> + * by scp_ipi_register will be called in interrupt context.
> + *
> + * Return: Return 0 if sending data successfully, otherwise it is failed.
> + **/
> +int scp_ipi_send(struct platform_device *pdev,
> +		 enum scp_ipi_id id,
> +		 void *buf,
> +		 unsigned int len,
> +		 unsigned int wait);
> +
> +/**
> + * scp_get_plat_device - get SCP's platform device
> + *
> + * @pdev:	the platform device of the module requesting SCP platform
> + *		device for using SCP API.
> + *
> + * Return: Return NULL if it is failed.
> + * otherwise it is SCP's platform device
> + **/
> +struct platform_device *scp_get_plat_device(struct platform_device *pdev);
> +
> +/**
> + * scp_get_vdec_hw_capa - get video decoder hardware capability
> + *
> + * @pdev:	SCP platform device
> + *
> + * Return: video decoder hardware capability
> + **/
> +unsigned int scp_get_vdec_hw_capa(struct platform_device *pdev);
> +
> +/**
> + * scp_get_venc_hw_capa - get video encoder hardware capability
> + *
> + * @pdev:	SCP platform device
> + *
> + * Return: video encoder hardware capability
> + **/
> +unsigned int scp_get_venc_hw_capa(struct platform_device *pdev);
> +
> +/**
> + * scp_mapping_dm_addr - Mapping SRAM/DRAM to kernel virtual address
> + *
> + * @pdev:	SCP platform device
> + * @mem_addr:	SCP views memory address
> + *
> + * Mapping the SCP's SRAM address /
> + * DMEM (Data Extended Memory) memory address /
> + * Working buffer memory address to
> + * kernel virtual address.
> + *
> + * Return: Return ERR_PTR(-EINVAL) if mapping failed,
> + * otherwise the mapped kernel virtual address
> + **/
> +void *scp_mapping_dm_addr(struct platform_device *pdev,
> +			  u32 mem_addr);
> +
> +#endif /* _MTK_SCP_H */

Cheers

Matthias
