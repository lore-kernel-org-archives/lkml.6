Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370AEECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C5821480
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLIhekn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C5821480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeJRDmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbeJRDmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:42:06 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF6D82086E;
        Wed, 17 Oct 2018 19:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539805493;
        bh=Wj/Uqtu1elTDzgvfPfD7xo1Oklxr7ThmW4O50rSVwr0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=iLIhekn2tGtl6b+5tWc2p2OVnLQc+yGAB7IBp+XnqZQMLAdlSg/7TXyBMHhGhihIw
         mN33rhL2ZyIT///ls8hgyQrkvgwgACOFyrPZCuFtvOaXdGLUSuoon68zyv5eoMMwkO
         Rn5fvMvycYUGCx8c17Rsi2LZbdiPda6q8krakPm8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1537785597-26499-6-git-send-email-abel.vesa@nxp.com>
Cc:     linux-imx@nxp.com, Abel Vesa <abelvesa@linux.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-6-git-send-email-abel.vesa@nxp.com>
Message-ID: <153980549223.5275.1496899374465535150@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v9 5/5] clk: imx: add clock driver for i.MX8MQ CCM
Date:   Wed, 17 Oct 2018 12:44:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-09-24 03:39:57)
> From: Lucas Stach <l.stach@pengutronix.de>
> =

> Add driver for the Clock Control Module found on i.MX8MQ.
> =

> This is largely based on the downstream driver from Anson Huang and
> Bai Ping at NXP, plus the imx composite clock from Abel Vesa at NXP,
> with only some small adaptions to mainline from me.

Can you point to the downstream driver so we can know what small
adaptations were made.

> =

> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/Makefile     |   1 +
>  drivers/clk/imx/clk-imx8mq.c | 602 +++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/clk/imx/clk.h        |  36 +++
>  3 files changed, 639 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-imx8mq.c
> =

> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 4fabb0a..64e695c 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -30,3 +30,4 @@ obj-$(CONFIG_SOC_IMX6SX) +=3D clk-imx6sx.o
>  obj-$(CONFIG_SOC_IMX6UL) +=3D clk-imx6ul.o
>  obj-$(CONFIG_SOC_IMX7D)  +=3D clk-imx7d.o
>  obj-$(CONFIG_SOC_VF610)  +=3D clk-vf610.o
> +obj-$(CONFIG_SOC_IMX8MQ) +=3D clk-imx8mq.o

Please try to keep this alphabetical on CONFIG symbol.

> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> new file mode 100644
> index 0000000..aadb523
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -0,0 +1,602 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018 NXP.
> + * Copyright (C) 2017 Pengutronix, Lucas Stach <kernel@pengutronix.de>
> + */
> +
> +#include <dt-bindings/clock/imx8mq-clock.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>

Are these two includes used?

> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/types.h>
> +
> +#include "clk.h"
> +
> +static u32 share_count_sai1;
> +static u32 share_count_sai2;
> +static u32 share_count_sai3;
> +static u32 share_count_sai4;
> +static u32 share_count_sai5;
> +static u32 share_count_sai6;
> +static u32 share_count_dcss;
> +static u32 share_count_nand;
> +
[...]
> +
> +static const char *imx8mq_ecspi3_sels[] =3D {"osc_25m", "sys2_pll_200m",=
 "sys1_pll_40m", "sys1_pll_160m",
> +                                          "sys1_pll_800m", "sys3_pll2_ou=
t", "sys2_pll_250m", "audio_pll2_out", };
> +static const char *imx8mq_dram_core_sels[] =3D {"dram_pll_out", "dram_al=
t_root", };
> +
> +static const char *imx8mq_clko2_sels[] =3D {"osc_25m", "sys2_pll_200m", =
"sys1_pll_400m", "sys2_pll_166m", "audio_pll1_out",
> +                                        "video_pll1_out", "ckil", };
> +
> +static struct clk_onecell_data clk_data;
> +
> +static void __init imx8mq_clocks_init(struct device_node *ccm_node)
> +{
> +       struct device_node *np;
> +       void __iomem *base;
> +       int i;
> +
> +       clks[IMX8MQ_CLK_DUMMY] =3D imx_clk_fixed("dummy", 0);
> +       clks[IMX8MQ_CLK_32K] =3D of_clk_get_by_name(ccm_node, "ckil");
> +       clks[IMX8MQ_CLK_25M] =3D of_clk_get_by_name(ccm_node, "osc_25m");
> +       clks[IMX8MQ_CLK_27M] =3D of_clk_get_by_name(ccm_node, "osc_27m");
> +       clks[IMX8MQ_CLK_EXT1] =3D of_clk_get_by_name(ccm_node, "clk_ext1"=
);
> +       clks[IMX8MQ_CLK_EXT2] =3D of_clk_get_by_name(ccm_node, "clk_ext2"=
);
> +       clks[IMX8MQ_CLK_EXT3] =3D of_clk_get_by_name(ccm_node, "clk_ext3"=
);
> +       clks[IMX8MQ_CLK_EXT4] =3D of_clk_get_by_name(ccm_node, "clk_ext4"=
);
> +
> +       np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop");
> +       base =3D of_iomap(np, 0);
> +       WARN_ON(!base);

And if that fails? return without continuing?

> +
> +       clks[IMX8MQ_ARM_PLL_REF_SEL] =3D imx_clk_mux("arm_pll_ref_sel", b=
ase + 0x28, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_GPU_PLL_REF_SEL] =3D imx_clk_mux("gpu_pll_ref_sel", b=
ase + 0x18, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_VPU_PLL_REF_SEL] =3D imx_clk_mux("vpu_pll_ref_sel", b=
ase + 0x20, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_AUDIO_PLL1_REF_SEL] =3D imx_clk_mux("audio_pll1_ref_s=
el", base + 0x0, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
[..]
> +       clks[IMX8MQ_CLK_DSI_CORE] =3D imx_clk_composite("dsi_core", imx8m=
q_dsi_core_sels, base + 0xbb00);
> +       clks[IMX8MQ_CLK_DSI_PHY_REF] =3D imx_clk_composite("dsi_phy_ref",=
 imx8mq_dsi_phy_sels, base + 0xbb80);
> +       clks[IMX8MQ_CLK_DSI_DBI] =3D imx_clk_composite("dsi_dbi", imx8mq_=
dsi_dbi_sels, base + 0xbc00);
> +       clks[IMX8MQ_CLK_DSI_ESC] =3D imx_clk_composite("dsi_esc", imx8mq_=
dsi_esc_sels, base + 0xbc80);
> +       clks[IMX8MQ_CLK_DSI_AHB] =3D imx_clk_composite("dsi_ahb", imx8mq_=
dsi_ahb_sels, base + 0x9200);
> +       clks[IMX8MQ_CLK_CSI1_CORE] =3D imx_clk_composite("csi1_core", imx=
8mq_csi1_core_sels, base + 0xbd00);
> +       clks[IMX8MQ_CLK_CSI1_PHY_REF] =3D imx_clk_composite("csi1_phy_ref=
", imx8mq_csi1_phy_sels, base + 0xbd80);
> +       clks[IMX8MQ_CLK_CSI1_ESC] =3D imx_clk_composite("csi1_esc", imx8m=
q_csi1_esc_sels, base + 0xbe00);
> +       clks[IMX8MQ_CLK_CSI2_CORE] =3D imx_clk_composite("csi2_core", imx=
8mq_csi2_core_sels, base + 0xbe80);
> +       clks[IMX8MQ_CLK_CSI2_PHY_REF] =3D imx_clk_composite("csi2_phy_ref=
", imx8mq_csi2_phy_sels, base + 0xbf00);
> +       clks[IMX8MQ_CLK_CSI2_ESC] =3D imx_clk_composite("csi2_esc", imx8m=
q_csi2_esc_sels, base + 0xbf80);
> +       clks[IMX8MQ_CLK_PCIE2_CTRL] =3D imx_clk_composite("pcie2_ctrl", i=
mx8mq_pcie2_ctrl_sels, base + 0xc000);
> +       clks[IMX8MQ_CLK_PCIE2_PHY] =3D imx_clk_composite("pcie2_phy", imx=
8mq_pcie2_phy_sels, base + 0xc080);
> +       clks[IMX8MQ_CLK_PCIE2_AUX] =3D imx_clk_composite("pcie2_aux", imx=
8mq_pcie2_aux_sels, base + 0xc100);
> +       clks[IMX8MQ_CLK_ECSPI3] =3D imx_clk_composite("ecspi3", imx8mq_ec=
spi3_sels, base + 0xc180);
> +
> +       /*FIXME, the doc is not ready now */

What does this mean?

> +       clks[IMX8MQ_CLK_ECSPI1_ROOT] =3D imx_clk_gate4("ecspi1_root_clk",=
 "ecspi1", base + 0x4070, 0);
> +       clks[IMX8MQ_CLK_ECSPI2_ROOT] =3D imx_clk_gate4("ecspi2_root_clk",=
 "ecspi2", base + 0x4080, 0);
> +       clks[IMX8MQ_CLK_ECSPI3_ROOT] =3D imx_clk_gate4("ecspi3_root_clk",=
 "ecspi3", base + 0x4090, 0);
> +       clks[IMX8MQ_CLK_ENET1_ROOT] =3D imx_clk_gate4("enet1_root_clk", "=
enet_axi", base + 0x40a0, 0);
> +       clks[IMX8MQ_CLK_GPT1_ROOT] =3D imx_clk_gate4("gpt1_root_clk", "gp=
t1", base + 0x4100, 0);
[...]
> +
> +       clks[IMX8MQ_GPT_3M_CLK] =3D imx_clk_fixed_factor("gpt_3m", "osc_2=
5m", 1, 8);
> +       clks[IMX8MQ_CLK_DRAM_ALT_ROOT] =3D imx_clk_fixed_factor("dram_alt=
_root", "dram_alt", 1, 4);
> +
> +       for (i =3D 0; i < IMX8MQ_CLK_END; i++)
> +               if (IS_ERR(clks[i]))
> +                       pr_err("i.MX8mq clk %u register failed with %ld\n=
",
> +                              i, PTR_ERR(clks[i]));
> +
> +       clk_data.clks =3D clks;
> +       clk_data.clk_num =3D ARRAY_SIZE(clks);
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);

Any chance to move to using clk_hw based provider and clk registration
APIs?

> +
> +       clk_set_parent(clks[IMX8MQ_CLK_AHB], clks[IMX8MQ_SYS1_PLL_133M]);
> +       clk_set_parent(clks[IMX8MQ_CLK_NAND_USDHC_BUS], clks[IMX8MQ_SYS1_=
PLL_266M]);
> +       clk_set_parent(clks[IMX8MQ_CLK_AUDIO_AHB], clks[IMX8MQ_SYS2_PLL_5=
00M]);
> +
> +       /* config video_pll1 clock */
> +       clk_set_parent(clks[IMX8MQ_VIDEO_PLL1_REF_SEL], clks[IMX8MQ_CLK_2=
7M]);
> +       clk_set_rate(clks[IMX8MQ_VIDEO_PLL1], 593999999);
> +
> +       /* increase NOC clock to achieve best DDR access performance */
> +       clk_set_rate(clks[IMX8MQ_CLK_NOC], clk_get_rate(clks[IMX8MQ_SYS1_=
PLL_800M]));
> +
> +       /* set pcie root's parent clk source */
> +       clk_set_parent(clks[IMX8MQ_CLK_PCIE1_CTRL], clks[IMX8MQ_SYS2_PLL_=
250M]);
> +       clk_set_parent(clks[IMX8MQ_CLK_PCIE1_PHY], clks[IMX8MQ_SYS2_PLL_1=
00M]);
> +       clk_set_parent(clks[IMX8MQ_CLK_PCIE2_CTRL], clks[IMX8MQ_SYS2_PLL_=
250M]);
> +       clk_set_parent(clks[IMX8MQ_CLK_PCIE2_PHY], clks[IMX8MQ_SYS2_PLL_1=
00M]);
> +
> +       clk_set_parent(clks[IMX8MQ_CLK_CSI1_CORE], clks[IMX8MQ_SYS1_PLL_2=
66M]);
> +       clk_set_parent(clks[IMX8MQ_CLK_CSI1_PHY_REF], clks[IMX8MQ_SYS2_PL=
L_1000M]);
> +       clk_set_parent(clks[IMX8MQ_CLK_CSI1_ESC], clks[IMX8MQ_SYS1_PLL_80=
0M]);
> +       clk_set_parent(clks[IMX8MQ_CLK_CSI2_CORE], clks[IMX8MQ_SYS1_PLL_2=
66M]);
> +       clk_set_parent(clks[IMX8MQ_CLK_CSI2_PHY_REF], clks[IMX8MQ_SYS2_PL=
L_1000M]);
> +       clk_set_parent(clks[IMX8MQ_CLK_CSI2_ESC], clks[IMX8MQ_SYS1_PLL_80=
0M]);

Can this be done with assigned clock parents and assigned clock rates?

> +}
> +
> +CLK_OF_DECLARE(imx8mq, "fsl,imx8mq-ccm", imx8mq_clocks_init);

Can you please add a comment indicating why this can't be done with a
platform driver, or convert this to be a platform driver?

