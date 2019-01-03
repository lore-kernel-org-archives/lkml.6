Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F33C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8109320578
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="asVc3OGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbfACLk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:40:28 -0500
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:14649
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbfACLk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpk1Pt79/nDF88pAdiga4kSi4xlmfWUWjZ8A+hrtrds=;
 b=asVc3OGBLHkR0jVofM69wTALhl7Q5YHdEaiX5pyhl1rpYDSaqXVkpJqosQgjlx/sy5fKFkvZ5eMCidT90qWbDzCNlhwTdREyjDBcxTqz7yOT38jwYK/7YzZSIfDZsf8MhTMd30x42uabuPEe2+7Q4vN/BQs5iTrmHRpMrVWfKUk=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0659.eurprd08.prod.outlook.com (10.163.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 11:40:22 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 11:40:22 +0000
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
Subject: [PATCH v4 3/9] drm/komeda: Build komeda to be a platform module
Thread-Topic: [PATCH v4 3/9] drm/komeda: Build komeda to be a platform module
Thread-Index: AQHUo1kcnxKiZ75woEmWpeJJkQUkQA==
Date:   Thu, 3 Jan 2019 11:40:21 +0000
Message-ID: <20190103113841.15403-4-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0659;6:iOymrVD63onZZZ728560XLzo4xnDqVTMfzGa8z4HfURe2lE7LYejf/TtfJUsYXCIQsRw5r+mt3q6k/TaQ3vbeCN6Al/SyYQvfjmys9s9X7NJQ0SlLH1L9YyMqZmxDPK7OK7F+I5YiJ0+qN/mP9pOMOVn9Vb8rd5QBrKZ6Ykw8+4wI++pDaGYOpMh4CyvekcwKo0Hsm2YeLpWNjqbbRbf8wGIr6Vut6wsPrgQWk1Mvcabj7V0QAQgeUfEO7Q/bVO9gY2CNbwd5GOvp9Huvl7GhyQWUKUFGPPcYIX7yt7wZtwVqASnjYNy0AZjzwj6i86LncJ+XX6g5FQ6RQCP/Ls9o1JceIANbyIc9iJ0qko5dCrt7LT3oTahrQ1fozjiwO2Kc5XWsfYfzmd4B5YvVDBvyZINfe6/jP6c+3n8OXoj+86b44iQumc8LVIcgcZ1jwV9R3GuNeCLfvdOFrxwXP8/Fg==;5:to1f7/DAv3yxzsVXzECQEKIFtA8lUcmhp2i9kxiDhfqyzWXJyVX4r3a0/HBcrKLwfeuoptVGxnWUDYjcklu5+o3tpr7fRqbemrWQAXpGqZ2bvkE5RXqjQqJpnVT3tkr2f6YigINDTBjQT5IUWiupYF4xFZiuxu+2siFIq0RAx1B3JrC9+tBn/lDZsOGvzenox4QV6hYlGjNjDQT5wrNRhg==;7:82TVA11V1uA9hOUifX6ZskKe29yOdgPQdJX6ODlqY4a3g3kUINUXxGhncxzKoG4cl/NQPfKeWX3IueVKyIjpyqMzM2ekqJjZgJl1tN2zhnmlcbbnpoxB+B5c68d4b3yutEwa+CB7pPSQwROm9svP7Q==
x-ms-office365-filtering-correlation-id: 8a62ddd5-4a8d-4007-264c-08d671703e50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0659;
x-ms-traffictypediagnostic: AM3PR08MB0659:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0659D66FC92D5B18996A51B5B38D0@AM3PR08MB0659.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0659;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0659;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(396003)(136003)(189003)(199004)(575784001)(76176011)(53936002)(52116002)(25786009)(106356001)(4326008)(316002)(103116003)(386003)(6506007)(55236004)(71190400001)(102836004)(26005)(2616005)(476003)(446003)(11346002)(7736002)(1076003)(14454004)(256004)(66066001)(14444005)(478600001)(305945005)(110136005)(8936002)(99286004)(81156014)(54906003)(81166006)(68736007)(8676002)(36756003)(5660300001)(6486002)(6436002)(2501003)(6512007)(105586002)(97736004)(486006)(3846002)(6116002)(86362001)(186003)(2906002)(7416002)(71200400001)(2201001)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0659;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6VXIM06rfG8zgwR/rldxzP5ddDdeE3H2T/hJJm2jXgF0TzuKcbGtXrFdDjSHoulXh+lZYYwPfElav22U2p8mk6kaHawmStpE10m9pciEJof/f7rX2DQp+2OLFXNMu/1kCW0YhFAmc8oRdBqnlf5C4hfiZ9lPJN8Y2pUerDy94qnPbQztAC4cZhh6YCHGPD4OTxmg2KoExNue9rBlnqz4rFGozqZXwsFt2BcVgvllCEIyAOFtPjTy/NJI9rgo/JS9GZ3b2BOfGCqB/VvrfDIOM6uB3w7tlhJXSB192Kykiz3Ql2+LAIk9OwiS/Q+pZ2Qr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a62ddd5-4a8d-4007-264c-08d671703e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 11:40:21.9032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

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

Changes in v4:
- Replaced kzalloc with devm_kzalloc

Changes in v3:
- Fixed style problem found by checkpatch.pl --strict.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
---
 .../gpu/drm/arm/display/include/malidp_io.h   |  42 ++++++
 drivers/gpu/drm/arm/display/komeda/Makefile   |   6 +-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  |  33 +++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |   3 +
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 132 ++++++++++++++++++
 5 files changed, 215 insertions(+), 1 deletion(-)
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
index 5b44e36509b1..c03d6876ef75 100644
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
index 03b8703736c2..b48d711071be 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -92,6 +92,9 @@ komeda_product_match(struct komeda_dev *mdev, u32 target)
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
index 000000000000..dd386d82d143
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
+	if (!mdrv)
+		return;
+
+	komeda_dev_destroy(mdrv->mdev);
+
+	dev_set_drvdata(dev, NULL);
+	devm_kfree(dev, mdrv);
+}
+
+static int komeda_bind(struct device *dev)
+{
+	struct komeda_drv *mdrv;
+	int err;
+
+	mdrv =3D devm_kzalloc(dev, sizeof(*mdrv), GFP_KERNEL);
+	if (!mdrv)
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
+	devm_kfree(dev, mdrv);
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
+	if (remote) {
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
+	if (!dev->of_node)
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

