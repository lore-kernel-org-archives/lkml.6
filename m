Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA814C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2EE2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qZX0oPFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2EE2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbeKGV4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:56:55 -0500
Received: from mail-ve1eur01on0043.outbound.protection.outlook.com ([104.47.1.43]:4072
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbeKGV4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWdlKFMkANVCMuvXHla/TZLHCvxgiR9pEzgDRS5YITo=;
 b=qZX0oPFTzospr9uB6MPZv1xSlVdejzuADSXvJVwdkowz+N1kTkTzrjaQXygOtDppqdcqxmHLcYhWq63qjIYZwcYsCtLYeYzSpfWy2FG6CNUdyJgWGI9hSMat/aYq4kSVAtLTLLEum9wwJ73Oo4TC9gbvTufLpZmcsTZXDkFphYo=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3767.eurprd04.prod.outlook.com (52.133.29.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.32; Wed, 7 Nov 2018 12:25:59 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b%4]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 12:25:59 +0000
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
Subject: Re: [PATCH v9 2/5] clk: imx: add fractional PLL output clock
Thread-Topic: [PATCH v9 2/5] clk: imx: add fractional PLL output clock
Thread-Index: AQHUU/MMUMe0FdAvrE6d03JzIJMOT6Uj//8AgCCCLQA=
Date:   Wed, 7 Nov 2018 12:25:59 +0000
Message-ID: <20181107122558.mlul4keytay4lrtc@fsr-ub1664-175>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-3-git-send-email-abel.vesa@nxp.com>
 <153980638471.5275.2935268205764106887@swboyd.mtv.corp.google.com>
In-Reply-To: <153980638471.5275.2935268205764106887@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3767;6:Q/JrAUHUPbMjJtbNEt5BBIGARNn+tgWTN29ulVmwSuWF9zGozMpjMDtvV9qF+VYNAZgDuEiqjpbxEkMcfPRYb4+c36wFwFucOHhbm9fde3E/Z4XYjgzgI8YUXb32eNtIPGjG6PICJa+AJlN6MJxNNsy7XPmPw1F8o84VudXDfkT7DUnItQbqCC5tYB5w83R1Vu/NjBTHiyuGkss2j6vLUO4awp4lx5sQpoxTxAXYB+jQakSkj+pv1H58KxQMhL578kkwZ0V9dDaoKlsSchfkUW6aMvVrkYGl+uP2yLwa4N1WH6vJVT+/vQ1r+w6Ii+XCbWZj2xuUV+7jlSCbmK6L0q5TfaIfJX0Adabgs+xObqVCh35NK9K9TQK00DRCu0Bug0rg6dvg2Cn8NJFxKKgflAaGJreWwtffbLx8zf6k44HwF7xLKpkBZMrk7Q7B8Dn4ncBo768zCOppGMyH7HdHBA==;5:1w4VGa+bSixx75Wq8ty7mafkdsold+HaxBJAfBbIgnxeycI15N+vS+f3Xend08lJDHpLfzHC8sf7lgd3rmvsmI0epzWCNMN9bD3diQ13/xDoCfXEKpS7AuxHR7QFebhcihRegwPwQvk8wPrEYsSjDZJVH4b2u4VNIUlkH95gakg=;7:pcjAbMjp6yKupiBTqY3eb39lWyFlsad/w+WDIG66DtSiicE/PT+pUpfBSz5FhVLDogLwIY8LH/wjIW9BN0jW6AUwL8NSMTeAT5dxsqcKFmFjXD0GpWVE4xOoPY9VgErTwrw5GCC0TnJknA/cB/okIg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7d1b1368-6418-4f7c-05e5-08d644ac2ccc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3767;
x-ms-traffictypediagnostic: AM6PR0402MB3767:
x-microsoft-antispam-prvs: <AM6PR0402MB3767A889EF2BB17644D1C4D8F6C40@AM6PR0402MB3767.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3767;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3767;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(229853002)(256004)(1076002)(97736004)(3846002)(6116002)(7416002)(6916009)(33896004)(53936002)(6246003)(6486002)(4326008)(39060400002)(9686003)(25786009)(105586002)(6512007)(6436002)(71190400001)(76176011)(54906003)(81166006)(316002)(81156014)(7736002)(8936002)(8676002)(86362001)(26005)(186003)(106356001)(71200400001)(6506007)(305945005)(2900100001)(486006)(446003)(102836004)(5660300001)(33716001)(478600001)(11346002)(2906002)(44832011)(476003)(99286004)(68736007)(14454004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3767;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y4IkemREcpI94oFEMmR6+LKDnXLdP2h7Z3KNwS+MQ9IsolIv36s01i35L0+uLwwPCpM05jA5i5qhomyAYHLbwdhhF44WvBuP7xtSut+XEF7G9LZzwD3wC+jN/N63stvuPSwXil7cVAwZFiC+QAqF7AYWSgkS15iAtULooTkba5H/HELJL8Urp+MqV5VBal1yMLS0T1+t8dFrogucTMYoqY1LI/ns+NrB0ES7DcJrXcB9pmISgUBD2FipQ0QquN7TST8A2DK188bjFHRCSr8D0h5BG1SbmopC78fDOlpQ9lRzzswDZPlxHsMfpsS1OLpZzP7GyiD4UWYMKyO6uIXhI9uTvaue2ZvOnTbDEzexL8E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C90F878DA08E2E469BA19D4101D89A67@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1b1368-6418-4f7c-05e5-08d644ac2ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 12:25:59.5175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:59:44PM -0700, Stephen Boyd wrote:
> Quoting Abel Vesa (2018-09-24 03:39:54)
> > From: Lucas Stach <l.stach@pengutronix.de>
> >=20
> > This is a new clock type introduced on i.MX8.
>=20
> Ok, what's the clock type? Add another sentence please.
>=20

Added in the next version a link with the pdf describing the hardware
and specified in the commit message that is a fractional clock.

> >=20
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> [..]
> > diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-=
pll.c
> > new file mode 100644
> > index 0000000..030df76
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-frac-pll.c
> > @@ -0,0 +1,215 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2018 NXP.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/jiffies.h>
>=20
> Is this used for something?
>

Removed in the next version.

> > +#include <linux/slab.h>
> > +#include <linux/bitfield.h>
> > +
> > +#include "clk.h"
> [...]
> > +
> > +static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
> > +                                        unsigned long parent_rate)
> > +{
> > +       struct clk_frac_pll *pll =3D to_clk_frac_pll(hw);
> > +       u32 val, divff, divfi, divq;
> > +       u64 temp64;
> > +
> > +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> > +       divq =3D ((val & PLL_OUTPUT_DIV_MASK) + 1) * 2;
> > +       val =3D readl_relaxed(pll->base + PLL_CFG1);
> > +       divff =3D FIELD_GET(PLL_FRAC_DIV_MASK, val);
> > +       divfi =3D (val & PLL_INT_DIV_MASK);
>=20
> Nitpick: Drop useless parenthesis please.
>=20

Removed in the next version.

> > +
> > +       temp64 =3D (u64)parent_rate * 8;
> > +       temp64 *=3D divff;
> > +       do_div(temp64, PLL_FRAC_DENOM);
> > +       temp64 /=3D divq;
> > +
> > +       return parent_rate * 8 * (divfi + 1) / divq + (unsigned long)te=
mp64;
> > +}
> > +
> > +static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> > +                              unsigned long *prate)
> > +{
> > +       unsigned long parent_rate =3D *prate;
> > +       u32 divff, divfi;
> > +       u64 temp64;
> > +
> > +       parent_rate *=3D 8;
>=20
> And parent_rate can't overflow if it's a u32? Maybe it could be a u64 so
> that we don't need casting later on in this function.
>=20

Fixed in the next version.

> > +       rate *=3D 2;
> > +       divfi =3D rate / parent_rate;
> > +       temp64 =3D (u64)(rate - divfi * parent_rate);
> > +       temp64 *=3D PLL_FRAC_DENOM;
> > +       do_div(temp64, parent_rate);
> > +       divff =3D temp64;
> > +
> > +       temp64 =3D (u64)parent_rate;
> > +       temp64 *=3D divff;
> > +       do_div(temp64, PLL_FRAC_DENOM);
> > +
> > +       return (parent_rate * divfi + (unsigned long)temp64) / 2;
> > +}
> > +
> > +/*
> > + * To simplify the clock calculation, we can keep the 'PLL_OUTPUT_VAL'=
 at zero
> > + * (means the PLL output will be divided by 2). So the PLL output can =
use
> > + * the below formula:
> > + * pllout =3D parent_rate * 8 / 2 * DIVF_VAL;
> > + * where DIVF_VAL =3D 1 + DIVFI + DIVFF / 2^24.
> > + */
> > +static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> > +                           unsigned long parent_rate)
> > +{
> > +       struct clk_frac_pll *pll =3D to_clk_frac_pll(hw);
> > +       u32 val, divfi, divff;
> > +       u64 temp64;
> > +       int ret;
> > +
> > +       parent_rate *=3D 8;
> > +       rate *=3D 2;
> > +       divfi =3D rate / parent_rate;
> > +       temp64 =3D (u64) (rate - divfi * parent_rate);
> > +       temp64 *=3D PLL_FRAC_DENOM;
> > +       do_div(temp64, parent_rate);
> > +       divff =3D temp64;
> > +
> > +       val =3D readl_relaxed(pll->base + PLL_CFG1);
> > +       val &=3D ~(PLL_FRAC_DIV_MASK | PLL_INT_DIV_MASK);
> > +       val |=3D ((divff << 7) | (divfi - 1));
>=20
> Nitpick: Drop the extra parenthesis please.
>=20

Removed in the next version.

> > +       writel_relaxed(val, pll->base + PLL_CFG1);
> > +
> > +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> > +       val &=3D ~0x1f;
> > +       writel_relaxed(val, pll->base + PLL_CFG0);
> > +
> > +       /* Set the NEV_DIV_VAL to reload the DIVFI and DIVFF */
> > +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> > +       val |=3D PLL_NEWDIV_VAL;
> > +       writel_relaxed(val, pll->base + PLL_CFG0);
> > +
> > +       ret =3D clk_wait_ack(pll);
> > +
> > +       /* clear the NEV_DIV_VAL */
> > +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> > +       val &=3D ~PLL_NEWDIV_VAL;
> > +       writel_relaxed(val, pll->base + PLL_CFG0);
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct clk_ops clk_frac_pll_ops =3D {
> > +       .prepare        =3D clk_pll_prepare,
> > +       .unprepare      =3D clk_pll_unprepare,
> > +       .is_prepared    =3D clk_pll_is_prepared,
> > +       .recalc_rate    =3D clk_pll_recalc_rate,
> > +       .round_rate     =3D clk_pll_round_rate,
> > +       .set_rate       =3D clk_pll_set_rate,
> > +};
> > +
> > +struct clk *imx_clk_frac_pll(const char *name, const char *parent_name=
,
> > +                            void __iomem *base)
> > +{
> > +       struct clk_init_data init;
> > +       struct clk_frac_pll *pll;
> > +       struct clk *clk;
> > +
> > +       pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
> > +       if (!pll)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       pll->base =3D base;
> > +       init.name =3D name;
> > +       init.ops =3D &clk_frac_pll_ops;
> > +       init.flags =3D 0;
> > +       init.parent_names =3D &parent_name;
> > +       init.num_parents =3D 1;
> > +
> > +       pll->hw.init =3D &init;
> > +
> > +       clk =3D clk_register(NULL, &pll->hw);
>=20
> clk_hw based please.
>=20

Fixed in the next version.

> > +       if (IS_ERR(clk))
> > +               kfree(pll);
> > +
> > +       return clk;
> > +}

-- =
