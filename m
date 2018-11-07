Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC257C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A9520817
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bfmAF/E9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A9520817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbeKGWI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:08:27 -0500
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:35217
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726388AbeKGWIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0alN577rb7a/7vF82Br8TrX8xGw0pllUVSRb9wXWd30=;
 b=bfmAF/E9b3dBYlQALuoNOxEpmss92f7unWmo7UNY9hNJ+s1i0NEktKhZpFSPLTK1DXse6zbZIzhknqY36AIejw8YobU1Cd7ziaaNqC9Iv4i9jj042eyFtTbg0Y4GMpxr4noz8qrEuS2JS7XR08B52HQIfLP7KxdM0FxQK+lU33M=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3494.eurprd04.prod.outlook.com (52.133.19.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 12:38:05 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b%4]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 12:38:05 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v12 0/5] Add i.MX8MQ clock driver
Thread-Topic: [PATCH v12 0/5] Add i.MX8MQ clock driver
Thread-Index: AQHUdpa6tQxfFOevC0+oXcF/U1kvxQ==
Date:   Wed, 7 Nov 2018 12:38:05 +0000
Message-ID: <1541594266-16712-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR06CA0009.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::22) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3494;6:uyZvVJPgJnnVDyrsV9vw5/rpcQxW8/BALtM51VXbTAw+O20/nbj5xpKW2UHsqXBzVBfjFBiL7npb3YQwk4nXOq58fqlFKb6KxhT1EUlospaxo73RNeOQ+SwQ0BTr8fpjsS4B7/DLZBLNfKSd7YPSXOrOYiX5MuW+h6RtU8nE361a9GadvdpLqz5FSKOd5acaUymjkNGL12xxWoaqHXhgUme8KRsC4BC5XUiL+BJwwQ62nd5JppmZnYa4TG6f+LjZepkU5xlnUPrfwQWOy9Q4PyW2yf61CUcq/v8q5wOmLBulsODJXZWevxFXu/e7FHpE5JU56YshvWtde9UpvyOLeEicPuYX0Z0deKeWh5paLkuZMBhtE4Zm8i5619TGxtSEJJoiI6BbvhMTl1CQCOcMcnhzi9e+yhujrAiTx4VPMR4San76qM//vqJzgoEkzLLKM6QsJDnFvLjtlDErJ9DmSw==;5:0+7jx4nN1wHBLcHelrH5HzzLjpEQ5/00lE+G0e4MmGjGxq5fL0q9jUt7Nq8Tl51EembvGBoQz19MraSHfl5LqH9xAV4UKkvR6jvMAWBB68qkYBI2l4TP6+STbISUjGNLKZFzjfF+EPw66/AumuPXUEdYgOiXFU690WbTh+eUAgA=;7:jJzEjdQC354790nJ8+jofihEazLdw0bGe1eh3+DIdfuz4TBi5dfBvmeHhOuwM3SPPEq9jUMWpWzZmXIYLxowDUa2MVbx1PYtnZK7zGqRAQZrfpW0O5VuOofnwB7EfRFzTjl8dRPaum6cDgB8PeYbjQ==
x-ms-office365-filtering-correlation-id: 3631fb17-a552-479d-bb43-08d644addd17
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3494;
x-ms-traffictypediagnostic: AM6PR0402MB3494:
x-microsoft-antispam-prvs: <AM6PR0402MB3494651641F5CD0783D9F6BFF6C40@AM6PR0402MB3494.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3494;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3494;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(8936002)(2900100001)(4326008)(6306002)(97736004)(476003)(53936002)(6512007)(2906002)(486006)(256004)(14444005)(44832011)(7416002)(386003)(6486002)(186003)(6436002)(36756003)(2616005)(25786009)(478600001)(6506007)(52116002)(102836004)(7736002)(305945005)(71190400001)(71200400001)(3846002)(99286004)(5660300001)(66066001)(316002)(966005)(6116002)(26005)(6636002)(86362001)(81156014)(81166006)(110136005)(105586002)(106356001)(54906003)(14454004)(68736007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3494;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M0XSErTEolQ+FhhagxpPO4FlBiO06dRo+cngkqIV/5GNFSOUEajVpv8+lBWz/kB2f72H0Yss85ILxP8qsgoPopZSFWr+LAQLM2i0JGa9wJ4SwIDRxAWTQF5zwnitTYvVuO2ivUJHugZKiGO7Tz5h6xeFF4K74yEyeAVwhnXpgkEay9Njo8AU/2B2Ab5NyBJWpi1be/XQ1ApOB7OI7ADa7pK8C8LQ01LAGOrbRwaZoQiuuZT75doYv9YCB4ts9b4Tw8G6SEzF+xrTy6DnifcNTQHXyk7LROBrvMZuYVc3I/aghVWbGnzzYiwethY0UIOsi9olwijY2MIfGm809vJyryv7mvy+qiD07K2jSUbvbSw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3631fb17-a552-479d-bb43-08d644addd17
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 12:38:05.1616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So this is all cleaned up now. The switch from clk to clk_hw registration
is done only for the newly added clock types because changing the older
ones will imply a bigger change. I will spend some time on that, but this
can't be delayed by that since this is needed in order to boot up.

Here is a link to the 11th version:
https://lkml.org/lkml/2018/10/10/292

Changes since v11:
 * changed the authorship of the CCM driver
     since it has changed drastically from the original version.
 * changed the CCM driver to platform driver
 * changed all new clock types to clk_hw based registration
 * fixed the all other comments from Stephen

Abel Vesa (2):
  clk: imx: Add imx composite clock
  clk: imx: Add clock driver for i.MX8MQ CCM

Lucas Stach (3):
  dt-bindings: add binding for i.MX8MQ CCM
  clk: imx: add fractional PLL output clock
  clk: imx: Add SCCG PLL type

 .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 +
 drivers/clk/imx/Makefile                           |   6 +-
 drivers/clk/imx/clk-composite-8m.c                 | 178 +++++++
 drivers/clk/imx/clk-frac-pll.c                     | 221 ++++++++
 drivers/clk/imx/clk-imx8mq.c                       | 589 +++++++++++++++++=
++++
 drivers/clk/imx/clk-sccg-pll.c                     | 256 +++++++++
 drivers/clk/imx/clk.h                              |  64 +++
 include/dt-bindings/clock/imx8mq-clock.h           | 395 ++++++++++++++
 8 files changed, 1728 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.tx=
t
 create mode 100644 drivers/clk/imx/clk-composite-8m.c
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
 create mode 100644 drivers/clk/imx/clk-imx8mq.c
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

--=20
2.7.4

