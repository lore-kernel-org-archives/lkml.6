Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeDTQiW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:38:22 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:52592
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752109AbeDTQh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:37:56 -0400
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
Subject: [PATCH V5 1/3] mmc: sdhci: Add support for O2 eMMC HS200 mode
Date: Sat, 21 Apr 2018 00:37:26 +0800
Message-Id: <20180420163726.17036-1-ernest.zhang@bayhubtech.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [59.174.170.68]
X-ClientProxiedBy: HK2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:202:16::22) To BY2PR04MB807.namprd04.prod.outlook.com
 (2a01:111:e400:2c51::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BY2PR04MB807;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR04MB807;3:muqekC9S4dxsB0x1ynLMRiny90+bVaY1zhWl7Mw1/5c24+eW0L4BaOnBx0xfXdNBmYUAEXywQ+F8rJNJKIcatPD1T22rAsATcZJHzQpO/AUNXwVeLtTMWssWYg+sJYsBVZBDr4btdhu3MFDJqiJan91BUHAyxAmqZc0xobUY71btUahwOKDlWx/q7OuZVQti28S4ZAYk7r4o5Jz/46HxIkWvthXUboKDf8oynq8/0/KmJwbLkQZMbwdJMIPJFlxo;25:LQVq53gb7tVxISWm4D1l7KDY0VUd1g/Bs+IdAwgMGw0KSKJYJmrIsVN9Afbcg9oLKikWyBXi7Mk3u8GHM6zJtaA81q7NoFMbQWxNfoBd9++7C9Q0k4mjHUch5J6jJ+L+HU4FS104EVXYnXpXN2BW9rBLy6roC/OEpnGawRU83HY7VZ2pccCsD+64HQVH9/1vvSJ46s2dON8rKli9CgP/j28/t9tDCNgrWV52dZpTjARhOpxYn1J6Yf9ZE8B861yBJ6Wc7ayrRMeEJp24yeUry75amqbPJzk7SdBHoqL+qmvGTEhWIpoY4mWfmPOwUFHb5SL7DUHxN4d7jaBF8ilU4w==;31:Aik2W6qRvQLwYgXS+Imi8X6joi3IOsTBvtSsqnYR6rKNKRIQa71LX1K58SIcOLzPcrh+dErzBeq0vI8SGJI28oGofvX+zj6AtswXNSvFiyKTUD96JiWnlMbYFw0mWfIMMv5u5OIa+lagSEaRc6goXUMm/5In5v4//HiNREaxkGx6yDlVfklijkLeiXifrcjhrJPo1m3VwGmr51+w8DLZxeZf5Jrp+Jnyxj7qXloJBs0=
X-MS-TrafficTypeDiagnostic: BY2PR04MB807:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR04MB807;20:6OlNt+F3FLBcbMnur4DTDVgZcz9N9ozx1iIyxIu1sPAnFGsJNabkWisANMLCcEo7zZP/OWmmQJY3nzt4mQ/w6p3dQG3dlql16wmqFxqaexYv54qNMXGtGZ/L8CF2acF5BZCeKur1SiE4yS8T9SCteqagqqK1CEooyL0H+XR6jYxt1RLuoCsTaamPuMxN1CcE66cm9jiMYCEMRBXH6E8l0faIShtTf8YWZxvMCuzGWX2WMv+V4+jl8346dGzVV/WcHNGHbT8H/YrlHK3e/1qvdghA2ZmbGRTyf7LNmXJCsYhY6/2FRMYRIpblR1KCB1SyVnoC3k8WqdvowcQTaWhrpqIuocztNE5UUyftPqK/HAlOzH6DomDBIfWWRoIB737lKBI2UhD4NKG+ppRVI1LY0Q+IuP+Jj5mFWxIYM7QtR6Q=;4:cuK5brygu2DbNyg+R3hb12vd+F6xcN0Fq5Dt5/JQ2DvPJaX+0PrneGJ2KaW2NSkRo+GXselm73iY3syCaDWDazHZD/rIZ5IjMWypVeHrJt9mogqVyayzp0h1VR1Re9+H5/5giYSCN888SNR8doCB9idr6jfhhnv5GQkV1BCjVK7nbuV34mJoSpnz/RrMYcQikRkNUvv7Z0zwoXgiUdVbUHV4DAuiYEnY+QKwxNfiyYXJDB/YaySunlvwvjaEf9lmHBccfIVwn8oNthCQkVJC6oGcTUJMN0SD0VyK3JmdgGJfe2VgyErPUdURzAgYlAap
X-Microsoft-Antispam-PRVS: <BY2PR04MB807F41C0F2021F67956A7C0E5B40@BY2PR04MB807.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501396)(52105095)(6041310)(20161123558120)(2016111802025)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:BY2PR04MB807;BCL:0;PCL:0;RULEID:;SRVR:BY2PR04MB807;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39380400002)(366004)(16586007)(50226002)(478600001)(2616005)(6486002)(26005)(6512007)(66066001)(1076002)(50466002)(6116002)(81166006)(3846002)(86362001)(476003)(2906002)(107886003)(25786009)(8936002)(6666003)(7736002)(316002)(54906003)(956004)(16526019)(36756003)(186003)(52116002)(305945005)(47776003)(6506007)(59450400001)(53936002)(4326008)(386003)(8676002)(5660300001)(110136005)(48376002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR04MB807;H:localhost.localdomain;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR04MB807;23:55Cibpu34K9gkyiAGyd6VfrLzzcN56+ipJwqejabSn?=
 =?us-ascii?Q?ALXo8wairZSsst5M3hlCXtmSIwnN2cO9VdDkH6Bd652qOPYGu0SGd9ek8W/p?=
 =?us-ascii?Q?bAXGKPs4IU4uqWgOOrSDHgNdCoja+GpTqOjfpjCfUbXj+cSalMI7Rn6Cbbcv?=
 =?us-ascii?Q?TZ63t1gpozuENsyzOpEp70p/pPHeT2KLd3MIxaSWgi+SzgeKNeS/RlTnp6eG?=
 =?us-ascii?Q?zGGljlTjKkPorOz+VDsCAqNPU07lrmzOwlkrg2XivL+jBD20Q+NvQhIJclnH?=
 =?us-ascii?Q?jFZFVmeHUsA0GvjHVeKm8uXqdhhjTyEJixvb9DVW9vnhTbjj3O4FfzSBr5jw?=
 =?us-ascii?Q?wWdrIpiyisxsASEyBv7gmthHKMT84ngce7oJ2Haj8h8tp1r1oQoWMEp7sntr?=
 =?us-ascii?Q?j32jSYvruHgl17grnfbCX4cgGG6Rk0d/cC8fz57yT0jNqR1wjeo19jILv24J?=
 =?us-ascii?Q?fRwKwp97MNB0DnsaugUh2M4rqm/aTom+S3SjrnEt2DyZ3pK/8mSNSpJklp3/?=
 =?us-ascii?Q?n00mMYiFw6cWjZDsy1geehGl/tuGzotyN5is4uTA/RXUxbsKdCM4W+Nz4I9O?=
 =?us-ascii?Q?2P6mORk+L1btAVYgu2Nuwfp8B29FzJ1DlOWR1EKnk0v4HUHvjUcpOQCaJQRd?=
 =?us-ascii?Q?jXZKlZdUSxFuiCebGWgpiH8vVM746ABUvBoiTf/v74G8mCAal6Iv/pmETo90?=
 =?us-ascii?Q?LqV7mVjXXRHZiMt/q/TINpi2qW2LXI0q5n1rOiEx/56tND56v2YrN7Mu25LO?=
 =?us-ascii?Q?xa9fD3rAjbMpDKsRFt5Rh+TsLmnqnkjRqrHXkWJqp5x1Ke78k9iPnMBzISnG?=
 =?us-ascii?Q?xR9Qez9qtwLDhKBQiSrvnsieJOj1Vh4IxWs13LZduWkbHUPl8jJjq1ZtjoDN?=
 =?us-ascii?Q?bbk4BSMTg3FOvXLFeDqyN1+XUyTFHJNS6h/hhlPKdXECHnQ3mKikDicmeHyf?=
 =?us-ascii?Q?Hw8UBAjnB+wf5f+9p+fS/vYLjwuNieA1QUcg2jXeIOY6zWdv6/2maE5Ls4TO?=
 =?us-ascii?Q?Sq0iWhmIHoufAP431RrT9b?=
X-Microsoft-Antispam-Message-Info: gDPQuKN4Pi0OQ0tyH7RqaAqv0sgplP2cRM1Ukojafr4evsS89CQf2NjPxIDC4hlF8zkLGrt/5MZ6Xzn8KY9ChNEYplz7xL7TGAO8MttGdPF8Zo473alHT4zIH4YWcKfmFQ/DPu5ja5KnfBncyemdGeVC1/QEQdeOqLLoRmBJK52QL47iY702pgy31+eKO/vV
X-Microsoft-Exchange-Diagnostics: 1;BY2PR04MB807;6:uh2JHMJBFdqg3efTozwM+iR5W34wqQnPnZ2Nz45foK+og6LCXOfj/XbDmhY3aDsxaK5mY0jDmlpqVpvW/TsuC+ZDY1j/jiKIBEjz7UakhS9bB0xYqInSOhRQHnd9l3dNRbn8u7xbCBkgoMX1NObAJHVxpXw0te+xSKSnauTEjM0n9dbV6VHS55XWME/T/zpHk7Qv3x20L9ML8Az+bkOGX3v9swaq6D+rwmaSIttZRq0RZBhOVvcdoZ6qBXjXnqp59nV5Gg2VptdcWUzkubM/pFRyDUKWjAbO31i1E4uCRBXwbV+wq6iz0X9EWmj6ze/5QDConxV8bKdtnbGhnjXy+r3VeI4ND2h5q7dvGmrx7+PNbEI8rlQYCz69gq+jHORBi+6ZJq+E013CyDZ5dc32ovUnMGCIE9clf+uGMss6YbYvXcWtREQycTKwx/ua2HafL+UOgTqoPkzZ/kcp4HO3iA==;5:D86umgpAjMOD2yuAHRXzR/Zo8hkP8sJRhovO1RbhCABDX0Hg5k5a9pI11kBWKtflbCaqUuVqOl/nuzdY1+RxnR10a8sy39HOB2uPD+Hnh8bdzaPiIKKSH3tpDGvD6DKr75KFuRgdhOjwkFwzpUAXwutQgU8sj914UYUuf7riedo=;24:LU2p+oU99vMKMPzdO9tbKew//HIS8Trauc4t0HNFkYUFWNIcGwafZFegjdgzGr8R0ZUHISb4WmkPOXZrjCCBpSWNXxJ0QA4vgDKoe3XaltA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR04MB807;7:92zDEGBETvVYTUIrjccKjgdzscXJB8EyNskrX+t0mrCpFfIUmuz/QwHul2NpNlR35FgBpVWTERU5NjlEqGhaJy7Ej5IajqTBWEcXDccdRPc7MYR1fP+frhgnQIwHDb7L8j0xNsCW0WGZF3V0peIr2eN4/kqiq6A8WkrOBlnB5LPu/s3La+vQhGqN/m/DrV1wvhMFTGQG/PtfLBpLeBRqVkbanwWcrhHcV73DUD1lTf2uKBnS6xnnsd0fK5w4woGN
X-MS-Office365-Filtering-Correlation-Id: 3917bcc2-60c4-4782-d66f-08d5a6dd1066
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 16:37:51.6888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3917bcc2-60c4-4782-d66f-08d5a6dd1066
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR04MB807
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When use eMMC as boot device, the eMMC signaling voltage is tied to 1.8v
fixed output voltage, bios can set o2 sd host controller PCI configuration
register 0x308 bit4 to 1 to let driver skip 3.3v signaling voltage and
direct use 1.8v singling voltage in eMMC initialize process.

Changes in V5:
	Modify code format to pass checkpatch.pl check and add a summary
	of what has changed in each version.

Changes in V4:
	Skip SDIO and SD initalization when register 0x308 bit 4 is set,
	and modify some typo.

Changes in V3:
	Rebase the patch on the mmc tree 'next' branch.

Changes in V2:
	Modify code format, and delete unused code path.

Changes in V1:
	Check PCIe register 0x308 bit 4 and skip eMMC 3.3v initialization
	process if it is set to 1.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 555970a..ba59db6a 100644
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
+					mmc_hostname(host->mmc));
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
