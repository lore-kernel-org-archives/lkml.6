Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162166AbeBOTyw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 14:54:52 -0500
Received: from mail-sn1nam01on0074.outbound.protection.outlook.com ([104.47.32.74]:18464
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161938AbeBOTys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:54:48 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
From: David Daney <david.daney@cavium.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v3] rtc: isl12026: Add driver.
Date: Thu, 15 Feb 2018 11:54:37 -0800
Message-Id: <20180215195437.29207-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0082.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::50) To DM5PR07MB3178.namprd07.prod.outlook.com
 (2603:10b6:3:df::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f10890ff-104d-45ec-616e-08d574adf72b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR07MB3178;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3178;3:IrP7kNTYtfWJMhEdxgWBPJHHifOd+TOVIT3EWmA3AeyWo2M3NYBvHUd5GiwbxaPVLNDWhpTQGWOO4qUYTrozonb/EJvN8ssk2+j3bzf1Fcvt5rZoNnbf0yckWypc9LUdXrHZGG8MEx6Q94EAQBekF+nSxWTGnkVVfBvAwgeVa6PvSYX+S3BwE27XT7PcKCtVerT3g4hY6bDOFruwVAajZRzXCggbdQMy8n+BsUa1/3VdCDcM0VfnJSVvtAbfFajv;25:MsRq+FpZdC5c6IaS/EXmrTSA6QqSg4nVG8JDXKj7enLuUyAPLA9MYvhDsA8W8UTRaF7xnS8SHf0gdXlQT01oOWkYrCcVjTSxqn4VxiDz6BYLdBN2bdUREcyjuU9lii5dk1V6Mq+YIcsVI9DD2HyfwQRBaZBGK/mExpFh16v1KgLLXVzug22vSKzOxLsl1WX7uuAPIqaI2UeyHLa7yScDOtBSUHJdscrpZcA3TfMTg3LC0xVaLcpoWwUtf5/DbLcSUDGYFSFYk3lduwLaJpr52+G67OP4NcL/fljo5ziuw0IFVzwUqsPQ1wgL76JIrUiw3pkIbAMpfH/l80Bn/E8k5w==;31:myFalQsBs+m7D0+ewyEEjX204t1bTPiw76DSENtzzK3sAvHCLSQRwmSuvARhVPxZdQXwE9AODPsIlsoA7afdb6agfNEEE8hTu+TTn2UteBIIweIF89bmTQeDU8tpXGiooUYhV5QaBLHM7opD56RxRBTAU+XonAW3gS90P7bZ6+P/cVSwzWLuKnA7c9S3qy5uDPn73cKCUcGqJrxLB3iB3T78Ncf7c0QmrM2PKwi0yNo=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3178:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3178;20:8m7RTc6XfZAdwO7734ejW0Gh7JdALI0b7O5FJBjtlTszCV9IlfbvzH2s0Wfgcl8Laa2g61bZ+bCJXuC8UKawMTVmAu4w8uGe+tFB8oK/9H4Zc/92PDoZtcDtwU7+r6TUKyuSHTr09qCQdBgRWpwbMbq/dVIv1PGXwpmVgP5mgad5CumnzvspUJST/Uzejk+5sWxPnt8X8j+SZ9VC7JbVPDrmC37k/D+1GqtrqDVO5QeDH+AK+Zj92MeLv89Y68mDPFoJWvdMHDvK8V8rgB7g81D6LLy2GB9Y8Wa5+W1v3M3rE2MkF/LzcxRoYzZ5D+6+vsG6nNlgOkft/RtKd++FVUcLuFdCwMQUf6TufTuJ5Ei/71SQie058jqwb58uAp4tK/uwPMR7n54TGMnAb+YYs4mk9pxPZTjtrm1lb5lFPLMtc6up6f20Xi/0FrTceV4jFqIlJN/5NmwB1p0Gw+eOeIBW0pX/2+edaS0n+lXHFfHdNF7EF5svu4FYFd7oE4Vf;4:QhM3VanITUAUSXa6QZ1UjNv6+csRiAC5AcBDih/0QOVRD84EHwBb7v55tij5BT7XFCoiRVzRrqvFH/VH5UOaT1gPVh3Ffj7kmYqkP9ba1UgRbPofQSJQzD3lGPPCeLM4/+ab6koOToaKsd5DBgtzSQYz0QbzCxK5sG7T60pT/xIbO40VmPtNIQFl8gUK2mhPglt5D7rTcOkgWi75GCxX5M9FdSWD3Hsw9RSguX0AJOd21eR2px3iL4aC0aJ0KhrqOfiH/yhyoYBOdHwtTINK/Q==
X-Microsoft-Antispam-PRVS: <DM5PR07MB317872684F6DBFDD5F8A473197F40@DM5PR07MB3178.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231101)(944501161)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR07MB3178;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3178;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(376002)(346002)(39860400002)(396003)(199004)(189003)(107886003)(97736004)(3846002)(26005)(6486002)(53936002)(6506007)(386003)(36756003)(7736002)(16526019)(4326008)(186003)(48376002)(1076002)(69596002)(316002)(105586002)(53416004)(50466002)(478600001)(81156014)(52116002)(81166006)(110136005)(51416003)(5660300001)(59450400001)(16586007)(2906002)(25786009)(106356001)(66066001)(6666003)(50226002)(305945005)(72206003)(575784001)(86362001)(6116002)(47776003)(8676002)(6512007)(68736007)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3178;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3178;23:VHS5zUUacQnhCb4AUWfoZr4LXtJj4x0Do6u8XXmod?=
 =?us-ascii?Q?8SApJIjO0VJtXYozhSinK4VsCqeru8xxPAzOeYbSZONV6xcJ8fvfcMMlTh7O?=
 =?us-ascii?Q?5+WMwAvLFwhTMDnmppSK9NAYVEch/8Ouvk2NW/gO8jahFn5ROR4dURRrNg0h?=
 =?us-ascii?Q?GPRXeoeCF3H/QK/5+HKXgfHt1MX17kAIqIovH01I9clkqz2Mo1/vmL9YUoXi?=
 =?us-ascii?Q?1vX6vCLWlA6MnqQKqzQgtyIst426k24PW71V8Uex64mBuD+gDtQTboVqAnDo?=
 =?us-ascii?Q?IipOLG8tzgcfvl55UrsKErUvEkCOFazA4EQMfD8wIq6FZaCd2r9gszpHiXB1?=
 =?us-ascii?Q?Ow4vnxXgztBdyjncmA++tJmRMSJCHl2bZd4g6viUqY8cgJpfYik3wZlwh9Rr?=
 =?us-ascii?Q?Qda3GYW71OEjj2jVa0YoF+7YrOKJQmFk3GXJ8uAqw/vzDKN7uyYrEuUir9bq?=
 =?us-ascii?Q?WOnDCQmknrx8Ti1HfiT0pQ6yPfziI7r70KJSDCzP8KnlPTz/wc2UUW4HPJc3?=
 =?us-ascii?Q?LrWHLRHC8L5oWK58LMeliXBCSCkUIJAV2/sQYOlZIPT/sZMmw8jFLZCrDSN5?=
 =?us-ascii?Q?x9FIU1i6m1OJLqqXi9Z/AlHxSbMhBFtL+b1rWcVOAfyu6Ms9tcrM5hSDFkf5?=
 =?us-ascii?Q?OkmLugbJMzsm/qxXAU0RJL46K8H8m3Mxaf9y/14pDeUI6It1cmcAzEY2vBj+?=
 =?us-ascii?Q?EjG8QC9KR929ws4tA0SVNFEZJjaF2TLM3LvdJwtfUkKr0Tj360wKSrn5Cup8?=
 =?us-ascii?Q?ok6PnXX5mAiVAHARdJN+pwEAz2zrId3ZVPepW4AdeZl0mFvQb0wU34ZapBQP?=
 =?us-ascii?Q?b7SY5nCH4CcwLWVChGFlwukELeAj4xP+vcdJ/mRtLg+b0LreJcDyxtKs6oZl?=
 =?us-ascii?Q?zi1hSxx6lqYCs/TlVLWdCVKf5eQpGqZT31amSWn6dSehYgbuC+zq3YbAj4SX?=
 =?us-ascii?Q?CaAHJtUHUuwmlPydLZdKU6BWZVxNL3v/p2QVyOT+FRwK2MROj3Dcl+2wAFU8?=
 =?us-ascii?Q?zkBc1z+VDYKJf737Buupr2+NuO7r5+HKrWYQ03BFE4cix8VxU8J0tqJKj9pv?=
 =?us-ascii?Q?USSGP3Tvtz+5YV06expB0z8vduraVy+FS/PH0JyR2iy15AXmtaP2B4x1A/UM?=
 =?us-ascii?Q?Ivv6WJaBZC53uF3dqIl+H0vnCXuwubwn/F0+E14eWnVm722RiukbSlb0hI6c?=
 =?us-ascii?Q?Vo/0cEwfoVYbL7XVjYKt3KEVL7yjiPA7Kye?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3178;6:X5Hs9Er5pn+wQsq7ttI0/hP8CHR42qTf0vAXdhj9oWncGyYBynY1Y7Vm7Z7qVYrYlE7d2H4oA5p2sL41n3N3IuSWVImBS9xRdtkDGj5BOzrgA8L83SVQVTcdYhTvuHHxu4ven6guUzFej9y97IzK52Ta05Cq8DikKAxfrVQ1ij5ZiiTDQonLoZnUJqsh87zNQdFsgCHJNOpcqjT3SqkFZsqjwdITO8tusqqfH2HenxetJ5lSmDHVZQLJa1s8Ar9qXCniDW5r5zstA5BfRxguTnUDPkRg5FMoBIu7AEW/9lQvUqv0crfUR4KBBuHZYIA5+NkhG1Mc0AnQbzYp46yjpfOhenS/PubotVTHF5TfzoA=;5:0Dt66CnPnp4lG/zjbEH8m/iSTn5uid5dqyhsbsWbZOeVWZGaW1Ov7FNj9czrAAXIe6iIHp0zgYXpzPGibeNTVthZbEEk38eQYeGn5BfwZXCa+xlzBhfTR2krZT7/POjD3DY62ZQ4VbRAau0PJHIswqpwrzoIMi+V0VeKZG+i3BA=;24:C0qoHzGis6O4TKtGD969rq8HwxynvVU3EuZU8msu2PULK9gSycTG6ARYJbUDxKngd6VowIKypEJNns1/KE9QozUaLxVPBns8x16wn9aHerM=;7:RdKXfFQqadT8RoEjFJg5Zsq2KtlXTpdXCW1iADGMpUg+S+bCHjijHq2JT++6u/wTrDqjzVtvxAMm3CXBwcPgz9bqxdHFAFX41Mjdt4mT4RbUC9O1XC1gC8MAiCoU1cV7Gzs85D3WLzzcEeCYdF+tVVPo/5RzxvOLl71tkKail8guY5zs/Ht5ulfPD/QVXrCmxDGAlE7rMZlYhCvJ2ODTGPRTjJSyIABw0Ca7vFiI0If3k/I3GRhCjJ4bRFmmE82U
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 19:54:46.1210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f10890ff-104d-45ec-616e-08d574adf72b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3178
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISL12026 is a combination RTC and EEPROM device with I2C
interface.  The standard RTC driver interface is provided.  The EEPROM
is accessed via the NVMEM interface via the "eeprom0" directory in the
sysfs entry for the device.

Signed-off-by: David Daney <david.daney@cavium.com>
---
Changes from v2:

o More code cleanups suggested by reviewers.

Changes from v1:

o Fixed device tree bindings document example.

o Use RTC_NVMEM facility for eeprom support.

o Small code cleanups suggested by reviewers.

.../devicetree/bindings/rtc/isil,isl12026.txt      |  28 ++
 drivers/rtc/Kconfig                                |   9 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-isl12026.c                         | 529 +++++++++++++++++++++
 4 files changed, 567 insertions(+)
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
index 000000000000..1cb111e4c442
--- /dev/null
+++ b/drivers/rtc/rtc-isl12026.c
@@ -0,0 +1,529 @@
+// SPDX-License-Identifier: GPL-2.0
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
+	struct nvmem_config nvm_cfg;
+	/*
+	 * RTC write operations require that multiple messages be
+	 * transmitted, we hold the lock for all accesses to the
+	 * device so that these sequences cannot be disrupted.  Also,
+	 * the write cycle to the nvmem takes many ms during which the
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
+		}, {
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
+	if (ret != ARRAY_SIZE(msgs)) {
+		dev_err(&client->dev, "read reg error, ret=%d\n", ret);
+		ret = ret < 0 ? ret : -EIO;
+	} else {
+		ret = val;
+	}
+
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int isl12026_write_reg(struct i2c_client *client, int reg, u8 val)
+{
+	struct isl12026 *priv = i2c_get_clientdata(client);
+	int ret;
+	u8 op[3];
+	struct i2c_msg msg = {
+		.addr	= client->addr,
+		.flags	= 0,
+		.len	= 1,
+		.buf	= op
+	};
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
+	}
+
+	op[1] = reg;
+	op[2] = val;
+	msg.len = 3;
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev, "write error CCR, ret=%d\n", ret);
+		ret = ret < 0 ? ret : -EIO;
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
+		ret = ret < 0 ? ret : -EIO;
+		goto out;
+	}
+	ret = 0;
+out:
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int isl12026_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct isl12026 *priv = i2c_get_clientdata(client);
+	int ret;
+	u8 op[10];
+	struct i2c_msg msg = {
+		.addr	= client->addr,
+		.flags	= 0,
+		.len	= 1,
+		.buf	= op
+	};
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
+	}
+
+	/* Set the CCR registers */
+	op[1] = ISL12026_REG_SC;
+	op[2] = bin2bcd(tm->tm_sec); /* SC */
+	op[3] = bin2bcd(tm->tm_min); /* MN */
+	op[4] = bin2bcd(tm->tm_hour) | ISL12026_REG_HR_MIL; /* HR */
+	op[5] = bin2bcd(tm->tm_mday); /* DT */
+	op[6] = bin2bcd(tm->tm_mon + 1); /* MO */
+	op[7] = bin2bcd(tm->tm_year % 100); /* YR */
+	op[8] = bin2bcd(tm->tm_wday & 7); /* DW */
+	op[9] = bin2bcd(tm->tm_year >= 100 ? 20 : 19); /* Y2K */
+	msg.len = 10;
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev, "write error CCR, ret=%d\n", ret);
+		ret = ret < 0 ? ret : -EIO;
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
+		ret = ret < 0 ? ret : -EIO;
+		goto out;
+	}
+	ret = 0;
+out:
+	mutex_unlock(&priv->lock);
+
+	return ret;
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
+	ret = rtc_valid_tm(tm);
+out:
+	mutex_unlock(&priv->lock);
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
+	if (offset >= priv->nvm_cfg.size)
+		return 0; /* End-of-file */
+	if (offset + bytes > priv->nvm_cfg.size)
+		bytes = priv->nvm_cfg.size - offset;
+
+	mutex_lock(&priv->lock);
+
+	/* 2 bytes of address, most significant first */
+	addr[0] = offset >> 8;
+	addr[1] = offset;
+	msgs[1].len = bytes;
+	ret = i2c_transfer(priv->nvm_client->adapter, msgs, ARRAY_SIZE(msgs));
+
+	mutex_unlock(&priv->lock);
+
+	if (ret != ARRAY_SIZE(msgs)) {
+		dev_err(priv->nvm_cfg.dev, "nvmem read error, ret=%d\n", ret);
+		return ret < 0 ? ret : -EIO;
+	}
+
+	return bytes;
+}
+
+static int isl12026_nvm_write(void *p, unsigned int offset,
+			      void *val, size_t bytes)
+{
+	struct isl12026 *priv = p;
+	int ret = -EIO;
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
+			dev_err(priv->nvm_cfg.dev,
+				"nvmem write error, ret=%d\n", ret);
+			ret = ret < 0 ? ret : -EIO;
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
+	return num_written >= 0 ? num_written : ret;
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
+		dev_err(&client->dev, "Error: Failed to read PWR %d\n", pwr);
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
+		dev_info(&client->dev, "PWR: %02x\n", pwr);
+		dev_info(&client->dev,
+			 "Updating PWR to: %02x\n", requested_pwr);
+		isl12026_write_reg(client, ISL12026_REG_PWR, requested_pwr);
+	}
+}
+
+static int isl12026_probe_new(struct i2c_client *client)
+{
+	struct isl12026 *priv;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mutex_init(&priv->lock);
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
+
+	priv->nvm_cfg.name = "eeprom";
+	priv->nvm_cfg.read_only = false;
+	priv->nvm_cfg.root_only = true;
+	priv->nvm_cfg.base_dev = &client->dev;
+	priv->nvm_cfg.priv = priv;
+	priv->nvm_cfg.stride = 1;
+	priv->nvm_cfg.word_size = 1;
+	priv->nvm_cfg.size = 512;
+	priv->nvm_cfg.reg_read = isl12026_nvm_read;
+	priv->nvm_cfg.reg_write = isl12026_nvm_write;
+
+	priv->rtc->nvmem_config = &priv->nvm_cfg;
+	priv->rtc->nvram_old_abi = false;
+
+	return rtc_register_device(priv->rtc);
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
+	{ },
+};
+MODULE_DEVICE_TABLE(of, isl12026_dt_match);
+
+static struct i2c_driver isl12026_driver = {
+	.driver		= {
+		.name	= "rtc-isl12026",
+		.of_match_table = of_match_ptr(isl12026_dt_match),
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
