Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA52C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF4D26FE3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF4D26FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933827AbeF1HAj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:00:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35710 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752642AbeF1HAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:00:38 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C7A9020703; Thu, 28 Jun 2018 09:00:35 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5801B203EC;
        Thu, 28 Jun 2018 09:00:35 +0200 (CEST)
Date:   Thu, 28 Jun 2018 09:00:34 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-mtd@lists.infradead.org>,
        Liang Yang <liang.yang@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Jian Hu <jian.hu@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
Message-ID: <20180628090034.0637a062@xps13>
In-Reply-To: <7ha7rfiz3c.fsf@baylibre.com>
References: <20180613161314.14894-1-yixun.lan@amlogic.com>
        <20180613161314.14894-3-yixun.lan@amlogic.com>
        <20180624213844.2207ca6f@bbrezillon>
        <7ha7rfiz3c.fsf@baylibre.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Wed, 27 Jun 2018 16:33:43 -0700, Kevin Hilman <khilman@baylibre.com>
wrote:

> Hi Boris,
> 
> Boris Brezillon <boris.brezillon@bootlin.com> writes:
> 
> > Hi Yixun,
> >
> > On Wed, 13 Jun 2018 16:13:14 +0000
> > Yixun Lan <yixun.lan@amlogic.com> wrote:
> >  
> >> From: Liang Yang <liang.yang@amlogic.com>
> >> 
> >> Add initial support for the Amlogic NAND flash controller which found
> >> in the Meson-GXBB/GXL/AXG SoCs.
> >> 
> >> Singed-off-by: Liang Yang <liang.yang@amlogic.com>
> >> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> >> ---
> >>  drivers/mtd/nand/raw/Kconfig      |    8 +
> >>  drivers/mtd/nand/raw/Makefile     |    3 +
> >>  drivers/mtd/nand/raw/meson_nand.c | 1422 +++++++++++++++++++++++++++++
> >>  3 files changed, 1433 insertions(+)
> >>  create mode 100644 drivers/mtd/nand/raw/meson_nand.c  
> >
> > Can you run checkpatch.pl --strict and fix the coding style issues?
> >  
> >> 
> >> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> >> index 19a2b283fbbe..b3c17a3ca8f4 100644
> >> --- a/drivers/mtd/nand/raw/Kconfig
> >> +++ b/drivers/mtd/nand/raw/Kconfig
> >> @@ -534,4 +534,12 @@ config MTD_NAND_MTK
> >>  	  Enables support for NAND controller on MTK SoCs.
> >>  	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
> >>  
> >> +config MTD_NAND_MESON
> >> +	tristate "Support for NAND flash controller on Amlogic's Meson SoCs"
> >> +	depends on ARCH_MESON || COMPILE_TEST
> >> +	select COMMON_CLK_REGMAP_MESON
> >> +	select MFD_SYSCON
> >> +	help
> >> +	  Enables support for NAND controller on Amlogic's Meson SoCs.
> >> +
> >>  endif # MTD_NAND
> >> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> >> index 165b7ef9e9a1..cdf6162f38c3 100644
> >> --- a/drivers/mtd/nand/raw/Makefile
> >> +++ b/drivers/mtd/nand/raw/Makefile
> >> @@ -1,5 +1,7 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  
> >> +ccflags-$(CONFIG_MTD_NAND_MESON) += -I$(srctree)/drivers/clk/meson  
> >
> > Please don't do that. If you need to expose common regs, put them
> > in include/linux/soc/meson/. I'm also not sure why you need to access
> > the clk regs directly. Why can't you expose the MMC/NAND clk as a clk
> > provider whose driver would be placed in drivers/clk and which would use
> > the mmc syscon. This way the same clk driver could be used for both
> > MMC and NAND clk indifferently, and the NAND driver would be much
> > simpler.  
> 
> [...]
> 
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const char * sd_emmc_ext_clk0_parent_names[MUX_CLK_NUM_PARENTS];
> >> +
> >> +static struct clk_regmap sd_emmc_c_ext_clk0_sel = {
> >> +	.data = &(struct clk_regmap_mux_data){
> >> +		.offset = SD_EMMC_CLOCK,
> >> +		.mask = 0x3,
> >> +		.shift = 6,
> >> +	},
> >> +	.hw.init = &(struct clk_init_data) {
> >> +		.name = "sd_emmc_c_nand_clk_mux",
> >> +		.ops = &clk_regmap_mux_ops,
> >> +		.parent_names = sd_emmc_ext_clk0_parent_names,
> >> +		.num_parents = ARRAY_SIZE(sd_emmc_ext_clk0_parent_names),
> >> +		.flags = CLK_SET_RATE_PARENT,
> >> +	},
> >> +};
> >> +
> >> +static struct clk_regmap sd_emmc_c_ext_clk0_div = {
> >> +	.data = &(struct clk_regmap_div_data){
> >> +		.offset = SD_EMMC_CLOCK,
> >> +		.shift = 0,
> >> +		.width = 6,
> >> +		.flags = CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
> >> +	},
> >> +	.hw.init = &(struct clk_init_data) {
> >> +		.name = "sd_emmc_c_nand_clk_div",
> >> +		.ops = &clk_regmap_divider_ops,
> >> +		.parent_names = (const char *[]){ "sd_emmc_c_nand_clk_mux" },
> >> +		.num_parents = 1,
> >> +		.flags = CLK_SET_RATE_PARENT,
> >> +	},
> >> +};
> >> +
> >> +static int meson_nfc_clk_init(struct meson_nfc *nfc)
> >> +{
> >> +	struct clk_regmap *mux = &sd_emmc_c_ext_clk0_sel;
> >> +	struct clk_regmap *div = &sd_emmc_c_ext_clk0_div;
> >> +	struct clk *clk;
> >> +	int i, ret;
> >> +
> >> +	/* request core clock */
> >> +	nfc->core_clk = devm_clk_get(nfc->dev, "core");
> >> +	if (IS_ERR(nfc->core_clk)) {
> >> +		dev_err(nfc->dev, "failed to get core clk\n");
> >> +		return PTR_ERR(nfc->core_clk);
> >> +	}
> >> +
> >> +	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
> >> +	regmap_update_bits(nfc->reg_clk, 0,
> >> +			CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK,
> >> +			CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK);
> >> +
> >> +	/* get the mux parents */
> >> +	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
> >> +		char name[16];
> >> +
> >> +		snprintf(name, sizeof(name), "clkin%d", i);
> >> +		clk = devm_clk_get(nfc->dev, name);
> >> +		if (IS_ERR(clk)) {
> >> +			if (clk != ERR_PTR(-EPROBE_DEFER))
> >> +				dev_err(nfc->dev, "Missing clock %s\n", name);
> >> +			return PTR_ERR(clk);
> >> +		}
> >> +
> >> +		sd_emmc_ext_clk0_parent_names[i] = __clk_get_name(clk);
> >> +	}
> >> +
> >> +	mux->map = nfc->reg_clk;
> >> +	clk = devm_clk_register(nfc->dev, &mux->hw);
> >> +	if (WARN_ON(IS_ERR(clk)))
> >> +		return PTR_ERR(clk);
> >> +
> >> +	div->map = nfc->reg_clk;
> >> +	nfc->device_clk = devm_clk_register(nfc->dev, &div->hw);
> >> +	if (WARN_ON(IS_ERR(nfc->device_clk)))
> >> +		return PTR_ERR(nfc->device_clk);
> >> +
> >> +	ret = clk_prepare_enable(nfc->core_clk);
> >> +	if (ret) {
> >> +		dev_err(nfc->dev, "failed to enable core clk\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = clk_prepare_enable(nfc->device_clk);
> >> +	if (ret) {
> >> +		dev_err(nfc->dev, "failed to enable device clk\n");
> >> +		clk_disable_unprepare(nfc->core_clk);
> >> +		return ret;
> >> +	}
> >> +
> >> +	return 0;
> >> +}  
> >
> >
> > As said above, I don't like having a clk driver here, especially since
> > the registers you're accessing are not part of the NAND controller
> > registers. Please try to create a driver in drivers/clk/ for that.  
> 
> We went back and forth on this one on some off-list reviews.
> 
> Had we known that the NAND controller was (re)using the clock registers
> internal to the MMC IP block from the beginning, we would have written a
> clock provider in drivers/clk for this, and shared it.
> 
> However, when I wrote the MMC driver[1] (already upstream) along with
> the bindings[2], we did not fathom that the internal mux and divider
> would be "borrowed" by another device. :(
> 
> We only recently found out that the NAND controller "borrows" one of the
> MMC clocks, whose registers are inside the MMC range.  Taking the clock
> out of the MMC driver and into its own clock-provider implies redoing
> the MMC driver, as well as its bindings, which we wanted to avoid
> (especially the binding changes.)
> 
> We (I can take the blame) decided that since the MMC and NAND are
> mutually exclusive (they also share pins), that allowing NAND to reuse
> the MMC range would be a good compromise.  The DT still accurately
> describes the hardware, but we don't have to throw a large wrench into
> the DT bindings just for a newly discovered shared clock.
> 
> I agree, it's not the prettiest thing, but when we cannot know the full
> details of the hardware when we start, sometimes we end up in a bit of a
> mess that requires some compromise.

I totally understand your situation but as MMC and NAND are mutually
exclusive, how is this a problem to have a dedicated clock driver used
only by the NAND controller (as maybe a first step)? I mean, if you
don't change the MMC bindings, then the MMC driver will still use its
own 'local' clock driver, right? I don't know if you can have two
nodes reserving the same address range though.


> 
> Kevin
> 
> [1] drivers/mmc/host/meson-gx-mmc.c
> [2] Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt                                                                                                       


Thanks,
Miquèl
