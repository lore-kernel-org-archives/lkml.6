Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2F3C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BE320661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pJt+sxrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BE320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeLDQdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:33:17 -0500
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:19958
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbeLDQdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpzoRCaBgRoqmKDIAJm+f4X4BJqxuaSvIaYNVLNPxQI=;
 b=pJt+sxrlMTd/HxK4Bs2vqPuUG6+9vcYnVjObm0lg5jxKTod52kxrw9uMXNZ5ozxxNrlLxmOSVIVhYOSFZrNUcMtrVEsOLn38V2hzueG+AZp0FKwt1JhDYE19JtNmFIxze5ad0eWYOBa08lE268wOnwHV0ZmXLICxTXg6ThHkE08=
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com (20.177.40.15) by
 AM0PR04MB4386.eurprd04.prod.outlook.com (52.135.148.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Tue, 4 Dec 2018 16:33:06 +0000
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2]) by AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2%4]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 16:33:06 +0000
From:   Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] arm64: dts: ls1088a: Move fsl-mc node
Thread-Topic: [PATCH 1/2] arm64: dts: ls1088a: Move fsl-mc node
Thread-Index: AQHUi+8IvrQ2gcpaXkmLZ1+Gz0neYA==
Date:   Tue, 4 Dec 2018 16:33:06 +0000
Message-ID: <1543941180-5147-1-git-send-email-ruxandra.radulescu@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4386;6:c29F9OAiqPOjI+qWE4hXCZgu48U6UQxz4Xgp4qVDo90bTKxguw5hbKS1je8D9xvIf526pWM7DreNhwqpC1dI+rJfqcCxLGCivZrAR+dM4cG5z7fp8Irq4jfwkrlOYWdUvNczyt1VAzwf+QOchbT3/Tm8VF/goB3icFd/TQGjDg5qCZT9xByoI1xJ2l1GWoy6lzgwpiHuxgqY7c1NxmcMcr99e7WnqCiVklkx2KoM+pnetNQ4G51VlcyCAPWiqT3AJT/tOziozClAYjVmInIKjKQkFyTM2w/j39vEcXr6BQnanjpIuYBk3UANe1byfEOjXn4Uq8ZJhVeHBkPAVYwjBxCqzfJZihnNhD1l4jJBEk4dCejK8czfj5L8AnDkYMovs8J/iZhK+dWjgUjm/dn2sy5mEmElXWNJmP/TvRiJEajl/himIyCG5lejToLsmTcy3wOLUOCJLm+Ord0QTp/JVw==;5:FjcnG0ghl1OukIe3ZyQl8P/PHtan/Kvbjch4OMsrLR4dk3TQnZkQ9I8RaKY1yCUZ7TG0ZMlVuwJBIgik1DwqtYfDBnKX2LOKlOrHkiKAXP56wVirCoopApU+LD9/9elNlV5ILqqnrFT++MpKVYbpcGjr58u64myUaT0sNBjNpZA=;7:SkmkC5oE85SMSaNUdF7vGunlPeDB0xyLF5e7+YK3M1ltVu3Eeaw4yQ9xJFUi7f+l64O3iL6qWHKjhNpB2v+aIVt7IO5zEQoBhkc1x7peqc5kejXtbzOe3WCr6ZYLF2LFI/Djk+m5KTRgknfkF1dp+w==
x-ms-office365-filtering-correlation-id: 1ae4e94b-d27a-4b0a-a5e1-08d65a062b3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4386;
x-ms-traffictypediagnostic: AM0PR04MB4386:
x-microsoft-antispam-prvs: <AM0PR04MB43862CD241D15D80B05D46F494AF0@AM0PR04MB4386.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4386;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4386;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(189003)(8936002)(52116002)(97736004)(5660300001)(478600001)(53936002)(2351001)(2906002)(6436002)(6916009)(575784001)(14454004)(6116002)(68736007)(6486002)(305945005)(3846002)(256004)(316002)(4326008)(7736002)(54906003)(86362001)(6512007)(5640700003)(81166006)(25786009)(476003)(186003)(99286004)(102836004)(2616005)(1730700003)(8676002)(386003)(6506007)(26005)(36756003)(81156014)(66066001)(71190400001)(71200400001)(106356001)(105586002)(2501003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4386;H:AM0PR04MB4994.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vnoschHcPpedb0lSwBbIBKo8uiXZAtI+rRgRREcjItQtCFaIrjxlI89iW5CWIppa7kaL1AQpUmLk0iwa8Qdd6FWreilCSPNyno01fOGwU/TIOcUWNxLv3r2ESSJ2I8Lo5+RL4eZxiTlXfZFEEW5qf8n04himc5Qq1685gL9YrPrs3OVGMb6Tnc0qnhF47RqsEM+1SPG4pFhUHYhFPxpP8m8wwyAchyQqV9qdqXZnD4d/LgtNZfLohoqfD5KCgYFtzRJmbJi1k0S+59QbtpLPm9Dj1cwqS8RITkQBW4lIWYgCkbJitUh7PX2NSOQrr2sF3N/9kccZhPC0X84XUE0W412B4/gfSg5Uoct6bTIZ7PM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae4e94b-d27a-4b0a-a5e1-08d65a062b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 16:33:06.4014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4386
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fsl-mc node should sit under the soc node, so move it to
its proper location.

Fixes: ac7c9ff741fb ("arm64: dts: ls1088a: add fsl-mc hardware resource man=
ager node")

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 142 ++++++++++++---------=
----
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1088a.dtsi
index a07f612..ba5ce73 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -174,77 +174,6 @@
 			     <1 10 IRQ_TYPE_LEVEL_LOW>;/* Hypervisor PPI */
 	};
=20
-	fsl_mc: fsl-mc@80c000000 {
-		compatible =3D "fsl,qoriq-mc";
-		reg =3D <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
-		      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
-		msi-parent =3D <&its>;
-		#address-cells =3D <3>;
-		#size-cells =3D <1>;
-
-		/*
-		 * Region type 0x0 - MC portals
-		 * Region type 0x1 - QBMAN portals
-		 */
-		ranges =3D <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
-			  0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
-
-		dpmacs {
-			#address-cells =3D <1>;
-			#size-cells =3D <0>;
-
-			dpmac1: dpmac@1 {
-				compatible =3D "fsl,qoriq-mc-dpmac";
-				reg =3D <1>;
-			};
-
-			dpmac2: dpmac@2 {
-				compatible =3D "fsl,qoriq-mc-dpmac";
-				reg =3D <2>;
-			};
-
-			dpmac3: dpmac@3 {
-				compatible =3D "fsl,qoriq-mc-dpmac";
-				reg =3D <3>;
-			};
-
-			dpmac4: dpmac@4 {
-				compatible =3D "fsl,qoriq-mc-dpmac";
-				reg =3D <4>;
-			};
-
-			dpmac5: dpmac@5 {
-				compatible =3D "fsl,qoriq-mc-dpmac";
-				reg =3D <5>;
-			};
-
-			dpmac6: dpmac@6 {
-				compatible =3D "fsl,qoriq-mc-dpmac";
-				reg =3D <6>;
-			};
-
-			dpmac7: dpmac@7 {
-				compatible =3D "fsl,qoriq-mc-dpmac";
-				reg =3D <7>;
-			};
-
-			dpmac8: dpmac@8 {
-				compatible =3D "fsl,qoriq-mc-dpmac";
-				reg =3D <8>;
-			};
-
-			dpmac9: dpmac@9 {
-				compatible =3D "fsl,qoriq-mc-dpmac";
-				reg =3D <9>;
-			};
-
-			dpmac10: dpmac@a {
-				compatible =3D "fsl,qoriq-mc-dpmac";
-				reg =3D <0xa>;
-			};
-		};
-	};
-
 	psci {
 		compatible =3D "arm,psci-0.2";
 		method =3D "smc";
@@ -638,6 +567,77 @@
 			clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names =3D "apb_pclk", "wdog_clk";
 		};
+
+		fsl_mc: fsl-mc@80c000000 {
+			compatible =3D "fsl,qoriq-mc";
+			reg =3D <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
+			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
+			msi-parent =3D <&its>;
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
+			dpmacs {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				dpmac1: dpmac@1 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <1>;
+				};
+
+				dpmac2: dpmac@2 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <2>;
+				};
+
+				dpmac3: dpmac@3 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <3>;
+				};
+
+				dpmac4: dpmac@4 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <4>;
+				};
+
+				dpmac5: dpmac@5 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <5>;
+				};
+
+				dpmac6: dpmac@6 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <6>;
+				};
+
+				dpmac7: dpmac@7 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <7>;
+				};
+
+				dpmac8: dpmac@8 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <8>;
+				};
+
+				dpmac9: dpmac@9 {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <9>;
+				};
+
+				dpmac10: dpmac@a {
+					compatible =3D "fsl,qoriq-mc-dpmac";
+					reg =3D <0xa>;
+				};
+			};
+		};
 	};
=20
 	firmware {
--=20
2.7.4

