Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF18BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F7021906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Wga3hXry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389297AbeLUKA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:00:26 -0500
Received: from mail-eopbgr40079.outbound.protection.outlook.com ([40.107.4.79]:64284
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389267AbeLUKAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au4tOnaVhgUfve33gYnpt3VEnu1TQZjb1ebp+Klu1t8=;
 b=Wga3hXrybj7wWPXHXUgKKlM9ZKZjWdRgsAdbWeqUnEDA9MpWFJG3EjSbHYCSoJun6INdXhxl6apAfqO8PhqxkoCU2fZvWkRjdTC6irl3dEkqLvr5uqWAXHFxOMFCmMP6/Z5U0SNbCpWyrz0Z3KEw99ZVDZjwzu0n+nnC6YuuVdk=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB3187.eurprd08.prod.outlook.com (52.134.93.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 10:00:17 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db%5]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 10:00:17 +0000
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
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v3 6/9] drm/komeda: Add komeda_framebuffer
Thread-Topic: [PATCH v3 6/9] drm/komeda: Add komeda_framebuffer
Thread-Index: AQHUmRP5skxDANnM6EeocvoEivyStQ==
Date:   Fri, 21 Dec 2018 10:00:17 +0000
Message-ID: <20181221095757.15510-7-james.qian.wang@arm.com>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
In-Reply-To: <20181221095757.15510-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY3PR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:0:19::32) To AM0PR08MB4483.eurprd08.prod.outlook.com
 (2603:10a6:208:145::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3187;6:9KAXu41KPk2aGc6i0kr5yQACa3rVSChIiJR3g87qMyjdSOgpXLrRGkHHlL9KTVckA0bmXGgJOys9n1pd/Lt3+PhdoBpGxTfUEa7n/5YmVqw/XtDdNn1r/u7FMvhVy6SO1aJj4srle4G4FuZrr/49ZRyM6zoUXN648wrRtdZp+khou7gzYKS0Kea7rcWyfH/QXLP75Yj5hGI+QoBv3WUTc/MumRnIrNYJefytu89oob4Azm5B/HJDv/Ve4jirNQKEeeN0JHmCztr3wY4dmM3IAgMuSujLXZSK9hGQbbQt/FkyvvQobXagMxsz06RMyojOvhRQmsdFm/me1zM42z7QchDaMisBrlSKv5PmAN+hQ9G8zK2mWlOc+onG3pJq7ECJf+eLmLoGjg43OnKCmpsYee9hC0PvB7hGM4niFBCEBHdw4tjB0m6XvLw52RbpOdGrHjR8HdzP9Sxl2FEGKvQp3Q==;5:9vp2S3X4OnXhS53ppL4jSrXjyTG3yaFSKY44FfCJ4T8umg0IBxgQBuOfyUZ/9b6+iFcj0xeZA/aBlyJ+QSFoAgXg5IR/T06vFxSO8BFEhWJDS6uoGKfIEpVOLujeUbqQT5qea2EJlPlbiBJQEhd2slJbVKsKNh3MGp15Bl55tJg=;7:4C6niPI8X+TugwjwWXlJxMHrQ3vJ81BXIscpRsGlD1bKZD3Uj9Yvwql8ZxkgUuu8oGXmi0DUh7bETYO7t2ZKnBSnYAnijzpNdY90UoJCxWAfMBuAOiZrOHDgDazV+WAuutnmeYb/B2T7GifQmS4KrA==
x-ms-office365-filtering-correlation-id: 510db79f-7d54-404e-d8cd-08d6672b1bf2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3187;
x-ms-traffictypediagnostic: AM0PR08MB3187:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3187AF239EC1C3AC1C765D68B3B80@AM0PR08MB3187.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3187;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3187;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(366004)(189003)(199004)(71200400001)(97736004)(71190400001)(103116003)(86362001)(14454004)(2906002)(5660300001)(106356001)(6116002)(105586002)(66066001)(54906003)(6636002)(3846002)(37006003)(99286004)(68736007)(478600001)(25786009)(6486002)(7736002)(36756003)(6436002)(76176011)(316002)(186003)(386003)(6506007)(55236004)(1076003)(26005)(6512007)(256004)(14444005)(6862004)(52116002)(81156014)(476003)(486006)(81166006)(7416002)(102836004)(8676002)(305945005)(2616005)(8936002)(53936002)(4326008)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3187;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: x2d+rg8CwUpEtpfgrA73FjVtTLlfahADLSa25hI4een1q8plv46vImAKBQYl7+UbqTVB7l1LJFzEpZJ31YgvCghF9KP6iYxjH8VBFU0EWOq+wb69StQySZ/55BvjsCaWwlhLWv7P7pb4IUJI0IFpSxbJyQIxJcroXbtwwDBOvZwoGtJhRFuqqVYDvsx6/1t4FfbXQemGTgdTmCbIb5iuQEKG0eDmfqV4ypnwl4HkmyhZ7axEtaOn3LMPrAhUpiwuszMGLmbNS0c2RzXqT5C4n0mgGAfz0qyRjf2KBEFSKPdTyFf9qP763b57Lu4ajFtt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510db79f-7d54-404e-d8cd-08d6672b1bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 10:00:17.3181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

komeda_framebuffer is for extending drm_framebuffer to add komeda own
attributes and komeda specific fb handling.

Changes in v3:
- Fixed style problem found by checkpatch.pl --strict.

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
index 394fc2aa434a..25beae900ed2 100644
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
index 000000000000..4ddd5314ca23
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
+	.destroy	=3D komeda_fb_destroy,
+	.create_handle	=3D komeda_fb_create_handle,
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
+			DRM_DEBUG_KMS("Pitch[%d]: 0x%x doesn't align to 0x%x\n",
+				      i, fb->pitches[i], mdev->chip.bus_width);
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
+	if (!kfb->format_caps) {
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
+	for (i =3D 0; i < kfb->base.format->num_planes; i++)
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

