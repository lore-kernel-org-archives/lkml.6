Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeC1GrQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:47:16 -0400
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:43380
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752723AbeC1GrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:47:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com;
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Peter Chen <peter.chen@freescale.com>,
        Irina Tirdea <irina.tirdea@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Anson Huang <anson.huang@nxp.com>,
        Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
        Abel Vesa <abelvesa@linux.com>, Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <b20788@freescale.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND 2/4] clk: imx7d: Correct dram pll type
Date: Wed, 28 Mar 2018 09:46:37 +0300
Message-Id: <1522219599-10831-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
References: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::29) To AM4PR04MB2129.eurprd04.prod.outlook.com
 (2603:10a6:200:12::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72bef301-7c14-4ccd-fed9-08d59477b7ec
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB2129;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;3:C3x2OD2s1WqZXgQgihZfBpKXq6u06FPuCQYZguTfI6B/5rgea8PaEDy0OkhgcL5fZKsuVpX6aD6mPP8Sy3FuNwYz0lOzkJGevIPh2QC9JUHgmqS/o4OU+sWSNLSRDHcA8CX5X3bferptwTghiiEhVONi2iGgu6MFV2bT9gFZcAtuIJ8kfP6tXOGowIPwx9J1GlMu+UD5+SVKtx4k4oje3ayqF58GV8lp5MZjHKnsL4VmBvoxd+ZwXC9xYQyX/y4V;25:Y94aikVbmIHJrkrtlMPoTSQuqpy9RFK0laE99tHukJnvA2MSAUsh4YV8cWAd+Swa/TTgLh3EndgK4hJ0+dVLuvkjvKCZN0rhtBL5Bm+FTLtkgPQuZEY4//AsvoCSF3D4tOOLARXxPPWmOdwFAJ32NAPkcjBas+NAPCj+DJjUDJExVdM1mMYmMj0BTwcbnKxKdi+bk1B7IGS7YQZxxwuT7SqGRB4R/jwbd3gwvWMPtgYg88fOKmh/loEoFOyq5OvNKsJZmA5OndvSGw5ARySc8Z/1h5kVMZcFilouPW0P/zE/v3EHM6eGoltS/ORarqXvX0rJTnVIIC+veDDdVLc2Jg==;31:baLCwXyJVzvY6XyfnE9UiNd3mGOrq8BXlB0TQHhV8LBEFN2fhaPmEwUzCFWUOFXNEMNz8iIU8KOikXXVmCEpWEjMnD1FXvdQfjDDTQ7GXEltT5VxM+zaIb1pVm5YzYANO1VGTnt0JVZiOufd21joj/DgXxUQ7UVeEu6Yik+aHzlm7LS/9zfN140lTySaNWRHhUX4ZIx9WcL4Fj5hwO75ThinKlHFfp91XlwvxNGsLeE=
X-MS-TrafficTypeDiagnostic: AM4PR04MB2129:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;20:5E2vajZlo4Woix6BorfVTTNSXIC34g/LZeMeFII0Uj6XlwTFHR4vPAt2gtXVzREdyB3gayUK3UDRpYft6VJk0Pan1Cb6004l0HrJXlkGSv3D1COrM6fpILCIrFEUt+FbkGtse/c2yqyUCDepPLwIUwPn4DFjjSecfWLKC+KM1yLam1xF9J17Smi9c9iDnAEcppBJSJ66Nzo4d+D6Weg82vxg9/x5yIVER0rh0HyS3R0U9oZMzrvy5zaq5bYQ7xkF/s+XPcMv4+AZ4+8yFspqMTd8+UzqbJXhS/1+HtFbhKM+QZm91lGkXpJYjoAJ9VhX37v07iI/+WU2JTnVqv92wceTDjw+Er+LTJcuzvrYKInFclo1uBTQfPUE5ln0gTs9lrw3Q4mtXqt5hJJ+4dW4RkjsF9g/T50GuavgjdJMKsmQ5hAWc1geK09dIJFmzawTbd7FxM2fDMn8GHAEDHLdcvTkKltbKXPhC48JdHdDkIv4aQiNmeK970Dd6IGKvS7q;4:lko23QKAE80bo6k4k/KKmQTKk+MDJDHRxpJVI6ZnbqadAGipYGy3Qn9kU9b/3WHpVK/MeyH+BaJEhsimlBHh+fMQfoIEbFTo9NjGlgwsGQXWPmqOT8IvfcdjfOiqNEht7N5p0KlHD2IaUWRslb5pXeyAaZDfUG+AJDPsCMyaJiiOz3CeaSxiPmNcfftgWoJ3QRu7x5QJqhmj1+DpNBl+seSEHEl8cGOTi4NvnCSOaHsc88XrL+ENZxpAdHZtWJxFe2VHOfY+QWAdrEGNd+i8PjRGeq4XnB9nUwvlRNMVdRRG+TMsKHOcl55lo4LXXdSniPqrrhwkpGOq084nBJiAXU1ZB9HGTJTKismpkH8G3Mk=
X-Microsoft-Antispam-PRVS: <AM4PR04MB212987E8BF271274DD9CC541F6A30@AM4PR04MB2129.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR04MB2129;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB2129;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(346002)(376002)(366004)(199004)(189003)(6636002)(47776003)(6666003)(186003)(6506007)(16526019)(386003)(48376002)(59450400001)(3846002)(51416003)(6116002)(36756003)(26005)(76176011)(6512007)(50466002)(446003)(54906003)(305945005)(106356001)(486005)(2616005)(50226002)(956004)(316002)(486005)(81166006)(478600001)(16586007)(105586002)(2906002)(81156014)(476003)(66066001)(8676002)(110136005)(11346002)(6486002)(97736004)(53936002)(52116002)(86362001)(7736002)(4326008)(25786009)(5660300001)(8936002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB2129;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB2129;23:Ebz0yogaIeQRCy23urvpE3Aoif83tUETrp2c9hP03?=
 =?us-ascii?Q?FphXOgJgn9UocsuR64kldxRENG07GXAWaNN0KdGBlA0Mi/YwcUMOfPfS13av?=
 =?us-ascii?Q?hLF1aG6rEcmZGu2r/YmnQ8b4qhs55A8BTDwAXo1JjvhJWMwwZ+0M4UlfxPlO?=
 =?us-ascii?Q?00rVdIHek5MJNTTP1Ncv+cgUouTPlrMyR88sqbWhlRvwcg+PZwvqFO3HkfyT?=
 =?us-ascii?Q?do7Ofgu0lZ3/0dEmXMGM/tCUXAxQuIon64GaTwXUA0vWaQmyKOUXvtRtYzmn?=
 =?us-ascii?Q?eQK0Z1eqIiTApRl7ck1I3a9cJMk1ZtirJOe8G+OayBHjrl81m9SMjeanU3Ze?=
 =?us-ascii?Q?ItNvHNcmOqb4vYDMkB1+g8mrLHlLnUj1bDyhGKtMTRzx7L6AwUoh7166y+ZN?=
 =?us-ascii?Q?cpa5Y3APNrfPm2m4+QV+Pu2pBrK3OjgtKtmZSFeErxdXUFIOd9ngoUsmRpMh?=
 =?us-ascii?Q?jyN8qXhgLg8d0cOYR7l/SymM3jX8xf2+4TvYesi/9hDNuCx39G/umO7o3O2W?=
 =?us-ascii?Q?LCu2TI79Yt5DqUa0JpGB3CFFOPmSIsQTiAPZK/JtQat7XpsdF03KwW/cb1lj?=
 =?us-ascii?Q?3S8dThr0Gy/b5oBw8uOKSLHhTiWaIMaV6UIKI5vF60edS432HJuKfdJy9GYS?=
 =?us-ascii?Q?2yYcAA+jx9J07mDrLSFmWcPmCaUtwxmCMvYdDm8e4YBdtG5+9oMvvJLIeBBn?=
 =?us-ascii?Q?WhuVHsVUHBvhfLvLbmhF+XwcBRNFmAR/RXteshFPxughqX1YTgnpCXq3ZH29?=
 =?us-ascii?Q?ch62kVpCEIlJ5plQk3/bUrD1sN1dcChm9QHgucGIQKA+fycp5Mn7QqI7/pES?=
 =?us-ascii?Q?izbd24YfPmhW/rhX02yp+H4STvq32xzyS1FpOsMngX29lxl5xkl/w3Vz7hZT?=
 =?us-ascii?Q?0TAiMXs7VLOcxrIy3kVWluDjt6F4fMjWn67JfESTxHWp0Pk1LGX5Jc8HP+RD?=
 =?us-ascii?Q?4KKj7DzRi/xXxVMVKC484RsOxwXQ3IvVdWHVl04tqFD+z32fUI9wbtc9JJWb?=
 =?us-ascii?Q?OQHw+fB6QcolnmWmbQrFlk2BXj8RaEFuXCauwPyRIz8/wAhyneggDu7HW0j/?=
 =?us-ascii?Q?rh2cY8spFzN89LaRLj8oqXpKX43dcbYNge0bcaNb/0CqZY4Ayx4lCXfcRCIP?=
 =?us-ascii?Q?9YhGsM+CskuNfw4ltms+YgY7OzVdhxMO6GE7cU8jj+AgTMquNiKf1K9EPXiv?=
 =?us-ascii?Q?IRKAlINT+Jd+MMihaUsNrkUtuZwKwiYXNn6Hqzy5IYFqCHKnJA3rIOKpL8q+?=
 =?us-ascii?Q?VO54ygx8WUdCAUTgKvF078a2SBd8tkCj07isUqs?=
X-Microsoft-Antispam-Message-Info: ntPuixFewHe5PiySSmG/NRL9GUnHnzYSiGiKxUbSdY4VDxxPnwH6hnJtaaKvuaHdI8GYZofwb4VN8dC9Hl3Rdg9fmgQ+MNI9GXb1KPfY+YS1tYgkYZC9V8/gwdj7K5SJZjVsdSa9ut0Mwb741cA0lzC3QCTw9GoyZjd95ZE448bhIn0wWZOakYwpnAm5xjWX
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;6:kV5flFZcKx11ZlN2jRzw1zPLf9E03Ku1qc1O30/exWoNHKyX0rZy7wlJ2X1mEaD0Hkox/H/0XoPOrtSxmHd8IvD/Vc2w3NxFdIo0RHMJW5p2cOytS5Oe0fZSiOPuOrqa2jdI17wSZSakc0C0+49Ym/rbYDTnz/+zqMduAiXAgsSDJt1Dnb0gD5C11YC4jyjQ6DZFPFP5TF8usAdkLL+5a0gYZVOjhWH0wlNC4brgwHpzOXyZllO6HRKI1xCT/CligQ7HOKtEU9OFHdVn9FUnZcpdBQyXqplvysUaOigNq4ZwCyHMMZ7xrbEEUrdrQFbvy6xqNLIYqsx6ANhi5AOwaSrM2/4Cduq7ZzSG7ddOcWE69m8ugmLWhFLXCzepDB8WwO4elPhwMrinS/bDKodg2UZKv5zMqlEc9BQCE2vbNyPRblpYiC7sL4kXEugdul7LAo+/jzvgNZ6CLvQHxXh1lQ==;5:hOC8gl88QjNxq6q6j/amWyB/S1flovcvnXcY2GjvdHR93yUsfXTH+VxBcshIoJtsUFy4Gv4cyHW4e+4pYVfMS0V5qD7V68goJhf4j4qJx1A48rVpT1Xz+ZV0LrB0lYhyc6mXNLLq7CNvenjA3ld1Pfu99oRHailSy/UOrfvKCrE=;24:4qdfikA6bFdAfbwVj4YCA/xUWb3JKbv2VEpe07jwfqFy+mGViarK9mx4RBlymlRdupl881HeXKrCJg++IrPNA4NXwUh3GiOQPB+VNo3uViU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;7:gKKZmGw9tN0Ab/xUxQza1XyDQyyc4jraGPe6tTjV/9XJEyyTslskfCvyIiqD4F2SviDT1jO8HKF3zNkwUtG9GX5TKh5N2bnSHcuvEuyD8NYBPNVq9DWeK2ULu5K/cnw5owe7mTtuvm8AvSoJHXs+D7/2TBD16QQfALwxqfbqYeEaBPlZTlHpkFY25cUr5QGj0bOVoPjbfxh2dO7BK67LGWeyEDA8yJ7R1Y971LvitVWixbFpq4787n/TrVD6mCnt
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 06:47:04.2580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bef301-7c14-4ccd-fed9-08d59477b7ec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB2129
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <b20788@freescale.com>

DRAM PLL is a audio/video type PLL, need to correct
it to get correct ops of PLL.

There is a test_div placed before DRAM PLL's gate, so
add this test div clk.

Signed-off-by: Anson Huang <b20788@freescale.com>
Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 39d110b..1cc485f 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -441,11 +441,13 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);
 
 	clks[IMX7D_PLL_ARM_MAIN_CLK] = imx_clk_gate("pll_arm_main_clk", "pll_arm_main_bypass", base + 0x60, 13);
-	clks[IMX7D_PLL_DRAM_MAIN_CLK] = imx_clk_gate("pll_dram_main_clk", "pll_dram_main_bypass", base + 0x70, 13);
+	clks[IMX7D_PLL_DRAM_MAIN_CLK] = imx_clk_gate("pll_dram_main_clk", "pll_dram_test_div", base + 0x70, 13);
 	clks[IMX7D_PLL_SYS_MAIN_CLK] = imx_clk_gate("pll_sys_main_clk", "pll_sys_main_bypass", base + 0xb0, 13);
 	clks[IMX7D_PLL_AUDIO_MAIN_CLK] = imx_clk_gate("pll_audio_main_clk", "pll_audio_main_bypass", base + 0xf0, 13);
 	clks[IMX7D_PLL_VIDEO_MAIN_CLK] = imx_clk_gate("pll_video_main_clk", "pll_video_main_bypass", base + 0x130, 13);
 
+	clks[IMX7D_PLL_DRAM_TEST_DIV]  = clk_register_divider_table(NULL, "pll_dram_test_div", "pll_dram_main_bypass",
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x70, 21, 2, 0, test_div_table, &imx_ccm_lock);
 	clks[IMX7D_PLL_AUDIO_TEST_DIV]  = clk_register_divider_table(NULL, "pll_audio_test_div", "pll_audio_main_clk",
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0xf0, 19, 2, 0, test_div_table, &imx_ccm_lock);
 	clks[IMX7D_PLL_AUDIO_POST_DIV] = clk_register_divider_table(NULL, "pll_audio_post_div", "pll_audio_test_div",
-- 
2.7.4
