Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeAaPdk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:33:40 -0500
Received: from mail-bn3nam01on0066.outbound.protection.outlook.com ([104.47.33.66]:2973
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932162AbeAaPdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:33:31 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Daniel Baluta <daniel.baluta@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <wakasugi.jb@om.asahi-kasei.co.jp>,
        <shengjiu.wang@nxp.com>, <daniel.baluta@nxp.com>,
        <mihai.serban@gmail.com>, <cosmin.samoila@nxp.com>,
        <linux-imx@nxp.com>, Mihai Serban <mihai.serban@nxp.com>
Subject: [PATCH] ASoC: codecs: Add support for AK5558 ADC driver
Date: Wed, 31 Jan 2018 14:57:39 +0200
Message-ID: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131618864087699419;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(346002)(376002)(396003)(39860400002)(39380400002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(450100002)(50226002)(956003)(8936002)(5660300001)(4326008)(508600001)(48376002)(966005)(97736004)(36756003)(105606002)(104016004)(106466001)(86362001)(2906002)(2201001)(6666003)(305945005)(53936002)(47776003)(6306002)(68736007)(8676002)(81156014)(336011)(81166006)(26005)(16586007)(356003)(110136005)(54906003)(85426001)(50466002)(51416003)(59450400001)(316002)(42866002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB1412;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD017;1:VcWFqt8bw/BfhX9I3ftAMfiEzRZO40aJHclTpCngsM1/rzoy4weA8p8KCbBYqQL0IxtGWgmW43XyC3l2/RZrkHBvvdFjrCMLGjl9sVo6iKPfrYy8/rzD/CpDP8F8nU97
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 218de027-08d5-4f1e-ae7a-08d568bffa24
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BLUPR03MB1412;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1412;3:rpVY0Jhj/Ry6qnCd+aMcoFqwK5bz8XqfiaJmRzbVzvx0HKgK2mUruIHCGMgSM88Ss93qDvLNEGRrs0v8eURO9cCuBt+fbEdivxc9sxdWSEDr5HITek43OMeNy3GWlgrJuC6XDrJfe48Q0HAxtaCQT27Pa7oj/VhZHbHmkeYYBRO5Uu0WvQm7QIMT2Mo0xhVXpAxMwbOK0O4ZTF4OCgNO48GHi6U5p0e3VBDHCuaLLSaD+qEfFJf6KP/JiCuWWg3rKgIPiv40iQ0zYJZrMIL9PrFPHRj8mcBIeUfv1rv2sUoEbicoVfP93QtRHqvY86PnJQmKN0/MbrpgJqp3znwJQuw/c4ADLtVABSqCZUz8K/w=;25:fYg7M4kKchvuGJ2hldIWrkgZoE/FeSDwHn5eGpqS7WZL3+3j0ePHq7m/4lmw0CK4ckpAV9VYTtgy4YyrppG6DRodQBjys1mPPqkJ9cnimiCAva6Yc9h/mNlrmEGeE3QyUQs6xxyLHWRvSK7q7fPjDuS82y5RmBOCC0ZDuyOk2S2ujjNfwdVOtfFrUo2O6IfgBqyMMKP3wN5OMiyMblGl8dyopz00m1fybF/8r1wj2raxrW6WJ2rt27OQZr4waQf6VFJhra+uyLmb8qOX6LsxyXulTehjBqa9IFTVaa9WTW7AK1H3yXUy7nXpbRcLiNQNISffExwV6l3rx/d9XWrExA==
X-MS-TrafficTypeDiagnostic: BLUPR03MB1412:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1412;31:HvyucQc8UKv6WKwVrTY9GJ1tEIxPAA5XwiECogSk/pQdRBBpfu9gU71w4UwHLaQN87m3JGfKwEg+505ELCortIlMP4Bf3AaZV48Rya1Awe3NEAn05NnMlpJ+OUrj+gcb+WiTQehWKKrtU3NVXoOMviL9q3Oq/oZmo+pP1DFfG8hevw4QyGKKoyvuvp8dGC0yijKYgRF1TTu7lVGxz7X1IaAamj50GePsXu4rD0uBrDs=;4:1+f3RXpQ5zWgsloCvBogKXbEkfHL8UmPiwQtIH5bp4xYVR1iA5AaQpuj2ltSxgePWWASvearHXIdkNuCwfjYzgsOrFlIq8OEqD0aZry4GzSINmn0+icdziXc6NYObQ3o5mkyWzyJDQEnOdcrrXtoIcDmQRH0hKFNJtPUdo14TYVJqU0WMiCMjbqd4L8s0j8iXCIwgBW0j/Z9cYsHNaYBcJkP9umFv7Gyc9Aczy07BoBj33pc2X6bnvZKVB3zRsK1KU8jMnOx5y/LA8x2wJwF6MVbiUACJ83RSvcd5IkDeSXf4lfea5SuqTwWNN0uHbMI
X-Microsoft-Antispam-PRVS: <BLUPR03MB141212E0E943BCFAD88C9B42F9FB0@BLUPR03MB1412.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(3002001)(10201501046)(6055026)(6096035)(20161123565025)(20161123563025)(20161123559100)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(20161123561025)(20161123556025)(201708071742011);SRVR:BLUPR03MB1412;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR03MB1412;
X-Forefront-PRVS: 056929CBB8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB1412;23:AgPQVH7wrTvNkIUqe2JIjXINNGRuaIrFbmW/KpqTQ?=
 =?us-ascii?Q?bRWh8LIIoV0ev3FPIGh8TZDdj89Zn/x3RLlYGAeNf/G4GImYhdRg0Z1uCsam?=
 =?us-ascii?Q?yNLBMOqvangKRjEG4R4N4yBW8tlLqKLomZ+jnBjMQ+Pu1AMZe19IXfSqejh9?=
 =?us-ascii?Q?sPvsYWCgEzzVq/J9UCtTySFpr1HUityN3yXhpv2ZZXpDsrdDG7JJFVuy+l2F?=
 =?us-ascii?Q?GL/na888kxJYWb6iNftv7AoYFK7mRzMK+928vyJMRRE1WfTtNGfoNpDlt7Ut?=
 =?us-ascii?Q?ql8zl29+2yqjiiDjVLgJ7JNwUb4jZ7zDlwD/uCQNFtq9VHZ8Q5tN7yBJfXxd?=
 =?us-ascii?Q?zqDpbbsTkpZzEUlkBkm8hpAyMPgHGGYAGikSFN1s1as1CYNem/KPKWNklW7g?=
 =?us-ascii?Q?gR3u0tK9P8radGIABbu2+clh7dqQwD3Zk0iQHltD4s67j75hFBDQrlwu6etZ?=
 =?us-ascii?Q?SdFDJrjWauUgCicFqvBFQ7SNtjoAkye3FXZ1ZY/PcJPDhNFmpyP0nfjVbxuG?=
 =?us-ascii?Q?NTuW5QXihGPPpNSpuSjUT7wTkLPlzcEsXU9zkHezpyRWAnDd36t6+CIIQmb4?=
 =?us-ascii?Q?bjO+yroWvuj75HTA6tEeJAfVOHktAQ1AevECOrVI7dN3zwC4+2W/Kh7QYkxm?=
 =?us-ascii?Q?Uby6f8dfnu1Bzr/JRsTclkRS9mKnBoojxPyZtGeNWanctukAm+VRiHaGYIDe?=
 =?us-ascii?Q?Xd4/0FFk0G/Sfl6daiTMH0qVz+lBNzpKx9WBwNZBNaMRzej153y1wZ51LLiy?=
 =?us-ascii?Q?62Vv9zLewZ/JHeEUWoQzwjLpEylg1a081OW/E8j+z8ZJkNGV+w5d4ZbNkx5q?=
 =?us-ascii?Q?+QELA42+DLZCnrJAyS9YIim9vbiKu1bqHzclEO67/qMn2xnRnbXtbm0MMpDA?=
 =?us-ascii?Q?oFLvtLdNH2M/LsNy6Jf4wHvNlay2MCPPPJxFBv0IuPaHl1fX8d+o0RHy8Nnn?=
 =?us-ascii?Q?XLTMDTvPC+lC2VX8nZOmW2O7KJbqA/dtxdFUJnU0LnGi+6FhnXuTSROUgZbN?=
 =?us-ascii?Q?q36G5Q6hjo8YUNeIXZkxNuLS4jjvraGALT6FyUnuTX0JX52Bngu4DGlO9u3D?=
 =?us-ascii?Q?mMYYxLzcKHqBfBijmSyeRfwlLGOTfrPXiDeypOdyDXM82PrFCrEG8D/296mO?=
 =?us-ascii?Q?aMf3sGRGa4laB2Czpe59HnUuTqAcXV9qlJDQMB7NvpRPhqAVnj94+ejYaxBG?=
 =?us-ascii?Q?L4mCFKvXaaWf4s=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1412;6:B1hkKd8hcF9uhKngXDadASlFGWCxrdVrzUhdbnKyyYkAGgc2a9j1RB1tTqqI96oGekcGDqoEqkLIqI4U5umpUp/x/Ef17DOLepwOxRt5RkdAjDFwaGg1LaNMZCkgfFRPQ8qfulSeqB7f23ejzfsDOzkybWkiX6JbB31T20LJ9JLFR9baStiQ9JnNsqLR+Ml+WdgQ0e0z3WkPWpInJKolX/GUPuXIPqX+wvqdJ59ohSgvQuGzr5BFZqB3081WIyYJL8n3n92Bky15GXUHelWWOdKRazuBTZ1iasL5s5WeQAxCGC/FveE0LwQSv1d98DypidBHsfES34QBl+bCGtD7YKbdT+NnJSKW85PdIJZ3b4A=;5:X6S7YWbaSyG4BrRr1SY6fve+Y/KWu3UP1/zq35aYErWzZgt+ciZNwtJ19UOUNaVc6/oo47xhXmaj8nEDC95uyjpvF9vSB+TEzcKkmEpa5mhb9lS93HNgKMDIJVx2BZlN/FGHuNoLZub1XguulNei44iJaktANBLgrRTlfpaWokY=;24:UPkBJ4mq0CtwV5FoST7m4O+xzbW5dZFk8+kdEVpcp/RLIVaBVsiMMwMrAESLPYI+bB8rrR2JYeNY+5k32ROGtLS1W7i6t3mH25YoRTmYJOU=;7:xwl3Bev95EgsLPxzW0i5/VnU4we+wnVsrvDSeO7cP7PMomQnY9mQghFW6oeZyCYSDeLMBM5MGpy2jEstETOr8npCLxkTC08NBdHnJq++Her7jLGcnIdlqmc2e7ot51iPCOimnDa+0rLlxVOgllJCnDC9Z7ffQo3QaWyxIc6d9ocf/gS+DYOPi7a/J4BX7YjlVkLDqy3EsL2fgpN0UpCIyOenIitihXFVdecQ67FupFRZybfg1e3YPdoryckLColU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2018 15:33:26.9759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 218de027-08d5-4f1e-ae7a-08d568bffa24
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
Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/sound/ak5558.txt |  20 +
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/ak5558.c                          | 754 +++++++++++++++++++++
 sound/soc/codecs/ak5558.h                          |  60 ++
 5 files changed, 842 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
 create mode 100644 sound/soc/codecs/ak5558.c
 create mode 100644 sound/soc/codecs/ak5558.h

diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
new file mode 100644
index 0000000..c6c71af
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak5558.txt
@@ -0,0 +1,20 @@
+AK5558 8 channel differential 32-bit delta-sigma ADC
+
+This device supports I2C mode only.
+
+Required properties:
+
+- compatible : "asahi-kasei,ak5558"
+- reg : The I2C address of the device for I2C.
+- asahi-kasei,pdn-gpios: A GPIO specifier for the GPIO controlling
+	the power down & reset pin.
+
+Example:
+
+&i2c {
+	ak5558: ak5558@10 {
+		compatible = "asahi-kasei,ak5558";
+		reg = <0x10>;
+		asahi-kasei,pdn-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+	};
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c367d11..84a15d4 100644
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
@@ -394,6 +395,11 @@ config SND_SOC_AK4671
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
index 77c1818..3a3d8b1 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -33,6 +33,7 @@ snd-soc-ak4641-objs := ak4641.o
 snd-soc-ak4642-objs := ak4642.o
 snd-soc-ak4671-objs := ak4671.o
 snd-soc-ak5386-objs := ak5386.o
+snd-soc-ak5558-objs := ak5558.o
 snd-soc-arizona-objs := arizona.o
 snd-soc-bt-sco-objs := bt-sco.o
 snd-soc-cq93vc-objs := cq93vc.o
@@ -271,6 +272,7 @@ obj-$(CONFIG_SND_SOC_AK4641)	+= snd-soc-ak4641.o
 obj-$(CONFIG_SND_SOC_AK4642)	+= snd-soc-ak4642.o
 obj-$(CONFIG_SND_SOC_AK4671)	+= snd-soc-ak4671.o
 obj-$(CONFIG_SND_SOC_AK5386)	+= snd-soc-ak5386.o
+obj-$(CONFIG_SND_SOC_AK5558)	+= snd-soc-ak5558.o
 obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
 obj-$(CONFIG_SND_SOC_ALC5632)	+= snd-soc-alc5632.o
 obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
new file mode 100644
index 0000000..eeaeea9
--- /dev/null
+++ b/sound/soc/codecs/ak5558.c
@@ -0,0 +1,754 @@
+/*
+ * ak5558.c  --  audio driver for AK5558 ADC
+ *
+ * Copyright (C) 2015 Asahi Kasei Microdevices Corporation
+ * Copyright 2018 NXP
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/gpio/consumer.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/pm_runtime.h>
+
+#include "ak5558.h"
+
+#define AK5558_SLAVE_CKS_AUTO
+
+/* AK5558 Codec Private Data */
+struct ak5558_priv {
+	struct snd_soc_codec codec;
+	struct regmap *regmap;
+	struct i2c_client *i2c;
+	int fs;		/* Sampling Frequency */
+	int rclk;	/* Master Clock */
+	int pdn_gpio;	/* Power on / Reset GPIO */
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
+#ifndef AK5558_SLAVE_CKS_AUTO
+	int mcki_rate;
+#endif
+
+	dev_dbg(codec->dev, "%s fs=%d rclk=%d\n", __func__, fs, rclk);
+
+	mode = snd_soc_read(codec, AK5558_02_CONTROL1);
+	mode &= ~AK5558_CKS;
+
+#ifdef AK5558_SLAVE_CKS_AUTO
+	mode |= AK5558_CKS_AUTO;
+#else
+	if (fs != 0 && rclk != 0) {
+		if (rclk % fs)
+			return -EINVAL;
+		mcki_rate = rclk / fs;
+
+		if (fs > 400000) {
+			switch (mcki_rate) {
+			case 32:
+				mode |= AK5558_CKS_32FS_768KHZ;
+				break;
+			case 48:
+				mode |= AK5558_CKS_48FS_768KHZ;
+				break;
+			case 64:
+				mode |= AK5558_CKS_64FS_768KHZ;
+				break;
+			default:
+				return -EINVAL;
+			}
+		} else if (fs > 200000) {
+			switch (mcki_rate) {
+			case 64:
+				mode |= AK5558_CKS_64FS_384KHZ;
+				break;
+			case 96:
+				mode |= AK5558_CKS_96FS_384KHZ;
+				break;
+			default:
+				return -EINVAL;
+			}
+		} else if (fs > 108000) {
+			switch (mcki_rate) {
+			case 128:
+				mode |= AK5558_CKS_128FS_192KHZ;
+				break;
+			case 192:
+				mode |= AK5558_CKS_192FS_192KHZ;
+				break;
+			default:
+				return -EINVAL;
+			}
+		} else if (fs > 54000) {
+			switch (mcki_rate) {
+			case 256:
+				mode |= AK5558_CKS_256FS_96KHZ;
+				break;
+			case 384:
+				mode |= AK5558_CKS_384FS_96KHZ;
+				break;
+			default:
+				return -EINVAL;
+			}
+		} else {
+			switch (mcki_rate) {
+			case 256:
+				mode |= AK5558_CKS_256FS_48KHZ;
+				break;
+			case 384:
+				mode |= AK5558_CKS_384FS_48KHZ;
+				break;
+			case 512:
+				mode |= AK5558_CKS_512FS_48KHZ;
+				break;
+			case 768:
+				mode |= AK5558_CKS_768FS_48KHZ;
+				break;
+			case 1024:
+				if (fs > 32000)
+					return -EINVAL;
+				mode |= AK5558_CKS_1024FS_16KHZ;
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+	}
+#endif
+	snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_CKS,  mode);
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
+	dev_dbg(dai->dev, "%s(%d)\n", __func__, __LINE__);
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
+	dev_dbg(dai->dev, "%s(%d)\n", __func__, __LINE__);
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
+	dev_dbg(dai->dev, "%s(%d)\n", __func__, __LINE__);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+#ifdef AK5558_SLAVE_CKS_AUTO
+		break;
+#else
+		return -EINVAL;
+#endif
+	case SND_SOC_DAIFMT_CBS_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
+	default:
+		dev_err(codec->dev, "Clock mode unsupported");
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
+	int ndt;
+
+	if (mute) {
+		ndt = 0;
+		if (ak5558->fs != 0)
+			ndt = 583000 / ak5558->fs;
+		if (ndt < 5)
+			ndt = 5;
+		msleep(ndt);
+	}
+
+	return 0;
+}
+
+static int ak5558_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	dev_dbg(codec->dev, "%s bias level=%d\n", __func__, (int)level);
+
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
+	int tdm_mode = 0;
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
+	int ret;
+
+	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
+					 SNDRV_PCM_HW_PARAM_RATE,
+					 &ak5558_rate_constraints);
+	return ret;
+}
+
+static struct snd_soc_dai_ops ak5558_dai_ops = {
+	.startup        = ak5558_startup,
+	.hw_params	= ak5558_hw_params,
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
+static int ak5558_init_reg(struct snd_soc_codec *codec)
+{
+	int  ret;
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+
+	dev_dbg(codec->dev, "%s(%d)\n", __func__, __LINE__);
+
+	usleep_range(10000, 11000);
+	if (gpio_is_valid(ak5558->pdn_gpio)) {
+		gpio_set_value_cansleep(ak5558->pdn_gpio, 0);
+		usleep_range(1000, 2000);
+		gpio_set_value_cansleep(ak5558->pdn_gpio, 1);
+		usleep_range(1000, 2000);
+	}
+
+	ret = snd_soc_write(codec, AK5558_00_POWER_MANAGEMENT1, 0x0);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_CKS,
+				  AK5558_CKS_AUTO);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int ak5558_probe(struct snd_soc_codec *codec)
+{
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+
+	dev_dbg(codec->dev, "%s(%d)\n", __func__, __LINE__);
+
+	ret = ak5558_init_reg(codec);
+
+	ak5558->fs = 48000;
+	ak5558->rclk = 0;
+
+	return ret;
+}
+
+static int ak5558_remove(struct snd_soc_codec *codec)
+{
+	struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
+
+	ak5558_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	if (gpio_is_valid(ak5558->pdn_gpio)) {
+		gpio_set_value_cansleep(ak5558->pdn_gpio, 0);
+		usleep_range(1000, 2000);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ak5558_runtime_suspend(struct device *dev)
+{
+	struct ak5558_priv *ak5558 = dev_get_drvdata(dev);
+
+	regcache_cache_only(ak5558->regmap, true);
+
+	if (gpio_is_valid(ak5558->pdn_gpio)) {
+		gpio_set_value_cansleep(ak5558->pdn_gpio, 0);
+		usleep_range(1000, 2000);
+	}
+
+	return 0;
+}
+
+static int ak5558_runtime_resume(struct device *dev)
+{
+	struct ak5558_priv *ak5558 = dev_get_drvdata(dev);
+
+	if (gpio_is_valid(ak5558->pdn_gpio)) {
+		gpio_set_value_cansleep(ak5558->pdn_gpio, 0);
+		usleep_range(1000, 2000);
+		gpio_set_value_cansleep(ak5558->pdn_gpio, 1);
+		usleep_range(1000, 2000);
+	}
+
+	regcache_cache_only(ak5558->regmap, false);
+	regcache_mark_dirty(ak5558->regmap);
+
+	return regcache_sync(ak5558->regmap);
+}
+#endif
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
+	struct device_node *np = i2c->dev.of_node;
+	struct ak5558_priv *ak5558;
+	int ret = 0;
+
+	dev_err(&i2c->dev, "%s(%d)\n", __func__, __LINE__);
+
+	ak5558 = devm_kzalloc(&i2c->dev, sizeof(struct ak5558_priv),
+			      GFP_KERNEL);
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
+	ak5558->pdn_gpio = of_get_named_gpio(np, "ak5558,pdn-gpio", 0);
+	if (gpio_is_valid(ak5558->pdn_gpio)) {
+		ret = devm_gpio_request_one(&i2c->dev, ak5558->pdn_gpio,
+					    GPIOF_OUT_INIT_LOW, "ak5558,pdn");
+		if (ret) {
+			dev_err(&i2c->dev, "unable to get pdn gpio\n");
+			return ret;
+		}
+	}
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
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ak5558.h b/sound/soc/codecs/ak5558.h
new file mode 100644
index 0000000..0e40c4a
--- /dev/null
+++ b/sound/soc/codecs/ak5558.h
@@ -0,0 +1,60 @@
+/*
+ * ak5558.h  --  audio driver for AK5558
+ *
+ * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
+ * Copyright 2018 NXP
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
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
+#define AK5558_DIF			0x02
+#define AK5558_DIF_MSB_MODE		(0 << 1)
+#define AK5558_DIF_I2S_MODE		(1 << 1)
+
+#define AK5558_BITS			0x04
+#define AK5558_DIF_24BIT_MODE		(0 << 2)
+#define AK5558_DIF_32BIT_MODE		(1 << 2)
+
+#define AK5558_CKS			0x78
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
+#define AK5558_MODE_BITS	0x60
+#define AK5558_MODE_NORMAL	(0 << 5)
+#define AK5558_MODE_TDM128	(1 << 5)
+#define AK5558_MODE_TDM256	(2 << 5)
+#define AK5558_MODE_TDM512	(3 << 5)
+
+#endif
-- 
2.7.4
