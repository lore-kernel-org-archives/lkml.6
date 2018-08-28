Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E482C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC952087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Csm5py+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC952087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeH1WjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:39:08 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53143 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeH1WjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:39:08 -0400
Received: by mail-it0-f66.google.com with SMTP id h3-v6so4140237ita.2;
        Tue, 28 Aug 2018 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hroqp0V7mzceu1NvBsDUQy/jjanPm7XmQVk0ssc7Qws=;
        b=Csm5py+Or/ZxIIY954eqxcc/ODU7G/HFv7wqNTYQiOgnmbNCDgV0kJpufss24S+rcL
         aiDVF2SeXFl1sINRkgbPfGViPX2tKDMrMGvWXF4Ni02H4rOKAF5OCm13XPAsSFoKtZU2
         9V+66BHoY6WPCP9ytYtPmWoP54bqh53UX6yyjQR/ApfLaQnsVusYXGHo0Kc46rPum0lD
         wrziYkbNISg/MAvjwInBXYVbX0oPCba6g94q31HhGhATFS2OYo/4lRfOGgtCk+LdKPLt
         0upnr47DvOZxgAmdOWkvSTiglebuuyoF5zF1+bV77VvnQSe5RjUzWamZzf4N9MtmfCY9
         p42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hroqp0V7mzceu1NvBsDUQy/jjanPm7XmQVk0ssc7Qws=;
        b=QZgTyIDRbjgPTQ/sKg1cO/J699Q4BiNN1krf1vNAkxzA1RKod14PaEfRYyHQtlnDF0
         gjBmw5Y5YzF4GGsYXLKaSYVJZnb1xN1YBraFArTEASyqTKmVujbDBaIUwtmZbS9Poe24
         uphYWZ7cyuE0Xhvw0MguBnAhYr/afY0d+5QNkNz8Pt4pZ4oHxCkLRidxmHNwAWYErpo3
         whDe6HnS1EHfIJcT3gI9erzVvj5lHGWN9bZ1r+JQnZH/gNVu+hMI/rNqR8GYgR6fikO0
         dXToK0Qu3kXfSScgkEOwL+/rQyJp+FPUVR6aRytpMGaDDpwxqzIZaHIUGvHsdGKwLl1P
         +xsA==
X-Gm-Message-State: APzg51BE4n7HGrO1PmN7VP7SIKo7Rt/M6jqs+5yP8uT5Vi88laa9bjlp
        vKYM7mbwYCn/j4y0CXPbCPbi/uCbMQcg4M8SSRw=
X-Google-Smtp-Source: ANB0Vdaw6quRPLneGb1uXndiCrAAsYq6FPRFLdliLmVPOOfkHDxLuCSW/wi4XiDmkQQ85Tn4Iyh+zciQvj7/pT/t/Ko=
X-Received: by 2002:a02:7f0a:: with SMTP id r10-v6mr2612664jac.3.1535481970377;
 Tue, 28 Aug 2018 11:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com> <1534945703-4730-6-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1534945703-4730-6-git-send-email-abel.vesa@nxp.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 28 Aug 2018 11:45:58 -0700
Message-ID: <CAHQ1cqHnp9BaE91+=BMYUjC6Haz4RCLmJcrTWgVQ098FmoHrag@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] clk: imx: add clock driver for i.MX8MQ CCM
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, abelvesa@linux.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 7:05 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> From: Lucas Stach <l.stach@pengutronix.de>
>
> Add driver for the Clock Control Module found on i.MX8MQ.
>
> This is largely based on the downstream driver from Anson Huang and
> Bai Ping at NXP, with only some small adaptions to mainline from me.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/Makefile     |   1 +
>  drivers/clk/imx/clk-imx8mq.c | 631 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h        |  36 +++
>  3 files changed, 668 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-imx8mq.c
>
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 4fabb0a..64e695c 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -30,3 +30,4 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
>  obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
>  obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
>  obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
> +obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> new file mode 100644
> index 0000000..d3a9e31
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -0,0 +1,631 @@
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
> +static const char *pll_ref_sels[] = { "osc_25m", "osc_27m", "dummy", "dummy", };
> +static const char *arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
> +static const char *gpu_pll_bypass_sels[] = {"gpu_pll", "gpu_pll_ref_sel", };
> +static const char *vpu_pll_bypass_sels[] = {"vpu_pll", "vpu_pll_ref_sel", };
> +static const char *audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_ref_sel", };
> +static const char *audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_ref_sel", };
> +static const char *video_pll1_bypass_sels[] = {"video_pll1", "video_pll1_ref_sel", };
> +
> +static const char *sys1_pll1_out_sels[] = {"sys1_pll1", "sys1_pll1_ref_sel", };
> +static const char *sys2_pll1_out_sels[] = {"sys2_pll1", "sys1_pll1_ref_sel", };
> +static const char *sys3_pll1_out_sels[] = {"sys3_pll1", "sys3_pll1_ref_sel", };
> +static const char *dram_pll1_out_sels[] = {"dram_pll1", "dram_pll1_ref_sel", };
> +static const char *video2_pll1_out_sels[] = {"video2_pll1", "video2_pll1_ref_sel", };
> +
> +static const char *sys1_pll2_out_sels[] = {"sys1_pll2_div", "sys1_pll1_ref_sel", };
> +static const char *sys2_pll2_out_sels[] = {"sys2_pll2_div", "sys2_pll1_ref_sel", };
> +static const char *sys3_pll2_out_sels[] = {"sys3_pll2_div", "sys2_pll1_ref_sel", };
> +static const char *dram_pll2_out_sels[] = {"dram_pll2_div", "dram_pll1_ref_sel", };
> +static const char *video2_pll2_out_sels[] = {"video2_pll2_div", "video2_pll1_ref_sel", };
> +
> +/* CCM ROOT */
> +static const char *imx8mq_a53_sels[] = {"osc_25m", "arm_pll_out", "sys2_pll_500m", "sys2_pll_1000m",
> +                                       "sys1_pll_800m", "sys1_pll_400m", "audio_pll1_out", "sys3_pll2_out", };
> +
> +static const char *imx8mq_vpu_sels[] = {"osc_25m", "arm_pll_out", "sys2_pll_500m", "sys2_pll_1000m",
> +                                       "sys1_pll_800m", "sys1_pll_400m", "audio_pll1_out", "vpu_pll_out", };
> +
> +static const char *imx8mq_gpu_core_sels[] = {"osc_25m", "gpu_pll_out", "sys1_pll_800m", "sys3_pll2_out",
> +                                            "sys2_pll_1000m", "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_gpu_shader_sels[] = {"osc_25m", "gpu_pll_out", "sys1_pll_800m", "sys3_pll2_out",
> +                                              "sys2_pll_1000m", "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_main_axi_sels[] = {"osc_25m", "sys2_pll_333m", "sys1_pll_800m", "sys2_pll_250m",
> +                                            "sys2_pll_1000m", "audio_pll1_out", "video_pll1_out", "sys1_pll_100m",};
> +
> +static const char *imx8mq_enet_axi_sels[] = {"osc_25m", "sys1_pll_266m", "sys1_pll_800m", "sys2_pll_250m",
> +                                            "sys2_pll_200m", "audio_pll1_out", "video_pll1_out", "sys3_pll2_out", };
> +
> +static const char *imx8mq_nand_usdhc_sels[] = {"osc_25m", "sys1_pll_266m", "sys1_pll_800m", "sys2_pll_200m",
> +                                              "sys1_pll_133m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll1_out", };
> +
> +static const char *imx8mq_vpu_bus_sels[] = {"osc_25m", "sys1_pll_800m", "vpu_pll_out", "audio_pll2_out", "sys3_pll2_out", "sys2_pll_1000m", "sys2_pll_200m", "sys1_pll_100m", };
> +
> +static const char *imx8mq_disp_axi_sels[] = {"osc_25m", "sys2_pll_125m", "sys1_pll_800m", "sys3_pll2_out", "sys1_pll_400m", "audio_pll2_out", "clk_ext1", "clk_ext4", };
> +
> +static const char *imx8mq_disp_apb_sels[] = {"osc_25m", "sys2_pll_125m", "sys1_pll_800m", "sys3_pll2_out",
> +                                            "sys1_pll_40m", "audio_pll2_out", "clk_ext1", "clk_ext3", };
> +
> +static const char *imx8mq_disp_rtrm_sels[] = {"osc_25m", "sys1_pll_800m", "sys2_pll_200m", "sys1_pll_400m",
> +                                             "audio_pll1_out", "video_pll1_out", "clk_ext2", "clk_ext3", };
> +
> +static const char *imx8mq_usb_bus_sels[] = {"osc_25m", "sys2_pll_500m", "sys1_pll_800m", "sys2_pll_100m",
> +                                           "sys2_pll_200m", "clk_ext2", "clk_ext4", "audio_pll2_out", };
> +
> +static const char *imx8mq_gpu_axi_sels[] = {"osc_25m", "sys1_pll_800m", "gpu_pll_out", "sys3_pll2_out", "sys2_pll_1000m",
> +                                           "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_gpu_ahb_sels[] = {"osc_25m", "sys1_pll_800m", "gpu_pll_out", "sys3_pll2_out", "sys2_pll_1000m",
> +                                           "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_noc_sels[] = {"osc_25m", "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_1000m", "sys2_pll_500m",
> +                                       "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_noc_apb_sels[] = {"osc_25m", "sys1_pll_400m", "sys3_pll2_out", "sys2_pll_333m", "sys2_pll_200m",
> +                                           "sys1_pll_800m", "audio_pll1_out", "video_pll1_out", };
> +
> +static const char *imx8mq_ahb_sels[] = {"osc_25m", "sys1_pll_133m", "sys1_pll_800m", "sys1_pll_400m",
> +                                       "sys2_pll_125m", "sys3_pll2_out", "audio_pll1_out", "video_pll1_out", };
> +
> +static const char *imx8mq_audio_ahb_sels[] = {"osc_25m", "sys2_pll_500m", "sys1_pll_800m", "sys2_pll_1000m",
> +                                                 "sys2_pll_166m", "sys3_pll2_out", "audio_pll1_out", "video_pll1_out", };
> +
> +static const char *imx8mq_dsi_ahb_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_800m",
> +                                               "sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out"};
> +
> +static const char *imx8mq_dram_alt_sels[] = {"osc_25m", "sys1_pll_800m", "sys1_pll_100m", "sys2_pll_500m",
> +                                               "sys2_pll_250m", "sys1_pll_400m", "audio_pll1_out", "sys1_pll_266m", };
> +
> +static const char *imx8mq_dram_apb_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_40m", "sys1_pll_160m",
> +                                               "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out", };
> +
> +static const char *imx8mq_vpu_g1_sels[] = {"osc_25m", "vpu_pll_out", "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_100m", "sys2_pll_125m", "sys3_pll2_out", "audio_pll1_out", };
> +
> +static const char *imx8mq_vpu_g2_sels[] = {"osc_25m", "vpu_pll_out", "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_100m", "sys2_pll_125m", "sys3_pll2_out", "audio_pll1_out", };
> +
> +static const char *imx8mq_disp_dtrc_sels[] = {"osc_25m", "vpu_pll_out", "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_160m", "sys2_pll_100m", "sys3_pll2_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_disp_dc8000_sels[] = {"osc_25m", "vpu_pll_out", "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_160m", "sys2_pll_100m", "sys3_pll2_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_pcie1_ctrl_sels[] = {"osc_25m", "sys2_pll_250m", "sys2_pll_200m", "sys1_pll_266m",
> +                                              "sys1_pll_800m", "sys2_pll_500m", "sys2_pll_250m", "sys3_pll2_out", };
> +
> +static const char *imx8mq_pcie1_phy_sels[] = {"osc_25m", "sys2_pll_100m", "sys2_pll_500m", "clk_ext1", "clk_ext2",
> +                                             "clk_ext3", "clk_ext4", };
> +
> +static const char *imx8mq_pcie1_aux_sels[] = {"osc_25m", "sys2_pll_200m", "sys2_pll_500m", "sys3_pll2_out",
> +                                             "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_160m", "sys1_pll_200m", };
> +
> +static const char *imx8mq_dc_pixel_sels[] = {"osc_25m", "video_pll1_out", "audio_pll2_out", "audio_pll1_out", "sys1_pll_800m", "sys2_pll_1000m", "sys3_pll2_out", "clk_ext4", };
> +
> +static const char *imx8mq_lcdif_pixel_sels[] = {"osc_25m", "video_pll1_out", "audio_pll2_out", "audio_pll1_out", "sys1_pll_800m", "sys2_pll_1000m", "sys3_pll2_out", "clk_ext4", };
> +
> +static const char *imx8mq_sai1_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext1", "clk_ext2", };
> +
> +static const char *imx8mq_sai2_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2", "clk_ext3", };
> +
> +static const char *imx8mq_sai3_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3", "clk_ext4", };
> +
> +static const char *imx8mq_sai4_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext1", "clk_ext2", };
> +
> +static const char *imx8mq_sai5_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2", "clk_ext3", };
> +
> +static const char *imx8mq_sai6_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3", "clk_ext4", };
> +
> +static const char *imx8mq_spdif1_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2", "clk_ext3", };
> +
> +static const char *imx8mq_spdif2_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3", "clk_ext4", };
> +
> +static const char *imx8mq_enet_ref_sels[] = {"osc_25m", "sys2_pll_125m", "sys2_pll_500m", "sys2_pll_100m",
> +                                            "sys1_pll_160m", "audio_pll1_out", "video_pll1_out", "clk_ext4", };
> +
> +static const char *imx8mq_enet_timer_sels[] = {"osc_25m", "sys2_pll_100m", "audio_pll1_out", "clk_ext1", "clk_ext2",
> +                                              "clk_ext3", "clk_ext4", "video_pll1_out", };
> +
> +static const char *imx8mq_enet_phy_sels[] = {"osc_25m", "sys2_pll_50m", "sys2_pll_125m", "sys2_pll_500m",
> +                                            "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
> +
> +static const char *imx8mq_nand_sels[] = {"osc_25m", "sys2_pll_500m", "audio_pll1_out", "sys1_pll_400m",
> +                                        "audio_pll2_out", "sys3_pll2_out", "sys2_pll_250m", "video_pll1_out", };
> +
> +static const char *imx8mq_qspi_sels[] = {"osc_25m", "sys1_pll_400m", "sys1_pll_800m", "sys2_pll_500m",
> +                                        "audio_pll2_out", "sys1_pll_266m", "sys3_pll2_out", "sys1_pll_100m", };
> +
> +static const char *imx8mq_usdhc1_sels[] = {"osc_25m", "sys1_pll_400m", "sys1_pll_800m", "sys2_pll_500m",
> +                                        "audio_pll2_out", "sys1_pll_266m", "sys3_pll2_out", "sys1_pll_100m", };
> +
> +static const char *imx8mq_usdhc2_sels[] = {"osc_25m", "sys1_pll_400m", "sys1_pll_800m", "sys2_pll_500m",
> +                                        "audio_pll2_out", "sys1_pll_266m", "sys3_pll2_out", "sys1_pll_100m", };
> +
> +static const char *imx8mq_i2c1_sels[] = {"osc_25m", "sys1_pll_160m", "sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
> +                                        "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
> +
> +static const char *imx8mq_i2c2_sels[] = {"osc_25m", "sys1_pll_160m", "sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
> +                                        "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
> +
> +static const char *imx8mq_i2c3_sels[] = {"osc_25m", "sys1_pll_160m", "sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
> +                                        "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
> +
> +static const char *imx8mq_i2c4_sels[] = {"osc_25m", "sys1_pll_160m", "sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
> +                                        "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
> +
> +static const char *imx8mq_uart1_sels[] = {"osc_25m", "sys1_pll_80m", "sys2_pll_200m", "sys2_pll_100m",
> +                                         "sys3_pll2_out", "clk_ext2", "clk_ext4", "audio_pll2_out", };
> +
> +static const char *imx8mq_uart2_sels[] = {"osc_25m", "sys1_pll_80m", "sys2_pll_200m", "sys2_pll_100m",
> +                                         "sys3_pll2_out", "clk_ext2", "clk_ext3", "audio_pll2_out", };
> +
> +static const char *imx8mq_uart3_sels[] = {"osc_25m", "sys1_pll_80m", "sys2_pll_200m", "sys2_pll_100m",
> +                                         "sys3_pll2_out", "clk_ext2", "clk_ext4", "audio_pll2_out", };
> +
> +static const char *imx8mq_uart4_sels[] = {"osc_25m", "sys1_pll_80m", "sys2_pll_200m", "sys2_pll_100m",
> +                                         "sys3_pll2_out", "clk_ext2", "clk_ext3", "audio_pll2_out", };
> +
> +static const char *imx8mq_usb_core_sels[] = {"osc_25m", "sys1_pll_100m", "sys1_pll_40m", "sys2_pll_100m",
> +                                            "sys2_pll_200m", "clk_ext2", "clk_ext3", "audio_pll2_out", };
> +
> +static const char *imx8mq_usb_phy_sels[] = {"osc_25m", "sys1_pll_100m", "sys1_pll_40m", "sys2_pll_100m",
> +                                            "sys2_pll_200m", "clk_ext2", "clk_ext3", "audio_pll2_out", };
> +
> +static const char *imx8mq_ecspi1_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_40m", "sys1_pll_160m",
> +                                          "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out", };
> +
> +static const char *imx8mq_ecspi2_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_40m", "sys1_pll_160m",
> +                                          "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out", };
> +
> +static const char *imx8mq_pwm1_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_160m", "sys1_pll_40m",
> +                                        "sys3_pll2_out", "clk_ext1", "sys1_pll_80m", "video_pll1_out", };
> +
> +static const char *imx8mq_pwm2_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_160m", "sys1_pll_40m",
> +                                        "sys3_pll2_out", "clk_ext1", "sys1_pll_80m", "video_pll1_out", };
> +
> +static const char *imx8mq_pwm3_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_160m", "sys1_pll_40m",
> +                                        "sys3_pll2_out", "clk_ext2", "sys1_pll_80m", "video_pll1_out", };
> +
> +static const char *imx8mq_pwm4_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_160m", "sys1_pll_40m",
> +                                        "sys3_pll2_out", "clk_ext2", "sys1_pll_80m", "video_pll1_out", };
> +
> +static const char *imx8mq_gpt1_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_400m", "sys1_pll_40m",
> +                                        "sys1_pll_80m", "audio_pll1_out", "clk_ext1", };
> +
> +static const char *imx8mq_wdog_sels[] = {"osc_25m", "sys1_pll_133m", "sys1_pll_160m", "vpu_pll_out",
> +                                        "sys2_pll_125m", "sys3_pll2_out", "sys1_pll_80m", "sys2_pll_166m", };
> +
> +static const char *imx8mq_wrclk_sels[] = {"osc_25m", "sys1_pll_40m", "vpu_pll_out", "sys3_pll2_out", "sys2_pll_200m",
> +                                         "sys1_pll_266m", "sys2_pll_500m", "sys1_pll_100m", };
> +
> +static const char *imx8mq_dsi_core_sels[] = {"osc_25m", "sys1_pll_266m", "sys2_pll_250m", "sys1_pll_800m",
> +                                            "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll1_out", };
> +
> +static const char *imx8mq_dsi_phy_sels[] = {"osc_25m", "sys2_pll_125m", "sys2_pll_100m", "sys1_pll_800m",
> +                                           "sys2_pll_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out", };
> +
> +static const char *imx8mq_dsi_dbi_sels[] = {"osc_25m", "sys1_pll_266m", "sys2_pll_100m", "sys1_pll_800m",
> +                                           "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll1_out", };
> +
> +static const char *imx8mq_dsi_esc_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_800m",
> +                                           "sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out", };
> +
> +static const char *imx8mq_csi1_core_sels[] = {"osc_25m", "sys1_pll_266m", "sys2_pll_250m", "sys1_pll_800m",
> +                                             "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll1_out", };
> +
> +static const char *imx8mq_csi1_phy_sels[] = {"osc_25m", "sys2_pll_125m", "sys2_pll_100m", "sys1_pll_800m",
> +                                            "sys2_pll_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out", };
> +
> +static const char *imx8mq_csi1_esc_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_800m",
> +                                            "sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out", };
> +
> +static const char *imx8mq_csi2_core_sels[] = {"osc_25m", "sys1_pll_266m", "sys2_pll_250m", "sys1_pll_800m",
> +                                             "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll1_out", };
> +
> +static const char *imx8mq_csi2_phy_sels[] = {"osc_25m", "sys2_pll_125m", "sys2_pll_100m", "sys1_pll_800m",
> +                                            "sys2_pll_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out", };
> +
> +static const char *imx8mq_csi2_esc_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_800m",
> +                                            "sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out", };
> +
> +static const char *imx8mq_pcie2_ctrl_sels[] = {"osc_25m", "sys2_pll_250m", "sys2_pll_200m", "sys1_pll_266m",
> +                                              "sys1_pll_800m", "sys2_pll_500m", "sys2_pll_333m", "sys3_pll2_out", };
> +
> +static const char *imx8mq_pcie2_phy_sels[] = {"osc_25m", "sys2_pll_100m", "sys2_pll_500m", "clk_ext1",
> +                                             "clk_ext2", "clk_ext3", "clk_ext4", "sys1_pll_400m", };
> +
> +static const char *imx8mq_pcie2_aux_sels[] = {"osc_25m", "sys2_pll_200m", "sys2_pll_50m", "sys3_pll2_out",
> +                                             "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_160m", "sys1_pll_200m", };
> +
> +static const char *imx8mq_ecspi3_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_40m", "sys1_pll_160m",
> +                                          "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out", };
> +static const char *imx8mq_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
> +
> +static const char *imx8mq_clko2_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_400m", "sys2_pll_166m", "audio_pll1_out",
> +                                        "video_pll1_out", "ckil", };
> +
> +static int const clks_init_on[] __initconst = {
> +       IMX8MQ_CLK_DRAM_CORE, IMX8MQ_CLK_AHB_CG,
> +       IMX8MQ_CLK_NOC, IMX8MQ_CLK_NOC_APB,
> +       IMX8MQ_CLK_USB_BUS, IMX8MQ_CLK_NAND_USDHC_BUS,
> +       IMX8MQ_CLK_MAIN_AXI, IMX8MQ_CLK_A53_CG,
> +       IMX8MQ_CLK_AUDIO_AHB_DIV, IMX8MQ_CLK_TMU_ROOT,
> +       IMX8MQ_CLK_DRAM_APB,
> +};
> +
> +static struct clk_onecell_data clk_data;
> +
> +static void __init imx8mq_clocks_init(struct device_node *ccm_node)
> +{
> +       struct device_node *np;
> +       void __iomem *base;
> +       int i;
> +
> +       clks[IMX8MQ_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
> +       clks[IMX8MQ_CLK_32K] = of_clk_get_by_name(ccm_node, "ckil");
> +       clks[IMX8MQ_CLK_25M] = of_clk_get_by_name(ccm_node, "osc_25m");
> +       clks[IMX8MQ_CLK_27M] = of_clk_get_by_name(ccm_node, "osc_27m");
> +       clks[IMX8MQ_CLK_EXT1] = of_clk_get_by_name(ccm_node, "clk_ext1");
> +       clks[IMX8MQ_CLK_EXT2] = of_clk_get_by_name(ccm_node, "clk_ext2");
> +       clks[IMX8MQ_CLK_EXT3] = of_clk_get_by_name(ccm_node, "clk_ext3");
> +       clks[IMX8MQ_CLK_EXT4] = of_clk_get_by_name(ccm_node, "clk_ext4");
> +
> +       np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop");
> +       base = of_iomap(np, 0);
> +       WARN_ON(!base);
> +
> +       clks[IMX8MQ_ARM_PLL_REF_SEL] = imx_clk_mux("arm_pll_ref_sel", base + 0x28, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_GPU_PLL_REF_SEL] = imx_clk_mux("gpu_pll_ref_sel", base + 0x18, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_VPU_PLL_REF_SEL] = imx_clk_mux("vpu_pll_ref_sel", base + 0x20, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_AUDIO_PLL1_REF_SEL] = imx_clk_mux("audio_pll1_ref_sel", base + 0x0, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_AUDIO_PLL2_REF_SEL] = imx_clk_mux("audio_pll2_ref_sel", base + 0x8, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_VIDEO_PLL1_REF_SEL] = imx_clk_mux("video_pll1_ref_sel", base + 0x10, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_SYS1_PLL1_REF_SEL]  = imx_clk_mux("sys1_pll1_ref_sel", base + 0x30, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_SYS2_PLL1_REF_SEL]  = imx_clk_mux("sys2_pll1_ref_sel", base + 0x3c, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_SYS3_PLL1_REF_SEL]  = imx_clk_mux("sys3_pll1_ref_sel", base + 0x48, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_DRAM_PLL1_REF_SEL]  = imx_clk_mux("dram_pll1_ref_sel", base + 0x60, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +       clks[IMX8MQ_VIDEO2_PLL1_REF_SEL] = imx_clk_mux("video2_pll1_ref_sel", base + 0x54, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +
> +       clks[IMX8MQ_ARM_PLL_REF_DIV]    = imx_clk_divider("arm_pll_ref_div", "arm_pll_ref_sel", base + 0x28, 5, 6);
> +       clks[IMX8MQ_GPU_PLL_REF_DIV]    = imx_clk_divider("gpu_pll_ref_div", "gpu_pll_ref_sel", base + 0x18, 5, 6);
> +       clks[IMX8MQ_VPU_PLL_REF_DIV]    = imx_clk_divider("vpu_pll_ref_div", "vpu_pll_ref_sel", base + 0x20, 5, 6);
> +       clks[IMX8MQ_AUDIO_PLL1_REF_DIV] = imx_clk_divider("audio_pll1_ref_div", "audio_pll1_ref_sel", base + 0x0, 5, 6);
> +       clks[IMX8MQ_AUDIO_PLL2_REF_DIV] = imx_clk_divider("audio_pll2_ref_div", "audio_pll2_ref_sel", base + 0x8, 5, 6);
> +       clks[IMX8MQ_VIDEO_PLL1_REF_DIV] = imx_clk_divider("video_pll1_ref_div", "video_pll1_ref_sel", base + 0x10, 5, 6);
> +       clks[IMX8MQ_SYS1_PLL1_REF_DIV]  = imx_clk_divider("sys1_pll1_ref_div", "sys1_pll1_ref_sel", base + 0x38, 25, 3);
> +       clks[IMX8MQ_SYS2_PLL1_REF_DIV]  = imx_clk_divider("sys2_pll1_ref_div", "sys2_pll1_ref_sel", base + 0x44, 25, 3);
> +       clks[IMX8MQ_SYS3_PLL1_REF_DIV]  = imx_clk_divider("sys3_pll1_ref_div", "sys3_pll1_ref_sel", base + 0x50, 25, 3);
> +       clks[IMX8MQ_DRAM_PLL1_REF_DIV]  = imx_clk_divider("dram_pll1_ref_div", "dram_pll1_ref_sel", base + 0x68, 25, 3);
> +       clks[IMX8MQ_VIDEO2_PLL1_REF_DIV]  = imx_clk_divider("video2_pll1_ref_div", "video2_pll1_ref_sel", base + 0x5c, 25, 3);
> +
> +       clks[IMX8MQ_ARM_PLL] = imx_clk_frac_pll("arm_pll", "arm_pll_ref_div", base + 0x28);
> +       clks[IMX8MQ_GPU_PLL] = imx_clk_frac_pll("gpu_pll", "gpu_pll_ref_div", base + 0x18);
> +       clks[IMX8MQ_VPU_PLL] = imx_clk_frac_pll("vpu_pll", "vpu_pll_ref_div", base + 0x20);
> +       clks[IMX8MQ_AUDIO_PLL1] = imx_clk_frac_pll("audio_pll1", "audio_pll1_ref_div", base + 0x0);
> +       clks[IMX8MQ_AUDIO_PLL2] = imx_clk_frac_pll("audio_pll2", "audio_pll2_ref_div", base + 0x8);
> +       clks[IMX8MQ_VIDEO_PLL1] = imx_clk_frac_pll("video_pll1", "video_pll1_ref_div", base + 0x10);
> +       clks[IMX8MQ_SYS1_PLL1] = imx_clk_sccg_pll("sys1_pll1", "sys1_pll1_ref_div", base + 0x30, SCCG_PLL1);
> +       clks[IMX8MQ_SYS2_PLL1] = imx_clk_sccg_pll("sys2_pll1", "sys2_pll1_ref_div", base + 0x3c, SCCG_PLL1);
> +       clks[IMX8MQ_SYS3_PLL1] = imx_clk_sccg_pll("sys3_pll1", "sys3_pll1_ref_div", base + 0x48, SCCG_PLL1);
> +       clks[IMX8MQ_DRAM_PLL1] = imx_clk_sccg_pll("dram_pll1", "dram_pll1_ref_div", base + 0x60, SCCG_PLL1);
> +       clks[IMX8MQ_VIDEO2_PLL1] = imx_clk_sccg_pll("video2_pll1", "video2_pll1_ref_div", base + 0x5c, 3);

This is a bug which will result in a crash once IMX8MQ_VIDEO2_PLL1 is
exercised (I know that from having to debug this issue when using this
code in Barebox). Last argument should be SCCG_PLL1.

Thanks,
Andrey Smirnov
