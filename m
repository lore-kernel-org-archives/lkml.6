Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E035C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9CF218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qc3O+Mea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfAVJYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:24:20 -0500
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:18912
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727802AbfAVJYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uLI7lEqKNHHcfLRAnRhgjzQTYqLzc3fNgVXDhen49c=;
 b=qc3O+MeafKKtbwfujh5Lw7UTXZ3YHe0a7q4rDCH+AlPt8P2lq465jdgtdMzeeR4xejy79nLLTVkdcucE/l1rwibza55gwJ6TYJJS8sJe/2+/keSLVjwvlCaYYK0jo1R16QqbEkgoyZiBXCsF/SlL8a2qwqHNpyhBq45lrWufV3o=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1928.eurprd08.prod.outlook.com (10.168.83.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.28; Tue, 22 Jan 2019 09:24:07 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:24:07 +0000
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
Subject: [PATCH v2 4/7] drm/komeda: Add D71 improc and timing_ctrlr
Thread-Topic: [PATCH v2 4/7] drm/komeda: Add D71 improc and timing_ctrlr
Thread-Index: AQHUsjQ5I/Axu8OgSUmbAN0FI2Xcuw==
Date:   Tue, 22 Jan 2019 09:24:07 +0000
Message-ID: <20190122092243.21226-5-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1928;6:EHdE0uMw48djwwc+GcVTZhHpyrFN3HLLIRZA7f40y7xL7wAbWHHVOgptXYb72T7tGRJ7S+wXqsY0WzoXanq6LqYWdqKRcG6prHqYbo56BXinH45U/KGxlMkATPT0RTL427jdDhnoauUkfMdlUU64D+eankY5IuTMCcdB7Id7Km2QOKiS8jtwAoMAeqIymvMZx/ztRPcCliJzVCjtkk7PqAvZp9okreIwACuJBXWhow3zEqPLhMRUcEwPRP9+xuDMEV/cagQAEGcC/rB5xkfvxn1Kdlj1fZpNfV7ylGmPg+URfgs6h/VMTzai9F5S2AhBcgDFhPSaTaSO4otrzH1YsQHAmPfScVE2lYjuMtNOLg4QmiMiz2Ptrsb+kpOc7B9lcQnFJzi4Ln066/qrV7gQF2UXtPDJQRXLhOlxQUUSiyGFzoYId3+RTc/zdAA5DWtWWz5QNJ9dX3jBNsM4n4WBpA==;5:/GfYOzGKKMjDx/P4DzbCmCXUAgewNWZ7KE2dK0+tFwu66Y7tmUYuU9JpCUJ0lPau5bxntf07Tzq3WVxt8ZmLVS5XyKE6+o3weSS2otBLxWSdKXT6ElbMe5GW9b9xXFOPDgfNW5iXHmZ6VT+N6BLVk/N2rxTxP34U9l1noFjptDqCuuqbZyJ/4BpAA5+hhDeIZRegAm1RxOJ2erIci1HxFA==;7:F6gzNb66VYR47npZs0AXSb1JeFB5wxuY2BA/0RHEOtlxYInIxqbf7XbjABGL51xJbVak+PsVMT5Wcf/EhM0RM+nJnj63XnTof0uNJv3yTuDk1gCudWn1QaewUxPJjIxLoFYNDyGPuKgfkX+7GGRQkw==
x-ms-office365-filtering-correlation-id: e71ea495-2498-4dc6-6c6d-08d6804b5c00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1928;
x-ms-traffictypediagnostic: DB6PR0801MB1928:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB19282D462A0B275FA4A66DF0B3980@DB6PR0801MB1928.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(3846002)(76176011)(99286004)(26005)(486006)(6116002)(71200400001)(110136005)(2906002)(71190400001)(316002)(103116003)(256004)(305945005)(14444005)(7736002)(53936002)(81166006)(8676002)(81156014)(54906003)(6436002)(6486002)(50226002)(2501003)(66066001)(68736007)(6512007)(106356001)(105586002)(52116002)(6346003)(8936002)(1076003)(4326008)(6636002)(476003)(97736004)(2616005)(478600001)(446003)(86362001)(102836004)(11346002)(14454004)(6506007)(386003)(186003)(55236004)(36756003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1928;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ASdPqUdhVJRVi1yVVxD8hsxluxF07Gb525Byyjv6L1/NlqozXsNQpVvvUUgmxLrrbHfW46PmSIWkeG4CdLXe+ixyqlykoqGOlzvf2VUieG+ruBSqfq4n1T3V+9ZHUmYPHtFGo27PQbqa6Ay37wFpcywwkZBMei1v9eEL1yeYWUCWPpmrxtip/UUcbkUYdGCpqyN66kRI9ZYKdTvZCPtz30tzs6U9Dw77JKkV+VKmwHrFIZSHTVlHWU7FmS3x33OtzWNNAquKrkrcbbuYsk46sJUuCGNAW9YsysUAqWiAKMSNGcjtSv6elcD1HiGK2Ica0WOnt60mEE52HUhGtJsVlFPs7dQMRDYHDBiKOGLQrHqKOxTbUc9nFBhjsAeNmX/XWt3t6R8riW8pFlzb+MC7WK2gQPZlsyVcj4QjtwBBt1Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71ea495-2498-4dc6-6c6d-08d6804b5c00
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:23:59.2687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1928
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

Add and initialize improc and timing_ctrlr according to D71 capablitites

v2: Rebase.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../arm/display/komeda/d71/d71_component.c    | 111 +++++++++++++++++-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   2 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |   7 ++
 3 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index 401053ef0a53..095779964518 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -282,18 +282,125 @@ static int d71_compiz_init(struct d71_dev *d71,
 	return 0;
 }
=20
+static void d71_improc_update(struct komeda_component *c,
+			      struct komeda_component_state *state)
+{
+	struct komeda_improc_state *st =3D to_improc_st(state);
+	u32 __iomem *reg =3D c->reg;
+	u32 index, input_hw_id;
+
+	for_each_changed_input(state, index) {
+		input_hw_id =3D state->active_inputs & BIT(index) ?
+			      to_d71_input_id(&state->inputs[index]) : 0;
+		malidp_write32(reg, BLK_INPUT_ID0 + index * 4, input_hw_id);
+	}
+
+	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
+}
+
+struct komeda_component_funcs d71_improc_funcs =3D {
+	.update		=3D d71_improc_update,
+	.disable	=3D d71_component_disable,
+};
+
 static int d71_improc_init(struct d71_dev *d71,
 			   struct block_header *blk, u32 __iomem *reg)
 {
-	DRM_DEBUG("Detect D71_improc.\n");
+	struct komeda_component *c;
+	struct komeda_improc *improc;
+	u32 pipe_id, comp_id, value;
+
+	get_resources_id(blk->block_info, &pipe_id, &comp_id);
+
+	c =3D komeda_component_add(&d71->pipes[pipe_id]->base, sizeof(*improc),
+				 comp_id,
+				 BLOCK_INFO_INPUT_ID(blk->block_info),
+				 &d71_improc_funcs, IPS_NUM_INPUT_IDS,
+				 get_valid_inputs(blk),
+				 IPS_NUM_OUTPUT_IDS, reg, "DOU%d_IPS", pipe_id);
+	if (IS_ERR(c)) {
+		DRM_ERROR("Failed to add improc component\n");
+		return PTR_ERR(c);
+	}
+
+	improc =3D to_improc(c);
+	improc->supported_color_depths =3D BIT(8) | BIT(10);
+	improc->supported_color_formats =3D DRM_COLOR_FORMAT_RGB444 |
+					  DRM_COLOR_FORMAT_YCRCB444 |
+					  DRM_COLOR_FORMAT_YCRCB422;
+	value =3D malidp_read32(reg, BLK_INFO);
+	if (value & IPS_INFO_CHD420)
+		improc->supported_color_formats |=3D DRM_COLOR_FORMAT_YCRCB420;
+
+	improc->supports_csc =3D true;
+	improc->supports_gamma =3D true;
=20
 	return 0;
 }
=20
+static void d71_timing_ctrlr_disable(struct komeda_component *c)
+{
+	malidp_write32_mask(c->reg, BLK_CONTROL, BS_CTRL_EN, 0);
+}
+
+static void d71_timing_ctrlr_update(struct komeda_component *c,
+				    struct komeda_component_state *state)
+{
+	struct drm_crtc_state *crtc_st =3D state->crtc->state;
+	u32 __iomem *reg =3D c->reg;
+	struct videomode vm;
+	u32 value;
+
+	drm_display_mode_to_videomode(&crtc_st->adjusted_mode, &vm);
+
+	malidp_write32(reg, BS_ACTIVESIZE, HV_SIZE(vm.hactive, vm.vactive));
+	malidp_write32(reg, BS_HINTERVALS, BS_H_INTVALS(vm.hfront_porch,
+							vm.hback_porch));
+	malidp_write32(reg, BS_VINTERVALS, BS_V_INTVALS(vm.vfront_porch,
+							vm.vback_porch));
+
+	value =3D BS_SYNC_VSW(vm.vsync_len) | BS_SYNC_HSW(vm.hsync_len);
+	value |=3D vm.flags & DISPLAY_FLAGS_VSYNC_HIGH ? BS_SYNC_VSP : 0;
+	value |=3D vm.flags & DISPLAY_FLAGS_HSYNC_HIGH ? BS_SYNC_HSP : 0;
+	malidp_write32(reg, BS_SYNC, value);
+
+	malidp_write32(reg, BS_PROG_LINE, D71_DEFAULT_PREPRETCH_LINE - 1);
+	malidp_write32(reg, BS_PREFETCH_LINE, D71_DEFAULT_PREPRETCH_LINE);
+
+	/* configure bs control register */
+	value =3D BS_CTRL_EN | BS_CTRL_VM;
+
+	malidp_write32(reg, BLK_CONTROL, value);
+}
+
+struct komeda_component_funcs d71_timing_ctrlr_funcs =3D {
+	.update		=3D d71_timing_ctrlr_update,
+	.disable	=3D d71_timing_ctrlr_disable,
+};
+
 static int d71_timing_ctrlr_init(struct d71_dev *d71,
 				 struct block_header *blk, u32 __iomem *reg)
 {
-	DRM_DEBUG("Detect D71_timing_ctrlr.\n");
+	struct komeda_component *c;
+	struct komeda_timing_ctrlr *ctrlr;
+	u32 pipe_id, comp_id;
+
+	get_resources_id(blk->block_info, &pipe_id, &comp_id);
+
+	c =3D komeda_component_add(&d71->pipes[pipe_id]->base, sizeof(*ctrlr),
+				 KOMEDA_COMPONENT_TIMING_CTRLR,
+				 BLOCK_INFO_INPUT_ID(blk->block_info),
+				 &d71_timing_ctrlr_funcs,
+				 1, BIT(KOMEDA_COMPONENT_IPS0 + pipe_id),
+				 BS_NUM_OUTPUT_IDS, reg, "DOU%d_BS", pipe_id);
+	if (IS_ERR(c)) {
+		DRM_ERROR("Failed to add display_ctrl component\n");
+		return PTR_ERR(c);
+	}
+
+	ctrlr =3D to_ctrlr(c);
+
+	ctrlr->supports_dual_link =3D true;
=20
 	return 0;
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index f13666004a42..f519a4c587e6 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -11,6 +11,8 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_writeback.h>
+#include <video/videomode.h>
+#include <video/display_timing.h>
=20
 /** struct komeda_plane - komeda instance of drm_plane */
 struct komeda_plane {
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index d75cc81ae9c0..943aa52189d4 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -256,15 +256,22 @@ struct komeda_compiz_state {
=20
 struct komeda_improc {
 	struct komeda_component base;
+	u32 supported_color_formats;  /* DRM_RGB/YUV444/YUV420*/
+	u32 supported_color_depths; /* BIT(8) | BIT(10)*/
+	u8 supports_degamma : 1;
+	u8 supports_csc : 1;
+	u8 supports_gamma : 1;
 };
=20
 struct komeda_improc_state {
 	struct komeda_component_state base;
+	u16 hsize, vsize;
 };
=20
 /* display timing controller */
 struct komeda_timing_ctrlr {
 	struct komeda_component base;
+	u8 supports_dual_link : 1;
 };
=20
 struct komeda_timing_ctrlr_state {
--=20
2.17.1

