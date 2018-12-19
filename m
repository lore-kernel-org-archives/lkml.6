Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B48C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8555121873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gQSvzYVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeLSMe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:34:58 -0500
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:51629
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729530AbeLSMez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hywrdd2eluQrgl6ypuJG2HxPyNpiyV+k4CzMUxbVqyk=;
 b=gQSvzYVUaneyPJUmy53+fy91ZCdEQxkDbEo6EzAzz4ia+KSXfq9inNoicJXrqNzYkb458UDhCaRrWqb2Bnio5fe4xQPer7h6lJ8cUZ8L5cu8votVFsvC7YNlk+HcrqyY7DUpuCuNqWn8jn5Aa1+W42HGVmw8t9fKkcGLiQ9EmgQ=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB3924.eurprd08.prod.outlook.com (20.178.118.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 19 Dec 2018 12:34:33 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db%5]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 12:34:33 +0000
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
Subject: [PATCH v2 7/9] drm/komeda: Attach komeda_dev to DRM-KMS
Thread-Topic: [PATCH v2 7/9] drm/komeda: Attach komeda_dev to DRM-KMS
Thread-Index: AQHUl5cxWOblOH4LREO0WtwAQQpdOw==
Date:   Wed, 19 Dec 2018 12:34:33 +0000
Message-ID: <20181219123147.16090-8-james.qian.wang@arm.com>
References: <20181219123147.16090-1-james.qian.wang@arm.com>
In-Reply-To: <20181219123147.16090-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0132.ausprd01.prod.outlook.com
 (2603:10c6:10:5::24) To AM0PR08MB4483.eurprd08.prod.outlook.com
 (2603:10a6:208:145::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3924;6:EF5yOQId6jNtbWrE/FgD/yVcZKZZJUKrC5BdERWRdvPZ0GZvK9fB4tluEpMsMrMBV990zN8eh+dRN7AA6VYIX4ge6dXjiTBT7VWn8Cc14nDeg5ekBXA2xnyKzGkr2xXzENTcnNEInOwvohcG4qPx8i8d+7CkZmZvVImWq8sYcxUxRzAV7asNc/zhq7geesgd6iRYv1RrkwQg8J4EitXrpsK160DiAyyFxtT31TtUv57Nm+hLWZA22uWm3R4ogxLJEE891BtnjybCehQDmx5CHIiq8rFk7MtDlxNVALwfnBlY2OsNd8FDF95aUQGY2bMPUIrBIMV1sG++11Asw/d3zRJuJkmUGpY9RMX0LN+BC4btUxakFMfct9O8UUTV1EXNywkym57B+ac1d4l60f139lMFpqV+c18pPl65RsH3WobjuRYZJHlp+aTtc9I2WXJq6KQZSYx7c334cFBPna95KA==;5:kaTGazVZty62MAhTn7TkgpjsnJNuPFBcodQSD/g5pHm+MIqWkJ+dKJad6vSrQ5ggm/quUZk/WHUi5+OYgia7OtCXbTGvYN7M6/mSmqYBjOm+t/WFPDJu8LbyAJxU1NUgt0g+eVSOeNR6YhNqw4JB5sWhxFMoezy/eXZdAPUO47Y=;7:IxrOqSUxwKP9lP3rrBbG1dngtFwAKJsG0nImE13AUV15wq8nei8IkfrJui7W7e/QzskWpWx5y6kIKwpVrLk5UUuqyuoTu1KLpDGUmnQ4+ll4KXiKDgTZPzNdg1fGt1XIbvwLLi4vE5XYesw/EZhKbQ==
x-ms-office365-filtering-correlation-id: aedb0ed9-db00-4566-83bd-08d665ae53e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3924;
x-ms-traffictypediagnostic: AM0PR08MB3924:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB392491150B699B78D96460A0B3BE0@AM0PR08MB3924.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3924;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3924;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(189003)(316002)(8936002)(103116003)(37006003)(1076003)(71190400001)(81166006)(81156014)(11346002)(446003)(97736004)(36756003)(54906003)(4744004)(256004)(2616005)(486006)(6636002)(99286004)(71200400001)(476003)(575784001)(86362001)(5024004)(14444005)(8676002)(106356001)(105586002)(5660300001)(3846002)(7416002)(6116002)(14454004)(68736007)(6512007)(2906002)(4326008)(25786009)(6486002)(76176011)(52116002)(53936002)(186003)(55236004)(102836004)(26005)(6862004)(6436002)(53946003)(305945005)(478600001)(6506007)(66066001)(386003)(7736002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3924;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Rp1KCg6qpDD9SYKbgTXfKfg5ceRwgM6fCdwpPWZkcMeiWXXQ3D1fsKCc6mxP7h8kUP0yNttS8QDw71s50i06qlHDameVgryx5xinM9RK1B3L3X5+vxcQq9Lxh80xAYCvI26jB3qEDXM7gLcfrT9sEY11T2bSfLkDXis81dTAGsmpccIBzO7GHPGQVaO6R+yGRlNORbwqm5qgeVXLcg9V+4U4yMZRJ4uv5BGLS0lphGW+X+yAL2sPSv6S5cIFZL6GN9NCgDZykkd1BQuriWjkKcfwoV3QlY7MTxEuQ+yvQv8MVEJIGl8/xrwf3Tp5Ph/X
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aedb0ed9-db00-4566-83bd-08d665ae53e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 12:34:33.1545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3924
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add komeda_kms abstracton to attach komeda_dev to DRM-KMS
  CRTC: according to the komeda_pipeline
  PLANE: according to komeda_layer (layer input pipeline)
  PRIVATE_OBJS: komeda_pipeline/component all will be treat as private_objs

komeda_kms is for connecting DRM-KMS and komeda_dev, like reporting the
kms object properties according to the komeda_dev, and pass/convert KMS's
requirement to komeda_dev.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/Makefile   |   6 +-
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 106 +++++++++++
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |  22 ++-
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 168 ++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_kms.h   | 113 ++++++++++++
 .../drm/arm/display/komeda/komeda_pipeline.h  |   3 +
 .../gpu/drm/arm/display/komeda/komeda_plane.c | 109 ++++++++++++
 .../arm/display/komeda/komeda_private_obj.c   |  87 +++++++++
 8 files changed, 608 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_kms.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_kms.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_plane.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c

diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/=
arm/display/komeda/Makefile
index d369317f72ab..1374c01d179e 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -9,7 +9,11 @@ komeda-y :=3D \
 	komeda_dev.o \
 	komeda_format_caps.o \
 	komeda_pipeline.o \
-	komeda_framebuffer.o
+	komeda_framebuffer.o \
+	komeda_kms.o \
+	komeda_crtc.o \
+	komeda_plane.o \
+	komeda_private_obj.o
=20
 komeda-y +=3D \
 	d71/d71_dev.o
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
new file mode 100644
index 000000000000..5bb5a55f6b31
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#include <linux/clk.h>
+#include <linux/spinlock.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_plane_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <linux/pm_runtime.h>
+#include "komeda_dev.h"
+#include "komeda_kms.h"
+
+struct drm_crtc_helper_funcs komeda_crtc_helper_funcs =3D {
+};
+
+static const struct drm_crtc_funcs komeda_crtc_funcs =3D {
+};
+
+int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
+			   struct komeda_dev *mdev)
+{
+	struct komeda_crtc *crtc;
+	struct komeda_pipeline *master;
+	char str[16];
+	int i;
+
+	kms->n_crtcs =3D 0;
+
+	for (i =3D 0; i < mdev->n_pipelines; i++) {
+		crtc =3D &kms->crtcs[kms->n_crtcs];
+		master =3D mdev->pipelines[i];
+
+		crtc->master =3D master;
+		crtc->slave  =3D NULL;
+
+		if (crtc->slave)
+			sprintf(str, "pipe-%d", crtc->slave->id);
+		else
+			sprintf(str, "None");
+
+		DRM_INFO("crtc%d: master(pipe-%d) slave(%s) output: %s.\n",
+			 kms->n_crtcs, master->id, str,
+			 master->of_output_dev ?
+			 master->of_output_dev->full_name : "None");
+
+		kms->n_crtcs++;
+	}
+
+	return 0;
+}
+
+static struct drm_plane *
+get_crtc_primary(struct komeda_kms_dev *kms, struct komeda_crtc *crtc)
+{
+	struct komeda_plane *kplane;
+	struct drm_plane *plane;
+
+	drm_for_each_plane(plane, &kms->base) {
+		if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY)
+			continue;
+
+		kplane =3D to_kplane(plane);
+		/* only master can be primary */
+		if (kplane->layer->base.pipeline =3D=3D crtc->master)
+			return plane;
+	}
+
+	return NULL;
+}
+
+static int komeda_crtc_add(struct komeda_kms_dev *kms,
+			   struct komeda_crtc *kcrtc)
+{
+	struct drm_crtc *crtc =3D &kcrtc->base;
+	int err;
+
+	err =3D drm_crtc_init_with_planes(&kms->base, crtc,
+					get_crtc_primary(kms, kcrtc), NULL,
+					&komeda_crtc_funcs, NULL);
+	if (err)
+		return err;
+
+	drm_crtc_helper_add(crtc, &komeda_crtc_helper_funcs);
+	drm_crtc_vblank_reset(crtc);
+
+	crtc->port =3D kcrtc->master->of_output_port;
+
+	return 0;
+}
+
+int komeda_kms_add_crtcs(struct komeda_kms_dev *kms, struct komeda_dev *md=
ev)
+{
+	int i, err;
+
+	for (i =3D 0; i < kms->n_crtcs; i++) {
+		err =3D komeda_crtc_add(kms, &kms->crtcs[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index bf32d334d20d..11ec0d275917 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -10,22 +10,26 @@
 #include <linux/component.h>
 #include <drm/drm_of.h>
 #include "komeda_dev.h"
+#include "komeda_kms.h"
=20
 struct komeda_drv {
 	struct komeda_dev *mdev;
+	struct komeda_kms_dev *kms;
 };
=20
 static void komeda_unbind(struct device *dev)
 {
 	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
=20
-	dev_set_drvdata(dev, NULL);
-
 	if (mdrv =3D=3D NULL)
 		return;
=20
+	komeda_kms_detach(mdrv->kms);
+
 	komeda_dev_destroy(mdrv->mdev);
-	kfree(mdrv);
+
+	dev_set_drvdata(dev, NULL);
+	devm_kfree(dev, mdrv);
 }
=20
 static int komeda_bind(struct device *dev)
@@ -33,7 +37,7 @@ static int komeda_bind(struct device *dev)
 	struct komeda_drv *mdrv;
 	int err;
=20
-	mdrv =3D kzalloc(sizeof(*mdrv), GFP_KERNEL);
+	mdrv =3D devm_kzalloc(dev, sizeof(*mdrv), GFP_KERNEL);
 	if (mdrv =3D=3D NULL)
 		return -ENOMEM;
=20
@@ -45,10 +49,18 @@ static int komeda_bind(struct device *dev)
=20
 	dev_set_drvdata(dev, mdrv);
=20
+	mdrv->kms =3D komeda_kms_attach(mdrv->mdev);
+	if (IS_ERR(mdrv->kms)) {
+		err =3D PTR_ERR(mdrv->kms);
+		goto destroy_mdev;
+	}
+
 	return 0;
=20
+destroy_mdev:
+	komeda_dev_destroy(mdrv->mdev);
 free_mdrv:
-	kfree(mdrv);
+	devm_kfree(dev, mdrv);
 	return err;
 }
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
new file mode 100644
index 000000000000..841ee8402812
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#include <linux/component.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <linux/interrupt.h>
+#include "komeda_dev.h"
+#include "komeda_kms.h"
+#include "komeda_framebuffer.h"
+
+DEFINE_DRM_GEM_CMA_FOPS(komeda_cma_fops);
+
+static int komeda_gem_cma_dumb_create(struct drm_file *file,
+				      struct drm_device *dev,
+				      struct drm_mode_create_dumb *args)
+{
+	u32 alignment =3D 16; /* TODO get alignment from dev */
+
+	args->pitch =3D ALIGN(DIV_ROUND_UP(args->width * args->bpp, 8), alignment=
);
+
+	return drm_gem_cma_dumb_create_internal(file, dev, args);
+}
+
+static struct drm_driver komeda_kms_driver =3D {
+	.driver_features =3D DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC |
+			   DRIVER_PRIME,
+	.lastclose			=3D drm_fb_helper_lastclose,
+	.gem_free_object_unlocked	=3D drm_gem_cma_free_object,
+	.gem_vm_ops			=3D &drm_gem_cma_vm_ops,
+	.dumb_create			=3D komeda_gem_cma_dumb_create,
+	.prime_handle_to_fd		=3D drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle		=3D drm_gem_prime_fd_to_handle,
+	.gem_prime_export		=3D drm_gem_prime_export,
+	.gem_prime_import		=3D drm_gem_prime_import,
+	.gem_prime_get_sg_table		=3D drm_gem_cma_prime_get_sg_table,
+	.gem_prime_import_sg_table	=3D drm_gem_cma_prime_import_sg_table,
+	.gem_prime_vmap			=3D drm_gem_cma_prime_vmap,
+	.gem_prime_vunmap		=3D drm_gem_cma_prime_vunmap,
+	.gem_prime_mmap			=3D drm_gem_cma_prime_mmap,
+	.fops =3D &komeda_cma_fops,
+	.name =3D "komeda",
+	.desc =3D "ARM Mali Komeda Display Processor driver",
+	.date =3D "20181101",
+	.major =3D 1,
+	.minor =3D 0,
+};
+
+static void komeda_kms_commit_tail(struct drm_atomic_state *old_state)
+{
+	struct drm_device *dev =3D old_state->dev;
+
+	drm_atomic_helper_commit_modeset_disables(dev, old_state);
+
+	drm_atomic_helper_commit_planes(dev, old_state, 0);
+
+	drm_atomic_helper_commit_modeset_enables(dev, old_state);
+
+	drm_atomic_helper_wait_for_flip_done(dev, old_state);
+
+	drm_atomic_helper_commit_hw_done(old_state);
+
+	drm_atomic_helper_cleanup_planes(dev, old_state);
+}
+
+static const struct drm_mode_config_helper_funcs komeda_mode_config_helper=
s =3D {
+	.atomic_commit_tail =3D komeda_kms_commit_tail,
+};
+
+static const struct drm_mode_config_funcs komeda_mode_config_funcs =3D {
+	.fb_create		=3D komeda_fb_create,
+	.atomic_check		=3D NULL,/*komeda_kms_check*/
+	.atomic_commit		=3D drm_atomic_helper_commit,
+};
+
+static void komeda_kms_mode_config_init(struct komeda_kms_dev *kms,
+					struct komeda_dev *mdev)
+{
+	struct drm_mode_config *config =3D &kms->base.mode_config;
+
+	drm_mode_config_init(&kms->base);
+
+	komeda_kms_setup_crtcs(kms, mdev);
+
+	/* Get value from dev */
+	config->min_width	=3D 0;
+	config->min_height	=3D 0;
+	config->max_width	=3D 4096;
+	config->max_height	=3D 4096;
+	config->allow_fb_modifiers =3D true;
+
+	config->funcs =3D &komeda_mode_config_funcs;
+	config->helper_private =3D &komeda_mode_config_helpers;
+}
+
+struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
+{
+	struct komeda_kms_dev *kms =3D kzalloc(sizeof(*kms), GFP_KERNEL);
+	struct drm_device *drm;
+	int err;
+
+	if (kms =3D=3D NULL)
+		return ERR_PTR(-ENOMEM);
+
+	drm =3D &kms->base;
+	err =3D drm_dev_init(drm, &komeda_kms_driver, mdev->dev);
+	if (err)
+		goto free_kms;
+
+	drm->dev_private =3D mdev;
+
+	komeda_kms_mode_config_init(kms, mdev);
+
+	err =3D komeda_kms_add_private_objs(kms, mdev);
+	if (err)
+		goto cleanup_mode_config;
+
+	err =3D komeda_kms_add_planes(kms, mdev);
+	if (err)
+		goto cleanup_mode_config;
+
+	err =3D drm_vblank_init(drm, kms->n_crtcs);
+	if (err)
+		goto cleanup_mode_config;
+
+	err =3D komeda_kms_add_crtcs(kms, mdev);
+	if (err)
+		goto cleanup_mode_config;
+
+	err =3D component_bind_all(mdev->dev, kms);
+	if (err)
+		goto cleanup_mode_config;
+
+	drm_mode_config_reset(drm);
+
+	err =3D drm_dev_register(drm, 0);
+	if (err)
+		goto uninstall_irq;
+
+	return kms;
+
+uninstall_irq:
+	drm_irq_uninstall(drm);
+cleanup_mode_config:
+	drm_mode_config_cleanup(drm);
+free_kms:
+	kfree(kms);
+	return ERR_PTR(err);
+}
+
+void komeda_kms_detach(struct komeda_kms_dev *kms)
+{
+	struct drm_device *drm =3D &kms->base;
+	struct komeda_dev *mdev =3D drm->dev_private;
+
+	drm_dev_unregister(drm);
+	component_unbind_all(mdev->dev, drm);
+	komeda_kms_cleanup_private_objs(mdev);
+	drm_mode_config_cleanup(drm);
+	drm->dev_private =3D NULL;
+	drm_dev_put(drm);
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
new file mode 100644
index 000000000000..8810e986bcbc
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#ifndef _KOMEDA_KMS_H_
+#define _KOMEDA_KMS_H_
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_writeback.h>
+
+/** struct komeda_plane - komeda instance of drm_plane */
+struct komeda_plane {
+	/** @base: &drm_plane */
+	struct drm_plane base;
+	/**
+	 * @layer:
+	 *
+	 * represents available layer input pipelines for this plane.
+	 *
+	 * NOTE:
+	 * the layer is not for a specific Layer, but indicate a group of
+	 * Layers with same capabilities.
+	 */
+	struct komeda_layer *layer;
+};
+
+/**
+ * struct komeda_plane_state
+ *
+ * The plane_state can be splitted into two data flow (left/right) and han=
dled
+ * by two layers &komeda_plane.layer and &komeda_plane.layer.right
+ */
+struct komeda_plane_state {
+	/** @base: &drm_plane_state */
+	struct drm_plane_state base;
+
+	/* private properties */
+};
+
+/**
+ * struct komeda_wb_connector
+ */
+struct komeda_wb_connector {
+	/** @base: &drm_writeback_connector */
+	struct drm_writeback_connector base;
+
+	/** @wb_layer: represents associated writeback pipeline of komeda */
+	struct komeda_layer *wb_layer;
+};
+
+/**
+ * struct komeda_crtc
+ */
+struct komeda_crtc {
+	/** @base: &drm_crtc */
+	struct drm_crtc base;
+	/** @master: only master has display output */
+	struct komeda_pipeline *master;
+	/**
+	 * @slave: optional
+	 *
+	 * Doesn't have its own display output, the handled data flow will
+	 * merge into the master.
+	 */
+	struct komeda_pipeline *slave;
+};
+
+/** struct komeda_crtc_state */
+struct komeda_crtc_state {
+	/** @base: &drm_crtc_state */
+	struct drm_crtc_state base;
+
+	/* private properties */
+
+	/* computed state which are used by validate/check */
+	u32 affected_pipes;
+	u32 active_pipes;
+};
+
+/** struct komeda_kms_dev - for gather KMS related things */
+struct komeda_kms_dev {
+	/** @base: &drm_device */
+	struct drm_device base;
+
+	/** @n_crtcs: valid numbers of crtcs in &komeda_kms_dev.crtcs */
+	int n_crtcs;
+	/** @crtcs: crtcs list */
+	struct komeda_crtc crtcs[KOMEDA_MAX_PIPELINES];
+};
+
+#define to_kplane(p)	container_of(p, struct komeda_plane, base)
+#define to_kplane_st(p)	container_of(p, struct komeda_plane_state, base)
+#define to_kconn(p)	container_of(p, struct komeda_wb_connector, base)
+#define to_kcrtc(p)	container_of(p, struct komeda_crtc, base)
+#define to_kcrtc_st(p)	container_of(p, struct komeda_crtc_state, base)
+#define to_kdev(p)	container_of(p, struct komeda_kms_dev, base)
+
+int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_dev *=
mdev);
+
+int komeda_kms_add_crtcs(struct komeda_kms_dev *kms, struct komeda_dev *md=
ev);
+int komeda_kms_add_planes(struct komeda_kms_dev *kms, struct komeda_dev *m=
dev);
+int komeda_kms_add_private_objs(struct komeda_kms_dev *kms,
+				struct komeda_dev *mdev);
+void komeda_kms_cleanup_private_objs(struct komeda_dev *mdev);
+
+struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev);
+void komeda_kms_detach(struct komeda_kms_dev *kms);
+
+#endif /*_KOMEDA_KMS_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index ead897720e1a..49dd869cb462 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -328,6 +328,9 @@ struct komeda_pipeline_state {
 #define to_improc_st(c)	container_of(c, struct komeda_improc_state, base)
 #define to_ctrlr_st(c)	container_of(c, struct komeda_timing_ctrlr_state, b=
ase)
=20
+#define priv_to_comp_st(o) container_of(o, struct komeda_component_state, =
obj)
+#define priv_to_pipe_st(o)  container_of(o, struct komeda_pipeline_state, =
obj)
+
 /* pipeline APIs */
 struct komeda_pipeline *
 komeda_pipeline_add(struct komeda_dev *mdev, size_t size,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_plane.c
new file mode 100644
index 000000000000..937bc800c81e
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_plane_helper.h>
+#include "komeda_dev.h"
+#include "komeda_kms.h"
+
+static const struct drm_plane_helper_funcs komeda_plane_helper_funcs =3D {
+};
+
+static void komeda_plane_destroy(struct drm_plane *plane)
+{
+	drm_plane_cleanup(plane);
+
+	kfree(to_kplane(plane));
+}
+
+static const struct drm_plane_funcs komeda_plane_funcs =3D {
+};
+
+/* for komeda, which is pipeline can be share between crtcs */
+static u32 get_possible_crtcs(struct komeda_kms_dev *kms,
+			      struct komeda_pipeline *pipe)
+{
+	struct komeda_crtc *crtc;
+	u32 possible_crtcs =3D 0;
+	int i;
+
+	for (i =3D 0; i < kms->n_crtcs; i++) {
+		crtc =3D &kms->crtcs[i];
+
+		if ((pipe =3D=3D crtc->master) || (pipe =3D=3D crtc->slave))
+			possible_crtcs |=3D BIT(i);
+	}
+
+	return possible_crtcs;
+}
+
+/* use Layer0 as primary */
+static u32 get_plane_type(struct komeda_kms_dev *kms,
+			  struct komeda_component *c)
+{
+	bool is_primary =3D (c->id =3D=3D KOMEDA_COMPONENT_LAYER0);
+
+	return is_primary ? DRM_PLANE_TYPE_PRIMARY : DRM_PLANE_TYPE_OVERLAY;
+}
+
+static int komeda_plane_add(struct komeda_kms_dev *kms,
+			    struct komeda_layer *layer)
+{
+	struct komeda_dev *mdev =3D kms->base.dev_private;
+	struct komeda_component *c =3D &layer->base;
+	struct komeda_plane *kplane;
+	struct drm_plane *plane;
+	u32 *formats, n_formats =3D 0;
+	int err;
+
+	kplane =3D kzalloc(sizeof(*kplane), GFP_KERNEL);
+	if (kplane =3D=3D NULL)
+		return -ENOMEM;
+
+	plane =3D &kplane->base;
+	kplane->layer =3D layer;
+
+	formats =3D komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
+					       layer->layer_type, &n_formats);
+
+	err =3D drm_universal_plane_init(&kms->base, plane,
+			get_possible_crtcs(kms, c->pipeline),
+			&komeda_plane_funcs,
+			formats, n_formats, NULL,
+			get_plane_type(kms, c),
+			"%s", c->name);
+
+	komeda_put_fourcc_list(formats);
+
+	if (err)
+		goto cleanup;
+
+	drm_plane_helper_add(plane, &komeda_plane_helper_funcs);
+
+	return 0;
+cleanup:
+	komeda_plane_destroy(plane);
+	return err;
+}
+
+int komeda_kms_add_planes(struct komeda_kms_dev *kms, struct komeda_dev *m=
dev)
+{
+	struct komeda_pipeline *pipe;
+	int i, j, err;
+
+	for (i =3D 0; i < mdev->n_pipelines; i++) {
+		pipe =3D mdev->pipelines[i];
+
+		for (j =3D 0; j < pipe->n_layers; j++) {
+			err =3D komeda_plane_add(kms, pipe->layers[j]);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_private_obj.c
new file mode 100644
index 000000000000..6f0db8f819f2
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#include "komeda_dev.h"
+#include "komeda_kms.h"
+
+static struct drm_private_state *
+komeda_pipeline_atomic_duplicate_state(struct drm_private_obj *obj)
+{
+	struct komeda_pipeline_state *st;
+
+	st =3D kmemdup(obj->state, sizeof(*st), GFP_KERNEL);
+	if (st =3D=3D NULL)
+		return NULL;
+
+	st->active_comps =3D 0;
+
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &st->obj);
+
+	return &st->obj;
+}
+
+static void
+komeda_pipeline_atomic_destroy_state(struct drm_private_obj *obj,
+				     struct drm_private_state *state)
+{
+	kfree(priv_to_pipe_st(state));
+}
+
+static const struct drm_private_state_funcs komeda_pipeline_obj_funcs =3D =
{
+	.atomic_duplicate_state	=3D komeda_pipeline_atomic_duplicate_state,
+	.atomic_destroy_state	=3D komeda_pipeline_atomic_destroy_state,
+};
+
+static int komeda_pipeline_obj_add(struct komeda_kms_dev *kms,
+				   struct komeda_pipeline *pipe)
+{
+	struct komeda_pipeline_state *st;
+
+	st =3D kzalloc(sizeof(*st), GFP_KERNEL);
+	if (st =3D=3D NULL)
+		return -ENOMEM;
+	st->pipe =3D pipe;
+	drm_atomic_private_obj_init(&pipe->obj, &st->obj,
+				    &komeda_pipeline_obj_funcs);
+
+	return 0;
+}
+
+int komeda_kms_add_private_objs(struct komeda_kms_dev *kms,
+				struct komeda_dev *mdev)
+{
+	struct komeda_pipeline *pipe;
+	int i, err;
+
+	for (i =3D 0; i < mdev->n_pipelines; i++) {
+		pipe =3D mdev->pipelines[i];
+
+		err =3D komeda_pipeline_obj_add(kms, pipe);
+		if (err)
+			return err;
+
+		/* Add component */
+	}
+
+	return 0;
+}
+
+void komeda_kms_cleanup_private_objs(struct komeda_dev *mdev)
+{
+	struct komeda_pipeline *pipe;
+	struct komeda_component *c;
+	int i, id;
+
+	for (i =3D 0; i < mdev->n_pipelines; i++) {
+		pipe =3D mdev->pipelines[i];
+		dp_for_each_set_bit(id, pipe->avail_comps) {
+			c =3D komeda_pipeline_get_component(pipe, id);
+
+			drm_atomic_private_obj_fini(&c->obj);
+		}
+		drm_atomic_private_obj_fini(&pipe->obj);
+	}
+}
--=20
2.17.1

