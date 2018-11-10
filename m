Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BEAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC68320817
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TD0tBUyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC68320817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeKKAUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:20:04 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:35840
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726283AbeKKAUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyjwAL1yIXsoXrVWf7+N2WLsI7mvd+BVE8pT37n19oI=;
 b=TD0tBUyqLj3Fl11Ji3PbUbbHY7FFk/qvw6KxAFvBTxE2dXFHZ7Oi5JUd7jBDBe7FUgozaJF7u9bOkKNGkY8N4SkQyAQKsgGpIrDDPiR9pO3em6OaAluocRZoOP6s1mginsozgcFOp+Tzh+wvsXx7uqorsPXx8uP9lk0KCPCGFgE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4402.eurprd04.prod.outlook.com (52.135.148.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Sat, 10 Nov 2018 14:34:43 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.039; Sat, 10 Nov 2018
 14:34:43 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V5 7/9] clk: imx: make mux parent strings const
Thread-Topic: [PATCH V5 7/9] clk: imx: make mux parent strings const
Thread-Index: AQHUeQKFB61LRb48akiUiqE0r4Bq0g==
Date:   Sat, 10 Nov 2018 14:34:43 +0000
Message-ID: <1541860165-401-8-git-send-email-aisheng.dong@nxp.com>
References: <1541860165-401-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1541860165-401-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::20) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4402;6:5ZDGgpAiDID65ptOsNIR67Tiahp2WJQUlb9G03Ky5twst038xcZE1illB15vRM0kAZjpIvg3IISIKJKS17Ndf9zvVuPbuAJ9pZNiLc8wrE0ShjHKTVBAvHLgN2ozfp5EZMwHklPmQRyNosOdn9LlKWmjNkq6G9zMok0Q/v85v1Dxuzxt2Mv3XnlShThRRTFEmDPPBAoLvUJFm/BX5Umj5tiobz+TnbcJLcHKS17nnzECymcqoTVmrG4SXIbq1TmzcdZgudElcUsvKXwBkWKES4P5MpkCnuNFbgjx0UE7BRJ6bu2lwZuGiWTvuZpN4nUPdQ+o/+Wv7cmicmBDC9/4f4ecYoggzz/heW/aZunLGG5tvcA6fm6AdabXwGXb7HQOJ+Xd/YPRzUkyrGDPdvLC7RQKGTyslMK1V6w41ZhzLH+XPK8FMAdDl50wC5+BZ39az0eMQgPyJQJ70O6eUBjKfg==;5:gBVX/AnvwIOrnnEjp9fLQsKXJOF5SNzr/D753ipRnzl/mou+OGzsdPiDsLtMUww+bjeHjssugRE0YC18n6JRoLJVvmbikgd8UtFFs1aueKYjVZaOkihHGrxVTylHFK7DbYcd6qGRuM51p5iSGaDh0VgiPtoV6VddplA1/RQiINc=;7:oyDydXPuTw+hLuko5MwGhTh2pRhL9/5phj0JQjI6qPwPpn5S1c47T20p9eUR7uHjPZwIiCq6IFqh4SmAJW+ZkGjJLVYXDQzCaPYAmRtAu34RtSt1AuYSVS1Hhzx7cXqQV0Z8xUvUS+1mGXnCvRrMTA==
x-ms-office365-filtering-correlation-id: 88d0808e-9006-44bf-48fc-08d64719a787
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4402;
x-ms-traffictypediagnostic: AM0PR04MB4402:
x-microsoft-antispam-prvs: <AM0PR04MB4402150B08D1F1B246A678A980C70@AM0PR04MB4402.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4402;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4402;
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(54534003)(6512007)(478600001)(102836004)(36756003)(14444005)(4326008)(105586002)(256004)(76176011)(97736004)(71200400001)(71190400001)(106356001)(14454004)(386003)(6506007)(52116002)(2351001)(5660300001)(25786009)(5640700003)(2906002)(81166006)(81156014)(66066001)(6436002)(26005)(186003)(6916009)(8676002)(54906003)(8936002)(3846002)(305945005)(486006)(7736002)(6116002)(2900100001)(446003)(11346002)(68736007)(53936002)(476003)(2501003)(99286004)(6486002)(50226002)(2616005)(316002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4402;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +9jBX2nBU98g+lH581cHAu6n2ARTQCKAagnR990bbG4Tg8rSaWvN2CcPkSOT8Z6xI34aorfGgy7Oe7/jqsOyd7Y9l7SfqBLhPFBgFmk4BwrNKhVpBBQ0xv3FyH8oLtvLL6Wybrr1H7TPkdS3/RVk0WeUI+jIUbV8neuVBaUY2UoqgLginmTPSUB7Kx6WP67fGnFwZ9HU78ajzWCU1auuLpuWixcuDwHP6zP3KeCMODS85Ix2sLnK6Cbn43oOORHRjq8Q++nYIQ1VMykMQrOEvjh4zt92FOZgBUmM2K2Ezn5EzNedso9pRJonkCi5lbjrTjNrz+hNoIWP7I9D+rDgJcy+cS7p5re422Z5ybDELQU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d0808e-9006-44bf-48fc-08d64719a787
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2018 14:34:43.4122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4402
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the commit 2893c379461a ("clk: make strings in parent name arrays
const"), let's make the parent strings const, otherwise we may meet
the following warning when compiling:

drivers/clk/imx/clk-imx7ulp.c: In function 'imx7ulp_clocks_init':
drivers/clk/imx/clk-imx7ulp.c:73:35: warning: passing argument 5 of
	'imx_clk_mux_flags' discards 'const' qualifier from pointer target type

  clks[IMX7ULP_CLK_APLL_PRE_SEL] =3D imx_clk_mux_flags("apll_pre_sel", base=
 + 0x508, 0,
	1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GATE);
                                   ^
In file included from drivers/clk/imx/clk-imx7ulp.c:23:0:
drivers/clk/imx/clk.h:200:27: note: expected 'const char **' but argument i=
s
 of type 'const char * const*'
...

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v1->v4: no changes
---
 drivers/clk/imx/clk-busy.c      |  2 +-
 drivers/clk/imx/clk-fixup-mux.c |  2 +-
 drivers/clk/imx/clk.h           | 18 +++++++++++-------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
index 9903652..e695622 100644
--- a/drivers/clk/imx/clk-busy.c
+++ b/drivers/clk/imx/clk-busy.c
@@ -154,7 +154,7 @@ static const struct clk_ops clk_busy_mux_ops =3D {
=20
 struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift=
,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
-			     const char **parent_names, int num_parents)
+			     const char * const *parent_names, int num_parents)
 {
 	struct clk_busy_mux *busy;
 	struct clk *clk;
diff --git a/drivers/clk/imx/clk-fixup-mux.c b/drivers/clk/imx/clk-fixup-mu=
x.c
index c9b327e..44817c1 100644
--- a/drivers/clk/imx/clk-fixup-mux.c
+++ b/drivers/clk/imx/clk-fixup-mux.c
@@ -70,7 +70,7 @@ static const struct clk_ops clk_fixup_mux_ops =3D {
 };
=20
 struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
-			      u8 shift, u8 width, const char **parents,
+			      u8 shift, u8 width, const char * const *parents,
 			      int num_parents, void (*fixup)(u32 *val))
 {
 	struct clk_fixup_mux *fixup_mux;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 55a6434..290d4b2 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -69,7 +69,7 @@ struct clk *imx_clk_busy_divider(const char *name, const =
char *parent_name,
=20
 struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift=
,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
-			     const char **parent_names, int num_parents);
+			     const char * const *parent_names, int num_parents);
=20
 struct clk_hw *imx7ulp_clk_composite(const char *name,
 				     const char * const *parent_names,
@@ -82,7 +82,7 @@ struct clk *imx_clk_fixup_divider(const char *name, const=
 char *parent,
 				  void (*fixup)(u32 *val));
=20
 struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
-			      u8 shift, u8 width, const char **parents,
+			      u8 shift, u8 width, const char * const *parents,
 			      int num_parents, void (*fixup)(u32 *val));
=20
 static inline struct clk *imx_clk_fixed(const char *name, int rate)
@@ -91,7 +91,8 @@ static inline struct clk *imx_clk_fixed(const char *name,=
 int rate)
 }
=20
 static inline struct clk *imx_clk_mux_ldb(const char *name, void __iomem *=
reg,
-		u8 shift, u8 width, const char **parents, int num_parents)
+			u8 shift, u8 width, const char * const *parents,
+			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT, reg,
@@ -204,7 +205,8 @@ static inline struct clk *imx_clk_gate4(const char *nam=
e, const char *parent,
 }
=20
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
-		u8 shift, u8 width, const char **parents, int num_parents)
+			u8 shift, u8 width, const char * const *parents,
+			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT, reg, shift,
@@ -212,7 +214,8 @@ static inline struct clk *imx_clk_mux(const char *name,=
 void __iomem *reg,
 }
=20
 static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg=
,
-		u8 shift, u8 width, const char **parents, int num_parents)
+			u8 shift, u8 width, const char * const *parents,
+			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
@@ -220,8 +223,9 @@ static inline struct clk *imx_clk_mux2(const char *name=
, void __iomem *reg,
 }
=20
 static inline struct clk *imx_clk_mux_flags(const char *name,
-		void __iomem *reg, u8 shift, u8 width, const char **parents,
-		int num_parents, unsigned long flags)
+			void __iomem *reg, u8 shift, u8 width,
+			const char * const *parents, int num_parents,
+			unsigned long flags)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
--=20
2.7.4

