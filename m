Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9B3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1051D218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="rIo3zp95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbfAKPTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:19:14 -0500
Received: from mail-eopbgr70093.outbound.protection.outlook.com ([40.107.7.93]:61900
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730170AbfAKPTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9YJ4r+Tkzs2mfsu2uAw8i1/mCA272r3M58fLfR/G4Y=;
 b=rIo3zp95LeXGBO3Y3fCjmdlUyZidg5qzYvPr4aqmiCmsOhkAzwFRSM+ZdZ2rEJdE+5H44nsrNiX0C4o+ODeGTxsFIisUecYJ30zxb7e30/jv2P91DqtliFE5Cc0T/3ruOHdwNwQH/Si30A5juJptguVIln6pnn8uzHbVUa4XBo8=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB3735.eurprd02.prod.outlook.com (52.134.113.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Fri, 11 Jan 2019 15:18:55 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 15:18:55 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v4 1/5] dt-bindings: display: bridge: fork out ti,ds90c185
 from lvds-transmitter
Thread-Topic: [PATCH v4 1/5] dt-bindings: display: bridge: fork out
 ti,ds90c185 from lvds-transmitter
Thread-Index: AQHUqcD3mZQqQIUs9EO69zWCM/1nig==
Date:   Fri, 11 Jan 2019 15:18:55 +0000
Message-ID: <20190111151843.11114-2-peda@axentia.se>
References: <20190111151843.11114-1-peda@axentia.se>
In-Reply-To: <20190111151843.11114-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:7:66::21) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB3735;6:jaC+FM7Nf+MeOk94e3n3CV7YAgSOStfA4UcPulU1ALRE4U1Zb/721XICjOlZ9Pc0U/7MsvVCbtX1xxMmwrPsFmZqcoyqlx6c1rzyis0Qbe42DSmd87Mdf4LHLiSJ2p3GWaz6hOWUKSVfG8pLEV8urJH0qj0FZ6z3vZep6YcwP7lhdnpaO0j/zcU18msJXCZr0JB9skPKPOP7dzM0zEl8kb5sgaE1d5GtMDKjAjpSAxjXDpEumxZ4UCFtDIF/u/yd3tqLDQu7oBZBndlrwVpLCD7zDSoVdh9j9I6GxGsGyD3oVxZYxhZxKawiUlEledflPWXVEteQC6A2fB4vvjaNcFK4jCxzVOTKx/jbJiiSYU7wbUjqSTB3QsiSWlnFipeD9fgZmmCEvOrlABmqNaMfwmNiCrP9aT54omumi5LJt7jeao7c388qOGnv20VXG2EFLh/TkbhFpQcVQksMcxL+BA==;5:uRTVQohJMGDpAlPx0iVDAWohPC4DIzPwZ+0ZinMzRWjEldB/j/9v7CZp3LSTcEZY7LSJ1P6mo59gJ6I1i4O/GtFuGoyPYOetmfg92mro2IPyXLw7AB0XgPOr0jBv9Mq+gMkIzEJyIZ+xvKizXwR/8wd/eh/D3yBEwc8AhoEeq6ZZfNdXwa+jXQpRJPjK29Kr8uXGZ8td5ZfkA1BOEQ702Q==;7:wxY3yBVXLSDErPnGadU5HvvFjaNrJ5s1z5avTx2S6AiLhNA0NdwVVxp38IHJZ1MP17f9fIsjfYaC0/tg8STpbOe5hZVbvgKSOwxWPntNQwdzvId6LlEJ8aOPFNXHHthoV4qRhNSyKTOejFFUDimTXQ==
x-ms-office365-filtering-correlation-id: a17466f9-ee70-45e0-e3f8-08d677d819fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB3735;
x-ms-traffictypediagnostic: AM6PR02MB3735:
x-microsoft-antispam-prvs: <AM6PR02MB3735876FE696343703369C14BC850@AM6PR02MB3735.eurprd02.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39830400003)(189003)(199004)(2501003)(1076003)(14454004)(99286004)(54906003)(508600001)(5640700003)(68736007)(6436002)(97736004)(2906002)(71190400001)(2351001)(106356001)(6486002)(316002)(105586002)(71200400001)(86362001)(386003)(6506007)(102836004)(66066001)(6116002)(52116002)(76176011)(3846002)(6512007)(53936002)(2616005)(11346002)(476003)(446003)(74482002)(8676002)(81156014)(81166006)(186003)(486006)(256004)(26005)(50226002)(8936002)(305945005)(7736002)(5660300001)(6916009)(25786009)(4326008)(36756003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB3735;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p5GctcAxexTtzkJ7YYUjwzLjeV0qSFIsDvjQTyIR/sPlpxr3/0L4h3Gwb2F4+YXUJjrDOpKZ0Nbz8Qxo6VfxGxZbfwtTuG9IdCYq17Bq8/9LiSos6kiU7APM0GTAX8+AoitIb7gjardpv4N29ILp2WjGC3LUwUazW0ExkrVNUM0f3dEhODlB4jNO8hDxAqwwlgngx4VpahOk8kgB5QGa6Y2NhNwNFAXIdPiG0hogtZMJ6JprWh/LC1Fq7EbGAL71UCmNRJYYkPLZugbZvSSpKUn1W5flGzCDFaHK88CSdT2HrH/9M+7whFB2RcBy6nOlrelpwRPBkEFqJFrUQ7xX/QLuQ8rdAFUKsFZoboSzhE9gVofOFI6ivV4x2zASax0FR6DUB482w5ey22oCHTzs36ex8vSdJKjqXF/2/gqdQFI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a17466f9-ee70-45e0-e3f8-08d677d819fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 15:18:54.5703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB3735
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DS90C185 has a shutdown pin which does not fit in the lvds-transmitter
binding, which is meant to be generic.

The sister chip DS90C187 is similar to DS90C185, describe it here as well.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/display/bridge/lvds-transmitter.txt   | 10 ++--
 .../bindings/display/bridge/ti,ds90c185.txt        | 55 ++++++++++++++++++=
++++
 2 files changed, 59 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds9=
0c185.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmit=
ter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter=
.txt
index 50220190c203..bc6960741cb5 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -22,13 +22,11 @@ among others.
=20
 Required properties:
=20
-- compatible: Must be one or more of the following
-  - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
-  - "lvds-encoder" for a generic LVDS encoder device
+- compatible: Must be "lvds-encoder"
=20
-  When compatible with the generic version, nodes must list the
-  device-specific version corresponding to the device first
-  followed by the generic version.
+  Any encoder compatible with this generic binding, but with additional
+  properties not listed here, must list a device specific compatible first
+  followed by this generic compatible.
=20
 Required nodes:
=20
diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.t=
xt b/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
new file mode 100644
index 000000000000..e575f996959a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
@@ -0,0 +1,55 @@
+Texas Instruments FPD-Link (LVDS) Serializer
+--------------------------------------------
+
+The DS90C185 and DS90C187 are low-power serializers for portable
+battery-powered applications that reduces the size of the RGB
+interface between the host GPU and the display.
+
+Required properties:
+
+- compatible: Should be
+  "ti,ds90c185", "lvds-encoder"  for the TI DS90C185 FPD-Link Serializer
+  "ti,ds90c187", "lvds-encoder"  for the TI DS90C187 FPD-Link Serializer
+
+Optional properties:
+
+- powerdown-gpios: Power down control GPIO (the PDB pin, active-low)
+
+Required nodes:
+
+The devices have two video ports. Their connections are modeled using the =
OF
+graph bindings specified in Documentation/devicetree/bindings/graph.txt.
+
+- Video port 0 for parallel input
+- Video port 1 for LVDS output
+
+
+Example
+-------
+
+lvds-encoder {
+	compatible =3D "ti,ds90c185", "lvds-encoder";
+
+	powerdown-gpios =3D <&gpio 17 GPIO_ACTIVE_LOW>;
+
+	ports {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		port@0 {
+			reg =3D <0>;
+
+			lvds_enc_in: endpoint {
+				remote-endpoint =3D <&lcdc_out_rgb>;
+			};
+		};
+
+		port@1 {
+			reg =3D <1>;
+
+			lvds_enc_out: endpoint {
+				remote-endpoint =3D <&lvds_panel_in>;
+			};
+		};
+	};
+};
--=20
2.11.0

