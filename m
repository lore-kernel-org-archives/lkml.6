Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCB6C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE7920892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EypQyfZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE7920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbeKGVkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:40:00 -0500
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:6976
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbeKGVkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4v/bLqWC0hxN7Hfq0KxkP48c0OL2Xgi+QxjN4/+PTE=;
 b=EypQyfZYvg9/dGgZiKJdE7u0kUz2C6LMXVG3LxZZ7DV0kboYrvSqkWeY6qhesJ3LC3wlL4Q4EHfusSmgvM7Ax29KUABJB6IWENyLUEYzJW9batNwOkbmdRK5bKSRJRiD7xP/RKRljT8M2j3YuCvDkBNGE/E17flFbTm/Tq5Z5d8=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3509.eurprd04.prod.outlook.com (52.133.19.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.36; Wed, 7 Nov 2018 12:09:47 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b%4]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 12:09:47 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abelvesa@linux.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v9 5/5] clk: imx: add clock driver for i.MX8MQ CCM
Thread-Topic: [PATCH v9 5/5] clk: imx: add clock driver for i.MX8MQ CCM
Thread-Index: AQHUU/MSa/BTvyU0uEeyQD5qlNzlsqUj+9cAgCCBzgA=
Date:   Wed, 7 Nov 2018 12:09:47 +0000
Message-ID: <20181107120946.myvj6kaoudyi4kzf@fsr-ub1664-175>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-6-git-send-email-abel.vesa@nxp.com>
 <153980549223.5275.1496899374465535150@swboyd.mtv.corp.google.com>
In-Reply-To: <153980549223.5275.1496899374465535150@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3509;6:Lw2HWiLSduvXFVOURgcrUk0ll99kXxqq2OgfwawztRHqD4BfIuFUcCx+3PiwBJ41b890x2oHAsHwI7T25chzuGPf2S7woHjw1jECo4Zmm/ap2/mwsfcUld/ZcLNsYX3azT3IAN+ShOR43GPSyTjWAqhbSY8Mfyai2gyOJIEA13CFIYHtNCeKVRVDq6r+8HQQoIudFClyq8j33tYLMCZaj7DAkG7SJ1AQvUn4zhua41mvmgzwevDzvN9MH+j3Z8yLPWdz6lnXF0xF55DeTqC+3bRgUugFR9afhjxFQZVh6LluFyo9f05U5aYNAoFLIpoorCP+JAnsZfVP/yQD7bktJwxgEzkTCoBec3JoO0IHTLVI9FAN6ONnXpBhqHZO4TjRGUJ1n3nR4cEydmtJozEhRl4VV6i46Hs1dGce7SvGgbx5avDd4WXnlQRnX9HiujWGuMEeJQF4+2/orxP5+OzrLg==;5:megELjVD7y9V4ieSeJ/v+TJF88y4cnn6WWaSRGU++82e+5PhmUAaqw0t3JwGK2/OpzkreUk5OLvtdfD6SUlCUvs1Z8C1Nn4hTrU45PM+m2IsDX/jgYd/A83a/D9SIHRgPNC6nNbbCAc6YkpKZ9ErqQyEUjI92Hhs/EcCKC7nRWs=;7:rkhJpZHc7IUlTYUSXOqvhWCXFoiKOsRUU/HyZKGpC1h2xMkkV2LqSlR0kU9AqEJASaxnSRJ8yCa8Zm0A/x1Y1G9eNqBc/G/mgkRztQu8JVtgQvcoO2LZ1p6k10WdZz7h6dJfkXfCP6jhZAYLdxb7eg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 37eb6953-6244-4117-4047-08d644a9e94d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3509;
x-ms-traffictypediagnostic: AM6PR0402MB3509:
x-microsoft-antispam-prvs: <AM6PR0402MB3509F5DEA759F726C986A1F4F6C40@AM6PR0402MB3509.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3509;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3509;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(136003)(396003)(366004)(376002)(39860400002)(199004)(189003)(71190400001)(71200400001)(256004)(446003)(1076002)(14444005)(6246003)(11346002)(2900100001)(39060400002)(14454004)(53936002)(25786009)(478600001)(44832011)(33896004)(6512007)(9686003)(81156014)(476003)(6116002)(3846002)(6506007)(4326008)(486006)(54906003)(97736004)(76176011)(229853002)(33716001)(102836004)(8936002)(316002)(99286004)(2906002)(6916009)(106356001)(81166006)(105586002)(6436002)(66066001)(575784001)(7736002)(86362001)(7416002)(68736007)(8676002)(26005)(305945005)(6486002)(5660300001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3509;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UGYk8jQPWNHVCfDnQ8Mf/jJIh1snFzEtrDIJ8gmANPbBFyun3nGf8Ms0u+ePotGuxrL2lFRTvCel/OwT7AAEv+Ar3pjAbjGzasMxT13RMEZ58A02huqrmjECg89ljxBR/ZACwirepqeX+Ye3e+n1RXVE9XEYd5d6MVcmvNbbWwnHhiGGggZT9w5AaPQnnQZeWLGYATUVeSl+slXW3fikDIMyQIbg3wssElpndZqF4JeeW2F0ei7/Bw5cM4HGLp6A4KcRxtzJIl0oAeqaAOj2NCBDuJ3msUOAtRZyePSLoDu0tS4wAwKqDMGZnKXIwnhbJhD2kvOj76d6ZZhZDPZZObwxXA0Hl3FUyF6H7ekWgHE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <629A11B30A49654CAFF3B521EA596989@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37eb6953-6244-4117-4047-08d644a9e94d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 12:09:47.3219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:44:52PM -0700, Stephen Boyd wrote:
> Quoting Abel Vesa (2018-09-24 03:39:57)
> > From: Lucas Stach <l.stach@pengutronix.de>
> >=20
> > Add driver for the Clock Control Module found on i.MX8MQ.
> >=20
> > This is largely based on the downstream driver from Anson Huang and
> > Bai Ping at NXP, plus the imx composite clock from Abel Vesa at NXP,
> > with only some small adaptions to mainline from me.
>=20
> Can you point to the downstream driver so we can know what small
> adaptations were made.
>=20

It's was implemented originally in NXP's internal tree. The adaptations
to the initial implementation are not that small anymore. I even changed th=
e
authorship since it has changed quite a lot compared to the initial version=
.

> >=20
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  drivers/clk/imx/Makefile     |   1 +
> >  drivers/clk/imx/clk-imx8mq.c | 602 +++++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/clk/imx/clk.h        |  36 +++
> >  3 files changed, 639 insertions(+)
> >  create mode 100644 drivers/clk/imx/clk-imx8mq.c
> >=20
> > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> > index 4fabb0a..64e695c 100644
> > --- a/drivers/clk/imx/Makefile
> > +++ b/drivers/clk/imx/Makefile
> > @@ -30,3 +30,4 @@ obj-$(CONFIG_SOC_IMX6SX) +=3D clk-imx6sx.o
> >  obj-$(CONFIG_SOC_IMX6UL) +=3D clk-imx6ul.o
> >  obj-$(CONFIG_SOC_IMX7D)  +=3D clk-imx7d.o
> >  obj-$(CONFIG_SOC_VF610)  +=3D clk-vf610.o
> > +obj-$(CONFIG_SOC_IMX8MQ) +=3D clk-imx8mq.o
>=20
> Please try to keep this alphabetical on CONFIG symbol.
>=20

Fixed in the next version.

> > diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.=
c
> > new file mode 100644
> > index 0000000..aadb523
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-imx8mq.c
> > @@ -0,0 +1,602 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2018 NXP.
> > + * Copyright (C) 2017 Pengutronix, Lucas Stach <kernel@pengutronix.de>
> > + */
> > +
> > +#include <dt-bindings/clock/imx8mq-clock.h>
> > +#include <linux/clk.h>
> > +#include <linux/clkdev.h>
>=20
> Are these two includes used?
>=20

clkdev.h include is removed in the next version.
clk.h is needed by of_clk_get_by_name.

> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/types.h>
> > +
> > +#include "clk.h"
> > +
> > +static u32 share_count_sai1;
> > +static u32 share_count_sai2;
> > +static u32 share_count_sai3;
> > +static u32 share_count_sai4;
> > +static u32 share_count_sai5;
> > +static u32 share_count_sai6;
> > +static u32 share_count_dcss;
> > +static u32 share_count_nand;
> > +
> [...]
> > +
> > +static const char *imx8mq_ecspi3_sels[] =3D {"osc_25m", "sys2_pll_200m=
", "sys1_pll_40m", "sys1_pll_160m",
> > +                                          "sys1_pll_800m", "sys3_pll2_=
out", "sys2_pll_250m", "audio_pll2_out", };
> > +static const char *imx8mq_dram_core_sels[] =3D {"dram_pll_out", "dram_=
alt_root", };
> > +
> > +static const char *imx8mq_clko2_sels[] =3D {"osc_25m", "sys2_pll_200m"=
, "sys1_pll_400m", "sys2_pll_166m", "audio_pll1_out",
> > +                                        "video_pll1_out", "ckil", };
> > +
> > +static struct clk_onecell_data clk_data;
> > +
> > +static void __init imx8mq_clocks_init(struct device_node *ccm_node)
> > +{
> > +       struct device_node *np;
> > +       void __iomem *base;
> > +       int i;
> > +
> > +       clks[IMX8MQ_CLK_DUMMY] =3D imx_clk_fixed("dummy", 0);
> > +       clks[IMX8MQ_CLK_32K] =3D of_clk_get_by_name(ccm_node, "ckil");
> > +       clks[IMX8MQ_CLK_25M] =3D of_clk_get_by_name(ccm_node, "osc_25m"=
);
> > +       clks[IMX8MQ_CLK_27M] =3D of_clk_get_by_name(ccm_node, "osc_27m"=
);
> > +       clks[IMX8MQ_CLK_EXT1] =3D of_clk_get_by_name(ccm_node, "clk_ext=
1");
> > +       clks[IMX8MQ_CLK_EXT2] =3D of_clk_get_by_name(ccm_node, "clk_ext=
2");
> > +       clks[IMX8MQ_CLK_EXT3] =3D of_clk_get_by_name(ccm_node, "clk_ext=
3");
> > +       clks[IMX8MQ_CLK_EXT4] =3D of_clk_get_by_name(ccm_node, "clk_ext=
4");
> > +
> > +       np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop")=
;
> > +       base =3D of_iomap(np, 0);
> > +       WARN_ON(!base);
>=20
> And if that fails? return without continuing?
>=20

Fixed in the next version.

> > +
> > +       clks[IMX8MQ_ARM_PLL_REF_SEL] =3D imx_clk_mux("arm_pll_ref_sel",=
 base + 0x28, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> > +       clks[IMX8MQ_GPU_PLL_REF_SEL] =3D imx_clk_mux("gpu_pll_ref_sel",=
 base + 0x18, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> > +       clks[IMX8MQ_VPU_PLL_REF_SEL] =3D imx_clk_mux("vpu_pll_ref_sel",=
 base + 0x20, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> > +       clks[IMX8MQ_AUDIO_PLL1_REF_SEL] =3D imx_clk_mux("audio_pll1_ref=
_sel", base + 0x0, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> [..]
> > +       clks[IMX8MQ_CLK_DSI_CORE] =3D imx_clk_composite("dsi_core", imx=
8mq_dsi_core_sels, base + 0xbb00);
> > +       clks[IMX8MQ_CLK_DSI_PHY_REF] =3D imx_clk_composite("dsi_phy_ref=
", imx8mq_dsi_phy_sels, base + 0xbb80);
> > +       clks[IMX8MQ_CLK_DSI_DBI] =3D imx_clk_composite("dsi_dbi", imx8m=
q_dsi_dbi_sels, base + 0xbc00);
> > +       clks[IMX8MQ_CLK_DSI_ESC] =3D imx_clk_composite("dsi_esc", imx8m=
q_dsi_esc_sels, base + 0xbc80);
> > +       clks[IMX8MQ_CLK_DSI_AHB] =3D imx_clk_composite("dsi_ahb", imx8m=
q_dsi_ahb_sels, base + 0x9200);
> > +       clks[IMX8MQ_CLK_CSI1_CORE] =3D imx_clk_composite("csi1_core", i=
mx8mq_csi1_core_sels, base + 0xbd00);
> > +       clks[IMX8MQ_CLK_CSI1_PHY_REF] =3D imx_clk_composite("csi1_phy_r=
ef", imx8mq_csi1_phy_sels, base + 0xbd80);
> > +       clks[IMX8MQ_CLK_CSI1_ESC] =3D imx_clk_composite("csi1_esc", imx=
8mq_csi1_esc_sels, base + 0xbe00);
> > +       clks[IMX8MQ_CLK_CSI2_CORE] =3D imx_clk_composite("csi2_core", i=
mx8mq_csi2_core_sels, base + 0xbe80);
> > +       clks[IMX8MQ_CLK_CSI2_PHY_REF] =3D imx_clk_composite("csi2_phy_r=
ef", imx8mq_csi2_phy_sels, base + 0xbf00);
> > +       clks[IMX8MQ_CLK_CSI2_ESC] =3D imx_clk_composite("csi2_esc", imx=
8mq_csi2_esc_sels, base + 0xbf80);
> > +       clks[IMX8MQ_CLK_PCIE2_CTRL] =3D imx_clk_composite("pcie2_ctrl",=
 imx8mq_pcie2_ctrl_sels, base + 0xc000);
> > +       clks[IMX8MQ_CLK_PCIE2_PHY] =3D imx_clk_composite("pcie2_phy", i=
mx8mq_pcie2_phy_sels, base + 0xc080);
> > +       clks[IMX8MQ_CLK_PCIE2_AUX] =3D imx_clk_composite("pcie2_aux", i=
mx8mq_pcie2_aux_sels, base + 0xc100);
> > +       clks[IMX8MQ_CLK_ECSPI3] =3D imx_clk_composite("ecspi3", imx8mq_=
ecspi3_sels, base + 0xc180);
> > +
> > +       /*FIXME, the doc is not ready now */
>=20
> What does this mean?
>=20

The comment does not apply anymore. It is remoed in the next version.
When the driver was initially implemented, the specs doc was not ready.

> > +       clks[IMX8MQ_CLK_ECSPI1_ROOT] =3D imx_clk_gate4("ecspi1_root_clk=
", "ecspi1", base + 0x4070, 0);
> > +       clks[IMX8MQ_CLK_ECSPI2_ROOT] =3D imx_clk_gate4("ecspi2_root_clk=
", "ecspi2", base + 0x4080, 0);
> > +       clks[IMX8MQ_CLK_ECSPI3_ROOT] =3D imx_clk_gate4("ecspi3_root_clk=
", "ecspi3", base + 0x4090, 0);
> > +       clks[IMX8MQ_CLK_ENET1_ROOT] =3D imx_clk_gate4("enet1_root_clk",=
 "enet_axi", base + 0x40a0, 0);
> > +       clks[IMX8MQ_CLK_GPT1_ROOT] =3D imx_clk_gate4("gpt1_root_clk", "=
gpt1", base + 0x4100, 0);
> [...]
> > +
> > +       clks[IMX8MQ_GPT_3M_CLK] =3D imx_clk_fixed_factor("gpt_3m", "osc=
_25m", 1, 8);
> > +       clks[IMX8MQ_CLK_DRAM_ALT_ROOT] =3D imx_clk_fixed_factor("dram_a=
lt_root", "dram_alt", 1, 4);
> > +
> > +       for (i =3D 0; i < IMX8MQ_CLK_END; i++)
> > +               if (IS_ERR(clks[i]))
> > +                       pr_err("i.MX8mq clk %u register failed with %ld=
\n",
> > +                              i, PTR_ERR(clks[i]));
> > +
> > +       clk_data.clks =3D clks;
> > +       clk_data.clk_num =3D ARRAY_SIZE(clks);
> > +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>=20
> Any chance to move to using clk_hw based provider and clk registration
> APIs?
>=20

Since a lot of the imx clocks that are already upstream and since it's not
quite a small change, I would prefer if this would go in as is. I intend to
make the switch to clk_hw based registration later, but it will take some t=
ime
for me to get that ready and that would delay the upstream of imx8mq driver=
s
even more.

All the new clock types introduced now are clk_hw based.

> > +
> > +       clk_set_parent(clks[IMX8MQ_CLK_AHB], clks[IMX8MQ_SYS1_PLL_133M]=
);
> > +       clk_set_parent(clks[IMX8MQ_CLK_NAND_USDHC_BUS], clks[IMX8MQ_SYS=
1_PLL_266M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_AUDIO_AHB], clks[IMX8MQ_SYS2_PLL=
_500M]);
> > +
> > +       /* config video_pll1 clock */
> > +       clk_set_parent(clks[IMX8MQ_VIDEO_PLL1_REF_SEL], clks[IMX8MQ_CLK=
_27M]);
> > +       clk_set_rate(clks[IMX8MQ_VIDEO_PLL1], 593999999);
> > +
> > +       /* increase NOC clock to achieve best DDR access performance */
> > +       clk_set_rate(clks[IMX8MQ_CLK_NOC], clk_get_rate(clks[IMX8MQ_SYS=
1_PLL_800M]));
> > +
> > +       /* set pcie root's parent clk source */
> > +       clk_set_parent(clks[IMX8MQ_CLK_PCIE1_CTRL], clks[IMX8MQ_SYS2_PL=
L_250M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_PCIE1_PHY], clks[IMX8MQ_SYS2_PLL=
_100M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_PCIE2_CTRL], clks[IMX8MQ_SYS2_PL=
L_250M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_PCIE2_PHY], clks[IMX8MQ_SYS2_PLL=
_100M]);
> > +
> > +       clk_set_parent(clks[IMX8MQ_CLK_CSI1_CORE], clks[IMX8MQ_SYS1_PLL=
_266M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_CSI1_PHY_REF], clks[IMX8MQ_SYS2_=
PLL_1000M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_CSI1_ESC], clks[IMX8MQ_SYS1_PLL_=
800M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_CSI2_CORE], clks[IMX8MQ_SYS1_PLL=
_266M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_CSI2_PHY_REF], clks[IMX8MQ_SYS2_=
PLL_1000M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_CSI2_ESC], clks[IMX8MQ_SYS1_PLL_=
800M]);
>=20
> Can this be done with assigned clock parents and assigned clock rates?
>=20

Fair enough. Removed entirely in the next version. Each driver will set its
own rate and parent in dts later on.

> > +}
> > +
> > +CLK_OF_DECLARE(imx8mq, "fsl,imx8mq-ccm", imx8mq_clocks_init);
>=20
> Can you please add a comment indicating why this can't be done with a
> platform driver, or convert this to be a platform driver?
>=20

Good point. Switched to platform driver.

Thanks

-- =
