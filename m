Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F00C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A68520868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IzKb82lX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A68520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeK2Udq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:33:46 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:2224
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726565AbeK2Udq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y91WBRarPZ5lWIZo7sRzb3vQQPZgjIqHF5yPYfFNGA0=;
 b=IzKb82lX2iNf6LA1LRUO55l5ZohWJLw7vqmuUXg/bBzV3VdP/b1cTYsh7cSqxYjCrorWxWu4Ax086zt2GBPShL5LjS28votnkEe4m2OrOKzqgbhzBWCoOMktGdP0Go8k9UAAHs9l5cF5lHBY+EnLKgxfkmQG86vSaUdbr8vxBMo=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3560.eurprd04.prod.outlook.com (52.133.19.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Thu, 29 Nov 2018 09:28:58 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%3]) with mapi id 15.20.1339.032; Thu, 29 Nov 2018
 09:28:58 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v14 0/5] Add i.MX8MQ clock driver
Thread-Topic: [PATCH v14 0/5] Add i.MX8MQ clock driver
Thread-Index: AQHUh8XkjJZ90goyKEOyM2phufHHyg==
Date:   Thu, 29 Nov 2018 09:28:32 +0000
Message-ID: <1543483640-4585-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR06CA0032.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::45) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3560;6:DHNf4i0MZFXWTGjD/Ss78TzNop/ayJS460VVEbHWSLcRJxUJUENVaFLZNxw9SsEDafKbIJT9S+UZ2M6/W4HhnF/SVIi7lHoZGiVRRpRfropmhrMPovq4dIBMMc2rmZBN74hVmkJGhB84xDD4ZyVPK+dSftXSf/s8NwBxDL8L+6IEPvYS5O+JULdlIkVMBr8kjFA4teTE4Fib3oyetvgbWpJ1M1ef5ZUdHfym+kLP0DEqIX59tuPA6AjjXhDB4GFt09WTBUbXvsHje7Dv112W0uIwItAkkE8pNO9cn1m5PCb1uhzK+RuiFN8chrBI77yKTzS9/D5WfmejM0M8J22NuVQbr8QK3tsiGb/7GOaP61NVOU/GKvliwn+mb8cfL94fM+wsV0z1HmIU62SFNYdmD+vGgeC4R6QMqxATAoLfmwX03P9FNtMkL5BDUqN3XjtPnx+3gMJMwFYg8/wbIOzjuw==;5:eBhi8YQjBw+XhgwQqrU0zxuxrPWNa6iWTfcQIq7tmdeySCZsJLPQNXuDsZWvUPgWMRPWDxsriYVjWxnZevSQguCT/9jCjHeHNjRCxLZ1ci9VvK4ARvxOHMgKqeRuYZQI24q2K9MNOajXrCPiIj0/LfKo9V8DApTB/D3EFpc89E8=;7:uEgO70zZt+mkSdHb9/EAH8ulxvBgDY73GzdQ3dA8x3dX8CI7/gvyuTwn3+2sq0+zHQoZDoHdFJ7rB72ljMWocN4GXaQLpGwSIXZyj5vN5WxAwxztJpmC7g7WLI0NlGBcVB8U04veYKbSBaX413OXNg==
x-ms-office365-filtering-correlation-id: c8414fbf-04ec-4507-a0af-08d655dd0749
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3560;
x-ms-traffictypediagnostic: AM6PR0402MB3560:
x-microsoft-antispam-prvs: <AM6PR0402MB3560D4B51C1F620A5CE377CDF6D20@AM6PR0402MB3560.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231453)(999002)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3560;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3560;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(4326008)(105586002)(6486002)(26005)(478600001)(966005)(97736004)(106356001)(3846002)(14454004)(44832011)(2906002)(2616005)(5660300001)(71200400001)(7416002)(71190400001)(316002)(66066001)(486006)(6506007)(81156014)(305945005)(7736002)(6436002)(25786009)(36756003)(81166006)(14444005)(6116002)(8936002)(110136005)(256004)(8676002)(476003)(6666004)(102836004)(54906003)(6512007)(6306002)(68736007)(99286004)(52116002)(186003)(386003)(86362001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3560;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dq6qaRjKdV+Pi0uzyersP73ZmmJ6+mEnalIr4ph1yxV0YPYLvAFj7yiOOEvoURyWKFfFOfYCaaW6jJ+cUqDnHZVTPRNPf4lL9qDvZ5/38Vr1tv6+IBNxrxmVkkWVhX2q5sbODecg7cp6jsFB1/prFiwvslikP1uxnmakCm8ZwzmDX9dgYi3ltb/2R1KWx4Ct5QAB1IyHU8p3EsPS6I3XuLcjW09tnwlhnI+ZxU98MlRevL2iI4DNLe2vcJyvHmAxrU6ke3kp6zFWvbNxY9SA+V/9he1Rmib6JpwNiO05CUqsVN5CfZ4Q+baFzlOvew3udAkMCRdaze7O4fE+FH6fl8kl4j22NgUC5vV5yizhz6I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8414fbf-04ec-4507-a0af-08d655dd0749
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 09:28:32.3215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3560
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a link to the 13th version:
https://lkml.org/lkml/2018/11/13/1020

Changes since v13:
 * included changes suggested by Stephen Boyd

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
 drivers/clk/imx/clk-frac-pll.c                     | 223 ++++++++
 drivers/clk/imx/clk-imx8mq.c                       | 589 +++++++++++++++++=
++++
 drivers/clk/imx/clk-sccg-pll.c                     | 256 +++++++++
 drivers/clk/imx/clk.h                              |  64 +++
 include/dt-bindings/clock/imx8mq-clock.h           | 395 ++++++++++++++
 8 files changed, 1730 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.tx=
t
 create mode 100644 drivers/clk/imx/clk-composite-8m.c
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
 create mode 100644 drivers/clk/imx/clk-imx8mq.c
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

--=20
2.7.4

