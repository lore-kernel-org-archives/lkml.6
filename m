Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A15C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C31F2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tNan/Diz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C31F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeH1Ote (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:49:34 -0400
Received: from mail-eopbgr20041.outbound.protection.outlook.com ([40.107.2.41]:49495
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727192AbeH1Otc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8lHp0vdYYynxTIq+eSKYc+Aj12COKaLCDzc14lOnlg=;
 b=tNan/DizmYLkMAEn3EjNVq7uyp4hBPX7gIhRsrAjrdMY9hHZR8Ac9P95ko0uH0U6Y181ndhNw94rdfvAXDQ9u9N4HIbvBt81Eao5Zn4isiz1DPpm+iggCIY+tCESyrKFJ8uHuVwPnLRhD6/7i45F2vpj8OKzejYYgzWC434cR2I=
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) by
 VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 28 Aug 2018 10:58:23 +0000
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::7cd2:5981:f694:cb23]) by VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::7cd2:5981:f694:cb23%2]) with mapi id 15.20.1080.015; Tue, 28 Aug 2018
 10:58:23 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v6 3/5] clk: imx: add SCCG PLL type
Thread-Topic: [PATCH v6 3/5] clk: imx: add SCCG PLL type
Thread-Index: AQHUOh7WhC7r7kHSw0m/M4QgXsh4FqTOhyKAgAaAsYA=
Date:   Tue, 28 Aug 2018 10:58:22 +0000
Message-ID: <20180828105821.gbd7tba7uvmeeqcx@fsr-ub1664-175>
References: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com>
 <1534945703-4730-4-git-send-email-abel.vesa@nxp.com>
 <20180824074011.lufm653imkf6fyd3@pengutronix.de>
In-Reply-To: <20180824074011.lufm653imkf6fyd3@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4222;6:MJ5RQ1Pv9rs+1ll34kyHDs/Zht8af6BAbQm1y6kmQsOX1hHeUZqdgqwi0ky6797bVNiT/fRK1X5fEV7br8OxMviU+K5ARCvSeC+hmz2TgeC8b2zeuHppHcSdkikUIvd1Aq2mVe9IGWGs8wVYA1y7FhA8ATyo0E2UPJdWmUL4GFI+okiZM8A9JEXYF0nG3UktP5Abo29wSi9UOjTHoXTq99iYBaVuRSMtgoZKePeWuA681zYWRTD1V/F5wrA8UrDgFc2wuQbxDBjfWrWE5ydGSCV5dMwKgmXT3pZfEMD6NCf/JlO6FZm99a2RqU5Q1KUkhL2Ckvq8ey1Xu+qOcUV/nMfYVzPiFQFVzsBk643btJeA2Jz9MBQNDubJuX/jbwYUB96ThZEqFt3FdpJac+ZYMiwa148N1W4GI7XPMtTyoOKPe9UDfXtWs2J1HVznSrMGDbv6tSUtuT56E7Pwhqg25g==;5:vvMpY3wPXTTVYwdm4qC5vS1eBDs0Bv1IIaoLsssrt6tFYdpyQ/tBZw29sKsHeKABo905BKR65j0XDq8925AmxxBkJZI8Fl9Cg/l+oFn5sRaYSmksQ7l1RClI3yvdGahzUfQfrQEi3/yt+wv6kknpp2etdlf0EwUfnH5UOpxDiss=;7:FLDWv1/rVSxPokpsWT16YEq0U2HluXoPIjlRNvONk0lk1496ZFyiWoFg9ZPW0RyeY5VKOtSkbIpvW+p/eh3o3xIfAvJaMY83tJPCfR8j6qvqE5FstofZyXbG0eBZvPUmx9c7f7hV8YT8awU4l5hfXwK/CwlnufW/MIfAafN9G5DuSVO3ahy2EEpUvgrRToLGMjkSxXmHuL0ccGlp6nozfgYYqy+owXpC72x7SHX1njPBcxUzvltGnZ5FIoPToqMb
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 25b686b8-b4b3-44b6-0106-08d60cd52c63
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4222;
x-ms-traffictypediagnostic: VI1PR04MB4222:
x-microsoft-antispam-prvs: <VI1PR04MB4222E888C053E6FAEEA3C40FF60A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(189930954265078)(185117386973197)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:VI1PR04MB4222;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4222;
x-forefront-prvs: 077884B8B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(39860400002)(136003)(346002)(366004)(376002)(189003)(199004)(256004)(8936002)(6506007)(446003)(6116002)(54906003)(6512007)(66066001)(3846002)(6306002)(86362001)(44832011)(229853002)(6486002)(6436002)(9686003)(476003)(316002)(11346002)(2906002)(6916009)(81166006)(217873002)(2900100001)(25786009)(97736004)(5250100002)(4326008)(26005)(6246003)(39060400002)(14444005)(305945005)(478600001)(53936002)(102836004)(966005)(45080400002)(14454004)(33716001)(7736002)(99286004)(486006)(186003)(76176011)(1076002)(106356001)(81156014)(7416002)(68736007)(8676002)(33896004)(105586002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4222;H:VI1PR04MB1613.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4rsrwwx3rvWlrG+Ibfbp5kY/vIUhH58GBf4zg5FnkjdSK941l+7H7oIEDPUugNF2JydQXZgMNNgfmmV0g4xaAqYysiptNZSPdH/niM/pBCwqGb6KZgVJJgT/fKs4ZOqaLoABl/q0GsOAn4w5+oUsABFJOs9vOCjo6NQnmKMZkYf0x3BtCIFabnMvQGSu14Yv3rD0M/3/kKwfpbVKvfTMCrsGNCsI4LF4YVpG2+GkwWwtpFEa1dREpuMdu6rzdrVLge37jbxzmk2XqeBaULi4JEZzQ1VnXwjCZ2fuqC0v5VbkiTW9Y4gTxx1vazdK2RMSyH9Nln+MJV40H19adPDGUxWPerTwkb/lHdpoBcY8dp4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9567F8D0E4488A42A2BA7920776C568F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b686b8-b4b3-44b6-0106-08d60cd52c63
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2018 10:58:22.9955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 09:40:11AM +0200, Sascha Hauer wrote:
> +Cc Andrey Smirnov who made me aware of this issue.
>=20
> On Wed, Aug 22, 2018 at 04:48:21PM +0300, Abel Vesa wrote:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >=20
> > The SCCG is a new PLL type introduced on i.MX8. Add support for this.
> > The driver currently misses the PLL lock check, as the preliminary
> > documentation mentions lock configurations, but is quiet about where
> > to find the actual lock status signal.
> >=20
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> > +static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate,
> > +			    unsigned long parent_rate)
> > +{
> > +	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> > +	u32 val;
> > +	u32 divf;
> > +
> > +	divf =3D rate / (parent_rate * 2);
> > +
> > +	val =3D readl_relaxed(pll->base + PLL_CFG2);
> > +	val &=3D ~(PLL_DIVF_MASK << PLL_DIVF1_SHIFT);
> > +	val |=3D (divf - 1) << PLL_DIVF1_SHIFT;
> > +	writel_relaxed(val, pll->base + PLL_CFG2);
> > +
> > +	/* FIXME: PLL lock check */
>=20
> Shouldn't be too hard to add, no?

Added to the next version which I intend to send today.

>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static int clk_pll1_prepare(struct clk_hw *hw)
> > +{
> > +	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> > +	u32 val;
> > +
> > +	val =3D readl_relaxed(pll->base);
> > +	val &=3D ~(1 << PLL_PD);
> > +	writel_relaxed(val, pll->base);
>=20
> pll->base + PLL_CFG0 please.

Same as above.

>=20
> > +static const struct clk_ops clk_sccg_pll1_ops =3D {
> > +	.is_prepared	=3D clk_pll1_is_prepared,
> > +	.recalc_rate	=3D clk_pll1_recalc_rate,
> > +	.round_rate	=3D clk_pll1_round_rate,
> > +	.set_rate	=3D clk_pll1_set_rate,
> > +};
> > +
> > +static const struct clk_ops clk_sccg_pll2_ops =3D {
> > +	.prepare	=3D clk_pll1_prepare,
> > +	.unprepare	=3D clk_pll1_unprepare,
> > +	.recalc_rate	=3D clk_pll2_recalc_rate,
> > +	.round_rate	=3D clk_pll2_round_rate,
> > +	.set_rate	=3D clk_pll2_set_rate,
> > +};
>=20
> So these are two PLLs that share the same enable register. Doing the
> prepare/unprepare for only one PLL can lead to all kinds of trouble.
> Finding a good abstraction the properly handles this case with the
> clock framework is probably also not easy.
>=20
> I could imagine we'll need to track the enable state on both PLLs and
> only if both are disabled we disable it in hardware.
>=20
> With the current code we disable the PLLs when all consumers are
> reparented to pll1, which probably has bad effects.
>=20

So it took me a while to understand exactly why this needs to stay like it =
is.

The PLL1 is never used by any device, instead it is used as a source for PL=
L2.

But because the interlink between the two of them is too complicated,
the PLLs 1 and 2 need to be separate clocks.

As for the disabling, it's safe to disable just the second one because,
as mentioned above, the first PLL is never used alone by a device.

If there isn't anything else here to discuss, I would like to send the next
version of this patchset with all the other comments taken care of.

Abel

> Sascha
>=20
> --=20
> Pengutronix e.K.                           |                             =
|
> Industrial Linux Solutions                 | https://emea01.safelinks.pro=
tection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pengutronix.de%2F&amp;data=3D02=
%7C01%7Cabel.vesa%40nxp.com%7C5e9c7c6f9e464ed522f108d60994d471%7C686ea1d3bc=
2b4c6fa92cd99c5c301635%7C0%7C0%7C636706932168087639&amp;sdata=3DXbfFq5z%2FR=
tkq6yGgwSyk6dNCZVuXOzY%2Fiygmwle3C2I%3D&amp;reserved=3D0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

-- =
