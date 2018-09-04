Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6A5C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF5620661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MFiDBEG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF5620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeIDRi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:38:56 -0400
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]:58879
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbeIDRiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO7/2K5N61tdrujrmHQ70+NWpCrIP3AcL949Fie5JZY=;
 b=MFiDBEG8AfBrzXKfiPlGdPe/3cobkD398WlfYBcMNg8cWWbRpNi7BGbzn2UsvSavOd1TEfKWkbcM+jOmZlBmy6UZxEmrhq8NmdGhEfwF8/FGABb3fKIRHuEz3o8dgkphRA7/b1K7sRTrKlpbHrBCEJZl9MTN2z8/DeYzoyHYIbA=
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) by
 VI1PR04MB1584.eurprd04.prod.outlook.com (10.164.84.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Tue, 4 Sep 2018 13:13:43 +0000
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::7cd2:5981:f694:cb23]) by VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::7cd2:5981:f694:cb23%2]) with mapi id 15.20.1101.016; Tue, 4 Sep 2018
 13:13:43 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "abelvesa@linux.com" <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v6 3/5] clk: imx: add SCCG PLL type
Thread-Topic: [PATCH v6 3/5] clk: imx: add SCCG PLL type
Thread-Index: AQHUOh7WhC7r7kHSw0m/M4QgXsh4FqTOhyKAgAaAsYCAAIm1gIAKnG4A
Date:   Tue, 4 Sep 2018 13:13:43 +0000
Message-ID: <20180904131341.ef7tvt6hvtkkpdhw@fsr-ub1664-175>
References: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com>
 <1534945703-4730-4-git-send-email-abel.vesa@nxp.com>
 <20180824074011.lufm653imkf6fyd3@pengutronix.de>
 <20180828105821.gbd7tba7uvmeeqcx@fsr-ub1664-175>
 <CAHQ1cqEsHoF0ZFY5+CpQFJ+b3sKd3yJPvmRZMAbaa9+Xzhe3=g@mail.gmail.com>
In-Reply-To: <CAHQ1cqEsHoF0ZFY5+CpQFJ+b3sKd3yJPvmRZMAbaa9+Xzhe3=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1584;6:ejxidm3wf7MIeqodxYKqy+XweNKuR/n6Hz5aLV2fzVOs3V7WqpkqdWIsdUdaR7LMksCSM5C7/I7aR11iTFPig6zGx6Uo79mR5QwLEV2WtkzAGA8jkwCBIMdM13/o+sDFQ3iFStAFsdh41VkZ4lkSoHyDVDCPbJSltfVj3uZyLYtWRpHIElBtZPYOUsdNVlRqsgqYEte9gGYw4hwuVaZi6jZAAmIG30K/A3f05Ksfc79s29aSEVG/DV/MQX7QNXUuMP717JyHfjViH4AlwvQaXixfe0S0WTU4/EqOG4BL2a14IJcGh/dlSsgI76KnyI61gufyToYANd5zlRXNv6N8eB0Ula3mOWo+Yc0EO0rOkJ8vKtdPcJAd8dfTz8IjqTVLKlCriCvBgFEHDbxCBorjbkSV5nkLCiKodS9KsE8F15GIJsgB+cKjDU11GCsDut/I3Num0mIZyCweL1y1Ag6WTQ==;5:jhovPeRBOJMJs26Hb5iRlLs9KejafCZ9tLxXe97n7V1q+WbzFBf3s3dZVyHLfrpyPjrWKJgy0x4WlWoBfT9pAsTQEhZ5XcwC6B+td2YVKrIexd+fwALGmXUOJrhp6hWs+Pqv2D3mBItZGThAIx1gDKn3YQd8uAQvzSudMGQ63lY=;7:2WxbqNiHomflJp41NeC4Vibz1+7LJAAPnq0N4YG3I/mJp4ItF3NOct4Dbgz8Mwuj8Y2oc0ilgW6ONJ+WlC4SE0Pe4vgDlvOJYogdA9s6GLO07fJcl1msKwb2UG4/87KLUe2bjBLO5AXyAgdhbQUexmRnkUTJTz8Y1pGtltzdp3Vgb1H2n/ZRQvQORzqCCNDzqF7iRPHFDSzeAI0saMSKOcg5bheBC0KCBCKzyUaDFI7HysGoh1Ob3gH5Qd99oQO5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 04c1c854-da3b-4ae5-e92e-08d612683d4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1584;
x-ms-traffictypediagnostic: VI1PR04MB1584:
x-microsoft-antispam-prvs: <VI1PR04MB158414C332EA77E81DFE7E6DF6030@VI1PR04MB1584.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(264314650089876);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:VI1PR04MB1584;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1584;
x-forefront-prvs: 0785459C39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(136003)(346002)(396003)(39860400002)(366004)(189003)(199004)(81166006)(81156014)(53936002)(6246003)(6436002)(97736004)(76176011)(8936002)(478600001)(105586002)(2900100001)(5250100002)(106356001)(316002)(99286004)(2906002)(217873002)(54906003)(6486002)(5660300001)(68736007)(14444005)(256004)(229853002)(476003)(44832011)(446003)(11346002)(25786009)(6506007)(53546011)(305945005)(93886005)(7416002)(6116002)(8676002)(3846002)(486006)(4326008)(7736002)(1076002)(33896004)(6512007)(66066001)(14454004)(33716001)(9686003)(6916009)(966005)(6306002)(86362001)(26005)(186003)(102836004)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1584;H:VI1PR04MB1613.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hL/8JTztzuTxOO/esOqIr//UEFlLQ2egU04qS3CsB9JwtELd7uVo4qp+dqk2L5CiwD/dgVH+2cXHVGaiqozf7YhxdX3rZMvagHCEjciZhYfO+GaCvF9kmIfb0gwtca1dv21Xo9kaV3rotZx0XLF5H3Dcg3XF95rtzJk3ue5YTbjYSRqxIUtx76imOhJ8nse89mWcgyMunVc1dEeEojFqKGNN8oeASRimUO6/rgN5VzWuez/PHZdIGXNmEgP7rOy8ISGEHuxfPuzU8oVpWp9jfIVXpolkZTb4W6NnMXm2g8Os5nqorQ6eUglvAQrtVeLlxnkcm83z8/QaKJS5Nc7vnnjNq6Z3237pzk11f4Qz2KU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDA3AE5FEC9B5C4FAAE907407192DC0B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c1c854-da3b-4ae5-e92e-08d612683d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2018 13:13:43.2828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 12:11:13PM -0700, Andrey Smirnov wrote:
> On Tue, Aug 28, 2018 at 3:58 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> >
> > On Fri, Aug 24, 2018 at 09:40:11AM +0200, Sascha Hauer wrote:
> > > +Cc Andrey Smirnov who made me aware of this issue.
> > >
> > > On Wed, Aug 22, 2018 at 04:48:21PM +0300, Abel Vesa wrote:
> > > > From: Lucas Stach <l.stach@pengutronix.de>
> > > >
> > > > The SCCG is a new PLL type introduced on i.MX8. Add support for thi=
s.
> > > > The driver currently misses the PLL lock check, as the preliminary
> > > > documentation mentions lock configurations, but is quiet about wher=
e
> > > > to find the actual lock status signal.
> > > >
> > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > > ---
> > > > +static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate=
,
> > > > +                       unsigned long parent_rate)
> > > > +{
> > > > +   struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> > > > +   u32 val;
> > > > +   u32 divf;
> > > > +
> > > > +   divf =3D rate / (parent_rate * 2);
> > > > +
> > > > +   val =3D readl_relaxed(pll->base + PLL_CFG2);
> > > > +   val &=3D ~(PLL_DIVF_MASK << PLL_DIVF1_SHIFT);
> > > > +   val |=3D (divf - 1) << PLL_DIVF1_SHIFT;
> > > > +   writel_relaxed(val, pll->base + PLL_CFG2);
> > > > +
> > > > +   /* FIXME: PLL lock check */
> > >
> > > Shouldn't be too hard to add, no?
> >
> > Added to the next version which I intend to send today.
> >
> > >
> > > > +
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +static int clk_pll1_prepare(struct clk_hw *hw)
> > > > +{
> > > > +   struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> > > > +   u32 val;
> > > > +
> > > > +   val =3D readl_relaxed(pll->base);
> > > > +   val &=3D ~(1 << PLL_PD);
> > > > +   writel_relaxed(val, pll->base);
> > >
> > > pll->base + PLL_CFG0 please.
> >
> > Same as above.
> >
> > >
> > > > +static const struct clk_ops clk_sccg_pll1_ops =3D {
> > > > +   .is_prepared    =3D clk_pll1_is_prepared,
> > > > +   .recalc_rate    =3D clk_pll1_recalc_rate,
> > > > +   .round_rate     =3D clk_pll1_round_rate,
> > > > +   .set_rate       =3D clk_pll1_set_rate,
> > > > +};
> > > > +
> > > > +static const struct clk_ops clk_sccg_pll2_ops =3D {
> > > > +   .prepare        =3D clk_pll1_prepare,
> > > > +   .unprepare      =3D clk_pll1_unprepare,
> > > > +   .recalc_rate    =3D clk_pll2_recalc_rate,
> > > > +   .round_rate     =3D clk_pll2_round_rate,
> > > > +   .set_rate       =3D clk_pll2_set_rate,
> > > > +};
> > >
> > > So these are two PLLs that share the same enable register. Doing the
> > > prepare/unprepare for only one PLL can lead to all kinds of trouble.
> > > Finding a good abstraction the properly handles this case with the
> > > clock framework is probably also not easy.
> > >
> > > I could imagine we'll need to track the enable state on both PLLs and
> > > only if both are disabled we disable it in hardware.
> > >
> > > With the current code we disable the PLLs when all consumers are
> > > reparented to pll1, which probably has bad effects.
> > >
> >
> > So it took me a while to understand exactly why this needs to stay like=
 it is.
> >
>=20
> IMHO this means that, if nothing else, all of the below should be
> documented in code as a comment, otherwise simpletons like me are
> going to continue stumbling over it and wondering what's going on.

Will try to add proper comment to explain what's happening.

>=20
> > The PLL1 is never used by any device, instead it is used as a source fo=
r PLL2.
> >
> > But because the interlink between the two of them is too complicated,
> > the PLLs 1 and 2 need to be separate clocks.
> >
>=20
> Can you go a little bit more into detail as for why PLL1 needs to be
> exposed in the first place and can't just be dealt with behind the
> scenes as a part of PLL2 abstraction? Are there use-cases where the
> rates of the two are going to be adjusted individually in Linux?
>=20

Here is the SCCG PLL Block Diagram:

https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=3D834

Now lets take the System PLL 2 for example. If you follow the hierarchy,
when you reach the sys2_pll1_out you can see that one of its selectors is
actually sys1_pll1_ref_sel. Same thing applies to sys3_pll2_out with
sys2_pll1_ref_sel. This means there is an input reference clock interlinkin=
g
between different System PLLs.

> Thanks,
> Andrey Smirnov

-- =
