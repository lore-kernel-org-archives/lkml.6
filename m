Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21C6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5E5206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="otaTfd+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393146AbfAPNVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:21:41 -0500
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:58528
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731240AbfAPNVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FhTNNMGl06GKrhzfdZ7UeZW0ETplLk8BD/R7JSIuic=;
 b=otaTfd+depZM2zjIsh/1J/E3E6fFsqmE9hAE9rUpAZa1MmK0AlZqp/mWcTYSurDfSvdf7sh88BUvnHn0ZRNi7TGuQstydK4xCmYfYdd9f3J9SqKzEociBjtV9iFYMgquUHGvGvHBUq9BAA0IJwaI1BMLWiUVj1f8UTXXbRRSN0A=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 13:21:36 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57%3]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 13:21:36 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2] arm64: dts: imx8qxp: Fix MU4_INT number
Thread-Topic: [PATCH v2] arm64: dts: imx8qxp: Fix MU4_INT number
Thread-Index: AQHUrZ5o76DkAvPevEK4JwTurBqFmg==
Date:   Wed, 16 Jan 2019 13:21:36 +0000
Message-ID: <20190116132124.4383-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::12) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2800;6:JZ7UJCC0bodwKxKrB5SqJ6q6jbPkeRjxpnz8ak3fpQyYlfZI36ysHFH5D4uefTReBMHWMCZ0g25P10Yt5Ep4cfCyvjxOOadLkLJnhwwS36Y7bZia+A8pxXPdmJLTwCXRPNrWKoyWHEqHsIKVLudC51MbY9ZqUR7QYSAJJbFtL6k4UASsq4l2iQVuFi2yIgLAy0yghQMB6fUkHke63JDbBdRwzDDDdcVAtUcJooEgvJUHegFU6mDf6Hiyajw+aYiaMKRvs5cscBS1eceGGJvdakQNOFpZCEsXAQA28zJ+VfdVjkGHFEyBwkMFzShhNxgj8zK2kjO3deqPE41CQNcS89zAayyz3wiwZG1bSEgMXFTOCBAdh9lg+3w0h7eV/LeIEweubWQouNx4nnujNftqANvoOmo5OchnKF+cNuMtCVAWewEWeKsix/ogznuElo+Xrz3AWQVuAKyKm2u3Oo2NUw==;5:m6TKgm+FkmCZsRiodCrbwfxnz9PyFHl6F9ytEBaiQuDka5LBbpmBXXBn6JlNp4cERdHXlpErI6SRRixEDbUmhv2X4cVJCIjSpQWB9lVrEYb8DnlB5A++ZDMLgThiBFL8lXTgmJ/dVYGLIyhD+phqMM6hU2av+TNs/9B7yDHdBgl7OfDAMfPDUR4oPzUVw1bTvBbTHsNmrrxkTbVyYVKWEQ==;7:MmDDA3xeMSKmvLHXqIrOmtFYKBv9De24PhG+oNob7kSgrBN971egQeu1+msPM0/yvpYw/TjS2HxL35XHmQO1C0oJSPv1d83QooFs+prUTf0vKJypk1pvnJnz4fTC7UnqEf8JE0EfvJ3fFRzSU89zqg==
x-ms-office365-filtering-correlation-id: dea30276-a446-4026-025d-08d67bb58a61
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2800;
x-ms-traffictypediagnostic: VI1PR0402MB2800:
x-microsoft-antispam-prvs: <VI1PR0402MB2800B57F941680A46F8B011CF9820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39860400002)(136003)(199004)(189003)(106356001)(26005)(5640700003)(53936002)(6506007)(486006)(316002)(7736002)(1076003)(86362001)(6916009)(44832011)(14444005)(386003)(66066001)(4326008)(6436002)(476003)(2616005)(305945005)(186003)(2351001)(68736007)(102836004)(105586002)(4744005)(6486002)(256004)(97736004)(14454004)(2501003)(5660300001)(8676002)(52116002)(71200400001)(81156014)(81166006)(1730700003)(71190400001)(3846002)(25786009)(6116002)(8936002)(54906003)(50226002)(36756003)(6512007)(99286004)(478600001)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2800;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GwwpLL0kJfCNRrPyUM+PGOciP43gd5P6kA9oOIjhBYjWf1JJyottf4znFUKPK5nQdK4PF0dFwKDIWZEsItwTEsq6qTfAZi39hkdhTb9EZeC0VWHZ2gzS3JiQElRxMNjYaFFOnfKFnynDjtI6prAiigT+hLQr8OudfK7C9DQ+QaIu8xqeBlhrObH8QzXvRZZuSfQEdDS3zjooIneYBMeLj/b4fbM6/mrm558F8s3Z2HMbSTrAW/S53hMD72UUER9L9V0VqPDz2kFR+eZSSyGk97pLEkofBjGKjFRmS4xi66NPOQNhcLlyLw8loxMJNVrWpdy3WC8dYUQzIpIYJvMcXlkn0gmEdktjtkNSmaK4JIjs6cwVOddLpRUp3+enqH8/QMRMNOUFl4eelLg4CEL3pWP0Emnpdv5E2we+yAyBEXE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea30276-a446-4026-025d-08d67bb58a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 13:21:35.3969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MU4_INT correct number is 180, while 179 is for MU3_INT.

Fixes: 3d91ba65fec ("arm64: dts: imx: add imx8qxp support")
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v1:
	- fix subject prefix 'arm64: dts: imx' -> 'arm64: dts: imx8qxp'
	- added 'Fixes' tag

 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index bb877cf25edc..4c3dd95ed488 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -350,7 +350,7 @@
 		lsio_mu4: mailbox@5d1f0000 {
 			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
 			reg =3D <0x5d1f0000 0x10000>;
-			interrupts =3D <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts =3D <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 			#mbox-cells =3D <0>;
 			status =3D "disabled";
 		};
--=20
2.17.1

