Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25680C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AC92081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bW8IYoPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AC92081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeLAWE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:04:28 -0500
Received: from mail-eopbgr30062.outbound.protection.outlook.com ([40.107.3.62]:53856
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726416AbeLAWE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhGepzEr5W0YkU5Ih5k1tb3XICCxH+dbv015txoDE9s=;
 b=bW8IYoPq1Yb3CYafW3E86fCk613YIJWfuCPc7WRlj7QkLH5cHp/V12QH/+EAXM2HBqvlRTHuT5byc8H61i1E+4/KY1ERNJ593jynADD4ePND7QbHaEj2Ihc/62b1kGvbA97un66hGO5zVWkHoI+ZfVqbT491mSa0ip/fm8KoE/Y=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3622.eurprd04.prod.outlook.com (52.133.20.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.20; Sat, 1 Dec 2018 10:52:09 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%3]) with mapi id 15.20.1339.036; Sat, 1 Dec 2018
 10:52:09 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v15 0/5] Add i.MX8MQ clock driver
Thread-Topic: [PATCH v15 0/5] Add i.MX8MQ clock driver
Thread-Index: AQHUiWPogHN0ujLDD0W0yi6RhMS+ow==
Date:   Sat, 1 Dec 2018 10:52:09 +0000
Message-ID: <1543661502-18573-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0402CA0017.eurprd04.prod.outlook.com
 (2603:10a6:209::30) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3622;6:DUNCsAPeDs86IeGRIxKXPzA2nIUgtLR8J7SkKgYGMyZ8+Qo5bu1dty3TzWlKwu/q/xpXC6pr2kENysM2sEhF/vY92N09UygTl1iUTPwGQg32lhTLXpcHnQzOE8JRafNUDEgCi3FWovg9+8hE98jOq7s8prN0hlzobXq4l6S6z3ljntJF/cpzlNdx1XHH4pfvfpzJ9Hz3f2XTjbha9GH7csi7MonkY9g9X88G9x4BKf+7FFBLUFqVhP8h/+rnyKi0Z39qX917BjGQ8wi2wPoWmbFRjuGOm2BNsi9GXwVnyiky80ICMNrZhqdSxKu57zk1zJ9VH4pERoRBQl10K400QXPmUj4RT/GSv2Tt43qtH3BDK9c9LzjCYyrhhfnznKrvf9Zigky2aYShBTSkz78eavLMy8jnmXgGbiMsFzmJDEYowdvPH/dI9gx6HeRy6GzMHVResHX1Dy7i+5R/1l/+gQ==;5:/qJIzbhDiIVZgIbAKHaZYKo/K5f9E3zigWmgdfEqIkl/61hC1cAZki6KEwBCEj3ohumukX2MvGWV8VIxN1B+jWtBlNNI9+Uxj7VuJ/aArN5JYphuUz3/s3RpJ9hvz+YpCreiMxjXczkR5BirxK3FnCEMKj84/gVR4u+z3d3abLc=;7:6LmjMobH8g6wcQjDwcdV7Mm2PkAxqTClcvxqMDQ+IUqkYdXB9r5S2oMiBT0tWazizyq/25YapP3xXTzilwoQkrvtV0CatlcB9y/3xgKCmbZv/ZzZBPr8YxV0JhE/+svOCE7WmORsoNypOvjY0ln7qA==
x-ms-office365-filtering-correlation-id: b5bd2c18-908b-4874-203c-08d6577b0a63
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3622;
x-ms-traffictypediagnostic: AM6PR0402MB3622:
x-microsoft-antispam-prvs: <AM6PR0402MB36224D356E1B52974FBA9CA7F6AC0@AM6PR0402MB3622.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231454)(999002)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3622;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3622;
x-forefront-prvs: 087396016C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(305945005)(53936002)(316002)(52116002)(99286004)(54906003)(3846002)(6116002)(86362001)(6512007)(106356001)(6306002)(110136005)(966005)(81156014)(81166006)(8676002)(2906002)(14454004)(476003)(2616005)(105586002)(256004)(8936002)(478600001)(66066001)(71200400001)(44832011)(486006)(97736004)(6486002)(6436002)(14444005)(26005)(186003)(102836004)(7416002)(5660300001)(71190400001)(4326008)(36756003)(68736007)(7736002)(386003)(6506007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3622;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HJ0yQyMWHLVmah5ApABemGTV2gtPqY/4/yziwpJechAVYq+OpE33XqrNwdtL3l5iFY4EmuIg1Jq81Qy0ZT1aNbY0U+nBwhVL+j+2XWILTMwrdmAZ7B30vWI33NgEIUmOMiQKRGSgpASKF0KoUjQSiwE3nEQ9xVkaOlouF0clqLT3bA5xhbR9PoJ67pt8+656ZKrjnwSQdF0FeG8PpGjgDoqEUSkaa+72tdvXMs+y3Redh+9/LcJj3lygCg+ma9hRPXQdAtcEuVM/gAr/mgsL2KdyEpnQMI/DrPrL0DZYDrpzNfcNczToRWytKmAj5vzwM+PcoKhTFVDItaXeV4BBzsYInQzXV5hW+ufLn750CkQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5bd2c18-908b-4874-203c-08d6577b0a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2018 10:52:09.3085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, there was a problem with some divisions by 64-bit values
in the Fractional PLL which led to a link failuire on arm32.
That has been fixed now without any kind of functionality changes.

Though the v14 has made it to clk-next, due to the arm32 build failure,
this patch series had to be dropped until the failure gets fixed.

Stephen, please take this in one more time and sorry for all the trouble
caused by this series. Thanks for all the support.

Here is a link to the 14th version:

https://lkml.org/lkml/2018/11/29/767

Changes since v14:
 * fixed all the divisions by 64-bit by replacing with do_divs in clk-frac-=
pll

Abel Vesa (2):
  clk: imx: Add imx composite clock
  clk: imx: Add clock driver for i.MX8MQ CCM

Lucas Stach (3):
  dt-bindings: Add binding for i.MX8MQ CCM
  clk: imx: Add fractional PLL output clock
  clk: imx: Add SCCG PLL type

 .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 +
 drivers/clk/imx/Makefile                           |   6 +-
 drivers/clk/imx/clk-composite-8m.c                 | 178 +++++++
 drivers/clk/imx/clk-frac-pll.c                     | 232 ++++++++
 drivers/clk/imx/clk-imx8mq.c                       | 589 +++++++++++++++++=
++++
 drivers/clk/imx/clk-sccg-pll.c                     | 256 +++++++++
 drivers/clk/imx/clk.h                              |  64 +++
 include/dt-bindings/clock/imx8mq-clock.h           | 395 ++++++++++++++
 8 files changed, 1739 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.tx=
t
 create mode 100644 drivers/clk/imx/clk-composite-8m.c
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
 create mode 100644 drivers/clk/imx/clk-imx8mq.c
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

--=20
2.7.4

