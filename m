Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF20C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236D6218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ym0gPP/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfAVJYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:24:15 -0500
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:18912
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbfAVJYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZVStgTlWgXkzkxos3crILs54IdY1/7ukloJH0LSCWM=;
 b=Ym0gPP/F87FmxnI30ITjmWPZ4KbYmzyQFuAuhhUzgTNSUb1ApOlq7tOfXCB2nclg3EML5kmgZ6JXqswTgoCFcGvgA041ZRCkHyg2nKSmJO+KQ7ZQjUQiD2cAaEG67JFSXV7Y+zDWZiICCbewzqLBF+5IHGNjPTV7t//Wvsbr7qk=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1928.eurprd08.prod.outlook.com (10.168.83.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.28; Tue, 22 Jan 2019 09:23:58 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:23:58 +0000
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
Subject: [PATCH v2 3/7] drm/komeda: Add d71 compiz component
Thread-Topic: [PATCH v2 3/7] drm/komeda: Add d71 compiz component
Thread-Index: AQHUsjQ09T9dOYaWLE+1o11yIp2LBw==
Date:   Tue, 22 Jan 2019 09:23:58 +0000
Message-ID: <20190122092243.21226-4-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1928;6:wzU9GegIw7ZPWVE7AiI58Xcd7lKRxM2cWD+lZA0HyDVmSoU3WOGtFtT+ZBt+6HVqSkO/W/GtzjAYFhgkFCp7Z6arTeAtnapXfNcpaICT5gC2fmXSe0RbwJo/b9+rzD/GrrI19VuI5QcHNl2WCSk4ZF004hZPyTHfi8XmWQUhMon/grGgTnBBOFtILZmZjJvHLk8xwYPJpRCtoWVeoAww2ZJDUfE/SIM/nSJF/YAToN7d1w5/FYuMEHq0lxPCm2JaWx1pMd8qt0RiXFqEjmQOJ47buaTsRyMlSf48FcnF/MfRhUVphdcfYTsE5t2q9aCvWyyNDJxDM3ovca1XfPEYa4tlo6X0MBPOnSNNnVEMvdqI+IHdjSGoagMgVDeCDDruMSsHNXpN0vqYBgZ13EPqS8rdUgkmFMrl1IrDFYZoOuouNkaFuiLYm2BXcGiGUxyqB6W9ufaTYdkWXAeWrASguQ==;5:85Io6gw4KXEBUPnXI/vBAbgaDlKTtva0yBVUr+Q5Q4Md8vMCox9odykLsgU+t+NaesC/myvrHd32mlzx7n4x04Nd/n4F2IDDwcqXHwiy7iNG1h5EPgRSod8qnBzqdSswtnV031keyJqIBlgwY0MRbkXLeQmLmjSWiv6vI6hpRCwV0DnK5njxuK6YL3xlyBf1aJ5C6P5ebCJuXgYMQhdKwA==;7:tfFRA4GErbxMFp8bSOJjj5DDSB0d4yvsAIgtVpQ8qR8F/mZk8OI81/+ibAuxqR1TsFv7U9mV3ZGljGL94uV1FkQ4I+D80YI1ROuckbmOQmpogSX4WOh0Uuh2KQ+IxXSwRs71JPTeLTLnUdxJQUhJdA==
x-ms-office365-filtering-correlation-id: fedb9d32-d471-43cc-464f-08d6804b56aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1928;
x-ms-traffictypediagnostic: DB6PR0801MB1928:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1928B46854F13819D1258FAAB3980@DB6PR0801MB1928.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(3846002)(76176011)(99286004)(26005)(486006)(6116002)(71200400001)(110136005)(2906002)(71190400001)(316002)(103116003)(256004)(305945005)(14444005)(7736002)(53936002)(81166006)(8676002)(81156014)(54906003)(6436002)(6486002)(50226002)(2501003)(66066001)(68736007)(6512007)(106356001)(105586002)(52116002)(6346003)(8936002)(1076003)(4326008)(6636002)(476003)(97736004)(2616005)(478600001)(446003)(86362001)(102836004)(11346002)(14454004)(6506007)(386003)(186003)(55236004)(36756003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1928;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Riq+Ze1Deg8HwHJZKm9mYLmVTy+V/6tVEIbDil3g++RGgW7Z3D3WCXl7UHSsFZMDDu3ItVIMpRzGg4izheVb3qOemwxrEwArxCdCUgzP0d51mR1Q0OgoT7mNjaFBW3s/XPskBIrT9nsAuwok4VDfIp5BHa0KhxcsY3gS3/UkRrVfK+BVcfjt1Nhppj6EoAtlc6pUBOW0ukgMGaxwy/5d1hSfjtTSWaZY+DkZpeelQvneNwZ4V0HoOzhKMKJ40LDjcdTuUNhaNSMMI0lWQa1+OW6bVvcGaah7p3G4ixtZCjbbk92SJPAy9thVTaewt9s8mOvyAtqviOF1ppGyJeJeEWwUNnXS8P8aHi/cS3DRBN9HQ+sVcrOtKyA+U8zI0/5TWn2qUYNALHMD0LHu/vb+vyQnBDP9exL46BDF78SlKSc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedb9d32-d471-43cc-464f-08d6804b56aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:23:50.3311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1928
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

Implement d71_compiz_init and add compiz component to komeda-CORE

v2: Rebase.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../arm/display/komeda/d71/d71_component.c    | 92 ++++++++++++++++++-
 .../drm/arm/display/komeda/komeda_pipeline.h  | 26 ++++--
 2 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index 0a602e875f5e..401053ef0a53 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -96,6 +96,13 @@ static u32 to_rot_ctrl(u32 rot)
 	return lr_ctrl;
 }
=20
+static inline u32 to_d71_input_id(struct komeda_component_output *output)
+{
+	struct komeda_component *comp =3D output->component;
+
+	return comp ? (comp->hw_id + output->output_port) : 0;
+}
+
 static void d71_layer_disable(struct komeda_component *c)
 {
 	malidp_write32_mask(c->reg, BLK_CONTROL, L_EN, 0);
@@ -184,10 +191,93 @@ static int d71_wb_layer_init(struct d71_dev *d71,
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
-	DRM_DEBUG("Detect D71_compiz.\n");
+	struct komeda_component *c;
+	struct komeda_compiz *compiz;
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
+				 "CU%d", pipe_id);
+	if (IS_ERR(c))
+		return PTR_ERR(c);
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
index 03525330efe8..d75cc81ae9c0 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -204,6 +204,10 @@ static inline u16 component_changed_inputs(struct kome=
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
@@ -223,23 +227,31 @@ struct komeda_layer_state {
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

