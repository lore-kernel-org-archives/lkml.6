Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DD1C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561B5218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tlX/7CXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfBRCCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:02:07 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:55457
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728206AbfBRCCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiGaM5YKyHD5ZZNwpj8ttfuA8x55jKBMPFvp8LNvpag=;
 b=tlX/7CXuC8XW/c/D4Hqyu0mbVQlYBqX953vWmmzKFfQBoLoVYusQafnpqi+UnFin76mZS69NfPsfMmMveu68JQNsp1tgsoh6UQpunErR9Pa9xfh3Y5xHgzPDmYv/hW9liQiIDtwYPF34iiTC9Wn2Ube1bIqNCpliPkKQeCE2LFM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3900.eurprd04.prod.outlook.com (52.134.71.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Mon, 18 Feb 2019 02:01:37 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Mon, 18 Feb 2019
 02:01:37 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 3/4] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Topic: [PATCH V2 3/4] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Index: AQHUxy3hUWZIuz2mrE2cLc3JYu3FGA==
Date:   Mon, 18 Feb 2019 02:01:37 +0000
Message-ID: <1550454997-4398-4-git-send-email-Anson.Huang@nxp.com>
References: <1550454997-4398-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550454997-4398-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7826d84-bb62-4a21-7d03-08d6954503f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3900;
x-ms-traffictypediagnostic: DB3PR0402MB3900:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3900;23:Kv2oF+VBsO3wLoNW0zQDoNMM/KHtUoly+MP2p?=
 =?iso-8859-1?Q?yAe+WQkrKB3akRhGe+rCbzMCv5rOQPozoRpy7FwzW025rssdqBoW3ltOZZ?=
 =?iso-8859-1?Q?xgcBuonsv9pCU0YhIvQvAP7jq06IAy3ZWz+2OaxPr7ltCkYmNKn9M53b3Q?=
 =?iso-8859-1?Q?V4ZKpkNa+t1YSdNJ18vudDOuXwECjWtQSp2WtjOxpy77Oyr1181leTqX40?=
 =?iso-8859-1?Q?rI972L26HCxlOVs0eQsijDVYgByMc5sKwck8nLYuQG09ZjrHZMOTWRCmWS?=
 =?iso-8859-1?Q?RCsJr7CyzZbcnMsKVivlVs8UzIV/yqE9d1+jjIaCwoJhTYj9ZuFAJPWZ1+?=
 =?iso-8859-1?Q?xLcpcCeuGzPBnnDRjabNwb3DKWCo+QjVheGF+bS1LEnlmnPOBJCxvcJtU1?=
 =?iso-8859-1?Q?dmJmClkJ+hFDpHk+ARz8Ip6g9ouxkZ8oVEbwiGINmwpFaBObNDmhfUPKNy?=
 =?iso-8859-1?Q?XUs2ReWk8ZEe8qeOpZ1vtDymM5qvy+5/DGaxIEmV2o1+M1tFNUCrY2Za20?=
 =?iso-8859-1?Q?OdPh8y4jqQ+mVxmthJ1Tq8aOwyD/jW6ktuDVXuak6yL68GHwiGEXsZoWjW?=
 =?iso-8859-1?Q?OH2AWICbMkkTv+qHQOkNQ8Tc2qQhGoI8srMUCD8e4Q+DryNVkA6VZBN3cD?=
 =?iso-8859-1?Q?90qOSOUtm2oz4lwO1t60bHwgEBDH1x6PCZ+02mE6KC9bkdx5wEO1+nnLjI?=
 =?iso-8859-1?Q?GhU+eH64YCJ4gKAR4PK1IowAohYtAekShwmNgp+PSrr4Cyj/6srgxrwtwq?=
 =?iso-8859-1?Q?x2cjvc475UQJfnYOM9J2DkfOh78x5MviJwajw72Xmmh60duWPx0M4Qsz7v?=
 =?iso-8859-1?Q?eilte0bQ9hexkqLOhrwQxZWmjbBPwGOZk25gMzSZa613QiqTKBg1rnz+dS?=
 =?iso-8859-1?Q?rH9Chc3O8M6Bf6uVN0vLnC9O7Ouwhs02mmjxAglaztOYwUz/vghtLBbhG5?=
 =?iso-8859-1?Q?ctOdHXNuuimaagkFj+I8AZfi+aag2UE2ENyk1V8TQONdKNgQGVky39kKEG?=
 =?iso-8859-1?Q?cvIJYphr7EUVdEB+lRifaufmB892dUGKxr3SjhzvJ7Qd+2yKdcPl6uI4+W?=
 =?iso-8859-1?Q?n+SUNGjLLkuR6MPUjgpnIOfn66PpBMMYEE3nUNXMk7Uvk7+keJncYECzhw?=
 =?iso-8859-1?Q?XVHEbUQwkSgNwiw3TmcohDI2U81ik/x2MDkybVMdpq+cAr0abu97NDlOxH?=
 =?iso-8859-1?Q?5I/iA+v+zq6rYM807k67QldjX2R87NkfK4VLeQgR/6Tmo4AobclQU0ekpU?=
 =?iso-8859-1?Q?QxP1Hj5TODwnQFbKxKNSnrKGWm1RfEdlS1OACBTwdmfArMRIaKde+fr6jD?=
 =?iso-8859-1?Q?hv7c=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3900E7109BC3747754E687B2F5630@DB3PR0402MB3900.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(7416002)(66066001)(81166006)(81156014)(8676002)(446003)(6512007)(11346002)(25786009)(3846002)(2501003)(8936002)(476003)(6116002)(2616005)(50226002)(68736007)(14454004)(478600001)(2906002)(2201001)(105586002)(6486002)(106356001)(110136005)(71190400001)(186003)(52116002)(76176011)(5660300002)(6436002)(36756003)(486006)(256004)(386003)(26005)(71200400001)(102836004)(99286004)(7736002)(53936002)(4326008)(305945005)(97736004)(86362001)(316002)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3900;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UN61+SYR4Aq1PIADjt8vjUUgRsAYumUBtRChGuKI0Sk67tUMJlvPlua/ol6HX3HVFj6i7gI3tqUX3of7iAJ1jqXzC5g2nySrIXRwAZXksvxhvClI6fB/yXzCUFXqUllGE/BkynuGq47tLOc6P66sfQfFGBCTULPa9XPXyzIsqls1J7x/LiYOfKRqKg3fsv1zOyig5nEqrF9xmWY0wA0sBmRnPPNI/sMdJbFG6hHdmPJ61HtxZ/lRUIS7yt1isz3RBJQ68yj9i/zxLoSudWQiOxW+a9Aj6uCl4L4t+1MnnV/LqpbVfNRgAuypbqOh9Kjy9hkl3APCw086IeWsoUYZfL0fZOAInzxA76C2OHnao5YAYCS+J3Y9qcJpaOxAa8RzaECq4BFcuv1BHrS0Db7X45AsGu2ruQ90oLJPeUU8LIc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7826d84-bb62-4a21-7d03-08d6954503f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 02:01:28.8980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_IMX_SC_WDT as module to support i.MX system
controller watchdog.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c390..690f4ba 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -427,6 +427,7 @@ CONFIG_WATCHDOG=3Dy
 CONFIG_ARM_SP805_WATCHDOG=3Dy
 CONFIG_S3C2410_WATCHDOG=3Dy
 CONFIG_IMX2_WDT=3Dy
+CONFIG_IMX_SC_WDT=3Dm
 CONFIG_MESON_GXBB_WATCHDOG=3Dm
 CONFIG_MESON_WATCHDOG=3Dm
 CONFIG_RENESAS_WDT=3Dy
--=20
2.7.4

