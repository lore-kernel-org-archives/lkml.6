Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeFDBKn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 21:10:43 -0400
Received: from mail-he1eur01on0079.outbound.protection.outlook.com ([104.47.0.79]:38848
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751814AbeFDBKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 21:10:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/4] clk: imx6sl: remove clks_init_on array
Date: Mon,  4 Jun 2018 09:06:44 +0800
Message-Id: <1528074406-11735-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
References: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:202:2::31) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:sKjZZ51x9EGlFdKkXn3+pArZlntrpNXLyyxalZOjMVqckm/329NSiNI6VVM+XXrGlWu2sv42hapNmxj/orvrkym4XdbhRCjczECarNYOrKnaUDiukz3wXzca1AmYKLbhasDccKGXxh5IhD9T3ov+QL8WptVSksIqG2zaZmmjCRWKOUfPU3ISNdgSn1cx7x9OTCJcqVanXCQlaxwm7pFjlr2js+O/cEnSzgWTuNEOCPQk0rvAoMJmP7YV86CX3cRu;25:BPEdDy+CV9nioRLN7E5cNKSv4JTV05RQS+enzAZDi4FWIqLGG3X0g3LXRA3Wvs2ieqrCXDZi+caxIT4VkuEWf5v9hLoJxCOgnz5iy1MeWgNbFlaj3wV58Hfld4A9oycJ69EsyFcLI0B3yoxjkI0zzGCETJGeVlKw0nQKgtk6mWIdUiel7kNEIYul+BNGLC9tVu0HspoVo7f4JDzPQN0zPopGRvxaf/eH5TIeX8/35qFRQJzB2qwk87ZZrFBDA9Taks7gT4jrC+PgLlS3M9OjK3yWfGOexdQnYc3RdzhntXf/4SZw7RJYlaR1kBQn/BFibe7ElkEfaekWGEDWbCemyg==;31:AHeoKwIt9p1Sk/aRcGc3IMvPF2ynUkPtknHABUuU1kpJun3XglE1C0IxLttciS2q9gQKJtFXMnHhzq3VUrwYdPjPwOroO4tC/wsYJ2VvoeSOStBOF75uGDfc3JGXNLpL7wMiZusN32IeRYrsPCGO4Q8jK5ynhRzHHE1ikcEd9eCa/L3LGDBU9zsCRLnyXrTaDzjoNRbwOeTTwc46Jl23l3lrp43lsiOzQFwDh8foHZY=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:BS0aUX1lxar5Jb7wCPAJjN4CbtsfWh/dMLwJ0KB1oM5qJUlZg7vIJ39XLCOA4LKrcY/PqCe5Y1sMPojp5l03JspmGjT/R8Kaki5g5x+ZckgiKgINRtoobBnXI2ErpgkcfUyQ+Jt7oesIPtg449hzHXoMAEd+yiWv9OwTArYZuEQr2UJWRSgCK+x2tMTtvNF6zLaariH+7MhKHuS05LUq0nmmytgmfyn4EAZUBYOcCA7rlVglgwwF98djJwLaKg0gO7a22NmwyEk4EZICDIGu0xiK3GC5LBJnw2CUFRXuwCqJPgXp9K6+C0fl0QkTxsW+htYdPd/SlW3RriAARDfgFNVkBgjYivzxzetTFGDzLHrqGpXYh0hUZnOW6c2j3/aRFdF+fDJH14u0BPmR3IVCqGkc8DQyVA65o8n/AbPYxCKTeSSKexaojaP4VRsid45n4oZkjSgZZsXPjCfWfsYgjfVf7pdxb3r1kyJ9v2rLBksQl4iqgiPwZGbsWyjeIwEN;4:nEYjim+e4Xn8ZF6WeNDgJJF4RkEsGh3SjV+VNQZqrv8PuzghM5HEnJsA0wGmz6v9QNnOouo9hV9bsdNIsPVm17RuIIufE0PoKscUKgafR5TtHZqRlkMpWJWtWf0YB6/eKoLmKfxYSLZbZahR/EZrTb/4lYdu5RQ0L9pMmMXwVBY3xyNb832cQJ2rUlB2oeRHEWMRZgV9aVwGgUC/Urm/5AK1J30mxY2B3aiSHVG3Ipv2g344+4oX6f0U4YgiR1fyFalF2z834ln3BmrFydf9iWANGSrO3iQuH8gAdLt4miXXjg0mm8g6FkgBbmzNLraO
X-Microsoft-Antispam-PRVS: <HE1PR04MB132351BAB248BD4626DF15FDF5670@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 069373DFB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(39380400002)(199004)(189003)(53936002)(105586002)(305945005)(97736004)(86362001)(106356001)(2906002)(478600001)(446003)(8676002)(66066001)(8936002)(7736002)(48376002)(51416003)(50466002)(486006)(186003)(956004)(47776003)(2616005)(476003)(81166006)(52116002)(16526019)(11346002)(81156014)(16586007)(76176011)(6486002)(36756003)(3846002)(6666003)(316002)(386003)(6506007)(25786009)(6512007)(50226002)(4326008)(5660300001)(68736007)(26005)(6116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:sFVVLFnxcKYWzl+eL3pc8e7Jq38X1FN/liF/ReiG1?=
 =?us-ascii?Q?HHr503cc7kkBQgxmB3cTvoymRe+hQ+kJo6741z3jEzDGPthuR9w/ycDNHoJE?=
 =?us-ascii?Q?lh6X7Bpw1MfrtUuwTd6OVbtfyZ5g4bxIG4r5Wde1ZDXHdTZFypT039+Y3itx?=
 =?us-ascii?Q?HgnGae44WThI5j6VyE6WWP7iwDntpwqeqJq4aHPM6KYLMuE9gmnE+QwjXsh3?=
 =?us-ascii?Q?44eSD2x/IVAQAM1xwWR6DKSoMmwjkWeMca0kezRFm9pjVFORGACDSnvDhiz3?=
 =?us-ascii?Q?LLBY8Z9jRjibhbM3pIOsgmhNqDDGNkxTmwUXpQ9JL6dhl3RpTef+KMpjYmyG?=
 =?us-ascii?Q?xhtwqtTAV3Sbze8RwRZi6NfmUyYI7oVc3TxTMPan+zIGrZgMaR4VER8A5wf0?=
 =?us-ascii?Q?NNkUwZxxN0nnjIt8RFElMbvLt6875fW3TxOCm2Ckwmpx2hHGMZVTMB1soGo+?=
 =?us-ascii?Q?vXycRPEFUeLgz/vY6olWxCBLMWl/ME0RVXc+HgWqT7WRdnoNG1HlDeb4OWxG?=
 =?us-ascii?Q?Qavle3NRjA1qCOzdEOtwX67BtD3FChbXZaA24308e45O35EzbcT/GmtC5SMY?=
 =?us-ascii?Q?ZHSMrgNDqEQeFFZjCHEUJTDBXjQTeSv6xC4lKZNk5Rr9fvIAX754OOdLgGqP?=
 =?us-ascii?Q?+cmQkCZgudV/xGaUJHt8n9u3AasWSfy/ApxZj7c4D9c85IztkedWCtNboW/+?=
 =?us-ascii?Q?C5jKHKkXJuoBZA5nApljDf6YuCvlZqpdtwA4TulK3mTqXW2PAIwXwwtyxrSl?=
 =?us-ascii?Q?Via7uB/6uS64kr1hXvOmNxHWobVRfy6DnuGOIRSllCz1BPgPgoZeD8/MbhQ5?=
 =?us-ascii?Q?ocqm/+l0PuSZZo7otMNKT6HSkBPOfX5l5JuDfO5Zkn0UG1qFMp9uOso9Kh3N?=
 =?us-ascii?Q?u7KIY2kWHbSzC/88ZXVflqbHAG4sLxRX5+OuXk1EhsikxI4NKiWHuLR+aG0v?=
 =?us-ascii?Q?YnUBbSsPg5Mye8be5V6W8xk0GAMEA4H7UuuisfXYZauMoePCWzJ1XNzL98mQ?=
 =?us-ascii?Q?QtrAih5z0mLpu+SucOHxKXUUSVEjDx6isr7+ZUBwQ/gYi50BiENyWhTnurdx?=
 =?us-ascii?Q?ifqD0D8UySjPjGb7s5KGD4y/sWwCXiDrngYUb+uXIr14TV2/xDOUXmCP6fxv?=
 =?us-ascii?Q?BWOZhZoZDxtsFKAObitSa8JOQgzTtkCvaTz6Dr6Q0Q0/n4oVl2GHAQ2nfgWR?=
 =?us-ascii?Q?QybOtn/z/W5bz8=3D?=
X-Microsoft-Antispam-Message-Info: eIlxbfeKlYKcIHSj0SA3+1jL0Z4q0wIoc4Ghf+/TY1urc4zSWv5F0KmO/rb3kHoE8aGb2jJ4hiSt/isuBJOSUQa9DgSG3CjwZIW8q0sm2G/ZvULD2cdXP0n1aPDCISoCEXAPgtM/q/TyJLMPnW8Y/zBFZk3LjN5Mm/Srcd90YIWVI1dWh8CfrApE1Pn3CzBz
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:g7ZkaIigu/HUbgipU2vnmWQk0hkye2oldji3MeAQjtaVz7kpZFE8cAKYhnXn6eG6GEr+0XYKFNoYlE7U1GEtKROjwGx1LY8RK5PQC0FotW9tHrQm9B2tuesFYwRJgZMiinx390l3Sa1VftpsJ5eRN2PixAwweIxnzExBAD+OwwnTfAAqca92kpEhQfaia4iO9BHW4oFwa2KiaJDgmzots3YQPpgu0G0UR1fu37DUumWLriYK2WX47etrkyokIkpCezMhb2uruhsHiw3vheOKyQcXEXJaICagfPH66MzSX8LJ8vXmrKibxCkNSZ3a8KWaO6TUxtutBAtFduUDqqeqbuzL5QShIAWML5YD97ePh6eXxM9yuEbtFiPuZ6/ex+6IPSmXA2gUDYiVaL4aRACtaGq9litFJ/e2vQKt33sn9Vhm0Vg/XCOZckGaO0/SQuKyR8bz3Bax8GJrEVo6575rXg==;5:C4GTQrdJ0+86TyPpNPy6LcZXK3yaaeFGWf2lMZSM06lrrp+D21E7ZQhfjCEJ6Hm/pnfDEiMBofkBSjYS/MDb9adKyxLZFXPSxbcmSNVXIPFiLZkxWfKPRTr2PvtC6MURwJrzBwZiez5Cmsz83QIDt/lY9hpFzHLyfGHHZlpBlDE=;24:OC/GqxOk6M2IIfsxtvNLVZdVXEpSetjOK4mIvnE2xSiHisikvI3b4GfV1ukM7hO236r2RLNJXrqxtfrANDlvdoQG9tVoDMpV0nvB/6+ncQo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:QddgQUqwQg/ogw0BSuT+/qkwzI5muKTpvPBY5X2b9e0OAMTDbhUW4k0QXqUvym8xMrU7vnboQs+/lZpRp/oqVIaemTGAmrTTCL0i1t9UAMdl1P3bFKaKyr4M6JQLzw2JXCFlEuo8ol00kgWsN8LLLjr1k8TtG/mXR6/2jI5/DKpv4S0Nqdh/6iEAGVXBONBy/081CGG+3M+AKtia1gdy+M5c+h7AA0qUR3PfCmVglmHxkSGbzUBzA8YZ+ROglUOD
X-MS-Office365-Filtering-Correlation-Id: 8f57a0a4-35aa-4948-b832-08d5c9b7f7fa
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2018 01:10:28.6737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f57a0a4-35aa-4948-b832-08d5c9b7f7fa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock framework will enable those clocks registered
with CLK_IS_CRITICAL flag, so no need to have
clks_init_on array during clock initialization now.

ARM clock is busy divider type which has the
CLK_IS_CRITICAL flag set by default when registered.

IPG clock has no clock gate and its parent AHB clock
is busy divider type, so no need to add CLK_IS_CRITICAL
flag for IPG clock.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	improve commit log to explain why no need to add CLK_IS_CRITICAL flag for ARM and IPG clocks.
 drivers/clk/imx/clk-imx6sl.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 66b1dd1..eb6bcbf 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -104,10 +104,6 @@ static struct clk_onecell_data clk_data;
 static void __iomem *ccm_base;
 static void __iomem *anatop_base;
 
-static const u32 clks_init_on[] __initconst = {
-	IMX6SL_CLK_IPG, IMX6SL_CLK_ARM, IMX6SL_CLK_MMDC_ROOT,
-};
-
 /*
  * ERR005311 CCM: After exit from WAIT mode, unwanted interrupt(s) taken
  *           during WAIT mode entry process could cause cache memory
@@ -195,7 +191,6 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
-	int i;
 	int ret;
 
 	clks[IMX6SL_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
@@ -426,13 +421,6 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 		pr_warn("%s: failed to set AHB clock rate %d!\n",
 			__func__, ret);
 
-	/*
-	 * Make sure those always on clocks are enabled to maintain the correct
-	 * usecount and enabling/disabling of parent PLLs.
-	 */
-	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-		clk_prepare_enable(clks[clks_init_on[i]]);
-
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
 		clk_prepare_enable(clks[IMX6SL_CLK_USBPHY1_GATE]);
 		clk_prepare_enable(clks[IMX6SL_CLK_USBPHY2_GATE]);
-- 
2.7.4
