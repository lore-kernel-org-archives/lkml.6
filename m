Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C900C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD372171F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Dw/UE/gk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeLXI7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:59:04 -0500
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:2496
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbeLXI7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gzZfBlZ6nO8RVoP8VoEFYlwdk6app85jjy/ZuonF60=;
 b=Dw/UE/gkFKJ3f2oTWxzWTAMOSJI7nvGzfFPAsaCRAZIFYdciVxoYV8YcKVWvTBHjEQeFu0VWHOEsieXITYz9DudEzFeYVXvB6yqRqgcuTa3hMcjnWqwfQx3sHP+VNeTzg6O0z11/0LP3WmTeVdttmlY5y9CkB6PMW3WNLSG8nng=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0609.eurprd08.prod.outlook.com (10.163.188.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Mon, 24 Dec 2018 08:58:57 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 08:58:57 +0000
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 2/7] drm/komeda: Add d71 layer
Thread-Topic: [PATCH 2/7] drm/komeda: Add d71 layer
Thread-Index: AQHUm2bnrnmMrJGwJ0m/wURmPVEiRA==
Date:   Mon, 24 Dec 2018 08:58:56 +0000
Message-ID: <20181224085716.2325-3-james.qian.wang@arm.com>
References: <20181224085716.2325-1-james.qian.wang@arm.com>
In-Reply-To: <20181224085716.2325-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:4::24) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0609;6:k4DPqjG0DB2FOCXrLNtgxd80PKwWYeGsWJiESk2GNHFt58TF/+H1lhZwC9lMb0WWqjDCHYOpHXbm9gLGm2E05nNlVv1WClE5TnehfmPQEyMEG0mcT65gftV50nCAjyJgBD8HGf3EFDl9B73WJgqdByFaySAP4ZMCeZw/OjDoXPeDCtCBL+His/Jzw+EwA/06sWS7EQfNYs2CLntxet0EqgxL1GDuvj1yCKv++HM2zblkRzBqQzVeWZw7ZJtzzTJycfhRBUFGFTOSS49UDjOCCCzP0ZwG+qdzDpnkiNAp+nPzl5i6u2/vj0b//X6erhuSUFR6RO7HlcA23zUoT9+XBevzMVOrwGQQRpGNWnEN2YannIBzooo46vlz94IUqdm3y8JUfLeaqQfQGFdhTZ874dTT6I/bG71EiTcDmfhUpG/evfO50RT5HavnQJFigzvuZdiXVAScyId5ZyMlSTb2ag==;5:lUpQdSiXt/cCtkzsGcp9bUzZM7ohwhc8oERmqociQ1MoCaEtnqY2pBJDt3WDH7ekGadjjQRyas0nmT0iH+rHNM6Uo8s3knuOHhraFyD+JOWLID5lFs7y0rn+S5QYjfSEDU9coYjp3rcqtH4XKD6QK3EO4JWlFtjE6rQDyrxKScA=;7:TNqPDgK01GQInPIPAJrG2Kco7psbpExpRAy8VgBYv83NobBudgOTQzvoqN/Fwl03gnXnPfgvCe/uO6bPYlMyl5CJLHkR0hJZLJEDhl6xvFUxTLoVorSJmLlV4cLri4X/hW5iXsK9RS64B9gyq6heCQ==
x-ms-office365-filtering-correlation-id: b5087b52-d393-42ff-272a-08d6697e0964
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0609;
x-ms-traffictypediagnostic: AM3PR08MB0609:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0609D265D8C27981BA11A416B3BB0@AM3PR08MB0609.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0609;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0609;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(136003)(366004)(376002)(189003)(199004)(66066001)(386003)(102836004)(305945005)(53936002)(3846002)(6116002)(6506007)(1076003)(5660300001)(478600001)(7736002)(186003)(97736004)(103116003)(6512007)(11346002)(68736007)(14454004)(71190400001)(55236004)(71200400001)(6636002)(446003)(99286004)(476003)(2616005)(76176011)(36756003)(486006)(4326008)(2906002)(6862004)(316002)(256004)(8936002)(25786009)(54906003)(37006003)(26005)(52116002)(8676002)(14444005)(81166006)(106356001)(86362001)(105586002)(6436002)(6486002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0609;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q5t0v6kY1iM3bdezRTC0PpHRSquHzh+wtgr8iPYVu+E0be/OvUkrLrgC1emYXvWIiLccpk9jhgkthT6UmBly9TxY/rp09v6apUXIAXp9I8A3L2paNYpsH9RjAJKfwjCH0fMUOlFavGxSF/l0mnXkOJ4hqb3K/9bT+lGg3tREuN4oldoFYD6ZB6UFLiHdYLC3AoV2lnTLhcRsIwjWkWEuu0EFsGZPV+kHc7+Rfx518TfnVnNgQqS9SfUUefYpoFj5KBc1PP2EkdkdhF7STv1SSjZdrJO+L4m/RK5f9L2HXNdZCW5CbF+NF1IXgtd06Zx5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5087b52-d393-42ff-272a-08d6697e0964
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 08:58:56.9702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add detailed layer/layer_state definitions
2. Add d71_layer_init to report layer features and capabilities according
   to D71 layer block.
3. Add d71_layer_updat/disable

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../drm/arm/display/include/malidp_utils.h    |  17 ++
 .../arm/display/komeda/d71/d71_component.c    | 162 +++++++++++++++++-
 .../drm/arm/display/komeda/komeda_pipeline.c  |   2 +-
 .../drm/arm/display/komeda/komeda_pipeline.h  |  10 +-
 4 files changed, 186 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/include/malidp_utils.h b/drivers/g=
pu/drm/arm/display/include/malidp_utils.h
index b7bf8db39a64..e97df5fbc9ea 100644
--- a/drivers/gpu/drm/arm/display/include/malidp_utils.h
+++ b/drivers/gpu/drm/arm/display/include/malidp_utils.h
@@ -25,4 +25,21 @@
 	num_tries;					\
 })
=20
+/* the restriction of range is [start, end] */
+struct malidp_range {
+	u32 start;
+	u32 end;
+};
+
+static inline void set_range(struct malidp_range *rg, u32 start, u32 end)
+{
+	rg->start =3D start;
+	rg->end   =3D end;
+}
+
+static inline bool in_range(struct malidp_range *rg, u32 v)
+{
+	return (v >=3D rg->start) && (v <=3D rg->end);
+}
+
 #endif /* _MALIDP_UTILS_ */
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index a43a2410159f..0e8ae7b00d14 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -7,11 +7,171 @@
 #include "d71_dev.h"
 #include "komeda_kms.h"
 #include "malidp_io.h"
+#include "komeda_framebuffer.h"
+
+static void get_resources_id(u32 hw_id, u32 *pipe_id, u32 *comp_id)
+{
+	u32 id =3D BLOCK_INFO_BLK_ID(hw_id);
+	u32 pipe =3D id;
+
+	switch (BLOCK_INFO_BLK_TYPE(hw_id)) {
+	case D71_BLK_TYPE_LPU_WB_LAYER:
+		id =3D KOMEDA_COMPONENT_WB_LAYER;
+		break;
+	case D71_BLK_TYPE_CU_SPLITTER:
+		id =3D KOMEDA_COMPONENT_SPLITTER;
+		break;
+	case D71_BLK_TYPE_CU_SCALER:
+		pipe =3D id / D71_PIPELINE_MAX_SCALERS;
+		id %=3D D71_PIPELINE_MAX_SCALERS;
+		id +=3D KOMEDA_COMPONENT_SCALER0;
+		break;
+	case D71_BLK_TYPE_CU:
+		id +=3D KOMEDA_COMPONENT_COMPIZ0;
+		break;
+	case D71_BLK_TYPE_LPU_LAYER:
+		pipe =3D id / D71_PIPELINE_MAX_LAYERS;
+		id %=3D D71_PIPELINE_MAX_LAYERS;
+		id +=3D KOMEDA_COMPONENT_LAYER0;
+		break;
+	case D71_BLK_TYPE_DOU_IPS:
+		id +=3D KOMEDA_COMPONENT_IPS0;
+		break;
+	case D71_BLK_TYPE_CU_MERGER:
+		id =3D KOMEDA_COMPONENT_MERGER;
+		break;
+	case D71_BLK_TYPE_DOU:
+		id =3D KOMEDA_COMPONENT_TIMING_CTRLR;
+		break;
+	default:
+		id =3D 0xFFFFFFFF;
+	}
+
+	if (comp_id)
+		*comp_id =3D id;
+
+	if (pipe_id)
+		*pipe_id =3D pipe;
+}
+
+static u32 get_valid_inputs(struct block_header *blk)
+{
+	u32 valid_inputs =3D 0, comp_id;
+	int i;
+
+	for (i =3D 0; i < PIPELINE_INFO_N_VALID_INPUTS(blk->pipeline_info); i++) =
{
+		get_resources_id(blk->input_ids[i], NULL, &comp_id);
+		if (comp_id =3D=3D 0xFFFFFFFF)
+			continue;
+		valid_inputs |=3D BIT(comp_id);
+	}
+
+	return valid_inputs;
+}
+
+static u32 to_rot_ctrl(u32 rot)
+{
+	u32 lr_ctrl =3D 0;
+
+	switch (rot & DRM_MODE_ROTATE_MASK) {
+	case DRM_MODE_ROTATE_0:
+		lr_ctrl |=3D L_ROT(L_ROT_R0);
+		break;
+	case DRM_MODE_ROTATE_90:
+		lr_ctrl |=3D L_ROT(L_ROT_R90);
+		break;
+	case DRM_MODE_ROTATE_180:
+		lr_ctrl |=3D L_ROT(L_ROT_R180);
+		break;
+	case DRM_MODE_ROTATE_270:
+		lr_ctrl |=3D L_ROT(L_ROT_R270);
+		break;
+	}
+
+	if (rot & DRM_MODE_REFLECT_X)
+		lr_ctrl |=3D L_HFLIP;
+	if (rot & DRM_MODE_REFLECT_Y)
+		lr_ctrl |=3D L_VFLIP;
+
+	return lr_ctrl;
+}
+
+static void d71_layer_disable(struct komeda_component *c)
+{
+	malidp_write32_mask(c->reg, BLK_CONTROL, L_EN, 0);
+}
+
+static void d71_layer_update(struct komeda_component *c,
+			     struct komeda_component_state *state)
+{
+	struct komeda_layer_state *st =3D to_layer_st(state);
+	struct drm_plane_state *plane_st =3D state->plane->state;
+	struct drm_framebuffer *fb =3D plane_st->fb;
+	struct komeda_fb *kfb =3D to_kfb(fb);
+	u32 __iomem *reg =3D c->reg;
+	u32 ctrl_mask =3D L_EN | L_ROT(L_ROT_R270) | L_HFLIP | L_VFLIP | L_TBU_EN=
;
+	u32 ctrl =3D L_EN | to_rot_ctrl(st->rot);
+	int i;
+
+	for (i =3D 0; i < fb->format->num_planes; i++) {
+		malidp_write32(reg,
+			       BLK_P0_PTR_LOW + i * LAYER_PER_PLANE_REGS * 4,
+			       lower_32_bits(st->addr[i]));
+		malidp_write32(reg,
+			       BLK_P0_PTR_HIGH + i * LAYER_PER_PLANE_REGS * 4,
+			       upper_32_bits(st->addr[i]));
+		if (i >=3D 2)
+			break;
+
+		malidp_write32(reg,
+			       BLK_P0_STRIDE + i * LAYER_PER_PLANE_REGS * 4,
+			       fb->pitches[i] & 0xFFFF);
+	}
+
+	malidp_write32(reg, LAYER_FMT, kfb->format_caps->hw_id);
+	malidp_write32(reg, BLK_IN_SIZE, HV_SIZE(st->hsize, st->vsize));
+
+	malidp_write32_mask(reg, BLK_CONTROL, ctrl_mask, ctrl);
+}
+
+struct komeda_component_funcs d71_layer_funcs =3D {
+	.update		=3D d71_layer_update,
+	.disable	=3D d71_layer_disable,
+};
=20
 static int d71_layer_init(struct d71_dev *d71,
 			  struct block_header *blk, u32 __iomem *reg)
 {
-	DRM_INFO("Detect D71_Layer.\n");
+	struct komeda_component *c;
+	struct komeda_layer *layer;
+	u32 pipe_id, layer_id, layer_info;
+
+	get_resources_id(blk->block_info, &pipe_id, &layer_id);
+	c =3D komeda_component_add(&d71->pipes[pipe_id]->base, sizeof(*layer),
+				 layer_id,
+				 BLOCK_INFO_INPUT_ID(blk->block_info),
+				 &d71_layer_funcs, 0,
+				 get_valid_inputs(blk),
+				 1, reg, "LPU%d_LAYER%d", pipe_id, layer_id);
+	if (!c) {
+		DRM_ERROR("Failed to add layer component\n");
+		return -EINVAL;
+	}
+
+	layer =3D to_layer(c);
+	layer_info =3D malidp_read32(reg, LAYER_INFO);
+
+	if (layer_info & L_INFO_RF)
+		layer->layer_type =3D KOMEDA_FMT_RICH_LAYER;
+	else
+		layer->layer_type =3D KOMEDA_FMT_SIMPLE_LAYER;
+
+	set_range(&layer->hsize_in, 4, d71->max_line_size);
+	set_range(&layer->vsize_in, 4, d71->max_vsize);
+
+	malidp_write32(reg, LAYER_PALPHA, D71_PALPHA_DEF_MAP);
+
+	layer->supported_rots =3D DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK;
=20
 	return 0;
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.c
index e731b2a85c3a..65b35495d3b7 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -146,7 +146,7 @@ komeda_component_add(struct komeda_pipeline *pipe,
 	}
=20
 	pos =3D komeda_pipeline_get_component_pos(pipe, id);
-	if (!pos || !(*pos))
+	if (!pos || (*pos))
 		return NULL;
=20
 	if (has_bit(id, KOMEDA_PIPELINE_LAYERS)) {
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 114129d96851..b8cf502982fb 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -209,16 +209,20 @@ static inline u16 component_changed_inputs(struct kom=
eda_component_state *st)
 #define to_comp(__c)	(((__c) =3D=3D NULL) ? NULL : &((__c)->base))
 #define to_cpos(__c)	((struct komeda_component **)&(__c))
=20
-/* these structures are going to be filled in in uture patches */
 struct komeda_layer {
 	struct komeda_component base;
-	/* layer specific features and caps */
-	int layer_type; /* RICH, SIMPLE or WB */
+	/* accepted h/v input range before rotation */
+	struct malidp_range hsize_in, vsize_in;
+	u32 layer_type; /* RICH, SIMPLE or WB */
+	u32 supported_rots;
 };
=20
 struct komeda_layer_state {
 	struct komeda_component_state base;
 	/* layer specific configuration state */
+	u16 hsize, vsize;
+	u32 rot;
+	dma_addr_t addr[3];
 };
=20
 struct komeda_compiz {
--=20
2.17.1

