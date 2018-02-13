Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965417AbeBMR4P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:56:15 -0500
Received: from mail-cys01nam02on0064.outbound.protection.outlook.com ([104.47.37.64]:8169
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965217AbeBMRzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:55:46 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Daniel Baluta <daniel.baluta@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <andy.shevchenko@gmail.com>,
        <fabio.estevam@nxp.com>, <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <wakasugi.jb@om.asahi-kasei.co.jp>,
        <shengjiu.wang@nxp.com>, <daniel.baluta@nxp.com>,
        <mihai.serban@gmail.com>, <cosmin.samoila@nxp.com>,
        <linux-imx@nxp.com>, <daniel.baluta@gmail.com>,
        Mihai Serban <mihai.serban@nxp.com>
Subject: [PATCH v4 1/2] ASoC: codecs: Add support for AK5558 ADC driver
Date: Tue, 13 Feb 2018 16:29:33 +0200
Message-ID: <1518532174-11350-2-git-send-email-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518532174-11350-1-git-send-email-daniel.baluta@nxp.com>
References: <1518532174-11350-1-git-send-email-daniel.baluta@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630181437261250;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(346002)(396003)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(305945005)(53936002)(2201001)(956003)(2906002)(26005)(86362001)(336011)(16586007)(51416003)(316002)(47776003)(54906003)(110136005)(48376002)(4326008)(6306002)(50466002)(450100002)(8676002)(81156014)(81166006)(97736004)(36756003)(50226002)(8936002)(498600001)(26826003)(966005)(76176011)(2950100002)(6666003)(68736007)(105606002)(356003)(104016004)(106466001)(5660300001)(59450400001)(85426001)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB479;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD028;1:G0lM2uRJjIpw8uInNDf2JfRzcqb9tV4Pons3In9yTwpxEhOOGzc7gzwyrBqP2SjviKc0N5c/c4zOXkNBXzHMjhJoyryNyIcwfz28SXhJ42VUUH/13IFdyh74Nq4ChDNP
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9f6d8c2-376b-4f59-6461-08d5730b00be
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:DM2PR03MB479;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB479;3:Dmn4/ohaJuS79DMLchRjkOg2QmxTB8omMB9u9R42E2OgDHb+LDO2YAqQvD+oL8wlA7B/pchjDYIOTPsUvCH6mSV210z2egJgtJ7WDRiBLt5wZQ924b72KTmDEBHHBUIyExtmubj5w8pDVjZCksvqMlglnlY+QK4VEPfQRRdD7Xxef+r2Yyx3/ZzDeGudP6R6qIQ9wCDOiMcGZpTpq8cZTJjKeqD8hPODxu/hDN4OzjrjIUR9jnsWX0eWdmceR/y1C/bFvKMFedAf49ea1m5j+6HCmdh7n/IejeQXFUzqyf4QxPg5JhFOeMTsfyJza/APuuFIjCHVBGTOS4S9d1eIva2MRP+l8/Bx+X9IjLVq0iM=;25:oc0VN032zBs4q/Uhb28sOPNCtESEi5aAx7yjGpDkT2P5j3+yk/imfClDUw7m3j/ry0Sx25mNxNiTnU3tIW8LvwIvaZYiTkUs8jqqrybfuRHwRM/yylejWOUDuKDNQsAx1W6bxqKbPOPyFWqMu2rbdnJScf+7BRZYgi+0ulr1FmyfCvFzqZl1+UbLOWwBO6AQ/mO4FdgYBg+edDVa5Ac/+w5Yi+pyHISLu745f4rkv6IIW5Hnue+D8Y4dBnBqmMuajfRLf9z96yqHORqNa+TU4dkSeu3Sq/0358xlIqNZlCqMlDY+mfrYDTSQ8SwHQTnlA1+NueVXkHzJOkm5uHgmiA==
X-MS-TrafficTypeDiagnostic: DM2PR03MB479:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB479;31:kEMKbbq+xAgEy7hZ0WgOHX1JgKS2qAbTljDI+nWb3kYXu8Cfh1KhU0nUoWKaxqdPPqFZ/XeA81Id/NNBSlzgtlkDZ8wjFRgOJN9Jz2vFpLg5YbfN/3pl8LFK+itqDgGE+5huyG5LzxpFVFw0btNEh7pYx3sxZJuzzvZRiDcDxFE2BM4TUfHEYnadxAn01cnNQqzCFI+y6h3YW/DprwlsVx7tcQIylkg9xhyxtssQsjM=;4:FZLnh9vahtvuDO4rXVg0omjZFXrqz8Mx/V0OzWj6kKBlUtyDvbRA0dSf6Gl4X/RuqyFOT28FWYJ0sursjdqI81PqQnseg077SO3Evnmje1Gxk8lgSkm3DnbI58qECUmZftm6mstbdZUkoI7uB3KotpWJDCFNKFIi7lsGbUg9jpqutfpvcP+kTgF+n9814tV0ajw8cwvni3hW63HBIBfS1r3Cg3hFT1oSEu9vujzXrweC3gUyglCtRtxGtvxMPf8o6ciVtRRsMoAHYpwGB3Egu/cJ8Z7NEmfonwuXwhd2cvP6C3BICf4bUR3aDBJDVQuwhqFN249GmxJuNKcBERO9pw==
X-Microsoft-Antispam-PRVS: <DM2PR03MB4799BAFF368C6DE7A5C69F4F9F60@DM2PR03MB479.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(6055026)(6096035)(20161123559100)(20161123561025)(20161123556025)(20161123565025)(20161123563025)(201703131430075)(201703131433075)(201703131448075)(201703151042153)(201708071742011);SRVR:DM2PR03MB479;BCL:0;PCL:0;RULEID:(400006);SRVR:DM2PR03MB479;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB479;23:7c1AyaDSVL0IVAnDlv4lKAZMu4F7VssoB5cCmJAACp?=
 =?us-ascii?Q?CVvfF5OOrDWuiW6YRioKR70nnjLBudX5sXA6w6967Yo1Kqy4MrIbbxUAXQst?=
 =?us-ascii?Q?mn62xzC7DK4XiwHVeiNhICjMF4fM7599cZyYetU7umDscOQXUQKkXrLSMfQJ?=
 =?us-ascii?Q?iLjrwUNnozgbyOOYG4sAVvSZYF1A6WzUe7HemVXD8EnoD5qNppyyCKN/Q/yW?=
 =?us-ascii?Q?cGrH8Ae5n6DCH4rol4fF41Qv9vbqJMTs1f7Qd5IUrC8Hr6AV5hJqccxaTW5O?=
 =?us-ascii?Q?BcXMmYsTJghjWAwnNEzGb6TW4xyH0LBp+Xq2kZvBTbWgr8GbOl6eON7k7P9U?=
 =?us-ascii?Q?EPsgr3QYSUZqXoyNbd2nsnrMYB4xFv7JS+247OXbFKvrRT1QpecgLegdF/lc?=
 =?us-ascii?Q?5d9lHgUL3CgZhiPG1DPn4vf7qoJ8/6kLA5KAW81qlh7P5zUjjbFCmvejQqV2?=
 =?us-ascii?Q?leHvQaphfoJ3ir7+ClQwXrE/EE2FD9Rvm9D4xFnXAloKgN5NUk7Uu+3NP74L?=
 =?us-ascii?Q?gFjJV+WfD/4jpdxoZmf4vlJnVdSntl4kremMByephAQnxG8bLaQRfBMyXyzU?=
 =?us-ascii?Q?tz2hH5fmhRPu+DYkHh7uBmDZYH5L7bljIfjf0kPQTd/dD6VkdhkAdUvR2Tv0?=
 =?us-ascii?Q?w3Bv6AjWbdLrhlDtJ83Y3riuhW+oSqWHUXCZBGs4AWGXaKjkuPDiZXcLtOED?=
 =?us-ascii?Q?MTtLwGoZchox7zo8klLwj5T9foU9qxwmHU9C8s93d7VNJQM14vJhDJ38zy8J?=
 =?us-ascii?Q?u9Dnk74f34EPIQukUp7yk457JsT32cEWzGJ1gK5i1+svMuChOarR4DtlZxR+?=
 =?us-ascii?Q?rP36QrEr9cPZR2ijgraYDxIZQ+xHS+OIY4vTGgfRogR6Ie1CDBmD4MRZiBuU?=
 =?us-ascii?Q?1Vz1cMm2Lor7Yww1qH+HPbN3Fp5R55kT8CgBpY8iqS8m53nZw6InwY916OAo?=
 =?us-ascii?Q?Q887n8btF6IA1gN9jwOoHPa+Ouvv15JHEW3N2twiWH3J9ZGTtKF/YBadlttN?=
 =?us-ascii?Q?eIEVnnpVMd1R0iiEvy6A0S7cUFQnSM5KfpxTNubj6gnB+zQGDmJu3uWhV+56?=
 =?us-ascii?Q?mGANv0/oW8TqTu3hWI9gFXTsqPLKyGJYpXW2NhHFeooJzBfqmGnEBcDeW2M+?=
 =?us-ascii?Q?Fi1TmYnvtC/bax8j9dEU5tksvG3rBcQ7uikelabdexFD0NLfNZfjeGxubBX/?=
 =?us-ascii?Q?CG++532SnqJqIo8y/KD20xSbJ2IWcYflX9?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB479;6:CWTCiCukaNq+N/utnnvDnGzOWk8zwcZBBICD3eKTJMbokubUUiUL06CPYirvl7Jng46jKc+sMYVvaAvqkQY5McvbNaLPLkevIoASz7RuDxf3OZFV2M539ha8hebFht73rK6D0CB5TkrO1thJXHWOZp2zB9wJH+nYOHzqqpKV+r3GQ2fTwM7Ekx5T4Udl78nIaprXOiuSVDNxn94S/zxSZ67ideRiUWJgRm1qYHLLz/+sZgnDh4gXNi+NQCvQLVUDY5tqfvGJqTuLtGGmdddyWGy68atUSKetRRseZacbHYKw3VKe2Fj2ODS/TE8N1NZI/UP/nabctCyI9aUzkK+gQClSYQR72qUNcxEFTBPHUcw=;5:tC7iaLICwzgeF6JavNkcuREKRRe+kLOu5RZNOFxS8UAwiczgf3JQITMKGtqcIB4+Uzc6FRcUdFkbqJUSRRn5deS3uB2LMZiuKSL8GKLgelw9AwS9TWwc5d7Cz9CRpRZS//j4Fe34i8v6TvSIJKr8D071wRztEtidypWrylAtfHw=;24:6WHi8q/Airz6sZgqaPKtTaU+zLWc6brHYUdVwz4NAcsgm4yDAfqCmDvxoxK8s7t4l0VqIFBSCrBSI0OxWknHp1YxxgxdqT1GSIpjwgpX39c=;7:HnzAj0wLbYjE1jNlmb+eGPsQOn2BSeclg8dwH45Lzme4Xj1jyY7ZmHDKzH3A3foK8dPQhvRRmj9FTqXMLG3TkkEA5qtD/5VDEIP3jfXM4TyjXWKoaWOZNIqYUVBqwnDxV3ed7HcV/+AAFg96iXSU2jUdZ1tpu4pRv5asPOOD2iH9r6b8UikX9mkAM91nS3WIch0HjjIdm0xpwhg2fw6/8BGXLn5lR1rwDTRTvTWdCy1tWsvVUI0PzzGEX8ABNiCU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 17:55:43.3673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f6d8c2-376b-4f59-6461-08d5730b00be
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB479
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AK5558 is a 32-bit, 768 kHZ sampling, differential input ADC
for digital audio systems.

Datasheet is available at:

https://www.akm.com/akm/en/file/datasheet/AK5558VN.pdf

Initial patch includes support for normal and TDM modes.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
[initial coding for 3.18 kernel]
Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
[cleanups and porting to 4.9 kernel]
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
[tdm support]
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
[pm support, cleanups and porting to latest kernel]
---
 sound/soc/codecs/Kconfig  |   6 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/ak5558.c | 417 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ak5558.h |  52 ++++++
 4 files changed, 477 insertions(+)
 create mode 100644 sound/soc/codecs/ak5558.c
 create mode 100644 sound/soc/codecs/ak5558.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2b331f7..c29728c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -42,6 +42,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AK4642 if I2C
 	select SND_SOC_AK4671 if I2C
 	select SND_SOC_AK5386
+	select SND_SOC_AK5558 if I2C
 	select SND_SOC_ALC5623 if I2C
 	select SND_SOC_ALC5632 if I2C
 	select SND_SOC_BT_SCO
@@ -398,6 +399,11 @@ config SND_SOC_AK4671
 config SND_SOC_AK5386
 	tristate "AKM AK5638 CODEC"
 
+config SND_SOC_AK5558
+	tristate "AKM AK5558 CODEC"
+	depends on I2C
+	select REGMAP_I2C
+
 config SND_SOC_ALC5623
        tristate "Realtek ALC5623 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index da15713..3e71d40 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -34,6 +34,7 @@ snd-soc-ak4641-objs := ak4641.o
 snd-soc-ak4642-objs := ak4642.o
 snd-soc-ak4671-objs := ak4671.o
 snd-soc-ak5386-objs := ak5386.o
+snd-soc-ak5558-objs := ak5558.o
 snd-soc-arizona-objs := arizona.o
 snd-soc-bt-sco-objs := bt-sco.o
 snd-soc-cq93vc-objs := cq93vc.o
@@ -277,6 +278,7 @@ obj-$(CONFIG_SND_SOC_AK4641)	+= snd-soc-ak4641.o
 obj-$(CONFIG_SND_SOC_AK4642)	+= snd-soc-ak4642.o
 obj-$(CONFIG_SND_SOC_AK4671)	+= snd-soc-ak4671.o
 obj-$(CONFIG_SND_SOC_AK5386)	+= snd-soc-ak5386.o
+obj-$(CONFIG_SND_SOC_AK5558)	+= snd-soc-ak5558.o
 obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
 obj-$(CONFIG_SND_SOC_ALC5632)	+= snd-soc-alc5632.o
 obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
new file mode 100644
index 0000000..225173f
--- /dev/null
+++ b/sound/soc/codecs/ak5558.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Audio driver for AK5558 ADC
+ *
+ * Copyright (C) 2015 Asahi Kasei Microdevices Corporation
+ * Copyright 2018 NXP
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+
+#include "ak5558.h"
+
+/* AK5558 Codec Private Data */
+struct ak5558_priv {
+	struct snd_soc_codec codec;
+	struct regmap *regmap;
+	struct i2c_client *i2c;
+	struct gpio_desc *reset_gpiod; /* Reset & Power down GPIO */
+	int slots;
+	int slot_width;
+};
+
+/* ak5558 register cache & default register settings */
+static const struct reg_default ak5558_reg[] = {
+	{ 0x0, 0xFF },	/*	0x00	AK5558_00_POWER_MANAGEMENT1	*/
+	{ 0x1, 0x01 },	/*	0x01	AK5558_01_POWER_MANAGEMENT2	*/
+	{ 0x2, 0x01 },	/*	0x02	AK5558_02_CONTROL1		*/
+	{ 0x3, 0x00 },	/*	0x03	AK5558_03_CONTROL2		*/
+	{ 0x4, 0x00 },	/*	0x04	AK5558_04_CONTROL3		*/
+	{ 0x5, 0x00 }	/*	0x05	AK5558_05_DSD			*/
+};
+
+static const char * const mono_texts[] = {
+	"8 Slot", "2 Slot", "4 Slot", "1 Slot",
+};
+
+static const struct soc_enum ak5558_mono_enum[] = {
+	SOC_ENUM_SINGLE(AK5558_01_POWER_MANAGEMENT2, 1,
+			ARRAY_SIZE(mono_texts), mono_texts),
+};
+
+static const char * const digfil_texts[] = {
+	"Sharp Roll-Off", "Show Roll-Off",
+	"Short Delay Sharp Roll-Off", "Short Delay Show Roll-Off",
+};
+
+static const struct soc_enum ak5558_adcset_enum[] = {
+	SOC_ENUM_SINGLE(AK5558_04_CONTROL3, 0,
+			ARRAY_SIZE(digfil_texts), digfil_texts),
+};
+
+static const struct snd_kcontrol_new ak5558_snd_controls[] = {
+	SOC_ENUM("AK5558 Monaural Mode", ak5558_mono_enum[0]),
+	SOC_ENUM("AK5558 Digital Filter", ak5558_adcset_enum[0]),
+};
+
+static const struct snd_soc_dapm_widget ak5558_dapm_widgets[] = {
+	/* Analog Input */
+	SND_SOC_DAPM_INPUT("AIN1"),
+	SND_SOC_DAPM_INPUT("AIN2"),
+	SND_SOC_DAPM_INPUT("AIN3"),
+	SND_SOC_DAPM_INPUT("AIN4"),
+	SND_SOC_DAPM_INPUT("AIN5"),
+	SND_SOC_DAPM_INPUT("AIN6"),
+	SND_SOC_DAPM_INPUT("AIN7"),
+	SND_SOC_DAPM_INPUT("AIN8"),
+
+	SND_SOC_DAPM_ADC("ADC Ch1", NULL, AK5558_00_POWER_MANAGEMENT1, 0, 0),
+	SND_SOC_DAPM_ADC("ADC Ch2", NULL, AK5558_00_POWER_MANAGEMENT1, 1, 0),
+	SND_SOC_DAPM_ADC("ADC Ch3", NULL, AK5558_00_POWER_MANAGEMENT1, 2, 0),
+	SND_SOC_DAPM_ADC("ADC Ch4", NULL, AK5558_00_POWER_MANAGEMENT1, 3, 0),
+	SND_SOC_DAPM_ADC("ADC Ch5", NULL, AK5558_00_POWER_MANAGEMENT1, 4, 0),
+	SND_SOC_DAPM_ADC("ADC Ch6", NULL, AK5558_00_POWER_MANAGEMENT1, 5, 0),
+	SND_SOC_DAPM_ADC("ADC Ch7", NULL, AK5558_00_POWER_MANAGEMENT1, 6, 0),
+	SND_SOC_DAPM_ADC("ADC Ch8", NULL, AK5558_00_POWER_MANAGEMENT1, 7, 0),
+
+	SND_SOC_DAPM_AIF_OUT("SDTO", "Capture", 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route ak5558_intercon[] = {
+	{"ADC Ch1", NULL, "AIN1"},
+	{"SDTO", NULL, "ADC Ch1"},
+
+	{"ADC Ch2", NULL, "AIN2"},
+	{"SDTO", NULL, "ADC Ch2"},
+
+	{"ADC Ch3", NULL, "AIN3"},
+	{"SDTO", NULL, "ADC Ch3"},
+
+	{"ADC Ch4", NULL, "AIN4"},
+	{"SDTO", NULL, "ADC Ch4"},
+
+	{"ADC Ch5", NULL, "AIN5"},
+	{"SDTO", NULL, "ADC Ch5"},
+
+	{"ADC Ch6", NULL, "AIN6"},
+	{"SDTO", NULL, "ADC Ch6"},
+
+	{"ADC Ch7", NULL, "AIN7"},
+	{"SDTO", NULL, "ADC Ch7"},
+
+	{"ADC Ch8", NULL, "AIN8"},
+	{"SDTO", NULL, "ADC Ch8"},
+};
+
+static int ak5558_set_mcki(struct snd_soc_codec *codec)
+{
+	return snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_CKS,
+				   AK5558_CKS_AUTO);
+}
+
+static int ak5558_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+	u8 bits;
+	int pcm_width = max(params_physical_width(params), ak5558->slot_width);
+
+	/* set master/slave audio interface */
+	bits = snd_soc_read(codec, AK5558_02_CONTROL1);
+	bits &= ~AK5558_BITS;
+
+	switch (pcm_width) {
+	case 16:
+		bits |= AK5558_DIF_24BIT_MODE;
+		break;
+	case 32:
+		bits |= AK5558_DIF_32BIT_MODE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_BITS, bits);
+
+	return 0;
+}
+
+static int ak5558_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u8 format;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
+	default:
+		dev_err(dai->dev, "Clock mode unsupported");
+		return -EINVAL;
+	}
+
+	/* set master/slave audio interface */
+	format = snd_soc_read(codec, AK5558_02_CONTROL1);
+	format &= ~AK5558_DIF;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		format |= AK5558_DIF_I2S_MODE;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		format |= AK5558_DIF_MSB_MODE;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		format |= AK5558_DIF_MSB_MODE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_DIF, format);
+
+	return 0;
+}
+
+static int ak5558_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+			       unsigned int rx_mask, int slots,
+			       int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+	int tdm_mode;
+
+	ak5558->slots = slots;
+	ak5558->slot_width = slot_width;
+
+	switch (slots * slot_width) {
+	case 128:
+		tdm_mode = AK5558_MODE_TDM128;
+		break;
+	case 256:
+		tdm_mode = AK5558_MODE_TDM256;
+		break;
+	case 512:
+		tdm_mode = AK5558_MODE_TDM512;
+		break;
+	default:
+		tdm_mode = AK5558_MODE_NORMAL;
+		break;
+	}
+
+	snd_soc_update_bits(codec, AK5558_03_CONTROL2, AK5558_MODE_BITS,
+			    tdm_mode);
+	return 0;
+}
+
+#define AK5558_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static const unsigned int ak5558_rates[] = {
+	8000, 11025,  16000, 22050,
+	32000, 44100, 48000, 88200,
+	96000, 176400, 192000, 352800,
+	384000, 705600, 768000, 1411200,
+	2822400,
+};
+
+static const struct snd_pcm_hw_constraint_list ak5558_rate_constraints = {
+	.count = ARRAY_SIZE(ak5558_rates),
+	.list = ak5558_rates,
+};
+
+static int ak5558_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_RATE,
+					  &ak5558_rate_constraints);
+}
+
+static struct snd_soc_dai_ops ak5558_dai_ops = {
+	.startup        = ak5558_startup,
+	.hw_params	= ak5558_hw_params,
+
+	.set_fmt	= ak5558_set_dai_fmt,
+	.set_tdm_slot   = ak5558_set_tdm_slot,
+};
+
+static struct snd_soc_dai_driver ak5558_dai = {
+	.name = "ak5558-aif",
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_KNOT,
+		.formats = AK5558_FORMATS,
+	},
+	.ops = &ak5558_dai_ops,
+};
+
+static void ak5558_power_off(struct ak5558_priv *ak5558)
+{
+	if (!ak5558->reset_gpiod)
+		return;
+
+	gpiod_set_value_cansleep(ak5558->reset_gpiod, 0);
+	usleep_range(1000, 2000);
+}
+
+static void ak5558_power_on(struct ak5558_priv *ak5558)
+{
+	if (!ak5558->reset_gpiod)
+		return;
+
+	gpiod_set_value_cansleep(ak5558->reset_gpiod, 1);
+	usleep_range(1000, 2000);
+}
+
+static int ak5558_probe(struct snd_soc_codec *codec)
+{
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+
+	ak5558_power_on(ak5558);
+	return ak5558_set_mcki(codec);
+}
+
+static int ak5558_remove(struct snd_soc_codec *codec)
+{
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+
+	ak5558_power_off(ak5558);
+
+	return 0;
+}
+
+static int __maybe_unused ak5558_runtime_suspend(struct device *dev)
+{
+	struct ak5558_priv *ak5558 = dev_get_drvdata(dev);
+
+	regcache_cache_only(ak5558->regmap, true);
+	ak5558_power_off(ak5558);
+
+	return 0;
+}
+
+static int __maybe_unused ak5558_runtime_resume(struct device *dev)
+{
+	struct ak5558_priv *ak5558 = dev_get_drvdata(dev);
+
+	ak5558_power_off(ak5558);
+	ak5558_power_on(ak5558);
+
+	regcache_cache_only(ak5558->regmap, false);
+	regcache_mark_dirty(ak5558->regmap);
+
+	return regcache_sync(ak5558->regmap);
+}
+
+const struct dev_pm_ops ak5558_pm = {
+	SET_RUNTIME_PM_OPS(ak5558_runtime_suspend, ak5558_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+struct snd_soc_codec_driver soc_codec_dev_ak5558 = {
+	.probe = ak5558_probe,
+	.remove = ak5558_remove,
+
+	.component_driver = {
+		.controls = ak5558_snd_controls,
+		.num_controls = ARRAY_SIZE(ak5558_snd_controls),
+		.dapm_widgets = ak5558_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(ak5558_dapm_widgets),
+		.dapm_routes = ak5558_intercon,
+		.num_dapm_routes = ARRAY_SIZE(ak5558_intercon),
+	},
+};
+
+static const struct regmap_config ak5558_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = AK5558_05_DSD,
+	.reg_defaults = ak5558_reg,
+	.num_reg_defaults = ARRAY_SIZE(ak5558_reg),
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int ak5558_i2c_probe(struct i2c_client *i2c)
+{
+	struct ak5558_priv *ak5558;
+	int ret = 0;
+
+	ak5558 = devm_kzalloc(&i2c->dev, sizeof(*ak5558), GFP_KERNEL);
+	if (!ak5558)
+		return -ENOMEM;
+
+	ak5558->regmap = devm_regmap_init_i2c(i2c, &ak5558_regmap);
+	if (IS_ERR(ak5558->regmap))
+		return PTR_ERR(ak5558->regmap);
+
+	i2c_set_clientdata(i2c, ak5558);
+	ak5558->i2c = i2c;
+
+	ak5558->reset_gpiod = devm_gpiod_get_optional(&i2c->dev, "reset",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(ak5558->reset_gpiod))
+		return PTR_ERR(ak5558->reset_gpiod);
+
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_ak5558,
+				     &ak5558_dai, 1);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(&i2c->dev);
+
+	return 0;
+}
+
+static int ak5558_i2c_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_codec(&i2c->dev);
+	pm_runtime_disable(&i2c->dev);
+
+	return 0;
+}
+
+static const struct of_device_id ak5558_i2c_dt_ids[] = {
+	{ .compatible = "asahi-kasei,ak5558"},
+	{ }
+};
+
+static struct i2c_driver ak5558_i2c_driver = {
+	.driver = {
+		.name = "ak5558",
+		.of_match_table = of_match_ptr(ak5558_i2c_dt_ids),
+		.pm = &ak5558_pm,
+	},
+	.probe_new = ak5558_i2c_probe,
+	.remove = ak5558_i2c_remove,
+};
+
+module_i2c_driver(ak5558_i2c_driver);
+
+MODULE_AUTHOR("Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>");
+MODULE_AUTHOR("Mihai Serban <mihai.serban@nxp.com>");
+MODULE_DESCRIPTION("ASoC AK5558 ADC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/ak5558.h b/sound/soc/codecs/ak5558.h
new file mode 100644
index 0000000..7c9e373
--- /dev/null
+++ b/sound/soc/codecs/ak5558.h
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Audio driver header for AK5558
+ *
+ * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
+ * Copyright 2018 NXP
+ */
+
+#ifndef _AK5558_H
+#define _AK5558_H
+
+#define AK5558_00_POWER_MANAGEMENT1    0x00
+#define AK5558_01_POWER_MANAGEMENT2    0x01
+#define AK5558_02_CONTROL1             0x02
+#define AK5558_03_CONTROL2             0x03
+#define AK5558_04_CONTROL3             0x04
+#define AK5558_05_DSD                  0x05
+
+/* AK5558_02_CONTROL1 fields */
+#define AK5558_DIF			GENMASK(1, 1)
+#define AK5558_DIF_MSB_MODE		(0 << 1)
+#define AK5558_DIF_I2S_MODE		(1 << 1)
+
+#define AK5558_BITS			GENMASK(2, 2)
+#define AK5558_DIF_24BIT_MODE		(0 << 2)
+#define AK5558_DIF_32BIT_MODE		(1 << 2)
+
+#define AK5558_CKS			GENMASK(6, 3)
+#define AK5558_CKS_128FS_192KHZ		(0 << 3)
+#define AK5558_CKS_192FS_192KHZ		(1 << 3)
+#define AK5558_CKS_256FS_48KHZ		(2 << 3)
+#define AK5558_CKS_256FS_96KHZ		(3 << 3)
+#define AK5558_CKS_384FS_96KHZ		(4 << 3)
+#define AK5558_CKS_384FS_48KHZ		(5 << 3)
+#define AK5558_CKS_512FS_48KHZ		(6 << 3)
+#define AK5558_CKS_768FS_48KHZ		(7 << 3)
+#define AK5558_CKS_64FS_384KHZ		(8 << 3)
+#define AK5558_CKS_32FS_768KHZ		(9 << 3)
+#define AK5558_CKS_96FS_384KHZ		(10 << 3)
+#define AK5558_CKS_48FS_768KHZ		(11 << 3)
+#define AK5558_CKS_64FS_768KHZ		(12 << 3)
+#define AK5558_CKS_1024FS_16KHZ		(13 << 3)
+#define AK5558_CKS_AUTO			(15 << 3)
+
+/* AK5558_03_CONTROL2 fields */
+#define AK5558_MODE_BITS	GENMASK(6, 5)
+#define AK5558_MODE_NORMAL	(0 << 5)
+#define AK5558_MODE_TDM128	(1 << 5)
+#define AK5558_MODE_TDM256	(2 << 5)
+#define AK5558_MODE_TDM512	(3 << 5)
+
+#endif
-- 
2.7.4
