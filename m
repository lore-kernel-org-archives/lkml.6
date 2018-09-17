Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38619ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56D9208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TBkKWzWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56D9208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbeIQIyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:54:37 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:22121
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729437AbeIQI16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1cwZc2GoqWB7dyJYMHcn2cBewbwFOlNX7qqrTQSDSA=;
 b=TBkKWzWbuBEHt202gdW5WRXBRpx9v1mSOKhAx2TjOtRZWBzz2rMEY9rweE4sTUoXyCWHrrJliWtN3EzuHPa5JZNaMS/AXUu5C8DK+O+nzRKiL9IUDxQAqG6LLbxx0AMSamVWISyTpaY1l0dqHfUjcaVG4Q8TZ8FRljd41M1XvVc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 105/136] arm64: dts: renesas: Fix VSPD registers
 range
Thread-Topic: [PATCH AUTOSEL 4.18 105/136] arm64: dts: renesas: Fix VSPD
 registers range
Thread-Index: AQHUTjK0vMmYgZoRVUa/9mdqPOu+WQ==
Date:   Mon, 17 Sep 2018 03:01:18 +0000
Message-ID: <20180917030006.245495-105-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:yhfuIni/Ubk9TADmSQb0qN7WHsZhjcY+WiFAd4bLfZ5n8pefE0Qb6W3i8wqETDtH6QiBSVkF+NDsT7o5uYFooVVFmimmKtQHbRaAW3CJSJNekQN9yUaIATG4Iz+fOnGiQTJyWmQaSTjXqaxrJf1lMzvdOr4nf1BNJJmAQc4dyE5/+FK9yuw5FGDdX3QAWGHgwp52C1BTaiKKqFjXkn9q6Bae675NAPNg5wKeVwQMOQORnXrFs3ntorMKi2WsGDKIaMJXV78tCMRaF4TSvyLePqdgFXRxP7wjF6a6GwXz9jyLG1KMajVgc/bld/dfJecI/+7lM1hPAmE0rbNEksdjwSmY453tYzHslQkRGPmS+fPkZbc0ii9rsAziayW+47fJW7wFnsqesdze4J86NtlI8zv4773xOlnjd2c+VAm7kqNFvDCpzEOvH7x7cui3cVuplXuYwu+anKQvdIUel4IWuw==;5:G+T0UxjqTHq1ZDNs7KK0EkJ5GjlmZ67BtK1G81XXeojlG0S9vJiOXTKiyNKaxypLTcddhYAXTwqzVEPWvk3gqB161rWk5WsnR8ezZzwy8yi0KzgY45aCR2IKwepNLTw6jZr6Aqgs7GyTHMvKZc2gXWk56VNw69309Jsi2bbYr4M=;7:nL1y09hw/OFzJb3lizuwOAtyXfhvFzCxntDZNPKP7KpLnrJgtlHx0dY3uklTINaDLGKviRTAWkvc04D+pwjMlIOqfkOuMFZgF9y2CPQHPECrrnOcR9Po0CzfKZ2cGS3eJJCcFfP/ihSMWXltfgYSycmR+fE/wbEo42bOnPWLOWpyttNUyaN0NbFeiAMFaDabBuH7PQqtZy3VVjfA9gMhiVfZ3cu0UBNG2x85tmuGyxVI8nEEHKSb3eTcNui0jb8P
x-ms-office365-filtering-correlation-id: 41a255cc-96c6-462c-db95-08d61c4a0921
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB0168435BC9B65B995ABAEFDCFB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(575784001)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6512007)(2501003)(5250100002)(2900100001)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: y0cGMFJg5ZZ8ZoHZ5Kg3aW8yweDlI+a2o17AJIftwp/CUltmYJDvLOPzug4aVW9AFHrz6h0Z/2fp9EuAMvCk9fsh+DkfqSgVayke4WmSQIpe4IojyHKu5IU61l2uoFqL5R0iMlfHVykLr5vVpYwz4J7puOe5Q8WSV2yJvbVMbO/ejjFQ3tzeODsJ3qCBn5O2zJHmkYBMG7HuT3tNG9+117y2Gnr/7Dmzo4lzu2XNwAA9taGUxkNCgrAKo4qktOpMOYiLoCBFZPAQqS4fPXM5Vwjs184GFPREsyoYGFi7rJWf/anUmjOU/adO9x04DP0LhZOZ6i4cLykRSDm+CF8/91blW8G+GvHmHs2z1KOLSfk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a255cc-96c6-462c-db95-08d61c4a0921
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:18.5729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

[ Upstream commit e21adc781bb45e810f1c396c4bc2c1624a4c25b9 ]

The VSPD and FCPVD nodes have overlapping register ranges, as the FCPVD
devices are mapped in the memory range usually used by the VSP LUT and
CLU, which are not present in the VSPD. Fix this by shortening the VSPD
registers range to 0x5000.

Fixes: 9f8573e38a0b ("arm64: dts: renesas: r8a7795: Add VSP instances")
Fixes: 291e0c4994d0 ("arm64: dts: r8a7795: Add support for R-Car H3 ES2.0")
Fixes: f06ffdfbdd90 ("arm64: dts: r8a7796: Add VSP instances")
Fixes: b4f92030d5d3 ("arm64: dts: renesas: r8a77970: add VSPD support")
Fixes: 295952a183d3 ("arm64: dts: renesas: r8a77995: add VSP instances")
Fixes: 85cb3229218a ("arm64: dts: renesas: r8a77965: Add VSP instances")
Reported-by: Simon Horman <horms+renesas@verge.net.au>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 6 +++---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi     | 6 +++---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi    | 4 ++--
 arch/arm64/boot/dts/renesas/r8a77970.dtsi    | 2 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi    | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot=
/dts/renesas/r8a7795-es1.dtsi
index e19dcd6cb767..0a42b016f257 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -80,7 +80,7 @@
=20
 	vspd3: vsp@fea38000 {
 		compatible =3D "renesas,vsp2";
-		reg =3D <0 0xfea38000 0 0x8000>;
+		reg =3D <0 0xfea38000 0 0x5000>;
 		interrupts =3D <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
 		clocks =3D <&cpg CPG_MOD 620>;
 		power-domains =3D <&sysc R8A7795_PD_ALWAYS_ON>;
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts=
/renesas/r8a7795.dtsi
index d842940b2f43..91c392f879f9 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2530,7 +2530,7 @@
=20
 		vspd0: vsp@fea20000 {
 			compatible =3D "renesas,vsp2";
-			reg =3D <0 0xfea20000 0 0x8000>;
+			reg =3D <0 0xfea20000 0 0x5000>;
 			interrupts =3D <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =3D <&cpg CPG_MOD 623>;
 			power-domains =3D <&sysc R8A7795_PD_ALWAYS_ON>;
@@ -2541,7 +2541,7 @@
=20
 		vspd1: vsp@fea28000 {
 			compatible =3D "renesas,vsp2";
-			reg =3D <0 0xfea28000 0 0x8000>;
+			reg =3D <0 0xfea28000 0 0x5000>;
 			interrupts =3D <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =3D <&cpg CPG_MOD 622>;
 			power-domains =3D <&sysc R8A7795_PD_ALWAYS_ON>;
@@ -2552,7 +2552,7 @@
=20
 		vspd2: vsp@fea30000 {
 			compatible =3D "renesas,vsp2";
-			reg =3D <0 0xfea30000 0 0x8000>;
+			reg =3D <0 0xfea30000 0 0x5000>;
 			interrupts =3D <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =3D <&cpg CPG_MOD 621>;
 			power-domains =3D <&sysc R8A7795_PD_ALWAYS_ON>;
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts=
/renesas/r8a7796.dtsi
index 7c25be6b5af3..a3653f9f4627 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -2212,7 +2212,7 @@
=20
 		vspd0: vsp@fea20000 {
 			compatible =3D "renesas,vsp2";
-			reg =3D <0 0xfea20000 0 0x8000>;
+			reg =3D <0 0xfea20000 0 0x5000>;
 			interrupts =3D <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =3D <&cpg CPG_MOD 623>;
 			power-domains =3D <&sysc R8A7796_PD_ALWAYS_ON>;
@@ -2223,7 +2223,7 @@
=20
 		vspd1: vsp@fea28000 {
 			compatible =3D "renesas,vsp2";
-			reg =3D <0 0xfea28000 0 0x8000>;
+			reg =3D <0 0xfea28000 0 0x5000>;
 			interrupts =3D <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =3D <&cpg CPG_MOD 622>;
 			power-domains =3D <&sysc R8A7796_PD_ALWAYS_ON>;
@@ -2234,7 +2234,7 @@
=20
 		vspd2: vsp@fea30000 {
 			compatible =3D "renesas,vsp2";
-			reg =3D <0 0xfea30000 0 0x8000>;
+			reg =3D <0 0xfea30000 0 0x5000>;
 			interrupts =3D <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =3D <&cpg CPG_MOD 621>;
 			power-domains =3D <&sysc R8A7796_PD_ALWAYS_ON>;
diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dt=
s/renesas/r8a77965.dtsi
index 486aecacb22a..ca618228fce1 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1397,7 +1397,7 @@
=20
 		vspd0: vsp@fea20000 {
 			compatible =3D "renesas,vsp2";
-			reg =3D <0 0xfea20000 0 0x8000>;
+			reg =3D <0 0xfea20000 0 0x5000>;
 			interrupts =3D <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =3D <&cpg CPG_MOD 623>;
 			power-domains =3D <&sysc R8A77965_PD_ALWAYS_ON>;
@@ -1416,7 +1416,7 @@
=20
 		vspd1: vsp@fea28000 {
 			compatible =3D "renesas,vsp2";
-			reg =3D <0 0xfea28000 0 0x8000>;
+			reg =3D <0 0xfea28000 0 0x5000>;
 			interrupts =3D <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =3D <&cpg CPG_MOD 622>;
 			power-domains =3D <&sysc R8A77965_PD_ALWAYS_ON>;
diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dt=
s/renesas/r8a77970.dtsi
index 98a2317a16c4..89dc4e343b7c 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -776,7 +776,7 @@
=20
 		vspd0: vsp@fea20000 {
 			compatible =3D "renesas,vsp2";
-			reg =3D <0 0xfea20000 0 0x8000>;
+			reg =3D <0 0xfea20000 0 0x5000>;
 			interrupts =3D <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =3D <&cpg CPG_MOD 623>;
 			power-domains =3D <&sysc R8A77970_PD_ALWAYS_ON>;
diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dt=
s/renesas/r8a77995.dtsi
index 2506f46293e8..ac9aadf2723c 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -699,7 +699,7 @@
=20
 		vspd0: vsp@fea20000 {
 			compatible =3D "renesas,vsp2";
-			reg =3D <0 0xfea20000 0 0x8000>;
+			reg =3D <0 0xfea20000 0 0x5000>;
 			interrupts =3D <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =3D <&cpg CPG_MOD 623>;
 			power-domains =3D <&sysc R8A77995_PD_ALWAYS_ON>;
@@ -709,7 +709,7 @@
=20
 		vspd1: vsp@fea28000 {
 			compatible =3D "renesas,vsp2";
-			reg =3D <0 0xfea28000 0 0x8000>;
+			reg =3D <0 0xfea28000 0 0x5000>;
 			interrupts =3D <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =3D <&cpg CPG_MOD 622>;
 			power-domains =3D <&sysc R8A77995_PD_ALWAYS_ON>;
--=20
2.17.1
