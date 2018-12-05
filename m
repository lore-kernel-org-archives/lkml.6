Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B4BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B3720659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ptC2xn3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B3720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeLEKT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:19:56 -0500
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:47744
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727349AbeLEKTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFUf6ECGlvPN4FZNIIhNByx80L3ewdrUCgZNS9YUyMQ=;
 b=ptC2xn3v/EcBFakTYzBriuwRyYmHqXszLY0tMq7Fy8BfeYeOX2Axw/jiIaD/2FFanag3Bn6qD2DYQHTHRTmMZT0+m5J91DU7b8450uUngXBHh8FD4ndjM3xaeVXHR3bq6OqQ1+IHMy2vYEhwOceMsRN9+8qLj9JxaFFffs5yyF4=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0580.eurprd08.prod.outlook.com (10.163.188.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 10:19:40 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 10:19:40 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v1 6/9] drm/komeda: Add komeda_framebuffer
Thread-Topic: [PATCH v1 6/9] drm/komeda: Add komeda_framebuffer
Thread-Index: AQHUjIQInLevTY4Ed0qtS3xrEo1/WA==
Date:   Wed, 5 Dec 2018 10:19:40 +0000
Message-ID: <20181205101635.7696-7-james.qian.wang@arm.com>
References: <20181205101635.7696-1-james.qian.wang@arm.com>
In-Reply-To: <20181205101635.7696-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYCPR01CA0014.ausprd01.prod.outlook.com
 (2603:10c6:10:31::26) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0580;6:DCZzwxm3EfXaUEg48oM0bsd4UIu5+FaBQC/gySEYV7XGrZ4cTpsT9zZ5OteTimXfpP6c7bmwFJp/cvNRQwdoG4FCnnbzEp9Uw+vf1RxjMdifP5xh3nESgWovv4ZSSIDrmzzSzID3eD4MKSGvOkrHDkGJVR8IGq2Cv8RJt2ayjyzUWxmAkGz3PacKIZrYt5bmPas2MLTnZN0//R8Y2YGXqKl1BxKYkZxArQa5OviaR4ZemPe+aiTwrHTLUnzh7wsJaEY0srgO/+Ae9waPCvYxWkNFG/YEW74fHkL3YDuiScrTfBpi7kSdqCA+XtxSxEIhAHGqaI74F3P6gEb6MTIYKyBuzmceU9dLqSUPt8NVfgHU1ejzN1pPTzmO3/W+zpP9H30gsiLXFyLzGHEij1vkkvKynY5os07o2uyyoJlub2x50/1JuMdr4cJb8tcmdxSEKU9XdHwogBPfEIqJ7r5T4A==;5:hgtLc8LDLkRpkG5oUeiDa3qbsAEaDFB+G3C2fqIztBP7IQ33E1ICsTleTbTVcc7L9DrkafGzVE7gOLf/Z2XkL2L8KNHCrV6o3ZA7OCGsvxH4+nl0t++dA+IdwFTVmi0/sofHSSEFh5rQv/sVECmRyJbavJ/vRxBKcZzKfEndIHo=;7:giUTdov6/0Nyh8Vv5vrSyfLDRKi1IcppAbnRIIGamAUKvyxSt0FUcPDK6BRmI3FrEzdfwVw5T6bp5Szx1MUsl5ME3JkNFVlg2owKCXwijrRunRsQo7h5bh7Ag1TgiK9VeAB6N6HfHhhRjZBZs4LMQQ==
x-ms-office365-filtering-correlation-id: e5399137-194b-4baf-9e0d-08d65a9b2a88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0580;
x-ms-traffictypediagnostic: AM3PR08MB0580:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0580DD73F0E5B43735D490F0B3A80@AM3PR08MB0580.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0580;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0580;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(446003)(71190400001)(25786009)(4326008)(486006)(71200400001)(3846002)(478600001)(6116002)(186003)(256004)(102836004)(55236004)(14454004)(6862004)(86362001)(97736004)(26005)(14444005)(105586002)(103116003)(37006003)(53936002)(106356001)(36756003)(476003)(2906002)(386003)(7736002)(6506007)(305945005)(6436002)(8676002)(68736007)(2616005)(6636002)(6512007)(8936002)(6486002)(76176011)(1076002)(81156014)(52116002)(11346002)(99286004)(66066001)(316002)(81166006)(54906003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0580;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c43lo/a3kklG4Dxf85X1/YI6jRCVTa7nU3QrE3RzzQtoAggEIm5z3T+L5uu8xK1uU+r36SHOEvLK/g6lwOEqjWqYsa/BuiHEOipOsFic80eQ6Iu/NJbSo91BX9fCSmKnRmCVIxJXJU01s3/Qz+cSDklTTkPqTU4Ze9zsyYg2vctlqnGSRWrB4oAWiZEYx23p9wHG/ChGAvVMEAQ11oAkIJKJpOZ9ObyQuEPmKb/khB+iaJAaAcZdphJapdKP1Y84rjqVRKJ/O+lO5fjt9hSLzlQwdAc82cX+2W8NgmebzA3Ir3uSt3WUL5gMDfMj7p8JglJfoyse67bCm5Z++9K3l6SuXvOsDLaxRP4SKnstBBk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5399137-194b-4baf-9e0d-08d65a9b2a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 10:19:40.3494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

komeda_framebuffer is for extending drm_framebuffer to add komeda own
attributes and komeda specific fb handling.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/Makefile   |   3 +-
 .../arm/display/komeda/komeda_framebuffer.c   | 165 ++++++++++++++++++
 .../arm/display/komeda/komeda_framebuffer.h   |  31 ++++
 3 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h

diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/=
arm/display/komeda/Makefile
index c86602131dbc..d369317f72ab 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -8,7 +8,8 @@ komeda-y :=3D \
 	komeda_drv.o \
 	komeda_dev.o \
 	komeda_format_caps.o \
-	komeda_pipeline.o
+	komeda_pipeline.o \
+	komeda_framebuffer.o
=20
 komeda-y +=3D \
 	d71/d71_dev.o
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
new file mode 100644
index 000000000000..9912d6cc4c4f
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include "komeda_framebuffer.h"
+#include "komeda_dev.h"
+
+static void komeda_fb_destroy(struct drm_framebuffer *fb)
+{
+	struct komeda_fb *kfb =3D to_kfb(fb);
+	u32 i;
+
+	for (i =3D 0; i < fb->format->num_planes; i++)
+		drm_gem_object_put_unlocked(fb->obj[i]);
+
+	drm_framebuffer_cleanup(fb);
+	kfree(kfb);
+}
+
+static int komeda_fb_create_handle(struct drm_framebuffer *fb,
+				   struct drm_file *file, u32 *handle)
+{
+	return drm_gem_handle_create(file, fb->obj[0], handle);
+}
+
+static const struct drm_framebuffer_funcs komeda_fb_funcs =3D {
+	.destroy 	=3D komeda_fb_destroy,
+	.create_handle 	=3D komeda_fb_create_handle,
+};
+
+static int
+komeda_fb_none_afbc_size_check(struct komeda_dev *mdev, struct komeda_fb *=
kfb,
+			       struct drm_file *file,
+			       const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	struct drm_framebuffer *fb =3D &kfb->base;
+	struct drm_gem_object *obj;
+	u32 min_size =3D 0;
+	u32 i;
+
+	for (i =3D 0; i < fb->format->num_planes; i++) {
+		obj =3D drm_gem_object_lookup(file, mode_cmd->handles[i]);
+		if (!obj) {
+			DRM_DEBUG_KMS("Failed to lookup GEM object\n");
+			fb->obj[i] =3D NULL;
+
+			return -ENOENT;
+		}
+
+		kfb->aligned_w =3D fb->width / (i ? fb->format->hsub : 1);
+		kfb->aligned_h =3D fb->height / (i ? fb->format->vsub : 1);
+
+		if (fb->pitches[i] % mdev->chip.bus_width) {
+			DRM_DEBUG_KMS("Pitch[%d]: 0x%x doesn't aligned 0x%x\n",
+				   i, fb->pitches[i], mdev->chip.bus_width);
+			drm_gem_object_put_unlocked(obj);
+			fb->obj[i] =3D NULL;
+
+			return -EINVAL;
+		}
+
+		min_size =3D ((kfb->aligned_h / kfb->format_caps->tile_size - 1)
+			    * fb->pitches[i])
+			    + (kfb->aligned_w * fb->format->cpp[i]
+			       * kfb->format_caps->tile_size)
+			    + fb->offsets[i];
+
+		if (obj->size < min_size) {
+			DRM_DEBUG_KMS("Fail to check none afbc fb size.\n");
+			drm_gem_object_put_unlocked(obj);
+			fb->obj[i] =3D NULL;
+
+			return -EINVAL;
+		}
+
+		fb->obj[i] =3D obj;
+	}
+
+	if (fb->format->num_planes =3D=3D 3) {
+		if (fb->pitches[1] !=3D fb->pitches[2]) {
+			DRM_DEBUG_KMS("The pitch[1] and [2] are not same\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+struct drm_framebuffer *
+komeda_fb_create(struct drm_device *dev, struct drm_file *file,
+		 const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	struct komeda_dev *mdev =3D dev->dev_private;
+	struct komeda_fb *kfb;
+	int ret =3D 0, i;
+
+	kfb =3D kzalloc(sizeof(*kfb), GFP_KERNEL);
+	if (!kfb)
+		return ERR_PTR(-ENOMEM);
+
+	kfb->format_caps =3D komeda_get_format_caps(&mdev->fmt_tbl,
+						  mode_cmd->pixel_format,
+						  mode_cmd->modifier[0]);
+	if (kfb->format_caps =3D=3D NULL) {
+		DRM_DEBUG_KMS("FMT %x is not supported.\n",
+			      mode_cmd->pixel_format);
+		kfree(kfb);
+		return ERR_PTR(-EINVAL);
+	}
+
+	drm_helper_mode_fill_fb_struct(dev, &kfb->base, mode_cmd);
+
+	ret =3D komeda_fb_none_afbc_size_check(mdev, kfb, file, mode_cmd);
+	if (ret < 0)
+		goto err_cleanup;
+
+	ret =3D drm_framebuffer_init(dev, &kfb->base, &komeda_fb_funcs);
+	if (ret < 0) {
+		DRM_DEBUG_KMS("failed to initialize fb\n");
+
+		goto err_cleanup;
+	}
+
+	return &kfb->base;
+
+err_cleanup:
+	for(i =3D 0; i < kfb->base.format->num_planes; i++)
+		drm_gem_object_put_unlocked(kfb->base.obj[i]);
+
+	kfree(kfb);
+	return ERR_PTR(ret);
+}
+
+dma_addr_t
+komeda_fb_get_pixel_addr(struct komeda_fb *kfb, int x, int y, int plane)
+{
+	struct drm_framebuffer *fb =3D &kfb->base;
+	const struct drm_gem_cma_object *obj;
+	u32 plane_x, plane_y, cpp, pitch, offset;
+
+	if (plane > fb->format->num_planes) {
+		DRM_DEBUG_KMS("Out of max plane num.\n");
+		return -EINVAL;
+	}
+
+	obj =3D drm_fb_cma_get_gem_obj(fb, plane);
+
+	offset =3D fb->offsets[plane];
+	if (!fb->modifier) {
+		plane_x =3D x / (plane ? fb->format->hsub : 1);
+		plane_y =3D y / (plane ? fb->format->vsub : 1);
+		cpp =3D fb->format->cpp[plane];
+		pitch =3D fb->pitches[plane];
+		offset +=3D plane_x * cpp *  kfb->format_caps->tile_size +
+				(plane_y * pitch) / kfb->format_caps->tile_size;
+	}
+
+	return obj->paddr + offset;
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h b/driv=
ers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
new file mode 100644
index 000000000000..383780013bb9
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#ifndef _KOMEDA_FRAMEBUFFER_H_
+#define _KOMEDA_FRAMEBUFFER_H_
+
+/** struct komeda_fb - entend drm_framebuffer with komeda attribute */
+struct komeda_fb {
+	/** @base: &drm_framebuffer */
+	struct drm_framebuffer base;
+	/* @format_caps: &komeda_format_caps */
+	const struct komeda_format_caps *format_caps;
+	/** @aligned_w: aligned frame buffer width */
+	u32 aligned_w;
+	/** @aligned_h: aligned frame buffer height */
+	u32 aligned_h;
+};
+
+#define to_kfb(dfb)	container_of(dfb, struct komeda_fb, base)
+
+struct drm_framebuffer *
+komeda_fb_create(struct drm_device *dev, struct drm_file *file,
+		 const struct drm_mode_fb_cmd2 *mode_cmd);
+dma_addr_t
+komeda_fb_get_pixel_addr(struct komeda_fb *kfb, int x, int y, int plane);
+bool komeda_fb_is_layer_supported(struct komeda_fb *kfb, u32 layer_type);
+
+#endif
--=20
2.17.1

