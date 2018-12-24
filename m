Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A79C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9162173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lR5cuq8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbeLXJ0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:26:37 -0500
Received: from mail-eopbgr150052.outbound.protection.outlook.com ([40.107.15.52]:25380
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbeLXJ0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3brXUZjW0ecMdPsbmdMF6h3G6Q090dX2ypslU0FAsOI=;
 b=lR5cuq8CPK95JzqGCoijEapediWci2e2+SpYMGmi/P78jOSAobkYcArL3HCOTp6bkBmlc1QW5iEqjG9kxIOT/XQn1FizKOKPRbv4X6WIv4ALfjNsHdB0kpJUfzZyVXw51oqYMXHn8LF/jRbjYDLy5TiaiJmTXN0acbLPgVFAgLg=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0262.eurprd08.prod.outlook.com (10.161.35.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Mon, 24 Dec 2018 09:26:31 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:26:31 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 07/11] drm/komeda: Add komeda_crtc_vblank_enable/disable
Thread-Topic: [PATCH 07/11] drm/komeda: Add komeda_crtc_vblank_enable/disable
Thread-Index: AQHUm2rBQ9cUqfU5BUCGr5zf1/3BfA==
Date:   Mon, 24 Dec 2018 09:26:31 +0000
Message-ID: <20181224092435.2792-8-james.qian.wang@arm.com>
References: <20181224092435.2792-1-james.qian.wang@arm.com>
In-Reply-To: <20181224092435.2792-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYXPR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::32) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0262;6:T+MYHczo+UlIFsAzIG6RXCLJ8tFi/kFHpRkK/E4W4BLKCFFR5537oMz+YmZZWlOKhh8JPRCv4v+jEOwwRbOi7l3hsxigfCqzPOBrs/YaxV+ktwH3HSfX3aq3oZvngY/aV3yEqNyQ4iG+otMYtpBp+uD17efb2Hemqw/lRPcve3OH4oODCVkCme6MLk/Yn/dyy7X/Ig7YOuwEMIuiIrGamYKGnjmbus3+nXPlkqhB6BiWeLY+WtluBK53UQtj9HmEb4INTHNVaX8rfg59ZRP1MJ6Nd3eZOSuOlkiouUkeiTPKiPvz9nequ5s5S9UAu262oowh7KEdjGhBux0WqGJ7J+JTxbjFZr3Lkj/As2I4nMX4RaYPBsaM+c6Quf2p8xclOo4FTB45MsRaiPxuvNRujQikO4KSanmmY/n/9Yt8HUBDKvoHOI7b4xuIDJH5tBTSB5iDELnVs8uXXJWSd8qVqg==;5:cuyPkiU4rKq5/l/ZtcoEduLVjcNKyWHPcZMEbI/xNN6i0PUAxsn3oZaWHU4zSBwBukicK7Nt947GF8TnFqLd5/+Qy/yL2TlYUKYQP3Z1pe0PdKBQXc6eXk6w+AE3UtIQ7KkgIpP8bkbS29doMJm4VsXc7Ef70IoGd6fxcpvBPQ4=;7:f3EAkONrDukCcZ8z6rfpHChCD7XotobmoasnlXVc2koFiRFCrHuKnEABjCGcNqdI7EGAtTEzhI6PbqLq4i45EooB7jB2mCgNJcmR5Spykmp6IrRcRlyzdakEei1qkxXUOiZq8N2WzVt6U/vhyEsuyQ==
x-ms-office365-filtering-correlation-id: c09464d7-b9a2-49c2-6620-08d66981e3a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0262;
x-ms-traffictypediagnostic: AM3PR08MB0262:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB02623D6618DB5F8E2D36116FB3BB0@AM3PR08MB0262.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0262;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0262;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(366004)(136003)(376002)(39850400004)(346002)(199004)(189003)(4326008)(256004)(305945005)(53936002)(6862004)(71190400001)(71200400001)(486006)(7736002)(97736004)(446003)(2906002)(52116002)(6116002)(76176011)(1076003)(575784001)(6436002)(86362001)(6512007)(5660300001)(11346002)(186003)(26005)(68736007)(3846002)(2616005)(476003)(55236004)(386003)(102836004)(6506007)(25786009)(103116003)(14454004)(105586002)(99286004)(54906003)(37006003)(6486002)(106356001)(316002)(8676002)(81166006)(81156014)(8936002)(6636002)(36756003)(478600001)(66066001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0262;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XF78ugxyBRll0FWRatVFv6DvPK0ipstWeJ6uTEO4iRUYkz1oiwhUTFEIlr862Qw6r9glxDXgfWz5R6hcQiJCwsDDvMb/8j3sGw5GuMUVPOCk2OL5dETRGydYZijNHQCU3HLSQgvXeyoby09M2SYCoZbGZjsb/nNbWVv+jlz6Temv/OSwy0/vdVKwdo30wt5Jrux4HkACMikNR8bAS07vg+ObNAB0BHbtkb7GQK79krQuOEg91WnvzLXpqwBWhRsV6IqfbUZWZNr5Jxr46qH/Jhch21Ik9gIDCrI30qzBryUfPaACf8Xaj1rMqO7h65yA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09464d7-b9a2-49c2-6620-08d66981e3a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:26:31.4202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new komeda_dev_func->on_off_vblank to enable/disable HW vblank event

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 10 ++++++++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 19 +++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index 39b3c84cf483..31680bc0ccba 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -241,6 +241,15 @@ static int d71_disable_irq(struct komeda_dev *mdev)
 	return 0;
 }
=20
+static void d71_on_off_vblank(struct komeda_dev *mdev, int master_pipe, bo=
ol on)
+{
+	struct d71_dev *d71 =3D mdev->chip_data;
+	struct d71_pipeline *pipe =3D d71->pipes[master_pipe];
+
+	malidp_write32_mask(pipe->dou_addr, BLK_IRQ_MASK,
+			    DOU_IRQ_PL0, on ? DOU_IRQ_PL0 : 0);
+}
+
 static int to_d71_opmode(int core_mode)
 {
 	switch (core_mode) {
@@ -492,6 +501,7 @@ static struct komeda_dev_funcs d71_chip_funcs =3D {
 	.irq_handler	=3D d71_irq_handler,
 	.enable_irq	=3D d71_enable_irq,
 	.disable_irq	=3D d71_disable_irq,
+	.on_off_vblank	=3D d71_on_off_vblank,
 	.change_opmode	=3D d71_change_opmode,
 	.flush		=3D d71_flush,
 };
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index c76cd75a0100..6d9fb4626ba5 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -347,7 +347,26 @@ struct drm_crtc_helper_funcs komeda_crtc_helper_funcs =
=3D {
 	.mode_fixup	=3D komeda_crtc_mode_fixup,
 };
=20
+static int komeda_crtc_vblank_enable(struct drm_crtc *crtc)
+{
+	struct komeda_dev *mdev =3D crtc->dev->dev_private;
+	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
+
+	mdev->funcs->on_off_vblank(mdev, kcrtc->master->id, true);
+	return 0;
+}
+
+static void komeda_crtc_vblank_disable(struct drm_crtc *crtc)
+{
+	struct komeda_dev *mdev =3D crtc->dev->dev_private;
+	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
+
+	mdev->funcs->on_off_vblank(mdev, kcrtc->master->id, false);
+}
+
 static const struct drm_crtc_funcs komeda_crtc_funcs =3D {
+	.enable_vblank		=3D komeda_crtc_vblank_enable,
+	.disable_vblank		=3D komeda_crtc_vblank_disable,
 };
=20
 int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 18dd82b09340..2beaa0d49c34 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -103,6 +103,9 @@ struct komeda_dev_funcs {
 	int (*enable_irq)(struct komeda_dev *mdev);
 	/** @disable_irq: disable irq */
 	int (*disable_irq)(struct komeda_dev *mdev);
+	/** @on_off_vblank: notify HW to on/off vblank */
+	void (*on_off_vblank)(struct komeda_dev *mdev,
+			      int master_pipe, bool on);
=20
 	/** @dump_register: Optional, dump registers to seq_file */
 	void (*dump_register)(struct komeda_dev *mdev, struct seq_file *seq);
--=20
2.17.1

