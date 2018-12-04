Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C5EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18A6206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jg9fcaVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18A6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeLDQdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:33:13 -0500
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:53892
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbeLDQdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84xX7OyGt8G9MUx2p/0glsaQCK6IA1bHj4cpO3Q8sxw=;
 b=Jg9fcaVDdeSIzTtZOEEVlw3gkOQy2mF5LA71QvoFNEfY/UOndU+VYic/dF9+S77m+mKy5Y87Cclx1/GDzbXUKxhJ6XVAOJveP1ZJnBUb5dtqfYeZDqklRE3Dnkfdf1XT+rAJC8ZAKe6KY/GGQ2Jx83MP30c8hhh5aO51ps/Zj4E=
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com (20.177.40.15) by
 AM0PR04MB4035.eurprd04.prod.outlook.com (52.134.125.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Tue, 4 Dec 2018 16:33:07 +0000
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2]) by AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2%4]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 16:33:07 +0000
From:   Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] arm64: dts: ls1088a: Add missing dma-ranges property
Thread-Topic: [PATCH 2/2] arm64: dts: ls1088a: Add missing dma-ranges property
Thread-Index: AQHUi+8Jlx886xNNzUavMi//28za+A==
Date:   Tue, 4 Dec 2018 16:33:07 +0000
Message-ID: <1543941180-5147-2-git-send-email-ruxandra.radulescu@nxp.com>
References: <1543941180-5147-1-git-send-email-ruxandra.radulescu@nxp.com>
In-Reply-To: <1543941180-5147-1-git-send-email-ruxandra.radulescu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0002.eurprd05.prod.outlook.com
 (2603:10a6:803:1::15) To AM0PR04MB4994.eurprd04.prod.outlook.com
 (2603:10a6:208:c7::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4035;6:vyHEi9xc4seo/E6Sz0SbOnh0CY7lg2KK/6OurB24in1Cdh9XF3PQmSrJ/z5vG6XU8Jc8HiFxPLd8WQXatvSe6h5++nUlGtC6uT6LvLiImbfRF4JYwbcxSCQAOFDM7SQXoOHKTVM/n5gGOfrBl/n6pkT0z6p9nmPNrhb6JIle+SaMsgbgs9aCSKvc27i2181RqNQaI0uWuT50rfjmOaGwEqf7P0PovCUiOIV2RrNimvWE2/R9P2JfIjJjtQIXMuFJcFTOGzWpb1tptRO/Jww92BvT+9WDMNZVwkgToqfXOhafaQ5cTkGFzTE+9Mu38u7pcRtB48PnVgAvdozAysS9vSKlg6taW5DEyIsGJ9ZR6Pv9HsWwGqtYbbqjniMbePQ7yP4LcN3H8V2xAslcb4IfvifOSKMNjrRHvpUztS/u/ddJLihnkmU1Im6VWHG1bRqllq0qZJHHEqrWl20Fi0aAfg==;5:o3bXrmrUnfXh3ajVjAA5MchA1ZbkZ4AXVRPcIgGPExV0jZmpvAlAKtCGMNnExk1AKm4ZK3OZ/OMZjfMDd3b5aFeRWmI+OCgn1nwIMZyojnOMAiKGCdC2Ehq2LR0BBSb8D/LV9hOZlEj0Xkk+rF/2lOS7Tz3J1v9ZvsycN5ZzpgU=;7:0C4tlzNhePf8FGL4M+OOMkyacg9iuHoSm0azXf3miDeKseCJdvFudZX0hJ/rdnI9+5/a+AXwYqB0Tr0/jM7wKRo+FumXZmKjhSLK+rU+YRtCVRYmtnjq468sPN5G8Vrv+mUt4U31hM0zgZrhhzdk9g==
x-ms-office365-filtering-correlation-id: 3bc40c9d-6c53-4830-f00c-08d65a062ba7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4035;
x-ms-traffictypediagnostic: AM0PR04MB4035:
x-microsoft-antispam-prvs: <AM0PR04MB40352DDE720A77A2452B71E294AF0@AM0PR04MB4035.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4035;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4035;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(366004)(189003)(199004)(6916009)(6486002)(53936002)(71190400001)(6436002)(14454004)(71200400001)(6512007)(256004)(86362001)(478600001)(97736004)(25786009)(2501003)(36756003)(446003)(5660300001)(476003)(11346002)(6506007)(2616005)(102836004)(66066001)(186003)(386003)(305945005)(26005)(81156014)(8936002)(68736007)(4326008)(316002)(7736002)(81166006)(8676002)(54906003)(52116002)(1730700003)(2906002)(2351001)(5640700003)(106356001)(99286004)(6116002)(76176011)(3846002)(486006)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4035;H:AM0PR04MB4994.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DGQ3HtpsoDsBBZB0+rUiRJDQ9rPr7QTUy0OEZXdpO+ubZTLxxMQ3+3/vecLmXzkAXtlvNOrXVYakpb9jCHPRunLzZGCbpDiDq9mL1F3Le8VKKPICML3Hfymxhv75Z0TXgGOdwVMl0Qf+8TDkuYunXM9MLP+GA9oh9EFsVRIYiJyVpTsrPKltLY1HsynmVdlFSeuLHS09gKlBfhvpC3fXiDYjCdpg6PSUKkifHEZnj9TRZFpQJSrCW1Nn/dDJ1Gv5ZHWsMFCG71vnO6EGp1otH4OWD4+5FOZhg20pJEisNj+FzZMf7fI7uP0gJLBh54NREJYKaHhVd1KSNbCAtnpw/cVyfHN5HLOEzJf5/ZpgYew=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc40c9d-6c53-4830-f00c-08d65a062ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 16:33:07.1983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS1088A has a 48-bit address size so make sure that the
dma-ranges property reflects this.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1088a.dtsi
index ba5ce73..e73e55f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -191,6 +191,7 @@
 		#address-cells =3D <2>;
 		#size-cells =3D <2>;
 		ranges;
+		dma-ranges =3D <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
=20
 		clockgen: clocking@1300000 {
 			compatible =3D "fsl,ls1088a-clockgen";
--=20
2.7.4

