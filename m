Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481E3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F9321B1A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GPPBZvp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405073AbfBNDoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:44:25 -0500
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:34821
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388138AbfBNDoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPygySHmkC7eXwxZ6Pyq4nSejjUZiX2FJoXK35RAhlg=;
 b=GPPBZvp/xyzq63e2U+KNZ+fx0mISS2AzSk8KwnZjlJOuhxAGVnwdmHrwxAQaluooR1Tsfq6znwm/0kOxFCf8kgHsAzHXSlb2iZH3ojOTDgfJYtbt/+EM5oLBBMRnOPICKIEIM96PUBE7Wi3N8CHl9ElTB45o11hDUmkM5J40sxI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 03:44:20 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 03:44:19 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 0/4] Add i.MX SCU general interrupt support
Thread-Topic: [PATCH V2 0/4] Add i.MX SCU general interrupt support
Thread-Index: AQHUxBeRAJF0COhDkUKIcKizfFbw6g==
Date:   Thu, 14 Feb 2019 03:44:19 +0000
Message-ID: <1550115535-14488-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::32) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68acc746-078d-41c4-8a45-08d6922eb337
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3659;23:ksjkRwsMNBjMPURrcHv1YFNSvRsT94HRmGFAr?=
 =?iso-8859-1?Q?Ku1wpYWGIbmVsGmh2Ls8xWIDadyh8CFalCsyGljBIczvazAV+7jesHUExU?=
 =?iso-8859-1?Q?b8tq7uUGEm+HEqM3s3ENt6fbb50rj7GFtcsZsTxAE05O52oghi30KQMFg+?=
 =?iso-8859-1?Q?m+7kqYoI/HDHjcQ9LV+XZjhIKD19plXwDoWfZB3RSjfDOkO6zJSpNHAMz3?=
 =?iso-8859-1?Q?+Fba56pwuC1xd9LGcZJYbggLkXIahpptNaoJOFOspW5wCYdXjEI9LsTEvT?=
 =?iso-8859-1?Q?/dBaDE/X5JDaWBc3yyo2S4/n/4leBXnP2ijHalkuhhXa32wSEVXSxkzeQS?=
 =?iso-8859-1?Q?hzzcOrLQuOiWGkgec+G48la+ll0kkAQHsM7eRPCgPXQ0UOziEiZKupx4m6?=
 =?iso-8859-1?Q?ygOm67o8QBP/cGfCN0GTgoCm509veHYFgcCMPPpZAmvvqWAIwkeqySYXPn?=
 =?iso-8859-1?Q?mEj9UKw8dRzhbVaSLm0gypkU9C8Tyi2DBqea8HghTAChQCSI/VJ8cKqoxZ?=
 =?iso-8859-1?Q?e0EWaD9m5VH/YXHcjDt6MMWwN/i6a/Yz/QLTyfYQ0rJ0EROdN8rASvWQyP?=
 =?iso-8859-1?Q?KryFlJb1ped5kX7TQ0qPW4ufXcGi2yFlQGNo3Y+mqI7ZuRUh8nrR1p9YsU?=
 =?iso-8859-1?Q?RoRb3K0cZiCpqL5eih41W362vkd4PYdHhP4bgbRvUdC8YubMCRyQQIFEWG?=
 =?iso-8859-1?Q?tzATS9VyfGVpdMzI3X/nvSYhTzywtd8fllGpGOc1U4sJUnwiBV29/ntJ1G?=
 =?iso-8859-1?Q?n/cDOHwLP0vTzmtFm39UnEmQJmKMSRLEXmpbJAI8INEanrwE3baF6FWBrD?=
 =?iso-8859-1?Q?GbHNMEOio2N8WFMiMo1IL0KNnHRmQFf2JvEaGzx64N2GTPf8dYjUfgjeko?=
 =?iso-8859-1?Q?zE2bpf0q0ppf51maqENslnt/70oxU6sW5wiR8ASo6g7Ys14vqWrSoP+mrL?=
 =?iso-8859-1?Q?IZ12M1KDPBU0yluaxYBWZUThKX7pa+NxzbBtAUDzqsyWkpnw0/10RSsNYv?=
 =?iso-8859-1?Q?hFbH9tkVGxxF5prioDx6nNZUc1VX6uAD/AGflICmqS2/cC391NiNMUAx8q?=
 =?iso-8859-1?Q?YyKJ1yzI643jrm3ARDLfoJYTJOXu/tKQV4UneV4hNswVKcky98Y62P5YuK?=
 =?iso-8859-1?Q?nummuPC/IYWDI8DKsBoCjcvT2QzwXuixzRj3re+laWZFolgOJ9Q8dvVxSX?=
 =?iso-8859-1?Q?v2RRlzWaN5jHfL9YE/C8i/FGgZUWpGNxZmdTc6P/ClqoCa9OAlgfaxno?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB365984CBD18CB83A37956DCDF5670@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(376002)(396003)(136003)(199004)(189003)(476003)(2616005)(68736007)(53936002)(52116002)(66066001)(14454004)(486006)(86362001)(50226002)(4326008)(26005)(6512007)(2201001)(478600001)(71200400001)(6436002)(8936002)(6486002)(25786009)(8676002)(71190400001)(81156014)(81166006)(186003)(2501003)(105586002)(3846002)(6116002)(386003)(6506007)(99286004)(102836004)(7416002)(316002)(2906002)(305945005)(110136005)(97736004)(7736002)(14444005)(106356001)(256004)(36756003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tcTzajP2Mu2j8MsrsRyGTCALNcu2BoOCnro8ykHL19DD5w1l2lCut9i6y99BkvTRCGFGhKUmCNcIs5r3piw8MNbXd4JjVbyTwZSVGpzBUI1E+sFVR6TpSUGqQHZH4A3eByW0UJfFB4UxDh1kES7kV0WX4eTn8y5uIz4KCg/lpSyKMPgZSiZY+0Fxk+Ll674QhgwPWHERRK54AqRp/33z7OLDlGwvmqwtjEvQuUuHt9rbhCLSuaC5JQkmedGCCrdw+wP68tpgpWKVoXUWxBhIcEV8nDeq7skJueGIINotQDAGUAQEbAGbSjs6xCz+A9bwuQTaMf3C85FH6PU6DyPJtbEnK3+fgVRE/hehxB6zja0z1jAC9NJj/pf2qfAUGDZ4ygTB8i45zx03JhuuH9QU98or/WGfZzQYyTK5nEO/Jxs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68acc746-078d-41c4-8a45-08d6922eb337
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 03:44:14.0949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds i.MX SCU general interrupt support, the SCU general
interrupt supports RTC alarm, wdog, thermal alarm etc., e.g. RTC alarm
irq is controlled by system controller and when RTC alarm fires, system
controller will general SCU MU general interrupt rather than RTC IRQ, so
need to use notification for RTC driver to handle the alarm event.

RTC alarm function patch depends on i.MX SCU general interrupt support,
so put it into same series for review.

Anson Huang (4):
  dt-bindings: fsl: scu: add general interrupt support
  firmware: imx: enable imx scu general irq function
  arm64: dts: freescale: imx8qxp: enable scu general irq channel
  rtc: imx-sc: add rtc alarm support

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  18 ++--
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   6 +-
 drivers/firmware/imx/imx-scu.c                     | 101 +++++++++++++++++=
++++
 drivers/rtc/rtc-imx-sc.c                           | 100 +++++++++++++++++=
+++
 include/linux/firmware/imx/sci.h                   |   3 +
 5 files changed, 220 insertions(+), 8 deletions(-)

--=20
2.7.4

