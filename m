Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C17BC43610
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B59320817
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vG7QAuhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B59320817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeKKATb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:19:31 -0500
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:32256
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbeKKATb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+p0iybDrIX/MlCAcr0zLkjY3q/QfBkVV/26BY3QZLA=;
 b=vG7QAuhzzVunuBJm3Bmn7BufwQcup05Yb5eMt0Aa7/ZykDzkCuk6HvtcSctgSyNRHvIfvZv0uNNiGjSouOq2lbQRC3SfmK5uniEER44tLbKOKwNw+qzxXB6ChtKml+boLNOtZINO8eKq9El/fhxRqcBaw9evzIUn/RuR2JYdjTE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5011.eurprd04.prod.outlook.com (20.177.40.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Sat, 10 Nov 2018 14:34:13 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.039; Sat, 10 Nov 2018
 14:34:13 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: [PATCH V5 0/9] clk: add imx7ulp clk support
Thread-Topic: [PATCH V5 0/9] clk: add imx7ulp clk support
Thread-Index: AQHUeQJzlY28dhnvHU2XqCzewNq+zg==
Date:   Sat, 10 Nov 2018 14:34:13 +0000
Message-ID: <1541860165-401-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::20) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5011;6:HY4aj/NizipDE/8k8Jbxs2FpI99fteKXQg6t5pOkbqV4gI4eekFaUvD1SfNX6WVdJqlDgHn5/1qi4J/bvgK27w11JQesCr84267E1GrxmKxS2Bv3ACXYltRIvxdLqQDrXDOh4IBX4TxjPRajiPGUP+G6dmosyG+DuOO2TbSaFTDEV5kPfQhMitdV44JGgchrYYRBpXbO24WGMzquqWp2lyyYqlAghuirXJHkRG+X5intvvNTUMPe6wxGmH5zYqBjwK0qu9KDuAdQCsZXc4EeMow9YWNO824eihXQVda8RgoXdoTHlOjFgjHPnA6jaF5KTFS9xfHX9y8YYpAcPOzgrdTWI7h/0XNfs9SUcN99UBuSOiPSzYX38lluWO0x49mmUpvBjLEEyz2f2gxggypxqYuHPT9tG3KjKN2elkkwhT6NS5L1Bw07DyCCdzIKciUTBB2DL2aXBdAXw9+LLf9WPQ==;5:nnvLZ6Rrp8227UsEkwkNgJVIC3bPjEFlet9JbQ/e4Zq0EMIzShZTWgMia545vaLWer/X2aun24T04/SXYuR5T8t0RbtFJRYKen9mAmCSD0nD0Cr1aEZlZynaCYnu5eSrt+ypz3MYvE+02AJl+3aIzIEXi5EkNWc4SSLt7C3WaxM=;7:SaZlLAOqFJjXE77E/tdUqCQGBg8skUCsxM4sOtUCbaBzxV3/kwMcV7QI9r73meNiw2rMG1Exgq5CNO6cp3s4qAX7Z8Z6uJQtCvKAlg6YW2+o4GmaV+xge+7Z1pF0CywnGE4+KiiJ0r3vVW5jGP2hmg==
x-ms-office365-filtering-correlation-id: e10f5984-d0e2-4280-f4c0-08d6471995c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5011;
x-ms-traffictypediagnostic: AM0PR04MB5011:
x-microsoft-antispam-prvs: <AM0PR04MB50113F452D26267E24C3961C80C70@AM0PR04MB5011.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5011;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5011;
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39850400004)(136003)(366004)(54534003)(189003)(199004)(50226002)(53936002)(81156014)(7736002)(476003)(6916009)(36756003)(6512007)(305945005)(14454004)(8676002)(2616005)(486006)(86362001)(478600001)(81166006)(26005)(8936002)(186003)(66066001)(14444005)(97736004)(256004)(2501003)(54906003)(68736007)(2900100001)(2906002)(2351001)(71190400001)(71200400001)(316002)(3846002)(6116002)(6506007)(102836004)(5640700003)(106356001)(105586002)(386003)(99286004)(5660300001)(25786009)(4326008)(52116002)(6486002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5011;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dpwHeXHOs2RVLSZ7DQw1Fk1gLWCcoJ8ryeTWQ7bA9Bb4x3yvMeIz9kNfxCcU1swmKeKbhZZrJsZho0qViw2rDYXTn30dvBvnTRLCaf4T5Krah5g1LZ+Cnrs3r53hEOUwsOW22AOmWcKdEC+IdKNEnfPH79jCyl765d7DjH4qxRkXxfjoILQW3zLlvJdVpB2p/6keBA/XZMMPF+0cl0A5EHf8+HIVbjhuXTiONdQaD8ja5DJdd3JqAfzTFM9ZFh1T4unT6xmYJuFYkbWo0PNzfPD6f3803dlkqprbboXLsOr940djWRYAWhmvudMB4f6UdvWcYDoaOSI33EUMEiK+h+UwTYPjURZpfL0nFF4689E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10f5984-d0e2-4280-f4c0-08d6471995c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2018 14:34:13.7532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series intends to add imx7ulp clk support.

i.MX7ULP Clock functions are under joint control of the System
Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
modules, and Core Mode Controller (CMC)1 blocks

The clocking scheme provides clear separation between M4 domain
and A7 domain. Except for a few clock sources shared between two
domains, such as the System Oscillator clock, the Slow IRC (SIRC),
and and the Fast IRC clock (FIRCLK), clock sources and clock
management are separated and contained within each domain.

M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.

Note: this series only adds A7 clock domain support as M4 clock
domain will be handled by M4 seperately.

Change Log:
v4->v5:
 * rename to clk-composite-7ulp.c as we have another
   clk-composite-8m.c, function name also changed accordingly
 * binding doc updated with adding input clocks for PCC module
v3->v4:
 * update after changing scg and pcc into separete nodes according to
   Rob's suggestion
v2->v3:
 * Patch 1 changed on: 1) split normal and gate ops 2) fix the possible rac=
y
   Others no changes.

v1->v2:
 * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
 * use clk_hw apis to register clocks
 * use of_clk_add_hw_provider
 * split the clocks register process into two parts: early part for possibl=
e
   timers clocks registered by CLK_OF_DECLARE_DRIVER and the later part for
   the left normal peripheral clocks registered by a platform driver.

Dong Aisheng (9):
  clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
  clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
  clk: imx: add pllv4 support
  clk: imx: add pfdv2 support
  clk: imx: add imx7ulp composite clk support
  dt-bindings: clock: add imx7ulp clock binding doc
  clk: imx: make mux parent strings const
  clk: imx: implement new clk_hw based APIs
  clk: imx: add imx7ulp clk driver

 .../devicetree/bindings/clock/imx7ulp-clock.txt    | 104 ++++++++++
 drivers/clk/clk-divider.c                          | 152 +++++++++++++++
 drivers/clk/clk-fractional-divider.c               |  10 +
 drivers/clk/imx/Makefile                           |   6 +-
 drivers/clk/imx/clk-busy.c                         |   2 +-
 drivers/clk/imx/clk-composite-7ulp.c               |  85 +++++++++
 drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
 drivers/clk/imx/clk-imx7ulp.c                      | 209 +++++++++++++++++=
++++
 drivers/clk/imx/clk-pfdv2.c                        | 201 +++++++++++++++++=
+++
 drivers/clk/imx/clk-pllv4.c                        | 182 +++++++++++++++++=
+
 drivers/clk/imx/clk.c                              |  22 +++
 drivers/clk/imx/clk.h                              |  92 ++++++++-
 include/dt-bindings/clock/imx7ulp-clock.h          | 109 +++++++++++
 include/linux/clk-provider.h                       |  17 ++
 14 files changed, 1183 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.t=
xt
 create mode 100644 drivers/clk/imx/clk-composite-7ulp.c
 create mode 100644 drivers/clk/imx/clk-imx7ulp.c
 create mode 100644 drivers/clk/imx/clk-pfdv2.c
 create mode 100644 drivers/clk/imx/clk-pllv4.c
 create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h

--=20
2.7.4

