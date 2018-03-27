Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeC0OQS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:16:18 -0400
Received: from mail-db5eur01on0059.outbound.protection.outlook.com ([104.47.2.59]:4070
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750898AbeC0OQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:16:16 -0400
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
        Anson Huang <anson.huang@nxp.com>, Anson Huang <b20788@freescale.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] clk: imx7d: Correct dram pll type
Date: Tue, 27 Mar 2018 17:15:59 +0300
Message-Id: <1522160159-25250-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM3PR05CA0113.eurprd05.prod.outlook.com
 (2603:10a6:207:2::15) To HE1PR04MB2137.eurprd04.prod.outlook.com
 (2a01:111:e400:7b73::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc17f38d-5b63-4e6b-ff5e-08d593ed49ab
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB2137;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB2137;3:wcdMkHTt67xHBtSjLdMNi1CRgT+nb/mNkV6zBr24cRjLVYnpXlm3OUOzc1HNtn7i+9VhRmAusetN70PulL1ccX6mXboHqmME3e7zPnTR8++Ljja5rlwaQO8HBVptgrFS+7NhP4OTrwk7RzcACJZzWnPKizUZ8NFeBQ6ayoLSV2ODvdFAEkSiLd5D6rVLMwOxa6IAoLS6mk6PIOnpd7w3NdXFDYY459izXTRIU2c15XAHr7VjJRkIFH/hhEvXpjs7;25:Vis43/pB0mSvoI2CU5SjBGem5xJq8VY8wS3L7gxxrqquuYtURdHkJYepdD9sXV6ufXAhUGG+u74xq68w7EGUJbh15/qfuRNxiqaA5HXc46dM6owv/nSCFYeGkC2RDSYRju6BB7MhhrOdGit7HEDFgVngo+Z6aJ706POpAftxQPu4ckrhXBcrIEAfSqaqgKFNV7sX8XAWtD9zZ9TIi21ia7+kHVIzPTvlh6pUJKjMMVglOMtawk5fby+YtHi4ac8hPRsDwTa5tnxk2qO9NKbAfS2vhrvdZbFbj6XskycT1J6BJ50BfAHDUkrJng9ONicJs7+OpRCbC2wE22+eqQIlvw==;31:unTZMwdlawbZWLOL86Y0xeLew64pMMq+wDbJzNUEHDawoBYJDvfgrWqcva/DunbcaGEWyjZA+dOsmQPfNu5LLWUbFlz2jJAUKKHcARholKo33C+0DsXzBJuI/rgIZbG7XW0dxZy+anZf0nTpX4EBlZ2FsvQL4jwe4QQqVkHzp78M2gJUv/GotIb/ISmlXGbcMpHkPRia3jIeYm90IovLbzddEPhtKEbciAOLlnjxzpI=
X-MS-TrafficTypeDiagnostic: HE1PR04MB2137:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB2137;20:lgK901VFd4PINlPJkkdIaiojJU11mMWkvhGN6m8NabyMuEnFbUT7h7FrP3wksmkYMiTM74CuNJ1f41ytHlUvvnk3YfBPinkw4PFt7BQId/UhQB2a/GUbVQzxTUXN8BXOaCIJhZ+KHFYzqOfa+8tI6S4er1Dt8XGPmYUAwEqpuBZ33wQmwu8+qu+O1MC6ZWAY+NQt1yuB6nNgZkI6K6vWo8+LxDvgZaw/K/AckJd26rMqhfog0SYGO8AIQutZWj8WFjbE6W4DNCFScAL16MwhB5UuUJPgJuXDLKe1679/eaHSuRxY3Ho0ZkZu45dsMbO/S8ct3KeJXBj282YwFRTKh3zstEsZh779Eyr4URqbehFDJaIaW3k+1eDW/adJJallFFsaDVupLZRJrLHDWMRrGsn9LIOs3JadzSxMXdY9IOl7HZOpVP6mI6faMrja/JL3wnMS+ZL3OMUrzUUCw/fcOFV97DYKvIAQrttAe54oPD2tk/rRn7TdnZlrUEPQO8t9;4:+TLd2osLa4uF0BgmGwb0+l7ncX5ftZBmKB4M249zGd/j+JLeY3A0/sDt0HehAN0PwD0prdcXCm84uuqWTsAf7fvompe5thLuXUyjeryccuTV1zlmQGrtdahVYOXCNW3zX7Kotpf0Wx2gSsRNsWNGmC82siQDbDa4uYsWEV73FmIPhdQCZ4EQfTXoP/pspuoEJq/yKGIwgJxGDAKRFKfgC6hgglht8ACfu/NyD8+94JsjC+v+ttNZLJVUtRI4vGb82sDFSx5mDn/+G19Q5hfJVW+iloDuTk/uEtqZrvUwl+C7cJMc+CUa3Sm8YrTXetCr/Wu3AR1Y8alVQbeqpwJsXyz3ljedveWUjzVnNDTAUUE=
X-Microsoft-Antispam-PRVS: <HE1PR04MB2137897AA7988EB1602EBE61F6AC0@HE1PR04MB2137.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR04MB2137;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB2137;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(26005)(50226002)(105586002)(81156014)(8676002)(6512007)(81166006)(68736007)(52116002)(25786009)(305945005)(36756003)(2906002)(51416003)(476003)(5660300001)(54906003)(6486002)(97736004)(3846002)(16526019)(6636002)(4326008)(110136005)(59450400001)(53936002)(478600001)(48376002)(386003)(6116002)(316002)(186003)(66066001)(8936002)(16586007)(1857600001)(6666003)(6506007)(956004)(50466002)(2616005)(7736002)(47776003)(486005)(86362001)(106356001)(486005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB2137;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB2137;23:VGKu9rXqveseVC1k/MowXnuqL3Q+WKBbXHhaI9xnj?=
 =?us-ascii?Q?RxZO3ECDVeCqkRPm+3p0dHSJyygwYNJiu9EWNGEXO7MBovVBkyh13gDPZUph?=
 =?us-ascii?Q?5E6/7ETzMj9W1F6bGlgnDGxBahGE4Tf1JeclPWspXqG7GekeOE+onkDry8nR?=
 =?us-ascii?Q?i+mUj2GzrgFO5O1nmQbyuqazdmnACLCh6hgLNO+KTXP4QrrHaYZbhTbsLRw6?=
 =?us-ascii?Q?MKpBIui6SePiJNPtzpvRdcvud89hxKLfUqlLvgB96o3wofoLV1Uc1EsRv+Ty?=
 =?us-ascii?Q?Rlk8y+itaui9I5WvQVDKulA+ZRMxEP/EA+M2hpj2qd2oB19nlwKXB/ZbQkwd?=
 =?us-ascii?Q?x1trRnynhbzvMWzJP6xlAA4B4Kss2i9cqQKPM6WYtY31l3e/WTTIOuHZ5NOh?=
 =?us-ascii?Q?4y0UQOc8wRhIRNyf6d49TvTZhW82Mu7trfVwcw3zQAZps+EQmhOQqdo0aJaR?=
 =?us-ascii?Q?aCaNKgDJXHE3TlyBMjKVOM3UOLKlIO508QpQakKYJlhXFHq9V4D/C1UjhN6n?=
 =?us-ascii?Q?+hzhHWfw7InpjOkBFDxNGo2deYzhMOp/m6ZSgU2EIlAaxldko/dVxV6dFEOC?=
 =?us-ascii?Q?xnYeXgCn2wBR6t5heA73K1gc90mmqwZvaqyMzYju3rYsSoP9kpqWY2dwUSS0?=
 =?us-ascii?Q?nz7lBMl5uXfJmrxQAPR50pm3PPw8ZvxD+m/iI5Cu77J8XA5v2PfEEXsq9xFf?=
 =?us-ascii?Q?GdW/PM/wgCn3xZz5wGG/rU9OFMz9aWIBCerh/2UUpJN3rAGv6/o3ZzEBVvcr?=
 =?us-ascii?Q?l7FObK2HQcwJ5VzCA4aeTX1T6OPzYaib07MAWTq+g/+gnzEyfmAlqlhEvrLC?=
 =?us-ascii?Q?ETFeUoNCQCxTBDbQ9dCw6EaKkpbo7NbVNgcjTgAoiRoznISr+rruUCsUfvSO?=
 =?us-ascii?Q?KbeGi5dqvJMglga9WlHuBvwAxBfAwMLWNXd3eDjwD2KINdgEFKmmyDtP7HBB?=
 =?us-ascii?Q?YvA15vtrGIFbyqMf8BRUncPqeRsEV8gVweH65Qx2pc/+vqlK3mUavqNIfi4j?=
 =?us-ascii?Q?rEbQat/1l4oYqR+IGkNmHzEheRMyIv+EPasySeaCZqQJ+0K18nyBmuC6px+B?=
 =?us-ascii?Q?CgstZAqCwfwPSfNA1xkCaExUYe7h41LZYwa23vZ/Fbcrsau0KOV+U8gaHEAK?=
 =?us-ascii?Q?6RYQ1Pnp7Qt1F+EsF+ZfJd0EshtV7KKIzdF3MFc82C3fQLVOGwqkjmigz5Ib?=
 =?us-ascii?Q?qyjJdszuonjnHulA0xf9AtF+4mf2bsem1eTDk9oeL+Rf18vxD0le9+0QQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: KXsixoJALjWMDPkrOHAh10LePkEPxpACJ8VYxp9CJQKBTRVRYSDeBVjoE13ntrk9pf0HqtQAAMjf355+iYhPS15WsNj9y4B3Xjc1fmW7JEPVjVN1bvwM42F4xGEv9XZcPRi6ojvlf6Er2ZSnrCBxh84c2z3Pgemdg36fOnyCWl7gOuW5GPVupsR6+CdGZNaE
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB2137;6:uj1T7KU8Sx1Z2kgYhvBLLlkn+lzVtNj0YuFKmygsI3kULbmECp2DUVA7LvqTqeRpwHhGncUQxpy1g1d1yl7NPaIzfHoBfP9XfB6vs6CsxGB92SxKywQI1veOsHN5BEsJDUX0BhWImnKWBnlqBS7d4QwwS/GV9aRwCOce7Kg+lWSo9oaqJllt3wZyjAZ+v2lrO5wDkpcoROpizbhSV8sw82QgcqMST5UXgk6KQ/rCjRxF/iEccjgtCYtsUUfNpxOxzb/4CQHGQI3zYfFW3OeXqrOVE3hkVCPLgt2C2DoiAL1ZlpcuMi5Q0yKuC6+8H3kGUR1Xi1qyIWhskazN6Zm6bMKkUR0nXNMA6RNS2b93eW6cv6AuP9GiCSImCLSPAaMaT3d6VOV4aYG1ab4+2dEnZulNieqjdDIdsO6U81V+yDL1og6nF9NlaW8SVYWb10WiA9z822pgqVs76IUdBZxswA==;5:xVq4UUDKU9W0ktTFMt5r272UJCvkHzuEDz/bRA94k42dnYZPhUwQSH8AnBT251u1InkD4cLT7oj2sifPyoYYsd08tcDFV9Cr0vYAToog9AvNAB6Bii/YqsB60bQlws2+w2Ssfq/EHP5ffXnWoWoNyNMBdTZlG5sjn2NUgBuu1ME=;24:7pM2aWKwmF2O2afDa+8ryxcrhi6ipentKGSGFiCtOCEe8JvPR1eam0aQ20fpsj5K25ZHvrW9MjMz8USKlzSTbjh2EIx5MmoivHdBoPnivHA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB2137;7:R3BFhXA1AazI5ylWpxiwSUx8VGIo3Qzt2UU9lPaEkGvonwXg2gukqzD0YijPT7xKR6t/a5Jh0p0cX2/JO22RgKeJn03AbK2mCNitSxL4fFrZE+WT6AjuDtwygb8Nadh/4mcxDN3RjGkmAH2Si8xQTJhyMUgkZEvQHsoXWU6gSskge0ktRfcvFV2h94pZWr/Po2bMCzEgZ7m+rC0Zb6JPRz28OA9Vj61CO2SH8SgXdeOCqw5VHX0b4FyQgL0lvbN9
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 14:16:08.0177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc17f38d-5b63-4e6b-ff5e-08d593ed49ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB2137
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
index 89bfa75..45c83b6 100644
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
