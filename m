Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2F8C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BB121848
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KPQY14vF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfBUJUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:20:07 -0500
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:35760
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727401AbfBUJUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jPtRko9Q1oHdDC0dUWXPdjY2DAGN3sUrtQ3n7CZSNg=;
 b=KPQY14vF9PPoWbl3OIKvXFADIJvoPAno8C4fxPlrVZ8cPmlvKZc78NwQq7agPwWNcmzPCtqJyKt8wOKY1UGQNZ1WdlwvKbef+NbrS14c8xTe1tsvYWOUJxbt8T/gYjBhL5MZHIB+2yfcFdEkm08AQ/k2VM5VuSk84Nggl/dBBdo=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3784.eurprd04.prod.outlook.com (52.133.9.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 09:19:23 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1622.018; Thu, 21 Feb 2019
 09:19:23 +0000
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
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 1/4] dt-bindings: fsl: scu: add general interrupt support
Thread-Topic: [PATCH V4 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Index: AQHUycaIN7xFf3mk/UCK6kIxRpvqJg==
Date:   Thu, 21 Feb 2019 09:19:22 +0000
Message-ID: <1550740354-2701-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:203:2f::13) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f283e694-9269-4154-352b-08d697ddaa6e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3784;
x-ms-traffictypediagnostic: AM6PR0402MB3784:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR0402MB3784;23:e3iC9gNapXxYUBZaoYXEAkkBT9hbwLbJIEDmr?=
 =?iso-8859-1?Q?EC35tLp4ibEquHy6c66i45amlGLmyIU6/+m+lMXRRxDyKZiZdAxaHHpoMQ?=
 =?iso-8859-1?Q?hYS3q1TdmKsy6EjFLnO5x64+4kSsH45itYFLUh0zlzzNmc06icy9x1rBv+?=
 =?iso-8859-1?Q?RX5gqBrvJUyf0S240MwyDms2UYHcSEG8SYzeksbUh/QUxryN1zSnyE/wRl?=
 =?iso-8859-1?Q?4i+pYn9fWWMLi9VqAojRB4zoCR7a8ftWwRbH6rwXSHazm/Jxkd+waGaYfd?=
 =?iso-8859-1?Q?aBi9ju8k4gGK0ybS4P0t8H2CgbW9EQFApSaY+AIxgkuU0PjQy2F3vcSkvZ?=
 =?iso-8859-1?Q?do+koZdwhPb6CARsWVJ5fiXe3yldp+b7/DImLiWS1pDZvTMh5iFfsXf8Zt?=
 =?iso-8859-1?Q?A0+vIFIqWefiq/rtwLvqjsbGCQSb5FfkH+X6KcNtPukyYDamgJtO7BULxo?=
 =?iso-8859-1?Q?6XXOh5aCNmJHD0XyX39Pga7RFBr3gwwnnb94iDgao55KHTdXoLSdjVQyKZ?=
 =?iso-8859-1?Q?bUdCVLPIe+bHnPtHpYHc3BeVUnMNXwkordu04t4CN+UGYuoWNohCTc/8mp?=
 =?iso-8859-1?Q?roRMDpGYWTA49k/FarMThDFzCSfdg35CQ8M6adUW3CONttR4O0OUa7MjOa?=
 =?iso-8859-1?Q?SYOpQq/2YM8C96Iwnfy2lFGBQYDONxev+v+bCRGxCYAiPzAwHOMraw/EN0?=
 =?iso-8859-1?Q?d6m1wuq83V5ktoXbk0+52aqZT9KLZlQFrVLT4guSi7fxJtXXoOmAvGdSDV?=
 =?iso-8859-1?Q?XAaLz4D3jqU9OvciFesW/6LHyeTh3Sz3OOYAGrPdFj8qvQGCu4vi/YJecK?=
 =?iso-8859-1?Q?UyMUQ/q8QGBfD/WFTkijYFOkG/WDrpftsoZV5lq/GkFPYO7yU2XT4zOu6t?=
 =?iso-8859-1?Q?TZ9Pfnzyj98HEg3D716jZsOcPxjirBO3v1XlaBMKKtaSIbp1Re/cG1Xth5?=
 =?iso-8859-1?Q?jq03aZ9e3d3PloPqmLsOajLp4i7IVrvZFRCXD2GABI3MVJrZQvPYhBWSGS?=
 =?iso-8859-1?Q?eBbRAargEXaU8R77/IyrTLUEXKt+YeL32sDwKvyP/xYHpsdq0s841WEWEf?=
 =?iso-8859-1?Q?yV7zoZhNBJv/CTSfOSyBFmqyzkGylKTjV7ftH1VcnJJS7bbPSrEXGrfPn/?=
 =?iso-8859-1?Q?wZIR8XXLsuCTLZbFJmnzb1aLBWdPuzeqUvnPLz2tEFSzO5hw5nu52fZSgy?=
 =?iso-8859-1?Q?afCDBF2AcabMiBdswMrZXTj8sYCOe1sqajbCm8vrS+oGv7Hhh+4W0KOcC5?=
 =?iso-8859-1?Q?vCon0G1sCREf99OzdE3?=
x-microsoft-antispam-prvs: <AM6PR0402MB3784B3879E92A3BBF406F977F57E0@AM6PR0402MB3784.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(366004)(189003)(199004)(71190400001)(68736007)(71200400001)(14454004)(66066001)(26005)(386003)(102836004)(6506007)(186003)(86362001)(2201001)(316002)(6512007)(36756003)(256004)(99286004)(305945005)(2501003)(478600001)(52116002)(97736004)(7416002)(106356001)(50226002)(8936002)(3846002)(53936002)(6116002)(7736002)(105586002)(5660300002)(2906002)(4326008)(8676002)(81166006)(6486002)(6436002)(476003)(486006)(81156014)(2616005)(110136005)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3784;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bnFy4Quu3l/s/5EqmQw+7nV82Ob5Wet5ImsKCPSilBPcpW9DZsVJUecJ/5Rqm5DitojML6/Rb65p8Xq117/xmptanX64+morU3Ra7j7wSvuBS1D3k3AaxXWaw7yhs01ycakXULy9NkoH/Qq70i6TuVhoFlojd27RnCcItIev3cjwErXmK2llTVjztGIdkaykJJzHLhIgdypVQgnnv3vz8mIouuTTviAt8iWzod9rBGmJpEe295A/m2DKTcmN3UjXmh2lynGEoMwkbdtIRaK6w/pw7M1gf8EoV3l+rgTolKRg+FTwXF2lwu5W+y/K0G9epfzdlv56cd8RRosGht7Yu+pLoWor2etQfBb1dKA3E2BrhjXWS1vvTUTCD8FbDjJGJRMFXNDpr4vpt5c8oM7u7sWRk+JatnWgcEmCD4FU2sA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f283e694-9269-4154-352b-08d697ddaa6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 09:19:17.3866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add scu general interrupt function support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since V3:
	- make general MU interrupt channel as optional;
	- rename "gi3" to "gip3" according to driver/dts change.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt      | 18 ++++++++++++--=
----
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/=
Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 72d481c..4a9b9ab 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -22,9 +22,11 @@ Required properties:
 -------------------
 - compatible:	should be "fsl,imx-scu".
 - mbox-names:	should include "tx0", "tx1", "tx2", "tx3",
-			       "rx0", "rx1", "rx2", "rx3".
-- mboxes:	List of phandle of 4 MU channels for tx and 4 MU channels
-		for rx. All 8 MU channels must be in the same MU instance.
+			       "rx0", "rx1", "rx2", "rx3";
+		include "gip3" if want to support general MU interrupt.
+- mboxes:	List of phandle of 4 MU channels for tx, 4 MU channels for
+		rx, and 1 optional MU channel for general interrupt.
+		All MU channels must be in the same MU instance.
 		Cross instances are not allowed. The MU instance can only
 		be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
 		to make sure use the one which is not conflict with other
@@ -34,6 +36,7 @@ Required properties:
 		Channel 1 must be "tx1" or "rx1".
 		Channel 2 must be "tx2" or "rx2".
 		Channel 3 must be "tx3" or "rx3".
+		General interrupt rx channel must be "gip3".
 		e.g.
 		mboxes =3D <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
@@ -42,7 +45,8 @@ Required properties:
 			  &lsio_mu1 1 0
 			  &lsio_mu1 1 1
 			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3>;
+			  &lsio_mu1 1 3
+			  &lsio_mu1 3 3>;
 		See Documentation/devicetree/bindings/mailbox/fsl,mu.txt
 		for detailed mailbox binding.
=20
@@ -133,7 +137,8 @@ firmware {
 	scu {
 		compatible =3D "fsl,imx-scu";
 		mbox-names =3D "tx0", "tx1", "tx2", "tx3",
-			     "rx0", "rx1", "rx2", "rx3";
+			     "rx0", "rx1", "rx2", "rx3",
+			     "gip3";
 		mboxes =3D <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
 			  &lsio_mu1 0 2
@@ -141,7 +146,8 @@ firmware {
 			  &lsio_mu1 1 0
 			  &lsio_mu1 1 1
 			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3>;
+			  &lsio_mu1 1 3
+			  &lsio_mu1 3 3>;
=20
 		clk: clk {
 			compatible =3D "fsl,imx8qxp-clk", "fsl,scu-clk";
--=20
2.7.4

