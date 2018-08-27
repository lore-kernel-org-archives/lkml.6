Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEF4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BF221722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iL3lUEiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BF221722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeH0Han (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 03:30:43 -0400
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:2563
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbeH0Han (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 03:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOFdmKLGoNrwRI7L0YQNoe7dqRy97pTqNULnwRFbVu0=;
 b=iL3lUEiulztDcRlBhADRo5xmcgBolKsnl581KcLAZjdBrNO6IW9ML9aFBwLEdkccoyCmJzGq6BhGHjoW0r2YYbGNIY+ZEVH9GeSctbu26etBBUd85QEM66RUt2qOz4ZKu1j1dmGkBp5s5ywSTQC2foZ8T1WHxUzAmHhqS3uzAuo=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4514.eurprd04.prod.outlook.com (52.135.148.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Mon, 27 Aug 2018 03:45:51 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5d61:a56c:c249:290]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5d61:a56c:c249:290%3]) with mapi id 15.20.1080.015; Mon, 27 Aug 2018
 03:45:51 +0000
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
Thread-Index: AQHUHpzNbEQ50bW8r0K17gNet3HqL6Sgx+QwgDJrIKA=
Date:   Mon, 27 Aug 2018 03:45:51 +0000
Message-ID: <AM0PR04MB421153E1441FBE356E1B859E800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB421169829CFE1A6A32DCC209802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB421169829CFE1A6A32DCC209802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4514;6:D8R3QRWr03hMYh//wijvlicA5HULUrE0tg7hrrchdFfy8l+5Ayjj5ejY+96AL+1s5xvA3xTz+pxxzkSmGRBk41w2W5IMycf057GjpZ75zx/A+x3Jg8O0eOoyHD/XB/5kMUV9uR9WychbNaan2a30nrvcLlNjJX+nAcTUjPgJ6EPEFtCL4u6ad5HLLvb9zujTpuKLXdcHY8YZpFETeVkRi6GyGT+vBeTddly7Vv7lnViZeJWUEzmlEBO8nQHXYLXV4XKMAtSfQjA0zi6oy/cGvs069AAOhIt1e96UEouRH4CrZRQ15Tg5AVsKTluQsxNz//BJbSPqOR0YmICFTYL3S5LOaO/dbiTMQeVjqJKSKIpX9SI5dH0ecLuDiTczmW/QB99lsral8buTAF14MmYzwjJGow6XTgHUXfzawia7YGZ/QGh9YWF00ZuA2jCpH3VHrSpIN8lzirFEaES/jRTjxw==;5:82CjPoHmqe9StMcRYQanIixAiICvsdF2wXVn3h6aYxQN8yVHyVwzpCju+HLqmKbxlmH39bx2kwA8aLjKnAXriLG3lV4R4Wr77ctkTaQBwSQ8CmPGvZKrErsnRoxXy64GUlyU6Slo26Up2uhZa0YaCn/KnhHpTKw2pnMiJEaS44E=;7:WnAyI1Mb+6FMQnXcBSbI41XeREpbwvfySelQqJEocnJGqW/VsIYu/b/H5yLm50XqwnaW2QFtIZuv7r9U44M6AUb47LLD3u8EKSNMIEs0EtQraFKYo0y3FsIs04YpZshpVa7FN7iLRZji5IX56Bi/1pzips3/rpvk8G6R94wU174swSev5Q7hLZ89pe6TAriQ9Fq0nmb7RZ4jKfU4VlIpiMHSdqZLDZgtUdliQ+p/YFf3gcC/0C5D5dj7yhapW7gU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 104bd28c-dec7-4e73-6713-08d60bcf95ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4514;
x-ms-traffictypediagnostic: AM0PR04MB4514:
x-microsoft-antispam-prvs: <AM0PR04MB4514F05F0A8750951C324959800B0@AM0PR04MB4514.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:AM0PR04MB4514;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4514;
x-forefront-prvs: 07778E4001
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(366004)(54534003)(13464003)(189003)(199004)(6506007)(53546011)(8936002)(110136005)(68736007)(54906003)(102836004)(478600001)(569044001)(186003)(2906002)(81166006)(81156014)(53936002)(966005)(6306002)(86362001)(9686003)(14454004)(55016002)(2201001)(7736002)(6116002)(4326008)(446003)(11346002)(25786009)(3846002)(7696005)(99286004)(2501003)(316002)(8676002)(5250100002)(2900100001)(26005)(6246003)(256004)(14444005)(105586002)(476003)(305945005)(97736004)(76176011)(6436002)(486006)(74316002)(66066001)(106356001)(5660300001)(229853002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4514;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: S0AB0GohHkt4Vkvch+5+WvzrcxoGr/37rL6FqyKJE5rEl8KRaXmcA7sbhv8lf0x3vR4MKRMn3FLE/Y14nqcKIB504LvqmP3OLzMNm58YhfM6woopCACbApY/Wgc1vxqqbzOcSXjel581lYR7wD+CH5xnm2pUjZEVHJfpscwqa7S0NRJ5JMFWzF5cPwDcVfGuuYeBBFK+vrvF3tNMcJP6KoVX/lUw8m3DzVeGofP0CsKxTFJpaDmrGskxMmKRYdlKfI45+ZoxchjNW0JkziUI0gWM+xPpt+wr53PROXdRUqCTeDVRQWWTQQ+2uuHkoMNlZOCVroSPECEwtZ/Vv1MWgPH5SjV5rIHG46uzB3QGF5M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104bd28c-dec7-4e73-6713-08d60bcf95ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2018 03:45:51.7721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kindly ping again...  This is really pending too long...

Stephen & Shawn,
Any suggestion on how to proceed this patch set?

Regards
Dong Aisheng

> -----Original Message-----
> From: A.s. Dong
> Sent: Thursday, July 26, 2018 9:51 AM
> To: linux-clk@vger.kernel.org; sboyd@kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> mturquette@baylibre.com; shawnguo@kernel.org; Anson Huang
> <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
>=20
> Hi Stephen,
>=20
> Do you have a chance to look at it?
> This patch series has been pending for quite a long time without much
> comments.
>=20
> Regards
> Dong Aisheng
>=20
> > -----Original Message-----
> > From: A.s. Dong
> > Sent: Wednesday, July 18, 2018 9:37 PM
> > To: linux-clk@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org;
> > sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org;
> Anson
> > Huang <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-
> > linux-imx <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> > Subject: [PATCH V4 0/9] clk: add imx7ulp clk support
> >
> > This is a rebased version of below patch series against latest clk tree=
.
> > [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
> > https://lkml.org/lkml/2018/3/16/310
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
> >  * rebased to latest kernel
> >  * make scg and pcc separate nodes according to Rob's suggestion
> >
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
> +++++++++++++++
> >  drivers/clk/clk-fractional-divider.c               |  10 +
> >  drivers/clk/imx/Makefile                           |   6 +-
> >  drivers/clk/imx/clk-busy.c                         |   2 +-
> >  drivers/clk/imx/clk-composite.c                    |  85 +++++++++
> >  drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
> >  drivers/clk/imx/clk-imx7ulp.c                      | 209
> +++++++++++++++++++++
> >  drivers/clk/imx/clk-pfdv2.c                        | 201
> ++++++++++++++++++++
> >  drivers/clk/imx/clk-pllv4.c                        | 182
> ++++++++++++++++++
> >  drivers/clk/imx/clk.c                              |  22 +++
> >  drivers/clk/imx/clk.h                              |  92 ++++++++-
> >  include/dt-bindings/clock/imx7ulp-clock.h          | 109 +++++++++++
> >  include/linux/clk-provider.h                       |  17 ++
> >  14 files changed, 1166 insertions(+), 10 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> >  create mode 100644 drivers/clk/imx/clk-composite.c  create mode
> > 100644 drivers/clk/imx/clk-imx7ulp.c  create mode 100644
> > drivers/clk/imx/clk- pfdv2.c  create mode 100644
> > drivers/clk/imx/clk-pllv4.c  create mode 100644
> > include/dt-bindings/clock/imx7ulp-clock.h
> >
> > --
> > 2.7.4

