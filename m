Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEF9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2A020657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I17EIurI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392562AbfAPLsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:48:54 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:57311
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392541AbfAPLsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtybiGACgmn7BGqGzPOjdCrkOF1+3TRVfcMBxUT55mg=;
 b=I17EIurI1R0orY9Wk/+J0SxssFdTU8cYfaA3Q6/XUVfk5GTuQBmprjyEK7UXcS2QT4d2tyZvDQtNEtxa0GrpFtMz3F5E96E13XBHYR6EvV4PhfH/iwjKJ0rrpAYi3HM+ZOQ2FCTw7EI8TDYmaLVYvTLo/M1ZTTlPVtH/gLhfKiY=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB6101.eurprd04.prod.outlook.com (20.179.5.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 11:48:41 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 11:48:41 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
CC:     Robert Chiras <robert.chiras@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Anson Huang <anson.huang@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/11] drm/mxsfb: Add max-res property for MXSFB
Thread-Topic: [PATCH 03/11] drm/mxsfb: Add max-res property for MXSFB
Thread-Index: AQHUrZFtCGq+Do85ZE6KGSMh1XYBZg==
Date:   Wed, 16 Jan 2019 11:48:41 +0000
Message-ID: <1547639306-19151-4-git-send-email-robert.chiras@nxp.com>
References: <1547639306-19151-1-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1547639306-19151-1-git-send-email-robert.chiras@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:203:91::28) To AM6PR04MB4007.eurprd04.prod.outlook.com
 (2603:10a6:209:40::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB6101;6:1zH71gbM6klkT07UGkSNDT0dZq4PtucMNSmQyeogRRhkhOLgkTb38SPZSn8+y+uKG96Day0loLkb/OEFpKvWkeX0vS9cNCv/0RJECzzpJ6ldQNX8oiCqmadC6yM7yvQe/isKA8idlJ3ksTKdTCXXpfy2D03ejri6RTcLbZ0TFRoTmUhMfD4HHUsE7IKtQhZvAP0YtVaEjyoqfb2/a9MwieHWggL1/+59mkWZHFIMEHohTWDaji2pv86J1BNgyfA5EMSpjhP5yoLoKhAXCd/aRi6g+eA899V1RrOrfoOBZPKs6N2WzItvPbTvOTwnwGWZ/psJMD5Jah39Fu+TXCZBPxcxjZDh01HkeH2tg20FZUgQMQgzd2E8tPEpLLGsAuNEMNj5AjU7JEzU4QsZ5Ny9xQFNtov8Nl1IiERfANRxO3aInVtrmqTMAoR7A1ulCTW63BdCqS/WlnRCSDSZwcco/g==;5:y8vT4Hto6AD034JRf4P2wZZ9SETt8dDptZNBQ4N5kmqqT23Grq1MpOX/nTfeAolMxBgvDiJ7B382M+3SGXy3xHI6oYze0a4co8U4mEl5YQeXLNd/QUdtgPR0HJU1cocptb5aVNPFP2xqAtNMpUPYG0s+RdpkhHvnZ3kw9ZEslzA5wM1orAeW9V7p4KA184NKs7sGI+3y1ZiN12+GfzvDHA==;7:9Na+PzFZfOW4y0zXPhaiy1mWMb5Ti2wYfcGSaAJP/lZkHsV7bzOkEFLZy4Qi/RrvhaPF+T9SJqQ7tqLhRaAtPhxtX4iEYYZHM3vIFelwk0bHuETRJvLLFiKFjwZZCHnULj1MpZi90Nf6Ifhnsluczw==
x-ms-office365-filtering-correlation-id: f5b7c150-aff1-41e9-05fa-08d67ba88f55
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6101;
x-ms-traffictypediagnostic: AM6PR04MB6101:
x-microsoft-antispam-prvs: <AM6PR04MB6101E32FD09845C4BD706E39E3820@AM6PR04MB6101.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(316002)(81156014)(110136005)(102836004)(81166006)(476003)(26005)(2616005)(186003)(8676002)(7736002)(66066001)(3846002)(50226002)(105586002)(305945005)(6486002)(8936002)(99286004)(54906003)(6436002)(106356001)(6116002)(86362001)(2906002)(44832011)(14454004)(478600001)(486006)(71200400001)(68736007)(97736004)(5660300001)(53936002)(76176011)(36756003)(256004)(446003)(14444005)(11346002)(25786009)(386003)(6506007)(6512007)(52116002)(4326008)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6101;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2FLkoL2Hr7qtIISVrOTWxlNB3trk7S1fO1aHOMEkq/NEo61M5fBClH7DgXwdS6RAnLQBolL882q7jDuAhVaWqZNFDoqHyOFgIkUrgGSAnaHrL24bw8aORfgB1DCsIsmpIF0dHSx9FurK6ULIckD1FnyI2my+flTcL/22gOV90TseZxfsm82B0JSbiFsIk9Rm3nZjtGx/AIIBkd5XJP4aHTPwwvyP2Go5mB41jTi9WRkyCtWbAVpTnAw4X+kQLc442v/YXIdJ5c7cb0HH/M1OC5zTgabkh4FX61wZ2/FGbqyJA0CWwaopBXRhX9kj3xnOo7LFBeKFlotYkyUXOpBzs/RoXLt8N4vzSE9v8oJZ6qGQafG0zyj6QgibnBLOl/oSZ70zGpL/diitf1fA2tdGhADE4uaSh4ZlPyr2hw2FFWA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b7c150-aff1-41e9-05fa-08d67ba88f55
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 11:48:40.2945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of stability issues, we may want to limit the maximum resolution
supported by the MXSFB (eLCDIF) driver.
This patch add support for a new property which we can use to impose such
limitation.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsf=
b_drv.c
index 9a73564..c0b6198 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -201,6 +201,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned =
long flags)
 	struct platform_device *pdev =3D to_platform_device(drm->dev);
 	struct mxsfb_drm_private *mxsfb;
 	struct resource *res;
+	u32 max_res[2] =3D {0, 0};
 	int ret;
=20
 	mxsfb =3D devm_kzalloc(&pdev->dev, sizeof(*mxsfb), GFP_KERNEL);
@@ -279,10 +280,17 @@ static int mxsfb_load(struct drm_device *drm, unsigne=
d long flags)
 		}
 	}
=20
+	of_property_read_u32_array(drm->dev->of_node, "max-res",
+				   &max_res[0], 2);
+	if (!max_res[0])
+		max_res[0] =3D MXSFB_MAX_XRES;
+	if (!max_res[1])
+		max_res[1] =3D MXSFB_MAX_YRES;
+
 	drm->mode_config.min_width	=3D MXSFB_MIN_XRES;
 	drm->mode_config.min_height	=3D MXSFB_MIN_YRES;
-	drm->mode_config.max_width	=3D MXSFB_MAX_XRES;
-	drm->mode_config.max_height	=3D MXSFB_MAX_YRES;
+	drm->mode_config.max_width	=3D max_res[0];
+	drm->mode_config.max_height	=3D max_res[1];
 	drm->mode_config.funcs		=3D &mxsfb_mode_config_funcs;
 	drm->mode_config.helper_private	=3D &mxsfb_mode_config_helpers;
=20
--=20
2.7.4

