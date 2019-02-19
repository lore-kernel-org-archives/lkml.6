Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74008C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385ED2075A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iBN+lcOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfBSDKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:10:49 -0500
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:45097
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfBSDKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMdVyfv4lkkTWzf8aFeLRADG3QC6V6+YGdrLiHZWN/s=;
 b=iBN+lcOQxF/3lfnIXMzqFL3q4528sXLZBkymYwrhzrTAPiJEOvtDXiftArBOvwGcNoq9sBzJbUgCQrL7/Yz5Gm5gSFokidPd7L4cD6jiWJ/FmyYhnJbciyrWWsBcIUF4C6vaGJIQmTdXX0pTqKXmZ5p/uQewkS/Ps76Z7L70/Eg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 19 Feb 2019 03:10:42 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Tue, 19 Feb 2019
 03:10:42 +0000
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
Subject: [PATCH V3 1/4] dt-bindings: fsl: scu: add general interrupt support
Thread-Topic: [PATCH V3 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Index: AQHUyACy8HmIYiPaSECjXHiTh1QyKA==
Date:   Tue, 19 Feb 2019 03:10:42 +0000
Message-ID: <1550545569-7197-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8ff25f2-d5bb-4a48-893e-08d69617d4e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
x-ms-traffictypediagnostic: DB3PR0402MB3916:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3916;23:mb9o3mZL8y30999K2d4iIYDAbSM+X9PdaPZrn?=
 =?iso-8859-1?Q?phL7MIj8Qa5oElC6EadUlokTv8ofmyZlqP0eR/MGtxqlj1L4GoReNGfegz?=
 =?iso-8859-1?Q?eQI7G9DJjRiZau8MYy/mFujDLQr1fmauXx+i6YouLKCqOEM0HOHBIWJdJE?=
 =?iso-8859-1?Q?SO95kfPp+wkHbhVzRTcYNS788dU24xbA1Om5sbE253ntxuf/8qF7bjkp2F?=
 =?iso-8859-1?Q?AR2AAFMJmdjgW0bSvwurwB4h6pBunBKw/mgVqsXJ+00k/XRtuGKkzHYQRw?=
 =?iso-8859-1?Q?1OG5l2oct8UG9HoAnvIflW/9bKPOlCr/leCBdLDHsf5+5h587wMHSq+nAl?=
 =?iso-8859-1?Q?ygC5lRatkkMt94sb5we7CDcJcbi6P/wXX69hcxkvu7mQrpLORldW/J6k7p?=
 =?iso-8859-1?Q?44YTpOnrRIzDyGP1j2XRT9dqoJejx26BR6wpPwtHvaT0e6o8uEAL4fLqzJ?=
 =?iso-8859-1?Q?BiQeVtJtWv/ovQntGk+Vyt6/hkvCG/0iCowZerVFXxoNIFV18JaXpHMd3g?=
 =?iso-8859-1?Q?A707iSP7nfnpWgInBhAMzA3WCySp7QIoIOWn0UASwbuWs/H07hnQAHA534?=
 =?iso-8859-1?Q?rRgcQ/SQaChU3E/UTrwu4eUyidQ2lL4c9DgfYnxWBZD6pAnx8ENvFUPKpu?=
 =?iso-8859-1?Q?nCoAaSFlA+NJ2ROfFbD5t0Fck+0/aWPSDN/1IjZ+vAj6kGgwC/JvzR1h1K?=
 =?iso-8859-1?Q?PZFPmOfP1Q8f/ztSW8CVOeVgvjgy6tQrpEYwH+5bZbqI2i3eAAp4UD7CIH?=
 =?iso-8859-1?Q?9tvNNHviQe/QfUS9wAjTp8z2EU9c4+3jfYA+omKrJVho7tCtSyEK3yfz4W?=
 =?iso-8859-1?Q?BApivGT+KIyWOtu8ciYrbfpwY4VV4IkropCFyEdc1zkKIOreo/GJXsvrMm?=
 =?iso-8859-1?Q?p4s+He9pLeJW1jwAh8TJLh1Uc07G024DWvs5r3rAFnZx3RfK1mfOdS4vRB?=
 =?iso-8859-1?Q?yTk9sDB7876HFCKnheGoJSedcWmsLh8x59ivozgaiZom7DUYj7TXphENwp?=
 =?iso-8859-1?Q?nhp4MpigiLbpg8d5JS/xblGMYnkbb3rAohIpKUu1h9nMDxtKWDFh6IU4IR?=
 =?iso-8859-1?Q?FvI9C+hNS24GNTkOmhQsfiE95iwDjhkSYqlkmHtt67BFj+4UpJTKPwDieZ?=
 =?iso-8859-1?Q?zpSCG1/lcNFW72mYDbPyEcKDrN62GTRxDb4WsTuAQghJvXppGzqF7GIgdB?=
 =?iso-8859-1?Q?1O8ulV21JGwUmGksTYUMMfycCS1EOO1J72yks2lttcb19VcegbLt8pWCfv?=
 =?iso-8859-1?Q?CyiMcXVldXjyWoRpOxpHU/GdFoV3e8E7TeDssJBgg=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB391692163D7DEFBFAE5BB5AFF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39850400004)(376002)(346002)(366004)(189003)(199004)(26005)(6512007)(25786009)(68736007)(256004)(6346003)(478600001)(486006)(3846002)(6116002)(6436002)(7416002)(2616005)(186003)(14454004)(476003)(6486002)(4326008)(52116002)(316002)(8936002)(81166006)(50226002)(99286004)(7736002)(81156014)(53936002)(305945005)(110136005)(8676002)(2906002)(86362001)(102836004)(105586002)(2501003)(2201001)(386003)(6506007)(71190400001)(71200400001)(97736004)(106356001)(36756003)(66066001)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6rTrLIc7XwgM07W/nYfCJBV+ZNEb9y3FL0suW4Y47xmqNku40nN/9aSCefxMnw0L+INQHian3ibK7lAbSPjRCfWuW69oq51lu3KysFeu7nrjh5k26nfuRm1dUGBoDiSfX8cAZioVfnCFA2SBAn18UTkGPS1bS9EzVFXxPhUZ9+jUSgNYL2yKSyuLfctoTPuPAQqwpewtiBCdu+hN6l+pSYP/VCZlprxKM+FNr3pyyEp3/8w1qpiXmC5Y2BfnqYk5nj6wJKB60ZPW8YYLIDLILLQJ9IM4MrEjIaon3OG0Xs5dLKqecAoe61b8g801mY9IapQnr0zqhSZaDoR4YdXW4m7oambURDYyG0niUWhpycFAmE22558KmNR04ePRn19/ZWzg/Sd8YeT9sqyjbJWAlLHDXTjDYl0wSnn36LySuoE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ff25f2-d5bb-4a48-893e-08d69617d4e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 03:10:36.8447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add scu general interrupt function support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
No change since V2.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt      | 18 ++++++++++++--=
----
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/=
Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index f388ec6..e5def3e 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -22,9 +22,11 @@ Required properties:
 -------------------
 - compatible:	should be "fsl,imx-scu".
 - mbox-names:	should include "tx0", "tx1", "tx2", "tx3",
-			       "rx0", "rx1", "rx2", "rx3".
-- mboxes:	List of phandle of 4 MU channels for tx and 4 MU channels
-		for rx. All 8 MU channels must be in the same MU instance.
+			       "rx0", "rx1", "rx2", "rx3",
+			       "gi3".
+- mboxes:	List of phandle of 4 MU channels for tx, 4 MU channels for
+		rx, and 1 MU channel for general interrupt. All 9 MU channels
+		must be in the same MU instance.
 		Cross instances are not allowed. The MU instance can only
 		be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
 		to make sure use the one which is not conflict with other
@@ -34,6 +36,7 @@ Required properties:
 		Channel 1 must be "tx1" or "rx1".
 		Channel 2 must be "tx2" or "rx2".
 		Channel 3 must be "tx3" or "rx3".
+		General interrupt channel must be "gi3".
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
@@ -153,7 +157,8 @@ firmware {
 	scu {
 		compatible =3D "fsl,imx-scu";
 		mbox-names =3D "tx0", "tx1", "tx2", "tx3",
-			     "rx0", "rx1", "rx2", "rx3";
+			     "rx0", "rx1", "rx2", "rx3",
+			     "gi3";
 		mboxes =3D <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
 			  &lsio_mu1 0 2
@@ -161,7 +166,8 @@ firmware {
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

