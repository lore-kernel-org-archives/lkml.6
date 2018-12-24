Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A2DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A95D21773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="E1/Pdcw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeLXI7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:59:12 -0500
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:46816
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbeLXI7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cou5Umw+HlGUGmelTbtU2z4MxKphzGCqY+ts9yPpPVY=;
 b=E1/Pdcw06VttCguIfUFo0eNsU4kqf9tzKn18HE6YqI30t/cOkPsqPBVsZjiKcB1hWHAdEsdKTwvLAN/+TMCS2R33GpTc7HLizieonhQ47+Bs59yP3x8IeMZZE946FohDrn/f3SuPaK8yX+5ymClnWAM50bb+skiKtgMtollo7Zs=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0609.eurprd08.prod.outlook.com (10.163.188.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Mon, 24 Dec 2018 08:59:06 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 08:59:06 +0000
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
Subject: [PATCH 3/7] arm/komeda: Add d71 compiz component
Thread-Topic: [PATCH 3/7] arm/komeda: Add d71 compiz component
Thread-Index: AQHUm2bsfRm5zI8VskaR6w9e6TuVrw==
Date:   Mon, 24 Dec 2018 08:59:06 +0000
Message-ID: <20181224085716.2325-4-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0609;6:08+2xenuawVD8e1IIYtO9c/6IpZOaxlnPc6aLjiRJb6ZGiOwe2KmfOCW8+E9cgaSZwZA9BMh0kBmvJQhlRQcqGATraqyDEJ6GqvOu2rrFc6YfWJsIjsSnFjrIlxxo8uvkkKtUysWTG4a/tPynTwHghjGBfO4hc7q6ozNwNy5fWu+yIc0ULeA0FQdk7+Zv/7yWkLnYuTiBC/1Jc8vrCHLRR/1AeHbcX1dF3GypliJGqBb3KSlG2eVO2+PddjYtcp8Vh037VdgnzbBlzN+Jz+eHKn8EvMqdToGZu7MK+tSG1VCae5NgQLyvx0LUyDoHKxEv3GA/mFzB/Onx9DMJYP3XhuFrfA2A/cPzDBXIuC+y9GNoHBTQo5JYHKaOFzun2xHafXMrob4IwneyCtuamAi31L4Bio1PQM47XU6NDz5FZ6yXezclZfloo8E6v1k6DhaEiwPbVdNqv4YNV5G0yGmSw==;5:Fn4QVGSzGmWiIA2mVcogXQQi0twP8nFbxGwvVAykkndUNifQFNOGOQ9M/5eHeOaLlop64e/Rcd5PrhlkMtyS9MksbQUy5QrZ63Q2Kzbll6lF7VkHolxYgfOZw1muq9aVNKlWNF+EQlfYDBCf4sckQeaTErgx3mguqMSqLQhMatQ=;7:/hEONyeqVivsKBplqEmouunclC9PCs78CmhSLfOWVw9yICNP/OO4l0xEe1UqgRoglQyHpmFLZQE3WApX0zzc+TNAnGRSSYBVYcaG7JY6ljovea/1voZgqKorGQ8ovP6jEIQwt9AoL1Tvw1nR37utUQ==
x-ms-office365-filtering-correlation-id: 1abbb723-8693-49ba-08e3-08d6697e0f3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0609;
x-ms-traffictypediagnostic: AM3PR08MB0609:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB06094A7AD42C168A5DEC4608B3BB0@AM3PR08MB0609.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0609;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0609;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(136003)(366004)(376002)(189003)(199004)(66066001)(386003)(102836004)(305945005)(53936002)(3846002)(6116002)(6506007)(1076003)(5660300001)(478600001)(7736002)(186003)(97736004)(103116003)(6512007)(11346002)(68736007)(14454004)(71190400001)(55236004)(71200400001)(6636002)(446003)(99286004)(476003)(2616005)(76176011)(36756003)(486006)(4326008)(2906002)(6862004)(316002)(256004)(8936002)(25786009)(54906003)(37006003)(26005)(52116002)(8676002)(14444005)(81166006)(106356001)(86362001)(105586002)(6436002)(6486002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0609;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1dBbY9ndKzUt/qXn0IWcBGy6iWXAoLBKozB2Lq1adw16cB7RF83UTfMwKJvCxSVusByvwu1fc87mhm4B8Z+x3+OAH2QWhM09Qi0G6k7Fl82sWGp9ioeU/xyoolWfjjR6W0S9PtEf21dTaX4J15H2O/1wiUIyw5pgWgmp5EHbOjbLttK7CZJBA3Tzz1cRdw1o8be3UMdfMMAajIuSMm8RC+k4bSw118NH6SiOrDkEGG5tv9HG2dhXfe5USLQqAVCOocqI5RoDpKH3MYf2HrufieNWLtl10UdJE4lnpfsGFHoKTK1mfcPDdnln9T45OSh/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abbb723-8693-49ba-08e3-08d6697e0f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 08:59:06.5550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement d71_compiz_init and add compiz component to komeda-CORE

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    | 95 ++++++++++++++++++-
 .../drm/arm/display/komeda/komeda_pipeline.h  | 26 +++--
 2 files changed, 113 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index 0e8ae7b00d14..5458df726b08 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -96,6 +96,14 @@ static u32 to_rot_ctrl(u32 rot)
 	return lr_ctrl;
 }
=20
+static inline u32
+to_d71_input_id(struct komeda_component_output *output)
+{
+	struct komeda_component *comp =3D output->component;
+
+	return comp ? (comp->hw_id + output->output_port) : 0;
+}
+
 static void d71_layer_disable(struct komeda_component *c)
 {
 	malidp_write32_mask(c->reg, BLK_CONTROL, L_EN, 0);
@@ -184,10 +192,95 @@ static int d71_wb_layer_init(struct d71_dev *d71,
 	return 0;
 }
=20
+static void d71_component_disable(struct komeda_component *c)
+{
+	u32 __iomem *reg =3D c->reg;
+	u32 i;
+
+	malidp_write32(reg, BLK_CONTROL, 0);
+
+	for (i =3D 0; i < c->max_active_inputs; i++)
+		malidp_write32(reg, BLK_INPUT_ID0 + (i << 2), 0);
+}
+
+static void compiz_enable_input(u32 __iomem *id_reg,
+				u32 __iomem *cfg_reg,
+				u32 input_hw_id,
+				struct komeda_compiz_input_cfg *cin)
+{
+	u32 ctrl =3D CU_INPUT_CTRL_EN;
+	u8 blend =3D cin->pixel_blend_mode;
+
+	if (blend =3D=3D DRM_MODE_BLEND_PIXEL_NONE)
+		ctrl |=3D CU_INPUT_CTRL_PAD;
+	else if (blend =3D=3D DRM_MODE_BLEND_PREMULTI)
+		ctrl |=3D CU_INPUT_CTRL_PMUL;
+
+	ctrl |=3D CU_INPUT_CTRL_ALPHA(cin->layer_alpha);
+
+	malidp_write32(id_reg, BLK_INPUT_ID0, input_hw_id);
+
+	malidp_write32(cfg_reg, CU_INPUT0_SIZE,
+		       HV_SIZE(cin->hsize, cin->vsize));
+	malidp_write32(cfg_reg, CU_INPUT0_OFFSET,
+		       HV_OFFSET(cin->hoffset, cin->voffset));
+	malidp_write32(cfg_reg, CU_INPUT0_CONTROL, ctrl);
+}
+
+static void d71_compiz_update(struct komeda_component *c,
+			      struct komeda_component_state *state)
+{
+	struct komeda_compiz_state *st =3D to_compiz_st(state);
+	u32 __iomem *reg =3D c->reg;
+	u32 __iomem *id_reg, *cfg_reg;
+	u32 index, input_hw_id;
+
+	for_each_changed_input(state, index) {
+		id_reg =3D reg + index;
+		cfg_reg =3D reg + index * CU_PER_INPUT_REGS;
+		input_hw_id =3D to_d71_input_id(&state->inputs[index]);
+		if (state->active_inputs & BIT(index)) {
+			compiz_enable_input(id_reg, cfg_reg,
+					    input_hw_id, &st->cins[index]);
+		} else {
+			malidp_write32(id_reg, BLK_INPUT_ID0, 0);
+			malidp_write32(cfg_reg, CU_INPUT0_CONTROL, 0);
+		}
+	}
+
+	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
+}
+
+struct komeda_component_funcs d71_compiz_funcs =3D {
+	.update		=3D d71_compiz_update,
+	.disable	=3D d71_component_disable,
+};
+
 static int d71_compiz_init(struct d71_dev *d71,
 			   struct block_header *blk, u32 __iomem *reg)
 {
-	DRM_INFO("Detect D71_compiz.\n");
+	struct komeda_component *c;
+	struct komeda_compiz *compiz;
+	u32 blk_id =3D BLOCK_INFO_BLK_ID(blk->block_info);
+	u32 pipe_id, comp_id;
+
+	get_resources_id(blk->block_info, &pipe_id, &comp_id);
+
+	c =3D komeda_component_add(&d71->pipes[pipe_id]->base, sizeof(*compiz),
+				 comp_id,
+				 BLOCK_INFO_INPUT_ID(blk->block_info),
+				 &d71_compiz_funcs,
+				 CU_NUM_INPUT_IDS, get_valid_inputs(blk),
+				 CU_NUM_OUTPUT_IDS, reg,
+				 "CU%d", blk_id);
+
+	if (!c)
+		return -1;
+
+	compiz =3D to_compiz(c);
+
+	set_range(&compiz->hsize, D71_MIN_LINE_SIZE, d71->max_line_size);
+	set_range(&compiz->vsize, D71_MIN_VERTICAL_SIZE, d71->max_vsize);
=20
 	return 0;
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index b8cf502982fb..22baeb5e1b61 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -206,6 +206,10 @@ static inline u16 component_changed_inputs(struct kome=
da_component_state *st)
 	return component_disabling_inputs(st) | st->changed_active_inputs;
 }
=20
+#define for_each_changed_input(st, i)	\
+	for ((i) =3D 0; (i) < (st)->component->max_active_inputs; (i)++)	\
+		if (has_bit((i), component_changed_inputs(st)))
+
 #define to_comp(__c)	(((__c) =3D=3D NULL) ? NULL : &((__c)->base))
 #define to_cpos(__c)	((struct komeda_component **)&(__c))
=20
@@ -225,23 +229,31 @@ struct komeda_layer_state {
 	dma_addr_t addr[3];
 };
=20
-struct komeda_compiz {
+struct komeda_scaler {
 	struct komeda_component base;
-	/* compiz specific features and caps */
+	/* scaler features and caps */
 };
=20
-struct komeda_compiz_state {
+struct komeda_scaler_state {
 	struct komeda_component_state base;
-	/* compiz specific configuration state */
 };
=20
-struct komeda_scaler {
+struct komeda_compiz {
 	struct komeda_component base;
-	/* scaler features and caps */
+	struct malidp_range hsize, vsize;
 };
=20
-struct komeda_scaler_state {
+struct komeda_compiz_input_cfg {
+	u16 hsize, vsize;
+	u16 hoffset, voffset;
+	u8 pixel_blend_mode, layer_alpha;
+};
+
+struct komeda_compiz_state {
 	struct komeda_component_state base;
+	/* composition size */
+	u16 hsize, vsize;
+	struct komeda_compiz_input_cfg cins[KOMEDA_COMPONENT_N_INPUTS];
 };
=20
 struct komeda_improc {
--=20
2.17.1

