Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932169AbeBLS7a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:59:30 -0500
Received: from mail-sn1nam01on0051.outbound.protection.outlook.com ([104.47.32.51]:43429
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753366AbeBLS71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:59:27 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
From: David Daney <david.daney@cavium.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH] rtc: isl12026: Add driver.
Date: Mon, 12 Feb 2018 10:59:15 -0800
Message-Id: <20180212185915.25041-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CY1PR07CA0002.namprd07.prod.outlook.com (10.166.202.12) To
 MWHPR07MB3183.namprd07.prod.outlook.com (10.172.96.141)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea1c77c1-6c30-44fa-e0a5-08d5724abbe4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:MWHPR07MB3183;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3183;3:wo95vcqTzLF1Ehxn1ijIIqxMv9IOmQ2bGU28ux0VROL4ZIy7ACp5sdrqPOro86eeL1lDQjZnggDH4IYDR/r93P/Tc0y2qh/XxkQtwXGvNSeDIo5nLcALf6OCOhWtkbepRvJftVbkEoz/OiordZmvyefY4TW5veMBI+N/Ncsu3qKJavVRWzmhh+KW184KnSawXx5iQ+IbvGSbUgYrkIsPUV64Jwq4OkKLvRq2/7TN7jJlN/PJQOYqDxIuTB0g2+cb;25:iMom6B2ZZAJBEQIvdJI7UO8Ho6a7XHPf3f/69wmctq5MAsLcGJ0WrFGLnM1fSzGhH8oGH8EDKn5m2kYw2mfCtdjBtWn8qv/2/SuozWOzSDrz+DjISQuDAC9S+VFwU5+2Zd8k7048l5aXQIfX8eCanfn4ec4fmh4RsbNi5/HL6pc94F+VFhAiZkpiJCHA0LGdky5yeFgO2Hfp/Z9SAF1ZZ30ZtwmDx1Q+8lGqvK/IlTpAhj39LJVQgF7Qvnpu734DVBYDXP9LlDw0N2lJ2PXihFQPoFEzGDRDlB0sc8iqEByqRt0EQ4HnYEASnYbhJcQyUAvbb9821JHZZXH1tJAa5A==;31:9BVqf3lGKTeq4rO7bcwyTSjXIuxZVF3JJOzT8PG+JZI83KQv77fMnhEqZcOMR1pyxsnBMsHnwpCx0nBO8YkHOQAkZu2J6Ce+ABU/0YBvEWZintVcgeX7h1Fjl3x8Okdv4ilfPe/FKipiVwV8qmjBPuJHW7m6V93KvCdY1FXx5FxdA6UvknZ0E9Kv9yyn65BCe+sRxEJlNvzRP0ABVDI2QU4Etp9okhHTD05xRKGS5Io=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3183:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3183;20:Oi0/LPJ/3CpeCgGAHVMzwxtoWZYYtdXPa98C2eS54hKX0J0RQhKDv1U+0NQQxYlLRIQXUH7ng5qMjZejrk6QMCYV8abaC4ZbsRJpsl/Tbu08o8Lic7kk4ctcbmAnlTWwOqFZalxwUWNstujOe9aQM0WUDKBcWYKxNmkrwKR62p6eWe8NTokBosKsif46IY1uuaciK4KEgYK941wGFTM/kWSB2uSSozcSwjVb58xmHAzm9HTlR/XHXLzh5XOEbvTHkz71BT6FVqEXkl2EupWJY8w1aIM+mcC5/+8EGs2mscWsm1kM1DF30z+zqcUtUTnwjT8uF8G4AzhejAcx7J8NokkV5dunKVXpzJnxxQIY9YEK8Ws0PU9f/ORlTfwrWZiThizASTDdlpeB0ad2Re2y0Pl/pjuFz+ja5leW53uM3xoWTjjHv+RlZFc0cH+OpGzygKKgg7KFJ6OzJNsH1mrVEAffTjIJWyvtQ+IcARwcWd8S3mjbGalVMkJB84jOXjXi;4:ad4fV8M8/qqfdE7U3FQK1quXQWbvJpE3bsABciOKVD6JgOCqG1eIpnvW1WDiJf1w7Qtio52pBluMt65J/t9k7F4O6XXQC4NaJ1Twozn4Pf8VE4j+2Hkx5HoLeEy4dXeGLmv9Tv5iaj8o/dm3KioTuTFdko7ip3mieSYOSDm1sA/E6vLZjDdSvLH6EjUJ0Kwp7EuxM5TNc7LjhQfeIBNeVYG1/AlyXwN29XPV64vwXVAKvkgcbBgChZZhpD9IPFDWW6uaemVRvxFyyy0fmcsQNw==
X-Microsoft-Antispam-PRVS: <MWHPR07MB3183F1540D1297D3953886CA97F70@MWHPR07MB3183.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR07MB3183;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3183;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(346002)(366004)(396003)(199004)(189003)(59450400001)(53416004)(53936002)(66066001)(6666003)(105586002)(6506007)(6116002)(1076002)(72206003)(478600001)(6512007)(47776003)(26005)(16526019)(1857600001)(386003)(3846002)(186003)(2906002)(5660300001)(4326008)(106356001)(8936002)(81156014)(8676002)(107886003)(25786009)(81166006)(97736004)(50226002)(305945005)(7736002)(6486002)(68736007)(36756003)(69596002)(316002)(52116002)(51416003)(16586007)(50466002)(110136005)(86362001)(575784001)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3183;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3183;23:zoJTnmxiC+mkRZNANwRMpcWx8OUVtOuqwB/P/wPdn?=
 =?us-ascii?Q?ZECfA2ioB+b2RAyjOzgswjIUJa9DWidRi54zn04S2t9MX9xYKtuRkAp2E/CI?=
 =?us-ascii?Q?96AsMEsmxh2Zm1ayo2QSiVddPqwBRo5mvG+Ocg8wWDhjK/sbAFml9+mbQGA0?=
 =?us-ascii?Q?rPJWBT5ZQKVNdoYL/xmV1Dt1wYcutZSmXpXceo1pMNjP3uJx19yQPOCUMlnW?=
 =?us-ascii?Q?MHefzyKg8dUrXJ5wlrIV28CEBbitLOU6Cx+x/mpZB6RR6Evyo9k7smHeNSZY?=
 =?us-ascii?Q?6sDkfucOfqdtC3lJFhgH0+Fq78M6V3qoxHjs9lYz2+XlEgLZmKp/8lqJC9ZQ?=
 =?us-ascii?Q?B6DcIRDJJEOlaKjcGmTF4VWCACYPoQXPuu5T8d7nIi7sAMyIi0VQ9C3AkeyK?=
 =?us-ascii?Q?JTLW3h0WF00yjsIy1VWcyU6yrL+yik09ttSaOec+E61dvT+4LTlUjuTqECL1?=
 =?us-ascii?Q?kTehMfeMWJ4xW/+K336hGlicS6y3DvtWxjiMsGhbdCqmZKmfYFh65mqg06F8?=
 =?us-ascii?Q?fSVtau37dMdjp4E6VnYbG4Xn5PfwWEMysTJnXr+/6Cc+o5JmHslOCbJcT/AL?=
 =?us-ascii?Q?PEvNyMijG3XmYpFpdihi6JK9Z7RVdG4nW9wZQqo3A1M7TIUin0wW8JT5rlTh?=
 =?us-ascii?Q?OokRNv+kIsPfCWTzClX06NYtASDktlhF4YD/oTV+z6/VOITGJL2zQd0NVD8W?=
 =?us-ascii?Q?EU06zkUpCvm2Kc39sUpV/LAajM/lSn1Lzn2hpfmr5OeywAjFY5L88jXEc7fq?=
 =?us-ascii?Q?79m6trS2ZSYe/FoiY/1frHUrI2FlYqG6dfjZkYm8akvAsCL4dwexklLey3J0?=
 =?us-ascii?Q?TKzIpkCKybz/P3gtMfYZzT4jgBdzRSKV8iH7t04FoVoSUnohpHZW/gcskym1?=
 =?us-ascii?Q?K4wiya27ke8ef1cLwFDaMQ1k6CJ19cNbLX8F+UUkxB18fp+APXSiTEvX5vkm?=
 =?us-ascii?Q?Y6L/7FbHKpIKYrvEjqOnGPEVOi55fi50P880df2UrMfIMBFAzu8AHGaFqZ8s?=
 =?us-ascii?Q?ZokOZVjwkreLYLK3VudIM8OPYCjGP8BXw5yV0c2ez4StgofPSHUeqoPORQq2?=
 =?us-ascii?Q?U9j/VRJIA36AE9W9uNvg/WLIdJ4KEkmsJlQj+DqNFHEWQulnQjLbYTtHuNqD?=
 =?us-ascii?Q?R1wyB1sM7C+lgTV1mIjGDohjVmnTLJEODug7hreJHxc+X8dWiwOts7ANvV0t?=
 =?us-ascii?Q?LG7o5UcB1yIoON+s0U50g/faaTS54+nIYnIurzAYRWCs7YoX1b4uZoncA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3183;6:532BXhrUJmpy4z7X4nLhPXKHGKeIbq+EKvmwSWPLHR/J4teNhwSDS/l+35M+qI4AnRIJExsJpEFP3j3srclEYR3P7nIx4R0Ib2fn5+PlPc1G+MZGd4fwBxj4KOh+O4cTQ29cBFnA7SOPWnKlCANzD6/gTWRREpbviZ92u0kYzGsylb9Tweaf1QsT91gVuiLltswll6ut21Z9OMcSxhpIiT5Hl+rVg2loWQEd0wFeYEDIrr4Fet8vwhbVG529JRr9N5KeAj5pQUECt9zVfk9Cdp/oYNauTl38A/9NhrjsYFNyblltNW2vX+sSLqTcMgHPtQ2qIeUe8N0uapkKzKeE5R5ZBrpOXNfUy813BBIuBCM=;5:92YPCjzjcJeAKmmtjQWa8hY631RSa3DTCgERh9GA+iXyo1qWDIqTRmjw6npN1V4GRNx0fWubWAAK4ckcDiUZG9AHsiHFCd5QRCWDJYdjc/qv2L4CLptL2Jfiax1pmHOiFN00s2pBWp81zWVjDZYY6tWELnSmoqlNyp6XTqw82ls=;24:qAqsnZzdTEVs+7hcU0QdOuL22aDs74oYwB0hWdgzXHehfuWCY5qJvzu7WZo7P4uz7A5RXTGB7917k0FdnW2LhoNZg9FQVfcoNHdD13k3CuI=;7:w/p/GTzt2F93T36xEvPQzp4Ej3STHwu58t9shvY4SiQxDjLub5PWu1vVEeeeWCi5s7uS49RnFe2sQY0y8DbqbINocxZazhzXtyyU3li8p0peWbOVW9MHbe1X7HGK2yop8bVQNw9sqTulucbOgJuGNFEMMbxN2XBnuGh8J8ISCvqyspy6SPUgnh7dPbV2XQ3RXuhJa6v6IYV66hHokMYjFZ2YtghqmUHr/X+iVE7bPEznU8kHvpT2NmUFlvZwUjqT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 18:59:24.2966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1c77c1-6c30-44fa-e0a5-08d5724abbe4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3183
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISL12026 is a combination RTC and EEPROM device with I2C
interface.  The standard RTC driver interface is provided.  The EEPROM
is accessed via the NVMEM interface via the "eeprom0" directory in the
sysfs entry for the device.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 .../devicetree/bindings/rtc/isil,isl12026.txt      |  27 +
 drivers/rtc/Kconfig                                |   9 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-isl12026.c                         | 550 +++++++++++++++++++++
 4 files changed, 587 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl12026.txt
 create mode 100644 drivers/rtc/rtc-isl12026.c

diff --git a/Documentation/devicetree/bindings/rtc/isil,isl12026.txt b/Documentation/devicetree/bindings/rtc/isil,isl12026.txt
new file mode 100644
index 000000000000..4b6c7177a95a
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/isil,isl12026.txt
@@ -0,0 +1,27 @@
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
+		reg = <0x6f>;
+		isil,pwr-bsw = <0>;
+		isil,pwr-sbib = <1>;
+	}
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8ab5f0a5d323..85171e9e3ada 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -407,6 +407,15 @@ config RTC_DRV_ISL12022
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-isl12022.
 
+config RTC_DRV_ISL12026
+	tristate "Intersil ISL12026"
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
index 000000000000..a5f04e0faceb
--- /dev/null
+++ b/drivers/rtc/rtc-isl12026.c
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An I2C driver for the Intersil ISL 12026
+ *
+ * Copyright (c) 2018 Cavium, Inc.
+ */
+#include <linux/types.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/bcd.h>
+#include <linux/i2c.h>
+#include <linux/rtc.h>
+#include <linux/of.h>
+
+/* register offsets */
+#define ISL12026_REG_SC		0x30
+
+#define ISL12026_REG_SR		0x3f
+# define ISL12026_REG_SR_RTCF	BIT(0)
+# define ISL12026_REG_SR_WEL	BIT(1)
+# define ISL12026_REG_SR_RWEL	BIT(2)
+# define ISL12026_REG_SR_MBZ	BIT(3)
+# define ISL12026_REG_SR_OSCF	BIT(4)
+
+/* ISL register bits */
+#define ISL12026_HR_MIL		BIT(7)	/* military or 24 hour time */
+
+#define ISL12026_REG_PWR	0x14
+# define ISL12026_REG_PWR_BSW	BIT(6)
+# define ISL12026_REG_PWR_SBIB	BIT(7)
+
+#define ISL12026_PAGESIZE 16
+#define ISL12026_NVMEM_WRITE_TIME 20
+
+struct isl12026 {
+	struct rtc_device *rtc;
+	struct i2c_client *nvm_client;
+	struct nvmem_device *nvm_dev;
+	struct nvmem_config nvm_cfg;
+	/*
+	 * RTC write operations require that multiple messages be
+	 * transmitted, we hold the lock for all accesses to the
+	 * device so that these sequences cannot be disrupted.  Also,
+	 * the write cycle to the nvmem takes many mS during which the
+	 * device does not respond to commands, so holding the lock
+	 * also prevents access during these times.
+	 */
+	struct mutex lock;
+};
+
+static int isl12026_read_reg(struct i2c_client *client, int reg)
+{
+	struct isl12026 *priv = i2c_get_clientdata(client);
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
+		},
+		{
+			.addr	= client->addr,
+			.flags	= I2C_M_RD,
+			.len	= 1,
+			.buf	= &val
+		}
+	};
+
+	mutex_lock(&priv->lock);
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+
+	mutex_unlock(&priv->lock);
+
+	if (ret != ARRAY_SIZE(msgs)) {
+		dev_err(&client->dev, "read reg error, ret=%d\n", ret);
+		return -EIO;
+	}
+	return val;
+}
+
+static int isl12026_write_reg(struct i2c_client *client, int reg, u8 val)
+{
+	struct isl12026 *priv = i2c_get_clientdata(client);
+	int rv = 0;
+	u8 op[3];
+
+	struct i2c_msg msg = {
+		.addr	= client->addr,
+		.flags	= 0,
+		.len	= 1,
+		.buf	= op
+	};
+
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	/* Set SR.WEL */
+	op[0] = 0;
+	op[1] = ISL12026_REG_SR;
+	op[2] = ISL12026_REG_SR_WEL;
+	msg.len = 3;
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev, "write error SR.WEL, ret=%d\n", ret);
+		rv = -EIO;
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
+		rv = -EIO;
+		goto out;
+	}
+
+	op[1] = reg;
+	op[2] = val;
+	msg.len = 3;
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev, "write error CCR, ret=%d\n", ret);
+		rv = -EIO;
+		goto out;
+	}
+
+	msleep(ISL12026_NVMEM_WRITE_TIME);
+
+	/* Clear SR.WEL and SR.RWEL */
+	op[1] = ISL12026_REG_SR;
+	op[2] = 0;
+	msg.len = 3;
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev, "write error SR, ret=%d\n", ret);
+		rv = -EIO;
+		goto out;
+	}
+
+out:
+	mutex_unlock(&priv->lock);
+
+	return rv;
+}
+
+static int isl12026_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct isl12026 *priv = i2c_get_clientdata(client);
+	int rv = 0;
+	u8 op[10];
+
+	struct i2c_msg msg = {
+		.addr	= client->addr,
+		.flags	= 0,
+		.len	= 1,
+		.buf	= op
+	};
+
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	/* Set SR.WEL */
+	op[0] = 0;
+	op[1] = ISL12026_REG_SR;
+	op[2] = ISL12026_REG_SR_WEL;
+	msg.len = 3;
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev, "write error SR.WEL, ret=%d\n", ret);
+		rv = -EIO;
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
+		rv = -EIO;
+		goto out;
+	}
+
+	/* Set the CCR registers */
+	op[1] = ISL12026_REG_SC;
+	op[2] = bin2bcd(tm->tm_sec); /* SC */
+	op[3] = bin2bcd(tm->tm_min); /* MN */
+	op[4] = bin2bcd(tm->tm_hour) | ISL12026_HR_MIL; /* HR */
+	op[5] = bin2bcd(tm->tm_mday); /* DT */
+	op[6] = bin2bcd(tm->tm_mon + 1); /* MO */
+	op[7] = bin2bcd(tm->tm_year % 100); /* YR */
+	op[8] = bin2bcd(tm->tm_wday & 7); /* DW */
+	op[9] = bin2bcd(tm->tm_year >= 100 ? 20 : 19); /* Y2K */
+	msg.len = 10;
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev, "write error CCR, ret=%d\n", ret);
+		rv = -EIO;
+		goto out;
+	}
+
+	/* Clear SR.WEL and SR.RWEL */
+	op[1] = ISL12026_REG_SR;
+	op[2] = 0;
+	msg.len = 3;
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev, "write error SR, ret=%d\n", ret);
+		rv = -EIO;
+		goto out;
+	}
+
+out:
+	mutex_unlock(&priv->lock);
+
+	return rv;
+}
+
+static int isl12026_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct isl12026 *priv = i2c_get_clientdata(client);
+	u8 ccr[8];
+	u8 addr[2];
+	u8 sr;
+	int ret;
+	int rv = 0;
+
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= client->addr,
+			.flags	= 0,
+			.len	= sizeof(addr),
+			.buf	= addr
+		},
+		{
+			.addr	= client->addr,
+			.flags	= I2C_M_RD,
+		}
+	};
+
+	mutex_lock(&priv->lock);
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
+		rv = -EIO;
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
+		rv = -EIO;
+		goto out;
+	}
+
+	dev_dbg(&client->dev,
+		"raw data is sec=%02x, min=%02x, hr=%02x, mday=%02x, mon=%02x, year=%02x, wday=%02x, y2k=%02x\n",
+		ccr[0], ccr[1], ccr[2], ccr[3],
+		ccr[4], ccr[5], ccr[6],	ccr[7]);
+
+	tm->tm_sec = bcd2bin(ccr[0] & 0x7F);
+	tm->tm_min = bcd2bin(ccr[1] & 0x7F);
+	if (ccr[2] & ISL12026_HR_MIL)
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
+	dev_dbg(&client->dev, "secs=%d, mins=%d, hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
+		tm->tm_sec, tm->tm_min, tm->tm_hour,
+		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
+	rv = rtc_valid_tm(tm);
+out:
+	mutex_unlock(&priv->lock);
+	return rv;
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
+	int r;
+	u8 addr[2];
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= priv->nvm_client->addr,
+			.flags	= 0,
+			.len	= sizeof(addr),
+			.buf	= addr
+		},
+		{
+			.addr	= priv->nvm_client->addr,
+			.flags	= I2C_M_RD,
+			.buf	= val
+		}
+	};
+
+	if (offset >= priv->nvm_cfg.size)
+		return 0; /* End-of-file */
+	if (offset + bytes > priv->nvm_cfg.size)
+		bytes = priv->nvm_cfg.size - offset;
+
+	addr[0] = (offset >> 8) & 0xff;
+	addr[1] = offset & 0xff;
+	msgs[1].len = bytes;
+	mutex_lock(&priv->lock);
+
+	r = i2c_transfer(priv->nvm_client->adapter, msgs, ARRAY_SIZE(msgs));
+
+	mutex_unlock(&priv->lock);
+
+	if (r != ARRAY_SIZE(msgs)) {
+		dev_err(priv->nvm_cfg.dev, "nvmem read error, ret=%d\n", r);
+		return -EIO;
+	}
+
+	return bytes;
+}
+
+static int isl12026_nvm_write(void *p, unsigned int offset,
+			      void *val, size_t bytes)
+{
+	struct isl12026 *priv = p;
+	int r;
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
+	if (offset >= priv->nvm_cfg.size)
+		return 0; /* End-of-file */
+	if (offset + bytes > priv->nvm_cfg.size)
+		bytes = priv->nvm_cfg.size - offset;
+
+	mutex_lock(&priv->lock);
+
+	num_written = 0;
+	while (bytes) {
+		chunk_size = round_down(offset, ISL12026_PAGESIZE) +
+			ISL12026_PAGESIZE - offset;
+		chunk_size = min(bytes, chunk_size);
+		memcpy(payload + 2, v + num_written, chunk_size);
+		payload[0] = (offset >> 8) & 0xff;
+		payload[1] = offset & 0xff;
+		msgs[0].len = chunk_size + 2;
+		r = i2c_transfer(priv->nvm_client->adapter,
+				 msgs, ARRAY_SIZE(msgs));
+		if (r != ARRAY_SIZE(msgs)) {
+			dev_err(priv->nvm_cfg.dev,
+				"nvmem write error, ret=%d\n", r);
+			break;
+		}
+		bytes -= chunk_size;
+		offset += chunk_size;
+		num_written += chunk_size;
+		msleep(ISL12026_NVMEM_WRITE_TIME);
+	}
+
+	mutex_unlock(&priv->lock);
+
+	return num_written > 0 ? num_written : -EIO;
+}
+
+static int isl12026_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct isl12026 *priv;
+	int pwr, requested_pwr;
+	int ret;
+	u32 bsw_val, sbib_val;
+	bool set_bsw, set_sbib;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	priv = devm_kzalloc(&client->dev, sizeof(struct isl12026), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mutex_init(&priv->lock);
+
+	i2c_set_clientdata(client, priv);
+
+	ret = of_property_read_u32(client->dev.of_node,
+				   "isil,pwr-bsw", &bsw_val);
+	set_bsw = (ret == 0);
+
+	ret = of_property_read_u32(client->dev.of_node,
+				   "isil,pwr-sbib", &sbib_val);
+	set_sbib = (ret == 0);
+
+	/* Check if PWR.BSW and/or PWR.SBIB need specified values */
+
+	if (set_bsw || set_sbib) {
+		pwr = isl12026_read_reg(client, ISL12026_REG_PWR);
+		if (pwr < 0)
+			dev_err(&client->dev,
+				"Error: Failed to read PWR %d\n", pwr);
+
+		requested_pwr = pwr;
+
+		if (set_bsw) {
+			if (bsw_val)
+				requested_pwr |= ISL12026_REG_PWR_BSW;
+			else
+				requested_pwr &= ~ISL12026_REG_PWR_BSW;
+		}
+		if (set_sbib) {
+			if (sbib_val)
+				requested_pwr |= ISL12026_REG_PWR_SBIB;
+			else
+				requested_pwr &= ~ISL12026_REG_PWR_SBIB;
+		}
+
+		if (pwr >= 0 && pwr != requested_pwr) {
+			dev_info(&client->dev, "PWR: %02x\n", pwr);
+			dev_info(&client->dev,
+				 "Updating PWR to: %02x\n", (u8)requested_pwr);
+			isl12026_write_reg(client,
+					   ISL12026_REG_PWR, requested_pwr);
+		}
+	}
+
+	priv->rtc = devm_rtc_device_register(&client->dev, "rtc-isl12026",
+					     &isl12026_rtc_ops, THIS_MODULE);
+
+	ret = PTR_ERR_OR_ZERO(priv->rtc);
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_NVMEM)) {
+		/* The NVMem array responds at i2c address 0x57 */
+		priv->nvm_client = i2c_new_dummy(client->adapter, 0x57);
+		if (!priv->nvm_client)
+			return -ENOMEM;
+
+		priv->nvm_cfg.name = "eeprom";
+		priv->nvm_cfg.dev = &client->dev;
+		priv->nvm_cfg.read_only = false;
+		priv->nvm_cfg.root_only = true;
+		priv->nvm_cfg.owner = THIS_MODULE;
+		priv->nvm_cfg.base_dev = &client->dev;
+		priv->nvm_cfg.priv = priv;
+		priv->nvm_cfg.stride = 1;
+		priv->nvm_cfg.word_size = 1;
+		priv->nvm_cfg.size = 512;
+		priv->nvm_cfg.reg_read = isl12026_nvm_read;
+		priv->nvm_cfg.reg_write = isl12026_nvm_write;
+		priv->nvm_dev = nvmem_register(&priv->nvm_cfg);
+
+		if (!priv->nvm_dev)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+static int isl12026_remove(struct i2c_client *client)
+{
+	struct isl12026 *priv = i2c_get_clientdata(client);
+
+	if (priv->nvm_dev)
+		nvmem_unregister(priv->nvm_dev);
+	if (priv->nvm_client)
+		i2c_unregister_device(priv->nvm_client);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id isl12026_dt_match[] = {
+	{ .compatible = "isil,isl12026" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, isl12026_dt_match);
+#endif
+
+static const struct i2c_device_id isl12026_id[] = {
+	{ "isl12026", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, isl12026_id);
+
+static struct i2c_driver isl12026_driver = {
+	.driver		= {
+		.name	= "rtc-isl12026",
+#ifdef CONFIG_OF
+		.of_match_table = of_match_ptr(isl12026_dt_match),
+#endif
+	},
+	.probe		= isl12026_probe,
+	.remove		= isl12026_remove,
+	.id_table	= isl12026_id,
+};
+
+module_i2c_driver(isl12026_driver);
+
+MODULE_DESCRIPTION("ISL 12026 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.14.3
