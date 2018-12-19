Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D46C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E53F2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="HrS7woWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeLSMdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:33:18 -0500
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:23447
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728408AbeLSMdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlPy91lQT3odKBByIctpl/C4FjIXaMX/L1iOwj10H7o=;
 b=HrS7woWCQh5jaOwzF2diQsmR/Dkdq6VUnEFowZ080L72ztaZaThk25xEr0TsK2O2iBEm0dYPKcM2IulVogwTB2pk4vCjUma6T4vbtCwAbyzcypeLM/QCJLm24obDXJdSnTSgvyFL8947AKDH55YRaa7W3KtNtZCWtSRVpiBkFCQ=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB4084.eurprd08.prod.outlook.com (20.178.119.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Wed, 19 Dec 2018 12:33:10 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db%5]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 12:33:10 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
Thread-Topic: [PATCH v2 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
Thread-Index: AQHUl5cAOCEuMH0GRUuCne9wdYhyiw==
Date:   Wed, 19 Dec 2018 12:33:09 +0000
Message-ID: <20181219123147.16090-3-james.qian.wang@arm.com>
References: <20181219123147.16090-1-james.qian.wang@arm.com>
In-Reply-To: <20181219123147.16090-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0132.ausprd01.prod.outlook.com
 (2603:10c6:10:5::24) To AM0PR08MB4483.eurprd08.prod.outlook.com
 (2603:10a6:208:145::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB4084;6:jGB+8hNvhh8LuguHB+eCOcWVkNWBJ5Q3M+VA89ky4uVtvgZKVeQzyNFwuQucmCgq6fdQ2zTfWbZ1N5ciEaWsZLUVzB4cHRsp3vzIGqDL/2Cxb7QxEyDohb6uDjXIzw1aur6JcZ47motHGedW1eyJLX8SnhpSSg1+GFPBlRCkaPRJIGCXh8wVjg116RN/nsjB8wUMJ2PletKIOm/p02eSlMjbi4k79T8TOjjYMDbu6XWbdQGHFUvzEMNSoHFQJwW/bfkJ7F0T2O5jTEO7zUrc6w74OOeGzQm7+wZCKiu+kuCPQXkWb/cyCxAQeKsqvyD9I3N2yA9iC1tWnvv78hripUMZxpe60mtTRA1yVNBMRtj4rHhAVgUoDbZs5wHs29/uRnuCvuY4vTl11RO36d6pk1VpXmNXHzt/+dqGqtB034oo/KEgzDON/TXvKUwCLq9IpGKzFBEF0iAg8JNR0M3hjA==;5:LRN44KuE2JWO78BCreJPs7/RPBvsScsyzFgTEMneQOemn1TXM4SNy01TFjZWF/b5jvvcgTQQYi+yCAWyRbrRsmuTvcQ+X2KTsxGPZBov7qUDCo5JsgRO4FTJNKm+4ChLrNjtjtT/UtdYsYQSGHDrgW3Eh7zw4H9GwJYRUeURJ/8=;7:/NEo6PF//w6iC7yMyklPjG4HwU8rbCV5Tesp7I+OOXI4UCxoTi+is30o3CK6mMJj3CrC8zpRSTRRh1FGW6ZuubfMAEKmk2k6ch0g1K0tX5JBRHJEdx6CqUJqnQYD97loaoZhxtFIpW8q2s5M/5HsaA==
x-ms-office365-filtering-correlation-id: 2c964f44-92e9-46ba-119c-08d665ae2264
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB4084;
x-ms-traffictypediagnostic: AM0PR08MB4084:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB40849A11FC7A21DFD3837508B3BE0@AM0PR08MB4084.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB4084;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB4084;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(7736002)(14444005)(256004)(6116002)(3846002)(7416002)(6636002)(305945005)(11346002)(6512007)(446003)(66066001)(6436002)(76176011)(2616005)(52116002)(68736007)(99286004)(8676002)(478600001)(81166006)(25786009)(81156014)(5660300001)(8936002)(71190400001)(71200400001)(14454004)(6486002)(316002)(105586002)(86362001)(186003)(106356001)(97736004)(55236004)(486006)(102836004)(26005)(4326008)(36756003)(1076003)(54906003)(6862004)(37006003)(103116003)(2906002)(476003)(386003)(6506007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4084;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZaA/1aPzDWRr3AXB1S7AuM42gm5Vqqnj0XOK/5wRdFrn9+k47q1cBMRim9C/uAPUYR7sK8NIiFcrM4QglLODoqmhhUvgX69kUEezRMBMF8OlFmndpLNzDgDmR7AKAu0rJjvq4yjl5eNB5LOpilzS3mhnKjyJhvLCyxU96wrnGN7H367e3U9TWVH+0dcnpvl8dPLk65sLiUmmOLGSQ1n4oXIupBtI9VTUQ4wYu82kmcm5pJhoS1O/Uks4rp0Bm3G2sFDYowKSYOGb3Udr70hDtKvijYYOCKB94zyO3ayejmYKZjdWcpuhwRHMVFbBuEEN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c964f44-92e9-46ba-119c-08d665ae2264
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 12:33:09.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings documentation for the ARM display processor D71 and later
IPs.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../bindings/display/arm/arm,komeda.txt       | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/arm/arm,komed=
a.txt

diff --git a/Documentation/devicetree/bindings/display/arm/arm,komeda.txt b=
/Documentation/devicetree/bindings/display/arm/arm,komeda.txt
new file mode 100644
index 000000000000..d4b53c11b2a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/arm/arm,komeda.txt
@@ -0,0 +1,87 @@
+Device Tree bindings for ARM Komeda display driver
+
+Required properties:
+- compatible: Should be "arm,mali-d71"
+- reg: Physical base address and length of the registers in the system
+- interrupts: the interrupt line numbers of the device in the system
+- interrupt-names: contains the names of the IRQs in the order they were
+    provided in the "interrupts" property. Must contain: "DPU".
+- clocks: A list of phandle + clock-specifier pairs, one for each entry
+    in 'clock-names'
+- clock-names: A list of clock names. It should contain:
+      - "pclk": for the APB interface clock
+      - "mclk": for the main processor clock
+- #address-cells: Must be 1
+- #size-cells: Must be 0
+
+Required properties for sub-node: pipeline@nq
+Each device contains one or two pipeline sub-nodes (at least one), each
+pipeline node should provide properties:
+- reg: Zero-indexed identifier for the pipeline
+- clocks: A list of phandle + clock-specifier pairs, one for each entry
+    in 'clock-names'
+- clock-names: should contain:
+      - "aclk": AXI interface clock
+      - "pxclk": pixel clock
+
+- port: each pipeline connect to an encoder input port. The connection is
+    modelled using the OF graph bindings specified in
+    Documentation/devicetree/bindings/graph.txt
+
+Optional properties:
+  - memory-region: phandle to a node describing memory (see
+    Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt)
+    to be used for the framebuffer; if not present, the framebuffer may
+    be located anywhere in memory.
+
+Example:
+/ {
+	...
+
+	dp0: display@c00000 {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		compatible =3D "arm,mali-d71";
+		reg =3D <0xc00000 0x20000>;
+		interrupts =3D <0 168 4>;
+		interrupt-names =3D "DPU";
+		clocks =3D <&dpu_mclk>, <&dpu_aclk>;
+		clock-names =3D "mclk", "pclk";
+
+		pl0: pipeline@0 {
+			clocks =3D <&fpgaosc2>, <&dpu_aclk>;
+			clock-names =3D "pxclk", "aclk";
+			reg =3D <0>;
+
+			ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@0 {
+					reg =3D <0>;
+					dp0_pl0_out: endpoint {
+						remote-endpoint =3D <&db_dvi0_in>;
+					};
+				};
+			};
+		};
+		pl1: pipeline@1 {
+			clocks =3D <&fpgaosc2>, <&dpu_aclk>;
+			clock-names =3D "pxclk", "aclk";
+			reg =3D <1>;
+
+			ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@0 {
+					reg =3D <0>;
+					dp0_pl1_out: endpoint {
+						remote-endpoint =3D <&db_dvi1_in>;
+					};
+				};
+			};
+		};
+	};
+	...
+};
--=20
2.17.1

