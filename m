Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B6FC43444
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA4F2146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="wkgBtMhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbeL2HIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 02:08:04 -0500
Received: from mail-eopbgr40126.outbound.protection.outlook.com ([40.107.4.126]:48352
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbeL2HIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 02:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ineoprByoCSASSSpNJb8vcCQYRdB+6MyUcDS1Lo/RU=;
 b=wkgBtMhLv3NU7jPXFMLbC7nPfjtF1eOBUr7Ckp1XcuxbSTkktBVAUJMWbW7NXTVaUnzQCQoPlJrmQn5GC106n753JXB3imn9GhrT/rx2UsVrMXr/9uWgbGB9b3v6CfDPUyamBTpPps7hUPwiikBDxnXicjKVC5AbGUQU3m1M0ug=
Received: from AM0PR0202MB3267.eurprd02.prod.outlook.com (52.133.34.148) by
 AM0PR0202MB3459.eurprd02.prod.outlook.com (52.133.35.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Sat, 29 Dec 2018 07:07:19 +0000
Received: from AM0PR0202MB3267.eurprd02.prod.outlook.com
 ([fe80::cdf9:e79c:8ad0:7422]) by AM0PR0202MB3267.eurprd02.prod.outlook.com
 ([fe80::cdf9:e79c:8ad0:7422%5]) with mapi id 15.20.1471.019; Sat, 29 Dec 2018
 07:07:19 +0000
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
Subject: [PATCH v3 1/5] dt-bindings: display: bridge: fork out ti,ds90c185
 from lvds-transmitter
Thread-Topic: [PATCH v3 1/5] dt-bindings: display: bridge: fork out
 ti,ds90c185 from lvds-transmitter
Thread-Index: AQHUn0UjTwFZ5Unco0Sw1517iPZW4g==
Date:   Sat, 29 Dec 2018 07:07:19 +0000
Message-ID: <20181229070649.21308-2-peda@axentia.se>
References: <20181229070649.21308-1-peda@axentia.se>
In-Reply-To: <20181229070649.21308-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0502CA0002.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::12) To AM0PR0202MB3267.eurprd02.prod.outlook.com
 (2603:10a6:208:5::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0202MB3459;6:M7bpl6UvCXkIJOPU9Qfw7MfqKWsOPaN30se0m2Elg4M4UdhEW1IWB1XJ4vPsylCMy5IhDhJoJ3NpNIFOpBEjdc3lmOn7XJzxcTj+Zj8NmW+6BPeePnnq/NLUzryGG8k4xw/6oFWqyvXyAb8qy2T3ClAY7lqJ4lZYF9td83rYcx3bfaoJSTPM9KVRGywLGyg8IEglNtO40S1y6SiEe2lNu60Q6Mrlx36nlBn/NcUIW2yEkYU5BSeZ3AXeU4BUCAd6esjNDJRfsur3vmXHne+BDdPk9aaDHFgEMPqsGC7kOj0QVNzuL75h92eI2TyUVirtUoThkElTPP3uhRVJefBMdwU/y9qE2Snrv84Y4gD1HA/iPNwM8yu46xy37GsoFZQhXUqmrNvp6lT7CMzd2tqswVdUF6YNDvwtmgDTBijVYpUz/ipk/cl1vrwH65OGQfkABG8gt94f7qR56pHdwABn9w==;5:ZiNc1O71NcH5/cjU5wXPZtxI3esbnf9tOFJV5jqjtCx4lJEph0oZ4w2oER855UCtzHQ6RCoAicZLXC7/idq6PuZBk3xELFDP70LoW/Ko+2jJgp/Lf1OsEJWjjJaCcIYo5RTJyJ2Y/f6hfxcb7zVynFXck3HPQElneyTzBNCNymA=;7:rzA7qoHTDD7L5HwH+gmZTyueQJuckGY9VEEAkckDhNG4IMcC06LbmA6X44n/gOlGk1CT/Gx7iYHMulqjyiMpzQOr1v8rYryD7DgloP6GwOlvHrQMvzB8gIlozl2Gvlcr5ToyQuzSfNUWnz0pHxKGlg==
x-ms-office365-filtering-correlation-id: a5e9bb04-a616-4c90-5396-08d66d5c4568
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM0PR0202MB3459;
x-ms-traffictypediagnostic: AM0PR0202MB3459:
x-microsoft-antispam-prvs: <AM0PR0202MB345938F7BE4E689A5E2B4245BCB00@AM0PR0202MB3459.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220055)(2401047)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM0PR0202MB3459;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0202MB3459;
x-forefront-prvs: 09011458FC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(39830400003)(136003)(189003)(199004)(71200400001)(71190400001)(66066001)(6916009)(305945005)(99286004)(8676002)(81166006)(106356001)(6116002)(6436002)(81156014)(7736002)(2616005)(1076003)(86362001)(2906002)(6486002)(8936002)(476003)(74482002)(54906003)(3846002)(256004)(446003)(11346002)(486006)(68736007)(50226002)(186003)(5660300001)(316002)(36756003)(14454004)(6506007)(6512007)(508600001)(76176011)(2351001)(52116002)(97736004)(26005)(4326008)(5640700003)(386003)(25786009)(53936002)(102836004)(105586002)(2501003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR0202MB3459;H:AM0PR0202MB3267.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +5bm+Blk1x9G1h5YRLbnmUkckiSQz0IcASGxbJ1g5EN9Dz6AhDzAuloChrttuA+7FpU6jskqwHE0sAVk+9PtZKcfBkPzMfnEeUqcR80m7SJqJ+c86wDCXeH82OVAZOk1F2y4ve9wllXNkugj70X/vknVZK63uQ1O3olDRQCp5BWko2xtfV14cwGX54w1zZB6w1Rm/6LMuMUIEjPudAfOYSNDduhkDOt86VDOXUY5iDXM95HaSwbrhzDk+Tu1etbjd0gZVrifjSuSrQlDIhJZN5JZYbBFAcZfVsWzJi7EZN8yiaGnxXpJtaZGySlpJVA6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e9bb04-a616-4c90-5396-08d66d5c4568
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2018 07:07:19.2280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0202MB3459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DS90C185 has a shutdown pin which does not fit in the lvds-transmitter
binding, which is meant to be generic.

The sister chip DS90C187 is similar to DS90C185, describe it here as well.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/display/bridge/lvds-transmitter.txt   |  8 +---
 .../bindings/display/bridge/ti,ds90c185.txt        | 55 ++++++++++++++++++=
++++
 2 files changed, 56 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds9=
0c185.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmit=
ter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter=
.txt
index 50220190c203..fd39ad34c383 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -22,13 +22,7 @@ among others.
=20
 Required properties:
=20
-- compatible: Must be one or more of the following
-  - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
-  - "lvds-encoder" for a generic LVDS encoder device
-
-  When compatible with the generic version, nodes must list the
-  device-specific version corresponding to the device first
-  followed by the generic version.
+- compatible: Must be "lvds-encoder"
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

