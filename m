Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BB2C00449
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1A4214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h8DKPHPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1A4214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJJPLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:11:42 -0400
Received: from mail-eopbgr40044.outbound.protection.outlook.com ([40.107.4.44]:3328
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbeJJPLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H6tiN7OJk9A2carQxvTc3sDk1HBBeTzBztjB6WLf50=;
 b=h8DKPHPVOH7s08FlRGRzZoxuG6+5W47OiP3spFLUljccjVz0ML5c1ukLtgag6fjFCYLMRmMrfZrUmimJ9wFqSH6NGOtUEiyl0dDl9yUrKRGERNblIlxYgO4/hlxO8MZ36Mu6fWaNQV7Fz0J/NVbh5Fy87moWdxjUelYx3trYQrE=
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) by
 VI1PR04MB5039.eurprd04.prod.outlook.com (20.177.50.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.28; Wed, 10 Oct 2018 07:50:41 +0000
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::f014:635a:bee7:76b3]) by VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::f014:635a:bee7:76b3%3]) with mapi id 15.20.1207.029; Wed, 10 Oct 2018
 07:50:41 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     Leonard Crestez <leonard.crestez@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "abelvesa@linux.com" <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 4/5] clk: imx: add imx composite clock
Thread-Topic: [PATCH v10 4/5] clk: imx: add imx composite clock
Thread-Index: AQHUX6tQJ9541kIf10SWRaGOsstznKUXhzgAgABwLQCAACUkAA==
Date:   Wed, 10 Oct 2018 07:50:41 +0000
Message-ID: <20181010075040.lcpdsw433vfet3ok@fsr-ub1664-175>
References: <1539074230-27277-1-git-send-email-abel.vesa@nxp.com>
 <1539074230-27277-5-git-send-email-abel.vesa@nxp.com>
 <5c0cc4de8403fca17431a9382f7e34e8003f497b.camel@nxp.com>
 <20181010053744.5pxrlcdxmmyisu62@pengutronix.de>
In-Reply-To: <20181010053744.5pxrlcdxmmyisu62@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5039;6:ZRlxSSD4am/SrjcEjhskadKuS3FU0kwp0jMZ6ERZCFxshCnkWmOj1W/YvoMUMXLftm+WiAYSppv8AWAc5tpa76CEaqJB7S21TuApew8K8VgjqHi3+h6zdgViBonaZAI7SE0Of0OA3NvwVNy3Y22Vuc8wFbK3uqPwb18dRxl5dSj7fnuGWpg5wgTmBVjHigEmzGcHv9cj2m6R0vZHwQPdeIH1R85rWQLbcyU9WLsIsFAxfp52XuTEkzkr4Gw5uyKujS4rn6WziQdrT8N2p0EYOdGcuL7QeaK/aFVH746OJBFJYzbkXzHDGg5q0tH9VFgiEsdcZ0LnBQMNkOm0TdlaXyb91HWnKsWFIPbOG80okQbneaouHHo79U1daP2FZV//pvGwU0zI8a2v0k32WJgArWqqvXKugUB6bVYbcUX0Zp71FAOPVEt8CYF4TojS+dMEVwW3ME6S+DnJyJiBqEMZPw==;5:UFyvYKV0XFJ3yR5Xznjsxdb89bf/SYOx+DLElqvZSEGLun6NEAKw9lZD0//FpJyjTCvhDBHqNus5i7tqabhISVkaPT1CYVYU2b0BrmUT0HwL2yiQvDJg+uOrSM+OALenr/4ZjsitqpKHrG0SFBjkkvnSqZV6/Oa5VhEie8TWeSg=;7:gdkcNfeJNb5auGo2evvzd4XlAKmXAJZ/l5Wn5wP2cRqZDyeqmm8dxb13UIrqxaKidYKOO3qMKpFDZND0jqCJJ9MOsr+GfZWRElpsDKKJsjwEO+yJstWLt/VoaGSB62ZbZT9Pa7RtZMOIrJQInGu3nOppqYDhUFF/qZEApZ7OrGh7l1PcSCeWq478MRNTq7ZMEwRVvv/6OBXyfzRG5f2CTnj2ZriOL0RmhTi1+PuLAIWOKTeKiXwL1eXk7Li6I0CU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c124020e-b77c-4bd2-9eeb-08d62e8513aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5039;
x-ms-traffictypediagnostic: VI1PR04MB5039:
x-microsoft-antispam-prvs: <VI1PR04MB5039D1E0A53E5ADA6F061737F6E00@VI1PR04MB5039.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(45079756050767)(189930954265078);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231355)(944501410)(4982022)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:VI1PR04MB5039;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5039;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(8676002)(316002)(33896004)(81166006)(81156014)(76176011)(93886005)(6506007)(6916009)(54906003)(71200400001)(71190400001)(66066001)(68736007)(8936002)(99286004)(186003)(26005)(86362001)(486006)(476003)(44832011)(7736002)(2906002)(446003)(11346002)(305945005)(102836004)(7416002)(575784001)(53936002)(9686003)(6512007)(3846002)(6116002)(6306002)(105586002)(106356001)(14454004)(6486002)(478600001)(45080400002)(1076002)(229853002)(6436002)(6246003)(5250100002)(256004)(4326008)(33716001)(97736004)(2900100001)(5660300001)(25786009)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5039;H:VI1PR04MB1613.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: slATLHFFOUMOl8MSeh01+IrOTTCN4RXgG7zE821Gb5bdTmdoiDQeFVIz5wYUrkJF+B6qgRLZwjHYUBLgGt3Ex5qKMWnen4DacmPqNMMgMZfkABjFqgmWmyd1xqgA2QraXPIAwlc3rIm9XqrxChO+roYF3dvgTytfyfDOpaeXNOY2OQfJRm9Keyd8U3zo8vkqVmZgmiFpEAGROL2UIPGScCX394uVZcSDXNtBdC5D54T5pTxy9Z4OeeZRPBFDHDEiMKNVyyxc5NATrt0f/yw7Ij1uFGrrJS5x8X5r4DBe3swelVwYwTfLnsTzHKtSDUapPeLJZqaaQoeQ82rIEiCBAnz7tXUo7NIPkbM/1nl5wpQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8154C3D079ABF34BAFDD6596570EF2CB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c124020e-b77c-4bd2-9eeb-08d62e8513aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 07:50:41.3418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 07:37:44AM +0200, Sascha Hauer wrote:
> On Tue, Oct 09, 2018 at 10:56:14PM +0000, Leonard Crestez wrote:
> > On Tue, 2018-10-09 at 08:37 +0000, Abel Vesa wrote:
> > > +struct clk *imx_clk_composite_8m_flags(const char *name,
> > > +					const char **parent_names,
> > > +					int num_parents, void __iomem *reg,
> > > +					unsigned long flags);
> > > +
> > > +#define __imx_clk_composite_8m(name, parent_names, reg, flags) \
> > > +	imx_clk_composite_8m_flags(name, parent_names, \
> > > +		ARRAY_SIZE(parent_names), reg, \
> > > +		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
> > > +
> > > +#define imx_clk_composite_8m(name, parent_names, reg) \
> > > +	__imx_clk_composite_8m(name, parent_names, reg, 0)
> > > +
> > > +#define imx_clk_composite_8m_critical(name, parent_names, reg) \
> > > +	__imx_clk_composite_8m(name, parent_names, reg, CLK_IS_CRITICAL)
> >=20
> > Does anyone else think that the "8m" would be prettier next to imx
> > rather than as a suffix? Using imx8m_clk_composite* and
> > imx7ulp_clk_composite* makes more sense to me.
>=20
> +1
>=20
> Sascha

Just sent another version.

Abel

>=20
> --=20
> Pengutronix e.K.                           |                             =
|
> Industrial Linux Solutions                 | https://emea01.safelinks.pro=
tection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pengutronix.de%2F&amp;data=3D02=
%7C01%7Cabel.vesa%40nxp.com%7C4eaf85c4f4504cc112d908d62e72870e%7C686ea1d3bc=
2b4c6fa92cd99c5c301635%7C0%7C0%7C636747466762782779&amp;sdata=3DmuaryKQFzFY=
CKzVw4XNxzp0m1Y1wZmAsfwNBodJfTKY%3D&amp;reserved=3D0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

-- =
