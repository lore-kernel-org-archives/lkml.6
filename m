Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89007C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4373320578
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gblVY1D9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfACLkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:40:11 -0500
Received: from mail-eopbgr30079.outbound.protection.outlook.com ([40.107.3.79]:33292
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730324AbfACLkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1XQmbL2MFf3kQsLtSuP+3Ovn6DFXnAtZHCnBfr+qO8=;
 b=gblVY1D94ag+pW6Dh73ALFtyGVezV1SnyHyYbrmjTSEK8NIvv30WGA67eGV1YTJN8xlJMtkErdq4nU+YsybHZc6EAMyg5nPVLARghtAAP7L+CKODIbOLW1feGpX981KA0XGgJ7KATeibmM0ge4sjoeASvDYz6P+nPHi//rDglZU=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0658.eurprd08.prod.outlook.com (10.163.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 11:40:05 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 11:40:05 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
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
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v4 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
Thread-Topic: [PATCH v4 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
Thread-Index: AQHUo1kR3aloiKD41Uys9n4X8zOt2A==
Date:   Thu, 3 Jan 2019 11:40:04 +0000
Message-ID: <20190103113841.15403-3-james.qian.wang@arm.com>
References: <20190103113841.15403-1-james.qian.wang@arm.com>
In-Reply-To: <20190103113841.15403-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY2PR01CA0046.ausprd01.prod.outlook.com
 (2603:10c6:1:15::34) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0658;6:1GDtTJAiGo7+z3it8N9D3ub3D/j/dKnC4xWP5AvTqC5P7qApWtk4Eksj22SRY2QK+LUh4rWYk3wS2nxUokZ/pHeJdRsAQX4SZDZz/gLtN4dFBLWn2UP+8odvrJ5LOMPXkTlKPkiNVVNbQlaYjajTpXZHakCtN14OZL4y9V09cgJ1alzyzymX5bNxqKeVZvC/95f0FhZ1ZY3QthQZsCmcGF1dMWBcnzGRfpCd2Peutj6SQGjTSfZhqBN7XdolJ0xRtZV33Ps02bwJbR+AgHmhgfiCyLwwcXJdkn1ESXAfMsEr3Jj5wcFkWinumBsieF9hpSrmqyItqOzDxNOKXRML19rLTPeJ+Std5fpqjME+fQxodPTWHlTKryXS89tfh6Y2R0R4+WnCxFSe/qsDiSPgyjgBG7KTHy7NyBySEoyXzZlzHTTl3mJ2dVxtw6XAfhSEADyCg8nqiTdvaOhSkc678w==;5:YkCAiNT6bjYaBSCuNjqr1FzHFI6wPXfYs+ieyBcKZ8hc4eZOEa29MuZ24HEhAYJr4NanrPvgI1j9O5SPLcy3Ci4iK65fiEj5pXErDCOrx6C/HaXzX9NyxEk+UrIl4uKqh6oanwD6bHp2kk6YYNPqDZeW6ihMhKaZNfK1gy/Wir9ln+GhhLBgmcwu4iwNeHZ0iStW212sbJ85nYb/YlQwpw==;7:Ds/P0nqykewOD6KOMFbw4+j4PV2+pY+jqOHtgwrGuOXtiQIv8s94TfVX2BoMJuLAoAqjwEOR3WZBmQEvsVF7zoYQfCx3tWpHh0vEgZEDgKsN0PkFEti4TLMgGhZDMGBld1lbOVoOK18TamLduMM0fg==
x-ms-office365-filtering-correlation-id: 295b4777-ff29-4fbc-d8aa-08d671703431
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0658;
x-ms-traffictypediagnostic: AM3PR08MB0658:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB065854FA461B7B8020EAA1D8B38D0@AM3PR08MB0658.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0658;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0658;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(366004)(376002)(199004)(189003)(71190400001)(8936002)(316002)(8676002)(71200400001)(6486002)(256004)(81166006)(186003)(6436002)(76176011)(81156014)(86362001)(99286004)(52116002)(478600001)(26005)(2501003)(2201001)(14454004)(55236004)(106356001)(105586002)(386003)(102836004)(6506007)(6116002)(3846002)(103116003)(5660300001)(7416002)(2906002)(36756003)(486006)(66066001)(25786009)(97736004)(4326008)(54906003)(446003)(305945005)(7736002)(1076003)(110136005)(68736007)(476003)(2616005)(11346002)(53936002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0658;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RiqskkCV/P+In5R4lgzlnFvOz30LbLfyLkxGjzOWQYKSPVHevShbu3yi+K6RXl1ImSFb1ivKJqOJ+gP7K2FKjkpLYSF+5Z8CRXbnAptyCLa3QofnpOqu65bg+sD/HOk3dTrkhmO7WjPwYabv66nrai1v7zDbeJ4ASMeKU7mie/4pER6+g9w4xotqTm9igH/Hhf8MsdxCMVVYg+FwW0reyP+w37G3KV93tnM2MiYEdXcIqIopdx4RoLVvVPjb3xXKZjMyj2zdJ/eH4yfYUVv5KMI0byPRxBLw6UWG8N4Txqh1Hc7ZqIMsdjtwJ5Vs1Y1E
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295b4777-ff29-4fbc-d8aa-08d671703431
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 11:40:04.9595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

Add DT bindings documentation for the ARM display processor D71 and later
IPs.

Changes in v4:
- Deleted unnecessary address-cells, size-cells [Liviu Dudau]

Changes in v3:
- Deleted unnecessary property: interrupt-names.
- Dropped 'ports' and moving 'port' up a level.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 .../bindings/display/arm/arm,komeda.txt       | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/arm/arm,komed=
a.txt

diff --git a/Documentation/devicetree/bindings/display/arm/arm,komeda.txt b=
/Documentation/devicetree/bindings/display/arm/arm,komeda.txt
new file mode 100644
index 000000000000..919d651d3e8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/arm/arm,komeda.txt
@@ -0,0 +1,73 @@
+Device Tree bindings for Arm Komeda display driver
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

