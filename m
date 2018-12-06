Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E0BC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08F0214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xKt5sCoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08F0214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeLFBmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:42:45 -0500
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:24848
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728810AbeLFBmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3oCWEdFGr/NXgQk26zLXM8Wm81LvyY+Zr7GHokgYJM=;
 b=xKt5sCohgymcIzUmwr8ZjlTLTfBbkqm/M+obnv88HQ1ZU/oUJmeho925eVQOsDztnqFQyz46CJYgBi6PhYgnI6FNpFBagUUjzDLYhALfqEmUo1VOePg2vUyX6a/OZLcxrnotni7SnkKPsJB1sbJO1nQbLmR2cn+hEcIww3TgirY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 01:42:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 01:42:38 +0000
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
Subject: [PATCH V2 3/4] ARM: dts: imx6qdl-sabresd: add magnetometer sensor
 support
Thread-Topic: [PATCH V2 3/4] ARM: dts: imx6qdl-sabresd: add magnetometer
 sensor support
Thread-Index: AQHUjQT4+nE01zYojkqtssE2nVyeIg==
Date:   Thu, 6 Dec 2018 01:42:38 +0000
Message-ID: <1544060203-22163-3-git-send-email-Anson.Huang@nxp.com>
References: <1544060203-22163-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544060203-22163-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0051.apcprd04.prod.outlook.com
 (2603:1096:202:14::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3947;6:pO3jse3n0nLreAQ64j+Sf3Vdmslmo78mHCU1SzaxhsmxtEZJQxHUD7uUNUutM0UU8CoIntM39+w0scN/JNd/kqQvTuL4WhKt3yGiRh3V43rY8ECdqF84F60zaEfLMqu81TuPEY/4KmW6U1CfqGhR8LNCtbS9b0YF61Divdrd0i49stXIERDzKoFt/Fu11woekQb6Ht4pUXpxNRkDyuHlnA3SS3nPz1bYfY8SNX0xwzZx+fakRCwHZE+8plFNQ7AWnE64dq2bdXYDZqNSEO5LQ0uQyVntgG6X3l6x/9zkkPe48IaAdukH8EUJbWAMaMt1pVlDMP8+MpslDV8l+C0OskzOEQV7wu03d0Cc4MCt1zk7kXHcgoj3EtuZ4i3WEhbWC2Ha+tYT00TaXLOxhI+y8PtAgm6amtuFwhDSdN9cExPnEu9ogVRkPQAGrOJU8O+dWvUsCRNij/Bmidl+D6dhGQ==;5:kcSegU2sojS0tjwNbYoWN0q3HOUdiZdLV/jJWdC66/BXUr+z3T2JwNdZ9rN0B0La6vKzjQMxvzBCqEq3J2xg58wfzt4b5a5d6YwsMxjpRG76NBvoIbOluOHxKfSSmrY0ITdMc5xrKanvfhMZ+Fcb0ZMu984hhM0HZHnzbXMvpcU=;7:23F6DtV1LDWngYhXNHEb4c9DpI6EnCq0IIPUy4gdAk8I3d4z6Xa6nrMcO25kLBZgV3bi5vEwiR3wX5z5n0z1mvxbq7SQRTShMm/pWKJmQP9XXKr0i3nfoKrq1IhXVb4zhqXvD3aHcCRo22XuTYU6zw==
x-ms-office365-filtering-correlation-id: d71487a8-8a6b-4a99-703d-08d65b1c1a76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3947;
x-ms-traffictypediagnostic: DB3PR0402MB3947:
x-microsoft-antispam-prvs: <DB3PR0402MB3947A8F59E5D910F1E631BDFF5A90@DB3PR0402MB3947.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3947;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3947;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(102836004)(86362001)(2501003)(76176011)(11346002)(6486002)(97736004)(386003)(52116002)(6506007)(99286004)(3846002)(476003)(6436002)(575784001)(256004)(2906002)(26005)(446003)(486006)(6116002)(186003)(110136005)(106356001)(2616005)(14454004)(2201001)(105586002)(305945005)(478600001)(7736002)(4326008)(66066001)(25786009)(8936002)(50226002)(81166006)(81156014)(71190400001)(71200400001)(5660300001)(6512007)(68736007)(53936002)(36756003)(8676002)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3947;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lziqcQsK3q+EwbHRch6DmqPQCX5liE6yiNFCDraiA9agXbx8+FvHVPvioBG74z/NDTJQDQ3QjHHu2S6tDJJ+0ghqk8/nIJhHWDdBjp1SIOe8YZl6g7I34OZ+8Az8bFhoWGKVt08c9mr7qey8ne75Td/JVFe6QmzeqTOSznLpzvYKkkOKmFuTigeVc4iyXwrwtZrxPu0/6B1JapldF6FqzTMcKcJ724zcOz9cdtbPW/G3U3AhhrkVgVMbgj/pfNJ5hCbmgQzz4VLvWjE8WL94Weqpa6u1gsLvmiK96HDLqIQ57eBO35ufLqR8KU1tVl2Ou/kwldpPOtIwQpTXuUmDf1SNHDxm3NgkEPo2FRWKOuk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71487a8-8a6b-4a99-703d-08d65b1c1a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 01:42:38.5148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add magnetometer sensor mag3110 support on i2c3 bus.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx=
6qdl-sabresd.dtsi
index d07c250..b8a2fd8 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -423,6 +423,15 @@
 		wakeup-gpios =3D <&gpio6 7 0>;
 	};
=20
+	magnetometer@e {
+		compatible =3D "fsl,mag3110";
+		reg =3D <0x0e>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_i2c3_mag3110_int>;
+		interrupt-parent =3D <&gpio3>;
+		interrupts =3D <16 IRQ_TYPE_EDGE_RISING>;
+	};
+
 	light-sensor@44 {
 		compatible =3D "isil,isl29023";
 		reg =3D <0x44>;
@@ -538,6 +547,12 @@
 			>;
 		};
=20
+		pinctrl_i2c3_mag3110_int: i2c3mag3110intgrp {
+			fsl,pins =3D <
+				MX6QDL_PAD_EIM_D16__GPIO3_IO16		0xb0b1
+			>;
+		};
+
 		pinctrl_ipu1_csi0: ipu1csi0grp {
 			fsl,pins =3D <
 				MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12    0x1b0b0
--=20
2.7.4

