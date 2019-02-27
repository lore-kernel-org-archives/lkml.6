Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BC9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3FD218FF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C+X7QVek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfB0Iqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:46:51 -0500
Received: from mail-eopbgr10048.outbound.protection.outlook.com ([40.107.1.48]:19877
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726724AbfB0Iqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Inv0zd1lGXPYjCKkHxkCG1cGUaq1baqCUxdg4l7brdM=;
 b=C+X7QVek5va9AaONbqdOVvwFaeAG2MxbWweGDvsM+SvYjIuJAxopQ0yZBTvTs8d+uVV7sLK2XHMOKNhIyPaIAfq8Sof2XBXBLsFo4YDPME871F5SbdEyILpdZ0SpOIa1en8W/sRzywhAA1u9WcfCv+lO8smn6ARFcJG72KjshzM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3674.eurprd04.prod.outlook.com (52.134.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Wed, 27 Feb 2019 08:46:41 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 08:46:41 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V10 3/4] defconfig: arm64: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V10 3/4] defconfig: arm64: add i.MX system controller
 thermal support
Thread-Index: AQHUznj1lMbmz4Y0XUuo8x2Mi1zctQ==
Date:   Wed, 27 Feb 2019 08:46:41 +0000
Message-ID: <1551256894-21954-3-git-send-email-Anson.Huang@nxp.com>
References: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:202:2::31) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d84e2d9a-4b61-4006-2258-08d69c9017d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3674;
x-ms-traffictypediagnostic: DB3PR0402MB3674:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3674;23:aIqUSMaZk8deCcLY2pZgGrLAvtBs+fqOMVMNK?=
 =?iso-8859-1?Q?dOOISfTaBf8jzYdC9VH7fRI3L1tC3RLAYTB1F/7dHllGXvZUaZHYzeCdP/?=
 =?iso-8859-1?Q?GpC8L8doMRoIhRYSMr4Y0aDfh6YPUkfo8XJVQmEUXv14ZVzzriRSLreIoP?=
 =?iso-8859-1?Q?JVw288v1xn3S1fOIamI83zegMnwt17gFPq2fidtqEaO1ko944INaLln1TE?=
 =?iso-8859-1?Q?bcDskl4EqUjbcyF8L+/QpZlwSl6fWui2amB0QWZk3Rse0SAmh5yEqiVJG4?=
 =?iso-8859-1?Q?4vxReTlGH8bTgGJuYmCeGSiYkAT9dmK9t+mYZJI/LsVJf3plIHhy1SX3/V?=
 =?iso-8859-1?Q?3EWujWZBhoHgybWJt/mmfUn9LlSj5dKkwlyWzHGOIr4uPFa+fAPq61FGs+?=
 =?iso-8859-1?Q?amhl5tXPcOjyTYiPpwDQV6FXkmEnXkVaDHbUgKLBfGh6YAEUvgzitjIr3/?=
 =?iso-8859-1?Q?BU+uCxs6ygCvlaUQkYZj2igDXoxIGw3ow6c8xEieSpv3aT5QNLdz0jQEcw?=
 =?iso-8859-1?Q?Hrltz7A2jURZB5fDIA8iOQB7w5M5EoKMte9uYw2aq0ixIC8uFkB7I+2RBu?=
 =?iso-8859-1?Q?fBj3HtTNFd1bHIx3Q2IOQ3eBEsYWpWKK0KESEuivjIqKKAo5y4XISR/wZR?=
 =?iso-8859-1?Q?SDX0UjsF/GpfxnABcnx6GcSCga6uYViXct/DErtK+CCXkrOzSJ1yTtRkNM?=
 =?iso-8859-1?Q?8HOR0V+UfRpmZAIeTcGvqw9i7ZPcP50Xgq3VvmKM3bXkjLJ8G8p0w+6/YA?=
 =?iso-8859-1?Q?IN+cdDM4OpDuFjOfS5kpDAsqYvZU9/0SwFPJ3RUe1g2mU6BEhbP1Ok2IJg?=
 =?iso-8859-1?Q?v9reZpdil+nYksUZko3/atvtd/t037uXbhMMCZSpdkIigJFKNFJsxqMtsw?=
 =?iso-8859-1?Q?IOM0gHFfONItjfzswlQC07e0Caeq51TJ+isQK8t8sGaZOXVXC1aPjgKeX4?=
 =?iso-8859-1?Q?EJJ44Z/uzhWjxOflBXMJa554D5Ko55acRp1FAvbndKOll8VBkK2tdqKLQ2?=
 =?iso-8859-1?Q?Q+PatJw7iw57frjN1Wl0np9iDM20DT6Yq93kf2cIUaD3mf6DKU5tXi0uwS?=
 =?iso-8859-1?Q?8/clZXePn5m5OQkoedVRZ/goyAfj4qzlb7tbQKN5qgOIpXl2V7EZCB/RDq?=
 =?iso-8859-1?Q?E49cG8r9dywU+Hsv0sGNTN0M+HBx9meuBdwAaa9+nly5xhBqWfBwGD5vGb?=
 =?iso-8859-1?Q?GzNRUFDaNIQeV3fnwbjyUeGQp4AGShlHM1ZVnHtOZv5GKJmQlNmV8mwnri?=
 =?iso-8859-1?Q?coiRnT6c/q//1YEDVG6H9Kvp7wBGivrZFnMiVeIckP7k36Gi+mmuMh5Vh8?=
 =?iso-8859-1?Q?bJMYCyQWMf/VlzE+vSdFVoYVW?=
x-microsoft-antispam-prvs: <DB3PR0402MB3674F8391E2024AD13574627F5740@DB3PR0402MB3674.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(25786009)(102836004)(2906002)(81166006)(8676002)(4326008)(4744005)(3846002)(6116002)(478600001)(81156014)(14454004)(8936002)(68736007)(6506007)(6436002)(186003)(2501003)(386003)(71200400001)(71190400001)(26005)(5660300002)(6512007)(6486002)(36756003)(86362001)(52116002)(316002)(7736002)(110136005)(66066001)(2201001)(305945005)(2616005)(97736004)(7416002)(11346002)(105586002)(99286004)(50226002)(106356001)(486006)(476003)(256004)(76176011)(446003)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3674;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d9Lf7ZY1rqyg52RjvdOVYxlq8tS0CAd2F5E3sDdvUSFlL7JXrH5GaeB/0VxCCw0bG7Ft8WMZVHHNVfbDfM8Sm9MgfZEV2UkMGiSI1W7ZTsfyIkMa8pucstBKVaTeZ6wQZLiLjhPazCCLpw63s1MwvGeaQH0vuz7jjvZgCSHgdfRe9W8SGle/R9ahhW+9qGpauqfmb/GQHX1WKF2+UX2PZE6X1knst6VtdsE6wzpoCp+7v/+lLG02N6sTRrDpYPYnCydPLEEyvgfFiJxC6+CMDIt7BaNKoo2nACLy7ZijufKCgNGJXenNyCFci9bBWGPzRICRMAK7uhAH1A+y1Mw2zAwq/X9EDfA/zZ/AKfbgQk632xTt0fPL5V1FrIsBepw+P89gBSFmPRQ/UWdO57kiFOr+TPVheRCtvloL6CNIKe8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84e2d9a-4b61-4006-2258-08d69c9017d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 08:46:31.9698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables CONFIG_IMX_SC_THERMAL as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c390..52d503e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -413,6 +413,7 @@ CONFIG_SENSORS_INA2XX=3Dm
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=3Dy
 CONFIG_CPU_THERMAL=3Dy
 CONFIG_THERMAL_EMULATION=3Dy
+CONFIG_IMX_SC_THERMAL=3Dm
 CONFIG_ROCKCHIP_THERMAL=3Dm
 CONFIG_RCAR_THERMAL=3Dy
 CONFIG_RCAR_GEN3_THERMAL=3Dy
--=20
2.7.4

