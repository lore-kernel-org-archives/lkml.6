Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DECC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5512084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IesKaECy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfB0KIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:08:51 -0500
Received: from mail-eopbgr130049.outbound.protection.outlook.com ([40.107.13.49]:36576
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfB0KIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMAm9NOsAK64vZKydJsc+kvokW6a3GVgNTdHp7zYV1I=;
 b=IesKaECyE5iYgSmZywepSyTeZRRI0Zm2ZLQrk5Kbj+JOHjKkbVUzOzRosdPvOJi/0/mxtGReeNkwPpWw+50FWBdPHjJX31VuX3aNEv9Gxkg1PFSntH9NqiapjoYuKUvo2bQ0jbiUAI0KTNRN02jI9sZXAWr8D6ya7TagMzEeJJo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3708.eurprd04.prod.outlook.com (52.134.70.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Wed, 27 Feb 2019 10:08:47 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 10:08:47 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/2] dt-bindings: memory-controllers: freescale: add MMDC
 binding doc
Thread-Topic: [PATCH 1/2] dt-bindings: memory-controllers: freescale: add MMDC
 binding doc
Thread-Index: AQHUzoRtPPOcU3pFxU6ikSfd3nqjew==
Date:   Wed, 27 Feb 2019 10:08:47 +0000
Message-ID: <1551261844-23983-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0215.apcprd02.prod.outlook.com
 (2603:1096:201:20::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84f1b329-54e0-43d3-2c82-08d69c9b8ffe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3708;
x-ms-traffictypediagnostic: DB3PR0402MB3708:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3708;23:CVIUSZoSfnCh1StZHmQQoIGRJKznLzg3ztk9J?=
 =?iso-8859-1?Q?rG5Yg8u4yIcbqb47XPtR+mbx1+CQ4Op21Ic3+XDWWABbmJWcjwMO6kkT5W?=
 =?iso-8859-1?Q?QDbU2BlYEUIA+96Q9Vga1E0RlIi5INYz4qlBSmCnFO/dbS3TivQZvxOXm/?=
 =?iso-8859-1?Q?/9fVtNxUX0ke9kZF1XkQzOmNDiElJ4uRe34mrq4xxmcopdBNL5Sn0FpGZP?=
 =?iso-8859-1?Q?NQDZ3w4/vaGHkTnTWwr0cbVtKvKyigF8Ds8rRorBXhaY+EBS7vET/FaVhq?=
 =?iso-8859-1?Q?dJN5g9XDMsPEm1kcFo89O0CmBtK8oxNsAF6AouaggiDkN849fu0Tv9CSzV?=
 =?iso-8859-1?Q?7E3QOtsP5hCFKT32PmxknV0R0WQJB4LJBIjxJGK7gRWooTMu/9jc27SncU?=
 =?iso-8859-1?Q?YCszSlTmws2vKS6jpUxOMH7F8is9Qi3TT+UMZupqf5i8v/HU1ppACZ0tZm?=
 =?iso-8859-1?Q?RabYkTFCKhb8ylgx2iixYyZZ8k7d67tPjk5Jx1dC2n0bA30m3jXmZjkAne?=
 =?iso-8859-1?Q?eLYdiQbZIe1t8zqm9EqngLY1A8UOSf5T1iZBzZWDFcCr41gVlbse9BpM9D?=
 =?iso-8859-1?Q?Urd8zR/Zy6raQ5l/z4hWNZKRrWRDJA1XqDGnGcGbNdpS4/nPHBHVzpYtZl?=
 =?iso-8859-1?Q?baezpp1O7FVSBBHfGp1Gl3XAVACvfRljKVA7c6AO8htxZnFRQcDm3iAt2s?=
 =?iso-8859-1?Q?79B/eTmAAo8g1kxYtdhNI1J/0ugsxEtAVnMqhc+SQs5p1HGkGa9b1Apeuk?=
 =?iso-8859-1?Q?Vko9WoJyUEaoVEzDXFb7dpJPuN6JXUplBYTnFbf/iVJFM5G9TjZ7VMh7Bb?=
 =?iso-8859-1?Q?2DUK4jcqBNZbkKhhuFhrfON1GhULfPpb+ttcnx7rhoAt98gGgSqPWmPv6u?=
 =?iso-8859-1?Q?mGkm80ti+wuqd+ReKRd75aupkzriMOZGTmnTLammCLKksMmgpGer0Tqr2N?=
 =?iso-8859-1?Q?aLWkdf2xeUbEqa4dNfgTpCTz7wtQfs/gwNb927XiAloeVRZrQvW5MU4R3t?=
 =?iso-8859-1?Q?vaaI4d+8D/yX1ON8SFwFXQdk3mPyBW21lv25iH3T0PL4lkQWLUtSEQnAdn?=
 =?iso-8859-1?Q?umctUhyRGJeLrBc2bQxyLPKmf3OMuuf1lQxcTryPlvq/tw9fCFw+Ir55/D?=
 =?iso-8859-1?Q?kLby6Fr72zSbsMS+ymQ1N6mlXgxPQKoxzf6Qox/NWFRnYWMfYhjiCeaqiF?=
 =?iso-8859-1?Q?yUBHyyY2NFLP8viGHn3stPicyjDMrSHAJJw=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3708D60983B644DEB2999D2CF5740@DB3PR0402MB3708.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(6512007)(71200400001)(71190400001)(53936002)(8676002)(6436002)(68736007)(316002)(186003)(52116002)(486006)(50226002)(2201001)(105586002)(5660300002)(81166006)(81156014)(8936002)(4326008)(106356001)(6486002)(25786009)(86362001)(97736004)(14454004)(305945005)(3846002)(6116002)(7736002)(14444005)(6506007)(110136005)(386003)(478600001)(26005)(2906002)(102836004)(2501003)(99286004)(2616005)(256004)(66066001)(36756003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3708;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YgZdfuSjsYIsTeu4c3CBYaWvofLJDRgTpqD1yznf5T/4zdS1yi/DMcrcHvPKEEcod8VqmFzFa7YArgyOEyJIjNOY/cUCBJVTfxFi0lmHh85DKKzHAZlyvf6RsleFBYn0qO2Xx8PyXG+PZxD9EJB/+VMYCnL8mEC2jGe1ac8OSPLnTWzhRwdi/ZIXIlcK+bZktFWRVfeSGmQJbN5l7VoIklndOg3Pscu8ZQslbPD7rYDfL7Tdrw0flY7hfh8UnjomoVhxJv1x58O4VV2MmhhMJUWflCrKo85gped38prY9UHVHmtSr1Kc7Tx9g7AL391JcsQowfNdPIAFP7qKbapU51ndVbdo6uyjSAS6IVeRHqqhoJQ/EnK+g8PB6xqj7ordscnpIBK/hdhz2wQJgOs8qpRkNRGNKDxsRHwWJf5WfX4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f1b329-54e0-43d3-2c82-08d69c9b8ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 10:08:43.3341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freescale MMDC (Multi Mode DDR Controller) driver is supported
since i.MX6Q, but not yet documented, this patch adds binding
doc for MMDC module driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../bindings/memory-controllers/fsl/mmdc.txt       | 27 ++++++++++++++++++=
++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fs=
l/mmdc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.=
txt b/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
new file mode 100644
index 0000000..5b5a224
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
@@ -0,0 +1,27 @@
+Freescale Multi Mode DDR controller (MMDC)
+
+Required properties :
+- compatible : should be one of following:
+	for i.MX6Q/i.MX6DL:
+	- "fsl,imx6q-mmdc";
+	for i.MX6SL:
+	- "fsl,imx6sl-mmdc", "fsl,imx6q-mmdc";
+	for i.MX6SLL:
+	- "fsl,imx6sll-mmdc", "fsl,imx6q-mmdc";
+	for i.MX6SX:
+	- "fsl,imx6sx-mmdc", "fsl,imx6q-mmdc";
+	for i.MX6UL/i.MX6ULL/i.MX6ULZ:
+	- "fsl,imx6ul-mmdc", "fsl,imx6q-mmdc";
+	for i.MX7ULP:
+	- "fsl,imx7ulp-mmdc", "fsl,imx6q-mmdc";
+- reg : address and size of MMDC DDR controller registers
+
+Optional properties :
+- clocks : the clock provided by the SoC to access the MMDC registers
+
+Example :
+	mmdc0: mmdc@21b0000 { /* MMDC0 */
+		compatible =3D "fsl,imx6q-mmdc";
+		reg =3D <0x021b0000 0x4000>;
+		clocks =3D <&clks IMX6QDL_CLK_MMDC_P0_IPG>;
+	};
--=20
2.7.4

