Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BEEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E902075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bokMv8Qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfAIOOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:14:41 -0500
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:4544
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731257AbfAIONw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtybiGACgmn7BGqGzPOjdCrkOF1+3TRVfcMBxUT55mg=;
 b=bokMv8QqXdTQ1S/c/0/mf3wGc94r7QsJrB2qVj/b1Fww55cle+KW30Uht4KBre0CqJZ02Rld1JQU4KZ3UNL6CB0fw+09/ZZPlCQSlw+Lz9dz4fqKymGPDwBr/c9LzLuwLKZVc1Q1zQ6pMrjDEia/x/knA2IOid9DRAXYp+aZH3g=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB5157.eurprd04.prod.outlook.com (20.177.34.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 14:13:42 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 14:13:42 +0000
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
Subject: [PATCH 03/10] drm/mxsfb: Add max-res property for MXSFB
Thread-Topic: [PATCH 03/10] drm/mxsfb: Add max-res property for MXSFB
Thread-Index: AQHUqCWGtYQ0qHm40Ee/QdOcyQcMqw==
Date:   Wed, 9 Jan 2019 14:13:42 +0000
Message-ID: <1547043209-8283-4-git-send-email-robert.chiras@nxp.com>
References: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0015.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::28) To AM6PR04MB4007.eurprd04.prod.outlook.com
 (2603:10a6:209:40::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5157;6:kK58Epz5ipc6/+Fq8ILwygfcJzVgILNJUsVgAu/rl5d514kDE4iVkTfQJ4VwixO5savEqsdIuv4Mzf7O26xIhRbz2Y6NVxSdOk3EPJdTwysIgc5nlbrjiiSMXzF7/fnwtHxizOGgwKvgyzG7VDt3fq+3jfQlWsf6YKSqxYDyBGcq35LBty7UL1lVNSdUWzPYqGnQwfzVQwIzVmFWPvI6Y9uG1fsLRpoZX0r8uegkvBy7xxUouamFeDnksP0PpF6rSbQOaHr/Om1hfq85G/b94BoCUL3vFxGTFsAiSvNIl10+Jl7cbCqeaWDps3CKaDA5VlULXqlyEwzd0Lm+FNaq2D6YU2S2bWTw6/ccd1BA/6UqbaAvK2fSABsTxibhQFkqVToLSGkJyFhw6X6e2NvQaSo54WQmhI6YlizRF8A7GWYCsT+cq9qYfzvagskhdGkdil7ExDnfPh3d0HXGifOXxA==;5:1by10Mb7LnbesYrEbDQCdiCvRQvm5Dw/kbLYEYo3h8tDk9j620kkeLHk1ZQS8vEDcF4DvNJerReXVXgIepOa/rw1vTp8a8XUcoZP+kfrlGWAb9QjCHQyYGPBb7H95+kBkD8SUt1uWBpXznqNWlc7TWT7+satOPQDTAWMpuaR2qARufeGmLI/prEMk7AYOCiWajftgO4t/OeMvEiV1LedUQ==;7:T41Yo4jAmu2hPYs7zfhl4nLolznBOxlpZdg4w/9jakedb+qfjCkL7rJ33EgSkgkQV59DlbBjv4ArNrUusZ7p9iF18QN/4jYtM3oFGO82Ml1VW/yioXQbh3pIzOPfUoxvf2B36NCVr/db3MMP+Tq99Q==
x-ms-office365-filtering-correlation-id: 85002a64-38d3-4996-542f-08d6763ca8e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5157;
x-ms-traffictypediagnostic: AM6PR04MB5157:
x-microsoft-antispam-prvs: <AM6PR04MB5157F9860A34C4A9463103C8E38B0@AM6PR04MB5157.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5157;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5157;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(50226002)(99286004)(11346002)(110136005)(2616005)(575784001)(256004)(316002)(86362001)(14444005)(54906003)(305945005)(7736002)(8676002)(71190400001)(6486002)(71200400001)(446003)(8936002)(105586002)(97736004)(81166006)(81156014)(36756003)(106356001)(476003)(25786009)(486006)(6436002)(186003)(3846002)(6116002)(478600001)(68736007)(53936002)(102836004)(6512007)(14454004)(5660300001)(44832011)(76176011)(52116002)(386003)(26005)(6506007)(2906002)(4326008)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5157;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TL8EcaMF6ExQ9EVW6CoPyiRjtAlPqLfO2hxhcLfrcvyjAENNDKTsL2mWJ5JYuV+a+AubPn8K3wC4GNHj5eGniGxif3QQLhOvoYVxqjWqQctbqfe4oatuORIqaSZkMZIAb44zM3/eSvGfJU6juPTYJBN+XgqTkq2539AdEuoss7aa+crzWUTD8U+KpUBCdBfHDQZNxrv+wAtfiV/lrYHvkwKoKbeT8hW7tjrYydGAUJc/gkhJTpRlfYt4D25qgdRu4f3H5VSl+UQYczc2ng2KGLSbNay0Hs27QRdDBtsbOKB/DudPrmQp/z6/d1LEKEP2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85002a64-38d3-4996-542f-08d6763ca8e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 14:13:41.6868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5157
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

