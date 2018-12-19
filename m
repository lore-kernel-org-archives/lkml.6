Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC142C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08612054F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="espWOOmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeLSIjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:39:19 -0500
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:28016
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727696AbeLSIjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VIr6ViroUsgEJ1JpWyFUT68p2ZRVYVKOa+itDuIUr0=;
 b=espWOOmkphsKexzItKGehRCHTcxzmIukR6CApIxjUGkbT5uZ0dx9qtnowLMAww9rbFFmMYCwZbfl8EBcjnbu/RvRjO/Tacc2xzW2UtfEUvn7JoChQodOiOEpeZmxdFgiCGtR1+OTGx7Wd1RrzGCF7VVVCDyw2Am8EznPbkrI2vc=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5226.eurprd04.prod.outlook.com (20.176.236.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 19 Dec 2018 08:39:07 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9%4]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 08:39:07 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 3/3] can: flexcan: add imx8qm support
Thread-Topic: [PATCH 3/3] can: flexcan: add imx8qm support
Thread-Index: AQHUl3ZNU9SYX5tKg0iU+Zk5TZUuzA==
Date:   Wed, 19 Dec 2018 08:39:07 +0000
Message-ID: <20181219083637.641-4-qiangqing.zhang@nxp.com>
References: <20181219083637.641-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181219083637.641-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR0601CA0014.apcprd06.prod.outlook.com (2603:1096:3::24)
 To DB7PR04MB4618.eurprd04.prod.outlook.com (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5226;6:6M7Q/nFm+YYeyFo3s4A5uy7aYWJ5i20g1PyNeymnGOBPjTChTEmylMd1re0nR0GjWnwGl/iMECudlESNe8N/WlY43yfuZw5Q6TrrNtp04ZOXsBeoyzjPyAAxHv0LgsX2qX/leqDAzbo7TJRfA1sLDTT1pf2Peq3tRhmbfyuI3yYf638UsclwFR223nSY0Nb0Wjpw2fq6pOAeR8VEDGBCd2JqxWH018Yc42FdK1mVx7aZvh2y7gLojDQmWb4NefeocKoa0CDyo1XWXLKkLQxbReYI7EixMoXT42/FnCEFfI0x9wkhEUs3X1ectdKl0UJOZ6AV0x7pRj15lB/JfuK8a4sHk8DBAorKL9ybHngDRO5XjU+etGtZMNvUqaVpAbbvEc6ccgf5+gX+VpZI2xYwrZTqeTAcqhStF/Nr7hS0sXDLaS7e5CdEFWO6wUvUPBVbLKhuyhz3lDVCq17JtOoX9w==;5:uQqI5dFOj/Xw1ZACsby6LZearrDaIL6ddrI7jBkM6LszWN+hbfkMBG5uhnhEPajrODkvpzQRWX2Yft08gtaimuJ3+/at9c5VIk4P2IMMkjTojGwlRKCSNwZ/xKnknnXLwvbqIYQMBjAG+7smG7FUYcC3uhh1Dg6gzPMJTq/PT+E=;7:rtdeq3MpU5Ymjjtdo2uIG36UXPqyEGd7pokHs1OsvKwbGl0KpYxbKUhm9kTXQ3ZYeMkY3i96DaznkAbHdC2ANDUoCYBB3PScraGR2n5J+IGO6J1zN4G7CbIrG3YlKmCM6nEOLv0A1/09IeLgUw3GyA==
x-ms-office365-filtering-correlation-id: 687821d2-d8b5-480f-bc0b-08d6658d7034
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5226;
x-ms-traffictypediagnostic: DB7PR04MB5226:
x-microsoft-antispam-prvs: <DB7PR04MB522642C8F9C9A7CC1E83F5C5E6BE0@DB7PR04MB5226.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5226;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5226;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(316002)(110136005)(54906003)(186003)(26005)(97736004)(8676002)(6436002)(7736002)(6486002)(50226002)(2501003)(81166006)(8936002)(6116002)(52116002)(6506007)(76176011)(86362001)(102836004)(386003)(3846002)(2906002)(36756003)(81156014)(53936002)(71190400001)(6512007)(71200400001)(66066001)(1076003)(68736007)(105586002)(305945005)(106356001)(4326008)(446003)(486006)(2616005)(476003)(11346002)(25786009)(99286004)(5660300001)(14454004)(256004)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5226;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oehyQSn3I2P2CLPcUZ/N/PSUseJXeij2bexR6FDXdmmvz/7lil9Z82eSjq5oA5VJBllyDkR+zcuriHyegl1OptyY41UNdcHWgQcKESgDMx930eUHSUfONa+2uqT6/LJ6miAqlO+SJ7nN7hFMyolrdCRjs/R68oKQusM0lD/ivDHe+o9ZmD1tcYaxdnz8N3jn3cJ038r9JndwwDvusRDPvhNq6z8eTLeIm3Bwt9CgIPwP7V6MtfR2iZx8gfYrmWDo2EnAD5ctQCcKGw/olyaskps01zSLFQe10aTz5KlrbL3QlgW5Y76h0vnFWfBUBLwe
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687821d2-d8b5-480f-bc0b-08d6658d7034
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 08:39:07.0564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

The Flexcan on i.MX8QM supports CAN FD protocol.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0fc77d4e8ade..b7ab6ed87344 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -331,6 +331,12 @@ static const struct flexcan_devtype_data fsl_imx6q_dev=
type_data =3D {
 		FLEXCAN_QUIRK_SETUP_STOP_MODE,
 };
=20
+static struct flexcan_devtype_data fsl_imx8qm_devtype_data =3D {
+	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD,
+};
+
 static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D {
 	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
@@ -1534,6 +1540,7 @@ static int flexcan_setup_stop_mode(struct platform_de=
vice *pdev)
 }
=20
 static const struct of_device_id flexcan_of_match[] =3D {
+	{ .compatible =3D "fsl,imx8qm-flexcan", .data =3D &fsl_imx8qm_devtype_dat=
a, },
 	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_data,=
 },
 	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_data,=
 },
 	{ .compatible =3D "fsl,imx53-flexcan", .data =3D &fsl_imx25_devtype_data,=
 },
--=20
2.17.1

