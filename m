Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF32DC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA6321929
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uDD9vf+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfBGPSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:18:39 -0500
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:38611
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726196AbfBGPSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzLIuFuM+sB6HoVUjnGPQiLwzYYoe1nseqyI2h8+pH8=;
 b=uDD9vf+fYiv+ACX8jMxOAS5POOzieaS8KWREQb1i0cgRGWHdu0YI7aLlNSPFGTDhABeuLGxrTpAjKGqRoDyIqxta5+9wHjMsSwTpVgqfZy6XyLRXrapH04QpAEqXx8j7RY56TXw2LjAAUujMk45T7tQb+/wJLX4z1VKXj7Y30FU=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3813.eurprd04.prod.outlook.com (52.133.29.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 15:18:34 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 15:18:34 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/4] ARM: dts: imx6qdl-sabresd: add regulators control for
 mag3110 sensor
Thread-Topic: [PATCH 2/4] ARM: dts: imx6qdl-sabresd: add regulators control
 for mag3110 sensor
Thread-Index: AQHUvvhkRaIThN50x0O+chgxi0thvQ==
Date:   Thu, 7 Feb 2019 15:18:34 +0000
Message-ID: <1549552397-22798-2-git-send-email-Anson.Huang@nxp.com>
References: <1549552397-22798-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1549552397-22798-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3813;6:LzQnJgS7hXgvuaUuq20Rc9JNG/KxwL+6NBvllYccm/C2ZTqlCloUPA4N7dtKbt5CqwE5sacRKm8UsPo9lv8UoBv9ASKCDPVEbuoztsDQEOONtWT5zPgz5UOUqMRdml5S4Oso0+uNa3zNde+4bBUwsobMOKsF0uuqZRWnJR38GEPmRhjw+YEAhNCH5KN33Nr1Pd18JE5KL16XnukL9A4/nV16ZCO/Vk9VYPuZJbXf/54hHHCJk9DVNoQqOQ25SRZFAOeH5o7AvRKdmN29xtwbBaEJ+S6KMca3JmLbncsieuzi6mqX2YYHHrTJyFNRjal+BDPv4CdDvGenrnVZ+cGlKRJTa2WGIGsY1jHFTxFbTMORjzb3lL51F54/te+nCzmLIB8nDgMKFNPWwQ2u7Vx0BpCNK43nqF+y3cCHAgwA6zhU3MyNm/bca/d+1shpXVQgwQ2xZkZk/rRnIybjGZ6RXQ==;5:fM2NzDEZXnemk85sZaBJS3zsnV+JkXsfE25BSwodWGGUhxy/i2PL3uxLaBIl51BayivxsZoRknDvI3sK7AOIQ/xt0eX67gbzlQGITfMb3fGzqL5K6bDgyFLGmRi1piDj5mMSpB6P+gF1Y1xfnfxHle6B75l1yl+hpcW2ITm2oWugywHmhOWriuC0tTj5APpYw/w4Z+LYi89D4PZMuCVHVQ==;7:xbxWf3Zj1wqxbdkQ1nHAHRNoveOsOPfkQCO2gQaQXi4ka4g//H1iQeyVqgPMqxZV3OuboIkImE/yVfP+x62kBvIzgIs1eQ8WTMsgG/uzFMJfwg6Ljied3NJnEujL4B5m7k8wD/WoodPsPFsE7s/PNw==
x-ms-office365-filtering-correlation-id: df7d0a50-6e52-41d7-6f0a-08d68d0f8668
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3813;
x-ms-traffictypediagnostic: AM6PR0402MB3813:
x-microsoft-antispam-prvs: <AM6PR0402MB3813106CFD3CFF64D854FC75F5680@AM6PR0402MB3813.eurprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(110136005)(4744005)(486006)(4326008)(25786009)(97736004)(316002)(68736007)(53936002)(2501003)(86362001)(2906002)(6116002)(2201001)(386003)(6506007)(99286004)(6346003)(14454004)(8676002)(6512007)(3846002)(478600001)(106356001)(8936002)(105586002)(186003)(36756003)(81156014)(102836004)(81166006)(256004)(76176011)(7736002)(52116002)(26005)(6436002)(71200400001)(476003)(2616005)(66066001)(6486002)(11346002)(71190400001)(446003)(50226002)(305945005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3813;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JDEo3I7hL2rwkWdap14RP9zbcdwhxu/8jjeyq74btJhBK3KTvfZqoPy3CspLDTjV+yEqMnSLgG1Ix1g2zCdXyO/5i/QGLpU0yV1+bQ9XMA0sXhtLZ2Uq4cmUCcC8dv+it1fvOGBbnMK+3bcI2kcpn8NFJWMfBRC+OdtyWI9GDaUMKDglERq0itz+8cc2y7xg3F/MJ/Wgplf21JCRP/3sJ+d+XLhWa8P2H7gecfE4UPXj7Tj+2POarCv7xKimPhjUk8I7pYIXrq9wSenOARWmtSZiTz//iuH9qhi02xXacIsRvxKZRJkNRrF/HNk0rqn+gYv9pHvwAfdCQn9RhepQ0sF+oclozaBC9L1fkUTlSuhJnENar/Zu9XNongE2/KJvBQ0nHK/Dlj6TvV++Z00Qe4qeWelVCzqZb4ZhoyPJQFA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7d0a50-6e52-41d7-6f0a-08d68d0f8668
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 15:18:30.6878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3813
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mag3110 sensor driver has supported regulators control,
assign the power supplies for mag3110 to enable the control.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx=
6qdl-sabresd.dtsi
index 21e03b1..618f186a 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -440,6 +440,8 @@
 		pinctrl-0 =3D <&pinctrl_i2c3_mag3110_int>;
 		interrupt-parent =3D <&gpio3>;
 		interrupts =3D <16 IRQ_TYPE_EDGE_RISING>;
+		vdd-supply =3D <&reg_sensors>;
+		vddio-supply =3D <&reg_sensors>;
 	};
=20
 	light-sensor@44 {
--=20
2.7.4

