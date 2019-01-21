Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF668C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E412087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O6zTqWg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfAUKZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:25:32 -0500
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:61312
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726773AbfAUKZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8j4CiHHK0IWaN6WFSaCa/1k983I9QtcbMIFQEgWW00=;
 b=O6zTqWg+vy200E0Z+5tCGevX/11E6o+dYuMpCxEOnM8idISTh2M49uGW04ecXpan72gRHg+5CdHI+6CyhXClvdlx2yIE9Mx+QkbIgyCVN27nZB9gnsBx4R9b/9RYqvjWi/3Cy72ZS785kRlfet+e+gy7Cto0U35ex6jXsRQXO7A=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB6048.eurprd04.prod.outlook.com (20.179.24.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Mon, 21 Jan 2019 10:25:25 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 10:25:25 +0000
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
Subject: [PATCH v2 6/6] usb :fsl: Change string format for errata property
Thread-Topic: [PATCH v2 6/6] usb :fsl: Change string format for errata
 property
Thread-Index: AQHUsXOfbjL2T1lCNUuHKjRpLt03xA==
Date:   Mon, 21 Jan 2019 10:25:25 +0000
Message-ID: <20190121102601.4735-6-yinbo.zhu@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6048;6:cGBRdc1g4BiSoz26ruDW7E9tOpoHlvx3IhjKfJNqU3ftHYTGlZwsqnIV8ckMW7DKLWgJHFQzlFzV65vF1ry2YptgNnN89yQQMMQEwz6ypw7dNB1S+juG7LD8ogcFgaTGjkQs642mOp87PeKLaLMTo8TujOEG181aXQs23Dyfc0Fptos+TyDl8qg8LuIfxyfqhlYQfiPXRt3MJHTzynYzT6XsIEsLr+smK6QBkfRBI3BQLlnDvPd23NiqAxkcjDwu7cvBFw7OPdoUblqk7eRUt5Wac574CIfNwXloZTZ1LiQqYbLSqXDal1loIoV3RrLUsiuB5ia53Tkh6/dOuXJZVcoSBp6CBFja6IFdXhvdcY73C4iMtjQ5qGIDAgBX0BPPzFnp0X6HJhWdm6lgQY1kentjpOCciuEebT4bTn9rGwQR/GhJ2p1HVu57lkQJw3YQ/QOpi/+nXPdIYxpk8UYybQ==;5:BErJ0cvSClpi/G0KWxmOeqbytPTXfj/YnsxIVHPRUtCt8B1UjGYR5ydnpkqF0Eq29PEemP/+CmWhq12rhhT+LiBi4WLt2bh91mlr6UmKXB+N0/N6xkn4gI1RTGBy9xkwAMHpN1RrSecKHWBH9JrGaApGb16XG3stzRDpGEtbpwVBA48MlnVjXWsNaudUcTXM0g6NzHYXvRiSgq6L8U6I1w==;7:njqomSqycavtd3NwbSbkfRQUf/56EH7V2XS5cRP2OHyt1Tl5Nd9UtrdNbjMp7MFMfQshNegGBFK/On0PyZbrLwtv6noSD1w+cjkMNH8Ia1vjCCmliMqYW4FNTf690fy4fcyGO5yv3druwV7lIxN/Qg==
x-ms-office365-filtering-correlation-id: be36c8cb-ea06-43e5-080e-08d67f8ac1ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6048;
x-ms-traffictypediagnostic: VI1PR04MB6048:
x-microsoft-antispam-prvs: <VI1PR04MB604845BA7282C47F06FC77E0E99F0@VI1PR04MB6048.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(39860400002)(376002)(189003)(199004)(3846002)(1076003)(86362001)(386003)(6506007)(102836004)(71190400001)(316002)(6486002)(26005)(71200400001)(2906002)(6436002)(52116002)(6916009)(99286004)(186003)(76176011)(54906003)(81166006)(81156014)(68736007)(6116002)(8676002)(2171002)(66066001)(53936002)(97736004)(478600001)(305945005)(36756003)(4326008)(7736002)(256004)(476003)(44832011)(50226002)(105586002)(106356001)(11346002)(486006)(25786009)(2616005)(446003)(8936002)(6512007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6048;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jAkm9getwiL1UF4zCIClwFQhm17G5bO0B4qRd8ucRvsS0NMwWpZoR2bPZCNK9dkQMhMmUDC0OtouUGIhh8zeFNA+n86Oo2/rLqYuryGZ60ZB8DnzKaz9Q2KX4iNePpkvl8DkQczrxbRXjDM1JNXtlxHsxYvfQZ3PwD9bt6HqWm5OUa0cHCi2UIfaG+PEl+imUcaq99tmiJOGjwwTbFaCRmZ5/MY6jP7KS8S/aRDQG8ws5WguwMmMnOgdlhB+hVzYbkqCKJZXs6SDhMM6SE7B99crJZGlhYLmc7vMf5iDpri4L7dH732o2m3EsUVhnIqsfQTcBGkMzPHZ6Z43ZlBaos0bXzI4YpgA5MCAYhbGnbVtXI4CtRTnJNdfzfPSi7V8Fbt5tFoEswwJfd4QNpxzhXDjIkkIMaWl1LmeGnX5gNM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be36c8cb-ea06-43e5-080e-08d67f8ac1ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 10:25:21.3377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6048
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
 drivers/usb/host/ehci-fsl.c      |    7 +------
 drivers/usb/host/fsl-mph-dr-of.c |    9 ++++-----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 6884130..c71680e 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -310,14 +310,9 @@ static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 			return -EINVAL;
=20
 	if (pdata->operating_mode =3D=3D FSL_USB2_MPH_HOST) {
-		unsigned int chip, rev, svr;
-
-		svr =3D mfspr(SPRN_SVR);
-		chip =3D svr >> 16;
-		rev =3D (svr >> 4) & 0xf;
=20
 		/* Deal with USB Erratum #14 on MPC834x Rev 1.0 & 1.1 chips */
-		if ((rev =3D=3D 1) && (chip >=3D 0x8050) && (chip <=3D 0x8055))
+		if (pdata->has_fsl_erratum_14 =3D=3D 1)
 			ehci->has_fsl_port_bug =3D 1;
=20
 		if (pdata->port_enables & FSL_USB2_PORT0_ENABLED)
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr=
-of.c
index 7e07701..ae8f60f 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -224,11 +224,10 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_d=
evice *ofdev)
 		of_property_read_bool(np, "fsl,usb-erratum-a005275");
 	pdata->has_fsl_erratum_a005697 =3D
 		of_property_read_bool(np, "fsl,usb_erratum-a005697");
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

