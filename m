Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF527C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4A22084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="q9k67uzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfAYHpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:45:54 -0500
Received: from mail-eopbgr750049.outbound.protection.outlook.com ([40.107.75.49]:22592
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726392AbfAYHpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdhBa/flrEdHpJf6nhfffKKix/9UEbxZzN2WmxPxxOU=;
 b=q9k67uzTJPFAQhL3ra1KORXHxFJO62LEY/0Jh22SXL/Z8LamI9A7JnimA6Kv/3FEo7NB7vss9b+ddW7ZAJYcXjKeUhWbOUnvle/hUT+Jhl6g8bXzXjq/QT5pSf+EcMUKrt13hgCa/blafnWURQbj1nl9z+mudtxqicJiR6MXWug=
Received: from SN6PR03MB4398.namprd03.prod.outlook.com (20.177.255.219) by
 SN6PR03MB4095.namprd03.prod.outlook.com (52.135.113.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Fri, 25 Jan 2019 07:45:47 +0000
Received: from SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::59c4:7034:c325:36f]) by SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::59c4:7034:c325:36f%2]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 07:45:47 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] pinctrl: berlin: as370: use generic "pwm" as pwm function
 name
Thread-Topic: [PATCH] pinctrl: berlin: as370: use generic "pwm" as pwm
 function name
Thread-Index: AQHUtIH8c6ujliEJykebgfjDayK5WQ==
Date:   Fri, 25 Jan 2019 07:45:47 +0000
Message-ID: <20190125153934.3dc818b6@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TYAPR01CA0056.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::20) To SN6PR03MB4398.namprd03.prod.outlook.com
 (2603:10b6:805:fd::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR03MB4095;6:2uWH3gtgU5tcoMiLypouFwRXGClr+sVvK2Meb9W9GS4WWQ1V+H23t7CqrJV6mFdaazFCtNJGGWy40ru75m/F+yIqCSJWB7i9M7B1+Zg923k76r6gWJYYHurQNjXSwnE/eaSAlKMviABlaFBpl0j28fpRH+8Z9tXI/gBhdnpBhp0DNE8rdNb6Fo9CCyUB/zIT96ZxXWdPkHcAPjVgFwo0auHhw9YguoickOumrFgeJBHNPigMk5BLoakPmNxGwvw0JUUyyJtkQhLCYXjqhOFbhUpOJgJbNkmkVu7iGKhrRc+wjkNJpjI54Plm8Iu2CjgrC1ZH8uW/gjKqlhXPTsLNXpiPVKGbol9oxhF9J6Epr8fezWRbHdhBQQrV2abLCWnCmlfzXJSoWfdJpAEbtnRxbw7viQ+u3qQ7hqS1S//RLuo2BNHqWyu/1NxIj0CoYvHympQ1CyzcjxHtQJKBDy+dzw==;5:yCnvIPOpv/FMUy/cxgIz+JNuWB+6NlgJvikQYDEfn66nMLwve22sgppwbIeFhagPYGQ98gUQRJMacEMHtZywdVCGbL14PzHuiIjAiHM0OyhEqa7EzNRzo/tWdPbhOi3qhM9OgCCQN6nzafrusJ0kF4skAf7C1AmfvcY0afuXv9aekMaV+fZ0uuh+wGS12nLIV4DnE5YZdYOUMQFLUf791Q==;7:gGraahA7mCC5oqYlkCYqQNPkOjLURnB8R/AFpGgWZJX4Anf4hu7kGxAyWjtberVJBAbbPZdfGkhdUJpJJA0THNRnO++ECHCi2VE+xNyRIt+gxeKnDFfX/cJVZ5a8pp/sm1qiWfhsRCmDtn9Q0rFMWA==
x-ms-office365-filtering-correlation-id: 4c460626-9f37-4a45-1f17-08d682991e90
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SN6PR03MB4095;
x-ms-traffictypediagnostic: SN6PR03MB4095:
x-microsoft-antispam-prvs: <SN6PR03MB409517DFB962002A0F2F5560ED9B0@SN6PR03MB4095.namprd03.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(366004)(199004)(189003)(476003)(52116002)(105586002)(25786009)(14454004)(486006)(3846002)(6116002)(33896004)(478600001)(68736007)(186003)(26005)(6506007)(386003)(106356001)(99286004)(102836004)(6916009)(6486002)(7736002)(6512007)(9686003)(6436002)(54906003)(81166006)(305945005)(71200400001)(71190400001)(50226002)(4326008)(2906002)(97736004)(66066001)(86362001)(53936002)(81156014)(72206003)(1076003)(8676002)(316002)(8936002)(256004)(41533002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB4095;H:SN6PR03MB4398.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4bbFr8vTYwqEXIdsVG7ZCrSAnhjSEy3DUQaqhUByFZK/VGG1tAfy4ys8R/MKYgPTn1Dw4gJkqA40ncSZiiQcb4DGT2/RZ4bWFVzwyWPYCqzxzl4zdcwtDJuzlvA0T+IK0zcsBJWJOQKPDhogaKYwtwE/tjZ0eNGwKTvE08xoB7+RF3vp1ZGYQrhMZiogoDPeBV5CPRme59ur7Fv/V7YKO1GaADbolYy3BjRPn5n14DwQhz9zxBuF715NwLY0xfPHoqZFNSCmbQGlAfbr2vw3A3DN+Y6JM68+aRf8rW6IaJgP+XAnyqsUNCbgKnZRzvi2oBJVMNdKqEtVY9z0zkhzXwbjrl8z6C9fWFU73OJjTitZvBNoKWh8BXP/3hGHt0oqnVHq8lN3nJ4WamNyBP+QIZ1sj5BLE9bKY6L7G9DyEp0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04FB5ED0A3209A4C90B36EE317683494@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c460626-9f37-4a45-1f17-08d682991e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 07:45:46.2254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that we could use the generic "pwm" for two or more pins, e.g

	pwm0_pmux: pwm0-pmux {
		groups =3D "PWM0", "PWM1";
		function =3D "pwm";
	};

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pinctrl/berlin/pinctrl-as370.c | 58 +++++++++++++-------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/berlin/pinctrl-as370.c b/drivers/pinctrl/berli=
n/pinctrl-as370.c
index d2bb811fc5fa..44f8ccdbeeff 100644
--- a/drivers/pinctrl/berlin/pinctrl-as370.c
+++ b/drivers/pinctrl/berlin/pinctrl-as370.c
@@ -36,13 +36,13 @@ static const struct berlin_desc_group as370_soc_pinctrl=
_groups[] =3D {
 	BERLIN_PINCTRL_GROUP("I2S1_DO2", 0x0, 0x3, 0x0c,
 			BERLIN_PINCTRL_FUNCTION(0x0, "por"), /* CORE RSTB */
 			BERLIN_PINCTRL_FUNCTION(0x1, "i2s1"), /* DO2 */
-			BERLIN_PINCTRL_FUNCTION(0x2, "pwm4"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm"), /* PWM4 */
 			BERLIN_PINCTRL_FUNCTION(0x3, "gpio"), /* GPIO4 */
 			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG4 */
 	BERLIN_PINCTRL_GROUP("I2S1_DO3", 0x0, 0x3, 0x0f,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO5 */
 			BERLIN_PINCTRL_FUNCTION(0x1, "i2s1"), /* DO3 */
-			BERLIN_PINCTRL_FUNCTION(0x2, "pwm5"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm"), /* PWM5 */
 			BERLIN_PINCTRL_FUNCTION(0x3, "spififib"), /* SPDIFIB */
 			BERLIN_PINCTRL_FUNCTION(0x4, "spdifo"), /* SPDIFO */
 			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG5 */
@@ -61,24 +61,24 @@ static const struct berlin_desc_group as370_soc_pinctrl=
_groups[] =3D {
 	BERLIN_PINCTRL_GROUP("I2S2_DI0", 0x0, 0x3, 0x1b,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO9 */
 			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2"), /* DI0 */
-			BERLIN_PINCTRL_FUNCTION(0x2, "pwm2"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm"), /* PWM2 */
 			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG9 */
 	BERLIN_PINCTRL_GROUP("I2S2_DI1", 0x4, 0x3, 0x00,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO10 */
 			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2"), /* DI1 */
-			BERLIN_PINCTRL_FUNCTION(0x2, "pwm3"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm"), /* PWM3 */
 			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG10 */
 	BERLIN_PINCTRL_GROUP("I2S2_DI2", 0x4, 0x3, 0x03,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO11 */
 			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2"), /* DI2 */
-			BERLIN_PINCTRL_FUNCTION(0x2, "pwm6"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm"), /* PWM6 */
 			BERLIN_PINCTRL_FUNCTION(0x3, "spdific"), /* SPDIFIC */
 			BERLIN_PINCTRL_FUNCTION(0x4, "spdifo"), /* SPDIFO */
 			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG11 */
 	BERLIN_PINCTRL_GROUP("I2S2_DI3", 0x4, 0x3, 0x06,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO12 */
 			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2"), /* DI3 */
-			BERLIN_PINCTRL_FUNCTION(0x2, "pwm7"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm"), /* PWM7 */
 			BERLIN_PINCTRL_FUNCTION(0x3, "spdifia"), /* SPDIFIA */
 			BERLIN_PINCTRL_FUNCTION(0x4, "spdifo"), /* SPDIFO */
 			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG12 */
@@ -98,14 +98,14 @@ static const struct berlin_desc_group as370_soc_pinctrl=
_groups[] =3D {
 	BERLIN_PINCTRL_GROUP("PDM_DI2", 0x4, 0x3, 0x12,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO16 */
 			BERLIN_PINCTRL_FUNCTION(0x1, "pdm"), /* DI2 */
-			BERLIN_PINCTRL_FUNCTION(0x2, "pwm4"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm"), /* PWM4 */
 			BERLIN_PINCTRL_FUNCTION(0x3, "spdifid"), /* SPDIFID */
 			BERLIN_PINCTRL_FUNCTION(0x4, "spdifo"), /* SPDIFO */
 			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG16 */
 	BERLIN_PINCTRL_GROUP("PDM_DI3", 0x4, 0x3, 0x15,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO17 */
 			BERLIN_PINCTRL_FUNCTION(0x1, "pdm"), /* DI3 */
-			BERLIN_PINCTRL_FUNCTION(0x2, "pwm5"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm"), /* PWM5 */
 			BERLIN_PINCTRL_FUNCTION(0x3, "spdifi"), /* SPDIFI */
 			BERLIN_PINCTRL_FUNCTION(0x4, "spdifo"), /* SPDIFO */
 			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG17 */
@@ -139,11 +139,11 @@ static const struct berlin_desc_group as370_soc_pinct=
rl_groups[] =3D {
 			BERLIN_PINCTRL_FUNCTION(0x1, "emmc")), /* DATA7 */
 	BERLIN_PINCTRL_GROUP("NAND_ALE", 0x8, 0x3, 0x12,
 			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* ALE */
-			BERLIN_PINCTRL_FUNCTION(0x2, "pwm6"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm"), /* PWM6 */
 			BERLIN_PINCTRL_FUNCTION(0x3, "gpio")), /* GPIO18 */
 	BERLIN_PINCTRL_GROUP("NAND_CLE", 0x8, 0x3, 0x15,
 			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* CLE */
-			BERLIN_PINCTRL_FUNCTION(0x2, "pwm7"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm"), /* PWM7 */
 			BERLIN_PINCTRL_FUNCTION(0x3, "gpio")), /* GPIO19 */
 	BERLIN_PINCTRL_GROUP("NAND_WEn", 0x8, 0x3, 0x18,
 			BERLIN_PINCTRL_FUNCTION(0x0, "nand"), /* WEn */
@@ -169,12 +169,12 @@ static const struct berlin_desc_group as370_soc_pinct=
rl_groups[] =3D {
 	BERLIN_PINCTRL_GROUP("SPI1_SS1n", 0xc, 0x3, 0x0c,
 			BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SS1n */
 			BERLIN_PINCTRL_FUNCTION(0x2, "gpio"), /* GPIO26 */
-			BERLIN_PINCTRL_FUNCTION(0x3, "pwm2")),
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm")), /* PWM2 */
 	BERLIN_PINCTRL_GROUP("SPI1_SS2n", 0xc, 0x3, 0x0f,
 			BERLIN_PINCTRL_FUNCTION(0x0, "uart0"), /* RXD */
 			BERLIN_PINCTRL_FUNCTION(0x1, "spi1"), /* SS2n */
 			BERLIN_PINCTRL_FUNCTION(0x2, "gpio"), /* GPIO27 */
-			BERLIN_PINCTRL_FUNCTION(0x3, "pwm3")),
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm")), /* PWM3 */
 	BERLIN_PINCTRL_GROUP("SPI1_SS3n", 0xc, 0x3, 0x12,
 			BERLIN_PINCTRL_FUNCTION(0x0, "uart0"), /* TXD */
 			BERLIN_PINCTRL_FUNCTION(0x1, "spi1"), /* SS3n */
@@ -182,11 +182,11 @@ static const struct berlin_desc_group as370_soc_pinct=
rl_groups[] =3D {
 	BERLIN_PINCTRL_GROUP("SPI1_SCLK", 0xc, 0x3, 0x15,
 			BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SCLK */
 			BERLIN_PINCTRL_FUNCTION(0x1, "gpio"), /* GPIO29 */
-			BERLIN_PINCTRL_FUNCTION(0x3, "pwm4")),
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm")), /* PWM4 */
 	BERLIN_PINCTRL_GROUP("SPI1_SDO", 0xc, 0x3, 0x18,
 			BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SDO */
 			BERLIN_PINCTRL_FUNCTION(0x1, "gpio"), /* GPIO30 */
-			BERLIN_PINCTRL_FUNCTION(0x3, "pwm5")),
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm")), /* PWM5 */
 	BERLIN_PINCTRL_GROUP("SPI1_SDI", 0xc, 0x3, 0x1b,
 			BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SDI */
 			BERLIN_PINCTRL_FUNCTION(0x1, "gpio")), /* GPIO31 */
@@ -209,51 +209,51 @@ static const struct berlin_desc_group as370_soc_pinct=
rl_groups[] =3D {
 	BERLIN_PINCTRL_GROUP("TMS", 0x10, 0x3, 0x0f,
 			BERLIN_PINCTRL_FUNCTION(0x0, "jtag"), /* TMS */
 			BERLIN_PINCTRL_FUNCTION(0x1, "gpio"), /* GPIO37 */
-			BERLIN_PINCTRL_FUNCTION(0x4, "pwm0")),
+			BERLIN_PINCTRL_FUNCTION(0x4, "pwm")), /* PWM0 */
 	BERLIN_PINCTRL_GROUP("TDI", 0x10, 0x3, 0x12,
 			BERLIN_PINCTRL_FUNCTION(0x0, "jtag"), /* TDI */
 			BERLIN_PINCTRL_FUNCTION(0x1, "gpio"), /* GPIO38 */
-			BERLIN_PINCTRL_FUNCTION(0x4, "pwm1")),
+			BERLIN_PINCTRL_FUNCTION(0x4, "pwm")), /* PWM1 */
 	BERLIN_PINCTRL_GROUP("TDO", 0x10, 0x3, 0x15,
 			BERLIN_PINCTRL_FUNCTION(0x0, "jtag"), /* TDO */
 			BERLIN_PINCTRL_FUNCTION(0x1, "gpio"), /* GPIO39 */
-			BERLIN_PINCTRL_FUNCTION(0x4, "pwm0")),
+			BERLIN_PINCTRL_FUNCTION(0x4, "pwm")), /* PWM0 */
 	BERLIN_PINCTRL_GROUP("PWM6", 0x10, 0x3, 0x18,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO40 */
-			BERLIN_PINCTRL_FUNCTION(0x1, "pwm6")),
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm")), /* PWM6 */
 	BERLIN_PINCTRL_GROUP("PWM7", 0x10, 0x3, 0x1b,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO41 */
-			BERLIN_PINCTRL_FUNCTION(0x1, "pwm7")),
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm")), /* PWM7 */
 	BERLIN_PINCTRL_GROUP("PWM0", 0x14, 0x3, 0x00,
 			BERLIN_PINCTRL_FUNCTION(0x0, "por"), /* VDDCPUSOC RSTB */
-			BERLIN_PINCTRL_FUNCTION(0x1, "pwm0"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm"), /* PWM0 */
 			BERLIN_PINCTRL_FUNCTION(0x2, "gpio")), /* GPIO42 */
 	BERLIN_PINCTRL_GROUP("PWM1", 0x14, 0x3, 0x03,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO43 */
-			BERLIN_PINCTRL_FUNCTION(0x1, "pwm1")),
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm")), /* PWM1 */
 	BERLIN_PINCTRL_GROUP("PWM2", 0x14, 0x3, 0x06,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO44 */
-			BERLIN_PINCTRL_FUNCTION(0x1, "pwm2")),
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm")), /* PWM2 */
 	BERLIN_PINCTRL_GROUP("PWM3", 0x14, 0x3, 0x09,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO45 */
-			BERLIN_PINCTRL_FUNCTION(0x1, "pwm3")),
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm")), /* PWM3 */
 	BERLIN_PINCTRL_GROUP("PWM4", 0x14, 0x3, 0x0c,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO46 */
-			BERLIN_PINCTRL_FUNCTION(0x1, "pwm4")),
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm")), /* PWM4 */
 	BERLIN_PINCTRL_GROUP("PWM5", 0x14, 0x3, 0x0f,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO47 */
-			BERLIN_PINCTRL_FUNCTION(0x1, "pwm5")),
+			BERLIN_PINCTRL_FUNCTION(0x1, "pwm")), /* PWM5 */
 	BERLIN_PINCTRL_GROUP("URT1_RTSn", 0x14, 0x3, 0x12,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO48 */
 			BERLIN_PINCTRL_FUNCTION(0x1, "uart1"), /* RTSn */
-			BERLIN_PINCTRL_FUNCTION(0x2, "pwm6"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm"), /* PWM6 */
 			BERLIN_PINCTRL_FUNCTION(0x3, "tw1a"), /* SCL */
 			BERLIN_PINCTRL_FUNCTION(0x4, "aio"), /* DBG0 */
 			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG18 */
 	BERLIN_PINCTRL_GROUP("URT1_CTSn", 0x14, 0x3, 0x15,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO49 */
 			BERLIN_PINCTRL_FUNCTION(0x1, "uart1"), /* CTSn */
-			BERLIN_PINCTRL_FUNCTION(0x2, "pwm7"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm"), /* PWM7 */
 			BERLIN_PINCTRL_FUNCTION(0x3, "tw1a"), /* SDA */
 			BERLIN_PINCTRL_FUNCTION(0x4, "aio"), /* DBG1 */
 			BERLIN_PINCTRL_FUNCTION(0x5, "phy")), /* DBG19 */
@@ -308,11 +308,11 @@ static const struct berlin_desc_group as370_soc_pinct=
rl_groups[] =3D {
 	BERLIN_PINCTRL_GROUP("SD0_CDn", 0x1c, 0x3, 0x00,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO62 */
 			BERLIN_PINCTRL_FUNCTION(0x1, "sd0"), /* CDn */
-			BERLIN_PINCTRL_FUNCTION(0x3, "pwm2")),
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm")), /* PWM2 */
 	BERLIN_PINCTRL_GROUP("SD0_WP", 0x1c, 0x3, 0x03,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO63 */
 			BERLIN_PINCTRL_FUNCTION(0x1, "sd0"), /* WP */
-			BERLIN_PINCTRL_FUNCTION(0x3, "pwm3")),
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm")), /* PWM3 */
 };
=20
 static const struct berlin_pinctrl_desc as370_soc_pinctrl_data =3D {
--=20
2.20.1

