Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC581C7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D806207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="utNpO6ou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D806207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeJWRTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:19:32 -0400
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:59456
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728331AbeJWRTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkdDdalyCbajzTiDmMxlr1h63JhhOHvONUhbyipS2JU=;
 b=utNpO6ouy/pG9Vblubr5yzjNC5JlzebVmnQZ+ry2aIORt8p+6N+4CeYTxPsr+H60e3iQ/IT09h8ki7N4vVbJq2oSERqMQk0YzgKyQgFSrTHnxHNWVhR7rxUMZkETOqVdR3eaBBuHTfDkXU8WvMH0WTA4N4ac8BWKN7fQiE9C5Zo=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4367.eurprd04.prod.outlook.com (52.134.123.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 08:56:53 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 08:56:53 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
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
Subject: [PATCH RESEND v4 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
Thread-Topic: [PATCH RESEND v4 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
Thread-Index: AQHUaq5XJQuy5qHcUEiJP666T9Ihfg==
Date:   Tue, 23 Oct 2018 08:56:53 +0000
Message-ID: <1540284888-32307-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0601CA0008.apcprd06.prod.outlook.com (2603:1096:3::18)
 To VI1PR04MB1038.eurprd04.prod.outlook.com (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4367;6:wfe+OzNZDU8KOWKbrFgAxyFKErJuC06SHXBWqcLbp8NN4pGAGwDTe3cN6rMsjMvleTJFEE14HNh26fu7l6nPM9pfOr0nCMxDCRpjf+LA2hyG1p80K29CbrgBLsUgsI78qsvAbOAWUgzjkn9UN27NXsRdON518LOQGIeGWZryAtFNC/lhtR9RzosifS2QA/whJhoOc5ehbrPFruVake13YfC8BLMB2y8YoiNot3DhTVhmL5fJwkaA9XFWvoY8k6OdAGSWkQ8Q3V50rZLnham13DTxH1jJBFXTOxriLgq0eAYVqyojr6OzkM9TVqWwebonvwfRKd9U6cwCKzGOjnnmCLVgRNsoLe74NMld7LSFaCaeY4jZRbr0UJN4JFxFPvDk+XPM8fncdqQgfrQqk0hoGJ7D45P6jYt9CTWXQhT8WirEuPtx/DoZK9AJ0eypRDia79AEvNmcA2P+HLMJIYRfcQ==;5:RfJETBk6lo7QDFApYNHu5u6bogUM1xJ4AF5OgLoAMLHvxln8zUMfaEDbeSl91A1e/5UjHxfX+AZqTdkif00mgGvxXsHDXoLJZ5/UInwKKdQ4oJtP7yvFsaVMQFoWiwjtyq60Nh8teQI8icm6cy0JRAwjTP6uaFKPG6VMoM+Of5c=;7:PedQILQX+hPFfDgrf08gq5bms90pAliaZH8RyNVUxcmClhQL1WRP7rprrAx2oi7uA7UidL1iJUjQROrNGWxvmkzoFl0tp/1yi1LhntsLvPZk3wPcqGQ87gjz/JyWLCdxIAAg0cRdMGpFYCk7peMrZPx+Hc3dL7aQvMNI2j3AiDjfc9R5AZN1bZLBzsSb4gjesXVjqRtkoN6WVJwSkGnfdpLyf0T3cu7YUksC18ESPsOftvEdV5ziVzcgVc4mrqUQ
x-ms-office365-filtering-correlation-id: b5997c25-d4b4-4070-1dbb-08d638c579f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4367;
x-ms-traffictypediagnostic: VI1PR04MB4367:
x-microsoft-antispam-prvs: <VI1PR04MB4367C318E00289A8144002DE99F50@VI1PR04MB4367.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4367;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4367;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(5250100002)(6512007)(2900100001)(486006)(97736004)(105586002)(476003)(2616005)(7416002)(11346002)(25786009)(316002)(53936002)(446003)(4326008)(99286004)(26005)(106356001)(6506007)(2201001)(5660300001)(386003)(6436002)(256004)(86362001)(81156014)(478600001)(102836004)(36756003)(39060400002)(6486002)(8676002)(55236004)(81166006)(7736002)(71200400001)(71190400001)(76176011)(66066001)(52116002)(2906002)(68736007)(8936002)(305945005)(186003)(3846002)(217873002)(54906003)(6116002)(110136005)(2501003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4367;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9GCVRjQrSVQo1iU+CmCWzRl4Xr2RtmaVeXZrt09rSlybyJuqJJuAgXKKzeF72of7YDg6Sn2hhCEpswQlTFjhJ5jT5nqgP/pnY2Oxatg5lOiRKc9wULp1qEZYa9Ki6L4kCmz0eS7DCV5RB/s9txQj7aygcXdzwH808qP2uL93Wt9PVH2tnxWrep+ZK4dkhybUcHJo65dis76DyUv6JFsn4eXWKDhBWshORZHg9yR+e+P9WA7LpU+Gn+rr3v1ADi/3/VUl+6NarVj4b4rPrU+pmXIX0Tfdk7ToQX3mZ1+u07b9ci0KzvqAhoLb4xrbB/urM3X57XyW/dqT54lLiCU1siXqnfLic8KKcBongwEgW1A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5997c25-d4b4-4070-1dbb-08d638c579f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 08:56:53.2948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding file for NXP FlexSPI controller

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v4:
- Incorporated Rob review comments.
Changes for v3:
- Removed node property 'big-endian'.
Changes for v2:
- Incorporated Rob review comments.

 .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 39 ++++++++++++++++++=
++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Docum=
entation/devicetree/bindings/spi/spi-nxp-fspi.txt
new file mode 100644
index 0000000..2cd67eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
@@ -0,0 +1,39 @@
+* NXP Flex Serial Peripheral Interface (FSPI)
+
+Required properties:
+  - compatible : Should be "nxp,lx2160a-fspi"
+  - reg :        First contains the register location and length,
+                 Second contains the memory mapping address and length
+  - reg-names :  Should contain the resource reg names:
+	         - fspi_base: configuration register address space
+                 - fspi_mmap: memory mapped address space
+  - interrupts : Should contain the interrupt for the device
+
+Required SPI slave node properties:
+  - reg :        There are two buses (A and B) with two chip selects each.
+                 This encodes to which bus and CS the flash is connected:
+                 - <0>: Bus A, CS 0
+                 - <1>: Bus A, CS 1
+                 - <2>: Bus B, CS 0
+                 - <3>: Bus B, CS 1
+
+Example showing the usage of two SPI NOR slave devices on bus A:
+
+fspi0: spi@20c0000 {
+	compatible =3D "nxp,lx2160a-fspi";
+	reg =3D <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
+	reg-names =3D "fspi_base", "fspi_mmap";
+	interrupts =3D <0 25 0x4>; /* Level high type */
+	clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
+	clock-names =3D "fspi_en", "fspi";
+
+	mt35xu512aba0: flash@0 {
+		reg =3D <0>;
+		....
+	};
+
+	mt35xu512aba1: flash@1 {
+		reg =3D <1>;
+		....
+	};
+};
--=20
2.7.4

