Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B45EC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFF1218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N3SgetWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfAYGDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:03:49 -0500
Received: from mail-eopbgr00076.outbound.protection.outlook.com ([40.107.0.76]:34823
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbfAYGDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0IKRecnFAAU0wtY0kl/7PEcI9Y+xCrg3ypS1gwNzSA=;
 b=N3SgetWDWOuI07dC+4DoAALU0SWda0dv1+PIZQlu6bDA7wh4sTR4krQypoPHAv1lw/PdWS+/JwtuFgGYUw2FTwljRwsWhBkTdRdr21adQSV/ueHnYa4TgvAVrjMXqQkjwn0P43PCjbKC1aoRWfauABjjK87hBLhSMBm1YEAiFtM=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB5455.eurprd04.prod.outlook.com (20.178.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Fri, 25 Jan 2019 06:03:11 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Fri, 25 Jan 2019
 06:03:11 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Yinbo Zhu <yinbo.zhu@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jerry Huang <jerry.huang@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/5] usb :fsl: Change string format for errata property
Thread-Topic: [PATCH v4 5/5] usb :fsl: Change string format for errata
 property
Thread-Index: AQHUtHOmPG3RGfu/2069HGSKVx2OYw==
Date:   Fri, 25 Jan 2019 06:03:11 +0000
Message-ID: <20190125060356.14294-5-yinbo.zhu@nxp.com>
References: <20190125060356.14294-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190125060356.14294-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:46::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5455;6:q79+oDYQUNZsWANHZwd++M2e9L2JVsegJV1UPVAuDk2x869EXIIq7pxqndnXWhR+qaA70NZb9ft/DLMlXbCkwXyI5iC+QUhzBQJhKzjEszRouROPLafOlvTB/r/hx5+XGPNTmCMQTnTpEingqp/tuGWcNjWvAUiLxTG8WQmMjfRm2r+NfaTmIbMFNzrHwZrAY5rqi9QMo7awFY5wOC0LHZYL3fgL54Aokz2H72y6T4Zj2eJnnqK6WNfZAtPngprEmDEUlUWbwKBrSdZ2P33xwLNTaFlueJRhoA8Hg1dgw54PZlKJmkOjO2Z7bU1O0QnzV56+4cJX8575rAD/AqGSU6PxoVWscgar1J+LNWB0B9uV5iGSjn0ItWcdRNXLTKTxsUc7DJHynEH2vjpTWWTND9zCJEBvvzUbHgMmCwnV5+kr7/MhDi0AE2/KzFXspHfiDPU6ppmZmC4UpdrlbdWy0A==;5:yXkiSz0eIAAwZYg7Ri6lOowI+g9n8AnykFSJpIg8vSZCNmYzjDO3l8EJe5k/4UCWGJz4eWvk1mZd0zE9mk5ualGJlLsbMlHXy+yj8urz9mI4pwBusZ5XYlzgzhw/FTTqldVyASXDngxWDaW7SWCqYN6w8ToSmBfwVKxb4jPYivavI+AXjiFMDwcePiRHPiC/h6B90aoJzzeonPfIoBy49A==;7:RyaV2eVmDfzcaRcNo+00Gjye2/rZ4sxW229/QAa24Dkf3VNccmBVCAN3waKUbiz+u7f5m7pDzq3/7zdBWoCi/57unpER47P7YtMSpPKZHPiJDOH6gI05R/By95C8WyzftHKJc36DuTpiP25KjEZYRQ==
x-ms-office365-filtering-correlation-id: 17b4ad8c-2100-475f-5f3d-08d6828ac8e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5455;
x-ms-traffictypediagnostic: VI1PR04MB5455:
x-microsoft-antispam-prvs: <VI1PR04MB545547C0CAF46BCDF7ABEEB8E99B0@VI1PR04MB5455.eurprd04.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(189003)(199004)(6916009)(486006)(4326008)(105586002)(106356001)(52116002)(1076003)(14454004)(2616005)(6486002)(446003)(44832011)(76176011)(11346002)(6436002)(476003)(316002)(478600001)(25786009)(3846002)(6116002)(2171002)(50226002)(305945005)(7736002)(8936002)(26005)(186003)(256004)(86362001)(54906003)(71190400001)(71200400001)(99286004)(102836004)(36756003)(2906002)(386003)(6512007)(97736004)(8676002)(81156014)(81166006)(66066001)(68736007)(6506007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5455;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cu38dJMtrUmsy4ar8Br5SAWmnMsPI860130nN1YlhoNs1j1NBR7AJVEcjkNy28iNGu3/uFB1SqxFV8Kn0zjOW7flK/flrV0E4TVWluJbbKOkdHAuy8H+He7ccRDpYhlgqxtmpwQqnIMBYdtLUwlRvR+4a2ZE7L54CLgxwJZv645rCzucDB1THVRbpwDgNml7cL9Tzw4YXmp1fNlxxnaasydswmpRhr/HaBQkFFYeblcEJTiIT7/0T+zLe+jKhaUSpmWVFU4wAGqQaQ0IfmodlCeO9X7Qv6cJzJXcNzFy9uK3NYNyZPNaUDZ47C8IiqYd+YX2AlMW0lpjfoL7hq71Gj0UpI4BIelxgltyRrQC6YCGUA5xZQ3XImwzdWrh4tMWzOyOGAWDR7O7MpJvnxEUS5d115nuiMfxxZXGuwF3Qs0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b4ad8c-2100-475f-5f3d-08d6828ac8e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 06:03:06.5186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikhil Badola <nikhil.badola@freescale.com>

Remove USB errata checking code from driver. Applicability of erratum
is retrieved by reading corresponding property in device tree.
This property is written during device tree fixup.

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/usb/host/fsl-mph-dr-of.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr=
-of.c
index 762b976..ae8f60f 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -226,11 +226,8 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_de=
vice *ofdev)
 		of_property_read_bool(np, "fsl,usb_erratum-a005697");
 	pdata->has_fsl_erratum_a006918 =3D
 		of_property_read_bool(np, "fsl,usb_erratum-a006918");
-
-	if (of_get_property(np, "fsl,usb_erratum_14", NULL))
-		pdata->has_fsl_erratum_14 =3D 1;
-	else
-		pdata->has_fsl_erratum_14 =3D 0;
+	pdata->has_fsl_erratum_14 =3D
+		of_property_read_bool(np, "fsl,usb_erratum-14");
=20
 	/*
 	 * Determine whether phy_clk_valid needs to be checked
--=20
1.7.1

