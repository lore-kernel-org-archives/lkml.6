Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A00C46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B935E20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GmfH10cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B935E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388540AbeKGAzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:55:51 -0500
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:11645
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388107AbeKGAzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTveJ2nUJEVACsSgHHa9nVznCedQTXNcf71rhV8jDI8=;
 b=GmfH10cwGVGnIu1PCROjkkQcyJ/g1pfBV8qcjzSs7dbGyEjSs+FujFj5xk2BqeUVM+/h1r6QEpoSY4Oazbpj0PNZXsEWEXo7jb4wmoZbqyN5J4SGpmFBVwfUlZnTZhjW3KT4vv2nYubESipiF7aKUmnz+HacFiMe3ssXCTbhEpM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4993.eurprd04.prod.outlook.com (20.177.40.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Tue, 6 Nov 2018 15:30:03 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 15:30:03 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
Thread-Topic: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
Thread-Index: AQHUaT95oCO6Jr50e0qyeeRGaZQa8qUprLpggBlLwPA=
Date:   Tue, 6 Nov 2018 15:30:03 +0000
Message-ID: <AM0PR04MB4211280B09B72F637FC5650280CB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211576EF2FE906A6B0C3F1680FB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211576EF2FE906A6B0C3F1680FB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4993;6:EIKsuHIm0PPMA+QsEYlVBdlXPOaI/fDij0j8TNSlm+1L8Ml8cwuoqdhGKB2i6VT7/bYPygerIGHW13zQ9Lv8YoYuxPOHkFgaUaeEnZD5Mu2dSaTsjajRJI+oJcy2oMFWCf091AwfSdsSAWq70FEJHB+X7N8BFoSt1uPhNpAeCJfSTp/jIpE2B/MLlEAwRMiYqAqKQPlEbD/wFAIcWWVhdsfcKO8pPs8W6SOXK5OBw1mkgu0ljEdJhjnvVbcxHzkGgyyKErzthI/SOjKpKLfL1oRlcKQf4BEy8VIEsUcGXsqv/loenK2Xn46q2863I2QTnZujKaMg0jpE+y6qwyj0KzzR7I2gGRxRzk/XyT8U/gLjlI3UdcEYNSBP0GsHWQjg3eQuUwxk6mqW8xSE2bGcvueU3DKVkcJtJyZvKnzNzu56yG43YidMF69Xha0HTGOkDa+XSbC4ycyNHlZhFwHEUQ==;5:u/Km+kZWNt9FK5erTUrdYC1Ak6qYHAheHzzKqKYHJWmcloiHFsnES4lfbTl/01Up4BhLNZFJQ9dgDag3hxJUxVvmFARBZb/BDyF2xzEOll9p76vkecfBYawuGZiWdkrxAjki8hPDxdLquHITm/QW+E5GwcUJLfG1i1DRZMDuoy0=;7:mbjuJaIdOI8PE1/4MhwxTeijCaLLGxpFGjnlEnTTF1rKbyEUYOpQbCYClu9yCdJEiB50LAlJiu5kb5UUEc5qLOlx9J+KVSa1U8yNTKjvy75ZW0LFJbqqowcA9OKhHC/dJyygpEIyYknKP0/GaqAa9w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8b4e740a-cc54-49dc-68c9-08d643fcb8db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4993;
x-ms-traffictypediagnostic: AM0PR04MB4993:
x-microsoft-antispam-prvs: <AM0PR04MB4993EBE9DE93B16EED2ECF7080CB0@AM0PR04MB4993.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4993;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4993;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(396003)(376002)(54534003)(13464003)(189003)(199004)(6306002)(53546011)(186003)(76176011)(5660300001)(7736002)(2906002)(106356001)(26005)(8936002)(2900100001)(305945005)(7696005)(53936002)(1730700003)(6506007)(6436002)(5640700003)(55016002)(99286004)(74316002)(81156014)(81166006)(6246003)(105586002)(9686003)(6916009)(66066001)(25786009)(256004)(2351001)(217873002)(11346002)(476003)(33656002)(14444005)(316002)(97736004)(2501003)(8676002)(102836004)(54906003)(486006)(229853002)(71190400001)(71200400001)(446003)(68736007)(3846002)(86362001)(6116002)(14454004)(478600001)(4326008)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4993;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vS5ilameW5xngEDuI+0kBBbG8Z6SZnHHCbtOc9PSzszC3qS+bKSfzWHMWALkwMcqrmyZcCqWc3BVQmIvrWMsP5MLPpRKjNU6f2F7BCDp/LHIGoBvNULAqj4Z+3hfznusXyl3zG5K411Qlbk1gzVs4Vj6qSTm11ElB+8HRP0f0n0WsrF4u0Kzr65jxA6BsO+XnWO+KCF8zOnZr9KJ8FgQeshy8alYOXbk2RXcL3wP++21IVEGAtqu1Nl/BsoKeNzYkUkmFuOloSoDeeAKwIVqPvNKNie89IhrOK8BllPy1BXsmJt+doEKrPHE2Mc7FqRkoOgPzeaT3oJktL6h7DFLz0oJG9E+2GDhepb6JKfuci8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4e740a-cc54-49dc-68c9-08d643fcb8db
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 15:30:03.0489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4993
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gently Ping...

> -----Original Message-----
> From: A.s. Dong
> Sent: Sunday, October 21, 2018 9:15 PM
> To: sboyd@kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> mturquette@baylibre.com; shawnguo@kernel.org; Anson Huang
> <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-linux-imx
> <linux-imx@nxp.com>; linux-clk@vger.kernel.org
> Subject: RE: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
>=20
> Hi Stephen,
>=20
> In case you might miss to queue this series into your review list, so I r=
esend this
> series again.
> This series actually has been pending for a couple of months without
> comments.
> Hopefully you could help find some time to handle it when you're free.
>=20
> Thanks
>=20
> Regards
> Dong Aisheng
>=20
> > -----Original Message-----
> > From: A.s. Dong
> > Sent: Sunday, October 21, 2018 9:11 PM
> > To: linux-clk@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org;
> > sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org;
> Anson
> > Huang <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>;
> > dl-linux-imx <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> > Subject: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
> >
> > This is a rebased version of below patch series against latest clk tree=
.
> > [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
> > https://lkml.org/lkml/2018/3/16/310
> >
> > It only updates the license to SPDX format as well as a minor fix of pl=
lv4.
> >
> > This patch series intends to add imx7ulp clk support.
> >
> > i.MX7ULP Clock functions are under joint control of the System Clock
> > Generation (SCG) modules, Peripheral Clock Control (PCC) modules, and
> > Core Mode Controller (CMC)1 blocks
> >
> > The clocking scheme provides clear separation between M4 domain and A7
> > domain. Except for a few clock sources shared between two domains,
> > such as the System Oscillator clock, the Slow IRC (SIRC), and and the
> > Fast IRC clock (FIRCLK), clock sources and clock management are
> > separated and contained within each domain.
> >
> > M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> > A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> >
> > Note: this series only adds A7 clock domain support as M4 clock domain
> > will be handled by M4 seperately.
> >
> > Change Log:
> > v3->v4:
> >  * update after changing scg and pcc into separete nodes according to
> >    Rob's suggestion
> > v2->v3:
> >  * Patch 1 changed on: 1) split normal and gate ops 2) fix the possible=
 racy
> >    Others no changes.
> >
> > v1->v2:
> >  * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
> >  * use clk_hw apis to register clocks
> >  * use of_clk_add_hw_provider
> >  * split the clocks register process into two parts: early part for pos=
sible
> >    timers clocks registered by CLK_OF_DECLARE_DRIVER and the later part
> for
> >    the left normal peripheral clocks registered by a platform driver.
> >
> > Dong Aisheng (9):
> >   clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
> >   clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
> >   clk: imx: add pllv4 support
> >   clk: imx: add pfdv2 support
> >   clk: imx: add composite clk support
> >   dt-bindings: clock: add imx7ulp clock binding doc
> >   clk: imx: make mux parent strings const
> >   clk: imx: implement new clk_hw based APIs
> >   clk: imx: add imx7ulp clk driver
> >
> >  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87 +++++++++
> >  drivers/clk/clk-divider.c                          | 152
> > +++++++++++++++
> >  drivers/clk/clk-fractional-divider.c               |  10 +
> >  drivers/clk/imx/Makefile                           |   6 +-
> >  drivers/clk/imx/clk-busy.c                         |   2 +-
> >  drivers/clk/imx/clk-composite.c                    |  85 +++++++++
> >  drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
> >  drivers/clk/imx/clk-imx7ulp.c                      | 209
> > +++++++++++++++++++++
> >  drivers/clk/imx/clk-pfdv2.c                        | 201
> > ++++++++++++++++++++
> >  drivers/clk/imx/clk-pllv4.c                        | 182
> > ++++++++++++++++++
> >  drivers/clk/imx/clk.c                              |  22 +++
> >  drivers/clk/imx/clk.h                              |  92 ++++++++-
> >  include/dt-bindings/clock/imx7ulp-clock.h          | 109 +++++++++++
> >  include/linux/clk-provider.h                       |  17 ++
> >  14 files changed, 1166 insertions(+), 10 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> >  create mode 100644 drivers/clk/imx/clk-composite.c  create mode
> > 100644 drivers/clk/imx/clk-imx7ulp.c  create mode 100644
> > drivers/clk/imx/clk-pfdv2.c  create mode 100644
> > drivers/clk/imx/clk-pllv4.c create mode 100644
> > include/dt-bindings/clock/imx7ulp-clock.h
> >
> > --
> > 2.7.4

