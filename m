Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AF8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E48B2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XRvMnwSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfAVLMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:12:00 -0500
Received: from mail-eopbgr10072.outbound.protection.outlook.com ([40.107.1.72]:25318
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727845AbfAVLMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoECVy3FyKeJtq/adhuyZ/+h24OUWt926HhhjKc+keM=;
 b=XRvMnwSw4U3qIYf69geAYiDsg+MtFK+gbFlu9oG5Ae1Iz957yRqgtJdM9Xi3tdOJ229bIIGw+a8jTxYrt7v6DvSZ5YVtEHcHsXOVCf84MydU5/528s/jx4sw9q7taBOMOryYQjrAI78CeFBA8IwFgacxAanBIPERxjqx9/jD1ac=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1352.eurprd08.prod.outlook.com (10.168.11.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 11:11:53 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:11:53 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 10/11] drm/komeda: Add sysfs attribute: core_id and
 config_id
Thread-Topic: [PATCH v2 10/11] drm/komeda: Add sysfs attribute: core_id and
 config_id
Thread-Index: AQHUskNHnZZz5PyQ/k2C8sILEn4p3w==
Date:   Tue, 22 Jan 2019 11:11:53 +0000
Message-ID: <20190122110932.5138-11-james.qian.wang@arm.com>
References: <20190122110932.5138-1-james.qian.wang@arm.com>
In-Reply-To: <20190122110932.5138-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYAPR01CA0034.ausprd01.prod.outlook.com (2603:10c6:1:1::22)
 To DB6PR0801MB1990.eurprd08.prod.outlook.com (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1352;6:s9kD5ACpBgEuhDAZAyMFC2i3SaiHrPH3HmYNeRwiKkxpGu0O8dMG5G214hLhoqz4zuf58nQo450dkbdOa8MBo12jPeOvN3BbXBZuxDTrZ7jJXStRQ5bFy7hDNvIkdbb1jbgSCUpYJPgiDZiMusRajuHSIvpMehnGebv8fcPi0X4J9kHr5CfEZQa1NQ9vhJDa6bz3LAs7eUpJSqQkq/vO1eJ8pUbgTuDvwEPPnjNJfjd+rbkQQBVrj5MwIsWzKxgxGKFzd+6OEROI9rBN/IY0T68SUw1f5QWyrhyH+UUVNk9Kw/HpVlAOVe/MY9Q0F3qNdljlxdmLkfrioFkABOTeboV+QzTf3sIlvUo3K725h8O+2NhfUsae0v5fXD1s+2PbQI9P1/VxvqAHkliZuLP4EczpzjflzQuTX/bRKGJVmB77cFwOwQMSMEx8MmqvQeyMfNI6/YMkK41omY9qSu4eYQ==;5:uK1YuvDBM31C6m///u4zFBSiIoag4hmdXx2wCdsz0QODErVKTw4cDRlE8/LUrbhKSoFo3ld+RLcj9N1O2i1f8UaovtZ7C2r1RuWyU5FBNbzz33ygRtcBIa6cjZzRPBrYDwdlTH1vjomARvDp2VHQ3l5LmFONCWwBD1bRz4koX0OzdJ0hRSErJZGKLEo7TTmZabzY8kBa7u6X/C0JyDZkvw==;7:Rt8HPA91k6a350ZKyRkwzHkpKbZZDcSHGJgJbtDgOfVU+ABlqC1PovXm4lqBIY6b0wQxr5nZX20/8VCtZYdk9PbwLRYUeSL2VDTLLxxayMXzc6rlPYA76NCrUonFxjwXKvhQncdcKEeBbc5BRRMyCg==
x-ms-office365-filtering-correlation-id: 2dcfaa57-e7a6-4330-7d73-08d6805a69dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1352;
x-ms-traffictypediagnostic: DB6PR0801MB1352:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1352F55AEB927E834E2965C1B3980@DB6PR0801MB1352.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(446003)(26005)(76176011)(71200400001)(103116003)(2501003)(81156014)(81166006)(36756003)(6486002)(99286004)(97736004)(54906003)(110136005)(6506007)(386003)(6436002)(102836004)(3846002)(2906002)(6116002)(478600001)(305945005)(186003)(256004)(14454004)(71190400001)(316002)(1076003)(55236004)(11346002)(52116002)(53936002)(66066001)(25786009)(6512007)(486006)(8676002)(86362001)(7736002)(476003)(4326008)(2616005)(105586002)(106356001)(6636002)(8936002)(50226002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1352;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R84cdJAJJrgUOHSs/LJ7KgLlm2V9kGlJEb/bBKrIL6yneust0tyYoH8mWLg67B4xTvizYY56EYbv+Q3ZJXgI89sU1GZHUQseNtD7AHCuC/ADIKDTBabiZG+38qzrTkFEMeENabiNRi0p6RX8cvIh0QuiZ7oIU5npY9lnXNz1b0TzfHasUzOgF5BRVZHgpi1jTICaieAJ6ll0QNyY54dNcEQIUGyUTYmMy7gy9C5RfKWos/9YjQKd6/fK9lZgiUoBru4a8vhcPw0dv9QRGuF6B1gESHMhVC1DJ0JjfE6OHGL7zC0pXHoCfjXYH/tp7/5VhTQ7cnZxHopCrW76URgYl1/A50hJGJ8tqk6RHyZjr1rhb99P07rLLdukSX/wTdKwXOAwMvt3xIPjnA9Lnr3UcKyECINbtk+Bwp/0vC5vPHI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcfaa57-e7a6-4330-7d73-08d6805a69dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:11:45.0100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

Add two sysfs node: core_id, config_id, user can read them to fetch the
HW product information.

v2: Rebase

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../drm/arm/display/include/malidp_product.h  | 12 +++++
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 48 +++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  2 +
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |  7 +++
 4 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drivers=
/gpu/drm/arm/display/include/malidp_product.h
index b35fc5db866b..1053b11352eb 100644
--- a/drivers/gpu/drm/arm/display/include/malidp_product.h
+++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
@@ -20,4 +20,16 @@
 /* Mali-display product IDs */
 #define MALIDP_D71_PRODUCT_ID   0x0071
=20
+union komeda_config_id {
+	struct {
+		__u32	max_line_sz:16,
+			n_pipelines:2,
+			n_scalers:2, /* number of scalers per pipeline */
+			n_layers:3, /* number of layers per pipeline */
+			n_richs:3, /* number of rich layers per pipeline */
+			reserved_bits:6;
+	};
+	__u32 value;
+};
+
 #endif /* _MALIDP_PRODUCT_H_ */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 7152f2c08e01..9e017ce89d69 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -53,6 +53,46 @@ static void komeda_debugfs_init(struct komeda_dev *mdev)
 			    mdev, &komeda_register_fops);
 }
=20
+static ssize_t
+core_id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct komeda_dev *mdev =3D dev_to_mdev(dev);
+
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n", mdev->chip.core_id);
+}
+static DEVICE_ATTR_RO(core_id);
+
+static ssize_t
+config_id_show(struct device *dev, struct device_attribute *attr, char *bu=
f)
+{
+	struct komeda_dev *mdev =3D dev_to_mdev(dev);
+	struct komeda_pipeline *pipe =3D mdev->pipelines[0];
+	union komeda_config_id config_id =3D {0,};
+	int i;
+
+	config_id.max_line_sz =3D pipe->layers[0]->hsize_in.end;
+	config_id.n_pipelines =3D mdev->n_pipelines;
+	config_id.n_scalers =3D pipe->n_scalers;
+	config_id.n_layers =3D pipe->n_layers;
+	config_id.n_richs =3D 0;
+	for (i =3D 0; i < pipe->n_layers; i++) {
+		if (pipe->layers[i]->layer_type =3D=3D KOMEDA_FMT_RICH_LAYER)
+			config_id.n_richs++;
+	}
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n", config_id.value);
+}
+static DEVICE_ATTR_RO(config_id);
+
+static struct attribute *komeda_sysfs_entries[] =3D {
+	&dev_attr_core_id.attr,
+	&dev_attr_config_id.attr,
+	NULL,
+};
+
+static struct attribute_group komeda_sysfs_attr_group =3D {
+	.attrs =3D komeda_sysfs_entries,
+};
+
 static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_nod=
e *np)
 {
 	struct komeda_pipeline *pipe;
@@ -201,6 +241,12 @@ struct komeda_dev *komeda_dev_create(struct device *de=
v)
 		goto err_cleanup;
 	}
=20
+	err =3D sysfs_create_group(&dev->kobj, &komeda_sysfs_attr_group);
+	if (err) {
+		DRM_ERROR("create sysfs group failed.\n");
+		goto err_cleanup;
+	}
+
 #ifdef CONFIG_DEBUG_FS
 	komeda_debugfs_init(mdev);
 #endif
@@ -218,6 +264,8 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
 	struct komeda_dev_funcs *funcs =3D mdev->funcs;
 	int i;
=20
+	sysfs_remove_group(&dev->kobj, &komeda_sysfs_attr_group);
+
 #ifdef CONFIG_DEBUG_FS
 	debugfs_remove_recursive(mdev->debugfs_root);
 #endif
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 8acd25afb3e9..0c3e32b596d9 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -190,4 +190,6 @@ d71_identify(u32 __iomem *reg, struct komeda_chip_info =
*chip);
 struct komeda_dev *komeda_dev_create(struct device *dev);
 void komeda_dev_destroy(struct komeda_dev *mdev);
=20
+struct komeda_dev *dev_to_mdev(struct device *dev);
+
 #endif /*_KOMEDA_DEV_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index 2bdd189b041d..0285fd37a016 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -17,6 +17,13 @@ struct komeda_drv {
 	struct komeda_kms_dev *kms;
 };
=20
+struct komeda_dev *dev_to_mdev(struct device *dev)
+{
+	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
+
+	return mdrv ? mdrv->mdev : NULL;
+}
+
 static void komeda_unbind(struct device *dev)
 {
 	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
--=20
2.17.1

