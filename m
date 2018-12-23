Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E35C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B9C2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FPFpUSRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeLWNUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 08:20:51 -0500
Received: from mail-eopbgr50079.outbound.protection.outlook.com ([40.107.5.79]:48832
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbeLWNUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 08:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VS6zH1pKpv7msh+3TGEwhUSqiLlfq7Ei4MW+ReFiQxk=;
 b=FPFpUSRzKKBGk5z7+umQO6Ef+cObNJQbmYFAXGbJD43hjfDXFcOWb1hiA2eMAilqdM69kLuyAc1V7AcX1PaYQDEHXdO3lVcn3CG+LQYq/4XjDw+wO29gKFqbS4JUihsUHo8EauNWzeIy58frPB67wuBHn2a3Fjf38/zdtoiRFrc=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3414.eurprd04.prod.outlook.com (52.133.19.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Sun, 23 Dec 2018 13:20:46 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d%2]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 13:20:46 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Thread-Topic: [PATCH v2] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Thread-Index: AQHUmsJJoCj9FDFtKkuyM9TG7go6uw==
Date:   Sun, 23 Dec 2018 13:20:34 +0000
Message-ID: <1545571216-655-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:203:69::13) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3414;6:/WdNbNA2ZOWdvr2/rCmysBLezOk1xwbQGmprAyV6txU+QYP47zatywf+d46KHar1Z5q6w5jxfr9IZrklV7KD9eEtcFllFGeqDS/c1e4bEN+uaaiNftmE941HK70+fFRcVHFIdZuPIag7MJLCW2fryDGjdUH+5S530EryXVsF6pXxY8u/vZhmhOJtlUOG2nWVfgWqpMNB0MiaoVUwNODum9NTyOtVjvybqpQEvmmwhM88APtywdNtP/ElpJCh5I5dV2V24az0epX1kQqy83Nae5ditb+5dz7+FHyMeX3hAh1zLBSoides5nNfHx8hdGjEYnMSiT3LUC1xf+mMJjxygubBIvAubXXWux7PzDEHTLvg6fHwe8rmfhrhMRd++a2uJuNHF0ASPu7b77j2uYGSDesOSBX9AoyutNTvuRE9vOoJIhQ140SfISRn9Q5C7qN0qLRgjL+cNONl47+DMSeWIQ==;5:p8LDs6HOVe4rShxVjkoMh0oSYRl0BdXy/qeA97f1lirwmeAMwM2+Vo4ZaytdSVLbw8nynEwtDuYfxnxeswCLGQjElgBj9qdOLt79Byjhrj0qoEytg3IX57IVyn2V+VuA7MIX30kwU5U49Z8yjEXoho0IannkmkjH3ukL2qaeRoU=;7:nKkuP59Qfs8+aELTQxEe/0LRYskeQFlm767wZzxjKeS4TrW2OQ5uq09vjl4NBCzrl3Vk3sQT6Dp61Qq+F/kf/RGUbQYue935shWr86Go8wzzZsw6czOjqVS0MvIkL0pKp4SqBu/yhCk+hLWkt8aXdA==
x-ms-office365-filtering-correlation-id: 4727e5ec-826d-4db2-3ec5-08d668d96bd3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600098)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3414;
x-ms-traffictypediagnostic: AM6PR0402MB3414:
x-microsoft-antispam-prvs: <AM6PR0402MB34146C75BEB82A89AB0C14BFF6BA0@AM6PR0402MB3414.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220043)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3414;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3414;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(136003)(346002)(199004)(189003)(44832011)(476003)(486006)(71200400001)(2616005)(6666004)(68736007)(71190400001)(5660300001)(53936002)(6116002)(3846002)(305945005)(36756003)(6346003)(99286004)(7736002)(97736004)(316002)(54906003)(110136005)(186003)(26005)(25786009)(6436002)(4326008)(386003)(6506007)(8676002)(2906002)(81156014)(8936002)(81166006)(86362001)(66066001)(6486002)(106356001)(52116002)(105586002)(102836004)(6512007)(6636002)(256004)(14444005)(14454004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3414;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RbYJAh9GDVoUh7VXfqKocX7k2aaNMVwL+PUNF3ZKo0EQRwSTVIuc8x7R/lLkY7K2bDJgGRVcMmy+4DefwnGfCxWmoTsYqPRyhdDahI2fTlgt+bL5Bn9QhZYpriK2hFWarztUjKe1Qnbnfjm8tO3uR9YRkFqX8Igpq/DU9nQ7yOmD7AnxR05/qVJ46q5bPp7nqcWMK6u4LcBb1yYoIAUm/5C7pGfy4fbrkQUNtY3io1vXGG9a2+ah03rdkrKmFVAhQkt8mybEe6p0yWqC2BHkJtaU3yMPC8jUDpMQdzfP7OakFDbiU1WCi5u0xA2X3OiU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4727e5ec-826d-4db2-3ec5-08d668d96bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 13:20:34.8358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this is going to be used on more SoCs than just i.MX8MQ,
make the dependency here more generic.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
Changes since v1:
 * removed the SOC_IMX7D since it's included by ARCH_MXC
   as suggested by Dong Aisheng.

 drivers/soc/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 2112d18..d80f899 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -2,7 +2,7 @@ menu "i.MX SoC drivers"
=20
 config IMX_GPCV2_PM_DOMAINS
 	bool "i.MX GPCv2 PM domains"
-	depends on SOC_IMX7D || SOC_IMX8MQ || (COMPILE_TEST && OF)
+	depends on ARCH_MXC || (COMPILE_TEST && OF)
 	depends on PM
 	select PM_GENERIC_DOMAINS
 	default y if SOC_IMX7D
--=20
2.7.4

