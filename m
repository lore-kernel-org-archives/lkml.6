Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA51C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C652098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gj34291X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C652098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeJMVED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 17:04:03 -0400
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:41424
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726235AbeJMVEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 17:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F1hh0Anbu/qXj9tlGf5Gc8HqJJFXKFu7XsCYdQg0jA=;
 b=gj34291X8sGD9rVV9p70SMPuoKpCUFZFS7lk9KErd1MU6u1tqCHgHAGb1EeUzQGPLa0TsSQT3vctosKRGdmbIRXtiHDD3XQ3EW2wcwrNi4uBF0Z89/3b6mdBcvKSY44tzD49606T/wdyxjzE0+1Gs6MFMA6WY/zXp9EiB0ePdDk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4900.eurprd04.prod.outlook.com (20.176.215.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Sat, 13 Oct 2018 13:26:47 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::25a0:3167:d718:91c1]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::25a0:3167:d718:91c1%3]) with mapi id 15.20.1228.020; Sat, 13 Oct 2018
 13:26:47 +0000
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
Thread-Index: AQHUHpzNbEQ50bW8r0K17gNet3HqL6Sgx+QwgDJrIKCAD7HAYIAePDVAgBySYiA=
Date:   Sat, 13 Oct 2018 13:26:46 +0000
Message-ID: <AM0PR04MB4211DA1E7F0C9DBD635E136780E30@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB421169829CFE1A6A32DCC209802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB421153E1441FBE356E1B859E800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB421176CFEF18F815CE0EC1A980010@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211732CC6C078017C8B849680160@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211732CC6C078017C8B849680160@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4900;6:SrThWGOWTVDvQtGPyEjQo7zUwJLnq7w8SqFqpGhsiJasq0OvsgwtrzyyezEWGQ8cxDCBOMuEU99oZnBwodsMGQG/9sBQoUbSUeZihRfVxtAL0wa7y3YdkPUKpO9wsaty4jO0DS3AF6qnAiVCdy3H+43BOkI85zTQSV4myvsOsjPKJMPeB+oidBdZ7Wc9UKvAG3nC2mx03vpWsr68/L7Qu/amZYWlzr3eraHMj7cJenPla+JVQe+zkxLjtrO4wiZSZ0HZOsLu/Y8gCWtHghTp97q7AtS4YTpyNbNspU/nPzylA/Mf7dIpQMC55zhKnIwC6M0SGnUQsGn0bH1qmXpMLLkhGSqHGiBSO/Ajk6PUPnICb/mPbtd6blGhNtlv5u+FkuXOFmQim/w9ASsS5SdEddbAUg0its1/R0wx0N+tINBUTN7eoGNvGFkztdb4IkNspjQjoqcPSyilM8nbxiaOUw==;5:YrMsxPTLlK7UkxMbBdYX4zJK+k5sBDq9ugR4KUuvkqFtrcKCVFDFiQs9jfEP+U7J+Yx3kKoIPOwzb68ka7cCcUy7iY9YE6p0y3lh7LBLJLz9xlaPGxGaMCKOVFnYcnzeCe5plKpu1x93QYcFqY66ONwVD/AFrq3okR6t+enMIao=;7:4GH03tfg5t5CW7nR3zCMNOmGbFF/Jmx2fM774/bIDZWfaDtW8IOeVzDnWOBl8MsyKTU7yoVmWiy+PvKpdFNx970wZJcD3e2hrYyb91sgQwGyBxW6a7BujGeM0QW+iVQqKtswPVoRwrUbtJ4Fd0BF2/aUQQClxTot5vIFGEov9P4FD1+v36vtwdZ0biM2DV38TgrE+Ftyn/LI7xMJUUyowg+d5Ja8Y5UMeoeDB3YzWCbmQpu+ulleRGbolkjsF3gW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 17b3916e-4049-4892-967b-08d6310f86a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4900;
x-ms-traffictypediagnostic: AM0PR04MB4900:
x-microsoft-antispam-prvs: <AM0PR04MB490000C6F48333175F4FCC9280E30@AM0PR04MB4900.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:AM0PR04MB4900;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4900;
x-forefront-prvs: 082465FB26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(13464003)(54534003)(26005)(11346002)(446003)(68736007)(5660300001)(6246003)(2900100001)(106356001)(14444005)(256004)(478600001)(99286004)(966005)(4326008)(74316002)(14454004)(25786009)(105586002)(7696005)(486006)(7736002)(476003)(186003)(305945005)(33656002)(6116002)(102836004)(3846002)(53936002)(316002)(97736004)(55016002)(6436002)(76176011)(86362001)(8936002)(6306002)(81156014)(93886005)(5250100002)(2501003)(110136005)(54906003)(6506007)(53546011)(81166006)(71200400001)(71190400001)(8676002)(229853002)(2906002)(66066001)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4900;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6g7tYyNX5BmtRYsmQVMcxTs570ce3fI+3mviSjRGHvYdzJF90DsZrfJbW3wUmZgIEmBTgaEC9vb5umR+HmwMvaESRFGguwY5ClxbT4oE55vr3yksOEhw36BKLSSPYTuFJwM7fQxoOoJy6u4wBTiybBgIzqkfpBKu/Cm+AyAlU7NnGqqwax1A9RcJo0PopRL7kiduDLvvy+Elx2lopdRsBELHOnl/kiTogCKG56z8TrfI06NU8dxGYhRRyTADiQxLG2jVzHEs4MEkS1w2lpZV1Fxl5J/Mac1CA46QpQynVruE8QKyw0p+IG0/lNQTwKYOCogOR7VGhsZDSGyGUG9NJDbVUtqmmhMK1mCZyhbWby8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b3916e-4049-4892-967b-08d6310f86a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2018 13:26:47.0725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping

> -----Original Message-----
> From: A.s. Dong
> Sent: Tuesday, September 25, 2018 5:11 PM
> To: sboyd@kernel.org; shawnguo@kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> mturquette@baylibre.com; Anson Huang <anson.huang@nxp.com>; Jacky Bai
> <ping.bai@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> linux-clk@vger.kernel.org
> Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
>=20
> It's been a few months without comments.
>=20
> Shawn & Stephen,
> Would you provide some suggestions on how to handle this?
>=20
> Regards
> Dong Aisheng
>=20
> > -----Original Message-----
> > From: A.s. Dong
> > Sent: Thursday, September 6, 2018 11:25 AM
> > To: linux-clk@vger.kernel.org; sboyd@kernel.org; shawnguo@kernel.org
> > Cc: linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org;
> > mturquette@baylibre.com; Anson Huang <anson.huang@nxp.com>; Jacky
> Bai
> > <ping.bai@nxp.com>; dl-linux-imx <linux-imx@nxp.com>
> > Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
> >
> > Hi Stephen,
> >
> > Would you shine some lights on how to proceed?
> >
> > Regards
> > Dong Aisheng
> >
> > > -----Original Message-----
> > > From: A.s. Dong
> > > Sent: Monday, August 27, 2018 11:46 AM
> > > To: linux-clk@vger.kernel.org; sboyd@kernel.org; shawnguo@kernel.org
> > > Cc: linux-kernel@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org;
> > > mturquette@baylibre.com; Anson Huang <anson.huang@nxp.com>; Jacky
> > Bai
> > > <ping.bai@nxp.com>; dl-linux-imx <linux-imx@nxp.com>
> > > Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
> > >
> > > Kindly ping again...  This is really pending too long...
> > >
> > > Stephen & Shawn,
> > > Any suggestion on how to proceed this patch set?
> > >
> > > Regards
> > > Dong Aisheng
> > >
> > > > -----Original Message-----
> > > > From: A.s. Dong
> > > > Sent: Thursday, July 26, 2018 9:51 AM
> > > > To: linux-clk@vger.kernel.org; sboyd@kernel.org
> > > > Cc: linux-kernel@vger.kernel.org;
> > > > linux-arm-kernel@lists.infradead.org;
> > > > mturquette@baylibre.com; shawnguo@kernel.org; Anson Huang
> > > > <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-linux-imx
> > > > <linux-imx@nxp.com>
> > > > Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
> > > >
> > > > Hi Stephen,
> > > >
> > > > Do you have a chance to look at it?
> > > > This patch series has been pending for quite a long time without
> > > > much comments.
> > > >
> > > > Regards
> > > > Dong Aisheng
> > > >
> > > > > -----Original Message-----
> > > > > From: A.s. Dong
> > > > > Sent: Wednesday, July 18, 2018 9:37 PM
> > > > > To: linux-clk@vger.kernel.org
> > > > > Cc: linux-kernel@vger.kernel.org;
> > > > > linux-arm-kernel@lists.infradead.org;
> > > > > sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org;
> > > > Anson
> > > > > Huang <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-
> > > > > linux-imx <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> > > > > Subject: [PATCH V4 0/9] clk: add imx7ulp clk support
> > > > >
> > > > > This is a rebased version of below patch series against latest cl=
k tree.
> > > > > [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
> > > > > https://lkml.org/lkml/2018/3/16/310
> > > > >
> > > > > This patch series intends to add imx7ulp clk support.
> > > > >
> > > > > i.MX7ULP Clock functions are under joint control of the System
> > > > > Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
> > > > > modules, and Core Mode Controller (CMC)1 blocks
> > > > >
> > > > > The clocking scheme provides clear separation between M4 domain
> > > > > and
> > > > > A7 domain. Except for a few clock sources shared between two
> > > > > domains, such as the System Oscillator clock, the Slow IRC
> > > > > (SIRC), and and the Fast IRC clock (FIRCLK), clock sources and
> > > > > clock management are separated and contained within each domain.
> > > > >
> > > > > M4 clock management consists of SCG0, PCC0, PCC1, and CMC0
> > modules.
> > > > > A7 clock management consists of SCG1, PCC2, PCC3, and CMC1
> modules.
> > > > >
> > > > > Note: this series only adds A7 clock domain support as M4 clock
> > > > > domain will be handled by M4 seperately.
> > > > >
> > > > > Change Log:
> > > > > v3->v4:
> > > > >  * rebased to latest kernel
> > > > >  * make scg and pcc separate nodes according to Rob's suggestion
> > > > >
> > > > > v2->v3:
> > > > >  * Patch 1 changed on: 1) split normal and gate ops 2) fix the
> > > > > possible
> > racy
> > > > >    Others no changes.
> > > > >
> > > > > v1->v2:
> > > > >  * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE
> > > > > dividers
> > > > >  * use clk_hw apis to register clocks
> > > > >  * use of_clk_add_hw_provider
> > > > >  * split the clocks register process into two parts: early part f=
or
> possible
> > > > >    timers clocks registered by CLK_OF_DECLARE_DRIVER and the
> > > > > later part
> > > > for
> > > > >    the left normal peripheral clocks registered by a platform dri=
ver.
> > > > >
> > > > > Dong Aisheng (9):
> > > > >   clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
> > > > >   clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag
> > > support
> > > > >   clk: imx: add pllv4 support
> > > > >   clk: imx: add pfdv2 support
> > > > >   clk: imx: add composite clk support
> > > > >   dt-bindings: clock: add imx7ulp clock binding doc
> > > > >   clk: imx: make mux parent strings const
> > > > >   clk: imx: implement new clk_hw based APIs
> > > > >   clk: imx: add imx7ulp clk driver
> > > > >
> > > > >  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87 +++++++=
++
> > > > >  drivers/clk/clk-divider.c                          | 152
> > > > +++++++++++++++
> > > > >  drivers/clk/clk-fractional-divider.c               |  10 +
> > > > >  drivers/clk/imx/Makefile                           |   6 +-
> > > > >  drivers/clk/imx/clk-busy.c                         |   2 +-
> > > > >  drivers/clk/imx/clk-composite.c                    |  85
> > +++++++++
> > > > >  drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
> > > > >  drivers/clk/imx/clk-imx7ulp.c                      | 209
> > > > +++++++++++++++++++++
> > > > >  drivers/clk/imx/clk-pfdv2.c                        | 201
> > > > ++++++++++++++++++++
> > > > >  drivers/clk/imx/clk-pllv4.c                        | 182
> > > > ++++++++++++++++++
> > > > >  drivers/clk/imx/clk.c                              |  22 +++
> > > > >  drivers/clk/imx/clk.h                              |  92
> > ++++++++-
> > > > >  include/dt-bindings/clock/imx7ulp-clock.h          | 109
> > > +++++++++++
> > > > >  include/linux/clk-provider.h                       |  17 ++
> > > > >  14 files changed, 1166 insertions(+), 10 deletions(-)  create
> > > > > mode
> > > > > 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> > > > >  create mode 100644 drivers/clk/imx/clk-composite.c  create mode
> > > > > 100644 drivers/clk/imx/clk-imx7ulp.c  create mode 100644
> > > > > drivers/clk/imx/clk- pfdv2.c  create mode 100644
> > > > > drivers/clk/imx/clk-pllv4.c  create mode 100644
> > > > > include/dt-bindings/clock/imx7ulp-clock.h
> > > > >
> > > > > --
> > > > > 2.7.4

