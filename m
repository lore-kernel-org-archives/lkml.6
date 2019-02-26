Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8866C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9395F217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ljE4mucP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfBZKxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:53:36 -0500
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:31278
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727342AbfBZKxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZpziB1cdnScQ2sTd5HNk7xXpgrLoJqOnGewX0Xv8Ms=;
 b=ljE4mucPbhDUXxE48wf0AovveB97wqtkarRTOcb7mx5kzS9jdeV97+9csGFuocoZkMCOSnQZIe4sE5NuE7qn0sg90VhPLUGcA3WkfQ5k/OX4dZ0BTJm/hW3MaR6/FTFcWn4izeWXZXSiHcaShWQWKPMo02T1UkmsHgMGIno5yJI=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5233.eurprd04.prod.outlook.com (20.177.40.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 26 Feb 2019 10:53:28 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 10:53:27 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Chris Spencer <spencercw@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, Abel Vesa <abelvesa@linux.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Topic: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Index: AQHUzcGB6LodUxnT8UyD0+K7eGuy3g==
Date:   Tue, 26 Feb 2019 10:53:27 +0000
Message-ID: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR04CA0005.eurprd04.prod.outlook.com
 (2603:10a6:206:1::18) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f58e806c-7906-4e69-f0a3-08d69bd8a360
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5233;
x-ms-traffictypediagnostic: AM0PR04MB5233:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5233;23:KGx72z1r/1ooPLR1BkxwjcLofHhCTv1WhHzFv5t?=
 =?iso-8859-1?Q?JK3JNUs8Yvg3jZwUlpGPw6ZJ8nqNv8CIwvJWZ/5pnVMxuEQWFqwchWadjv?=
 =?iso-8859-1?Q?N7krpYEyIDgKnpaJqcSuN4MbU/zme2gM9INGwmigrKXa6BQAKWh5oe9XC7?=
 =?iso-8859-1?Q?JZQMVl3J9aLbASiDa7bvMWQ8BFSa4MDE8guHY3EuZSSIdfAbod0WAQe+eH?=
 =?iso-8859-1?Q?Wd9pIIjo+oloYOCYsYAPL+6n+5WN1CrF4Eu0s9k3ezzToxj5TNQ3X6n6NN?=
 =?iso-8859-1?Q?s1xfbThcXAo79Pi7Jdjw57tUVwyWOx4TIDQcPqIMAo248kscVVdNwF21Da?=
 =?iso-8859-1?Q?k5Qwv3NMVRvAO6AndkYzDioo4f/wL+YuWsAoHm8jGJob1Y+QckIzLWfs4l?=
 =?iso-8859-1?Q?fLAoQa2ZIKYbdZwu6bHU+Ppn+T7u/TPLDY0Ng+FL27RQjTFixQyI83I1s6?=
 =?iso-8859-1?Q?0uJ334dhEI3O3vmCoT9DQZk0eYhGdex9F7wLQTnSV4y5i8S0g9NHar43Om?=
 =?iso-8859-1?Q?wvAuHDxfiKAyoqGZnSpcmArH/X7sVj21DSolS+90MZhlyPFoko39z9z0jt?=
 =?iso-8859-1?Q?RWTNDEkeEDiYc2AI/AOErGsfec2R4q8Dt+QpdDmn3b9D+lhzQ7FCz7W6+/?=
 =?iso-8859-1?Q?3zCTo4Yz/n8YX6bu/kKHQTYLptil7Tqf+HcNHJgY9GeHHWpqGRyhopDv0P?=
 =?iso-8859-1?Q?D6gS+Vf9kgZuUha3fl408Mhyu2dUUxzXppwHw0cMr6wQHJvVbgTgvL8ZnC?=
 =?iso-8859-1?Q?Tg3ZMqBHMOOUx6J2Upo7Y3teh3DJR8yfHkzrMD72JO4Z3Kifr48InIoqrJ?=
 =?iso-8859-1?Q?lksU28Q1mgsd6+y2+OykKttKwwiTgED3ToinoJW1TWkoGPylFECh22MFyV?=
 =?iso-8859-1?Q?dfCRWx1+OXw9HySgnXdvFrPhrGPbnyMx8jzw/J0nosnjTiVu5Z8G4DvdWp?=
 =?iso-8859-1?Q?WN0BDj5wh1avtq9S9MRkC2TKOx4DAPAfgU6cP8dqHf9K5+SVJt8JnPUMZJ?=
 =?iso-8859-1?Q?+pK2E9lB5BL2vtxKWA52FhevwVJxBSh+O/mNDQW5PAqPRiDkxPAtwbyaBW?=
 =?iso-8859-1?Q?o70MTHy6caVJHOQWDdUWFMMoWhyamiPGDZN1PytYYQJo2LfSuSWVtH3KMp?=
 =?iso-8859-1?Q?V9/4t5ZQzcFL54Re5i5zZlTimTnl4SkmoraIJOiIRgWkW6+sJk7eNYA8Jw?=
 =?iso-8859-1?Q?1icuWYJ/pSKH2cpx930ceCwrdpLb9T1ui4w/7WZACxEZ6jAzbgiOv8=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB52330B63D62B4302D31EE1AFF67B0@AM0PR04MB5233.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(366004)(199004)(189003)(66066001)(5660300002)(52116002)(99286004)(6506007)(386003)(106356001)(71190400001)(71200400001)(256004)(14454004)(102836004)(14444005)(50226002)(478600001)(6116002)(4326008)(6486002)(3846002)(25786009)(86362001)(36756003)(105586002)(305945005)(68736007)(2616005)(110136005)(53936002)(476003)(6512007)(81156014)(486006)(8936002)(8676002)(7736002)(81166006)(6436002)(97736004)(186003)(26005)(54906003)(2906002)(316002)(44832011)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5233;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rJmY7FgsPZq2a1RezvB2yxWn5Gl4wGdwB2ZPbn0x4Gi4JFD6jLBrCq7bwiSueCC4NnYMwT+T1/b3YQUeQKzzWCoZc1fbz4zs3gQOl8yHH+XoKffmIHJnjSSbZ60T3UBUBFi/h7LADurfalIlqC1Jp3WtdpJPslzWTudYN59UZWkBA4vGtd0qgrXg6qAJswySvDgF12aUIVYZFICKDpP7mIOGsxUJTWjnstfSN5A25xC01wiJzHiUnkA4S8c5Mz2tg1xb8ptab0XqMAojlsFyjui/YargYqIXU4R4Y60/7JBD4twOH+hAM8tk5aZHSWB6VrvqPmm6bacJCS38mjjW0tjtGjCzN9Trlse5HXStTTFLgQLGa3WhERRpVinlGlCqEzSGuB4zF4b/1ZNXXE/mdzo+0qWGmVfADr97ICl7TAk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58e806c-7906-4e69-f0a3-08d69bd8a360
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 10:53:26.9920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5233
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic i.MX8 SoC driver along with the i.MX8MQ SoC specific code.
For now, only i.MX8MQ revision B1 is supported. For any other, i.MX8MQ
revision it will print 'unknown'.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

Changes since v1:                                                          =
 =20
 * added the of_node_put on free_soc failure as suggested by Stefan Agner.
 * made imx8mq_soc_data const as suggested by Stefan Agner.
 * also made the imx8mq_soc_data static
 * marked imx8mq_soc_revision as __init
 * changed the revision read-out from anatop to ocotp since the rev B1
   is specified in there. For now, for i.MX8MQ only revision B1 is supporte=
d.
   For any other revision, it will print the revision as unknown.

 drivers/soc/imx/Makefile   |   1 +
 drivers/soc/imx/soc-imx8.c | 115 +++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 116 insertions(+)
 create mode 100644 drivers/soc/imx/soc-imx8.c

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 506a6f3..d6b529e0 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
+obj-$(CONFIG_ARCH_MXC) +=3D soc-imx8.o
diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
new file mode 100644
index 0000000..fc6429f
--- /dev/null
+++ b/drivers/soc/imx/soc-imx8.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#define REV_B1				0x21
+
+#define IMX8MQ_SW_INFO_B1		0x40
+#define IMX8MQ_SW_MAGIC_B1		0xff0055aa
+
+struct imx8_soc_data {
+	char *name;
+	u32 (*soc_revision)(void);
+};
+
+static u32 __init imx8mq_soc_revision(void)
+{
+	struct device_node *np;
+	void __iomem *ocotp_base;
+	u32 magic;
+	u32 rev =3D 0;
+
+	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
+	if (!np)
+		goto out;
+
+	ocotp_base =3D of_iomap(np, 0);
+	WARN_ON(!ocotp_base);
+
+	magic =3D readl_relaxed(ocotp_base + IMX8MQ_SW_INFO_B1);
+	if (magic =3D=3D IMX8MQ_SW_MAGIC_B1)
+		rev =3D REV_B1;
+
+	iounmap(ocotp_base);
+
+out:
+	of_node_put(np);
+	return rev;
+}
+
+static const struct imx8_soc_data imx8mq_soc_data =3D {
+	.name =3D "i.MX8MQ",
+	.soc_revision =3D imx8mq_soc_revision,
+};
+
+static const struct of_device_id imx8_soc_match[] =3D {
+	{ .compatible =3D "fsl,imx8mq", .data =3D &imx8mq_soc_data, },
+	{ }
+};
+
+#define imx8_revision(soc_rev) \
+	soc_rev ? \
+	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
+	"unknown"
+
+static int __init imx8_soc_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	struct device_node *root;
+	const struct of_device_id *id;
+	u32 soc_rev =3D 0;
+	const struct imx8_soc_data *data;
+	int ret;
+
+	soc_dev_attr =3D kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENODEV;
+
+	soc_dev_attr->family =3D "Freescale i.MX";
+
+	root =3D of_find_node_by_path("/");
+	ret =3D of_property_read_string(root, "model", &soc_dev_attr->machine);
+	if (ret)
+		goto free_soc;
+
+	id =3D of_match_node(imx8_soc_match, root);
+	if (!id)
+		goto free_soc;
+
+	of_node_put(root);
+
+	data =3D id->data;
+	if (data) {
+		soc_dev_attr->soc_id =3D data->name;
+		if (data->soc_revision)
+			soc_rev =3D data->soc_revision();
+	}
+
+	soc_dev_attr->revision =3D imx8_revision(soc_rev);
+	if (!soc_dev_attr->revision)
+		goto free_soc;
+
+	soc_dev =3D soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev))
+		goto free_rev;
+
+	return 0;
+
+free_rev:
+	kfree(soc_dev_attr->revision);
+free_soc:
+	kfree(soc_dev_attr);
+	of_node_put(root);
+	return -ENODEV;
+}
+device_initcall(imx8_soc_init);
--=20
2.7.4

