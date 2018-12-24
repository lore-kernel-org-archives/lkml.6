Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD12C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA75E218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="HfzMe6mG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbeLXJQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:16:29 -0500
Received: from mail-eopbgr10078.outbound.protection.outlook.com ([40.107.1.78]:38314
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbeLXJQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quxklvEw/Arg0zfXAeyx4mn6z6grKPNoHrZ06K7DV7A=;
 b=HfzMe6mGCKdrKRUjxThxTk8nVW2gL2JPpELguocWESZZrqz1zigVvD/BMs5JiCYsQBmAPSfRYeoDfGLmnAI68HoOqSsmLM2jt7+xD7TuQPBnquJXVpPOohk+jkPR69+BtcJ8jU+r7zy2a2Gy73/7ska5Ep8kOdgI6wVKBQox9yg=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0183.eurprd08.prod.outlook.com (10.161.35.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Mon, 24 Dec 2018 09:16:22 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:16:22 +0000
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
Subject: [PATCH 5/5] drm/komeda: Add komeda_plane/plane_helper_funcs
Thread-Topic: [PATCH 5/5] drm/komeda: Add komeda_plane/plane_helper_funcs
Thread-Index: AQHUm2lW2VHhssSqN0G4mdVQH4ekOw==
Date:   Mon, 24 Dec 2018 09:16:22 +0000
Message-ID: <20181224091450.2643-6-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0183;6:57uAXk9t7s+qeRPXx8qoMsywMBxEplrR0jKrz9Nv47EjmfdodzohZnviWRv20mj9qUWckn7zsbaBm/0O2WCFL5xThkhmf20D5VAEbpCJB0ziAHtiGt2RoYnn4h+hyKqNEIf0D+4qVJ5osRMReiAx4Hidr1m/10XrxTORGPIF3lSH3M2Cu2oufGJwnDF4uQB3RMMemVfvUIn+W+m6ZwjO3CjkK1RUMS253p2UdMCwT32IuI+8J8wyOIBQ+2YxI3/4zKrf6WUFdbER15pUux0uqyvKOxgYMgF/9XTYSEOdW13fuk85eiQSNTXFrMjggrtlEUn/N9SWNXGgbsr3TvSBPMJo0MHg/CytD+a2TNF2b0C06oI13ZduoiOj2Y/Hn4eVW+MwQTGWb04ftaJIgJNg7Y6cJyKE+oh1e00qsJYwOq6rdlO2jrAiJD5uACtoX+svIzUm4BCtII21NHhCcVW5Ow==;5:JM+Lc1AjY/P73KlIFVJBPYjC+IZpDT0DQvEgAsQnEzadxsaF05NhfFk62pEbI92r7twtqiDzZEZQwp31uDSLIwBDeblrftiBzjjFIxpWqZ/EjQZAI5Pr0fF15PCrwXdEOMivTA/Xdwc2Tf9DVqXYHGoec5ZDg/ouuvgbCC/QLmA=;7:w/45rHemOmNvUMA7flV50z1q/DI/ChcNWSHRZaSUM/jvN2/UdwMBZEdMmOswgt782ckJXdROu81BgPq1mOfYvxkDR8kt0iKofKxqDMJnpBfx9xb0TkvgYW5GtymFJrFWKs6GEziVAwr7+NcxrOqbBw==
x-ms-office365-filtering-correlation-id: a8c5d520-dba2-4ace-dab5-08d669807886
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0183;
x-ms-traffictypediagnostic: AM3PR08MB0183:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB01839D71C6B3AF69D2DC2045B3BB0@AM3PR08MB0183.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0183;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0183;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39850400004)(346002)(376002)(189003)(199004)(5660300001)(54906003)(7736002)(37006003)(256004)(14444005)(6862004)(4326008)(316002)(55236004)(386003)(86362001)(106356001)(14454004)(6506007)(186003)(99286004)(2906002)(105586002)(8936002)(97736004)(76176011)(36756003)(476003)(2616005)(71200400001)(478600001)(1076003)(6486002)(486006)(81156014)(71190400001)(3846002)(26005)(52116002)(68736007)(6116002)(6436002)(11346002)(8676002)(446003)(25786009)(305945005)(102836004)(103116003)(6636002)(81166006)(53936002)(6512007)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0183;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sKCdyduL+1SZ3asyZG7wtSkAc6uXIAXiK0xdA0u/0z7RtPHcTd4i1djYZfUjLLFTZbFBhFZO33SAAk3wFCjUmstQTtFeAVPjDQ+fjgWLJGZkz4zvyPf8srMDEoC08QcsjwulCDjPOk/KzawUqQ6h+hAGIVI38VJnA4qEvWWFWNVOvhRTk0RJMLkCtqMGgomLZyqlbDfGuGCYf61FLN3w+KdxB3iHgve/jTRZiPIojbjEvzAYsC10fPTRQpBDynbjTsyfS1aSLx+OieBgklH3ffUtgVMp26k5XXe49lsB18SeKs9gtDQfPcVilaIcc6RE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c5d520-dba2-4ace-dab5-08d669807886
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:16:22.2121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per komeda design KMS-plane maps to komeda layer input pipeline.
komeda_plane_atomic_check is for building a komeda layer input pipeline.

And KMS-plane is only a user of komeda resources. so there is no real HW
update for plane, but all HW update will be handled in crtc->flush.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_plane.c | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_plane.c
index 0a4953a9a909..522bdddd0600 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -10,7 +10,83 @@
 #include "komeda_dev.h"
 #include "komeda_kms.h"
=20
+int komeda_prepare_viewport(struct drm_plane_state *st,
+			    struct komeda_layer_viewport *view)
+{
+	struct drm_framebuffer *fb =3D st->fb;
+
+	memset(view, 0, sizeof(*view));
+
+	view->blending_zorder =3D st->zpos;
+
+	/* if format doesn't have alpha, fix blend mode to PIXEL_NONE */
+	view->pixel_blend_mode =3D fb->format->has_alpha ?
+		st->pixel_blend_mode : DRM_MODE_BLEND_PIXEL_NONE;
+	view->layer_alpha =3D st->alpha >> 8;
+
+	view->out_x =3D st->crtc_x;
+	view->out_y =3D st->crtc_y;
+	view->out_w =3D st->crtc_w;
+	view->out_h =3D st->crtc_h;
+
+	view->in_x =3D st->src_x >> 16;
+	view->in_y =3D st->src_y >> 16;
+	view->in_w =3D st->src_w >> 16;
+	view->in_h =3D st->src_h >> 16;
+
+	return 0;
+}
+
+int komeda_plane_atomic_check(struct drm_plane *plane,
+			      struct drm_plane_state *state)
+{
+	struct komeda_plane *kplane =3D to_kplane(plane);
+	struct komeda_plane_state *kplane_st =3D to_kplane_st(state);
+	struct komeda_layer *layer =3D kplane->layer;
+	struct drm_crtc_state *crtc_st;
+	struct komeda_crtc *kcrtc;
+	struct komeda_crtc_state *kcrtc_st;
+	struct komeda_layer_viewport view;
+	struct komeda_component_output dflow;
+	int err;
+
+	if (!state->crtc || !state->fb)
+		return 0;
+
+	crtc_st =3D drm_atomic_get_crtc_state(state->state, state->crtc);
+	if (!crtc_st->enable) {
+		DRM_DEBUG_ATOMIC("Cannot update plane on a disabled CRTC.\n");
+		return -EINVAL;
+	}
+
+	/* crtc is inactive, skip the resource assignment */
+	if (!crtc_st->active)
+		return 0;
+
+	kcrtc =3D to_kcrtc(state->crtc);
+	kcrtc_st =3D to_kcrtc_st(crtc_st);
+
+	err =3D komeda_prepare_viewport(state, &view);
+	if (err)
+		return err;
+
+	err =3D komeda_build_layer_data_flow(layer, &dflow,
+					   kplane_st, kcrtc_st, &view);
+
+	return err;
+}
+
+/* plane doesn't represent a real HW, so there is no HW update for plane.
+ * komeda handles all the HW update in crtc->atomic_flush
+ */
+void komeda_plane_atomic_update(struct drm_plane *plane,
+				struct drm_plane_state *old_state)
+{
+}
+
 static const struct drm_plane_helper_funcs komeda_plane_helper_funcs =3D {
+	.atomic_check	=3D komeda_plane_atomic_check,
+	.atomic_update	=3D komeda_plane_atomic_update,
 };
=20
 static void komeda_plane_destroy(struct drm_plane *plane)
@@ -20,7 +96,60 @@ static void komeda_plane_destroy(struct drm_plane *plane=
)
 	kfree(to_kplane(plane));
 }
=20
+static void komeda_plane_reset(struct drm_plane *plane)
+{
+	struct komeda_plane_state *state;
+	struct komeda_plane *kplane =3D to_kplane(plane);
+
+	if (plane->state)
+		__drm_atomic_helper_plane_destroy_state(plane->state);
+
+	kfree(plane->state);
+	plane->state =3D NULL;
+
+	state =3D kzalloc(sizeof(*state), GFP_KERNEL);
+	if (state) {
+		state->base.rotation =3D DRM_MODE_ROTATE_0;
+		state->base.pixel_blend_mode =3D DRM_MODE_BLEND_PREMULTI;
+		state->base.alpha =3D DRM_BLEND_ALPHA_OPAQUE;
+		state->base.zpos =3D kplane->layer->base.id;
+		plane->state =3D &state->base;
+		plane->state->plane =3D plane;
+	}
+}
+
+static struct drm_plane_state *
+komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
+{
+	struct komeda_plane_state *new;
+
+	if (WARN_ON(!plane->state))
+		return NULL;
+
+	new =3D kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	__drm_atomic_helper_plane_duplicate_state(plane, &new->base);
+
+	return &new->base;
+}
+
+static void
+komeda_plane_atomic_destroy_state(struct drm_plane *plane,
+				  struct drm_plane_state *state)
+{
+	__drm_atomic_helper_plane_destroy_state(state);
+	kfree(to_kplane_st(state));
+}
+
 static const struct drm_plane_funcs komeda_plane_funcs =3D {
+	.update_plane		=3D drm_atomic_helper_update_plane,
+	.disable_plane		=3D drm_atomic_helper_disable_plane,
+	.destroy		=3D komeda_plane_destroy,
+	.reset			=3D komeda_plane_reset,
+	.atomic_duplicate_state	=3D komeda_plane_atomic_duplicate_state,
+	.atomic_destroy_state	=3D komeda_plane_atomic_destroy_state,
 };
=20
 /* for komeda, which is pipeline can be share between crtcs */
--=20
2.17.1

