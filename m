Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA8CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 07:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC9E21905
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 07:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ldOYBb+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbeLWHIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 02:08:36 -0500
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:43840
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbeLWHIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 02:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDbA1FKsvfGtaTsRiD4JMsGSE8p46EkotzD3HHGGC7w=;
 b=ldOYBb+zhL/NOAeiU72IbSbd6ydnvRBsiwAETpRu/1RJT5TTdrD5/zxjURneoVQtxVt3dcCVRxtNMJ0SKzUDRIo0mJVjpWT32xGmM3SPSPgI7UoJoyiIyZph7PacUpGXmSHt2JZBNqz8mvywMFNpbERc/9wlcZcFjtjdXs7UXL0=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3431.eurprd04.prod.outlook.com (52.133.19.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.25; Sun, 23 Dec 2018 07:08:31 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d%2]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 07:08:31 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stefan Agner <stefan.agner@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] pinctrl: freescale: Break dependency on SOC_IMX8MQ for
 i.MX8MQ
Thread-Topic: [PATCH] pinctrl: freescale: Break dependency on SOC_IMX8MQ for
 i.MX8MQ
Thread-Index: AQHUmo5PK/Tz1O1SH0SGzdYOjnerFw==
Date:   Sun, 23 Dec 2018 07:08:31 +0000
Message-ID: <1545548891-24671-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P194CA0023.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::33) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3431;6:cWQYHFnF00FiqRM7fPtFhUoO+gJioLoqoqIHVplfaYVBvx4pmi2XLo46BaQeLqC10tyRIM2MUiBeGkFJf4lvzWYDJIQNXnrZ0OMF/jvLAfbhi8hCpuyvgNdGPD+Y0DXKRLjZ7RZXklYbJdGq3MsGFDhOguPEOc/ujI5QE81k6lESN41x8vVxXO/7j1TmqMx8f++cLbm4IxDLutOv/eU4WS5aM4wrSleAeh8CNz5g82++f2sCVR0jcsitiSd9QYCzt2D0pw2vkXVLrR2lLAkhm/jmQmll6CtG4P/YSk5JB2KHQah7KFm4JKLUzjBxzUmIk6wyR8LseJUlVaZqsyVQ+kJ7Y+goRHg2Sy5rxM/JoleZRiy5wxlChsHkNctdFfVVBY545WwKxhWYhG/7oAbyPKwnbFJHt9RpawVcQhLayZGMNTCqbuvsRhv9M2MEqv+0d3/Tqj6cpuUmuxMjsPlsog==;5:12QYCyXUr7VUY8eoDzF6wlegQ+F3dkW7graYjvp1hP8FkqJX83Fprweqk8rKR61zFPi7BmWmPan+U/2YeZ05py2B7htrQ9MPfTgQPy0UlOdZQwt+LAMzkLZzE9utifnEAO79bH8Yi+Ed9tIZ2eZOLQ1gP+JnIl0WLvyHvOVbMjU=;7:+kohbjRsGrZCtrzrZzlP9On/SVhVkVOPbL2wULIgb4GUtYNXW4SEaNUXiOws8FZDoiohNOSmpkcdvQ7HlWmpJ957GRlUCdUEGl7O0JOpZ66zCUuBVQnP0f9zdCIL9bjVc+uzmlElXSlSDEH1en7fmQ==
x-ms-office365-filtering-correlation-id: 51fa8012-a44a-41cf-f459-08d668a57211
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600098)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3431;
x-ms-traffictypediagnostic: AM6PR0402MB3431:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB343107AF511D34DE70E51123F6BA0@AM6PR0402MB3431.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220043)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3431;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3431;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(136003)(376002)(396003)(346002)(39860400002)(189003)(199004)(66066001)(71190400001)(71200400001)(2906002)(6512007)(53936002)(97736004)(86362001)(5660300001)(105586002)(106356001)(25786009)(478600001)(99286004)(476003)(486006)(186003)(6346003)(102836004)(26005)(256004)(14444005)(2616005)(14454004)(6486002)(68736007)(44832011)(316002)(4326008)(6436002)(8676002)(6116002)(3846002)(36756003)(6506007)(54906003)(110136005)(81166006)(81156014)(7736002)(8936002)(52116002)(386003)(305945005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3431;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3rvyHGZwushESI3Qo/P8ORg2voHK1VxbDp4GDy5ObAk42a8SdLlMbjtiaRvAlWGSTdoCHFcR4QXe0m6E+x1lU7N4s1NU+eMGbmP53gbymV0jcKM5oDqaJ2tI2YML1a2zasCJ6t7GffEQobfKg7OO51Oib+QpmwKctQ7xrtq/rm8D8ZXLNPMYqSXkTZRDLUq50RoWD90UX/VHdaR9vtXZZyhM0+NvM4umzylRutHcouoj0qntSiD5t2TSgs6rex0MJYENzq/28MF4xDb/O3ivFTJclhGe91nGc1P9OALLJdniXiHOZahEdsyuiTiCk6oC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fa8012-a44a-41cf-f459-08d668a57211
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 07:08:31.4988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3431
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_SOC_IMX8MQ will go away, so the dependency can be based on
ARCH_MXC && ARM64.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/pinctrl/freescale/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/=
Kconfig
index 2d6db43..624902e 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -123,7 +123,7 @@ config PINCTRL_IMX7ULP
=20
 config PINCTRL_IMX8MQ
 	bool "IMX8MQ pinctrl driver"
-	depends on SOC_IMX8MQ
+	depends on ARCH_MXC && ARM64
 	select PINCTRL_IMX
 	help
 	  Say Y here to enable the imx8mq pinctrl driver
--=20
2.7.4

