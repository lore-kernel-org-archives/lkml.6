Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCFAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C520218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="c2hKLgyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbeLXJQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:16:20 -0500
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:48122
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbeLXJQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NlQoP/DTvM3t372khjNsz16qdg6Bu2Gaf1L3b9BiAU=;
 b=c2hKLgyg/QUXVrkb6KhgKgXcx6aeo7SYKr6/xwP9tAW+rS/SVPKYYAAcS5OYGglBgKafmpOv8NfKkDKZWnu8KXnSe27QpqS5qH3hI3opZZ5mvFjHDRY/TSwNpzgqtV0+cfjNPCDNisGytNZq5N5+uEEV7V01jRFbbkNSWHmVMLY=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0183.eurprd08.prod.outlook.com (10.161.35.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Mon, 24 Dec 2018 09:16:11 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:16:11 +0000
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
Subject: [PATCH 4/5] drm/komeda: Add komeda_build_layer_data_flow
Thread-Topic: [PATCH 4/5] drm/komeda: Add komeda_build_layer_data_flow
Thread-Index: AQHUm2lPP+YTnvFnVUO+YotBgRrcsA==
Date:   Mon, 24 Dec 2018 09:16:11 +0000
Message-ID: <20181224091450.2643-5-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0183;6:96oDFwHzuhY0SiKghCiz+BWvGI0usVfS7hMlH1YmLw9dJoqvCkdkBUifbsvVJf9QALYyBNEAQuijbQ8USRpxygJbBxmNDWMVtuRdkLs2QeveqGRFoVddykwu0aEttNtzdVK+B9X1/6CaGZLQKxzro2qtFGth6LL5UG6YSjtl8KSZyRLrF41AU4F2puv6Sg9FmDs99kUPqeR9h3xXr6PeSdED7u9ENzTKB7DyNHZXUclAV8v7AqkwXFEj1m2H/dF+/BzQ1Jvj/4vOIJlUvHaVFqpRtBGdIZ0TTPq/AjjUMsrAnQwgZ1SZsFB+9mN/2LmsxH0YQGuf3lpVCcnXglbD12FcK76MQ5wajUTELsD+vIYPzNHZld2PJ9XwG8mNmQ1DR/aQcK9Ow+tc81eVa+ZGwl0NULyhE9F9vr+bWJn0Iy4gcx+f1Ff2mvlXg0vZlywGSYsTP2I0W2CJGm3isVHQZQ==;5:du+UxJJsEGbZ2Hss6lRWmcnJ3NTaoDcu9i8vA9QPD3jVYjUn9FlvN5TV1RQQ8hmkJ2Ya7/4SSAibfZsApxBArmcdcYhAm2Mifg4CYfXNSaW/UPAwYpyu2HArbqndViTEK/rY4rh2piRqQkbvP/ZCWtANVbNqWpL0KF5rYcO5/EE=;7:0s4WEn+srrcWMBW1Zzx+2hxHEtuXqh6HdXGxrmGms5aDMu3Y4gqYlOmXfo+go3v0tLtrmghXvAO/iYp7lEaw6vytfzlNwIMV9v4NeSxR0O8WewmGH2fe3OwhUgF1QT3qgrxtDL1J4Z3UjgRXxIixiw==
x-ms-office365-filtering-correlation-id: 2af3305e-5671-495b-52c2-08d6698071ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0183;
x-ms-traffictypediagnostic: AM3PR08MB0183:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB018358B7823F7F7EA2A03634B3BB0@AM3PR08MB0183.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0183;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0183;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39850400004)(346002)(376002)(189003)(199004)(5660300001)(54906003)(7736002)(37006003)(256004)(14444005)(6862004)(4326008)(316002)(55236004)(386003)(86362001)(106356001)(14454004)(6506007)(186003)(99286004)(2906002)(105586002)(8936002)(97736004)(76176011)(36756003)(476003)(2616005)(71200400001)(478600001)(1076003)(6486002)(486006)(81156014)(71190400001)(3846002)(26005)(52116002)(68736007)(6116002)(6436002)(11346002)(8676002)(446003)(25786009)(305945005)(102836004)(103116003)(6636002)(81166006)(53936002)(6512007)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0183;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NjiliOni3pg4RMECRdUf5Ct+WL1jW2MQIU7UEXoQOrntFKwTNbGj39hFZHdR7A7fcYsbT6DwncVSoN2FdsLPoonrMckPmHjKBqxLwYt2b3kkiVRV+HBw2mZj25aTV2jnAAeyNy5aT+5KdqN1yMSP5Tcx2hlR+mdVSUYs8m6RGQ/uhyeLQJlG35lk84j6mR2KgUI1glSVjt1bfqzMA8qxTj0L0cruYuhryXJzGfbDC0p71oejLHFw7ZHzw1D3bLqdEZHA8SQ3dm6/1B4G+rHfMrJN9UhyWo15DJiW//tQweGGpR6jwqQFghEJAEZsdRES
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af3305e-5671-495b-52c2-08d6698071ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:16:11.2871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

build_layer_data_flow builds a input pipeline according to plane_state.
and in this initial stage only added this simplest pipeline usage:
  Layer -> compiz
The scaler and layer_split will be added in the future.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../drm/arm/display/komeda/komeda_pipeline.h  |  24 ++
 .../display/komeda/komeda_pipeline_state.c    | 260 ++++++++++++++++++
 2 files changed, 284 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 201fcf074fa1..c78edfc6ed5b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -280,6 +280,21 @@ struct komeda_timing_ctrlr_state {
 	struct komeda_component_state base;
 };
=20
+/* Why define A separated structure but not use plane_state directly ?
+ * 1. Komeda supports layer_split which means a plane_state can be split a=
nd
+ *    handled by two layers, one layer only handle half of plane image.
+ * 2. Fix up the user properties according to HW's capabilities, like user
+ *    set rotation to R180, but HW only supports REFLECT_X+Y. the rot here=
 is
+ *    after drm_rotation_simplify()
+ */
+struct komeda_layer_viewport {
+	u16 in_x, in_y, in_w, in_h;
+	u32 out_x, out_y, out_w, out_h;
+	u32 rot;
+	int blending_zorder;
+	u8 pixel_blend_mode, layer_alpha;
+};
+
 /** struct komeda_pipeline_funcs */
 struct komeda_pipeline_funcs {
 	/* dump_register: Optional, dump registers to seq_file */
@@ -391,4 +406,13 @@ komeda_component_add(struct komeda_pipeline *pipe,
 void komeda_component_destroy(struct komeda_dev *mdev,
 			      struct komeda_component *c);
=20
+struct komeda_plane_state;
+struct komeda_crtc_state;
+
+int komeda_build_layer_data_flow(struct komeda_layer *layer,
+				 struct komeda_component_output *dflow,
+				 struct komeda_plane_state *kplane_st,
+				 struct komeda_crtc_state *kcrtc_st,
+				 struct komeda_layer_viewport *vp);
+
 #endif /* _KOMEDA_PIPELINE_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 7ce006b9e5f7..b98163211cfd 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -8,6 +8,7 @@
 #include "komeda_dev.h"
 #include "komeda_kms.h"
 #include "komeda_pipeline.h"
+#include "komeda_framebuffer.h"
=20
 static inline bool is_switching_user(void *old, void *new)
 {
@@ -89,6 +90,18 @@ komeda_component_get_state(struct komeda_component *c,
 								&c->obj));
 }
=20
+static struct komeda_component_state *
+komeda_component_get_old_state(struct komeda_component *c,
+			       struct drm_atomic_state *state)
+{
+	struct drm_private_state *priv_st;
+
+	priv_st =3D drm_atomic_get_old_private_obj_state(state, &c->obj);
+	if (priv_st)
+		return priv_to_comp_st(priv_st);
+	return NULL;
+}
+
 /**
  * komeda_component_get_state_and_set_user()
  *
@@ -146,3 +159,250 @@ komeda_component_get_state_and_set_user(struct komeda=
_component *c,
=20
 	return st;
 }
+
+static void
+komeda_component_add_input(struct komeda_component_state *state,
+			   struct komeda_component_output *input,
+			   int idx)
+{
+	struct komeda_component *c =3D state->component;
+
+	WARN_ON((idx < 0 || idx >=3D c->max_active_inputs));
+
+	/* since the inputs[i] is only valid when it is active. So if a input[i]
+	 * is a newly enabled input which switches from disable to enable, then
+	 * the old inputs[i] is undefined (NOT zeroed), we can not rely on
+	 * memcmp, but directly mark it changed
+	 */
+	if (!has_bit(idx, state->affected_inputs) ||
+	    memcmp(&state->inputs[idx], input, sizeof(*input))) {
+		memcpy(&state->inputs[idx], input, sizeof(*input));
+		state->changed_active_inputs |=3D BIT(idx);
+	}
+	state->active_inputs |=3D BIT(idx);
+	state->affected_inputs |=3D BIT(idx);
+}
+
+static int
+komeda_component_check_input(struct komeda_component_state *state,
+			     struct komeda_component_output *input,
+			     int idx)
+{
+	struct komeda_component *c =3D state->component;
+
+	if ((idx < 0) || (idx >=3D c->max_active_inputs)) {
+		DRM_DEBUG_ATOMIC("%s invalid input id: %d.\n", c->name, idx);
+		return -EINVAL;
+	}
+
+	if (has_bit(idx, state->active_inputs)) {
+		DRM_DEBUG_ATOMIC("%s required input_id: %d has been occupied already.\n"=
,
+				 c->name, idx);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void
+komeda_component_set_output(struct komeda_component_output *output,
+			    struct komeda_component *comp,
+			    u8 output_port)
+{
+	output->component =3D comp;
+	output->output_port =3D output_port;
+}
+
+#define component_validate_private(x, st)			\
+({								\
+	struct komeda_component *c =3D &((x)->base);		\
+	int err =3D 0;						\
+								\
+	if (c->funcs->validate)				\
+		err =3D c->funcs->validate(c, &((st)->base));	\
+	err;							\
+})
+
+static int
+komeda_layer_check_cfg(struct komeda_layer *layer,
+		       struct komeda_plane_state *kplane_st,
+		       struct komeda_layer_viewport *view)
+{
+	if (!in_range(&layer->hsize_in, view->in_w)) {
+		DRM_DEBUG_ATOMIC("src_w: %d is out of range.\n", view->in_w);
+		return -EINVAL;
+	}
+
+	if (!in_range(&layer->vsize_in, view->in_h)) {
+		DRM_DEBUG_ATOMIC("src_h: %d is out of range.\n", view->in_h);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int komeda_layer_validate(struct komeda_layer *layer,
+			  struct komeda_component_output *input,
+			  struct komeda_plane_state *kplane_st,
+			  struct komeda_layer_viewport *view)
+{
+	struct drm_plane_state *plane_st =3D &kplane_st->base;
+	struct drm_framebuffer *fb =3D plane_st->fb;
+	struct komeda_fb *kfb =3D to_kfb(fb);
+	struct komeda_component_state *c_st;
+	struct komeda_layer_state *st;
+	int i, err;
+
+	err =3D komeda_layer_check_cfg(layer, kplane_st, view);
+	if (err)
+		return err;
+
+	c_st =3D komeda_component_get_state_and_set_user(&layer->base,
+			plane_st->state, plane_st->plane, plane_st->crtc);
+	if (IS_ERR(c_st))
+		return PTR_ERR(c_st);
+
+	st =3D to_layer_st(c_st);
+
+	st->rot =3D view->rot;
+	st->hsize =3D kfb->aligned_w;
+	st->vsize =3D kfb->aligned_h;
+
+	for (i =3D 0; i < fb->format->num_planes; i++)
+		st->addr[i] =3D komeda_fb_get_pixel_addr(kfb, view->in_x,
+						       view->in_y, i);
+
+	err =3D component_validate_private(layer, st);
+	if (err)
+		return err;
+
+	komeda_component_set_output(input, &layer->base, 0);
+
+	return 0;
+}
+
+static void pipeline_composition_size(struct komeda_crtc_state *kcrtc_st,
+				      u16 *hsize, u16 *vsize)
+{
+	struct drm_display_mode *m =3D &kcrtc_st->base.adjusted_mode;
+
+	if (hsize)
+		*hsize =3D m->hdisplay;
+	if (vsize)
+		*vsize =3D m->vdisplay;
+}
+
+int komeda_compiz_set_input(struct komeda_compiz *compiz,
+			    struct komeda_component_output *input,
+			    struct komeda_crtc_state *kcrtc_st,
+			    struct komeda_layer_viewport *vp)
+{
+	struct drm_atomic_state *drm_st =3D kcrtc_st->base.state;
+	struct komeda_component_state *c_st, *old_st;
+	struct komeda_compiz_input_cfg *cin;
+	u16 compiz_w, compiz_h;
+	int idx =3D vp->blending_zorder;
+
+	pipeline_composition_size(kcrtc_st, &compiz_w, &compiz_h);
+	/* check display rect */
+	if ((vp->out_x + vp->out_w > compiz_w) ||
+	    (vp->out_y + vp->out_h > compiz_h) ||
+	     vp->out_w =3D=3D 0 || vp->out_h =3D=3D 0) {
+		DRM_DEBUG_ATOMIC("invalid disp rect [x=3D%d, y=3D%d, w=3D%d, h=3D%d]\n",
+				 vp->out_x, vp->out_y, vp->out_w, vp->out_h);
+		return -EINVAL;
+	}
+
+	c_st =3D komeda_component_get_state_and_set_user(&compiz->base, drm_st,
+			kcrtc_st->base.crtc, kcrtc_st->base.crtc);
+	if (IS_ERR(c_st))
+		return PTR_ERR(c_st);
+
+	if (komeda_component_check_input(c_st, input, idx))
+		return -EINVAL;
+
+	cin =3D &(to_compiz_st(c_st)->cins[idx]);
+
+	cin->hsize   =3D vp->out_w;
+	cin->vsize   =3D vp->out_h;
+	cin->hoffset =3D vp->out_x;
+	cin->voffset =3D vp->out_y;
+	cin->pixel_blend_mode =3D vp->pixel_blend_mode;
+	cin->layer_alpha =3D vp->layer_alpha;
+
+	old_st =3D komeda_component_get_old_state(&compiz->base, drm_st);
+	WARN_ON(!old_st);
+
+	/* compare with old to check if this input has been changed */
+	if (memcmp(&(to_compiz_st(old_st)->cins[idx]), cin, sizeof(*cin)))
+		c_st->changed_active_inputs |=3D BIT(idx);
+
+	komeda_component_add_input(c_st, input, idx);
+
+	return 0;
+}
+
+int komeda_compiz_validate(struct komeda_compiz *compiz,
+			   struct komeda_component_output *input,
+			   struct komeda_crtc_state *state,
+			   struct komeda_layer_viewport *vp)
+{
+	struct komeda_component_state *c_st;
+	struct komeda_compiz_state *st;
+
+	c_st =3D komeda_component_get_state_and_set_user(&compiz->base,
+			state->base.state, state->base.crtc, state->base.crtc);
+	if (IS_ERR(c_st))
+		return PTR_ERR(c_st);
+
+	st =3D to_compiz_st(c_st);
+
+	pipeline_composition_size(state, &st->hsize, &st->vsize);
+
+	komeda_component_set_output(input, &compiz->base, 0);
+
+	/* compiz output dflow will be fed to the next pipeline stage, prepare
+	 * the viewport configuration for the next stage
+	 */
+	if (vp) {
+		vp->in_w =3D st->hsize;
+		vp->in_h =3D st->vsize;
+		vp->out_w =3D vp->in_w;
+		vp->out_h =3D vp->in_h;
+		/* the output data of compiz doesn't have alpha, it only can be
+		 * used as bottom layer when blend it with master layers
+		 */
+		vp->pixel_blend_mode =3D DRM_MODE_BLEND_PIXEL_NONE;
+		vp->layer_alpha =3D 0xFF;
+		vp->blending_zorder =3D 0;
+	}
+
+	return 0;
+}
+
+int komeda_build_layer_data_flow(struct komeda_layer *layer,
+				 struct komeda_component_output *dflow,
+				 struct komeda_plane_state *kplane_st,
+				 struct komeda_crtc_state *kcrtc_st,
+				 struct komeda_layer_viewport *vp)
+{
+	struct drm_plane *plane =3D kplane_st->base.plane;
+	struct komeda_pipeline *pipe =3D layer->base.pipeline;
+	int err;
+
+	DRM_DEBUG_ATOMIC("%s handling [PLANE:%d:%s]: "
+			 "src[x/y:%d/%d, w/h:%d/%d] disp[x/y:%d/%d, w/h:%d/%d]",
+			 layer->base.name, plane->base.id, plane->name,
+			 vp->in_x, vp->in_y, vp->in_w, vp->in_h,
+			 vp->out_x, vp->out_y, vp->out_w, vp->out_h);
+
+	memset(dflow, 0, sizeof(*dflow));
+
+	err =3D komeda_layer_validate(layer, dflow, kplane_st, vp);
+	if (err)
+		return err;
+
+	err =3D komeda_compiz_set_input(pipe->compiz, dflow, kcrtc_st, vp);
+
+	return err;
+}
--=20
2.17.1

