Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFB8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FF6218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GiQCQtev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfAVJYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:24:12 -0500
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:18912
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727802AbfAVJYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaEUGmfHQb3z12VtFozbY7DD2i65C7L8jxbSX7EscOE=;
 b=GiQCQtevOPpuD/zr7lVv+1fhYEAI9d0F+S5XQt5Dlf2EcBgewvDlPbDwknONClY8NvxJ4IDP9rSTxnJZnFd/AUk3g0Ri77W29qzYf/rbKHQnyuLhc7D9vHfYDog1hN5wPfkmuHF2xg0pH1C61pSrBK32FRAoGrX8wDL/QBDZcaU=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1928.eurprd08.prod.outlook.com (10.168.83.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.28; Tue, 22 Jan 2019 09:23:49 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:23:49 +0000
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
Subject: [PATCH v2 2/7] drm/komeda: Add d71 layer
Thread-Topic: [PATCH v2 2/7] drm/komeda: Add d71 layer
Thread-Index: AQHUsjQvnEwQcovBN0S9GJvUhejHpA==
Date:   Tue, 22 Jan 2019 09:23:49 +0000
Message-ID: <20190122092243.21226-3-james.qian.wang@arm.com>
References: <20190122092243.21226-1-james.qian.wang@arm.com>
In-Reply-To: <20190122092243.21226-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYCPR01CA0039.ausprd01.prod.outlook.com
 (2603:10c6:10:e::27) To DB6PR0801MB1990.eurprd08.prod.outlook.com
 (2603:10a6:4:6c::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1928;6:3ube1oRMrx6CuFwknQd8RpeDZKCJf+C1IoVw5trnGZsXAH/jYpQud+nZVHH2Olp4A3BQ5fgw1RbdQDNRBA9dIvbExMr2z8HUmntBTdS4quL53vHKZQSxH6xAbNagZ8aNIP5LM+kksE9CLGwDq5aayuZW5b6wG6C9VK0ncOUghme9YsXkGWIhsm8Z7kiLojALNI8IIV0zl2K1ulKAmQ/apRhy6RZ89qekJzZN5r+PLhuY1NdoJpOFQTF59b1Abbrmr2IS8n1CIr2S2UM26/6PzkK1TP/MQc0AYvWEU1YRM0CaXiNpyMD0OHgUbetGhxDl8gK6TV5D7/QQrPGNNYfVCA7RUZHrzUjDBk6/s8PwpFmRELnM0PIR+F1xUJFUbxh47MFrOEt5LHA8I6qiTYAEz9/wah6KnGVOFyCjj9mCaibBGw/y+B44GRiKhvvDuLb5MU54Sb23AaT4Mwx43IlgRw==;5:rGpf+d/26RZxPgQY5MzUndRUstD/ZyLAFXL6fcs+0pQhpFeFXA8jWvFtWUwd5inre8HD4Ep8Z344m4raUZIoVBmwqKfKvt+qQqwGazgg2BMto8MtJU5Ix4OJcdJvQdxImBMqhjWzlmOaOxW0/5bjEvQfB+BQ5OZz46h1pv9lBNE0FW26waKDYRTmWMqZU/0yc75zqlzrZzv2a61AFIvOVw==;7:u/kCVIRJ6kNnEBWmmooHFiimgebCL9x7Dp9DPtyEfpZFxbAPrSZ2TYmads52JdI708ihCM+o6K8HHcBZTCKGuIIdpcSnoX6vIVvO2juK7J2YtrAmzyNrnktB8QycvWVhvl4R6Rm5/uAL8SWSDnJg1Q==
x-ms-office365-filtering-correlation-id: e2c98aa5-b3c5-44c2-48e1-08d6804b513c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1928;
x-ms-traffictypediagnostic: DB6PR0801MB1928:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1928DF17001CC14417CA2C6CB3980@DB6PR0801MB1928.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(3846002)(76176011)(99286004)(26005)(486006)(6116002)(71200400001)(110136005)(2906002)(71190400001)(316002)(103116003)(256004)(305945005)(14444005)(7736002)(53936002)(81166006)(8676002)(81156014)(54906003)(6436002)(6486002)(50226002)(2501003)(66066001)(68736007)(6512007)(106356001)(105586002)(52116002)(6346003)(8936002)(1076003)(4326008)(6636002)(476003)(97736004)(2616005)(478600001)(446003)(86362001)(102836004)(11346002)(14454004)(6506007)(386003)(186003)(55236004)(36756003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1928;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oJkkx2VaBNcKalcDSQg1TfCwQ0sjM9NAkj7aztWE+YeATgbwosmKBX+ta2me9R2qstxgNk151Nc3SR3hzjoSwbR63Vv8Guh0HwPvdgNBwFPOnUCeHA8L4fmceiT7XBdtA0YkbWa9zdpGEmeU7rh44GmQL/9+BjUmJTOOywCQZ6ori/GFNagEzuEPoJ4HvAzuprPfmQRZbrChnKTcFNR98SO185h57pf1/AhlAPfdcvaVqfhRR3hEkDp01hItPfYKjjeODBWbBZM4wtA03ySa6zkMUEMAHZxzeVRSq1LYUx0JFbMR1lwdD7e9dr7ciTZYjmTaPW87Y8v4UeVyhDBocEu56WPBraAjFjIbI4HVRYcXHNGXQMmHtNjVD+mOP0eQozv7ni7qHrYqIxFglraIu7gm/2v2U7rjmaj9m+KGkUQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c98aa5-b3c5-44c2-48e1-08d6804b513c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:23:41.1904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1928
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

1. Add detailed layer/layer_state definitions
2. Add d71_layer_init to report layer features and capabilities according
   to D71 layer block.
3. Add d71_layer_updat/disable

v2: Rebase.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../drm/arm/display/include/malidp_utils.h    |  17 ++
 .../arm/display/komeda/d71/d71_component.c    | 162 +++++++++++++++++-
 .../drm/arm/display/komeda/komeda_pipeline.h  |  10 +-
 3 files changed, 185 insertions(+), 4 deletions(-)

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
index 18a36dd71567..0a602e875f5e 100644
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
-	DRM_DEBUG("Detect D71_Layer.\n");
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
+	if (IS_ERR(c)) {
+		DRM_ERROR("Failed to add layer component\n");
+		return PTR_ERR(c);
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
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 8c950bc8ae96..03525330efe8 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -207,16 +207,20 @@ static inline u16 component_changed_inputs(struct kom=
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

