Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B928C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF11120685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UgsaMQEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF11120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeGZDFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:05:04 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:35920
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728505AbeGZDFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQN+zL5cLUxxpwdu/s5po+phpCc+9jR5gXi0rWsBrAk=;
 b=UgsaMQEMbiZjnmexZPU0WqigB5L1yU1roW4wYPM2vo3xp/jHmRtkgD68lI/CUZGC8K67h6+kKBj5MBbv9++FB6W1vkwwPkY7RPg/HS+b0lF5Iw8rsSeIIbW2BDnf6Ow+v5YWxr283ZAJcIO4RjNwWfE13+Obho+RTzcvs4J79J4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5266.eurprd04.prod.outlook.com (20.177.42.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.22; Thu, 26 Jul 2018 01:50:35 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::6c5e:bec5:949d:4cc1]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::6c5e:bec5:949d:4cc1%2]) with mapi id 15.20.0973.022; Thu, 26 Jul 2018
 01:50:35 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
Thread-Topic: [PATCH V4 0/9] clk: add imx7ulp clk support
Thread-Index: AQHUHpzNbEQ50bW8r0K17gNet3HqL6Sgx+Qw
Date:   Thu, 26 Jul 2018 01:50:35 +0000
Message-ID: <AM0PR04MB421169829CFE1A6A32DCC209802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5266;6:EyCkaCmk4IU1H/LHijQ/Be4xQL4nKgxq5PiTL1rzuSrEfn1onda7ohwFyIhvoY7aHsCbueyc/2uxAo5L0Tmtv7Ur07IwmR1L7gMbGmEUxth2mHGEwj+3hECkpXYDMHoRJcz19n5BikyINsqE8+Q2qvZhu3AtPvO67q2GZA1+4t5hqBAzMKS4gSKKpN61pgyW9Epgup/XLRAU3XKQ1yllVoXN1FHZQ6F8wqAa5PKPkBHL6Syezcr+epekoqUkBXbSDbFS+NTUMKyTa6bO54fWNpsgxpt1I5lH8mFvrjpeIqeDIZ54lI5DtWIdgTZ5YvDZV327o0SUxMoNCt5lx14tOkLBMu2khQnW43YtnOIG7bBo6AElCYNu8j6EgibaW4smBI3DCvPIrM5O6Uwahxh1Fmm6tjtun2qoQ8RJWO9BnEg9HshI9ytFWxjSdtE9lxNz8Qb1N4GSywFPgfjzrAqsmg==;5:KQWZpHePalr+Cq6YGW9/KLFw3uaEzTukDv8i7IYOcaSpk8ioDy16+q8Mvkpm9OnvvbzlT4tnItcXb81Qykb3Kdrt8FabKG6kHbKVWm66N0vdByRaQZ3DAQWsARv4dGr8kKuKQnXlkhqo5etuDaN/mS2/kzclskGY8n0/xyPb7j4=;7:nirqFDfTN6tPGFDmTfglwRkTVa5crp0XkWa7xIpHAQYweOIs26dZSyl2fI51SApnysr6q/bjDrGdYZ7b6vzI5qlwwjHYlWFVG/rCuqGNRDJ4UTTmpwuquwACU2Haz+3AkIEPNGsTR+xhnMLKICfoyCm6iyl/BdM9FcV4U2V8AQ5Sx+gwAJTQuPYjjy/gpeqoRKHYX++FPzT4/FS7/FDFybRaKB3oNWS8IGNKXLYWGg5V0Ag0hoWiARRltnoSSxu1
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dbff7206-9b3a-4b82-347a-08d5f29a2e20
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5266;
x-ms-traffictypediagnostic: AM0PR04MB5266:
x-microsoft-antispam-prvs: <AM0PR04MB526643AF501E97DD2547F85B802B0@AM0PR04MB5266.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB5266;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5266;
x-forefront-prvs: 07459438AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(54534003)(13464003)(199004)(189003)(4326008)(486006)(66066001)(2906002)(14454004)(478600001)(5250100002)(2501003)(5660300001)(54906003)(3846002)(476003)(7696005)(25786009)(68736007)(305945005)(9686003)(6116002)(7736002)(8676002)(6306002)(74316002)(55016002)(11346002)(81156014)(446003)(81166006)(53936002)(6436002)(110136005)(76176011)(53546011)(229853002)(6506007)(256004)(14444005)(33656002)(99286004)(26005)(6246003)(105586002)(966005)(97736004)(186003)(106356001)(102836004)(86362001)(2900100001)(316002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5266;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aQWyEK/Y7Bt7ZMtreigQLS+rcfOZPikUeXtXpngu5K6XoQTafoD9kb6qi7R50uYU9TU2gwT19fj0pBg9cLpPX0KTtfxjQFe7H6LHNpxdEfYb/qRgYc+llDAxrNamUMjxTrQ/f2nHyFWU8ni/2+q798+n53mEq2afNSnWbtkVQbrle1uQOm2PHgfMf0fEM8yvck4ylCxxPeePu8Vu7KcsSaeFRoSA2ly84dUtP4UZ7KZRbvsXik65J/rTgqRfFvleBbSxn+KM9skFb0HBEO6RN4WYuOu+e3nEe1BPLkszhGq2tR5YpCr7ayOnBpoHfi4N3hug/kbYLDzPu50BGzBJwbWODxZmP01IFurHxs9zMJk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbff7206-9b3a-4b82-347a-08d5f29a2e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2018 01:50:35.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5266
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Do you have a chance to look at it?
This patch series has been pending for quite a long time without much comme=
nts.

Regards
Dong Aisheng

> -----Original Message-----
> From: A.s. Dong
> Sent: Wednesday, July 18, 2018 9:37 PM
> To: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org;
> Anson Huang <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-
> linux-imx <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> Subject: [PATCH V4 0/9] clk: add imx7ulp clk support
>=20
> This is a rebased version of below patch series against latest clk tree.
> [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
> https://lkml.org/lkml/2018/3/16/310
>=20
> This patch series intends to add imx7ulp clk support.
>=20
> i.MX7ULP Clock functions are under joint control of the System Clock
> Generation (SCG) modules, Peripheral Clock Control (PCC) modules, and
> Core Mode Controller (CMC)1 blocks
>=20
> The clocking scheme provides clear separation between M4 domain and A7
> domain. Except for a few clock sources shared between two domains, such
> as the System Oscillator clock, the Slow IRC (SIRC), and and the Fast IRC=
 clock
> (FIRCLK), clock sources and clock management are separated and contained
> within each domain.
>=20
> M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
>=20
> Note: this series only adds A7 clock domain support as M4 clock domain wi=
ll
> be handled by M4 seperately.
>=20
> Change Log:
> v3->v4:
>  * rebased to latest kernel
>  * make scg and pcc separate nodes according to Rob's suggestion
>=20
> v2->v3:
>  * Patch 1 changed on: 1) split normal and gate ops 2) fix the possible r=
acy
>    Others no changes.
>=20
> v1->v2:
>  * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
>  * use clk_hw apis to register clocks
>  * use of_clk_add_hw_provider
>  * split the clocks register process into two parts: early part for possi=
ble
>    timers clocks registered by CLK_OF_DECLARE_DRIVER and the later part f=
or
>    the left normal peripheral clocks registered by a platform driver.
>=20
> Dong Aisheng (9):
>   clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
>   clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
>   clk: imx: add pllv4 support
>   clk: imx: add pfdv2 support
>   clk: imx: add composite clk support
>   dt-bindings: clock: add imx7ulp clock binding doc
>   clk: imx: make mux parent strings const
>   clk: imx: implement new clk_hw based APIs
>   clk: imx: add imx7ulp clk driver
>=20
>  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87 +++++++++
>  drivers/clk/clk-divider.c                          | 152 +++++++++++++++
>  drivers/clk/clk-fractional-divider.c               |  10 +
>  drivers/clk/imx/Makefile                           |   6 +-
>  drivers/clk/imx/clk-busy.c                         |   2 +-
>  drivers/clk/imx/clk-composite.c                    |  85 +++++++++
>  drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
>  drivers/clk/imx/clk-imx7ulp.c                      | 209 +++++++++++++++=
++++++
>  drivers/clk/imx/clk-pfdv2.c                        | 201 +++++++++++++++=
+++++
>  drivers/clk/imx/clk-pllv4.c                        | 182 +++++++++++++++=
+++
>  drivers/clk/imx/clk.c                              |  22 +++
>  drivers/clk/imx/clk.h                              |  92 ++++++++-
>  include/dt-bindings/clock/imx7ulp-clock.h          | 109 +++++++++++
>  include/linux/clk-provider.h                       |  17 ++
>  14 files changed, 1166 insertions(+), 10 deletions(-)  create mode 10064=
4
> Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
>  create mode 100644 drivers/clk/imx/clk-composite.c  create mode 100644
> drivers/clk/imx/clk-imx7ulp.c  create mode 100644 drivers/clk/imx/clk-
> pfdv2.c  create mode 100644 drivers/clk/imx/clk-pllv4.c  create mode 1006=
44
> include/dt-bindings/clock/imx7ulp-clock.h
>=20
> --
> 2.7.4

