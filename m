Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935478AbeBMO4b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:56:31 -0500
Received: from mail-bn3nam01on0075.outbound.protection.outlook.com ([104.47.33.75]:60416
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965126AbeBMOzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:55:45 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: <linux-clk@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <sboyd@codeaurora.org>, <mturquette@baylibre.com>,
        <shawnguo@kernel.org>, <Anson.Huang@nxp.com>, <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RESEND V3 7/9] clk: imx: make mux parent strings const
Date: Tue, 13 Feb 2018 21:28:12 +0800
Message-ID: <1518528494-25723-8-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
References: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630073429455773;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39380400002)(39860400002)(396003)(376002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(54534003)(105606002)(8676002)(36756003)(81166006)(81156014)(48376002)(97736004)(16586007)(8936002)(26005)(336011)(498600001)(47776003)(51416003)(50466002)(68736007)(2906002)(104016004)(76176011)(77096007)(26826003)(59450400001)(85426001)(5660300001)(86362001)(2950100002)(6916009)(316002)(450100002)(4326008)(50226002)(53936002)(6666003)(2351001)(305945005)(54906003)(356003)(106466001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB1421;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC013;1:H2BzajUybcfQIAn55Qo5xal1utDdJxpNsO48fjz0/HG5nEffluUJfkUw+Ou9XTpVCz91SPqCwctvAy5vzIiJ7kRg/6hdAcwIefZo1INRe4Ak3TlAAQas+E5sNCEf5Vzy
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00d3c7d6-a8e2-4632-a5e7-08d572f1dae4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:CY1PR03MB1421;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1421;3:hF+3JEjIU75c0nS148LpkeKn0xqLXrSY/e9CdrGtyieaqEXJqtuBswMRTrrM+CfoX8N2qHdnbRXNkzVfKBLriC2iBJ8NJMlkklutFLMWIAg01ta3CCdHE2zVwhQSvC0RZ7U+4Ts2xbQxvIRP7futRgjDUFlOQnUv1NTKWuT44VXZXFbznggIIk6BzqomzKk3hJdx/ueI5atfS8myzlba3tqGh8OrzKmhW263vWDipwzkX2zJKs0XwUp7HB9Ac8Dw7xyxAIJmlqNdP0TsCF3sA5fXDtDRhnUhozEo80UqqGQCgd7U8M8gJbJZ6t0QGd7Bn0QuDFsN77StB3DJAsLEdZIGzhsLmopNCUHf/gjp79E=;25:EjvTApfHvM7G4MHTmWi73c/dZWpBKP5J8ZelMFmSeuJgqBfz6yBRXuXEzRxiPlzGsV2V6+8ISErZkET52oKvzj6FplHwXVh+WB+cupKh+wKtz44/s7xu1ytoBz5A5HkbMysUbP/IQTPoI+gFssy+YDqcvVjGjpmAdDiRiXLVslfPTUh5akXQ0QnZQZZhVd1+AtMCsYxcsBJwfDD+DMJlClHxYdl1uNDcLgd32m9B0MTBnuJl1X59/vi8kUuiP50DgbOZQ3H6KQdPsntZEazYEtA7epyhdnYQq0BG5WyAfNGgW5wFgE66fTokSibnTgLt8Ey51fY5zbCAOXyCFoMGlw==
X-MS-TrafficTypeDiagnostic: CY1PR03MB1421:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1421;31:qfcCAelcYNzgh90eAPR9NqpPAEcomBePH2uUiMfDbEBHO7MN/PVHyS33e2CCfpxQxRpM/NPI4td810VMui+RKDGg9KmZCynrruYRPOdQlVH0JeEw7uhkU1ees9JYcK2agh8k6l7+9t1syLqkRY1vkTcGoRdR6DfdQ2CDU3HGUAUgLgakKvTjfr0tHhiqk6nAB48gjzDH0+ZpsybpK6kjiMivLwL/mVzaTV2aSlsgO/U=;4:4BCc4qL/zL4qdqWiWuEC8fMK3z16Ccrr+TAxZMRqzrt0uUZ1GFrrbfFUbI5khqoXrmyNTKEpsgXPyzRCr+Liuke3nfu664Rv7XQQ9SciYPqAfTPw7Y6EyZ8nxo8LxtcyenP5rrcpMMgDR7Lh+adJ8X01Hk4GHtdOnzovCcX80FuIdUdB2N10Pv6JOAxAUFhYkld1wfmyTiw4C9vUwEqcnVlvoGDcbO1gZ7wZI9QhPYioE9TLMK1bZhQnrqP7Azvg9ADSxAug/gl+eOkpHfCpZ4Q5mxUPZDNd6+BPU8UxZXlI5rPjqwTPU+ni8oAcoYtL
X-Microsoft-Antispam-PRVS: <CY1PR03MB142122F7E25663DFEA75F4A580F60@CY1PR03MB1421.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(6096035)(20161123556025)(20161123559100)(20161123565025)(20161123561025)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:CY1PR03MB1421;BCL:0;PCL:0;RULEID:(400006);SRVR:CY1PR03MB1421;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR03MB1421;23:KGeeDLt4PWxm6Qkm0/HtA6HHRdi416kWURq9CAfGG?=
 =?us-ascii?Q?K2BurApv1Pns1gfkxKmMhNnhXtii6eMkp0346xrFPcE1BZpKbUvd+kxse59H?=
 =?us-ascii?Q?41FU+ffrcJ8JO/tt/a6ZgsHRt01xAcClGgy37a50LSUFJGMLJJrBETrOciZm?=
 =?us-ascii?Q?L4gV7V9ahBVQc3sjZD2QqN4x0UQCfofIG/wmkKO+cnNI+Zpz5JtwowXax945?=
 =?us-ascii?Q?zP9hlqJ6buzr3fyaSO5MkJJ0Z0owHTxDRAFs8XpzxFYFc65j0F4vrpl7/ZyW?=
 =?us-ascii?Q?z8sAVfonzffYHrMKSLzZK663NuN+25HhpJGJHZ6hf6cJVHfeRMlZdKWZrr66?=
 =?us-ascii?Q?juBV+1Bc6fqK7+PxnLvGhzbV1ttqppikDFhZk+nehMIsJ008o4GTD9iFF5pD?=
 =?us-ascii?Q?gEQqphEF13QSCx6g0ZcsgaTtqowBPNloyhJxh1yb4exgFNZhSj15inqId5R8?=
 =?us-ascii?Q?12bKfHZcwQ3tMonVEUdiU0/mHqpTPgXGr05RK5+DbK+Qjm7V/G30x+qKdDy6?=
 =?us-ascii?Q?9jL4menORMvLVp7bJW58od61KTnAgBRr/HowEtBDBJLJtH0I03mumUxF15F0?=
 =?us-ascii?Q?qwYEBpGQCGRPf3haLYs6PhnTmgcz52qRkNh8PCvGX+OzO+3NTQE1v0q3a7La?=
 =?us-ascii?Q?ktcZgDyRFvCXZhXKOt5XF6QQZsKzOyDzKFi698BBmtm7sTtlXCqC0wJ9lFDM?=
 =?us-ascii?Q?W6fN3rzWl2ZliOXh+mWLKNSmun9OeCZa3v17tMusvDl2DR67dh54iavBxIDg?=
 =?us-ascii?Q?WPeHi328xwLZYSWpfziuVczJmZ/1LksZBEK/JXhP2CCoXqArZqQ5ksXhoy4Y?=
 =?us-ascii?Q?lCb7xJxn8c4IT5zyFLo5PZF8IuYCS7s7Pkn9pXGe+9DHXmS1ZPzAJ1DSHOva?=
 =?us-ascii?Q?J5OKnnZ/ZeCJ4JSbXohu/0QfnBVlzRBfa25r6nClJN2J98M4LSBhpO947jbU?=
 =?us-ascii?Q?Xdq26jSFPtjnwJQBo4Xe0DUqvTUFEW2JVO3Abidd4/YWU5jFcob4r6LcBm9a?=
 =?us-ascii?Q?olDXnwc6ET0trgiG4O6vWk/851ZarRisggpnj2BdijxhgnbfHkzFY2V6fC2r?=
 =?us-ascii?Q?gRsvAKjWnSEX0InMNVUHANDUx4Qx0awqX9cY8dX5f7hwJs2wFtrS7kxyLOEG?=
 =?us-ascii?Q?xKoSgpITO0IXBvxZ0tli0oCR+VCT/ttlDNINoktjMGoKX0BrQ2qoFSa2nQgj?=
 =?us-ascii?Q?BGhpE6+WfbRzlA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1421;6:H9NqqylmyKxCgTWOby12iwC4V8EvTls2qCVaq5AdaPnfmRl3igvzhOScEvkkc1MZ+4RXwIuzunUlAaX0m3gm5HGWKVmu9mXl3UMzzfsoXp6nS/oylmlucr+jwQ11qumEvrrLN0KtzsURQJ7qe3ppejLBDeKphZVY8rOco8bJnXYexM7Hrm3nU4OCoCfjHPWsdneWZlZlieF54J2PiGlv29p1Bt975oHVrHYvzOn3zC2bIPaBk3z5LdiApeoPkTp04GF2c61d91utROlJbSg1R8jzQ1fX8lRXk5FETF82NBk6HqkjiXWnwguntWJIUtVXWRVGIS+hlsX59sgbTwpB3J433dYpJeQ36n9RcJQFtU4=;5:Z2DONIE5b2Q26s4na6h/XjlYhJZmOqdxVh0YmSghFOK6mTlMmXdjcZFHWmq6FHqYgmYdq+QNKefy2iU49zCMkrb8nysnzC7GZZePWeXUb01BpgkHnlsSEtvyJITDJVKFhYeZDSircaBVT9ZAAMfTKXIPXqNXWvxzZp2IULcy9KI=;24:dcz1WhuOusX0eQ1RP/PlCg9O9737Rmfg9UfbsjAyh/QdoKgAB6agkEGi4gTotfSoss019u39Yj6M2nr7qEA02m8hZ8/u5Hq+vJCRpPEVq8A=;7:Dw36+sIl4puNLj9Tte6EzkdkjYCIr9O/id7K9Zok+SWaQoNqyO8HY1h/AZtrCxtFJ7es4fODHL63WI3Soz38VxMRfBIcg8P0ge/ljFLCsr40Xz6f6aI00L2NiNJS+fUC4A0MA47QOQBSwiT7J2sY6JT/5CXLiIgjJIU7lZn7bFhrhnFlm7CMhZzj7zHwiAIUaAq/W3czSr5NdpnqmuI8VMiEvJnMInsMsln8ZNbLtrZUYpA1150FBlLJ0Owv6LaG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 14:55:42.6023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d3c7d6-a8e2-4632-a5e7-08d572f1dae4
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB1421
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
index 6df3389..ba1541f 100644
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
index fed7660..956155c 100644
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
@@ -190,7 +191,8 @@ static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 }
 
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
-		u8 shift, u8 width, const char **parents, int num_parents)
+			u8 shift, u8 width, const char * const *parents,
+			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT, reg, shift,
@@ -198,7 +200,8 @@ static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 }
 
 static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
-		u8 shift, u8 width, const char **parents, int num_parents)
+			u8 shift, u8 width, const char * const *parents,
+			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
@@ -206,8 +209,9 @@ static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
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
