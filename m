Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DD5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D40B21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UmxogrM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbeLUPbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:31:16 -0500
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:56925
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731074AbeLUPbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgLxbuvJZcf3yQ7cACTLuYwoOpt5DrqhYCGNnThVRAo=;
 b=UmxogrM2uAFPoU9MmhckRx5b6Q8QjRdT7DsdfV4rcLlBjTVl4m5Rx2HKuiNTAiOGp9ccUhK1TWUo1NQbUSrptak/BG8AbnvllROoNEuVI/DFf5vpjD2yMJonNIWxUkV2yNWrPcOKh8u8/wBqtUoD+3HhGG+B2mPGrlboeo5sIYs=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3488.eurprd04.prod.outlook.com (52.134.4.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Fri, 21 Dec 2018 15:31:09 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9%6]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 15:31:09 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2 platforms
Thread-Topic: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
 platforms
Thread-Index: AQHUmUIyF6ylLjPS3UibJyYT5PgWGw==
Date:   Fri, 21 Dec 2018 15:31:09 +0000
Message-ID: <1545406240-3061-2-git-send-email-ioana.ciornei@nxp.com>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0082.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::26) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3488;6:YaSNjSv889VOJyrkFS7X+u0Pcr1Wz6g492X0xDgM8Nw99x2TRAendTLnfl3mUtmcxBGFkpotyDFD1mfImXtcjpY5BEsJg2jtQ4P1qpauHoB4Uu24ibH7fN03/bMfrJ2XlyJnoI+//8oaXuKHH4c3Gt1gOYVLFHphHnNPdHhgwsdXi3YyxooWsVJHuZ0bK8bcLilKbjw6X1Zb2xlmCX0I/9Lv+bPQx4fqQeZNHpMpmUg7fHXAWX+rwjjgQ9Xy1OS9ZxHZF4Q1JpLeNtALUCVOgDxHYPY+k5blLzcJqU0vxyIDCYzHAHTMXNUCiuQI3Jx8Nj5USFMBk2QcsN0CnVyerCA5rl5ICkXXCSpMbwYZwsqCm0dBehGO/zNTyijIlmYRf8lz/cEhXQE4xibuel0B9gWc1wRW/NPVwWKgXbGkhPI92y34U7sx7mO05RVLeaKcAHihGw8x1wUHBnmnqxDhKA==;5:f4YCXJdiqUmF3tRvKk8ENshVC6lyDydG4c9RE7wX6pjZhptduOHyREwgLRJ3X87eakkllkxrZRGBKP+8vyUn8FW8XrrqbLjH/m6oZH3ll5p9seOXMnCSS9Z/iYIp4N8swRw+cyPNh5GDhPmNDhAzM/Hf6gHk7Rdt4A8xaXt+SIo=;7:BVhi1Cpx3EOUu3TxWHlxvSjdE16b56oCEfUy8b+gWmgCcz7M3XiQzLuSz3yyefdiS5DiJoJFU7YLfUac1UHaI2OBmog5Kjxk5Ip2RAdfJYJ4PFzv+oXZswgVZrvHb55WNqXdXb6CR0FWfM9jijnmfg==
x-ms-office365-filtering-correlation-id: c7911344-1ccd-4b8b-59b8-08d6675954fd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3488;
x-ms-traffictypediagnostic: VI1PR0402MB3488:
x-microsoft-antispam-prvs: <VI1PR0402MB3488B9B074FD3F7CB4240F1DE0B80@VI1PR0402MB3488.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3488;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3488;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(6512007)(53936002)(2906002)(71200400001)(71190400001)(575784001)(86362001)(2201001)(26005)(97736004)(256004)(102836004)(6486002)(110136005)(186003)(386003)(68736007)(99286004)(316002)(52116002)(305945005)(446003)(76176011)(36756003)(6116002)(25786009)(11346002)(66066001)(8936002)(105586002)(6436002)(106356001)(2616005)(476003)(54906003)(81166006)(81156014)(14454004)(44832011)(3846002)(6506007)(8676002)(478600001)(5660300001)(486006)(2501003)(4326008)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3488;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ly3GmqiyT2wswRBByp1XXFH/VJrWDFl0ktPgJQunpckLaFUJgYzfcvm7vTrMxRvtvPuWPZYGHDQ6Sq5WeaTbiqUCtf98VyW1X0TpZpBxS7RA5paOfBxCH+7+q/FzqHo/Ac0NydNg+qVR8L9ey8POea0mmf3MWBwYscSlsv22SVIYAMmTC9KZawsedS3A1/NLqDJ+KSO2iUBqjtcnEfcPdiyxRVI1Jpvn4OUU8/uoQdvXBMUsLP4RGGVA90lLgwis9olv+nVTIQ2Ldnbh6zSp7hyg/iyVygORIdSYCNw8JJQh9dBIsz2Wx6Zuuoi5lvMV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7911344-1ccd-4b8b-59b8-08d6675954fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 15:31:09.7956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3488
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dpaa2-console device tree node for the following
DPAA2 based platforms: LS1088A, LS2080A and LS2088A.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 5 +++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1088a.dtsi
index e73e55f..664e337 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -569,6 +569,11 @@
 			clock-names =3D "apb_pclk", "wdog_clk";
 		};
=20
+		dpaa2-console@0x08340020 {
+			compatible =3D "dpaa2-console";
+			reg =3D <0x00000000 0x08340020 0 0x2>;
+		};
+
 		fsl_mc: fsl-mc@80c000000 {
 			compatible =3D "fsl,qoriq-mc";
 			reg =3D <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls208xa.dtsi
index d188774..6db6ea4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -333,6 +333,11 @@
 			};
 		};
=20
+		dpaa2-console@0x08340020 {
+			compatible =3D "dpaa2-console";
+			reg =3D <0x00000000 0x08340020 0 0x2>;
+		};
+
 		fsl_mc: fsl-mc@80c000000 {
 			compatible =3D "fsl,qoriq-mc";
 			reg =3D <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
--=20
1.9.1

