Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E76DC31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D962089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+smTvIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfAURmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:42:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34466 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfAURmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:42:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so24486329wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 09:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YyzvH/8Q4pGNg1W1n2qHOKlUovRCDiPxfEZ9t6x1xts=;
        b=D+smTvIoYJvbTxXGZZ7bMwyatfMmwPLP7art+mD0fml7WuHolkPTjJR7iKfi06L/A0
         0XUu6/FAdyUqUimCGuR65lazHvU9Nu9JU0Ag7HCbFvayJNqPCqjQSeKsB2h2B4kIMs5e
         5htHNSPBS9AfKdbjT8dIVt49hiz/ssaTmjHBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YyzvH/8Q4pGNg1W1n2qHOKlUovRCDiPxfEZ9t6x1xts=;
        b=kScA+rvb2nTDSRiX8uS/NqJIBq2SPu6rx0I/SbLDyYEME2gK7iBdSZQ6rCEoNyx/Mn
         gWsrjuMaTjq+h5i4hAQQIPuDyyzLUT0RSBCW4jwrov6Ln42kIR8pyvCcpZAYSUb7NDjW
         2e5EvGCBGsPxFvl4yn86zoS4t05DmAuetov+/OGO+RTBanSICf0ZDfu5mVXcVhKh02Rj
         SmakSoh2FgDgTZNzvAR3rXhvPSKrylhop+viHlCz4hQ28uhfxqlpE67u6FiYytGfAW61
         6ANst+WVrIUTsP9B/kBYkZf7ziml9q5EVo4ykfoAfyg68bcdO+7KezL97t3ypnfsE+Zn
         VY4A==
X-Gm-Message-State: AJcUukd5uLhDiYcbNUemY1Bcbx0MTQ0qHT/6Q79KOMGwAgs+ErUlgfZm
        094PUMPDCz5trey5TNNmsyBbhA==
X-Google-Smtp-Source: ALg8bN5J9m5Y4zWoG1QYq6T3+XQoCsqYLvG0YSaHGeuGghMB2qeHU/mLZ9pRjMoooNMTj4C09059Dg==
X-Received: by 2002:adf:ee46:: with SMTP id w6mr29997926wro.261.1548092519184;
        Mon, 21 Jan 2019 09:41:59 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y1sm64723166wme.1.2019.01.21.09.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 09:41:58 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [RFC PATCH 1/2] Add support of imx7ulp to interconnect framework
To:     abailon@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181117111905.29091-1-abailon@baylibre.com>
 <20181117111905.29091-2-abailon@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <3691c453-b2cb-df6f-d029-e82ac98733c7@linaro.org>
Date:   Mon, 21 Jan 2019 19:41:56 +0200
MIME-Version: 1.0
In-Reply-To: <20181117111905.29091-2-abailon@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Thanks for submitting this patchset!

On 11/17/18 13:19, abailon@baylibre.com wrote:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> This is a PoC of interconnect driver for the imx7ulp.
> This scales the clock of nic0 and nic1 (the two interconnects).
> In order too solve some issue with clocks (I will give more details

s/too/to/

> later in code), the bus topology described in the driver differ a little
> from the one in the datasheet.

Is there a public datasheet available?

> In addition, the driver manages nic0 and nic1 as an unique
> interconnect. It would have been better to manage them separately but
> it was harder to do it because of the clocks (again).
> Later, I will add third clock for the MMDC endpoint, which is the
> DDR controller. This will be used to scale the DDR in addition of
> interconnect.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com.com>

s/.com.com/.com/

> ---
>  drivers/interconnect/Kconfig       |   1 +
>  drivers/interconnect/Makefile      |   1 +
>  drivers/interconnect/imx/Kconfig   |   9 +
>  drivers/interconnect/imx/Makefile  |   1 +
>  drivers/interconnect/imx/imx7ulp.c | 369 +++++++++++++++++++++++++++++
>  5 files changed, 381 insertions(+)
>  create mode 100644 drivers/interconnect/imx/Kconfig
>  create mode 100644 drivers/interconnect/imx/Makefile
>  create mode 100644 drivers/interconnect/imx/imx7ulp.c
> 
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index 07a8276fa35a..99955906bea8 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -11,5 +11,6 @@ menuconfig INTERCONNECT
>  if INTERCONNECT
>  
>  source "drivers/interconnect/qcom/Kconfig"
> +source "drivers/interconnect/imx/Kconfig"
>  
>  endif
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index 7944cbca0527..4c8814fc2b4b 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_INTERCONNECT)		+= core.o
>  obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
> +obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
> diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx/Kconfig
> new file mode 100644
> index 000000000000..5eb88eafc1fd
> --- /dev/null
> +++ b/drivers/interconnect/imx/Kconfig
> @@ -0,0 +1,9 @@
> +config INTERCONNECT_IMX
> +	bool "IMX Network-on-Chip interconnect drivers"

I was wondering if this can be a module?

> +	depends on INTERCONNECT

The above is redundant.

> +	depends on ARCH_MXC

It would be nice if we can support COMPILE_TEST.

> +	default y
> +
> +config INTERCONNECT_IMX7ULP
> +	tristate "i.MX7ULP NIC-301 interconnect driver"
> +	depends on INTERCONNECT_IMX
> diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/imx/Makefile
> new file mode 100644
> index 000000000000..61d994b8fe2c
> --- /dev/null
> +++ b/drivers/interconnect/imx/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_INTERCONNECT_IMX7ULP) += imx7ulp.o
> diff --git a/drivers/interconnect/imx/imx7ulp.c b/drivers/interconnect/imx/imx7ulp.c
> new file mode 100644
> index 000000000000..7715198ad151
> --- /dev/null
> +++ b/drivers/interconnect/imx/imx7ulp.c
> @@ -0,0 +1,369 @@

Missing SPDX?

> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/interconnect-provider.h>

Please move this above io.h to keep it sorted.

> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define IMX7ULP_MAX_LINKS	32
> +
> +/**
> + * Clock property of node

The format should be:
struct my_struct - short description

> + * @name: The name of the clock
> + * @clk: A pointer to the clock
> + * @rate: The rate to use, when the clock frequency is updated
> + */
> +struct imx7ulp_bus_clock {
> +	char *name;
> +	struct clk *clk;
> +	u64 rate;
> +};
> +
> +/**
> + * IMX7ULP specific interconnect nodes

Ditto.

> + * @name: the node name used in debugfs
> + * @id: a unique node identifier
> + * @links: an array of nodes where we can go next while traversing
> + * @num_links: the total number of @links
> + * @buswidth: width (in bit) of the interconnect between a node and the bus
> + * @bus_clk: If not NULL, define clock properties of the node
> + * @ep: true if the node is an end point. Used to scale the frequency
> + */
> +struct imx7ulp_icc_node {
> +	char *name;
> +	u16 id;
> +	u16 links[IMX7ULP_MAX_LINKS];
> +	u16 num_links;
> +	u16 buswidth;
> +	struct imx7ulp_bus_clock *bus_clk;
> +	bool ep;
> +};
> +
> +/**

Ditto.

> + * @dev: device pointer for the overall interconnect
> + *       Although there are 2 interconnects, they are represented using one
> + *       device.
> + * @nodes: Array of nodes
> + * @num_nodes: The total number of nodes
> + * @nic0: Clock properties for nic0 interconnect
> + * @nic1: Clock properties for nic1 interconnect
> + */
> +struct imx7ulp_icc_desc {
> +	struct device *dev;
> +	struct imx7ulp_icc_node *nodes;
> +	size_t num_nodes;
> +	struct imx7ulp_bus_clock *nic0;
> +	struct imx7ulp_bus_clock *nic1;
> +};

I assume that we can be only change the rate of the interconnect clocks
and there are no other knobs? Is this correct? If that's the case, i
don't see a problem to represent it as a single device.

> +
> +#define DEFINE_AXI_INTERCONNECT(_name, _id, _buswidth, _ep, _clk,	\
> +				_numlinks, ...)				\
> +	{								\
> +		.id = _id,						\
> +		.name = #_name,						\
> +		.buswidth = (_buswidth * 4),				\

Please put parenthesis around _buswidth or avoid potential precedence
issues.

> +		.num_links = _numlinks,					\
> +		.links = { __VA_ARGS__ },				\
> +		.ep = _ep,						\
> +		.bus_clk = _clk,					\
> +	}
> +
> +#define DEFINE_AXI_MASTER(_name, _id, _buswidth, dest_id)		\
> +	DEFINE_AXI_INTERCONNECT(_name, _id, _buswidth, false, NULL,	\
> +				1, dest_id)
> +
> +#define DEFINE_AXI_SLAVE(_name, _id, _buswidth, _numlinks, ...)		\
> +	DEFINE_AXI_INTERCONNECT(_name, _id, _buswidth, false, NULL,	\
> +				_numlinks, __VA_ARGS__)
> +
> +#define DEFINE_AXI_SLAVE_EP(_name, _id, _buswidth)			\
> +	DEFINE_AXI_INTERCONNECT(_name, _id, _buswidth, true, NULL, 0, 0)
> +
> +#define DEFINE_AHB_SLAVE_EP(_name, _id)					\
> +	DEFINE_AXI_SLAVE_EP(_name, _id, 4)
> +
> +static struct imx7ulp_bus_clock nic0_clock = {
> +	.name = "nic0_div",
> +};
> +
> +static struct imx7ulp_bus_clock nic1_clock = {
> +	.name = "nic1_div",
> +};
> +
> +static struct imx7ulp_icc_node imx7ulp_nodes[] = {
> +	/* NIC0 Masters */
> +	DEFINE_AXI_MASTER(a7, 2000, 16, 1000),
> +	DEFINE_AXI_MASTER(nic1_s1, 2001, 8, 1000),
> +	DEFINE_AXI_MASTER(dsi, 2002, 4, 1000),
> +	DEFINE_AXI_MASTER(gpu3d, 2003, 8, 1000),
> +	DEFINE_AXI_MASTER(gpu2d, 2004, 16, 1000),
> +
> +	/* NIC0 Slaves */
> +	DEFINE_AXI_SLAVE_EP(mmdc, 2005, 16),
> +	DEFINE_AXI_SLAVE_EP(sram0, 2006, 8),
> +
> +	/* NIC0 */
> +	DEFINE_AXI_INTERCONNECT(nic0_m, 1000, 8, false, &nic0_clock, 1, 1001),
> +	DEFINE_AXI_INTERCONNECT(nic0_s, 1001, 8, false, NULL, 3,
> +				2005, 2006, 1008),
> +
> +	/* NIC1 Masters */
> +	DEFINE_AXI_MASTER(dma1_m, 2011, 8, 1008),
> +	DEFINE_AXI_MASTER(caam_m, 2013, 4, 1008),
> +	DEFINE_AXI_MASTER(usbotg_m, 2014, 4, 1008),
> +	DEFINE_AXI_MASTER(viu_m, 2015, 8, 1008),
> +	DEFINE_AXI_MASTER(usdhc0_m, 2016, 4, 1008),
> +	DEFINE_AXI_MASTER(usdhc1_m, 2017, 4, 1008),
> +
> +	/* NIC1 Slaves */
> +	DEFINE_AXI_SLAVE_EP(sram1, 2018, 8),
> +	DEFINE_AXI_SLAVE_EP(secure_ram, 2020, 4),
> +	DEFINE_AXI_SLAVE_EP(rom, 2023, 4), /* Also flexbus, gpu 2d and 3d */
> +	DEFINE_AXI_SLAVE_EP(m4xbar, 2024, 4),
> +
> +	/* AHB0 */
> +	DEFINE_AHB_SLAVE_EP(dma1, 8),
> +	DEFINE_AHB_SLAVE_EP(dmadesc1, 9),
> +	DEFINE_AHB_SLAVE_EP(rgpio2p, 15),
> +	DEFINE_AHB_SLAVE_EP(flexbus, 16),
> +	DEFINE_AHB_SLAVE_EP(sema42_1, 27),
> +	DEFINE_AHB_SLAVE_EP(dmamux1, 33),
> +	DEFINE_AHB_SLAVE_EP(mu_b, 34),
> +	DEFINE_AHB_SLAVE_EP(caam, 36),
> +	DEFINE_AHB_SLAVE_EP(tpm4, 37),
> +	DEFINE_AHB_SLAVE_EP(tpm5, 38),
> +	DEFINE_AHB_SLAVE_EP(lpit1, 39),
> +	DEFINE_AHB_SLAVE_EP(lpspi2, 41),
> +	DEFINE_AHB_SLAVE_EP(lpspi3, 42),
> +	DEFINE_AHB_SLAVE_EP(lpi2c4, 43),
> +	DEFINE_AHB_SLAVE_EP(lpi2c5, 44),
> +	DEFINE_AHB_SLAVE_EP(lpuart4, 45),
> +	DEFINE_AHB_SLAVE_EP(lpuart5, 46),
> +	DEFINE_AHB_SLAVE_EP(flexio1, 49),
> +	DEFINE_AHB_SLAVE_EP(usbotg1, 51),
> +	DEFINE_AHB_SLAVE_EP(usbotg2, 52),
> +	DEFINE_AHB_SLAVE_EP(usbphy, 53),
> +	DEFINE_AHB_SLAVE_EP(usbpl301, 54),
> +	DEFINE_AHB_SLAVE_EP(usdhc0, 55),
> +	DEFINE_AHB_SLAVE_EP(usdhc1, 56),
> +	DEFINE_AHB_SLAVE_EP(trgmux1, 59),
> +	DEFINE_AHB_SLAVE_EP(wdog1, 61),
> +	DEFINE_AHB_SLAVE_EP(scg1, 62),
> +	DEFINE_AHB_SLAVE_EP(pcc2, 63),
> +	DEFINE_AHB_SLAVE_EP(pmc1, 64),
> +	DEFINE_AHB_SLAVE_EP(cmc1, 65),
> +	DEFINE_AHB_SLAVE_EP(wdog2, 67),
> +
> +	DEFINE_AXI_SLAVE(ahb0, 2021, 4, 32,
> +			 8, 9, 15, 16, 27, 33, 34, 35, 36, 37, 38, 39, 41, 42,
> +			 43, 44, 45, 46, 49, 51, 52, 53, 54, 55, 56, 59, 61, 62,
> +			 63, 64, 65, 67),
> +
> +	/* AHB1 */
> +	DEFINE_AHB_SLAVE_EP(romc1, 116),
> +	DEFINE_AHB_SLAVE_EP(tpm6, 133),
> +	DEFINE_AHB_SLAVE_EP(tpm7, 134),
> +	DEFINE_AHB_SLAVE_EP(lpi2c6, 136),
> +	DEFINE_AHB_SLAVE_EP(lpi2c7, 137),
> +	DEFINE_AHB_SLAVE_EP(lpuart6, 138),
> +	DEFINE_AHB_SLAVE_EP(lpuart7, 139),
> +	DEFINE_AHB_SLAVE_EP(viu, 140),
> +	DEFINE_AHB_SLAVE_EP(dsi, 141),
> +	DEFINE_AHB_SLAVE_EP(lcdif, 142),
> +	DEFINE_AHB_SLAVE_EP(mmdc, 143),
> +	DEFINE_AHB_SLAVE_EP(iomuxc1, 144),
> +	DEFINE_AHB_SLAVE_EP(iomuxc_ddr, 145),
> +	DEFINE_AHB_SLAVE_EP(pctlc, 146),
> +	DEFINE_AHB_SLAVE_EP(pctld, 147),
> +	DEFINE_AHB_SLAVE_EP(pctle, 148),
> +	DEFINE_AHB_SLAVE_EP(pctlf, 149),
> +	DEFINE_AHB_SLAVE_EP(pcc3, 151),
> +
> +	DEFINE_AXI_SLAVE(ahb1, 2022, 4, 19,
> +			 116, 133, 134, 136, 137, 138, 139, 140, 141,
> +			 142, 143, 144, 145, 146, 147, 148, 149, 151),
> +
> +	/* NIC1 */
> +	DEFINE_AXI_INTERCONNECT(nic1_m, 1008, 8, false, &nic1_clock, 1, 1009),
> +	DEFINE_AXI_INTERCONNECT(nic1_s, 1009, 8, false, NULL, 7,
> +				2018, 1000, 2020, 2021, 2022, 2023, 2024),> +};
> +
> +static struct imx7ulp_icc_desc icc_desc = {
> +	.nodes = (struct imx7ulp_icc_node *)&imx7ulp_nodes,
> +	.num_nodes = ARRAY_SIZE(imx7ulp_nodes),
> +};
> +
> +static int imx7ulp_icc_aggregate(struct icc_node *node, u32 avg_bw,
> +				  u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +	*agg_avg += avg_bw;
> +	*agg_peak = max(*agg_peak, peak_bw);
> +
> +	return 0;
> +}
> +
> +static int imx7ulp_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	int ret;
> +	struct imx7ulp_icc_node *node;
> +	struct imx7ulp_icc_desc *desc = src->provider->data;
> +
> +	/* If node has a clock, compute the new rate */
> +	node = src->data;
> +	if (node->bus_clk) {
> +		u64 rate;
> +		struct imx7ulp_bus_clock *bus_clk = node->bus_clk;
> +
> +		rate = (src->peak_bw / node->buswidth) * 1000;

Maybe use do_div().

> +		rate = clk_round_rate(bus_clk->clk, rate);
> +		if (rate != bus_clk->rate) {
> +			dev_dbg(desc->dev, "%s: new rate = %llu\n",
> +				bus_clk->name, rate);
> +			bus_clk->rate = rate;
> +		}
> +	}
> +
> +	/*
> +	 * If the node is an endpoint, update the clock rate of nic0 and nic1
> +	 * nodes. nic1 clock derives from nic0, so we usually have to update
> +	 * both of them even if bandwidth changed only for one of the
> +	 * interconnect.
> +	 */
> +	node = dst->data;
> +	if (node->ep) {
> +		struct imx7ulp_bus_clock *nic0_clk = desc->nic0;
> +		struct imx7ulp_bus_clock *nic1_clk = desc->nic1;
> +
> +		if (nic1_clk->rate > nic0_clk->rate)
> +			nic0_clk->rate = nic1_clk->rate;
> +
> +		if (clk_get_rate(nic0_clk->clk) != nic0_clk->rate) {
> +			dev_dbg(desc->dev, "%s: apply rate = %llu\n",
> +				nic0_clk->name, nic0_clk->rate);
> +			ret = clk_set_rate(nic0_clk->clk, nic0_clk->rate);
> +			if (ret)
> +				dev_err(desc->dev, "Failed to set clock: %d\n",
> +					ret);
> +		}
> +
> +		if (clk_get_rate(nic1_clk->clk) != nic1_clk->rate) {
> +			dev_dbg(desc->dev, "%s: apply rate = %llu\n",
> +				nic1_clk->name, nic1_clk->rate);
> +			ret = clk_set_rate(nic1_clk->clk, nic1_clk->rate);
> +			if (ret)
> +				dev_err(desc->dev, "Failed to set clock: %d\n",
> +					ret);
> +		}
> +	}
> +
> +	return 0;

Just f.y.i, i recently introduced another patch that reverts to the
settings to the previous configuration if any of the requests fail, so
you can also return errors here (if it makes sense to do so on this
platform).

> +}
> +
> +static int imx7ulp_probe(struct platform_device *pdev)
> +{
> +	struct imx7ulp_icc_desc *desc = &icc_desc;
> +	struct icc_provider *provider;
> +	size_t i;
> +	int ret;
> +
> +	desc->dev = &pdev->dev;
> +	desc->nic0 = &nic0_clock;
> +	desc->nic1 = &nic1_clock;
> +
> +	provider = devm_kzalloc(&pdev->dev, sizeof(*provider), GFP_KERNEL);
> +	provider->set = imx7ulp_icc_set;
> +	provider->aggregate = imx7ulp_icc_aggregate;

If you want to use DT, you will need to put the endpoint IDs in some
header file and implement the xlate() function or use the generic
of_icc_xlate_onecell().

> +	INIT_LIST_HEAD(&provider->nodes);
> +	provider->data = desc;
> +
> +	ret = icc_provider_add(provider);
> +	if (ret) {
> +		dev_err(&pdev->dev, "error adding interconnect provider\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < desc->num_nodes; i++) {
> +		struct icc_node *node;
> +		int ret;
> +		size_t j;
> +
> +		if (desc->nodes[i].bus_clk) {
> +			struct imx7ulp_bus_clock *bus_clk;
> +
> +			bus_clk = desc->nodes[i].bus_clk;
> +			bus_clk->clk = devm_clk_get(&pdev->dev, bus_clk->name);
> +			if (IS_ERR(bus_clk->clk)) {
> +				dev_err(&pdev->dev,
> +					"Failed to get clock %s: %d\n",
> +					bus_clk->name, PTR_ERR(bus_clk->clk));
> +				ret = PTR_ERR(bus_clk->clk);
> +				goto err;
> +			}
> +
> +			ret = clk_prepare_enable(bus_clk->clk);
> +			if (ret) {
> +				dev_err(&pdev->dev,
> +					"error enabling clock: %s %d\n",
> +					bus_clk->name, ret);
> +				goto err;
> +			}
> +		}
> +
> +		node = icc_node_create(desc->nodes[i].id);
> +		if (IS_ERR(node)) {
> +			ret = PTR_ERR(node);
> +			dev_err(&pdev->dev, "Failed to create node %s\n",
> +				desc->nodes[i].name);
> +			goto err;
> +		}
> +
> +		node->name = desc->nodes[i].name;
> +		node->data = &desc->nodes[i];
> +		icc_node_add(node, provider);
> +
> +		dev_dbg(&pdev->dev, "registered node %p %s %d\n", node,
> +			desc->nodes[i].name, node->id);
> +
> +		for (j = 0; j < desc->nodes[i].num_links; j++)
> +			if (desc->nodes[i].links[j])
> +				icc_link_create(node, desc->nodes[i].links[j]);
> +	}
> +
> +	platform_set_drvdata(pdev, provider);
> +
> +	return 0;
> +err:
> +	icc_provider_del(provider);

First delete the nodes (if any) and then the provider.

> +	return ret;
> +}
> +
> +static int imx7ulp_remove(struct platform_device *pdev)
> +{
> +	struct icc_provider *provider = platform_get_drvdata(pdev);
> +
> +	icc_provider_del(provider);

Ditto.

> +	return 0;
> +}
> +
> +static const struct of_device_id imx7ulp_of_match[] = {
> +	{ .compatible = "fsl,imx7ulp-icc" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, imx7ulp_of_match);
> +
> +static struct platform_driver imx7ulp_driver = {
> +	.probe = imx7ulp_probe,
> +	.remove = imx7ulp_remove,
> +	.driver = {
> +		.name = "imx7ulp-icc",
> +		.of_match_table = imx7ulp_of_match,
> +	},
> +};
> +module_platform_driver(imx7ulp_driver);

Please use builtin_platform_driver if it can't be a module.

Thank you for working on this! I am expecting the next version.

BR,
Georgi
