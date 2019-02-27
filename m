Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D28C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C2C2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sxnHl+uQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfB0KI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:08:56 -0500
Received: from mail-eopbgr150058.outbound.protection.outlook.com ([40.107.15.58]:55684
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfB0KIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7URCDpbOEgv1UGBmaFgl7byvHxzRHDNILZ8VaVH879g=;
 b=sxnHl+uQg6Ast0YxPMe4T35bRTKRniqk0Sje5LqFFQP7K7WCeGgnoF8eGpqkl3hX/Cx+ecqdo2A6vH8KRI1WIjLzrt7FYUrK1g/ZHAUfVhOi7STK54KtV41V2Y0q88vcDvMEuFkPMM8Zq4mjMhh6q2Raqwrkfy/f6PKm8FChw+A=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3708.eurprd04.prod.outlook.com (52.134.70.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Wed, 27 Feb 2019 10:08:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 10:08:51 +0000
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
Subject: [PATCH 2/2] ARM: dts: imx7ulp: add mmdc support
Thread-Topic: [PATCH 2/2] ARM: dts: imx7ulp: add mmdc support
Thread-Index: AQHUzoRwpxAD4szv5EOGWpqqmiUsgQ==
Date:   Wed, 27 Feb 2019 10:08:51 +0000
Message-ID: <1551261844-23983-2-git-send-email-Anson.Huang@nxp.com>
References: <1551261844-23983-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551261844-23983-1-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 4e7985fb-17c0-4db0-2cf1-08d69c9b9281
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3708;
x-ms-traffictypediagnostic: DB3PR0402MB3708:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3708;23:fUrq8TPuxIuTAaTac3oikk9Mg6fxZclIcLdej?=
 =?iso-8859-1?Q?zZQC2vuTlr3d4GuygcefU2wIxGojEbsitqnIMjNq/1RBmRqH9dKUth6Id5?=
 =?iso-8859-1?Q?9y1E1CRoMOcs5sPNdYyhetc6ONVvodvw1NB9Wa3MU1pH0LNqR239DRG+Mt?=
 =?iso-8859-1?Q?4dQK1YFbXWUuGay3oR8cBkKjPu5QNCR7z7nWc8sfGpx/oyHFMDjtAvhv2s?=
 =?iso-8859-1?Q?Z72CNjO/nLKdxGH94ZPYpnWBSaeO6LN/myyhrJSGJVni71YsnWJ/aARF45?=
 =?iso-8859-1?Q?Qxjvjm3qkqN5sGrzJf6/KxUAAlNt4j8GPJCQQ+O6PslR3ZCQvpyYHUkJE/?=
 =?iso-8859-1?Q?WoZdYxQeEQGrl6A0iqjDmLN6NryBG0uRqEW6s3XAY1PilK+6oH9RSyxCY7?=
 =?iso-8859-1?Q?rgs7SrVNnhVLMlycsvuGqs3BaUKPPuxvh3nz3oJBCJ+5GyA0AjqBorwUzp?=
 =?iso-8859-1?Q?XeatYkfJ2zbVAhogCPOF5FMDgKGqOSWqmZqH+Qj4arzdSspOE0DRjDR7A+?=
 =?iso-8859-1?Q?bxWyGvzalq2Aa6coDa2A/ZSXVbufoObjwZmmVbyVWyGLzdEH7Rdjk8jdIt?=
 =?iso-8859-1?Q?M/9tdu8md8Smcm+ab+hgyYWnYFHHBqdrY7cdZyBwolcZPZvjPzrHnEwPEt?=
 =?iso-8859-1?Q?OElIH/OwOTkC16k06vHy+lDThyItJ35BJip4Ej1/cfs0a1Z2SBJOLDH/UK?=
 =?iso-8859-1?Q?7Qno/a2TkAX8S4Dh4rhwrPXw5UlSB39summ4dV7s64sISzz5gkYCRpECtx?=
 =?iso-8859-1?Q?r9Y9oqGhgFRzoumJ3gWsr7Eestfh1uNwBAbxxjJk4WfiLFFK1EQqd2jzkT?=
 =?iso-8859-1?Q?xPM1DCefEyXUK4l5ISxrImIUuImPcb/v/uCbD05W3/Yg6FGpbWB5+WO59x?=
 =?iso-8859-1?Q?he7MCLadezKBOUsLED6r2MzXRatgHh3NPruVmd9rARaKwrQMzhxSIA3hkV?=
 =?iso-8859-1?Q?WtGG6Mvwh6PDGtRdki0q7j78ZeiXBZj4oqeOJcMt0vVuWxg0nb+WZcDz18?=
 =?iso-8859-1?Q?utS0ZWK5B3SZldt8OEhbPJYcONz8esYlYjRSprNlxM6dJM6v7oXQrpJRfN?=
 =?iso-8859-1?Q?taxbH68bfRHT+BGPmMHS2mejj5eKje3ROrqfPJo84ZJrokfW2NwCFlRHex?=
 =?iso-8859-1?Q?12FtemR7lgkDD1Inc1qH5D2NvtZR3NWED8zkVnwOpQ7/96+Pj2NI5FR03t?=
 =?iso-8859-1?Q?hQ4Zzci+PYmTzYE+ASkEPUbmujp9qk4Yq9sK5cRinASMX5Kc79Qc9h0CGb?=
 =?iso-8859-1?Q?g9zHrAS8Kpr9UaQk4RX8VmeQTb+sVQCjGAremPsM5cXBuO1er9l2ZwXZVn?=
 =?iso-8859-1?Q?MYeQ=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3708814979F05CB9194CF822F5740@DB3PR0402MB3708.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(6512007)(71200400001)(71190400001)(53936002)(8676002)(6436002)(68736007)(316002)(186003)(52116002)(486006)(50226002)(2201001)(105586002)(5660300002)(4744005)(81166006)(81156014)(8936002)(4326008)(106356001)(6486002)(25786009)(86362001)(97736004)(14454004)(305945005)(3846002)(6116002)(7736002)(14444005)(11346002)(6506007)(110136005)(76176011)(386003)(478600001)(26005)(2906002)(102836004)(2501003)(99286004)(446003)(2616005)(256004)(66066001)(36756003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3708;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KLMCPbLFTHuvhUUPjz3yHLpzGN/RE2zMwKPlgsawfrxxsh86iV8yS9QRteP3UAuUZzV1sYzAJWPlLpbvwGseeANmmKp5eqGMtLy5c8VU5bVRyCHXr62mj9x1tfvXPMxdAQfSSiH6ru4WY24fJ2Iu1Bp5prIPZTcr1L3aERCjxfg7GUqTgpx7KPLeyMS8Tg8FN4dSli/MttyBpvyy0SNy8h41Wcm5kE46dwu5lmmlxDTdrWB8oJSa5pWgofNt+nB8ptiobVCxMJ67uNP2JFZU7YCYknFlU+sRYqQXOPSRfqxNmZgEZVD3G9FwO5g8eSmFGAGFAlO9/SkJr4THmigd4I2RqFwEMAhHxSnKBy1QO2qQcU3AH/yzbuG9vZu9dqTNsH6cNzpD3EHR/h2PwsoYD6c/xqWXC7UdMjNr5onn2Gs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7985fb-17c0-4db0-2cf1-08d69c9b9281
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 10:08:47.7783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP has a MMDC module to control DDR, it reuses
i.MX6Q's MMDC module, add support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index fca6e50..fca4a01 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -286,6 +286,12 @@
 			status =3D "disabled";
 		};
=20
+		mmdc: mmdc@40ab0000 {
+			compatible =3D "fsl,imx7ulp-mmdc", "fsl,imx6q-mmdc";
+			reg =3D <0x40ab0000 0x1000>;
+			clocks =3D <&pcc3 IMX7ULP_CLK_MMDC>;
+		};
+
 		iomuxc1: pinctrl@40ac0000 {
 			compatible =3D "fsl,imx7ulp-iomuxc1";
 			reg =3D <0x40ac0000 0x1000>;
--=20
2.7.4

