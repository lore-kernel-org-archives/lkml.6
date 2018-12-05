Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D81CC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12A4204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Z/Y33x3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12A4204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeLEKTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:19:12 -0500
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:57024
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726944AbeLEKTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gStoIeGg9KCeTEMF/++TJASYI0MC3+wny6CkaEvbqxU=;
 b=Z/Y33x3hjGoE4fs9B8UmT0utJhCrxKCPidL2W7sZRKt0wzDniDxOTeQVNVhRGf2eFfx37ZoAA75f3YA5VhMNE3uiz2/nnJrFiUt23shw4Q+IWI59OUnIPlbIjWom1bNWU1Z6SrLwMYPbC41hm90JdNywcwuKgrCoqQUxKvVr9yQ=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0644.eurprd08.prod.outlook.com (10.163.188.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 10:19:08 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 10:19:08 +0000
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
Subject: [PATCH v1 3/9] drm/komeda: Build komeda to be a platform module
Thread-Topic: [PATCH v1 3/9] drm/komeda: Build komeda to be a platform module
Thread-Index: AQHUjIP1iY+4fnPb90m6yEcpImAldA==
Date:   Wed, 5 Dec 2018 10:19:07 +0000
Message-ID: <20181205101635.7696-4-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0644;6:fwldTyI6FxHDS6DXE4g1d5RhpOqsGMSIWEeLO/oZa+a9ogk1kIYfH0zh5pCu22NSF0ZH9OMNjyrL4RE6cePu2uemXh5WexGBB0U1VN16GrfGT7tPOt0hkAWWOalhV/WDJrzMzd+SB5sRaxGuO8MSzWIvMVvBGfD/RLl3iXA7E1OjLyt70xQZs2oYflghzkyX0WG/9pnyH84t5i8ybX2GdyX32PoUNdjmafnQv9ZIQwWRl4DdGXZNdP25Zy7YgTaS3Qe6BZvJTks4ZKw+V7Owzui234u173GoskJb46ZT8SthB5/lr+cX/kK1DrDGKPy3qx+1KW7F9NUiwmCpUnIwAaASA0/ufJalC52OmL8XNP4EE+BP4J/VbVHM03tDEpyFHdwaWjiAKb7fygYdvoKKs65GqA5dlIzbQSCb2oaC3LTjxpqq34Gh2JKArtGz5Gym3wH+vVLJ5pvDy8Ivl2xMjw==;5:PnGcW5nJX/stsW30oduR91f+SCCRSa9ccr2grICjYrewdo0uYF9dlUY4dCJDMia+k4ZpuhXEmcsBvsBvjRdn7uT2QamsofOkMMY5/q0baopsZs+zv5rNf6qxJNwlIxDGZyShjTSKCq+rX7c4h2nQkw6U9qhQ4XxfVZZIzS79oec=;7:zxf0QL9vWddfK7NHnw07Qsg3JBEnynSmNgjHzFXeeJ060r+WNfonLS5jyHIJSbd74pR4g4TqRMlLhjHGA+mMY56zvjWacNjJNWw6te3KYSJ3X4qApudTk38XGkCE9Zxv9HkfU31N8OzZOEM3pO/ZlA==
x-ms-office365-filtering-correlation-id: 6e12f61a-9fab-45be-11e3-08d65a9b1742
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0644;
x-ms-traffictypediagnostic: AM3PR08MB0644:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0644432C5C7CA13D11012767B3A80@AM3PR08MB0644.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0644;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0644;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(189003)(199004)(305945005)(6506007)(55236004)(8676002)(2906002)(6636002)(5660300001)(68736007)(102836004)(575784001)(86362001)(71200400001)(71190400001)(66066001)(386003)(36756003)(1076002)(3846002)(6116002)(26005)(256004)(186003)(14454004)(99286004)(486006)(11346002)(6436002)(476003)(446003)(6486002)(6862004)(4326008)(6512007)(53936002)(76176011)(478600001)(103116003)(52116002)(37006003)(8936002)(105586002)(106356001)(54906003)(2616005)(97736004)(25786009)(316002)(81156014)(81166006)(7736002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0644;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X0H7Sk+0Gfyq7ayLtU5Ll7b4i2qqAb4o0DDkgtDdjMk0mSME4kLupMVLfgwa6gFVtyYQbQsADsxalukoCDIB9CzBdSuJPVEJY/WFpVCsN0I+tdyoSwXOO8mGw6C56A6fwGueDe10s16fsGfrypgKBowzGYRhI/4lywp3vPovhA9J3DYd5gqKbCd4hb0HxdSTHHeSdr02SPhu510YLKiLoWd+L8OEX7ydf2orwVCa4d1HjHn39D1VXcS7FIPkR+I4TXy5S/KpEieeXgcaGHkpvucTSHaVDoTWRSQwjWw3BrHBzeppWDgnkaPXwwDHVsIRPE3Ol74xp6fyTltG1SdrZHsxLRO7wLFqCw2CSme4504=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e12f61a-9fab-45be-11e3-08d65a9b1742
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 10:19:07.9983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a simple wrapper for platform module to build komeda to module,
Also add a very simple D71 layer code to show how to discover a product.
Komeda driver direct bind the product ENTRY function xxx_identity to DT
compatible name like:

d71_product =3D {
	.product_id =3D MALIDP_D71_PRODUCT_ID,
	.identify =3D d71_identify,
},

const struct of_device_id komeda_of_match[] =3D {
	{ .compatible =3D "arm,mali-d71", .data =3D &d71_product, },
	{},
};

Then when linux found a matched DT node and call driver to probe, we can
easily get the of data, and call into the product to do the identify:

komeda_bind()
{
    ...
    product =3D of_device_get_match_data(dev);

    product->identify();
    ...
}

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../gpu/drm/arm/display/include/malidp_io.h   |  42 ++++++
 drivers/gpu/drm/arm/display/komeda/Makefile   |   6 +-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  |  33 +++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |   4 +-
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 132 ++++++++++++++++++
 5 files changed, 215 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/display/include/malidp_io.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_drv.c

diff --git a/drivers/gpu/drm/arm/display/include/malidp_io.h b/drivers/gpu/=
drm/arm/display/include/malidp_io.h
new file mode 100644
index 000000000000..4fb3caf864ce
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/include/malidp_io.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#ifndef _MALIDP_IO_H_
+#define _MALIDP_IO_H_
+
+#include <linux/io.h>
+
+static inline u32
+malidp_read32(u32 __iomem *base, u32 offset)
+{
+	return readl((base + (offset >> 2)));
+}
+
+static inline void
+malidp_write32(u32 __iomem *base, u32 offset, u32 v)
+{
+	writel(v, (base + (offset >> 2)));
+}
+
+static inline void
+malidp_write32_mask(u32 __iomem *base, u32 offset, u32 m, u32 v)
+{
+	u32 tmp =3D malidp_read32(base, offset);
+
+	tmp &=3D (~m);
+	malidp_write32(base, offset, v | tmp);
+}
+
+static inline void
+malidp_write_group(u32 __iomem *base, u32 offset, int num, const u32 *valu=
es)
+{
+	int i;
+
+	for (i =3D 0; i < num; i++)
+		malidp_write32(base, offset + i * 4, values[i]);
+}
+
+#endif /*_MALIDP_IO_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/=
arm/display/komeda/Makefile
index 07b5965f3808..4efcce0cdce8 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -5,7 +5,11 @@ ccflags-y :=3D \
 	-I$(src)
=20
 komeda-y :=3D \
+	komeda_drv.o \
 	komeda_dev.o \
-	komeda_pipeline.o \
+	komeda_pipeline.o
+
+komeda-y +=3D \
+	d71/d71_dev.o
=20
 obj-$(CONFIG_DRM_KOMEDA) +=3D komeda.o
\ No newline at end of file
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
new file mode 100644
index 000000000000..af3dabb499cd
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#include "malidp_io.h"
+#include "komeda_dev.h"
+
+static int d71_enum_resources(struct komeda_dev *mdev)
+{
+	/* TODO add enum resources */
+	return -1;
+}
+
+static struct komeda_dev_funcs d71_chip_funcs =3D {
+	.enum_resources	=3D d71_enum_resources,
+	.cleanup	=3D NULL,
+};
+
+#define GLB_ARCH_ID		0x000
+#define GLB_CORE_ID		0x004
+#define GLB_CORE_INFO		0x008
+
+struct komeda_dev_funcs *
+d71_identify(u32 __iomem *reg_base, struct komeda_chip_info *chip)
+{
+	chip->arch_id	=3D malidp_read32(reg_base, GLB_ARCH_ID);
+	chip->core_id	=3D malidp_read32(reg_base, GLB_CORE_ID);
+	chip->core_info	=3D malidp_read32(reg_base, GLB_CORE_INFO);
+
+	return &d71_chip_funcs;
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 25c79528dac4..680e3e2cf100 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -12,7 +12,6 @@
 #include "komeda_pipeline.h"
 #include "malidp_product.h"
=20
-
 /* malidp device id */
 enum {
 	MALI_D71 =3D 0,
@@ -93,6 +92,9 @@ komeda_product_match(struct komeda_dev *mdev, u32 target)
 	return MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id) =3D=3D target;
 }
=20
+struct komeda_dev_funcs *
+d71_identify(u32 __iomem *reg, struct komeda_chip_info *chip);
+
 struct komeda_dev *komeda_dev_create(struct device *dev);
 void komeda_dev_destroy(struct komeda_dev *mdev);
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
new file mode 100644
index 000000000000..bf32d334d20d
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/component.h>
+#include <drm/drm_of.h>
+#include "komeda_dev.h"
+
+struct komeda_drv {
+	struct komeda_dev *mdev;
+};
+
+static void komeda_unbind(struct device *dev)
+{
+	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
+
+	dev_set_drvdata(dev, NULL);
+
+	if (mdrv =3D=3D NULL)
+		return;
+
+	komeda_dev_destroy(mdrv->mdev);
+	kfree(mdrv);
+}
+
+static int komeda_bind(struct device *dev)
+{
+	struct komeda_drv *mdrv;
+	int err;
+
+	mdrv =3D kzalloc(sizeof(*mdrv), GFP_KERNEL);
+	if (mdrv =3D=3D NULL)
+		return -ENOMEM;
+
+	mdrv->mdev =3D komeda_dev_create(dev);
+	if (IS_ERR(mdrv->mdev)) {
+		err =3D PTR_ERR(mdrv->mdev);
+		goto free_mdrv;
+	}
+
+	dev_set_drvdata(dev, mdrv);
+
+	return 0;
+
+free_mdrv:
+	kfree(mdrv);
+	return err;
+}
+
+static const struct component_master_ops komeda_master_ops =3D {
+	.bind	=3D komeda_bind,
+	.unbind	=3D komeda_unbind,
+};
+
+static int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node =3D=3D data;
+}
+
+static void komeda_add_slave(struct device *master,
+			     struct component_match **match,
+			     struct device_node *np, int port)
+{
+	struct device_node *remote;
+
+	remote =3D of_graph_get_remote_node(np, port, 0);
+	if (remote !=3D NULL) {
+		drm_of_component_match_add(master, match, compare_of, remote);
+		of_node_put(remote);
+	}
+}
+
+static int komeda_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct component_match *match =3D NULL;
+	struct device_node *child;
+
+	if (dev->of_node =3D=3D NULL)
+		return -ENODEV;
+
+	for_each_available_child_of_node(dev->of_node, child) {
+		if (of_node_cmp(child->name, "pipeline") !=3D 0)
+			continue;
+
+		/* add connector */
+		komeda_add_slave(dev, &match, child, KOMEDA_OF_PORT_OUTPUT);
+	}
+
+	return component_master_add_with_match(dev, &komeda_master_ops, match);
+}
+
+static int komeda_platform_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &komeda_master_ops);
+	return 0;
+}
+
+static const struct komeda_product_data komeda_products[] =3D {
+	[MALI_D71] =3D {
+		.product_id =3D MALIDP_D71_PRODUCT_ID,
+		.identify =3D d71_identify,
+	},
+};
+
+const struct of_device_id komeda_of_match[] =3D {
+	{ .compatible =3D "arm,mali-d71", .data =3D &komeda_products[MALI_D71], }=
,
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, komeda_of_match);
+
+static struct platform_driver komeda_platform_driver =3D {
+	.probe	=3D komeda_platform_probe,
+	.remove	=3D komeda_platform_remove,
+	.driver	=3D {
+		.name =3D "komeda",
+		.of_match_table	=3D komeda_of_match,
+		.pm =3D NULL,
+	},
+};
+
+module_platform_driver(komeda_platform_driver);
+
+MODULE_AUTHOR("James.Qian.Wang <james.qian.wang@arm.com>");
+MODULE_DESCRIPTION("Komeda KMS driver");
+MODULE_LICENSE("GPL v2");
--=20
2.17.1

