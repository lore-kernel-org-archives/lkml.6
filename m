Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B64C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC97F2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eXUPUX7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfBYCTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:19:18 -0500
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:10548
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727276AbfBYCTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+0riIk0T0lhUCKhrbCxfM6raeVrsAIZ+4UiwiKQO7c=;
 b=eXUPUX7SMMbM8A2NX9fy1cBdLLRFJDT51H2fnB7DgubruGundY0t0u01rAFDmATRW2k3xWQrGhArpSTuANoWuWMe4KarktDPahKg0jN3xYK+DdBh5ZPyQCLEgVxYy2LcNmzprqilcVNfNJ1P2qwexDW9iZKZkDqcBqy8K+/9CtU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3674.eurprd04.prod.outlook.com (52.134.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 02:19:02 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 02:19:02 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Topic: [PATCH V3 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Index: AQHUzLB5489WCb7WrEioBIeWtwARYA==
Date:   Mon, 25 Feb 2019 02:19:02 +0000
Message-ID: <1551060850-22553-2-git-send-email-Anson.Huang@nxp.com>
References: <1551060850-22553-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551060850-22553-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0078.apcprd03.prod.outlook.com
 (2603:1096:203:72::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1df051e4-8121-4fc7-4a51-08d69ac79bc5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3674;
x-ms-traffictypediagnostic: DB3PR0402MB3674:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3674;23:CBvu/A0gwV4gc34GxmjN61A1YsFNYQ+Kb2pv+?=
 =?iso-8859-1?Q?tysSeo71G/3jhx10SsKXcy3+UQdCnvNeDVlPo7wysuPxW7g8+mprFAme9J?=
 =?iso-8859-1?Q?H1yRBHQaoUhlBMukYHxRwjHhc4KsxBltgJCZEDiV01CDvfLdceiWLdSfTD?=
 =?iso-8859-1?Q?wmBjirmei6DVgloaGzsA9FBKB8G0tla3ocyxzwk+X+A2AGW9byiaDS+zIv?=
 =?iso-8859-1?Q?mddvcNNKWSFbwQpP9affgrHT+r4azKLM+0mbjvb/i6NSwYsUm7cath1yXy?=
 =?iso-8859-1?Q?8LusXHRR/H/4bP1MTC9HzAFEpldO5ufgFGbsXwYK7FvpuW+jJJcTWwdEn0?=
 =?iso-8859-1?Q?rnjMEbSvvKEUNEmMTtqWlU6b/3BXk4yIjQYZxti4jFG8G8jdIPzjTv17fB?=
 =?iso-8859-1?Q?7tpPLIB7mWLQXKOSyBQfCWvxoW6ys8DrtFhmtCLgViOC8RyCplcv4X9lv0?=
 =?iso-8859-1?Q?3iyVtGKgj2bAF8l7e2tzx3rEHZ1EG9DYXwKS2F+kIvAhSaHXlPB4rviJ9M?=
 =?iso-8859-1?Q?sspHiEmvwUwgGncJhzmaDQzss9+/4nOkUHhHbRlwYa4n9SuCld0DFAlDh3?=
 =?iso-8859-1?Q?MY9tLJ6NzBhIl6mwtNQnO1JEetkcmCmiA1XEPNM9r/23zzqB7u0OuzGkPg?=
 =?iso-8859-1?Q?FmZ5oWdkBQcfqSQYKBShFyS3knL+KtywprWOKHx+BNmS6cWyO67rJ2JfMW?=
 =?iso-8859-1?Q?amShhD4oFicBoxdjkHQDnxy0oe79cV50bVu/jtrxLA8AKP2oYZGkle+ULx?=
 =?iso-8859-1?Q?cJwGcNT3zHXwjNKrbD9pu2BU5AIHNTTpdMLBXBTYrXb6Hi5e2YUo3XX5CC?=
 =?iso-8859-1?Q?119OOjbhnNTmlz0K9d8dEPrS6grQgWtt3MEmCDiR9NUXgNRDDQsyShgpIZ?=
 =?iso-8859-1?Q?fj1NdiPdoNSJ8pLgf+H6E5jz17O91K6zFh6JBOc9ggvIUfYauO4bOEtelx?=
 =?iso-8859-1?Q?QR06ijIROAQClL4AnNXVmchONjyy4xlo4EKNcK1YZyHU5JTGhZPLQ8QO/N?=
 =?iso-8859-1?Q?/cPGbRuJy4EKk44zWIQTVtTZlyRcH2PJGOXnEz1q07QPtake43H281roxH?=
 =?iso-8859-1?Q?d3pF2JDm7kk9gal7OfnTtrHVxfluuoKN1ohH2Zb8/y5FdR/lqco3WRHWBt?=
 =?iso-8859-1?Q?kptuBqfOeyae0bR0qClqzAXfEOhC96BMRh6IFK44cMaxhERng7B4PvGqDl?=
 =?iso-8859-1?Q?JjhS6BD0cfRUzhf3EoYpc5DzSA6JKZOR/xrK/LUGNz/ZKubC8asvj+P47N?=
 =?iso-8859-1?Q?vRjqjFJdgJez9wxWWWzpbtvQfb+LweyLYvjoBqAV7z19hucwadk7PoW61K?=
 =?iso-8859-1?Q?1yXMEXUCml8hMyPVqcm5960XhV1vocYVMfL6aeqlWKDiSIg=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3674BB59CCBBB09D7D0F3A7AF57A0@DB3PR0402MB3674.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(66066001)(305945005)(2201001)(52116002)(486006)(7736002)(316002)(110136005)(256004)(476003)(50226002)(106356001)(2616005)(53936002)(76176011)(446003)(86362001)(105586002)(99286004)(11346002)(97736004)(7416002)(966005)(81156014)(3846002)(6116002)(478600001)(68736007)(6436002)(8936002)(186003)(2906002)(4326008)(25786009)(102836004)(8676002)(81166006)(36756003)(71200400001)(71190400001)(26005)(6486002)(5660300002)(6512007)(14454004)(6506007)(6306002)(386003)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3674;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AKK2dPejjofU2r111inCH4ZSiaAZi/6kGV9PYeFtXrv+UWfFIFlcVuTHOK3N07iGMd7/JvosLWt24QNid2psP9Yg4HejeLd35QGNzeu/9gDs4VGgP/j2yKyaTmHJlw7S+LQRYxtjssds7RbJnBGYDXJBOKOb3S67olAHf3HrazJkMrAPHnBPVnubP0IzV71cI4Mr80hIO2ffx/6Xcv95lJpFSV4E4yRaKBR0fnbcPk06dj3MB7b/ttreovz0hys0PKmDrD33U0kqif32eTzzZNdT18uiUuAQW0Ei5dO44AD5WWK4SAmy94aQFAf1HCOy59OsL11ugi7g7PHIqY16ZCDCt8y1/GVY+gM7hIzN0Qux5cJinZvT2RVQxPmKhIgn8wMim/Ii/1R96USPc3jQ0sK/Ty3j20LpqUWVxqtjWi0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df051e4-8121-4fc7-4a51-08d69ac79bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 02:18:54.2876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP system controller watchdog binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- add fallback compatible "fsl,imx-sc-wdt" to cover other i.MX platforms w=
ith system controller
	  watchdog available.
	- this patch depends on my thermal patch series: https://patchwork.kernel.=
org/patch/10827673/
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 12 +++++++++=
+++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/=
Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 2e310ac..4f9a3f4 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -137,6 +137,14 @@ Required properties:
 				an array of integers to specify each thermal zone's sensor
 				resource ID.
=20
+Watchdog bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible:			Should be :
+				  "fsl,imx8qxp-sc-wdt"
+				followed by "fsl,imx-sc-wdt";
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox@5d1c0000 {
@@ -189,6 +197,10 @@ firmware {
 			#thermal-sensor-cells =3D <0>;
 			imx,sensor-resource-id =3D <IMX_SC_R_SYSTEM>;
 		};
+
+		watchdog: watchdog {
+			compatible =3D "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
+		};
 	};
 };
=20
--=20
2.7.4

