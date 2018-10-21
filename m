Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0579BECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9688520869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="t4sj9tGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9688520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeJUV3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 17:29:31 -0400
Received: from mail-he1eur01on0047.outbound.protection.outlook.com ([104.47.0.47]:42784
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726982AbeJUV3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 17:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G53vIzWOFNjPMyIC8+G3p4O83GmTd8nPjEntWpFV+Mk=;
 b=t4sj9tGgCs1N9IICKbUSL8ww4UkSry/VA/gAWNMlAHFFsTvivlSUpkE/aDgoxU2ZjfkpTsvzxLLC+SHFClV2JSCDx9OPslRY6YKQYCwxtUbbgT5C/hiMACyHsgCk8QzHtNIUxFdmwRhnHiL+LaFcE+G1JxQV16I3cyXDhF/nh9U=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4580.eurprd04.prod.outlook.com (52.135.149.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Sun, 21 Oct 2018 13:15:07 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1250.028; Sun, 21 Oct 2018
 13:15:07 +0000
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
Thread-Index: AQHUaT95oCO6Jr50e0qyeeRGaZQa8qUprLpg
Date:   Sun, 21 Oct 2018 13:15:07 +0000
Message-ID: <AM0PR04MB4211576EF2FE906A6B0C3F1680FB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4580;6:lmoqFo//9hMCaHgSd0Zs3/Nth6XaS6aRlZr7ax21XodpLMUwK3j11UbiR6b4HD7peHXn1E1He4OET2B85GI7tnYEwwGMPwNPHluGrZjWlXYLQ5zQwVqg9TB3LrKdzodxfu47ERN5RyKuNq9sHnzAgZKG0pJJ2aniUj0hucGnYabom/QgMKzNU+EkfAwmCpYzT1/siol/CJAxt8ZJJFCeKCNLBuc4YQGkYVsivdBZ2zQAPkEr47hW7bOlRAMKYi/l1onRuZ4E+27k9E8InyfDQqJAMLAcNqCGlUSaQkxSYHWLRg7kNt5KVBOhHmXsCkhtI78/FE0kKO1HA77DZoRRgEAVO8ATWqDSWenyszAmcixMOSul2MqWFj5BGEvshsDV+fRkuI6n2yQAlYm9LGxT62NHEEYw3YlC7lAXUiypLebwFMV0hbVXLr1z86kTDJXbggKs5qzt8HQGs90CiW06Xg==;5:N2oeKHZI+deuKKleZhdRIbKG7veTzQthYuhfeUMAdqvhwcOiaHNxqjXRdhGCKmlBzV9tQBl5n5WVE04zSE2iR08zvkVdhHTvbwSkXdCawK9njak9vFu2WQ1FhV1aJxJb+g39hIJFonngCkgCCawJqulRhkthFD94TX5qmqFUovQ=;7:s9eGE7tmysmrh9eo+0WxIiKnklBl4MyTSTShIHsIgPvwJLZW5Aclcn0JbJ/g2vmWgqMSyRWBMDA+yxk4HhV+tMbiKEL9iGnbh0hB3BYlCI8ajXcIQIvr2oop9PczbavriKsTrp9gPmsjeS6vPui2lTi/YBE1fsjfPdqBjOQZnjb+nmGaXoVu0O6T/otV1GsiYYyfQ9wb413e4aDKUfrP/bChXOqBBR7GQxqNIAQsxCCHqlTtbE0vptJO4BiBf238
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: aaca81a5-15ce-42c6-5fa1-08d6375738ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4580;
x-ms-traffictypediagnostic: AM0PR04MB4580:
x-microsoft-antispam-prvs: <AM0PR04MB4580E9C8D878F035F9DCFAFF80FB0@AM0PR04MB4580.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4580;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4580;
x-forefront-prvs: 083289FD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39850400004)(136003)(54534003)(13464003)(199004)(189003)(476003)(11346002)(446003)(66066001)(54906003)(316002)(26005)(74316002)(7696005)(99286004)(486006)(186003)(7736002)(53546011)(6506007)(305945005)(102836004)(105586002)(76176011)(86362001)(106356001)(256004)(14444005)(1730700003)(81156014)(81166006)(217873002)(8936002)(8676002)(6916009)(5250100002)(25786009)(2900100001)(2501003)(68736007)(71190400001)(2906002)(5660300001)(14454004)(3846002)(4326008)(6116002)(6306002)(33656002)(6246003)(9686003)(53936002)(2351001)(966005)(71200400001)(478600001)(229853002)(5640700003)(55016002)(97736004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4580;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OOwNFhZvDhT49IMJBC322cTuAIrnMED5UBoKcRVhZulFl0ev/lW5rsgR7onq2PYK7bp8XoQpjQgs8AVwmIEIzumUAYSXiAUBU6WHf1iOCMTLEbCcQQB0pUTkP5P/wqD6zrUNQ/FNh5OYlJg1YOoy0jL/Jut08loEjsPj9tNCHU9WDXIF+5yW+Rgn6HdgJBIJPvGxtVwOdAur59T2XfDqVV2wy771mIlmhFrMZaulIeTifP40on/jmNEkxs31MCZODimsvbqhOoSOe/VlQJCd0c+Op2+CpoIuXXulpIFwGGnyjCOHz7Uwxhju2EkCm8v1lkJ9WW1cUljHexaMtv2m+ZPDKDDTapRUnq0w5wH8BtA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaca81a5-15ce-42c6-5fa1-08d6375738ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2018 13:15:07.1160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

In case you might miss to queue this series into your review list, so I res=
end this series again.
This series actually has been pending for a couple of months without commen=
ts.
Hopefully you could help find some time to handle it when you're free.

Thanks

Regards
Dong Aisheng

> -----Original Message-----
> From: A.s. Dong
> Sent: Sunday, October 21, 2018 9:11 PM
> To: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org; Anson
> Huang <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-linux-imx
> <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> Subject: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
>=20
> This is a rebased version of below patch series against latest clk tree.
> [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
> https://lkml.org/lkml/2018/3/16/310
>=20
> It only updates the license to SPDX format as well as a minor fix of pllv=
4.
>=20
> This patch series intends to add imx7ulp clk support.
>=20
> i.MX7ULP Clock functions are under joint control of the System Clock
> Generation (SCG) modules, Peripheral Clock Control (PCC) modules, and Cor=
e
> Mode Controller (CMC)1 blocks
>=20
> The clocking scheme provides clear separation between M4 domain and A7
> domain. Except for a few clock sources shared between two domains, such a=
s
> the System Oscillator clock, the Slow IRC (SIRC), and and the Fast IRC cl=
ock
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
>  * update after changing scg and pcc into separete nodes according to
>    Rob's suggestion
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
>  drivers/clk/clk-divider.c                          | 152
> +++++++++++++++
>  drivers/clk/clk-fractional-divider.c               |  10 +
>  drivers/clk/imx/Makefile                           |   6 +-
>  drivers/clk/imx/clk-busy.c                         |   2 +-
>  drivers/clk/imx/clk-composite.c                    |  85 +++++++++
>  drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
>  drivers/clk/imx/clk-imx7ulp.c                      | 209
> +++++++++++++++++++++
>  drivers/clk/imx/clk-pfdv2.c                        | 201
> ++++++++++++++++++++
>  drivers/clk/imx/clk-pllv4.c                        | 182
> ++++++++++++++++++
>  drivers/clk/imx/clk.c                              |  22 +++
>  drivers/clk/imx/clk.h                              |  92 ++++++++-
>  include/dt-bindings/clock/imx7ulp-clock.h          | 109 +++++++++++
>  include/linux/clk-provider.h                       |  17 ++
>  14 files changed, 1166 insertions(+), 10 deletions(-)  create mode 10064=
4
> Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
>  create mode 100644 drivers/clk/imx/clk-composite.c  create mode 100644
> drivers/clk/imx/clk-imx7ulp.c  create mode 100644
> drivers/clk/imx/clk-pfdv2.c  create mode 100644 drivers/clk/imx/clk-pllv4=
.c
> create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h
>=20
> --
> 2.7.4

