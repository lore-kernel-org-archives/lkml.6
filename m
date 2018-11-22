Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAA5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C71320820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XJ9NOVzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C71320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404587AbeKVPww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:52:52 -0500
Received: from mail-eopbgr20076.outbound.protection.outlook.com ([40.107.2.76]:37632
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392215AbeKVPww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdvvLPq7cPVFANa4Why9qGDsUoiMNrIwZ/JtRskiQEc=;
 b=XJ9NOVzdVWcgQBUS7rYlgzZOhEWOhkzgGnrtNkxt94fZZHtg6sEc8377D7HLy951yMVJRseEqm2VN213l/sZZlaK0ZuyJiexZh8/nmUIW7VyEUbBilbmrhOLwerU1wZq0kWaaCyHBu5IDcWoY7HZ9DB6KMQa9EqnN/TncFGY1m8=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3055.eurprd04.prod.outlook.com (10.170.228.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 05:15:06 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%3]) with mapi id 15.20.1361.016; Thu, 22 Nov 2018
 05:15:06 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v4 7/7] arm64: dts: lx2160a: update fspi node
Thread-Topic: [PATCH v4 7/7] arm64: dts: lx2160a: update fspi node
Thread-Index: AQHUgiJUXC1eycPwL0i53LplGbKuaQ==
Date:   Thu, 22 Nov 2018 05:15:06 +0000
Message-ID: <1542863544-21257-8-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR01CA0106.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::32) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3055;6:cq43ovNDsoqXxp1cbvy58+weHkXaJWIojMcmXj5CAaze3UyjFB83e79wjCYrpaORvrfQhc9qE+E0Ki+Bsr4B1E5NKndv2DMgVz8YlBFaUDuzedO9v0+lqS6kKOLhUxDC1SikU3tfY8Bce0CWxD36sqcGXmRsvEQrdWa+Xr7zrGDELNmnGt7LYbTe9Pgdk8D5gSHdIGdDR29vxRvFGt/ejzxWwozWo8MEadoAEXVfz97naIdKyQKVzxpzu4oGVku16yn6oihk/3W3fp7IS8KKq1whVXRnQVRP820pfzXuh9fkiI0S87PM8TxMKDtNJXzb+oMpOs0RjRBYvgpvOLMhJBYMSDcQzJ2+4/SPwNIBOHa5ooBFZGHqwM/FG2ckLHdcqurqWAPQjUk5PJyKcTgA0UFuyhs7gKeFz1GwWVropDlFE+ex+Har/cOiHrptIUxd0/IusoeufjELoQwH/ewHwg==;5:wYNOQDWqMMp0Wbu0sMWac9wpvdoqC8k8Iro5N8TI4NT1ojz+xaZQL4XfldDjokrRLRY73GnJqOX7W8Ohyyuun6pIYuMt7HoKoLpV/cG3SSCZR0z4pMDzXr7tQPWmx1r1SErZUIO4TTp6O9l/re9zcGMrU/KDq0yXu5/mM2BddXU=;7:cp2ZNFBQycpqOIreC1TiJJ5nej2uzFraJgAfxe2n8YMZ4JL0uOZPE08gAp7DA8FfsplD+l/zBCHhSZAKgc2WoucksuLijrDnPgYMp6Drate4K/BAuBLW0TMhdWQPGUPiuoFABhZyqy+//U3K+tqWpQ==
x-ms-office365-filtering-correlation-id: 71fe3128-614c-499e-85b8-08d650397704
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3055;
x-ms-traffictypediagnostic: VI1PR04MB3055:
x-microsoft-antispam-prvs: <VI1PR04MB3055837184899CEB44986CBD99DB0@VI1PR04MB3055.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3055;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3055;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(8936002)(25786009)(105586002)(316002)(2906002)(106356001)(52116002)(76176011)(4326008)(14454004)(6436002)(6512007)(6486002)(53936002)(39060400002)(68736007)(2616005)(476003)(486006)(99286004)(478600001)(11346002)(446003)(36756003)(102836004)(54906003)(71190400001)(71200400001)(386003)(6506007)(66066001)(6116002)(3846002)(110136005)(26005)(256004)(186003)(5660300001)(55236004)(81156014)(78486014)(97736004)(2900100001)(81166006)(8676002)(2201001)(2501003)(305945005)(86362001)(7736002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3055;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L95/OZvekS7WJ1YLCfRbVF7nEbTqHkC77dkamJ2sfNufVaVKRq749e3jkYEoa7RfFy8Gwb1iDFqsn+M8YF/QIn0wqijAAYgc45daSoH9xk7Z2MvH61Wfw5/PAiIjw2bz442VciCQ4B/4ioQiELQGqmLueLGdZDlMuMT6FM2rEFcprpncWPC2AdC0mgBQI+TBNLQa0yR7Uv5sPAvkGFAqmOdItOxBwQ3HwMYpj7uZvbaa1HdJwLjcsHwceEOKiiXdIgGrvKeoWRN1TPaz7zo4ZWhJBIaOliTtUo3CgjcWAHeriBrTIvxINyUAZuUoZpLGHH1WtUJnZjZaPTugq0LhHcKogTTW4S3luIWPJr8YIF4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fe3128-614c-499e-85b8-08d650397704
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 05:15:06.3240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flash mt35xu512aba connected to FlexSPI controller supports
1-1-8/1-8-8 protocol.
Added flag spi-rx-bus-width and spi-tx-bus-width with values as
8 and 8 respectively for both flashes connected at CS0 and CS1.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 3b20c97..24cc41c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -45,6 +45,8 @@
 		m25p,fast-read;
 		spi-max-frequency =3D <20000000>;
 		reg =3D <0>;
+		spi-rx-bus-width =3D <8>;
+		spi-tx-bus-width =3D <8>;
 	};
=20
 	mt35xu512aba1: flash@1 {
@@ -54,6 +56,8 @@
 		m25p,fast-read;
 		spi-max-frequency =3D <20000000>;
 		reg =3D <1>;
+		spi-rx-bus-width =3D <8>;
+		spi-tx-bus-width =3D <8>;
 	};
 };
=20
--=20
2.7.4

