Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032015AbeBNP5Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:57:25 -0500
Received: from mail-dm3nam03on0059.outbound.protection.outlook.com ([104.47.41.59]:57632
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031854AbeBNPzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:55:53 -0500
From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
CC: <mihai.serban@gmail.com>, <linux-imx@nxp.com>, <shegjiu.wang@nxp.com>,
        <daniel.baluta@nxp.com>, <linux-kernel@vger.kernel.org>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>,
        Mihai Serban <mihai.serban@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH v3 1/2] ASoC: codecs: Add support for AK4458 DAC driver
Date: Wed, 14 Feb 2018 15:21:06 +0200
Message-ID: <1518614467-20613-2-git-send-email-cosmin.samoila@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518614467-20613-1-git-send-email-cosmin.samoila@nxp.com>
References: <1518614467-20613-1-git-send-email-cosmin.samoila@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630973518367775;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(39380400002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(2950100002)(106466001)(6666003)(76176011)(305945005)(51416003)(336011)(356003)(47776003)(54906003)(966005)(575784001)(110136005)(316002)(2201001)(16586007)(48376002)(68736007)(6346003)(36756003)(26005)(86362001)(26826003)(5660300001)(53936002)(50226002)(498600001)(50466002)(6306002)(956003)(59450400001)(105606002)(104016004)(8936002)(81156014)(2906002)(4326008)(97736004)(8676002)(81166006)(450100002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB1411;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD001;1:k3ZB/zBhUc1AtXCfCY9ZoPJH1V9jPNLauR2iHKCsuo1feS3WAaz31avdsLiG7M1xRpTLqjJxBqXFC7zxHE0JDaCZnZJfU/620O1xQoZjnWciKeNbtEawVpQMGunYX9AE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 830e8769-e338-4163-eabe-08d573c36c74
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BLUPR03MB1411;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1411;3:g7uxKWJ++fKBWGMLhxw4dlaMKH/5J1N9yJV3Cn4IBq0XOiT/5bYVi/zbks0V5D+J7ln3wyMQvYAzcG+bIj93TbtsxS7Kd47GiFDA78XpH9zxhm9kRFXfBwlIZFUuIPWadXcvICWxW6AZyPV9td3+5OeGUBPCBFqbcRN8lzDj/gpsOPJfKy55sGppn/wjGfG+VeRQSqVN16mYBDFDNfQ9MRsN1KbVxTzCZbwLBOPVrBle4EtQ4ufIh+sn9Og61G0e+dSjhRKGBiw2f5zixhC567FshyC4wdmMjhQmFCyNTERmGNrs+nQkOC9RxbD7E9Vm6FKb6SmxC+vfWUTb4MQrfUr8LmSoWpNfX8C3e9isHLA=;25:0x10KYqtgZePJs9GO7zLZa0i8fYxHb9ZfVOvgyRc8z3uwU2FDMe3nFuePgj3+C4QJGluzfqSeTqFt9lJVi0JVd2aizIgQ2K95oYDnT5E+e0QXdwezR8rfVls1jxp07Pmkj1vJVkbYrhjCEztRS4GEn+aaYvL4CXCpKsMwGLAK+BwiaFYG9ucFA2Wx+SpfIzy+oeBXKOkX0xcOn56XHcA1yloU3e2wyfC9Zk92tD0PAYWOA8LCw2sL5dP+CV74UnWBDurMTw2LaDVMmQwJgdoYleksmZYD/9pCWEqUMioFMp+vWlarZak4mx4Kiiw0T04qR9Nc6Mc5pjdIZsHE2A0vA==
X-MS-TrafficTypeDiagnostic: BLUPR03MB1411:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1411;31:hc2WWZMg8qJwly5xF0IrKUMLkYgeQ0fqJFOtSy9bXlPE5H8wdaO/kMr8KYGj1EKnfSp/5g9aABEMK0ulqt+u6XDnaCQN56HbE8mpxsQnVJWUOIJkyuj4ONt8dsL+oUNd8MJXcBZAewO1ZgHPmtrnDobieoAUEMP2lwWb3QQE/tDXS7pXtYWJyrAp55eogcqNPwDVco7vqdRbFvM5Fk19MmAJQ3IPYCAPPBQ2jlw+6i8=;4:k8yZ0b/uM3k/faqvUNzOTEgd8+THi6eoHJHXKd8fzxzPj1aurSVhsuOnHQ67dzgeeZdk6Vs1LS3XDjIq9OQkBThEHajxtZYZG6oFfWpwKaAG9EeW7FiXdS/T5qoy7urJweyryZ26hv86OnnBwfgtySJ73jD01uqKgwZ9M2x1pDGebU6sc7a6ozEKdE08DOO04gSTkra/NmVWH0HnOE4jF2ze/q6UExHbnWAo9oDhUyljovv9KrPM4ZjwThsv5A+dImVooOeOjp3mH3mAkWBpNpcY6IsEnQyFwZovt5AIJov0G+XPL4L5HFkOGwDPx7KL
X-Microsoft-Antispam-PRVS: <BLUPR03MB141146F3407B56BBFB13D5A19CF50@BLUPR03MB1411.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231101)(944501161)(10201501046)(93006095)(93001095)(3002001)(6055026)(6096035)(20161123556025)(20161123559100)(20161123561025)(20161123565025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123563025)(201708071742011);SRVR:BLUPR03MB1411;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR03MB1411;
X-Forefront-PRVS: 0583A86C08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB1411;23:o1yBZDs4NsyMFzM7z/dul0MIk2Qtt0oaQEuqO/1Tt?=
 =?us-ascii?Q?C0+hfHIhr03335WxtelDcAa+Lxcax/hZntKHONMQKNQnwNj4DMYJf9Euk3LA?=
 =?us-ascii?Q?N2BHR3WJoD/QQfoy+PpQ2fJBytoVihz9nTrxpEX4rqRY8FCZexingF9Qf4TK?=
 =?us-ascii?Q?KVryZyMkheQXlmtpoyPZGpjpzsPt7hvqJHacsT+tRSDJmOiuSgkVgj2MqLf9?=
 =?us-ascii?Q?JmdDkvNDlwKWYNSpeoyhPuVETZ8WoRpSv+1mwJ741iaIKedxxElBy/JKcNJn?=
 =?us-ascii?Q?v5WoMq8toNmxF2cj2pz7iIG/7W4BiiKoN1tC8y9M6g+6vB5lILq3saRG53FV?=
 =?us-ascii?Q?7pNyuf3vPlsQcqBb8QEIiX2t28iC5D+CBkmSNp2h1Pj1WYrAN3NDOncgbPVS?=
 =?us-ascii?Q?wYlMtlXKGrFrUu50DHCVx9rhsEPDFoeCHCv215k+Wv6CqR2HnMeSI4KNbp1S?=
 =?us-ascii?Q?Sy4b6kUZiVaA7LiLMRYg+O22OxcgT3zWS2kczLVgOnJM0WeBcTGbLnA+/nzL?=
 =?us-ascii?Q?NHpOwC0eHztizdovBLMOPktn5BA8gJ/gTqMuGTG9wi3FOqCSrcBkjrVf7msc?=
 =?us-ascii?Q?aScrFRYSKLMNQAwU4OowO9r/QqGTXl1UbFEP+Qx/Zq31tywGiAKK8n/+DSv+?=
 =?us-ascii?Q?KHRwhSfwZ8GC6PbtxDSjFlDCwVCkoXapA3Fn2O0cey6JWl7z5eGNIg+UJB6H?=
 =?us-ascii?Q?gpbW9c9zHOOeTw/a29fZD05yrgJIHSEj7yGm6RWjAmOHMVzCx/v8cixUzMqe?=
 =?us-ascii?Q?n51o18eZ1AfMlQCe06UBvssa6YqPBsWhRRwEwNbqd9yaFt82WjASWapVxlCg?=
 =?us-ascii?Q?PxTA8FGnIMruRPiI8+h1bsvx3cwbFTpN2TpYsoxwQ7a6j/VJIYCk5m1elYws?=
 =?us-ascii?Q?vBXtmkwO2KfkDtbfLWztdeljUy4ajE8cLQ6dYWUmBp8hnr9reNBzZtzHBXf4?=
 =?us-ascii?Q?vJtq7XfuWbmBz1L1pFWtJ9TE+2a8VkBvaxJuwN1Imucmx0TkxnH+Ih2o55Gd?=
 =?us-ascii?Q?1ubyhg7LCLrJpB8Tc2R0UYxKWMzIXuS3NPqroQmMHWBJUbOmud6GLIh42Kf2?=
 =?us-ascii?Q?TN/gC8cEchP+LGfbqBKL5+6y1m/ViJYkavurD2vVcUwkAgfnhvQsd7L4umLF?=
 =?us-ascii?Q?wcEnt+CPb17g2kk7jk5xq2ySevES1zmTqOeWisQSD6a2BoKVmL6/ZpSG9aGI?=
 =?us-ascii?Q?qQKUQSvJ/02vi7NQS4FpEsA6QYzn3DXMKAleM40qwYwXAFG2W00X1cJvg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1411;6:Jxfgq47eAJUOjtM5V8tFLDg7MsMrjEsY6cR2F+HHgz/R4pdJKX7U58rvLc8Ha6+LmwTaggpByyQsMf9ku8NUC4GHX9ZHLxvkzHm6LEAhJIKRab5xkXsdn4ftes2Y5dJppWmYSA6Dux+M13XZfkKHiDxpTZ0E2C/5PSe1OdE6l4t6Ry8TWHuBmGN++C6JEgZweJ6qL8iX4v1pLCHArc9h8GV7qnTlyOqHaPkQhA11Gx6h9uSVct7FeGpLoon3gYtcDeOjX2ORy/1Dv7hu8SEP6UZTF9hqqlX4kWrAsnjSCNs1CtNl7o20EYq6nnmwsUAvqpH5otDHpsDQIqPsYSoNOAxMiDafiIiazCu9wyeTLFU=;5:7/9d4zd0jkUOd99RZ8tVe1ErURE1/hEv+dUjOIsFGciFRxXFZdx734BQcEdMjv7Yo1XDmgOvr7JFcx+Mt9TFeiAVjKQHWWobiuNIwTDpoQpTHOOblhs5udeH1UEuRwoX/nXn3GLqLZQy9P7KhMzT2dQMdiZjxFW5KXodcgRCJYU=;24:Of1tIMiViM2GIRtal2uKbKSXmI1FZ5pWSJ4Vi5eEdsG0IaEhq4P+CqMu4LqrbP/LJgtUFXVdZNettdZaTY3dHM4p4+s+09/HaVbV9G22KGk=;7:r36VtXTVJRpjLjqs4QJPiX0EVDClBGW3NgHTo4/lO3k92T78lXMGiaMIagxxBAqaTWhp/fQUXTXOa3rJdLXi37gGt33GBOvZ0xunDeJwZjx6/8A+WyZqOwhd4qmp6kJtoF2ZGxMFzNGdxyEXJXatmQT6bYGuh/gRFFC7nVhhsnLLaCzRV8NN3TxXFHXq42IHfEQJThCkFpn7v1BFQNA1KrrAxUtVLPrwIh9+kc9UepcB/Ioo2bF7E+VNLct4F7T6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 15:55:51.1659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 830e8769-e338-4163-eabe-08d573c36c74
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
 sound/soc/codecs/ak4458.c | 659 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ak4458.h |  86 ++++++
 4 files changed, 753 insertions(+)
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
index 4053c72..339b674 100644
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
index 0000000..b579cda
--- /dev/null
+++ b/sound/soc/codecs/ak4458.c
@@ -0,0 +1,659 @@
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
+	int pcm_width = max(params_physical_width(params), ak4458->slot_width);
+	int nfs1;
+	u8 format;
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
+			format = AK4458_DIF_24BIT_I2S;
+		else
+			format = AK4458_DIF_16BIT_LSB;
+		break;
+	case 32:
+		switch (ak4458->fmt) {
+		case SND_SOC_DAIFMT_I2S:
+			format = AK4458_DIF_32BIT_I2S;
+			break;
+		case SND_SOC_DAIFMT_LEFT_J:
+			format = AK4458_DIF_32BIT_MSB;
+			break;
+		case SND_SOC_DAIFMT_RIGHT_J:
+			format = AK4458_DIF_32BIT_LSB;
+			break;
+		case SND_SOC_DAIFMT_DSP_B:
+			format = AK4458_DIF_32BIT_MSB;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, AK4458_00_CONTROL1,
+			    AK4458_DIF_MASK, format);
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
+	ats = (reg & AK4458_ATS_MASK) >> AK4458_ATS_SHIFT;
+
+	ndt = att_speed[ats] / (nfs / 1000);
+
+	if (mute) {
+		ret = snd_soc_update_bits(codec, AK4458_01_CONTROL2,  0x01, 1);
+		mdelay(ndt);
+		if (ak4458->mute_gpiod)
+			gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
+	} else {
+		if (ak4458->mute_gpiod)
+			gpiod_set_value_cansleep(ak4458->mute_gpiod, 0);
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
+	int mode;
+
+	ak4458->slots = slots;
+	ak4458->slot_width = slot_width;
+
+	switch (slots * slot_width) {
+	case 128:
+		mode = AK4458_MODE_TDM128;
+		break;
+	case 256:
+		mode = AK4458_MODE_TDM256;
+		break;
+	case 512:
+		mode = AK4458_MODE_TDM512;
+		break;
+	default:
+		mode = AK4458_MODE_NORMAL;
+		break;
+	}
+
+	snd_soc_update_bits(codec, AK4458_0A_CONTROL6,
+			    AK4458_MODE_MASK,
+			    mode);
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
+static void ak4458_init(struct snd_soc_codec *codec)
+{
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	/* External Mute ON */
+	if (ak4458->mute_gpiod)
+		gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
+
+	ak4458_power_on(ak4458);
+
+	snd_soc_update_bits(codec, AK4458_00_CONTROL1,
+			    0x80, 0x80);   /* ACKS bit = 1; 10000000 */
+
+	ak4458_rstn_control(codec, 1);
+}
+
+static int ak4458_probe(struct snd_soc_codec *codec)
+{
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	ak4458_init(codec);
+
+	ak4458->fs = 48000;
+
+	return 0;
+}
+
+static int ak4458_remove(struct snd_soc_codec *codec)
+{
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	ak4458_power_off(ak4458);
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
+	.probe = ak4458_probe,
+	.remove = ak4458_remove,
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
+const struct dev_pm_ops ak4458_pm = {
+	SET_RUNTIME_PM_OPS(ak4458_runtime_suspend, ak4458_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+static int ak4458_i2c_probe(struct i2c_client *i2c)
+{
+	struct ak4458_priv *ak4458;
+	int ret;
+
+	ak4458 = devm_kzalloc(&i2c->dev, sizeof(*ak4458), GFP_KERNEL);
+	if (!ak4458)
+		return -ENOMEM;
+
+	ak4458->regmap = devm_regmap_init_i2c(i2c, &ak4458_regmap);
+	if (IS_ERR(ak4458->regmap))
+		return PTR_ERR(ak4458->regmap);
+
+	i2c_set_clientdata(i2c, ak4458);
+	ak4458->dev = &i2c->dev;
+
+	ak4458->reset_gpiod = devm_gpiod_get_optional(ak4458->dev, "reset",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(ak4458->reset_gpiod))
+		return PTR_ERR(ak4458->reset_gpiod);
+
+	ak4458->mute_gpiod = devm_gpiod_get_optional(ak4458->dev, "mute",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(ak4458->mute_gpiod))
+		return PTR_ERR(ak4458->mute_gpiod);
+
+	ret = snd_soc_register_codec(ak4458->dev, &soc_codec_dev_ak4458,
+				     &ak4458_dai, 1);
+	if (ret < 0) {
+		dev_err(ak4458->dev, "Failed to register CODEC: %d\n", ret);
+		return ret;
+	}
+
+	pm_runtime_enable(&i2c->dev);
+
+	return 0;
+}
+
+static int ak4458_i2c_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_codec(&i2c->dev);
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
index 0000000..16d9d22
--- /dev/null
+++ b/sound/soc/codecs/ak4458.h
@@ -0,0 +1,86 @@
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
+#define AK4458_SD_MASK		GENMASK(5, 5)
+#define AK4458_SLOW_MASK	GENMASK(0, 0)
+#define AK4458_SSLOW_MASK	GENMASK(0, 0)
+
+/* DIF2	1 0
+ *  x	1 0 MSB justified  Figure 3 (default)
+ *  x	1 1 I2S Compliment  Figure 4
+ */
+#define AK4458_DIF_SHIFT	1
+#define AK4458_DIF_MASK		GENMASK(3, 1)
+
+#define AK4458_DIF_16BIT_LSB	(0 << 1)
+#define AK4458_DIF_24BIT_I2S	(3 << 1)
+#define AK4458_DIF_32BIT_LSB	(5 << 1)
+#define AK4458_DIF_32BIT_MSB	(6 << 1)
+#define AK4458_DIF_32BIT_I2S	(7 << 1)
+
+/* AK4458_00_CONTROL1 (0x00) D0 bit */
+#define AK4458_RSTN_MASK	GENMASK(0, 0)
+#define AK4458_RSTN		(0x1 << 0)
+
+/* AK4458_0A_CONTROL6 Mode bits */
+#define AK4458_MODE_SHIFT	6
+#define AK4458_MODE_MASK	GENMASK(7, 6)
+#define AK4458_MODE_NORMAL	(0 << AK4458_MODE_SHIFT)
+#define AK4458_MODE_TDM128	(1 << AK4458_MODE_SHIFT)
+#define AK4458_MODE_TDM256	(2 << AK4458_MODE_SHIFT)
+#define AK4458_MODE_TDM512	(3 << AK4458_MODE_SHIFT)
+
+/* DAC Digital attenuator transition time setting
+ * Table 19
+ * Mode	ATS1	ATS2	ATT speed
+ * 0	0	0	4080/fs
+ * 1	0	1	2040/fs
+ * 2	1	0	510/fs
+ * 3	1	1	255/fs
+ * */
+#define AK4458_ATS_SHIFT	6
+#define AK4458_ATS_MASK		GENMASK(7, 6)
+
+#endif /* _AK4458_H */
-- 
2.7.4
