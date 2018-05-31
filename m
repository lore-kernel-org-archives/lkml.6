Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932634AbeEaCJt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 22:09:49 -0400
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:56967
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932588AbeEaCJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 22:09:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: imx: add standby mode suspend for i.MX6SLL
Date: Thu, 31 May 2018 10:06:08 +0800
Message-Id: <1527732369-19740-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:VTgxD4UEqfvrbJ/eXTVKfd04q3VwfRepnNsygNYNRbiak5OG5ZVdWmpvSy+LtEeqHJRs8lGcF3gMskpTOTYnqZg5Fvlbj+Nwq3P9dOuoe+mjsuVicPk7Djre4e60X6HN6Sdfh5377rW6ORrDPvfonflR6Ysjjq59+6/A/kw6A4euEBCQ2ahWsi6eSfHG4ud3XbdLmkjkOWre7gBrgdIaTsNtSJf3Lfpc0ZBkD8NJUF8hQYCcGtVFTzetN+cXZebe;25:wW/Xg3J9drfYbOwXPMNeXjjeHnG/t3ovmXcmcLzIj8mnssHGwh/49wnSPpZV/y0DoLEo9DSXq51nue8AtBXJQGY3PpX60YG8xtpTKAWDoduvTR0i0RIEfdh4zyqRCYaXyltFdl6x+CP8yDxXZasntnnGTIL//nCw26rC2G5jl2ldfX5/ITZOumZ0CQ63XZ1mXhJi4YOe2kuNTUdkrwniZnyzIcf6px00TIcodR/GIDDS9ApLW/IMrXYDerP6e+8W74+HL2CyePK5dEF/J8KbK+0jZnZfUyV+HY0pGLXVw27/v/sXXq3xsDhnQoosQftpL13eI31DAQP0UwdYbUDAqQ==;31:0LFNMMi6/cdOQldMadAC0xE0J57x6yPQPpF63ayTjRZhuO8TrDN3H7es62SLEs/iwYiMtIB24Tujyv+qMTV1IgaJ+hJ1zVLq6m5tv8c78QTjPMZ02f7TiubYH6bKvwS1yerAgBOoBSFlJoqeC7ujdztKeI5BPmzHoFYz8+mY5E6Q/f37g7nwhe7xEqEPtdyDnsN/RXLFw9RQvsSch4ZJSK+MtYt42D5QJOz62MqByyY=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:fQhZGsk5aob+pIsPYrv4BmzlZMS4QyZM7gdzfz+nCaWEVZP9S5l+atRgdVHxiyvFZCYxfuTOKv+PgeaQnhtuG1wr1+zQ38hKvefvVFbiJcsCNZLA/IYWxNdG05NIVfTGh4LC+6eoVhqjwprtSnCwhRrcHmSvsijBgCAQb5Z0Nxt7vVrXEinpul594QJuYPOO9FGTaClumP5FBsIgG5nN3x0T/smXLFWd0PQVyVdm+9Pl5Z1ziefrecJI7tLwItZOohTqB9FwoGB0ieI4y59sKcyGwLZf40EsA/BzhdpE+upNX4f9xFOpPTOE+aBRqpbTyK2MJSjX6D4xw7jD2Fee6TcOkrm9nVKwcYqELQgSgZlTAqDvu2OgEBxqdpqq/ONBATQwPhdlEYaVJ8App2056C/0viXl5NEe7ChDfzyNG6kNicRK/75fwwaF+WTJWN5tmSI7DBSZFU7yzmOv04DTNl0P2rCmA3QCFdBabaLfvlA8x3vuyWSQg4rqq+eP2CRU;4:vMI74u+4/i3YWOpIBw//gOG/uAcoihEDlBVlcvISCvMDiktFV9BH8FQKVDVSERDflGEM4oGvQLvrH5EyI7xZMRQ+tC0SUFuQWaPkZo+I1Lm54k0GEYhpS0uIHravTKHwHKjX+tyv0HYggxBP06fNYwWW0icYC0GF1VoVcoL33Y3iExcKgxfa5boTWMUpNbv8jBv0RUwP3Tc4GAc4mkknSL6/vMwreYqKZ5NaE9jI72hyI/hmQNlP1wx3GAjqZbfG1oIWPmN4a9Q1AEqoFXDszz9f9jefwgMH+78nWabe2ls+LZtkH2AHM//ytL1ip28u
X-Microsoft-Antispam-PRVS: <AM3PR04MB131508B900FAD0CA2ED2E593F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 06891E23FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(105586002)(36756003)(52116002)(16586007)(316002)(6486002)(50466002)(106356001)(6666003)(6506007)(386003)(48376002)(68736007)(478600001)(26005)(59450400001)(51416003)(2906002)(97736004)(7736002)(6512007)(476003)(305945005)(86362001)(8936002)(5660300001)(8676002)(486006)(47776003)(16526019)(186003)(25786009)(50226002)(3846002)(6116002)(53936002)(81166006)(15650500001)(4326008)(956004)(81156014)(2616005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:U19+/vrl+lDo3V/yJR/6jQZ66cErAQU6n/2McGGAs?=
 =?us-ascii?Q?szp8cekbfZqfsogu5uJEPfPaNPlvkHc8H/5KULC9rvLIJluluHd7N93vJZh0?=
 =?us-ascii?Q?dDouCOMiF3EQ8jHDuN+4nflYvgJHquGDP9W0rdapUm5dMYjaYVOVByj4Th+S?=
 =?us-ascii?Q?9bZnBlCg8MGUkhTmj6W1SXOpRmXkrdp931V4juhrEGpj+JqprDEnpy9bAdj6?=
 =?us-ascii?Q?dVZuwGVpdGLXYeHEpIQchoKFhBcPQ6pchqKFYHRl1JibO76I8V1dGfZQC+A1?=
 =?us-ascii?Q?JtgCcMED87sAuS8hyRsPJqP2Ack2cXpCaH2NHP0c595A+jrt0v/pTMH4kiT1?=
 =?us-ascii?Q?nBUAWFfB6Piy53n8ytxjrZHB5TQae9XafgthNlNpbM9AG2iDT4HW37MGKwgl?=
 =?us-ascii?Q?6JTErI0E51gVWE0GCJ53+/XTSFhB7eV92caaO1ljwiW3SawcXjh+r1t/qeqt?=
 =?us-ascii?Q?KJV3o3wf4xIIyehGoru8wEbT8iCIAQde7QiVKhIhJ278naNkfd+EZwzJ89j2?=
 =?us-ascii?Q?+07d+qLCLP693U5IGm+R74/GZh1QYjqKsh8kumd8iC6WugoRVWxfMyS6MT5b?=
 =?us-ascii?Q?QFxyf91sNdmB5HpQxRamxgvyAKlStlxm1AEUFgycHNQShU31zSYNjCy1w34S?=
 =?us-ascii?Q?6zajJTx5STCOd+CKwXCW30NX7ygwiSlfmUWVq5IlzQFnphNWDrvoGI12jqwD?=
 =?us-ascii?Q?qrshE3USjQUPYc8TkvrIx4QQl8GavMF7T5o1gM+DNcj9IqNzVNUqS+bzLD5B?=
 =?us-ascii?Q?4EZUVoyaPNrMtcZi48eipxSxWOMcUQqzCHa0xSgSft09aAUIhoG9/FqMXJEv?=
 =?us-ascii?Q?9RzDdp6Mwx9ThPpL2LCHyBB20OLAc1e3imW25PZcN7MBjPDcUENnXt3gZ1MK?=
 =?us-ascii?Q?YZOWMbAp9UO129tSw9/OAawnn2sMdURlowr8YpkD391den2kUJeqBuC1IwOp?=
 =?us-ascii?Q?KsmkwcxP8XAyXoxB4A6pUId8s6ktgOZm0cIJtVTCl9G3aZi1z+OUvx9J7IPx?=
 =?us-ascii?Q?u/6rkZjnJN5Jpxo1bEA1NAMMWsHFgoKOv0qwkDYtmBCpA30gVVOScOkxNaq5?=
 =?us-ascii?Q?kLCujpV6NNAMve6F5fiE48OQd0bqfg+MVgbIxCXVAwcq6vWPDIrb85JIxgzh?=
 =?us-ascii?Q?0eXUMnicCCyvmlf3ND3RIoFQbi8CKjDIqYoyra69qO9XuShEZAOug=3D=3D?=
X-Microsoft-Antispam-Message-Info: pi4ur6jy8NgVyyr+LExmroPyyhIC0kdrndHr2NK+7b2eXmkztdoMCsebplFKz7XbYXYRLyCQzGL0mAK6POGdMZAkcQuo5MFsHwCzVoo/JqQxEUh5F5DanjXAH5OE0AD/6Ji4T9XIH7xhtlvqrxr5cRZutr13aDRaIZqo7NmI8eX5X+Z7RIyjAvt3Pa2xEm0B
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:1aYBVxy/W49qs50/7iqZzmW/TuYMNsXTno0Iw3NZOz7jyNwpqlTo+imDFeMA1Q1nfoaIkOOsGH6KbyFcveyly4nRHrh8L68OU/3ttxmZFG/6T1PVgUSpBfnKwWDtoDh1cAWadtV0nYblRbKrerxFy2v+RNHfnFU36WVUhcUHr46ttN5F26z/LuWuCbUL3cWsj1n0K3qTy23dNrACn9dHZF1Va/Jf7dpOZSddUdyMWuH+Xy8NIMGgChsGKElFYx8bCvwm77hEiGPOkhhSzeF4aTm650DR+wM45akwRe6Rzrgk9sXhIiIB0WXVIejjP+flf3uy0WQHCyKmRUkf2bj7JGI/ptVORailaS+PI/AHZCSq7lUksu3jdvX5zB5vy74Fp/gxmaVsoI1Cr6wF4Q694t8npUGl6cmUDA1YNy9GYlFJI2wT8/gb0jnoAcWONHDaa2Nseg9bLmN4CwbaeMcvbg==;5:hEheyTKv2JfKrJU0Sn2HHUn5gREbJDDioHQ0XjYUe4iQmJvJAc9ybWviHwkXvj9I+ZwBdbNDUBFaYPgdxgc5gF//r/hxkhdB0+pWqYhZDeD0Ag/YEylK27MGWSW7Iry1Uv0b+4rQ3MKFfzM9r4IGv6BA0qU3VlQXTuRzbgrLmZY=;24:HugKYOZPYdSJjpI5E7kMdD183u5LBOvOzsg2Qv3DFTPxtC1VtC8t2mj0WbhNcvMSnM61RH82ZuJQvkBPtNTCQRNsFhCGRvHp2npHglrO1X8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:tqBb0x1Ahwj8VRWspKNaSp6DslbjuXCyV6kPLCc8AbRozfKYgrdF3i7speuV3+eETofPmlHZ8fF6hCLGCYJgQA/iRmERX+SLCQ0tcMUpxyEdlgXb7Bm3BAGczOzj9ZA+xpYM2NEthCy3i2uBOWLA4sk8WVxyq/giJWTwqKKiHT5MqDWdOIu+2FW45OzNrTLD3QCxeTc5DLLShBe8BZ1EwRYCs0Vrk9WOSliHSPjj6Lmf2BacX7kkeeeQhPDbXgNU
X-MS-Office365-Filtering-Correlation-Id: c0be7077-d9e6-4135-ef71-08d5c69b9389
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2018 02:09:41.1562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0be7077-d9e6-4135-ef71-08d5c69b9389
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add standby mode suspend for i.MX6SLL, when
linux kernel suspend, SoC will enter STOP mode
with ARM core power on.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/pm-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 017539d..d319b20 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -296,7 +296,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		if (cpu_is_imx6sl())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
 		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
-		    cpu_is_imx6ull())
+		    cpu_is_imx6ull() || cpu_is_imx6sll())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
-- 
2.7.4
