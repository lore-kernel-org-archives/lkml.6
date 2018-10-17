Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AECECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A8C214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7WJNm4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A8C214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeJRBwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbeJRBwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:52:09 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99B772148E;
        Wed, 17 Oct 2018 17:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539798919;
        bh=oKCeicnOcOt2y88Klf2TYs6tqbYIZqPHify4wuVezYs=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=c7WJNm4fXy3ayPgdDAuyUMb4gDttSYAmo7k1MpgtMrvsvA8qAc3ENrAopIY25mG5c
         nos/xDHDCpw08gGSUQ0LCSB2Z+hqerew/eqFjv/O/HD9eT8n7s+7sUwZ2sLV2S4c23
         CTyKH+hF0e1T/FtTVT1xWn+qjg5oBcZIG4k12zyo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Abel Vesa <abel.vesa@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1539157520-25081-6-git-send-email-abel.vesa@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
References: <1539157520-25081-1-git-send-email-abel.vesa@nxp.com>
 <1539157520-25081-6-git-send-email-abel.vesa@nxp.com>
Message-ID: <153979891894.5275.8347445225422393489@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v11 5/5] clk: imx: add clock driver for i.MX8MQ CCM
Date:   Wed, 17 Oct 2018 10:55:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-10-10 00:45:20)
> From: Lucas Stach <l.stach@pengutronix.de>
> =

> Add driver for the Clock Control Module found on i.MX8MQ.
> =

> This is largely based on the downstream driver from Anson Huang and
> Bai Ping at NXP, plus the imx composite clock from Abel Vesa at NXP,
> with only some small adaptions to mainline from me.

What are those small adapations? Is there a link to the downstream
driver somewhere where we can compare?

> =

> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> new file mode 100644
> index 0000000..cef080a
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
> +static struct clk *clks[IMX8MQ_CLK_END];
> +
> +static const char *pll_ref_sels[] =3D { "osc_25m", "osc_27m", "dummy", "=
dummy", };
> +static const char *arm_pll_bypass_sels[] =3D {"arm_pll", "arm_pll_ref_se=
l", };
> +static const char *gpu_pll_bypass_sels[] =3D {"gpu_pll", "gpu_pll_ref_se=
l", };
> +static const char *vpu_pll_bypass_sels[] =3D {"vpu_pll", "vpu_pll_ref_se=
l", };
> +static const char *audio_pll1_bypass_sels[] =3D {"audio_pll1", "audio_pl=
l1_ref_sel", };
> +static const char *audio_pll2_bypass_sels[] =3D {"audio_pll2", "audio_pl=
l2_ref_sel", };
> +static const char *video_pll1_bypass_sels[] =3D {"video_pll1", "video_pl=
l1_ref_sel", };
> +
> +static const char *sys1_pll1_out_sels[] =3D {"sys1_pll1", "sys1_pll1_ref=
_sel", };
> +static const char *sys2_pll1_out_sels[] =3D {"sys2_pll1", "sys1_pll1_ref=
_sel", };
> +static const char *sys3_pll1_out_sels[] =3D {"sys3_pll1", "sys3_pll1_ref=
_sel", };
> +static const char *dram_pll1_out_sels[] =3D {"dram_pll1", "dram_pll1_ref=
_sel", };
> +
> +static const char *sys1_pll2_out_sels[] =3D {"sys1_pll2_div", "sys1_pll1=
_ref_sel", };
> +static const char *sys2_pll2_out_sels[] =3D {"sys2_pll2_div", "sys2_pll1=
_ref_sel", };
> +static const char *sys3_pll2_out_sels[] =3D {"sys3_pll2_div", "sys2_pll1=
_ref_sel", };
> +static const char *dram_pll2_out_sels[] =3D {"dram_pll2_div", "dram_pll1=
_ref_sel", };
> +
> +/* CCM ROOT */
> +static const char *imx8mq_a53_sels[] =3D {"osc_25m", "arm_pll_out", "sys=
2_pll_500m", "sys2_pll_1000m",
> +                                       "sys1_pll_800m", "sys1_pll_400m",=
 "audio_pll1_out", "sys3_pll2_out", };
> +
> +static const char *imx8mq_vpu_sels[] =3D {"osc_25m", "arm_pll_out", "sys=
2_pll_500m", "sys2_pll_1000m",
> +                                       "sys1_pll_800m", "sys1_pll_400m",=
 "audio_pll1_out", "vpu_pll_out", };
> +
> +static const char *imx8mq_gpu_core_sels[] =3D {"osc_25m", "gpu_pll_out",=
 "sys1_pll_800m", "sys3_pll2_out",
> +                                            "sys2_pll_1000m", "audio_pll=
1_out", "video_pll1_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_gpu_shader_sels[] =3D {"osc_25m", "gpu_pll_out=
", "sys1_pll_800m", "sys3_pll2_out",
> +                                              "sys2_pll_1000m", "audio_p=
ll1_out", "video_pll1_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_main_axi_sels[] =3D {"osc_25m", "sys2_pll_333m=
", "sys1_pll_800m", "sys2_pll_250m",
> +                                            "sys2_pll_1000m", "audio_pll=
1_out", "video_pll1_out", "sys1_pll_100m",};
> +
> +static const char *imx8mq_enet_axi_sels[] =3D {"osc_25m", "sys1_pll_266m=
", "sys1_pll_800m", "sys2_pll_250m",
> +                                            "sys2_pll_200m", "audio_pll1=
_out", "video_pll1_out", "sys3_pll2_out", };
> +
> +static const char *imx8mq_nand_usdhc_sels[] =3D {"osc_25m", "sys1_pll_26=
6m", "sys1_pll_800m", "sys2_pll_200m",
> +                                              "sys1_pll_133m", "sys3_pll=
2_out", "sys2_pll_250m", "audio_pll1_out", };
> +
> +static const char *imx8mq_vpu_bus_sels[] =3D {"osc_25m", "sys1_pll_800m"=
, "vpu_pll_out", "audio_pll2_out", "sys3_pll2_out", "sys2_pll_1000m", "sys2=
_pll_200m", "sys1_pll_100m", };
> +
> +static const char *imx8mq_disp_axi_sels[] =3D {"osc_25m", "sys2_pll_125m=
", "sys1_pll_800m", "sys3_pll2_out", "sys1_pll_400m", "audio_pll2_out", "cl=
k_ext1", "clk_ext4", };
> +
> +static const char *imx8mq_disp_apb_sels[] =3D {"osc_25m", "sys2_pll_125m=
", "sys1_pll_800m", "sys3_pll2_out",
> +                                            "sys1_pll_40m", "audio_pll2_=
out", "clk_ext1", "clk_ext3", };
> +
> +static const char *imx8mq_disp_rtrm_sels[] =3D {"osc_25m", "sys1_pll_800=
m", "sys2_pll_200m", "sys1_pll_400m",
> +                                             "audio_pll1_out", "video_pl=
l1_out", "clk_ext2", "clk_ext3", };
> +
> +static const char *imx8mq_usb_bus_sels[] =3D {"osc_25m", "sys2_pll_500m"=
, "sys1_pll_800m", "sys2_pll_100m",
> +                                           "sys2_pll_200m", "clk_ext2", =
"clk_ext4", "audio_pll2_out", };
> +
> +static const char *imx8mq_gpu_axi_sels[] =3D {"osc_25m", "sys1_pll_800m"=
, "gpu_pll_out", "sys3_pll2_out", "sys2_pll_1000m",
> +                                           "audio_pll1_out", "video_pll1=
_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_gpu_ahb_sels[] =3D {"osc_25m", "sys1_pll_800m"=
, "gpu_pll_out", "sys3_pll2_out", "sys2_pll_1000m",
> +                                           "audio_pll1_out", "video_pll1=
_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_noc_sels[] =3D {"osc_25m", "sys1_pll_800m", "s=
ys3_pll2_out", "sys2_pll_1000m", "sys2_pll_500m",
> +                                       "audio_pll1_out", "video_pll1_out=
", "audio_pll2_out", };
> +
> +static const char *imx8mq_noc_apb_sels[] =3D {"osc_25m", "sys1_pll_400m"=
, "sys3_pll2_out", "sys2_pll_333m", "sys2_pll_200m",
> +                                           "sys1_pll_800m", "audio_pll1_=
out", "video_pll1_out", };
> +
> +static const char *imx8mq_ahb_sels[] =3D {"osc_25m", "sys1_pll_133m", "s=
ys1_pll_800m", "sys1_pll_400m",
> +                                       "sys2_pll_125m", "sys3_pll2_out",=
 "audio_pll1_out", "video_pll1_out", };
> +
> +static const char *imx8mq_audio_ahb_sels[] =3D {"osc_25m", "sys2_pll_500=
m", "sys1_pll_800m", "sys2_pll_1000m",
> +                                                 "sys2_pll_166m", "sys3_=
pll2_out", "audio_pll1_out", "video_pll1_out", };
> +
> +static const char *imx8mq_dsi_ahb_sels[] =3D {"osc_25m", "sys2_pll_100m"=
, "sys1_pll_80m", "sys1_pll_800m",
> +                                               "sys2_pll_1000m", "sys3_p=
ll2_out", "clk_ext3", "audio_pll2_out"};
> +
> +static const char *imx8mq_dram_alt_sels[] =3D {"osc_25m", "sys1_pll_800m=
", "sys1_pll_100m", "sys2_pll_500m",
> +                                               "sys2_pll_250m", "sys1_pl=
l_400m", "audio_pll1_out", "sys1_pll_266m", };
> +
> +static const char *imx8mq_dram_apb_sels[] =3D {"osc_25m", "sys2_pll_200m=
", "sys1_pll_40m", "sys1_pll_160m",
> +                                               "sys1_pll_800m", "sys3_pl=
l2_out", "sys2_pll_250m", "audio_pll2_out", };
> +
> +static const char *imx8mq_vpu_g1_sels[] =3D {"osc_25m", "vpu_pll_out", "=
sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_100m", "sys2_pll_125m", "sys3_p=
ll2_out", "audio_pll1_out", };
> +
> +static const char *imx8mq_vpu_g2_sels[] =3D {"osc_25m", "vpu_pll_out", "=
sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_100m", "sys2_pll_125m", "sys3_p=
ll2_out", "audio_pll1_out", };
> +
> +static const char *imx8mq_disp_dtrc_sels[] =3D {"osc_25m", "vpu_pll_out"=
, "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_160m", "sys2_pll_100m", "sys=
3_pll2_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_disp_dc8000_sels[] =3D {"osc_25m", "vpu_pll_ou=
t", "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_160m", "sys2_pll_100m", "s=
ys3_pll2_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_pcie1_ctrl_sels[] =3D {"osc_25m", "sys2_pll_25=
0m", "sys2_pll_200m", "sys1_pll_266m",
> +                                              "sys1_pll_800m", "sys2_pll=
_500m", "sys2_pll_250m", "sys3_pll2_out", };
> +
> +static const char *imx8mq_pcie1_phy_sels[] =3D {"osc_25m", "sys2_pll_100=
m", "sys2_pll_500m", "clk_ext1", "clk_ext2",
> +                                             "clk_ext3", "clk_ext4", };
> +
> +static const char *imx8mq_pcie1_aux_sels[] =3D {"osc_25m", "sys2_pll_200=
m", "sys2_pll_500m", "sys3_pll2_out",
> +                                             "sys2_pll_100m", "sys1_pll_=
80m", "sys1_pll_160m", "sys1_pll_200m", };
> +
> +static const char *imx8mq_dc_pixel_sels[] =3D {"osc_25m", "video_pll1_ou=
t", "audio_pll2_out", "audio_pll1_out", "sys1_pll_800m", "sys2_pll_1000m", =
"sys3_pll2_out", "clk_ext4", };
> +
> +static const char *imx8mq_lcdif_pixel_sels[] =3D {"osc_25m", "video_pll1=
_out", "audio_pll2_out", "audio_pll1_out", "sys1_pll_800m", "sys2_pll_1000m=
", "sys3_pll2_out", "clk_ext4", };
> +
> +static const char *imx8mq_sai1_sels[] =3D {"osc_25m", "audio_pll1_out", =
"audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext1",=
 "clk_ext2", };
> +
> +static const char *imx8mq_sai2_sels[] =3D {"osc_25m", "audio_pll1_out", =
"audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2",=
 "clk_ext3", };
> +
> +static const char *imx8mq_sai3_sels[] =3D {"osc_25m", "audio_pll1_out", =
"audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3",=
 "clk_ext4", };
> +
> +static const char *imx8mq_sai4_sels[] =3D {"osc_25m", "audio_pll1_out", =
"audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext1",=
 "clk_ext2", };
> +
> +static const char *imx8mq_sai5_sels[] =3D {"osc_25m", "audio_pll1_out", =
"audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2",=
 "clk_ext3", };
> +
> +static const char *imx8mq_sai6_sels[] =3D {"osc_25m", "audio_pll1_out", =
"audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3",=
 "clk_ext4", };
> +
> +static const char *imx8mq_spdif1_sels[] =3D {"osc_25m", "audio_pll1_out"=
, "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2=
", "clk_ext3", };
> +
> +static const char *imx8mq_spdif2_sels[] =3D {"osc_25m", "audio_pll1_out"=
, "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3=
", "clk_ext4", };
> +
> +static const char *imx8mq_enet_ref_sels[] =3D {"osc_25m", "sys2_pll_125m=
", "sys2_pll_500m", "sys2_pll_100m",
> +                                            "sys1_pll_160m", "audio_pll1=
_out", "video_pll1_out", "clk_ext4", };
> +
> +static const char *imx8mq_enet_timer_sels[] =3D {"osc_25m", "sys2_pll_10=
0m", "audio_pll1_out", "clk_ext1", "clk_ext2",
> +                                              "clk_ext3", "clk_ext4", "v=
ideo_pll1_out", };
> +
> +static const char *imx8mq_enet_phy_sels[] =3D {"osc_25m", "sys2_pll_50m"=
, "sys2_pll_125m", "sys2_pll_500m",
> +                                            "audio_pll1_out", "video_pll=
1_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_nand_sels[] =3D {"osc_25m", "sys2_pll_500m", "=
audio_pll1_out", "sys1_pll_400m",
> +                                        "audio_pll2_out", "sys3_pll2_out=
", "sys2_pll_250m", "video_pll1_out", };
> +
> +static const char *imx8mq_qspi_sels[] =3D {"osc_25m", "sys1_pll_400m", "=
sys1_pll_800m", "sys2_pll_500m",
> +                                        "audio_pll2_out", "sys1_pll_266m=
", "sys3_pll2_out", "sys1_pll_100m", };
> +
> +static const char *imx8mq_usdhc1_sels[] =3D {"osc_25m", "sys1_pll_400m",=
 "sys1_pll_800m", "sys2_pll_500m",
> +                                        "audio_pll2_out", "sys1_pll_266m=
", "sys3_pll2_out", "sys1_pll_100m", };
> +
> +static const char *imx8mq_usdhc2_sels[] =3D {"osc_25m", "sys1_pll_400m",=
 "sys1_pll_800m", "sys2_pll_500m",
> +                                        "audio_pll2_out", "sys1_pll_266m=
", "sys3_pll2_out", "sys1_pll_100m", };
> +
> +static const char *imx8mq_i2c1_sels[] =3D {"osc_25m", "sys1_pll_160m", "=
sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
> +                                        "video_pll1_out", "audio_pll2_ou=
t", "sys1_pll_133m", };
> +
> +static const char *imx8mq_i2c2_sels[] =3D {"osc_25m", "sys1_pll_160m", "=
sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
> +                                        "video_pll1_out", "audio_pll2_ou=
t", "sys1_pll_133m", };
> +
> +static const char *imx8mq_i2c3_sels[] =3D {"osc_25m", "sys1_pll_160m", "=
sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
> +                                        "video_pll1_out", "audio_pll2_ou=
t", "sys1_pll_133m", };
> +
> +static const char *imx8mq_i2c4_sels[] =3D {"osc_25m", "sys1_pll_160m", "=
sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
> +                                        "video_pll1_out", "audio_pll2_ou=
t", "sys1_pll_133m", };
> +
> +static const char *imx8mq_uart1_sels[] =3D {"osc_25m", "sys1_pll_80m", "=
sys2_pll_200m", "sys2_pll_100m",
> +                                         "sys3_pll2_out", "clk_ext2", "c=
lk_ext4", "audio_pll2_out", };
> +
> +static const char *imx8mq_uart2_sels[] =3D {"osc_25m", "sys1_pll_80m", "=
sys2_pll_200m", "sys2_pll_100m",
> +                                         "sys3_pll2_out", "clk_ext2", "c=
lk_ext3", "audio_pll2_out", };
> +
> +static const char *imx8mq_uart3_sels[] =3D {"osc_25m", "sys1_pll_80m", "=
sys2_pll_200m", "sys2_pll_100m",
> +                                         "sys3_pll2_out", "clk_ext2", "c=
lk_ext4", "audio_pll2_out", };
> +
> +static const char *imx8mq_uart4_sels[] =3D {"osc_25m", "sys1_pll_80m", "=
sys2_pll_200m", "sys2_pll_100m",
> +                                         "sys3_pll2_out", "clk_ext2", "c=
lk_ext3", "audio_pll2_out", };
> +
> +static const char *imx8mq_usb_core_sels[] =3D {"osc_25m", "sys1_pll_100m=
", "sys1_pll_40m", "sys2_pll_100m",
> +                                            "sys2_pll_200m", "clk_ext2",=
 "clk_ext3", "audio_pll2_out", };
> +
> +static const char *imx8mq_usb_phy_sels[] =3D {"osc_25m", "sys1_pll_100m"=
, "sys1_pll_40m", "sys2_pll_100m",
> +                                            "sys2_pll_200m", "clk_ext2",=
 "clk_ext3", "audio_pll2_out", };
> +
> +static const char *imx8mq_ecspi1_sels[] =3D {"osc_25m", "sys2_pll_200m",=
 "sys1_pll_40m", "sys1_pll_160m",
> +                                          "sys1_pll_800m", "sys3_pll2_ou=
t", "sys2_pll_250m", "audio_pll2_out", };
> +
> +static const char *imx8mq_ecspi2_sels[] =3D {"osc_25m", "sys2_pll_200m",=
 "sys1_pll_40m", "sys1_pll_160m",
> +                                          "sys1_pll_800m", "sys3_pll2_ou=
t", "sys2_pll_250m", "audio_pll2_out", };
> +
> +static const char *imx8mq_pwm1_sels[] =3D {"osc_25m", "sys2_pll_100m", "=
sys1_pll_160m", "sys1_pll_40m",
> +                                        "sys3_pll2_out", "clk_ext1", "sy=
s1_pll_80m", "video_pll1_out", };
> +
> +static const char *imx8mq_pwm2_sels[] =3D {"osc_25m", "sys2_pll_100m", "=
sys1_pll_160m", "sys1_pll_40m",
> +                                        "sys3_pll2_out", "clk_ext1", "sy=
s1_pll_80m", "video_pll1_out", };
> +
> +static const char *imx8mq_pwm3_sels[] =3D {"osc_25m", "sys2_pll_100m", "=
sys1_pll_160m", "sys1_pll_40m",
> +                                        "sys3_pll2_out", "clk_ext2", "sy=
s1_pll_80m", "video_pll1_out", };
> +
> +static const char *imx8mq_pwm4_sels[] =3D {"osc_25m", "sys2_pll_100m", "=
sys1_pll_160m", "sys1_pll_40m",
> +                                        "sys3_pll2_out", "clk_ext2", "sy=
s1_pll_80m", "video_pll1_out", };
> +
> +static const char *imx8mq_gpt1_sels[] =3D {"osc_25m", "sys2_pll_100m", "=
sys1_pll_400m", "sys1_pll_40m",
> +                                        "sys1_pll_80m", "audio_pll1_out"=
, "clk_ext1", };
> +
> +static const char *imx8mq_wdog_sels[] =3D {"osc_25m", "sys1_pll_133m", "=
sys1_pll_160m", "vpu_pll_out",
> +                                        "sys2_pll_125m", "sys3_pll2_out"=
, "sys1_pll_80m", "sys2_pll_166m", };
> +
> +static const char *imx8mq_wrclk_sels[] =3D {"osc_25m", "sys1_pll_40m", "=
vpu_pll_out", "sys3_pll2_out", "sys2_pll_200m",
> +                                         "sys1_pll_266m", "sys2_pll_500m=
", "sys1_pll_100m", };
> +
> +static const char *imx8mq_dsi_core_sels[] =3D {"osc_25m", "sys1_pll_266m=
", "sys2_pll_250m", "sys1_pll_800m",
> +                                            "sys2_pll_1000m", "sys3_pll2=
_out", "audio_pll2_out", "video_pll1_out", };
> +
> +static const char *imx8mq_dsi_phy_sels[] =3D {"osc_25m", "sys2_pll_125m"=
, "sys2_pll_100m", "sys1_pll_800m",
> +                                           "sys2_pll_1000m", "clk_ext2",=
 "audio_pll2_out", "video_pll1_out", };
> +
> +static const char *imx8mq_dsi_dbi_sels[] =3D {"osc_25m", "sys1_pll_266m"=
, "sys2_pll_100m", "sys1_pll_800m",
> +                                           "sys2_pll_1000m", "sys3_pll2_=
out", "audio_pll2_out", "video_pll1_out", };
> +
> +static const char *imx8mq_dsi_esc_sels[] =3D {"osc_25m", "sys2_pll_100m"=
, "sys1_pll_80m", "sys1_pll_800m",
> +                                           "sys2_pll_1000m", "sys3_pll2_=
out", "clk_ext3", "audio_pll2_out", };
> +
> +static const char *imx8mq_csi1_core_sels[] =3D {"osc_25m", "sys1_pll_266=
m", "sys2_pll_250m", "sys1_pll_800m",
> +                                             "sys2_pll_1000m", "sys3_pll=
2_out", "audio_pll2_out", "video_pll1_out", };
> +
> +static const char *imx8mq_csi1_phy_sels[] =3D {"osc_25m", "sys2_pll_125m=
", "sys2_pll_100m", "sys1_pll_800m",
> +                                            "sys2_pll_1000m", "clk_ext2"=
, "audio_pll2_out", "video_pll1_out", };
> +
> +static const char *imx8mq_csi1_esc_sels[] =3D {"osc_25m", "sys2_pll_100m=
", "sys1_pll_80m", "sys1_pll_800m",
> +                                            "sys2_pll_1000m", "sys3_pll2=
_out", "clk_ext3", "audio_pll2_out", };
> +
> +static const char *imx8mq_csi2_core_sels[] =3D {"osc_25m", "sys1_pll_266=
m", "sys2_pll_250m", "sys1_pll_800m",
> +                                             "sys2_pll_1000m", "sys3_pll=
2_out", "audio_pll2_out", "video_pll1_out", };
> +
> +static const char *imx8mq_csi2_phy_sels[] =3D {"osc_25m", "sys2_pll_125m=
", "sys2_pll_100m", "sys1_pll_800m",
> +                                            "sys2_pll_1000m", "clk_ext2"=
, "audio_pll2_out", "video_pll1_out", };
> +
> +static const char *imx8mq_csi2_esc_sels[] =3D {"osc_25m", "sys2_pll_100m=
", "sys1_pll_80m", "sys1_pll_800m",
> +                                            "sys2_pll_1000m", "sys3_pll2=
_out", "clk_ext3", "audio_pll2_out", };
> +
> +static const char *imx8mq_pcie2_ctrl_sels[] =3D {"osc_25m", "sys2_pll_25=
0m", "sys2_pll_200m", "sys1_pll_266m",
> +                                              "sys1_pll_800m", "sys2_pll=
_500m", "sys2_pll_333m", "sys3_pll2_out", };
> +
> +static const char *imx8mq_pcie2_phy_sels[] =3D {"osc_25m", "sys2_pll_100=
m", "sys2_pll_500m", "clk_ext1",
> +                                             "clk_ext2", "clk_ext3", "cl=
k_ext4", "sys1_pll_400m", };
> +
> +static const char *imx8mq_pcie2_aux_sels[] =3D {"osc_25m", "sys2_pll_200=
m", "sys2_pll_50m", "sys3_pll2_out",
> +                                             "sys2_pll_100m", "sys1_pll_=
80m", "sys1_pll_160m", "sys1_pll_200m", };
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

But then we continue? Shouldn't we return?

> +
> +       clks[IMX8MQ_ARM_PLL_REF_SEL] =3D imx_clk_mux("arm_pll_ref_sel", b=
ase + 0x28, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_GPU_PLL_REF_SEL] =3D imx_clk_mux("gpu_pll_ref_sel", b=
ase + 0x18, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_VPU_PLL_REF_SEL] =3D imx_clk_mux("vpu_pll_ref_sel", b=
ase + 0x20, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_AUDIO_PLL1_REF_SEL] =3D imx_clk_mux("audio_pll1_ref_s=
el", base + 0x0, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_AUDIO_PLL2_REF_SEL] =3D imx_clk_mux("audio_pll2_ref_s=
el", base + 0x8, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_VIDEO_PLL1_REF_SEL] =3D imx_clk_mux("video_pll1_ref_s=
el", base + 0x10, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_SYS1_PLL1_REF_SEL]  =3D imx_clk_mux("sys1_pll1_ref_se=
l", base + 0x30, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_SYS2_PLL1_REF_SEL]  =3D imx_clk_mux("sys2_pll1_ref_se=
l", base + 0x3c, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_SYS3_PLL1_REF_SEL]  =3D imx_clk_mux("sys3_pll1_ref_se=
l", base + 0x48, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_DRAM_PLL1_REF_SEL]  =3D imx_clk_mux("dram_pll1_ref_se=
l", base + 0x60, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +
> +       clks[IMX8MQ_ARM_PLL_REF_DIV]    =3D imx_clk_divider("arm_pll_ref_=
div", "arm_pll_ref_sel", base + 0x28, 5, 6);
> +       clks[IMX8MQ_GPU_PLL_REF_DIV]    =3D imx_clk_divider("gpu_pll_ref_=
div", "gpu_pll_ref_sel", base + 0x18, 5, 6);
> +       clks[IMX8MQ_VPU_PLL_REF_DIV]    =3D imx_clk_divider("vpu_pll_ref_=
div", "vpu_pll_ref_sel", base + 0x20, 5, 6);
> +       clks[IMX8MQ_AUDIO_PLL1_REF_DIV] =3D imx_clk_divider("audio_pll1_r=
ef_div", "audio_pll1_ref_sel", base + 0x0, 5, 6);
> +       clks[IMX8MQ_AUDIO_PLL2_REF_DIV] =3D imx_clk_divider("audio_pll2_r=
ef_div", "audio_pll2_ref_sel", base + 0x8, 5, 6);
> +       clks[IMX8MQ_VIDEO_PLL1_REF_DIV] =3D imx_clk_divider("video_pll1_r=
ef_div", "video_pll1_ref_sel", base + 0x10, 5, 6);
> +       clks[IMX8MQ_SYS1_PLL1_REF_DIV]  =3D imx_clk_divider("sys1_pll1_re=
f_div", "sys1_pll1_ref_sel", base + 0x38, 25, 3);
> +       clks[IMX8MQ_SYS2_PLL1_REF_DIV]  =3D imx_clk_divider("sys2_pll1_re=
f_div", "sys2_pll1_ref_sel", base + 0x44, 25, 3);
> +       clks[IMX8MQ_SYS3_PLL1_REF_DIV]  =3D imx_clk_divider("sys3_pll1_re=
f_div", "sys3_pll1_ref_sel", base + 0x50, 25, 3);
> +       clks[IMX8MQ_DRAM_PLL1_REF_DIV]  =3D imx_clk_divider("dram_pll1_re=
f_div", "dram_pll1_ref_sel", base + 0x68, 25, 3);
> +
> +       clks[IMX8MQ_ARM_PLL] =3D imx_clk_frac_pll("arm_pll", "arm_pll_ref=
_div", base + 0x28);
> +       clks[IMX8MQ_GPU_PLL] =3D imx_clk_frac_pll("gpu_pll", "gpu_pll_ref=
_div", base + 0x18);
> +       clks[IMX8MQ_VPU_PLL] =3D imx_clk_frac_pll("vpu_pll", "vpu_pll_ref=
_div", base + 0x20);
> +       clks[IMX8MQ_AUDIO_PLL1] =3D imx_clk_frac_pll("audio_pll1", "audio=
_pll1_ref_div", base + 0x0);
> +       clks[IMX8MQ_AUDIO_PLL2] =3D imx_clk_frac_pll("audio_pll2", "audio=
_pll2_ref_div", base + 0x8);
> +       clks[IMX8MQ_VIDEO_PLL1] =3D imx_clk_frac_pll("video_pll1", "video=
_pll1_ref_div", base + 0x10);
> +       clks[IMX8MQ_SYS1_PLL1] =3D imx_clk_sccg_pll("sys1_pll1", "sys1_pl=
l1_ref_div", base + 0x30, SCCG_PLL1);
> +       clks[IMX8MQ_SYS2_PLL1] =3D imx_clk_sccg_pll("sys2_pll1", "sys2_pl=
l1_ref_div", base + 0x3c, SCCG_PLL1);
> +       clks[IMX8MQ_SYS3_PLL1] =3D imx_clk_sccg_pll("sys3_pll1", "sys3_pl=
l1_ref_div", base + 0x48, SCCG_PLL1);
> +       clks[IMX8MQ_DRAM_PLL1] =3D imx_clk_sccg_pll("dram_pll1", "dram_pl=
l1_ref_div", base + 0x60, SCCG_PLL1);
> +
> +       clks[IMX8MQ_SYS1_PLL2] =3D imx_clk_sccg_pll("sys1_pll2", "sys1_pl=
l1_out_div", base + 0x30, SCCG_PLL2);
> +       clks[IMX8MQ_SYS2_PLL2] =3D imx_clk_sccg_pll("sys2_pll2", "sys2_pl=
l1_out_div", base + 0x3c, SCCG_PLL2);
> +       clks[IMX8MQ_SYS3_PLL2] =3D imx_clk_sccg_pll("sys3_pll2", "sys3_pl=
l1_out_div", base + 0x48, SCCG_PLL2);
> +       clks[IMX8MQ_DRAM_PLL2] =3D imx_clk_sccg_pll("dram_pll2", "dram_pl=
l1_out_div", base + 0x60, SCCG_PLL2);
> +
> +       /* PLL divs */
> +       clks[IMX8MQ_SYS1_PLL1_OUT_DIV] =3D imx_clk_divider("sys1_pll1_out=
_div", "sys1_pll1_out", base + 0x38, 19, 6);
> +       clks[IMX8MQ_SYS2_PLL1_OUT_DIV] =3D imx_clk_divider("sys2_pll1_out=
_div", "sys2_pll1_out", base + 0x44, 19, 6);
> +       clks[IMX8MQ_SYS3_PLL1_OUT_DIV] =3D imx_clk_divider("sys3_pll1_out=
_div", "sys3_pll1_out", base + 0x50, 19, 6);
> +       clks[IMX8MQ_DRAM_PLL1_OUT_DIV] =3D imx_clk_divider("dram_pll1_out=
_div", "dram_pll1_out", base + 0x68, 19, 6);
> +       clks[IMX8MQ_SYS1_PLL2_DIV] =3D imx_clk_divider("sys1_pll2_div", "=
sys1_pll2", base + 0x38, 1, 6);
> +       clks[IMX8MQ_SYS2_PLL2_DIV] =3D imx_clk_divider("sys2_pll2_div", "=
sys2_pll2", base + 0x44, 1, 6);
> +       clks[IMX8MQ_SYS3_PLL2_DIV] =3D imx_clk_divider("sys3_pll2_div", "=
sys3_pll2", base + 0x50, 1, 6);
> +       clks[IMX8MQ_DRAM_PLL2_DIV] =3D imx_clk_divider("dram_pll2_div", "=
dram_pll2", base + 0x68, 1, 6);
> +
> +       /* PLL bypass out */
> +       clks[IMX8MQ_ARM_PLL_BYPASS] =3D imx_clk_mux("arm_pll_bypass", bas=
e + 0x28, 14, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels));
> +       clks[IMX8MQ_GPU_PLL_BYPASS] =3D imx_clk_mux("gpu_pll_bypass", bas=
e + 0x18, 14, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels));
> +       clks[IMX8MQ_VPU_PLL_BYPASS] =3D imx_clk_mux("vpu_pll_bypass", bas=
e + 0x20, 14, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels));
> +       clks[IMX8MQ_AUDIO_PLL1_BYPASS] =3D imx_clk_mux("audio_pll1_bypass=
", base + 0x0, 14, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_=
sels));
> +       clks[IMX8MQ_AUDIO_PLL2_BYPASS] =3D imx_clk_mux("audio_pll2_bypass=
", base + 0x8, 14, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_=
sels));
> +       clks[IMX8MQ_VIDEO_PLL1_BYPASS] =3D imx_clk_mux("video_pll1_bypass=
", base + 0x10, 14, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass=
_sels));
> +
> +       clks[IMX8MQ_SYS1_PLL1_OUT] =3D imx_clk_mux("sys1_pll1_out", base =
+ 0x30, 5, 1, sys1_pll1_out_sels, ARRAY_SIZE(sys1_pll1_out_sels));
> +       clks[IMX8MQ_SYS2_PLL1_OUT] =3D imx_clk_mux("sys2_pll1_out", base =
+ 0x3c, 5, 1, sys2_pll1_out_sels, ARRAY_SIZE(sys2_pll1_out_sels));
> +       clks[IMX8MQ_SYS3_PLL1_OUT] =3D imx_clk_mux("sys3_pll1_out", base =
+ 0x48, 5, 1, sys3_pll1_out_sels, ARRAY_SIZE(sys3_pll1_out_sels));
> +       clks[IMX8MQ_DRAM_PLL1_OUT] =3D imx_clk_mux("dram_pll1_out", base =
+ 0x60, 5, 1, dram_pll1_out_sels, ARRAY_SIZE(dram_pll1_out_sels));
> +       clks[IMX8MQ_SYS1_PLL2_OUT] =3D imx_clk_mux("sys1_pll2_out", base =
+ 0x30, 4, 1, sys1_pll2_out_sels, ARRAY_SIZE(sys1_pll2_out_sels));
> +       clks[IMX8MQ_SYS2_PLL2_OUT] =3D imx_clk_mux("sys2_pll2_out", base =
+ 0x3c, 4, 1, sys2_pll2_out_sels, ARRAY_SIZE(sys2_pll2_out_sels));
> +       clks[IMX8MQ_SYS3_PLL2_OUT] =3D imx_clk_mux("sys3_pll2_out", base =
+ 0x48, 4, 1, sys3_pll2_out_sels, ARRAY_SIZE(sys3_pll2_out_sels));
> +       clks[IMX8MQ_DRAM_PLL2_OUT] =3D imx_clk_mux("dram_pll2_out", base =
+ 0x60, 4, 1, dram_pll2_out_sels, ARRAY_SIZE(dram_pll2_out_sels));
> +
> +       /* unbypass all the plls */
> +       clk_set_parent(clks[IMX8MQ_GPU_PLL_BYPASS], clks[IMX8MQ_GPU_PLL]);
> +       clk_set_parent(clks[IMX8MQ_VPU_PLL_BYPASS], clks[IMX8MQ_VPU_PLL]);
> +       clk_set_parent(clks[IMX8MQ_AUDIO_PLL1_BYPASS], clks[IMX8MQ_AUDIO_=
PLL1]);
> +       clk_set_parent(clks[IMX8MQ_AUDIO_PLL2_BYPASS], clks[IMX8MQ_AUDIO_=
PLL2]);
> +       clk_set_parent(clks[IMX8MQ_VIDEO_PLL1_BYPASS], clks[IMX8MQ_VIDEO_=
PLL1]);
> +       clk_set_parent(clks[IMX8MQ_SYS3_PLL1_OUT], clks[IMX8MQ_SYS3_PLL1]=
);
> +       clk_set_parent(clks[IMX8MQ_SYS3_PLL2_OUT], clks[IMX8MQ_SYS3_PLL2_=
DIV]);
> +
> +       /* PLL OUT GATE */
> +       clks[IMX8MQ_ARM_PLL_OUT] =3D imx_clk_gate("arm_pll_out", "arm_pll=
_bypass", base + 0x28, 21);
> +       clks[IMX8MQ_GPU_PLL_OUT] =3D imx_clk_gate("gpu_pll_out", "gpu_pll=
_bypass", base + 0x18, 21);
> +       clks[IMX8MQ_VPU_PLL_OUT] =3D imx_clk_gate("vpu_pll_out", "vpu_pll=
_bypass", base + 0x20, 21);
> +       clks[IMX8MQ_AUDIO_PLL1_OUT] =3D imx_clk_gate("audio_pll1_out", "a=
udio_pll1_bypass", base + 0x0, 21);
> +       clks[IMX8MQ_AUDIO_PLL2_OUT] =3D imx_clk_gate("audio_pll2_out", "a=
udio_pll2_bypass", base + 0x8, 21);
> +       clks[IMX8MQ_VIDEO_PLL1_OUT] =3D imx_clk_gate("video_pll1_out", "v=
ideo_pll1_bypass", base + 0x10, 21);
> +       clks[IMX8MQ_SYS1_PLL_OUT] =3D imx_clk_gate("sys1_pll_out", "sys1_=
pll2_out", base + 0x30, 9);
> +       clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_gate("sys2_pll_out", "sys2_=
pll2_out", base + 0x3c, 9);
> +       clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_gate("sys3_pll_out", "sys3_=
pll2_out", base + 0x48, 9);
> +       clks[IMX8MQ_DRAM_PLL_OUT] =3D imx_clk_gate("dram_pll_out", "dram_=
pll2_out", base + 0x60, 9);
> +
> +       /* SYS PLL fixed output */
> +       clks[IMX8MQ_SYS1_PLL_40M] =3D imx_clk_fixed_factor("sys1_pll_40m"=
, "sys1_pll_out", 1, 20);
> +       clks[IMX8MQ_SYS1_PLL_80M] =3D imx_clk_fixed_factor("sys1_pll_80m"=
, "sys1_pll_out", 1, 10);
> +       clks[IMX8MQ_SYS1_PLL_100M] =3D imx_clk_fixed_factor("sys1_pll_100=
m", "sys1_pll_out", 1, 8);
> +       clks[IMX8MQ_SYS1_PLL_133M] =3D imx_clk_fixed_factor("sys1_pll_133=
m", "sys1_pll_out", 1, 6);
> +       clks[IMX8MQ_SYS1_PLL_160M] =3D imx_clk_fixed_factor("sys1_pll_160=
m", "sys1_pll_out", 1, 5);
> +       clks[IMX8MQ_SYS1_PLL_200M] =3D imx_clk_fixed_factor("sys1_pll_200=
m", "sys1_pll_out", 1, 4);
> +       clks[IMX8MQ_SYS1_PLL_266M] =3D imx_clk_fixed_factor("sys1_pll_266=
m", "sys1_pll_out", 1, 3);
> +       clks[IMX8MQ_SYS1_PLL_400M] =3D imx_clk_fixed_factor("sys1_pll_400=
m", "sys1_pll_out", 1, 2);
> +       clks[IMX8MQ_SYS1_PLL_800M] =3D imx_clk_fixed_factor("sys1_pll_800=
m", "sys1_pll_out", 1, 1);
> +
> +       clks[IMX8MQ_SYS2_PLL_50M] =3D imx_clk_fixed_factor("sys2_pll_50m"=
, "sys2_pll_out", 1, 20);
> +       clks[IMX8MQ_SYS2_PLL_100M] =3D imx_clk_fixed_factor("sys2_pll_100=
m", "sys2_pll_out", 1, 10);
> +       clks[IMX8MQ_SYS2_PLL_125M] =3D imx_clk_fixed_factor("sys2_pll_125=
m", "sys2_pll_out", 1, 8);
> +       clks[IMX8MQ_SYS2_PLL_166M] =3D imx_clk_fixed_factor("sys2_pll_166=
m", "sys2_pll_out", 1, 6);
> +       clks[IMX8MQ_SYS2_PLL_200M] =3D imx_clk_fixed_factor("sys2_pll_200=
m", "sys2_pll_out", 1, 5);
> +       clks[IMX8MQ_SYS2_PLL_250M] =3D imx_clk_fixed_factor("sys2_pll_250=
m", "sys2_pll_out", 1, 4);
> +       clks[IMX8MQ_SYS2_PLL_333M] =3D imx_clk_fixed_factor("sys2_pll_333=
m", "sys2_pll_out", 1, 3);
> +       clks[IMX8MQ_SYS2_PLL_500M] =3D imx_clk_fixed_factor("sys2_pll_500=
m", "sys2_pll_out", 1, 2);
> +       clks[IMX8MQ_SYS2_PLL_1000M] =3D imx_clk_fixed_factor("sys2_pll_10=
00m", "sys2_pll_out", 1, 1);
> +
> +       np =3D ccm_node;
> +       base =3D of_iomap(np, 0);
> +       WARN_ON(!base);
> +       /* CORE */
> +       clks[IMX8MQ_CLK_A53_SRC] =3D imx_clk_mux2("arm_a53_src", base + 0=
x8000, 24, 3, imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels));
> +       clks[IMX8MQ_CLK_VPU_SRC] =3D imx_clk_mux2("vpu_src", base + 0x810=
0, 24, 3, imx8mq_vpu_sels, ARRAY_SIZE(imx8mq_vpu_sels));
> +       clks[IMX8MQ_CLK_GPU_CORE_SRC] =3D imx_clk_mux2("gpu_core_src", ba=
se + 0x8180, 24, 3,  imx8mq_gpu_core_sels, ARRAY_SIZE(imx8mq_gpu_core_sels)=
);
> +       clks[IMX8MQ_CLK_GPU_SHADER_SRC] =3D imx_clk_mux2("gpu_shader_src"=
, base + 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shad=
er_sels));
> +       clks[IMX8MQ_CLK_A53_CG] =3D imx_clk_gate3_flags("arm_a53_cg", "ar=
m_a53_src", base + 0x8000, 28, CLK_IS_CRITICAL);
> +       clks[IMX8MQ_CLK_VPU_CG] =3D imx_clk_gate3("vpu_cg", "vpu_src", ba=
se + 0x8100, 28);
> +       clks[IMX8MQ_CLK_GPU_CORE_CG] =3D imx_clk_gate3("gpu_core_cg", "gp=
u_core_src", base + 0x8180, 28);
> +       clks[IMX8MQ_CLK_GPU_SHADER_CG] =3D imx_clk_gate3("gpu_shader_cg",=
 "gpu_shader_src", base + 0x8200, 28);
> +
> +       clks[IMX8MQ_CLK_A53_DIV] =3D imx_clk_divider2("arm_a53_div", "arm=
_a53_cg", base + 0x8000, 0, 3);
> +       clks[IMX8MQ_CLK_VPU_DIV] =3D imx_clk_divider2("vpu_div", "vpu_cg"=
, base + 0x8100, 0, 3);
> +       clks[IMX8MQ_CLK_GPU_CORE_DIV] =3D imx_clk_divider2("gpu_core_div"=
, "gpu_core_cg", base + 0x8180, 0, 3);
> +       clks[IMX8MQ_CLK_GPU_SHADER_DIV] =3D imx_clk_divider2("gpu_shader_=
div", "gpu_shader_cg", base + 0x8200, 0, 3);
> +
> +       /* BUS */
> +       clks[IMX8MQ_CLK_MAIN_AXI] =3D imx8m_clk_composite_critical("main_=
axi", imx8mq_main_axi_sels, base + 0x8800);
> +       clks[IMX8MQ_CLK_ENET_AXI] =3D imx8m_clk_composite("enet_axi", imx=
8mq_enet_axi_sels, base + 0x8880);
> +       clks[IMX8MQ_CLK_NAND_USDHC_BUS] =3D imx8m_clk_composite("nand_usd=
hc_bus", imx8mq_nand_usdhc_sels, base + 0x8900);
> +       clks[IMX8MQ_CLK_VPU_BUS] =3D imx8m_clk_composite("vpu_bus", imx8m=
q_vpu_bus_sels, base + 0x8980);
> +       clks[IMX8MQ_CLK_DISP_AXI] =3D imx8m_clk_composite("disp_axi", imx=
8mq_disp_axi_sels, base + 0x8a00);
> +       clks[IMX8MQ_CLK_DISP_APB] =3D imx8m_clk_composite("disp_apb", imx=
8mq_disp_apb_sels, base + 0x8a80);
> +       clks[IMX8MQ_CLK_DISP_RTRM] =3D imx8m_clk_composite("disp_rtrm", i=
mx8mq_disp_rtrm_sels, base + 0x8b00);
> +       clks[IMX8MQ_CLK_USB_BUS] =3D imx8m_clk_composite("usb_bus", imx8m=
q_usb_bus_sels, base + 0x8b80);
> +       clks[IMX8MQ_CLK_GPU_AXI] =3D imx8m_clk_composite("gpu_axi", imx8m=
q_gpu_axi_sels, base + 0x8c00);
> +       clks[IMX8MQ_CLK_GPU_AHB] =3D imx8m_clk_composite("gpu_ahb", imx8m=
q_gpu_ahb_sels, base + 0x8c80);
> +       clks[IMX8MQ_CLK_NOC] =3D imx8m_clk_composite_critical("noc", imx8=
mq_noc_sels, base + 0x8d00);
> +       clks[IMX8MQ_CLK_NOC_APB] =3D imx8m_clk_composite_critical("noc_ap=
b", imx8mq_noc_apb_sels, base + 0x8d80);
> +
> +       /* AHB */
> +       clks[IMX8MQ_CLK_AHB] =3D imx8m_clk_composite("ahb", imx8mq_ahb_se=
ls, base + 0x9000);
> +       clks[IMX8MQ_CLK_AUDIO_AHB] =3D imx8m_clk_composite("audio_ahb", i=
mx8mq_audio_ahb_sels, base + 0x9100);
> +
> +       /* IPG */
> +       clks[IMX8MQ_CLK_IPG_ROOT] =3D imx_clk_divider2("ipg_root", "ahb",=
 base + 0x9080, 0, 1);
> +       clks[IMX8MQ_CLK_IPG_AUDIO_ROOT] =3D imx_clk_divider2("ipg_audio_r=
oot", "audio_ahb", base + 0x9180, 0, 1);
> +
> +       /* IP */
> +       clks[IMX8MQ_CLK_DRAM_CORE] =3D imx_clk_mux2_flags("dram_core_clk"=
, base + 0x9800, 24, 1, imx8mq_dram_core_sels, ARRAY_SIZE(imx8mq_dram_core_=
sels), CLK_IS_CRITICAL);
> +
> +       clks[IMX8MQ_CLK_DRAM_ALT] =3D imx8m_clk_composite("dram_alt", imx=
8mq_dram_alt_sels, base + 0xa000);
> +       clks[IMX8MQ_CLK_DRAM_APB] =3D imx8m_clk_composite_critical("dram_=
apb", imx8mq_dram_apb_sels, base + 0xa080);
> +       clks[IMX8MQ_CLK_VPU_G1] =3D imx8m_clk_composite("vpu_g1", imx8mq_=
vpu_g1_sels, base + 0xa100);
> +       clks[IMX8MQ_CLK_VPU_G2] =3D imx8m_clk_composite("vpu_g2", imx8mq_=
vpu_g2_sels, base + 0xa180);
> +       clks[IMX8MQ_CLK_DISP_DTRC] =3D imx8m_clk_composite("disp_dtrc", i=
mx8mq_disp_dtrc_sels, base + 0xa200);
> +       clks[IMX8MQ_CLK_DISP_DC8000] =3D imx8m_clk_composite("disp_dc8000=
", imx8mq_disp_dc8000_sels, base + 0xa280);
> +       clks[IMX8MQ_CLK_PCIE1_CTRL] =3D imx8m_clk_composite("pcie1_ctrl",=
 imx8mq_pcie1_ctrl_sels, base + 0xa300);
> +       clks[IMX8MQ_CLK_PCIE1_PHY] =3D imx8m_clk_composite("pcie1_phy", i=
mx8mq_pcie1_phy_sels, base + 0xa380);
> +       clks[IMX8MQ_CLK_PCIE1_AUX] =3D imx8m_clk_composite("pcie1_aux", i=
mx8mq_pcie1_aux_sels, base + 0xa400);
> +       clks[IMX8MQ_CLK_DC_PIXEL] =3D imx8m_clk_composite("dc_pixel", imx=
8mq_dc_pixel_sels, base + 0xa480);
> +       clks[IMX8MQ_CLK_LCDIF_PIXEL] =3D imx8m_clk_composite("lcdif_pixel=
", imx8mq_lcdif_pixel_sels, base + 0xa500);
> +       clks[IMX8MQ_CLK_SAI1] =3D imx8m_clk_composite("sai1", imx8mq_sai1=
_sels, base + 0xa580);
> +       clks[IMX8MQ_CLK_SAI2] =3D imx8m_clk_composite("sai2", imx8mq_sai2=
_sels, base + 0xa600);
> +       clks[IMX8MQ_CLK_SAI3] =3D imx8m_clk_composite("sai3", imx8mq_sai3=
_sels, base + 0xa680);
> +       clks[IMX8MQ_CLK_SAI4] =3D imx8m_clk_composite("sai4", imx8mq_sai4=
_sels, base + 0xa700);
> +       clks[IMX8MQ_CLK_SAI5] =3D imx8m_clk_composite("sai5", imx8mq_sai5=
_sels, base + 0xa780);
> +       clks[IMX8MQ_CLK_SAI6] =3D imx8m_clk_composite("sai6", imx8mq_sai6=
_sels, base + 0xa800);
> +       clks[IMX8MQ_CLK_SPDIF1] =3D imx8m_clk_composite("spdif1", imx8mq_=
spdif1_sels, base + 0xa880);
> +       clks[IMX8MQ_CLK_SPDIF2] =3D imx8m_clk_composite("spdif2", imx8mq_=
spdif2_sels, base + 0xa900);
> +       clks[IMX8MQ_CLK_ENET_REF] =3D imx8m_clk_composite("enet_ref", imx=
8mq_enet_ref_sels, base + 0xa980);
> +       clks[IMX8MQ_CLK_ENET_TIMER] =3D imx8m_clk_composite("enet_timer",=
 imx8mq_enet_timer_sels, base + 0xaa00);
> +       clks[IMX8MQ_CLK_ENET_PHY_REF] =3D imx8m_clk_composite("enet_phy",=
 imx8mq_enet_phy_sels, base + 0xaa80);
> +       clks[IMX8MQ_CLK_NAND] =3D imx8m_clk_composite("nand", imx8mq_nand=
_sels, base + 0xab00);
> +       clks[IMX8MQ_CLK_QSPI] =3D imx8m_clk_composite("qspi", imx8mq_qspi=
_sels, base + 0xab80);
> +       clks[IMX8MQ_CLK_USDHC1] =3D imx8m_clk_composite("usdhc1", imx8mq_=
usdhc1_sels, base + 0xac00);
> +       clks[IMX8MQ_CLK_USDHC2] =3D imx8m_clk_composite("usdhc2", imx8mq_=
usdhc2_sels, base + 0xac80);
> +       clks[IMX8MQ_CLK_I2C1] =3D imx8m_clk_composite("i2c1", imx8mq_i2c1=
_sels, base + 0xad00);
> +       clks[IMX8MQ_CLK_I2C2] =3D imx8m_clk_composite("i2c2", imx8mq_i2c2=
_sels, base + 0xad80);
> +       clks[IMX8MQ_CLK_I2C3] =3D imx8m_clk_composite("i2c3", imx8mq_i2c3=
_sels, base + 0xae00);
> +       clks[IMX8MQ_CLK_I2C4] =3D imx8m_clk_composite("i2c4", imx8mq_i2c4=
_sels, base + 0xae80);
> +       clks[IMX8MQ_CLK_UART1] =3D imx8m_clk_composite("uart1", imx8mq_ua=
rt1_sels, base + 0xaf00);
> +       clks[IMX8MQ_CLK_UART2] =3D imx8m_clk_composite("uart2", imx8mq_ua=
rt2_sels, base + 0xaf80);
> +       clks[IMX8MQ_CLK_UART3] =3D imx8m_clk_composite("uart3", imx8mq_ua=
rt3_sels, base + 0xb000);
> +       clks[IMX8MQ_CLK_UART4] =3D imx8m_clk_composite("uart4", imx8mq_ua=
rt4_sels, base + 0xb080);
> +       clks[IMX8MQ_CLK_USB_CORE_REF] =3D imx8m_clk_composite("usb_core_r=
ef", imx8mq_usb_core_sels, base + 0xb100);
> +       clks[IMX8MQ_CLK_USB_PHY_REF] =3D imx8m_clk_composite("usb_phy_ref=
", imx8mq_usb_phy_sels, base + 0xb180);
> +       clks[IMX8MQ_CLK_ECSPI1] =3D imx8m_clk_composite("ecspi1", imx8mq_=
ecspi1_sels, base + 0xb280);
> +       clks[IMX8MQ_CLK_ECSPI2] =3D imx8m_clk_composite("ecspi2", imx8mq_=
ecspi2_sels, base + 0xb300);
> +       clks[IMX8MQ_CLK_PWM1] =3D imx8m_clk_composite("pwm1", imx8mq_pwm1=
_sels, base + 0xb380);
> +       clks[IMX8MQ_CLK_PWM2] =3D imx8m_clk_composite("pwm2", imx8mq_pwm2=
_sels, base + 0xb400);
> +       clks[IMX8MQ_CLK_PWM3] =3D imx8m_clk_composite("pwm3", imx8mq_pwm3=
_sels, base + 0xb480);
> +       clks[IMX8MQ_CLK_PWM4] =3D imx8m_clk_composite("pwm4", imx8mq_pwm4=
_sels, base + 0xb500);
> +       clks[IMX8MQ_CLK_GPT1] =3D imx8m_clk_composite("gpt1", imx8mq_gpt1=
_sels, base + 0xb580);
> +       clks[IMX8MQ_CLK_WDOG] =3D imx8m_clk_composite("wdog", imx8mq_wdog=
_sels, base + 0xb900);
> +       clks[IMX8MQ_CLK_WRCLK] =3D imx8m_clk_composite("wrclk", imx8mq_wr=
clk_sels, base + 0xb980);
> +       clks[IMX8MQ_CLK_CLKO2] =3D imx8m_clk_composite("clko2", imx8mq_cl=
ko2_sels, base + 0xba80);
> +       clks[IMX8MQ_CLK_DSI_CORE] =3D imx8m_clk_composite("dsi_core", imx=
8mq_dsi_core_sels, base + 0xbb00);
> +       clks[IMX8MQ_CLK_DSI_PHY_REF] =3D imx8m_clk_composite("dsi_phy_ref=
", imx8mq_dsi_phy_sels, base + 0xbb80);
> +       clks[IMX8MQ_CLK_DSI_DBI] =3D imx8m_clk_composite("dsi_dbi", imx8m=
q_dsi_dbi_sels, base + 0xbc00);
> +       clks[IMX8MQ_CLK_DSI_ESC] =3D imx8m_clk_composite("dsi_esc", imx8m=
q_dsi_esc_sels, base + 0xbc80);
> +       clks[IMX8MQ_CLK_DSI_AHB] =3D imx8m_clk_composite("dsi_ahb", imx8m=
q_dsi_ahb_sels, base + 0x9200);
> +       clks[IMX8MQ_CLK_CSI1_CORE] =3D imx8m_clk_composite("csi1_core", i=
mx8mq_csi1_core_sels, base + 0xbd00);
> +       clks[IMX8MQ_CLK_CSI1_PHY_REF] =3D imx8m_clk_composite("csi1_phy_r=
ef", imx8mq_csi1_phy_sels, base + 0xbd80);
> +       clks[IMX8MQ_CLK_CSI1_ESC] =3D imx8m_clk_composite("csi1_esc", imx=
8mq_csi1_esc_sels, base + 0xbe00);
> +       clks[IMX8MQ_CLK_CSI2_CORE] =3D imx8m_clk_composite("csi2_core", i=
mx8mq_csi2_core_sels, base + 0xbe80);
> +       clks[IMX8MQ_CLK_CSI2_PHY_REF] =3D imx8m_clk_composite("csi2_phy_r=
ef", imx8mq_csi2_phy_sels, base + 0xbf00);
> +       clks[IMX8MQ_CLK_CSI2_ESC] =3D imx8m_clk_composite("csi2_esc", imx=
8mq_csi2_esc_sels, base + 0xbf80);
> +       clks[IMX8MQ_CLK_PCIE2_CTRL] =3D imx8m_clk_composite("pcie2_ctrl",=
 imx8mq_pcie2_ctrl_sels, base + 0xc000);
> +       clks[IMX8MQ_CLK_PCIE2_PHY] =3D imx8m_clk_composite("pcie2_phy", i=
mx8mq_pcie2_phy_sels, base + 0xc080);
> +       clks[IMX8MQ_CLK_PCIE2_AUX] =3D imx8m_clk_composite("pcie2_aux", i=
mx8mq_pcie2_aux_sels, base + 0xc100);
> +       clks[IMX8MQ_CLK_ECSPI3] =3D imx8m_clk_composite("ecspi3", imx8mq_=
ecspi3_sels, base + 0xc180);
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
> +       clks[IMX8MQ_CLK_I2C1_ROOT] =3D imx_clk_gate4("i2c1_root_clk", "i2=
c1", base + 0x4170, 0);
> +       clks[IMX8MQ_CLK_I2C2_ROOT] =3D imx_clk_gate4("i2c2_root_clk", "i2=
c2", base + 0x4180, 0);
> +       clks[IMX8MQ_CLK_I2C3_ROOT] =3D imx_clk_gate4("i2c3_root_clk", "i2=
c3", base + 0x4190, 0);
> +       clks[IMX8MQ_CLK_I2C4_ROOT] =3D imx_clk_gate4("i2c4_root_clk", "i2=
c4", base + 0x41a0, 0);
> +       clks[IMX8MQ_CLK_MU_ROOT] =3D imx_clk_gate4("mu_root_clk", "ipg_ro=
ot", base + 0x4210, 0);
> +       clks[IMX8MQ_CLK_OCOTP_ROOT] =3D imx_clk_gate4("ocotp_root_clk", "=
ipg_root", base + 0x4220, 0);
> +       clks[IMX8MQ_CLK_PCIE1_ROOT] =3D imx_clk_gate4("pcie1_root_clk", "=
pcie1_ctrl", base + 0x4250, 0);
> +       clks[IMX8MQ_CLK_PCIE2_ROOT] =3D imx_clk_gate4("pcie2_root_clk", "=
pcie2_ctrl", base + 0x4640, 0);
> +       clks[IMX8MQ_CLK_PWM1_ROOT] =3D imx_clk_gate4("pwm1_root_clk", "pw=
m1", base + 0x4280, 0);
> +       clks[IMX8MQ_CLK_PWM2_ROOT] =3D imx_clk_gate4("pwm2_root_clk", "pw=
m2", base + 0x4290, 0);
> +       clks[IMX8MQ_CLK_PWM3_ROOT] =3D imx_clk_gate4("pwm3_root_clk", "pw=
m3", base + 0x42a0, 0);
> +       clks[IMX8MQ_CLK_PWM4_ROOT] =3D imx_clk_gate4("pwm4_root_clk", "pw=
m4", base + 0x42b0, 0);
> +       clks[IMX8MQ_CLK_QSPI_ROOT] =3D imx_clk_gate4("qspi_root_clk", "qs=
pi", base + 0x42f0, 0);
> +       clks[IMX8MQ_CLK_RAWNAND_ROOT] =3D imx_clk_gate2_shared2("nand_roo=
t_clk", "nand", base + 0x4300, 0, &share_count_nand);
> +       clks[IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK] =3D imx_clk_gate2_sha=
red2("nand_usdhc_rawnand_clk", "nand_usdhc_bus", base + 0x4300, 0, &share_c=
ount_nand);
> +       clks[IMX8MQ_CLK_SAI1_ROOT] =3D imx_clk_gate2_shared2("sai1_root_c=
lk", "sai1", base + 0x4330, 0, &share_count_sai1);
> +       clks[IMX8MQ_CLK_SAI1_IPG] =3D imx_clk_gate2_shared2("sai1_ipg_clk=
", "ipg_audio_root", base + 0x4330, 0, &share_count_sai1);
> +       clks[IMX8MQ_CLK_SAI2_ROOT] =3D imx_clk_gate2_shared2("sai2_root_c=
lk", "sai2", base + 0x4340, 0, &share_count_sai2);
> +       clks[IMX8MQ_CLK_SAI2_IPG] =3D imx_clk_gate2_shared2("sai2_ipg_clk=
", "ipg_root", base + 0x4340, 0, &share_count_sai2);
> +       clks[IMX8MQ_CLK_SAI3_ROOT] =3D imx_clk_gate2_shared2("sai3_root_c=
lk", "sai3", base + 0x4350, 0, &share_count_sai3);
> +       clks[IMX8MQ_CLK_SAI3_IPG] =3D imx_clk_gate2_shared2("sai3_ipg_clk=
", "ipg_root", base + 0x4350, 0, &share_count_sai3);
> +       clks[IMX8MQ_CLK_SAI4_ROOT] =3D imx_clk_gate2_shared2("sai4_root_c=
lk", "sai4", base + 0x4360, 0, &share_count_sai4);
> +       clks[IMX8MQ_CLK_SAI4_IPG] =3D imx_clk_gate2_shared2("sai4_ipg_clk=
", "ipg_audio_root", base + 0x4360, 0, &share_count_sai4);
> +       clks[IMX8MQ_CLK_SAI5_ROOT] =3D imx_clk_gate2_shared2("sai5_root_c=
lk", "sai5", base + 0x4370, 0, &share_count_sai5);
> +       clks[IMX8MQ_CLK_SAI5_IPG] =3D imx_clk_gate2_shared2("sai5_ipg_clk=
", "ipg_audio_root", base + 0x4370, 0, &share_count_sai5);
> +       clks[IMX8MQ_CLK_SAI6_ROOT] =3D imx_clk_gate2_shared2("sai6_root_c=
lk", "sai6", base + 0x4380, 0, &share_count_sai6);
> +       clks[IMX8MQ_CLK_SAI6_IPG] =3D imx_clk_gate2_shared2("sai6_ipg_clk=
", "ipg_audio_root", base + 0x4380, 0, &share_count_sai6);
> +       clks[IMX8MQ_CLK_UART1_ROOT] =3D imx_clk_gate4("uart1_root_clk", "=
uart1", base + 0x4490, 0);
> +       clks[IMX8MQ_CLK_UART2_ROOT] =3D imx_clk_gate4("uart2_root_clk", "=
uart2", base + 0x44a0, 0);
> +       clks[IMX8MQ_CLK_UART3_ROOT] =3D imx_clk_gate4("uart3_root_clk", "=
uart3", base + 0x44b0, 0);
> +       clks[IMX8MQ_CLK_UART4_ROOT] =3D imx_clk_gate4("uart4_root_clk", "=
uart4", base + 0x44c0, 0);
> +       clks[IMX8MQ_CLK_USB1_CTRL_ROOT] =3D imx_clk_gate4("usb1_ctrl_root=
_clk", "usb_core_ref", base + 0x44d0, 0);
> +       clks[IMX8MQ_CLK_USB2_CTRL_ROOT] =3D imx_clk_gate4("usb2_ctrl_root=
_clk", "usb_core_ref", base + 0x44e0, 0);
> +       clks[IMX8MQ_CLK_USB1_PHY_ROOT] =3D imx_clk_gate4("usb1_phy_root_c=
lk", "usb_phy_ref", base + 0x44f0, 0);
> +       clks[IMX8MQ_CLK_USB2_PHY_ROOT] =3D imx_clk_gate4("usb2_phy_root_c=
lk", "usb_phy_ref", base + 0x4500, 0);
> +       clks[IMX8MQ_CLK_USDHC1_ROOT] =3D imx_clk_gate4("usdhc1_root_clk",=
 "usdhc1", base + 0x4510, 0);
> +       clks[IMX8MQ_CLK_USDHC2_ROOT] =3D imx_clk_gate4("usdhc2_root_clk",=
 "usdhc2", base + 0x4520, 0);
> +       clks[IMX8MQ_CLK_WDOG1_ROOT] =3D imx_clk_gate4("wdog1_root_clk", "=
wdog", base + 0x4530, 0);
> +       clks[IMX8MQ_CLK_WDOG2_ROOT] =3D imx_clk_gate4("wdog2_root_clk", "=
wdog", base + 0x4540, 0);
> +       clks[IMX8MQ_CLK_WDOG3_ROOT] =3D imx_clk_gate4("wdog3_root_clk", "=
wdog", base + 0x4550, 0);
> +       clks[IMX8MQ_CLK_VPU_G1_ROOT] =3D imx_clk_gate2_flags("vpu_g1_root=
_clk", "vpu_g1", base + 0x4560, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENA=
BLE);
> +       clks[IMX8MQ_CLK_GPU_ROOT] =3D imx_clk_gate4("gpu_root_clk", "gpu_=
core_div", base + 0x4570, 0);
> +       clks[IMX8MQ_CLK_VPU_G2_ROOT] =3D imx_clk_gate2_flags("vpu_g2_root=
_clk", "vpu_g2", base + 0x45a0, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENA=
BLE);
> +       clks[IMX8MQ_CLK_DISP_ROOT] =3D imx_clk_gate2_shared2("disp_root_c=
lk", "disp_dc8000", base + 0x45d0, 0, &share_count_dcss);
> +       clks[IMX8MQ_CLK_DISP_AXI_ROOT]  =3D imx_clk_gate2_shared2("disp_a=
xi_root_clk", "disp_axi", base + 0x45d0, 0, &share_count_dcss);
> +       clks[IMX8MQ_CLK_DISP_APB_ROOT]  =3D imx_clk_gate2_shared2("disp_a=
pb_root_clk", "disp_apb", base + 0x45d0, 0, &share_count_dcss);
> +       clks[IMX8MQ_CLK_DISP_RTRM_ROOT] =3D imx_clk_gate2_shared2("disp_r=
trm_root_clk", "disp_rtrm", base + 0x45d0, 0, &share_count_dcss);
> +       clks[IMX8MQ_CLK_TMU_ROOT] =3D imx_clk_gate4_flags("tmu_root_clk",=
 "ipg_root", base + 0x4620, 0, CLK_IS_CRITICAL);
> +       clks[IMX8MQ_CLK_VPU_DEC_ROOT] =3D imx_clk_gate2_flags("vpu_dec_ro=
ot_clk", "vpu_bus", base + 0x4630, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_=
ENABLE);
> +       clks[IMX8MQ_CLK_CSI1_ROOT] =3D imx_clk_gate4("csi1_root_clk", "cs=
i1_core", base + 0x4650, 0);
> +       clks[IMX8MQ_CLK_CSI2_ROOT] =3D imx_clk_gate4("csi2_root_clk", "cs=
i2_core", base + 0x4660, 0);
> +       clks[IMX8MQ_CLK_SDMA1_ROOT] =3D imx_clk_gate4("sdma1_clk", "ipg_r=
oot", base + 0x43a0, 0);
> +       clks[IMX8MQ_CLK_SDMA2_ROOT] =3D imx_clk_gate4("sdma2_clk", "ipg_a=
udio_root", base + 0x43b0, 0);
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

And if this fails?

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

Is there a reason this can't be done with assigned clock rates and
assigned clock parents?

> +}
> +
> +CLK_OF_DECLARE(imx8mq, "fsl,imx8mq-ccm", imx8mq_clocks_init);

Can you add a comment indicating why this can't be a platform driver?
Otherwise this should be a platform driver.

