Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeDTQkV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:40:21 -0400
Received: from mail-by2nam01on0102.outbound.protection.outlook.com ([104.47.34.102]:45287
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751227AbeDTQkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:40:17 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=bayhubtech.com;
From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: Xiaoguang Yu <xiaoguang.yu@bayhubtech.com>,
        Shirley Her <shirley.her@bayhubtech.com>,
        Yuxiang Wan <yuxiang.wan@bayhubtech.com>
Subject: [PATCH V5 3/3] mmc: sdhci: Add MSI interrupt support for O2 SD host
Date: Sat, 21 Apr 2018 00:39:50 +0800
Message-Id: <20180420163950.11756-1-ernest.zhang@bayhubtech.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [59.174.170.68]
X-ClientProxiedBy: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To BLUPR04MB802.namprd04.prod.outlook.com
 (2a01:111:e400:89f::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BLUPR04MB802;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR04MB802;3:2Bq1Gw+eDymdMMDvzWF0QwyH65cXBD2vrYFKSCgq3ILOJLr1IEs9vl0rVUUmh99wwYRd9kv8nD18GTlI99os16RnbyFqgsmDzqcWHTnB/jMq5iPzNtj2a3Tp517t96Q1Ed4bzaf5orqGCuUejzu4QLKwIQ8xjv/I/2l3J1HpFzV54Pv9o84aPYFqydKz25DPRntdB0Op8eG9kpsGsLMcIh/96x3CIdZX4qAZfywhc4KKD46MTjpBZ3HsBo4AuJo+;25:fDdzUUPdxKDA3Mh7QDfKVwX8l35KR7WzSlU//akSn5g95U/7i8SocszxQ9DXn0EYKabLbD1yUqv5JJd3uuXH3TUbCvqCZezMdXfFyqTxZ6+cmOKSXGXbjTXX16HSl12xqlFn6RmrMfZqfX8s75HZyX6eQ0Vu1moIMsagS3Vp62uJN7tEKv3xYtOR44NpWbwpBBRLz7LJA7nZRC95Sg2+ZCJzjpoNGKEsf9QixBN4YxwCjWA+juxIcplNncdB2P2jE+hkZDbf8mtHzGmWl+dDT/8s0LQsnhfnsQLfEZorDCC3mO8UGD0Ye68WsYOh5V0CvioHutJXqlN5jzK6oW0THQ==;31:4i8lckbE79W70Z/hz1m0fy1twpro30HYIoueKDf0p+5iuuaEqfyTaAMIPWJiCx7K4CNkMT7dgBQnNXsNGaWlI5fqeq0uEoERnVC0hYN0HNJWk/LIhGhUCz4aqKYjtGRcynsZvw36ctoK2Lsc37ecybfl2YdOv7ZljeEwBBazXRTyoNlqctHBv2109Q5EFwdDnFT3HsuPDqjGZML5/Jqj3nuOk6KD8GZuBIeC/4ofhVo=
X-MS-TrafficTypeDiagnostic: BLUPR04MB802:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR04MB802;20:C6BzxGPMyqw5aLXudmAUNTmUHvsNwTPc3H6qxdt24j+dF7A58bArKA5vc4Kx7kTpIzWgi10XG6qOFw7X+IPwSVD31mBgq2KkXfLaEqexFuOOwugxJjDAUeVP78ZJfl6yQMzsuy2Rgh1PEWXv8drQyPXMkr5Ec8G16X8H4XP9w+rBDC4B6Sx+Dq/GfaWrMIqFq7WDs8EYtOqFsrkfvtOlPrcnYH4bwReexT9EVTyIvbITZzggFD2QC+u4zP1u8wnOJj9L7EqV2/yoUe6DbBdPk/olaRJEsf/V9azJ7Y5IBRX9bnaJpZqexLhPVn7sbHKWop888zNLBj8ptcgYFmNeZhVnFHTYlmnF61xVbF2KW4ks8nG1L/7kZa5Gg5jklvQKZUr1EFQogd+pwRi4QDzWJU7zNNcgHIAgoj7ajpe34Q0=;4:ZMcV+oLDdKrWTnD4UvyohZG3ApNYr8gajBKHZ7wv3gZCUSSRqrsTMXDI9viiXBnCH426QgurTf3lrimVZYOMl9PwZXnpGE0WniuVSwpOmXKZOWkjHLv4bBxur+OEBofFbm4t9psZb6VPp2gnY4qtvFiHZaihY4Ki7tW4YbFRw8pjvoD7SnyTJG8QiBonTigvan5UBG00NYiXS3M7tiYH24U70WvsDWlpdkvm6f+jYSHkacz4FfSguUA+Hr0q8EQWelbiG9mkUqa1OcRqGeL8+Q==
X-Microsoft-Antispam-PRVS: <BLUPR04MB802D5AD36E9068AB7C33A75E5B40@BLUPR04MB802.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501396)(52105095)(6041310)(20161123564045)(20161123558120)(2016111802025)(20161123562045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:BLUPR04MB802;BCL:0;PCL:0;RULEID:;SRVR:BLUPR04MB802;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(376002)(366004)(6486002)(54906003)(52116002)(50226002)(6506007)(478600001)(386003)(48376002)(53936002)(4326008)(7736002)(5660300001)(26005)(476003)(2616005)(6666003)(86362001)(16586007)(305945005)(107886003)(110136005)(956004)(316002)(1076002)(8936002)(81166006)(66066001)(47776003)(50466002)(6116002)(2906002)(36756003)(186003)(6512007)(25786009)(8676002)(16526019)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR04MB802;H:localhost.localdomain;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR04MB802;23:E2YIX8WNyreDrLPAPH1xMD5XGynWqtAzPWEzbBsZZ5?=
 =?us-ascii?Q?V/dl45DuPqEpfqI6CQZzGzNBTkJd6df2nSrrJgvEsoEGVhH1QyS5l2BKzaM+?=
 =?us-ascii?Q?BY1sZUzR52UC7QDVje90uL5PUhQ5CUov+SyoHFwW9GNx3095WoCOglEOXhdo?=
 =?us-ascii?Q?ArTElCcjsXZCad9wLqgNPGqxiiuWEKYroaQFXCZEvVsFBIMdLFxe+s0zNnpL?=
 =?us-ascii?Q?yk+FL5WXpWaKfgPciQND0siwJ2x8n8E8Rij5gXvqv1EKxDr/eUUG8J2uH/k0?=
 =?us-ascii?Q?3JWhjMhM6edlIihtfgCUJbwHD1MuIs5UhcdQDQYNOhK4vf4xp17Zr44b3Jyi?=
 =?us-ascii?Q?GqHTLc3ADRWKoPw1333ZGM9RXkI8YTcUIRLu3MdaHe0EuXMSIrqF7LWb0Sv8?=
 =?us-ascii?Q?RY8OsxdBKLI5K5zUZNjZ5ML/ZKo/5BGbEwQhRqOs5d0eb0/lZojXwA6g8mH+?=
 =?us-ascii?Q?tiZSWofzAbOjzU0SXvl8T75oQD1AWiP5+smebX/V5s4P50hb+3UmZ3YPFuyd?=
 =?us-ascii?Q?qKSL7habIZ0bb9u7fnqjIe2oSYn23IUn9VW4o32tnRXFGhgkPGBHeOeVtv5O?=
 =?us-ascii?Q?jlxmhnQvsgjTuqo2+bNZAZIQ6eti2wMS0qOJCP+u0xeGo/pwuC9UlMxuGqEy?=
 =?us-ascii?Q?9xMn40VQ0+apxODOi7/E2OWcQwXwCD/QGFfpvC3AVO2LhpdfdJ02pIopb3Ce?=
 =?us-ascii?Q?KfB8Wrl9eCYM3jGLjnFuhGe25Q6Kf7HLbSqTW+lP5K0POvtqnHk+TGnio7PR?=
 =?us-ascii?Q?wLDtWmF/pYunb2g56M7Wh+CsbsTZCJR9nteksGNtBpe1FUsgCd6KW+h/oXEk?=
 =?us-ascii?Q?CV05s4vR1t0VDZpCEi6/DMM9AlyqTFLDpN4FdqmRgmDR7TUmmSPe8e6q+NLH?=
 =?us-ascii?Q?HYdIbmMvpeIbrAObrqdPLxkVdibMGw0YKcqjigFI9u1cSq4wGGthyU3McPs9?=
 =?us-ascii?Q?9ITNIJ0+tc3AC+fQZig3lYKZTvjrXdNW6FX1Nw9CQ9JVi1huMz65siRiYeJx?=
 =?us-ascii?Q?w=3D?=
X-Microsoft-Antispam-Message-Info: HcPyxA/o9pyg+b8Fdz8j5JLdF6I7YV6zuo2Bty5sI4RH+1UMhRtdKD3bBRjy9hv5agVjYbzc7IcvcgAdktXcolUokdm3cZjj+0Tpv85IW7eyGPbW9Rkmepep5S1FPwijeML2ZGUsaAoZPuvEweI7MiMB8tG6RVNynwDxBtpMBn9SxXHNpQfxqfjLnsrcz/GZ
X-Microsoft-Exchange-Diagnostics: 1;BLUPR04MB802;6:3RiCCZGvLRvC3WwDsyj3H88lVQXOrS7ygKUzeFwtairwSJ+pMXqtLZazreGrl24xK3O0KC6NGTZAHkbQJRIa53W5+Ndy49FvlwC04A07tchFmq/QDSV5S3nqm/nsaNqnrqa2QDnmqoi4pCoXttZtQk8PBWEFx6cC8TBBcGi/X9hHTPoQHt2jpzOYMEnGmY15K0wDiWFiHXIVnuori6lCLiAuXzGIXWrVmr+ljgJmi/1ROw1UpVTQazPSJzbJnTI2XgBuvFJik/d6FozSIRr2oPRdwk3QqV1CNRuksbNAMMv+31++UUMLBjvPNTIeR+IRQzrhgpWoZ5lt5w4wm37It2CFyXRnuEPeKTc2IOFb72ewDxty1RtldzFbc+/eUGpBIWlCrHb/QqRRQ56bnGdb1khXUXRBFUNg3/CBDo8bgFTMVLOatkzL+B74LuygZ4oZk7TdQqem65UMsNwrHWFdsg==;5:OVrgXYA6xz29nXyXnU9F4VyfZ/pMkldK+Eh3iCSS548F7KxN1fV0UUMzuy4+jyTQYU59brCxToTIJuWS6/Aok40Gia/VgE+aVK0G/vsR4Vn2t5WaqERrOdcPsTqyJuC4Of6fnwierRVtdcfDwPw3sC3rt/tzueTH89u7gEziTiA=;24:x/6lTnQuhAZX1o6aE+lx+NV5e1dJihmzylOLoQpINjOm/7xEDSnCIJZc8I/+9Iu+pOopkExr6L6pp32NPsBUeaMMFZ0DY0R4ZKAzQCn3BW8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR04MB802;7:LvMaOmUde9tL6akFzj9B6PCEn6L3k/obBEn8ArFGATYjdA7SSqSUGvwxrWtf+v3cqhNDmrKGH1s9Oy4Ndkmh6oCix2Kz4Jr+G4QHtipvWWiq4FLmDnQp31+sW6oWhy+t6FJz1Z8EMhH4l3a2/F/Ms8wZeHFwf3B5Gf661x3l89+VyGsgRqyk4NU4f7OlhjPwQOkaoZer6ohIiiCc3/GD+q29jggvMPc8q4WNPWgwmhyQtbRtBA2Il6ntb/jYDkW8
X-MS-Office365-Filtering-Correlation-Id: c34fe61e-0d67-42ab-91fb-08d5a6dd648b
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 16:40:12.7059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c34fe61e-0d67-42ab-91fb-08d5a6dd648b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR04MB802
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSI interrupt support if the SD host device can support MSI interrupt.

Changes in V5:
	1. Because pci_enable_msi is marked as deprecated and should not be
	used in new code, use pci_alloc_irq_vectors instead.
	2. Remove unneeded CONFIG_PCI_MSI macro check

Changes in V4:
	Enable MSI interrupt if the MSI capability bit is set in
	capability register.

Changes in V3:
	None. This patch is add in V4.

Changes in V2:
	None. This patch is add in V4.

Changes in V1:
	None. This patch is add in V4.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 96adaae..374c783 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -358,11 +358,13 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
+	struct mmc_host *mmc;
 	u32 reg;
 	int ret;
 
 	chip = slot->chip;
 	host = slot->host;
+	mmc = host->mmc;
 	switch (chip->pdev->device) {
 	case PCI_DEVICE_ID_O2_SDS0:
 	case PCI_DEVICE_ID_O2_SEABIRD0:
@@ -373,6 +375,28 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		if (reg & 0x1)
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
+		if (pci_find_capability(chip->pdev, PCI_CAP_ID_MSI)) {
+			ret = pci_alloc_irq_vectors(chip->pdev, 1, 1,
+						    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+			if (ret == 1) {
+				ret = pci_irq_vector(chip->pdev, 0);
+				if (ret >= 0) {
+					host->irq = ret;
+					pr_info("%s: use MSI irq, irq=%d\n",
+						mmc_hostname(mmc), host->irq);
+				} else {
+					pr_err("%s: failed to get device irq, err=%d\n",
+					       mmc_hostname(mmc), ret);
+				}
+			} else {
+				pr_err("%s: enable PCI MSI failed, err=%d\n",
+				       mmc_hostname(mmc), ret);
+			}
+		} else {
+			pr_info("%s: unsupport msi, use INTx irq\n",
+				mmc_hostname(mmc));
+		}
+
 		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
 			ret = pci_read_config_dword(chip->pdev,
 						    O2_SD_MISC_SETTING, &reg);
@@ -380,11 +404,11 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 				return -EIO;
 			if (reg & (1 << 4)) {
 				pr_info("%s: emmc 1.8v flag is set, force 1.8v signaling voltage\n",
-					mmc_hostname(host->mmc));
+					mmc_hostname(mmc));
 				host->flags &= ~SDHCI_SIGNALING_330;
 				host->flags |= SDHCI_SIGNALING_180;
-				host->mmc->caps2 |= MMC_CAP2_NO_SD;
-				host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+				mmc->caps2 |= MMC_CAP2_NO_SD;
+				mmc->caps2 |= MMC_CAP2_NO_SDIO;
 			}
 		}
 
-- 
2.7.4
