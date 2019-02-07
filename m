Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313D1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CBA20821
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SvKtK+4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfBGPSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:18:35 -0500
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:27072
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726196AbfBGPSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klx6I+y2UkmCnxKLcyHQVSbXt7SPfe1+b7bxtPwMyUg=;
 b=SvKtK+4pNeqyngGggJa8VooSNL9NmJLIQzTdrHPlClDopGL30wQxEIhPpgUAtaqkhx+FiXB2OZznx+RMAdFBjRUu49TCiD2ZAwHG2LdQUuiq3ysF62B2q7o38kdFL4fgAxwIonEjQfwYNKSHfpCXJz6XpDTD54fnwKH3q1mzjoc=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3813.eurprd04.prod.outlook.com (52.133.29.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 15:18:30 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 15:18:30 +0000
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
Subject: [PATCH 1/4] ARM: dts: imx6qdl-sabresd: add regulator control for
 isl29023 sensor
Thread-Topic: [PATCH 1/4] ARM: dts: imx6qdl-sabresd: add regulator control for
 isl29023 sensor
Thread-Index: AQHUvvhhF2pDAvu18U6xzHG0ktgCdw==
Date:   Thu, 7 Feb 2019 15:18:30 +0000
Message-ID: <1549552397-22798-1-git-send-email-Anson.Huang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3813;6:5KzptwVo92xEp+VQMVpJN6PmI8zCi5hPnKkB9uGWpXZHGuVsyHqXCwi03mbyv24QKEvzjJ533TZ2+/ZR/w+IMwuBDW02d/eB73im/QyOYr5fZAJQSN+ZQKUAhODIFcMjiN1UcXi6aYijwS7W1+n/fZa6jnZYnagpIUyBpcAx7+jy1ccF8FVYEkr+vAuv1LeO5HE1zH8sbVU+ObLxYly2ZFs4k7ckakwb1kLBV2yxRnLHv7lPhWbq+MwptHTyt1bhMvRciUDSy6ywCH1Pvpog49rLaqHMuCpOY06yQJJpHvVl5DMktG9/6GlMpaNKGIXwvky6XeYVaoVrqh93a6nl1ZrrkWK1GvetL+s1sS+HscKWav6/XaoCl71glXwZSzCmjlrAZU6hQbigdfhPrQvCT3vMANTOX0Y3Tm6gALRK38HLf3eF42SYiHxvmPufShSMQaMekAx6NyK3/tctfWMnPA==;5:hNOlxlOWbIDqCPshWY1DvY/gRp0T2rAsGQ0GEjanr8Kc+tH+D7UOmtoz9RAXcjeVtQRu5n572XgPL9vanxypin99wiwUVtZ6GA6PMb6cSwoyhGsw9C7QwYbfMRk2MYe1+8xuX6zXN9tanAPvgXsWuk8JuJTsMoMsQadvveo8qV3Y2Gc/OyWMzVoBDKqsODlTm1c6mRNE4Q36lHCSPIatGA==;7:tkcm9WODjgmX+MA4+c+IBWRsGz4VGwUCSKaPaj46R5iI4NCAcdqmiwliHLsXx8rDeDHThoLX/Oy4g8279WG/Rfjvt1EdxaHlBasOzsNTClXtMF7zetiE0pV6R7AMXL2LEf3o3m27MgTzeg8aCPLpRg==
x-ms-office365-filtering-correlation-id: 5105c8f0-f8ad-44f6-0dbf-08d68d0f83f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3813;
x-ms-traffictypediagnostic: AM6PR0402MB3813:
x-microsoft-antispam-prvs: <AM6PR0402MB3813AACD43B235A0414B4856F5680@AM6PR0402MB3813.eurprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(110136005)(4744005)(486006)(4326008)(25786009)(97736004)(316002)(68736007)(53936002)(2501003)(86362001)(2906002)(6116002)(2201001)(386003)(6506007)(99286004)(6346003)(14454004)(8676002)(6512007)(3846002)(478600001)(106356001)(8936002)(105586002)(186003)(36756003)(81156014)(102836004)(81166006)(256004)(7736002)(52116002)(26005)(6436002)(71200400001)(476003)(2616005)(66066001)(6486002)(71190400001)(50226002)(305945005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3813;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lTuBLYmqYbhJCc3yPpWbS2IeejUHh6C5GGx9ucJMv6Cx65ryaVQaoxRheBBk0qz6R41QSGvaL3iNaBMsY95CypsFi46Cu9GMwruuMZvOZRaOJd2eHN3nlyJ0jKaURKfxcvFvYvMLlK87Zcm+rUVhcCAh00RT5xp33ziDSDgJyPxkOHqLd3FlwaCm79ACryXTYZBDcaEpnZsYy1Uqf+kJEoc3rJphp/fdO18L6kBfS0iMSpbtS+lI14NM5P2YG2mNO4S+jtBvuYR6gnIjVnArW6i5lMSMurw7RwiHB3ENFgbJGM2bNDixX0Qd6JJJo3JnMwC1N4j4x8X8/JIfXjG4AcAAm7tu/4Kcfjv21F0Nc6Fek6CGnRnbRoW6zcY84WxHwapdeDPJkdioMOAY3zx9z3ZyY8/J8Dhzg+CLMzOZ6is=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5105c8f0-f8ad-44f6-0dbf-08d68d0f83f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 15:18:26.5978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3813
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The isl29023 light sensor driver has supported regulator control,
assign the power supply for isl29023 to enable the control.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx=
6qdl-sabresd.dtsi
index 8930aec..21e03b1 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -449,6 +449,7 @@
 		pinctrl-0 =3D <&pinctrl_i2c3_isl29023_int>;
 		interrupt-parent =3D <&gpio3>;
 		interrupts =3D <9 IRQ_TYPE_EDGE_FALLING>;
+		vcc-supply =3D <&reg_sensors>;
 	};
 };
=20
--=20
2.7.4

