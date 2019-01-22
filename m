Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E829C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2532420879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aZZIHI1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfAVLGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:06:41 -0500
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:63488
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727624AbfAVLG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVCuN+Rgl6qxxikjUjUjHSDdemOyZgdyD7gXhJX8W+0=;
 b=aZZIHI1X/R6sataDpBohjY8I2FQyiUlA6k6jeWLI2Au9/NZWwlArykW2TwBvx5p6/C8ZlZ7P4//RE7n8NAR/K2WACWXjXdASwR+U4Q+LlmmeZBpJ34ZewVMIiUSv3Rr2idve2cyGmOOitV11KIWZBFN+WPDduOoKiqNQvarzaUI=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1989.eurprd08.prod.outlook.com (10.168.85.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Tue, 22 Jan 2019 11:06:22 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:06:22 +0000
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
Subject: [PATCH v2 5/5] drm/komeda: Add komeda_plane/plane_helper_funcs
Thread-Topic: [PATCH v2 5/5] drm/komeda: Add komeda_plane/plane_helper_funcs
Thread-Index: AQHUskKCF0KwCqI+2kmiQGQ+rCgcTg==
Date:   Tue, 22 Jan 2019 11:06:22 +0000
Message-ID: <20190122110431.5025-6-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1989;6:546P6yePM7Uzq5fvXhQo2UexgFAVmk6bIzWvFc26303jB2aLmHPQmg7sY0DFixxmiKzAYk7qIZzgiGlqAHcHwpNwFk+L5j0OdG5IxrboCo93aMcuNJsASS0ZD5GYQwgFIxtoy2cCXc9ORdSwy5s/4HyE5CDnzWCe3AR1hL3oUzmciWAZbNfc8BqsI55zTaKhyej/P1uicpCCyJdidbZySyCcgcWKgLpgSocCOyHopo7FMqTArhqZEaWtcLp/BjTKbtSsUio/w5np2VQAzVxCU+eunPWZcj8TXsHYXw6w8AlU1LlJN4lrgiwRvGMg8mqJzVCy0b16eY8fu0TsygKWf3cjCgReWqbVSpd86aWhH49+n70mYD3FK7zKykz11oM71oZX9KSHlP5gtjqU0h7UGxsvUAVJ9PjUSf7On6J3zEn0ICsQVdk3hO7l3XCaKN9TntmHb0hAgNDv7OE6hgOjVw==;5:8i4bynMZg9Y3MOmqpodaKmZ/R+XLcS0c3If8bdTtti7gF8+XBmtP0/464S76Zlk2XL4iB0t0okSXv9Y8jrOrVXefAPH264PbuA3HmuCJpGGVdtVYriLi7MbM1yx2pna9XW3h7M/crRVQWg46y7zi3n/E7Gw0CHLthDEL6BejycKsGneCRVeZw/LG8ENygkh6eUeA+63/sicSGQyxWhnKzg==;7:1pJcMUQ0PqtgXfzSK7s4JWYb1y0+IGKXUcafVNQiCGWzWlcQmrpx7CzJplPTXt3avMYVxxqUPHLoVyupznlfncpfgmrV4lYz5e5T7VRiWL7qJY89AkgFNUFylxDmGiudYhGaH1n387enbBCNWH9XPw==
x-ms-office365-filtering-correlation-id: aaeb320f-ff82-48b5-8979-08d68059a467
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1989;
x-ms-traffictypediagnostic: DB6PR0801MB1989:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB19894E5C0921C8F32E68107BB3980@DB6PR0801MB1989.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(4326008)(106356001)(105586002)(316002)(25786009)(2501003)(8936002)(256004)(14444005)(2201001)(1076003)(86362001)(52116002)(53936002)(2906002)(54906003)(110136005)(478600001)(14454004)(6512007)(99286004)(26005)(102836004)(55236004)(97736004)(36756003)(386003)(6506007)(66066001)(76176011)(68736007)(2616005)(476003)(81166006)(50226002)(186003)(11346002)(6116002)(3846002)(7736002)(486006)(103116003)(8676002)(6486002)(305945005)(71190400001)(71200400001)(6436002)(446003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1989;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LzeDApEPeEhZ9GzyzOcjBsF9sKDAazNwX9vPATiHauEXf8noTISPooTVrlMK7/osCjtQmNjGvxd/o4yndN6fVpenBzd0qT3E+BpazXyiPxFVVYdv1RWjb9uEoQ75lc30K3kTJNW8JYT2PW/wMDDh+hJWVVDgQ6dlCozLSADcCIiWx8KgSaYmLWRJN/eKBYVWbUqONlkRiW725EHa036VEWELwXnrMJ1MpoFleP+VlEHnJWmK5+bvgW/HwRTCQeRrgwwGOx0pFqJmZFvIYH5IOY95GoGj5ZmX1HobG1rvTa9HmhWZ3sPQ+Txy+0zeHFP0drZRs4/NagsCmExKVJK++H6FrLJO9K4rCJy4BQjodLzMy6dP9kWpDPvlyHLziwsqAQP/Y/t2U+DKFEtEBMgkGPvsqkyUB5MBH5/Yx5hu9Q0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaeb320f-ff82-48b5-8979-08d68059a467
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:06:12.6946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1989
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

Per komeda design KMS-plane maps to komeda layer input pipeline.
komeda_plane_atomic_check is for building a komeda layer input pipeline.

And KMS-plane is only a user of komeda resources. so there is no real HW
update for plane, but all HW update will be handled in crtc->flush.

v2: Rebase

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_plane.c | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_plane.c
index 0a4953a9a909..af51f0cc9c16 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -10,7 +10,82 @@
 #include "komeda_dev.h"
 #include "komeda_kms.h"
=20
+static int
+komeda_plane_init_data_flow(struct drm_plane_state *st,
+			    struct komeda_data_flow_cfg *dflow)
+{
+	struct drm_framebuffer *fb =3D st->fb;
+
+	memset(dflow, 0, sizeof(*dflow));
+
+	dflow->blending_zorder =3D st->zpos;
+
+	/* if format doesn't have alpha, fix blend mode to PIXEL_NONE */
+	dflow->pixel_blend_mode =3D fb->format->has_alpha ?
+		st->pixel_blend_mode : DRM_MODE_BLEND_PIXEL_NONE;
+	dflow->layer_alpha =3D st->alpha >> 8;
+
+	dflow->out_x =3D st->crtc_x;
+	dflow->out_y =3D st->crtc_y;
+	dflow->out_w =3D st->crtc_w;
+	dflow->out_h =3D st->crtc_h;
+
+	dflow->in_x =3D st->src_x >> 16;
+	dflow->in_y =3D st->src_y >> 16;
+	dflow->in_w =3D st->src_w >> 16;
+	dflow->in_h =3D st->src_h >> 16;
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
+	struct komeda_data_flow_cfg dflow;
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
+	err =3D komeda_plane_init_data_flow(state, &dflow);
+	if (err)
+		return err;
+
+	err =3D komeda_build_layer_data_flow(layer, kplane_st, kcrtc_st, &dflow);
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
@@ -20,7 +95,60 @@ static void komeda_plane_destroy(struct drm_plane *plane=
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

