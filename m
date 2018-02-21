Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeBUAda (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 19:33:30 -0500
Received: from mail-by2nam01on0056.outbound.protection.outlook.com ([104.47.34.56]:6976
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750732AbeBUAd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 19:33:28 -0500
From: David Daney <david.daney@cavium.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v5] rtc: isl12026: Add driver.
Date: Tue, 20 Feb 2018 16:33:16 -0800
Message-Id: <20180221003316.13007-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0020.namprd07.prod.outlook.com (10.166.107.15) To
 MWHPR07MB3184.namprd07.prod.outlook.com (10.172.96.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae5226be-1cf7-4ec4-79e5-08d578c2b897
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR07MB3184;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3184;3:CCT6DhlqzpHVVsFDJ+bZiozdSUp3lY7iOuDLsbtWQU7e8mUnApj9xwlfIvmVc4PW1bu9b6sN30PoB2Wnn219ZdcyNYv6td0ikpN/wlUmOqQ1kkmmbT9JRxpP5zjUqSREbNoY2XMDp0RQqBaze0T+rWCsTKm0PmRIyPb+vCf2z1MU9EN/M/2lz+jhfCmOF2V6tzG5YjVAm07S+KRdFjYPjGU6gyxalEA7ybcoc3eW72/ZJydrduy+FWmsXMkeDPE6;25:pC/y8KDpM0P2KuO6h0LHniyHATNi+AG828w8lvAxDgk8TyTbrRjCTgLLPbvRY98R4IxXH3Zq8BSQC3LsItnWPYvpDjCTR/d+l/CuPpEFESkHrLXTyXtudPqiF5QjFFUMbVkP+TuuaUHkQCEVLIqsstisyyVy7rjyNYAOKAq0gchJ+IYn3RPRk76hq0ogm3qDauIuXyFMLrdSLvvn9XdgeD0DPvqXi+zUMCJ+gx9rZVL5rW5gYug/U+3iXHOKUxNNO+HmPFHxvTUW/WUvGs2ihUfEPyyUdcnQIXBfDfy8S53LTl89mKcOMcRu/nF0qr6QujTnoeF6qG4h08v2EEYW3A==;31:c1G3RAAVXGXngt/d+ANVybx7ifdc4dPsGKrCH/mLXzd0ywTidtoTOZTe5otSHJ9sPOmF/f1RBRrnRh4Zb9E7p6IyfYx4SJIDwG27BycqCG0PxZxsr/X9Mr9r3EJMgZdNmGgLg0p3vI5RW73WoIyx3iX1LRB4THF4RMcHognrB1zJGTj+8DUUvpJnzjuRV6oSKYRj3Wub2xqy7Yte5C7/stHNXbh2aq5yhI5wwVAfq4Q=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3184:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3184;20:097LYtFA1hBkSw/BEGTCmsoU30t2AWeCax9mUCifch1a8j/zjn29bweiDLl2wLTL5hlSykeFQPcnHE5+Cemzb3H57A5diHRcHled/z62GfUP/B7YEoh0yRtsPYkcNknN68xpJMRid4sDoT5CDuO7ME6jnjChGWjKu9b+e2fiptwnItcwJROeSLqXm5R3WPJ/uKxqYib4kVmJ1kvdnCy5dC069hvP1uWXSujWWIwsV3HcYIvjLpE1UibdMdnW8DwUrWcJptENm/gjim9SiiCXlKeqaBrVZO+V63ItSRZRBkwa3dg0w8D5bIRr2tXGA+esiv/OS6KpRDBJ2mtAUwOjb6Sf/LGHXZHmmdp+PR5A4HXKH0UxEnvFCOh8YE6XQ4uYZGXNZEKSYJCirTm9bU9cavNoKzwNPIdsQXNa5wC8wVJA6h0PaVKziBQI3Jc4ebmdrnu4vpC9UE44n9k0cOXUhLhpAur9S0CsmCDyUeNFG2zR1W1tTRUTEnrMVenLkhfy;4:VcneLO9WeEEpUHSzfcwuXS1tBkABvDlxiNJUorVnknbZWRj3IG+/Zgfqvu42/7VtwrBQDems70BnDDUH/jBMdUeEnq/Vn51pdY6rpLzN+gmzid7HIfZ1/m3gtxxAfzJXj7iUgUIXqxXiSpUaoBJT2+fRmPLEnC4i7MS8/WDB4JjDSKQaUBWsljQ+Sz4S6X9HbqMBiBXaGbrv1foEqE7PuWMa8+BaOOOD2w65SQ/sPRb7Vhu6YPsKP5n0AhvL630ly1hq6i/mTkNnhefWUpQIiEI4jy7s6kU6T/m8Kz3QqC1IjrOrfOhIFR8idbE+Lb+m
X-Microsoft-Antispam-PRVS: <MWHPR07MB31847AA93BCCD7DBFE2BFE5097CE0@MWHPR07MB3184.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001061)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(944501161)(93006095)(93001095)(10201501046)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR07MB3184;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3184;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39380400002)(39860400002)(366004)(199004)(189003)(97736004)(72206003)(2906002)(8676002)(81156014)(81166006)(106356001)(5660300001)(6666003)(25786009)(6512007)(6486002)(68736007)(6116002)(8936002)(3846002)(1076002)(478600001)(53936002)(50226002)(48376002)(107886003)(305945005)(4326008)(51416003)(575784001)(53416004)(86362001)(69596002)(110136005)(52116002)(50466002)(16586007)(316002)(39060400002)(16526019)(6506007)(386003)(59450400001)(7736002)(26005)(105586002)(47776003)(186003)(36756003)(66066001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3184;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3184;23:5bzOuERWCqF3rndEGSj2fN2Rf4SKZPlSAwx2NPOS2?=
 =?us-ascii?Q?wcPFnUKr5ynuXih0B7CzHMQnW6ApKQR8mlHEb17XXr+3qisN3y5rWVANu32a?=
 =?us-ascii?Q?Nw9jtuaPXJw89HtVyszKQr/FZvDRIC1p815ko5a09tZnN+usVQ+xe2aVZFUJ?=
 =?us-ascii?Q?JHvvJN3uNIjvxCpkdpbLMI/wJsy5ooPcG1JRG1vPc17RfA3Dh6lpLCrtwahc?=
 =?us-ascii?Q?FAWmY/0N3rSFIWwNEq3/xRWuNuYMmsWNy8mfoDTtmQmCWGTiU9Wgpcc9q9MN?=
 =?us-ascii?Q?BKs83sH4T+8ASYEht9iOBfYEmEVlebIEd8mmmDXbVA/siD5xQ5tHx9M3uXZ/?=
 =?us-ascii?Q?TBDl0qDWEvT8pS8RXx0sjpcRprjZDlmIxU6URUYeTsK/GXeE9PJmBYHphILd?=
 =?us-ascii?Q?2liHZSBvB/iWldNLb/uP/sUDMhKNHhfGy20+cPMDuCuT7jxlEoBPK+lypE5Z?=
 =?us-ascii?Q?GxNUrAsn5uEnu6DZgQl/2DmW67ldkiSA9sO5M85Fbvz0C2kv8cGP8CTT2l/5?=
 =?us-ascii?Q?kFgzyXDfamZyCc/oEnN8HZdJ976eXuKnYC7BYoEcOfL1uUn7uTT2pcqjiUnn?=
 =?us-ascii?Q?xe4P6wQcQJj/oGU0082moBftpfp1FJIqo7LIwW99/4SBqciLWh+kXDjn4r1c?=
 =?us-ascii?Q?Brrg8OchWYe/Tco1DxlLKUfynQ4kue3tstl3ocNMiHwK/GvUOUgMrQVJ0QXD?=
 =?us-ascii?Q?19w9OHIFettBmm8vIuIhIcvd9bdU+z3hA23Ix6IakWpfnXB9StUEcyCM9zeX?=
 =?us-ascii?Q?P5CYTSWl1pvkEcRhyQdVdYNdYSoVaX1p4azWg+2gJMrY9XNBpFRTitUZzjde?=
 =?us-ascii?Q?Sly5QEcIraVM5Cmzeu2hAs66FDiLY+RGVYeQ6Sq1JDVwNEyNIjlla0YV/UJT?=
 =?us-ascii?Q?QxVIlJdxSKPLup4jo2AZmXecIIH2hrbPORPCj5+n8EiE7wnlzVi2ltXBytiq?=
 =?us-ascii?Q?VVk6DLAz63nwx8RsiMc/WArlntRuRIye+twT0XQTBOcL491V+KhLhupPSarM?=
 =?us-ascii?Q?cWdivD/8jx/PXD034e13xf3oMxlflJgf31ZCKVtU9eTC8JI2KYWp6AU3CCZx?=
 =?us-ascii?Q?vLiLGnCI6oyYmpeWbhZSmKeJI0kakOusAY7heU/1ZFF/NGLToT2G4SN8BpyL?=
 =?us-ascii?Q?OssyR4iJloXtGpvR4z/gZ1SEVU2Q4/H3rPQsg4TX6O6+jVm7Y/cP5TTiLjo4?=
 =?us-ascii?Q?+Ulft+dNWG+Cd+YubYyyLBuIth8z1AgDsyV4t16QzBCPVxuBBgbuWodXrZLE?=
 =?us-ascii?Q?I0XEJovvthJ5VW82qG+9y6eeRYnCW24YEsgDK6K?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3184;6:CAqgyJSNJBhx2/NeBu67JuKnen1Ncro+koyUz5Nswdy81Hm3AdReGdvTKk3T0Vehr2vN/tdwiZqXfE2CdeRHEYPjQ8zyhNf+a0LMe/j4hhh0r72M71lGhAhXKdJ3aWn7cEOqV6mJO41bUXfbxLkmmK17cU9TusnWbjS1aakJ+PY0oQFWMutMHtt24ZB5naOG9QXnHebJeC+JZb9UJx/mR5ip5AvCVREqjmZD0FyGtIPRx4pVAbnKi/9yCOzv0iogZmC7c+TMN9ezoPzmcjJxejaGtd2tGRFzrC7nVgY3m3Eltzt9jc05nyR7wAh9y883VYTeqalMQp8jxgfZVe5uBg==;5:Ojc3Cmdjr0ZotD6rIALoHm1Ld6YaFwJdppTinz1Z1HaJnHIQZyMSz+nyp8s+TjJSQj3NsPObcd7A0aZbljohrqeixJm7q1dtIM2uJD9Qf/q9o+5yNEcfTe8RvVW+mx9y5pGSJL5Vqor40z8Ts6qgjLs4Z8Iq6sTmyfqZeiTh6jA=;24:0vGrazusIcZOCjLsYI/X16sbvEXXTJ1kP3Wp32zIJJhtV1TmdkGdelh5VpOMdHZ7ehEdr/XWBGjAAfHnu+d5/HXnyvMWzbAjtnUibFM6jl0=;7:jkGtqzQeD318zwql6dsDYOwXrYll2C5I+ubh3/kAsdv/W6hwjhsIG9/ZOjkaHCiy41VKoCpvYAp1BIuzvljqwJdc5pBH4pUm/Nbl/Mj9TvLed2urCQ6ZywzpTj5AWwFt2EnmBFXabbTGH+cYYABvyHdh3QWaz8ZXXzlugDM6pctfhzzp2CnzBaVkgWoWDNFdQC5rv76LR1JMCVWT5jHl868OVIb67TEnAB4n0+njoXqxPtmO5z05KvCTfFlGBmbe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 00:33:25.5122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5226be-1cf7-4ec4-79e5-08d578c2b897
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3184
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
index 000000000000..521511d1cc2d
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
+	ret = rtc_valid_tm(tm);
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
