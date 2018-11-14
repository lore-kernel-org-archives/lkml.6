Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A24C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C4922360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gbq5VLA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C4922360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbeKNXFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:05:13 -0500
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:16800
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733021AbeKNXFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg/1rh4wBmVDadNyvr1KevifY1vHFXdP1rgVWZDG3Zo=;
 b=Gbq5VLA/jjuf2fe2xFqxt5+BN2lXKqv6YgY11Sq7VnF+lUInPnav6FSQIFOuSEw7R8J/zpNqebLY+PxLnKSbZMxo8cSP6XBTsyzVAQgYNimB0N4B1zrC45ZkGZzJ2X1DhzXkP3zBo5zR6JeeIA6tg4OqHCUxS+N1Ld2Xq0SPatc=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5985.eurprd04.prod.outlook.com (20.178.114.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Wed, 14 Nov 2018 13:02:00 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 13:02:00 +0000
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
Subject: [PATCH V6 7/9] clk: imx: make mux parent strings const
Thread-Topic: [PATCH V6 7/9] clk: imx: make mux parent strings const
Thread-Index: AQHUfBo7I6cYLtI/ckmZJ0WKpHh1wA==
Date:   Wed, 14 Nov 2018 13:02:00 +0000
Message-ID: <1542200198-3017-8-git-send-email-aisheng.dong@nxp.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::21) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5985;6:bcXZ0/yMvxInZ98eqfYQjOZRA0cMw/953KZF/f6JImKmklknIbe3zamHzWYFCggA3ytpGo/QPlDanZCj39Kt1pXCZi8/Vo4QF4QFkkYMv7v4eViFUNr5NUjMJ5dgMmCX1mXH9e3sAGpKR73KuXs5Sqc+rbKe9BUQoeu605YtsxxA0KeBe37OAdAimKIq+uFkomfE6ypJ7wPtNod+ka4nw6UAYAoo4Qcoow2FjfBnLpM84W4HS+l8Yv6eG7wiIdXKYeV/k9vkBaLvq4vlua1apo+c+w9XxPcC8hZIZ7CtcT/ci7Z1BInU8gf3a8CAgipobtwGQfuwrbx/ZBn80HlH344y+5/D5EprYs9dlzX4grWu0IITFfd/7wEKGd44D6Fpn+bP8vuLNck2w1I1Bm4SfjSVycK1qpBSID9MaApEIx9BD4D5dXnRBgkelvTNYH5SxAVaec/aB/xekOBxNGkDhQ==;5:sVImCZ/voCjpQs/xgRdoPF4buLn4Zh9Tvg758HtQtTWvomLB+g+inY3EpqD7Wpw6+6meoZr7LVj99v2yZqgTibd7PG706pFfW3/uKp285WA0rJ/OoPS9dueOV5dx0tWghshw4bE4JbkVuhkyElD4PIWln3+eEqpzTQELobo3Jdc=;7:7QUYlDoJFt8vZmFZSqge2pO4Esz21X01BYHYXcE9Pagzi1TbGUfw308YiSRNqeSyaw0aCXX9c0RrUuzmm0058qTDolkpIimk3uJ0MUwvA9fK+lLQdqNWxwjEAvNo0vPFt/jHQsBojpI6ymiS+mLzbg==
x-ms-office365-filtering-correlation-id: 3eb220ec-509f-44df-c3fa-08d64a315d65
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5985;
x-ms-traffictypediagnostic: AM0PR04MB5985:
x-microsoft-antispam-prvs: <AM0PR04MB59852D13ED02B6927BB5C6BE80C30@AM0PR04MB5985.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5985;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5985;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(39860400002)(376002)(54534003)(189003)(199004)(6916009)(305945005)(316002)(446003)(54906003)(476003)(14454004)(2616005)(68736007)(5660300001)(11346002)(53936002)(14444005)(8676002)(486006)(105586002)(7736002)(256004)(186003)(25786009)(4326008)(2906002)(99286004)(6512007)(6116002)(52116002)(81156014)(66066001)(81166006)(3846002)(76176011)(5640700003)(50226002)(386003)(6506007)(102836004)(71200400001)(71190400001)(26005)(86362001)(106356001)(2351001)(2900100001)(2501003)(6436002)(6486002)(97736004)(8936002)(36756003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5985;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5O5d5ARx/sEhnZYOQblweJARtN09PX9L7sc3GgjhpJ0hi0VvqZvt9mauJPrQzWRJGDVgkiqBTGMVvGP1UJ7MDlKno1j69dPo4lL/JJTJW913dder0OuEobnQ1FkIeud63k4iJ/vHNKDCEo8az8yzjPTcKNOKvwLJ/OCx6bO0hKLQmTuEO8HAthNvXZfNzH9eAD5D2M6/rx4U7B3oFqar959KosIziW1o+zZQcYxzzBcWLk6NEF9lVI5L15yAeXWZD1n+nH+42J2uCgCzK908OXZqVP48yluCblrRb4nPiFgpNewB7BKfAP4oqXZGS3rpkt1EvFvNK1Qg5Y/mpPX21iH8KvaobCgT501SsUOC+yg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb220ec-509f-44df-c3fa-08d64a315d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 13:02:00.2999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5985
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
index 2e3bcfa..3886979 100644
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

