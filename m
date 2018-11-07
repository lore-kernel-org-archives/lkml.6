Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39375C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28452081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K4dWQVT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28452081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeKGVYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:24:55 -0500
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:19038
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726241AbeKGVYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT/TKKZ9ENNdffasifzbf6FXOgqw7XmcVmhhkgEbp8E=;
 b=K4dWQVT8PlDNcIFUD1QGitGj38ykeL7AKf+3mrVTxID4BJ9QFeMN5wcpsBsC39peWCBstPe3Q6SQoMZw3p5S3+7yjiHo8V+mmZBoFirhNaUYpCQB768nymnHSJje9cbYpM9HVbdpLc+rLzhxY8oCU8jj2/fX5tsl3q9BKRL21T8=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3798.eurprd04.prod.outlook.com (52.133.29.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Wed, 7 Nov 2018 11:54:45 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b%4]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 11:54:45 +0000
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
Subject: Re: [PATCH v9 3/5] clk: imx: add SCCG PLL type
Thread-Topic: [PATCH v9 3/5] clk: imx: add SCCG PLL type
Thread-Index: AQHUU/MOgX3H5GYYv0SLPnYITk0b36Uj/uoAgCB6iAA=
Date:   Wed, 7 Nov 2018 11:54:45 +0000
Message-ID: <20181107115444.gscxwud7e57nx3c7@fsr-ub1664-175>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-4-git-send-email-abel.vesa@nxp.com>
 <153980615257.5275.13866740376184829057@swboyd.mtv.corp.google.com>
In-Reply-To: <153980615257.5275.13866740376184829057@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3798;6:HYqtyKAGukVuEUxitdZ+m/MLmNBihYIFLj6vqja6laE/+MQftuoM7btPwuy6TPLEL/ZX4Kiz0Xgg4zOoQbU2BQaWXGlGqrO36TAlsO3x6Zo0YfIxY52r+xTZ6S1zDY+BgGD1I84bKEj2eU2gluyOwQ+j5sG1lUaCqVztVTYJ4JjQufjpPcVVXnol1nfCggLzJOPSbEbV64vQNqIjhZGGvv1DZQ3ten7vEIIW79gpBFALfmXmI8kek6YtBdkc+lUQkgoOB5wd2hf4BmA+YfmfdxJzYS6ECH70tvhoHeO+DT0pk2h2N1hifl5U6dwb5rojFJSnEGFE2OoLO0v4oucBKToeH5FdirG3aIIZ9A0SYtd5EatvSQJyTkzcakE6qe9qGl96sjmiCrcxb13VouzEWMcyGyJqI83ee5RAdxEKhzFJybhUWPIyJvwi9O0qrzksNuym1Gw2/i8Wvke18UTOCQ==;5:n8YvqtL+5qEU4IjAD1eFAL6g+RuQtSo6w2Uyx15if3cLOynIVKg3PDvGBOzSlx/5OJ7VhNhPNtz0QcoZTWat39P2Tjczt/G8Qut0y6+GOFl0/kfEj1ol2CG9VHjH6eTNXSIwu/Ib4D6M4g+YnUVA/l3sqaB3p7HlBv7RPh2iSb0=;7:FHN5+5r3laknvp3DO3WMLP3uqhI8BSfeTnkWOjqv8se5sT/M+QAtBv+Lq3QV+AG0LJZwNrsSdP7VJ4UwQl79vu2gbgCpixlZRdN49YrulOGzDQpYDyZ1/2/YgHi/zRKb4/qJ6j0qRwPDIp8bvutZ8w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: eef3c737-88aa-4ab2-e2f6-08d644a7cfd4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3798;
x-ms-traffictypediagnostic: AM6PR0402MB3798:
x-microsoft-antispam-prvs: <AM6PR0402MB37981775B856730862204C3AF6C40@AM6PR0402MB3798.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(264314650089876)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3798;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3798;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(376002)(396003)(366004)(346002)(39860400002)(199004)(189003)(14454004)(4326008)(11346002)(6116002)(3846002)(6436002)(486006)(68736007)(6246003)(53936002)(966005)(7736002)(97736004)(54906003)(6306002)(8936002)(86362001)(81166006)(2900100001)(9686003)(44832011)(1076002)(6512007)(229853002)(14444005)(217873002)(8676002)(81156014)(305945005)(25786009)(6486002)(105586002)(26005)(106356001)(2906002)(66066001)(71200400001)(71190400001)(256004)(7416002)(33896004)(76176011)(478600001)(102836004)(6506007)(5660300001)(99286004)(476003)(6916009)(446003)(316002)(186003)(39060400002)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3798;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7cRaHnvF2tM7oobCQOOnbH4FRtUn1BfWPQF1W/0TCbK9zSvAEmH8AdpFj2u3RkG1v6jyJ4OKyOeS1CxuDSKKxX1g51EUJ7WVBGdtUURskCX2d3HfavgiJJeQgG58GcSXNWbVumHxhSDn1c7GbEmfxgHiuPAdrrx1hOHskAIub2b7gFIVuyVu32zHt5woswC43ZDWZ9IksK/RZY6dhBZBU0C2jNWFJROTMPsHxVopVsztvqp1j703R2p7AUmcVlZbszzeXjZmjOz/4E0kpQOANfajXa4re3g9Zji+ZxaWp/VCBSKI877CjLb61nkuSJoW0kZh0SyhsC8URLJGp25CMYaaWUn98eaIDlVsHKNlVxM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <927F875D285A1B4AAD3E822314D23B7F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef3c737-88aa-4ab2-e2f6-08d644a7cfd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 11:54:45.5435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:55:52PM -0700, Stephen Boyd wrote:
> Quoting Abel Vesa (2018-09-24 03:39:55)
> > diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-=
pll.c
> > new file mode 100644
> > index 0000000..a9837fa
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-sccg-pll.c
> > @@ -0,0 +1,237 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright 2018 NXP.
> > + */
> > +
> > +#include <linux/clk.h>
>=20
> Is this include used? Otherwise should see clk-provider.h included here.
>=20

Fixed in the next version.

> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/slab.h>
> > +#include <linux/delay.h>
> > +#include <linux/bitfield.h>
> > +
> > +#include "clk.h"
> > +
> > +/* PLL CFGs */
> > +#define PLL_CFG0               0x0
> > +#define PLL_CFG1               0x4
> > +#define PLL_CFG2               0x8
> > +
> > +#define PLL_DIVF1_MASK         GENMASK(18, 13)
> > +#define PLL_DIVF2_MASK         GENMASK(12, 7)
> > +#define PLL_DIVR1_MASK         GENMASK(27, 25)
> > +#define PLL_DIVR2_MASK         GENMASK(24, 19)
> > +#define PLL_REF_MASK           GENMASK(2, 0)
> > +
> > +#define PLL_LOCK_MASK          BIT(31)
> > +#define PLL_PD_MASK            BIT(7)
> > +
> > +#define OSC_25M                        25000000
> > +#define OSC_27M                        27000000
> > +
> > +#define PLL_SCCG_LOCK_TIMEOUT  70
> > +
> > +struct clk_sccg_pll {
> > +       struct clk_hw   hw;
> > +       void __iomem    *base;
> > +};
> > +
> > +#define to_clk_sccg_pll(_hw) container_of(_hw, struct clk_sccg_pll, hw=
)
> > +
> > +static int clk_pll_wait_lock(struct clk_sccg_pll *pll)
> > +{
> > +       u32 val;
> > +
> > +       return readl_poll_timeout(pll->base, val, val & PLL_LOCK_MASK, =
0,
> > +                                       PLL_SCCG_LOCK_TIMEOUT);
> > +}
> > +
> > +static int clk_pll1_is_prepared(struct clk_hw *hw)
> > +{
> > +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> > +       u32 val;
> > +
> > +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> > +       return (val & PLL_PD_MASK) ? 0 : 1;
> > +}
> > +
> > +static unsigned long clk_pll1_recalc_rate(struct clk_hw *hw,
> > +                                        unsigned long parent_rate)
> > +{
> > +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> > +       u32 val, divf;
> > +
> > +       val =3D readl_relaxed(pll->base + PLL_CFG2);
> > +       divf =3D FIELD_GET(PLL_DIVF1_MASK, val);
> > +
> > +       return parent_rate * 2 * (divf + 1);
> > +}
> > +
> > +static long clk_pll1_round_rate(struct clk_hw *hw, unsigned long rate,
> > +                              unsigned long *prate)
> > +{
> > +       unsigned long parent_rate =3D *prate;
> > +       u32 div;
> > +
> > +       div =3D rate / (parent_rate * 2);
>=20
> Can parent_rate be 0?
>=20

Fixed in the next version.

> > +
> > +       return parent_rate * div * 2;
> > +}
> > +
> > +static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate,
> > +                           unsigned long parent_rate)
> > +{
> > +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> > +       u32 val;
> > +       u32 divf;
> > +
> > +       divf =3D rate / (parent_rate * 2);
>=20
> Can parent_rate be 0?
>=20

Fixed in the next version.

> > +
> > +       val =3D readl_relaxed(pll->base + PLL_CFG2);
> > +       val &=3D ~PLL_DIVF1_MASK;
> > +       val |=3D FIELD_PREP(PLL_DIVF1_MASK, divf - 1);
> > +       writel_relaxed(val, pll->base + PLL_CFG2);
> > +
> > +       return clk_pll_wait_lock(pll);
> > +}
> > +
> > +static int clk_pll1_prepare(struct clk_hw *hw)
> > +{
> > +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> > +       u32 val;
> > +
> > +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> > +       val &=3D ~PLL_PD_MASK;
> > +       writel_relaxed(val, pll->base + PLL_CFG0);
> > +
> > +       return clk_pll_wait_lock(pll);
> > +}
> > +
> > +static void clk_pll1_unprepare(struct clk_hw *hw)
> > +{
> > +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> > +       u32 val;
> > +
> > +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> > +       val |=3D PLL_PD_MASK;
> > +       writel_relaxed(val, pll->base + PLL_CFG0);
> > +
> > +}
> > +
> > +static unsigned long clk_pll2_recalc_rate(struct clk_hw *hw,
> > +                                        unsigned long parent_rate)
> > +{
> > +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> > +       u32 val, ref, divr1, divf1, divr2, divf2;
> > +       u64 temp64;
> > +
> > +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> > +       switch (FIELD_GET(PLL_REF_MASK, val)) {
> > +       case 0:
> > +               ref =3D OSC_25M;
> > +               break;
> > +       case 1:
> > +               ref =3D OSC_27M;
> > +               break;
> > +       default:
> > +               ref =3D OSC_25M;
>=20
> Does this information not come through 'parent_rate'?
>=20

No. So basically both pll1 and pll2 and the divider after it form together =
this SCCG:

https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=3D834

See: Figure 5-8. SSCG PLL Block Diagram

We're basically reading the input of the pll 1 in order to compute the outp=
ut of the entire SCCG.

I know it's a mess. I'm working on cleaning it up, but for now we need this=
 in in order to boot up.

> > +               break;
> > +       }
> > +
> > +       val =3D readl_relaxed(pll->base + PLL_CFG2);
> > +       divr1 =3D FIELD_GET(PLL_DIVR1_MASK, val);
> > +       divr2 =3D FIELD_GET(PLL_DIVR2_MASK, val);
> > +       divf1 =3D FIELD_GET(PLL_DIVF1_MASK, val);
> > +       divf2 =3D FIELD_GET(PLL_DIVF2_MASK, val);
> > +
> > +       temp64 =3D ref * 2;
> > +       temp64 *=3D (divf1 + 1) * (divf2 + 1);
> > +
> > +       do_div(temp64, (divr1 + 1) * (divr2 + 1));
>=20
> Nitpicks: A comment with the equation may be helpful to newcomers.

Since the SCCG is contructed by multiple different types of clocks here, th=
e equation doesn't help
since it is spread in all constructing blocks.

>=20
> > +
> > +       return (unsigned long)temp64;
>=20
> Drop useless cast please.
>=20

Fixed in the next version.

> > +}
> > +
> > +static long clk_pll2_round_rate(struct clk_hw *hw, unsigned long rate,
> > +                              unsigned long *prate)
> > +{
> > +       u32 div;
> > +       unsigned long parent_rate =3D *prate;
> > +
> > +       div =3D rate / (parent_rate);
> > +
> > +       return parent_rate * div;
> > +}
> > +
> > +static int clk_pll2_set_rate(struct clk_hw *hw, unsigned long rate,
> > +                           unsigned long parent_rate)
> > +{
> > +       u32 val;
> > +       u32 divf;
> > +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> > +
> > +       divf =3D rate / (parent_rate);
>=20
> Drop useless parenthesis please.
>=20

Fixed in the next version.

> > +
> > +       val =3D readl_relaxed(pll->base + PLL_CFG2);
> > +       val &=3D ~PLL_DIVF2_MASK;
> > +       val |=3D FIELD_PREP(PLL_DIVF2_MASK, divf - 1);
> > +       writel_relaxed(val, pll->base + PLL_CFG2);
> > +
> > +       return clk_pll_wait_lock(pll);
> > +}
> > +
> > +static const struct clk_ops clk_sccg_pll1_ops =3D {
> > +       .is_prepared    =3D clk_pll1_is_prepared,
> > +       .recalc_rate    =3D clk_pll1_recalc_rate,
> > +       .round_rate     =3D clk_pll1_round_rate,
> > +       .set_rate       =3D clk_pll1_set_rate,
> > +};
> > +
> > +static const struct clk_ops clk_sccg_pll2_ops =3D {
> > +       .prepare        =3D clk_pll1_prepare,
> > +       .unprepare      =3D clk_pll1_unprepare,
> > +       .recalc_rate    =3D clk_pll2_recalc_rate,
> > +       .round_rate     =3D clk_pll2_round_rate,
> > +       .set_rate       =3D clk_pll2_set_rate,
> > +};
> > +
> > +struct clk *imx_clk_sccg_pll(const char *name,
> > +                               const char *parent_name,
> > +                               void __iomem *base,
> > +                               enum imx_sccg_pll_type pll_type)
> > +{
> > +       struct clk_sccg_pll *pll;
> > +       struct clk *clk;
> > +       struct clk_init_data init;
> > +
> > +       pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
> > +       if (!pll)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       pll->base =3D base;
> > +       init.name =3D name;
> > +       switch (pll_type) {
> > +       case SCCG_PLL1:
> > +               init.ops =3D &clk_sccg_pll1_ops;
> > +               break;
> > +       case SCCG_PLL2:
> > +               init.ops =3D &clk_sccg_pll2_ops;
> > +               break;
> > +       default:
> > +               kfree(pll);
> > +               return ERR_PTR(-EINVAL);
>=20
> Do this case statement before allocating? So that kfree() isn't required
> here?
>=20

Fixed in the next version.

> > +       }
> > +
> > +       init.flags =3D 0;
> > +       init.parent_names =3D &parent_name;
> > +       init.num_parents =3D 1;
> > +
> > +       pll->hw.init =3D &init;
> > +
> > +       clk =3D clk_register(NULL, &pll->hw);
>=20
> Any chance to use clk_hw based registration APIs?
>=20

Fixed in the next version.

> > +       if (IS_ERR(clk))
> > +               kfree(pll);
> > +
> > +       return clk;

-- =
