Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F24C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587AE20815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C6dOMozW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733254AbeLTRCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:02:48 -0500
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:36800
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbeLTRCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfTjtM1Pg+EjbEb/4QQr+VHJp+yvfw7cesqk8qIE64k=;
 b=C6dOMozWkszzEbzykkzHgc06uG46akgw56ryF85vPLqtFxNpFGpHOLGu8fcPbMsOpCNTDkETCsPYPJd22GRm+6Kk6libV2FNHPZJr7W/4BkiZUpvzIyQ9R1WHTBl3f6kQWtkhVZPWNWDK8Hie1yXcLEbAEuvcpTo3C/Vw22xEzg=
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com (20.177.40.15) by
 AM0PR04MB4979.eurprd04.prod.outlook.com (20.177.40.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Thu, 20 Dec 2018 17:02:03 +0000
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2]) by AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2%5]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 17:02:03 +0000
From:   Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] arm64: dts: lx2160a: Add fsl-mc node
Thread-Topic: [PATCH 1/2] arm64: dts: lx2160a: Add fsl-mc node
Thread-Index: AQHUmIW6Vu2k4jOI+0ubj1oSsG+umg==
Date:   Thu, 20 Dec 2018 17:02:03 +0000
Message-ID: <1545325306-1681-1-git-send-email-ruxandra.radulescu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0135.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::33) To AM0PR04MB4994.eurprd04.prod.outlook.com
 (2603:10a6:208:c7::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4979;6:TWiEyXPOAGJxczHRzS40YOTIvGQsFFbwyOysWgVDLCbviGBsEO4bkP+9P3GlmtE3HC7wn2XbrnYRvww4hP+wKWX7xJ0ay48xtHQKM8wpXu4VboHXWhi9RB5cgy4dOkG0LlCdcAWPx1OZZirFP09d4C/JqZIO6U3PMQ8GoHUWtLWFHR2HwDAkA0dsgc9VT7OCwVRcYJx06h+wDIG4dcCW/GDKgYGaWfT7GuQXZbzRLJ2V8FanIVt8Get/KGcfok2de0ghNG/7P7Qf2flLaZH0YxeSOGB5S142eCWboN7yshKAHPgat2g3cqKixVZspe+dS0nmc3fkKV/W5eqyKIAej84rC9EP53b0fqu7In++xPe8+i7t9XZ4qBVCUIx1B7mhPM+J3SLTq4Aegk2RFK5if7mtCD06XOvWz3bbThV5x/G/KJkcHF3vafg/lnKVMd/7CGbHVirvNaxL1PVFKOr6Hg==;5:KEj4m9cCn+o0vyTdnZsa1IiVC3w+A+enS4Ww0RpFokSu8IIvvSdRPpTrEqf83PGdsJxzfRrlCqvheWov6zjRxUYw8lnlV8lDrbzOqltHwLbxXBCHcjax8Q8UpUYAczhZAB8Ay7z+J8npZmgntUMcNBUM+XtdvJ3an4887CXVmww=;7:uqQKvQ8d5C2Ja+KEbPmL9oG4vAJVdh84y+VCL6MIrUdmh3hGBEOyNmE0IGANuMmuSlNbvcdXt2qU/vmYRv0/4OdT0luzEX10kuB8WyWGxKKTgnu6yq12Ru/I8i7xRKPJfMxYDvq/pGxaElNL0W9jFA==
x-ms-office365-filtering-correlation-id: 89fceaa4-bd5b-4341-8cb2-08d6669cdd50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4979;
x-ms-traffictypediagnostic: AM0PR04MB4979:
x-microsoft-antispam-prvs: <AM0PR04MB497936381746610CE2672F7394BF0@AM0PR04MB4979.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4979;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4979;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(5640700003)(26005)(316002)(256004)(66066001)(52116002)(36756003)(54906003)(102836004)(476003)(486006)(386003)(6506007)(575784001)(86362001)(6116002)(3846002)(68736007)(5660300001)(186003)(2351001)(2616005)(99286004)(6486002)(2501003)(6916009)(4326008)(106356001)(25786009)(2906002)(478600001)(305945005)(6512007)(1730700003)(7736002)(81156014)(105586002)(14454004)(8936002)(71200400001)(97736004)(53936002)(71190400001)(8676002)(6436002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4979;H:AM0PR04MB4994.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rVZCXGPQyxr9nmIPxw2cxI4LoDXnxB9cOgH9dqBFlpwxqynDsxixMAI6V/hvCHuclX1AqhuKtpTQFdDWIuZ+WBDFFkOEmvq1nVj+VtzHdoT0By2BFYmMGvqeWXCF8TOMdODD/srINQiaSUGL3AM5ENEkA2a/BxVKYAdhuXCPzL3qzseAA+l7JHCeUEF63ZGSAYZWjW1LyrToWwYEHbGlb8cXl+Yvzdsc/1Ww1G7+b/4s8LLRSsOYOWR+oH7bvrK5F33DiwISTQnLr85IoerWZxuNqmyWo14hXTZfgEL4R1y89tzTu9A5ECHo7/6QmYY7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fceaa4-bd5b-4341-8cb2-08d6669cdd50
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 17:02:03.5740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4979
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the fsl-mc node in the LX2160A device tree.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 117 +++++++++++++++++++++=
++++
 1 file changed, 117 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-lx2160a.dtsi
index a79f5c1..2366fd6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -762,5 +762,122 @@
 				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 			dma-coherent;
 		};
+
+		fsl_mc: fsl-mc@80c000000 {
+			compatible =3D "fsl,qoriq-mc";
+			reg =3D <0x00000008 0x0c000000 0 0x40>,
+			      <0x00000000 0x08340000 0 0x40000>;
+			msi-parent =3D <&its>;
+			/* iommu-map property is fixed up by u-boot */
+			iommu-map =3D <0 &smmu 0 0>;
+			dma-coherent;
+			#address-cells =3D <3>;
+			#size-cells =3D <1>;
+
+			/*
+			 * Region type 0x0 - MC portals
+			 * Region type 0x1 - QBMAN portals
+			 */
+			ranges =3D <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
+				  0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
+
+			/*
+			 * Define the maximum number of MACs present on the SoC.
+			 */
+			dpmacs {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				dpmac1: dpmac@1 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0x1>;
+				};
+
+				dpmac2: dpmac@2 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0x2>;
+				};
+
+				dpmac3: dpmac@3 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0x3>;
+				};
+
+				dpmac4: dpmac@4 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0x4>;
+				};
+
+				dpmac5: dpmac@5 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0x5>;
+				};
+
+				dpmac6: dpmac@6 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0x6>;
+				};
+
+				dpmac7: dpmac@7 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0x7>;
+				};
+
+				dpmac8: dpmac@8 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0x8>;
+				};
+
+				dpmac9: dpmac@9 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0x9>;
+				};
+
+				dpmac10: dpmac@a {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0xa>;
+				};
+
+				dpmac11: dpmac@b {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0xb>;
+				};
+
+				dpmac12: dpmac@c {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0xc>;
+				};
+
+				dpmac13: dpmac@d {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0xd>;
+				};
+
+				dpmac14: dpmac@e {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0xe>;
+				};
+
+				dpmac15: dpmac@f {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0xf>;
+				};
+
+				dpmac16: dpmac@10 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0x10>;
+				};
+
+				dpmac17: dpmac@11 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0x11>;
+				};
+
+				dpmac18: dpmac@12 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0x12>;
+				};
+			};
+		};
 	};
 };
--=20
2.7.4

