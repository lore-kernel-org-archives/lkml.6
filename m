Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83385C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115C22086B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TXtKw1CW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115C22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbeIFIAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 04:00:20 -0400
Received: from mail-he1eur01on0040.outbound.protection.outlook.com ([104.47.0.40]:20896
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbeIFIAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 04:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHmKpYdYjaREprwA+xxfy/TMS4Uhz53VTzExMrDPVrE=;
 b=TXtKw1CWoZsERmO+duAiv13EFbu+hYJyKmKHPN9EazfmzZVF6G4Hn5WstQeJHTs0FZPXatVZW6W4e4ekWwD65CQ+KeuhmET8WnK2YNYYRNT+DSorsGfywiKM7GXGEpVxaJr1ngLMnK5aCmynsSXjVI+xuKjoffRRu/grnn2kiTc=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4547.eurprd04.prod.outlook.com (52.135.148.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.16; Thu, 6 Sep 2018 03:25:06 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9475:35f6:e801:6802]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9475:35f6:e801:6802%4]) with mapi id 15.20.1101.019; Thu, 6 Sep 2018
 03:25:06 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
Thread-Topic: [PATCH V4 0/9] clk: add imx7ulp clk support
Thread-Index: AQHUHpzNbEQ50bW8r0K17gNet3HqL6Sgx+QwgDJrIKCAD7HAYA==
Date:   Thu, 6 Sep 2018 03:25:06 +0000
Message-ID: <AM0PR04MB421176CFEF18F815CE0EC1A980010@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB421169829CFE1A6A32DCC209802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB421153E1441FBE356E1B859E800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB421153E1441FBE356E1B859E800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4547;6:aCYdpDSNkRVrLOo/KjiSRUlvMK+GdAaW5j1Alm4N7RoJwcfggVYRya+QRQrC9PL+aLVb184XLcSSToGM42Bgb1nRjpV0sHHOwAhN1otorklq+/ZQTFZMUL8XM3I7jz7WeMtfhH7uShulQnmJd+dZZCmeVuoWAMBdq6JFno3z3Ftq6aQ0G5Hbnzmf9vB+bQVCiUxKWZg4aj15VUN2FUzZtEVeEltRXwdBGpRktdo6Djinpd2EAi8BdqcLN+oqhGK2gl8N6Hs+LgMloL1AcmpGI/dyyo1yfSbPTFwP6IPFL0FF4byJikq2kQwfxJT3A0+FwmUFS7pcNr8wcM7AHo3M5/ki1nNauGsxe59jN1+iN/hjz3sYMJ31hxVuMsKmZgdYPJtO3dnZXRlVr8mHXGJhAtnCf+qFnZZJK4uoU/Gxqn+f2X+x1JV91SEegbawhKT1nKm7udk37fy1Lp3Qy9CiAA==;5:rRd0FhKH1gP3CmhTM8NfvF4XcqLAEZWgfFefxUB+A+Se/Re4vhVpQ6UTM3Ff1U1ak+B8S9pM7V5EeQCmKHklpvC5s5Lht3Xt5vVs2AwyebvunwmSuyrJIXZelT6Bn+SXKnnxQurBH4v1IHFTPC1ejZFs2ECtQhcHyfqtQj/29+g=;7:CnLvelSeQL47g2+5ombpt0k4j/mjGKaLThh9VzFNcrhTicKJzW4oodftldowJZtfzV1HhvAgXEVAWPZYUmtkIqur8f48MeHOGUNFdJoBQxRZhCS1gnrb0SnYexicRfgxPlk4W5Y9+3GK4tWYKRYwFiZ/LwfclB4G+xf84FLA63/6V0fw6H45n004sf12H7Ujl+0oPFj6kktNad4lNN2tH4+LMaQvC9G1GUN4VikcuFMjWUSTjdTF/cY4fVhomblK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8503e12a-0dbd-427e-7ccf-08d613a857d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4547;
x-ms-traffictypediagnostic: AM0PR04MB4547:
x-microsoft-antispam-prvs: <AM0PR04MB45477146B0B8372C23F68E8B80010@AM0PR04MB4547.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:AM0PR04MB4547;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4547;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(366004)(13464003)(54534003)(189003)(199004)(74316002)(6306002)(2900100001)(446003)(8936002)(86362001)(105586002)(4326008)(81166006)(81156014)(3846002)(11346002)(53936002)(8676002)(6436002)(6506007)(53546011)(486006)(229853002)(305945005)(55016002)(2906002)(9686003)(2201001)(14444005)(7736002)(476003)(2501003)(97736004)(256004)(966005)(7696005)(33656002)(25786009)(68736007)(26005)(186003)(316002)(14454004)(102836004)(76176011)(6246003)(106356001)(66066001)(5250100002)(6116002)(110136005)(99286004)(478600001)(54906003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4547;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XD9LftRULrYg1APZTGFY6t6XTvAKavt2p/OuseUXRd4iXc0seQN8tiFPdkJ1y0uqWsfc+YhIRjG0YJq5n3WYTf2zgEqlUKlKJ8zSiwuQgD/CBIudZV0t/te+9zMA0AsZhDSftii3CiClNKUsB53unSTc24QZ+l5EPdYxqNMRLzx99xC1J6YghbJMoITuq5Mo2I2xXuFnozs6/b6qbFhKaT92wvTY+5XNjjTKUYojsnEgLSoeE7dXrGs2SFgMJqExBQQjZbc44NnLBqxGd4EqhHOFXqkDm5ccd3B2p8kVGX4k3lZLidgkjr0iTrchqajMY2/SlN3QfFDf7hsMsqGwjvu2ErPa1tVItVuuklyjzuM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8503e12a-0dbd-427e-7ccf-08d613a857d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 03:25:06.7764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Would you shine some lights on how to proceed?

Regards
Dong Aisheng

> -----Original Message-----
> From: A.s. Dong
> Sent: Monday, August 27, 2018 11:46 AM
> To: linux-clk@vger.kernel.org; sboyd@kernel.org; shawnguo@kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> mturquette@baylibre.com; Anson Huang <anson.huang@nxp.com>; Jacky Bai
> <ping.bai@nxp.com>; dl-linux-imx <linux-imx@nxp.com>
> Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
>=20
> Kindly ping again...  This is really pending too long...
>=20
> Stephen & Shawn,
> Any suggestion on how to proceed this patch set?
>=20
> Regards
> Dong Aisheng
>=20
> > -----Original Message-----
> > From: A.s. Dong
> > Sent: Thursday, July 26, 2018 9:51 AM
> > To: linux-clk@vger.kernel.org; sboyd@kernel.org
> > Cc: linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org;
> > mturquette@baylibre.com; shawnguo@kernel.org; Anson Huang
> > <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
> >
> > Hi Stephen,
> >
> > Do you have a chance to look at it?
> > This patch series has been pending for quite a long time without much
> > comments.
> >
> > Regards
> > Dong Aisheng
> >
> > > -----Original Message-----
> > > From: A.s. Dong
> > > Sent: Wednesday, July 18, 2018 9:37 PM
> > > To: linux-clk@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org;
> > > sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org;
> > Anson
> > > Huang <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-
> > > linux-imx <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> > > Subject: [PATCH V4 0/9] clk: add imx7ulp clk support
> > >
> > > This is a rebased version of below patch series against latest clk tr=
ee.
> > > [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
> > > https://lkml.org/lkml/2018/3/16/310
> > >
> > > This patch series intends to add imx7ulp clk support.
> > >
> > > i.MX7ULP Clock functions are under joint control of the System Clock
> > > Generation (SCG) modules, Peripheral Clock Control (PCC) modules,
> > > and Core Mode Controller (CMC)1 blocks
> > >
> > > The clocking scheme provides clear separation between M4 domain and
> > > A7 domain. Except for a few clock sources shared between two
> > > domains, such as the System Oscillator clock, the Slow IRC (SIRC),
> > > and and the Fast IRC clock (FIRCLK), clock sources and clock
> > > management are separated and contained within each domain.
> > >
> > > M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> > > A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> > >
> > > Note: this series only adds A7 clock domain support as M4 clock
> > > domain will be handled by M4 seperately.
> > >
> > > Change Log:
> > > v3->v4:
> > >  * rebased to latest kernel
> > >  * make scg and pcc separate nodes according to Rob's suggestion
> > >
> > > v2->v3:
> > >  * Patch 1 changed on: 1) split normal and gate ops 2) fix the possib=
le racy
> > >    Others no changes.
> > >
> > > v1->v2:
> > >  * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
> > >  * use clk_hw apis to register clocks
> > >  * use of_clk_add_hw_provider
> > >  * split the clocks register process into two parts: early part for p=
ossible
> > >    timers clocks registered by CLK_OF_DECLARE_DRIVER and the later
> > > part
> > for
> > >    the left normal peripheral clocks registered by a platform driver.
> > >
> > > Dong Aisheng (9):
> > >   clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
> > >   clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag
> support
> > >   clk: imx: add pllv4 support
> > >   clk: imx: add pfdv2 support
> > >   clk: imx: add composite clk support
> > >   dt-bindings: clock: add imx7ulp clock binding doc
> > >   clk: imx: make mux parent strings const
> > >   clk: imx: implement new clk_hw based APIs
> > >   clk: imx: add imx7ulp clk driver
> > >
> > >  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87 +++++++++
> > >  drivers/clk/clk-divider.c                          | 152
> > +++++++++++++++
> > >  drivers/clk/clk-fractional-divider.c               |  10 +
> > >  drivers/clk/imx/Makefile                           |   6 +-
> > >  drivers/clk/imx/clk-busy.c                         |   2 +-
> > >  drivers/clk/imx/clk-composite.c                    |  85 +++++++++
> > >  drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
> > >  drivers/clk/imx/clk-imx7ulp.c                      | 209
> > +++++++++++++++++++++
> > >  drivers/clk/imx/clk-pfdv2.c                        | 201
> > ++++++++++++++++++++
> > >  drivers/clk/imx/clk-pllv4.c                        | 182
> > ++++++++++++++++++
> > >  drivers/clk/imx/clk.c                              |  22 +++
> > >  drivers/clk/imx/clk.h                              |  92 ++++++++-
> > >  include/dt-bindings/clock/imx7ulp-clock.h          | 109
> +++++++++++
> > >  include/linux/clk-provider.h                       |  17 ++
> > >  14 files changed, 1166 insertions(+), 10 deletions(-)  create mode
> > > 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> > >  create mode 100644 drivers/clk/imx/clk-composite.c  create mode
> > > 100644 drivers/clk/imx/clk-imx7ulp.c  create mode 100644
> > > drivers/clk/imx/clk- pfdv2.c  create mode 100644
> > > drivers/clk/imx/clk-pllv4.c  create mode 100644
> > > include/dt-bindings/clock/imx7ulp-clock.h
> > >
> > > --
> > > 2.7.4

