Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635A6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2828321741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r5XJ+n39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbeLTI4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:56:40 -0500
Received: from mail-eopbgr130049.outbound.protection.outlook.com ([40.107.13.49]:8248
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729276AbeLTI4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVe59oMEYCVIZAEYrYBWm42C89ihNUZkQpZ+b6B6SO4=;
 b=r5XJ+n39Ls/SDvz/V6fNNk+BCtet82B1m+RFZ+O0H4LD4m+lYEXFAmHpH5sbFws/gmyR328E5FJvUsFm/+idWPygoNvdtFlB0skRyihE/zo7dL8/Wyf4ZCE22AdXkIk55AUO2ro/gyu9FAovV9lbU1I/7kEpKrBeo4LymAYRqMs=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3621.eurprd04.prod.outlook.com (52.133.20.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Thu, 20 Dec 2018 08:56:34 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71%2]) with mapi id 15.20.1425.025; Thu, 20 Dec 2018
 08:56:34 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
Thread-Topic: [PATCH V5 4/4] ARM64: dts: imx: add i.MX8QXP system controller
 RTC support
Thread-Index: AQHUmEHo/auk+mfKDUO8s4DTm6ISsg==
Date:   Thu, 20 Dec 2018 08:56:33 +0000
Message-ID: <1545295872-20169-5-git-send-email-Anson.Huang@nxp.com>
References: <1545295872-20169-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545295872-20169-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:202::31) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3621;6:eHY60iTUFncGOBHabuvoJNOnj+t2S+BniFasp1LrbfoyGaJuKXcPPzMxiHxDCDRAe7j9LXBFLL5PhVHctYQyr3oLNQOmTXdU4x28XvoBj3bmR6VcppynTxppMgeGxD4u2GMKa+wWKIZkvz2vCihBVJ08VQWUaFRsLrx3EdL2nxFNS9lDiePhruM699V/O6cJ0gdsDRvDvUf+hzY178MVLgQUBBUDTbYkwDelcr8BgC4zoQOgOH8WyhrCEga5/DAr99vLeG3diAw9SYKnDeFNxG4iYEqtU9VPwi8RG12C4t6Qu1KuRzR+e+We8YbjFrPqupk8S9SkaALB9lSoJWmYLrIYqXjQGSONYiWg8v+3TpiIbw+GagqYNlfwr5IMar4DXEIG5SG7jTnc4YmtyP3vEgGAw+qx/uIzGkK0AOBd3FT42SrXRTeNtip7v9xn1vFeQiNxlP5mFHVwuWSks+eAIA==;5:ayeVIWfF73aY1fwaQo7lHe2l/cFTrGOEF3hILhaFjjcQMvI0B1cs9N7wf5Z0h5JkKjM3h1pCJsZiw8GXvSeRoiuj3zgLdiGXC9IvJiWxLjD5SB0EFO5+e4QQEewLnBvV+hu/JVUJIMfMjYs8mZ0OelYH49obSOujmFLFhEiDtOk=;7:/NHK89YfiyfOj7fH+FRSTqGhcnWOIrIVuFm6u9UhBV68gK0vpVW6KiL9Jv0Q+CQYkFlrtt3iL7Fqiu8GA8egKL+bYA7ga7r4dzppAHZOI2FTtfqt+44vG95dw/jjLuARMRwqIgG0inBarl2auVHnmg==
x-ms-office365-filtering-correlation-id: 1be93a77-378e-4690-3d2c-08d666590a87
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3621;
x-ms-traffictypediagnostic: AM6PR0402MB3621:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB36210340B1E9400D88D82FA9F5BF0@AM6PR0402MB3621.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3621;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3621;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(11346002)(68736007)(8676002)(305945005)(97736004)(256004)(52116002)(6506007)(14454004)(25786009)(4326008)(316002)(6436002)(386003)(105586002)(7736002)(6486002)(106356001)(81166006)(81156014)(2906002)(7416002)(53936002)(36756003)(6116002)(86362001)(3846002)(71190400001)(2616005)(50226002)(186003)(71200400001)(476003)(8936002)(2501003)(26005)(6512007)(2201001)(478600001)(486006)(5660300001)(110136005)(66066001)(102836004)(446003)(99286004)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3621;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qBSpuU7xutTJK3qWtbTapTEf7UINsMItnsZGVz8Tu0jSidlIifbtDBXqBh81YHeX6V4F/NEwpOKAW8bMKz3rNOo1xXj0Kx8vrHVQSNXHSwDEyOv7x9FUX3IyknumClJ/vhHb/8qHx/7oWCJONwDfWd2bIyOjyR4qgBDdvl7Kk8Ng4pKqNNjhpNFqRFbHi9Oda/OycSVI9w+4i8Ax/SDCiDLfLAwEIUNVSMuo5V9qDL9gKbEc/5McgSoqBVsasiYqzk2U4ddXVUVP01W0RDzQ9iHswvQIK6v0M28yu3kp4zFwMFih/YMRCVPoAZLNa8zw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be93a77-378e-4690-3d2c-08d666590a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 08:56:33.9535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3621
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP system controller RTC support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change since V4.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index da99b6f..9b08688 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -83,6 +83,10 @@
 			compatible =3D "fsl,imx8qxp-scu-pd";
 			#power-domain-cells =3D <1>;
 		};
+
+		rtc: rtc {
+			compatible =3D "fsl,imx8qxp-sc-rtc";
+		};
 	};
=20
 	adma_subsys: bus@59000000 {
--=20
2.7.4

