Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C10FC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B8C2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547250975;
	bh=FvrIwQ31pL3FRVTP4WBRQllOu8nZ60ny2EBaPgmiGmY=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=1rPBVc4eYeK3CkKBzjBFpy/TuBkSm+LrAj4ci/8HsAQjtoWOdVzBvEIV+rqQfQKeN
	 32wtjaQ+etR7My5RCzNjhNKaT2t9WlWKI49NdO2A5PuyUy3FXvckWG0NXVButhaAJD
	 ejQ4aVCkNN7R62Pb628Nft+kaNCQ571lRScN4g+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfAKX4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfAKX4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:56:14 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96C3920835;
        Fri, 11 Jan 2019 23:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547250972;
        bh=FvrIwQ31pL3FRVTP4WBRQllOu8nZ60ny2EBaPgmiGmY=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=wOwoXjUH1YJsBvY6+sosj9koOBqq40BORV1182r3quAPc4wLM6e02adpJcT0KA+yz
         a1EEz4Sch96cUvyI/88K7sytiAKfnNhw0ZfENE/kuty042MS826uoxpPz4yaj1MZ1W
         y0xX2mIZiY2x56LCtW7znye46OFcCNg3sDa2wB+M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/6] clk: actions: Add clock driver for S500 SoC
User-Agent: alot/0.8
In-Reply-To: <20181231185517.18517-6-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org> <20181231185517.18517-6-manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        afaerber@suse.de, mturquette@baylibre.com, robh+dt@kernel.org
Message-ID: <154725097174.169631.1773315055825741424@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 15:56:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2018-12-31 10:55:16)
> diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s50=
0.c
> new file mode 100644
> index 000000000000..93feea8d71e2
> --- /dev/null
> +++ b/drivers/clk/actions/owl-s500.c
> @@ -0,0 +1,524 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//

Please make the reset of these the typical /* type of comments.

> +// Actions Semi Owl S500 SoC clock driver
> +//
> +// Copyright (c) 2014 Actions Semi Inc.
> +// Author: David Liu <liuwei@actions-semi.com>
> +//
> +// Copyright (c) 2018 Linaro Ltd.
> +// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +//
> +// Copyright (c) 2018 LSI-TEC - Caninos Loucos
> +// Author: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>

I'm amazed nothing else is required to be included.

[..]
> +#define CMU_NANDPLLDEBUG               (0x00E4)
> +#define CMU_DISPLAYPLLDEBUG            (0x00E8)
> +#define CMU_TVOUTPLLDEBUG              (0x00EC)
> +#define CMU_DEEPCOLORPLLDEBUG          (0x00F4)
> +#define CMU_AUDIOPLL_ETHPLLDEBUG       (0x00F8)
> +#define CMU_CVBSPLLDEBUG               (0x00FC)
> +
> +#define OWL_S500_COREPLL_DELAY         (150)
> +#define OWL_S500_DDRPLL_DELAY          (63)
> +#define OWL_S500_DEVPLL_DELAY          (28)
> +#define OWL_S500_NANDPLL_DELAY         (44)
> +#define OWL_S500_DISPLAYPLL_DELAY      (57)
> +#define OWL_S500_ETHERNETPLL_DELAY     (25)
> +#define OWL_S500_AUDIOPLL_DELAY                (100)
> +
> +static const struct clk_pll_table clk_audio_pll_table[] =3D {
> +       { 0, 45158400 }, { 1, 49152000 },
> +       { 0, 0 },
> +};
> +
> +/* pll clocks */
> +static OWL_PLL_NO_PARENT_DELAY(ethernet_pll_clk, "ethernet_pll_clk", CMU=
_ETHERNETPLL, 500000000, 0, 0, 0, 0, 0, OWL_S500_ETHERNETPLL_DELAY, NULL, C=
LK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT_DELAY(core_pll_clk, "core_pll_clk", CMU_COREPLL=
, 12000000, 9, 0, 8, 4, 134, OWL_S500_COREPLL_DELAY, NULL, CLK_IGNORE_UNUSE=
D);
> +static OWL_PLL_NO_PARENT_DELAY(ddr_pll_clk, "ddr_pll_clk", CMU_DDRPLL, 1=
2000000, 8, 0, 8, 1, 67, OWL_S500_DDRPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT_DELAY(nand_pll_clk, "nand_pll_clk", CMU_NANDPLL=
, 6000000, 8, 0, 7, 2, 86, OWL_S500_NANDPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT_DELAY(display_pll_clk, "display_pll_clk", CMU_D=
ISPLAYPLL, 6000000, 8, 0, 8, 2, 126, OWL_S500_DISPLAYPLL_DELAY, NULL, CLK_I=
GNORE_UNUSED);
> +static OWL_PLL_NO_PARENT_DELAY(dev_pll_clk, "dev_pll_clk", CMU_DEVPLL, 6=
000000, 8, 0, 7, 8, 126, OWL_S500_DEVPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT_DELAY(audio_pll_clk, "audio_pll_clk", CMU_AUDIO=
PLL, 0, 4, 0, 1, 0, 0, OWL_S500_AUDIOPLL_DELAY, clk_audio_pll_table, CLK_IG=
NORE_UNUSED);
> +
> +static const char *dev_clk_mux_p[] =3D { "hosc", "dev_pll_clk" };

These can't be const char * const ?

> +static const char *bisp_clk_mux_p[] =3D { "display_pll_clk", "dev_clk" };
> +static const char *sensor_clk_mux_p[] =3D { "hosc", "bisp_clk" };
> +static const char *sd_clk_mux_p[] =3D { "dev_clk", "nand_pll_clk" };
> +static const char *pwm_clk_mux_p[] =3D { "losc", "hosc" };
> +static const char *ahbprediv_clk_mux_p[] =3D { "dev_clk", "display_pll_c=
lk", "nand_pll_clk", "ddr_pll_clk" };
> +static const char *uart_clk_mux_p[] =3D { "hosc", "dev_pll_clk" };
> +static const char *de_clk_mux_p[] =3D { "display_pll_clk", "dev_clk" };
> +static const char *i2s_clk_mux_p[] =3D { "audio_pll_clk" };
> +static const char *hde_clk_mux_p[] =3D { "dev_clk", "display_pll_clk", "=
nand_pll_clk", "ddr_pll_clk" };
> +static const char *nand_clk_mux_p[] =3D { "nand_pll_clk", "display_pll_c=
lk", "dev_clk", "ddr_pll_clk" };
> +
> +static struct clk_factor_table sd_factor_table[] =3D {

Can these tables be const?

> +       /* bit0 ~ 4 */
> +       { 0, 1, 1 }, { 1, 1, 2 }, { 2, 1, 3 }, { 3, 1, 4 },
> +       { 4, 1, 5 }, { 5, 1, 6 }, { 6, 1, 7 }, { 7, 1, 8 },
> +       { 8, 1, 9 }, { 9, 1, 10 }, { 10, 1, 11 }, { 11, 1, 12 },
> +       { 12, 1, 13 }, { 13, 1, 14 }, { 14, 1, 15 }, { 15, 1, 16 },
> +       { 16, 1, 17 }, { 17, 1, 18 }, { 18, 1, 19 }, { 19, 1, 20 },
> +       { 20, 1, 21 }, { 21, 1, 22 }, { 22, 1, 23 }, { 23, 1, 24 },
> +       { 24, 1, 25 }, { 25, 1, 26 }, { 26, 1, 27 }, { 27, 1, 28 },
> +       { 28, 1, 29 }, { 29, 1, 30 }, { 30, 1, 31 }, { 31, 1, 32 },
> +
> +       /* bit8: /128 */
> +       { 256, 1, 1 * 128 }, { 257, 1, 2 * 128 }, { 258, 1, 3 * 128 }, { =
259, 1, 4 * 128 },
> +       { 260, 1, 5 * 128 }, { 261, 1, 6 * 128 }, { 262, 1, 7 * 128 }, { =
263, 1, 8 * 128 },
> +       { 264, 1, 9 * 128 }, { 265, 1, 10 * 128 }, { 266, 1, 11 * 128 }, =
{ 267, 1, 12 * 128 },
> +       { 268, 1, 13 * 128 }, { 269, 1, 14 * 128 }, { 270, 1, 15 * 128 },=
 { 271, 1, 16 * 128 },
> +       { 272, 1, 17 * 128 }, { 273, 1, 18 * 128 }, { 274, 1, 19 * 128 },=
 { 275, 1, 20 * 128 },
> +       { 276, 1, 21 * 128 }, { 277, 1, 22 * 128 }, { 278, 1, 23 * 128 },=
 { 279, 1, 24 * 128 },
> +       { 280, 1, 25 * 128 }, { 281, 1, 26 * 128 }, { 282, 1, 27 * 128 },=
 { 283, 1, 28 * 128 },
> +       { 284, 1, 29 * 128 }, { 285, 1, 30 * 128 }, { 286, 1, 31 * 128 },=
 { 287, 1, 32 * 128 },
> +       { 0, 0, 0 },
> +};
> +
> +static struct clk_factor_table bisp_factor_table[] =3D {
> +       { 0, 1, 1 }, { 1, 1, 2 }, { 2, 1, 3 }, { 3, 1, 4 },
> +       { 4, 1, 5 }, { 5, 1, 6 }, { 6, 1, 7 }, { 7, 1, 8 },
> +       { 0, 0, 0 },
> +};
> +
> +static struct clk_factor_table ahb_factor_table[] =3D {
> +       { 1, 1, 2 }, { 2, 1, 3 },
> +       { 0, 0, 0 },
> +};
> +
> +static struct clk_div_table rmii_ref_div_table[] =3D {
> +       { 0, 4 }, { 1, 10 },
> +       { 0, 0 },
> +};
> +
> +static struct clk_div_table i2s_div_table[] =3D {
> +       { 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
> +       { 4, 6 }, { 5, 8 }, { 6, 12 }, { 7, 16 },
> +       { 8, 24 },
> +       { 0, 0 },
> +};
> +
> +static struct clk_div_table nand_div_table[] =3D {
> +       { 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 6 },
> +       { 4, 8 }, { 5, 10 }, { 6, 12 }, { 7, 14 },
> +       { 8, 16 }, { 9, 18 }, { 10, 20 }, { 11, 22 },
> +       { 0, 0 },
> +};
> +
> +/* mux clock */
> +static OWL_MUX(dev_clk, "dev_clk", dev_clk_mux_p, CMU_DEVPLL, 12, 1, CLK=
_SET_RATE_PARENT);
> +static OWL_MUX(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p, CMU_=
BUSCLK1, 8, 3, CLK_SET_RATE_PARENT);
> +
> +/* gate clocks */
> +static OWL_GATE(spi0_clk, "spi0_clk", "ahb_clk", CMU_DEVCLKEN1, 10, 0, C=
LK_IGNORE_UNUSED);
> +static OWL_GATE(spi1_clk, "spi1_clk", "ahb_clk", CMU_DEVCLKEN1, 11, 0, C=
LK_IGNORE_UNUSED);
[...]
> +               [CLK_HDMI]              =3D &hdmi_clk.common.hw,
> +               [CLK_VDE]               =3D &vde_clk.common.hw,
> +               [CLK_VCE]               =3D &vce_clk.common.hw,
> +               [CLK_SPDIF]             =3D &spdif_clk.common.hw,
> +               [CLK_NAND]              =3D &nand_clk.common.hw,
> +               [CLK_ECC]               =3D &ecc_clk.common.hw,
> +       },
> +       .num =3D CLK_NR_CLKS,
> +};
> +
> +static struct owl_clk_desc s500_clk_desc =3D {

This can't be const?

> +       .clks       =3D s500_clks,
> +       .num_clks   =3D ARRAY_SIZE(s500_clks),
> +
> +       .hw_clks    =3D &s500_hw_clks,
> +};
> +
