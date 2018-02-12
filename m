Return-Path: <MNARANI@xilinx.com>
X-Google-Smtp-Source: AH8x224CJcktysfG+AAHz5qbNSB2iC3XlAx1iPlVatCGxlhzsH8PanFBrbkQJvFY6mSxdajYiEYo
ARC-Seal: i=1; a=rsa-sha256; t=1518431722; cv=none;
        d=google.com; s=arc-20160816;
        b=FHsqXyFWCc4L+6tiyVx1fyKWqmlgDj0Q+xACmlJltajZB9ISLkjpWiBBHXqYL2hixf
         8jmemAhJ+Ev7rAeUTMyxrNmvU/0mMFyhFrb51C5fIRifOKDAZzQZYmISRwRvBFwoIFyv
         X15T7nu4V69SBpctkslKac4rVs4lNHvgAJW44ud3SKRTgyCqYEhToe3JLKRzx+qNTAh6
         iuSWQ4tkwG4NXA0EUFBxBqlfWacEUP1ApLA+c2WI6XXBVlqcJqGmJdlYBgx/P4fnXdYO
         fMMfY9ZjCmYZPreCwSY/CYGtJEqF7CmwNMTSF6hLOMUZlNKnIgxKgN9M2r12Xx7DYB1L
         pZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=woy9sLdsRPfnBfczf5IZYiXD1aZlqCI8Bg159tStGJc=;
        b=lveVvmKA/E0IrG0Qlm1mqFVevd8xiC09V6v9EP5FhX8HOx1PpmxH/QZcTxjLJCT2l1
         wDSH63jpksWbsMkjrwx0JvKpdqyxELB07YIYIxp9gdxdqrSagEA768a9MGBSnlfWiGOe
         NMOsZQZBdjXynGLfdd8FERBWwNtHaN1gWx+E2sEUwzML6XgkTv4oqkF9EU2U7xHT1b2u
         waDc39jUkfVKAIPasx+uEFJanC/OWc+n8KbGUzf1saVDGsUtEGDCwQ6K57tMlpI/zc0h
         uLqgS96VktI0gcWIrY6eaagN3yAK4PT5HGxMj7GHvf9a7ZQ2w39ftTHufXlV8wguK0Ql
         lnHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=3+csKPaG;
       spf=pass (google.com: domain of mnarani@xilinx.com designates 104.47.34.43 as permitted sender) smtp.mailfrom=MNARANI@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=3+csKPaG;
       spf=pass (google.com: domain of mnarani@xilinx.com designates 104.47.34.43 as permitted sender) smtp.mailfrom=MNARANI@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Manish Narani <manish.narani@xilinx.com>
To: <michal.simek@xilinx.com>, <dhaval.shah@xilinx.com>,
	<gregkh@linuxfoundation.org>, <tglx@linutronix.de>, <pombredanne@nexb.com>,
	<mnarani@xilinx.com>, <kstewart@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <anirudh@xilinx.com>, <sgoud@xilinx.com>
Subject: [RFC PATCH] soc: zynqmp: Add support for tap delay settings
Date: Mon, 12 Feb 2018 16:05:03 +0530
Message-ID: <1518431703-32649-1-git-send-email-mnarani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(39380400002)(346002)(376002)(396003)(2980300002)(438002)(199004)(189003)(59450400001)(26005)(72206003)(110136005)(54906003)(305945005)(81166006)(478600001)(316002)(42186006)(8746002)(106002)(356003)(8676002)(8936002)(63266004)(81156014)(50226002)(36756003)(52956003)(2906002)(6266002)(6306002)(2201001)(36386004)(90966002)(5890100001)(51416003)(106466001)(336011)(50466002)(48376002)(47776003)(186003)(107886003)(4326008)(103686004)(5660300001)(6666003)(107986001)(2004002)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB3377;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT061;1:d05gwpMhWHkXG6e99AGf3+fj0oWoCA98ASotVL6PgagR14jpRc9c/o/SnnG1xsOdaUREH7AEezqO35LLMR1s6/YelLhWuVtzW0GINvtjP85grjCCsrxxB3dDtLXfPU7i
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f850ad6-a3a2-46c2-7ca4-08d5720450f6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:BN6PR02MB3377;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3377;3:D15gEaA/Iq5JiAy4t2zfwbmFIvEYFl7oNAqjlPg6WU27+BRXuGw4k0VHrLn9wYLSo3MLKmy9QI+x2v9MZCWR9/maCi8wBbXMtdcY5usFP0kTKMpcHevAnz2ki4COK+lLI8a+SewpNG/6o1pWpGmQrLHhL66PRQWT1YnYkvfTneywiueCVgZ0P+ZMBEu+z/dmx3JWPw1JbVdF9fm30gYeWMT+gLf771oj/mCyvJ1UQRsJwKeG6uu08/9GZhUMgUgSSjt/pAF4GiEJZt3A3Vfh4GLtqYx4WjUN8z2jROKChXLlSAnNFth3QnDqDubJl8UG1kf6mY0FL3ExelC4h4UjGM4b5OBLLztibgUJ2EProoo=;25:Le61gDT0tc7h2Uzz2tdtKN5XjOnPrO3DF/0H4KeHOAKTXlAhggqCs7Wo4YRw9JT89xIlGKrU3dyjB2p2u7I7645KEpDU89+yZjgPaOCRZvA0SaZCoKryzj3befdi2JcLDU2Wk7B9i03lDSeiV68Hds190pNpeWiOtZGXEdardYHpwy7tTQT98VhnBuLKS8rbxgo/xBQL9yJjdrwCPGqU6XHvM8CRFykMGDR+XFOESf2khJQ5u47QfTmyAMpZGczbQCRrqgjCXQNCfEwkKu+XPFGGU670X26ue4l5yAWwDGBo0gjD4Nkz2PAVnTXlrkj+PNe3xMCQcH5SMSRDCg8+ng==
X-MS-TrafficTypeDiagnostic: BN6PR02MB3377:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3377;31:4bXQY6AwdOXWhUBrNAtMaqvrXWSQIqnl7pHbVHfz0RBTr//GbJvr0ssal00hqOG1MOhSrrRPRXixDJxAKl35tahZT85t8y/4N6v7QzWxsYM2nIMEVyzhIVBNRaYRNQthj2nRAdKEX4Bq38OebSX7IG4VR3UQ3XhnXp7TN6LHuxk36YxzT8aO6GD15Mf784oRPVSy66XhBamHM/ZjGSxaQnCoMEL49QEhjQtMsCgYObE=;20:FSQVHLm4TV2/q1gvSQBNlkxGQxlD8hwWKI3vmipK+vSJ1Der/3cCWAmmmMNjLAG9WNXJQ6RkFePi+Yz00LlTqLe8nvC5rWyyuI8BmVCLsXPuIYdA16AJi+yb5yI2WE0wyb1oDmf7WnsDw0YaQ+3dwyuEiHl5oYXAWr1V2B1s9bs15fe7MbWfFGFelSNg70oUn49UdhJRxvWqFeeIwXN3Ka/i4vOPFVhu1BBNWlB3zDwkdV6ZF5QHFD+9Mg90wkitgg9e0Mp1Ti2usLfzUAkXqibOiy1E1O3P/dEWx024vnCahrLHPM0XXK/Cm6u9IHx6qm1nfCW01G+ShJnUFtXQ3dppigQh+bqWJRQ1PZEz81AR0MJcVRfSviWymVmVYgxz4JBN55587KEaj6UGfbVLTlJQecdjureHqRda/o3jLs/H9D/l9gUd+W0wk0JpLHwG1MQewYW1UU5M6OM2KMxPkSx/CY7yCkyjSIzUBZ9FM/KfwasQOx4TqhNdvHmN9IRN
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB33777D47149131B52EED0B02C1F70@BN6PR02MB3377.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030)(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR02MB3377;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB3377;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3377;4:0XjcPchbi7NAFayWyTGNpdVeUQeYnwEliMcHV1+ZKumoa8Plz4t9NrIq/nFGUDOgdNVExaLK6O79dsrQWHBXE5uOtUX1W4BrTA1snuYOqSL8R3fi6JV86gS/bQl7HAlIrcUu+wYiOfWMnoRAy5cQJ2gXohMpb+exmAdzp2QIsICtva8USmPIi+BZV5obidDT9jZkEzAF7Kja8rd6xlGXszr74SCEQWxBs+hVq0s9XjPxgUj+6Igjbfych2u0cMvrv8HthnOquVd7VQX2GvlzF13NDdX8W+iHBaBz7S99F+H1Ia489HWr/zWSzdZbZF0kRGUE0++jmWcPdGmtiv2JhYf6whqSn1hf+mhnXXz3Vc7IsDZzvPcIWTxTpuFi5/hu
X-Forefront-PRVS: 0581B5AB35
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB3377;23:fBWcgLI7dHFnVJhALKiUFlqtw5/EcqRqKqn29/S3I?=
 =?us-ascii?Q?XSChABnpVJQN93AyXcKU/66tpFWrJ3eb+9Ra4U6YklesG07iGAOSlyMOIoXv?=
 =?us-ascii?Q?VlYovHfP/MvRvBVAvVn/qckZG2fwgs0LaxxlRwmV+rAKTHUu9gPKhurBPnCz?=
 =?us-ascii?Q?9v4N02OkKpKUJAslNbj3skjv6tWwulKimi6hebvA7K41JknyHElwS8iTIQgF?=
 =?us-ascii?Q?tA3jPJDuUi2SJbXX050nI7bn997yN4miBGw92VL9iw6VxbhogC1V5/3xZXw4?=
 =?us-ascii?Q?JGCt34I5EzgqbnCJVsAD0liV5T301qeWbjPKGdiTNKXnZWufcbxzzGOemWCx?=
 =?us-ascii?Q?poD0BZshHIgnjwQSAlM7EmOcx4z7peAfcUf8EmyPHmHom4LHAxcS3gD95YKb?=
 =?us-ascii?Q?INWFGPkRxyoexV1eXzzK8+SFB0dtxRWyu225ZzYjFIvxDzgV+yWnTMbG4gsf?=
 =?us-ascii?Q?D/7S/E3G/23n5SX1DBggLq/gHUQ1D3IUmcGW02k2/86p424jy2vmizYguk1b?=
 =?us-ascii?Q?bc3BfXs52Cm306eMBhbDdfAVFfLWJ4LDxPK1Ay94MdJWrGa/9evswE+bi0Rk?=
 =?us-ascii?Q?dZ60tqHxZmQknZsrkfKEf/8sjF7epsDMeNggQ/g4kiUsfuEkkYxx+/9A9pCR?=
 =?us-ascii?Q?UCEXTwvD6Pn3Z1RJllkZcHpip89Vp3gcbUkGgDItsg1HmtHCR9ttLASyGnaI?=
 =?us-ascii?Q?Wt8CD/kAJmPtRXUTFLs1dgG/KrWpMtN+cSS1a25SYAaTalXJmLp0ywWDOUS2?=
 =?us-ascii?Q?aeeixTjgLTXk/OjUBG8QocFE1gKAd//mbgqLTqYsIrAGxv13uiJHF2xAp2rK?=
 =?us-ascii?Q?5qrwndyApN2elH5GocWqtbdxGA15CO9xEwxXtOV9I/8YM/mdqElDQmvUGivW?=
 =?us-ascii?Q?iYsh1AunvEr4ZMIQiNY2HRMun2aztKfxHBt7BBzLj/N0IBWABgQKVlOt0OQs?=
 =?us-ascii?Q?nmurnWpQPl3FW4F4XRyDFI2LTKSI9Gf2u53qFSniHjf02xL/jwfQ1bI1PuyB?=
 =?us-ascii?Q?WX59636yYXoi7DmsRa2zqAeyWW8Gp0zjAP23esl7dWxOjxtRlOq0eLve/ayk?=
 =?us-ascii?Q?L3qsGVPGKe2PU9fYUvRBtLOxq73h0Uabb9O6lM5VIjdlhyBTBBuQlTBR3zCg?=
 =?us-ascii?Q?E1PwOmi/L5S0q3ffU2FiU932S6SvbxJFsomvx2xvE/VQ7PXhB/+aA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB3377;6:HW5xWZWqz0lO5IWjenEzE6Lq8lZzVlnV/IPgEYdXlapRnhdN0iW87nV9MTl9WpnvSpIgeBtAsu7fuKZeF6fMcoFNbwnjT9L5s4wyQiWnY94/xC+uf/Tu/a9MM6qZsVJ5vGLaapgJkulXY2++5czzksrg9OjEiwIFM6tSQsfTDANLRoZQSqo8os8B7HMs3SgNB25TGqU03Hl4DgwzL1wWY5H5JnAoQAdC4HQC3D3saCXjjBLnKYLxwNZLKeBIA1icL7savc5FOWHXtDSd6ePArbc7jPZqhOqOxnaibBCZCh4Eb3/iqpS0oM1KuF9wqhyWzXMsXKR84rx/pdd2QQa2CW+2VAu3vPRiPUZIs3VB8EE=;5:oIN5OoBHQa0SKahgEm9cEgw75tJ4wHA9PQ76/Ik5S+lpeb/pNmrs9zS8R4QMPmCn8BmoZI5hVxpVL3dWK707Oh0+mYOLtrU4IhO3xQc1h8+70ZpE916ABy5eaIkJlR8wclWdRuQNtACHhnlJ8rEtqqD5kyPq5sblyzOrff5noy0=;24:YZuRa/M0SQbGcDWe6Ag5+0TNkTEz+wW+3rbBl/8ory315ULtw4iIsFeyiF5Z0i396AHpV8BLiBlQUXPhepnoycQhqhAstqGC7st3V1gQkZk=;7:MjBcg+2FypgQfnImhi/4RTUynEbC43Ixgj2McfuNXlNIZRtmJ7KlIhJtQVre5ufXErtDIKqE1XWokGGvpRLnIlQD6qxEPDfcEzxohcTHFarcskV1ggai3Jy4scLvSY/1iJmhlwmSlKB+87ohhfS5jqZJNcBHWsljtcngeEMTMiblM6E3Da42XdQUZtAzZ76kO4zVMpyH6qo7ZSpmF2EZTZ6quIQZTr3e+YZZHX5SMZkYQXS8iRPISFdBtCPCqtsK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 10:35:20.1716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f850ad6-a3a2-46c2-7ca4-08d5720450f6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3377
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592191062183184575?=
X-GMAIL-MSGID: =?utf-8?q?1592191062183184575?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch add support for tep delays programming for zynqmp platform.
This also adds dll reset support.

Signed-off-by: Manish Narani <mnarani@xilinx.com>
---
 drivers/soc/xilinx/Kconfig                   |   6 +-
 drivers/soc/xilinx/Makefile                  |   2 +
 drivers/soc/xilinx/zynqmp/Makefile           |   4 +
 drivers/soc/xilinx/zynqmp/tap_delays.c       | 270 +++++++++++++++++++++++=
++++
 include/linux/soc/xilinx/zynqmp/tap_delays.h |  31 +++
 5 files changed, 312 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/xilinx/zynqmp/Makefile
 create mode 100644 drivers/soc/xilinx/zynqmp/tap_delays.c
 create mode 100644 include/linux/soc/xilinx/zynqmp/tap_delays.h

diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 687c8f3..aa49859 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -1,4 +1,8 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0+
+# Kconfig for Xilinx firmwares
+
+source "drivers/firmware/xilinx/zynqmp/Kconfig"
+
 menu "Xilinx SoC drivers"

 config XILINX_VCU
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index dee8fd5..5440b34 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)       +=3D xlnx_vcu.o
+
+obj-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp/
diff --git a/drivers/soc/xilinx/zynqmp/Makefile b/drivers/soc/xilinx/zynqmp=
/Makefile
new file mode 100644
index 0000000..b33b031
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile for Xilinx zynqmp SoC
+
+obj-$(CONFIG_ARCH_ZYNQMP) +=3D tap_delays.o
diff --git a/drivers/soc/xilinx/zynqmp/tap_delays.c b/drivers/soc/xilinx/zy=
nqmp/tap_delays.c
new file mode 100644
index 0000000..d74fc6f
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp/tap_delays.c
@@ -0,0 +1,270 @@
+/*
+ * Xilinx Zynq MPSoC Tap Delay Programming
+ *
+ *  Copyright (C) 2016 Xilinx, Inc.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <linux/soc/xilinx/zynqmp/tap_delays.h>
+
+#define SD0_ITAPDLYSEL_HSD             0x15
+#define SD0_ITAPDLYSEL_SD_DDR50                0x3D
+#define SD0_ITAPDLYSEL_MMC_DDR50       0x12
+#define SD1_ITAPDLYSEL_HSD             0x15
+#define SD1_ITAPDLYSEL_SD_DDR50                0x3D
+#define SD1_ITAPDLYSEL_MMC_DDR50       0x12
+
+#define SD0_OTAPDLYSEL_MMC_HSD         0x06
+#define SD0_OTAPDLYSEL_SD_HSD          0x05
+#define SD0_OTAPDLYSEL_SDR50           0x03
+#define SD0_OTAPDLYSEL_SDR104_B0       0x03
+#define SD0_OTAPDLYSEL_SDR104_B2       0x02
+#define SD0_OTAPDLYSEL_SD_DDR50                0x04
+#define SD0_OTAPDLYSEL_MMC_DDR50       0x06
+#define SD1_OTAPDLYSEL_MMC_HSD         0x06
+#define SD1_OTAPDLYSEL_SD_HSD          0x05
+#define SD1_OTAPDLYSEL_SDR50           0x03
+#define SD1_OTAPDLYSEL_SDR104_B0       0x03
+#define SD1_OTAPDLYSEL_SDR104_B2       0x02
+#define SD1_OTAPDLYSEL_SD_DDR50                0x04
+#define SD1_OTAPDLYSEL_MMC_DDR50       0x06
+
+#define MMC_BANK2              0x2
+
+#define MMC_TIMING_MMC_HS       1
+#define MMC_TIMING_SD_HS        2
+#define MMC_TIMING_UHS_SDR25    4
+#define MMC_TIMING_UHS_SDR50    5
+#define MMC_TIMING_UHS_SDR104   6
+#define MMC_TIMING_UHS_DDR50    7
+#define MMC_TIMING_MMC_DDR52    8
+#define MMC_TIMING_MMC_HS200    9
+
+/**
+ * arasan_zynqmp_tap_sdr104 - Program the tap delys for HS and SDR25 modes=
.
+ * @deviceid:          Unique Id of device
+ * @timing:            timing specification used
+ * @bank:              MIO bank for SDIO
+ */
+static void arasan_zynqmp_tap_hs(u8 deviceid, u8 timing, u8 bank)
+{
+       const struct zynqmp_eemi_ops *eemi_ops =3D get_eemi_ops();
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return;
+
+       if (deviceid =3D=3D 0) {
+               eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                              PM_TAPDELAY_INPUT, SD0_ITAPDLYSEL_HSD, NULL)=
;
+               if (timing =3D=3D MMC_TIMING_MMC_HS)
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD0_OTAPDLYSEL_MMC_HSD,
+                                      NULL);
+               else
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD0_OTAPDLYSEL_SD_HSD,
+                                      NULL);
+       } else {
+               eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                              PM_TAPDELAY_INPUT, SD1_ITAPDLYSEL_HSD, NULL)=
;
+               if (timing =3D=3D MMC_TIMING_MMC_HS)
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD1_OTAPDLYSEL_MMC_HSD,
+                                      NULL);
+               else
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD1_OTAPDLYSEL_SD_HSD,
+                                      NULL);
+       }
+}
+
+/**
+ * arasan_zynqmp_tap_ddr50 - Program the tap delys for DDR50 and DDR52 mod=
es.
+ * @deviceid:          Unique Id of device
+ * @timing:            timing specification used
+ * @bank:              MIO bank for SDIO
+ */
+static void arasan_zynqmp_tap_ddr50(u8 deviceid, u8 timing, u8 bank)
+{
+       const struct zynqmp_eemi_ops *eemi_ops =3D get_eemi_ops();
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return;
+
+       if (deviceid =3D=3D 0) {
+               if (timing =3D=3D MMC_TIMING_UHS_DDR50) {
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_INPUT,
+                                      SD0_ITAPDLYSEL_SD_DDR50,
+                                      NULL);
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD0_OTAPDLYSEL_SD_DDR50,
+                                      NULL);
+               } else {
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_INPUT,
+                                      SD0_ITAPDLYSEL_MMC_DDR50,
+                                      NULL);
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD0_OTAPDLYSEL_MMC_DDR50,
+                                      NULL);
+               }
+       } else {
+               if (timing =3D=3D MMC_TIMING_UHS_DDR50) {
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_INPUT,
+                                      SD1_ITAPDLYSEL_SD_DDR50,
+                                      NULL);
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD1_OTAPDLYSEL_SD_DDR50,
+                                      NULL);
+               } else {
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_INPUT,
+                                      SD1_ITAPDLYSEL_MMC_DDR50,
+                                      NULL);
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD1_OTAPDLYSEL_MMC_DDR50,
+                                      NULL);
+               }
+       }
+}
+
+/**
+ * arasan_zynqmp_tap_sdr50 - Program the tap delys for SDR50 mode.
+ * @deviceid:          Unique Id of device
+ * @timing:            timing specification used
+ * @bank:              MIO bank for SDIO
+ */
+static void arasan_zynqmp_tap_sdr50(u8 deviceid, u8 timing, u8 bank)
+{
+       const struct zynqmp_eemi_ops *eemi_ops =3D get_eemi_ops();
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return;
+
+       if (deviceid =3D=3D 0) {
+               eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                              PM_TAPDELAY_OUTPUT,
+                              SD0_OTAPDLYSEL_SDR50,
+                              NULL);
+       } else {
+               /* Program OTAP */
+               eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                              PM_TAPDELAY_OUTPUT,
+                              SD1_OTAPDLYSEL_SDR50,
+                              NULL);
+       }
+}
+
+/**
+ * arasan_zynqmp_tap_sdr104 - Program the tap delys for SDR104 and HS200 m=
odes.
+ * @deviceid:          Unique Id of device
+ * @timing:            timing specification used
+ * @bank:              MIO bank for SDIO
+ */
+static void arasan_zynqmp_tap_sdr104(u8 deviceid, u8 timing, u8 bank)
+{
+       const struct zynqmp_eemi_ops *eemi_ops =3D get_eemi_ops();
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return;
+
+       if (deviceid =3D=3D 0) {
+               /* Program OTAP */
+               if (bank =3D=3D MMC_BANK2)
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD0_OTAPDLYSEL_SDR104_B2,
+                                      NULL);
+               else
+                       eemi_ops->ioctl(NODE_SD_0, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD0_OTAPDLYSEL_SDR104_B0,
+                                      NULL);
+       } else {
+               /* Program OTAP */
+               if (bank =3D=3D MMC_BANK2)
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD1_OTAPDLYSEL_SDR104_B2,
+                                      NULL);
+               else
+                       eemi_ops->ioctl(NODE_SD_1, IOCTL_SET_SD_TAPDELAY,
+                                      PM_TAPDELAY_OUTPUT,
+                                      SD1_OTAPDLYSEL_SDR104_B0,
+                                      NULL);
+       }
+}
+
+/**
+ * arasan_zynqmp_set_tap_delay - Program the tap delys based on the mmc ti=
ming.
+ * @deviceid:          Unique Id of device
+ * @timing:            Timing specification used
+ * @bank:              MIO bank for SDIO
+ */
+void arasan_zynqmp_set_tap_delay(u8 deviceid, u8 timing, u8 bank)
+{
+       switch (timing) {
+       case MMC_TIMING_SD_HS:
+       case MMC_TIMING_MMC_HS:
+       case MMC_TIMING_UHS_SDR25:
+               arasan_zynqmp_tap_hs(deviceid, timing, bank);
+               break;
+       case MMC_TIMING_UHS_SDR50:
+               arasan_zynqmp_tap_sdr50(deviceid, timing, bank);
+               break;
+       case MMC_TIMING_UHS_SDR104:
+       case MMC_TIMING_MMC_HS200:
+               arasan_zynqmp_tap_sdr104(deviceid, timing, bank);
+               break;
+       case MMC_TIMING_UHS_DDR50:
+       case MMC_TIMING_MMC_DDR52:
+               arasan_zynqmp_tap_ddr50(deviceid, timing, bank);
+               break;
+       }
+}
+EXPORT_SYMBOL_GPL(arasan_zynqmp_set_tap_delay);
+
+/**
+ * arasan_zynqmp_dll_reset - Issue the DLL reset.
+ * @deviceid:          Unique Id of device
+ */
+void zynqmp_dll_reset(u8 deviceid)
+{
+       const struct zynqmp_eemi_ops *eemi_ops =3D get_eemi_ops();
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return;
+
+       /* Issue DLL Reset */
+       if (deviceid =3D=3D 0)
+               eemi_ops->ioctl(NODE_SD_0, IOCTL_SD_DLL_RESET,
+                              PM_DLL_RESET_PULSE, 0, NULL);
+       else
+               eemi_ops->ioctl(NODE_SD_1, IOCTL_SD_DLL_RESET,
+                              PM_DLL_RESET_PULSE, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_dll_reset);
diff --git a/include/linux/soc/xilinx/zynqmp/tap_delays.h b/include/linux/s=
oc/xilinx/zynqmp/tap_delays.h
new file mode 100644
index 0000000..6eb7328
--- /dev/null
+++ b/include/linux/soc/xilinx/zynqmp/tap_delays.h
@@ -0,0 +1,31 @@
+/*
+ * Xilinx Zynq MPSoC Power Management
+ *
+ *  Copyright (C) 2016 Xilinx
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+
+#ifdef CONFIG_ARCH_ZYNQMP
+/* API for programming the tap delays */
+void arasan_zynqmp_set_tap_delay(u8 deviceid, u8 timing, u8 bank);
+
+/* API to reset the DLL */
+void zynqmp_dll_reset(u8 deviceid);
+#else
+inline void arasan_zynqmp_set_tap_delay(u8 deviceid, u8 timing, u8 bank) {=
}
+inline void zynqmp_dll_reset(u8 deviceid) {}
+#endif
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
