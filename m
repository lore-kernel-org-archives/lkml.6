Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeERBEw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:04:52 -0400
Received: from mail-he1eur01on0079.outbound.protection.outlook.com ([104.47.0.79]:45312
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751280AbeERBEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:04:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, stefan@agner.ch, adriana.reus@nxp.com,
        rui.silva@linaro.org
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH V2 1/3] clk: imx7d: correct enet phy ref clock gates
Date: Fri, 18 May 2018 09:01:04 +0800
Message-Id: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0144.apcprd02.prod.outlook.com
 (2603:1096:202:16::28) To DB5PR04MB1318.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1318;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;3:ACIyc4G9NK4CDNGsJwGDlTDBYDYMNsmWK3j7aQXAPneFBJuEg13a3FsgPlHNJfyNhAAVkbJkaU3AKeaIP7c11Plh4tfr7ogStKAV8gYiXVokH5YXbsxs3ewvFIxtOD2lwuI8ZCsYFouIpQaPGtW3JAOFnArjWcFTCO91HrpkwFbvdbmU3126DVYenXO6FiXHyxOjDV16+U+O7xzwf+LA5z2FwWdN8ORUgF5+/JRgT+CtCrtbiobguBoblVvrdoQf;25:uTirolHnz0b/jnzsL1CBFw4dF9T6w4AnLqj94rARPrZr9R5drfZ/D+HX7OgT52VM7LJNQZYu+UxWN8cwZDMEs2i+fSuYOKyuITzHhR5bIXQhmmXuXXlaG6IHgOMAhxtsB5BNGunXDjRVo4sFUeATE5qQ+Ahr4o6bSxjMPx7T2KFJATsgCQsW4vHqDXq/OpYESCt+p4K2UyunUyVPwCVHJ/wKazq1nobWhSEKGz2f/QRyGbiaz3L3GVrMEwbTdb5ioZMX/vlzN6HmbYVvTS1tsYa7ZQQm6kANjNvZwyWkQr4xUwMhq3jNZe85sAtPjOFRki7bYFEps0oDbaFCv6uZbA==;31:CJx7Fk/6nXWVN9eXLMHUO7jnW36jVwp1ifT++8mZpoix5VjBjyLYKsSDloswEoHnBK3p34xXatTfSF4biozfWyJh2x68kvNxVIds9QQFA8c+1FmHFaAz0S7aQYQx0ND74sqcLGan1OD8MpepQA0F/n8cCEJUmJ1VAD2dHdp4mzoqBas/ZMkaaJI0EBM881DvS6fI3XQ9T7fNMDQXotVXjTNakYCad7I67g5JIMm3ObM=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1318:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;20:0fA3+RVPTD/yjAepmIylFD6kyDPa9ewJeRPPJs0pd88mnd5d9TAiMyN6J2Yr2WsAwggVWPDeBkSRS8+opgFI9iE+dSftmRgXMvDc0ByK2pzVqICXwd8O5W4a0JCcoDsi+bo1aHxlFuPYJqSBmBXqNqIr5hM07LfMxbgst512HLHt/FeY3OcyoZhKCbmd87RLfKuJluGO0UN8+RWRF2ZDedntWMXJjtdbarus4R2K1VK6SCEaAZDqhvtWkRyxkk0ONUQsfX/eWC6OXz1XSL0duuU1so9OggrQ06bh3rBk+jJaG8CvOQqmQgUiH7+T1slxTnVM7S6cE4zq9HRVv7rGfW8BS6JhGnOShYi7TJAnsPjoOVhlFDUokv5lUDVriZ2OTY2UCADoZW70idhbdHgpE/bzymI33Yb3fIEBlhSTlgyKFhSX0D81FEx0vNhjC56lhyGpDJ+0I2Jvz01aWBA4sTKh9TraVENS0o5rp19kfyuhTepIwNWm06hsvnt9KHTw;4:bhKqNMjMw/ltbd9qIClyErEqGpR7YIssHChFaxSMERaAfj76GGiggcXvg0iBbD/ElE0QPdoXoeDjEN+rhcSROMJMI9IU79NeKngiFLCFgaB5StQUH1gmBFhhLLUVvN+y0B48N9Q3bUXabpg+PRbkQIYIq3K6gQt+sf3a5apOLxG7Pvktn2nJL1C8hy2hfYaZYI/bCc/YGusvsOHGXrIUoEMbN3N09BTP7laalVOsJ1fNaDURZF+xbLR8U/t9Pnd9fv/wW6TRmTWb4WNMxug5DF26B3buIOGxTqJR1yb2v07cep4nXzF3qpl3tA7PO2WJ
X-Microsoft-Antispam-PRVS: <DB5PR04MB1318F9333241FF8EBC504FC9F5900@DB5PR04MB1318.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1318;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1318;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(39380400002)(396003)(189003)(199004)(476003)(6116002)(5660300001)(50466002)(81166006)(81156014)(2906002)(105586002)(486006)(3846002)(106356001)(316002)(956004)(25786009)(2616005)(186003)(8936002)(47776003)(97736004)(51416003)(478600001)(16526019)(66066001)(16586007)(50226002)(8676002)(26005)(48376002)(7416002)(6506007)(4326008)(7736002)(305945005)(386003)(6512007)(53936002)(52116002)(6666003)(36756003)(6486002)(86362001)(68736007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1318;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1318;23:Ol9dubju1wA2bTkAQfrxgpr6dg9r60aY2JHJg6vPv?=
 =?us-ascii?Q?8p63zcsOHlBNkcgZkFITsmNJuxvW9w23COVWjF+3+BVnOT0ff2iCfmh7/3s2?=
 =?us-ascii?Q?amHPcQFWRDJzq5pv6rUXiCpAlo9c5QKN8c9M/jS1NZqu0rMG8V2B0MrpVnUE?=
 =?us-ascii?Q?zSKDA5SECux8dqBRR/x/HbAA2DQELGE0Xb1IZEIbECCTXlqsohn/l4VXqtDz?=
 =?us-ascii?Q?Dfolt5s7KQ/fIokWoEUO+58sL2PA2lAzhw6AGssApPLMeYge38wH/gBX6qn+?=
 =?us-ascii?Q?4OTjx3OaRhQEKrAiINB03JddAhlE0sOv1sjs3BhP3yO/k+Ah0IgsZoKpKqeQ?=
 =?us-ascii?Q?o2A+diBd+99aLvECqUAvdOEvDedRWKR+Lxlg5wtv9+EutepXwx0ly2uvE6TD?=
 =?us-ascii?Q?eoTxUFO7XnLtmwDLHILwS623Nx8llLqiKMdbj1r6gCceYUnRsqK8ygYopF/v?=
 =?us-ascii?Q?uM7MB94+B2H4ii1edZynOSXKihKbfBXkmgwijhFpktECjmq0C5PBHjx6v62V?=
 =?us-ascii?Q?2c3kSkZ1mYa5fGwJpa6tFZ24fHCkgbp2hXFB9P9xxVAYi6tS1UtWWExOCB+/?=
 =?us-ascii?Q?/7vx4rVnDlvf+vqsW8S/SRCT9GkaO2KcI3dLG09q4EjCWoLn1MX/fTtGK2hX?=
 =?us-ascii?Q?jMd+ltw+H+c2zBWNM4nyTjqMDZ7rD551Gpdvw7AJYXK+BaMghFBzTVpFnxlc?=
 =?us-ascii?Q?CFRGuX7lTOrnrPn0MZxM36ExFa3n0rwtNG74KprIcZERXYuoa7uU2A1xaYie?=
 =?us-ascii?Q?hHu8vCEMjQ1nP9RhT4Wsfb9zS+AWuhajxkDpcf4F/ebiY0UidvP4vsdMxGug?=
 =?us-ascii?Q?yR8Lfgu3n0YE3nhYXGJm99dtrV0z7xbZ5A4zetNLk1yCvJX+cBuscmSvgzdP?=
 =?us-ascii?Q?6aHBzch4QoggEP6WlJesTDfKm+N7Ljsl6BYlX7VeQVGju5e4Eq95gYB1pr4X?=
 =?us-ascii?Q?GWugTRKkfsgkYTUjzrZ3sD9WsTp4CbPP/vQmz1xrWF6PHoNEXTCyc4VS0EZs?=
 =?us-ascii?Q?Acl/JxLHpCJdPU61fLWzPkL/1Io2DGCU3ZyU4okzqo5PMfrDLhYmhs9RWt5E?=
 =?us-ascii?Q?J4QUHEswN8WuDoi8A5QFsdOd/GLEO8MO/LafHX/tE2XkSsPzCSIoJycC0zsV?=
 =?us-ascii?Q?Hec11zR0MrK7vzmbuObwkPEFcKT3nsnaHcCqugLwjPU0uW2xvr3qg=3D=3D?=
X-Microsoft-Antispam-Message-Info: KFQEIO4xB+/w+yBcMyOzmVpCV5NGvzuXKirfuRmlJ66+7xaQsi5ZxAxLTAtaZ06Aib76fV+hR5dCitkHeFME+VO4fh9xFzpmC0XyD9TNGVWouEscR+HWoUr4ZXeXjHOqbvK6Hk4Ubqr1FptQG3CVe+Te3lq9xWBmXdm+uBU6+6MiHgIH9M/yU8R9etMvmWkq
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;6:/aM7uz76heg+Rs8f1eyzKPtbB2du+7oYaLaAO2jVe+g0Fsx7W9ZdxjaawnJwwtUOt5FuVklwbYy71+SYJ8foL+UxrCmgsktwbKNbEtUcgWOjZw4IMS6s99vtKwogWlQY5ygChxZFFo4jBoYhptfB3kr4P1oo3FNChvvtgXuCHbhxg5bXAC8UKY+nvQKg5VPPl7eV0Xw+JVfaLp2mCPv8aydKaBXezYJX2G47BZ7VImdUL3v0vxQDKTSkE0U0iPnsfS+uRIZn9a6+RjyZNLTogcU9vH/AzUx6QG1yJEEaRv/bfoWZB1d0MH7PmdFpJoTLvJYboK0IYK4HH93Z/SQV8ftk9rIKCxdb4+x6cxqhWVzj8U5jsv9b7kmvn/yEQ3+ZQTfSG5pnTNKanBWvqgIOvZQfK7xEINHpGxyCGIoM3mC+xUWLSdJqKKE+N0agRNuE/U0/LKauzFgImXd7CAea1w==;5:oayNlO/gobZTitQgUySoPKIQ6MpQAdqjzc+j0gR4QUEoSTPQMJHITxv396+HadEQ1ibMKnm8cubJo0Z3YlV+Oh1qyDPBdPxnSiDR/ZYpPhtjd0D4lXeJSADsskll0xOrQDT8gSeKtvStqYWNrwvMucLKktszBwYMyPb+VXX7VcU=;24:9MFodbL0pG7dCGrUDYrFPlFlhBQCMUy4rLBhoNYrFHJzQoYHPWIkvQa/4TMRLHBqY/LdNuKX+O3RW0EgX9n3U6DiXOPXL0nbbNysmjDQJuw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;7:HjDpVwzsEz4HoOL235aH0D9k0r8924yeqoXrcPgtj/YdLSD5ggqfe+rd0/r/xiM7o+yQq3yHOUS1UM8MDBUltiNlLWrA58P43D6+MPOG9iFpHgQhJ0e51vz3N2de0VsWahFaszrV5ESm3Ep9R3uxqGCJI8Sg4vLVkPVuvF+dLCInlH5+04Xb8mshL5Z4wyGJXPl32nZTG2kxgN6SLzLrrZQ1pMv+TuxGcOL354YeqDNcCBG/RnvjaKJ3yHze9lZt
X-MS-Office365-Filtering-Correlation-Id: 0aca75da-2472-467a-07c6-08d5bc5b579e
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 01:04:39.6124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aca75da-2472-467a-07c6-08d5bc5b579e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1318
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMX7D_ENET_PHY_REF_ROOT_DIV supplies clock for PHY directly,
there is no clock gate after it, rename it to
IMX7D_ENET_PHY_REF_ROOT_CLK to avoid device tree change.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 975a20d..23d5090a 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -738,7 +738,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_ENET1_TIME_ROOT_DIV] = imx_clk_divider2("enet1_time_post_div", "enet1_time_pre_div", base + 0xa780, 0, 6);
 	clks[IMX7D_ENET2_REF_ROOT_DIV] = imx_clk_divider2("enet2_ref_post_div", "enet2_ref_pre_div", base + 0xa800, 0, 6);
 	clks[IMX7D_ENET2_TIME_ROOT_DIV] = imx_clk_divider2("enet2_time_post_div", "enet2_time_pre_div", base + 0xa880, 0, 6);
-	clks[IMX7D_ENET_PHY_REF_ROOT_DIV] = imx_clk_divider2("enet_phy_ref_post_div", "enet_phy_ref_pre_div", base + 0xa900, 0, 6);
+	clks[IMX7D_ENET_PHY_REF_ROOT_CLK] = imx_clk_divider2("enet_phy_ref_root_clk", "enet_phy_ref_pre_div", base + 0xa900, 0, 6);
 	clks[IMX7D_EIM_ROOT_DIV] = imx_clk_divider2("eim_post_div", "eim_pre_div", base + 0xa980, 0, 6);
 	clks[IMX7D_NAND_ROOT_CLK] = imx_clk_divider2("nand_root_clk", "nand_pre_div", base + 0xaa00, 0, 6);
 	clks[IMX7D_QSPI_ROOT_DIV] = imx_clk_divider2("qspi_post_div", "qspi_pre_div", base + 0xaa80, 0, 6);
@@ -816,7 +816,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_ENET1_TIME_ROOT_CLK] = imx_clk_gate4("enet1_time_root_clk", "enet1_time_post_div", base + 0x44f0, 0);
 	clks[IMX7D_ENET2_REF_ROOT_CLK] = imx_clk_gate4("enet2_ref_root_clk", "enet2_ref_post_div", base + 0x4500, 0);
 	clks[IMX7D_ENET2_TIME_ROOT_CLK] = imx_clk_gate4("enet2_time_root_clk", "enet2_time_post_div", base + 0x4510, 0);
-	clks[IMX7D_ENET_PHY_REF_ROOT_CLK] = imx_clk_gate4("enet_phy_ref_root_clk", "enet_phy_ref_post_div", base + 0x4520, 0);
 	clks[IMX7D_EIM_ROOT_CLK] = imx_clk_gate4("eim_root_clk", "eim_post_div", base + 0x4160, 0);
 	clks[IMX7D_NAND_RAWNAND_CLK] = imx_clk_gate2_shared2("nand_rawnand_clk", "nand_root_clk", base + 0x4140, 0, &share_count_nand);
 	clks[IMX7D_NAND_USDHC_BUS_RAWNAND_CLK] = imx_clk_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_root_clk", base + 0x4140, 0, &share_count_nand);
-- 
2.7.4
