Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC56C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BC920578
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="QJ4Gh+93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbfACLlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:41:20 -0500
Received: from mail-eopbgr10076.outbound.protection.outlook.com ([40.107.1.76]:38365
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbfACLlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqg2+oWXwjY29Kp9LCyEihat1OGqDN2evzdDQrMW8/I=;
 b=QJ4Gh+93sQtJMpTCUr73GoRWgVJzDInledmhwzg+jNtREbYWAEQacPuc7xL8gWr/h8kdqTX3UkIHmbGZoZktwHU/1+6SU6a8sWtKr6cvpX26xx3+yivPyaOK8YV0sTIyTC03JI0e0cvhL7G9+vaTh3JZq02h8Ie9CoQUT0Yju3g=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0181.eurprd08.prod.outlook.com (10.161.35.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 11:41:13 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 11:41:13 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
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
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v4 6/9] drm/komeda: Add komeda_framebuffer
Thread-Topic: [PATCH v4 6/9] drm/komeda: Add komeda_framebuffer
Thread-Index: AQHUo1k6/6INF0W4kUa/Pv/8ojBcMQ==
Date:   Thu, 3 Jan 2019 11:41:13 +0000
Message-ID: <20190103113841.15403-7-james.qian.wang@arm.com>
References: <20190103113841.15403-1-james.qian.wang@arm.com>
In-Reply-To: <20190103113841.15403-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY2PR01CA0046.ausprd01.prod.outlook.com
 (2603:10c6:1:15::34) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0181;6:AWxj6gLje7XPzsQzUSkqU9NkQmQ1k8by/+Fhe75GJiY9CPt9eePLLgLW+Y54igIvzf2k2OY/W5H+9IPSie5sZoYGpb1D6gesxgJz634ZLnC8Clor6P2YEkzA5PuUaC6Ta+0zj+lHR0M39SAzTTYJ9Gks9Tx6RcOYccj/uPABxTjqRurB5vtKiTZy+2l0Nr1/rHNYuM/3r1j5cKFq4lXHC1oYtJrlH7flSQQyYWMJMhKwH+9Tm1VqZacbIC2Vw8eYn2D3K5qFYoI1i3ezWbPDTTfG3HV0mi5L+CM3upBVA9TN6N9M798SIIycW0tZ9s3OY1uTUhtEOZmQ5s4sgme6Ms+VJlu4Xd380U6E2nfMi/xpHEoBhp+UEOCgI3PlQ6F8JbTsYIgajqTEZAj308nyq9T3MP9rP6cWjD1mZqhoT6JFAGMRGdHyF+J2HpyEkrgEr/vgc4hn2eK0le+GP8F3fQ==;5:68W2s7qxD6SFvdktHvUiSyPRopKS22TOq8z1sz+YQNrtTnXeBsn+Mkbse23zO8yZkxfcbqvlG7+HXqvYNzlzB6JQybWoVPrgjq6RcPAgVujOtr9/aZEuX8AefnCpj1Vedy1RWA6R1g1CCTk0vg3XW7cYuvgTxoVi7WVPu2HBZOJseN73/iAPkLOZagQqNhHwbPc7g6Cmh+O6u5wpN5Nc8A==;7:6IhlBMJ/5XkMaz82zwH8q0ZIsoNLBnAPrko2L4w78BMnqyTjJrY+Hy9bW5do8DJKb9jEfhJgXrMbvyGoK+pl0j4YzsGv5wgGwIdyMewEeEX0PJL1XNl2KGDC2YHG23BW6XT6aYC3UFAt6Iq0b4mCOw==
x-ms-office365-filtering-correlation-id: cc71ad2b-ecc2-40d5-84c7-08d671705ce9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0181;
x-ms-traffictypediagnostic: AM3PR08MB0181:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0181C5C14365E7211B05B71DB38D0@AM3PR08MB0181.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0181;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0181;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(189003)(6436002)(6486002)(1076003)(68736007)(2501003)(66066001)(6512007)(103116003)(36756003)(106356001)(105586002)(11346002)(478600001)(97736004)(14454004)(486006)(476003)(4326008)(2616005)(14444005)(256004)(386003)(86362001)(6506007)(7736002)(102836004)(316002)(446003)(2201001)(8936002)(26005)(7416002)(3846002)(81156014)(99286004)(2906002)(6116002)(81166006)(71200400001)(186003)(71190400001)(52116002)(76176011)(25786009)(5660300001)(8676002)(305945005)(54906003)(110136005)(53936002)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0181;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2JVoU7LRlj87lzVZUYsMd/Ug7LIFDsyjHb0Y4sV0vvJX9J4oU9Fn1ZUmm0g7YvrK6g4Ko5cM03OdVcnqZlYl3/baEbys6mu+cWlURt1phv7dGJPnZfcjvKTJt968/1fpEQ0pcTzGc38ixxRb/kpage9rYSGIv7yp7iIvm5WzgFOnrzuh1JjhYzZy4XaxKpYMmIYZuwriukYDRWx+i2mPePvrECNqay08fgqWA5oHRk+Mw1oqnBHWZDRpmampT4mUh45NCw8NFBvo8Wb6n8MoXlOZvPDfbQgjgtqDWgB51eMTo2QhR52lQE9gltqi20+D
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc71ad2b-ecc2-40d5-84c7-08d671705ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 11:41:13.2540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

komeda_framebuffer is for extending drm_framebuffer to add komeda own
attributes and komeda specific fb handling.

Changes in v3:
- Fixed style problem found by checkpatch.pl --strict.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
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

