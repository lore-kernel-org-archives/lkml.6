Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A2BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5873E218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="H6cG1ycO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfAVJYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:24:40 -0500
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:42544
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbfAVJYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t45Bkw9g4fVhNbkvNPwOFcQZWdH+JTWobVZVeXDJpMw=;
 b=H6cG1ycOCoag90wnnl1K8oyhPYRZeZE+jVnGNUimoBoinjqfLB0ORkmSKDhNZTdc1cPDtChkjLmQReTUkrHilbXhNpV4YyCyHnKSMK+E5y7yz81fE0jDcS54yBdSv7Ew3v16jbRQDTASYQYQ10S0AzvmtoLw+mBKyjpk6aCJ13g=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1813.eurprd08.prod.outlook.com (10.169.227.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 09:24:35 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:24:34 +0000
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
Subject: [PATCH v2 7/7] drm/komeda: Add debugfs node "register" for register
 dump
Thread-Topic: [PATCH v2 7/7] drm/komeda: Add debugfs node "register" for
 register dump
Thread-Index: AQHUsjRJm9LBEOXXEUGw5UphHf7jmw==
Date:   Tue, 22 Jan 2019 09:24:34 +0000
Message-ID: <20190122092243.21226-8-james.qian.wang@arm.com>
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
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1813;6:Cq2mT8qXNL+Yb18O2/qsWFGwwoq0OlYYOQZWxtueBhqEtKgwGf2nQQKR0vS5e/Y5CrQ/45tkeQvP+5eiw/lVnB63vABV6I6paHseYLngYkinZY07xppAsRI8T2NNwVRrl8fR/TdFC77jnRnoFu7I+sJZPYWzc0ZtYcTnKxI2qZjc6Ql54AyPkU7qbaOvaDJZr7zaZWkrFBqrG8EGTtmzZoueLF3ZimZZtj7WrYsDMvcTzf6sfLjWEf/CycgxSS59bv2Mx+bJjnymyjMNyv4djv1gbUovwIlr8pD1SLNAFXHPVT8SMe9gIbOYwmi+27bbQSxEpTnIaEBAl5ZLJDLqFlH4Q3ixVpuqSght4uBt1oVaPSgUkKjywPgCHKsySznCLqys9BTlv/b6ZSLk2dfeAZkc25hNH9Tt27/dyFiUGTGWgG9BSAXElgSpQI7WplXsb46LOE7p6QqL8Nw5ip4Prg==;5:eCxFIYN8BIbqeIk0RVQhg9g9+naVQ7nA/Un140FgzMJRgEAG9g7hyBZP/xhJI1mYE2U0iWx23GIxyvCIqN9X3Nq9eLVNoCzCI0T928LigQT2v5HGf1Sz3sdG9IXwH2LhRgTPi+nOM0eAOq2HmPNOPZSiBBsy0gqrpmMyvMmbXFb+LuuCYDxdJDTwgy19dFD5mfJ1Tx5ZOq2fQ1qrKfwFyQ==;7:VgSi5oEg6l9gAbsKt6fCJpbSRk/c/R6rH8c2N/cxFckMRNinpwMgRMS5eNf/XYIKgwzhoQ55X+hbIIX/ZwglNo+fUBB4uwNoP4/npvi3Asb1qOTXh2MvIL7YIL5aJtDuNcJKxll90NiBh4UNkHGWUA==
x-ms-office365-filtering-correlation-id: 966fa096-25b2-4cd6-8d7d-08d6804b6c32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1813;
x-ms-traffictypediagnostic: DB6PR0801MB1813:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1813AE9D8777D7E9C9154CA4B3980@DB6PR0801MB1813.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(189003)(199004)(54906003)(110136005)(305945005)(66066001)(103116003)(316002)(6486002)(25786009)(6636002)(478600001)(11346002)(446003)(256004)(14444005)(486006)(81156014)(2616005)(476003)(1076003)(4326008)(50226002)(68736007)(6512007)(386003)(6506007)(55236004)(71190400001)(71200400001)(53936002)(36756003)(105586002)(3846002)(2501003)(6116002)(8936002)(14454004)(99286004)(52116002)(97736004)(26005)(8676002)(81166006)(7736002)(86362001)(30864003)(186003)(6436002)(2906002)(102836004)(106356001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1813;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IyRXuJW/YFDN9VBn+NXT11JXljNVxWQcc8rlPlfD4gLnao87sFzCppOKNxhjPQySrMw9MCCjtcpbThuy9ec+Yub8J0P+bxFPoiBz7f09G46G9PjQETTOAn2vOhaFK6GTR4/U7mNWgSmTfO0jsIshX0fpzOPNLufDGUPJYEiiNJ+QU43ymAPoPRbtMWKkZoJtmNVS/lTzOdhvPP2WEhHTlloS/CebnFTPvmVEcRIwTxJvBJX6yXEq8URAm4v0yor920OCq1b9HgNdOCaIOzeoD6/NjGTTzF+dwhUnO5CyCYVsCaYY6Ucwhu4QCkNxgf4lD4buskdwC1KpqvbcBBA8ySppIf8EcKqbiB5je2E17l8+qWXM09i5y9tdZf0RBVR089sYvmJh0lNNLB13Beus+TR2zDkMZmj10+UZ86u8JrA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966fa096-25b2-4cd6-8d7d-08d6804b6c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:24:26.4251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1813
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

Add a debugfs node "register" and entry function dump_register to
dev/pipeline/component to register dump, then user can read
"/sys/kernel/debug/komeda/register" to get the register values via these
chip function.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../arm/display/komeda/d71/d71_component.c    | 205 ++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  52 +++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |   5 +
 .../drm/arm/display/komeda/komeda_pipeline.c  |  20 ++
 .../drm/arm/display/komeda/komeda_pipeline.h  |   3 +
 5 files changed, 285 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index 095779964518..eb8f16e089e7 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -69,6 +69,42 @@ static u32 get_valid_inputs(struct block_header *blk)
 	return valid_inputs;
 }
=20
+static void get_values_from_reg(void __iomem *reg, u32 offset,
+				u32 count, u32 *val)
+{
+	u32 i, addr;
+
+	for (i =3D 0; i < count; i++) {
+		addr =3D offset + (i << 2);
+		/* 0xA4 is WO register */
+		if (addr !=3D 0xA4)
+			val[i] =3D malidp_read32(reg, addr);
+		else
+			val[i] =3D 0xDEADDEAD;
+	}
+}
+
+static void dump_block_header(struct seq_file *sf, void __iomem *reg)
+{
+	struct block_header hdr;
+	u32 i, n_input, n_output;
+
+	d71_read_block_header(reg, &hdr);
+	seq_printf(sf, "BLOCK_INFO:\t\t0x%X\n", hdr.block_info);
+	seq_printf(sf, "PIPELINE_INFO:\t\t0x%X\n", hdr.pipeline_info);
+
+	n_output =3D PIPELINE_INFO_N_OUTPUTS(hdr.pipeline_info);
+	n_input  =3D PIPELINE_INFO_N_VALID_INPUTS(hdr.pipeline_info);
+
+	for (i =3D 0; i < n_input; i++)
+		seq_printf(sf, "VALID_INPUT_ID%u:\t0x%X\n",
+			   i, hdr.input_ids[i]);
+
+	for (i =3D 0; i < n_output; i++)
+		seq_printf(sf, "OUTPUT_ID%u:\t\t0x%X\n",
+			   i, hdr.output_ids[i]);
+}
+
 static u32 to_rot_ctrl(u32 rot)
 {
 	u32 lr_ctrl =3D 0;
@@ -141,9 +177,76 @@ static void d71_layer_update(struct komeda_component *=
c,
 	malidp_write32_mask(reg, BLK_CONTROL, ctrl_mask, ctrl);
 }
=20
+static void d71_layer_dump(struct komeda_component *c, struct seq_file *sf=
)
+{
+	u32 v[15], i;
+	bool rich, rgb2rgb;
+	char *prefix;
+
+	get_values_from_reg(c->reg, LAYER_INFO, 1, &v[14]);
+	if (v[14] & 0x1) {
+		rich =3D true;
+		prefix =3D "LR_";
+	} else {
+		rich =3D false;
+		prefix =3D "LS_";
+	}
+
+	rgb2rgb =3D !!(v[14] & L_INFO_CM);
+
+	dump_block_header(sf, c->reg);
+
+	seq_printf(sf, "%sLAYER_INFO:\t\t0x%X\n", prefix, v[14]);
+
+	get_values_from_reg(c->reg, 0xD0, 1, v);
+	seq_printf(sf, "%sCONTROL:\t\t0x%X\n", prefix, v[0]);
+	if (rich) {
+		get_values_from_reg(c->reg, 0xD4, 1, v);
+		seq_printf(sf, "LR_RICH_CONTROL:\t0x%X\n", v[0]);
+	}
+	get_values_from_reg(c->reg, 0xD8, 4, v);
+	seq_printf(sf, "%sFORMAT:\t\t0x%X\n", prefix, v[0]);
+	seq_printf(sf, "%sIT_COEFFTAB:\t\t0x%X\n", prefix, v[1]);
+	seq_printf(sf, "%sIN_SIZE:\t\t0x%X\n", prefix, v[2]);
+	seq_printf(sf, "%sPALPHA:\t\t0x%X\n", prefix, v[3]);
+
+	get_values_from_reg(c->reg, 0x100, 3, v);
+	seq_printf(sf, "%sP0_PTR_LOW:\t\t0x%X\n", prefix, v[0]);
+	seq_printf(sf, "%sP0_PTR_HIGH:\t\t0x%X\n", prefix, v[1]);
+	seq_printf(sf, "%sP0_STRIDE:\t\t0x%X\n", prefix, v[2]);
+
+	get_values_from_reg(c->reg, 0x110, 2, v);
+	seq_printf(sf, "%sP1_PTR_LOW:\t\t0x%X\n", prefix, v[0]);
+	seq_printf(sf, "%sP1_PTR_HIGH:\t\t0x%X\n", prefix, v[1]);
+	if (rich) {
+		get_values_from_reg(c->reg, 0x118, 1, v);
+		seq_printf(sf, "LR_P1_STRIDE:\t\t0x%X\n", v[0]);
+
+		get_values_from_reg(c->reg, 0x120, 2, v);
+		seq_printf(sf, "LR_P2_PTR_LOW:\t\t0x%X\n", v[0]);
+		seq_printf(sf, "LR_P2_PTR_HIGH:\t\t0x%X\n", v[1]);
+
+		get_values_from_reg(c->reg, 0x130, 12, v);
+		for (i =3D 0; i < 12; i++)
+			seq_printf(sf, "LR_YUV_RGB_COEFF%u:\t0x%X\n", i, v[i]);
+	}
+
+	if (rgb2rgb) {
+		get_values_from_reg(c->reg, LAYER_RGB_RGB_COEFF0, 12, v);
+		for (i =3D 0; i < 12; i++)
+			seq_printf(sf, "LS_RGB_RGB_COEFF%u:\t0x%X\n", i, v[i]);
+	}
+
+	get_values_from_reg(c->reg, 0x160, 3, v);
+	seq_printf(sf, "%sAD_CONTROL:\t\t0x%X\n", prefix, v[0]);
+	seq_printf(sf, "%sAD_H_CROP:\t\t0x%X\n", prefix, v[1]);
+	seq_printf(sf, "%sAD_V_CROP:\t\t0x%X\n", prefix, v[2]);
+}
+
 struct komeda_component_funcs d71_layer_funcs =3D {
 	.update		=3D d71_layer_update,
 	.disable	=3D d71_layer_disable,
+	.dump_register	=3D d71_layer_dump,
 };
=20
 static int d71_layer_init(struct d71_dev *d71,
@@ -250,9 +353,46 @@ static void d71_compiz_update(struct komeda_component =
*c,
 	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
 }
=20
+static void d71_compiz_dump(struct komeda_component *c, struct seq_file *s=
f)
+{
+	u32 v[8], i;
+
+	dump_block_header(sf, c->reg);
+
+	get_values_from_reg(c->reg, 0x80, 5, v);
+	for (i =3D 0; i < 5; i++)
+		seq_printf(sf, "CU_INPUT_ID%u:\t\t0x%X\n", i, v[i]);
+
+	get_values_from_reg(c->reg, 0xA0, 5, v);
+	seq_printf(sf, "CU_IRQ_RAW_STATUS:\t0x%X\n", v[0]);
+	seq_printf(sf, "CU_IRQ_CLEAR:\t\t0x%X\n", v[1]);
+	seq_printf(sf, "CU_IRQ_MASK:\t\t0x%X\n", v[2]);
+	seq_printf(sf, "CU_IRQ_STATUS:\t\t0x%X\n", v[3]);
+	seq_printf(sf, "CU_STATUS:\t\t0x%X\n", v[4]);
+
+	get_values_from_reg(c->reg, 0xD0, 2, v);
+	seq_printf(sf, "CU_CONTROL:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "CU_SIZE:\t\t0x%X\n", v[1]);
+
+	get_values_from_reg(c->reg, 0xDC, 1, v);
+	seq_printf(sf, "CU_BG_COLOR:\t\t0x%X\n", v[0]);
+
+	for (i =3D 0, v[4] =3D 0xE0; i < 5; i++, v[4] +=3D 0x10) {
+		get_values_from_reg(c->reg, v[4], 3, v);
+		seq_printf(sf, "CU_INPUT%u_SIZE:\t\t0x%X\n", i, v[0]);
+		seq_printf(sf, "CU_INPUT%u_OFFSET:\t0x%X\n", i, v[1]);
+		seq_printf(sf, "CU_INPUT%u_CONTROL:\t0x%X\n", i, v[2]);
+	}
+
+	get_values_from_reg(c->reg, 0x130, 2, v);
+	seq_printf(sf, "CU_USER_LOW:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "CU_USER_HIGH:\t\t0x%X\n", v[1]);
+}
+
 struct komeda_component_funcs d71_compiz_funcs =3D {
 	.update		=3D d71_compiz_update,
 	.disable	=3D d71_component_disable,
+	.dump_register	=3D d71_compiz_dump,
 };
=20
 static int d71_compiz_init(struct d71_dev *d71,
@@ -298,9 +438,37 @@ static void d71_improc_update(struct komeda_component =
*c,
 	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
 }
=20
+static void d71_improc_dump(struct komeda_component *c, struct seq_file *s=
f)
+{
+	u32 v[12], i;
+
+	dump_block_header(sf, c->reg);
+
+	get_values_from_reg(c->reg, 0x80, 2, v);
+	seq_printf(sf, "IPS_INPUT_ID0:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "IPS_INPUT_ID1:\t\t0x%X\n", v[1]);
+
+	get_values_from_reg(c->reg, 0xC0, 1, v);
+	seq_printf(sf, "IPS_INFO:\t\t0x%X\n", v[0]);
+
+	get_values_from_reg(c->reg, 0xD0, 3, v);
+	seq_printf(sf, "IPS_CONTROL:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "IPS_SIZE:\t\t0x%X\n", v[1]);
+	seq_printf(sf, "IPS_DEPTH:\t\t0x%X\n", v[2]);
+
+	get_values_from_reg(c->reg, 0x130, 12, v);
+	for (i =3D 0; i < 12; i++)
+		seq_printf(sf, "IPS_RGB_RGB_COEFF%u:\t0x%X\n", i, v[i]);
+
+	get_values_from_reg(c->reg, 0x170, 12, v);
+	for (i =3D 0; i < 12; i++)
+		seq_printf(sf, "IPS_RGB_YUV_COEFF%u:\t0x%X\n", i, v[i]);
+}
+
 struct komeda_component_funcs d71_improc_funcs =3D {
 	.update		=3D d71_improc_update,
 	.disable	=3D d71_component_disable,
+	.dump_register	=3D d71_improc_dump,
 };
=20
 static int d71_improc_init(struct d71_dev *d71,
@@ -373,9 +541,46 @@ static void d71_timing_ctrlr_update(struct komeda_comp=
onent *c,
 	malidp_write32(reg, BLK_CONTROL, value);
 }
=20
+void d71_timing_ctrlr_dump(struct komeda_component *c, struct seq_file *sf=
)
+{
+	u32 v[8], i;
+
+	dump_block_header(sf, c->reg);
+
+	get_values_from_reg(c->reg, 0xC0, 1, v);
+	seq_printf(sf, "BS_INFO:\t\t0x%X\n", v[0]);
+
+	get_values_from_reg(c->reg, 0xD0, 8, v);
+	seq_printf(sf, "BS_CONTROL:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "BS_PROG_LINE:\t\t0x%X\n", v[1]);
+	seq_printf(sf, "BS_PREFETCH_LINE:\t0x%X\n", v[2]);
+	seq_printf(sf, "BS_BG_COLOR:\t\t0x%X\n", v[3]);
+	seq_printf(sf, "BS_ACTIVESIZE:\t\t0x%X\n", v[4]);
+	seq_printf(sf, "BS_HINTERVALS:\t\t0x%X\n", v[5]);
+	seq_printf(sf, "BS_VINTERVALS:\t\t0x%X\n", v[6]);
+	seq_printf(sf, "BS_SYNC:\t\t0x%X\n", v[7]);
+
+	get_values_from_reg(c->reg, 0x100, 3, v);
+	seq_printf(sf, "BS_DRIFT_TO:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "BS_FRAME_TO:\t\t0x%X\n", v[1]);
+	seq_printf(sf, "BS_TE_TO:\t\t0x%X\n", v[2]);
+
+	get_values_from_reg(c->reg, 0x110, 3, v);
+	for (i =3D 0; i < 3; i++)
+		seq_printf(sf, "BS_T%u_INTERVAL:\t\t0x%X\n", i, v[i]);
+
+	get_values_from_reg(c->reg, 0x120, 5, v);
+	for (i =3D 0; i < 2; i++) {
+		seq_printf(sf, "BS_CRC%u_LOW:\t\t0x%X\n", i, v[i << 1]);
+		seq_printf(sf, "BS_CRC%u_HIGH:\t\t0x%X\n", i, v[(i << 1) + 1]);
+	}
+	seq_printf(sf, "BS_USER:\t\t0x%X\n", v[4]);
+}
+
 struct komeda_component_funcs d71_timing_ctrlr_funcs =3D {
 	.update		=3D d71_timing_ctrlr_update,
 	.disable	=3D d71_timing_ctrlr_disable,
+	.dump_register	=3D d71_timing_ctrlr_dump,
 };
=20
 static int d71_timing_ctrlr_init(struct d71_dev *d71,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 01ae869b659b..a012b3bbf53b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -7,8 +7,52 @@
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#endif
 #include "komeda_dev.h"
=20
+static int komeda_register_show(struct seq_file *sf, void *x)
+{
+	struct komeda_dev *mdev =3D sf->private;
+	int i;
+
+	if (mdev->funcs->dump_register)
+		mdev->funcs->dump_register(mdev, sf);
+
+	for (i =3D 0; i < mdev->n_pipelines; i++)
+		komeda_pipeline_dump_register(mdev->pipelines[i], sf);
+
+	return 0;
+}
+
+static int komeda_register_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, komeda_register_show, inode->i_private);
+}
+
+static const struct file_operations komeda_register_fops =3D {
+	.owner		=3D THIS_MODULE,
+	.open		=3D komeda_register_open,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
+static void komeda_debugfs_init(struct komeda_dev *mdev)
+{
+	if (!debugfs_initialized())
+		return;
+
+	mdev->debugfs_root =3D debugfs_create_dir("komeda", NULL);
+	if (IS_ERR_OR_NULL(mdev->debugfs_root))
+		return;
+
+	debugfs_create_file("register", 0444, mdev->debugfs_root,
+			    mdev, &komeda_register_fops);
+}
+
 static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_nod=
e *np)
 {
 	struct komeda_pipeline *pipe;
@@ -155,6 +199,10 @@ struct komeda_dev *komeda_dev_create(struct device *de=
v)
 		goto err_cleanup;
 	}
=20
+#ifdef CONFIG_DEBUG_FS
+	komeda_debugfs_init(mdev);
+#endif
+
 	return mdev;
=20
 err_cleanup:
@@ -168,6 +216,10 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
 	struct komeda_dev_funcs *funcs =3D mdev->funcs;
 	int i;
=20
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(mdev->debugfs_root);
+#endif
+
 	for (i =3D 0; i < mdev->n_pipelines; i++) {
 		komeda_pipeline_destroy(mdev, mdev->pipelines[i]);
 		mdev->pipelines[i] =3D NULL;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 681fe022bd22..8eae2620ce77 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -103,6 +103,9 @@ struct komeda_dev_funcs {
 	int (*enable_irq)(struct komeda_dev *mdev);
 	/** @disable_irq: disable irq */
 	int (*disable_irq)(struct komeda_dev *mdev);
+
+	/** @dump_register: Optional, dump registers to seq_file */
+	void (*dump_register)(struct komeda_dev *mdev, struct seq_file *seq);
 };
=20
 /**
@@ -139,6 +142,8 @@ struct komeda_dev {
 	 * destroyed by &komeda_dev_funcs.cleanup()
 	 */
 	void *chip_data;
+
+	struct dentry *debugfs_root;
 };
=20
 static inline bool
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.c
index c2e469164244..06da94f509e4 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -273,3 +273,23 @@ int komeda_assemble_pipelines(struct komeda_dev *mdev)
=20
 	return 0;
 }
+
+void komeda_pipeline_dump_register(struct komeda_pipeline *pipe,
+				   struct seq_file *sf)
+{
+	struct komeda_component *c;
+	u32 id;
+
+	seq_printf(sf, "\n=3D=3D=3D=3D=3D=3D=3D=3D Pipeline-%d =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D\n", pipe->id);
+
+	if (pipe->funcs && pipe->funcs->dump_register)
+		pipe->funcs->dump_register(pipe, sf);
+
+	dp_for_each_set_bit(id, pipe->avail_comps) {
+		c =3D komeda_pipeline_get_component(pipe, id);
+
+		seq_printf(sf, "\n------%s------\n", c->name);
+		if (c->funcs->dump_register)
+			c->funcs->dump_register(c, sf);
+	}
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index f9b7f517a484..c30a790d0712 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -367,6 +367,9 @@ int komeda_assemble_pipelines(struct komeda_dev *mdev);
 struct komeda_component *
 komeda_pipeline_get_component(struct komeda_pipeline *pipe, int id);
=20
+void komeda_pipeline_dump_register(struct komeda_pipeline *pipe,
+				   struct seq_file *sf);
+
 /* component APIs */
 struct komeda_component *
 komeda_component_add(struct komeda_pipeline *pipe,
--=20
2.17.1

