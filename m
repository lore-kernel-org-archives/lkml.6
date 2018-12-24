Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A80C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8637C218AF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fnamop0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbeLXJP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:15:57 -0500
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:37556
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbeLXJP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj6Has3h6gNdbRWUbleSEHCtXu1LhMSVpuF+eexfpu0=;
 b=fnamop0KngDNmwJhRaI0fML0z9lkazf5aHH0ysYtNhz9mGdh+T5mLIZDSq9ljtvkI2JxxHaejP8nWk9Up+uEX7WzqOEATvya5zmT0N5TCNjOOnpVR+vI48d0/CssUAkvt5MdEXQUjBPvbsrwmIHJDycC3otuL0zBiwFfcmuYEgk=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0183.eurprd08.prod.outlook.com (10.161.35.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Mon, 24 Dec 2018 09:15:49 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:15:49 +0000
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
Subject: [PATCH 2/5] drm/komeda: Add
 komeda_pipeline/component_get_state_and_set_user
Thread-Topic: [PATCH 2/5] drm/komeda: Add
 komeda_pipeline/component_get_state_and_set_user
Thread-Index: AQHUm2lCeELNQHzQ80OmA4uEgAdeNA==
Date:   Mon, 24 Dec 2018 09:15:48 +0000
Message-ID: <20181224091450.2643-3-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0183;6:B1PyX/cUXQ+u9SCdqU7dGWvewFzV2jYpVnX2cBgxT1nZqTvlhzPU9JiV/YAcBlO7I9Utmr6bP4mgHgymEijv/QX+6uxWyyZHIl1U488coys4neM/jNcJqkEnZ5fICuTzZbLNym6PiRww3XRmJt6xJn3KS4fQX8r2LZxogBGs7nmSAwUTSNRXsTXhksQXCF1SkEFlluAw+bvyN8SrNeDpcUOLmYbj9NBedT8H48XWx83l4vTNpr4gRIMtsLb4dZ28YrNDsQz3FEijP1U1HBx2fMnegSBdDYTn7a3jOFrtFEJKnHhGSqI6TtIjcUlg/B5dfCGuulwmToyHz5fK9e9XHuiTzr4XU3GWSyym3p4iA5zQCmYLKuxxuwNGQPzAVT4z8lMifdslTQc5BxsDWfysFd3hKbsAHIM/wbAqYKvvf2LtXahNEeSI/rqCMuoDJD7XAm8LQfPKAHZcLp2ysWCz8w==;5:QqmynkiYPv8UGPKs+rY3hvUlWZ3wxR507hrs9F3nMEPHe+3ltDWOojtTZF98vXtYa6dWuH28mF80+Ysbux0iqqcY2AlTh/IZnaY0FPTmIdTgwHBIrZj3SHfNW6U2u+WjJvdhjM96F6oaUHaRLXIZM2uBzT73vWcz1n3eAF43Sd8=;7:c9fz/T9ttil4BC9gRDTCOx5EEAlE6scZZZeH/eP+rbBPAkUMBb/JueeCXQUASfba4XTpay1x1l6KlGbqEybSkYXBkMm6JRQjUX0lrnMtIoFvCvBZPSlHbF0Kkl/n1VCfCXVLTKtF6rNfXCs3eytpeQ==
x-ms-office365-filtering-correlation-id: 821e39d3-9aaa-4bd9-505e-08d6698064a6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0183;
x-ms-traffictypediagnostic: AM3PR08MB0183:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0183625898EF56F9A11A0794B3BB0@AM3PR08MB0183.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0183;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0183;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39850400004)(346002)(376002)(189003)(199004)(5660300001)(575784001)(54906003)(7736002)(37006003)(256004)(14444005)(6862004)(4326008)(316002)(55236004)(386003)(86362001)(106356001)(14454004)(6506007)(186003)(99286004)(2906002)(105586002)(8936002)(97736004)(76176011)(36756003)(476003)(2616005)(71200400001)(478600001)(1076003)(6486002)(486006)(81156014)(71190400001)(3846002)(26005)(52116002)(68736007)(6116002)(6436002)(11346002)(8676002)(446003)(25786009)(305945005)(102836004)(103116003)(6636002)(81166006)(53936002)(6512007)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0183;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IfPBLmFiHOxaIJYyIN3fzuDsTgqiO0OWui1HGaXNMk+1BFJ4VqutYOclekLo/PdtobUx5EBDj8euSNd+HKDM3hG5F/W13uAsfzF4wrGz4mPekTftyjYuK9jvQO4x4ippS9TbHIKL4HcN+//Rbqfc8w7KWnwPuJwXdztgYVCxqjdBNYM1jiglA+4FEGPk4YTMKqP7Tc80fABGsoFhB3/SzcIOIiJqsLSm3tAE2rfekuBYmmY7GCE9zJG1agImILMTBbpUL25GJU/ZXC1YRGy/I/33umwmuuMrczid8b64FI4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821e39d3-9aaa-4bd9-505e-08d6698064a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:15:48.8808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_state_and_set_user packed get_state and set_user into one function,
which get pipeline/component state for a specific pipeline/component, if
success set the user to it.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/Makefile   |   1 +
 .../drm/arm/display/komeda/komeda_pipeline.c  |   2 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |   7 +
 .../display/komeda/komeda_pipeline_state.c    | 148 ++++++++++++++++++
 4 files changed, 158 insertions(+)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_stat=
e.c

diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/=
arm/display/komeda/Makefile
index d593125236ae..62bd1bff66a3 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -9,6 +9,7 @@ komeda-y :=3D \
 	komeda_dev.o \
 	komeda_format_caps.o \
 	komeda_pipeline.o \
+	komeda_pipeline_state.o \
 	komeda_framebuffer.o \
 	komeda_kms.o \
 	komeda_crtc.o \
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.c
index 611e8c53e248..1c9205d0e61b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -34,6 +34,8 @@ komeda_pipeline_add(struct komeda_dev *mdev, size_t size,
 	pipe->id   =3D mdev->n_pipelines;
 	pipe->funcs =3D funcs;
=20
+	drm_modeset_lock_init(&pipe->mutex);
+
 	mdev->pipelines[mdev->n_pipelines] =3D pipe;
 	mdev->n_pipelines++;
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 4f98fdb21557..201fcf074fa1 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -295,6 +295,13 @@ struct komeda_pipeline_funcs {
 struct komeda_pipeline {
 	/** @obj: link pipeline as private obj of drm_atomic_state */
 	struct drm_private_obj obj;
+
+	/**
+	 * @mutex:
+	 *
+	 * protects pipeline_state, since pipeline can be shared between crtcs
+	 */
+	struct drm_modeset_lock mutex;
 	/** @mdev: the parent komeda_dev */
 	struct komeda_dev *mdev;
 	/** @pxlclk: pixel clock */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
new file mode 100644
index 000000000000..7ce006b9e5f7
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#include <linux/clk.h>
+#include "komeda_dev.h"
+#include "komeda_kms.h"
+#include "komeda_pipeline.h"
+
+static inline bool is_switching_user(void *old, void *new)
+{
+	if (!old || !new)
+		return false;
+
+	return old !=3D new;
+}
+
+struct komeda_pipeline_state *
+komeda_pipeline_get_state(struct komeda_pipeline *pipe,
+			  struct drm_atomic_state *state)
+{
+	struct drm_private_state *priv_st;
+	int err;
+
+	WARN_ON(!state->acquire_ctx);
+
+	priv_st =3D drm_atomic_get_new_private_obj_state(state, &pipe->obj);
+	if (priv_st)
+		return priv_to_pipe_st(priv_st);
+
+	err =3D drm_modeset_lock(&pipe->mutex, state->acquire_ctx);
+	if (err)
+		return ERR_PTR(err);
+
+	priv_st =3D drm_atomic_get_private_obj_state(state, &pipe->obj);
+	if (IS_ERR(priv_st))
+		return ERR_CAST(priv_st);
+
+	return priv_to_pipe_st(priv_st);
+}
+
+/* Assign a pipeline crtc */
+struct komeda_pipeline_state *
+komeda_pipeline_get_state_and_set_crtc(struct komeda_pipeline *pipe,
+				       struct drm_atomic_state *state,
+				       struct drm_crtc *crtc)
+{
+	struct komeda_pipeline_state *st;
+
+	st =3D komeda_pipeline_get_state(pipe, state);
+	if (IS_ERR(st))
+		return st;
+
+	if (is_switching_user(crtc, st->crtc)) {
+		DRM_DEBUG_ATOMIC("CRTC%d required pipeline%d is busy.\n",
+				 drm_crtc_index(crtc), pipe->id);
+		return ERR_PTR(-EBUSY);
+	}
+
+	/* pipeline only can be disabled when the it is free or unused */
+	if (!crtc && st->active_comps) {
+		DRM_DEBUG_ATOMIC("Disabling a busy pipeline:%d.\n", pipe->id);
+		return ERR_PTR(-EBUSY);
+	}
+
+	st->crtc =3D crtc;
+
+	if (crtc) {
+		struct komeda_crtc_state *kcrtc_st;
+
+		kcrtc_st =3D to_kcrtc_st(drm_atomic_get_new_crtc_state(state,
+								     crtc));
+
+		kcrtc_st->active_pipes |=3D BIT(pipe->id);
+		kcrtc_st->affected_pipes |=3D BIT(pipe->id);
+	}
+	return st;
+}
+
+static struct komeda_component_state *
+komeda_component_get_state(struct komeda_component *c,
+			   struct drm_atomic_state *state)
+{
+	WARN_ON(!drm_modeset_is_locked(&c->pipeline->mutex));
+
+	return priv_to_comp_st(drm_atomic_get_private_obj_state(state,
+								&c->obj));
+}
+
+/**
+ * komeda_component_get_state_and_set_user()
+ *
+ * @c: component to get state and set user
+ * @state: global atomic state
+ * @user: direct user, the binding user
+ * @crtc: the CRTC user, the big boss :)
+ *
+ * This function accepts two users:
+ * -   The direct user: can be plane/crtc/wb_connector depends on componen=
t
+ * -   The big boss (CRTC)
+ * CRTC is the big boss (the final user), because all component resources
+ * eventually will be assigned to CRTC, like the layer will be binding to
+ * kms_plane, but kms plane will be binding to a CRTC eventually.
+ *
+ * The big boss (CRTC) is for pipeline assignment, since &komeda_component=
 isn't
+ * independent and can be assigned to CRTC freely, but belongs to a specif=
ic
+ * pipeline, only pipeline can be shared between crtc, and pipeline as a w=
hole
+ * (include all the internal components) assigned to a specific CRTC.
+ *
+ * So when set a user to komeda_component, need first to check the status =
of
+ * component->pipeline to see if the pipeline is available on this specifi=
c
+ * CRTC. if the pipeline is busy (assigned to another CRTC), even the requ=
ired
+ * component is free, the component still cannot be assigned to the direct=
 user.
+ */
+static struct komeda_component_state *
+komeda_component_get_state_and_set_user(struct komeda_component *c,
+					struct drm_atomic_state *state,
+					void *user,
+					struct drm_crtc *crtc)
+{
+	struct komeda_pipeline_state *pipe_st;
+	struct komeda_component_state *st;
+
+	/* First check if the pipeline is available */
+	pipe_st =3D komeda_pipeline_get_state_and_set_crtc(c->pipeline,
+							 state, crtc);
+	if (IS_ERR(pipe_st))
+		return ERR_CAST(pipe_st);
+
+	st =3D komeda_component_get_state(c, state);
+	if (IS_ERR(st))
+		return st;
+
+	/* check if the component has been occupied */
+	if (is_switching_user(user, st->binding_user)) {
+		DRM_DEBUG_ATOMIC("required %s is busy.\n", c->name);
+		return ERR_PTR(-EBUSY);
+	}
+
+	st->binding_user =3D user;
+	/* mark the component as active if user is valid */
+	if (st->binding_user)
+		pipe_st->active_comps |=3D BIT(c->id);
+
+	return st;
+}
--=20
2.17.1

