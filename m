Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E8EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8794920870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ufn34flj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfAWHFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:05:50 -0500
Received: from mail-eopbgr10078.outbound.protection.outlook.com ([40.107.1.78]:45155
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726910AbfAWHFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YWWhoInCsJh4SQFgZgXENVYHvb7fYb+VJa++Q5qwBY=;
 b=Ufn34fljmWhO9hztpJyKYAN4y3JlrGKiMJplDP+i7sgC2hd7ibsKtQ3SQO3LSDUUQpqZTKH5N9Xo3oZOzR9XNGhfTQjdv2HpVdM/DldzYwfccRxrNi46l1KMuKd5W/Ckc9owJIvGNHvNsW71JG53HrjwYyU+MaRAZZ0yVQpqZRc=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB5166.eurprd04.prod.outlook.com (20.177.50.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Wed, 23 Jan 2019 07:05:41 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 07:05:41 +0000
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
Subject: [PATCH v3 4/5] usb: linux/fsl_device: Add platform member
 has_fsl_erratum_a006918
Thread-Topic: [PATCH v3 4/5] usb: linux/fsl_device: Add platform member
 has_fsl_erratum_a006918
Thread-Index: AQHUsuoNYE7dS+cmskyNP5ovt1/ZKA==
Date:   Wed, 23 Jan 2019 07:05:41 +0000
Message-ID: <20190123070615.14462-4-yinbo.zhu@nxp.com>
References: <20190123070615.14462-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190123070615.14462-1-yinbo.zhu@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5166;6:cbZZRCAm4XmmU3yXLLNBUgIbBUe0+fkPhWuIMk4AAQTTFXtAm2TuII3nIBr61BqoJUdQNzLcy5qNyEi0OBcLlBp+eOmy49FMy2bIA49gM+n/iNlu0HCcGJkZANcHEuGYgTFcY5gbSyzwKIYqXBH3Qsspfilk4unrJXgieQi4IdIPTUm+MAMI+5BwZJWzlk6fxOUyDsdMSthr9e1Qzgtv5P7z/zILhkVApQTIrpJIpN5DZb9pgjA9KGjtYp5QYLuZzCGoIPQg8hJV+cWoOpmghkCW+0E2UQ6lkHbZZAYk3u3CEOXnFC506xcSed6pZie3wcD3Cw18d8ntbGRlk8/ag9QN1LPWlODGKI64kk3S4hvYV1N9uMQo3OmrIzzPkxPi78E0BvkWg02U06AAP9jlhBWbkJImxI3Iaei0qMgvV6sequflMYWjbNzuPf2G2nG+2mm7JfhS0q7cW2Ui6ybQVw==;5:liyLbEjjmTuRpmsfPplboRff6k3fI4gqDTu+zfafSqrVb7m5oo3eDbg+6qsv5VXbPf4JaFLmKS05j/YS+6+NHBaxD6Rf6VoqvytfdVdAaKdDysNfUtZvSrpujIuP8nlsqHbHmNBp/vxgbHFYB4D58SNGDfDzYtKGwp+lkKZUH8YX6sCC5RARv8VEZEECch8m4cxTTcTYMpcW+T9t5pQbOA==;7:DlVWKA7w8HRFLHhwcQFGwgJrglbDCjUgGvNe/TqjOeCp4ij1fSJp0nlJaO3rT5WzTr9obHExcLs0SU3FIGw4O3Ftqf/1ZmSMKzgf3KMIv3AyBXZ+KbieiZ4qQbK+Z3R93Kq0HFqxkfoufbAXAXCWjQ==
x-ms-office365-filtering-correlation-id: 83cb1bf7-3799-481c-190a-08d681012f3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5166;
x-ms-traffictypediagnostic: VI1PR04MB5166:
x-microsoft-antispam-prvs: <VI1PR04MB5166E75C9F585B90A667F4A0E9990@VI1PR04MB5166.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(305945005)(6512007)(14454004)(14444005)(256004)(6116002)(186003)(6436002)(1076003)(71190400001)(81156014)(8676002)(71200400001)(105586002)(6486002)(106356001)(478600001)(4744005)(81166006)(7736002)(8936002)(52116002)(6506007)(53936002)(2906002)(386003)(3846002)(99286004)(25786009)(486006)(54906003)(86362001)(26005)(476003)(6916009)(102836004)(76176011)(446003)(68736007)(4326008)(2616005)(316002)(50226002)(97736004)(66066001)(11346002)(44832011)(2171002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5166;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IdwgJ/bETF/iEfUN7cFOc6vazioHz5UcubJtU+eiaocJijKupuz8ZNyNLK92N5+DfpZblyleJURNJ++M/NZIGUeg6TGqZgavE/JUiRuRSV8c/hAEMo0EYhGz70VxQwlieH6MMAYPZoZIY/NjJCKuRjMdeNltDoYzDSPYMP7kWM6JJeP2R6zGnQIT6hWdVfsuem6RnVe++FV53vQqzHZRftWIft2/PuG+G6eRifPu7smvWDheQplTXg9KKY7LxtsyAMgaGfnUsldd0puM2C4LgCut2jNDCtC2Bz7kRuuVVyt5zemAvrx6IZIiYP/P8sjr34uKOBZKqS+fCxYHuHpz3Rkv1IcLLXzpopprQPy7mUr4FtTFIab0GM793QNQWzfvFe//BNX+sJPkh+LNj69LPCD1lZ3zvydVXOSIele7N/w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cb1bf7-3799-481c-190a-08d681012f3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 07:05:36.8509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5166
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

