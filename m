Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEF8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C5920645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N/Q/tlWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbfAORFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:05:22 -0500
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:41696
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730502AbfAORFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcZijv0SyyBKmRZZJZAZrQ9a5Rd2rJS3wnR4KmpRH04=;
 b=N/Q/tlWxmPbsc2k52JPMG2VYIb3Rdo6dbs+uHaFpyOT9LHtzRQyBnW0u0WyFMOZ5szIgu9Zhftui5tOMDzk8sW/+uf7l6m0LAQzT4TgDi6bnwVpnxuj8opVi9FbM8YX/Zn81zVX/QvoVCaKDq/ieBvtZDpXIkR29RtunJxnHqh8=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2832.eurprd04.prod.outlook.com (10.175.23.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Tue, 15 Jan 2019 17:05:16 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57%3]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 17:05:16 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH] arm64: dts: imx: Fix MU4_INT number
Thread-Topic: [PATCH] arm64: dts: imx: Fix MU4_INT number
Thread-Index: AQHUrPR8+s4T0qQiBEy8rhYNUN5cRA==
Date:   Tue, 15 Jan 2019 17:05:16 +0000
Message-ID: <20190115170501.10952-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::45) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2832;6:KMAdkSj8kJaunKVRQB9ZhXfblYAyrza4S9ko124O5kEU88lwyGv/WluERr9EEroch5soUKlFT4mgAxTSw90A5cTy/6Z/ONraqzEx9yBIV774qagk3LcChO6q7iIl8HKGz5GZhJk1vdcCfydIjcBgY5eIqhgf7epADNWFQW+Ad8wyYF7N2xFyfBlpmgyOJAwRCNcWQ96J180y+eRntR2p6bKrRiwBqtjVsMWBDSSbm5W4s+6vl++X0dAEY1oc8eMKpOSSelx7LHP+5lT2OuGnzjhGntDCs+P5wFMps3asUt6RTZxEpL6WnmbnsJiv19NlIbni0gHiRJ9/2AiQjd/C3EQnDIle7PccErv4HtPH332zQxJVCoYxCFSglM0WpAwhlrylRYiGMA6Hj7Y2dDc3yvEM8p7Itw9mC3F3lubGNMX6NOS32bPSXuRdCJObvsahR0bCaVmzLGzLw5LQe+FYJg==;5:s+yWCGQ7KEFghG63QTvhlTqjOos7pIHRoAunSUk3ZEc0/MRvphoac1pLoX1htJgT3gMaEdRbHupMOOKKiKEydr9KUhk8DkqB49O49JOqo1pFhQOdoWclVVYqX57WIzgyFPoPiQHHCRV82AHQXtSqXHBjrFzCOt4oAOvMINygXVhG6jrYUog2GUaplJbbNil3LkxKoU3AmjJ2+6EKRyzz7g==;7:tr1ks+eFonyIfBU30XibVfe1tFgokhTyTznzq5wqxsPqZV7NEeVUqE7zSbN/IK+69m2YriZ7wslH7FpuJxvUVT0RaQsvGmWmkLRBJvkgAPlj2gHJp2+SiNVudr4jed/VKBrOWAdcJQ5w5B11yU//Ig==
x-ms-office365-filtering-correlation-id: 9f6acfb8-73f2-4e4d-1348-08d67b0b9f13
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2832;
x-ms-traffictypediagnostic: VI1PR0402MB2832:
x-microsoft-antispam-prvs: <VI1PR0402MB283260CD70DB8A3E8F481234F9810@VI1PR0402MB2832.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(366004)(199004)(189003)(6486002)(26005)(50226002)(36756003)(186003)(1730700003)(81166006)(6436002)(5640700003)(2501003)(52116002)(99286004)(54906003)(5660300001)(6116002)(3846002)(8676002)(316002)(478600001)(71200400001)(2906002)(44832011)(6916009)(71190400001)(68736007)(14454004)(81156014)(256004)(14444005)(102836004)(4744005)(6506007)(386003)(2351001)(486006)(105586002)(106356001)(7736002)(305945005)(86362001)(97736004)(25786009)(8936002)(53936002)(66066001)(1076003)(6512007)(476003)(2616005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2832;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6M0ukLdW+7A+Kbj5nqfqYpFIUoQpL9kXz2Rxcx92eM4AU9CJDRe7sceNaQedo8K5ijqLds+mXmh5G+Xo3P8J36cWILusv+ongyUItem2oFvwkRrksd/vBRhGIeR/PY2Bbb2tbAZ95wmV+A5yxutrEQFV9yjzEoKGTkmulgtBvn6tNG7phqviLqtkcykAkdgs66dmvn8LwvRTqn4km7cjB5xtgB5b/WfPeNmc4qGKBMFWgE3KKUxiqQc8TBDTPWzB6nXjyCbDtxOQmYwePHBZjQZEzHvoBdXMdpu2Xl7K2D05q1d3v+DmWiLPkQkWnAU7VPtO71Ui9gCAWQIatg+pnOTGkyCt4DdJRLCSqHhFm4oKhBG487fZvURaw37QTHEalcsO1pIHG9H6BHWIlAzazfntiaJ6b0D4otXweDdVcGg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6acfb8-73f2-4e4d-1348-08d67b0b9f13
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 17:05:15.8154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MU4_INT correct number is 180, while 179 is for MU3_INT.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
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

