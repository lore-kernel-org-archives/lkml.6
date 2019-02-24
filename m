Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20E5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C00B206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dbWTEkmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfBXCuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 21:50:12 -0500
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:5698
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbfBXCuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 21:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHxbR+mGL8fczXmbRc4w/D8IqC0OPND8gOUarj9FHws=;
 b=dbWTEkmTVLmxbXCuXImbKqrkBRZwMWE3vaSVHhAbM83R/EulYHd6idm0w37Baorjq9Aq58nfFULItHXWgMs4+nmoEtYYxCA2VSvNfAVR03pibXgEe9dPVM3QBc4+58u0Z4TxDVG7qKdJqg4MkoMcH/f7wSe077DJ21I/WFDnAsU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3865.eurprd04.prod.outlook.com (52.134.73.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Sun, 24 Feb 2019 02:50:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 02:50:03 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V9 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V9 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUy+ukMWDajCXXzkGf+b3wfa1YNQ==
Date:   Sun, 24 Feb 2019 02:50:03 +0000
Message-ID: <1550976319-20216-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 297df944-045d-4a88-8a1c-08d69a02c6b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3865;
x-ms-traffictypediagnostic: DB3PR0402MB3865:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3865;23:jy8HJ5t1xdLfRMAKOZUN9wf2lKaEMzipItprw?=
 =?iso-8859-1?Q?zyqtIRc+jWar7wXQvajeB89DNOh3xgz0on28xTE44kGDFlBY9MwcVMvNTu?=
 =?iso-8859-1?Q?U0FeEwwcfSj+sV3IWQLs1R3c4bXAy+LIvkqI1AgNjCJb0tR4tQXMSsdW7o?=
 =?iso-8859-1?Q?In2acKywESlLs0f5QSg93CJxpeDpjYV1yYCH6fi2yAOHT6Hre9MSmrsSGo?=
 =?iso-8859-1?Q?RKzTfP4MwbbqPnqH7IGuLsUJQ31Ia3pE5YAOBg9FuVnw4StQ+QIkfTambR?=
 =?iso-8859-1?Q?2GuT6X5xC+qD76HzSIitLrgSQAo7NSsMXyQvonG8GKAhtZ67QEcZagexYs?=
 =?iso-8859-1?Q?/Z3+y/1EJ+ggKYWl0HZQW4sRDhLavc3bQwZKQKcQjtrIcsk66CmCoTIPS7?=
 =?iso-8859-1?Q?cgsCkCisN0y7QQWA4NyxdRgiLU2R1MvahBwBOI071/prx7EJpta07P+A4w?=
 =?iso-8859-1?Q?M0j17iQY29QRmuhe/eVe36m3UUhSTzrZ9oPsVyaQHWtatFztgkjLL4/mBt?=
 =?iso-8859-1?Q?5eOZlUW8/7iyJSJSpMwDJNj0TOmkZTUPAVD9PECBFi08VY5twhRS0MOQDr?=
 =?iso-8859-1?Q?rA226pEApUBY/trapIoVfihO05bIz5RzFgKgB8HkfZ5ZetWhffXW4cb0Zz?=
 =?iso-8859-1?Q?l8BtGy9AyHvO+sRhO6eqLFfqOuUEHmxQ2UOd+tRqWsaSdqu1CAglAnA6m2?=
 =?iso-8859-1?Q?r4RYzligtdf6AV0YxECuqIeVQiCFyErXyJqtIuLo++Jo0bTHbwDF0Jlfpp?=
 =?iso-8859-1?Q?IR6xWv/4TffNYvHH1kxPwKjbAJr87neuqZL9gaacc3yYhrxRIfmJ9wztho?=
 =?iso-8859-1?Q?y+M272LZHgC1S9GHn1VLx3ht1jCEiONZ84Qli+WN+fO0OeLRHRJR+3aYLC?=
 =?iso-8859-1?Q?rB9Tp8Rwf5IIiV/SVhgpnU6u2aCO/b0QObmpVemQ68WD6KfY3wx7woPz9D?=
 =?iso-8859-1?Q?D5UxXjRy1u4kIvv21uEUnsGon19dK9/P2weZKy4YNdyD/dcj9E+ZyDVS/z?=
 =?iso-8859-1?Q?rjveuPBkCT6eMX+1cZYPTTrErbRxttYSYTlRs4rSsBooUJh0Jv2IONQ6zL?=
 =?iso-8859-1?Q?WTcvOR6rW+YQBDwiD2v1TUn90XFvvLFe3qf1WonPmDzjQUOL+TeyRmAgFJ?=
 =?iso-8859-1?Q?/q3GEOD2TknDG6jvL/sN/vt/QcZZ4maBDHzUQP9+K3HpvrmYNFioubwyG6?=
 =?iso-8859-1?Q?E5PGZsZqAl1ynNmgW/9o10yJJ9fmjbW4h2b6JMBSbYOaJAi6u61fEKS78D?=
 =?iso-8859-1?Q?TKuO5ajrpFwdEwSPECG?=
x-microsoft-antispam-prvs: <DB3PR0402MB3865141F0BA2777B37268A1AF5790@DB3PR0402MB3865.eurprd04.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(396003)(136003)(346002)(376002)(189003)(199004)(110136005)(478600001)(4326008)(316002)(66066001)(256004)(3846002)(6116002)(36756003)(2501003)(52116002)(7416002)(99286004)(14454004)(6486002)(71200400001)(71190400001)(8676002)(6436002)(53936002)(106356001)(2201001)(6506007)(386003)(86362001)(6512007)(7736002)(305945005)(68736007)(50226002)(97736004)(8936002)(486006)(26005)(81166006)(2906002)(186003)(2616005)(5660300002)(476003)(81156014)(25786009)(102836004)(105586002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3865;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: arisezFOBvbPG9w3E41PRx6cHmq+tJCbxGQ/2PLZ+XLigx9o603aZc/oGmYDg+Cwtt5oNJeb8dj7i8/2xn+N/6sP0+wiPtqBernwDfm5WTTvMH4VbHZLaeNuBwrJS3fd+UnO94dwYmwMh4Lr2sKUjczga/Q2YBTna3Nncvh5UPM7gzLXPPRcLJbMAUg2yjakDvE1wWPoySVm2mwxZCi0s6/z21L6e6IkfDd2+WDY4+OrMsXip1ZRU1L+wmpSXDzq+Y5IBo4qAjwyV+MYWFVVRmVe8pkn3dbFlJ3BM0rFeogu+z29GbHSyjbXdi6dTo99FaM3Fsmz+EXTwgSOw7KEAlgb9TQt2v6cto66xXnIOmSef7aMJWoajIQYnKMpHLKktW9g2C2XyLSQqMKk/zEFixqKQUF1bASUBzDLj2jbxkU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297df944-045d-4a88-8a1c-08d69a02c6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 02:49:54.8095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and thermal sensors etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to get temperature from thermal sensors, this patch adds
binding doc for i.MX system controller thermal driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since V8:
	- improve "imx,sensor-resource-id" description to cover single and multipl=
e thermal zones.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt   | 21 +++++++++++++++++=
++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/=
Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 72d481c..2e310ac 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -122,6 +122,21 @@ RTC bindings based on SCU Message Protocol
 Required properties:
 - compatible: should be "fsl,imx8qxp-sc-rtc";
=20
+Thermal bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible:			Should be :
+				  "fsl,imx8qxp-sc-thermal"
+				followed by "fsl,imx-sc-thermal";
+
+- #thermal-sensor-cells:	See Documentation/devicetree/bindings/thermal/the=
rmal.txt
+				for a description.
+
+- imx,sensor-resource-id: 	A single integer for single thermal zone's reso=
urce ID or
+				an array of integers to specify each thermal zone's sensor
+				resource ID.
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox@5d1c0000 {
@@ -168,6 +183,12 @@ firmware {
 		rtc: rtc {
 			compatible =3D "fsl,imx8qxp-sc-rtc";
 		};
+
+		tsens: thermal-sensor {
+			compatible =3D "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+			#thermal-sensor-cells =3D <0>;
+			imx,sensor-resource-id =3D <IMX_SC_R_SYSTEM>;
+		};
 	};
 };
=20
--=20
2.7.4

