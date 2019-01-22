Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D484C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4864A20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfAVIQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:16:37 -0500
Received: from mailproxy01.manitu.net ([217.11.48.65]:35950 "EHLO
        mailproxy01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfAVIQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:16:34 -0500
Received: from [192.168.178.20] (aftr-88-217-180-118.dynamic.mnet-online.de [88.217.180.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wg@grandegger.com)
        by mailproxy01.manitu.net (Postfix) with ESMTPSA id 9961612600B5;
        Tue, 22 Jan 2019 09:16:31 +0100 (CET)
Subject: Re: [PATCH v4 1/4] can: m_can: Create a m_can platform framework
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de,
        davem@davemloft.net, b29396@freescale.com
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190117200601.16416-1-dmurphy@ti.com>
From:   Wolfgang Grandegger <wg@grandegger.com>
Openpgp: preference=signencrypt
Autocrypt: addr=wg@grandegger.com; prefer-encrypt=mutual; keydata=
 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
 8QEfHnPzgykCs2DOOQ==
Message-ID: <8d1c7f7a-217e-2a22-5e88-2535bbf7405c@grandegger.com>
Date:   Tue, 22 Jan 2019 09:16:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117200601.16416-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

looks already quite good...

Am 17.01.19 um 21:05 schrieb Dan Murphy:
> Create a m_can platform framework that peripherial
> devices can register to and use common code and register sets.
> The peripherial devices may provide read/write and configuration
> support of the IP.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/net/can/m_can/m_can.c          |   6 +
>  drivers/net/can/m_can/m_can_platform.c | 209 +++++++++++++++++++++++++
>  drivers/net/can/m_can/m_can_platform.h | 163 +++++++++++++++++++
>  3 files changed, 378 insertions(+)
>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>  create mode 100644 drivers/net/can/m_can/m_can_platform.h
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 9b449400376b..f817b28582e9 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -414,6 +414,9 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
>  	u32 timeout = 10;
>  	u32 val = 0;
>  
> +	if (cccr & CCCR_CSR)
> +		cccr &= ~CCCR_CSR;
> +

This is an unrelated change/fix. Should go somewhere else.

>  	if (enable) {
>  		/* enable m_can configuration */
>  		m_can_write(priv, M_CAN_CCCR, cccr | CCCR_INIT);
> @@ -1155,6 +1158,9 @@ static void m_can_chip_config(struct net_device *dev)
>  	m_can_set_bittiming(dev);
>  
>  	m_can_config_endisable(priv, false);
> +
> +	if (priv->device_init)
> +		priv->device_init(priv);
>  }
>  
>  static void m_can_start(struct net_device *dev)
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> new file mode 100644
> index 000000000000..03172911323a
> --- /dev/null
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -0,0 +1,209 @@
> +/*
> + * CAN bus driver for Bosch M_CAN controller
> + *
> + * Copyright (C) 2014 Freescale Semiconductor, Inc.
> + *	Dong Aisheng <b29396@freescale.com>
> + *
> + * Bosch M_CAN user manual can be obtained from:
> + * http://www.bosch-semiconductors.de/media/pdf_1/ipmodules_1/m_can/
> + * mcan_users_manual_v302.pdf
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/can/dev.h>
> +#include <linux/pinctrl/consumer.h>
> +
> +#include "m_can_platform.h"
> +
> +struct m_can_plat_priv {
> +	void __iomem *base;
> +	void __iomem *mram_base;
> +};
> +
> +static u32 iomap_read_reg(struct m_can_classdev *m_can_class, int reg)
> +{
> +	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
> +
> +	return readl(priv->base + reg);
> +}
> +
> +static u32 iomap_read_fifo(struct m_can_classdev *m_can_class, int addr_offset)

Why not just "offset".

> +{
> +	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
> +
> +	return readl(priv->mram_base + addr_offset);
> +}
> +
> +static int iomap_write_reg(struct m_can_classdev *m_can_class, int reg, int val)
> +{
> +	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
> +
> +	writel(val, priv->base + reg);
> +
> +	return 0;
> +}
> +
> +static int iomap_write_fifo(struct m_can_classdev *m_can_class, int addr_offset, int val)
> +{
> +	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
> +
> +	writel(val, priv->base + addr_offset);
> +
> +	return 0;
> +}
> +
> +static int m_can_plat_probe(struct platform_device *pdev)
> +{
> +	struct m_can_classdev *mcan_class;
> +	struct m_can_plat_priv *priv;
> +	struct resource *res;
> +	void __iomem *addr;
> +	void __iomem *mram_addr;
> +	int irq, ret = 0;
> +
> +	mcan_class = m_can_core_allocate_dev(&pdev->dev);
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	mcan_class->device_data = priv;
> +
> +	m_can_core_get_clocks(mcan_class);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
> +	addr = devm_ioremap_resource(&pdev->dev, res);
> +	irq = platform_get_irq_byname(pdev, "int0");
> +	if (IS_ERR(addr) || irq < 0) {
> +		ret = -EINVAL;
> +		goto failed_ret;
> +	}
> +
> +	/* message ram could be shared */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
> +	if (!res) {
> +		ret = -ENODEV;
> +		goto failed_ret;
> +	}
> +
> +	mram_addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (!mram_addr) {
> +		ret = -ENOMEM;
> +		goto failed_ret;
> +	}
> +
> +	priv->base = addr;
> +	priv->mram_base = mram_addr;
> +
> +	mcan_class->net->irq = irq;
> +	mcan_class->pm_clock_support = 1;
> +	mcan_class->can.clock.freq = clk_get_rate(mcan_class->cclk);
> +	mcan_class->dev = &pdev->dev;
> +
> +	mcan_class->read_reg = &iomap_read_reg;
> +	mcan_class->write_reg = &iomap_write_reg;
> +	mcan_class->write_fifo = &iomap_write_fifo;
> +	mcan_class->read_fifo = &iomap_read_fifo;

No "&" please!

> +	mcan_class->is_peripherial = false;
> +
> +	platform_set_drvdata(pdev, mcan_class->dev);
> +
> +	m_can_init_ram(mcan_class);
> +
> +	ret = m_can_core_register(mcan_class);
> +
> +failed_ret:
> +	return ret;
> +}
> +
> +static __maybe_unused int m_can_suspend(struct device *dev)
> +{
> +	return m_can_core_suspend(dev);
> +}
> +
> +static __maybe_unused int m_can_resume(struct device *dev)
> +{
> +	return m_can_core_resume(dev);
> +}
> +
> +static int m_can_plat_remove(struct platform_device *pdev)
> +{
> +	struct net_device *dev = platform_get_drvdata(pdev);
> +	struct m_can_classdev *mcan_class = netdev_priv(dev);
> +
> +	m_can_core_unregister(mcan_class);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused m_can_runtime_suspend(struct device *dev)
> +{
> +	struct net_device *ndev = dev_get_drvdata(dev);
> +	struct m_can_classdev *mcan_class = netdev_priv(ndev);
> +
> +	m_can_core_suspend(dev);
> +
> +	clk_disable_unprepare(mcan_class->cclk);
> +	clk_disable_unprepare(mcan_class->hclk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused m_can_runtime_resume(struct device *dev)
> +{
> +	struct net_device *ndev = dev_get_drvdata(dev);
> +	struct m_can_classdev *mcan_class = netdev_priv(ndev);
> +	int err;
> +
> +	err = clk_prepare_enable(mcan_class->hclk);
> +	if (err)
> +		return err;
> +
> +	err = clk_prepare_enable(mcan_class->cclk);
> +	if (err)
> +		clk_disable_unprepare(mcan_class->hclk);
> +
> +	m_can_core_resume(dev);
> +
> +	return err;
> +}
> +
> +static const struct dev_pm_ops m_can_pmops = {
> +	SET_RUNTIME_PM_OPS(m_can_runtime_suspend,
> +			   m_can_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
> +};
> +
> +static const struct of_device_id m_can_of_table[] = {
> +	{ .compatible = "bosch,m_can", .data = NULL },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, m_can_of_table);
> +
> +static struct platform_driver m_can_plat_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = m_can_of_table,
> +		.pm     = &m_can_pmops,
> +	},
> +	.probe = m_can_plat_probe,
> +	.remove = m_can_plat_remove,
> +};
> +
> +module_platform_driver(m_can_plat_driver);
> +
> +MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");

Feel free to add yourself as second author.

> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller");
> diff --git a/drivers/net/can/m_can/m_can_platform.h b/drivers/net/can/m_can/m_can_platform.h
> new file mode 100644
> index 000000000000..97e90dd79613
> --- /dev/null
> +++ b/drivers/net/can/m_can/m_can_platform.h

These are common definitions, right? Therefore the filen name should be
"m_can.h"!?

> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> +
> +#ifndef _CAN_M_CAN_CORE_H_
> +#define _CAN_M_CAN_CORE_H_
> +
> +#include <linux/can/core.h>
> +#include <linux/can/led.h>
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/freezer.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/iopoll.h>
> +#include <linux/can/dev.h>
> +#include <linux/pinctrl/consumer.h>

Do you really need them all in this header file?

> +
> +/* m_can lec values */
> +enum m_can_lec_type {
> +	LEC_NO_ERROR = 0,
> +	LEC_STUFF_ERROR,
> +	LEC_FORM_ERROR,
> +	LEC_ACK_ERROR,
> +	LEC_BIT1_ERROR,
> +	LEC_BIT0_ERROR,
> +	LEC_CRC_ERROR,
> +	LEC_UNUSED,
> +};
> +
> +enum m_can_mram_cfg {
> +	MRAM_SIDF = 0,
> +	MRAM_XIDF,
> +	MRAM_RXF0,
> +	MRAM_RXF1,
> +	MRAM_RXB,
> +	MRAM_TXE,
> +	MRAM_TXB,
> +	MRAM_CFG_NUM,
> +};
> +
> +/* registers definition */
> +enum m_can_reg {
> +	M_CAN_CREL	= 0x0,
> +	M_CAN_ENDN	= 0x4,
> +	M_CAN_CUST	= 0x8,
> +	M_CAN_DBTP	= 0xc,
> +	M_CAN_TEST	= 0x10,
> +	M_CAN_RWD	= 0x14,
> +	M_CAN_CCCR	= 0x18,
> +	M_CAN_NBTP	= 0x1c,
> +	M_CAN_TSCC	= 0x20,
> +	M_CAN_TSCV	= 0x24,
> +	M_CAN_TOCC	= 0x28,
> +	M_CAN_TOCV	= 0x2c,
> +	M_CAN_ECR	= 0x40,
> +	M_CAN_PSR	= 0x44,
> +/* TDCR Register only available for version >=3.1.x */
> +	M_CAN_TDCR	= 0x48,
> +	M_CAN_IR	= 0x50,
> +	M_CAN_IE	= 0x54,
> +	M_CAN_ILS	= 0x58,
> +	M_CAN_ILE	= 0x5c,
> +	M_CAN_GFC	= 0x80,
> +	M_CAN_SIDFC	= 0x84,
> +	M_CAN_XIDFC	= 0x88,
> +	M_CAN_XIDAM	= 0x90,
> +	M_CAN_HPMS	= 0x94,
> +	M_CAN_NDAT1	= 0x98,
> +	M_CAN_NDAT2	= 0x9c,
> +	M_CAN_RXF0C	= 0xa0,
> +	M_CAN_RXF0S	= 0xa4,
> +	M_CAN_RXF0A	= 0xa8,
> +	M_CAN_RXBC	= 0xac,
> +	M_CAN_RXF1C	= 0xb0,
> +	M_CAN_RXF1S	= 0xb4,
> +	M_CAN_RXF1A	= 0xb8,
> +	M_CAN_RXESC	= 0xbc,
> +	M_CAN_TXBC	= 0xc0,
> +	M_CAN_TXFQS	= 0xc4,
> +	M_CAN_TXESC	= 0xc8,
> +	M_CAN_TXBRP	= 0xcc,
> +	M_CAN_TXBAR	= 0xd0,
> +	M_CAN_TXBCR	= 0xd4,
> +	M_CAN_TXBTO	= 0xd8,
> +	M_CAN_TXBCF	= 0xdc,
> +	M_CAN_TXBTIE	= 0xe0,
> +	M_CAN_TXBCIE	= 0xe4,
> +	M_CAN_TXEFC	= 0xf0,
> +	M_CAN_TXEFS	= 0xf4,
> +	M_CAN_TXEFA	= 0xf8,
> +};
> +
> +/* address offset and element number for each FIFO/Buffer in the Message RAM */
> +struct mram_cfg {
> +	u16 off;
> +	u8  num;
> +};
> +
> +struct m_can_classdev;
> +
> +typedef	int (*can_dev_init) (struct m_can_classdev *m_can_class);
> +typedef	int (*can_clr_dev_interrupts) (struct m_can_classdev *m_can_class);
> +typedef	u32 (*can_reg_read) (struct m_can_classdev *m_can_class, int reg);
> +typedef	int (*can_reg_write) (struct m_can_classdev *m_can_class, int reg, int val);
> +typedef	u32 (*can_fifo_read) (struct m_can_classdev *m_can_class, int addr_offset);
> +typedef	int (*can_fifo_write) (struct m_can_classdev *m_can_class, int addr_offset, int val);

No typedefs in the kernel, please!

> +struct m_can_classdev {
> +	struct can_priv can;
> +	struct napi_struct napi;
> +	struct net_device *net;
> +	struct device *dev;
> +	struct clk *hclk;
> +	struct clk *cclk;
> +
> +	struct workqueue_struct *wq;
> +	struct work_struct tx_work;
> +	struct sk_buff *skb;
> +
> +	struct can_bittiming_const *bit_timing;
> +	struct can_bittiming_const *data_timing;
> +
> +	void *device_data;
> +
> +	/* Device specific call backs */
> +	can_dev_init device_init;
> +	can_clr_dev_interrupts clr_dev_interrupts;
> +	can_reg_read read_reg;
> +	can_reg_write write_reg;
> +	can_fifo_read read_fifo;
> +	can_fifo_write write_fifo;
> +
> +	int version;
> +	int freq;
> +	u32 irqstatus;
> +
> +	int pm_clock_support;
> +	bool is_peripherial;
> +
> +	struct mram_cfg mcfg[MRAM_CFG_NUM];
> +};
> +
> +struct m_can_classdev *m_can_core_allocate_dev(struct device *dev);
> +int m_can_core_register(struct m_can_classdev *m_can_dev);
> +void m_can_core_unregister(struct m_can_classdev *m_can_dev);
> +int m_can_core_get_clocks(struct m_can_classdev *m_can_dev);

You use here three different prefixes: "m_can_core", "m_can_classdev"
and "m_can_dev". There should be just one principle name for the struct,
func, args and vars, e.g.:

  int m_can_device_register(struct m_can_device *mcan_dev);

> +void m_can_init_ram(struct m_can_classdev *priv);
> +void m_can_config_endisable(const struct m_can_classdev *priv, bool enable);
> +
> +int m_can_core_suspend(struct device *dev);
> +int m_can_core_resume(struct device *dev);
> +#endif	/* _CAN_M_CAN_CORE_H_ */
> 

Wolfgang
