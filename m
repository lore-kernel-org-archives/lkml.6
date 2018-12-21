Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF1FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8FA21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hbqJ8zUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbeLUJ7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:59:51 -0500
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:22326
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729268AbeLUJ7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNeKExCutgOK38V9MkPTTIC1w4o2zbdxUb5j/rfZDw0=;
 b=hbqJ8zUHWTl29ihYL+8LNV7uDSyUhRzbhwgG4wYgYEVExooz/xEWuQgJ7HX67ce74TnH3+bM3m7v/e+bxP1RTcf/3Go8lrhnWxSRvQEDB56SSakx1M/POpgxw/NY12vqNNF0eO0p5DzMY+YDOr8AAuwRMn4eUA0XDIkOLX3/UDI=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB3187.eurprd08.prod.outlook.com (52.134.93.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 09:59:12 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db%5]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 09:59:12 +0000
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
Subject: [PATCH v3 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
Thread-Topic: [PATCH v3 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
Thread-Index: AQHUmRPTBdPt1uc570uDsKJLIqlNSA==
Date:   Fri, 21 Dec 2018 09:59:12 +0000
Message-ID: <20181221095757.15510-3-james.qian.wang@arm.com>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
In-Reply-To: <20181221095757.15510-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY3PR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:0:19::32) To AM0PR08MB4483.eurprd08.prod.outlook.com
 (2603:10a6:208:145::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3187;6:9ifAP2FrWlnX0nTBZl0Jg1fkqF6d4W2lh6jlbNi0PISVrm3S+asK0VUOdcKrwt6wwRb9qFNS3LjfoCpGV6Cc+L4lt2o/Be6z4Ql8K1Cg24jG3Rrw34Ln4ONnihUHjDf6Pp7dafiqdOpmeYyjx3qH3IGVKet+1KsNK4Ta0kdMOl2btObOY5E0TN3nxj9R9HkNpMrtxN016DWWXeJ8GkTGSz8IbUdINrm61WJBTV0ro8gWkSux4nh+n9UXPyC2GebXPT+6KGzIqtwz2RirmCgE52V43HJCX2WC7YDM+WL89Ih49vX+BWO11PvspMBomRU/dWKk39LovTjZA+tbrL5qBiAG9sUaj6k7oi3hr21yv6h0D+6WPhY0CGcXL80qQhhnQx2PGJYnWtmwqET2UqjBC2MPX0TfSwkbrfh1LwI6B6AMqVvxFdKj5+IXqo98Rm8VWoLR+JSIiv9r7gdUpebc/A==;5:2m2e8zwEAN7q/ahhy/Q1zAL9hDLjimW+4yfkiIfS7gPS0S/dlRJI4UZHhPOJtPDwCUvafdIGMfw7tOTnDy5EewNhOmVo0iPdxkr8I4Gxoi3eFBX25zC/OF3/hlLLE7NZ5Fh+ahxAspqkpdZBhiaobhdGAFCbPKr5SxgN4j7bvmk=;7:bYUG06WAgj8ISQV5QjUUxhvDB3wLoAPXDF66ev/GXitM9pgjC4oWTroiSSBrG6Ep//0vsDTTJHnKoUYM0kwJBQkjzlH0hZSrConqrc3RxMLMYQGIODDP6AFl3Xlx6eyFfaFeQe6u/ux+NaKjl3+aKA==
x-ms-office365-filtering-correlation-id: fdfb71a1-5b1a-4c56-f020-08d6672af552
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3187;
x-ms-traffictypediagnostic: AM0PR08MB3187:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB31879D21F8B5BB9CA8CC0BB6B3B80@AM0PR08MB3187.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3187;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3187;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(366004)(189003)(199004)(71200400001)(97736004)(71190400001)(103116003)(86362001)(14454004)(2906002)(5660300001)(106356001)(6116002)(105586002)(66066001)(54906003)(6636002)(3846002)(37006003)(99286004)(68736007)(478600001)(25786009)(6486002)(7736002)(36756003)(6436002)(76176011)(316002)(186003)(386003)(6506007)(55236004)(1076003)(26005)(6512007)(256004)(6862004)(52116002)(81156014)(476003)(486006)(81166006)(7416002)(102836004)(8676002)(305945005)(2616005)(8936002)(53936002)(4326008)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3187;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Mg+TS1idSpEEqw/XW8IiRaZnoZqbaqbJO3mot4xHfOx5WAASYiQWMWjrWen/RPXjnBG3LNtmP8AjlySqJ5FFiYUKWRzggUblYVVOpqrhVDspsi4M1yAwGqPQ+mOlUZHbFebX0O95jAK1CsTZIDdKAZq9y/lnAo+PdkL3pZmQWnsuzoaxwSvs8NZilI5Cu/NoQ9ITMRnhR+GdC08PA/W/m9dgNWIx3suirii3zKevHdWsjiLynwAkHY94QrRp9+xeGBa3jDvvM28SpJBgpWNdidI+KZz+mz+HpVHIxCFAGmIZ90NcRG1lrzCZ/pZRD8wX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfb71a1-5b1a-4c56-f020-08d6672af552
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 09:59:12.5077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings documentation for the ARM display processor D71 and later
IPs.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>

Changes in v3:
- Deleted unnecessary property: interrupt-names.
- Dropped 'ports' and moving 'port' up a level.
---
 .../bindings/display/arm/arm,komeda.txt       | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/arm/arm,komed=
a.txt

diff --git a/Documentation/devicetree/bindings/display/arm/arm,komeda.txt b=
/Documentation/devicetree/bindings/display/arm/arm,komeda.txt
new file mode 100644
index 000000000000..b4e450243c7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/arm/arm,komeda.txt
@@ -0,0 +1,79 @@
+Device Tree bindings for ARM Komeda display driver
+
+Required properties:
+- compatible: Should be "arm,mali-d71"
+- reg: Physical base address and length of the registers in the system
+- interrupts: the interrupt line number of the device in the system
+- clocks: A list of phandle + clock-specifier pairs, one for each entry
+    in 'clock-names'
+- clock-names: A list of clock names. It should contain:
+      - "mclk": for the main processor clock
+      - "pclk": for the APB interface clock
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
+      - "pxclk": pixel clock
+      - "aclk": AXI interface clock
+
+- port: each pipeline connect to an encoder input port. The connection is
+    modeled using the OF graph bindings specified in
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
+		clocks =3D <&dpu_mclk>, <&dpu_aclk>;
+		clock-names =3D "mclk", "pclk";
+
+		dp0_pipe0: pipeline@0 {
+			clocks =3D <&fpgaosc2>, <&dpu_aclk>;
+			clock-names =3D "pxclk", "aclk";
+			reg =3D <0>;
+
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+
+			port@0 {
+				dp0_pipe0_out: endpoint {
+					remote-endpoint =3D <&db_dvi0_in>;
+				};
+			};
+		};
+
+		dp0_pipe1: pipeline@1 {
+			clocks =3D <&fpgaosc2>, <&dpu_aclk>;
+			clock-names =3D "pxclk", "aclk";
+			reg =3D <1>;
+
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+
+			port@0 {
+				dp0_pipe1_out: endpoint {
+					remote-endpoint =3D <&db_dvi1_in>;
+				};
+			};
+		};
+	};
+	...
+};
--=20
2.17.1

