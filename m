Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FF1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B767320870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jHnVfdmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfAWHFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:05:54 -0500
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]:21568
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbfAWHFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qZ5cvtG9lgjrUAQwUv3DOZRcHVE41K7CIPrp+Klb1I=;
 b=jHnVfdmgWsjswyqpUz39qavXwCnZVehTFc+Gsybshw3CsXzEmTSV/mZfva2uIn4HuWhuFPrz5cU1U2leC+0HlG4lFHXOxzWT+pA5UpNGRcHZxuuSHagn/aw8S6Pq2Rp06W4qP2i6r3GH3n2OFHggKcE5nacyZdtLlJIDrglh2fA=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB5166.eurprd04.prod.outlook.com (20.177.50.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Wed, 23 Jan 2019 07:05:45 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 07:05:45 +0000
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
Subject: [PATCH v3 5/5] usb :fsl: Change string format for errata property
Thread-Topic: [PATCH v3 5/5] usb :fsl: Change string format for errata
 property
Thread-Index: AQHUsuoPGRGhZoV4Hk2GRooEkv36fw==
Date:   Wed, 23 Jan 2019 07:05:45 +0000
Message-ID: <20190123070615.14462-5-yinbo.zhu@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5166;6:pq9Tk6pgAGuPYy7S/o1d8wW7Hez9Pgzlis59b5E3DdgYxyDBujhqyL/Zlo8XVmRmwPLlexiWer3UScQ/QXC3c15UKfXZsfEhQlKwEax5RA/aMbgPEI1kw/QlAK8IxTQYJKmUDwEsMGlxObQYhfOnH36OfcAcoQ4MWYVZcSVCQvAgbv2Nr41bQS7KWfDzcA89CPDl6YaC73CK37AqDGwggwcvVPc1hK6x3+1rCnwd4AAe7MJslmgyBX9qc8q0GAgmUbWbojYJyz3xddcUZbymplD+iGJSjiCWR7poiLIGaCGnBh/ez+MkZkiwTewcw5qGZ7nLi97OlxIIELqj3WiWVoOmx1pLVHZ3LhGx3VXYRaZrpLRiVrMspnEGvECcy2KezyxLqssU2pYGFI37jabQ5wq192SP1t2LoVh+1B4Yh8/BTfu5XFWJNyOCgNXsy12vU7rn8HsGFAEy1dWNNgS9dg==;5:zlNNeW+Zl1SDj42TPWOBSJ/825EuSx3GgTCxnoDQ1gy0Rq534q/2Er50a6gG0qNQJaIXmFa+n2+s8uKc/6ChfkbankVL+oQ3OienuOFvYhNhOmx/PfQahkG5u4EP+EnNce1ByRhIbO0bXzlO1wDk5nw2r9g/iJJ1CBYQZgVtNTXrufcpIJvhWAGWRpi5JYOhLTi5e2ukLa9OR/5Stv1tWg==;7:NbBnn1EMetzltQe36+SP/zUcFcxWPN78Sc7VFZh3jKMUM7bADHJpUkD0Ap/LiwT6kMfj0b9WPqkuVAS5K06Bk1QpJmGV/tf/P4L5LnuZLCsvpV3G4fESCca1mvDooziyZPxGd6GJtaQhLvAG2LY8RQ==
x-ms-office365-filtering-correlation-id: ed5f2781-a230-499a-2017-08d68101320a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5166;
x-ms-traffictypediagnostic: VI1PR04MB5166:
x-microsoft-antispam-prvs: <VI1PR04MB516639511B326A8303BF6D89E9990@VI1PR04MB5166.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(305945005)(6512007)(14454004)(256004)(6116002)(186003)(6436002)(1076003)(71190400001)(81156014)(8676002)(71200400001)(105586002)(6486002)(106356001)(478600001)(81166006)(7736002)(8936002)(52116002)(6506007)(53936002)(2906002)(386003)(3846002)(99286004)(25786009)(486006)(54906003)(86362001)(26005)(476003)(6916009)(102836004)(76176011)(446003)(68736007)(4326008)(2616005)(316002)(50226002)(97736004)(66066001)(11346002)(44832011)(2171002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5166;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mYJcv+G/hezxt5XyzorjmK8T3wMoNfdGcGzNCwEdOrWULvzyQdvpniIC/UBU4r4YwTm851n64WCY1/rNetEYxvPY3vagD6jzzaoXSoG5Jhgx65ou2oMjlgGFCW/j7n50GOxznwZXhWOFPklF0Hhih6IF24ZQ/Ljp5+bQZ/lTNsGIo4ZK+sC8cVL1DB6iWraYnqsu08+aKoXyBsklyaGfegL6I60UsGmQNxdij44Hsn+UrU5jBbdaS4IVHcTcFCDnlMKbuEwr80Yp7l6ZpiwLhAgWI5LDNh6Hh5ftv1hUAgEsiCChO+tMnddoeX8XpNuWa1nwljLUannJqQSvfk2BDiJvcKIg7T7Im6ZSSvz6JonFXk7i04OGNnLRQ9c1ZxH7pYFRUuhuza3mZOD3Mf28T62xUEk7g/xh4sJdxQUCSJc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5f2781-a230-499a-2017-08d68101320a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 07:05:41.4915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5166
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
 drivers/usb/host/fsl-mph-dr-of.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr=
-of.c
index bdc8812..ae8f60f 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -224,16 +224,10 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_d=
evice *ofdev)
 		of_property_read_bool(np, "fsl,usb-erratum-a005275");
 	pdata->has_fsl_erratum_a005697 =3D
 		of_property_read_bool(np, "fsl,usb_erratum-a005697");
-
-	if (of_get_property(np, "fsl,usb_erratum_14", NULL))
-		pdata->has_fsl_erratum_14 =3D 1;
-	else
-		pdata->has_fsl_erratum_14 =3D 0;
-
-	if (of_get_property(np, "fsl,erratum_a006918", NULL))
-		pdata->has_fsl_erratum_a006918 =3D 1;
-	else
-		pdata->has_fsl_erratum_a006918 =3D 0;
+	pdata->has_fsl_erratum_a006918 =3D
+		of_property_read_bool(np, "fsl,usb_erratum-a006918");
+	pdata->has_fsl_erratum_14 =3D
+		of_property_read_bool(np, "fsl,usb_erratum-14");
=20
 	/*
 	 * Determine whether phy_clk_valid needs to be checked
--=20
1.7.1

