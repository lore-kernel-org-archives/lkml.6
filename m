Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965174AbeBMQ4b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:56:31 -0500
Received: from mail-dm3nam03on0053.outbound.protection.outlook.com ([104.47.41.53]:23181
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934279AbeBMQzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:55:47 -0500
From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
CC: <mihai.serban@gmail.com>, <linux-imx@nxp.com>, <shegjiu.wang@nxp.com>,
        <daniel.baluta@nxp.com>, <linux-kernel@vger.kernel.org>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>,
        Mihai Serban <mihai.serban@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH v2 1/2] ASoC: codecs: Add support for AK4458 DAC driver
Date: Tue, 13 Feb 2018 16:14:47 +0200
Message-ID: <1518531288-2017-2-git-send-email-cosmin.samoila@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518531288-2017-1-git-send-email-cosmin.samoila@nxp.com>
References: <1518531288-2017-1-git-send-email-cosmin.samoila@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630145443589997;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(48376002)(53936002)(54906003)(110136005)(68736007)(6306002)(966005)(2201001)(51416003)(76176011)(106466001)(316002)(305945005)(105606002)(16586007)(498600001)(36756003)(26826003)(356003)(50466002)(81156014)(50226002)(86362001)(575784001)(47776003)(2906002)(450100002)(5660300001)(4326008)(104016004)(8936002)(8676002)(81166006)(2950100002)(336011)(6666003)(956003)(6346003)(59450400001)(97736004)(26005)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB1411;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD031;1:xRypHkfFUZkeGUAsaz3XHsVDfu5MizNg/BSwUoUga5LJOQeM/C04TQmWMk4e1mnLrc98Z9YezPF112gbyT2d9ekASnpjL/M1Eu30ZOwLg1QCaMWwLWOmmQ8nP7re99NY
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66c570b9-5dba-42d9-14b4-08d573029e89
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BLUPR03MB1411;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1411;3:YqQNHRH9nmyzL2YL9BbghLFU5xR6RmbeurBAYuDIn7OkN/GT4EC8TtpoPxmpkEHN32eijauEVfUeSxfOSlV5RZ49RzoudCXjLvJa/7Q15b+zsBuc1TAl+0bOxBop/IclcUIUBfuUXJU9HFkk1cuDPfUJs+hR9Ua6KCFEvGFnWqe7rZ8vYA82XW3Lkwnxt6mwa196BMcj3j+Ju6HEfYgx083bt55pqYq0Bls4/9DXFuRp6Omak7cHd1+JZBSYbBy9AXxM86GM4UDMatzvgsJvscjmvJ2V7NVmOH/7184Gb4jZL+Be/KAU1M5xYJkEUK5bn+8Io0xzo0GRHfIYrG6/vQxlgkPB+h27eB536v++Y+8=;25:hlkDXvEAT23Oiq05YdPC2dN6garanCcyN5UvOKgaCWYyNK8b2HbNQeJ+S1AoO3eml508/xkVcBpF2cRCTa3rGmcxn43xhL7XRDzyxn1GQDQHdC/U61u7mWmm0uxup1Q1c4/XiJ6IdGCK+vUEtvkEqq0gvRSOL9w8ulUkCuSgr6vNtWSwBvgrAx8h2NOrpeMLwEXZcutqUDACpWz4WDnF0giPMaGXFkVdjzQpXvgm4P4a9uxtBOxQL522cZ4FvQ4aOV7FViIR+9+0fC6K5l06OkJmEEWr82pM4Uy5J5Pd8/D/LvWaeCh5mDSUwi2DWhKVp5AZs9DYEzn68Sk2T9yVqA==
X-MS-TrafficTypeDiagnostic: BLUPR03MB1411:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1411;31:pUbyFAQM8GivWtUcD12GP3LuWZOcZpOeMXpSmZCBWNB586RbAKzr0fneHSPyakcTu6B1ZhGGvHCTKLv1+jdMxWbMWNYO1zTdMIg9ht5EBXrzTrHigtnwls5KHdQ31mq2+n3EKIQ0m1mzzbwnWWrETVmsp7lVx9GAmUCkaHgqSHCFZWq8ZVYuHL6eRwZ365LuxpqHCSmbjqSft0zhf/aAiYlq5OoCOnJ5h9ZVgw32vyY=;4:K9eN+vrZPacf+ybAA1vEjvo1z2GNu5hYpINzyFkr7iXX1B49dFdEfEhjTVqSitlUjLhbjX00WGHwTCT3rCh5VaP2SY705dzG0BatDRCNJ6gJnq9G/s9EaUMFwPXXMccseT18XUUJ2spFCvqZ50t4ligpGtdt0mq6JNyaECWuH+lgOgPFqeM8vaKa69x2Bzisz6+kBCv+B5zKd2w7kKjme0bdFJt/viQyWMMvrCXqYUh++t5gsJJdJziDPJy1fFHSuWEEALPnd3QdbfQmjyb69862tsDpPquiZ7xQgGVOjw53Wju/zP+DsBzAWNS/6uuF
X-Microsoft-Antispam-PRVS: <BLUPR03MB14111EE656E64204EFB0D05D9CF60@BLUPR03MB1411.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231101)(944501161)(3002001)(6055026)(6096035)(20161123561025)(20161123556025)(20161123559100)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(201708071742011);SRVR:BLUPR03MB1411;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR03MB1411;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB1411;23:5Ab/tAFF2VUkNVlMybwAKwFgNFT9XZa3doh+aZs1v?=
 =?us-ascii?Q?XfpB5y1Xn0VW7Cd8VqlOkU5iapcMGXOsJ6JSA3Zoww0mgNCAkPfyGOQx2uWJ?=
 =?us-ascii?Q?BGjAkSrq6O7cOrFM5PmlEmGMECgZ22d4wmvaQ+wFGC4ZHd9iUd+Guqzaakmn?=
 =?us-ascii?Q?DPIGEf3YrKiDoEbux2R2YptEjx2//KWoqG6BscmFgP25L5mfQ72SAwY9ee0j?=
 =?us-ascii?Q?WC2us0b5FXDQkyvOibjILBx5MNWi/6/fwJxSny9l05yESMytwQuehGfM8jT4?=
 =?us-ascii?Q?QRXCpjc8ms6TmT0ARDpvRonrdMA6CSUrQ2rOjxbgPZntH0sU5sM91+lis8wT?=
 =?us-ascii?Q?+MB+MYLmgnwPTK0kBxDESAkl7c/dm43TD6rlLiJmAa50Jc8Jwsk04A7kfY/h?=
 =?us-ascii?Q?HFMJvt5YOrs8p8Uhmia/dy6NQXN+bWgCxrnI0JdSItZfWhLc+w8VfTcBsdBs?=
 =?us-ascii?Q?EN89s9YtpyYgMxxApPz7Ed5vexcrueVQYxqhu/LK0A0+/oIaCNHAQ/IRqUHk?=
 =?us-ascii?Q?7hkmAsjCX9EqDlVAmVM3OHMiKxHg8l1AFcdoBm+jp19fml69FlHphZW3xZqY?=
 =?us-ascii?Q?1zWtl9a99Zw6DipMoRhPTEO0eVpgJGgXEdVxkO+miSE0YiKvN1PBjR3XIjQK?=
 =?us-ascii?Q?92cm07heBLd34u3AqviU/Y5P0lb2W1WmeO82A2nyQ7H4YssJZWXMWzOmNfVw?=
 =?us-ascii?Q?LUC6s7Kg2k/kvMLjstiftgdQVG4SPKq7t7dJi7fmwYcpnaW65czceI7wH2Zc?=
 =?us-ascii?Q?bs800FbysTcag0dwKENQ7zr/Qr6FR0AvBoJcuSFfps24wytc43sRoY6kfLEO?=
 =?us-ascii?Q?Q6QGMGg5bgS9YhwgecmBQpay/r7HJ/oikozkLu1eJ23AacIle2ig1l/rW7i+?=
 =?us-ascii?Q?3u8Mi9abiHkw+dIhNNTSAyyiX5zC9Rnfyp2qxwhGJ7enBjJHexwiE0QzwIUe?=
 =?us-ascii?Q?q+XO+b9lChrX6orqnp5eyN2lQu4GqPZUubdvJvqiH8TIQkLI/RAgbxsShkDT?=
 =?us-ascii?Q?q+MTx0796BmUvnbhMa0HrLvjMuPrUT0+R0Dm4E+EKCx8fGG+RFe8merLh+pg?=
 =?us-ascii?Q?/ay5faY72zEhAI/dZJFG2MqaJ0ySVT5Ra0kZJbfjbmgv5HBVKhVYUHk+bsU7?=
 =?us-ascii?Q?XJvZKjuDaBMWbQvCH8uY5y8MdJWu4XXtQj3GpuDKzsfnh3GrKepiPFWrfkbq?=
 =?us-ascii?Q?2aWIU5YVFIdK/4kfRT7+lMsuzyvTidUgHfQUVfB4KERhnaP4kZSQOdc8w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1411;6:UJFU2Co0u0I8tAjtN2kDJAoDXkh++63PaPyiozwiygNo178jBfff5be9YnIqMnujndcKLxa8kAi91zEaVBxeDf8fepG08BxSpVGVmgrw1R8zT3in4fCQHbcrkx+VfthndjZsNkoyr034w7h6IkcON+pOBqlMmYnVNaowG8xRLn1mJ6lZrULlAaULceIpmVBDd1GUsGo0UspkcRijoIYGSEzMIqIMaEPRRUE7s27Br9zIPq2VDLETRfpSwJ1vnqDcJDiaO7B9sjhG+FmSkkK/TsKvQI8BPBuP+6i45wh4/iUp1XU4DuIPCKtHSJMU35Ozd01lylHUW4dbQYAa9O7qQz9wLPlHeAvAd87IYHdnwa0=;5:jwHSw5NrJBEHzyYONGbwtQDIFRyta/eRY69Y9DwfI6exYletpFp177yYY7HQQEz3SSgWGY753xGflvHzcbtFGAKF9HrK06Xtm3n2axBGgu406pk0r1+Rm9cVfA6sEUBxi1RDi6Tpgn9Ca8xc/6ta9+qiCHVTPAGmGa9S0L8DXzM=;24:QDcqhvILd9jNi0Q6Fw5S86mNa6s3yYLNAcHxn3yvil+gJnkg7MCrYH1SyTYMcDfjOAxxTtSEJzn93O3xnKvZh3m/YdRu+fcVMX6F3RZNdZc=;7:ulVGaBAi5ESNp4EmuTiNy0hQXro58YLHbc7n7iHQXYMSmVshxu0KKw1dtt2jnes549M0PbojkIpVAzmorpn3DdtwwTxQnCF1/xgMZ8ndPWOt+1gJqj+eMawE7WRLCoDaLFJ/XbCFzEtbTjd1LtaaenTj5euC3KHS/gQHTHBSrM2ZOIw+HnQTZVv39k5YsCQKR6TC1RF0P/pJYNygZEwh9kiRXNyo2N59LLDI5Zfl96QtTe7V6iybmQEp3jLSD7c3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 16:55:42.5961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c570b9-5dba-42d9-14b4-08d573029e89
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB1411
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AK4458 is a 32-bit 8ch Premium DAC that corresponds
to a 768kHz PCM input and an 11.2MHz DSD input at maximum.
It supports I2S, DSD and TDM modes with 24 or 32 bit MSB
or 16, 24, 32 LSB formats. Its datasheet is available here:
https://www.akm.com/akm/en/file/datasheet/AK4458VN.pdf

Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
---
 sound/soc/codecs/Kconfig  |   6 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/ak4458.c | 684 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ak4458.h |  75 +++++
 4 files changed, 767 insertions(+)
 create mode 100644 sound/soc/codecs/ak4458.c
 create mode 100644 sound/soc/codecs/ak4458.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2b331f7..7f6fb5e 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -35,6 +35,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ADAU7002
 	select SND_SOC_ADS117X
 	select SND_SOC_AK4104 if SPI_MASTER
+	select SND_SOC_AK4458 if I2C
 	select SND_SOC_AK4535 if I2C
 	select SND_SOC_AK4554
 	select SND_SOC_AK4613 if I2C
@@ -375,6 +376,11 @@ config SND_SOC_AK4104
 	tristate "AKM AK4104 CODEC"
 	depends on SPI_MASTER
 
+config SND_SOC_AK4458
+	tristate "AKM AK4458 CODEC"
+	depends on I2C
+	select REGMAP_I2C
+
 config SND_SOC_AK4535
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index da15713..7f5d575 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -27,6 +27,7 @@ snd-soc-adav801-objs := adav801.o
 snd-soc-adav803-objs := adav803.o
 snd-soc-ads117x-objs := ads117x.o
 snd-soc-ak4104-objs := ak4104.o
+snd-soc-ak4458-objs := ak4458.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-ak4554-objs := ak4554.o
 snd-soc-ak4613-objs := ak4613.o
@@ -270,6 +271,7 @@ obj-$(CONFIG_SND_SOC_ADAV801)  += snd-soc-adav801.o
 obj-$(CONFIG_SND_SOC_ADAV803)  += snd-soc-adav803.o
 obj-$(CONFIG_SND_SOC_ADS117X)	+= snd-soc-ads117x.o
 obj-$(CONFIG_SND_SOC_AK4104)	+= snd-soc-ak4104.o
+obj-$(CONFIG_SND_SOC_AK4458)	+= snd-soc-ak4458.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_AK4554)	+= snd-soc-ak4554.o
 obj-$(CONFIG_SND_SOC_AK4613)	+= snd-soc-ak4613.o
diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
new file mode 100644
index 0000000..7da3f65
--- /dev/null
+++ b/sound/soc/codecs/ak4458.c
@@ -0,0 +1,684 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Audio driver for AK4458 DAC
+ *
+ * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
+ * Copyright 2018 NXP
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/pm_runtime.h>
+#include <linux/i2c.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <sound/pcm_params.h>
+
+#include "ak4458.h"
+
+/* AK4458 Codec Private Data */
+struct ak4458_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *reset_gpiod;
+	struct gpio_desc *mute_gpiod;
+	int digfil;	/* SSLOW, SD, SLOW bits */
+	int fs;		/* sampling rate */
+	int fmt;
+	int slots;
+	int slot_width;
+};
+
+static const struct reg_default ak4458_reg_defaults[] = {
+	{ 0x00, 0x0C },	/*	0x00	AK4458_00_CONTROL1	*/
+	{ 0x01, 0x22 },	/*	0x01	AK4458_01_CONTROL2	*/
+	{ 0x02, 0x00 },	/*	0x02	AK4458_02_CONTROL3	*/
+	{ 0x03, 0xFF },	/*	0x03	AK4458_03_LCHATT	*/
+	{ 0x04, 0xFF },	/*	0x04	AK4458_04_RCHATT	*/
+	{ 0x05, 0x00 },	/*	0x05	AK4458_05_CONTROL4	*/
+	{ 0x06, 0x00 },	/*	0x06	AK4458_06_DSD1		*/
+	{ 0x07, 0x03 },	/*	0x07	AK4458_07_CONTROL5	*/
+	{ 0x08, 0x00 },	/*	0x08	AK4458_08_SOUND_CONTROL	*/
+	{ 0x09, 0x00 },	/*	0x09	AK4458_09_DSD2		*/
+	{ 0x0A, 0x0D },	/*	0x0A	AK4458_0A_CONTROL6	*/
+	{ 0x0B, 0x0C },	/*	0x0B	AK4458_0B_CONTROL7	*/
+	{ 0x0C, 0x00 },	/*	0x0C	AK4458_0C_CONTROL8	*/
+	{ 0x0D, 0x00 },	/*	0x0D	AK4458_0D_CONTROL9	*/
+	{ 0x0E, 0x50 },	/*	0x0E	AK4458_0E_CONTROL10	*/
+	{ 0x0F, 0xFF },	/*	0x0F	AK4458_0F_L2CHATT	*/
+	{ 0x10, 0xFF },	/*	0x10	AK4458_10_R2CHATT	*/
+	{ 0x11, 0xFF },	/*	0x11	AK4458_11_L3CHATT	*/
+	{ 0x12, 0xFF },	/*	0x12	AK4458_12_R3CHATT	*/
+	{ 0x13, 0xFF },	/*	0x13	AK4458_13_L4CHATT	*/
+	{ 0x14, 0xFF },	/*	0x14	AK4458_14_R4CHATT	*/
+};
+
+/*
+ * Volume control:
+ * from -127 to 0 dB in 0.5 dB steps (mute instead of -127.5 dB)
+ */
+static DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
+
+/*
+ * DEM1 bit DEM0 bit Mode
+ * 0 0 44.1kHz
+ * 0 1 OFF (default)
+ * 1 0 48kHz
+ * 1 1 32kHz
+ */
+static const char * const ak4458_dem_select_texts[] = {
+	"44.1kHz", "OFF", "48kHz", "32kHz"
+};
+
+/*
+ * SSLOW, SD, SLOW bits Digital Filter Setting
+ * 0, 0, 0 : Sharp Roll-Off Filter
+ * 0, 0, 1 : Slow Roll-Off Filter
+ * 0, 1, 0 : Short delay Sharp Roll-Off Filter
+ * 0, 1, 1 : Short delay Slow Roll-Off Filter
+ * 1, *, * : Super Slow Roll-Off Filter
+ */
+static const char * const ak4458_digfil_select_texts[] = {
+	"Sharp Roll-Off Filter",
+	"Slow Roll-Off Filter",
+	"Short delay Sharp Roll-Off Filter",
+	"Short delay Slow Roll-Off Filter",
+	"Super Slow Roll-Off Filter"
+};
+
+/*
+ * DZFB: Inverting Enable of DZF
+ * 0: DZF goes H at Zero Detection
+ * 1: DZF goes L at Zero Detection
+ */
+static const char * const ak4458_dzfb_select_texts[] = {"H", "L"};
+
+/*
+ * SC1-0 bits: Sound Mode Setting
+ * 0 0 : Sound Mode 0
+ * 0 1 : Sound Mode 1
+ * 1 0 : Sound Mode 2
+ * 1 1 : Reserved
+ */
+static const char * const ak4458_sc_select_texts[] = {
+	"Sound Mode 0", "Sound Mode 1", "Sound Mode 2"
+};
+
+/* FIR2-0 bits: FIR Filter Mode Setting */
+static const char * const ak4458_fir_select_texts[] = {
+	"Mode 0", "Mode 1", "Mode 2", "Mode 3",
+	"Mode 4", "Mode 5", "Mode 6", "Mode 7",
+};
+
+/* ATS1-0 bits Attenuation Speed */
+static const char * const ak4458_ats_select_texts[] = {
+	"4080/fs", "2040/fs", "510/fs", "255/fs",
+};
+
+/* DIF2 bit Audio Interface Format Setting(BICK fs) */
+static const char * const ak4458_dif_select_texts[] = {"32fs,48fs", "64fs",};
+
+static const struct soc_enum ak4458_dac1_dem_enum =
+	SOC_ENUM_SINGLE(AK4458_01_CONTROL2, 1,
+			ARRAY_SIZE(ak4458_dem_select_texts),
+			ak4458_dem_select_texts);
+static const struct soc_enum ak4458_dac2_dem_enum =
+	SOC_ENUM_SINGLE(AK4458_0A_CONTROL6, 0,
+			ARRAY_SIZE(ak4458_dem_select_texts),
+			ak4458_dem_select_texts);
+static const struct soc_enum ak4458_dac3_dem_enum =
+	SOC_ENUM_SINGLE(AK4458_0E_CONTROL10, 4,
+			ARRAY_SIZE(ak4458_dem_select_texts),
+			ak4458_dem_select_texts);
+static const struct soc_enum ak4458_dac4_dem_enum =
+	SOC_ENUM_SINGLE(AK4458_0E_CONTROL10, 6,
+			ARRAY_SIZE(ak4458_dem_select_texts),
+			ak4458_dem_select_texts);
+static const struct soc_enum ak4458_digfil_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(ak4458_digfil_select_texts),
+			    ak4458_digfil_select_texts);
+static const struct soc_enum ak4458_dzfb_enum =
+	SOC_ENUM_SINGLE(AK4458_02_CONTROL3, 2,
+			ARRAY_SIZE(ak4458_dzfb_select_texts),
+			ak4458_dzfb_select_texts);
+static const struct soc_enum ak4458_sm_enum =
+	SOC_ENUM_SINGLE(AK4458_08_SOUND_CONTROL, 0,
+			ARRAY_SIZE(ak4458_sc_select_texts),
+			ak4458_sc_select_texts);
+static const struct soc_enum ak4458_fir_enum =
+	SOC_ENUM_SINGLE(AK4458_0C_CONTROL8, 0,
+			ARRAY_SIZE(ak4458_fir_select_texts),
+			ak4458_fir_select_texts);
+static const struct soc_enum ak4458_ats_enum =
+	SOC_ENUM_SINGLE(AK4458_0B_CONTROL7, 6,
+			ARRAY_SIZE(ak4458_ats_select_texts),
+			ak4458_ats_select_texts);
+static const struct soc_enum ak4458_dif_enum =
+	SOC_ENUM_SINGLE(AK4458_00_CONTROL1, 3,
+			ARRAY_SIZE(ak4458_dif_select_texts),
+			ak4458_dif_select_texts);
+
+static int get_digfil(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = ak4458->digfil;
+
+	return 0;
+}
+
+static int set_digfil(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	int num;
+
+	num = ucontrol->value.enumerated.item[0];
+	if (num > 4)
+		return -EINVAL;
+
+	ak4458->digfil = num;
+
+	/* write SD bit */
+	snd_soc_update_bits(codec, AK4458_01_CONTROL2,
+			    AK4458_SD_MASK,
+			    ((ak4458->digfil & 0x02) << 4));
+
+	/* write SLOW bit */
+	snd_soc_update_bits(codec, AK4458_02_CONTROL3,
+			    AK4458_SLOW_MASK,
+			    (ak4458->digfil & 0x01));
+
+	/* write SSLOW bit */
+	snd_soc_update_bits(codec, AK4458_05_CONTROL4,
+			    AK4458_SSLOW_MASK,
+			    ((ak4458->digfil & 0x04) >> 2));
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new ak4458_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("DAC1 Playback Volume", AK4458_03_LCHATT,
+			 AK4458_04_RCHATT, 0, 0xFF, 0, dac_tlv),
+	SOC_DOUBLE_R_TLV("DAC2 Playback Volume", AK4458_0F_L2CHATT,
+			 AK4458_10_R2CHATT, 0, 0xFF, 0, dac_tlv),
+	SOC_DOUBLE_R_TLV("DAC3 Playback Volume", AK4458_11_L3CHATT,
+			 AK4458_12_R3CHATT, 0, 0xFF, 0, dac_tlv),
+	SOC_DOUBLE_R_TLV("DAC4 Playback Volume", AK4458_13_L4CHATT,
+			 AK4458_14_R4CHATT, 0, 0xFF, 0, dac_tlv),
+	SOC_ENUM("AK4458 De-emphasis Response DAC1", ak4458_dac1_dem_enum),
+	SOC_ENUM("AK4458 De-emphasis Response DAC2", ak4458_dac2_dem_enum),
+	SOC_ENUM("AK4458 De-emphasis Response DAC3", ak4458_dac3_dem_enum),
+	SOC_ENUM("AK4458 De-emphasis Response DAC4", ak4458_dac4_dem_enum),
+	SOC_ENUM_EXT("AK4458 Digital Filter Setting", ak4458_digfil_enum,
+		     get_digfil, set_digfil),
+	SOC_ENUM("AK4458 Inverting Enable of DZFB", ak4458_dzfb_enum),
+	SOC_ENUM("AK4458 Sound Mode", ak4458_sm_enum),
+	SOC_ENUM("AK4458 FIR Filter Mode Setting", ak4458_fir_enum),
+	SOC_ENUM("AK4458 Attenuation transition Time Setting",
+		 ak4458_ats_enum),
+	SOC_ENUM("AK4458 BICK fs Setting", ak4458_dif_enum),
+};
+
+/* ak4458 dapm widgets */
+static const struct snd_soc_dapm_widget ak4458_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("AK4458 DAC1", NULL, AK4458_0A_CONTROL6, 2, 0),/*pw*/
+	SND_SOC_DAPM_AIF_IN("AK4458 SDTI", "Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("AK4458 AOUTA"),
+
+	SND_SOC_DAPM_DAC("AK4458 DAC2", NULL, AK4458_0A_CONTROL6, 3, 0),/*pw*/
+	SND_SOC_DAPM_OUTPUT("AK4458 AOUTB"),
+
+	SND_SOC_DAPM_DAC("AK4458 DAC3", NULL, AK4458_0B_CONTROL7, 2, 0),/*pw*/
+	SND_SOC_DAPM_OUTPUT("AK4458 AOUTC"),
+
+	SND_SOC_DAPM_DAC("AK4458 DAC4", NULL, AK4458_0B_CONTROL7, 3, 0),/*pw*/
+	SND_SOC_DAPM_OUTPUT("AK4458 AOUTD"),
+};
+
+static const struct snd_soc_dapm_route ak4458_intercon[] = {
+	{"AK4458 DAC1",		NULL,	"AK4458 SDTI"},
+	{"AK4458 AOUTA",	NULL,	"AK4458 DAC1"},
+
+	{"AK4458 DAC2",		NULL,	"AK4458 SDTI"},
+	{"AK4458 AOUTB",	NULL,	"AK4458 DAC2"},
+
+	{"AK4458 DAC3",		NULL,	"AK4458 SDTI"},
+	{"AK4458 AOUTC",	NULL,	"AK4458 DAC3"},
+
+	{"AK4458 DAC4",		NULL,	"AK4458 SDTI"},
+	{"AK4458 AOUTD",	NULL,	"AK4458 DAC4"},
+};
+
+static int ak4458_rstn_control(struct snd_soc_codec *codec, int bit)
+{
+	int ret;
+
+	if (bit)
+		ret = snd_soc_update_bits(codec,
+					  AK4458_00_CONTROL1,
+					  AK4458_RSTN_MASK,
+					  0x1);
+	else
+		ret = snd_soc_update_bits(codec,
+					  AK4458_00_CONTROL1,
+					  AK4458_RSTN_MASK,
+					  0x0);
+	return ret;
+}
+
+static int ak4458_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	u8 format;
+	int pcm_width = max(params_physical_width(params), ak4458->slot_width);
+	int nfs1;
+
+	format = snd_soc_read(codec, AK4458_00_CONTROL1);
+	format &= ~AK4458_DIF_MASK;
+
+	nfs1 = params_rate(params);
+	ak4458->fs = nfs1;
+
+	/* Master Clock Frequency Auto Setting Mode Enable */
+	snd_soc_update_bits(codec, AK4458_00_CONTROL1, 0x80, 0x80);
+
+	switch (pcm_width) {
+	case 16:
+		if (ak4458->fmt == SND_SOC_DAIFMT_I2S)
+			format |= AK4458_DIF_24BIT_I2S;
+		else
+			format |= AK4458_DIF_16BIT_LSB;
+		break;
+	case 32:
+		switch (ak4458->fmt) {
+		case SND_SOC_DAIFMT_I2S:
+			format |= AK4458_DIF_32BIT_I2S;
+			break;
+		case SND_SOC_DAIFMT_LEFT_J:
+			format |= AK4458_DIF_32BIT_MSB;
+			break;
+		case SND_SOC_DAIFMT_RIGHT_J:
+			format |= AK4458_DIF_32BIT_LSB;
+			break;
+		case SND_SOC_DAIFMT_DSP_B:
+			format |= AK4458_DIF_32BIT_MSB;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_write(codec, AK4458_00_CONTROL1, format);
+
+	ak4458_rstn_control(codec, 0);
+	ak4458_rstn_control(codec, 1);
+
+	return 0;
+}
+
+static int ak4458_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	u8 format;
+
+	/* set master/slave audio interface */
+	format = snd_soc_read(codec, AK4458_00_CONTROL1);
+
+	format &= ~AK4458_DIF_MASK;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS: /* Slave Mode */
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM: /* Master Mode is not supported */
+	case SND_SOC_DAIFMT_CBS_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
+	default:
+		dev_err(codec->dev, "Master mode unsupported\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+	case SND_SOC_DAIFMT_DSP_B:
+		ak4458->fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+		break;
+	default:
+		dev_err(codec->dev, "Audio format 0x%02X unsupported\n",
+			fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
+	/* set format */
+	snd_soc_write(codec, AK4458_00_CONTROL1, format);
+
+	ak4458_rstn_control(codec, 0);
+	ak4458_rstn_control(codec, 1);
+
+	return 0;
+}
+
+static const int att_speed[] = { 4080, 2040, 510, 255 };
+
+static int ak4458_set_dai_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	int nfs, ndt, ret, reg;
+	int ats;
+
+	nfs = ak4458->fs;
+
+	reg = snd_soc_read(codec, AK4458_0B_CONTROL7);
+	ats = (reg & 0xC0) >> 6;
+
+	ndt = att_speed[ats] / (nfs / 1000);
+
+	if (mute) { /* SMUTE: 1 , MUTE */
+		ret = snd_soc_update_bits(codec, AK4458_01_CONTROL2,  0x01, 1);
+		mdelay(ndt);
+
+		if (ak4458->mute_gpiod)
+			gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
+	} else { /* SMUTE: 0 ,NORMAL operation */
+		if (ak4458->mute_gpiod)
+			gpiod_set_value_cansleep(ak4458->mute_gpiod, 0);
+
+		ret = snd_soc_update_bits(codec, AK4458_01_CONTROL2, 0x01, 0);
+		mdelay(ndt);
+	}
+
+	return 0;
+}
+
+static int ak4458_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+			       unsigned int rx_mask, int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	int tdm_mode;
+
+	ak4458->slots = slots;
+	ak4458->slot_width = slot_width;
+
+	switch (slots * slot_width) {
+	case 128:
+		tdm_mode = 1;
+		break;
+	case 256:
+		tdm_mode = 2;
+		break;
+	case 512:
+		tdm_mode = 3;
+		break;
+	default:
+		tdm_mode = 0;
+		break;
+	}
+
+	snd_soc_update_bits(codec, AK4458_0A_CONTROL6,
+			    AK4458_TDM_MASK,
+			    (tdm_mode << AK4458_TDM_OFFSET));
+
+	return 0;
+}
+
+#define AK4458_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static const unsigned int ak4458_rates[] = {
+	8000, 11025,  16000, 22050,
+	32000, 44100, 48000, 88200,
+	96000, 176400, 192000, 352800,
+	384000, 705600, 768000, 1411200,
+	2822400,
+};
+
+static const struct snd_pcm_hw_constraint_list ak4458_rate_constraints = {
+	.count = ARRAY_SIZE(ak4458_rates),
+	.list = ak4458_rates,
+};
+
+static int ak4458_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	int ret;
+
+	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
+					 SNDRV_PCM_HW_PARAM_RATE,
+					 &ak4458_rate_constraints);
+
+	return ret;
+}
+
+static struct snd_soc_dai_ops ak4458_dai_ops = {
+	.startup        = ak4458_startup,
+	.hw_params	= ak4458_hw_params,
+	.set_fmt	= ak4458_set_dai_fmt,
+	.digital_mute	= ak4458_set_dai_mute,
+	.set_tdm_slot	= ak4458_set_tdm_slot,
+};
+
+static struct snd_soc_dai_driver ak4458_dai = {
+	.name = "ak4458-aif",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_KNOT,
+		.formats = AK4458_FORMATS,
+	},
+	.ops = &ak4458_dai_ops,
+};
+
+static void ak4458_power_off(struct ak4458_priv *ak4458)
+{
+	if (ak4458->reset_gpiod) {
+		gpiod_set_value_cansleep(ak4458->reset_gpiod, 0);
+		usleep_range(1000, 2000);
+	}
+}
+
+static void ak4458_power_on(struct ak4458_priv *ak4458)
+{
+	if (ak4458->reset_gpiod) {
+		gpiod_set_value_cansleep(ak4458->reset_gpiod, 1);
+		usleep_range(1000, 2000);
+	}
+}
+
+static void ak4458_init_reg(struct snd_soc_codec *codec)
+{
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	/* External Mute ON */
+	if (ak4458->mute_gpiod)
+		gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
+
+	ak4458_power_off(ak4458);
+	ak4458_power_on(ak4458);
+
+	snd_soc_update_bits(codec, AK4458_00_CONTROL1,
+			    0x80, 0x80);   /* ACKS bit = 1; 10000000 */
+
+	ak4458_rstn_control(codec, 0);
+	ak4458_rstn_control(codec, 1);
+}
+
+static int ak4458_codec_probe(struct snd_soc_codec *codec)
+{
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	ak4458_init_reg(codec);
+
+	ak4458->fs = 48000;
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int __maybe_unused ak4458_runtime_suspend(struct device *dev)
+{
+	struct ak4458_priv *ak4458 = dev_get_drvdata(dev);
+
+	regcache_cache_only(ak4458->regmap, true);
+
+	ak4458_power_off(ak4458);
+
+	if (ak4458->mute_gpiod)
+		gpiod_set_value_cansleep(ak4458->mute_gpiod, 0);
+
+	return 0;
+}
+
+static int __maybe_unused ak4458_runtime_resume(struct device *dev)
+{
+	struct ak4458_priv *ak4458 = dev_get_drvdata(dev);
+
+	if (ak4458->mute_gpiod)
+		gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
+
+	ak4458_power_off(ak4458);
+	ak4458_power_on(ak4458);
+
+	regcache_cache_only(ak4458->regmap, false);
+	regcache_mark_dirty(ak4458->regmap);
+
+	return regcache_sync(ak4458->regmap);
+}
+#endif /* CONFIG_PM */
+
+struct snd_soc_codec_driver soc_codec_dev_ak4458 = {
+	.probe = ak4458_codec_probe,
+
+	.component_driver = {
+		.controls = ak4458_snd_controls,
+		.num_controls = ARRAY_SIZE(ak4458_snd_controls),
+		.dapm_widgets = ak4458_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(ak4458_dapm_widgets),
+		.dapm_routes = ak4458_intercon,
+		.num_dapm_routes = ARRAY_SIZE(ak4458_intercon),
+	},
+};
+
+const struct regmap_config ak4458_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = AK4458_14_R4CHATT,
+	.reg_defaults = ak4458_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ak4458_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
+int ak4458_probe(struct device *dev, struct regmap *regmap)
+{
+	struct ak4458_priv *ak4458;
+	int ret;
+
+	ak4458 = devm_kzalloc(dev, sizeof(*ak4458), GFP_KERNEL);
+	if (!ak4458)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, ak4458);
+
+	ak4458->dev = dev;
+	ak4458->regmap = regmap;
+
+	ak4458->reset_gpiod = devm_gpiod_get_optional(dev, "reset",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(ak4458->reset_gpiod))
+		return PTR_ERR(ak4458->reset_gpiod);
+
+	ak4458->mute_gpiod = devm_gpiod_get_optional(dev, "mute",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(ak4458->mute_gpiod))
+		return PTR_ERR(ak4458->mute_gpiod);
+
+	ret = snd_soc_register_codec(dev, &soc_codec_dev_ak4458,
+				     &ak4458_dai, 1);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register CODEC: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void ak4458_remove(struct device *dev)
+{
+	snd_soc_unregister_codec(dev);
+}
+
+const struct dev_pm_ops ak4458_pm = {
+	SET_RUNTIME_PM_OPS(ak4458_runtime_suspend, ak4458_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+static int ak4458_i2c_probe(struct i2c_client *i2c)
+{
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(i2c, &ak4458_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ret = ak4458_probe(&i2c->dev, regmap);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(&i2c->dev);
+
+	return 0;
+}
+
+static int ak4458_i2c_remove(struct i2c_client *i2c)
+{
+	ak4458_remove(&i2c->dev);
+	pm_runtime_disable(&i2c->dev);
+
+	return 0;
+}
+
+static const struct of_device_id ak4458_of_match[] = {
+	{ .compatible = "asahi-kasei,ak4458", },
+	{ },
+};
+
+static struct i2c_driver ak4458_i2c_driver = {
+	.driver = {
+		.name = "ak4458",
+		.pm = &ak4458_pm,
+		.of_match_table = ak4458_of_match,
+		},
+	.probe_new = ak4458_i2c_probe,
+	.remove = ak4458_i2c_remove,
+};
+
+module_i2c_driver(ak4458_i2c_driver);
+
+MODULE_AUTHOR("Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>");
+MODULE_AUTHOR("Mihai Serban <mihai.serban@nxp.com>");
+MODULE_DESCRIPTION("ASoC AK4458 DAC driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ak4458.h b/sound/soc/codecs/ak4458.h
new file mode 100644
index 0000000..9628653
--- /dev/null
+++ b/sound/soc/codecs/ak4458.h
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Audio driver for AK4458
+ *
+ * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
+ * Copyright 2018 NXP
+ */
+
+#ifndef _AK4458_H
+#define _AK4458_H
+
+#include <linux/regmap.h>
+
+/* Settings */
+
+#define AK4458_00_CONTROL1			0x00
+#define AK4458_01_CONTROL2			0x01
+#define AK4458_02_CONTROL3			0x02
+#define AK4458_03_LCHATT			0x03
+#define AK4458_04_RCHATT			0x04
+#define AK4458_05_CONTROL4			0x05
+#define AK4458_06_DSD1				0x06
+#define AK4458_07_CONTROL5			0x07
+#define AK4458_08_SOUND_CONTROL			0x08
+#define AK4458_09_DSD2				0x09
+#define AK4458_0A_CONTROL6			0x0A
+#define AK4458_0B_CONTROL7			0x0B
+#define AK4458_0C_CONTROL8			0x0C
+#define AK4458_0D_CONTROL9			0x0D
+#define AK4458_0E_CONTROL10			0x0E
+#define AK4458_0F_L2CHATT			0x0F
+#define AK4458_10_R2CHATT			0x10
+#define AK4458_11_L3CHATT			0x11
+#define AK4458_12_R3CHATT			0x12
+#define AK4458_13_L4CHATT			0x13
+#define AK4458_14_R4CHATT			0x14
+
+/* Bitfield Definitions */
+
+/* AK4458_00_CONTROL1 (0x00) Fields
+ * Addr Register Name  D7     D6    D5    D4    D3    D2    D1    D0
+ * 00H  Control 1      ACKS   0     0     0     DIF2  DIF1  DIF0  RSTN
+ */
+
+/* Digital Filter (SD, SLOW, SSLOW) */
+#define AK4458_SD_MASK		0x20
+#define AK4458_SLOW_MASK	0x01
+#define AK4458_SSLOW_MASK	0x01
+
+/* DIF2	1 0
+ *  x	1 0 MSB justified  Figure 3 (default)
+ *  x	1 1 I2S Compliment  Figure 4
+ */
+
+#define AK4458_DIF_MASK			0x0E
+#define AK4458_DIF_MSB_LOW_FS_MODE	(2 << 1)
+#define AK4458_DIF_I2S_LOW_FS_MODE	(3 << 1)
+
+#define AK4458_DIF_16BIT_LSB	(0 << 1)
+#define AK4458_DIF_24BIT_MSB	(2 << 1)
+#define AK4458_DIF_24BIT_I2S	(3 << 1)
+#define AK4458_DIF_24BIT_LSB	(4 << 1)
+#define AK4458_DIF_32BIT_LSB	(5 << 1)
+#define AK4458_DIF_32BIT_MSB	(6 << 1)
+#define AK4458_DIF_32BIT_I2S	(7 << 1)
+
+/* AK4458_00_CONTROL1 (0x00) D0 bit */
+#define AK4458_RSTN_MASK	0x01
+#define AK4458_RSTN		(0x1 << 0)
+
+/* AK4458_0A_CONTROL6 TDM Mode bits */
+#define AK4458_TDM_OFFSET	6
+#define AK4458_TDM_MASK		(3 << AK4458_TDM_OFFSET)
+
+#endif /* _AK4458_H */
-- 
2.7.4
