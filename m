Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0D3C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBB4218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pi611JES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfAYGDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:03:40 -0500
Received: from mail-eopbgr00076.outbound.protection.outlook.com ([40.107.0.76]:34823
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726762AbfAYGDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YWWhoInCsJh4SQFgZgXENVYHvb7fYb+VJa++Q5qwBY=;
 b=pi611JESlN2BZSscdJxtAlxtF5vSkmITOoXSTp3yiNB7Y6kd1S4z/EAUW0KW1PQNzDZ3sc6fzkKq77jZpRsNwMca+MrVLyxNABp8yVwcHbPgreaXh4glnxRX5PX2892Q4hd0dYy4BdDJMf3EA6VhxHaB5Ggw6yEhqzD/yajNlCw=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB5455.eurprd04.prod.outlook.com (20.178.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Fri, 25 Jan 2019 06:03:01 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Fri, 25 Jan 2019
 06:03:01 +0000
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
Subject: [PATCH v4 3/5] usb: linux/fsl_device: Add platform member
 has_fsl_erratum_a006918
Thread-Topic: [PATCH v4 3/5] usb: linux/fsl_device: Add platform member
 has_fsl_erratum_a006918
Thread-Index: AQHUtHOhli28NA5iwEy8ppr9lv9SVg==
Date:   Fri, 25 Jan 2019 06:03:01 +0000
Message-ID: <20190125060356.14294-3-yinbo.zhu@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5455;6:CfwWxea90jR42APyWQU5eNoPfrWf8RkH3AoytHn4SQjmc0cfVNS6LnTlbJNcBFuiccbVzRcGLu0WKrT1DXOP6M+PPYLpYX6MVUEZtFfxAZJ+qu65fGYnQDF+VZ0epmX8nNEvoZTB8jbVZD9LiuOJNBiL/jCb9v6XcxIaaaXUjnzjWiLIhVRsPT9RqEsQrSbxhLFGDa5Znn/EgF8OzPJ7mR1LN/IM0WvmUtKC5YxBt5jYhjXCmL5wGpydM22h7mKqmIy18oRuKPXlIfgQB3VRCkkUXhbZELX5ouB8p8x4k0Qix0ZcZHN2Diq+ZqsZ+U2pEPE9bIqiWna7Su4P6SREILMLAOdowExBj/2ovs2wpHmrFotX2v7b5BUpZ1SKHzc21hBR4y3rGzspW2ZFSSaoxHAyzEFWBLKM+223Eo5powIOXT8HhsgmyYkty+3I2plOemK0WNyb2Bmw6cMupnE4mA==;5:wp96dVOG3P9LKBEBOT8qPLqHh+WNJ722+S3yFI5JbWTz4sb34l6LgcsZR86/yFBh6biZJ7RvI7QoFRME9uRAAfql9AYnD7tbvmCFCXDx27RhxhVKH/mHO031bdcBe4yFb9mbX0xEtztHB+EZmJvvPzZlY0XIpHi9QyBh5if2CLs4zLNk+g/jpwHu+vq5BVIo7UOFOOTUMAiHmiJ7YDf7IA==;7:pB9eeAlhbF8tWEx7bH8m+JR7UMq9tWxdlpFq/oDXVnvYSmvIwhAADffYicOOY0cRQI4tOHN10PP+eqjmE+MyuSo2OIYmm+9mj+H+ttovqJJJ9eXd26c97FZnnx4fWXUH/iMJviY44A4GL6ich/bFxA==
x-ms-office365-filtering-correlation-id: 6bd075db-8ef4-4154-9e44-08d6828ac34e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5455;
x-ms-traffictypediagnostic: VI1PR04MB5455:
x-microsoft-antispam-prvs: <VI1PR04MB5455EF66E3AAC6AE00140436E99B0@VI1PR04MB5455.eurprd04.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(39860400002)(136003)(366004)(346002)(189003)(199004)(4744005)(6916009)(486006)(4326008)(105586002)(106356001)(52116002)(1076003)(14454004)(2616005)(6486002)(446003)(44832011)(76176011)(11346002)(6436002)(476003)(316002)(478600001)(25786009)(3846002)(6116002)(2171002)(50226002)(305945005)(7736002)(8936002)(26005)(186003)(256004)(14444005)(86362001)(54906003)(71190400001)(71200400001)(99286004)(102836004)(36756003)(2906002)(386003)(6512007)(97736004)(8676002)(81156014)(81166006)(66066001)(68736007)(6506007)(53936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5455;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ONHnf9RYSeFeMylT6Ez2aElp/8VvfnFpc/UOWJrDqPYBprDSNLLeDoqcFOjsvVqu1kztQeb63Vu7iz3/PwG4cFZlKsI1ftQ+b7b6kFUc+zHcuLSPBXLspAMDNsufhUOpHgkiS3GgctKcCv7nntBjl0ZrAX+g6TESsnnQ+DiwjdWkhhxYSsIpZiy2ayI6J31dHYvniVHIh49JgX/hg216AbsctRjWWFNG0za5HUqBI8omw2Ial4KKupBkgvIC0mIVTyv+zkRK0tsUJN1GMxlaSkyO9sDP6f/353k+MK0O3DnFhHz5iCvuJnWiDtLOBQuxQDtsxERCqHDj/xNOVsCk9UKuiI7O1y1qALcd7RFbhiojrA5uQmzlgqMYZvuylb08w7DLzLK7rKK3zaa0TosqA7f+Ex5gHGYa5pJdGu8t5cs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd075db-8ef4-4154-9e44-08d6828ac34e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 06:02:57.4560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yinbo Zhu <yinbo.zhu@nxp.com>

This patch is to add member has_fsl_erratum_a006918 in platform data

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 include/linux/fsl_devices.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 5da56a6..4c613da 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -102,6 +102,7 @@ struct fsl_usb2_platform_data {
 	unsigned	has_fsl_erratum_14:1;
 	unsigned	has_fsl_erratum_a005275:1;
 	unsigned	has_fsl_erratum_a005697:1;
+	unsigned        has_fsl_erratum_a006918:1;
 	unsigned	check_phy_clk_valid:1;
=20
 	/* register save area for suspend/resume */
--=20
1.7.1

