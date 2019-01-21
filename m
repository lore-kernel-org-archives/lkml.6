Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E144C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38CF20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aOYTqGAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfAUKZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:25:27 -0500
Received: from mail-eopbgr10041.outbound.protection.outlook.com ([40.107.1.41]:55872
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726857AbfAUKZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSgYunpgKZchCJdSL5LuweHzn3IEUVZcWtvHO5dhjm8=;
 b=aOYTqGAmjKQxd2tzRFMcvl8o0RHGym6KrXD3JrlyGdbyqCjKsrRJkaUD5iJGjhtofNZwAEEtzjMxwB8IhnfiGqrn+iY/2/2Ww3Wfpci3Nl8sFBsyMKvusP6jUGhaxW4w47N4f2Y2mwqXi0t5UPHREGp6ctJbw5W0xrwZEbvswWw=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB6048.eurprd04.prod.outlook.com (20.179.24.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Mon, 21 Jan 2019 10:25:21 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 10:25:21 +0000
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
Subject: [PATCH v2 5/6] usb: linux/fsl_device: Add platform member
 has_fsl_erratum_14
Thread-Topic: [PATCH v2 5/6] usb: linux/fsl_device: Add platform member
 has_fsl_erratum_14
Thread-Index: AQHUsXOcZao9MRKiB0609jwBmJw81g==
Date:   Mon, 21 Jan 2019 10:25:20 +0000
Message-ID: <20190121102601.4735-5-yinbo.zhu@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6048;6:rVUuaM6+CXavrzVwtxar3maSbTmcxeND35rzZMs+jZOZ7/Oxe2jR8s6yAgH7Fu1U7gOlTy/ICVic6KDEWBMMM1hWFPlxt8YSvcMQ/1/iW3qzk5VLdmqXircXoRH2YfDeQv4JW8JcC2FXLjhqK3HvlRiY/A0shtRzs2Fr0nENSE1K0ji74hRxUE6TcaaWz4nDktsioIHHP7Fe2o9EXhUAofMauxfu9y9/g7gGjKk0huo0ov6SYHKHS3fs3VgSJNEDATHZDVpDZaMF6vJ7UXZxhhXS7TvmsPPWRHz/GHgQjKdxddd8mad2VsdNWubKHm0VInUh4sKf6J/0ayjaFf0CgNBGpZie3c1zTkxxdKu08kiRIOinWVLVSFDIujOvzZG7GrmyINhTesmeuPcWy73qDFE0lpLShVNY0SadYTRTRKbWJMVbrT3qzf87HgIkd2mD5GXPej+t+/w2OXY1mRUAAg==;5:+F9NjS4NtMFat4PPMalDYkpY9c4lyJtlfdPt8RtHOGEjiCluOWcG0yl+Irx715pvXFFPOU71/LioZ4vJSCjXfrgfT8PsnMXJ1cchhXnDeXgTPqRw22hqtJ4Aazg3lEC4diRwy2n1rd+7mg1edTOvJ7Qn6Tv5nNwjyuBIxQJYFKdxcUqVJmbBaXeqZkxOev1ktno2hYpbAs4nf4y6rI8tmA==;7:qZCkr92UXpGAgtUgCO1hdZGkmOily37Wts0z+IVjPO1rZWLoKg7lWaJIja3OltXQtO5KG/FQNi1FGh1MI9IyzSOe4hWcs2ZaXSorWxVoADBdj6Ri37o5oHRRG9Rw+y1vFX7NswtLXwDUCav87grlwg==
x-ms-office365-filtering-correlation-id: 1ff00c86-5635-47b7-e6b4-08d67f8abeea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6048;
x-ms-traffictypediagnostic: VI1PR04MB6048:
x-microsoft-antispam-prvs: <VI1PR04MB60489E2C2501AD0A536F15FDE99F0@VI1PR04MB6048.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(39860400002)(376002)(189003)(199004)(3846002)(1076003)(86362001)(386003)(6506007)(102836004)(71190400001)(316002)(6486002)(26005)(71200400001)(2906002)(6436002)(52116002)(6916009)(99286004)(186003)(76176011)(54906003)(81166006)(81156014)(68736007)(6116002)(8676002)(4744005)(2171002)(66066001)(53936002)(97736004)(478600001)(305945005)(14444005)(36756003)(4326008)(7736002)(256004)(476003)(44832011)(50226002)(105586002)(106356001)(11346002)(486006)(25786009)(2616005)(446003)(8936002)(6512007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6048;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ujch1lu8yd8lIX3DZvrfqV6buZovIj65G7CWf0phWxtz8jVvHyawmokFeSJHoy8tnYoNGk0AEKVf227ISdts3lIA6iSPhsXiivPQaXgK8XjM+QiuD39hCP+liLss7EGCzXA6Q5HQfhW18XfnPqVQJG3ThF7vgMl0ERX3WD+dvcPnCanrpwb1E7GanONG4KcAfWVb1fxdyytzmVkIFnjkwG8S4/e4MwMoDY49jA2jmg1S335SbipoKDqGNNlV4x9C3gzl3Dp7yw0Q1m9FjWov0UdgS5Ug00PkVK4OHwsn8r6uJtnRHqQFBK4MuhFaNASQ9wCzo1YYwO37E8YAYv/BDQAA3CGfFaY7dF9s5/L4SgO7DKWOmW+a97sWsV3bYQjQ2vWXrZmNml2VK4ndJG10dbAXAXpuLSz9YscKpuCnEJ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff00c86-5635-47b7-e6b4-08d67f8abeea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 10:25:16.2752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yinbo Zhu <yinbo.zhu@nxp.com>

This patch is to add member has_fsl_erratum_14 in platform data

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 include/linux/fsl_devices.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 7ea53c8..5c21a3a 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -102,6 +102,7 @@ struct fsl_usb2_platform_data {
 	unsigned        has_fsl_erratum_a005275:1;
 	unsigned	has_fsl_erratum_a005697:1;
 	unsigned	has_fsl_erratum_a006918:1;
+	unsigned	has_fsl_erratum_14:1;
 	unsigned        check_phy_clk_valid:1;
=20
 	/* register save area for suspend/resume */
--=20
1.7.1

