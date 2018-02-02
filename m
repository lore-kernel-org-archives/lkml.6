Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeBBUdt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:33:49 -0500
Received: from mail-sn1nam02on0065.outbound.protection.outlook.com ([104.47.36.65]:61618
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752028AbeBBUd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:33:29 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Daniel Baluta <daniel.baluta@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <andy.shevchenko@gmail.com>,
        <fabio.estevam@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <wakasugi.jb@om.asahi-kasei.co.jp>,
        <shengjiu.wang@nxp.com>, <daniel.baluta@nxp.com>,
        <mihai.serban@gmail.com>, <cosmin.samoila@nxp.com>,
        <linux-imx@nxp.com>, <daniel.baluta@gmail.com>,
        Mihai Serban <mihai.serban@nxp.com>
Subject: [PATCH v2 1/2] ASoC: codecs: Add support for AK5558 ADC driver
Date: Fri, 2 Feb 2018 18:20:05 +0200
Message-ID: <1517588406-3295-2-git-send-email-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com>
References: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131620772074205736;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(39380400002)(376002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(2950100002)(85426001)(305945005)(47776003)(356003)(97736004)(50466002)(81166006)(450100002)(50226002)(8676002)(81156014)(68736007)(105606002)(48376002)(966005)(26826003)(4326008)(8936002)(26005)(2201001)(54906003)(2906002)(110136005)(498600001)(106466001)(316002)(16586007)(53936002)(86362001)(6306002)(104016004)(956003)(336011)(5660300001)(51416003)(6636002)(6666003)(76176011)(59450400001)(36756003)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB1415;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD018;1:hrfyLbmofJnIStx14PyhOBhOGgXpdKS58H/aqCojW4HlDlBVAo2FXDEQ7JVu/2e+/25VzAh9vRzmgjXEZhgQ6Os+JRWmbz/mv430s5cTk6wFGmscemdvqWcBh6/NNA0t
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64374f42-85e3-4721-b228-08d56a7c3702
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BN3PR03MB1415;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1415;3:jRXdZEx5Os5sSm6FGOmBkBoe79qgk3PBPtGtcTB7JPUGmo0BWhmqNiuiOIZA0SJ3MohLty/gKcl3ZZwEwQWeowVmFiWcmu4Yh9tI2sp3zLqpdDT+MUD4kdBvkVsemXbkq5SZif5e3vY0EDYclLFbVIdA0bHKGKVLqH148rS95UuAATlZRjO/uU9m6gbi821te3S+/DViDlVi5LicfoDDRaLWYduqCWtuLx+QU3zCH8YHlyHcTjKTWSAXN0P9/cNypApHu9kB1GuutUNbPZ+vUfh7+lSYiIPnUuHbwiMIcQMcs8SIfOrGGtF90D7s7kkeqkAMG2o72DXG6H6KBch3GX4DFEPxk/wRs1N29WgDmdM=;25:pK4mPUuN31l3QHj3a+KNKVuusi9xSn2cDN5avrw+JdU7CFX0cblTqO2c1JBBzU0nvB52wCC8v/Ip+bz7Hj39fDhLTa5dm70VK5uAlYTNVheslT5em6hlyVCKmlA7n9U0n17Kx6qhEOTaGSENkxgr5/Ej1PYRBAKosCC6IW26FNI07hg2+y7Y7trRUyku4lw8PjbYvZw69hLUo2tzb9gWp2nYOcdIBPYLBUSJ8qDr/ewcOsUkjFf79h9Ev7DgKUlQ512MSmfx9MachsikJsF5X0s54z419/91tOdJ7bXVzU7dihJciPVeh2mOSGC7OduoTq0mDBf2dRHfOXbPg/X9Wg==
X-MS-TrafficTypeDiagnostic: BN3PR03MB1415:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1415;31:9KYX+lYrj3aPI2Qs83fkEu5gzr+FOhOpRMb8gMdvnLN3eV8dAWV0pMlrZYsNQG74OBwc9HfLMFIrjuROGaDt5v7qk1ujJ52OZFBzzv6KAuIR2REdonXux91crebgy9nBxHITyDNgdoOaTDq6GP5MRZ0yHUWf5DpJfg8Ei98vZD7udsoTK6vOWoVPtzIlXLI8vxOuC+Mj6QFZjcWV8m4O4AJp7pm0sH9iMzApySVUgyQ=;4:81+SBgmgKEdGn2mjRj1zwLphkZ6doVa70altsPOmSv5/Ais13whYNCtwCeRBEumTwtNbWFfxiWXex+ngt5WkCeEAbPKjU39Qx0MAjbEKxPhK9YTO1GpvIQo0ynvkS/TqWiHYFtgZVCQ2Tlcou/YA6T1pwhgPEYkHkLPIfUCY4LHIrhfXZBQgvhCqTkSt/Z6/ioNTT3HRh1Vdw9PZ/0A3UCV/DysCwePeqdVfyhd9xvAoT+d6iybohnd1JoCgvtOl5T2WP0G+kKrv7kgn8Ib25y5KI99PxgekJ+ciZHHLGVCd/z2J5cJbHoN0eDcl1XrE
X-Microsoft-Antispam-PRVS: <BN3PR03MB14153DA6850D4F07603E3209F9F90@BN3PR03MB1415.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(6055026)(6096035)(20161123565025)(20161123561025)(20161123556025)(20161123563025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:BN3PR03MB1415;BCL:0;PCL:0;RULEID:(400006);SRVR:BN3PR03MB1415;
X-Forefront-PRVS: 05715BE7FD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR03MB1415;23:az9x4inN1EIQhX2frEeXdyvaKeBhHrsfxtELVW+Tf?=
 =?us-ascii?Q?k53x7vOYATTGOegZaVewxa8em4WSvMtpq7d6avbhLAY4942hZmDlWPPB+OHL?=
 =?us-ascii?Q?VsGplvu6ygs6T9y+nZvnV5zxsCR3PcW92Onea8xLnTVzaiaknWzIqw+OEzeY?=
 =?us-ascii?Q?WEUI+GqvsqUvh7GqHbyT1UDYbxUtScTnw8TK44KZ61dSBS/7r/qv6FpPS/o8?=
 =?us-ascii?Q?kYAuciiTBT2XZTQwmm9oIg3C/Lqr8o3CRagq/BTw8s4clksiu34bnoFoi7P1?=
 =?us-ascii?Q?StmXQglH7uhztRUQddTRob28/VMR31UChcAF5wH7FSMXlJxHR26cQp97Sh8l?=
 =?us-ascii?Q?5Yj++q2uRG0h943aJAk1W8yUOZIVkQpIX+YXffdUGiyELOJByYAFTI2mI40O?=
 =?us-ascii?Q?IcXrl8IHW5mhk08lb0XEGHFdzjOwRpIh1b/X/ZmRZQbHJbovW8hRvLCsXIwK?=
 =?us-ascii?Q?6gvW7WBI/1SLkZcFuMQtm3f9s99ow1kVInzq0j4TVpi+0MU/EPbSZsyURIoP?=
 =?us-ascii?Q?KmuLmVKG0Hi4qO3rr4sWfWxfqy1i4ZAooobgo/9Ry5a6a1dp5iX3Wxus5mlg?=
 =?us-ascii?Q?BcjjQTCYUrSA0nT0mefmIvcBbh5xgb+ABL1SFKn2tvBhjDYAStf5yoytp56O?=
 =?us-ascii?Q?kHAWSorFYooBdJ/RvNwlh8tv/NrEsrd9ohUI8AUb/LNvF7C6NsxK5Figel/u?=
 =?us-ascii?Q?K62FWlcpAHqa6svJiOLhL70ez5UGq2R3WeyxdN1eCb1eHmC2RLWEADPUWrWe?=
 =?us-ascii?Q?vNanLK6LSm1j922yjcDDBF/gnsb74TqUjzdnyKy7vpUytttyAQEuue8MxZa6?=
 =?us-ascii?Q?5l7TM5kH5JbMeKyJtu7Dsw5dYRio1aiuydtGIYhGtdcAUtBf0FGMpakGYlU7?=
 =?us-ascii?Q?kI7SaFrXfruyC1QZWDJwxeZtC8I6/2BqAxpgMo80cObFtkJ5t+yt5WLKn7Bt?=
 =?us-ascii?Q?7D7zXPcoSaL1y6HXMPCt1vT2GGcDAm8WjV8JOYu4SnUUkE3hEcNJrTZUqg0U?=
 =?us-ascii?Q?PAvxJ8D2faIXaPh/w05BlZZ65L62+aFtEpsiWVnE96ktuuwWG5MRQoOvaXTh?=
 =?us-ascii?Q?q1Y71FW50rp0/KjhswA7rQijVZXpmWsmKQh6R748HOV5gLgG5Mo17MVquL0e?=
 =?us-ascii?Q?McDt4bZE4Pc2zdHANZwVW4Kky4T8y5D0WpyvhsKsOdJ/BGWw3gMDYFC9Iszj?=
 =?us-ascii?Q?l7COHS5ozEPaYFFbnDl50t9+OdhJtzV3fVEKsxmTOzOZAi8LpNvEdkYkA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1415;6:p4BQJe38fMNuk2LJRtjyGfmThZ1aMPpAO1+gMAapKu7xtr8NU3LIZDwxyN5U7Yr+j9zjjKPNRO5MkG9w5FBirNSOz0Xybe7DpM3MnL1+VdQxATtHOerrxOqWKb11eB/ob0V/4HAKJRaPMDy4RmjBc/P7BRzBC1p2ogR8mZvbljBZxSlE1hF2A9oCIWxT5csXkYmBa8xfv5bcDRo6t57YR1vEz/oRNnPVGz4OQ1XfRRmUo24uZUg6XpU88aDrPAmdHpjlNIDd7G9bTk6rCkPLkZZqpXzFIuthQ3lAafFO2mqjbWGz4Gn20yyDtHhIIzu8HGCaV3nkbdIi6hvVxk02hIVslo/Pw89db9fbhzpXOLY=;5:QhYXHRT0eRbAPXAU+GAsxHg7IA3awrGzEf8YbnKsaqYwtyF7EMbG2O0J7JgZ9iEYkVFv3/C3edktNYBFpl8kP+Hp8InFS7Qi3ZfslkhX/hZH0S2OGS/PmG7KS7+i75xQ2eyRMvJ2tAjGhXe/6MxGtflFh7YXXrvqQZ4fZxZIGF4=;24:7B9tfKtEOCwV6LI+gwmhH4AfNWOTopI643MtIHDcT6S+q//zbVGAWpUN6KToG6g8HTLVVC0FJyMwwxg4CIpWfNUCM9J9iQvk6/iNC/EmJUY=;7:lKydIwpiI4upBV8Lv8LxM+5ku1z+1pm8FqpWRxGj44UZuVcDuCfCzKNSF4roVSZ3QQCTiMQaXxhV71Tm/gZIhsPYpbQi0C435dB3cri9zRu5oITBg9CwDyh6wL1BRpGqLpn7xbZWBHKFA1S52Ex/IlHT4h3MCLaQZTWC8mX6bIKzlMphrHjFuliWUjK9reUFWpLA/xvSnbBdlrft/Irk+eZ5vwHYtwoghgk0oLJSHy+yxyF5PdlRdalNQabKEx9A
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2018 20:33:26.3129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64374f42-85e3-4721-b228-08d56a7c3702
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB1415
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
 sound/soc/codecs/ak5558.c | 626 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ak5558.h |  52 ++++
 4 files changed, 686 insertions(+)
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
index 0000000..74993cf
--- /dev/null
+++ b/sound/soc/codecs/ak5558.c
@@ -0,0 +1,626 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ak5558.c  --  audio driver for AK5558 ADC
+ *
+ * Copyright (C) 2015 Asahi Kasei Microdevices Corporation
+ * Copyright 2018 NXP
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/gpio/consumer.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <linux/pm_runtime.h>
+#include <sound/initval.h>
+#include <linux/i2c.h>
+#include <sound/tlv.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
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
+static int ak5558_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
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
+static int ak5558_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	pm_runtime_disable(&client->dev);
+
+	return 0;
+}
+
+static const struct of_device_id ak5558_i2c_dt_ids[] = {
+	{ .compatible = "asahi-kasei,ak5558"},
+	{ }
+};
+
+static const struct i2c_device_id ak5558_i2c_id[] = {
+	{ "ak5558", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ak5558_i2c_id);
+
+static struct i2c_driver ak5558_i2c_driver = {
+	.driver = {
+		.name = "ak5558",
+		.of_match_table = of_match_ptr(ak5558_i2c_dt_ids),
+		.pm = &ak5558_pm,
+	},
+	.probe = ak5558_i2c_probe,
+	.remove = ak5558_i2c_remove,
+	.id_table = ak5558_i2c_id,
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
index 0000000..b2d4645
--- /dev/null
+++ b/sound/soc/codecs/ak5558.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ak5558.h  --  audio driver for AK5558
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
