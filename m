Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB286C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DD7222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FI194rcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389829AbfBMTFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:05:17 -0500
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:5779
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfBMTFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsSTv2/G99JpPDvMmznDyNQ8rRkMBCqqXMbJUHn6gkc=;
 b=FI194rcTFywa2/ajyElOtyKV3ivmDt/tZ8dN0CJv0cpakT2hiqLAgi5TdqIO//hMLF0hxuXgscZHExa7HoNABiQyitExbhVpTP3M+xamXO4DiweSVGjPIFmomgFv4TYCZwpunLBMjgkXJ0EYRJVxpLpRYak9iA1mm64ubqGv8g8=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4515.eurprd04.prod.outlook.com (52.135.148.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 19:05:11 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 19:05:11 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 0/5] Add cpufreq-dt support i.MX8MQ
Thread-Topic: [RFC 0/5] Add cpufreq-dt support i.MX8MQ
Thread-Index: AQHUw88LTkjKdriTxE6guK0OS+WFfQ==
Date:   Wed, 13 Feb 2019 19:05:11 +0000
Message-ID: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0058.eurprd07.prod.outlook.com
 (2603:10a6:203:2::20) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 542ed91e-8eba-4b85-cd32-08d691e62d54
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4515;
x-ms-traffictypediagnostic: AM0PR04MB4515:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB4515;23:vczA4NvZ9nvPtXLKcj1pHS49d8V8l2Cb+LmTl/6?=
 =?iso-8859-1?Q?SjCYGAKAIzpr9TlXEEVR+M7ohqRM8u7BI0yDG03o3cwObMQ4IDgo6HWiXP?=
 =?iso-8859-1?Q?COyMF+kW8+cjl6cYRVerYFdMT5GrY5OtMUHEIaA1RUp9Fd9fIgc5NqmgNF?=
 =?iso-8859-1?Q?V989tCRVibG1fM0tXPvIQGkUWeW9eTzBhtm5N5pxyUIWcSmNCL9K8lBFGF?=
 =?iso-8859-1?Q?2f2LsV983GiB8FJNc4bS/hFzzVRz9YzC3gbAluchyU6SD/KY+iroK57oSP?=
 =?iso-8859-1?Q?yHgDmo84ZaMTI0euairhmSzRuHMNQliuG6f5PoDgdqkLqJlUUkYCMzpijl?=
 =?iso-8859-1?Q?SldyXorRYDxDQcbQOWFWGB2eDC4lQ9XO4cgb5n8rzc4ykWzdtE+bbn35gT?=
 =?iso-8859-1?Q?TL2l4SI++pW+XucsfscGKxXmjXuZBbecxD1nJSTACWed/H3NFPhy3EfaGi?=
 =?iso-8859-1?Q?EwS0ZKYh6jgn7q/QDazFlBaw+M6VUzGtiThI3BXu4oOrM0lt/97n/5UHdK?=
 =?iso-8859-1?Q?Ow3P/LmJgSIi4B1J4sIr86DA69CzwUq1sPffSbF3sxfMvew1cF4BewfwHL?=
 =?iso-8859-1?Q?Uq/590bC/dJ+9RmQbt8oqSrXhEco+x2QP1Zy1XSTdgq62v3okTHMAa+Iqy?=
 =?iso-8859-1?Q?334wyAvcs1AczzUsB9jSkrKQAwo7NKOyvyzKejBgBeSGqoJQxNAb434ehb?=
 =?iso-8859-1?Q?fz3He/QRh1OMYUCxWMZ5ByQmS8wMeCo35NvFsDXpdl9ZbqlhA30h13JEkv?=
 =?iso-8859-1?Q?2uyVQ7BnfNUg8qxkeREGmOgiVkdEiFcQmpEMehKyVteoaWmrf0c4o0bqjY?=
 =?iso-8859-1?Q?dQzzZWb6lNDueiO2tnpPZyPFePFqNI0P0YAeESDRI232r0znEOc14wA8Cu?=
 =?iso-8859-1?Q?9N8xlIhDfLtRUwzQUqp5feBGJLrUkzMEwXw+vmhKakkNGbri8H6IKMga3n?=
 =?iso-8859-1?Q?B//wGf8N2CkkkHlfCeOg0kF1WSYXd5ot2170dEReyn2fTvytjnTPnd43iP?=
 =?iso-8859-1?Q?tHVVzj5wqgY40cadWsUniUDinf3+pXnl1rw0cB6SliLO6qD1/1raPZEKll?=
 =?iso-8859-1?Q?h5BSAR8502jN4DXhwnIZ7yAj1315R7xQ0UHdtCIvAboEFJw62m3HrwrlRO?=
 =?iso-8859-1?Q?78u6hWqv4QwSM98Ddv+g8MtOvEwFGEZU89xtH46ZsBA//36Xx5z0F/4Lyu?=
 =?iso-8859-1?Q?eds+gnJaQSrVoUwYPAFeZCJ90q3Mf3jWaIi8IyVcyIfY5+dtaRhO+Da7ZP?=
 =?iso-8859-1?Q?v/7OtP8q8paDkiX0ei1tHD6UFLID8IqImcSpomw=3D=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB45158AFF3A4CFC74E9A4C01BF6660@AM0PR04MB4515.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(4326008)(52116002)(2906002)(6636002)(3846002)(6116002)(99286004)(106356001)(105586002)(7736002)(305945005)(25786009)(97736004)(14454004)(66066001)(966005)(53936002)(8676002)(81156014)(81166006)(68736007)(36756003)(8936002)(478600001)(6486002)(6436002)(6306002)(6512007)(50226002)(110136005)(54906003)(316002)(486006)(186003)(2616005)(476003)(14444005)(256004)(26005)(102836004)(71200400001)(71190400001)(7416002)(6506007)(86362001)(386003)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4515;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EXooFvcXkI9/VjzauF4b9mPoZNypyq+MI90ek7mi1dfgka7hwd5PNFPy7Rx0ZlbZWZGIsCef5CuHHOXYReg9ypCVYpn9HmZ5IX66N/7VkR5/UVhV1umJkzlv2fmNOc/IzFdJaY2uUpPGMqSVvDsM/GFHsNGspaDM9O+MZuXKmSAqKMLDbrCuHbut5zCEL/PtGeBiBwSeUwim+VQxyKRKUJrncQOzqoX+N0VpNMteQ2lANHIYXNOQ2TxbD9YVAJb+M3wgKGhauESPBg+4JWar+6dG4zP9FsVSzdBZYkQ025jTBAdwXp9zpIOfn+DI3WENTYWQ+kDq4P6skG8S4ZgeQMqm7QKq8qcikRCGSqF4H55qml9FqIAD4csq3bsORsvoIKWB92R+vp3FpD1MUGaQYiF60vnzWEolQQY1mmBJqMA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542ed91e-8eba-4b85-cd32-08d691e62d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 19:05:10.1606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sending this as a patchseries (RFC) just to show all the changes
needed for this to work. I'll resend separately once I get some feedback
on the entire thing.

One thing that is missing compared to the earlier work
(here: https://patchwork.kernel.org/patch/10807821/ )
is the speed grading. That can be done as a separate change=20
once I figure out how to do it with cpufreq-dt.

Unfortumately, there is a need to update the dt-bindings
once again in order to add missing ARM clock from patches 1 and 2.

Abel Vesa (5):
  clk: imx: imx8mq: Fix the rate propagation for arm pll
  dt-bindings: imx8mq-clock: Add the missing ARM clock
  clk: imx8mq: Add the missing ARM clock
  arm64: dts: imx8mq: Add the clocks and the latencies for the A53 cores
  arm64: dts: imx8mq: Add the opp table and the cpu-supply nodes

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 17 +++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 31 ++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk-imx8mq.c                 |  8 ++++++-
 include/dt-bindings/clock/imx8mq-clock.h     |  4 +++-
 4 files changed, 58 insertions(+), 2 deletions(-)

--=20
2.7.4

