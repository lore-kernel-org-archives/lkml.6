Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334DBC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C492183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CH8j5bjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfAKGWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:22:47 -0500
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:19896
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728042AbfAKGWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=va6EszgpMG1pBMAICVzHE2KsRLN2Z9bm0ddaZ186U5Y=;
 b=CH8j5bjVAOY2tDgRK1d1aPMj3F3dw6n4afqhGK7TMX1Bt9L5dRqumRBKj09odTHFTh3MFbGvl6xPTFS7qt4shqrwYEjfe9ZkaN/S7om1620UKJsm6fG1K2Ro4JHRC8bBdJwKyMmJWpw9bzc8NnYJ8/ywX0/fjqQ1gHkxw22uMY8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3788.eurprd04.prod.outlook.com (52.134.72.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 11 Jan 2019 06:22:40 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 06:22:40 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 1/3] dt-bindings: fsl: add imx7ulp system integration
 module binding
Thread-Topic: [PATCH V2 1/3] dt-bindings: fsl: add imx7ulp system integration
 module binding
Thread-Index: AQHUqXYN+J7GKpm380y3RHGstkMQ5g==
Date:   Fri, 11 Jan 2019 06:22:40 +0000
Message-ID: <1547187469-14046-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0090.apcprd04.prod.outlook.com
 (2603:1096:202:15::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3788;6:fU7FA9XjZouFS0oz0RbkNV1Cpy2v6K5q9Y6Al4zwSo7wbREGjAYXIFYiymY/2L6T83ILdsupcN5SY5Eg74ahbQro/LuKRML048wtPFtURwOGdLPO/Mnc3ZbAaOI1O1zF77qjeKMU9wvw/gZcVKhjpqEanDZcFs9aEeUV0F3TpRE1D8hd9sLiQlT2ZsqwGfSaPf5BV+u9VWB0sgDrWmqwWrp+lLlHP2DuXyqLUK524fweQn49QC7N0JcIVFzgB0Fk2Si13/l/sTdtldjGoDOOYQNhfsqhWLfc9MQDKYvwBj5sVlkgBkUHIqwJPQqN9+9X/A8IW08fJ7lnYdAsHlP2QAqLdd0FsDHNZL4r0GwoHV8KMNRIL9YUqGQJG7a6Af8IKctnrjdgkInnt9Yc+KIyhwpacI3bjjRUzc/Mouv0GCk5xPU4JD4BvOaEfnHOkERXZAOcI4ONqo/04zbBhnGBUg==;5:FWF7euROZU5HzwPZrLfGiaHoJRknC3Rx7AvUBiSqNvvUdBqAWtTKpSxwoc1wbKKBjuYdxOEj+A4o/ivsbAvN9NtGlGNbc3oI4MdIG1AYH9pW7x7Ksjv4sxfpZvfWNdiHJoXMbJeAfMaDjJqXqjl1m+ermOAMDmkkrK2//AOqaQsjvnqI3TMRCg2Q01UDiSvt/RkIPPX+gJzpNjOCM9W4Jg==;7:3aakN36QGcTJ+EP6a/Q8SmSy+tdXpSZdgqNlTx+n2Z88WGR6YEM5BCePduYMQ17V/uYIsEdmNq4SHRj9/8J0PyuyGDqKz5QX51Bir+Joj/FyFG19oWRQzRUhRLffDrtSRcxSST6v4vtTjspCrsWqkA==
x-ms-office365-filtering-correlation-id: 90c2f8fd-ffdb-4ed1-5a27-08d6778d3019
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3788;
x-ms-traffictypediagnostic: DB3PR0402MB3788:
x-microsoft-antispam-prvs: <DB3PR0402MB3788820BD47278EC80F081DEF5850@DB3PR0402MB3788.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(4326008)(486006)(106356001)(105586002)(53936002)(316002)(2616005)(102836004)(2906002)(25786009)(26005)(99286004)(186003)(386003)(6506007)(97736004)(6512007)(6486002)(52116002)(71190400001)(71200400001)(256004)(2501003)(305945005)(478600001)(7736002)(36756003)(14454004)(6436002)(6116002)(66066001)(476003)(3846002)(5660300001)(81156014)(68736007)(81166006)(8936002)(575784001)(86362001)(8676002)(50226002)(110136005)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3788;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GkeVI5JRa7ORV0tfU506li4hOOWf5J6/gtxa3uSr1YOdTVFYGlk7f2tR8MxTHwJ1i8xtlOyqPH3jBH9OrdGrwlwYSU0bJUptQN5O1P51Cf/0LsO+KzYiRLmSFaNeY7Jk9Gaue3dyvI0ccUBtSznDi0TCakiS27XswOT+uIjjWkrPFRJhBvGI5b0HqeWflKAB7pl6iS9d2P5+MUolVQS/1XiFs9twvnFs8mfbFY5wbyhq+qeiw6c1BPin/DZRE8YLhrdLNN5ldmQW3f0vj6pNv8VdXZJKOGxt36YiwtAvIWciKvEgWlKR9VdtTGJ17NQl/Z4trJJzlNNFjh0ROEhpa8CNEXcKfB2+jtBE/QHq1IopToxcqt0XttJf/voGcV10NcilLdrkHBTRFickvo0kf1Mes81X47ybj6x/GE9JXSE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c2f8fd-ffdb-4ed1-5a27-08d6778d3019
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 06:22:34.2925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7ULP system integration module (SIM) binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../bindings/arm/freescale/fsl,imx7ulp-sim.txt           | 16 ++++++++++++=
++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx=
7ulp-sim.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-si=
m.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.txt
new file mode 100644
index 0000000..7d0c7f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.txt
@@ -0,0 +1,16 @@
+Freescale i.MX7ULP System Integration Module
+----------------------------------------------
+The system integration module (SIM) provides system control and chip confi=
guration
+registers. In this module, chip revision information is located in JTAG ID=
 register,
+and a set of registers have been made available in DGO domain for SW use, =
with the
+objective to maintain its value between system resets.
+
+Required properties:
+- compatible:	Should be "fsl,imx7ulp-sim".
+- reg:		Specifies base physical address and size of the register sets.
+
+Example:
+sim: sim@410a3000 {
+	compatible =3D "fsl,imx7ulp-sim", "syscon";
+	reg =3D <0x410a3000 0x1000>;
+};
--=20
2.7.4

