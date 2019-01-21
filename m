Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED92C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08E820879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M5JDfr0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfAUKZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:25:22 -0500
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:45568
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbfAUKZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwZbwsEDU3J/GAQ7lcOOK8y5Ns8DrXZecVIVKr+xb8A=;
 b=M5JDfr0GQR4Ebt8uXNLWOksTqpDPUHjUEaWLvnd4hGBQIX2o3APqtKB95hnJi6AY8/ODI20em6Vcdrd21+sFMw7qQTZHO1IuAGgyRdKLoxO0oDLeBg2ZIUp+iinAhmZ9MdcewIbvkvIvRiwzk/1E9XHF0mDTYdD7KW7w1qAfPk0=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB6048.eurprd04.prod.outlook.com (20.179.24.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Mon, 21 Jan 2019 10:25:16 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 10:25:16 +0000
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
Subject: [PATCH v2 4/6] usb: linux/fsl_device: Add platform member
 has_fsl_erratum_a006918
Thread-Topic: [PATCH v2 4/6] usb: linux/fsl_device: Add platform member
 has_fsl_erratum_a006918
Thread-Index: AQHUsXOZxMMeIXYUFUa7J7VHKAaqcw==
Date:   Mon, 21 Jan 2019 10:25:15 +0000
Message-ID: <20190121102601.4735-4-yinbo.zhu@nxp.com>
References: <20190121102601.4735-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190121102601.4735-1-yinbo.zhu@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6048;6:f/SYdXY7GCFKbgoTn8HRit2ks9tLKYDL2zgXP+DPO7K6rC/ID20y2n8eHrdN1ny3uQ3NuLlDpndO8HhoTUH6pMH7WlFHlXrlSVbzkpd5RgHPRbVGDbervJeOcJophPh5jNhO3Z/Sntz0mc8qQa2adYfsuA6QRfiPn9kXFxoEbrzzXfMudsacDUc4Bc5jSTJr1/ZYHpr4gutouBnHwb8bZjIkVWYKPiREHvCboLYvXLxGerWi9IpbXhnZJrvGtnPq6zKswErdaNEwrZZKwQyVsetAURjhIKCA86KtZUWGy3NcIZjkLjwo1JX4/W9vcbHN4jlfVoRSI6aGaWKo/IO2gc4nXq85rgK7kZXewWdazy1LyKHGcGJGcgblMZAUlKNOTm2dnXEihSySlb56zrEVxPi0I9uq5CAF5u/Kij5KeHea2P7/R1O9p0Q28i+aRetvcc64a/V+HDVLgNNQEIyhiw==;5:Fpj81qbN2XGj6bzVZd+OcG20Uwcex9TlkaOQgkOPVQzJ2d9YRmudbGr1PJBUbn3spbGUF/RX+ed5hGmRWyMB9V3k2hiReq3Aun5J9pXXy49jr4LlzEkeFF4kDdA1j3IhdVfECczAkWgQG2SGiB3PK+OOL+YzsTAEKt2j2MQ2NkRMJOif0gHTvcI0g1G1uzcXxomjHW+qE2KSy18xtB1GiA==;7:s8l/9Z6nA2TBhYgcZSDm04aVt0+jYkCvVW1FZwtZQX4OWNxjMAuIx4GtxZ/KA3weaGO3e/Am1bHNCTdVKXW2t45s9ecdR4Ubz9lquqBXiX3qaiXsEB6xsz37nZ8bNlWm6iuxPBijyqcoyM6Vsacjcw==
x-ms-office365-filtering-correlation-id: 11834e83-b5e3-4b58-929f-08d67f8abbed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6048;
x-ms-traffictypediagnostic: VI1PR04MB6048:
x-microsoft-antispam-prvs: <VI1PR04MB604898C1050E1FC89FB700C6E99F0@VI1PR04MB6048.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(39860400002)(376002)(189003)(199004)(3846002)(1076003)(86362001)(386003)(6506007)(102836004)(71190400001)(316002)(6486002)(26005)(71200400001)(2906002)(6436002)(52116002)(6916009)(99286004)(186003)(76176011)(54906003)(81166006)(81156014)(68736007)(6116002)(8676002)(4744005)(2171002)(66066001)(53936002)(97736004)(478600001)(305945005)(14444005)(36756003)(4326008)(7736002)(256004)(476003)(44832011)(50226002)(105586002)(106356001)(11346002)(486006)(25786009)(2616005)(446003)(8936002)(6512007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6048;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2kRogi7vb8fmPS7vb2KByCT7FIp8AJKNYq6GFWeNVod8PNpo5DO0API2cdGEQRgAg5C5sQBjP+C3fe5Y0Lp73wAEvFyypVsC28DjGnXJAyiy1DJpXbBYv6cRRoHeIDqQpwkX6s28/q1M5QtYqoB8h6+13nDRdyOP0j0QL5qXkD7a0hcnDVjLqmMbOTc7KJ2eKBzRlFvYyvBcu+kPsLCttDViHqMC/PDKik4/NwDaBGeZ74rp5TS5Iiql2Yic5NXy4g9tyGePOB/Ou4RpAb0Kct8WcUr5gkqDqhuZe9Mty/YnmrDS+7FEXFWIlgPJxBSz2ptYFmm4tfc22cWomFBg3EAVJqMhELq8xbNxBtIGv4/mf88zIfwxJkxNvzN+Og/EUcIzhDVYHaFL0aUThH+D9wT1CELG1EMVQR0AEsfWaks=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11834e83-b5e3-4b58-929f-08d67f8abbed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 10:25:11.2595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6048
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
index 60cef82..7ea53c8 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -101,6 +101,7 @@ struct fsl_usb2_platform_data {
 	unsigned        has_fsl_erratum_a007792:1;
 	unsigned        has_fsl_erratum_a005275:1;
 	unsigned	has_fsl_erratum_a005697:1;
+	unsigned	has_fsl_erratum_a006918:1;
 	unsigned        check_phy_clk_valid:1;
=20
 	/* register save area for suspend/resume */
--=20
1.7.1

