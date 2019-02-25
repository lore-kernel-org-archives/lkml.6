Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE877C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932D220663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gcAE05Bd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfBYNTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:19:09 -0500
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:60803
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727011AbfBYNTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Znr2T6ovlH7mTq+u1NnPVFs5YNm/YXTxwScDcqrMY/A=;
 b=gcAE05BdfLVFfysgD5hqHR3+eoqIrhQylss3Ug6q+o9/NcDdcJrf5q9aiPiSpfpZXlR6uWAV4on5gHumIY4CF6rXA/KmdpRYPgfAK+FedkyD5jZ4JUVaNk3ahAb9dqwDM0/ui5FuP8USDSY8/1wZeUzBRuNJ3o6Ha2MUolgyQu0=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2895.eurprd04.prod.outlook.com (10.175.24.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 13:17:50 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:17:50 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 5/5] arm64: dts: imx8qm: Enable wm8524 codec
Thread-Topic: [PATCH 5/5] arm64: dts: imx8qm: Enable wm8524 codec
Thread-Index: AQHUzQyBsy8AZ7sdeEG8XBzoxNlyKg==
Date:   Mon, 25 Feb 2019 13:17:50 +0000
Message-ID: <20190225131722.10253-5-daniel.baluta@nxp.com>
References: <20190225131722.10253-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225131722.10253-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0202.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::32) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d5f5307-d481-4858-de86-08d69b23a436
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2895;
x-ms-traffictypediagnostic: VI1PR0402MB2895:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB2895;23:TpL9OvmsVO95Gtd9zRFm1j+LW4Q9sGt3ZG+nn?=
 =?iso-8859-1?Q?uY1M2q+nrFM9Kasg/SC5jMvAON9Rn2SLx9SgxbjhGLpmYUsVaRtCFnF5qP?=
 =?iso-8859-1?Q?mOVynIu8i/AnZRyG1ETmJOaUeM4kgjne+RkrxgrygweDK57ei0yq43UDgX?=
 =?iso-8859-1?Q?IrND9kV4dfzWBL+JZQEIyDoc2cv0V6wffEu6K+A9BhiQ3dOscWvJHcbJY6?=
 =?iso-8859-1?Q?WUXaIWHb5im0vYDUNB8Pnpu+hL5NPO6eJMGnSzbGa1aZmFcLPFfgoA/NVg?=
 =?iso-8859-1?Q?31U+cviKNB2Huft7R10sPOD9p+FGsGfc8wO3Sp+qoc/rWp5mppaJfyTXqB?=
 =?iso-8859-1?Q?goibqTa9vNO0p6R7tvPpYMetJr1R2wKGdvOKgg8tIU0LS5AYne8KVMAwx2?=
 =?iso-8859-1?Q?3qMGvKYWOQzZTP9VvKurYdJIkjFVfY6mzVrtctZNLxFv4hz3qi2iGEAVUq?=
 =?iso-8859-1?Q?XFw3HGM281MKLM3V59+2kz0OKCvtIBxntAanbSeUm5aE60Mbvl8LdzN9bi?=
 =?iso-8859-1?Q?/SbJfMq+/CUmQsgRuB37OJn2TrwjT0mZqvE4zoobJ9GhBI+CyWoo/4mi5g?=
 =?iso-8859-1?Q?RRMpgkblQvg0HlWNt+iWqNsVudmH0mRVxY8E11hgd6/Nn4MSZwYyO2kY2R?=
 =?iso-8859-1?Q?1Vr3BsXyXs0kBcNXSjOr4DyJB3zljNhDF6YxDkrWcWBhwGXLC1TciWdUwJ?=
 =?iso-8859-1?Q?lamSiROX8NkPII3Kut2NN8xDMlW+Tc4MmPtPxWmgX+8weyItWe1vxAtRaH?=
 =?iso-8859-1?Q?vPgeXSJqvYMZfmCAga36iP6DtbWYD/euwVyoA9t2APGdgIjgp3EdowqMv/?=
 =?iso-8859-1?Q?96mzymYFIj4nfO5oGFXuT6XYVy6tftF54OO+zjlJ1E7EF8Y0elHixRRien?=
 =?iso-8859-1?Q?bXNFPaqty1m6qRdd8e8iq6KiWloKL9GSFtc62yb9EnL8ZCpeWUoDA8LV2s?=
 =?iso-8859-1?Q?HmIaP4c4QG3V/RaKrjpneM2u/CjTpyNU8Uq+F0bzfQ5Sm7BIYjCoZkBzZM?=
 =?iso-8859-1?Q?LIVqbAHDVAzH63Eq3NHzNk7zIWMbV8W9EZHm0t5Cn5CkVI0Au/XD7qH/un?=
 =?iso-8859-1?Q?nODazuokACfwcZhFY90QiIqZBDNhPPTeoLNk1tmhcbePQm3Ezjc2wVVPUz?=
 =?iso-8859-1?Q?BRl6wUdgWgayeoGa/9YB+g7idToH2CnA1YDUzL5b8TUMUSFFtiVsFZdAEG?=
 =?iso-8859-1?Q?sCD7xH/+gs/8bUkVojiku0frJwh8FqF8Dkl7l6dGThrbjG+K/GbD4RXzVk?=
 =?iso-8859-1?Q?n63IiUfyU/VlgbFEzFrgY7UwZX6VoUl0AJwNxw2e2z9xvN3K98K93ydd8r?=
 =?iso-8859-1?Q?Po9jU1KUkEjDqlutqzJrWTOSx0bJ9XGMGKkbFDRd5ypCc8J6NHyUtKXs4f?=
 =?iso-8859-1?Q?U0hCuXM3U/xj1KohQ3PUwFBtsy6QGWWCUe3qm00+2GTnTCb8oQ4VA=3D?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB28951A7BF75A784FE9889E86F97A0@VI1PR0402MB2895.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(8676002)(81166006)(1730700003)(2351001)(81156014)(446003)(6486002)(6116002)(3846002)(2616005)(476003)(186003)(44832011)(36756003)(305945005)(11346002)(486006)(7736002)(7416002)(106356001)(26005)(105586002)(14454004)(5640700003)(4326008)(6916009)(25786009)(256004)(6512007)(97736004)(50226002)(2906002)(478600001)(386003)(8936002)(54906003)(102836004)(66066001)(71190400001)(71200400001)(316002)(1076003)(68736007)(6436002)(86362001)(99286004)(6506007)(5660300002)(76176011)(52116002)(53936002)(2501003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2895;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lZM36OmWPmyqNCkEZVtmyca0IeCK05VMDaH08Ah9AX00HLP+/CtMjN3fX2RXe/WtAroKsvWbb3QM8epoV4b2tHuCChuVOB8Due13CsCI7eSCzylJlL4rOX1Q1WNXa/Hzkd13jjEP6igrK2yJbjVEwVUrP9nYfAqJBfYe+kql6MHI86HPTKKGwI4WUklwlaVkZ8Bx5JbKfmjet4g2dKSaoTp/LcpPvMI50VcJuEXV8itcX33y0KwHzcPvTx7vQFx9XroFe33PK7k2hfTbiPD52jvK82LAk9eqvOS20924DD5G3sJrvZLy8UEJXRv12qf95FqCBSlY5pW4KcgnKrs9iB150dE8gYY1/WLeVQnQjF6DZyBKkEoJDkGa15FkO79u1osj9H8tFzGHE8/H7UhDNZkPyPv41Z5kegIXj3a4fAg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5f5307-d481-4858-de86-08d69b23a436
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:17:49.3158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses simple-audio-card machine driver adding 1 CPU DAI
and 1 Codec DAI.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
index 58de4a3d6029..77f590c13ee0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -31,6 +31,35 @@
 		gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	wm8524: audio-codec-0 {
+		#sound-dai-cells =3D <0>;
+		compatible =3D "wlf,wm8524";
+		clocks =3D <&clk IMX8MQ_CLK_SAI2_ROOT>;
+		clock-names =3D "mclk";
+		wlf,mute-gpios =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
+	};
+
+	sound-wm8524 {
+		compatible =3D "simple-audio-card";
+		simple-audio-card,name =3D "wm8524-audio";
+		simple-audio-card,format =3D "i2s";
+		simple-audio-card,frame-master =3D <&cpudai>;
+		simple-audio-card,bitclock-master =3D <&cpudai>;
+		simple-audio-card,widgets =3D
+			"Line", "Left Line Out Jack",
+			"Line", "Right Line Out Jack";
+		simple-audio-card,routing =3D
+			"Left Line Out Jack", "LINEVOUTL",
+			"Right Line Out Jack", "LINEVOUTR";
+		cpudai: simple-audio-card,cpu {
+			sound-dai =3D <&sai2>;
+		};
+		link_codec: simple-audio-card,codec {
+			sound-dai =3D <&wm8524>;
+			clocks =3D <&clk IMX8MQ_CLK_SAI2_ROOT>;
+		};
+	};
 };
=20
 &fec1 {
--=20
2.17.1

