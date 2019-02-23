Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7186C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB3B206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tW68+OJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfBWDTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:19:49 -0500
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:51808
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfBWDTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 22:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29jKVA1O7T+TQjOP1RYrhmq68HKrX4S93JGlP0REPyI=;
 b=tW68+OJGSIq2qwz7A39BVNzY/10gZm49sE56aNS/2wZh6RTcF/EGheQaxLYq52qy3WmFXYxDzv3gnKPQzVSd4NVty378GPaCWbY+F+Of/DnGpm19rwE3urSiH3h52LzyQgkasNFPg9Ye/u5XkGiAWdXykejGpHEbFBugOinklJc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Sat, 23 Feb 2019 03:19:03 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Sat, 23 Feb 2019
 03:19:03 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 1/2] clk: imx8mq: add GPIO clocks to clock tree
Thread-Topic: [PATCH V2 1/2] clk: imx8mq: add GPIO clocks to clock tree
Thread-Index: AQHUyyaGRBH6PMV7RkGGfcdev8mMpA==
Date:   Sat, 23 Feb 2019 03:19:03 +0000
Message-ID: <1550891665-29082-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0082.apcprd04.prod.outlook.com
 (2603:1096:202:15::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebaf8d05-7fb5-4eb2-cd57-08d6993da91a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3659;23:X0ofPE9jMxdL+XKG1pmtTCp3+wKiVQtzefSQQ?=
 =?iso-8859-1?Q?Yls5VFyYG5zLXz15qg0Xs5Su9H4ek7Kv2GZT1QsQfrWX+af8ZQEMVGVvU9?=
 =?iso-8859-1?Q?zJu6DaiJ4RhQd+TU0XVip+3oX3s7u91HLdj1A4JtW+v+XvMG/6cmkGz4ic?=
 =?iso-8859-1?Q?g0Fc9LcdkOYnBxcUFzeIWRsnbCdbqWTqvGIJ5RXH8Ndeia6H930hWGvThO?=
 =?iso-8859-1?Q?SHPR8YZj2BPf+GeGkq733/ZA1vXpRiImYFwYS9P6A0ejAcx+F/53BHecOd?=
 =?iso-8859-1?Q?qsAkskYHN/yRFICGOLtR4cgALMsyTKZK4KDhNJiyuTzZHiX0KkzeAfGbis?=
 =?iso-8859-1?Q?rHQYQf6GP95nzl6mzFn3V9xL0GaHfJNzd+qSm3ecuMt+tiXzYt+NESyQWj?=
 =?iso-8859-1?Q?0PaXj5F1YknwTYAU42+3QhWU0AWQmlCR0bxeg8/rh6/UOuAeQfimWyv/rY?=
 =?iso-8859-1?Q?h9CrBTGmUs5zC3jdC+0l5m/2DcFpbm4RMCfYNN9ST3xOw1SkdOVsPsQnCm?=
 =?iso-8859-1?Q?cj8LIKQeXvEPNieVbNdrRb41gOK0bXqRza++yL1hnHexqV0wa/gtMP/psd?=
 =?iso-8859-1?Q?iCZe5QL8Fggs1QgP/vOAOLqGcfn+ihzHK2sIQ20O17ZJEzfFdflAax034K?=
 =?iso-8859-1?Q?0BTVzlXZeyW6F8vCk+hKykuFeUfQaog968EpmANUp21e+wFRfnBNrkw2Py?=
 =?iso-8859-1?Q?Ho/baOycNIzFdR0mr+T2J9WBH8/b5Flgky0npGfEeeAsFFI4EKAHUMkKrE?=
 =?iso-8859-1?Q?wQLB7qFoIkcBeZURVvNrfs2Nvw2qDOTYh0Ty8QCNiwJwZbDOYwBMzZeN6R?=
 =?iso-8859-1?Q?3INNnJuDdcbI6yuI95z8KJmpxNJMy812xwk7xTyD88UMaq8T+4jQQZCklA?=
 =?iso-8859-1?Q?kL7vx441ta34f7H9Onxc2tNX1ANvtDnOBVBFn+x5wyvSR/BsE0BHkFpWUE?=
 =?iso-8859-1?Q?QMYqw/BmLv6cH4AHPB/Nd+QFVqKmYaOoPcsB9giQf/3bT2bpddX0hN5Mwu?=
 =?iso-8859-1?Q?3Bedj2PjmsdUGk4/ZXdkbKkYpWERNg00y0kIaALUUWL33DNw0AiyWDaH2M?=
 =?iso-8859-1?Q?lyR9aBL9ahfCKtHECRG9quT1P6qDGM4koJTPh1WZWppiSIZLmZuEv/BmSs?=
 =?iso-8859-1?Q?nNpuTP2q4vs0O10sANGoOQ9HalzakW8bGaRmKnyO1RBqQZEPOjwlc3+nkE?=
 =?iso-8859-1?Q?hbX937Um8wKpcBYcdlT1jrmVFEd+5kQyv7tjBmwr6XVU/xE7DXfd+HhTz1?=
 =?iso-8859-1?Q?uJqVlhMl1mQm+jNbFnUJhFRMelHJQX2mzbZOZ8Cfn77M6/BPPEHzsmBt15?=
 =?iso-8859-1?Q?yXaY=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB36597635D59E12B7960EABC0F5780@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(478600001)(14454004)(36756003)(99286004)(26005)(186003)(25786009)(53936002)(7736002)(50226002)(68736007)(86362001)(386003)(2201001)(6512007)(6506007)(2906002)(66066001)(4326008)(6436002)(106356001)(476003)(5660300002)(2501003)(2616005)(8676002)(102836004)(81166006)(8936002)(97736004)(7416002)(6116002)(81156014)(256004)(71200400001)(14444005)(3846002)(486006)(110136005)(316002)(105586002)(71190400001)(52116002)(305945005)(6486002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5RgnqqvrpXUEEfDNsa8ItvgsIKi1IHhhUmPCL3k/rexlSF3jiIdUbcWz6h1Bv3vpVMyBMcBsLF+TE87tuuG7oZpC5wMSPddeIwA5/x2rMET7PlHNm0LOyqLmZxqeyOxuXW87c0WoytLTp0X9rfj3OUQOM0OTnlxEELKCzJav3z3L7OiwAgWodLl8AQNgfi8/dlNCw6ttppGLYQZuQ2JSVrZP4Z4Q43K6ND/uNVa0kI1HkWpgjAmXC0ApWB6TBeFXQi9LQV17z/4IPWTaUY3tVDKWwQB4zslKZoO9dUEVLJLA15L2SUtun0KTfZ6Gz5SwHrWygl9dOO9aPOeiGWMPQtxSlmKn6X8pUfl9udr6YInekQeFbiTYOT/irMNYxW4McnRvjSuoUSr/bqB586IohGEWt7Kfm2Wci1n+KpatkUs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebaf8d05-7fb5-4eb2-cd57-08d6993da91a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 03:18:57.1624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MQ has clock gate for each GPIO bank, add them
into clock tree for GPIO driver to manage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change since V1, just drop 1 patch from V1 patch series.
---
 drivers/clk/imx/clk-imx8mq.c             | 5 +++++
 include/dt-bindings/clock/imx8mq-clock.h | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 26b57f4..553dcf5 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -500,6 +500,11 @@ static int imx8mq_clocks_probe(struct platform_device =
*pdev)
 	clks[IMX8MQ_CLK_ECSPI2_ROOT] =3D imx_clk_gate4("ecspi2_root_clk", "ecspi2=
", base + 0x4080, 0);
 	clks[IMX8MQ_CLK_ECSPI3_ROOT] =3D imx_clk_gate4("ecspi3_root_clk", "ecspi3=
", base + 0x4090, 0);
 	clks[IMX8MQ_CLK_ENET1_ROOT] =3D imx_clk_gate4("enet1_root_clk", "enet_axi=
", base + 0x40a0, 0);
+	clks[IMX8MQ_CLK_GPIO1_ROOT] =3D imx_clk_gate4("gpio1_root_clk", "ipg_root=
", base + 0x40b0, 0);
+	clks[IMX8MQ_CLK_GPIO2_ROOT] =3D imx_clk_gate4("gpio2_root_clk", "ipg_root=
", base + 0x40c0, 0);
+	clks[IMX8MQ_CLK_GPIO3_ROOT] =3D imx_clk_gate4("gpio3_root_clk", "ipg_root=
", base + 0x40d0, 0);
+	clks[IMX8MQ_CLK_GPIO4_ROOT] =3D imx_clk_gate4("gpio4_root_clk", "ipg_root=
", base + 0x40e0, 0);
+	clks[IMX8MQ_CLK_GPIO5_ROOT] =3D imx_clk_gate4("gpio5_root_clk", "ipg_root=
", base + 0x40f0, 0);
 	clks[IMX8MQ_CLK_GPT1_ROOT] =3D imx_clk_gate4("gpt1_root_clk", "gpt1", bas=
e + 0x4100, 0);
 	clks[IMX8MQ_CLK_I2C1_ROOT] =3D imx_clk_gate4("i2c1_root_clk", "i2c1", bas=
e + 0x4170, 0);
 	clks[IMX8MQ_CLK_I2C2_ROOT] =3D imx_clk_gate4("i2c2_root_clk", "i2c2", bas=
e + 0x4180, 0);
diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings=
/clock/imx8mq-clock.h
index 04f7ac3..aff3335 100644
--- a/include/dt-bindings/clock/imx8mq-clock.h
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -391,5 +391,11 @@
=20
 #define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK	267
=20
-#define IMX8MQ_CLK_END				268
+#define IMX8MQ_CLK_GPIO1_ROOT			268
+#define IMX8MQ_CLK_GPIO2_ROOT			269
+#define IMX8MQ_CLK_GPIO3_ROOT			270
+#define IMX8MQ_CLK_GPIO4_ROOT			271
+#define IMX8MQ_CLK_GPIO5_ROOT			272
+
+#define IMX8MQ_CLK_END				273
 #endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
--=20
2.7.4

