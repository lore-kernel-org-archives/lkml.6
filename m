Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeFCDEo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 23:04:44 -0400
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:23376
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750987AbeFCDEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 23:04:35 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] clk: imx6sl: remove clks_init_on array
Date: Sun,  3 Jun 2018 11:00:45 +0800
Message-Id: <1527994847-2363-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:202:2::13) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:3C/bIBFMbz6k2K7tVWDLncYiYWQxV6CMj9kR1jQ2DYTp3ZVK3319BRlgFFhDFQTZm7N99Hk+o5sLm2PEo8C6M+X6agZ1EI7H49rRGSmtm3Xav8y7SUVau5lyhq0xgEKRprtcQFWGaxFGPUZnu7/YKN8/CHFPKAX6oHWhkkO1gks/DDcf6VL2QV0s0pEVNR12pqWVvUvw1Uwz108icJVuo1BzwtPHRBPgeaIxgq3VfdUqz7UHF52zbNLAErx6Xm8r;25:eXDIoG55ryyJAaFbjBQ7Dv65ol9payHz6nFpLihMNyRt7CRZM9pL2aGkQSqW5zCvxdo5i5nwQoRtKS8OcU/CKM3SRwbLDUN80BsxV2d4ddF3OCNAA9p7qvhMmOj/iiGiasEjmenvR9So7he3zBeFBRZdbeptBvVD7YvpQCsJ8A5zlDy1st8DwtQSbvkHN8Vd44BAM+bfD/lwXp+Nl1epJagH07X2QDe1vyrqHC+1fliwNEH0M5XbDJN7WTUpJ8DjecNZrMqD6VIZfseLFRBtsxFjeIVrzJrzGFl/X/PiSvKKEUAWAAav9he40be61WdzyApVx1eyhbZ9A4lDkKVLlg==;31:Na683qFeaBoDTFNbXI2JnoRUenA9yY3+8gpQCKgipvF1WHpiviZJIENRvUVr5uEelCmJ83DLY/uBPwFjDsSEyb6OWWzNWSjAv+AaD/THCQxO1sRUhaKGk4WoT+1HJxfmhyXeV1R1RVt5YbKaxq/v+d5PkEUwXdBSyQeZ5eXzCjcpToKgDn2n57mzjyydlQm7M/XyZ4sAYgowyNtxsgacCmJdpB1oPUoxZ9Q5/lfQwQU=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:TDf/jlbgp+tovdjjxrTYA62lJjLWcENHXnxF7tEl8W5vDaYtylX+jaIAcD4hqLa/AEr3ygCAF+/hMbM57Wxw+y7tt1wahBMnCjRVwlpU9w2l2MfXE6pA3jfiZ9SD1zV17emjza3Z0XINBjJ8MwFdg1NCa7/NOM8Npj92pcKbPCh1r93NB73mG+bqBJ8NWLk/TepANR326eoHHvSj8OOPukzq2b1V4a9nBRzIpRGLgtdZ1bBgOocJGN/RjAlzn8c6xTe+N1l1ZnwPhVShPkZKMtum+g3nW79geL7gfONDgdcyNUiYPqnZpL+ZEWq52rkj8XwxXuOtZfIgSA0ds/kn+i8o2SShHpUefh9BbcxEXi6QdOYDjLEn2mp5ATYr+BvkLWAE4Z8FZlWOS96g5HT5mWdbE4+BbWpHUFuwMNh+yO8/vw9EKIuGvQV3vGeLmGjHfI6AP4tWk7S0dMRexdAoQxRiVeus1M3ntmubMvAUONYWpQyxlDzzAtulpHX6GuR4;4:kDeYs3T+BMzvSHmdpE8438hkltGUUyXfVRjBKh6l2zLAgFNr+ZLi6PggXnrqW9+Z6K312FRne7Xd9/4ub544NreYdc4m3xCYbzytgMRhDEofYuYD/HydsSNEBw45/7Og1UuUn/S4n26bTyIYmiyMLInASO89L9JBTArO3knocOBJYlJ5uO9TALiu7X9j+CgrMY2UmcFCdhWkyMD5YdZKVKuGc3dS1Jbrw+mKa19IJmAuAIWQQwJil/7V2PyqESEO8G7Tw3cTYClcaWUhQ/eeDUpM6UU19W3dAKJdWeByb0uHRu2iHHmnbO+tb5Vs8C1E
X-Microsoft-Antispam-PRVS: <HE1PR04MB1323E238652EADD924BFC48BF5600@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 069255B8B8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(39380400002)(396003)(199004)(189003)(105586002)(305945005)(97736004)(86362001)(2906002)(106356001)(478600001)(66066001)(81156014)(8676002)(7736002)(51416003)(8936002)(48376002)(81166006)(50466002)(486006)(186003)(956004)(47776003)(476003)(2616005)(52116002)(16526019)(11346002)(446003)(16586007)(76176011)(6486002)(36756003)(3846002)(6666003)(6116002)(316002)(386003)(6506007)(25786009)(6512007)(5660300001)(4326008)(50226002)(53936002)(26005)(68736007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:CdMm49TY060UwI77G5F9UwoXCEBdSzn/nIZkNavv+?=
 =?us-ascii?Q?bi2DS/aXXprV8kb+0D2jVDgUJAPyI+kuD6a5wZnMHuG1y0Ryf2k8vjYMiX4U?=
 =?us-ascii?Q?VAMEc4PvKl48d8wRIiuk2P29karR6BmavwhHzG47SDiBp9J0c+Y/CIXQxgFY?=
 =?us-ascii?Q?Q2HyONpDwBdM4jl2+lGXUmC3z64Vv9NHbXTcVHror4xWKEdborc/upI5IXB5?=
 =?us-ascii?Q?pN399WWrqNdCQBTbkbAAsn73n+R1zJgxNA4I2OMVpr7qiIUltulFZNiSFg9R?=
 =?us-ascii?Q?Mdj/2YZiOZ7md0EOcNBT5pHcDlbeUU+Jrpl8s6ek/A3jOZ5RB+d2HkUU+Fvm?=
 =?us-ascii?Q?fqo8f+B2A3fhAsAcohyL5zXYvB/5XxqJIavaIAC5/hbU+IpT53ke9PFQTP6z?=
 =?us-ascii?Q?fO0yGny4Vs/uvb12nCHW0pXxLoTZrMk4XZUUwhRCivBRc2n1FABlsVzCfRAA?=
 =?us-ascii?Q?pmXOx4raQcurtrKQ/q5cZS7ZKI/KbXAvcc6nepopBHkFJqWkSd+d9eJkyvP7?=
 =?us-ascii?Q?+ZJzAC8/Ts4oq2iYaCwFUVdW8Lf9ev3kJ4PXDZpEeNhe5ULCtPetlnzhNDVQ?=
 =?us-ascii?Q?uoKwDEIvULvKKHxykg+ooaU8D57pdh0R7g7nKGzo0WoniG0Fb9CrKhTOQDBe?=
 =?us-ascii?Q?HNIuPpnFruLTtVZSeR7fcpwhbhQxgREttD1jjinI/Ri/476ACwL2wPAn/o8L?=
 =?us-ascii?Q?LWAH900CWsAiMBaZMD6GvB2GE5yY6pEZiJPqw665jr8LgAgd+XnUiAVMNqzi?=
 =?us-ascii?Q?MeYUzpNxNDzOYIWxdYZnkGXU0q3pRfCRjwKDyCJzSDmIRXaLwFn2u+VNLi1L?=
 =?us-ascii?Q?tJkNfAGHj9hPjhpZ+P68dJuJ62N3w4SDr36PjrBLxv+Bidf8ikB/nqD7CrcO?=
 =?us-ascii?Q?TjSw4g5RszR6FIFL/D8vzPkKvGzhdGHGCoQYGFH5U6fJt0itl6KFIMbbvmUe?=
 =?us-ascii?Q?Q5QttvFLvI6GOnSAi1b33A/x72vkTOJ0VZoj7eBPmGxsN5y1iY1nYYmlkyc1?=
 =?us-ascii?Q?qb9oY+qFI/eJBP7nQ+wj4AvQ09oJ3yHUezQ40nXSMzcULMs/WuZWCkQkNZ1U?=
 =?us-ascii?Q?yX2HckfcsXAvx6pbHB9pQPcbK4BiATgZ923+CDBn6g7zF9OSetxURtYxvU1R?=
 =?us-ascii?Q?yDiMYVjtozojlAtIWwlppPzEQ+RPBY/bv8YyVbVjmBeBnN1XfeKx9FznxVA8?=
 =?us-ascii?Q?GeTff3XZbG1THc=3D?=
X-Microsoft-Antispam-Message-Info: yHzdUHrfCDDO73XRExAAtyrLFwl7XzgC+WxaNFcdeZa2It0mC9BqaXsxTdnY7vYqqjvn/Dn/SgIdk7uomRkkqXERq0cfHRPp3lO3vhou6oXlsEA2mkxcuvniUrKS5ARrxCSEQRJRPnnOeVhRxsVW6SUeuxZiJeinkS2uE6pprq/SqUmrS3578E1d80FjBh+8
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:IUS4hJ6Vrmih418ugC7hHyJanEV4u3tf7gt/114Vudc5krbmD8CFWcOtpFT3tYJ31HQPSnJ+SlcQ9CMJq9MZLY0VV/7k9axA/RxBKUo0or/DRBS1RZLe09ZL8hxkyuTnBOAYikugXQvzxTcNI45AiPg7e1Vm24jYcb6m41+871euDiR5uSpSMyNbw8iOE6W32TonH/K8lFn17jAtNkPPniaysCmKLZ3xl+yna5TgXlcUtmvnytLFvjSkRU/OElMXDyu5uRVUIMNRgDG+GbG6gvP7fRloFHncQVNIB+yVhJ/hRByPCKFbnYvHSclIwQQ4HrVhILxPc/RHvRoEU/ZvuIbCEmwZROTuxqtFwPF739hk6qVTW4o3nTgMea+0gnr6PbUkqdlcQEuuYqBf0P4/G2N2z/L9JDZpUJ8xFBTdVS/maJOmIBJGtjeBib1QGIfo6Cxc9hHnn7ms/TQE8hmybg==;5:WI8PaOFAPpQdcNoLBAtkQXfgG6r11YyYKL02f6WaGevnoi7NDdienWBtjggLSeKzTfl3ZS46cu6kpFXyS40ao/HyOwTk9726Jhu1QGpDnlflNqJrYB/tvWTpx1jLkOtEBPgUly7hYfl+MvxNVFqHMOspFSkXqbZbPfn3jeZ/UkQ=;24:M5eMJFXmLqotIKNFdd0g9XN+vS5smCyN74gpRv+1sofXlEZ+SNNGkTnVTxnDw/tqTOek5RHfCGG+5kyqtuJXrCGwEEyWM3RNok+k5cvJ9ZQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:l1lKmcJOEn1V1ldKWkyLZVCx4YpI+1zs6xeFgVpJ4gwayXxqueuFROhMxxnUxgCuEk0Fuuq2NIcKLLufpfEvbW3c4IeJ/FnEiwP7GLKnWJ4TkwYr73Y//FZWOI1GAb/shUXU+9RNMgpbG2of/BrYlXSF0AZRlcoFZUb2zS8DcuuiqhNlzAyTA2GVHx7LiJv9rcx9MVdutz8N+WMgkHI5yLt4iFgKwIeth/O+v00/150diUzXBE4YqhR3duFilchn
X-MS-Office365-Filtering-Correlation-Id: 3a5de1ef-2544-4979-7cbb-08d5c8feba18
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2018 03:04:28.1737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5de1ef-2544-4979-7cbb-08d5c8feba18
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock framework will enable those clocks registered
with CLK_IS_CRITICAL flag, so no need to have
clks_init_on array during clock initialization now.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
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
