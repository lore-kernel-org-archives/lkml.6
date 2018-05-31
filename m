Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932661AbeEaCKB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 22:10:01 -0400
Received: from mail-eopbgr20049.outbound.protection.outlook.com ([40.107.2.49]:35328
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932588AbeEaCJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 22:09:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: imx: add mem mode suspend for i.MX6SLL
Date: Thu, 31 May 2018 10:06:09 +0800
Message-Id: <1527732369-19740-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527732369-19740-1-git-send-email-Anson.Huang@nxp.com>
References: <1527732369-19740-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:hdfqUXcRJR+8Ut8cJVZSGP/m6vH9t3WSNnjwpbhJfmtsLy+fKVjP6r/ih4eYvxr0mcnbAh/1O+DyHFopfIOHwdW8iV8ILHb4geHmbDgsCsV++oSz6jBKpXTOrjh6NWs5Y8jamqZ2UstD1Qizr0I/n9EzfI72lw6t+f1PJ+5i00HiImqOVMUCaqh5Gbknemg1Wa6RA7EZqhobEXRJwtjP2AT4ceO7vI0XqXuVTkOmCYtOpLaKQCuhIk5AJihNkEvA;25:qewIJPl2F581HSAcGjRLRw9wAj4viSc3gWkCJlzF6r/0iCFTpSbFXIM8u2EFToUnxebTSq5v7VIs9MnFJGG/tl6+qM90polQOiNruy1roM3xduV0YryfiWfl9ilFM9Tt79MZs/X0iqFEozU6utJNBd8m0eaGyBflgXHYlQQ6QAT4qZ32dZ0HCLppaoOU1okvaaUiOP9turKUAcznuSOYBAdvjGgAOmpnQBfmvTWhAcwqQBgIaFyN7qr3ywOCX9p9sZ9UoOdZf27Jvx21vSZHxyYQWNxacV2tjHfpA+Djb9GsMssKn2L9yDOYRLVfm8Wf9wmiGNCIEgwgKGkGKgRB8w==;31:a0245pG+COO9Z4D7A6OmgWk7oKlu9c6fpCmZ1PHUABrDdkDqWxw/nrNXKLtZ/9GbSYrWNZx6TTPDqClbDXl54heKiSMn/NmGVYk66dMZlLgyDsmtukttkdWysYSW1LNh8Yv1S16c/t+RLzrg5tgYhGc1TVgU2L3mzGLOoD5mN2Pn1V0aK+s7x0PkGcasczrfhn8pKs8H0tKP0OCvVfYdEw1KHqipa9tUDcYSUuhsFds=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:U85fynZV8G/ubXjuNnR8AwBda1zmTRKPpI52FJ2I86prCoJsYSE4IMx8ldgNdEChWP5ssXaQh/0wzFzRZn4j9Z75A5ASSaUiS6uky47LvYZVjbfyzVVbrrfe2bcIYp7hzOj/EMQDwi0kGxMNay2tng8YKiyz9atF79p9x7rG0VIfUANFiwzU7VlZz15Xgm5v3MN0iSEmaoWRcRH+sCvaqOexLzqStC0eSYhcONWvcC85Uvh3bgsMTT8fQQw+OU6Ds0Yv1Mi5L3gyX3WHOowMAH1geXtul42VYSD2MIrofjFnvSb9gF5K+SLYtxRlqI4N8MN6hFOnr1IKuIByGXRhUSO52oGUAuv82fVDUh3FwYEFAchKZ7lDSV5ghKt+9AoIHTtkzZ5mf67zah09EWry2GBX5OHaICiLWusgmxl6Nx/Q+0Bk8aBzeL4tTdrnjyyt8NbSgxt+IMlnZoWzTqJ/koFVyFN9cgPyIXZsshCVPvekhwV75FJR+iRtNmUnSa5y;4:htwucIvZlv2Sj1WyV/qPTMkBa0odnY0oyu9sSI8idLUmjls3W+2Dr/zR74LFIYkLmvVHHvkm93a0i3Foz2jVfDX/WzRhKi2tKCF5MOmVQsbiwNyw7hgQ65+anVlv0sQPHpZv0eIkkJq7mXS9TyjqhMTejyjpm20YkQMIlWfKaOcVjQwiXiJb6vOhy0KN4jCO6Cyubn1fkGGPsaxE3DQTRXDdYCsNblTEW6GBIxMF9/42IQQJ42dvXMtfwoVIOZLn/UxgS0MGVNkOPyeZvfB7aWZNzxELLS/taD8fJEvGjwHwlVp/x2rZRYDyRvc7okR/
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315AA261A6EC920B1CFD890F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 06891E23FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(105586002)(36756003)(52116002)(16586007)(316002)(6486002)(76176011)(50466002)(106356001)(6666003)(6506007)(386003)(48376002)(68736007)(478600001)(26005)(59450400001)(51416003)(2906002)(97736004)(7736002)(6512007)(476003)(305945005)(86362001)(8936002)(5660300001)(8676002)(575784001)(486006)(47776003)(16526019)(186003)(25786009)(50226002)(3846002)(6116002)(446003)(11346002)(53936002)(81166006)(15650500001)(4326008)(956004)(81156014)(2616005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:ktp8hF9hAKoli/pAr7EBdLjN2QBoNiwPCaCb4AsR0?=
 =?us-ascii?Q?X9NZgDnW8QXJR8uuUFQj011l9AovY63btdKqmcCm1C0b5BWrMuoRiZRfjnZb?=
 =?us-ascii?Q?gPe9zFFJyGnxEl0QnU3+yF7eAI8un6+pHf+7SF84M8s8sQp7Fom1PTpJSv3o?=
 =?us-ascii?Q?peYBbNw7d0A5vdcGH/ExxwCzLHkWpOcSqMgKsmA3wzEU6wFqo4fj9EgJvrQD?=
 =?us-ascii?Q?yiuUqqSlOXdf8XeY/9sNefh7edAjajcIzDNs6oPLKY63v75cE7hxeaWggk2k?=
 =?us-ascii?Q?rkzAXaXsU4BMp+izY0YSwVTJXm3Fa0qXWyiOUQz/VzsOOoHzPiwv+0hXDKv4?=
 =?us-ascii?Q?H3efNyJKcMzmkGSBXqbQlsPbUjZbiZd7Q6yAPNQ/c0PrtxzcDeahtW7Awk4E?=
 =?us-ascii?Q?y/VX2QZIoxiHUPr3mmWyk99peSWE9aiKnr+LWm+SWO15KHTErV6oANfqsWNx?=
 =?us-ascii?Q?bHW2U85MyQs/7vCNvXU3iM920dz9+QJ76j2vjWEyxnqTXj1OnWkjmCmDlUrK?=
 =?us-ascii?Q?4GhQMA9CHh3gnNj+A8fedEVfQt0upmgPZjVRT5HkHaTANVhJADxMtKCGA/Nm?=
 =?us-ascii?Q?8wjJH1O3NngvMXdY6lSJSLSyUsB/sLGqFBQE4BYdYuJM5FvXshZkN7eZs9G2?=
 =?us-ascii?Q?hRnKpzE2SmKxmMPoBa04ZWrkyGyyQQ+HgW2sVciZ76vEb+q/5EfHtrwpdLud?=
 =?us-ascii?Q?YSe35T8KmpuNHuyAeos/jL39KuZp5XztHuyA6lRQGrSANDFmKYnnwPZS7LSH?=
 =?us-ascii?Q?Qt+3h3rIgiot/rY13abWI53brU6ivoYbCSIOEl/KzArW/d2+p+4/eM14w/vW?=
 =?us-ascii?Q?3w7PXBwWv5PjzVE9KDiP0Inc8Kd4R5P4ll8zNhMUlvQZWNkBDFxmSLcXo8uS?=
 =?us-ascii?Q?32GJd2QLva8HDE0w9M3KGvt/QrKwy26aQgqHMkxn1jYyfG0SCRoWMUbthdZc?=
 =?us-ascii?Q?PpirnfjPTw+DvArnQS40uhbzJXtY1/txtuyGfTOW0fLVmT1xO9fSvRx7Z/sv?=
 =?us-ascii?Q?YqLQNZds31eEaSpbuPjpY3Wr6lfhIFgavSH9DlzLMPQokNph0G0LPX/4PMc7?=
 =?us-ascii?Q?TgpfYE6SJqEuydQaAsRAxKgiJrscp05j43Zy4NwK7BX/nlBlgUepPkEH5Gy+?=
 =?us-ascii?Q?86O7F+F2PhJ6HhEg6XZenyAEpqJT3kuc6Gnf2wOfik41ipElfBBenY95gxMt?=
 =?us-ascii?Q?iuFw1Q38i45ay+TP5r4gh51pfyYEXtW3ZxQoX2l00SoWMxJ2jAiA20Wqg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: ddukxpOJcGf9SLbzzcJwPFxP0Sp7HMeqs4ki8MHf7dNj0VqATypICEVZpWGIt8iJBxvDQ4ssbp6cPfOhWkbWQStfenM+kxhOQWWAuYf7JpXFpDm5SnDj7S/XkcRHcJz5lscwOdYyHLEYHJ8jT6cAh0UdD8AQyxhxrmkWsIDXtlEZYBsfa0s9z8TD5iWe4sJ1
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:HymMcT5VerqijRl4RCbRfeP+p22/xPEL+dzK49LfzbG4wQ7TVXfW1LD+d4esKsBv67siMQl+SAIvFxRFJiFLYk7unoEeNE+KqXMr7F/nvNaqp3mNPe3+cypULubEQoPnSMuJfLaU/jF1hf7egpkkqic1jsIUp7QJElXw+hy7kJAL5Sru3KIobccwAktlLZW0c2L9aNdx7sP/ZgM+uIuP7NsjoMKwMhbOMj/DnwO42HU4XCCxJkmRW51MwAmPHvGggKEDrfT+Q3mZFCJVIFfDJ7PwRnEdtnzBQ0tbmRQCtLqL7HuH7+J8cS7lsR8MkHE8JF4NS/SUiS14W1TBRb3oaaO4OkaJAjsAhZlZ/lEfm23PklTpBdXvOzTldOAkMIC0SB/LXc7p9+K5upYuZfeIo0wVmW4MMiKoJkqV4Dz+J0TJDGiP49aONy9Ui+8RHqVRONdmIZ9oNFiPxuvg43OnnA==;5:ScD4J7EzPS/GC/zFca/EGfh1gMhx4oJcugV5BVcEF/LBkhfPOAGPyljoJ95yMhkswew6GvxjRh/ZIJvpK2o0lw+nV8f0LNUUq3oTld/2apFiZL7SEDie8uhccIUwG5Xz/BNmwo//15ZwtezLVArPGnpZuiliY0FYAVHchWIVp4E=;24:z5i8fQF3HT/J+h6XOeqPuquF8EYQhyuxvKUyQuotWBNBZDDbAzOCyqGE1bn8Mjbqe17tTRw8Mnk8cmL0H9nPHfB7akDKdOBvtXf+3IWmAPo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:dfSY09HWCv/EPDD9KLkth/Ykz4nwlMf7mHQI2CgHcYzkx7VQhbo0IE2+N0uZHLUqQ7liqPqJl1Kizbd8rZBSeqisJ6XznI+KN5DjcZd+tf1WrZMFjbgGpmU+MxrIeSQBiS0aMwodcuR0Ft81YdwkS3XcbH+rNZb4HMVjKLrBsYkIahbXb/uhONp7mFAYv0879rhex6VpxPXccZBC35YWyX4dapbXIMHRWnnB1nDnB7FQIEv06UAWJqKHwX70MsDF
X-MS-Office365-Filtering-Correlation-Id: baa6a758-2386-4691-8bf4-08d5c69b9644
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2018 02:09:44.8283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baa6a758-2386-4691-8bf4-08d5c69b9644
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mem mode suspend for i.MX6SLL, when linux
kernel suspend, SoC will enter STOP mode,
ARM core will be power gated and MMDC IO
will be set to low power mode.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/pm-imx6.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index d319b20..791e1fd 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -130,6 +130,13 @@ static const u32 imx6sl_mmdc_io_offset[] __initconst = {
 	0x330, 0x334, 0x320,        /* SDCKE0, SDCKE1, RESET */
 };
 
+static const u32 imx6sll_mmdc_io_offset[] __initconst = {
+	0x294, 0x298, 0x29c, 0x2a0, /* DQM0 ~ DQM3 */
+	0x544, 0x54c, 0x554, 0x558, /* GPR_B0DS ~ GPR_B3DS */
+	0x530, 0x540, 0x2ac, 0x52c, /* MODE_CTL, MODE, SDCLK_0, GPR_ADDDS */
+	0x2a4, 0x2a8,		    /* SDCKE0, SDCKE1*/
+};
+
 static const u32 imx6sx_mmdc_io_offset[] __initconst = {
 	0x2ec, 0x2f0, 0x2f4, 0x2f8, /* DQM0 ~ DQM3 */
 	0x60c, 0x610, 0x61c, 0x620, /* GPR_B0DS ~ GPR_B3DS */
@@ -175,6 +182,16 @@ static const struct imx6_pm_socdata imx6sl_pm_data __initconst = {
 	.mmdc_io_offset = imx6sl_mmdc_io_offset,
 };
 
+static const struct imx6_pm_socdata imx6sll_pm_data __initconst = {
+	.mmdc_compat = "fsl,imx6sll-mmdc",
+	.src_compat = "fsl,imx6sll-src",
+	.iomuxc_compat = "fsl,imx6sll-iomuxc",
+	.gpc_compat = "fsl,imx6sll-gpc",
+	.pl310_compat = "arm,pl310-cache",
+	.mmdc_io_num = ARRAY_SIZE(imx6sll_mmdc_io_offset),
+	.mmdc_io_offset = imx6sll_mmdc_io_offset,
+};
+
 static const struct imx6_pm_socdata imx6sx_pm_data __initconst = {
 	.mmdc_compat = "fsl,imx6sx-mmdc",
 	.src_compat = "fsl,imx6sx-src",
@@ -314,7 +331,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		if (cpu_is_imx6sl() || cpu_is_imx6sx())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
 		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
-		    cpu_is_imx6ull())
+		    cpu_is_imx6ull() || cpu_is_imx6sll())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
@@ -631,7 +648,10 @@ void __init imx6dl_pm_init(void)
 
 void __init imx6sl_pm_init(void)
 {
-	imx6_pm_common_init(&imx6sl_pm_data);
+	if (cpu_is_imx6sl())
+		imx6_pm_common_init(&imx6sl_pm_data);
+	else
+		imx6_pm_common_init(&imx6sll_pm_data);
 }
 
 void __init imx6sx_pm_init(void)
-- 
2.7.4
