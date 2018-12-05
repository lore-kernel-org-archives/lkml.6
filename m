Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CD5C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AE420659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rveN1IAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AE420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeLEKTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:19:04 -0500
Received: from mail-eopbgr10076.outbound.protection.outlook.com ([40.107.1.76]:11306
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbeLEKTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlPy91lQT3odKBByIctpl/C4FjIXaMX/L1iOwj10H7o=;
 b=rveN1IAqHtlandG6ofL8MDXJ08v71o3hlXxesE4MNS0+c29Y2XmbUWwlMBHyG8/OW+O5CvT3lnsUgHC6h2eh65f73hfXYIhUt3Zx6a/SOI/FWvprFQ7xnBv6t5a4Vybq8C+YlXGxsZdHEQjrHwY8JTsr24iDWK6suivsSVS0+h4=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0644.eurprd08.prod.outlook.com (10.163.188.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 10:18:57 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 10:18:57 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v1 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
Thread-Topic: [PATCH v1 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
Thread-Index: AQHUjIPu5G0ecZ3ps0mHJA0fC+KmUQ==
Date:   Wed, 5 Dec 2018 10:18:57 +0000
Message-ID: <20181205101635.7696-3-james.qian.wang@arm.com>
References: <20181205101635.7696-1-james.qian.wang@arm.com>
In-Reply-To: <20181205101635.7696-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYCPR01CA0014.ausprd01.prod.outlook.com
 (2603:10c6:10:31::26) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0644;6:6WBKpTFqCTaQCt9avTl8WxMR5O5PjjPLtyEHzQnVrqtxLGFSgNMqD7J8XCWioi6pUz2Fl8+kW8mhVvTzjELfutTAdLKPclqHGOPLXGYmf8fjViQb7P82p6nwgP1dKCvCLW72ZNG1jjK8YDNvyaK4EuEQ67WRlDwR0P3TfThyRfG2IkexcRZ88PUnoE60+Ru8/2THpgW0PRHw06KYAFfBmeNihHu4Std7Ebr0t2uPa9x3UkKwxE+/JxdSHMThrIrBzoC12H9ksECLt1n2DknLNUETsx7KYyN3xdaHnlnPzrGOKUU0GKQXY+hwa50cVmDv5hxUzRQn8N5W1BRd6eQLzJDLDqAvEI6UDg6YAvuIvsEVf/fqDg/MOjpa2t1nSnReZEnMgTGayYs3curSgb7aGajkpTZzurYomLAJLQwAkqick2sDSbriEKND7JDsFoNrIEjqv/S9RRG9/D4x75sirw==;5:Gh0dicLhb4SGVJ4FoU5QnviW70lJjsu0GJ4ytm6+Vbrzk3dCHiPio/RjHpkwv/VuTa6I3NnlFs2iRdcaDQDU7HJKNmeE05c69199rJb0JsXK9Cws3LZ+5EX+8z6CUdNEAn4YGFAt5l3vv8KbKxN/GSbfb0OepG/HCjozF0UFdmg=;7:G6j/IaUi+5yTGsLp1KoXPFFnznrFT5wknK8PaI0+m7y4okmh5Myur/tUwMPTW0sM1z0ragimY2Cq551ynJCo6qgC+We4G/vh7W4b8YF0LhFU7cGRPaE7ncmLMjSrhzrxDco+rTjqB6U8nEGku4Cp4A==
x-ms-office365-filtering-correlation-id: a8aa8fcd-c099-4928-09df-08d65a9b10d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0644;
x-ms-traffictypediagnostic: AM3PR08MB0644:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB06443AA3244276977E59ACB4B3A80@AM3PR08MB0644.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0644;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0644;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(189003)(199004)(305945005)(6506007)(55236004)(8676002)(2906002)(6636002)(5660300001)(68736007)(102836004)(86362001)(71200400001)(71190400001)(66066001)(386003)(36756003)(1076002)(3846002)(6116002)(26005)(256004)(186003)(14444005)(14454004)(99286004)(486006)(11346002)(6436002)(476003)(446003)(6486002)(6862004)(4326008)(6512007)(53936002)(76176011)(478600001)(103116003)(52116002)(37006003)(8936002)(105586002)(106356001)(54906003)(2616005)(97736004)(25786009)(316002)(81156014)(81166006)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0644;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uSw61omxZDq18F9hnn4sWvsULVuX4EcCurEaZUYbrR410NQq0f4t1EU5t6fERQC2qhfRfcUayFKrXPpHmb6auBhB7lxif1kqN3OLEz7k9ihMORx4UUL2juJru+ZJEzErmHhKhDpPId66X9PXT/RO3glXCEFBw1Dy2Soc1WFHflYCKrca0G4d8aVn+qwHsIqDURdkyZwftpUa7fYkgI2ewj7Hv9SWU83gCJiyC1UmZH2EdRiFqdIx6rj382+KY39BewPoafpOF6hrz4vEWgbNxj63L9B8SQLlgkN7gmc4KfB373r6400kf7IUZ10Kte5Wapt2iFW2HgezuyeNLtM8sHLd8JmPWRj3F2lEJdOIEDA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8aa8fcd-c099-4928-09df-08d65a9b10d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 10:18:57.2507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0644
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

