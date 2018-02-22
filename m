Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeBVUEs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:04:48 -0500
Received: from mail-bl2nam02on0041.outbound.protection.outlook.com ([104.47.38.41]:33459
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750816AbeBVUEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:04:45 -0500
From: David Daney <david.daney@cavium.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v6] rtc: isl12026: Add driver.
Date: Thu, 22 Feb 2018 12:04:32 -0800
Message-Id: <20180222200432.22003-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0004.namprd07.prod.outlook.com
 (2a01:111:e400:5173::14) To CY4PR07MB3174.namprd07.prod.outlook.com
 (2603:10b6:903:cf::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae22aeeb-1556-4305-6cee-08d57a2f82dc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR07MB3174;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3174;3:8kFUxwFbRbxwqPxtewmePulsb4ycVbIercqP9OfELT+AkmzxF4VwrlDCfThR+iFc6hgQ99D9rw2jOOyJyMxKepmIVqSG12/rbhLi+CDSV2TyFxmzut4rfZkSK9DWSUv7bJZydW2+xssxLWKl5EMD0eQRiJ1MrqTwMXDxn+SfdG0LIkcqYZoYYuS+lGUy8TxWHEyhim/z5Ap2erDpIcxZsXA0AFowhhPrN7tUNcT2K2PoYGKSRuYnwHjpSc4SLY+J;25:gzIsdgQtYGG+ZWj24eM7guL/sazahLbi7fwmNtnfpqF18DOyVgSQcDh4CDQga9voUjkl58byyTFZGTUBXjAaeLUqKxoK3oTo6if5MYNAetEvmYkdp+INjBY1IJ27ReG+MDmo019nIdVyjXN+sSgpIFKHrgb3hLZhTdvV+AtXm87NW0pvqE7OGIuWflmXPR6CetVi0lNXo7o5A3QEqjgzbaull2nvwpYpWo28jkS1wS28Y22ir9aJj9FyIbQC5x5aWfgqX55Ve6NoePYDFt/16Z1LGzMmg2cOURkalN1bbgZY1T53hURQXcIirkC5eICFRbxj+AkP6WV3o91OYiBxyA==;31:d+djKAUoY3uVZY9DAtq6CFrB8WaNIoH5zxCmkvyXBP2b42FCOUAkJ0KzkIXJxPhr4G/v+qGY8nxuqe0vsLj+oacWdwvMNZfMiSwpQm4kfm5Lm/AZRi0TOD0s07i2u2aykRfZS+ck7RFceJlSMPmcXv6N2jJmgrkiA6uwX2tabUNzPb+KUDntyE5P6uWJyGEphPfXbQILQU3qJJiHSCsw++HQUYd4bAPDG8EZ50FD4oo=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3174:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3174;20:h42w+ccByfA/dgJKOdk54Fdr+ojGI9cslpvWAm2NQxWZrSEtrjNuEIR1ErC9e+r6jxvvkw/X7kF2hc0GLQYzDf4JpWgwqIMNz5waeiA9VJA4pOiKjw1kUVBfIR8w8FANl109ESa4DGZGa2QlH9z9oYfjY/vbNmRZ0y2do1KE859/EYbt/e/maCm8ycH1bvG5BuvV6KDTCq0w26ua7BlkSsoWbYsNLxDbWGHtDxk8fKeQkUqXNgsRnGez2YCUGnDSLaQn25xqGIOOE7NfXFEts3/H1xXDua1k0tsDnHAU9J3URBqywvUvS8wjfp9JFaH5bPLdUtYulevnLJC1+7arS0BTfFWF1cg51Ye/5C61XeUaU/mJMlGubEPYom4n9rgdELUIpo3JhecZoI2I3jWgZY0pMVkXrI8vZ9noOztOxttJpdRsphha0+6ofJlS5c/KezPvwtzddOA7xpktcOat3e/SLzn4ceNh6UQUPJXMKwWN380k/sVSlF+a4+9gke60;4:tXRMkMjSyy8Q7x4+0hUImIoNM9nXcih4diOfcyeO1HtHQHpYZwAnp/SiDOy2lWTljF2/yVEsI6p1dPfPcsp/+0px68+9PbjiDgEw9NisUYoPSqJ2V3BgIV36oiZyP7bKLH7/6w7c3Kf/owDv8NY0kmgPZ/UkXkBYyjcJdR+p6UVPTse2PmGuaC2smoKS2nn0jyWIDLaWusyXe4cPqCPkZ5DoFc0KETyyYFvmigaHpbH3fAIXpH1Za0Fpua9lQo7mY2JFlbI4jQbfWZf8lSRjUuAcfwfQ81yMA6aFUPLMAjh8n16cxBvTnVEjd7nx3VUq
X-Microsoft-Antispam-PRVS: <CY4PR07MB3174AAC91CC26C31A4016B8497CD0@CY4PR07MB3174.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231166)(944501161)(52105095)(10201501046)(93006095)(93001095)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR07MB3174;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3174;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(366004)(346002)(376002)(189003)(199004)(6512007)(106356001)(51416003)(4326008)(110136005)(16586007)(54906003)(50226002)(39060400002)(52116002)(16526019)(6666003)(6486002)(50466002)(81166006)(26005)(81156014)(36756003)(186003)(69596002)(48376002)(8676002)(386003)(6506007)(59450400001)(7736002)(72206003)(53416004)(8936002)(478600001)(305945005)(5660300001)(316002)(1076002)(25786009)(105586002)(86362001)(575784001)(3846002)(6116002)(53936002)(2906002)(68736007)(107886003)(97736004)(66066001)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3174;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3174;23:Lms6yMeWMJJgysTB1J4N6lFeABn/F/GnIOFlu/Xsi?=
 =?us-ascii?Q?iZc7ISptoNeAtQz402l4NTwHQ11/aRhr8VJIbmm9+z1VvBy0PKYgnFee8ums?=
 =?us-ascii?Q?k4Oh66jYFoo4sQxYY/6L2/nE6kY8En31lHNVS6Vs5wHncRqHfvTCtCtzdJIS?=
 =?us-ascii?Q?aHa0uqGpR9/56pKC9yjgtZg2rHYM8laSUQIUUMSTh5wY84d/FOpY44QZWckd?=
 =?us-ascii?Q?NxDRUog7JU+vW6avhN+nBxirLhLklYBZ5XR4ydSAObGgNbRc9NYIVxeJkrQG?=
 =?us-ascii?Q?245NNcg93u8bb1pa3/T6Wp18+lIHnmMTIUIFyIpBiThzYF56B/ZrMmQEdVav?=
 =?us-ascii?Q?IKcYvEiqIPSwcNvWNAUHL1st2abS9X+NS8X6vQIfMKfFl1Yh1qNA/+49w5pc?=
 =?us-ascii?Q?A4RZWNzx8MauMEvaWEIxFUg7WL0rTFBYKLvcf212ln6wy+sYMMkSVD35LEV5?=
 =?us-ascii?Q?XDAgc09t/jvWG68y4JoB7gKpAqDYP+RVTZjdQjaCChn+iKCMPSCl29XYmQ3S?=
 =?us-ascii?Q?nASJ8LrkSNwl8m1SN/fysOMYmQ3ITS46inZSQT2Pzxc0nygNMfXCdWcCCOi9?=
 =?us-ascii?Q?h2TYOo1xXx+s/v58ofWolQYV5N8fK/xCJhWfmJA6k2ET+H/fWCMbfyBH3VCI?=
 =?us-ascii?Q?UgNsu4hY2hPHutINroNz+dkSTavM9o5DWTbGpH9iMQlV1Y0ZsxANsGzNpCsd?=
 =?us-ascii?Q?ogz5eNY/Pj4iK4AT++k3TGxmWdXNfeYu+M5QLUs2WUc0u2/dH3HHWJSihPSb?=
 =?us-ascii?Q?Ad1Py1SqkvqqswXFkvVuFsmBShffKAm9IFOcNUTe4qgMSZJ0ZZQhDfcdHu6l?=
 =?us-ascii?Q?Wg7ZRnhos2iKgIJyNke1ZUpWmv8c9dKNzISYECOruI69Xa4IVQw5oIOdxu37?=
 =?us-ascii?Q?Txj+Xbt4WDNMY5bn5ePANlsuP9i+twCIxsOMHkHBwAeygSgZkAhHnFjAptmr?=
 =?us-ascii?Q?7w7cRJkRhC+D6mh3KsQpYCJ+VYzeagwqweBxtw9HFpzhnY6yNRZBODKsjeE9?=
 =?us-ascii?Q?ykdQWYqeGVSBDWF91qSie2aNmItvLDmvYJmQrHszOhJsyLykaIkuR+iKHeSp?=
 =?us-ascii?Q?bvcYuQ+ogMISoFRMbP9ooFPoYlLXuTOkvQphI0DPvzF8hFnwoZubS5JxWAQL?=
 =?us-ascii?Q?ru+K4fW21+7tj76zcMtcfDcbipFr7Z3cIerEnz9QtPSL9RXJmD8RsVQfPNQ5?=
 =?us-ascii?Q?fwRi2J/9HonQQCXbABPhRWiRA7l68DRTxinUCFNDsepVbGYpVR9Ch1adNsYP?=
 =?us-ascii?Q?egRq3+Ya7o+hLYm568Ns5S1GSdNNO78cvgkgVbw?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3174;6:NpU63Ec0i1SGXGr/3nwrBAHjL7QQ2ZUvbwYnJyo8Z4WcKFe48EeniyLNy1YhMWLBRjOnJC8lr/2r09w7f8fgTzx27Oq7B6GdNPsP2ZikdU2JZ+f2uZBTjcOF0hI9k5sFb7S9uN8YW79vyr5uJmVIF4tPCjsEuM2JqAN9ktnlDtWLhXyeLMC1kLJ841Znfsa9RGAygC5cYo+dCxTTHdKXosnynhZaM9DFHrK7FCMDGHE9hqSmpzYyJS7Z6B5WefLVuhii1Tv/trs+VgGSwrsUkZNsAaSXtUugPhl/DY2ZKHHkxqRyyduMKhffRBWYsLSGY7fc5L69dNKR/T1VDihIfg==;5:TUNs6sk1Ibl2F0FIT85wybEDJSyRMNBKSqREG9UXy2urofa4437nfUQIxZPYLd02jDfEaRY3ImtI8WU+VeAf8atz4ii+UI5g1oFVXdT3aCYFXonTUKsM6LCSrTOhmFy9u+AtoRMLHE2BZzkMkpggvNeHAA3HxRUupVMYBaAzvWY=;24:ffhJgZg7e76bQgysw7bKPKICvQ8fp7YnfBcmEkb/4qr8zN4G8QnNjbu/xw1plxR7srNlfZaJQ6rBl1leJnNZtyB48NtewkWS3s5uQ37MmDc=;7:YOslbiBUIlyq2gHUlf4/hYvlgu/xLKjv38fKGOm6ZWF50Z42OKiuFnn8Befxd0RKp7Ka3sDEyMypjn8FA2ddhQu3Qevst17qn/O9g45625EaUhf6E+QEGqhIyA5SziHtxPk0DBM6HsB+CvOT1dhVVrxDXUwSLBlMPmeXuiRG8ssXJUmrlPxFXNOjAnkY0k44WNdOkJ8g0339vBF8dlHjuXhdUrDPG95Z5V1f8rGvU9HXNzVdQVEx6fms6+oqdfe7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 20:04:41.2828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae22aeeb-1556-4305-6cee-08d57a2f82dc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3174
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISL12026 is a combination RTC and EEPROM device with I2C
interface.  The standard RTC driver interface is provided.  The EEPROM
is accessed via the NVMEM interface via the "eeprom0" directory in the
sysfs entry for the device.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---

Changes from v5:

o removed obsolete call to rtc_valid_tm().

Changes from v4:

o Rebased to rtc-next

o Improvements suggested by Alexandre Belloni

o Added Reviewed-by Rob Herring

Changes from v3:

o Add Reviewed-by

o s/dev_err/dev_warn/ in one place

o Remove redundant ','

Changes from v2:

o More code cleanups suggested by reviewers.

Changes from v1:

o Fixed device tree bindings document example.

o Use RTC_NVMEM facility for eeprom support.

o Small code cleanups suggested by reviewers.

 .../devicetree/bindings/rtc/isil,isl12026.txt      |  28 ++
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-isl12026.c                         | 505 +++++++++++++++++++++
 4 files changed, 544 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl12026.txt
 create mode 100644 drivers/rtc/rtc-isl12026.c

diff --git a/Documentation/devicetree/bindings/rtc/isil,isl12026.txt b/Documentation/devicetree/bindings/rtc/isil,isl12026.txt
new file mode 100644
index 000000000000..2e0be45193bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/isil,isl12026.txt
@@ -0,0 +1,28 @@
+ISL12026 I2C RTC/EEPROM
+
+ISL12026 is an I2C RTC/EEPROM combination device.  The RTC and control
+registers respond at bus address 0x6f, and the EEPROM array responds
+at bus address 0x57.  The canonical "reg" value will be for the RTC portion.
+
+Required properties supported by the device:
+
+ - "compatible": must be "isil,isl12026"
+ - "reg": I2C bus address of the device (always 0x6f)
+
+Optional properties:
+
+ - "isil,pwr-bsw": If present PWR.BSW bit must be set to the specified
+                   value for proper operation.
+
+ - "isil,pwr-sbib": If present PWR.SBIB bit must be set to the specified
+                    value for proper operation.
+
+
+Example:
+
+	rtc@6f {
+		compatible = "isil,isl12026";
+		reg = <0x6f>;
+		isil,pwr-bsw = <0>;
+		isil,pwr-sbib = <1>;
+	}
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index f6d7e490e714..3bf649cd7b83 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -407,6 +407,16 @@ config RTC_DRV_ISL12022
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-isl12022.
 
+config RTC_DRV_ISL12026
+	tristate "Intersil ISL12026"
+	depends on OF || COMPILE_TEST
+	help
+	  If you say yes here you get support for the
+	  Intersil ISL12026 RTC chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-isl12026.
+
 config RTC_DRV_X1205
 	tristate "Xicor/Intersil X1205"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 4fbf87e45a7c..f481661a6eae 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_RTC_DRV_HID_SENSOR_TIME) += rtc-hid-sensor-time.o
 obj-$(CONFIG_RTC_DRV_HYM8563)	+= rtc-hym8563.o
 obj-$(CONFIG_RTC_DRV_IMXDI)	+= rtc-imxdi.o
 obj-$(CONFIG_RTC_DRV_ISL12022)	+= rtc-isl12022.o
+obj-$(CONFIG_RTC_DRV_ISL12026)	+= rtc-isl12026.o
 obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
 obj-$(CONFIG_RTC_DRV_JZ4740)	+= rtc-jz4740.o
 obj-$(CONFIG_RTC_DRV_LP8788)	+= rtc-lp8788.o
diff --git a/drivers/rtc/rtc-isl12026.c b/drivers/rtc/rtc-isl12026.c
new file mode 100644
index 000000000000..ada9849d8d97
--- /dev/null
+++ b/drivers/rtc/rtc-isl12026.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * An I2C driver for the Intersil ISL 12026
+ *
+ * Copyright (c) 2018 Cavium, Inc.
+ */
+#include <linux/bcd.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
+
+/* register offsets */
+#define ISL12026_REG_PWR	0x14
+# define ISL12026_REG_PWR_BSW	BIT(6)
+# define ISL12026_REG_PWR_SBIB	BIT(7)
+#define ISL12026_REG_SC		0x30
+#define ISL12026_REG_HR		0x32
+# define ISL12026_REG_HR_MIL	BIT(7)	/* military or 24 hour time */
+#define ISL12026_REG_SR		0x3f
+# define ISL12026_REG_SR_RTCF	BIT(0)
+# define ISL12026_REG_SR_WEL	BIT(1)
+# define ISL12026_REG_SR_RWEL	BIT(2)
+# define ISL12026_REG_SR_MBZ	BIT(3)
+# define ISL12026_REG_SR_OSCF	BIT(4)
+
+/* The EEPROM array responds at i2c address 0x57 */
+#define ISL12026_EEPROM_ADDR	0x57
+
+#define ISL12026_PAGESIZE 16
+#define ISL12026_NVMEM_WRITE_TIME 20
+
+struct isl12026 {
+	struct rtc_device *rtc;
+	struct i2c_client *nvm_client;
+};
+
+static int isl12026_read_reg(struct i2c_client *client, int reg)
+{
+	u8 addr[] = {0, reg};
+	u8 val;
+	int ret;
+
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= client->addr,
+			.flags	= 0,
+			.len	= sizeof(addr),
+			.buf	= addr
+		}, {
+			.addr	= client->addr,
+			.flags	= I2C_M_RD,
+			.len	= 1,
+			.buf	= &val
+		}
+	};
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret != ARRAY_SIZE(msgs)) {
+		dev_err(&client->dev, "read reg error, ret=%d\n", ret);
+		ret = ret < 0 ? ret : -EIO;
+	} else {
+		ret = val;
+	}
+
+	return ret;
+}
+
+static int isl12026_arm_write(struct i2c_client *client)
+{
+	int ret;
+	u8 op[3];
+	struct i2c_msg msg = {
+		.addr	= client->addr,
+		.flags	= 0,
+		.len	= 1,
+		.buf	= op
+	};
+
+	/* Set SR.WEL */
+	op[0] = 0;
+	op[1] = ISL12026_REG_SR;
+	op[2] = ISL12026_REG_SR_WEL;
+	msg.len = 3;
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev, "write error SR.WEL, ret=%d\n", ret);
+		ret = ret < 0 ? ret : -EIO;
+		goto out;
+	}
+
+	/* Set SR.WEL and SR.RWEL */
+	op[2] = ISL12026_REG_SR_WEL | ISL12026_REG_SR_RWEL;
+	msg.len = 3;
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev,
+			"write error SR.WEL|SR.RWEL, ret=%d\n", ret);
+		ret = ret < 0 ? ret : -EIO;
+		goto out;
+	} else {
+		ret = 0;
+	}
+out:
+	return ret;
+}
+
+static int isl12026_disarm_write(struct i2c_client *client)
+{
+	int ret;
+	u8 op[3] = {0, ISL12026_REG_SR, 0};
+	struct i2c_msg msg = {
+		.addr	= client->addr,
+		.flags	= 0,
+		.len	= sizeof(op),
+		.buf	= op
+	};
+
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev,
+			"write error SR, ret=%d\n", ret);
+		ret = ret < 0 ? ret : -EIO;
+	} else {
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int isl12026_write_reg(struct i2c_client *client, int reg, u8 val)
+{
+	int ret;
+	u8 op[3] = {0, reg, val};
+	struct i2c_msg msg = {
+		.addr	= client->addr,
+		.flags	= 0,
+		.len	= sizeof(op),
+		.buf	= op
+	};
+
+	ret = isl12026_arm_write(client);
+	if (ret)
+		return ret;
+
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev, "write error CCR, ret=%d\n", ret);
+		ret = ret < 0 ? ret : -EIO;
+		goto out;
+	}
+
+	msleep(ISL12026_NVMEM_WRITE_TIME);
+
+	ret = isl12026_disarm_write(client);
+out:
+	return ret;
+}
+
+static int isl12026_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret;
+	u8 op[10];
+	struct i2c_msg msg = {
+		.addr	= client->addr,
+		.flags	= 0,
+		.len	= sizeof(op),
+		.buf	= op
+	};
+
+	ret = isl12026_arm_write(client);
+	if (ret)
+		return ret;
+
+	/* Set the CCR registers */
+	op[0] = 0;
+	op[1] = ISL12026_REG_SC;
+	op[2] = bin2bcd(tm->tm_sec); /* SC */
+	op[3] = bin2bcd(tm->tm_min); /* MN */
+	op[4] = bin2bcd(tm->tm_hour) | ISL12026_REG_HR_MIL; /* HR */
+	op[5] = bin2bcd(tm->tm_mday); /* DT */
+	op[6] = bin2bcd(tm->tm_mon + 1); /* MO */
+	op[7] = bin2bcd(tm->tm_year % 100); /* YR */
+	op[8] = bin2bcd(tm->tm_wday & 7); /* DW */
+	op[9] = bin2bcd(tm->tm_year >= 100 ? 20 : 19); /* Y2K */
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev, "write error CCR, ret=%d\n", ret);
+		ret = ret < 0 ? ret : -EIO;
+		goto out;
+	}
+
+	ret = isl12026_disarm_write(client);
+out:
+	return ret;
+}
+
+static int isl12026_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 ccr[8];
+	u8 addr[2];
+	u8 sr;
+	int ret;
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= client->addr,
+			.flags	= 0,
+			.len	= sizeof(addr),
+			.buf	= addr
+		}, {
+			.addr	= client->addr,
+			.flags	= I2C_M_RD,
+		}
+	};
+
+	/* First, read SR */
+	addr[0] = 0;
+	addr[1] = ISL12026_REG_SR;
+	msgs[1].len = 1;
+	msgs[1].buf = &sr;
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret != ARRAY_SIZE(msgs)) {
+		dev_err(&client->dev, "read error, ret=%d\n", ret);
+		ret = ret < 0 ? ret : -EIO;
+		goto out;
+	}
+
+	if (sr & ISL12026_REG_SR_RTCF)
+		dev_warn(&client->dev, "Real-Time Clock Failure on read\n");
+	if (sr & ISL12026_REG_SR_OSCF)
+		dev_warn(&client->dev, "Oscillator Failure on read\n");
+
+	/* Second, CCR regs */
+	addr[0] = 0;
+	addr[1] = ISL12026_REG_SC;
+	msgs[1].len = sizeof(ccr);
+	msgs[1].buf = ccr;
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret != ARRAY_SIZE(msgs)) {
+		dev_err(&client->dev, "read error, ret=%d\n", ret);
+		ret = ret < 0 ? ret : -EIO;
+		goto out;
+	}
+
+	tm->tm_sec = bcd2bin(ccr[0] & 0x7F);
+	tm->tm_min = bcd2bin(ccr[1] & 0x7F);
+	if (ccr[2] & ISL12026_REG_HR_MIL)
+		tm->tm_hour = bcd2bin(ccr[2] & 0x3F);
+	else
+		tm->tm_hour = bcd2bin(ccr[2] & 0x1F) +
+			((ccr[2] & 0x20) ? 12 : 0);
+	tm->tm_mday = bcd2bin(ccr[3] & 0x3F);
+	tm->tm_mon = bcd2bin(ccr[4] & 0x1F) - 1;
+	tm->tm_year = bcd2bin(ccr[5]);
+	if (bcd2bin(ccr[7]) == 20)
+		tm->tm_year += 100;
+	tm->tm_wday = ccr[6] & 0x07;
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static const struct rtc_class_ops isl12026_rtc_ops = {
+	.read_time	= isl12026_rtc_read_time,
+	.set_time	= isl12026_rtc_set_time,
+};
+
+static int isl12026_nvm_read(void *p, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	struct isl12026 *priv = p;
+	int ret;
+	u8 addr[2];
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= priv->nvm_client->addr,
+			.flags	= 0,
+			.len	= sizeof(addr),
+			.buf	= addr
+		}, {
+			.addr	= priv->nvm_client->addr,
+			.flags	= I2C_M_RD,
+			.buf	= val
+		}
+	};
+
+	/*
+	 * offset and bytes checked and limited by nvmem core, so
+	 * proceed without further checks.
+	 */
+	ret = mutex_lock_interruptible(&priv->rtc->ops_lock);
+	if (ret)
+		return ret;
+
+	/* 2 bytes of address, most significant first */
+	addr[0] = offset >> 8;
+	addr[1] = offset;
+	msgs[1].len = bytes;
+	ret = i2c_transfer(priv->nvm_client->adapter, msgs, ARRAY_SIZE(msgs));
+
+	mutex_unlock(&priv->rtc->ops_lock);
+
+	if (ret != ARRAY_SIZE(msgs)) {
+		dev_err(&priv->nvm_client->dev,
+			"nvmem read error, ret=%d\n", ret);
+		return ret < 0 ? ret : -EIO;
+	}
+
+	return 0;
+}
+
+static int isl12026_nvm_write(void *p, unsigned int offset,
+			      void *val, size_t bytes)
+{
+	struct isl12026 *priv = p;
+	int ret;
+	u8 *v = val;
+	size_t chunk_size, num_written;
+	u8 payload[ISL12026_PAGESIZE + 2]; /* page + 2 address bytes */
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= priv->nvm_client->addr,
+			.flags	= 0,
+			.buf	= payload
+		}
+	};
+
+	/*
+	 * offset and bytes checked and limited by nvmem core, so
+	 * proceed without further checks.
+	 */
+	ret = mutex_lock_interruptible(&priv->rtc->ops_lock);
+	if (ret)
+		return ret;
+
+	num_written = 0;
+	while (bytes) {
+		chunk_size = round_down(offset, ISL12026_PAGESIZE) +
+			ISL12026_PAGESIZE - offset;
+		chunk_size = min(bytes, chunk_size);
+		/*
+		 * 2 bytes of address, most significant first, followed
+		 * by page data bytes
+		 */
+		memcpy(payload + 2, v + num_written, chunk_size);
+		payload[0] = offset >> 8;
+		payload[1] = offset;
+		msgs[0].len = chunk_size + 2;
+		ret = i2c_transfer(priv->nvm_client->adapter,
+				   msgs, ARRAY_SIZE(msgs));
+		if (ret != ARRAY_SIZE(msgs)) {
+			dev_err(&priv->nvm_client->dev,
+				"nvmem write error, ret=%d\n", ret);
+			ret = ret < 0 ? ret : -EIO;
+			break;
+		}
+		ret = 0;
+		bytes -= chunk_size;
+		offset += chunk_size;
+		num_written += chunk_size;
+		msleep(ISL12026_NVMEM_WRITE_TIME);
+	}
+
+	mutex_unlock(&priv->rtc->ops_lock);
+
+	return ret;
+}
+
+static void isl12026_force_power_modes(struct i2c_client *client)
+{
+	int ret;
+	int pwr, requested_pwr;
+	u32 bsw_val, sbib_val;
+	bool set_bsw, set_sbib;
+
+	/*
+	 * If we can read the of_property, set the specified value.
+	 * If there is an error reading the of_property (likely
+	 * because it does not exist), keep the current value.
+	 */
+	ret = of_property_read_u32(client->dev.of_node,
+				   "isil,pwr-bsw", &bsw_val);
+	set_bsw = (ret == 0);
+
+	ret = of_property_read_u32(client->dev.of_node,
+				   "isil,pwr-sbib", &sbib_val);
+	set_sbib = (ret == 0);
+
+	/* Check if PWR.BSW and/or PWR.SBIB need specified values */
+	if (!set_bsw && !set_sbib)
+		return;
+
+	pwr = isl12026_read_reg(client, ISL12026_REG_PWR);
+	if (pwr < 0) {
+		dev_warn(&client->dev, "Error: Failed to read PWR %d\n", pwr);
+		return;
+	}
+
+	requested_pwr = pwr;
+
+	if (set_bsw) {
+		if (bsw_val)
+			requested_pwr |= ISL12026_REG_PWR_BSW;
+		else
+			requested_pwr &= ~ISL12026_REG_PWR_BSW;
+	} /* else keep current BSW */
+
+	if (set_sbib) {
+		if (sbib_val)
+			requested_pwr |= ISL12026_REG_PWR_SBIB;
+		else
+			requested_pwr &= ~ISL12026_REG_PWR_SBIB;
+	} /* else keep current SBIB */
+
+	if (pwr >= 0 && pwr != requested_pwr) {
+		dev_dbg(&client->dev, "PWR: %02x\n", pwr);
+		dev_dbg(&client->dev, "Updating PWR to: %02x\n", requested_pwr);
+		isl12026_write_reg(client, ISL12026_REG_PWR, requested_pwr);
+	}
+}
+
+static int isl12026_probe_new(struct i2c_client *client)
+{
+	struct isl12026 *priv;
+	int ret;
+	struct nvmem_config nvm_cfg;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, priv);
+
+	isl12026_force_power_modes(client);
+
+	priv->nvm_client = i2c_new_dummy(client->adapter, ISL12026_EEPROM_ADDR);
+	if (!priv->nvm_client)
+		return -ENOMEM;
+
+	priv->rtc = devm_rtc_allocate_device(&client->dev);
+	ret = PTR_ERR_OR_ZERO(priv->rtc);
+	if (ret)
+		return ret;
+
+	priv->rtc->ops = &isl12026_rtc_ops;
+	priv->rtc->nvram_old_abi = false;
+	ret = rtc_register_device(priv->rtc);
+	if (ret)
+		return ret;
+
+	memset(&nvm_cfg, 0, sizeof(nvm_cfg));
+	nvm_cfg.name = "eeprom";
+	nvm_cfg.read_only = false;
+	nvm_cfg.root_only = true;
+	nvm_cfg.base_dev = &client->dev;
+	nvm_cfg.priv = priv;
+	nvm_cfg.stride = 1;
+	nvm_cfg.word_size = 1;
+	nvm_cfg.size = 512;
+	nvm_cfg.reg_read = isl12026_nvm_read;
+	nvm_cfg.reg_write = isl12026_nvm_write;
+
+	return rtc_nvmem_register(priv->rtc, &nvm_cfg);
+}
+
+static int isl12026_remove(struct i2c_client *client)
+{
+	struct isl12026 *priv = i2c_get_clientdata(client);
+
+	i2c_unregister_device(priv->nvm_client);
+	return 0;
+}
+
+static const struct of_device_id isl12026_dt_match[] = {
+	{ .compatible = "isil,isl12026" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, isl12026_dt_match);
+
+static struct i2c_driver isl12026_driver = {
+	.driver		= {
+		.name	= "rtc-isl12026",
+		.of_match_table = isl12026_dt_match,
+	},
+	.probe_new	= isl12026_probe_new,
+	.remove		= isl12026_remove,
+};
+
+module_i2c_driver(isl12026_driver);
+
+MODULE_DESCRIPTION("ISL 12026 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.14.3
