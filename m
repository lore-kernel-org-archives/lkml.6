Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeBEUVI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:21:08 -0500
Received: from mail-bn3nam01on0040.outbound.protection.outlook.com ([104.47.33.40]:59922
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750943AbeBEUU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:20:59 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Daniel Baluta <daniel.baluta@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <wakasugi.jb@om.asahi-kasei.co.jp>,
        <shengjiu.wang@nxp.com>, <daniel.baluta@nxp.com>,
        <mihai.serban@gmail.com>, <cosmin.samoila@nxp.com>,
        <linux-imx@nxp.com>, <fabio.estevam@nxp.com>, <robh@kernel.org>,
        <andy.shevchenko@gmail.com>, Mihai Serban <mihai.serban@nxp.com>
Subject: [PATCH v3 1/2] ASoC: codecs: Add support for AK5558 ADC driver
Date: Mon, 5 Feb 2018 19:01:54 +0200
Message-ID: <1517850115-24340-2-git-send-email-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com>
References: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131623356573584244;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(346002)(376002)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(4326008)(97736004)(2950100002)(105606002)(106466001)(498600001)(36756003)(53936002)(956003)(50226002)(356003)(305945005)(336011)(6666003)(8936002)(2906002)(26005)(8676002)(81156014)(81166006)(6306002)(16586007)(48376002)(5660300001)(26826003)(54906003)(450100002)(316002)(59450400001)(2201001)(85426001)(50466002)(966005)(110136005)(76176011)(47776003)(104016004)(68736007)(86362001)(51416003)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB1412;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD016;1:SK3xiW7UbpcdBIamM69RIQz48KqUbiaRfobtqMVYWGIB6HqvxMMX2I+xSR/IkB/avU0VksNN6lF180PD0sWyhRu/5XWA2YBfW1OpzC/9nrX/UOf1LgOaSdosDkWW8Zhh
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3471626-778c-4da2-bdaa-08d56cd5f715
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BLUPR03MB1412;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1412;3:vsVNb5EAQq46WFVMMw7yIhIdR4U+EZhYNczUJ8OdlrhdCeHrfLuP6qcaKaKWuYVur5DFTX1QQwVbj4sy5jKeImEdAK4OIrxg3D6tzk+yDgw6SwEY8eQsKvuhtKCR3n70+GqrBa0CP9rX7ovlfhHzjhgMmuexo8DZnhSpm7HhapX5yyvS2lcSOdGzXQ6h55VDvrwuswfSngbplNY4KGg6mB8bWr1xxFqjg3Nd3OWYL34/3NiWJoUzkAemeyByH4qz/5ZUZzyWZvPAfsPDNrlsh1Nhj0a//JpOGU5Zcvlk0UmPjqIzNgsw8hniembS/CwlhEbyw9Ym6IF0hZE7NL/BD8mYoqKLIPSy9meUuqjUE4Y=;25:yYR8nCEk5DNvaSbPHTctZ4raWR6Pw3sNsAHj6O1lD75+kA0/WYGwvZovYx+W0KkLGQNRSwc2AseRonTWE751hjBSwB39NSvnEdkx+NXaGdHDxqaHTHtPtHzmA8nJ8WOg2augeWLOj8M2dwK5NjnvI5D8agYV0WIWQpeXcH8VJc+WPHCqSJqLwo6idgHhf68K8FNgs/ajrEgi4KTwyJnKUn3oTeG5d3eQruG3K93GAyaUvAUhljvXTKKOVnQqrk2g3PiN8vAD/9wXu2Y7lXrWMjqNqvVCafRv1NyzMhuvhQFYvDBPj7/nez36Iiv7AsjuKdYtO5lK/XQ6+h1DVmfJ5Q==
X-MS-TrafficTypeDiagnostic: BLUPR03MB1412:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1412;31:YVjbIIQOvcJMWhLB/MBwHiD0N/8agxMFaz0BMacrtovVLtDil2JWsGLewNlJDoiNi87xztbc5GdbbQPrKwzNn3ck3g3+6lfVbcCyira4BekDzWx4gonQhGotd1fdDkCj2YikR/0JVhWiWFVeHFPq3QUIZwwOwsEBy5rSljYhS1VH/gVHx3HR7NnZgckmGBkHQRs6u5q4+rztbyT7QwbjtS4Oh8UQ+it1bS3eRBusPY0=;4:9ZZ8O/4lGNEcTusaIXVpijgLv235bAe3gKnf1okmMV0Q8bl8y4UussRAS7opETDK9Za1AVOUMmTBGKoumy9lQiB4Dp9MA+O5MEfDcl/dZ0CmJQFMAZLb9G9eZM+a205QxEsQXEsi/pLcP9FTE9+oiptij2O8uXTzqotKSfzx3qoOdNETP/RT/T94+tJYkiTitUMVwKS+th2l9A+A1Dj0zLhynP/KL3rNnTqWdRGjrB3V3cRbOSqP7/jTphQLMm13LhhT7p6Fk55/eehvTSgI4lJlNVnQIal8d/+mgHjJLNSWi3E0VA25exrfIxhnQo04
X-Microsoft-Antispam-PRVS: <BLUPR03MB141249B9FA42D674C7880588F9FE0@BLUPR03MB1412.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6096035)(20161123563025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123556025)(20161123561025)(20161123565025)(201708071742011);SRVR:BLUPR03MB1412;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR03MB1412;
X-Forefront-PRVS: 0574D4712B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB1412;23:FjXd0AVloL6pNvnnSewj3A3YJrvCBo8PSTyBd6TZO?=
 =?us-ascii?Q?9RadmpCe1fprj8TcW7IQiwDlfmiR9+AUixromzNpko2WHG5HARXc3QXp3btC?=
 =?us-ascii?Q?+wOVPKXOuaf30zUifhBA037dforX3A79RPXFSQPSY1Nf+mlEeOrXlft/vhAS?=
 =?us-ascii?Q?q6fBFh9FV0Rv5lSBZcwMAMtlNG8JRka2BmtvREn/m5vJss6D92eDcO4mQAmE?=
 =?us-ascii?Q?H2tK0znxgjNs0b0QECHeaY0q/rtQvuDJs9TLCgzuOA8gJeRDWCJVoNFVOgKJ?=
 =?us-ascii?Q?BZGBHQI2zW7dqJMMkXvqBtehgKFgOOPadCjdoP/7I3qSovqSI6p1XpDlVOex?=
 =?us-ascii?Q?CrniDCu8UwwSh7rS9eS8kkI/XMS8XHm49yqLpOuX2N/ZNwuY/sAA2kBxLIEI?=
 =?us-ascii?Q?TK6slzZB4kmySeoU2NoLTNIkcB7QwpXMdr8wuLjkPO9+teIa69ZEg9bhDprA?=
 =?us-ascii?Q?3JYYVepjsWru0HEgGJe5ZKGoJ3GS5A6N3uiGfULkic1f8tAkAyY7XU31scQE?=
 =?us-ascii?Q?NzcBVm8U7JuXCRt4RPiD0+oyMzJFqtnJIOeGuPsHYUntDlUaYkZDpT1ZJLmp?=
 =?us-ascii?Q?a+76HQ1KOP0BoVUr3n/qLz36Mj2obHsXCCKW9oFtPN4I3MpR7iA4tj7t8bDR?=
 =?us-ascii?Q?yxRql5oqI7JUDK4oARutDCI52xPi96fVrxpiKX9zmIpCCPnWGFee7oqFy7IP?=
 =?us-ascii?Q?F+kqsY8+lSeG2DTVn8pTXjDr3agshI4XAwziAOTYRQ8PrQ9Y3BhTEb8iH0ks?=
 =?us-ascii?Q?Pidgl6r+M9Twj5s0T/CNBdOo/FevKkPsJoijTxOCthmLWxG9g/OnQF7/F3Ky?=
 =?us-ascii?Q?7EUAYX3RhXhKnt2aCQEyz0A617FX037pS/DDETJrgn2QZpblntBtWzRCjot7?=
 =?us-ascii?Q?uVun6Ud8t4l/eyaTCBu9yMf6UilpgQkqtURmKn6CK9oWBWYtr7wLZ31KOLm3?=
 =?us-ascii?Q?XXZD/cjj42tZQSxkzpMuidU7+gZlRsh811dfL0ceQTeWPQTfH0NOExCJ1nLj?=
 =?us-ascii?Q?AtzCCM9CZD0QU8Qyo+875e/Aq6t+nMchkUj3qg0FXiKPLHxoXVi1Fwav0wzc?=
 =?us-ascii?Q?iUfcNxFknzTCgm6nN+ncM1oHcoubgnovBK0ggY24N6HcKeaxeFJoNzUZmzSv?=
 =?us-ascii?Q?NjvH+TGxIxcOmEp9voVXYd6lkUOX9F2AnG9fdA66k4hljVgHCC3GpZRNduJl?=
 =?us-ascii?Q?udy6OJyfSNCl2jv7RtazsTFbTjRN+mvrlru?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1412;6:/aQz3zNxIpReGdn+XtMOwqTD0aSNiMNq/wYSzLYQwLrO9l2fIY0ukFx3jk9PGjrm/NVZjAQHb6eQpgCTKPAzb6DsduY/wd04k1MwI3ZGIiAxZx27KO5MGwusyTzPf8xqmajjhHR/FnQIkNmGtVPewot70Wva/LPdjacyGGNrK7zLe+mlqWfzyvlBcI3EmzKGc3Yiik/xa3CXI0QCQ8bgPj7ZmEwuf49IehuYTT5UgMDgfHxDvvHygOdMQvxn4NsQjtZv0Fswt0xo4gwzJS2WDTL2ynLb3G6b4k9AiNedzNWXKzjldzOFI403ih5dKrR8f/sjZjriq6Gx3/ru52n1vu2Zuj4U1P235QllrM6bN0k=;5:uGpL0sM+k/Dn1Q2uIICR0WdHiczIveWJOkHzv+iNigJ1GnHkfImDNZBvv5U3TkDMHk9l73On33c+N74qCwBxZtMwGVERVtQ2qP4D9QCdHuNHjsQlLX3itUW3ZKlwP+n6mKmfN2qta2LMaB/GkJ6u2P9BB9JeKJfzzpG27w269tI=;24:THKcPdi7J807EY8qRyNCILC3EMBfy8i/XeTtU7p0xWlJdGuq6zXHVj8vd2HwuvrILjJO5Yg87ac6shhAWd73MIqVrIP8hv9wVPisJQfAr6I=;7:tq9TcG961oj2stAM/QJ3RjgLRjDQiF053PHrKwY5aLmXCGwWaTMiAgmay/Kz5+nLEB+8KOuruMCI+LHV0Af6Lnsrg6YeWz7WneGJrnqwgGcM8uA08xJ3CeqF2i1ntvJ2/1e/KnACJfXTo1SVFwf7UJsl8UGcKmKpqEFzC8saURcOzOKy5XlxsJ7Y7UJnJPtM9Fm2FcfXgKft4qaA6ZU760Mldo4n2WIVCgWgI9e41WSsgGJrpXOoP3p/XISdcJij
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 20:20:55.7516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3471626-778c-4da2-bdaa-08d56cd5f715
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB1412
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AK5558 is a 32-bit, 768 kHZ sampling, differential input ADC
for digital audio systems.

Datasheet is available at:

https://www.akm.com/akm/en/file/datasheet/AK5558VN.pdf

Initial patch includes support for normal and TDM modes.

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
 sound/soc/codecs/ak5558.c | 618 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ak5558.h |  52 ++++
 4 files changed, 678 insertions(+)
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
index 0000000..c1eed82
--- /dev/null
+++ b/sound/soc/codecs/ak5558.c
@@ -0,0 +1,618 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+	int fs;		/* Sampling Frequency */
+	int rclk;	/* Master Clock */
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
+			ARRAY_SIZE(mono_texts), mono_texts)
+};
+
+static const char * const tdm_texts[] = {
+	"Off", "TDM128",  "TDM256", "TDM512",
+};
+
+static const char * const digfil_texts[] = {
+	"Sharp Roll-Off", "Show Roll-Off",
+	"Short Delay Sharp Roll-Off", "Short Delay Show Roll-Off",
+};
+
+static const struct soc_enum ak5558_adcset_enum[] = {
+	SOC_ENUM_SINGLE(AK5558_03_CONTROL2, 5,
+			ARRAY_SIZE(tdm_texts), tdm_texts),
+	SOC_ENUM_SINGLE(AK5558_04_CONTROL3, 0,
+			ARRAY_SIZE(digfil_texts), digfil_texts),
+};
+
+static const char * const dsdon_texts[] = {
+	"PCM", "DSD",
+};
+
+static const char * const dsdsel_texts[] = {
+	"64fs", "128fs", "256fs"
+};
+
+static const char * const dckb_texts[] = {
+	"Falling", "Rising",
+};
+
+static const char * const dcks_texts[] = {
+	"512fs", "768fs",
+};
+
+static const struct soc_enum ak5558_dsdset_enum[] = {
+	SOC_ENUM_SINGLE(AK5558_04_CONTROL3, 7,
+			ARRAY_SIZE(dsdon_texts), dsdon_texts),
+	SOC_ENUM_SINGLE(AK5558_05_DSD, 0,
+			ARRAY_SIZE(dsdsel_texts), dsdsel_texts),
+	SOC_ENUM_SINGLE(AK5558_05_DSD, 2, ARRAY_SIZE(dckb_texts), dckb_texts),
+	SOC_ENUM_SINGLE(AK5558_05_DSD, 5, ARRAY_SIZE(dcks_texts), dcks_texts),
+};
+
+static const struct snd_kcontrol_new ak5558_snd_controls[] = {
+	SOC_ENUM("AK5558 Monaural Mode", ak5558_mono_enum[0]),
+	SOC_ENUM("AK5558 TDM mode", ak5558_adcset_enum[0]),
+	SOC_ENUM("AK5558 Digital Filter", ak5558_adcset_enum[1]),
+
+	SOC_ENUM("AK5558 DSD Mode", ak5558_dsdset_enum[0]),
+	SOC_ENUM("AK5558 Frequency of DCLK", ak5558_dsdset_enum[1]),
+	SOC_ENUM("AK5558 Polarity of DCLK", ak5558_dsdset_enum[2]),
+	SOC_ENUM("AK5558 Master Clock Frequency at DSD Mode",
+		 ak5558_dsdset_enum[3]),
+
+	SOC_SINGLE("AK5558 DSD Phase Modulation", AK5558_05_DSD, 3, 1, 0),
+};
+
+static const char * const ak5558_channel_select_texts[] = {"Off", "On"};
+
+static SOC_ENUM_SINGLE_VIRT_DECL(ak5558_channel1_mux_enum,
+				 ak5558_channel_select_texts);
+
+static const struct snd_kcontrol_new ak5558_channel1_mux_control =
+	SOC_DAPM_ENUM("Ch1 Switch", ak5558_channel1_mux_enum);
+
+static SOC_ENUM_SINGLE_VIRT_DECL(ak5558_channel2_mux_enum,
+				 ak5558_channel_select_texts);
+
+static const struct snd_kcontrol_new ak5558_channel2_mux_control =
+	SOC_DAPM_ENUM("Ch2 Switch", ak5558_channel2_mux_enum);
+
+static SOC_ENUM_SINGLE_VIRT_DECL(ak5558_channel3_mux_enum,
+				 ak5558_channel_select_texts);
+
+static const struct snd_kcontrol_new ak5558_channel3_mux_control =
+	SOC_DAPM_ENUM("Ch3 Switch", ak5558_channel3_mux_enum);
+
+static SOC_ENUM_SINGLE_VIRT_DECL(ak5558_channel4_mux_enum,
+				 ak5558_channel_select_texts);
+
+static const struct snd_kcontrol_new ak5558_channel4_mux_control =
+	SOC_DAPM_ENUM("Ch4 Switch", ak5558_channel4_mux_enum);
+
+static SOC_ENUM_SINGLE_VIRT_DECL(ak5558_channel5_mux_enum,
+				 ak5558_channel_select_texts);
+
+static const struct snd_kcontrol_new ak5558_channel5_mux_control =
+	SOC_DAPM_ENUM("Ch5 Switch", ak5558_channel5_mux_enum);
+
+static SOC_ENUM_SINGLE_VIRT_DECL(ak5558_channel6_mux_enum,
+				 ak5558_channel_select_texts);
+
+static const struct snd_kcontrol_new ak5558_channel6_mux_control =
+	SOC_DAPM_ENUM("Ch6 Switch", ak5558_channel6_mux_enum);
+
+static SOC_ENUM_SINGLE_VIRT_DECL(ak5558_channel7_mux_enum,
+				 ak5558_channel_select_texts);
+
+static const struct snd_kcontrol_new ak5558_channel7_mux_control =
+	SOC_DAPM_ENUM("Ch7 Switch", ak5558_channel7_mux_enum);
+
+static SOC_ENUM_SINGLE_VIRT_DECL(ak5558_channel8_mux_enum,
+				 ak5558_channel_select_texts);
+
+static const struct snd_kcontrol_new ak5558_channel8_mux_control =
+	SOC_DAPM_ENUM("Ch8 Switch", ak5558_channel8_mux_enum);
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
+	SND_SOC_DAPM_MUX("AK5558 Ch1 Enable", SND_SOC_NOPM, 0, 0,
+			 &ak5558_channel1_mux_control),
+	SND_SOC_DAPM_MUX("AK5558 Ch2 Enable", SND_SOC_NOPM, 0, 0,
+			 &ak5558_channel2_mux_control),
+	SND_SOC_DAPM_MUX("AK5558 Ch3 Enable", SND_SOC_NOPM, 0, 0,
+			 &ak5558_channel3_mux_control),
+	SND_SOC_DAPM_MUX("AK5558 Ch4 Enable", SND_SOC_NOPM, 0, 0,
+			 &ak5558_channel4_mux_control),
+	SND_SOC_DAPM_MUX("AK5558 Ch5 Enable", SND_SOC_NOPM, 0, 0,
+			 &ak5558_channel5_mux_control),
+	SND_SOC_DAPM_MUX("AK5558 Ch6 Enable", SND_SOC_NOPM, 0, 0,
+			 &ak5558_channel6_mux_control),
+	SND_SOC_DAPM_MUX("AK5558 Ch7 Enable", SND_SOC_NOPM, 0, 0,
+			 &ak5558_channel7_mux_control),
+	SND_SOC_DAPM_MUX("AK5558 Ch8 Enable", SND_SOC_NOPM, 0, 0,
+			 &ak5558_channel8_mux_control),
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
+	{"AK5558 Ch1 Enable", "On", "AIN1"},
+	{"ADC Ch1", NULL, "AK5558 Ch1 Enable"},
+	{"SDTO", NULL, "ADC Ch1"},
+
+	{"AK5558 Ch2 Enable", "On", "AIN2"},
+	{"ADC Ch2", NULL, "AK5558 Ch2 Enable"},
+	{"SDTO", NULL, "ADC Ch2"},
+
+	{"AK5558 Ch3 Enable", "On", "AIN3"},
+	{"ADC Ch3", NULL, "AK5558 Ch3 Enable"},
+	{"SDTO", NULL, "ADC Ch3"},
+
+	{"AK5558 Ch4 Enable", "On", "AIN4"},
+	{"ADC Ch4", NULL, "AK5558 Ch4 Enable"},
+	{"SDTO", NULL, "ADC Ch4"},
+
+	{"AK5558 Ch5 Enable", "On", "AIN5"},
+	{"ADC Ch5", NULL, "AK5558 Ch5 Enable"},
+	{"SDTO", NULL, "ADC Ch5"},
+
+	{"AK5558 Ch6 Enable", "On", "AIN6"},
+	{"ADC Ch6", NULL, "AK5558 Ch6 Enable"},
+	{"SDTO", NULL, "ADC Ch6"},
+
+	{"AK5558 Ch7 Enable", "On", "AIN7"},
+	{"ADC Ch7", NULL, "AK5558 Ch7 Enable"},
+	{"SDTO", NULL, "ADC Ch7"},
+
+	{"AK5558 Ch8 Enable", "On", "AIN8"},
+	{"ADC Ch8", NULL, "AK5558 Ch8 Enable"},
+	{"SDTO", NULL, "ADC Ch8"},
+};
+
+static int ak5558_set_mcki(struct snd_soc_codec *codec, int fs, int rclk)
+{
+	u8  mode;
+
+	mode = snd_soc_read(codec, AK5558_02_CONTROL1);
+	mode &= ~AK5558_CKS;
+	mode |= AK5558_CKS_AUTO;
+
+	snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_CKS, mode);
+
+	return 0;
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
+	ak5558->fs = params_rate(params);
+	snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_BITS, bits);
+
+	ak5558_set_mcki(codec, ak5558->fs, ak5558->rclk);
+
+	return 0;
+}
+
+static int ak5558_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
+				 unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+
+	ak5558->rclk = freq;
+	ak5558_set_mcki(codec, ak5558->fs, ak5558->rclk);
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
+static int ak5558_set_dai_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+	int ndt = 0;
+
+	if (!mute)
+		return 0;
+
+	if (ak5558->fs != 0)
+		ndt = 583000 / ak5558->fs;
+
+	msleep(max(ndt, 5));
+
+	return 0;
+}
+
+static int ak5558_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
+	case SND_SOC_BIAS_STANDBY:
+		break;
+	case SND_SOC_BIAS_OFF:
+		snd_soc_write(codec, AK5558_00_POWER_MANAGEMENT1, 0x00);
+		break;
+	}
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
+	int reg;
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
+	reg = snd_soc_read(codec, AK5558_03_CONTROL2);
+	reg &= ~AK5558_MODE_BITS;
+	reg |= tdm_mode;
+	snd_soc_write(codec, AK5558_03_CONTROL2, reg);
+
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
+	.set_sysclk	= ak5558_set_dai_sysclk,
+	.set_fmt	= ak5558_set_dai_fmt,
+	.digital_mute	= ak5558_set_dai_mute,
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
+static int ak5558_init_reg(struct snd_soc_codec *codec)
+{
+	int  ret;
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+
+	usleep_range(10000, 11000);
+
+	ak5558_power_off(ak5558);
+	ak5558_power_on(ak5558);
+
+	ret = snd_soc_write(codec, AK5558_00_POWER_MANAGEMENT1, 0x0);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_CKS,
+				   AK5558_CKS_AUTO);
+}
+
+static int ak5558_probe(struct snd_soc_codec *codec)
+{
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+
+	ak5558->fs = 48000;
+	ak5558->rclk = 0;
+
+	return ak5558_init_reg(codec);
+}
+
+static int ak5558_remove(struct snd_soc_codec *codec)
+{
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+
+	ak5558_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	ak5558_power_off(ak5558);
+
+	return 0;
+}
+
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
+	.idle_bias_off = true,
+	.set_bias_level = ak5558_set_bias_level,
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
index 0000000..2ed4c7c
--- /dev/null
+++ b/sound/soc/codecs/ak5558.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
