Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82077C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C292089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="duUX0i1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C292089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeJIPxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:53:17 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:11264
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbeJIPxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dczev483ecw7mZvWPuU96ebP7RGLuBez0ftzQzYEHA=;
 b=duUX0i1maHI/wvrkIl0vIwjo8Hn9fIWhmNOqLkhNFOfCl5EK3FwSDiiHe8bA6Eo5LFd0aJNGkR4OaKgSC5TIo3KxBQjLMKPS+vt6Wy+4nT3bD/ZnwxsPnhE7oeJ8t19j1hsqZEnh2WWINcwjIeNUQ1nIz3xLfWri2wwHEqED6rs=
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) by
 VI1PR04MB5343.eurprd04.prod.outlook.com (52.134.123.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Tue, 9 Oct 2018 08:37:24 +0000
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::f014:635a:bee7:76b3]) by VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::f014:635a:bee7:76b3%3]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 08:37:24 +0000
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
Subject: [PATCH v10 0/5] Add i.MX8MQ clock driver
Thread-Topic: [PATCH v10 0/5] Add i.MX8MQ clock driver
Thread-Index: AQHUX6tNeuStJ7AcK0aW/aqhOyJmNQ==
Date:   Tue, 9 Oct 2018 08:37:24 +0000
Message-ID: <1539074230-27277-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0058.eurprd02.prod.outlook.com
 (2603:10a6:802:14::29) To VI1PR04MB1613.eurprd04.prod.outlook.com
 (2a01:111:e400:596b::19)
x-originating-ip: [95.76.156.53]
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5343;6:oC00U9z2vuiXwDmFYr5YppbhmH51TPPfxuqNY8/TKWLp3aLUWrzSb3bZFjdsWEUbBWHT+NEfPex15LZUDuGFYPSxG6fIqrLomhlhu1gb0QH9M48hSxEq/P9IG4jw5IfAWoCtpj3+hEwAL8GgqkhwPVaJ/7WGra9IgcR3pVdU1ABICIXK19GQBCibZLiKr/o63j/TfkZboY6bV3se/YsGCZaH7/C8owegLk6Hs4//Q486fT4ZjLxjPhc9Jyh24AzNV7Re5wVYDjFpc1b3cQeS37vQma1jWSWh9hZnCZwDcEm55bq/TP1Mzl+YRQaUo4mHY9sSiDL5ykbaATC7BbAM89yT4MGQXK/B8SFEkFJIcaj6BRB9yP8tOMWe1e5kIIAE/blAh/PwO7YhLR3UxMtioE5CefQzpcb0mnZvJEbYaAJbTUeMK+TKxSHI0geeRFbZXSmG1EqsBip6wZUKkSdKWA==;5:cTTFgrJFUna3Oub4vljeg9rUOboMC4FK4omOjyYf8uBocUVhqrrr1GNRFBmQ8wEGwuBNq96gEFoPJlUZbq4FgIPNdvBsZvfPGJMH7OezY5EmeCzzxm+NdfKhtb423F0TjoqWPNDlXtSFi1HdxqQjUp+yrFW3HLYXrZjS+XrkOOo=;7:uUsgkDnfIvsFxTXvdajmLqMPxa60e+r51/4OKas+niEafeWNGBM5N8wJWAzZt1TuEFhM/+K8Ffv1y69r6c6arbb8IMfgv8Ep9MwKgrJbPvBtO2RCbCcz4QOQk9N4oO3irfiN/jOQnHEY5cr2Gm/41HKpspIasXXuyjtDwK1zC6FIyc01SqhfFAnCWczPjlK0jUKxSMDMJRlbXkC/8nnjBsc0LD4oQnJ1gLt/ASxVwALTcerQ802lsCkXlOSiydaN
x-ms-office365-filtering-correlation-id: 6808264c-c445-4757-61e7-08d62dc26f35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5343;
x-ms-traffictypediagnostic: VI1PR04MB5343:
x-microsoft-antispam-prvs: <VI1PR04MB53432F4FEA252BED335CB6CCF6E70@VI1PR04MB5343.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:VI1PR04MB5343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5343;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(476003)(486006)(44832011)(6512007)(6636002)(36756003)(5660300001)(2906002)(5250100002)(68736007)(2616005)(6116002)(3846002)(106356001)(7736002)(305945005)(105586002)(81166006)(81156014)(8676002)(71190400001)(52116002)(110136005)(71200400001)(25786009)(14454004)(478600001)(256004)(86362001)(6486002)(2900100001)(14444005)(4326008)(186003)(6436002)(54906003)(6506007)(8936002)(386003)(66066001)(7416002)(102836004)(6346003)(53936002)(97736004)(99286004)(316002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5343;H:VI1PR04MB1613.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-microsoft-antispam-message-info: v54h5AHuh0as7bTW4UKtWpDkIPfaWB9oqX+ps3WWf3C26N9wUBWI+5COLpfaAZsVF5w5uIM7dvNCawcpolNhEruUG52q/9NzCQglzfLjgEYCA9v9Stfo4rIRHcG8+TXu7ojrWU4szMpC196DaygdquRgcUH8015/Q99DxJnBUBFksi/fiKgHz2hQ90ecMUodvdgQPIKcjTlGxlgSAQ3QagPWWaJif+1pwxJzLnuvuv8EehmxQ8YgYZQYyXYlJlVQePwpausQYpwJ0WGuVTbf3+ZQuYETwM2f2LKMRhdfjThloDjTQMYOlN2H3sIoAmg9/IUjB2COWwt20WKRDom0AqasW33FA05mstFQ3DE3wGw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6808264c-c445-4757-61e7-08d62dc26f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 08:37:24.1085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v9:
 * Replaced DIV_ROUND_UP_ULL with DIV_ROUND_UP
 * Renamed the entire composite to composite-8m

Abel Vesa (1):
  clk: imx: add imx composite clock

Lucas Stach (4):
  dt-bindings: add binding for i.MX8MQ CCM
  clk: imx: add fractional PLL output clock
  clk: imx: add SCCG PLL type
  clk: imx: add clock driver for i.MX8MQ CCM

 .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 +
 drivers/clk/imx/Makefile                           |   6 +-
 drivers/clk/imx/clk-composite-8m.c                 | 181 +++++++
 drivers/clk/imx/clk-frac-pll.c                     | 215 ++++++++
 drivers/clk/imx/clk-imx8mq.c                       | 602 +++++++++++++++++=
++++
 drivers/clk/imx/clk-sccg-pll.c                     | 237 ++++++++
 drivers/clk/imx/clk.h                              |  64 +++
 include/dt-bindings/clock/imx8mq-clock.h           | 395 ++++++++++++++
 8 files changed, 1719 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.tx=
t
 create mode 100644 drivers/clk/imx/clk-composite-8m.c
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
 create mode 100644 drivers/clk/imx/clk-imx8mq.c
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

--=20
2.7.4

