Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966341AbeBNAzw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 19:55:52 -0500
Received: from mail-dm3nam03on0046.outbound.protection.outlook.com ([104.47.41.46]:55871
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966220AbeBNAzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 19:55:49 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
From: David Daney <david.daney@cavium.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v2] rtc: isl12026: Add driver.
Date: Tue, 13 Feb 2018 16:55:36 -0800
Message-Id: <20180214005536.22739-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0021.namprd07.prod.outlook.com (10.161.192.159)
 To DM5PR07MB3180.namprd07.prod.outlook.com (10.172.85.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4e24e06-b01c-429d-dc38-08d57345ae76
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR07MB3180;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;3:F24wLY5EluU/eTQa7G2IH+5rAw6UgHqwwlvcsxHLplVQbDg6bBl1eKe2Od79osznhmIoIxi942BX/LnLnvOyAYLt012HE+d7RoELoqrh9qG2ZQrVWOB3Lj7S9M6gHpQXjkIN4BI+2ecUZ6tRO70Z7nd8YTPiwpF2kcL+FqP3c7vJwlO1tE3a6BvCxMTe/CsHpT5SampZG3N1nIaSwfuKJpFcOaDMA8rBH6M3AZBPChujwnWn5pQkx/xhqqGDmk/y;25:YCNE0TONCPXqTz+FEFS1jyijD5DhqAgb0VAEgv3t7Nt+qzjMFXz5LbD4sBjX/Yb6Zfn3ZlUCkwBgYaSQqKSZKdLZOHUochoSFWPl+4HzcetxiKH83HItT5HaKnfB7yq58Dq34AyEutpITASjudqWjzPowp2nJwuybKboI7AmvwnW+3nWWBE/6zw+2lz3oYX3I2YfB08r1rQHbrr9wvpjtXlk6ise7OXt3BD9vEJRUITfAyEu4ZxqjVLLKCXPb7U5GV6ZtTwnuMShS63lZ6EPgvxf65SOP124BQ3BoPBgUFiVuME3SWmXN2q4MjTanIVH0vzJaAC/q0pv4emk6N3+3Q==;31:fTwtEJ5KB3+vf9RF/En1VH00fZ9hM30idONl5lAblCjzoPPnrRYXiKRAojGBnH0vj2hzXWlSJOUow2nZQAVDLSGw5F1BGjLY7h+hQkJdZ1v3+uWpMMYzf1Udj5oEzdaGxvhX6qvtj5btQnkNQAFVd/ngchFEGtj1XX5fJQGYejqPrIpoxE1hpNWLr2POIL/vPXzVn4CZtHtJW47fo/g/+onEXmvWEh4tmEQXpVGedtg=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3180:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;20:8gvH+UbAZzGiK89g/9TUhqW1uwrE6pcgqXLrXsd4CMFzzd4vuu96GnxGfAf2l5P48AikKND30lKjtEjjwLeIixCxz+GbWwxx/+IM16K87b2eQP20KNaC5W3QwC521cMPzsB8VzN8on8swJW1pKVI3oIV4mGE4pKiUE8/h6g5oZS8pwQXVLS8ihJBrFF5aSjdyGYApuWB12br/d7R7PwuT8rOFvj+VTVYGGPwJoU6U5dYgcA8SyRK5mMMIi1NSThcPiWEuTLHcE/01uYo6pxlcaVrzUStlKVnMvIP5qfBMrCJL/pMd2db84w23iS6wonikf65SBLgy7oxka3ukbl+rmk+IiCeVIlAUT9do5Z5d016oaA5TOuoWKJOweDAJJlAFZr0DQgsRlyJWEKJyTDLJ6+ZgD2NtG02q+mSUiRppofGohpYS6O1/EV4QRZ0a4NdWyg/Y3+QEPU/JQ3Pj6yrqYviOBwkhmgfGrD1JuDyfxVcjqkPhHi0QXKdJnuvkOvr;4:7PqJ3MkezHuT2CXXpZyyLZApJEH6xonBPtxmCyZ2CPmUHZRzoE8j51cIm1f+ApE0kpnaTSxbQTS7CZfZxh7JSyH5IH5DZksyGXMW29LXyF/1JWwaqlaZm9Zlib95fEBdf56lywuD6lmdSVTZ/wMoBJhyc12DK6SSz5Zi7fztO5GeYJ/et1VBzVr4icvMyBL5IPYGB03ggdeq3Ds5jStcxrOxGXy/vLGqC/pZi0MkkUkHcT6felJpxae6yYu/a/Giq6Nd4qqi7LqRzQ/y6cTfSA==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3180FF4467D1A44D6927BB1597F50@DM5PR07MB3180.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231101)(2400082)(944501161)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR07MB3180;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3180;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39850400004)(366004)(396003)(346002)(376002)(189003)(199004)(6666003)(69596002)(53416004)(6486002)(6512007)(68736007)(59450400001)(25786009)(53936002)(51416003)(386003)(6506007)(52116002)(81156014)(81166006)(50226002)(26005)(8936002)(4326008)(107886003)(6116002)(3846002)(48376002)(2906002)(36756003)(97736004)(1076002)(7736002)(47776003)(50466002)(478600001)(5660300001)(8676002)(106356001)(305945005)(316002)(66066001)(72206003)(575784001)(16526019)(186003)(86362001)(16586007)(105586002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3180;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3180;23:stJlLgool2qeck0UyinwJOpjvK+ULf8FbOS++Rt98?=
 =?us-ascii?Q?gr2uMOe8w8VbQv/4PZpFZpuTgATwx3a29k6B2/cuPgIKVbz12bvRnX9BYqzn?=
 =?us-ascii?Q?jtctso51jQItVEdJBvUQDQNfddsXMnu+PHQux3Nk2W3FmT2qsj8HagcGPsw+?=
 =?us-ascii?Q?Ok2JXMAVjY9YX48+nO6x0UBf23Z3ChcA6VW2UtxjlggVYHLMqipnctDDZYNw?=
 =?us-ascii?Q?zfk8egqaNNqfTCGR+W7AsVDWAHlLGrYUIjd91BIAwPNFLtKYaz1T9oaanROl?=
 =?us-ascii?Q?C21eZpuFSKKjY3hXL0R2Ulsxet6It3jpnw9wb1VRlFwxjjaKygUJu+x2kzwh?=
 =?us-ascii?Q?BQ2VIkA1zF99fWRG36Uq3NaqspJzgy3yERN8BuV+JZlaxjI4H4FoxEVFwCpx?=
 =?us-ascii?Q?h9DoaVv1Ed7pqhnLaYBpNMjbgegpJBarKEAhehQK0PJRFACQzAbV03QejrH2?=
 =?us-ascii?Q?4wre/DQujWn23R/BbpIRbd2SP9PIc7MdWQDsbTeUh+EuPzlttXr0Qkbv7II/?=
 =?us-ascii?Q?czGqge7xHrHMV/Busow6mtxjnqvG91yhGQPx5ZA+EKpzYqiKWmYmSTRYrdnb?=
 =?us-ascii?Q?+n+kJnWBHdgS1ct1AmITctY+fUSXnJay3f68VhQD/2ZBQ8mK37mlyQZYJZLh?=
 =?us-ascii?Q?U8rIQ039nR59V28Z7G7t7dKtWb+DEd8tta9yVYFyuNt7I0Xi17WoWzuN0WvT?=
 =?us-ascii?Q?TjSAb2HUmhu8fp23G0i2EAttSJ2DLd90oYPbiOxpcyDAnF0BMmitpW0nZ9Ut?=
 =?us-ascii?Q?AHfQBrXOdFwWuEPQORI8//88U35Fp8rgr9VUcL1OkirBEs6QjXZd1lS7n0gD?=
 =?us-ascii?Q?hK5tSGTZmAbveOXLMvGbh2xbxT/RejH1enXTcLEBR2FXCXh1JBiCCdu8NF/A?=
 =?us-ascii?Q?w27MgG3UWDPjLzjP3u2c0CU45wDoLge7vY5hkZcXgYupDgqxXYH69SOzQt3F?=
 =?us-ascii?Q?Lc0re47xuZI7YOTYAWMvJYVfySjk4cyCA22UF7WKx7IfpW0Y2wG9VfC/yJuY?=
 =?us-ascii?Q?+GcX7F5GcTvSzBKHqc2cFL9gwMQYxK0/jDZw2QN4kix6bPqBrqKWO/INHTk/?=
 =?us-ascii?Q?+HGHBNlR/At/4LXpSICg2qipzkcr/MvoO5TySW7RHVBdkQJhrg1/QkQgxwFI?=
 =?us-ascii?Q?3RYpo0FsU3NNDLcRiykPm2lEq7PGL+veiKNQhriZotrsAzLpAmBZwsmYZY7Y?=
 =?us-ascii?Q?3e2eBe/CMIcbPnW0erGbwW57R3I5gwLw3Yb?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;6:YCKNfIcYm1gVVAwR+LZzV1C8swaYJMJrFqaEzN5oBWtfCjdHoLqzFkU3Lzt4Rv/nboQ1fdf/NJ2O76gBTcaAlG68BCoUS28CAXu4two7JHhsH2IIaJTEGT1hDuBRgZ42g0J+kaaUHNEkDYuo/l2R3KoROfANXbEEqs0SqybQX10riOtAtlTmFzfln7SctMNLKic9WB6IHrnDl7goYTN9c1VMAOEVIdVJ5kSmK6HqtrGbWAkVkbPwEaTVjyi9c6CqyAt3YY4inIJLqVaCHrF9L/P7TMBMVQlNjsSEFNusI4Mu2Xldg0SI0neo1L0g7YBXXy03YLcRKvvwD99S2/tSgVC0PSM+3aCM7MJwUJ2PEdU=;5:Z2CQc6ZrKF55fKyKh2d4lEqvaPzzwal2+guBVjyoetNQR4tU1SgbnYFWIXpnb3DYHlBzjKIfYbs5m2+1hz00MOFkEhnXzkLrx755Vfr/YJveUaB0Nqdbb6NxWkTVpmA67PUyYDrX3NzFem9+zP2LpLIzKfqCdnUl8HHauwGvBf0=;24:EiIEfnO5eJqgIjoPhDdiVRjfKP/88ZU++T5s9Tc+bnCpT58RqDG6kjBPo9fmi4zeJZDxqlVeoYs7V+1bL/y4W1PuAq3+sU+ovay9u93F3wc=;7:JkSolI0ESQ+gBhAxj5fymEJ9aESDmZ8n4Onw389LWgKkgNqiK69xRm1/BpKRMzOf7Ln1UIXNrulFgwepU3FlN3b0Rn5cfQbhkfSp7K6e4Q9EwNYnv3LI8yPao9hZlfv8gl0NBbO+xMx1JalCkhj3X7Elx5xGPlYEkHTgAWeoiGCrY+LK+mGVEZL6BRuZiSmlI1T1d9FzxFV1/x1cCEcPNQd5eH5RBxQYlv62djEa6JolGsqtGGgB7MW6uiPlkCyS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 00:55:45.3037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e24e06-b01c-429d-dc38-08d57345ae76
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISL12026 is a combination RTC and EEPROM device with I2C
interface.  The standard RTC driver interface is provided.  The EEPROM
is accessed via the NVMEM interface via the "eeprom0" directory in the
sysfs entry for the device.

Signed-off-by: David Daney <david.daney@cavium.com>
---

Changes from v1:

o Fixed device tree bindings document example.

o Use RTC_NVMEM facility for eeprom support.

o Small code cleanups suggested by reviewers.

 .../devicetree/bindings/rtc/isil,isl12026.txt      |  28 ++
 drivers/rtc/Kconfig                                |   9 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-isl12026.c                         | 526 +++++++++++++++++++++
 4 files changed, 564 insertions(+)
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
index 000000000000..73bb70a2fde2
--- /dev/null
+++ b/drivers/rtc/rtc-isl12026.c
@@ -0,0 +1,526 @@
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
+	return val;
+}
+
+static int isl12026_write_reg(struct i2c_client *client, int reg, u8 val)
+{
+	struct isl12026 *priv = i2c_get_clientdata(client);
+	int ret;
+	int rv = 0;
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
+		rv = ret < 0 ? ret : -EIO;
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
+		rv = ret < 0 ? ret : -EIO;
+		goto out;
+	}
+
+	op[1] = reg;
+	op[2] = val;
+	msg.len = 3;
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev, "write error CCR, ret=%d\n", ret);
+		rv = ret < 0 ? ret : -EIO;
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
+		rv = ret < 0 ? ret : -EIO;
+		goto out;
+	}
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
+	int ret;
+	int rv = 0;
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
+		rv = ret < 0 ? ret : -EIO;
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
+		rv = ret < 0 ? ret : -EIO;
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
+		rv = ret < 0 ? ret : -EIO;
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
+		rv = ret < 0 ? ret : -EIO;
+		goto out;
+	}
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
+		rv = ret < 0 ? ret : -EIO;
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
+		rv = ret < 0 ? ret : -EIO;
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
+	addr[0] = (offset >> 8) & 0xff;
+	addr[1] = offset & 0xff;
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
+		payload[0] = (offset >> 8) & 0xff;
+		payload[1] = offset & 0xff;
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
+		if (pwr < 0) {
+			dev_err(&client->dev,
+				"Error: Failed to read PWR %d\n", pwr);
+			return;
+		}
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
+			dev_info(&client->dev, "PWR: %02x\n", (u8)pwr);
+			dev_info(&client->dev,
+				 "Updating PWR to: %02x\n", (u8)requested_pwr);
+			isl12026_write_reg(client,
+					   ISL12026_REG_PWR, requested_pwr);
+		}
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
+	/* The NVMem array responds at i2c address 0x57 */
+	priv->nvm_client = i2c_new_dummy(client->adapter, 0x57);
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
+#ifdef CONFIG_OF
+static const struct of_device_id isl12026_dt_match[] = {
+	{ .compatible = "isil,isl12026" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, isl12026_dt_match);
+#endif
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
