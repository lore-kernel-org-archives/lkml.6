Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D1EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 08:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301FA2063F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 08:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ol6CHq2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfBXI1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 03:27:33 -0500
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:38471
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726424AbfBXI1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 03:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3NcpLYiTN4RdfW2EC4VWAtEAf+HFKwSy9hflXy/sok=;
 b=Ol6CHq2iJFbY1TpCEnl3Pe9XQeZo21sU4kezGCWb4B9g5IliJZJYeMu2vWe25hLx7c8WQoMLOZWMDU4ePWNwwNqXK3TSrROl5PetmDEB4Xy6IzWVsIXZTfbyV5BotmyzSyOcrXnHl0X0t4pQjcM/iJ1gHG7h4PsQ1KJI3RutgbA=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2383.eurprd04.prod.outlook.com (10.169.134.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Sun, 24 Feb 2019 08:27:27 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 08:27:27 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Peter Rosin <peda@axentia.se>
CC:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Topic: [PATCH v3 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Index: AQHUzBrGTwclQk5U+0yy4Jt60r8AYw==
Date:   Sun, 24 Feb 2019 08:27:26 +0000
Message-ID: <20190224135143.24770-2-pankaj.bansal@nxp.com>
References: <20190224135143.24770-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190224135143.24770-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0145.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::13) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4afac8e7-f795-4f0b-730a-08d69a31e89f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2383;
x-ms-traffictypediagnostic: VI1PR0401MB2383:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0401MB2383;23:ixGP9NC0LsWWIYJSoZs8OlTYVrB2LXzJWWdBq?=
 =?iso-8859-1?Q?t0j7VUValwmYoZtpVB2s5UZhZEJqCaJ89CZMahZSq/rIcFPXToUfLqz4BA?=
 =?iso-8859-1?Q?ZgLwyVHn44DbbLNhYRyq9sGeteogLvCTBSRCaCkom4pLKjWI8neEanAn+9?=
 =?iso-8859-1?Q?o1Ke3+E1KhzoFwfM3rWIFqbh5NllfYLyswH+VCzWe6X7ba/aRCh1yjXTzC?=
 =?iso-8859-1?Q?27SLHbdsUf634YszQIX81Zr87rpRSBL7mivd1aIO+etA6bDSj2qE6qWLW1?=
 =?iso-8859-1?Q?Q519CE+8WCS1Sn/fpzrpLtH7/lK/h7LZg3m90elhp4yu4AJD2uBJs8wjBG?=
 =?iso-8859-1?Q?E6c1wy4Zr4wZE4tTHadXt3Ip+OXuEWYU6QvYtp7ck+ujSpoJt/elex7ie6?=
 =?iso-8859-1?Q?KZwMYTfZtHhqiA4YEhrI8ZZ2Rba+SgJhRJa72A7u5dqvPRRWFuLna3spYh?=
 =?iso-8859-1?Q?ysVkSvr2lhbgV52+IZruOYQKPQnyBLJ1X0v2D4wC7KxP6iTGy0MY7hej3+?=
 =?iso-8859-1?Q?uNx876v560tp30GGmmqUtlG5BlzmonFhxDoYAAoJtSAS2/44d5LpQwMTjB?=
 =?iso-8859-1?Q?zeNzAigICH+YUfhI40B2LfuPugchq9TSNxUSBdL2f0KQcjNuaFtkHejIJf?=
 =?iso-8859-1?Q?tZkcO/S2JhKP0DaqjlElaohBu9a0y1ZopnVMDNc1aM4IqK86XbBiE6ICUN?=
 =?iso-8859-1?Q?W71YUD8mJyU5Ssp6OQGVelCNFyhdyyjkUaljBgsAEtNsPx0Z8JuPkdPstQ?=
 =?iso-8859-1?Q?UKp0T97XJu+zX80MEnC3tjmfqZYk7/S5nBrnpAYZHDidUH8b/Mto77Qk7K?=
 =?iso-8859-1?Q?Q6gH3VEHzO9+O7pSZmYdQt4G7ecKnL+bV2/L6qauo60qAVEgS3YGyT4q9y?=
 =?iso-8859-1?Q?o+/3V+6TGCyUlLb7OP1RS9AqnF4MxK1UcJR4+WBZ7zSxTSZXBxrlTrIJ0c?=
 =?iso-8859-1?Q?XOTH8xs/GxC+qlHjb31AxqkZlRqR/pSzvhOzS/rby5jSnz6b8tR9UMsTGh?=
 =?iso-8859-1?Q?YeX8q5Qk3ecHBRBJp6dro2SSRDLlEEQlq2E2rX8TpUp046hKBLcmsqL0Pp?=
 =?iso-8859-1?Q?6rGvcZqf+psAa0g9nyi8E2aypXI07am4s2AD/1cEPV3OXkjr6ms4u9ECsb?=
 =?iso-8859-1?Q?ohL7Iqj91xpwH4yf1Xprdec0thIP6KHY4aO7fJvk1E95WRl1facYXDxQyX?=
 =?iso-8859-1?Q?z0PPRE3nb6HTnnS7dVub1YwErZkcDVmSNvxG3PfDOKjRfmOckj9iAlzT7x?=
 =?iso-8859-1?Q?jgaaue0/LuFMzCIS9S0Yb6k1LQ1ohgM1mlDzVLGeuakwSb8UCCtAQDw6gI?=
 =?iso-8859-1?Q?BTWw=3D?=
x-microsoft-antispam-prvs: <VI1PR0401MB2383F01CBBBA185A4E81EAE1F1790@VI1PR0401MB2383.eurprd04.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(2616005)(476003)(4326008)(478600001)(486006)(3846002)(6116002)(44832011)(2906002)(68736007)(6512007)(8936002)(50226002)(25786009)(11346002)(53936002)(66066001)(446003)(99286004)(105586002)(14454004)(97736004)(316002)(305945005)(7736002)(1076003)(106356001)(26005)(52116002)(76176011)(110136005)(186003)(102836004)(386003)(36756003)(71190400001)(6506007)(71200400001)(5660300002)(54906003)(6486002)(86362001)(6436002)(256004)(81156014)(8676002)(81166006)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2383;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N0j6+6pRFuLASdK7P77RdIOLS+HBqIe2TLdM688szOM29ErTq925Bs4zcOFFgmsrIdm4tlCqsTJmuiQNNaITzG7MVJia4se8AJ/WZ/iL7u5heJto+KNMaTAMmaagFp2TtR5AbB9aT+cpO54V15gWLjVhHiNGzDfWPcgRiZWpmcdfYFTxxcpfJWjP3kofx6JwmW+Hq5ubW2MvlBkxeConJ+mUwDJF1cUtJ3KLsgoxW46yhRWdbfOJhBYnPzr7tHUZXSUxQXkVHVM8V2PnbkuIxD++5QZG7MyEWjjma9/gGk068wL8pTBeVFmoMwXilsg5zDYh8f52CQW7UPQa2gwbzomkHAkZEVoBMWiZVyJOqo+PAzYfPV8zwBVEBZlf1+B3pLfPJdnSXxnXU3vrHiSk4ak8XjXNbhr3kwxLhCT9bHw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afac8e7-f795-4f0b-730a-08d69a31e89f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 08:27:24.3003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic register bitfield-based multiplexer that controls the multiplexer
producer defined under a parent node.
The driver corresponding to parent node provides register read/write
capabilities.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---

Notes:
    V3:
    - Added the patch in series with device tree binding patch
    - Added the NULL return handling for regmap
    V2:
    - removed seperate driver regmap.c and added the regmap function in mmi=
o.c
      based on compatible field, the syscon or regmap function would be cal=
led
    - Modified the KConfig as per Peter's comments

 drivers/mux/Kconfig | 12 ++++++------
 drivers/mux/mmio.c  | 10 +++++++---
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index 7659d6c5f718..e5c571fd232c 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -46,14 +46,14 @@ config MUX_GPIO
 	  be called mux-gpio.
=20
 config MUX_MMIO
-	tristate "MMIO register bitfield-controlled Multiplexer"
-	depends on (OF && MFD_SYSCON) || COMPILE_TEST
+	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
+	depends on OF || COMPILE_TEST
 	help
-	  MMIO register bitfield-controlled Multiplexer controller.
+	  MMIO/Regmap register bitfield-controlled Multiplexer controller.
=20
-	  The driver builds multiplexer controllers for bitfields in a syscon
-	  register. For N bit wide bitfields, there will be 2^N possible
-	  multiplexer states.
+	  The driver builds multiplexer controllers for bitfields in either
+	  a syscon register or a driver regmap register. For N bit wide
+	  bitfields, there will be 2^N possible multiplexer states.
=20
 	  To compile the driver as a module, choose M here: the module will
 	  be called mux-mmio.
diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 935ac44aa209..cc02155e4644 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -28,6 +28,7 @@ static const struct mux_control_ops mux_mmio_ops =3D {
=20
 static const struct of_device_id mux_mmio_dt_ids[] =3D {
 	{ .compatible =3D "mmio-mux", },
+	{ .compatible =3D "reg-mux", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mux_mmio_dt_ids);
@@ -43,9 +44,12 @@ static int mux_mmio_probe(struct platform_device *pdev)
 	int ret;
 	int i;
=20
-	regmap =3D syscon_node_to_regmap(np->parent);
-	if (IS_ERR(regmap)) {
-		ret =3D PTR_ERR(regmap);
+	if (of_device_is_compatible(np, "mmio-mux"))
+		regmap =3D syscon_node_to_regmap(np->parent);
+	else
+		regmap =3D dev_get_regmap(dev->parent, NULL);
+	if (IS_ERR_OR_NULL(regmap)) {
+		ret =3D PTR_ERR_OR_ZERO(regmap) ? PTR_ERR(regmap) : -ENODEV;
 		dev_err(dev, "failed to get regmap: %d\n", ret);
 		return ret;
 	}
--=20
2.17.1

