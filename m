Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D87C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2072086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eTVBFUYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2072086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbeKGSUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:20:34 -0500
Received: from mail-ve1eur01on0052.outbound.protection.outlook.com ([104.47.1.52]:58663
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbeKGSUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdF8PjdyATr52RuBEZBDE7Xa3GMtA7ly2KVbqIn32Io=;
 b=eTVBFUYzznr/zdpqbvigimT4MN0j4eqWHcaxewJXy69kVtGJsLdzurGFQcd2BsAc72aqR2SVmFjm//4lV9Nbrs7ImG89zlYq6ztUF8H49iF0otBFj8aT/ouWQ36JAIJp9/ZXG9pYUsj34kUFAvaev8L+ypRzCoUahuZ5pwL+JK4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3676.eurprd04.prod.outlook.com (52.134.70.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.33; Wed, 7 Nov 2018 08:51:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 08:51:07 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] ARM: dts: imx6sx: specify proper clock for nodes with dummy
 clock
Thread-Topic: [PATCH] ARM: dts: imx6sx: specify proper clock for nodes with
 dummy clock
Thread-Index: AQHUdncFdNhfbhMjLEys+zHePoZxFQ==
Date:   Wed, 7 Nov 2018 08:51:07 +0000
Message-ID: <1541580363-3968-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3676;6:EprlrLUkGIiNJUPdP2ouBzn9z8BtyMV649UCXxc7qJk89VjODBHGMa1ldrYdTOpr0Rj+k/hRWNggBcxE9MvNqbHu42Z8BJaSuU6J/FLllLUcOwetlLngc7mYmFQZ2lN9UnI4iCBHeGaFfcOhkDtLF9nNj/zMcIZWxDqMLJXXudu20lEnZeiMQIQ7GdAveQOJGpSDDQNOv67nsf529i5kLr8QDswhDalcsyBhXUfx/eoFMpz/OqvAQmzUE3mpPgcBTkhnOhFffvooGsq4aTa41CePhlEOmaMDs639JcyssvWOSFnQSj+Eeda/mizpoDkEqwVywGKNfay6wLSFUKIqQgUb09DsFV//+ML44ul45GG/Zu714gEH1Cc76hDayHcFfZ90UOceqQvzlgtzadhN33AX7NHhtMxjNvk5yW45rCN23ZvhS/SiCRYgz9mqQfRjIBdrq+1Qgv4YV857xSoz7g==;5:k47BUpsDr9C3QV5M1G6K0FOPHvoWqYEgZYvXK0m4Vkl2Eu6RH3lmYaQi2Cao+C2/5cEUHKVsd7fGUK0lLBq9DpSjTl7dlfa4PIDwYXWonnCrxrQolJSCpAHHMb1LmNXqNDdpfFvkrJnr9Iy3md78CYOhHJJ+ZvL8FjKXjJOwlRU=;7:bu6qh1L6CiUjOIMJpaTikKZn/8nGJJFw8NhYq1rIkIcXu6GLNTVrWyBGPKDnJcVlKlJGJgLsvF7l5acOvnzbV7cf7EdocfuUZQp9wu6gboyj2zuwn6CNkhK8/doszkOH8V5HN82HzbQHkBEK7r5Avw==
x-ms-office365-filtering-correlation-id: 75678c6e-bdec-4671-2cef-08d6448e2804
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3676;
x-ms-traffictypediagnostic: DB3PR0402MB3676:
x-microsoft-antispam-prvs: <DB3PR0402MB36765BF7C1559F4915357422F5C40@DB3PR0402MB3676.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231382)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3676;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3676;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(136003)(346002)(199004)(189003)(6512007)(6436002)(316002)(7736002)(102836004)(2616005)(36756003)(386003)(68736007)(486006)(6506007)(2201001)(5660300001)(52116002)(99286004)(53936002)(86362001)(476003)(81166006)(81156014)(6116002)(106356001)(8676002)(2900100001)(8936002)(26005)(105586002)(50226002)(3846002)(4326008)(2906002)(6486002)(305945005)(97736004)(478600001)(1857600001)(2501003)(25786009)(71200400001)(256004)(110136005)(186003)(71190400001)(66066001)(14454004)(14444005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3676;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TS1k+ES3Ci2IGBkqdHmIaF64VX8tTwDdK18+lrIJgFdA0BqR/iKwl8KHCCJjI5VP2C0TOasbQOcz9/IdEIGd9Z6XdEKg4tN+2Dz3v0wkFpMwoxUktCLiu0Qup6RS3J81nDg3jfvM6IHMaIaG9ViKT2N+nq4ggUquD52oeLlHc0S08uqQEKvJxUg+vlWexjSUAq+JxsATLi2FRiAVpB5gCwVSu5M0bmTwz5ruM96MG1WOYqHJrDM7e1FtTjLlxLU3fi2VM9k5mR/g7s6LPiV8ZFCYDotYRdYUFBxUyz8ruMfmEaBfREhxolwdJ5/EfyTUq+d2byQHUxNIDxjgmzOvWp5oKYZAlht3onnZKC0nafU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75678c6e-bdec-4671-2cef-08d6448e2804
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 08:51:07.1598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From i.MX6SX reference manual CCM chapter, KPP and
WDOGn use IPG clock as their clock, specify IPG
clock for KPP and WDOGn instead of DUMMY clock.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 84b7687..07ea7d9 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -558,7 +558,7 @@
 				compatible =3D "fsl,imx6sx-kpp", "fsl,imx21-kpp";
 				reg =3D <0x020b8000 0x4000>;
 				interrupts =3D <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-				clocks =3D <&clks IMX6SX_CLK_DUMMY>;
+				clocks =3D <&clks IMX6SX_CLK_IPG>;
 				status =3D "disabled";
 			};
=20
@@ -566,14 +566,14 @@
 				compatible =3D "fsl,imx6sx-wdt", "fsl,imx21-wdt";
 				reg =3D <0x020bc000 0x4000>;
 				interrupts =3D <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-				clocks =3D <&clks IMX6SX_CLK_DUMMY>;
+				clocks =3D <&clks IMX6SX_CLK_IPG>;
 			};
=20
 			wdog2: wdog@20c0000 {
 				compatible =3D "fsl,imx6sx-wdt", "fsl,imx21-wdt";
 				reg =3D <0x020c0000 0x4000>;
 				interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
-				clocks =3D <&clks IMX6SX_CLK_DUMMY>;
+				clocks =3D <&clks IMX6SX_CLK_IPG>;
 				status =3D "disabled";
 			};
=20
@@ -1270,7 +1270,7 @@
 				compatible =3D "fsl,imx6sx-wdt", "fsl,imx21-wdt";
 				reg =3D <0x02288000 0x4000>;
 				interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				clocks =3D <&clks IMX6SX_CLK_DUMMY>;
+				clocks =3D <&clks IMX6SX_CLK_IPG>;
 				status =3D "disabled";
 			};
=20
--=20
2.7.4

