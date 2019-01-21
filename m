Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED7CC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D27F20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iOGDIOG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfAUKZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:25:06 -0500
Received: from mail-eopbgr20086.outbound.protection.outlook.com ([40.107.2.86]:64147
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726231AbfAUKZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhKsbqWj79Ubee88jWim4G6U4muyRG4bNDB2cI3gVdg=;
 b=iOGDIOG1G3F8Xp/oCT22AdysrAXUg9xmBVl7IQne3j+JNvfeeMdDayerC0PwvLniNBED1ei7MV0YMUgs0JuBhDxCZgJTtmoQcr3dr0gJt8Gy+sNQ00MtI23iSGxoe1bPxHNkeFxZnJM3fyzDyZM7eGoxXF0AvPmsyig0S/DlyBs=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB4111.eurprd04.prod.outlook.com (52.133.14.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Mon, 21 Jan 2019 10:25:01 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 10:25:01 +0000
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
Subject: [PATCH v2 1/6] usb: fsl: Set USB_EN bit to select ULPI phy
Thread-Topic: [PATCH v2 1/6] usb: fsl: Set USB_EN bit to select ULPI phy
Thread-Index: AQHUsXOQuCNR1eimmkSvf2OsvNDAKA==
Date:   Mon, 21 Jan 2019 10:25:00 +0000
Message-ID: <20190121102601.4735-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:46::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4111;6:ACRA+xaksBABWkGcmOMgfjf7zb+2WBuGsWZECa8md1CtqFisR1rvfTf8frgleVQRegsmv5dCnUmNBnffxuXuv8wcrXJ36RFl86RydYfQ5hVXGNyrmcPbJd3WU9+TGltfVPmQ/lDvqMNl2X+DIoEI4GeCHQ7xjlv3jh3/7MGRF4V64vbVOpRhtdNxFjd4XFHui2F+/Par7yiVoJiNA074eqP98AGiaMYdyOyzxuY+aKou+4VRxpT9LxKRyWxoesu/UjW0HsYe7fSd7SeKDj+qEZQKwJFtSJfvgXa2BDjaxcNpLFgWTqxPVjlcm/vJifFBjld6ByCX0LV+tt/8gY/xG6wIsn8Egt8r8GkMhVPUKbdKR4IXkMisXtOtsIIYns3LBXYBwBA2Rfu4Pvxd7eLP/5eK4o10DmMMm6lN8ENtey4iyDYMrPxkz07Edpt2FQFbvZYbbGT1NvsXdFZOemVxfA==;5:upCN/RLwqpl34IkQlU/YlemWSsOcIJYwm6FbMuvqmlLDNgt+PfbBAJTclB5JUZ0V5XFLIJlVEoeI1bYMuuwXFACiqDtZArYwp2RRkxl6CUVUzl8suUtbwfvhPUVlDTKy4gvTElsallFp7YXPsM+bkRRfBfv2B1EMepvxD+TkZfhFoWTQwygl7CsUHAJdQgtMj7E5HNpGiKqmIyPv9BOK3w==;7:tkXjn0WsYwly3Cqoc8yB1WWUm/Pbhll2eN5E1Cnhot2TkVGHupSXOeiVdE2qFHOiZp+jBN+JVA/xO8sCDlE3hho3VACfViptAnmtBihgUv55kiNXMxpho8A+fcic7O0mjCrmB+rFVKvAexnam48uZg==
x-ms-office365-filtering-correlation-id: df8494a1-b423-4289-6f1e-08d67f8ab2ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4111;
x-ms-traffictypediagnostic: VI1PR04MB4111:
x-microsoft-antispam-prvs: <VI1PR04MB41118ABE02D5C0CF9E728D92E99F0@VI1PR04MB4111.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(39860400002)(396003)(189003)(199004)(97736004)(106356001)(14454004)(25786009)(6436002)(2171002)(476003)(4326008)(486006)(53936002)(6486002)(44832011)(105586002)(2616005)(478600001)(66066001)(68736007)(36756003)(6512007)(6916009)(3846002)(6116002)(26005)(102836004)(81166006)(186003)(86362001)(8936002)(50226002)(8676002)(71200400001)(71190400001)(81156014)(6506007)(99286004)(316002)(52116002)(386003)(305945005)(4744005)(1076003)(256004)(7736002)(2906002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4111;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rbOe6MCEkKalLNY4xfie3EEQJDY4FKRcGdioQI+g2RBqIYBAFk9mvN5ZhT8N4oasD4S7C4BXV49h8GUDJIWesJsG/fpTe3LxmRpJInEfLH5LOoPP5DUYMmVHxt4UvruAmIUb3Ajw5uZMH9EvfQwSn8UVJCkA7MO0i8X66naPqGUmRN/9XRubWpeUZepgz2FWPzm6MP7pBVG7n86is4XbGR61cSd5fXQ8iF/+wzxjPnRvov45wNuS+fmozqYL/5ozJAoHuzl8ureEYllRNRvj6R0wanwbJyqLXRHVh7ctCwuvb3qghO/KdENPwegwMOswzE2iainUgR2G6L0xSb4o2CGCAMsLRuRBWC986AErRLKNcSsB/r7VgZq8x+0Z1EoQZQZTouePBjpFywELc4r/Xj/xtX+s69jy5Se4O4pfuew=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8494a1-b423-4289-6f1e-08d67f8ab2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 10:24:55.7125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikhil Badola <nikhil.badola@freescale.com>

Set USB_EN bit to select ULPI phy for USB controller version 2.5

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
Change in v2:
		replace Yinbo.Zhu with Yinbo Zhu=20

 drivers/usb/host/ehci-fsl.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 0a9fd20..71c4661 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -118,6 +118,12 @@ static int fsl_ehci_drv_probe(struct platform_device *=
pdev)
 		clrsetbits_be32(hcd->regs + FSL_SOC_USB_CTRL,
 				CONTROL_REGISTER_W1C_MASK, 0x4);
=20
+	/* Set USB_EN bit to select ULPI phy for USB controller version 2.5 */
+	if (pdata->controller_ver =3D=3D FSL_USB_VER_2_5 &&
+		pdata->phy_mode =3D=3D FSL_USB2_PHY_ULPI)
+		iowrite32be(USB_CTRL_USB_EN, hcd->regs + FSL_SOC_USB_CTRL);
+
+
 	/*
 	 * Enable UTMI phy and program PTS field in UTMI mode before asserting
 	 * controller reset for USB Controller version 2.5
--=20
1.7.1

