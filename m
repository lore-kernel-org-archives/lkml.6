Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932216AbeCIOE4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:04:56 -0500
Received: from mail-by2nam01on0122.outbound.protection.outlook.com ([104.47.34.122]:48312
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751067AbeCIOEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:04:51 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com;
From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        yuxiang.wan@bayhubtech.com
Subject: [PATCH V4 3/3] mmc: sdhci: Add MSI interrupt support for O2 SD host
Date: Fri,  9 Mar 2018 22:04:25 +0800
Message-Id: <1520604265-4430-3-git-send-email-ernest.zhang@bayhubtech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520604265-4430-1-git-send-email-ernest.zhang@bayhubtech.com>
References: <1520604265-4430-1-git-send-email-ernest.zhang@bayhubtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [27.16.214.154]
X-ClientProxiedBy: HK2PR04CA0065.apcprd04.prod.outlook.com (10.170.154.33) To
 CO2PR04MB812.namprd04.prod.outlook.com (10.141.226.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed364326-2af6-4306-304c-08d585c6b93e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:CO2PR04MB812;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR04MB812;3:9v/rD8aoc6kpbNn8l8GctpBbiMMcOzDI1frY4B/1J+lvyHjweiLBQPYYkA0InaP/03fMsuuUU4vjjRpY+G1xzNZoto7RRBKnb3rVLW5yBmiNR/SZjFqho/jOV5ABm2mBVE4UiZK55Na4NnzkixWt4BQiALKT8YqNYpIhu7N2GIi5hWKngpJ1hZSupMo/0+86slau51ciZ7AJ/mXg4rYC2mfH+X8kjWNR+Cr8QFxCmJv36/TFWRYtmzzf1eOtU+W5;25:1adQKrQJdP1XDEboHp6eSnolhVViSHKi/HSDTYpFl3/4vewRU9f/ieAo/OzLvewWTna6urQh/Hu7zBFCt82U4NlGfJOwmNsw2ttxviBnvRnFK/1qdVypI1s4hIB/O+Ykr+FQzPJMBfU/1A0g00loZXj9/2meIbD7cKug8i9k/W8zJo340jz8o5BwZ103OaN96Zfm7HvMBhqc7yn2MN5mOQgI8fuUfnCtCiHEj/S6b4e5+Bd+2oIU2FlAlSRLu7GfmmCqK9HiZOWdZ2ZB59AjUT4704dpeEcpdXhhWK8H3Wl9XGa47+HqKWICqu8lbGyCOmiKpl2LKoz4vSxoH4SCpQ==;31:vO3eVKrnw0kbvz5YCpNt2e+SE5XbuEyU2nqo4yFk1t1Ib64g5JY8oNLaGBcZNDd8DUmFPqtMuZbPls7sHksLGSkeOxchzZAi22yrXXBWDzk2NiC5qsbGR0HhwoKNxc2wDtGF1Zmmkf971N4pKgW05yK9UlCG/ixNzBnB1l8X38UIyUaQwlpLbyR3N3U/ZJFZHp32X/Z/8wJMKsxdulkxO2OGu6hhntzOGLMt7ZZpU+s=
X-MS-TrafficTypeDiagnostic: CO2PR04MB812:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR04MB812;20:TcCdwHUEw6ZmDYLTgSuMjKQehrzqGy/l0hPe3IRm8nGDAIJUH3dWuBo5kxlEpg6ahT6kPVjncJLCcVBda622c2LPPrBlARPmVM1Zk4rFbVDED9KjhUZJJvJIygg52wA4m0NWIaXk38G1AdO8VdL4xg1bwG3Ok8t6YdbDZJIp9TfaxT5oNWeFwbZ0JKVX77jY9NSUoBaugIn09R5ay8mg3dhboj/FxWVJxtm6uLKeVyawgG3HUtw63K2u5g0dlbQMwNA0XQEowb0RXykBKnlqcUHvi9kn+jg5K4bZSmSXPPJMruc5w/sVnmut/Gn1LrB2Zhumtf5y/ODcMEBGuvGy4UWjI4o+jiYKQRla/PrYI4f4Cj1o9SPcTW4+8Y+pNkFDrD+lwbDYkMZnR4dBTXRDFmkvH5Rdi4X9DXnp7GrFkFs=;4:jmS8szDoRdB7cqno08figU2pA8sTCMYX8fCLe6Jkhl2qT3tMvXRpW5vfxL0aJVjWewWXBIEoWGa7IdOwNn6uLNbvEQVPAfOMbvMqW3xTdnoiPeh6Wc00X42EYo4UGTqF8XOWh723GJG6HeTRZ3acu222570b3OYlMCfT9gu1erif+e8saXTXVU1hdyUtDlnYVUtw9ZUYnudJJx+tIEdpoKU0jsWcKydgCm/ncnE56xqgBH4ma4J8IvjsU5rP9CQuGErZL05L7XmGVH50DyLS5A==
X-Microsoft-Antispam-PRVS: <CO2PR04MB812844AB827257F0AC48250E5DE0@CO2PR04MB812.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:CO2PR04MB812;BCL:0;PCL:0;RULEID:;SRVR:CO2PR04MB812;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39830400003)(396003)(376002)(39380400002)(366004)(346002)(199004)(189003)(97736004)(105586002)(6666003)(2950100002)(48376002)(7736002)(186003)(5660300001)(47776003)(107886003)(16526019)(3846002)(6116002)(50466002)(305945005)(76176011)(6512007)(26005)(106356001)(51416003)(52116002)(2906002)(68736007)(6486002)(53936002)(386003)(6506007)(81166006)(8676002)(478600001)(86362001)(110136005)(81156014)(16586007)(36756003)(50226002)(316002)(66066001)(25786009)(4326008)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB812;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR04MB812;23:Y6QBVhjp5nVovI2V8tP6D4AoKadnuxiePvgiV5SRG1?=
 =?us-ascii?Q?3grXiKRxwC5YqZBt+swLUBEfVm8DBKtP3hM/bc0oOJxTzbMqyan/4p42d+yZ?=
 =?us-ascii?Q?Pxdyco1PPrgln2tZ/2zjmQtE4on91Cgj7nLdUfTd03GVo0pbcq8NwIAcBT4/?=
 =?us-ascii?Q?xS54pLU8bzs9i0AzgU/Cf3HHo2Ehn5QFqlXYQ2zhuU/oT4CiLVfRUpW157Z+?=
 =?us-ascii?Q?H8P8DPFIefI19D1bw+HThdNNH0Gc5cGUd9JpQ5FZnzwNpLZjRH6nuRDyCyAd?=
 =?us-ascii?Q?4LHrn4jZzA5hyaQvvhIQJCmziCCyatb+k1L69K1IMBXYqgZRIEgE9HuWECQs?=
 =?us-ascii?Q?WfqwAMJ2o3Ap4k968bzrDpGeRLP8void8U2TaOuMo8eMoTiBaIcTOAsVzZC6?=
 =?us-ascii?Q?DA8SNqMR/10u2Fi1RqBUG0i/lFZZsDRH+z37hgBiBEhLnV4Wow83+ho1LQcf?=
 =?us-ascii?Q?s++uW39/QHdLcelJnJ1vY00osAQAhGIUnXdTj4E8VytFB5PvYxixop5TcYH1?=
 =?us-ascii?Q?+O9kOSqFwXDmeg8H8iYKdS6YL5UDdUTCz5nJr5LYnyl6/LlZA9IoVjiv2e51?=
 =?us-ascii?Q?iNTrPzgp82na9KRwuHcbD3c45fyR4PYqY241noVINreBa7QYcJbyNwhdSMFh?=
 =?us-ascii?Q?daf0yCyf/ZQnWvrREKm4ysE3oKS8RTKBK8XfVwtubx8jSJA3+NZs6vMVQsIW?=
 =?us-ascii?Q?Xa7qvo2H4WpoZGwRrQunK6AC3POK+MCt5+U8twH0HTPHE8SP10uqbFDeA3TY?=
 =?us-ascii?Q?Mo0eeIytrB0spgGWmVmnKk7uWGjE8sTcOjFMkCB9aLNidbvU5na50cNXv7RJ?=
 =?us-ascii?Q?czAhItO3xdFiyahBIBSnQlfpKys0H0ar+8uPLs5uGQpnvB6PChPHd8GQlGCz?=
 =?us-ascii?Q?GhE/ShcV2RRK9aFJjr/0+tsFdkdaVSvGfWpG0tZ4bRCzowExVm6jDjVKcrar?=
 =?us-ascii?Q?khMeXFZWWs6P7aLkhSuIrwy5WdfaVNy8bLwab5XGPI5JKVbxbNktO9+ZcOMr?=
 =?us-ascii?Q?Fqxvld6sFmM4Vfpb4tqa92SPdcLVTLYNg5Gxtx4BSncApPnvAoUTGVYuIVa4?=
 =?us-ascii?Q?xM/eQaznPs7WyK/Z8Jx08tjZFbSL5i1PBcy9rgj34fJyvienYAlwvGYdsgWL?=
 =?us-ascii?Q?81yfGEYAXEpUyyILK5D2ctEW2GgDJa?=
X-Microsoft-Antispam-Message-Info: hcKWyBdtSPN5x8nnp43SxwNlZmkHq3s+H9Kh9FsLstolNPQ9cuiHoZNgb6hmwqTaXisfq3u6tU2A53iHVCeG1w1ikpfx3DNmzSDuJDL3zAc7k5+Z8VIxmRRX5RYLFJbtoH36xhJSpnaI99eqFkLFsgxhU2sfCPe5Wh0tN+xwvFGfVGca3wC6VrsrW8iThEGw
X-Microsoft-Exchange-Diagnostics: 1;CO2PR04MB812;6:nUXhmR8vNa07LIwSTmp2OZkEmVJLzmCdOLNXrEjhpmclPTsvbp7Pg+N2DEB1TraQBKIM6+DfdP0tRM31UouXXWqS1NWC/1Sr4USMcO1Li/4fDffktU9t5b8LaooVSPBvoUmaRUXkXYtQsgEKC/dE72Uks1vK55OIf5cKPyAfg+OcfozOfyqhm396nXv2BBbS8hXGk2Fh+N2TlUZiI9qMVq3amkvDKnufKhZWSpiQvZDUM7PA9w6a0XTO9AwBDTagt34zCEnixloEybLhA2MqACsfROI18H5KCQKWRCfRKt0CHV8q0p5h6BAbbMSGd2NZDuotc/FssqRVyODhSpiyu0lwCyL9bVCBh8HkpHQXH2A=;5:n5ZmpwjMnuKXQ1odVyj/sX0jhamfnrmH+awr48qch+QFhhI0qkUYWr60fTwuFRHo3u/YhTwUQOWRfVpFNYuCeHcGNcmkcvfhXiPV6NinRfT4pcLKVcRdRAZmOqEc8ydJv580gwq5F1h3GNV5ituM6cERQtIswfQO9jGu2v17Pc8=;24:/xrUQ+DQ9DN1uN2h4Y7aul3sv34eCuMHP77LpEGE3gWGF42P7mEhsZoQkrMFzhR/hZ6IH6zl/0CX0RhlWSSdS/xa3FYmwpOslPUZ6Ip5HV0=;7:iixPakwISZKWXjBm5GLxzocjKdvzezgdYwRUfRvdOMpw/YH4T2wElHFOVpE3ldCHfXTQHaD8+Np1qduS69sHDW+oCo4Pvpacqa/hyLBBCoeCAvHR0k+gTvbEGBk3siJGe3RGWEGtrlN/8cgyOj9awP9ucgAfdyZ23PO+OmX2+2XQGiDijx/uni7JpnADDIYNbwSRYdjCXS9qD6SqzK7OpDP5w0zE0AE165K7HUwnQq6EOHwG+WehkBLxf4QHLCAO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 14:04:48.1150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed364326-2af6-4306-304c-08d585c6b93e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB812
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSI interrupt support if the SD host device can support MSI interrupt.

Changes: Enable MSI interrupt if the MSI capability bit is set in 
capability register.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index a918984..7d04f4b 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -391,6 +391,23 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		if (reg & 0x1)
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
+#if defined(CONFIG_PCI_MSI)
+		if (pci_find_capability(chip->pdev, PCI_CAP_ID_MSI)) {
+			ret = pci_enable_msi(chip->pdev);
+			if (!ret) {
+				host->irq = chip->pdev->irq;
+				pr_info("%s: use MSI irq, irq=%d\n",
+					mmc_hostname(host->mmc), host->irq);
+			} else {
+				pr_err("%s: enable PCI MSI failed, err=%d\n",
+					mmc_hostname(host->mmc), ret);
+			}
+		} else {
+			pr_info("%s: unsupport msi, use INTx irq\n",
+				mmc_hostname(host->mmc));
+		}
+#endif
+
 		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
 			ret = pci_read_config_dword(chip->pdev,
 						    O2_SD_MISC_SETTING, &reg);
-- 
2.7.4
