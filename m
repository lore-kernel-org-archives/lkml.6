Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936031AbeEYHxH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:53:07 -0400
Received: from mail-db5eur01on0059.outbound.protection.outlook.com ([104.47.2.59]:18496
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964804AbeEYHwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:52:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH RESEND V4 7/9] clk: imx: make mux parent strings const
Date: Fri, 25 May 2018 15:51:09 +0800
Message-Id: <1527234671-31755-8-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527234671-31755-1-git-send-email-aisheng.dong@nxp.com>
References: <1527234671-31755-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::23) To AM0PR04MB4210.eurprd04.prod.outlook.com
 (2603:10a6:208:66::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4210;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;3:2wxHdq2YmQlCJAjID/dKD+8dKnxsDUpj0WMUYGYPN0QiUR5RtPLGtIyHUQzubY0+S3Wws2DQa3pJ2mSm4q5RG3uq/o9oL5cDzisXxiti7Ae3XerWl4rNu8HbFXW3+hLrUYPxrj/SpKGHwbMFeBfHNTAZxwDCilPZRGrajsBc0vyGELpmAMpYOmwqRWx0mFV6TV0q55daH06OU3OJ4GJcbQLuOMjy8OsE45htxzDUZQDI20UHfIOFIiei5r+jLxwm;25:OWv0Z4vWNkuc1mXNlVyCJWUxraCP/GcIw68egYXHgM5p49kf1/mSA1mjtS0thD9zuziuLMpg/xWmKBoYejMkWcRogvIzBKlgU/Jq3gZIqO5Gk6WNyd76iT4kJ+yxn4v/y8qp6mtTdDWDbS/8RQl7fDXsYTYpHrVZrYbztYRwtejPGiQFBf15YMCJUgx8thwthfUZvnP9f0lZ1W0KkWfXXHSTr08hSC/Ly8kMMFTiRXr/qBCdCWcfBX5YWaKFuXvTwreqO7tbTUCwmsfjGlkKpZC1X/CPDIfLAZnjVRbXbplW+p/QyGVtJEpfAHW+2emwK9UfCe1OKjIkl2JGljJdXw==;31:1T71KrdZVDrVXlAVoX0Jv1VP9gsCI+ktHZp/Q0iJFJHjvL4M8n+0ng1oQLDFk2Ie8MxZCPqodihnb7dRSTD2rxTWGFx+rMVDV1t7k5yE/ppHNP/6bvKGZJDhgxjtlLo7TMtbVuvuta97Mp74dgUnndBO83hndob0PJAeLwfD5RYmJ7JFeFMJ7Dx7Z2DK6aIqHeg5wwOLYL5dtQSONobV5C6l3jO4SohRQTHjYXc+5TU=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4210:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;20:Wjzc647QwGYIQXonkRV8IKdFr6lH29QZoUn/wabPwZqIJNs5jcnagTFHMyA94S6nGsYT3qaNA3Zhb9j0iX0RVSMvM7kjiNIN7KdqL34bYqECUsdmQFnWTzDNLw7sFxizZPekRlrFj+sexN/LJHx7nRuRQJTbVIpnJIMi5bNrGhBHV8byJKSqQxu/BwFTuIaIyA6qFv5ErALqtZCYf4u9KJ9MUwQA1rsGr60SAG3uBsp6/RGspXIQHuOeJna77UBy8f2Re6eMpLtNgFxJ2a7RhWOUCyP60UW+6RiGKMKFGESqXqwRwf+WG72oRvzhz4K/1uAASQXnRNz02mdCKN8I5urQ0rjjlh+tiX5QcvhJxG3BvNfSaPlH8KRqFyd60ADhuMGscn60iSl/dGVoOMrqR7BlQWhrN+HsFD31+5egiJzGB8m/hsQeK0z3dXVIGhcmMnzfjcZf3HHuQUADsSPLrXgIP46wsWMARbL7R3V8ldaAlmjVkz0xnMEiXxQqPYeg;4:5VC+Vztb/ocwuqMdimyLEh9tgjxfwrXgeX7iezXn+VxBZvEAKk9eKmdCcoWlP3R246YBomq1Z2XSPfRugFNQYuy9npiIw1y4V70Gm+hnIpRi9d15E2HEnfLPZVVlPL7SqLe6zgqTG9yTBnHdtKh1E4I2VFpzzgikTTwDF9CoIR1HlgyOnjuZubDurM9NpYa733LXs2MNfPMvxEho7fFuDIxdD2yvCjXVT2P6rXJPkc7HnuZ+eNE5UUgQm5F2tEguGnYIhT+oEeP6V1Hbu1G9ihb9kUWP2CDpsIKkR9TYO0C45JTKUcSomvb/NRGnFjkN
X-Microsoft-Antispam-PRVS: <AM0PR04MB421007602C914EE3F8875F0980690@AM0PR04MB4210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4210;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4210;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(199004)(189003)(54534003)(8936002)(6486002)(50226002)(478600001)(2361001)(3846002)(6116002)(53936002)(2906002)(66066001)(6666003)(52116002)(68736007)(51416003)(76176011)(47776003)(6506007)(386003)(59450400001)(6512007)(81166006)(81156014)(8676002)(25786009)(4326008)(6916009)(956004)(16586007)(7736002)(305945005)(50466002)(105586002)(106356001)(48376002)(86362001)(5660300001)(36756003)(2351001)(97736004)(476003)(26005)(486006)(186003)(54906003)(16526019)(316002)(2616005)(446003)(11346002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4210;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4210;23:KoYCCeCdveo2LsijuorDlhvY9R4ZvkEnyPyOZ3Y0l?=
 =?us-ascii?Q?j+fC/PCxsgHZVOBOcI4o//o0dYRoBGMw1Zes9m7YG0KGMhuYqWj2Hpp1gG0l?=
 =?us-ascii?Q?arERNYgLvNGJKEdxsr7fzZ3Qrp0ktX+4OoyQ6BIB8V96iGwOeC+IIODSHUi6?=
 =?us-ascii?Q?VnK+n/ff2JeUnjpcCyxKUXP33Mz1tbiEhxe7fRkLqFnC5CgWIGev63uEE9IS?=
 =?us-ascii?Q?LjSBdBd+tFe5lkHrvA4ATUmNDbVNMBM9TzJRJEpi+/g9d0mPiqdS+cHP2XsT?=
 =?us-ascii?Q?Roo4UTVQuJQ1K0fufsX2yCQQogVBbc6agp5uKimZv7Ae1Ps/j3xu2nboaZzE?=
 =?us-ascii?Q?/Xwk4L4J101rPnzhLNK8mCv1mgV0IG8AaNC/tIWBF00e1xb7wYPoQ3raOI8m?=
 =?us-ascii?Q?xZzqSLbJcZ/PJrsclNmNZTYDNr92buZqRznrqtOWrZUsYZK5QVylujXuTqZC?=
 =?us-ascii?Q?rbR/nG8fuH0BC6OqmPWDxFzGjFNzepAqxCfy2KRXenwY0dtntapMfaDbVGAh?=
 =?us-ascii?Q?VI4OUcqaEjqTM5U52YGwiWFbUy8lKxjni7kESBDguhuYdimtjiW2u2DQfLm8?=
 =?us-ascii?Q?zoHN4b2ujlFVA64PytM42zHIdfYz7+k+OGUlK/UK82EzOo5y6U1PTZfi19ej?=
 =?us-ascii?Q?yNbCb49V8mw0SDfw5xhb4sWJCXOokb1/sQwj+7V3GGlil+UwaClEqYdjV5vc?=
 =?us-ascii?Q?h14WKVudhW8mciDQ9GzznYk7JkOm4nWJ7aB+vcHfYb6FEFMV9wQD8LnhQHdw?=
 =?us-ascii?Q?bGyUubHr5PdDOc1IVryjUSLOaDRREfy1PdX0kS5zfpsztr7qLdJ5UriiVXMC?=
 =?us-ascii?Q?iWm4FqjhjlQ+NR9+1LHY74UJz10evDX9Il2JDK4GOpr5edqOmX3feFQA/PZp?=
 =?us-ascii?Q?PVlFUZr/l8r9Vlj3bzhxEUzYTBghheH0eoJ351Of5Ie/PAxXC1IOTfIRMfSf?=
 =?us-ascii?Q?1DTnp+VoRGqKk5iIHXI2K/ElmIKcJHpFVg1RyIn3H+D4jnmHYlFxmfzAfKpX?=
 =?us-ascii?Q?sYuG/iES+Hm6Dqg5C5cgtzlvhzYAq6zjA4eh9xuJJyZCAG3DLFs1Cweh7DB0?=
 =?us-ascii?Q?bv8FbIaZP5uCCsyitsVbhv7ogDJj/MldHZ4LulhuxBCSTwIkid+FmnX9iomJ?=
 =?us-ascii?Q?Tn8Lpo6WvPKI0xuR03RQww3p1WJIL9EoI9u2mvbKfPTq3YuLkU9d+9IcbGBp?=
 =?us-ascii?Q?ODOcZlmPSWKGCBHhcRuA/bgLjNf99GE0J/+o8xScJU65olut1fiU5XjqXNRD?=
 =?us-ascii?Q?DsAuotMx5XC/VjPZ515pq2TyBwZcyUApUNukxSA0QTj8N9mJdbbzMKfOvoYR?=
 =?us-ascii?Q?mYxEpY2WObgTC04kYEuZuY=3D?=
X-Microsoft-Antispam-Message-Info: IisCww4QrBdASPlLrEMONebaBsIgfapKrQq4cs0T654dUrcbHbEXC/C+lW7I+yYb0ymzwN8GNQwL1rcxgk/iwa2F1KK39aWs85hPF/FteoQGw290MDovgu2bX7HYVj575JhZLZHyz5+ha8gyjLjXNuAtcvt51AMJ7JPPYRycit9wNnXNgu2Xjx8DhzJWHYYQ
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;6:Qvf0OgefWlCjf3PTHRzzt9pn2ildy8/KC7J+UPCao8U/0JoqprzSlwA5Rnqk41O7lcybwuPbVE+zsEF6U0ZWP0ow9pPxslMWHowJaqzJAvBP2MdiZE20hdA6xjGE8mWtn16XzGNwNjrizCCUZARLUClNBGVESKNbv9kZGENsWz9j2sT8lQKHkvRt3KYc9qbemL/uvE6leVSe1UBrlYDBLIWzdvqcZusFDlG4gGpFtf3kRzSzUm4t5UvMwLWIuD6wm5kxHUln/reh5W1fb+Jk7b/rZZFXgQqRH1wIq0GSNvKKyqxA1x7o++nJUAgKtxxa0Gb/Bfk5gqsSLBBkvw+I1d7CZltbLfe7XlV6eOnkkrG4c5IYQfLIjMlqmiZSGweGKK7HgNPY6SPNXz7etRkBUUbgFGn/YIuxFak7h+Uyl+6PonG/aFh9lVIqYMlJViB/zH7y0C4Jv1PhVgkGqkb15g==;5:SH1QzGmKujziFUo56MsH848GemaSVCM4SESmOpAVsjWtTXCXazZd0ImjLUlRQ1m+kTKwWZRbb8UkdcTC5ysLwqF0bWDI0fRbeUiLsjzq4bGMg1aM8CXTBvBUMZ9KSAtEf3h+REJa+6cC2hmDo9daeZ0bYZ+c6pM3eaFCTRH8SM8=;24:AVRAETgGsQqtpD8iArKXBlTmSiIkYHZ9Miv9T35v+mZ/4a+R/7wU6zuVUVg0PpIrYnGX8iaSM4XaNSiHBnM06fJJ470mITEln08O7ZKlUcE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;7:axDfDdyeiVCqY6Qcd1mcB823kv01I16Mb+6DqnYxR5Vu+6nFjHA9p+S8Bb8GkjQtwFQpu48/9AlBKoAptxWsPxISMUxxI8VJbCbHCiauhWas9WTLU1D71Ed7Z7Jat3R5uk/5lBY4Oi390Zzi2Xx/L8PVXPsdING1vcX3SXQjEuC44M32BN3T3RLpg9znReI4XPkTysVVEmrE0q7/Iu+qI8rSv6LkvTVZPFVUjmPT2JjaH5r+7mFM22N+z1TlYByc
X-MS-Office365-Filtering-Correlation-Id: 3d397658-985d-4b4b-cbef-08d5c214666b
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 07:51:58.1763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d397658-985d-4b4b-cbef-08d5c214666b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the commit 2893c379461a ("clk: make strings in parent name arrays
const"), let's make the parent strings const, otherwise we may meet
the following warning when compiling:

drivers/clk/imx/clk-imx7ulp.c: In function 'imx7ulp_clocks_init':
drivers/clk/imx/clk-imx7ulp.c:73:35: warning: passing argument 5 of
	'imx_clk_mux_flags' discards 'const' qualifier from pointer target type

  clks[IMX7ULP_CLK_APLL_PRE_SEL] = imx_clk_mux_flags("apll_pre_sel", base + 0x508, 0,
	1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GATE);
                                   ^
In file included from drivers/clk/imx/clk-imx7ulp.c:23:0:
drivers/clk/imx/clk.h:200:27: note: expected 'const char **' but argument is
 of type 'const char * const*'
...

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v1->v3: no changes
---
 drivers/clk/imx/clk-busy.c      |  2 +-
 drivers/clk/imx/clk-fixup-mux.c |  2 +-
 drivers/clk/imx/clk.h           | 18 +++++++++++-------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
index 9903652..e695622 100644
--- a/drivers/clk/imx/clk-busy.c
+++ b/drivers/clk/imx/clk-busy.c
@@ -154,7 +154,7 @@ static const struct clk_ops clk_busy_mux_ops = {
 
 struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
-			     const char **parent_names, int num_parents)
+			     const char * const *parent_names, int num_parents)
 {
 	struct clk_busy_mux *busy;
 	struct clk *clk;
diff --git a/drivers/clk/imx/clk-fixup-mux.c b/drivers/clk/imx/clk-fixup-mux.c
index c9b327e..44817c1 100644
--- a/drivers/clk/imx/clk-fixup-mux.c
+++ b/drivers/clk/imx/clk-fixup-mux.c
@@ -70,7 +70,7 @@ static const struct clk_ops clk_fixup_mux_ops = {
 };
 
 struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
-			      u8 shift, u8 width, const char **parents,
+			      u8 shift, u8 width, const char * const *parents,
 			      int num_parents, void (*fixup)(u32 *val))
 {
 	struct clk_fixup_mux *fixup_mux;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index bc43f68..7fca912 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -69,7 +69,7 @@ struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
 
 struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
-			     const char **parent_names, int num_parents);
+			     const char * const *parent_names, int num_parents);
 
 struct clk_hw *imx_clk_composite(const char *name,
 				 const char * const *parent_names,
@@ -82,7 +82,7 @@ struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
 				  void (*fixup)(u32 *val));
 
 struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
-			      u8 shift, u8 width, const char **parents,
+			      u8 shift, u8 width, const char * const *parents,
 			      int num_parents, void (*fixup)(u32 *val));
 
 static inline struct clk *imx_clk_fixed(const char *name, int rate)
@@ -91,7 +91,8 @@ static inline struct clk *imx_clk_fixed(const char *name, int rate)
 }
 
 static inline struct clk *imx_clk_mux_ldb(const char *name, void __iomem *reg,
-		u8 shift, u8 width, const char **parents, int num_parents)
+			u8 shift, u8 width, const char * const *parents,
+			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT, reg,
@@ -204,7 +205,8 @@ static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 }
 
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
-		u8 shift, u8 width, const char **parents, int num_parents)
+			u8 shift, u8 width, const char * const *parents,
+			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT, reg, shift,
@@ -212,7 +214,8 @@ static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 }
 
 static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
-		u8 shift, u8 width, const char **parents, int num_parents)
+			u8 shift, u8 width, const char * const *parents,
+			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
@@ -220,8 +223,9 @@ static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
 }
 
 static inline struct clk *imx_clk_mux_flags(const char *name,
-		void __iomem *reg, u8 shift, u8 width, const char **parents,
-		int num_parents, unsigned long flags)
+			void __iomem *reg, u8 shift, u8 width,
+			const char * const *parents, int num_parents,
+			unsigned long flags)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
-- 
2.7.4
