Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46A7C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FFA218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kkic222P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfB0B2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:28:35 -0500
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:61344
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729044AbfB0B2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrHTnIpqOsWp1sorKavNCaDKeym4sGa7ZutNrdbv8Oo=;
 b=Kkic222PWWYbewG/W2+x6ajarCTCMnXWlzeVE/YUhWvRQrqWEPK7dmOAiz6zAjohEkR1cupG9WHtJDSnUR8gXoyWDpWHFfG3Dq1LfTeYcQDJd31UZpMBf24Mv7hw7R1/Bemn+EUgDyvw9M4S6f+DC6EA+YIqAO/6bKwNLkvGblc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3772.eurprd04.prod.outlook.com (52.134.71.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Wed, 27 Feb 2019 01:28:27 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 01:28:26 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND V2 1/2] clk: imx8mq: add GPIO clocks to clock tree
Thread-Topic: [PATCH RESEND V2 1/2] clk: imx8mq: add GPIO clocks to clock tree
Thread-Index: AQHUzju83XkEqBBPo0W2mhbzy8FScA==
Date:   Wed, 27 Feb 2019 01:28:26 +0000
Message-ID: <1551230622-30660-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0022.apcprd04.prod.outlook.com
 (2603:1096:203:36::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bec0cde-b41e-49b2-7e68-08d69c52df44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3772;
x-ms-traffictypediagnostic: DB3PR0402MB3772:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3772;23:Q+LTe/YLteerxDh2mR1BpuR9So7/nw9vr9CVM?=
 =?iso-8859-1?Q?3L35Y9iQZJD6kol2ELZZRUcGDyjdvQcPLqX1lsFS97uS9nATf6Cksi9isj?=
 =?iso-8859-1?Q?rWO0CPqAQcAJEwTQhuAIyruOtE8ydsVjyjii3vwtjHtQAJDukj9rHN9h8f?=
 =?iso-8859-1?Q?dtHmEdqctk4vmizd4G42+wki0D39M90/1DeI3QcN8MD2EN5CWdZ7tlFWLN?=
 =?iso-8859-1?Q?kgW7BpU3waAS94kHlmSUp+mHxqWnJEBXS/DU3xTZJL3UawectsAVhGlQaN?=
 =?iso-8859-1?Q?nhDRP2aENWVNw+ZioXiFMc7NvGmoRu9mz80QcnZEMzII+JVg3XDDLhjcfD?=
 =?iso-8859-1?Q?+dKuXBX5OIbPi17PE5ErFllJmJzHJDgDDSwgOR34anrxa4ttolZ3vE97/n?=
 =?iso-8859-1?Q?YXiATQrE61bcAMMz905XFh4PaRrzif4RS1p8a9TTf01l7nePRC2raBePE+?=
 =?iso-8859-1?Q?YpXW7kzF8Ok6ar/NIfRQgcI5/kawsHdXHXSbKh+mt11TwiumOMB+tQP1JF?=
 =?iso-8859-1?Q?qlxRA4Vmp8T9gWY2ygIEuZichG4NlXcNIgUTe82/z/UIj7Ce1ttCfZbksn?=
 =?iso-8859-1?Q?fLxMNDYbTcoRMbt5QOJTh4Q7o5ph6yKU+gM4eApXwPOXQr4poXmRa/j4eY?=
 =?iso-8859-1?Q?Rpc1oLbquG/LHbgF2jXQLbu93VNaUn0CnFJPhzUK9TC5szOV55b14M9yVl?=
 =?iso-8859-1?Q?4cRQo+g/VlfFT2Y5hjcGGk9mfHYGBhOpRS6+vTifp/mQgtPkHRZZmEOtIt?=
 =?iso-8859-1?Q?TYwak5C+Qmm5/2oFS2M7NUGgBs006QoOymHBkzJB7wTCXfCx0PYhWbCKwK?=
 =?iso-8859-1?Q?+tVM9MGltYKT7WxVYcZ1wlTjq5e+IlYENW5vW1TT8/R0az5YrGG8bdUZNT?=
 =?iso-8859-1?Q?Ja4PlXMld9gpkzTl4+LiAKld7hshif3MxqgPsSk0p6DIj8Rc7QgDosB5S/?=
 =?iso-8859-1?Q?/7PEEqsy5rdtoRsBFGk2Cb65rfckTg8z1sUP001yAWeJaqZxPWgCnSCd6i?=
 =?iso-8859-1?Q?Eu0HPYAI5fHeHoptyzu8SJ8azSTgcqjpv/FBo+sO78qKeQorqgMeJhrmX/?=
 =?iso-8859-1?Q?KuUI1CXDN0WIFemzVWMd0huLc1nH4Kh4uL8JxfvjGkghtkKOdNQ1fqaT0c?=
 =?iso-8859-1?Q?dSWvBmDViU561woLgmOqYnlJUR/Mc6oLNPIi/T9IfYtYXm7J3KSUFBzQ0x?=
 =?iso-8859-1?Q?JvRHAPsKEJ+co3ZmY4JOSl0ErHejz9knSEAvTy1BMt+V5yBjEEjQ6H+heg?=
 =?iso-8859-1?Q?WS8nnjV5AQKOYtRW9uCtyzSjyeqQq76+73eGAgsZLP8zwwVVNgmrXJL21w?=
 =?iso-8859-1?Q?0guK0WieMfc7MxVIbJbFOxe5K?=
x-microsoft-antispam-prvs: <DB3PR0402MB37725A6AB1593824B5CE3246F5740@DB3PR0402MB3772.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(6486002)(3846002)(6436002)(386003)(6116002)(7416002)(316002)(71200400001)(71190400001)(14444005)(256004)(186003)(6506007)(478600001)(99286004)(6346003)(102836004)(5660300002)(53936002)(50226002)(6512007)(7736002)(305945005)(81166006)(14454004)(26005)(81156014)(8936002)(8676002)(486006)(2616005)(4326008)(68736007)(66066001)(25786009)(2906002)(105586002)(52116002)(110136005)(97736004)(2501003)(36756003)(2201001)(476003)(86362001)(106356001)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3772;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x4TWHMeNuSTc6k4yq374iZgJvNB/IsKXPev3thVdLs+utvAD5dvu9Prw8pRw0l3hXLA9z8Fpj7fL8MM5x3XflcFWrHkFwGddqHo79Is6XvaSxuaXs4j7tx04urXs0sRLhCrFVGbuMSfNI7zM+4hec37qLS0nVcYQJoFzvEO7hnlrpNlwWmubNlVPyqRi1xJWlGx+0DMs7Iinfc/8dYAxbHzLqKSpS2GAV+w3icWUocLqsjAgxoluZxtGWp7ngTcVyIyDqONr6+GlVSXaSk5RVfBev0DalwS0gqWndsDkE8k9VDhXTvUohG1w52Q+pVjdz6bF3BMmnBS98H/g5GkZeGIYhadrOt/vGaYI2SYN+DNN/XLXE+G9pQtaAjmt6xQA7PkSatIVFlhGZ5h7HnZuoqIOO5bLG2MAyPD+Ef6LHaA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bec0cde-b41e-49b2-7e68-08d69c52df44
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 01:28:21.7898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MQ has clock gate for each GPIO bank, add them
into clock tree for GPIO driver to manage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes, just rebase to clk-next.
---
 drivers/clk/imx/clk-imx8mq.c             | 5 +++++
 include/dt-bindings/clock/imx8mq-clock.h | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 01c771f..789dc8e 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -510,6 +510,11 @@ static int imx8mq_clocks_probe(struct platform_device =
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
index 491e39c..b58cc64 100644
--- a/include/dt-bindings/clock/imx8mq-clock.h
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -394,5 +394,11 @@
 #define IMX8MQ_CLK_CLKO1			268
 #define IMX8MQ_CLK_ARM				269
=20
-#define IMX8MQ_CLK_END				270
+#define IMX8MQ_CLK_GPIO1_ROOT			270
+#define IMX8MQ_CLK_GPIO2_ROOT			271
+#define IMX8MQ_CLK_GPIO3_ROOT			272
+#define IMX8MQ_CLK_GPIO4_ROOT			273
+#define IMX8MQ_CLK_GPIO5_ROOT			274
+
+#define IMX8MQ_CLK_END				275
 #endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
--=20
2.7.4

