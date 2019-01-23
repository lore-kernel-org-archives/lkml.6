Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186FAC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AA720870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="th+kFR5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfAWHFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:05:30 -0500
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:11488
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbfAWHFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou/cxH1ZtpfNCwtRpW7qcW4PT1fqSfelercThCdDzNA=;
 b=th+kFR5Hmdw2WwOA/ktfZ5D/T+Zz6St9edMWKCaAve1j8LF38GQA61iuLfs70ZDAliWuOhR9qrLNQL8V4WX57HgpYVkekO1fr/DV9Qo8iZBSD6UvxaQFigr9fKIRdqfoJso7yk2vopiGeSeELNuwT34VPqYMrjOSAmoJ65pmnCk=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB4717.eurprd04.prod.outlook.com (20.177.48.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 23 Jan 2019 07:05:26 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 07:05:26 +0000
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
Subject: [PATCH v3 1/5] usb: fsl: Set USB_EN bit to select ULPI phy
Thread-Topic: [PATCH v3 1/5] usb: fsl: Set USB_EN bit to select ULPI phy
Thread-Index: AQHUsuoEAZ+tgAeQzEGU2KnFgFz/1w==
Date:   Wed, 23 Jan 2019 07:05:26 +0000
Message-ID: <20190123070615.14462-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:46::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4717;6:xPM7FbK3TfEEj/ex40jddpO41fuWeknxrhpL9y1m5UKRISKz66fUlrd0bOJnqFKKjnZpwWOPXthKrjs0fE0Pi2OKylHRX5GI/8r4Nx1xBEyQK7enyzbhKsB/84/NV/ZXTaMHZjNQ6VPTYGoC0ETlVyQJz7Q7Zp3lD+8rOeJ42QeDuUktFR9LSRDNEJvhQ7SaS72IJ2FY2c1VIdAfvw5sCPhr1QP63JZVoSVvOAyB62DwTGBV25/4U2H15FY6sfp7j4X2/UzAzTHX9/x2tjWsLm3mKtPExuugPHbmADg1/Ko2paOAQu8g6P9x8bMIi3ZwVLafiv7ZMcOw1e3iTur9+NsYSiqaFJFNGKoX7RWpVsBUYQapN0kyDxgML9rdrhQspEH8s3sQMaeLWGTXMYJ4dTulzCvrqwEzL47QjF7HWocsCUu8ya/iyKuEBhLGGg7etepaQxfq4zMV2rZ1DczyYA==;5:fsoo/J+q/eIV+aDMnA+7WmAYBcp7lNz4MrcNDdAPnVoIXWIJ75mmdYa63LSTfKH9VThvfdf9RO2kyO0hQSk2kU2oRog/nh+GAKUePh6QSheAkiVIP8is1CXNl1TtRKkSkp6iFJXs2y3esEdWYer1nQ1uYptJqg3O6zRu7eTmjNgQWI96BpwbIbVcfH2itcmQFwZXFhF16G9N9ctL+wIbDQ==;7:zBWiPg6Xlimvjkm3GXexKgkcZEWKJk5qcNQkma5eILTgTp07Y9DnGQ/hRibdv6a+MdH1mmQF1WbhDYf8bIUvpvKpGrSWJ2JOAMKfB9baKwr05++sG7AI0vKo1qf2gR3QWVZEkCW6/ZJeyyOFC0U6Jw==
x-ms-office365-filtering-correlation-id: 1abcd217-8d53-4105-e14e-08d681012665
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4717;
x-ms-traffictypediagnostic: VI1PR04MB4717:
x-microsoft-antispam-prvs: <VI1PR04MB47177E2769F6029DB0B66D60E9990@VI1PR04MB4717.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(366004)(346002)(199004)(189003)(36756003)(99286004)(386003)(53936002)(6506007)(6486002)(7736002)(71190400001)(305945005)(6916009)(102836004)(71200400001)(81156014)(86362001)(52116002)(2171002)(25786009)(81166006)(4744005)(6436002)(6512007)(4326008)(66066001)(8676002)(97736004)(486006)(256004)(106356001)(316002)(105586002)(68736007)(2906002)(2616005)(478600001)(26005)(54906003)(186003)(6116002)(1076003)(3846002)(14454004)(8936002)(44832011)(476003)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4717;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LyR6Q/RTog1EL6fCAB7taU3CywsA8mvzP+Z5cJPvkONoSj+x0FrRkzTH9lj03nDAE4HNSFsXQwqTebVk0stQ0g3TWXse+ha+kyejFB5noeC/n2IAqDuVSGWb2pPpi48AnjpLQRDK8FWKfbUjOblCCIsafqWxEdiheEj9xWua8uirjkx6MdR4VWiM3nn3cikaEN2Gg0GBX7xNd/lR835/WtN4KWweI5nSVI2zyb2wUVFU7f51PFxoqfdG52Q4QqeafucN/9VlI76+4GPegUGFOM4EiFyHF7ESwKfl03XcnwDFiD+RHrWUVNIF4FRUc+sqtd1AmFOcjnGS9L26NUyynBq4TzIcJXhyG5PPBXQF8JeWvppxJvMt0agsr+fJ+WW9XXq+WKLmOEPBKTTxg1ygxv+ex8hPwjTwzjr6fURTkSw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abcd217-8d53-4105-e14e-08d681012665
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 07:05:22.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4717
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikhil Badola <nikhil.badola@freescale.com>

Set USB_EN bit to select ULPI phy for USB controller version 2.5

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
Change in v3:
		Code base already has patch[5/6], so remove it. =20

 drivers/usb/host/ehci-fsl.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index e3d0c1c..ea7e17b 100644
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
+		pdata->phy_mode =3D=3D FSL_USB2_PHY_ULPI)
+		iowrite32be(USB_CTRL_USB_EN, hcd->regs + FSL_SOC_USB_CTRL);
+
 	/*
 	 * Enable UTMI phy and program PTS field in UTMI mode before asserting
 	 * controller reset for USB Controller version 2.5
--=20
1.7.1

