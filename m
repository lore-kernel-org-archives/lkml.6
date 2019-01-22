Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5B6C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183E120879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="mV8jPogQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfAVLGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:06:18 -0500
Received: from mail-eopbgr40077.outbound.protection.outlook.com ([40.107.4.77]:6720
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727624AbfAVLGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAizjh/RawNJsQr8TEVF1lDtKek5vWwMrilQ+6zwlH8=;
 b=mV8jPogQs5dvKBOpZbu2z2IUk0phIrd/+n/dkivTsfaJw5wisnfVNLyYoqFUP3lubmandlGb4bKGv/5bjeofuuhJ09QfeIB39LKWe9rlsyy89mYfiLrdMpDeo+s2IKrINAnHedEjb1tnhG5hyUqwQEvqhbk8zBnantHPSpoglww=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1989.eurprd08.prod.outlook.com (10.168.85.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Tue, 22 Jan 2019 11:06:12 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:06:12 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
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
Subject: [PATCH v2 4/5] drm/komeda: Add komeda_build_layer_data_flow
Thread-Topic: [PATCH v2 4/5] drm/komeda: Add komeda_build_layer_data_flow
Thread-Index: AQHUskJ8pn6r/k6jA0axmHJlDcj+hQ==
Date:   Tue, 22 Jan 2019 11:06:12 +0000
Message-ID: <20190122110431.5025-5-james.qian.wang@arm.com>
References: <20190122110431.5025-1-james.qian.wang@arm.com>
In-Reply-To: <20190122110431.5025-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYAPR01CA0021.ausprd01.prod.outlook.com (2603:10c6:1::33)
 To DB6PR0801MB1990.eurprd08.prod.outlook.com (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1989;6:fyeckZyokdT44O1JrtgUT+uRQ929r7NAE+ZaCGTYdBHXwXtYF4NNojeKOpj5jasBBduG3D75daZQS6EoEPvGqv4eKztnR7Qc1NAzXsGi+12jIKotxifgglL4emCXbvpgxsqJk/qoI1vQKl9CzRVaRa2DZ6Fnrag38J9ZLN8o3fhqHCPqqrxfeQycMy6l46vUS1Md/nwRfbJlr6fnO44p0uE5o74yoJtzoS2MgvWgRUh9R+HXFiSyhcTpdWh5MBfdz4UjfScMtY4A8RCx7NIiNzD2nSGzMRgbEuY8drNn/mnQuOYGHcZWeYlf//bQ/DlYOfM6tJhOw7MLXXKBLC2MbcX7tlCaQJE6BX7TxiZnq2cvc7VVD6r7E9Cv3HJWI6/OKU/OJKlEkh9E8hIh1JD2/NrUmvnOua0qCfbFmGRRIYPuaBhjTZkd/sW1gXk+XP4RWVlDu6abYW91e2D/1fRK1A==;5:VFx3FQtyFFsMzr0H8KKExL8SFRrtyl8kIyOi7p1aHSjVAnht6Ob/BroTAYgN8mp5loZj9dgjBADRWAh7UtlWftuMo8gtYAWo5PNLiVnoTOm507ZDO4P9s+iQVghDsRY2DEG0M9VwqpRrq9NxMOx+4tAk9qikvC2M5GV204KIWQJgMzGdsYhEsIqjJxe6rsQFkYlVLHhoVDQayqWc8FLn8A==;7:G5WrdZOTLjZ9nL5vi+2zk+hgTa1kY/clkvAZi4iAfBJ+q+8PJIJNBjS1vNs14ERSLO5CzAR/NYX9t5QBDEX42B2fGEhft2eYIMvcCguCVHYpDi7EBuGlImPriEHm2URY5zEThLZIxBKqTnGv+CgYIw==
x-ms-office365-filtering-correlation-id: 25e0f2fb-0b68-4883-433f-08d680599e50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1989;
x-ms-traffictypediagnostic: DB6PR0801MB1989:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB19895F2792022A0E24A4DFCDB3980@DB6PR0801MB1989.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(4326008)(106356001)(105586002)(316002)(25786009)(2501003)(8936002)(256004)(14444005)(2201001)(1076003)(86362001)(52116002)(53936002)(2906002)(54906003)(110136005)(478600001)(14454004)(6512007)(99286004)(26005)(102836004)(55236004)(97736004)(36756003)(386003)(6506007)(66066001)(76176011)(68736007)(2616005)(476003)(81166006)(50226002)(186003)(11346002)(6116002)(3846002)(7736002)(30864003)(486006)(103116003)(8676002)(6486002)(305945005)(71190400001)(71200400001)(6436002)(446003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1989;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WD0BIP7F7dR7PZ7EFQz7QzXnpTCDR7JkJIdi/GKnRBcIiAR5erpNBkorFxFBwHTJs9QvRVVNlCb3GaBywt1t/1iXZwSnvYMBAR3FwJY3ce/Kbw+htCbzvMLHRPBSsrArMrTGkekws69d6MQZM9/Z7x7uRYx6rfSg2HjkMZO9cAkWMz9is9x3JqS0RvvyB/R8TnBAIP0fVJYuXMjOK9DYZJvLjcIHiNVvF53UALHxvoRaTZA+FwEuUDBvafGluH6ELEPvvNs2xFkugoowLPwODrbGdkT5qoJ3BdKYibmqPhaynRT77u1Bc/Q/iloTRgm0KjVfxO12SZ6ZHkLpI2l1QumlGYfUqi1EqjJA0nHcGHJxYM7VZjtThMkehFhL5derLli2GVy57yyHSWLdVBfHOyo1dF/T+hPkBdSRS6RmO28=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e0f2fb-0b68-4883-433f-08d680599e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:06:02.1320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1989
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

build_layer_data_flow builds a input pipeline according to plane_state.
and in this initial stage only added this simplest pipeline usage:
  Layer -> compiz
The scaler and layer_split will be added in the future.

v2:
- Rebase.
- Introduce struct komeda_data_flow_cfg
- Add a function komeda_component_validate_private to replace the MACRO
  component_validate_private

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../drm/arm/display/komeda/komeda_pipeline.h  |  24 ++
 .../display/komeda/komeda_pipeline_state.c    | 266 +++++++++++++++++-
 2 files changed, 289 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index c30a790d0712..16d7ae891e81 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -278,6 +278,22 @@ struct komeda_timing_ctrlr_state {
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
+struct komeda_data_flow_cfg {
+	struct komeda_component_output input;
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
@@ -382,4 +398,12 @@ komeda_component_add(struct komeda_pipeline *pipe,
 void komeda_component_destroy(struct komeda_dev *mdev,
 			      struct komeda_component *c);
=20
+struct komeda_plane_state;
+struct komeda_crtc_state;
+
+int komeda_build_layer_data_flow(struct komeda_layer *layer,
+				 struct komeda_plane_state *kplane_st,
+				 struct komeda_crtc_state *kcrtc_st,
+				 struct komeda_data_flow_cfg *dflow);
+
 #endif /* _KOMEDA_PIPELINE_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 7ebab4fae567..74d25e542103 100644
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
@@ -83,6 +84,18 @@ komeda_component_get_state(struct komeda_component *c,
 	return priv_to_comp_st(priv_st);
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
@@ -108,7 +121,7 @@ komeda_component_get_state(struct komeda_component *c,
  * CRTC. if the pipeline is busy (assigned to another CRTC), even the requ=
ired
  * component is free, the component still cannot be assigned to the direct=
 user.
  */
-struct komeda_component_state *
+static struct komeda_component_state *
 komeda_component_get_state_and_set_user(struct komeda_component *c,
 					struct drm_atomic_state *state,
 					void *user,
@@ -140,3 +153,254 @@ komeda_component_get_state_and_set_user(struct komeda=
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
+static int
+komeda_component_validate_private(struct komeda_component *c,
+				  struct komeda_component_state *st)
+{
+	int err;
+
+	if (!c->funcs->validate)
+		return 0;
+
+	err =3D c->funcs->validate(c, st);
+	if (err)
+		DRM_DEBUG_ATOMIC("%s validate private failed.\n", c->name);
+
+	return err;
+}
+
+static int
+komeda_layer_check_cfg(struct komeda_layer *layer,
+		       struct komeda_plane_state *kplane_st,
+		       struct komeda_data_flow_cfg *dflow)
+{
+	if (!in_range(&layer->hsize_in, dflow->in_w)) {
+		DRM_DEBUG_ATOMIC("src_w: %d is out of range.\n", dflow->in_w);
+		return -EINVAL;
+	}
+
+	if (!in_range(&layer->vsize_in, dflow->in_h)) {
+		DRM_DEBUG_ATOMIC("src_h: %d is out of range.\n", dflow->in_h);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+komeda_layer_validate(struct komeda_layer *layer,
+		      struct komeda_plane_state *kplane_st,
+		      struct komeda_data_flow_cfg *dflow)
+{
+	struct drm_plane_state *plane_st =3D &kplane_st->base;
+	struct drm_framebuffer *fb =3D plane_st->fb;
+	struct komeda_fb *kfb =3D to_kfb(fb);
+	struct komeda_component_state *c_st;
+	struct komeda_layer_state *st;
+	int i, err;
+
+	err =3D komeda_layer_check_cfg(layer, kplane_st, dflow);
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
+	st->rot =3D dflow->rot;
+	st->hsize =3D kfb->aligned_w;
+	st->vsize =3D kfb->aligned_h;
+
+	for (i =3D 0; i < fb->format->num_planes; i++)
+		st->addr[i] =3D komeda_fb_get_pixel_addr(kfb, dflow->in_x,
+						       dflow->in_y, i);
+
+	err =3D komeda_component_validate_private(&layer->base, c_st);
+	if (err)
+		return err;
+
+	/* update the data flow for the next stage */
+	komeda_component_set_output(&dflow->input, &layer->base, 0);
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
+static int
+komeda_compiz_set_input(struct komeda_compiz *compiz,
+			struct komeda_crtc_state *kcrtc_st,
+			struct komeda_data_flow_cfg *dflow)
+{
+	struct drm_atomic_state *drm_st =3D kcrtc_st->base.state;
+	struct komeda_component_state *c_st, *old_st;
+	struct komeda_compiz_input_cfg *cin;
+	u16 compiz_w, compiz_h;
+	int idx =3D dflow->blending_zorder;
+
+	pipeline_composition_size(kcrtc_st, &compiz_w, &compiz_h);
+	/* check display rect */
+	if ((dflow->out_x + dflow->out_w > compiz_w) ||
+	    (dflow->out_y + dflow->out_h > compiz_h) ||
+	     dflow->out_w =3D=3D 0 || dflow->out_h =3D=3D 0) {
+		DRM_DEBUG_ATOMIC("invalid disp rect [x=3D%d, y=3D%d, w=3D%d, h=3D%d]\n",
+				 dflow->out_x, dflow->out_y,
+				 dflow->out_w, dflow->out_h);
+		return -EINVAL;
+	}
+
+	c_st =3D komeda_component_get_state_and_set_user(&compiz->base, drm_st,
+			kcrtc_st->base.crtc, kcrtc_st->base.crtc);
+	if (IS_ERR(c_st))
+		return PTR_ERR(c_st);
+
+	if (komeda_component_check_input(c_st, &dflow->input, idx))
+		return -EINVAL;
+
+	cin =3D &(to_compiz_st(c_st)->cins[idx]);
+
+	cin->hsize   =3D dflow->out_w;
+	cin->vsize   =3D dflow->out_h;
+	cin->hoffset =3D dflow->out_x;
+	cin->voffset =3D dflow->out_y;
+	cin->pixel_blend_mode =3D dflow->pixel_blend_mode;
+	cin->layer_alpha =3D dflow->layer_alpha;
+
+	old_st =3D komeda_component_get_old_state(&compiz->base, drm_st);
+	WARN_ON(!old_st);
+
+	/* compare with old to check if this input has been changed */
+	if (memcmp(&(to_compiz_st(old_st)->cins[idx]), cin, sizeof(*cin)))
+		c_st->changed_active_inputs |=3D BIT(idx);
+
+	komeda_component_add_input(c_st, &dflow->input, idx);
+
+	return 0;
+}
+
+int
+komeda_compiz_validate(struct komeda_compiz *compiz,
+		       struct komeda_crtc_state *state,
+		       struct komeda_data_flow_cfg *dflow)
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
+	komeda_component_set_output(&dflow->input, &compiz->base, 0);
+
+	/* compiz output dflow will be fed to the next pipeline stage, prepare
+	 * the data flow configuration for the next stage
+	 */
+	if (dflow) {
+		dflow->in_w =3D st->hsize;
+		dflow->in_h =3D st->vsize;
+		dflow->out_w =3D dflow->in_w;
+		dflow->out_h =3D dflow->in_h;
+		/* the output data of compiz doesn't have alpha, it only can be
+		 * used as bottom layer when blend it with master layers
+		 */
+		dflow->pixel_blend_mode =3D DRM_MODE_BLEND_PIXEL_NONE;
+		dflow->layer_alpha =3D 0xFF;
+		dflow->blending_zorder =3D 0;
+	}
+
+	return 0;
+}
+
+int komeda_build_layer_data_flow(struct komeda_layer *layer,
+				 struct komeda_plane_state *kplane_st,
+				 struct komeda_crtc_state *kcrtc_st,
+				 struct komeda_data_flow_cfg *dflow)
+{
+	struct drm_plane *plane =3D kplane_st->base.plane;
+	struct komeda_pipeline *pipe =3D layer->base.pipeline;
+	int err;
+
+	DRM_DEBUG_ATOMIC("%s handling [PLANE:%d:%s]: src[x/y:%d/%d, w/h:%d/%d] di=
sp[x/y:%d/%d, w/h:%d/%d]",
+			 layer->base.name, plane->base.id, plane->name,
+			 dflow->in_x, dflow->in_y, dflow->in_w, dflow->in_h,
+			 dflow->out_x, dflow->out_y, dflow->out_w, dflow->out_h);
+
+	err =3D komeda_layer_validate(layer, kplane_st, dflow);
+	if (err)
+		return err;
+
+	err =3D komeda_compiz_set_input(pipe->compiz, kcrtc_st, dflow);
+
+	return err;
+}
--=20
2.17.1

