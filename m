Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0B9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226B0214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SuqmobIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226B0214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeIYPRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:17:51 -0400
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:17949
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727570AbeIYPRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfZ0dWLfJeBrWINTTpjx3hI4/kg/7xkuYrXEBrsR3xM=;
 b=SuqmobIFk71F+R3hv/Et45Jy6LvrEhMocLl8VWf/Bc4zANyRFQNW0WsJrJVHFFnSnZ6Z1+DrqZ3nWr1ZIcMgWmxYli/zsmqKuVvYeGLeTE9BopakCs6VjtW4DrA3PzQ9EBw18B9gA7abfaiBaasBML8s/shhHs0kcM2CVJZFot8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4147.eurprd04.prod.outlook.com (52.134.125.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Tue, 25 Sep 2018 09:11:13 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::25a0:3167:d718:91c1]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::25a0:3167:d718:91c1%3]) with mapi id 15.20.1164.024; Tue, 25 Sep 2018
 09:11:13 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
Thread-Topic: [PATCH V4 0/9] clk: add imx7ulp clk support
Thread-Index: AQHUHpzNbEQ50bW8r0K17gNet3HqL6Sgx+QwgDJrIKCAD7HAYIAePDVA
Date:   Tue, 25 Sep 2018 09:11:13 +0000
Message-ID: <AM0PR04MB4211732CC6C078017C8B849680160@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB421169829CFE1A6A32DCC209802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB421153E1441FBE356E1B859E800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB421176CFEF18F815CE0EC1A980010@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB421176CFEF18F815CE0EC1A980010@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4147;6:x5vkHKYdj5lYTS4vg7eLkD4Cxe2ONDj/cY9DfhJU08EOSDVxo5mgHKoLLwGIa0TJHPmgGuTbxtI7zQIVfWCo5KHRUtXaHKB+fMCjVOXYjZH/5xh2bUQ4O+E+q16/xCO3eJr3tIk7n4S1aC9Ia3qb0xqbnbNsr889lH5EQK5YTevXkFpxh5hqPZqF+7Pm/YnWnMYAWM7ZcWZiQntV6/3U7wmFAtiUB73XVgPYsOdAk8fPEMYq1pN1s/XZtR6XUx1P66ZnZb+xBYxf8tPDlSu8PUr7cnB3WmpczZUkICrcKgGn8qkdxSNVUwpK5oCubYXOmtv92lh9BoXltMM41VlBVoejnp1r4XWqbT/z4S5c9+Mb91IKFcSvAmmebzba5Yvw3J+4Mc8pVAk4AGFWgn7YNjko5K38dqo+xIImF8Seu651MuD+RgmyxAbZTZFvnjS7bCZZ5ONmki/1PKc6Fl5UiQ==;5:Qry2pDgd/83lU9dvINsfATR4zsay+DGS3iNvUyrHQpKE0/Y5FatXxozhAFFZdf8ABavCPRsS5isb9gOB41PNC2vgyd8YM1Fa8qyPuqzOACtG5AJWryqpwtQOtDdyoWkb5M1qUY5VgtI4haLlfshZRaPb+hk9OSe4pyJqibk+HCg=;7:ZW6GOAsj8MK/6Ys/cvWQmYtnD1+6RnCYW628I6XGQV0rwGrOe7DJFbg0R10em/f7fhBMAAlFOJwKJux7gMxgYQFxevlG+g8XoCeJyhwnoe3QTZveVdF0i4Q6IbwSzuWYTIdJSJkLpntSSsZf8gdZLxXRz/IOQt6bP82fPZKdbauohzOmwXe9X2grpG4twikkRvovEBWOJum/7HNhxh4DjucC8dMUoGSbPqz/fWK+Mea4UikWEwERYUDy9Ufu9ogU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6b3cc9e6-38dc-4eca-c45b-08d622c6d757
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4147;
x-ms-traffictypediagnostic: AM0PR04MB4147:
x-microsoft-antispam-prvs: <AM0PR04MB41476E58EBE817501E2A180080160@AM0PR04MB4147.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:AM0PR04MB4147;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4147;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(54534003)(13464003)(6116002)(3846002)(8936002)(81156014)(8676002)(81166006)(97736004)(2906002)(186003)(26005)(76176011)(7696005)(102836004)(66066001)(53546011)(6506007)(93886005)(86362001)(68736007)(5660300001)(2900100001)(2501003)(33656002)(5250100002)(105586002)(106356001)(9686003)(6306002)(55016002)(53936002)(478600001)(476003)(229853002)(25786009)(446003)(11346002)(6246003)(71200400001)(71190400001)(4326008)(110136005)(54906003)(486006)(6436002)(14454004)(316002)(99286004)(14444005)(966005)(256004)(7736002)(74316002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4147;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EnpexAYK7DIO4S1R6DCOqwgpxRA0zByugyPc4RUCwqy2OnBLPMNImmDTUR2AEOVI+2eoM0ydTJeIwxe/zJuktMDtyRFdJyCrIZp35Ww+ZSPiQFlGxgbooGIuai2iqfANjBiNODwyv+qgcL2arUeVboRgep2vXLg76nS+ACUZ302V+ksaAjsdBUcykDPyg6TVY8iZoIEB47OZ3QhHotMP4B9HsYNAUk0fyHe73vd4McwFi0WNJUXSL074qacp8ODkYDNKIC2C4VLpU0SAMLhEeUxrGUKJAKJt5AvG8KzwrcId+PwUKgFGvLhan4DTqgGKfUbFlWEoyTGRH6LItZPVqrBYFQvTjtPYoKuSchRzSDU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3cc9e6-38dc-4eca-c45b-08d622c6d757
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 09:11:13.0444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a few months without comments.

Shawn & Stephen,
Would you provide some suggestions on how to handle this?

Regards
Dong Aisheng

> -----Original Message-----
> From: A.s. Dong
> Sent: Thursday, September 6, 2018 11:25 AM
> To: linux-clk@vger.kernel.org; sboyd@kernel.org; shawnguo@kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> mturquette@baylibre.com; Anson Huang <anson.huang@nxp.com>; Jacky Bai
> <ping.bai@nxp.com>; dl-linux-imx <linux-imx@nxp.com>
> Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
>=20
> Hi Stephen,
>=20
> Would you shine some lights on how to proceed?
>=20
> Regards
> Dong Aisheng
>=20
> > -----Original Message-----
> > From: A.s. Dong
> > Sent: Monday, August 27, 2018 11:46 AM
> > To: linux-clk@vger.kernel.org; sboyd@kernel.org; shawnguo@kernel.org
> > Cc: linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org;
> > mturquette@baylibre.com; Anson Huang <anson.huang@nxp.com>; Jacky
> Bai
> > <ping.bai@nxp.com>; dl-linux-imx <linux-imx@nxp.com>
> > Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
> >
> > Kindly ping again...  This is really pending too long...
> >
> > Stephen & Shawn,
> > Any suggestion on how to proceed this patch set?
> >
> > Regards
> > Dong Aisheng
> >
> > > -----Original Message-----
> > > From: A.s. Dong
> > > Sent: Thursday, July 26, 2018 9:51 AM
> > > To: linux-clk@vger.kernel.org; sboyd@kernel.org
> > > Cc: linux-kernel@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org;
> > > mturquette@baylibre.com; shawnguo@kernel.org; Anson Huang
> > > <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-linux-imx
> > > <linux-imx@nxp.com>
> > > Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
> > >
> > > Hi Stephen,
> > >
> > > Do you have a chance to look at it?
> > > This patch series has been pending for quite a long time without
> > > much comments.
> > >
> > > Regards
> > > Dong Aisheng
> > >
> > > > -----Original Message-----
> > > > From: A.s. Dong
> > > > Sent: Wednesday, July 18, 2018 9:37 PM
> > > > To: linux-clk@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org;
> > > > linux-arm-kernel@lists.infradead.org;
> > > > sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org;
> > > Anson
> > > > Huang <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-
> > > > linux-imx <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> > > > Subject: [PATCH V4 0/9] clk: add imx7ulp clk support
> > > >
> > > > This is a rebased version of below patch series against latest clk =
tree.
> > > > [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
> > > > https://lkml.org/lkml/2018/3/16/310
> > > >
> > > > This patch series intends to add imx7ulp clk support.
> > > >
> > > > i.MX7ULP Clock functions are under joint control of the System
> > > > Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
> > > > modules, and Core Mode Controller (CMC)1 blocks
> > > >
> > > > The clocking scheme provides clear separation between M4 domain
> > > > and
> > > > A7 domain. Except for a few clock sources shared between two
> > > > domains, such as the System Oscillator clock, the Slow IRC (SIRC),
> > > > and and the Fast IRC clock (FIRCLK), clock sources and clock
> > > > management are separated and contained within each domain.
> > > >
> > > > M4 clock management consists of SCG0, PCC0, PCC1, and CMC0
> modules.
> > > > A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> > > >
> > > > Note: this series only adds A7 clock domain support as M4 clock
> > > > domain will be handled by M4 seperately.
> > > >
> > > > Change Log:
> > > > v3->v4:
> > > >  * rebased to latest kernel
> > > >  * make scg and pcc separate nodes according to Rob's suggestion
> > > >
> > > > v2->v3:
> > > >  * Patch 1 changed on: 1) split normal and gate ops 2) fix the poss=
ible
> racy
> > > >    Others no changes.
> > > >
> > > > v1->v2:
> > > >  * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE
> > > > dividers
> > > >  * use clk_hw apis to register clocks
> > > >  * use of_clk_add_hw_provider
> > > >  * split the clocks register process into two parts: early part for=
 possible
> > > >    timers clocks registered by CLK_OF_DECLARE_DRIVER and the later
> > > > part
> > > for
> > > >    the left normal peripheral clocks registered by a platform drive=
r.
> > > >
> > > > Dong Aisheng (9):
> > > >   clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
> > > >   clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag
> > support
> > > >   clk: imx: add pllv4 support
> > > >   clk: imx: add pfdv2 support
> > > >   clk: imx: add composite clk support
> > > >   dt-bindings: clock: add imx7ulp clock binding doc
> > > >   clk: imx: make mux parent strings const
> > > >   clk: imx: implement new clk_hw based APIs
> > > >   clk: imx: add imx7ulp clk driver
> > > >
> > > >  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87 +++++++++
> > > >  drivers/clk/clk-divider.c                          | 152
> > > +++++++++++++++
> > > >  drivers/clk/clk-fractional-divider.c               |  10 +
> > > >  drivers/clk/imx/Makefile                           |   6 +-
> > > >  drivers/clk/imx/clk-busy.c                         |   2 +-
> > > >  drivers/clk/imx/clk-composite.c                    |  85
> +++++++++
> > > >  drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
> > > >  drivers/clk/imx/clk-imx7ulp.c                      | 209
> > > +++++++++++++++++++++
> > > >  drivers/clk/imx/clk-pfdv2.c                        | 201
> > > ++++++++++++++++++++
> > > >  drivers/clk/imx/clk-pllv4.c                        | 182
> > > ++++++++++++++++++
> > > >  drivers/clk/imx/clk.c                              |  22 +++
> > > >  drivers/clk/imx/clk.h                              |  92
> ++++++++-
> > > >  include/dt-bindings/clock/imx7ulp-clock.h          | 109
> > +++++++++++
> > > >  include/linux/clk-provider.h                       |  17 ++
> > > >  14 files changed, 1166 insertions(+), 10 deletions(-)  create
> > > > mode
> > > > 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> > > >  create mode 100644 drivers/clk/imx/clk-composite.c  create mode
> > > > 100644 drivers/clk/imx/clk-imx7ulp.c  create mode 100644
> > > > drivers/clk/imx/clk- pfdv2.c  create mode 100644
> > > > drivers/clk/imx/clk-pllv4.c  create mode 100644
> > > > include/dt-bindings/clock/imx7ulp-clock.h
> > > >
> > > > --
> > > > 2.7.4

