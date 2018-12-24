Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B36C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BD0218AF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DtcCYfxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbeLXJQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:16:08 -0500
Received: from mail-eopbgr150047.outbound.protection.outlook.com ([40.107.15.47]:31001
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbeLXJQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42jEADxXujxv/Mq85Udf5NLrF2RKTBxuWTP93SXjIgg=;
 b=DtcCYfxK3K+JFtTW2nc7yc57oYfKM4EmUs3OkTIxtUzGEgzDC4oEyMsD8F7a1lT1kqvt+HNjfXg1XNmy/2y6ytu7O6z8eTBpPsRd2fO0Gd5+LjPwPhZ1UgkDlTg5MvuIAmN40NfG/92Mb+KDnQGmxhri0YqKwYeb99+ZL8RdX4c=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0183.eurprd08.prod.outlook.com (10.161.35.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Mon, 24 Dec 2018 09:16:00 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:16:00 +0000
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
Subject: [PATCH 3/5] drm/arm/komeda: Initialize komeda component as drm
 private object
Thread-Topic: [PATCH 3/5] drm/arm/komeda: Initialize komeda component as drm
 private object
Thread-Index: AQHUm2lJ5spMUqHclESHdnLDQsI9ag==
Date:   Mon, 24 Dec 2018 09:16:00 +0000
Message-ID: <20181224091450.2643-4-james.qian.wang@arm.com>
References: <20181224091450.2643-1-james.qian.wang@arm.com>
In-Reply-To: <20181224091450.2643-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY2PR01CA0039.ausprd01.prod.outlook.com
 (2603:10c6:1:15::27) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0183;6:T7Vt/sBXn410jFUlbKLR1n/Cpm7S0OvazPocEUDqBc7iAuHVhgdoqqLWr507pjP4fdUa/t8mL4sonbZqc+BnkEO6WPOB8GZudIJSEb00blfTM/ac2VsaTk49o4E830Bb0eqaWoiUQJZxgChHvtMYwr0hYmRwuSHB/lqSLEN84Mjrl4GVUF/15OG2A5UsbquDendajWygRez8aex20ip+znkxckVdAk1o3Zwyi+fWiFBZHAxI4OoxBlSUxZ3Xb1gI9uT58+cmpOl8V/m3MYJ0j6/67Nq4KRkqS971+mGb3q3nDqAB01HYx5W9+oXZOufseAGSLTXUlcKHozL7RE5/veT66awN255lBvgs7EhlBWuFdZpE6t0zl/e0D2lCacI73UJgsDA3YjGBWKOK7whecRmPmC1IXrIWgR2/BkCcVII13bq3mn7bSzhkj4Wa4shtUTh4fpVXQjM2uL0q1NI0yg==;5:D13wmqr53Q9iEbsqa9YBAPW9MFReJ9vaRq+0gVo46X8VeytsY0D7AmuD68dsbrABiZVjkYGHxXdUmh8Lbfzs1lfrpH+RbKs7oLFNyr2+toNeXUis3UpWkX549vuyVlTUmy5kqefitATlwAD8ypoUxeoHpX0WecjPnki6nI7nEU8=;7:k383mFlvSJxXg4TvsKLCGpG1ppql2JLK+LppAT+dBSh1/d0Iqn8RhSHmUXCUUegVkpf0+jp38jhJpKEuZje82JVz6zCksNJpoQnap2gBbCRIhdtsANr28LNaHNCgPXD8200M9xrwP93R7Hy90DySeA==
x-ms-office365-filtering-correlation-id: bf3b7917-f5f0-4a70-3b24-08d669806b5f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0183;
x-ms-traffictypediagnostic: AM3PR08MB0183:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0183971A7F4E9EF68B530450B3BB0@AM3PR08MB0183.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0183;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0183;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39850400004)(346002)(376002)(189003)(199004)(5660300001)(575784001)(54906003)(7736002)(37006003)(256004)(6862004)(4326008)(316002)(55236004)(386003)(86362001)(106356001)(14454004)(6506007)(186003)(99286004)(2906002)(105586002)(8936002)(97736004)(76176011)(36756003)(476003)(2616005)(71200400001)(478600001)(1076003)(6486002)(486006)(81156014)(71190400001)(3846002)(26005)(52116002)(68736007)(6116002)(6436002)(11346002)(8676002)(446003)(25786009)(305945005)(102836004)(103116003)(6636002)(81166006)(53936002)(6512007)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0183;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0/cRy/sJO5en+R/+TC0EMUDQwLVNBnfTYPtDxWE1/eyJmnVebICehi3cyxlbPe+Xo1wwWZsZLFIveyTL81JoWTys5RvoItHpdkTHoyQYn9dt70qOsntFItFPXwlIL2ZE6p7qV6g0ufVeck4bgYsUI2UXAyHOAnWN7+8cywlkAu6EWCgQWbM3u0yQXwD5kfSY86Nt+lJ6lpKWm5On7Ma7G+Zzl1KVeeVEpiSnDy+C5WInQAhaRwFZg50itN/097FUP5s4/whRMDETYOJLfVsy3GIojBCc4qib/lPZbXQ/fPG5vXfSX1TWaOjAMYslt7A4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3b7917-f5f0-4a70-3b24-08d669806b5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:16:00.1630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize koemda_layer, komeda_compiz, komeda_improc and
komeda_timing_ctrlr as drm private object, then track komeda private
component state by drm_atomic_state.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../arm/display/komeda/komeda_private_obj.c   | 200 +++++++++++++++++-
 1 file changed, 198 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_private_obj.c
index 9edfd6ab0c12..c5b42fc4f904 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
@@ -7,6 +7,184 @@
 #include "komeda_dev.h"
 #include "komeda_kms.h"
=20
+static void
+komeda_component_state_reset(struct komeda_component_state *st)
+{
+	st->binding_user =3D NULL;
+	st->affected_inputs =3D st->active_inputs;
+	st->active_inputs =3D 0;
+	st->changed_active_inputs =3D 0;
+}
+
+static struct drm_private_state *
+komeda_layer_atomic_duplicate_state(struct drm_private_obj *obj)
+{
+	struct komeda_layer_state *st;
+
+	st =3D kmemdup(obj->state, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return NULL;
+
+	komeda_component_state_reset(&st->base);
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &st->base.obj);
+
+	return &st->base.obj;
+}
+
+static void
+komeda_layer_atomic_destroy_state(struct drm_private_obj *obj,
+				  struct drm_private_state *state)
+{
+	struct komeda_layer_state *st =3D to_layer_st(priv_to_comp_st(state));
+
+	kfree(st);
+}
+
+static const struct drm_private_state_funcs komeda_layer_obj_funcs =3D {
+	.atomic_duplicate_state	=3D komeda_layer_atomic_duplicate_state,
+	.atomic_destroy_state	=3D komeda_layer_atomic_destroy_state,
+};
+
+static int komeda_layer_obj_add(struct komeda_layer *layer)
+{
+	struct komeda_layer_state *st;
+
+	st =3D kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->base.component =3D &layer->base;
+	drm_atomic_private_obj_init(&layer->base.obj, &st->base.obj,
+				    &komeda_layer_obj_funcs);
+	return 0;
+}
+
+static struct drm_private_state *
+komeda_compiz_atomic_duplicate_state(struct drm_private_obj *obj)
+{
+	struct komeda_compiz_state *st;
+
+	st =3D kmemdup(obj->state, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return NULL;
+
+	komeda_component_state_reset(&st->base);
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &st->base.obj);
+
+	return &st->base.obj;
+}
+
+static void
+komeda_compiz_atomic_destroy_state(struct drm_private_obj *obj,
+				   struct drm_private_state *state)
+{
+	kfree(to_compiz_st(priv_to_comp_st(state)));
+}
+
+static const struct drm_private_state_funcs komeda_compiz_obj_funcs =3D {
+	.atomic_duplicate_state	=3D komeda_compiz_atomic_duplicate_state,
+	.atomic_destroy_state	=3D komeda_compiz_atomic_destroy_state,
+};
+
+static int komeda_compiz_obj_add(struct komeda_compiz *compiz)
+{
+	struct komeda_compiz_state *st;
+
+	st =3D kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->base.component =3D &compiz->base;
+	drm_atomic_private_obj_init(&compiz->base.obj, &st->base.obj,
+				    &komeda_compiz_obj_funcs);
+
+	return 0;
+}
+
+static struct drm_private_state *
+komeda_improc_atomic_duplicate_state(struct drm_private_obj *obj)
+{
+	struct komeda_improc_state *st;
+
+	st =3D kmemdup(obj->state, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return NULL;
+
+	komeda_component_state_reset(&st->base);
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &st->base.obj);
+
+	return &st->base.obj;
+}
+
+static void
+komeda_improc_atomic_destroy_state(struct drm_private_obj *obj,
+				   struct drm_private_state *state)
+{
+	kfree(to_improc_st(priv_to_comp_st(state)));
+}
+
+static const struct drm_private_state_funcs komeda_improc_obj_funcs =3D {
+	.atomic_duplicate_state	=3D komeda_improc_atomic_duplicate_state,
+	.atomic_destroy_state	=3D komeda_improc_atomic_destroy_state,
+};
+
+static int komeda_improc_obj_add(struct komeda_improc *improc)
+{
+	struct komeda_improc_state *st;
+
+	st =3D kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->base.component =3D &improc->base;
+	drm_atomic_private_obj_init(&improc->base.obj, &st->base.obj,
+				    &komeda_improc_obj_funcs);
+
+	return 0;
+}
+
+static struct drm_private_state *
+komeda_timing_ctrlr_atomic_duplicate_state(struct drm_private_obj *obj)
+{
+	struct komeda_timing_ctrlr_state *st;
+
+	st =3D kmemdup(obj->state, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return NULL;
+
+	komeda_component_state_reset(&st->base);
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &st->base.obj);
+
+	return &st->base.obj;
+}
+
+static void
+komeda_timing_ctrlr_atomic_destroy_state(struct drm_private_obj *obj,
+					 struct drm_private_state *state)
+{
+	kfree(to_ctrlr_st(priv_to_comp_st(state)));
+}
+
+static const struct drm_private_state_funcs komeda_timing_ctrlr_obj_funcs =
=3D {
+	.atomic_duplicate_state	=3D komeda_timing_ctrlr_atomic_duplicate_state,
+	.atomic_destroy_state	=3D komeda_timing_ctrlr_atomic_destroy_state,
+};
+
+static int komeda_timing_ctrlr_obj_add(struct komeda_timing_ctrlr *ctrlr)
+{
+	struct komeda_compiz_state *st;
+
+	st =3D kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->base.component =3D &ctrlr->base;
+	drm_atomic_private_obj_init(&ctrlr->base.obj, &st->base.obj,
+				    &komeda_timing_ctrlr_obj_funcs);
+
+	return 0;
+}
+
 static struct drm_private_state *
 komeda_pipeline_atomic_duplicate_state(struct drm_private_obj *obj)
 {
@@ -55,7 +233,7 @@ int komeda_kms_add_private_objs(struct komeda_kms_dev *k=
ms,
 				struct komeda_dev *mdev)
 {
 	struct komeda_pipeline *pipe;
-	int i, err;
+	int i, j, err;
=20
 	for (i =3D 0; i < mdev->n_pipelines; i++) {
 		pipe =3D mdev->pipelines[i];
@@ -64,7 +242,23 @@ int komeda_kms_add_private_objs(struct komeda_kms_dev *=
kms,
 		if (err)
 			return err;
=20
-		/* Add component */
+		for (j =3D 0; j < pipe->n_layers; j++) {
+			err =3D komeda_layer_obj_add(pipe->layers[j]);
+			if (err)
+				return err;
+		}
+
+		err =3D komeda_compiz_obj_add(pipe->compiz);
+		if (err)
+			return err;
+
+		err =3D komeda_improc_obj_add(pipe->improc);
+		if (err)
+			return err;
+
+		err =3D komeda_timing_ctrlr_obj_add(pipe->ctrlr);
+		if (err)
+			return err;
 	}
=20
 	return 0;
@@ -78,11 +272,13 @@ void komeda_kms_cleanup_private_objs(struct komeda_dev=
 *mdev)
=20
 	for (i =3D 0; i < mdev->n_pipelines; i++) {
 		pipe =3D mdev->pipelines[i];
+
 		dp_for_each_set_bit(id, pipe->avail_comps) {
 			c =3D komeda_pipeline_get_component(pipe, id);
=20
 			drm_atomic_private_obj_fini(&c->obj);
 		}
+
 		drm_atomic_private_obj_fini(&pipe->obj);
 	}
 }
--=20
2.17.1

