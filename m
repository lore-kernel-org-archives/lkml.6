Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbeCIOEu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:04:50 -0500
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:59279
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751067AbeCIOEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:04:47 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com;
From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        yuxiang.wan@bayhubtech.com
Subject: [PATCH V4 1/3] mmc: sdhci: Add support for O2 eMMC HS200 mode
Date: Fri,  9 Mar 2018 22:04:23 +0800
Message-Id: <1520604265-4430-1-git-send-email-ernest.zhang@bayhubtech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [27.16.214.154]
X-ClientProxiedBy: HK2PR04CA0065.apcprd04.prod.outlook.com (10.170.154.33) To
 CO2PR04MB812.namprd04.prod.outlook.com (10.141.226.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17069514-852f-4711-4599-08d585c6b5e4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:CO2PR04MB812;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR04MB812;3:uHohHFNMpx9rPku201hpjEa3sBk6+SEru0A3B6VUQNAYA831wQSfcGYmk5Gf1ih/LBx8EIC5cC8csq8aoctwQZGNoOHOB5U5Qu6DnDt59NQLEIcehI4i5l4WzHRfr0KNIJP+RwtVVl5zdjnAWzax6LOA+UtmukxI24t4AUrk7fcflYHaYtXhDkbB9vQiB2IguSj5epqta/pCrFRboe1r8ehoZn6ZinGqcMm7200H1+ZVcGvDQ9vPWL6IIQAnsSJM;25:XO+Pm3xwZdQEhYV3i8702WLF3/WK0CyrrsRwSM5fxnOmTQwdsIK2T1U6teneNCwKdpnC+9aDN3YfycBx7MWzc2PS8xxZaAK9Ghq40Zkrf7jD11XOlzL6Qliyd4FezPzG7IvLSjwwyg/WjHpXENgGDBUdUJ07itKK7s2+8y8CMxb/nNrYuB+/t25zksuNXSYBoCwvqyXaRXNc7RJDKs3ptVy6CPEQD0E+M7hRAGJKVGk9/DIipRck7X4FH/uXaMQTr2LlQXmsI7gpoVefowuiND3L4ftgTxHQHIZ8cFXpeUdrgUGbGAI07vRn8ZN1azdjsWLcGrL06wKm2wR0hvT8fg==;31:yA9AbcIPulATyHFwOAxGGTbBeI/EEJGKUphNrBxKEhK43rEpZBISY4/yBgzPkYwNeylLsvHfF7iicKlAVZyFUoqM0mhS/7NnUO1s4pL1+kIfV+JggrsJTDFInmKcO3xaMac2maKyzi+XGIe07e61Egq2PnJlfKYb09wiA+TQa+6k5+coh5FosvrSBg5AtKjZsQ58qASxRdpMQxILxUT1J1gtQOqKV4aeGPxkTwqLjhs=
X-MS-TrafficTypeDiagnostic: CO2PR04MB812:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR04MB812;20:puJPzGvXzPw9oLwE2HpKNgLtbd5Vr16xyOYmQyYKXZs7uwmAlVbmt3vRGi1SGPXL+hyx6bWDmtw0sXZMzcekf0ir6NZYNkUlKp9WI7cioHgNL7GHI8CotiT7sI/eTCZ2Uu0FMzoUo+KEDhtb4YZ2JJOUwOubsitcNDKog9R5UzM6szxP0z9+gO0c0BiHNgfFltN78B6Ns8oKMIdANNhCBtq1cE4THRWJS+wp9dfOCvbt95T83ZdqkezKfwa9Zxm2Za7R4ng+5wk8ckrTgEmZOOsVUTSoBs2CgzTKMebo6YaS32fDUVrfBKfh8WwoMB2yNelutt3WwK1CK2l/01OMUB5Vo65kJmrJlsch2rqGkN9WztRy9Ob20l6U48sHgQRLsTt9P5X1RzAR9Ar67LG6I1Cb9D8Bz3228kzublEMVaxeGbT+CHc3fm1y0sKtYOUyPh0OHBee3gMUozf5UlCUIEA6B9BI0tX8JkD7MgyMqjEc1gem3/BcQPtBVzvYk3T0;4:++XKmmVvV1C4JRi7nVq+CdC4IJTgjgfcOe7XMrZiUpuSeZRZaNMdN0U5SJAK32ZHW8CvvvYqoK6dGipg/V729vVYFaQ6DP7PiOxcdDungE1t4hn8fTpdr9LC/8FalNMhCbsqo9uTjEG5IF54HeWOK2juKDGC3xYx6Md0Yvrq+GwXfaysiw4IR0JIWqmN8N333+K5EBpd6g0Jw5uF0q5Av7QsnQz9bMzZlzkIxAYOqAfggbFiznRSU0kp9fTRHJqh3xrX1ZElxIm1E8tXmP3XqfiSaYn4GuyniMYe2H7DU37EKOy9wHXbiBN5/F3TydRE
X-Microsoft-Antispam-PRVS: <CO2PR04MB8126A14C528A0316FC47D22E5DE0@CO2PR04MB812.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:CO2PR04MB812;BCL:0;PCL:0;RULEID:;SRVR:CO2PR04MB812;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39830400003)(396003)(376002)(39380400002)(366004)(346002)(199004)(189003)(97736004)(105586002)(6666003)(48376002)(7736002)(186003)(5660300001)(47776003)(107886003)(16526019)(3846002)(6116002)(50466002)(305945005)(6512007)(26005)(106356001)(51416003)(52116002)(2906002)(68736007)(6486002)(53936002)(386003)(6506007)(81166006)(8676002)(478600001)(86362001)(110136005)(81156014)(16586007)(36756003)(50226002)(316002)(66066001)(25786009)(4326008)(8936002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB812;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR04MB812;23:RuVJsrV3+ZGO033bGFkV/9hBpmbjzHZ/3CyIWPvbRe?=
 =?us-ascii?Q?Ii34HAuzvI2jkAvBr+Xnr1R3qZtqe08Veg0oMHnDdAzH+/S75EjCCbZP9SwE?=
 =?us-ascii?Q?tIHN2Oh00Jwd9qZG5LXntPudh+jkuAWNjHo1NpuQc224+7Ef5bGE4zN8Q7hQ?=
 =?us-ascii?Q?KG6F3xtTHRinM5bQFOLTLbCuCX1jVElCTNeJUJDE/iK4Sxnu+4LXAZV5M6CG?=
 =?us-ascii?Q?cLI0jrrfRpHtCSH7XxKKi/CAaNOOWeiWZHeQoNsSvcVYmya9YVp9AwAEWpbi?=
 =?us-ascii?Q?Z1UK7zkOQ7xUcEXozskkPwX9UOL3fcA5BWuRxuGIZIJk3KEAAFbMt7AtyW7b?=
 =?us-ascii?Q?eFzAmLWO7IJyGhECOnrL+bteCmWputIGY/7b/5xyvChr2XyQY/L2xQthPGI2?=
 =?us-ascii?Q?4tyaMg/YZPY81+6CJGtjkYpXM1GCtY4sMtd9JZTnwTI7OnXixS/bKSuJ9aKi?=
 =?us-ascii?Q?rVX9vDsWo3m5sSLqVzT4ay1NSkcPOWVHO6KVkCqbUjBomQ9ynghvSu9LFWQn?=
 =?us-ascii?Q?SRkyEmXa/uBf6I3SqsbZ3cg5zXU7+1xIlN9k/KJc+TZsxSGjuOToRm8YRUmW?=
 =?us-ascii?Q?dzPhRc/2y3ztK+XiFYoRsc6JxGji1UzBELpKJL95huoi4meeCc8/DB+DAcor?=
 =?us-ascii?Q?GOtvOO6Es9kA1Dc4Qb234MORl6aTNNTdo13LZQ9u0Lv2gQGgWJxDjrvQQKXO?=
 =?us-ascii?Q?KqbKjOdRZjV0uDml4SUQkwDIYBmwB8BTsqTlTn2gdy+whOigEOrfkx22ljtK?=
 =?us-ascii?Q?zJO6lw4QDt+ot+zXZ5uA3VGSFk3A/6mITAEDNYACljrDwY5t+0gBNyUH/Va+?=
 =?us-ascii?Q?ZHmUwuMcjrxPVUNwJ12acSStHEhx6IvqgyEECiSF0DpPnC5/Igo1zEYdjonI?=
 =?us-ascii?Q?H8Sez1ekS201cIz+jotN8PAADptb+M0vkvDo3ogoWPKzL8b2h3KcvB4rxw6r?=
 =?us-ascii?Q?etMc9YCXmTviJZ5xhUU79jYEyJcCapljonVG/wHClzPyEN3fBibXH8YnoN03?=
 =?us-ascii?Q?YG5GQxYvai9p2jxncL8vRyOrVfnun9euRpFIzH++rafxhtMwVMvkxASzkGCk?=
 =?us-ascii?Q?I55DTzteWxEsfJkV5tZBAuXzLcdqQUg1oRQ2wEsQyKILNFUH7+QU+q5PlExF?=
 =?us-ascii?Q?nddWFO/Ic=3D?=
X-Microsoft-Antispam-Message-Info: 5gh8Hd6FLQQURHucz1naYQXG2XbeESRV8xWSk7wm2rnmxMypT6z/cg1voPnHdmz1Tqi28+DMd07vHUwf65lDKUvra0cgU0oa0kxWA8+IBKta0YPNpj0CF1lxERdaZQJySTbJPuwbihppmVuGyJa9HDXDjZLlR2yQXMeKRr5eABciIPDIvHvmPIuqdIdC1OFv
X-Microsoft-Exchange-Diagnostics: 1;CO2PR04MB812;6:B4HOwAABif7wPDUb79f5QAiuVVbNQhqAhN8yoUzSgR1/ehd2HdWOYedasPfmBCb/oPjqf9d1uevJR5YGllLd6Y4cvVrPa2RSlQ+3pG+XPQgyELIi/c+Ql1d2Pstz1fT3AHFtn95gXAtXQtacikBt/J8Y8Df158882ftwwhGD3ufZ0WSSPvdYyVEV2KsYspIbKtgDNWZ3riXFjNHgDBZMQzsMzfNZRV7yuAB1ZFKwkfDgbWo53ggCIZ6aGLkp2zYHYbyWXSVXf4YmTIrgbDDxh4gz7FSFeRSLZZlRuuhVfSbNT6gBCaYlyL/G789ZdLoiDHsj9KAIbgbQtnOJ07BySmDGUNOqenMhENg96d+xLtg=;5:qtiKze7qMJSREkpfMyzCLvYlgrtlISTUH7ftGHzfa5KAmP5IiSHa+9MUpxYylp8+Nb9bAS/0AZC/ARdRnbAVrR1my/8jRsqq4lZcxjDV4hWQBHD17D+m/uP9GTmZQuHYPGh6CQJXMUFXSpUP2UYtAAnXkaf3dmMDKiiGkwOLp1k=;24:+N1yCY+9K0ieinn0IIHFQQkp5nhYx3TF6ciR5d1IF/2ynix4XxPiMPUDNXOelz2Jxo6K6Y4wpY0B20cF0/BBe3iVEzz7YJvQysuWQU1Flvo=;7:g7Mf73UEtG2mVYoCfLALp1l56B1dODC5R6SaY9AVOz3a+vHptoLZ89ecqtWXK/Z3Dhk4C8Yctn3ATH7CLuuUJzzBPPxgJhah+XuyM4kH2dlhS7WrHfJCU7fUe9tvL4acygZqtrfMjf5Dkov324oTgh6PSJa9OhJSgwpr4aE8ie5hmsyc3HR4VecP6ZnUjUNbvZD+V2ISb4HiHz49VWDehCa8cplIt4MsVId9A3bMb6ldde1jsNfHHwSzCjaIWV3P
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 14:04:42.6643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17069514-852f-4711-4599-08d585c6b5e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB812
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When use eMMC as boot device, the eMMC signaling voltage is tied to 1.8v
fixed output voltage, bios can set o2 sd host controller PCI configuration
register 0x308 bit4 to 1 to let driver skip 3.3v signaling voltage and 
direct use 1.8v singling voltage in eMMC initialize process.

Changes: Check PCIe register 0x308 bit 4 and skip eMMC 3.3v initialization
process if it is set to 1.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 555970a..d465751 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -3,6 +3,7 @@
  *
  * Authors: Peter Guo <peter.guo@bayhubtech.com>
  *          Adam Lee <adam.lee@canonical.com>
+ *          Ernest Zhang <ernest.zhang@bayhubtech.com>
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -39,6 +40,7 @@
 #define O2_SD_MISC_CTRL4	0xFC
 #define O2_SD_TUNING_CTRL	0x300
 #define O2_SD_PLL_SETTING	0x304
+#define O2_SD_MISC_SETTING	0x308
 #define O2_SD_CLK_SETTING	0x328
 #define O2_SD_CAP_REG2		0x330
 #define O2_SD_CAP_REG0		0x334
@@ -184,6 +186,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
 	u32 reg;
+	int ret;
 
 	chip = slot->chip;
 	host = slot->host;
@@ -197,6 +200,21 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		if (reg & 0x1)
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
+		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
+			ret = pci_read_config_dword(chip->pdev,
+						    O2_SD_MISC_SETTING, &reg);
+			if (ret)
+				return -EIO;
+			if (reg & (1 << 4)) {
+				pr_info("%s: emmc 1.8v flag is set, force 1.8v signaling voltage\n",
+				     mmc_hostname(host->mmc));
+				host->flags &= ~SDHCI_SIGNALING_330;
+				host->flags |= SDHCI_SIGNALING_180;
+				host->mmc->caps2 |= MMC_CAP2_NO_SD;
+				host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+			}
+		}
+
 		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
 			break;
 		/* set dll watch dog timer */
-- 
2.7.4
