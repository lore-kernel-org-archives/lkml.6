Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633D4C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2163D206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ip/Gs8iV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2163D206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeKHF63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:58:29 -0500
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:4551
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726722AbeKHF62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAqhWszIjgIlaqGVYSCpiuhfbFhFlmR/FSiVlA0BfFQ=;
 b=Ip/Gs8iVsssgn2lBLewf9YdH7E4sYycoFB6R9H5YgCpbaR1hykijr7Spou2zZM3yUiX6uFsBCRnaSviCM5Nj5LhnbMhlRerh4fsBngly/Tt4rMk9TIM52KcHTlXGO5EHA3svHcRIAfQDVnxJ79K2kZWEXxwZNSdNBbAqagj4W8U=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3686.eurprd04.prod.outlook.com (52.133.28.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Wed, 7 Nov 2018 20:26:25 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b%4]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 20:26:25 +0000
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
Thread-Index: AQHUU/MOgX3H5GYYv0SLPnYITk0b36Uj/uoAgCB6iACAAHccAIAAF9kA
Date:   Wed, 7 Nov 2018 20:26:25 +0000
Message-ID: <20181107202624.oya2runvbbwcilzu@fsr-ub1664-175>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-4-git-send-email-abel.vesa@nxp.com>
 <153980615257.5275.13866740376184829057@swboyd.mtv.corp.google.com>
 <20181107115444.gscxwud7e57nx3c7@fsr-ub1664-175>
 <154161726247.88331.15629902810537417880@swboyd.mtv.corp.google.com>
In-Reply-To: <154161726247.88331.15629902810537417880@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3686;6:S+jjjIr8YfQot2Jy4iQaPWYqecRbfPgvNiYqmNrr9jw8HDTV9AD7yNP7J5HBsoWTBXFo8yYzsmul/qG9AATJ4Af9JsM/jgjj1Tq6ki0fNvKO4AX/AD2jjQfw7VMdfbjBUqDSXTL5tY1auPq3AP+CDt+I6RYS18073wrQYIyb+nTQk9TgWc1cTIGBlLO1dnuXC8l+DRgfmwRwZcHyqxqm4ZpWGNH5/61MoJEWunZSX1D8pNKToTwfHIAF5zxH2Rs2LYVZeCmUg9p2S4542EHspDTI5hwjpu48M/Du99YpIFJsoetsE6AU1MWnMKYHlubnxy2DHb63XqWwFAY4YIwisW31dL2Gx7haEAn0iDjsxTzAXbG/gAfiYM3yRGo/wpbQGLtM6lyL2aZh5Azb6/y3Txn+0SDo6FTmnHE6tVCcc0YVypYcUHoJ6Y6YLyA8zNW8KNWiMINpiaSEZZwCalWAGg==;5:C3BBYutX4Mk+B1b+RXXL7CIqm1+2S/KwSDk4XfqPpFBVt2PG9NL/WJ5LvrPU9UUyfEBzdn9/QUTWzDGuquunR4D8FWC5CHzgOQokC/1VbMFcN6K7qZBHKepLzAUvIwo+WiY6/yPRJ/E7uExtkEXu3cbZgxAU1bzp4i2w08oYKtw=;7:HiuOhy/6+nXdb8IzUap2rQKbSDviff7dlLBWwgoabAtLWPIxUn61+MmzoFmqnNt9/i+PcYAwqKmoA7x23W/u0Dkg6toVzw7HHdA82G6ual6EFpPNIBTUNEK9vlSDm0SuzPNRI3y+DXCS5+O88eH4Wg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2a4cee15-fedc-490d-5e26-08d644ef4a38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3686;
x-ms-traffictypediagnostic: AM6PR0402MB3686:
x-microsoft-antispam-prvs: <AM6PR0402MB36864A5EACCF846A1F75BA83F6C40@AM6PR0402MB3686.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(264314650089876)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3686;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3686;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(396003)(376002)(136003)(366004)(39860400002)(51914003)(199004)(189003)(8936002)(446003)(305945005)(106356001)(5660300001)(217873002)(14444005)(97736004)(4326008)(6116002)(3846002)(14454004)(2900100001)(6436002)(256004)(1076002)(54906003)(71190400001)(26005)(6306002)(102836004)(68736007)(966005)(6916009)(7736002)(66066001)(71200400001)(316002)(39060400002)(33896004)(6506007)(53936002)(478600001)(9686003)(6246003)(25786009)(476003)(105586002)(2906002)(6486002)(99286004)(186003)(6512007)(7416002)(76176011)(44832011)(93886005)(486006)(11346002)(33716001)(8676002)(229853002)(81156014)(86362001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3686;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: N8dctvVRWXyjEoLbFUjLUmE+cID5397W1Ip3Q1kABwn1EXT7mvueQvHqJeKfDFNf8Z4j7lrKZ7UIqEFDVxESxQV650A+bqYele+LcBCi8yq5kTKcAZyh36jgZPE1xAld9CxlGqJhibC1l5b+5tO7oGUQAfiTb3NVzEbXJMiPOB3NidpjXnD/HyetsljrEHH83oAOHVp/hlNVs139xtkaTJoN4gr69u3dKxOOJJ0hccmhScHz02TC6VYkYvbWws8Tj8Pea26lDWVlCNOOTdF6knhbNi5D6JyTnsN0BRwUKQMwBoSFniwQ1oTBt5NPdbl/ZN+6pL4F+GJ7uq7+rXYzvo+JBb/aeCc6YHThZYxMbuY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FCAE57C999A7924DB0935B16EFA78093@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4cee15-fedc-490d-5e26-08d644ef4a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 20:26:25.2024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3686
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 11:01:02AM -0800, Stephen Boyd wrote:
> Quoting Abel Vesa (2018-11-07 03:54:45)
> > On Wed, Oct 17, 2018 at 12:55:52PM -0700, Stephen Boyd wrote:
> > > Quoting Abel Vesa (2018-09-24 03:39:55)
> > > > +static unsigned long clk_pll2_recalc_rate(struct clk_hw *hw,
> > > > +                                        unsigned long parent_rate)
> > > > +{
> > > > +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> > > > +       u32 val, ref, divr1, divf1, divr2, divf2;
> > > > +       u64 temp64;
> > > > +
> > > > +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> > > > +       switch (FIELD_GET(PLL_REF_MASK, val)) {
> > > > +       case 0:
> > > > +               ref =3D OSC_25M;
> > > > +               break;
> > > > +       case 1:
> > > > +               ref =3D OSC_27M;
> > > > +               break;
> > > > +       default:
> > > > +               ref =3D OSC_25M;
> > >=20
> > > Does this information not come through 'parent_rate'?
> > >=20
> >=20
> > No. So basically both pll1 and pll2 and the divider after it form toget=
her this SCCG:
> >=20
> > https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=3D834
> >=20
> > See: Figure 5-8. SSCG PLL Block Diagram
>=20
> Thanks for the link!
>=20
> >=20
> > We're basically reading the input of the pll 1 in order to compute the =
output of the entire SCCG.
> >=20
> > I know it's a mess. I'm working on cleaning it up, but for now we need =
this in in order to boot up.
>=20
> What's the plan to clean it up?

So I'm doing this in our internal tree first to make sure I don't break the
other (newer) socs.

I already have a prototype in testing but it's a long way to upstream it.

Basically, I'm replacing all of this with a single, more like a composite,
more complex, clock type that does all the magic inside.

One of the problems is the fact that the bypasses can have the same sources
and in my case, I'm implementing that as a list of parents name, but the
parent names list doesn't work with duplicates, so I have to find some othe=
r
way to do it.

Once I have something clean and tested enough I'll send it upstream.

>=20
> >=20
> > > > +               break;
> > > > +       }
> > > > +
> > > > +       val =3D readl_relaxed(pll->base + PLL_CFG2);
> > > > +       divr1 =3D FIELD_GET(PLL_DIVR1_MASK, val);
> > > > +       divr2 =3D FIELD_GET(PLL_DIVR2_MASK, val);
> > > > +       divf1 =3D FIELD_GET(PLL_DIVF1_MASK, val);
> > > > +       divf2 =3D FIELD_GET(PLL_DIVF2_MASK, val);
> > > > +
> > > > +       temp64 =3D ref * 2;
> > > > +       temp64 *=3D (divf1 + 1) * (divf2 + 1);
> > > > +
> > > > +       do_div(temp64, (divr1 + 1) * (divr2 + 1));
> > >=20
> > > Nitpicks: A comment with the equation may be helpful to newcomers.
> >=20
> > Since the SCCG is contructed by multiple different types of clocks here=
, the equation doesn't help
> > since it is spread in all constructing blocks.
>=20
> Ok.
>=20

-- =
