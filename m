Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76DCC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919DF206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeLaNVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 08:21:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:55499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbeLaNVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 08:21:15 -0500
Received: from corona.crabdance.com ([173.228.106.209]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M9OMc-1gTXtI1Yi6-00Cies; Mon, 31 Dec 2018 14:20:47 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
        id 3894E6E85603; Mon, 31 Dec 2018 05:20:00 -0800 (PST)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        andrew@aj.id.au, bp@alien8.de, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-edac@vger.kernel.org,
        sschaeck@cisco.com
In-reply-to: <1545026517-64069-2-git-send-email-schaecsn@gmx.net> (message
        from Stefan Schaeckeler on Sun, 16 Dec 2018 22:01:56 -0800)
Subject: Re: [PATCH 1/2] EDAC: Add Aspeed AST2500 EDAC driver
Reply-to: schaecsn@gmx.net
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net> <1545026517-64069-2-git-send-email-schaecsn@gmx.net>
Message-Id: <20181231132000.3894E6E85603@corona.crabdance.com>
Date:   Mon, 31 Dec 2018 05:20:00 -0800 (PST)
X-Provags-ID: V03:K1:Lp+TJN9DktN8Fhgkv1nPFwXy2gmA147b53IruQN6FiQV9h0elxQ
 uwgT38tXygzcv8N9s2vL6iggbHMLj7Rp4N/PVzZl0ZrbOwJnlV8DkLv/GkgDvTvBLAKJ8MC
 I1VcBy6K9rhrZ5+xmbaomyYB+5rTl6N1khzxCoDRn5Y3FW9cGwj016K6cSL8ffMkeEHK86M
 4bnsmQQDOnrPbkl2iMcRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ax8s2VSOIiw=:JmVEQeP2YmMj32EqxxO5La
 DjamtI+hhZjsPbVM8ozraLn1KK/VPE1afdjcdgpOFscTum3FyHmG/1Vs+JJo75SDiqzxfvr5Z
 4MWvMvZ2ozBH5U3SIwJIjXmM1H/Z7vdofDUPH8HS8XjJEvbCpK04MMU112TBba/glYsVr7+iQ
 +7pWCSb/s3hZIjZYcTNjFYWkdWMWU/XkjOMufdc4IEK/i8FF0p9lPcqSGw6t1N9zcT3vS3xMO
 1SdHwctY7aCHkJVlju+sbyvcT6tvwvsFCsTXfiUR7VfPzVgzrsxBKO93uiRFH2vDBD5KsMZmz
 3q+lNThRUAo+hVNyTFuaFM+EZ5SboAmU7tvpmn35AUHrEESM1Si4vkp0A3K5MJEAYspywNdmm
 xhrZHSltc9SKun9Xet6dpH86gtYxl9FOo2yy/GTHbYZlef4b5Ltx6a2NeFKfr80ZGsltBA4kU
 xwVmsMxI8/cBWhvbZgpSRv7hnv4yk1AS27FyD0G2vyOKuWBUM+yMSb1hBIAw9dkSMtmMNxtXP
 qtMA3UhJ2dnflyYOJhJULgYEFT1npErFIveOEQqwqE27WWVhMTg6eLDFacqp12/Ffm5LmnJIS
 E5SR+9izKJx9rza9DF+XHAPLnJHOF8dW11viT4geer1qPMSdRrXQQpctTpor4cSjq0dFEq6x/
 28tHDadtONhIqDwmxGoIQbUK4oEcGYFi1DBNkzbkASUqzh+SHzJjxGVUrew3PDRZmmATPinFC
 DOAtcLriuLjxV3yehF3GcqSOXkcmhweEHH+wiRG1lvrbeT/jOk9Q63U9ixPEP2AnI9xa6vQQP
 mpkBO+Ggyp8x1aN16xCXKCLnd4pZA58X0YdR7SmD8Dj1zYKL/pQgXo5jB34X9umALTxzm3JRt
 J1vS6BNSCCnI3MTK1v8d1pRgunW/savN5I7kF/MiI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let me start with reviewing my own driver. Perhaps someone could review it as well, please?

I found a cosmetic issue and a bug. See inline.


> From:   Stefan Schaeckeler <schaecsn@gmx.net>
> 
> From: Stefan M Schaeckeler <sschaeck@cisco.com>
> 
> Add support for the Aspeed AST2500 SoC EDAC driver.
> 
> Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
> ---
>  MAINTAINERS                      |   6 +
>  arch/arm/boot/dts/aspeed-g5.dtsi |   7 +
>  drivers/edac/Kconfig             |   7 +
>  drivers/edac/Makefile            |   1 +
>  drivers/edac/aspeed_edac.c       | 457 +++++++++++++++++++++++++++++++
>  5 files changed, 478 insertions(+)
>  create mode 100644 drivers/edac/aspeed_edac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3318f30903b2..1feb92b14029 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5315,6 +5315,12 @@ L:	linux-edac@vger.kernel.org
>  S:	Maintained
>  F:	drivers/edac/amd64_edac*
>  
> +EDAC-AST2500
> +M:	Stefan Schaeckeler <sschaeck@cisco.com>
> +S:	Supported
> +F:	drivers/edac/aspeed_edac.c
> +F:	Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> +
>  EDAC-CALXEDA
>  M:	Robert Richter <rric@kernel.org>
>  L:	linux-edac@vger.kernel.org
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index d107459fc0f8..b4e479ab5a2d 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -47,6 +47,13 @@
>  		reg = <0x80000000 0>;
>  	};
>  
> +	edac: sdram@1e6e0000 {
> +		compatible = "aspeed,ast2500-sdram-edac";
> +		reg = <0x1e6e0000 0x174>;
> +		interrupts = <0>;
> +		status = "disabled";
> +	};
> +
>  	ahb {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 41c9ccdd20d6..67834430b0a1 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -475,4 +475,11 @@ config EDAC_QCOM
>  	  For debugging issues having to do with stability and overall system
>  	  health, you should probably say 'Y' here.
>  
> +config EDAC_ASPEED
> +	tristate "Aspeed AST 2500 SoC"
> +	depends on MACH_ASPEED_G5
> +	help
> +	  Support for error detection and correction on the
> +	  Aspeed AST 2500 SoC.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 716096d08ea0..e1f23d4ff860 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -78,3 +78,4 @@ obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
>  obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
>  obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
>  obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
> +obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> new file mode 100644
> index 000000000000..d6ed119909eb
> --- /dev/null
> +++ b/drivers/edac/aspeed_edac.c
> @@ -0,0 +1,457 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018 Cisco Systems
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/edac.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/stop_machine.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +#include <asm/page.h>

Including asm/page.h does not seem to be necessary.


> +#include "edac_module.h"
> +
> +
> +#define DRV_NAME "aspeed-edac"
> +
> +
> +/* registers */
> +#define ASPEED_MCR_PROT        0x00 /* protection key register */
> +#define ASPEED_MCR_CONF        0x04 /* configuration register */
> +#define ASPEED_MCR_INTR_CTRL   0x50 /* interrupt control/status register */
> +#define ASPEED_MCR_ADDR_UNREC  0x58 /* address of first un-recoverable error */
> +#define ASPEED_MCR_ADDR_REC    0x5c /* address of last recoverable error */
> +#define ASPEED_MCR_LAST        ASPEED_MCR_ADDR_REC
> +
> +
> +/* bits and masks */
> +#define ASPEED_MCR_PROT_PASSWD	            0xfc600309
> +#define ASPEED_MCR_CONF_DRAM_TYPE               BIT(4)
> +#define ASPEED_MCR_CONF_ECC                     BIT(7)
> +#define ASPEED_MCR_INTR_CTRL_CLEAR             BIT(31)
> +#define ASPEED_MCR_INTR_CTRL_CNT_REC   GENMASK(23, 16)
> +#define ASPEED_MCR_INTR_CTRL_CNT_UNREC GENMASK(15, 12)
> +#define ASPEED_MCR_INTR_CTRL_ENABLE  (BIT(0) | BIT(1))
> +
> +
> +
> +static int aspeed_edac_regmap_reg_write(void *context, unsigned int reg,
> +					unsigned int val)
> +{
> +	void __iomem *regs = (void __iomem *)context;
> +
> +	/* enable write to MCR register set */
> +	writel(ASPEED_MCR_PROT_PASSWD, regs + ASPEED_MCR_PROT);
> +
> +	writel(val, regs + reg);
> +
> +	/* disable write to MCR register set */
> +	writel(~ASPEED_MCR_PROT_PASSWD, regs + ASPEED_MCR_PROT);
> +
> +	return 0;
> +}
> +
> +
> +static int aspeed_edac_regmap_reg_read(void *context, unsigned int reg,
> +				       unsigned int *val)
> +{
> +	void __iomem *regs = (void __iomem *)context;
> +
> +	*val = readl(regs + reg);
> +
> +	return 0;
> +}
> +
> +static bool aspeed_edac_regmap_is_volatile(struct device *dev,
> +					   unsigned int reg)
> +{
> +	switch (reg) {
> +	case ASPEED_MCR_PROT:
> +	case ASPEED_MCR_INTR_CTRL:
> +	case ASPEED_MCR_ADDR_UNREC:
> +	case ASPEED_MCR_ADDR_REC:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +
> +static const struct regmap_config aspeed_edac_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = ASPEED_MCR_LAST,
> +	.reg_write = aspeed_edac_regmap_reg_write,
> +	.reg_read = aspeed_edac_regmap_reg_read,
> +	.volatile_reg = aspeed_edac_regmap_is_volatile,
> +	.fast_io = true,
> +};
> +
> +
> +static struct regmap *aspeed_edac_regmap;
> +
> +
> +static void aspeed_edac_count_rec(struct mem_ctl_info *mci,
> +				  u8 rec_cnt,
> +				  u32 rec_addr)
> +{
> +	struct csrow_info *csrow = mci->csrows[0];
> +	u32 page, offset, syndrome;
> +
> +	if (rec_cnt > 0) {
> +		/* report first few errors (if there are) */
> +		/* note: no addresses are recorded */
> +		if (rec_cnt > 1) {
> +			page = 0; /* not available */
> +			offset = 0;  /* not available */
> +			syndrome = 0; /* not available */
> +			edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
> +					     rec_cnt-1, page, offset,
> +					     syndrome, 0, 0, -1,
> +					     "address(es) not available", "");
> +		}
> +
> +		/* report last error */
> +		/* note: rec_addr is the last recoverable error addr */
> +		page = rec_addr >> PAGE_SHIFT;
> +		offset = rec_addr & ~PAGE_MASK;
> +		syndrome = 0; /* not available */
> +		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1,
> +				     csrow->first_page + page, offset, syndrome,
> +				     0, 0, -1, "", "");
> +	}
> +}
> +
> +
> +static void aspeed_edac_count_un_rec(struct mem_ctl_info *mci,
> +				     u8 un_rec_cnt,
> +				     u32 un_rec_addr)
> +{
> +	struct csrow_info *csrow = mci->csrows[0];
> +	u32 page, offset, syndrome;
> +
> +	if (un_rec_cnt > 0) {
> +		/* report 1. error */
> +		/* note: un_rec_addr is the first unrecoverable error addr */
> +		page = un_rec_addr >> PAGE_SHIFT;
> +		offset = un_rec_addr & ~PAGE_MASK;
> +		syndrome = 0; /* not available */
> +		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
> +				     csrow->first_page + page, offset, syndrome,
> +				     0, 0, -1, "", "");
> +
> +		/* report further errors (if there are) */
> +		/* note: no addresses are recorded */
> +		if (un_rec_cnt > 1) {
> +			page = 0;  /* not available */
> +			offset = 0;  /* not available */
> +			syndrome = 0; /* not available */
> +			edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
> +					     un_rec_cnt-1, page, offset,
> +					     syndrome, 0, 0, -1,
> +					     "address(es) not available", "");
> +		}
> +	}
> +}
> +
> +
> +static void aspeed_edac_enable_interrupts(void)
> +{
> +
> +	regmap_update_bits(aspeed_edac_regmap, ASPEED_MCR_INTR_CTRL,
> +			   ASPEED_MCR_INTR_CTRL_ENABLE,
> +			   ASPEED_MCR_INTR_CTRL_ENABLE);
> +}
> +
> +
> +static void aspeed_edac_disable_interrupts(void)
> +{
> +	regmap_update_bits(aspeed_edac_regmap, ASPEED_MCR_INTR_CTRL,
> +			   ASPEED_MCR_INTR_CTRL_ENABLE, 0);
> +}
> +
> +
> +static void aspeed_edac_clear_interrupts(void)
> +{
> +	regmap_update_bits(aspeed_edac_regmap, ASPEED_MCR_INTR_CTRL,
> +			   ASPEED_MCR_INTR_CTRL_CLEAR,
> +			   ASPEED_MCR_INTR_CTRL_CLEAR);
> +
> +	regmap_update_bits(aspeed_edac_regmap, ASPEED_MCR_INTR_CTRL,
> +			   ASPEED_MCR_INTR_CTRL_CLEAR, 0);
> +}
> +
> +
> +static irqreturn_t aspeed_edac_isr(int irq, void *arg)
> +{
> +	u8  rec_cnt, un_rec_cnt;
> +	u32 rec_addr, un_rec_addr;
> +	struct mem_ctl_info *mci = arg;
> +	u32 reg50, reg5c, reg58;
> +
> +	regmap_read(aspeed_edac_regmap, ASPEED_MCR_INTR_CTRL, &reg50);
> +	dev_dbg(mci->pdev, "received edac interrupt w/ mmc register 50: 0x%x\n",
> +		reg50);
> +
> +	/* collect data about recoverable and unrecoverable errors */
> +	rec_cnt = (reg50 & ASPEED_MCR_INTR_CTRL_CNT_REC) >> 16;
> +	un_rec_cnt = (reg50 & ASPEED_MCR_INTR_CTRL_CNT_UNREC) >> 12;
> +
> +	dev_dbg(mci->pdev, "%d recoverable interrupts and %d unrecoverable interrupts\n",
> +		rec_cnt, un_rec_cnt);
> +
> +	regmap_read(aspeed_edac_regmap, ASPEED_MCR_ADDR_UNREC, &reg58);
> +	un_rec_addr = reg58 >> 4;

Now I better understand reg58. This is from aspeed docs:

- - - snip - - -
31:30 reserved (0)
29:4  Address of first un-recoverable ECC error
3:0   reserved (0)
- - - snip - - -

Bits 3:0 are indeed part of the address, but their values are not known and so
simply hardcoded to 0000. This is because there is one ECC byte for every 8
bytes and so the precision is 8-byte.

In other words, the whole register holds the address of the first
un-recoverable ECC error and so the shift must be removed:

 	un_rec_addr = reg58;


Sanity check: an address space of 29-4+1 bits would be quite small. The correct
address space is 30 bits.


> +	regmap_read(aspeed_edac_regmap, ASPEED_MCR_ADDR_REC, &reg5c);
> +	rec_addr = reg5c >> 4;

Same as above.


> +	/* clear interrupt flags and error counters: */
> +	aspeed_edac_clear_interrupts();
> +
> +	/* process recoverable and unrecoverable errors */
> +	if (rec_cnt > 0)
> +		aspeed_edac_count_rec(mci, rec_cnt, rec_addr);
> +
> +	if (un_rec_cnt > 0)
> +		aspeed_edac_count_un_rec(mci, un_rec_cnt, un_rec_addr);
> +
> +	if ((rec_cnt == 0) && (un_rec_cnt == 0))
> +		dev_dbg(mci->pdev, "received edac interrupt, but did not find any ecc counters\n");
> +
> +	regmap_read(aspeed_edac_regmap, ASPEED_MCR_INTR_CTRL, &reg50);
> +	dev_dbg(mci->pdev, "edac interrupt handled. mmc reg 50 is now: 0x%x\n",
> +		reg50);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
> +static int aspeed_edac_config_irq(void *ctx,
> +				  struct platform_device *pdev)
> +{
> +	int irq;
> +	int rc;
> +
> +	/* register interrupt handler */
> +
> +	irq = platform_get_irq(pdev, 0);
> +	dev_dbg(&pdev->dev, "got irq %d\n", irq);
> +	if (!irq)
> +		return -ENODEV;
> +
> +	rc = devm_request_irq(&pdev->dev, irq, aspeed_edac_isr,
> +			      IRQF_TRIGGER_HIGH, DRV_NAME, ctx);
> +	if (rc) {
> +		dev_err(&pdev->dev, "unable to request irq %d\n", irq);
> +		return rc;
> +	}
> +
> +	/* enable interrupts */
> +	aspeed_edac_enable_interrupts();
> +
> +	return 0;
> +}
> +
> +
> +static int aspeed_edac_init_csrows(struct mem_ctl_info *mci)
> +{
> +	struct csrow_info *csrow = mci->csrows[0];
> +	struct dimm_info *dimm;
> +	struct device_node *np;
> +	u32 nr_pages, dram_type;
> +	struct resource r;
> +	u32 reg04;
> +	int rc;
> +
> +	/* retrieve info about physical memory from device tree */
> +	np = of_find_node_by_path("/memory");
> +
> +	if (!np) {
> +		dev_err(mci->pdev, "dt: missing /memory node\n");
> +		return -ENODEV;
> +	};
> +
> +	rc = of_address_to_resource(np, 0, &r);
> +
> +	of_node_put(np);
> +
> +	if (rc) {
> +		dev_err(mci->pdev, "dt: failed requesting resource for /memory node\n");
> +		return rc;
> +	};
> +
> +	dev_dbg(mci->pdev, "dt: /memory node resources: first page r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> +		r.start, resource_size(&r), PAGE_SHIFT);
> +
> +	csrow->first_page = r.start >> PAGE_SHIFT;
> +	nr_pages = resource_size(&r) >> PAGE_SHIFT;
> +	csrow->last_page = csrow->first_page + nr_pages - 1;
> +
> +	regmap_read(aspeed_edac_regmap, ASPEED_MCR_CONF, &reg04);
> +	dram_type = (reg04 & ASPEED_MCR_CONF_DRAM_TYPE) ? MEM_DDR4 : MEM_DDR3;
> +
> +	dimm = csrow->channels[0]->dimm;
> +	dimm->mtype = dram_type;
> +	dimm->edac_mode = EDAC_SECDED;
> +	dimm->nr_pages = nr_pages / csrow->nr_channels;
> +
> +	dev_dbg(mci->pdev, "initialized dimm with first_page=0x%lx and nr_pages=0x%x\n",
> +		csrow->first_page, nr_pages);
> +
> +	return 0;
> +}
> +
> +
> +static int aspeed_edac_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	void __iomem *regs;
> +	struct resource *res;
> +	struct mem_ctl_info *mci;
> +	struct edac_mc_layer layers[2];
> +	struct device_node *np;
> +	u32 reg04;
> +	int rc;
> +
> +	/* setup regmap */
> +	np = dev->of_node;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENOENT;
> +
> +	regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	aspeed_edac_regmap = devm_regmap_init(dev, NULL, (__force void *)regs,
> +					       &aspeed_edac_regmap_config);
> +	if (IS_ERR(aspeed_edac_regmap))
> +		return PTR_ERR(aspeed_edac_regmap);
> +
> +	/* bail out if ECC mode is not configured */
> +	regmap_read(aspeed_edac_regmap, ASPEED_MCR_CONF, &reg04);
> +	if (!(reg04 & ASPEED_MCR_CONF_ECC)) {
> +		dev_err(&pdev->dev, "ECC mode is not configured in u-boot\n");
> +		return -EPERM;
> +	}
> +
> +	edac_op_state = EDAC_OPSTATE_INT;
> +
> +	/* allocate & init EDAC MC data structure */
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = 1;
> +	layers[0].is_virt_csrow = true;
> +	layers[1].type = EDAC_MC_LAYER_CHANNEL;
> +	layers[1].size = 1;
> +	layers[1].is_virt_csrow = false;
> +
> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
> +	if (mci == NULL)
> +		return -ENOMEM;
> +
> +	mci->pdev = &pdev->dev;
> +	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
> +	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
> +	mci->edac_cap = EDAC_FLAG_SECDED;
> +	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
> +	mci->scrub_mode = SCRUB_HW_SRC;
> +	mci->mod_name = DRV_NAME;
> +	mci->ctl_name = "MIC";
> +	mci->dev_name = dev_name(&pdev->dev);
> +
> +	rc = aspeed_edac_init_csrows(mci);
> +	if (rc) {
> +		dev_err(&pdev->dev, "failed to init csrows\n");
> +		goto probe_exit02;
> +	}
> +
> +	platform_set_drvdata(pdev, mci);
> +
> +	/* register with edac core */
> +	rc = edac_mc_add_mc(mci);
> +	if (rc) {
> +		dev_err(&pdev->dev, "failed to register with EDAC core\n");
> +		goto probe_exit02;
> +	}
> +
> +	/* register interrupt handler and enable interrupts */
> +	rc = aspeed_edac_config_irq(mci, pdev);
> +	if (rc) {
> +		dev_err(&pdev->dev, "failed setting up irq\n");
> +		goto probe_exit01;
> +	}
> +
> +	return 0;
> +
> +probe_exit01:
> +	edac_mc_del_mc(&pdev->dev);
> +probe_exit02:
> +	edac_mc_free(mci);
> +	return rc;
> +}
> +
> +
> +static int aspeed_edac_remove(struct platform_device *pdev)
> +{
> +	struct mem_ctl_info *mci;
> +
> +	/* disable interrupts */
> +	aspeed_edac_disable_interrupts();
> +
> +	/* free resources */
> +	mci = edac_mc_del_mc(&pdev->dev);
> +	if (mci)
> +		edac_mc_free(mci);
> +
> +	return 0;
> +}
> +
> +
> +static const struct of_device_id aspeed_edac_of_match[] = {
> +	{ .compatible = "aspeed,ast2500-sdram-edac" },
> +	{},
> +};
> +
> +
> +static struct platform_driver aspeed_edac_driver = {
> +	.driver		= {
> +		.name	= DRV_NAME,
> +		.of_match_table = aspeed_edac_of_match
> +	},
> +	.probe		= aspeed_edac_probe,
> +	.remove		= aspeed_edac_remove
> +};
> +
> +
> +static int __init aspeed_edac_init(void)
> +{
> +	return platform_driver_register(&aspeed_edac_driver);
> +}
> +
> +
> +static void __exit aspeed_edac_exit(void)
> +{
> +	platform_driver_unregister(&aspeed_edac_driver);
> +}
> +
> +
> +module_init(aspeed_edac_init);
> +module_exit(aspeed_edac_exit);
> +
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Stefan Schaeckeler <sschaeck@cisco.com>");
> +MODULE_DESCRIPTION("Aspeed AST2500 EDAC driver");
> +MODULE_VERSION("1.0");
> -- 
> 2.19.1
> 

 Stefan
