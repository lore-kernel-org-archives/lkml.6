Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964C2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DB2206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BdiMVu0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeLNPab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:30:31 -0500
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:22720
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727229AbeLNPab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTRTuZJ+uzzpRP+37ypljjdWZkH48LYNfrzAI+5DHW4=;
 b=BdiMVu0/8EmIYOx+v+GcgDYP7y4FdrdpO023EEX0cFnl2Ykuzc18iXkc44+wM5Sx1Kem6YoHWHoYcBZcFZT/pniw3e6vUcUcLnddPDX2Ko2K7o0lcQr2Nb+XxQGhkcj/BN97ctHSbd7R3mk9rH49CbOlD2nu93TuSxNHqXMRKUM=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 15:30:11 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Fri, 14 Dec 2018
 15:30:11 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 3/3] clk: imx8mq: Make parent names arrays const pointers
Thread-Topic: [PATCH 3/3] clk: imx8mq: Make parent names arrays const pointers
Thread-Index: AQHUk8Hmh2E/kTsYjEaF+if/bxGlkA==
Date:   Fri, 14 Dec 2018 15:30:11 +0000
Message-ID: <1544801400-18951-4-git-send-email-abel.vesa@nxp.com>
References: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::33) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3754;6:bn47IRcn4TUFy1yu/QE/znCAxITSinyd/DiFyIsKpJ2IZQbSxbUzkCSpjV4yCfAy69eGnhGIJ25beqsYvrWfUJCv1q0mK5Oc5Muwracc/ha2cpUFtafZ3Pgoyi8WmemfE7fZX/CixXGHqMjcH+u7dT+kfZooSN7IEub1sOPNi6uDqDUKS8ThabOfGc90z0PDs1BY99ODlmJVPjsyh46jR+o5XVzzEQf4XEY1AUp/buCi3xKMBlLVot1kDQDT0/EhuLnqiblxDj/gmEjVnTcx15zxXwZ6uEhhIB0a1helwBKl2Qkm73esiEk36ngOFcKEsWUfqdJiGi79vth3qyeGnkMZVi/dNgGlUYDELc1GtBT2UCUFgvNRkfHKIRtVTKob9B72TjFO60B7QgQRFNq+tXNmcdXpYmjxC1APs8ZtJplosxla0A3oEieiEWFnjxbR/QcBrhTC8URRuMWmufUyMg==;5:7FRD0t6wTYAw+LenLTtLn78a07EV8CF0Ut1tTErMUzosus0sfwUPP4Tv8/b50oGbORXFVIgOUsy3AENFzExFazE1kRL6eATq46nUiQNg3ooDye/pQw7LB0I9Pc3ZmvUM21GmAYyOaVXRqNa+RHTYgWjUEjohg+atxxJUqhJjFPA=;7:jHTpcWXhIXqYj2ep0wA4zxQv7TEV68Zx17g533yfLz/BwBRLmno4esVH/j9gqiXt1K+5XfjAci/bkM8H3f6zAGA5SHq/j+ycpDbeFkeI9QwPJ1ShbFI2LaBbAVXUftRMERYDO34pCVkBspjMIip7Zw==
x-ms-office365-filtering-correlation-id: 4bb5f2c6-3729-47b4-1879-08d661d90940
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3754;
x-ms-traffictypediagnostic: DB3PR0402MB3754:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB375425167ED384F0989E9AE4F6A10@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3754;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3754;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(2616005)(53936002)(6636002)(8936002)(186003)(66066001)(97736004)(52116002)(68736007)(4326008)(305945005)(36756003)(25786009)(14454004)(2906002)(53946003)(6512007)(478600001)(5660300001)(386003)(316002)(26005)(99286004)(6486002)(6506007)(71200400001)(105586002)(54906003)(110136005)(4744004)(76176011)(81166006)(81156014)(8676002)(575784001)(486006)(7736002)(3846002)(44832011)(6116002)(6436002)(86362001)(106356001)(71190400001)(102836004)(446003)(11346002)(476003)(256004)(32563001)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3754;H:DB3PR0402MB3658.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XQvtdQHqgmv60t3mjd+kJy0C2VsyFO+FyldrvwUanMN/GN0IkPzQxGDJ9z1vRgJRauYLxGiYL4S5eiqnIyiN1AhzwjD1mtffo8ST7hbp0Wgq82VpAPzK6FKd47CDvvVmriiDfJsY4Yp+2L4k/1L8s7OGLSpGPtWzPOrsZgTpeECaUCp4QFCddy57okIUFXvhce1PZi9AxNPoJepOOkWIZiwom7ZcaNKPToNxCY/9DxkXtPaQgBQAjJmgmsiNhsODzy2mRSbJijqIoXeXPcjAhXggYjjUy6X1ffarAJetjSf8WVC74IL+8TG4YPHbxcbv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb5f2c6-3729-47b4-1879-08d661d90940
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 15:30:11.4800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arrays containing the mux selectors need to be of const pointer
to const char.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c | 194 +++++++++++++++++++++------------------=
----
 1 file changed, 97 insertions(+), 97 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 26b57f4..398ab0b 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -26,245 +26,245 @@ static u32 share_count_nand;
=20
 static struct clk *clks[IMX8MQ_CLK_END];
=20
-static const char *pll_ref_sels[] =3D { "osc_25m", "osc_27m", "dummy", "du=
mmy", };
-static const char *arm_pll_bypass_sels[] =3D {"arm_pll", "arm_pll_ref_sel"=
, };
-static const char *gpu_pll_bypass_sels[] =3D {"gpu_pll", "gpu_pll_ref_sel"=
, };
-static const char *vpu_pll_bypass_sels[] =3D {"vpu_pll", "vpu_pll_ref_sel"=
, };
-static const char *audio_pll1_bypass_sels[] =3D {"audio_pll1", "audio_pll1=
_ref_sel", };
-static const char *audio_pll2_bypass_sels[] =3D {"audio_pll2", "audio_pll2=
_ref_sel", };
-static const char *video_pll1_bypass_sels[] =3D {"video_pll1", "video_pll1=
_ref_sel", };
-
-static const char *sys1_pll1_out_sels[] =3D {"sys1_pll1", "sys1_pll1_ref_s=
el", };
-static const char *sys2_pll1_out_sels[] =3D {"sys2_pll1", "sys1_pll1_ref_s=
el", };
-static const char *sys3_pll1_out_sels[] =3D {"sys3_pll1", "sys3_pll1_ref_s=
el", };
-static const char *dram_pll1_out_sels[] =3D {"dram_pll1", "dram_pll1_ref_s=
el", };
-
-static const char *sys1_pll2_out_sels[] =3D {"sys1_pll2_div", "sys1_pll1_r=
ef_sel", };
-static const char *sys2_pll2_out_sels[] =3D {"sys2_pll2_div", "sys2_pll1_r=
ef_sel", };
-static const char *sys3_pll2_out_sels[] =3D {"sys3_pll2_div", "sys2_pll1_r=
ef_sel", };
-static const char *dram_pll2_out_sels[] =3D {"dram_pll2_div", "dram_pll1_r=
ef_sel", };
+static const char * const pll_ref_sels[] =3D { "osc_25m", "osc_27m", "dumm=
y", "dummy", };
+static const char * const arm_pll_bypass_sels[] =3D {"arm_pll", "arm_pll_r=
ef_sel", };
+static const char * const gpu_pll_bypass_sels[] =3D {"gpu_pll", "gpu_pll_r=
ef_sel", };
+static const char * const vpu_pll_bypass_sels[] =3D {"vpu_pll", "vpu_pll_r=
ef_sel", };
+static const char * const audio_pll1_bypass_sels[] =3D {"audio_pll1", "aud=
io_pll1_ref_sel", };
+static const char * const audio_pll2_bypass_sels[] =3D {"audio_pll2", "aud=
io_pll2_ref_sel", };
+static const char * const video_pll1_bypass_sels[] =3D {"video_pll1", "vid=
eo_pll1_ref_sel", };
+
+static const char * const sys1_pll1_out_sels[] =3D {"sys1_pll1", "sys1_pll=
1_ref_sel", };
+static const char * const sys2_pll1_out_sels[] =3D {"sys2_pll1", "sys1_pll=
1_ref_sel", };
+static const char * const sys3_pll1_out_sels[] =3D {"sys3_pll1", "sys3_pll=
1_ref_sel", };
+static const char * const dram_pll1_out_sels[] =3D {"dram_pll1", "dram_pll=
1_ref_sel", };
+
+static const char * const sys1_pll2_out_sels[] =3D {"sys1_pll2_div", "sys1=
_pll1_ref_sel", };
+static const char * const sys2_pll2_out_sels[] =3D {"sys2_pll2_div", "sys2=
_pll1_ref_sel", };
+static const char * const sys3_pll2_out_sels[] =3D {"sys3_pll2_div", "sys2=
_pll1_ref_sel", };
+static const char * const dram_pll2_out_sels[] =3D {"dram_pll2_div", "dram=
_pll1_ref_sel", };
=20
 /* CCM ROOT */
-static const char *imx8mq_a53_sels[] =3D {"osc_25m", "arm_pll_out", "sys2_=
pll_500m", "sys2_pll_1000m",
+static const char * const imx8mq_a53_sels[] =3D {"osc_25m", "arm_pll_out",=
 "sys2_pll_500m", "sys2_pll_1000m",
 					"sys1_pll_800m", "sys1_pll_400m", "audio_pll1_out", "sys3_pll2_out", =
};
=20
-static const char *imx8mq_vpu_sels[] =3D {"osc_25m", "arm_pll_out", "sys2_=
pll_500m", "sys2_pll_1000m",
+static const char * const imx8mq_vpu_sels[] =3D {"osc_25m", "arm_pll_out",=
 "sys2_pll_500m", "sys2_pll_1000m",
 					"sys1_pll_800m", "sys1_pll_400m", "audio_pll1_out", "vpu_pll_out", };
=20
-static const char *imx8mq_gpu_core_sels[] =3D {"osc_25m", "gpu_pll_out", "=
sys1_pll_800m", "sys3_pll2_out",
+static const char * const imx8mq_gpu_core_sels[] =3D {"osc_25m", "gpu_pll_=
out", "sys1_pll_800m", "sys3_pll2_out",
 					     "sys2_pll_1000m", "audio_pll1_out", "video_pll1_out", "audio_pll=
2_out", };
=20
-static const char *imx8mq_gpu_shader_sels[] =3D {"osc_25m", "gpu_pll_out",=
 "sys1_pll_800m", "sys3_pll2_out",
+static const char * const imx8mq_gpu_shader_sels[] =3D {"osc_25m", "gpu_pl=
l_out", "sys1_pll_800m", "sys3_pll2_out",
 					       "sys2_pll_1000m", "audio_pll1_out", "video_pll1_out", "audio_p=
ll2_out", };
=20
-static const char *imx8mq_main_axi_sels[] =3D {"osc_25m", "sys2_pll_333m",=
 "sys1_pll_800m", "sys2_pll_250m",
+static const char * const imx8mq_main_axi_sels[] =3D {"osc_25m", "sys2_pll=
_333m", "sys1_pll_800m", "sys2_pll_250m",
 					     "sys2_pll_1000m", "audio_pll1_out", "video_pll1_out", "sys1_pll_=
100m",};
=20
-static const char *imx8mq_enet_axi_sels[] =3D {"osc_25m", "sys1_pll_266m",=
 "sys1_pll_800m", "sys2_pll_250m",
+static const char * const imx8mq_enet_axi_sels[] =3D {"osc_25m", "sys1_pll=
_266m", "sys1_pll_800m", "sys2_pll_250m",
 					     "sys2_pll_200m", "audio_pll1_out", "video_pll1_out", "sys3_pll2_=
out", };
=20
-static const char *imx8mq_nand_usdhc_sels[] =3D {"osc_25m", "sys1_pll_266m=
", "sys1_pll_800m", "sys2_pll_200m",
+static const char * const imx8mq_nand_usdhc_sels[] =3D {"osc_25m", "sys1_p=
ll_266m", "sys1_pll_800m", "sys2_pll_200m",
 					       "sys1_pll_133m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll1=
_out", };
=20
-static const char *imx8mq_vpu_bus_sels[] =3D {"osc_25m", "sys1_pll_800m", =
"vpu_pll_out", "audio_pll2_out", "sys3_pll2_out", "sys2_pll_1000m", "sys2_p=
ll_200m", "sys1_pll_100m", };
+static const char * const imx8mq_vpu_bus_sels[] =3D {"osc_25m", "sys1_pll_=
800m", "vpu_pll_out", "audio_pll2_out", "sys3_pll2_out", "sys2_pll_1000m", =
"sys2_pll_200m", "sys1_pll_100m", };
=20
-static const char *imx8mq_disp_axi_sels[] =3D {"osc_25m", "sys2_pll_125m",=
 "sys1_pll_800m", "sys3_pll2_out", "sys1_pll_400m", "audio_pll2_out", "clk_=
ext1", "clk_ext4", };
+static const char * const imx8mq_disp_axi_sels[] =3D {"osc_25m", "sys2_pll=
_125m", "sys1_pll_800m", "sys3_pll2_out", "sys1_pll_400m", "audio_pll2_out"=
, "clk_ext1", "clk_ext4", };
=20
-static const char *imx8mq_disp_apb_sels[] =3D {"osc_25m", "sys2_pll_125m",=
 "sys1_pll_800m", "sys3_pll2_out",
+static const char * const imx8mq_disp_apb_sels[] =3D {"osc_25m", "sys2_pll=
_125m", "sys1_pll_800m", "sys3_pll2_out",
 					     "sys1_pll_40m", "audio_pll2_out", "clk_ext1", "clk_ext3", };
=20
-static const char *imx8mq_disp_rtrm_sels[] =3D {"osc_25m", "sys1_pll_800m"=
, "sys2_pll_200m", "sys1_pll_400m",
+static const char * const imx8mq_disp_rtrm_sels[] =3D {"osc_25m", "sys1_pl=
l_800m", "sys2_pll_200m", "sys1_pll_400m",
 					      "audio_pll1_out", "video_pll1_out", "clk_ext2", "clk_ext3", };
=20
-static const char *imx8mq_usb_bus_sels[] =3D {"osc_25m", "sys2_pll_500m", =
"sys1_pll_800m", "sys2_pll_100m",
+static const char * const imx8mq_usb_bus_sels[] =3D {"osc_25m", "sys2_pll_=
500m", "sys1_pll_800m", "sys2_pll_100m",
 					    "sys2_pll_200m", "clk_ext2", "clk_ext4", "audio_pll2_out", };
=20
-static const char *imx8mq_gpu_axi_sels[] =3D {"osc_25m", "sys1_pll_800m", =
"gpu_pll_out", "sys3_pll2_out", "sys2_pll_1000m",
+static const char * const imx8mq_gpu_axi_sels[] =3D {"osc_25m", "sys1_pll_=
800m", "gpu_pll_out", "sys3_pll2_out", "sys2_pll_1000m",
 					    "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
=20
-static const char *imx8mq_gpu_ahb_sels[] =3D {"osc_25m", "sys1_pll_800m", =
"gpu_pll_out", "sys3_pll2_out", "sys2_pll_1000m",
+static const char * const imx8mq_gpu_ahb_sels[] =3D {"osc_25m", "sys1_pll_=
800m", "gpu_pll_out", "sys3_pll2_out", "sys2_pll_1000m",
 					    "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
=20
-static const char *imx8mq_noc_sels[] =3D {"osc_25m", "sys1_pll_800m", "sys=
3_pll2_out", "sys2_pll_1000m", "sys2_pll_500m",
+static const char * const imx8mq_noc_sels[] =3D {"osc_25m", "sys1_pll_800m=
", "sys3_pll2_out", "sys2_pll_1000m", "sys2_pll_500m",
 					"audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
=20
-static const char *imx8mq_noc_apb_sels[] =3D {"osc_25m", "sys1_pll_400m", =
"sys3_pll2_out", "sys2_pll_333m", "sys2_pll_200m",
+static const char * const imx8mq_noc_apb_sels[] =3D {"osc_25m", "sys1_pll_=
400m", "sys3_pll2_out", "sys2_pll_333m", "sys2_pll_200m",
 					    "sys1_pll_800m", "audio_pll1_out", "video_pll1_out", };
=20
-static const char *imx8mq_ahb_sels[] =3D {"osc_25m", "sys1_pll_133m", "sys=
1_pll_800m", "sys1_pll_400m",
+static const char * const imx8mq_ahb_sels[] =3D {"osc_25m", "sys1_pll_133m=
", "sys1_pll_800m", "sys1_pll_400m",
 					"sys2_pll_125m", "sys3_pll2_out", "audio_pll1_out", "video_pll1_out",=
 };
=20
-static const char *imx8mq_audio_ahb_sels[] =3D {"osc_25m", "sys2_pll_500m"=
, "sys1_pll_800m", "sys2_pll_1000m",
+static const char * const imx8mq_audio_ahb_sels[] =3D {"osc_25m", "sys2_pl=
l_500m", "sys1_pll_800m", "sys2_pll_1000m",
 						  "sys2_pll_166m", "sys3_pll2_out", "audio_pll1_out", "video_pll1_ou=
t", };
=20
-static const char *imx8mq_dsi_ahb_sels[] =3D {"osc_25m", "sys2_pll_100m", =
"sys1_pll_80m", "sys1_pll_800m",
+static const char * const imx8mq_dsi_ahb_sels[] =3D {"osc_25m", "sys2_pll_=
100m", "sys1_pll_80m", "sys1_pll_800m",
 						"sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out"};
=20
-static const char *imx8mq_dram_alt_sels[] =3D {"osc_25m", "sys1_pll_800m",=
 "sys1_pll_100m", "sys2_pll_500m",
+static const char * const imx8mq_dram_alt_sels[] =3D {"osc_25m", "sys1_pll=
_800m", "sys1_pll_100m", "sys2_pll_500m",
 						"sys2_pll_250m", "sys1_pll_400m", "audio_pll1_out", "sys1_pll_266m",=
 };
=20
-static const char *imx8mq_dram_apb_sels[] =3D {"osc_25m", "sys2_pll_200m",=
 "sys1_pll_40m", "sys1_pll_160m",
+static const char * const imx8mq_dram_apb_sels[] =3D {"osc_25m", "sys2_pll=
_200m", "sys1_pll_40m", "sys1_pll_160m",
 						"sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out",=
 };
=20
-static const char *imx8mq_vpu_g1_sels[] =3D {"osc_25m", "vpu_pll_out", "sy=
s1_pll_800m", "sys2_pll_1000m", "sys1_pll_100m", "sys2_pll_125m", "sys3_pll=
2_out", "audio_pll1_out", };
+static const char * const imx8mq_vpu_g1_sels[] =3D {"osc_25m", "vpu_pll_ou=
t", "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_100m", "sys2_pll_125m", "s=
ys3_pll2_out", "audio_pll1_out", };
=20
-static const char *imx8mq_vpu_g2_sels[] =3D {"osc_25m", "vpu_pll_out", "sy=
s1_pll_800m", "sys2_pll_1000m", "sys1_pll_100m", "sys2_pll_125m", "sys3_pll=
2_out", "audio_pll1_out", };
+static const char * const imx8mq_vpu_g2_sels[] =3D {"osc_25m", "vpu_pll_ou=
t", "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_100m", "sys2_pll_125m", "s=
ys3_pll2_out", "audio_pll1_out", };
=20
-static const char *imx8mq_disp_dtrc_sels[] =3D {"osc_25m", "vpu_pll_out", =
"sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_160m", "sys2_pll_100m", "sys3_=
pll2_out", "audio_pll2_out", };
+static const char * const imx8mq_disp_dtrc_sels[] =3D {"osc_25m", "vpu_pll=
_out", "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_160m", "sys2_pll_100m",=
 "sys3_pll2_out", "audio_pll2_out", };
=20
-static const char *imx8mq_disp_dc8000_sels[] =3D {"osc_25m", "vpu_pll_out"=
, "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_160m", "sys2_pll_100m", "sys=
3_pll2_out", "audio_pll2_out", };
+static const char * const imx8mq_disp_dc8000_sels[] =3D {"osc_25m", "vpu_p=
ll_out", "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_160m", "sys2_pll_100m=
", "sys3_pll2_out", "audio_pll2_out", };
=20
-static const char *imx8mq_pcie1_ctrl_sels[] =3D {"osc_25m", "sys2_pll_250m=
", "sys2_pll_200m", "sys1_pll_266m",
+static const char * const imx8mq_pcie1_ctrl_sels[] =3D {"osc_25m", "sys2_p=
ll_250m", "sys2_pll_200m", "sys1_pll_266m",
 					       "sys1_pll_800m", "sys2_pll_500m", "sys2_pll_250m", "sys3_pll2_=
out", };
=20
-static const char *imx8mq_pcie1_phy_sels[] =3D {"osc_25m", "sys2_pll_100m"=
, "sys2_pll_500m", "clk_ext1", "clk_ext2",
+static const char * const imx8mq_pcie1_phy_sels[] =3D {"osc_25m", "sys2_pl=
l_100m", "sys2_pll_500m", "clk_ext1", "clk_ext2",
 					      "clk_ext3", "clk_ext4", };
=20
-static const char *imx8mq_pcie1_aux_sels[] =3D {"osc_25m", "sys2_pll_200m"=
, "sys2_pll_500m", "sys3_pll2_out",
+static const char * const imx8mq_pcie1_aux_sels[] =3D {"osc_25m", "sys2_pl=
l_200m", "sys2_pll_500m", "sys3_pll2_out",
 					      "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_160m", "sys1_pll_200=
m", };
=20
-static const char *imx8mq_dc_pixel_sels[] =3D {"osc_25m", "video_pll1_out"=
, "audio_pll2_out", "audio_pll1_out", "sys1_pll_800m", "sys2_pll_1000m", "s=
ys3_pll2_out", "clk_ext4", };
+static const char * const imx8mq_dc_pixel_sels[] =3D {"osc_25m", "video_pl=
l1_out", "audio_pll2_out", "audio_pll1_out", "sys1_pll_800m", "sys2_pll_100=
0m", "sys3_pll2_out", "clk_ext4", };
=20
-static const char *imx8mq_lcdif_pixel_sels[] =3D {"osc_25m", "video_pll1_o=
ut", "audio_pll2_out", "audio_pll1_out", "sys1_pll_800m", "sys2_pll_1000m",=
 "sys3_pll2_out", "clk_ext4", };
+static const char * const imx8mq_lcdif_pixel_sels[] =3D {"osc_25m", "video=
_pll1_out", "audio_pll2_out", "audio_pll1_out", "sys1_pll_800m", "sys2_pll_=
1000m", "sys3_pll2_out", "clk_ext4", };
=20
-static const char *imx8mq_sai1_sels[] =3D {"osc_25m", "audio_pll1_out", "a=
udio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext1", "=
clk_ext2", };
+static const char * const imx8mq_sai1_sels[] =3D {"osc_25m", "audio_pll1_o=
ut", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_e=
xt1", "clk_ext2", };
=20
-static const char *imx8mq_sai2_sels[] =3D {"osc_25m", "audio_pll1_out", "a=
udio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2", "=
clk_ext3", };
+static const char * const imx8mq_sai2_sels[] =3D {"osc_25m", "audio_pll1_o=
ut", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_e=
xt2", "clk_ext3", };
=20
-static const char *imx8mq_sai3_sels[] =3D {"osc_25m", "audio_pll1_out", "a=
udio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3", "=
clk_ext4", };
+static const char * const imx8mq_sai3_sels[] =3D {"osc_25m", "audio_pll1_o=
ut", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_e=
xt3", "clk_ext4", };
=20
-static const char *imx8mq_sai4_sels[] =3D {"osc_25m", "audio_pll1_out", "a=
udio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext1", "=
clk_ext2", };
+static const char * const imx8mq_sai4_sels[] =3D {"osc_25m", "audio_pll1_o=
ut", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_e=
xt1", "clk_ext2", };
=20
-static const char *imx8mq_sai5_sels[] =3D {"osc_25m", "audio_pll1_out", "a=
udio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2", "=
clk_ext3", };
+static const char * const imx8mq_sai5_sels[] =3D {"osc_25m", "audio_pll1_o=
ut", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_e=
xt2", "clk_ext3", };
=20
-static const char *imx8mq_sai6_sels[] =3D {"osc_25m", "audio_pll1_out", "a=
udio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3", "=
clk_ext4", };
+static const char * const imx8mq_sai6_sels[] =3D {"osc_25m", "audio_pll1_o=
ut", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_e=
xt3", "clk_ext4", };
=20
-static const char *imx8mq_spdif1_sels[] =3D {"osc_25m", "audio_pll1_out", =
"audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2",=
 "clk_ext3", };
+static const char * const imx8mq_spdif1_sels[] =3D {"osc_25m", "audio_pll1=
_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk=
_ext2", "clk_ext3", };
=20
-static const char *imx8mq_spdif2_sels[] =3D {"osc_25m", "audio_pll1_out", =
"audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3",=
 "clk_ext4", };
+static const char * const imx8mq_spdif2_sels[] =3D {"osc_25m", "audio_pll1=
_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk=
_ext3", "clk_ext4", };
=20
-static const char *imx8mq_enet_ref_sels[] =3D {"osc_25m", "sys2_pll_125m",=
 "sys2_pll_500m", "sys2_pll_100m",
+static const char * const imx8mq_enet_ref_sels[] =3D {"osc_25m", "sys2_pll=
_125m", "sys2_pll_500m", "sys2_pll_100m",
 					     "sys1_pll_160m", "audio_pll1_out", "video_pll1_out", "clk_ext4",=
 };
=20
-static const char *imx8mq_enet_timer_sels[] =3D {"osc_25m", "sys2_pll_100m=
", "audio_pll1_out", "clk_ext1", "clk_ext2",
+static const char * const imx8mq_enet_timer_sels[] =3D {"osc_25m", "sys2_p=
ll_100m", "audio_pll1_out", "clk_ext1", "clk_ext2",
 					       "clk_ext3", "clk_ext4", "video_pll1_out", };
=20
-static const char *imx8mq_enet_phy_sels[] =3D {"osc_25m", "sys2_pll_50m", =
"sys2_pll_125m", "sys2_pll_500m",
+static const char * const imx8mq_enet_phy_sels[] =3D {"osc_25m", "sys2_pll=
_50m", "sys2_pll_125m", "sys2_pll_500m",
 					     "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
=20
-static const char *imx8mq_nand_sels[] =3D {"osc_25m", "sys2_pll_500m", "au=
dio_pll1_out", "sys1_pll_400m",
+static const char * const imx8mq_nand_sels[] =3D {"osc_25m", "sys2_pll_500=
m", "audio_pll1_out", "sys1_pll_400m",
 					 "audio_pll2_out", "sys3_pll2_out", "sys2_pll_250m", "video_pll1_out"=
, };
=20
-static const char *imx8mq_qspi_sels[] =3D {"osc_25m", "sys1_pll_400m", "sy=
s1_pll_800m", "sys2_pll_500m",
+static const char * const imx8mq_qspi_sels[] =3D {"osc_25m", "sys1_pll_400=
m", "sys1_pll_800m", "sys2_pll_500m",
 					 "audio_pll2_out", "sys1_pll_266m", "sys3_pll2_out", "sys1_pll_100m",=
 };
=20
-static const char *imx8mq_usdhc1_sels[] =3D {"osc_25m", "sys1_pll_400m", "=
sys1_pll_800m", "sys2_pll_500m",
+static const char * const imx8mq_usdhc1_sels[] =3D {"osc_25m", "sys1_pll_4=
00m", "sys1_pll_800m", "sys2_pll_500m",
 					 "audio_pll2_out", "sys1_pll_266m", "sys3_pll2_out", "sys1_pll_100m",=
 };
=20
-static const char *imx8mq_usdhc2_sels[] =3D {"osc_25m", "sys1_pll_400m", "=
sys1_pll_800m", "sys2_pll_500m",
+static const char * const imx8mq_usdhc2_sels[] =3D {"osc_25m", "sys1_pll_4=
00m", "sys1_pll_800m", "sys2_pll_500m",
 					 "audio_pll2_out", "sys1_pll_266m", "sys3_pll2_out", "sys1_pll_100m",=
 };
=20
-static const char *imx8mq_i2c1_sels[] =3D {"osc_25m", "sys1_pll_160m", "sy=
s2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
+static const char * const imx8mq_i2c1_sels[] =3D {"osc_25m", "sys1_pll_160=
m", "sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
 					 "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
=20
-static const char *imx8mq_i2c2_sels[] =3D {"osc_25m", "sys1_pll_160m", "sy=
s2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
+static const char * const imx8mq_i2c2_sels[] =3D {"osc_25m", "sys1_pll_160=
m", "sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
 					 "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
=20
-static const char *imx8mq_i2c3_sels[] =3D {"osc_25m", "sys1_pll_160m", "sy=
s2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
+static const char * const imx8mq_i2c3_sels[] =3D {"osc_25m", "sys1_pll_160=
m", "sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
 					 "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
=20
-static const char *imx8mq_i2c4_sels[] =3D {"osc_25m", "sys1_pll_160m", "sy=
s2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
+static const char * const imx8mq_i2c4_sels[] =3D {"osc_25m", "sys1_pll_160=
m", "sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
 					 "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
=20
-static const char *imx8mq_uart1_sels[] =3D {"osc_25m", "sys1_pll_80m", "sy=
s2_pll_200m", "sys2_pll_100m",
+static const char * const imx8mq_uart1_sels[] =3D {"osc_25m", "sys1_pll_80=
m", "sys2_pll_200m", "sys2_pll_100m",
 					  "sys3_pll2_out", "clk_ext2", "clk_ext4", "audio_pll2_out", };
=20
-static const char *imx8mq_uart2_sels[] =3D {"osc_25m", "sys1_pll_80m", "sy=
s2_pll_200m", "sys2_pll_100m",
+static const char * const imx8mq_uart2_sels[] =3D {"osc_25m", "sys1_pll_80=
m", "sys2_pll_200m", "sys2_pll_100m",
 					  "sys3_pll2_out", "clk_ext2", "clk_ext3", "audio_pll2_out", };
=20
-static const char *imx8mq_uart3_sels[] =3D {"osc_25m", "sys1_pll_80m", "sy=
s2_pll_200m", "sys2_pll_100m",
+static const char * const imx8mq_uart3_sels[] =3D {"osc_25m", "sys1_pll_80=
m", "sys2_pll_200m", "sys2_pll_100m",
 					  "sys3_pll2_out", "clk_ext2", "clk_ext4", "audio_pll2_out", };
=20
-static const char *imx8mq_uart4_sels[] =3D {"osc_25m", "sys1_pll_80m", "sy=
s2_pll_200m", "sys2_pll_100m",
+static const char * const imx8mq_uart4_sels[] =3D {"osc_25m", "sys1_pll_80=
m", "sys2_pll_200m", "sys2_pll_100m",
 					  "sys3_pll2_out", "clk_ext2", "clk_ext3", "audio_pll2_out", };
=20
-static const char *imx8mq_usb_core_sels[] =3D {"osc_25m", "sys1_pll_100m",=
 "sys1_pll_40m", "sys2_pll_100m",
+static const char * const imx8mq_usb_core_sels[] =3D {"osc_25m", "sys1_pll=
_100m", "sys1_pll_40m", "sys2_pll_100m",
 					     "sys2_pll_200m", "clk_ext2", "clk_ext3", "audio_pll2_out", };
=20
-static const char *imx8mq_usb_phy_sels[] =3D {"osc_25m", "sys1_pll_100m", =
"sys1_pll_40m", "sys2_pll_100m",
+static const char * const imx8mq_usb_phy_sels[] =3D {"osc_25m", "sys1_pll_=
100m", "sys1_pll_40m", "sys2_pll_100m",
 					     "sys2_pll_200m", "clk_ext2", "clk_ext3", "audio_pll2_out", };
=20
-static const char *imx8mq_ecspi1_sels[] =3D {"osc_25m", "sys2_pll_200m", "=
sys1_pll_40m", "sys1_pll_160m",
+static const char * const imx8mq_ecspi1_sels[] =3D {"osc_25m", "sys2_pll_2=
00m", "sys1_pll_40m", "sys1_pll_160m",
 					   "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out=
", };
=20
-static const char *imx8mq_ecspi2_sels[] =3D {"osc_25m", "sys2_pll_200m", "=
sys1_pll_40m", "sys1_pll_160m",
+static const char * const imx8mq_ecspi2_sels[] =3D {"osc_25m", "sys2_pll_2=
00m", "sys1_pll_40m", "sys1_pll_160m",
 					   "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out=
", };
=20
-static const char *imx8mq_pwm1_sels[] =3D {"osc_25m", "sys2_pll_100m", "sy=
s1_pll_160m", "sys1_pll_40m",
+static const char * const imx8mq_pwm1_sels[] =3D {"osc_25m", "sys2_pll_100=
m", "sys1_pll_160m", "sys1_pll_40m",
 					 "sys3_pll2_out", "clk_ext1", "sys1_pll_80m", "video_pll1_out", };
=20
-static const char *imx8mq_pwm2_sels[] =3D {"osc_25m", "sys2_pll_100m", "sy=
s1_pll_160m", "sys1_pll_40m",
+static const char * const imx8mq_pwm2_sels[] =3D {"osc_25m", "sys2_pll_100=
m", "sys1_pll_160m", "sys1_pll_40m",
 					 "sys3_pll2_out", "clk_ext1", "sys1_pll_80m", "video_pll1_out", };
=20
-static const char *imx8mq_pwm3_sels[] =3D {"osc_25m", "sys2_pll_100m", "sy=
s1_pll_160m", "sys1_pll_40m",
+static const char * const imx8mq_pwm3_sels[] =3D {"osc_25m", "sys2_pll_100=
m", "sys1_pll_160m", "sys1_pll_40m",
 					 "sys3_pll2_out", "clk_ext2", "sys1_pll_80m", "video_pll1_out", };
=20
-static const char *imx8mq_pwm4_sels[] =3D {"osc_25m", "sys2_pll_100m", "sy=
s1_pll_160m", "sys1_pll_40m",
+static const char * const imx8mq_pwm4_sels[] =3D {"osc_25m", "sys2_pll_100=
m", "sys1_pll_160m", "sys1_pll_40m",
 					 "sys3_pll2_out", "clk_ext2", "sys1_pll_80m", "video_pll1_out", };
=20
-static const char *imx8mq_gpt1_sels[] =3D {"osc_25m", "sys2_pll_100m", "sy=
s1_pll_400m", "sys1_pll_40m",
+static const char * const imx8mq_gpt1_sels[] =3D {"osc_25m", "sys2_pll_100=
m", "sys1_pll_400m", "sys1_pll_40m",
 					 "sys1_pll_80m", "audio_pll1_out", "clk_ext1", };
=20
-static const char *imx8mq_wdog_sels[] =3D {"osc_25m", "sys1_pll_133m", "sy=
s1_pll_160m", "vpu_pll_out",
+static const char * const imx8mq_wdog_sels[] =3D {"osc_25m", "sys1_pll_133=
m", "sys1_pll_160m", "vpu_pll_out",
 					 "sys2_pll_125m", "sys3_pll2_out", "sys1_pll_80m", "sys2_pll_166m", }=
;
=20
-static const char *imx8mq_wrclk_sels[] =3D {"osc_25m", "sys1_pll_40m", "vp=
u_pll_out", "sys3_pll2_out", "sys2_pll_200m",
+static const char * const imx8mq_wrclk_sels[] =3D {"osc_25m", "sys1_pll_40=
m", "vpu_pll_out", "sys3_pll2_out", "sys2_pll_200m",
 					  "sys1_pll_266m", "sys2_pll_500m", "sys1_pll_100m", };
=20
-static const char *imx8mq_dsi_core_sels[] =3D {"osc_25m", "sys1_pll_266m",=
 "sys2_pll_250m", "sys1_pll_800m",
+static const char * const imx8mq_dsi_core_sels[] =3D {"osc_25m", "sys1_pll=
_266m", "sys2_pll_250m", "sys1_pll_800m",
 					     "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll1=
_out", };
=20
-static const char *imx8mq_dsi_phy_sels[] =3D {"osc_25m", "sys2_pll_125m", =
"sys2_pll_100m", "sys1_pll_800m",
+static const char * const imx8mq_dsi_phy_sels[] =3D {"osc_25m", "sys2_pll_=
125m", "sys2_pll_100m", "sys1_pll_800m",
 					    "sys2_pll_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out",=
 };
=20
-static const char *imx8mq_dsi_dbi_sels[] =3D {"osc_25m", "sys1_pll_266m", =
"sys2_pll_100m", "sys1_pll_800m",
+static const char * const imx8mq_dsi_dbi_sels[] =3D {"osc_25m", "sys1_pll_=
266m", "sys2_pll_100m", "sys1_pll_800m",
 					    "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll1_=
out", };
=20
-static const char *imx8mq_dsi_esc_sels[] =3D {"osc_25m", "sys2_pll_100m", =
"sys1_pll_80m", "sys1_pll_800m",
+static const char * const imx8mq_dsi_esc_sels[] =3D {"osc_25m", "sys2_pll_=
100m", "sys1_pll_80m", "sys1_pll_800m",
 					    "sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out", =
};
=20
-static const char *imx8mq_csi1_core_sels[] =3D {"osc_25m", "sys1_pll_266m"=
, "sys2_pll_250m", "sys1_pll_800m",
+static const char * const imx8mq_csi1_core_sels[] =3D {"osc_25m", "sys1_pl=
l_266m", "sys2_pll_250m", "sys1_pll_800m",
 					      "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll=
1_out", };
=20
-static const char *imx8mq_csi1_phy_sels[] =3D {"osc_25m", "sys2_pll_125m",=
 "sys2_pll_100m", "sys1_pll_800m",
+static const char * const imx8mq_csi1_phy_sels[] =3D {"osc_25m", "sys2_pll=
_125m", "sys2_pll_100m", "sys1_pll_800m",
 					     "sys2_pll_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out"=
, };
=20
-static const char *imx8mq_csi1_esc_sels[] =3D {"osc_25m", "sys2_pll_100m",=
 "sys1_pll_80m", "sys1_pll_800m",
+static const char * const imx8mq_csi1_esc_sels[] =3D {"osc_25m", "sys2_pll=
_100m", "sys1_pll_80m", "sys1_pll_800m",
 					     "sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out",=
 };
=20
-static const char *imx8mq_csi2_core_sels[] =3D {"osc_25m", "sys1_pll_266m"=
, "sys2_pll_250m", "sys1_pll_800m",
+static const char * const imx8mq_csi2_core_sels[] =3D {"osc_25m", "sys1_pl=
l_266m", "sys2_pll_250m", "sys1_pll_800m",
 					      "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll=
1_out", };
=20
-static const char *imx8mq_csi2_phy_sels[] =3D {"osc_25m", "sys2_pll_125m",=
 "sys2_pll_100m", "sys1_pll_800m",
+static const char * const imx8mq_csi2_phy_sels[] =3D {"osc_25m", "sys2_pll=
_125m", "sys2_pll_100m", "sys1_pll_800m",
 					     "sys2_pll_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out"=
, };
=20
-static const char *imx8mq_csi2_esc_sels[] =3D {"osc_25m", "sys2_pll_100m",=
 "sys1_pll_80m", "sys1_pll_800m",
+static const char * const imx8mq_csi2_esc_sels[] =3D {"osc_25m", "sys2_pll=
_100m", "sys1_pll_80m", "sys1_pll_800m",
 					     "sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out",=
 };
=20
-static const char *imx8mq_pcie2_ctrl_sels[] =3D {"osc_25m", "sys2_pll_250m=
", "sys2_pll_200m", "sys1_pll_266m",
+static const char * const imx8mq_pcie2_ctrl_sels[] =3D {"osc_25m", "sys2_p=
ll_250m", "sys2_pll_200m", "sys1_pll_266m",
 					       "sys1_pll_800m", "sys2_pll_500m", "sys2_pll_333m", "sys3_pll2_=
out", };
=20
-static const char *imx8mq_pcie2_phy_sels[] =3D {"osc_25m", "sys2_pll_100m"=
, "sys2_pll_500m", "clk_ext1",
+static const char * const imx8mq_pcie2_phy_sels[] =3D {"osc_25m", "sys2_pl=
l_100m", "sys2_pll_500m", "clk_ext1",
 					      "clk_ext2", "clk_ext3", "clk_ext4", "sys1_pll_400m", };
=20
-static const char *imx8mq_pcie2_aux_sels[] =3D {"osc_25m", "sys2_pll_200m"=
, "sys2_pll_50m", "sys3_pll2_out",
+static const char * const imx8mq_pcie2_aux_sels[] =3D {"osc_25m", "sys2_pl=
l_200m", "sys2_pll_50m", "sys3_pll2_out",
 					      "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_160m", "sys1_pll_200=
m", };
=20
-static const char *imx8mq_ecspi3_sels[] =3D {"osc_25m", "sys2_pll_200m", "=
sys1_pll_40m", "sys1_pll_160m",
+static const char * const imx8mq_ecspi3_sels[] =3D {"osc_25m", "sys2_pll_2=
00m", "sys1_pll_40m", "sys1_pll_160m",
 					   "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out=
", };
-static const char *imx8mq_dram_core_sels[] =3D {"dram_pll_out", "dram_alt_=
root", };
+static const char * const imx8mq_dram_core_sels[] =3D {"dram_pll_out", "dr=
am_alt_root", };
=20
-static const char *imx8mq_clko2_sels[] =3D {"osc_25m", "sys2_pll_200m", "s=
ys1_pll_400m", "sys2_pll_166m", "audio_pll1_out",
+static const char * const imx8mq_clko2_sels[] =3D {"osc_25m", "sys2_pll_20=
0m", "sys1_pll_400m", "sys2_pll_166m", "audio_pll1_out",
 					 "video_pll1_out", "ckil", };
=20
 static struct clk_onecell_data clk_data;
--=20
2.7.4

