Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29FCC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4682085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KHF+ygqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4682085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbeKFVN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:13:26 -0500
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:17872
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730335AbeKFVNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx/xN8zRRu1EecmU2azSxE6TrCoTll9gCHGEU6tCYyg=;
 b=KHF+ygqYZP9qDhps9Rm/HZ5xvYhGUmsX+b6r8OTxFQVazQbSVBUKQ5c4KtbU9OjEcYWR6yCbt9smbODuNGtY9LBUcSjkjYzQA32EFcM4KUQZfQvDA57cUTyX/3krcRhTnjfOrQidj2lVYJmSCbdGTBrVC69k2VNUQJy0ViwJGZc=
Received: from AM6PR0402MB3863.eurprd04.prod.outlook.com (52.133.29.150) by
 AM6PR0402MB3670.eurprd04.prod.outlook.com (52.133.28.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.22; Tue, 6 Nov 2018 11:48:30 +0000
Received: from AM6PR0402MB3863.eurprd04.prod.outlook.com
 ([fe80::ed06:84da:17fa:8a98]) by AM6PR0402MB3863.eurprd04.prod.outlook.com
 ([fe80::ed06:84da:17fa:8a98%6]) with mapi id 15.20.1294.028; Tue, 6 Nov 2018
 11:48:30 +0000
From:   Florinel Iordache <florinel.iordache@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florinel Iordache <florinel.iordache@nxp.com>
Subject: [bindings][PATCH] bindings/net: DPAA Backplane Device Bindings
Thread-Topic: [bindings][PATCH] bindings/net: DPAA Backplane Device Bindings
Thread-Index: AQHUdcajUbLhQXbtgkSMlpJfRBen4A==
Date:   Tue, 6 Nov 2018 11:48:30 +0000
Message-ID: <1541504900-30091-1-git-send-email-florinel.iordache@nxp.com>
Reply-To: Florinel Iordache <florinel.iordache@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0026.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::12) To AM6PR0402MB3863.eurprd04.prod.outlook.com
 (2603:10a6:209:1b::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=florinel.iordache@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3670;6:Xhx7CHRR9ENE8+AZR3Wq5vaeoaiZkmORnRNYqz9pHKikFu5EJ+wjuX980VXAjvXj7vnIDtsgF2rGnjhDHuAkyvB3XsfEcmghKAvlv3ZZJr6aiVsk5ZVs2wPvDNRXYejz3vCiJ+goPvEtRPnwO4KfL34zf15rvVV2rnw4Kbq+8LRrnhztSyl62N+4SeJyTMKQTYKbaITYhVyNqZoEflGLkHNl1/VJdDyN/TxAgr4JLlLXbiyJtFWiq7AiQ1ntKGDBdmKKk8PpJgQ8JabG0uWgrhA0NLxNUkzOgK5bVz9pHoMh3dmsQNfVJMvU7jjkIZOLhjOs6Fc5seR1wgMUsVruCBRZdMg8i8y6Wy1BHfV8fw0DSycxkVpsKNfuRinMmds8gjfSdbQGnJfh7Z0gB4DOPJSBS+06SFDHYKDTvA5hWJknEUJ3s3W8SvVzql1C6lQz1uq8ypDSeXUuy+Zfy6OnpA==;5:X8KQTBBFtIrWYsHM5yY2UoRmYFN88bNuPP7HFmdQskZJQWg3Ea9WU623Vs8cY7cbEI6/1x6DViYL+BpcdNHpfbvDQP6AMMXZKjIurdbDxP15QmeQN2L5astyS7mfBI/8g3SKuUJtn8jjKRODia2/xAOckwDOVaIGJirFwK+3JpM=;7:+mgUD/XMBoeGoNdJVwUnFGueh+ywgubAQeTCi0fEpOBceKKgNxwAmVIGiSI9hTs6+vE6+Af2yUOvakhYXSp0mEt7WpMiuEHt1k1RtL+cNh8vLXgiWGDnR551rQ8PgDjHPN7dF4HDrweQeL/nmATdeg==
x-ms-office365-filtering-correlation-id: 28168bad-acb0-4752-4f74-08d643ddc577
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3670;
x-ms-traffictypediagnostic: AM6PR0402MB3670:
x-microsoft-antispam-prvs: <AM6PR0402MB3670EFAFFA564AC1FC37E346FBCB0@AM6PR0402MB3670.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3670;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3670;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(366004)(376002)(189003)(199004)(25786009)(6436002)(99286004)(52116002)(86362001)(6486002)(6512007)(6506007)(386003)(256004)(3450700001)(14444005)(54906003)(2906002)(66066001)(305945005)(110136005)(71200400001)(43066004)(7416002)(36756003)(71190400001)(316002)(102836004)(53936002)(81166006)(81156014)(8676002)(14454004)(44832011)(486006)(476003)(7736002)(8936002)(2616005)(2501003)(105586002)(478600001)(68736007)(4326008)(26005)(2900100001)(106356001)(5660300001)(1857600001)(186003)(3846002)(6116002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3670;H:AM6PR0402MB3863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +3xZZrsIccq6+g0mUvFMB7Zr6/Kms+Xt4jxlugWpNcJ6oU1pqmQpyoatSq72kAugtAl/O3swwXzxqLqloZ+bC6IZq2MesEi9Jif+3UNMwDIr3ClXgPhiQJEka5m3jGmuX1T9B1ZJ3dJWVVRaaHG4nB+pXbBumTv1zO2xggOzuLQKfdwYx8pVJ4qwDytDg6ysHiXmaNrAnHOgjQ8ZM++3ibQLoJSlYcw+9z3stufSME5iudZL7U5WlLmcUY4MdDe/gGJlnGQ2irxgp+jBerXoct5ZdjSOTPNxfKerhKGojhH/MEd66vW+Vitzp9wdPxh6LX6DETKtRLQxX54ktjl6JX0z/rRiuNv5ZF7jFxX8lV0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28168bad-acb0-4752-4f74-08d643ddc577
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 11:48:30.2240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3670
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device Tree Bindings for DPAA backplane available on Layerscape
 communications processors.

Signed-off-by: Florinel Iordache <florinel.iordache@nxp.com>
---
 .../devicetree/bindings/net/dpaa-backplane.txt     | 105 +++++++++++++++++=
++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dpaa-backplane.tx=
t

diff --git a/Documentation/devicetree/bindings/net/dpaa-backplane.txt b/Doc=
umentation/devicetree/bindings/net/dpaa-backplane.txt
new file mode 100644
index 0000000..f147c84
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dpaa-backplane.txt
@@ -0,0 +1,105 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+DPAA Backplane Device Bindings
+
+CONTENTS
+  - SerDes Node
+  - PCS Phy Node
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+SerDes Node
+
+DESCRIPTION
+
+SerDes (Serializer/Deserializer) HW peripheral
+
+PROPERTIES
+
+- compatible
+		Usage: required
+		Value type: <stringlist>
+		Definition: Specifies the type of SerDes.
+		Must include the prefix "fsl,serdes"
+		SerDes can be of different types:
+		- 10G SerDes must be specified as: "fsl,serdes-10g"
+		- 28G SerDes must be specified as: "fsl,serdes-28g"
+
+- reg
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: Specifies the offset of the SerDes configuration registers
+
+- little-endian
+		Usage: optional
+		Value type: <Boolean>
+		Definition: Specifies endianness access to SerDes registers.
+		If omitted, big-endian will be used
+		See common-properties.txt for complete definition
+
+EXAMPLE
+
+Example of 10G SerDes node:
+
+serdes1: serdes@1ea0000 {
+		compatible =3D "fsl,serdes-10g";
+		reg =3D <0x0 0x1ea0000 0 0x00002000>;
+		little-endian;
+};
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+PCS Phy Node
+
+DESCRIPTION
+
+PCS Phy (Physical Coding Sublayer / Physical layer) node
+
+PROPERTIES
+
+- compatible
+		Usage: required
+		Value type: <stringlist>
+		Definition: A standard property. Specifies the IEEE 802.3 Clause
+		Different IEEE 802.3 Clauses can be specified:
+		- Clause 22 must be specified as: "ethernet-phy-ieee802.3-c22"
+		- Clause 45 must be specified as: "ethernet-phy-ieee802.3-c45"
+		For complete definition see:
+		Documentation/devicetree/bindings/net/phy.txt
+
+- reg
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: A standard property.
+		Specifies the offset of the PCS Phy configuration registers
+		For complete definition see:
+		Documentation/devicetree/bindings/net/phy.txt
+
+- backplane-mode
+		Usage: required
+		Value type: <stringlist>
+		Definition: Specifies the speed and type of the protocol used
+		Different speeds and backplane protocol types can be used:
+		- 10GBase-KR must be specified as: "10gbase-kr"
+		- 40GBase-KR must be specified as: "40gbase-kr"
+
+- fsl,lane-handle
+		Usage: required
+		Value type: <phandle>
+		Definition: Specifies the reference to a node representing the SerDes
+		device
+
+- fsl,lane-reg
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: Specifies the offsets of the SerDes lanes configuration
+		registers
+
+EXAMPLE
+
+Example of pcs phy node for 10GBase-KR:
+
+pcs_phy1: ethernet-phy@0 {
+	compatible =3D "ethernet-phy-ieee802.3-c45";
+	backplane-mode =3D "10gbase-kr";
+	reg =3D <0x0>;
+	fsl,lane-handle =3D <&serdes1>;
+	fsl,lane-reg =3D <0xE00>; /* lane G */
+};
--=20
1.9.1

