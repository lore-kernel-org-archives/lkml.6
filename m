Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC40C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EC521721
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RbkE1lMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbeLXJ1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:27:11 -0500
Received: from mail-eopbgr30047.outbound.protection.outlook.com ([40.107.3.47]:62941
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbeLXJ1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d89qWePTyL4F2O/jeM/8v9hcHzBqgaWV4fxELVMmFFM=;
 b=RbkE1lMW6FfZO06BU6nJ57gD3R/EzPvo3Wtr5Dq1aIU0kp8bL41mM7s4MGzoNhFwkspc9aKelZxREKUsmflRA68mDQqPkPmRfLTSMm6Zfy6JLgtzrjV1v5XRyorQqZdPc2tZPs5y6SCBiHEFc8FToua6CNSLdeTfFcSn31POa0w=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0262.eurprd08.prod.outlook.com (10.161.35.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Mon, 24 Dec 2018 09:27:04 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:27:04 +0000
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
Subject: [PATCH 10/11] drm/komeda: Add sysfs attribute: core_id and config_id
Thread-Topic: [PATCH 10/11] drm/komeda: Add sysfs attribute: core_id and
 config_id
Thread-Index: AQHUm2rVSC8YItxtCkemYJar1zQhNQ==
Date:   Mon, 24 Dec 2018 09:27:04 +0000
Message-ID: <20181224092435.2792-11-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0262;6:NsmyprQbkBpSwFJuQxytI6rBzUqbeIbgiKsOGQOohkDKjxKMjp7gsnr67+6ZpVj8xiTQZZG6zt5ODH09JpBwCSBKUWljW8fGvPXkTvvsF7plrz/5Ze3NDv0SNGejIjI/yaGV7jrfcHuYIh/VqKdjyFRUAZXgxKrH7ffhlY8MIZrXhFORqH7THjn+cemvt5/twgtZCFxh0Yx9T6cMvFoogG7e52VT+5qydxmB+xfNh1RkilYR2Gqi3XlV33dGc2OIpUmlT3gI6IxsjTN5fXJeUalDZ0bn/w8wsyu30172HLzobXNsNaxBTlTSyMA3jdpCkfJJfg2VidM6Tp7KYa0aGmL7+pgZF3mxQgZMZHP4tSzd8rfNsCNLnQtpUts7XhwhTgJqfoZKk6hGnhZG/BztA23+P7FRdwZ1Kga+fMmxcsO1lYUSUN5BkABwitoaiUERGLJoIMDBZ6pIz8oDM0acKg==;5:SIqV41OY/RVNfZOqEV+TOemjLnFwq+X7a6g5YvJpTw+hlixNGcVJzX+GcJprYwR7/gHK/plTHTvYa5gpQ3JXRXJBErbcFdAYtG6w+8BAZMOONDAV8mQhHxOnvCDew+/hbzpPqRw4i41bzj4YsOAoqNxvmVrNpQBHtk7r/YWR1Vc=;7:IApeMR0IHjS8QIyobFF/r97xBHrGMTJ7xsh9slIk4Vef17sIMGf+ibs5SfGRPB33/oBn738NoTyAg6GrWyzQTJcfAOdGIixQ3ppgRKWen95t6Pn3RIgZPGnuDgMPPJLyv88tWOOVkixJeKh1rJE8GA==
x-ms-office365-filtering-correlation-id: 99e338fc-c6f0-42c8-6f2c-08d66981f780
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0262;
x-ms-traffictypediagnostic: AM3PR08MB0262:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0262FA40F39CE085CE23A5B6B3BB0@AM3PR08MB0262.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0262;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0262;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39850400004)(346002)(199004)(189003)(4326008)(256004)(305945005)(53936002)(6862004)(71190400001)(71200400001)(486006)(7736002)(97736004)(446003)(2906002)(52116002)(6116002)(76176011)(1076003)(575784001)(6436002)(86362001)(6512007)(5660300001)(11346002)(186003)(26005)(68736007)(3846002)(2616005)(476003)(55236004)(386003)(102836004)(14444005)(6506007)(25786009)(103116003)(14454004)(105586002)(99286004)(54906003)(37006003)(6486002)(106356001)(316002)(8676002)(81166006)(81156014)(8936002)(6636002)(36756003)(478600001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0262;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 87aMnCfyDQr11mT38pWFJUyiW6lLoZAYhQGoilw4RNJhresRSBbreygvZFllcxKdP1uVXlvQOectnWZ8xz0a28n+eykFuykrjesShz2y1Vj6AQFX0qVV0qRcV/7a575mhjcGdcqNnZp9cxDL7E/YmtgF/i7kaxx/j7jd7kXg7VnjLgS3T7WGK6z0SXZhLmWn/GIe/qeatmSCWD5sSTJQIPor5oEZExrPmy7DcjKavO9afBo14Vw27ZzoIFPOEJn2IPiUmtazbIUEdIXRs6SGbLfV1zEx8nj2tSfhxS1VtllubaJbwt2Th9f5pHJKgBsh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e338fc-c6f0-42c8-6f2c-08d66981f780
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:27:04.7303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two sysfs node: core_id, config_id, user can read them to fetch the
HW product information.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../drm/arm/display/include/malidp_product.h  | 12 +++++
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 48 +++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  2 +
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |  9 +++-
 4 files changed, 70 insertions(+), 1 deletion(-)

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
index 811f3617e893..8a0a78e1d1ff 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -56,6 +56,46 @@ static void komeda_debugfs_init(struct komeda_dev *mdev)
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
@@ -204,6 +244,12 @@ struct komeda_dev *komeda_dev_create(struct device *de=
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
@@ -221,6 +267,8 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
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
index 2beaa0d49c34..f237cd027717 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -191,4 +191,6 @@ d71_identify(u32 __iomem *reg, struct komeda_chip_info =
*chip);
 struct komeda_dev *komeda_dev_create(struct device *dev);
 void komeda_dev_destroy(struct komeda_dev *mdev);
=20
+struct komeda_dev *dev_to_mdev(struct device *dev);
+
 #endif /*_KOMEDA_DEV_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index d421d13e9742..ff7a095cf2aa 100644
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
@@ -29,7 +36,7 @@ static void komeda_unbind(struct device *dev)
 	komeda_dev_destroy(mdrv->mdev);
=20
 	dev_set_drvdata(dev, NULL);
-	kfree(mdrv);
+	devm_kfree(dev, mdrv);
 }
=20
 static int komeda_bind(struct device *dev)
--=20
2.17.1

