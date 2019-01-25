Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2610CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAC3218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BbMUbkWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfAYGC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:02:57 -0500
Received: from mail-eopbgr00040.outbound.protection.outlook.com ([40.107.0.40]:38033
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbfAYGC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkK6eG+ALZtENd0Eh0aeePYod4dZLLCjk0Z6SR/ezvY=;
 b=BbMUbkWi0wAT/3WEbU82XfvYxhbjLuKfl6pOyVt5Eq4o1uoAHKRys+0V93priN08gW/4WrqIa/DhrJDaNvdHNiBuWn1lc8y7SFqg5MwE3vOhLRhwlJuZOfe/zd6Kvk+ROl4CdFzyRLhSsRRDsv4boQE75+ZIuWphGU6phUyaeI4=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB5455.eurprd04.prod.outlook.com (20.178.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Fri, 25 Jan 2019 06:02:51 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Fri, 25 Jan 2019
 06:02:51 +0000
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
Subject: [PATCH v4 1/5] usb: fsl: Set USB_EN bit to select ULPI phy
Thread-Topic: [PATCH v4 1/5] usb: fsl: Set USB_EN bit to select ULPI phy
Thread-Index: AQHUtHOaww2wJ1zabEWo49kUjNOKxA==
Date:   Fri, 25 Jan 2019 06:02:51 +0000
Message-ID: <20190125060356.14294-1-yinbo.zhu@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5455;6:XkN++E+SpTaMMqexvBF1BfUlYFixQ1jvkuvEQzxuCNaGt/kAT2CrYaGh+NVQFLtwwVRJoNwo293f0ChjWN7+nCyz+9UqWKN5rwhn180787DPru5dMko5YrQlCmtHp9bnBbZWR1PxoEcq7x8+hoZ1nGgDCVoWuWd/h2m29P+lCsOP/oREnWWdyY0vUsohWdaF79v0MjQBih8Tb3HVVpxOnvKoJygJRiM7e/o/45aw90PYv/Mmbltq5utfLwFX6Da1g6wPaHAsLQdZAkp1jVu8toRhlARKzXWbjSmpkqQYQ/74G0YPGIOMZJ1dynjO4ifmge2ATKV5U/HJRX1iq0mpfBMGKNA3oZKxbG110qe+kbMexIONnDU5YtWGD5E8HfFYlMwwXh0gU0LKw8kLjRvSPxoZMuF1a7NzILmrqrJE5N333aTt7mnLmOv1nfztcf3H4wn31v9jvAajYL/OY6JHkQ==;5:k5+/fpPz5aXjdzPSdmmZvWKWTQ9kYtaT9jW2VyoVlu3KAbLMsOHAZi5ebqq5vIPTCZ2M59SWViHewCntUqFqrIRdksJzJTAGlS3LfbcETuPVMVodqIZWTy/KyN/O8M1SBTZzUuCGBshCwz4/JfWcHjAwTbi5gs0MSNChRDVwmLegIDFP6j/DMoVxu9UjQEPhgYNIScBxCgbPkQbS+NlGAg==;7:VA9mlqMCNPyBlfMIPPx7wnk7WicjUarspCR0fr+tlbdeX73RP2excGH37ejiovOutmgIs7s99Yl/XrtI8hLIthQ1H+KxM0d+YAw5LGrQDQgy0iR2rmuhcG7NUBJyhA1AOx006EaAG1DTQEuw2abm5w==
x-ms-office365-filtering-correlation-id: 11fab9ed-862d-46f4-2232-08d6828abcdf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5455;
x-ms-traffictypediagnostic: VI1PR04MB5455:
x-microsoft-antispam-prvs: <VI1PR04MB54554ED64E46EA17DC3B6CB8E99B0@VI1PR04MB5455.eurprd04.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(189003)(199004)(4744005)(6916009)(486006)(4326008)(105586002)(106356001)(52116002)(1076003)(14454004)(2616005)(6486002)(44832011)(6436002)(476003)(316002)(478600001)(25786009)(3846002)(6116002)(2171002)(50226002)(305945005)(7736002)(8936002)(26005)(186003)(256004)(86362001)(54906003)(71190400001)(71200400001)(99286004)(102836004)(36756003)(2906002)(386003)(6512007)(97736004)(8676002)(81156014)(81166006)(66066001)(68736007)(6506007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5455;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xRGVpL8S4kY+1jyizqtdQLu6JVyk8ntjYwgdPqZJR67NbWjvJeNpuKsepXuxbf9hjyQt+r123WWLjw+sS2j2PXOpYBDORihwMVAeiRP4PFw9XQae9RRHnlVfgx6snZfHyKHevIK1BQL2qlgV45RZpc6E8IghF0GgkcU+sVBA3V8KOaJHBhc4sG1Tx3xd8XeZJbIDmsVX4Dzpq36q0hBS15RvWYhBd2X7LknB3FgGJ5CjPOSaae88TUY+5MlncGt6Cwu3/uSDCp31mgB0jWWSFKDd+nTp0BJfSxwtTP19aVlkGTVtJZiQJm4p7n1vuDpa0COGGt4dUejMx/qWL8Y7xxUcWbeRDbuJocAIq/HQrXYtuVF9bIHqVMj4RTLqFsVxag7UFjWAx9oLtIxR1SU4DgfMrMY3C1NxPZeodhMPGMs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fab9ed-862d-46f4-2232-08d6828abcdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 06:02:46.6903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikhil Badola <nikhil.badola@freescale.com>

Set USB_EN bit to select ULPI phy for USB controller version 2.5

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
Change in v4:
		Incorrect indentation of the continuation line

 drivers/usb/host/ehci-fsl.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index e3d0c1c..38674b7 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -122,6 +122,12 @@ static int fsl_ehci_drv_probe(struct platform_device *=
pdev)
 		tmp |=3D 0x4;
 		iowrite32be(tmp, hcd->regs + FSL_SOC_USB_CTRL);
 	}
+
+	/* Set USB_EN bit to select ULPI phy for USB controller version 2.5 */
+	if (pdata->controller_ver =3D=3D FSL_USB_VER_2_5 &&
+	    pdata->phy_mode =3D=3D FSL_USB2_PHY_ULPI)
+		iowrite32be(USB_CTRL_USB_EN, hcd->regs + FSL_SOC_USB_CTRL);
+
 	/*
 	 * Enable UTMI phy and program PTS field in UTMI mode before asserting
 	 * controller reset for USB Controller version 2.5
--=20
1.7.1

