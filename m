Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeFEOXy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:23:54 -0400
Received: from mail-co1nam03on0044.outbound.protection.outlook.com ([104.47.40.44]:24722
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752269AbeFEOXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:23:51 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <mchehab@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
        <rdunlap@infradead.org>, <lukas@wunner.de>,
        <Ismail.Kose@maximintegrated.com>, <vilhelm.gray@gmail.com>,
        <sean.nyekjaer@prevas.dk>, <pombredanne@nexb.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 1/2] iio: dac: Add AD5758 support
Date: Tue, 5 Jun 2018 17:22:56 +0300
Message-ID: <1528208576-14978-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(396003)(346002)(2980300002)(438002)(199004)(189003)(48376002)(8666007)(51416003)(47776003)(50466002)(110136005)(54906003)(575784001)(36756003)(2201001)(16586007)(106002)(7696005)(7416002)(478600001)(476003)(126002)(2616005)(44832011)(59450400001)(486006)(53416004)(39060400002)(107886003)(246002)(8936002)(5660300001)(316002)(4326008)(8676002)(356003)(7636002)(50226002)(1720100001)(305945005)(6306002)(2906002)(77096007)(26005)(336012)(106466001)(426003)(186003)(6666003)(966005)(72206003)(19627235001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB0759;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD008;1:7xqpfmaqGNoD5uuBA8OfZ7N5QD0q92ugUGrSZ4p2apSH97NCKHSw16EEuuEf9rTfP3G49uBgOZ538QU8lowAxnd4fXCafIj4hldg8a+RLAFVht9rewRuzmgHPHiT7pMd
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR0301MB0759;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB0759;3:XvomX6mWLfMVuYE+kBjTQWarv4OtV9lR1A4YaWWeeD7PkOtuEPCRxqaw8xPbcJpIm0SO546fNxhy8bBMUkyVs3dKLuul08zlPwI3AV0LP2kuQBaETpWfC/K0UqGnlQCACtgOOtPsN5qItpbYEevKjg2hLJqnrRy9w/zVYJtwOj6iGua14XfdDP6qJaxue9bQPhMUSSpojW9R0a1o9l0NNCdgZ3r5Hwmwg8metThfkfqQ/GrRoK24R0Rmy6aPqMdfl+oG7BMZapL5n40hFGUHOmQpzU4WybWxFL7E0R4ni5IFffKPY42Wiv6by5Y8vQmciRyKmqJcaop6UXnStJJbVbyNdm2waf1frpnTXBslNWU=;25:V5wtZvDTV9O0KYEbw5gd1gUL6t22pv2eaTYFVC8/Qshg/2yWzoVxDuHOlDcUoWTBlISdcPcUgnjK7hOPgz4XSiHtqpmS0IDFCruacETti77NNLO+BkZwAinhBm/IF3xe+0CQ4KPo4qzewcpe6JCS9eZW9JMX4WeTuMJq0wpqmqT+j4Xcbt2cAQMO+KuvCU6KtCJdUvEHEf2jFodcXg2nMNwSd0U4Op3ylo6Z1JwoO368Da2Cps8bwDyO+i9wFHpy3YoPX9i3QSjMi9vt1O5OGBpdMSkVAPvbh4dCOsu1isSOX5LcA0C3L+ERW2sDJSra64ulHeSNOOeOIU02W0NMHQ==
X-MS-TrafficTypeDiagnostic: BY2PR0301MB0759:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB0759;31:a6FRtMnLIOAf572F2bS5H5AI/+ZcP1Hzl5IdvpSL1QkPUIaTcVe+8ktLRbEP3L1TFuxJiymf6hPF/oKGix4REdYs7WPZAbdeeE9Vdzt617P+sZqW/VwXz0ssiAeZaOAW/EZ2XKeVRGmMgCxZX5qEtXZoUNmygGV+OiY0QsbKA0yH6pNZGbN7xoVvrhidDFOTAI5iX9hurXGJJjoVxasTfNYWXy9IyzPTohhgYnYb1EY=;20:GhR+QJk2pt99W/3ML3oJQAODtB31c7O63d+UWAdsJgGlZLyqHiazboy9Y2gkPm+Z61kzVrL5+2oBhq3jvrs3E+H4n+rV400Y/fRSXc3IeXOXTpIqxFajWfNXjw68eaabNGZ+9u+QVTRP7DuX0yoTOHKpdpxyJvHBVIiwg/zu7BixyL1mQNsVoF49KJuLSOOWnKbTxJxXnqusG53JbOAS6KpDrIdJtyso+ximWSe+43E9DtWLy2oKS9KufwKScwKOuxrE0XCWjl3o8sj6YsgKweJCYUx5RKH09rC6QX9SbTps3xMxt6jbBap1+y2bLGhdaTstcZDH3VnxCsNGCrEvg2jo+NxYRRRIBwlplug/boYomEwoRtRVhZsqW5NfN6Cddq7DQzji1wqPUxGVOzMbJnCI0oL/nN1thU82lq5CI+sz4NUcFenV3y6aEdnxzwtWJTOccfpOyhFsnCit+CQ8C/WKmFWyzJJrpG/h2FxtQhqgQy3iMZgjQnnGVlZHRitJ
X-Microsoft-Antispam-PRVS: <BY2PR0301MB075990D88DEFF40BEE1615B89D660@BY2PR0301MB0759.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(95692535739014)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR0301MB0759;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB0759;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB0759;4:/1n7k/PkcmQzdOsAOao0VbKg890XpiUGKS5VAqS51lyAsGWBDwZt6oSXozsfSDAL/xwJyFm7tf2W+n6NQ6fXFSpcAJWHPKuBF5o1aQo3X53DppP8Ef+jtV3MVKy2wfQzfMqnH0XUQmuJ4WJpmPaQvhzJCR6T/Q7ZcbX4AFs1+vZSLFBtCfisGjrgp2XxfFcjiOsGLyPXsSkRSxiVNyFo88I46LQk35CXk2ZQohF/w5D+nmlFiYqGBdDeGfJTNliMbgPYqNauCxmuYAolBzV8Qv7VxW+/juW2MrCuAxuLXI+3WdtaL8veDV/MNfUkUj+Qs+lfsufOdmdJ9Tqydh9n2BdMefgenW9PX2F353tk+BmGyow/DkB+TBaaiygOIUcBxSHHFrtdlmDwzW+rwhpeN+cbz8f5mXdwWm3u+ymsh7OdbQ9VfctVcGdkOecAEtAWBeXv46GCC868qD2R/fb/lg==
X-Forefront-PRVS: 0694C54398
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB0759;23:O8/suYXbBmcaR3ihZmUS2ZSdafim7jRNTFZOU3T?=
 =?us-ascii?Q?12d3cta5rmBY9hvM/ejuDmGyWjQnwCS2AfqnTEo2FvQuEZQE75AVRf49tPqn?=
 =?us-ascii?Q?uYDgwo9GfmfjvA/2WWZVYiYhr5pZkOabQVC9OS+tSWbG7++3crUgBUS6WMZQ?=
 =?us-ascii?Q?8i7qAF1FD8LZVWnVGrlwnkH/Yp+hOqDsyLMsr84zmFmR8uciCfW69GmFJ4TX?=
 =?us-ascii?Q?B6jbFwlQL4qLjtfXzsDaGk5GEl3rJoIv2FCt5IbiE2AwFXyz4fAE76JiJ/+J?=
 =?us-ascii?Q?Lxn06fRtNw0vnKyjQF64UqjC5QYnoWZGg5UXppDJH3dKGbX5rLWRbGWQlN5Z?=
 =?us-ascii?Q?kKSUhu+lMnd4GNVa2kzOcR/XF1VUkz9aGEjXxm1wQbHgVFmzXKeV0LAlZL/V?=
 =?us-ascii?Q?xWVSyz2fiirr5ZgZhHwPAL/BqNNhrjr/uvkDwRniW1Wf+MVLp3ck472WwQvN?=
 =?us-ascii?Q?COhWIf1qVThncGcZpciPrMMAQPfy7tXlW0yzZ3NE6BgGLF+tO44nJ6T2zCCF?=
 =?us-ascii?Q?kJNWHhW2bgxO+8CV6XgdMmMcRqTp76Jz/0RDzdqGMkULqdZh26jT/IqAtlmf?=
 =?us-ascii?Q?rEH+tTkC9uIGu4sEJFJtmi9unw7dvKywxmZwRQi+LTDDzmVug0WLAdBPAMwf?=
 =?us-ascii?Q?J7cfCY69HpuuFe3gtAAB129ygxEEQ1QSkGEchlU8p4IUVRkst2EuzdZpyfD4?=
 =?us-ascii?Q?UF1WAiyl0UUiS8r3oOzgsOH+cQcdktWSXnfT/xYkE4J3tso3GrVqBvDSMPyI?=
 =?us-ascii?Q?rkWjYVMRVOw+eWPlfrp7GmfR+0Y622wxugQz6Ai9MQHoIfh4O/pfnj9cWwro?=
 =?us-ascii?Q?3nLuZmPdTx7h9/8m2+DgYIuI6fCRXrAOE2jt/2CYiDZDAL7IOXCnpALxAT5q?=
 =?us-ascii?Q?gOrSWEgRLIBcovRnSJDUXAsTs1UXy5cCpuZPoE28RzZwPqpwdXoKgvmaDWEy?=
 =?us-ascii?Q?eDWMiOUu+w1Dct3ebPL2Eu0jKFE/LylkyQBoEM0DYPYaPgdRyaUet6QBlHKy?=
 =?us-ascii?Q?ckk16gZ/NDcPUuUh4WWx4V/3nyJ3lR/136+dGl8vEaAxVS/wzxRnjYpUDTsM?=
 =?us-ascii?Q?3Qa3IDXPqHqsYPfdC9XgB61hDTG4tYZ6yg66qBL+nzZ9M8Ht/UrNhGwmPBEQ?=
 =?us-ascii?Q?WmK9AgU0BDdsBW94R/bKBcsOgdt3Rwgv07CGUbBQYGk2s3Ev7w438vMlSDr4?=
 =?us-ascii?Q?4GtUMoSnNcGRsvAMMUtri97JDyq2WDN3eXVW7c82T4nYfvNiy+Aexy1PIBab?=
 =?us-ascii?Q?G9G61DcqzhNjAhBHEy1Q=3D?=
X-Microsoft-Antispam-Message-Info: kOY0ZdQHI+xVYBiJFbZiurhvdXBiQ9lCynienYj1p0Ztppr0Xvncu7qvJJaXGgQSdVU4dPwJFpBzzV5Tt1KJsoSBura2r5lzz5P0+FlJe+6wbxoMvwNZ+JmHGusxRzEje1kP8VQYIylNlKn50BZeQHk/08f7KBg0m8719J06bU4NSV+qZYisWR/A//foSVDG
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB0759;6:gKl97Is3YH2lqB9g9Y1uF7aQD2dI6DchOe9jQsm5d4603/WBRR9cEa4QE2iAet9bZ2MwurYpYCz8OJWpurbAzhJ5PoBmm94jZF8V1Jbe1ZkJ1NwodFzDs4OPjXwhxafMb5EFodlHE8MsGFrH2yKu04qAaTu6t3AU5PhRVWb69lWvOczDLECa5v3OqNEhyowK4fuHS7FkDCDdskw4LfZRGI2MAtUWBJvxVwW50HhkM1Pzp3AfhAIWHSKFPt4LXwg4AsbTtEeSEVQkBNF3R5gz7BrMWXFuhtkEBjn9vbLUnS2UMBAbk/YLiAeL29U32+O4zLv3d2w3RwRhwFTorQ2lvGvwgJKRGacE/QwFZHXJyZQDe3XM5gLSZ0CdqUWUMTnTBcqvqnOqj3cpA8sPZKHQVRMMCANK6iy0p2yWvFIoyCcZuCPTeh2XQojiwW+vvCqjuwCCSJ8mfxdvdRZ2CXIBew==;5:24dR1bCEf8up99C4u+eME0Q7vUDa0L1+SEqa2vv2tfN0GXfwkhOn80oOaTDvJSyBPkcdRNw+zmm32JrTI2rgUzybt2dxs6f/+EL+FC2RfF5MlOFyIt9BDtDs6Nff/pH9K/s9lj9kcet6eKOwrdeyUM6BMIS+9x8uz3ze5cdTSfg=;24:cV8TLBkWJK+siPLhlGaKYyavONQddh28EbwdDRPLOcGw7i0OuV5OpaYd7+okunSaCYuFiMtuTLj/axPbp0SUUhVY/bz67iNqaTEW/7bP33Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB0759;7:5qpXquvccwLpg9Zh79u+Wh6y+uBZsaQOGeWIDBBmJjhWbS1VsWOr4wqkRZONnpMLDUTVlS3It/U8JdvYnvnQcItl/0Bqg93iNXVVmgC1rlZzSUNf9/hWvMnpjZHW9t/rrZqzrFOAzA76b5mSBMi0RXkCWyixliB8lvjqUgFRlAAXKHJiR80Z9bgW/1hVI2VPSllmE+Gjs0bxgB9Ofet3VZ1LuJiLM/QYhgMpgegCpClqT+l9Of0Dzy3QK8oIdPKg
X-MS-Office365-Filtering-Correlation-Id: 9ab6aeee-ef34-42d5-b1f3-08d5caeff242
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 14:23:45.1685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab6aeee-ef34-42d5-b1f3-08d5caeff242
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB0759
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD5758 is a single channel DAC with 16-bit precision which uses the SPI
interface that operates at clock rates up to 50MHz.

The output can be configured as voltage or current and is available on a
single terminal.

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/ad5758.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 MAINTAINERS              |   7 +
 drivers/iio/dac/Kconfig  |  10 +
 drivers/iio/dac/Makefile |   1 +
 drivers/iio/dac/ad5758.c | 826 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 844 insertions(+)
 create mode 100644 drivers/iio/dac/ad5758.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b65225..1993779 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -802,6 +802,13 @@ S:	Supported
 F:	drivers/iio/dac/ad5686*
 F:	drivers/iio/dac/ad5696*
 
+ANALOG DEVICES INC AD5758 DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/dac/ad5758.c
+
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 06e90de..80beb64 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -167,6 +167,16 @@ config AD5755
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5755.
 
+config AD5758
+	tristate "Analog Devices AD5758 DAC driver"
+	depends on SPI_MASTER
+	help
+	  Say yes here to build support for Analog Devices AD5758 single channel
+	  Digital to Analog Converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5758.
+
 config AD5761
 	tristate "Analog Devices AD5761/61R/21/21R DAC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 57aa230..e859f2d 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
 obj-$(CONFIG_AD5592R) += ad5592r.o
 obj-$(CONFIG_AD5593R) += ad5593r.o
 obj-$(CONFIG_AD5755) += ad5755.o
+obj-$(CONFIG_AD5758) += ad5758.o
 obj-$(CONFIG_AD5761) += ad5761.o
 obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5791) += ad5791.o
diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
new file mode 100644
index 0000000..0a26b9d
--- /dev/null
+++ b/drivers/iio/dac/ad5758.c
@@ -0,0 +1,826 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD5758 Digital to analog converters driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/spi/spi.h>
+#include <linux/delay.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/property.h>
+
+/* AD5758 registers definition */
+#define AD5758_NOP					0x00
+#define AD5758_DAC_INPUT				0x01
+#define AD5758_DAC_OUTPUT				0x02
+#define AD5758_CLEAR_CODE				0x03
+#define AD5758_USER_GAIN				0x04
+#define AD5758_USER_OFFSET				0x05
+#define AD5758_DAC_CONFIG				0x06
+#define AD5758_SW_LDAC					0x07
+#define AD5758_KEY					0x08
+#define AD5758_GP_CONFIG1				0x09
+#define AD5758_GP_CONFIG2				0x0A
+#define AD5758_DCDC_CONFIG1				0x0B
+#define AD5758_DCDC_CONFIG2				0x0C
+#define AD5758_WDT_CONFIG				0x0F
+#define AD5758_DIGITAL_DIAG_CONFIG			0x10
+#define AD5758_ADC_CONFIG				0x11
+#define AD5758_FAULT_PIN_CONFIG				0x12
+#define AD5758_TWO_STAGE_READBACK_SELECT		0x13
+#define AD5758_DIGITAL_DIAG_RESULTS			0x14
+#define AD5758_ANALOG_DIAG_RESULTS			0x15
+#define AD5758_STATUS					0x16
+#define AD5758_CHIP_ID					0x17
+#define AD5758_FREQ_MONITOR				0x18
+#define AD5758_DEVICE_ID_0				0x19
+#define AD5758_DEVICE_ID_1				0x1A
+#define AD5758_DEVICE_ID_2				0x1B
+#define AD5758_DEVICE_ID_3				0x1C
+
+/* AD5758_DAC_CONFIG */
+#define AD5758_DAC_CONFIG_RANGE_MSK			GENMASK(3, 0)
+#define AD5758_DAC_CONFIG_RANGE_MODE(x)			(((x) & 0xF) << 0)
+#define AD5758_DAC_CONFIG_OVRNG_EN_MSK			BIT(4)
+#define AD5758_DAC_CONFIG_OVRNG_EN_MODE(x)		(((x) & 0x1) << 4)
+#define AD5758_DAC_CONFIG_INT_EN_MSK			BIT(5)
+#define AD5758_DAC_CONFIG_INT_EN_MODE(x)		(((x) & 0x1) << 5)
+#define AD5758_DAC_CONFIG_OUT_EN_MSK			BIT(6)
+#define AD5758_DAC_CONFIG_OUT_EN_MODE(x)		(((x) & 0x1) << 6)
+#define AD5758_DAC_CONFIG_RSET_EXT_EN_MSK		BIT(7)
+#define AD5758_DAC_CONFIG_RSET_EXT_EN_MODE(x)		(((x) & 0x1) << 7)
+#define AD5758_DAC_CONFIG_SR_EN_MSK			BIT(8)
+#define AD5758_DAC_CONFIG_SR_EN_MODE(x)			(((x) & 0x1) << 8)
+#define AD5758_DAC_CONFIG_SR_CLOCK_MSK			GENMASK(12, 9)
+#define AD5758_DAC_CONFIG_SR_CLOCK_MODE(x)		(((x) & 0xF) << 9)
+#define AD5758_DAC_CONFIG_SR_STEP_MSK			GENMASK(15, 13)
+#define AD5758_DAC_CONFIG_SR_STEP_MODE(x)		(((x) & 0x7) << 13)
+
+/* AD5758_KEY */
+#define AD5758_KEY_CODE_RESET_1				0x15FA
+#define AD5758_KEY_CODE_RESET_2				0xAF51
+#define AD5758_KEY_CODE_SINGLE_ADC_CONV			0x1ADC
+#define AD5758_KEY_CODE_RESET_WDT			0x0D06
+#define AD5758_KEY_CODE_CALIB_MEM_REFRESH		0xFCBA
+
+/* AD5758_DCDC_CONFIG1 */
+#define AD5758_DCDC_CONFIG1_DCDC_VPROG_MSK		GENMASK(4, 0)
+#define AD5758_DCDC_CONFIG1_DCDC_VPROG_MODE(x)		(((x) & 0x1F) << 0)
+#define AD5758_DCDC_CONFIG1_DCDC_MODE_MSK		GENMASK(6, 5)
+#define AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(x)		(((x) & 0x3) << 5)
+#define AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MSK	BIT(7)
+#define AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MODE(x)	(((x) & 0x1) << 7)
+
+/* AD5758_DCDC_CONFIG2 */
+#define AD5758_DCDC_CONFIG2_ILIMIT_MSK			GENMASK(3, 1)
+#define AD5758_DCDC_CONFIG2_ILIMIT_MODE(x)		(((x) & 0x7) << 1)
+#define AD5758_DCDC_CONFIG2_ADC_CONTROL_DIAG_MSK	GENMASK(5, 4)
+#define AD5758_DCDC_CONFIG2_ADC_CONTROL_DIAG_MODE(x)	(((x) & 0x3) << 4)
+#define AD5758_DCDC_CONFIG2_VIOUT_PULLDOWN_EN_MSK	BIT(6)
+#define AD5758_DCDC_CONFIG2_VIOUT_PULLDOWN_EN_MODE(x)	(((x) & 0x1) << 6)
+#define AD5758_DCDC_CONFIG2_SHORT_DEGLITCH_MSK		BIT(7)
+#define AD5758_DCDC_CONFIG2_SHORT_DEGLITCH_MODE(x)	(((x) & 0x1) << 7)
+#define AD5758_DCDC_CONFIG2_READ_COMP_DIS_MSK		BIT(10)
+#define AD5758_DCDC_CONFIG2_READ_COMP_DIS_MODE(x)	(((x) & 0x1) << 10)
+#define AD5758_DCDC_CONFIG2_INTR_SAT_3WI_MSK		BIT(11)
+#define AD5758_DCDC_CONFIG2_BUSY_3WI_MSK		BIT(12)
+
+/* AD5758_DIGITAL_DIAG_RESULTS */
+#define AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK	BIT(15)
+
+#define AD5758_REG_WRITE(x)	((0x80) | ((x) & 0x1F))
+
+/* x^8 + x^2 + x^1 + x^0 */
+#define AD5758_CRC8_POLY	0x07
+
+/**
+ * struct ad5758_state - driver instance specific data
+ * @spi:	spi_device
+ * @dc_dc_mode:	variable which stores the mode of operation
+ * @out_range:	variable which stores the output range
+ * @pwr_down:	variable which contains whether a channel is powered down or not
+ * @data:	spi transfer buffers
+ */
+
+struct ad5758_state {
+	struct spi_device *spi;
+	struct mutex lock;
+	unsigned int dc_dc_mode;
+	unsigned int dc_dc_ilim;
+	unsigned int sr_config[3];
+	unsigned int out_range;
+	unsigned int pwr_down;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+
+	union {
+		__be32 d32;
+		u8 d8[4];
+	} data[3] ____cacheline_aligned;
+};
+
+enum ad5758_output_range {
+	AD5758_RANGE_0V_5V,
+	AD5758_RANGE_0V_10V,
+	AD5758_RANGE_PLUSMINUS_5V,
+	AD5758_RANGE_PLUSMINUS_10V,
+	AD5758_RANGE_0mA_20mA = 8,
+	AD5758_RANGE_0mA_24mA,
+	AD5758_RANGE_4mA_24mA,
+	AD5758_RANGE_PLUSMINUS_20mA,
+	AD5758_RANGE_PLUSMINUS_24mA,
+	AD5758_RANGE_MINUS_1mA_PLUS_22mA,
+};
+
+enum ad5758_dc_dc_mode {
+	AD5758_DCDC_MODE_POWER_OFF,
+	AD5758_DCDC_MODE_DPC_CURRENT,
+	AD5758_DCDC_MODE_DPC_VOLTAGE,
+	AD5758_DCDC_MODE_PPC_CURRENT,
+};
+
+struct ad5758_range {
+	int reg;
+	int min;
+	int max;
+};
+
+static const struct ad5758_range ad5758_min_max_table[] = {
+	{ AD5758_RANGE_0V_5V, 0, 5000 },
+	{ AD5758_RANGE_0V_10V, 0, 10000 },
+	{ AD5758_RANGE_PLUSMINUS_5V, -5000, 5000 },
+	{ AD5758_RANGE_PLUSMINUS_10V, -10000, 10000 },
+	{ AD5758_RANGE_0mA_20mA, 0, 20},
+	{ AD5758_RANGE_0mA_24mA, 0, 24 },
+	{ AD5758_RANGE_4mA_24mA, 4, 24 },
+	{ AD5758_RANGE_PLUSMINUS_20mA, -20, 20 },
+	{ AD5758_RANGE_PLUSMINUS_24mA, -24, 24 },
+	{ AD5758_RANGE_MINUS_1mA_PLUS_22mA, -1, 22 },
+};
+
+static const int ad5758_slew_rate_clk[16] = {
+	240000, 200000, 150000, 128000, 64000, 32000, 16000, 8000, 4000, 2000,
+	1000, 512, 256, 128, 64, 16
+};
+
+static const int ad5758_slew_rate_step[8] = {
+	4, 12, 64, 120, 256, 500, 1820, 2048
+};
+
+static const int ad5758_dc_dc_ilimt[6] = {
+	150, 200, 250, 300, 350, 400
+};
+
+static int ad5758_spi_reg_read(struct ad5758_state *st, unsigned int addr)
+{
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = &st->data[0].d8[0],
+			.len = 4,
+			.cs_change = 1,
+		}, {
+			.tx_buf = &st->data[1].d8[0],
+			.rx_buf = &st->data[2].d8[0],
+			.len = 4,
+		},
+	};
+	int ret;
+
+	st->data[0].d32 = cpu_to_be32(
+		(AD5758_REG_WRITE(AD5758_TWO_STAGE_READBACK_SELECT) << 24) |
+		(addr << 8));
+	st->data[1].d32 = cpu_to_be32(AD5758_REG_WRITE(AD5758_NOP) << 24);
+
+	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
+	if (ret < 0)
+		return ret;
+
+	return (be32_to_cpu(st->data[2].d32) >> 8) & 0xFFFF;
+}
+
+static int ad5758_spi_reg_write(struct ad5758_state *st,
+				unsigned int addr,
+				unsigned int val)
+{
+	st->data[0].d32 = cpu_to_be32((AD5758_REG_WRITE(addr) << 24) |
+				      ((val & 0xFFFF) << 8));
+
+	return spi_write(st->spi, &st->data[0].d8[0], 4);
+}
+
+static int ad5758_spi_write_mask(struct ad5758_state *st,
+				 unsigned int addr,
+				 unsigned long int mask,
+				 unsigned int val)
+{
+	int regval;
+
+	regval = ad5758_spi_reg_read(st, addr);
+	if (regval < 0)
+		return regval;
+
+	regval &= ~mask;
+	regval |= val;
+
+	return ad5758_spi_reg_write(st, addr, regval);
+}
+
+static int ad5758_get_array_index(const int *array, unsigned int size, int val)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (val == array[i])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int ad5758_wait_for_task_complete(struct ad5758_state *st,
+					 unsigned int reg,
+					 unsigned int mask)
+{
+	unsigned int timeout;
+	int ret;
+
+	timeout = 4;
+	do {
+		ret = ad5758_spi_reg_read(st, reg);
+		if (ret < 0)
+			return ret;
+
+		if (!(ret & mask))
+			return 0;
+
+		mdelay(1);
+	} while (--timeout);
+
+	dev_err(&st->spi->dev,
+		"Error reading bit 0x%x in 0x%x register\n", mask, reg);
+
+	return -EIO;
+}
+
+static int ad5758_calib_mem_refresh(struct ad5758_state *st)
+{
+	int ret;
+
+	ret = ad5758_spi_reg_write(st, AD5758_KEY,
+				   AD5758_KEY_CODE_CALIB_MEM_REFRESH);
+
+	if (ret < 0) {
+		dev_err(&st->spi->dev,
+			"Failed to initiate a calibration memory refresh\n");
+		return ret;
+	}
+
+	/* Wait to allow time for the internal calibrations to complete */
+	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
+}
+
+static int ad5758_soft_reset(struct ad5758_state *st)
+{
+	int ret;
+
+	ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_1);
+	if (ret < 0)
+		return ret;
+
+	ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_2);
+
+	mdelay(1);
+
+	return ret;
+}
+
+static int ad5758_set_dc_dc_conv_mode(struct ad5758_state *st,
+				      unsigned int mode)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
+				    AD5758_DCDC_CONFIG1_DCDC_MODE_MSK,
+				    AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(mode));
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
+	 * This allows the 3-wire interface communication to complete.
+	 */
+	ret = ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
+					    AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
+	if (ret < 0)
+		return ret;
+
+	st->dc_dc_mode = mode;
+
+	return ret;
+}
+
+static int ad5758_set_dc_dc_ilim(struct ad5758_state *st, unsigned int ilim)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG2,
+				    AD5758_DCDC_CONFIG2_ILIMIT_MSK,
+				    AD5758_DCDC_CONFIG2_ILIMIT_MODE(ilim));
+	if (ret < 0)
+		return ret;
+	/*
+	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
+	 * This allows the 3-wire interface communication to complete.
+	 */
+	return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
+					     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
+}
+
+static int ad5758_slew_rate_config(struct ad5758_state *st,
+				   unsigned int enable,
+				   unsigned int sr_clk,
+				   unsigned int sr_step)
+{
+	unsigned int mode;
+	unsigned long int mask;
+	int ret;
+
+	mask = (AD5758_DAC_CONFIG_SR_EN_MSK |
+	       AD5758_DAC_CONFIG_SR_CLOCK_MSK |
+	       AD5758_DAC_CONFIG_SR_STEP_MSK);
+
+	mode = (AD5758_DAC_CONFIG_SR_EN_MODE(enable) |
+		AD5758_DAC_CONFIG_SR_CLOCK_MODE(sr_clk) |
+		AD5758_DAC_CONFIG_SR_STEP_MODE(sr_step));
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG, mask, mode);
+	if (ret < 0)
+		return ret;
+
+	/* Wait to allow time for the internal calibrations to complete */
+	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
+}
+
+static int ad5758_set_out_range(struct ad5758_state *st, unsigned int range)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				    AD5758_DAC_CONFIG_RANGE_MSK,
+				    AD5758_DAC_CONFIG_RANGE_MODE(
+					    ad5758_min_max_table[range].reg));
+	if (ret < 0)
+		return ret;
+
+	/* Wait to allow time for the internal calibrations to complete */
+	ret =  ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
+	if (ret < 0)
+		return ret;
+
+	st->out_range = range;
+
+	return ret;
+}
+
+static int ad5758_fault_prot_switch_en(struct ad5758_state *st,
+				       unsigned char enable)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
+			AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MSK,
+			AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MODE(enable));
+	if (ret < 0)
+		return ret;
+	/*
+	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
+	 * This allows the 3-wire interface communication to complete.
+	 */
+	return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
+					     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
+}
+
+static int ad5758_internal_buffers_en(struct ad5758_state *st,
+				      unsigned char enable)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				    AD5758_DAC_CONFIG_INT_EN_MSK,
+				    AD5758_DAC_CONFIG_INT_EN_MODE(enable));
+	if (ret < 0)
+		return ret;
+
+	/* Wait to allow time for the internal calibrations to complete */
+	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
+}
+
+static int ad5758_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	if (readval == NULL) {
+		ret =  ad5758_spi_reg_write(st, reg, writeval);
+	} else {
+		ret = ad5758_spi_reg_read(st, reg);
+		if (ret < 0)
+			return ret;
+
+		*readval = ret;
+		ret = 0;
+	}
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int ad5758_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	int max, min, ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = ad5758_spi_reg_read(st, AD5758_DAC_INPUT);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+
+		*val = ret;
+		mutex_unlock(&st->lock);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		min = ad5758_min_max_table[st->out_range].min;
+		max = ad5758_min_max_table[st->out_range].max;
+		*val = max - min;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int ad5758_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = ad5758_spi_reg_write(st, AD5758_DAC_INPUT, val);
+		mutex_unlock(&st->lock);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t ad5758_read_powerdown(struct iio_dev *indio_dev,
+				     uintptr_t priv,
+				     const struct iio_chan_spec *chan,
+				     char *buf)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->pwr_down);
+}
+
+static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
+				      uintptr_t priv,
+				      struct iio_chan_spec const *chan,
+				      const char *buf, size_t len)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	bool pwr_down;
+	unsigned int dcdc_config1_mode, dc_dc_mode, dac_config_mode, val;
+	unsigned long int dcdc_config1_msk, dac_config_msk;
+	int ret;
+
+	ret = strtobool(buf, &pwr_down);
+	if (ret)
+		return ret;
+
+	mutex_lock(&st->lock);
+	if (pwr_down) {
+		dc_dc_mode = AD5758_DCDC_MODE_POWER_OFF;
+		val = 0;
+	} else {
+		dc_dc_mode = st->dc_dc_mode;
+		val = 1;
+	}
+
+	dcdc_config1_mode = (AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(dc_dc_mode) |
+			     AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MODE(val));
+	dcdc_config1_msk = (AD5758_DCDC_CONFIG1_DCDC_MODE_MSK |
+			    AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MSK);
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
+				    dcdc_config1_msk,
+				    dcdc_config1_mode);
+	if (ret < 0)
+		goto err_unlock;
+
+	dac_config_mode = (AD5758_DAC_CONFIG_OUT_EN_MODE(val) |
+			   AD5758_DAC_CONFIG_INT_EN_MODE(val));
+	dac_config_msk =  (AD5758_DAC_CONFIG_OUT_EN_MSK |
+			   AD5758_DAC_CONFIG_INT_EN_MSK);
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				    dac_config_msk,
+				    dac_config_mode);
+	if (ret < 0)
+		goto err_unlock;
+
+	st->pwr_down = pwr_down;
+
+err_unlock:
+	mutex_unlock(&st->lock);
+
+	return ret ? ret : len;
+}
+
+static const struct iio_info ad5758_info = {
+	.read_raw = ad5758_read_raw,
+	.write_raw = ad5758_write_raw,
+	.debugfs_reg_access = &ad5758_reg_access,
+};
+
+static const struct iio_chan_spec_ext_info ad5758_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = ad5758_read_powerdown,
+		.write = ad5758_write_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	{ },
+};
+
+static const struct iio_chan_spec ad5758_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.output = 1,
+		.channel = 0,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 32,
+			.shift = 0,
+			.endianness = IIO_BE,
+		},
+		.ext_info = ad5758_ext_info,
+	},
+};
+
+static int ad5758_crc_disable(struct ad5758_state *st)
+{
+	st->data[0].d32 =
+		cpu_to_be32(
+		(AD5758_REG_WRITE(AD5758_DIGITAL_DIAG_CONFIG) << 24) | 0x5C3A);
+
+	return spi_write(st->spi, &st->data[0].d8[0], 4);
+}
+
+static void ad5758_parse_dt(struct ad5758_state *st)
+{
+	unsigned int i, tmp, tmparray[3];
+	int index;
+
+	st->dc_dc_ilim = 150;
+	if (!device_property_read_u32(&st->spi->dev,
+				      "adi,dc-dc-ilim", &tmp)) {
+		index = ad5758_get_array_index(ad5758_dc_dc_ilimt,
+					ARRAY_SIZE(ad5758_dc_dc_ilimt), tmp);
+		if (index < 0)
+			dev_warn(&st->spi->dev,
+				 "dc-dc-ilim out of range using default");
+		else
+			st->dc_dc_ilim = index;
+	} else {
+		dev_dbg(&st->spi->dev,
+			 "Missing \"dc-dc-ilim\" property, using default\n");
+	}
+
+	st->dc_dc_mode = AD5758_DCDC_MODE_DPC_VOLTAGE;
+	if (device_property_read_u32(&st->spi->dev, "adi,dc-dc-mode",
+				     &st->dc_dc_mode))
+		dev_dbg(&st->spi->dev,
+			"Missing \"dc-dc-mode\" property, using DPC_VOLTAGE\n");
+
+	/* 0 V to 5 V voltage range */
+	st->out_range = 0;
+	if (!device_property_read_u32(&st->spi->dev, "adi,range", &tmp)) {
+		for (i = 0; i < ARRAY_SIZE(ad5758_min_max_table); i++) {
+			if (tmp == ad5758_min_max_table[i].reg) {
+				st->out_range = i;
+				break;
+			}
+		}
+
+		if (i == ARRAY_SIZE(ad5758_min_max_table))
+			dev_warn(&st->spi->dev, "range invalid, using default");
+	} else {
+		dev_dbg(&st->spi->dev,
+			"Missing \"range\" property, using default\n");
+	}
+
+	st->sr_config[0] = 1;
+	st->sr_config[1] = 16000;
+	st->sr_config[2] = 4;
+	if (!device_property_read_u32_array(&st->spi->dev, "adi,slew",
+					    tmparray, 3)) {
+		st->sr_config[0] = tmparray[0];
+
+		index = ad5758_get_array_index(ad5758_slew_rate_clk,
+					       ARRAY_SIZE(ad5758_slew_rate_clk),
+					       tmparray[1]);
+
+		if (index < 0)
+			dev_warn(&st->spi->dev,
+				"slew rate clock out of range, using default");
+		else
+			st->sr_config[1] = index;
+
+		index = ad5758_get_array_index(ad5758_slew_rate_step,
+					ARRAY_SIZE(ad5758_slew_rate_step),
+					tmparray[2]);
+
+		if (index < 0)
+			dev_warn(&st->spi->dev,
+				"slew rate step out of range, using default");
+		else
+			st->sr_config[2] = index;
+	} else {
+		dev_dbg(&st->spi->dev,
+			 "Missing \"slew\" property, using default\n");
+	}
+}
+
+static int ad5758_init(struct ad5758_state *st)
+{
+	int regval, ret;
+
+	ad5758_parse_dt(st);
+
+	/* Disable CRC checks */
+	ret = ad5758_crc_disable(st);
+	if (ret < 0)
+		return ret;
+
+	/* Perform a software reset */
+	ret = ad5758_soft_reset(st);
+	if (ret < 0)
+		return ret;
+
+	/* Disable CRC checks */
+	ret = ad5758_crc_disable(st);
+	if (ret < 0)
+		return ret;
+
+	/* Perform a calibration memory refresh */
+	ret = ad5758_calib_mem_refresh(st);
+	if (ret < 0)
+		return ret;
+
+	regval = ad5758_spi_reg_read(st, AD5758_DIGITAL_DIAG_RESULTS);
+	if (regval < 0)
+		return regval;
+
+	/* Clear all the error flags */
+	ret = ad5758_spi_reg_write(st, AD5758_DIGITAL_DIAG_RESULTS, regval);
+	if (ret < 0)
+		return ret;
+
+	/* Set the dc-to-dc current limit */
+	ret = ad5758_set_dc_dc_ilim(st, st->dc_dc_ilim);
+	if (ret < 0)
+		return ret;
+
+	/* Configure the dc-to-dc controller mode */
+	ret = ad5758_set_dc_dc_conv_mode(st, st->dc_dc_mode);
+	if (ret < 0)
+		return ret;
+
+	/* Configure the output range */
+	ret = ad5758_set_out_range(st, st->out_range);
+	if (ret < 0)
+		return ret;
+
+	/* Enable Slew Rate Control, set the slew rate clock and step */
+	ret = ad5758_slew_rate_config(st, st->sr_config[0],
+				      st->sr_config[1], st->sr_config[2]);
+	if (ret < 0)
+		return ret;
+
+	/* Enable the VIOUT fault protection switch (FPS is closed) */
+	ret = ad5758_fault_prot_switch_en(st, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Power up the DAC and internal (INT) amplifiers */
+	ret = ad5758_internal_buffers_en(st, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Enable VIOUT */
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				    AD5758_DAC_CONFIG_OUT_EN_MSK,
+				    AD5758_DAC_CONFIG_OUT_EN_MODE(1));
+
+	return ret;
+}
+
+static int ad5758_probe(struct spi_device *spi)
+{
+	struct ad5758_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+
+	st->spi = spi;
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ad5758_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad5758_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad5758_channels);
+
+	mutex_init(&st->lock);
+
+	ret = ad5758_init(st);
+	if (ret < 0) {
+		dev_err(&spi->dev, "AD5758 init failed\n");
+		return ret;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to register iio device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct spi_device_id ad5758_id[] = {
+	{ "ad5758", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad5758_id);
+
+static struct spi_driver ad5758_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = ad5758_probe,
+	.id_table = ad5758_id,
+};
+
+module_spi_driver(ad5758_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5758 DAC");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
