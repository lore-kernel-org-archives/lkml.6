Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A16C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBB820652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GRHfVE/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfBYNSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:18:34 -0500
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:2229
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727011AbfBYNSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NVjQ5W4YBNYBcdkZZgEi3CaQg9mWST4R9OGsHO+J9I=;
 b=GRHfVE/PkNz2ew28QWic3dUbuZamG8F4BMnPXAhEdisApy8khiswzr8T7c1jJemMJO7UrHqGJ+kMCskOxLhgh8lecsuGTIwZtB/7Orvct+ojJDC2lJ5R/gDbyMwLRyf/4y3rCQ+ORRJXNN/NtzL5GfpwenJ/fpCDgOfsQyXFtdg=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2895.eurprd04.prod.outlook.com (10.175.24.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 13:17:48 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:17:48 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 3/5] arm64: dts: imx8qm: Add SAI pinctrl configuration
Thread-Topic: [PATCH 3/5] arm64: dts: imx8qm: Add SAI pinctrl configuration
Thread-Index: AQHUzQyA05Rkgp/bxECMWAWFA0xKWQ==
Date:   Mon, 25 Feb 2019 13:17:48 +0000
Message-ID: <20190225131722.10253-3-daniel.baluta@nxp.com>
References: <20190225131722.10253-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225131722.10253-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0202.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::32) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecb15989-4075-412e-526f-08d69b23a2e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2895;
x-ms-traffictypediagnostic: VI1PR0402MB2895:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB2895;23:rYVMPUjfQqUT7Iej43AxhodX8R4OwhnGIf8De?=
 =?iso-8859-1?Q?/N+Pym0kb7sMvgI0elGWuv93dMTBQ8s4VnEz3RWl9IxtHJKgSoCxmbV53f?=
 =?iso-8859-1?Q?9gJURzKEtV9YC4maxy4JnOsc17VFU9Sb5XSaVkYZAyFvPERiFASXUjly96?=
 =?iso-8859-1?Q?Ed2ZNUoa1ybNwpl2eR0qPqL50/4y/UFnsGNUnYdRzbJ8c2IV8VzVgC05A0?=
 =?iso-8859-1?Q?uRxCOVvD39a4NmU87ydD9FASDPaCDWLbxeR+mcyamQXy3lOjqq7agA/BZN?=
 =?iso-8859-1?Q?LVB2qt/uGbsuunHpiJV44FlyCpUi9kbc/RFH0Fw0+RX057S9CMOtetNSaa?=
 =?iso-8859-1?Q?hj2BsnmgmOriSwGEncdr+vnLNZjtW4vXfhWiWWIf+IRQaF/SAwujVVtI7s?=
 =?iso-8859-1?Q?V0RDacON1y7I3M9cq6tXdfW1atAk/zS2atplLZeELC25/Ieu0Ewr/CSoG5?=
 =?iso-8859-1?Q?Tq9CbCXqETYDP+ObPiyhS0INng7BdgwTxm9zILK4WKNzgWlsws+U/Do988?=
 =?iso-8859-1?Q?Kw5ewNJmFZ1skNlW44yWXYmNjis2HGnnwWslH24rYEydDjKrEhCyfA4w3n?=
 =?iso-8859-1?Q?5y3v//KHaIyA9Oc5hH58flupBwqdGBoFHaiZWqMtle1SfiwN8rUpJJdjz/?=
 =?iso-8859-1?Q?jFcmR5w4biqEKbx06Z9gKbhIQGug25lPGhlb6UWs4Ot+WI2E683quwruPR?=
 =?iso-8859-1?Q?bz2nCJ38AfxceSPWS+BYZlWRjMj0BloKRQ6fzlHuQDHTHSgOuEwWquzmT1?=
 =?iso-8859-1?Q?/pH6yZQa+bIbrKZ5Rpm0GFuWolrv5aztpxvwE5m5CdfWqDDEGTfjglCX0t?=
 =?iso-8859-1?Q?rtsjc4uEdcIoL+CWftdVNBIGlulIuX7ezeVHgnwiQKJ5xdsJAV5uvhcgzw?=
 =?iso-8859-1?Q?FJluaoGP6PC1Jpdp56szBuq/ndS6oCfblx78NHpo7/2laq3c7dk6qg3NbJ?=
 =?iso-8859-1?Q?EyKkEoa0ItOcH8+ABV/+GkSYK2JljBd/Win9XWoQ3fKI/vDhgjLRmwHmhF?=
 =?iso-8859-1?Q?Eiht5ovEl8qi/IguIbpZB5DTrBBpqGOykXDWrg8QO70csJNSfbJbV5MkWA?=
 =?iso-8859-1?Q?CAL4fBpZmc/vEGIkOP4Gn6NGfOCekU8XLojJr/TKADfOeb3UFvsnnQJSFD?=
 =?iso-8859-1?Q?sngfWqtvsLZCiVsPeqctz/yGfpNQkEbIxd8aDlzu/3OoIZgC4mWkTHS7YA?=
 =?iso-8859-1?Q?UYtjwvkALLFqo64jodVldDvF1hdeAryJvt7lchkjyuY8dSZkG/DOum+Qbt?=
 =?iso-8859-1?Q?OGrSLf4vg/E2q3oqXfIQI5jdDS+CW8G64vQ+TzpMdZmKMfDJq6N7T47sBd?=
 =?iso-8859-1?Q?QhsMVYZIblDqdaA7QnvOGEqkf7t78UYq4BQbOJrCACvclpJDuJMJW6vXsf?=
 =?iso-8859-1?Q?qmwoWNYDHSR8Th41Sqop+XtfkimJhTs70P3ZX0Ae+wNhRqVhNhV94GsG2J?=
 =?iso-8859-1?Q?tv55sXotkMPAzWyA=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB28953018E806FDE60006DD90F97A0@VI1PR0402MB2895.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(8676002)(81166006)(1730700003)(2351001)(81156014)(446003)(6486002)(6116002)(3846002)(2616005)(476003)(186003)(44832011)(36756003)(305945005)(11346002)(486006)(7736002)(7416002)(106356001)(26005)(105586002)(14454004)(5640700003)(4326008)(6916009)(25786009)(256004)(6512007)(97736004)(50226002)(2906002)(478600001)(386003)(8936002)(54906003)(102836004)(66066001)(71190400001)(71200400001)(4744005)(316002)(1076003)(68736007)(6436002)(86362001)(99286004)(6506007)(5660300002)(76176011)(52116002)(53936002)(2501003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2895;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9Bus84Vr2ioPpsmqNqj2DcxZcecDuoWUmWsY+gs7w3M6rIRMDRaJbWokxip1p7l/9DRIm2zYTXhHApBdTjdCDu/hvzEBlfP9uQi9nBeVEUaPmV4naBqVBt9V+i2Vosn9uC/R68tIzIhkrFt3kYx9LRn4hoL4sFH4WWzPt9zlyBFPEfNEA+XeZCfSqAI6MWVj8nHGHuju9CdGd6xr5VvFdb5pfmwrrF8wYAnE43Xfg5Acb7R6ZyLVKcBmFl2yp3ssiFzPegXCnhAcUhBiLjHn+CnKPAa0yxBpxsa+zThADh70aZR7gWVPnvS5SiNuoauCkEVyZ0QSno1pPQcEGoyKfS1tYkOys+CdZZSTbDw1bBi+9YiLnA+VRnJ9oR+c02o8aGohm7nMlnp86XMToHd584nh/aQm+wUeM0y/Kt2zhqI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb15989-4075-412e-526f-08d69b23a2e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:17:47.1163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sets the pin configuration for SAI pins BLCK/MCLK/FSYNC/DATA.
GPIO_01 is used for mute.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
index 54737bf1772f..d21ee2a5312c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -223,6 +223,16 @@
 		>;
 	};
=20
+	pinctrl_sai2: sai2grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC     0xd6
+			MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK      0xd6
+			MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK        0xd6
+			MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0    0xd6
+			MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8       0xd6
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins =3D <
 			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
--=20
2.17.1

