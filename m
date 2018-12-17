Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F34FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F54D2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G9kIZJQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbeLQErs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 23:47:48 -0500
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:16754
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726318AbeLQErs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 23:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HrGtdLoy8eZg+UzIOy5JjS9CUThJU9X1tHxfNm1eY8=;
 b=G9kIZJQ1jJVfQ84fvf/agtlp8pw42WRRi2uOJ5KNtja3UY43KZa9dXMrAq6taqZ6mtiWW61K7+fTVxkzO8kbrdZ517V1WkQL9CM5p2ZMdLVVfU/FxD9EKIhnzU6O5GcX7GO/Ot9zy7AR+wWqlO/7a+q7bmaw8pXKc6n1vUhDTE0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3721.eurprd04.prod.outlook.com (52.134.67.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 04:47:43 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 04:47:43 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "olivier.moysan@st.com" <olivier.moysan@st.com>,
        "masneyb@onstation.org" <masneyb@onstation.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "peda@axentia.se" <peda@axentia.se>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 1/2] dt-bindings: iio: magnetometer: add dt-bindings for
 freescale mag3110
Thread-Topic: [PATCH V5 1/2] dt-bindings: iio: magnetometer: add dt-bindings
 for freescale mag3110
Thread-Index: AQHUlcOklc5L75Ok4Ei6u4K1KZWdZQ==
Date:   Mon, 17 Dec 2018 04:47:40 +0000
Message-ID: <1545021679-4025-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:202:2e::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3721;6:lcqHEl/ob14wBoc5/6DkUDVMIUmxBFKVRIiueK5eZQ8fSxlZ2miiOrvqiRsyZqRhIWN60BFb6VpXLi6SMMGmMG1mfLaUAjVTDlbIh1HW98Sdl5t5nOqlICrojnXZndV3gPB6csbJwCiikNOpQ91qgaHZq7TXGJSn+h+9fk9/dv+zw2z9BemAxgZ4Xue2+QLUOFM4cPypf901oJbh3oY5C9OsBDNhWmKgxi5jpDxUqDXILWwVcB7fWae7nCIgnXW1ldfen5CxDf30Hf8yggbSg5xQ5gYh3WAkrD6WEFjF42etF+6MWdPnz223FJlQ5LSyIY1SPaA+v9wtHl9FGIzeuwGwcfxUOAxrFY8DzzCdAgIQPb5/MDpJXRmqMffKb53AVRUqVvf4LDmpkakCBgxf8HnQCcnC3jskBmIRTyrzlw0dDpCeBy3mLEFq6CgNV9thTAhaSYxB/XQSzTcBIXoC+Q==;5:v+2f8pVNiM7F53pyLa0/oO/7TKiCd4qSFLSvoJ8d95D6/Z14G8UHKMz1QKtxMfsNz/Yyuld17me2IDyokGXJYnA3sH0Y6p3GpQaPy6OHDlPsR2jMTlW0mnYPcJ/UdyXpNadZ+3H9A9VDOG3GLT1chEi6HZ3kdE64AvFlB4H1Utg=;7:AUVXT0TX7uLgMYYkF8ZZM1GA3CepcEDEvOBvm6zVMJK4k5aK2LxcDxu7q/ZneKezCQ+fdLfG7YjR0/j/yHrXKg+yJHs2nt3Q+QowzBNfzsiZRQA5lUxWFPoyDVA0jzi1EbEFtwvGsuUc4Z8M+bP4Og==
x-ms-office365-filtering-correlation-id: a367056e-8949-466c-e283-08d663dac5f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3721;
x-ms-traffictypediagnostic: DB3PR0402MB3721:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB37217F501859AA15F36A4D9BF5BC0@DB3PR0402MB3721.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3721;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3721;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(189003)(199004)(97736004)(256004)(8676002)(39060400002)(81156014)(4326008)(6512007)(105586002)(53936002)(305945005)(7416002)(486006)(2501003)(476003)(106356001)(2616005)(478600001)(5660300001)(66066001)(71200400001)(71190400001)(36756003)(6116002)(3846002)(386003)(6506007)(7736002)(2906002)(50226002)(8936002)(25786009)(6436002)(52116002)(316002)(86362001)(6486002)(575784001)(99286004)(68736007)(186003)(102836004)(14454004)(81166006)(26005)(14444005)(2201001)(110136005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3721;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YsNroGOQSBMk94eJWmCb6q2NGOOpu8J4Zwe+43P/COcFZdiES2lp+PGP52QSzJKJlyOd9vxpkJeomZpAsGG0ePgp8jnQtPC7eR5IhwFUA6XesOsKuzjCHzu50VchxjlZnGZgw23rtssU1qemfnMJ6asBlAfVrWNg+I7692MCJcJ26kBFiNCjeApOlEYQs0ZsupvtLetK9/R5Xok5hN3VVbxMS6DIQCNeYITk0ifaF1coZ6qwrEptobvjkhZxEChfNTf0Pyaa0xdGwCRrE6WyyT1BeH2DXADAixDZbMio2mwHQIEAvETg+8VaHkAdZ9Vn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a367056e-8949-466c-e283-08d663dac5f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 04:47:43.3555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Freescale MAG3110 dt-bindings and remove it from trivial-devices
dt-bingding doc.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../bindings/iio/magnetometer/mag3110.txt          | 27 ++++++++++++++++++=
++++
 .../devicetree/bindings/trivial-devices.txt        |  1 -
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mag3=
110.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/mag3110.txt=
 b/Documentation/devicetree/bindings/iio/magnetometer/mag3110.txt
new file mode 100644
index 0000000..bdd40bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/mag3110.txt
@@ -0,0 +1,27 @@
+* FREESCALE MAG3110 magnetometer sensor
+
+Required properties:
+
+  - compatible : should be "fsl,mag3110"
+  - reg : the I2C address of the magnetometer
+
+Optional properties:
+
+  - interrupts: the sole interrupt generated by the device
+
+  Refer to interrupt-controller/interrupts.txt for generic interrupt clien=
t
+  node bindings.
+
+  - vdd-supply: phandle to the regulator that provides power to the sensor=
.
+  - vddio-supply: phandle to the regulator that provides power to the sens=
or's IO.
+
+Example:
+
+magnetometer@e {
+	compatible =3D "fsl,mag3110";
+	reg =3D <0x0e>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_i2c3_mag3110_int>;
+	interrupt-parent =3D <&gpio3>;
+	interrupts =3D <16 IRQ_TYPE_EDGE_RISING>;
+};
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Docume=
ntation/devicetree/bindings/trivial-devices.txt
index 6ab001f..5f086ac 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -43,7 +43,6 @@ domintech,dmard10	DMARD10: 3-axis Accelerometer
 epson,rx8010		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
 epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
 emmicro,em3027		EM Microelectronic EM3027 Real-time Clock
-fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
 fsl,mma7660		MMA7660FC: 3-Axis Orientation/Motion Detection Sensor
 fsl,mma8450		MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
 fsl,mpl3115		MPL3115: Absolute Digital Pressure Sensor
--=20
2.7.4

