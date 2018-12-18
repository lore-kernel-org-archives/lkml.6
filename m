Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F550C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6313E217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LxDoOiNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbeLREwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:52:03 -0500
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:20431
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726549AbeLREwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 23:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giB2Kh9mrzRb5jwNPWlKfbQHhBQWMKzbhLd8AlIDMJo=;
 b=LxDoOiNO2FZQqhQWDzik/Eggu5gTn4bYOZHq+EiU7Ji6ALZOs2tG9t30ETNMI8+zIpA0fCGw9X5A8dG8KLwVESsUT6vBEiVuB60R+QthKiaQfNj/ywDIeLKYj8QFYQkk72YmPLa5NNmO+hL22FH/Z2AboqWLJuIZ83gI31E9Av4=
Received: from VI1PR04MB4480.eurprd04.prod.outlook.com (20.177.53.224) by
 VI1PR04MB4112.eurprd04.prod.outlook.com (52.133.14.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Tue, 18 Dec 2018 04:51:58 +0000
Received: from VI1PR04MB4480.eurprd04.prod.outlook.com
 ([fe80::9564:6e18:8e79:eff0]) by VI1PR04MB4480.eurprd04.prod.outlook.com
 ([fe80::9564:6e18:8e79:eff0%5]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 04:51:58 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 1/2] arm64: dts: ls1088: add smmu device node
Thread-Topic: [PATCH 1/2] arm64: dts: ls1088: add smmu device node
Thread-Index: AQHUlo1oSPDChwILUE2cs2d7WwpBEQ==
Date:   Tue, 18 Dec 2018 04:51:58 +0000
Message-ID: <1545109016-1779-1-git-send-email-nipun.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::11) To VI1PR04MB4480.eurprd04.prod.outlook.com
 (2603:10a6:803:67::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4112;6:zUv7eHKqVOuX0DEar0Xdr1aeBUnWJ7V/J7xinN+DhZF8hIbiQ3GawFwLx1l47/fFDeQEQ4/XBnSjSlDlKTgxq1kf+ecAfy3s6rL6oEDQTsujJ0lCOaiWur1rWYyzPrp+qneWND8d6zWqdsc0pbZeiTCavNusQR23pysQvnTu98Ou9MmrAlvQTCghhu3Ns5DiglCtwxr3MZYvVEp9Za5BZ1iT2+4Qpgoz97OExVgUiM35PYOeSC3dttofkP/NdWlmBKwGmnU0Oj6C+lXcjjsa10yW8I7kh5XB7+7amlaiBly7LC6wH6kIi3JIZp7I+vyYR9NiDly9IPwoVddPJ7H68PJnRrOYDhQ3rKUx8UxFbeELzjgZk7tY1QKH63baFiDyPHuoarC6YsUXw/RA6iX+ikMcSkNexDdcvXYgLpB3x6wacfCPT8cWuKeyGvZZ21KOXJyZ8Vc7Ynu1US5zjd+HxQ==;5:liPWHueKz+G8CGOnQV7MnSs0hEh/BI+0sRjCBC7eR5vhtAt0vrDZBG35QWulD5ij+62McQblB5anCWzfEMvNN/vfgBKPvpVV2N/KqOA/gzpZIJ7dZdZ1d6gcD3PXzDK0632jTZ2xxnbmjsxbir62+ppa6zeV8kIsee+IX5ZlNp4=;7:15vErUKzfwlLpBfA1kqXDn9ZPcFG1qfb1XXWilWPJO/4hrgCqb98eIjHyu00KzLR1d9RYTQ6gTi4KBc5CKqz47tF7kRJSR0Ucsjo3Zd3/6ntKVxpyy+ixlhF/xtx+pPZW+y9rh/4g4IFdY4NkaRPSg==
x-ms-office365-filtering-correlation-id: bd926537-3ddc-4091-55e3-08d664a48a86
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4112;
x-ms-traffictypediagnostic: VI1PR04MB4112:
x-microsoft-antispam-prvs: <VI1PR04MB411213DA1066B0FC7910014DE6BD0@VI1PR04MB4112.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4112;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4112;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(14444005)(6512007)(256004)(6306002)(6486002)(14454004)(6116002)(3846002)(26005)(78486014)(2906002)(186003)(2201001)(71200400001)(966005)(71190400001)(6436002)(66066001)(575784001)(97736004)(86362001)(8936002)(81166006)(8676002)(81156014)(478600001)(36756003)(5660300001)(102836004)(99286004)(55236004)(6506007)(68736007)(4326008)(2501003)(52116002)(386003)(305945005)(44832011)(486006)(476003)(53936002)(2616005)(7736002)(25786009)(105586002)(110136005)(316002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4112;H:VI1PR04MB4480.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NwYt3b56ACKugmrVoePQ9fxP+DL+Vntm213Z/G9UVf/tG2Ch/Rc0XrZC/GN3He3P64ixjcQhJHh5hWyxCKt/uzqi3j/49z/Wsr/V5CMPZSE/N3b+QFX92A890qq9lMEUYGKy9W6MZyI3O2Y6jouGPZ4nBdX8gzwe7y2E+ah8ChhRUs/5m0QV5aMK5QsjtSb5EMZDX7wHT55lcq7p4NnuQ4sZquAaoOzENG1nBeeZ/WLr6gJ1z8YxVxw7zDIz2RtoGTJ4xNC1yRQr2Se+Zr3RF9Bwbt1yZpcHQqHjuhsSioYOO5lBQYES/NSc1V0G+BAP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd926537-3ddc-4091-55e3-08d664a48a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 04:51:58.5310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch also adds the iommu-map property in fsl-mc node, so
that fsl-mc can use iommu.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
These patches are based over:
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git,
as there are couple of changes related to fsl-mc bus in this tree:
https://lore.kernel.org/patchwork/patch/1021020/

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 92 ++++++++++++++++++++++=
+++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1088a.dtsi
index de93b42..dec0c2d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -576,6 +576,7 @@
 			reg =3D <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
 			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
 			msi-parent =3D <&its>;
+			iommu-map =3D <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
 			#address-cells =3D <3>;
 			#size-cells =3D <1>;
=20
@@ -641,6 +642,96 @@
 				};
 			};
 		};
+
+		smmu: iommu@5000000 {
+			compatible =3D "arm,mmu-500";
+			reg =3D <0 0x5000000 0 0x800000>;
+			#iommu-cells =3D <1>;
+			stream-match-mask =3D <0x7C00>;
+			#global-interrupts =3D <12>;
+				     // global secure fault
+			interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     // combined secure
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     // global non-secure fault
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     // combined non-secure
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     // performance counter interrupts 0-7
+				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+				     // per context interrupt, 64 interrupts
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
=20
 	firmware {
@@ -649,5 +740,4 @@
 			method =3D "smc";
 		};
 	};
-
 };
--=20
1.9.1

