Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17425C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16A521850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DldeMBcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeLSKMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:12:32 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:19480
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728880AbeLSKMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbPw663SWkSPEG6neWUwJKuGb6qo3VBr9Emm3qaOTbc=;
 b=DldeMBcWsfuIjGFqDu2PHmyzlSleugLu1AYUMcZ3RBhnTkhc48aYkTFh5vCbWYBimlfKjmXBX8JSqSbWo6tPd6BvVlC61TlFum6ieiFaxAisfLLIT1bPzcxQ+6Dw1TqNn9ylL7NWjxoWZoVLA6UN0shlGhjh0H+RTFd7pnGjQ3U=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB6096.eurprd04.prod.outlook.com (20.179.25.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Wed, 19 Dec 2018 10:12:26 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 10:12:26 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 7/7] arm64: dts: lx2160a: update fspi node
Thread-Topic: [PATCH 7/7] arm64: dts: lx2160a: update fspi node
Thread-Index: AQHUl4NXteDgsXc590a5AvzNn74rlw==
Date:   Wed, 19 Dec 2018 10:12:26 +0000
Message-ID: <1545214186-16987-8-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6096;6:gKm16CKaHtBfYJBD7ypGnHCnD9EEMlh7cMO6fs2IGE/SLAE3Q4HaPFbVMSd5kNqwmxBwSytKptNgv4yjBNjJm6z80rYXpXdfc+InjFL+GY61c/xh7MuG2nt3iY2GxO1vhEhPQuW1Dhtph8GgL7WAYIAG5DYWRhQypoCdAESj1pobqthtQbxe8kOZ52OaRRPKt9JBAp7MnaEAPeRev7S23dOMMOnr+1f2WnYka8OZD0O8UpPcVXWmys5DPjtU0f69Dz1Y2i3UyzK/ra9PzIGzndWSoZnJ7KpI67gCVo8VFB86iuEmXjoaPYKJZn53kIMlscBtZUFjxxRjjKOTFWmpVfPYQkyEAuPNbxjJhkYeU4JJpQ7YdCC+7cBHRZW3ztKNbyyiODKiGkMm19R3w5F2qOHphft7ejto71rOubel3b1dR+gupI3vH4frwvsNB14GhCcAnGXI/Htp+U/uOFl7IA==;5:Ki1FsH1V1QixpnljTelwl9FeeMTb1yc9EEdfoV86cY3EC02r8dIweAaiiWDI2W1eBtIwwaQBMWvlo5W1a+11B31D89OeIxhnWXVxc0KiteAgCk8WRcCz6ErUaSFHv6XhIA93VFChbaYS7MV7RYrlZOKSsY+5LW2npGskwI777Po=;7:O765m1oHIh6+O5iuIgRHdDTyZD3tStQeoCGpPzcs/p3KX4lppR34Ny9WFqqgA6PjgCzLUkEXLjDxS7DdYtNzjG+MV1CDNIYhiG/y8CkRL/L0rRfgE1M0Rif5iwDO2qdqhsHmWtGz6sOK3+OVtltjUw==
x-ms-office365-filtering-correlation-id: 20da854b-9dde-488a-cab3-08d6659a79ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6096;
x-ms-traffictypediagnostic: VI1PR04MB6096:
x-microsoft-antispam-prvs: <VI1PR04MB6096B99D1C87BC7B171FA9A499BE0@VI1PR04MB6096.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB6096;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB6096;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(366004)(189003)(199004)(52116002)(316002)(6116002)(2906002)(76176011)(5660300001)(256004)(53936002)(305945005)(68736007)(81166006)(6512007)(3846002)(66066001)(7416002)(446003)(2616005)(8676002)(81156014)(11346002)(99286004)(97736004)(476003)(486006)(478600001)(14454004)(8936002)(78486014)(25786009)(36756003)(2501003)(6436002)(2201001)(39060400002)(4326008)(54906003)(6486002)(106356001)(86362001)(105586002)(102836004)(26005)(71190400001)(110136005)(6506007)(7736002)(186003)(386003)(71200400001)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6096;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kiXwM/6Mo1FKUDJFDh6Cvk5IfjucEiqhyrSixs8qjl060T/3Re6PVqjL8hpjr+C3/2ZuZZBRX/iynex3uZ11AUPBm/KfQMuxV+oyKOkpQ2j/bNgH/rw3xlWESGsh41h1dVRJEzT8syHtqxZt8PoOfpl65Ncm89CEgAkg1rLd4zciqtiaT8etpLaHnAaioWBNgVb48hXLiThvhNNztnwZqnjRGFeM54DTuFO038FTRoyvr7m5HJUvGRCRsLZ1Re66ZoUlSdoo0SZUQgCkPCQ4wiPNe1ldhpbxer60hGiz3AWnIpB0i+MPWaEM2Hizfmns
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20da854b-9dde-488a-cab3-08d6659a79ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 10:12:26.4433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flash mt35xu512aba connected to FlexSPI controller supports
1-1-8/1-8-8 protocol.
Added flag spi-rx-bus-width and spi-tx-bus-width with values as
8 and 8 respectively for both flashes connected at CS0 and CS1.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v6:
- Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
Changes for v5:
- None
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

