Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44643C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3BD21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M7MXuYkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfAXGEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:04:37 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:56710 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbfAXGEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:04:36 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190124060430epoutp04087cd3b2451184d90fd3f33c185a1274~8s5_8t_uz3049330493epoutp043
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 06:04:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190124060430epoutp04087cd3b2451184d90fd3f33c185a1274~8s5_8t_uz3049330493epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548309870;
        bh=mD79Z+qYfuZTu4r5Crad9OSvhRk1a986S55m2/JOvxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7MXuYkT8ztfOwBEiHgLc5ExJi8rUo38+6/jSSixhZ6IfLuRfNtXFEuS40khypFzf
         y6/lIwcW33aesm1mOcA8HqF49tbSwT4dv/h99amCAkt0GulZ9vnOax+GnfkNfHfaQb
         JQkSna3vJDicIlddMhhNylCFrIWFWHZE570Nw7vc=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190124060427epcas1p37aeba34f944a354c9f4beaa50dcd00df~8s58SKDfi2522725227epcas1p3p;
        Thu, 24 Jan 2019 06:04:27 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.FE.04069.365594C5; Thu, 24 Jan 2019 15:04:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190124060419epcas1p4aed00219fc0e0281c2d5435ce6ec2e48~8s50Zjh_a2523825238epcas1p4I;
        Thu, 24 Jan 2019 06:04:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190124060419epsmtrp2b74b985a68b3f02cf6f5db59f85bc35a~8s50YuIZE2894028940epsmtrp2j;
        Thu, 24 Jan 2019 06:04:19 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-11-5c49556316bf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.E2.03971.365594C5; Thu, 24 Jan 2019 15:04:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190124060419epsmtip120c471488469bd50a160290ae2d7d4a8~8s50NlFnO1788617886epsmtip1F;
        Thu, 24 Jan 2019 06:04:19 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        vijaikumar.kanagarajan@gmail.com, myungjoo.ham@samsung.com
Subject: [PATCH v3] extcon: Add support for ptn5150 extcon driver
Date:   Thu, 24 Jan 2019 15:04:14 +0900
Message-Id: <1548309854-5324-1-git-send-email-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548247616-6709-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7bCmvm5yqGeMwcouWYuJN66wWFz/8pzV
        4vKuOWwWtxtXsFm83D+d1YHVY+esu+wem1Z1snn0bVnF6PF5k1wAS1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdkbP7gtsBadTKh5PfMjc
        wHgzqIuRg0NCwESi8ZJaFyMXh5DADkaJP7MbmSGcT4wSLd9usUM43xgl+p/dB3I4wTq+72+H
        qtrLKDHt+QlWkISQwBdGif9340FsNgEtif0vbrCB2CICChKbe5+B1TALZEscPnUEbJCwgKPE
        lSkrWUBsFgFViU8bXzCD2LwCLhKf1m9ihFgmJ3HzXCdYnFMgQGLdx/1MIIslBDrYJC5tussK
        UeQicfDIXSYIW1ji1fEtUJdKSXx+t5cNwq6WWHnyCBtUM6PElv0XoJqNJfYvncwECgxmAU2J
        9bv0IQ7lk3j3tYcVEka8Eh1tQhDVyhKXH8CskpRY3N4JNd5DYubmP9DQWswocXTjH7YJjLKz
        EKYuYGRcxSiWWlCcm55abFhgjBxLmxjBaUnLfAfjhnM+hxgFOBiVeHg5Cj1ihFgTy4orcw8x
        SnAwK4nwul50ixHiTUmsrEotyo8vKs1JLT7EaAoMvonMUqLJ+cCUmVcSb2hqZGxsbGFiaGZq
        aKgkzrvewTlGSCA9sSQ1OzW1ILUIpo+Jg1OqgbHraePertLtb+NSy19Wa1lJ5RR6BpyOOJr3
        zCikXz9YjHmv+1I9DR+55tCzt3eu4i6bxegRW/tbNqFdTnd9wQ27jMt85Q5GFqF/AmSaljhH
        Ngv/kRIXTbzvKbs0/N72jY16MofP32pZtkjaLZ7rDoPPoRZX3RmetuoSk961LGn8eGHB6aZz
        SizFGYmGWsxFxYkAMF3doGEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsWy7bCSnG5yqGeMwetFHBYTb1xhsbj+5Tmr
        xeVdc9gsbjeuYLN4uX86qwOrx85Zd9k9Nq3qZPPo27KK0ePzJrkAligum5TUnMyy1CJ9uwSu
        jJ7dF9gKTqdUPJ74kLmB8WZQFyMnh4SAicT3/e3MXYxcHEICuxklNncdYYNISEpMu3gUKMEB
        ZAtLHD5cDFHziVFi+RSIGjYBLYn9L26A2SICChKbe5+xgtjMAvkS5w40gMWFBRwlrkxZyQJi
        swioSnza+IIZxOYVcJH4tH4TI8QuOYmb5zrB4pwCARLrPu5nAtkrJOAvsf6p4gRGvgWMDKsY
        JVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYKDSktzB+PlJfGHGAU4GJV4eDkKPWKEWBPL
        iitzDzFKcDArifC6XnSLEeJNSaysSi3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFq
        EUyWiYNTqoFRtXxL9XtFHpk53JcX1+ucnlceGmXTpNB00l9P7Fd0+PHQMHYdI9ZDWXt37ebe
        drE2YanLlxvSnsGSN+8VbmDT2/pF4GbHQwGLtEfePyrzJ3wTiDJZJ3g+ofrmE/OiWdlrrWSq
        xNg75U//3iPxIPj61ORtr/e119Y3757M6xfDEmX98rOrP7sSS3FGoqEWc1FxIgChBcdBJgIA
        AA==
X-CMS-MailID: 20190124060419epcas1p4aed00219fc0e0281c2d5435ce6ec2e48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190124060419epcas1p4aed00219fc0e0281c2d5435ce6ec2e48
References: <1548247616-6709-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
        <CGME20190124060419epcas1p4aed00219fc0e0281c2d5435ce6ec2e48@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>

PTN5150 is a small thin low power CC (Configurationn Channel)
Logic chip supporting the USB Type-C connector application with
CC control logic detection and indication functions.

Signed-off-by: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
[cw00.choi: fix indentation of binding document and change patch subject]
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../devicetree/bindings/extcon/extcon-ptn5150.txt  |  27 ++
 drivers/extcon/Kconfig                             |   8 +
 drivers/extcon/Makefile                            |   1 +
 drivers/extcon/extcon-ptn5150.c                    | 339 +++++++++++++++++++++
 4 files changed, 375 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
 create mode 100644 drivers/extcon/extcon-ptn5150.c

diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
new file mode 100644
index 000000000000..936fbdf12815
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
@@ -0,0 +1,27 @@
+* PTN5150 CC (Configuration Channel) Logic device
+
+PTN5150 is a small thin low power CC logic chip supporting the USB Type-C
+connector application with CC control logic detection and indication functions.
+It is interfaced to the host controller using an I2C interface.
+
+Required properties:
+- compatible: should be "nxp,ptn5150"
+- reg: specifies the I2C slave address of the device
+- int-gpio: should contain a phandle and GPIO specifier for the GPIO pin
+	connected to the PTN5150's INTB pin.
+- vbus-gpio: should contain a phandle and GPIO specifier for the GPIO pin which
+	is used to control VBUS.
+- pinctrl-names : a pinctrl state named "default" must be defined.
+- pinctrl-0 : phandle referencing pin configuration of interrupt and vbus
+	control.
+
+Example:
+	ptn5150@1d {
+		compatible = "nxp,ptn5150";
+		reg = <0x1d>;
+		int-gpio = <&msmgpio 78 GPIO_ACTIVE_HIGH>;
+		vbus-gpio = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ptn5150_default>;
+		status = "okay";
+	};
diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index de15bf55895b..b9cc027e89ab 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -114,6 +114,14 @@ config EXTCON_PALMAS
 	  Say Y here to enable support for USB peripheral and USB host
 	  detection by palmas usb.

+config EXTCON_PTN5150
+	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here to enable support for USB peripheral and USB host
+	  detection by NXP PTN5150 CC (Configuration Channel) logic chip.
+
 config EXTCON_QCOM_SPMI_MISC
 	tristate "Qualcomm USB extcon support"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index 0888fdeded72..261ce4cfe209 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_EXTCON_MAX77693)	+= extcon-max77693.o
 obj-$(CONFIG_EXTCON_MAX77843)	+= extcon-max77843.o
 obj-$(CONFIG_EXTCON_MAX8997)	+= extcon-max8997.o
 obj-$(CONFIG_EXTCON_PALMAS)	+= extcon-palmas.o
+obj-$(CONFIG_EXTCON_PTN5150)	+= extcon-ptn5150.o
 obj-$(CONFIG_EXTCON_QCOM_SPMI_MISC) += extcon-qcom-spmi-misc.o
 obj-$(CONFIG_EXTCON_RT8973A)	+= extcon-rt8973a.o
 obj-$(CONFIG_EXTCON_SM5502)	+= extcon-sm5502.o
diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
new file mode 100644
index 000000000000..b6d0557030d3
--- /dev/null
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// extcon-ptn5150.c - PTN5150 CC logic extcon driver to support USB detection
+//
+// Based on extcon-sm5502.c driver
+// Copyright (c) 2018-2019 by Vijai Kumar K
+// Author: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/extcon-provider.h>
+#include <linux/gpio.h>
+
+/* PTN5150 registers */
+enum ptn5150_reg {
+	PTN5150_REG_DEVICE_ID = 0x01,
+	PTN5150_REG_CONTROL,
+	PTN5150_REG_INT_STATUS,
+	PTN5150_REG_CC_STATUS,
+	PTN5150_REG_CON_DET = 0x09,
+	PTN5150_REG_VCONN_STATUS,
+	PTN5150_REG_RESET,
+	PTN5150_REG_INT_MASK = 0x18,
+	PTN5150_REG_INT_REG_STATUS,
+	PTN5150_REG_END,
+};
+
+#define PTN5150_DFP_ATTACHED			0x1
+#define PTN5150_UFP_ATTACHED			0x2
+
+/* Define PTN5150 MASK/SHIFT constant */
+#define PTN5150_REG_DEVICE_ID_VENDOR_SHIFT	0
+#define PTN5150_REG_DEVICE_ID_VENDOR_MASK	\
+	(0x3 << PTN5150_REG_DEVICE_ID_VENDOR_SHIFT)
+
+#define PTN5150_REG_DEVICE_ID_VERSION_SHIFT	3
+#define PTN5150_REG_DEVICE_ID_VERSION_MASK	\
+	(0x1f << PTN5150_REG_DEVICE_ID_VERSION_SHIFT)
+
+#define PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT	2
+#define PTN5150_REG_CC_PORT_ATTACHMENT_MASK	\
+	(0x7 << PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT)
+
+#define PTN5150_REG_CC_VBUS_DETECTION_SHIFT	7
+#define PTN5150_REG_CC_VBUS_DETECTION_MASK	\
+	(0x1 << PTN5150_REG_CC_VBUS_DETECTION_SHIFT)
+
+#define PTN5150_REG_INT_CABLE_ATTACH_SHIFT	0
+#define PTN5150_REG_INT_CABLE_ATTACH_MASK	\
+	(0x1 << PTN5150_REG_INT_CABLE_ATTACH_SHIFT)
+
+#define PTN5150_REG_INT_CABLE_DETACH_SHIFT	1
+#define PTN5150_REG_INT_CABLE_DETACH_MASK	\
+	(0x1 << PTN5150_REG_CC_CABLE_DETACH_SHIFT)
+
+struct ptn5150_info {
+	struct device *dev;
+	struct extcon_dev *edev;
+	struct i2c_client *i2c;
+	struct regmap *regmap;
+	struct gpio_desc *int_gpiod;
+	struct gpio_desc *vbus_gpiod;
+	int irq;
+	struct work_struct irq_work;
+	struct mutex mutex;
+};
+
+/* List of detectable cables */
+static const unsigned int ptn5150_extcon_cable[] = {
+	EXTCON_USB,
+	EXTCON_USB_HOST,
+	EXTCON_NONE,
+};
+
+static const struct regmap_config ptn5150_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= PTN5150_REG_END,
+};
+
+static void ptn5150_irq_work(struct work_struct *work)
+{
+	struct ptn5150_info *info = container_of(work,
+			struct ptn5150_info, irq_work);
+	int ret = 0;
+	unsigned int reg_data;
+	unsigned int int_status;
+
+	if (!info->edev)
+		return;
+
+	mutex_lock(&info->mutex);
+
+	ret = regmap_read(info->regmap, PTN5150_REG_CC_STATUS, &reg_data);
+	if (ret) {
+		dev_err(info->dev, "failed to read CC STATUS %d\n", ret);
+		mutex_unlock(&info->mutex);
+		return;
+	}
+
+	/* Clear interrupt. Read would clear the register */
+	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &int_status);
+	if (ret) {
+		dev_err(info->dev, "failed to read INT STATUS %d\n", ret);
+		mutex_unlock(&info->mutex);
+		return;
+	}
+
+	if (int_status) {
+		unsigned int cable_attach;
+
+		cable_attach = int_status & PTN5150_REG_INT_CABLE_ATTACH_MASK;
+		if (cable_attach) {
+			unsigned int port_status;
+			unsigned int vbus;
+
+			port_status = ((reg_data &
+					PTN5150_REG_CC_PORT_ATTACHMENT_MASK) >>
+					PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT);
+
+			switch (port_status) {
+			case PTN5150_DFP_ATTACHED:
+				extcon_set_state_sync(info->edev,
+						EXTCON_USB_HOST, false);
+				gpiod_set_value(info->vbus_gpiod, 0);
+				extcon_set_state_sync(info->edev, EXTCON_USB,
+						true);
+				break;
+			case PTN5150_UFP_ATTACHED:
+				extcon_set_state_sync(info->edev, EXTCON_USB,
+						false);
+				vbus = ((reg_data &
+					PTN5150_REG_CC_VBUS_DETECTION_MASK) >>
+					PTN5150_REG_CC_VBUS_DETECTION_SHIFT);
+				if (vbus)
+					gpiod_set_value(info->vbus_gpiod, 0);
+				else
+					gpiod_set_value(info->vbus_gpiod, 1);
+
+				extcon_set_state_sync(info->edev,
+						EXTCON_USB_HOST, true);
+				break;
+			default:
+				dev_err(info->dev,
+					"Unknown Port status : %x\n",
+					port_status);
+				break;
+			}
+		} else {
+			extcon_set_state_sync(info->edev,
+					EXTCON_USB_HOST, false);
+			extcon_set_state_sync(info->edev,
+					EXTCON_USB, false);
+			gpiod_set_value(info->vbus_gpiod, 0);
+		}
+	}
+
+	/* Clear interrupt. Read would clear the register */
+	ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS,
+			&int_status);
+	if (ret) {
+		dev_err(info->dev,
+			"failed to read INT REG STATUS %d\n", ret);
+		mutex_unlock(&info->mutex);
+		return;
+	}
+
+	mutex_unlock(&info->mutex);
+}
+
+
+static irqreturn_t ptn5150_irq_handler(int irq, void *data)
+{
+	struct ptn5150_info *info = data;
+
+	schedule_work(&info->irq_work);
+
+	return IRQ_HANDLED;
+}
+
+static int ptn5150_init_dev_type(struct ptn5150_info *info)
+{
+	unsigned int reg_data, vendor_id, version_id;
+	int ret;
+
+	ret = regmap_read(info->regmap, PTN5150_REG_DEVICE_ID, &reg_data);
+	if (ret) {
+		dev_err(info->dev, "failed to read DEVICE_ID %d\n", ret);
+		return -EINVAL;
+	}
+
+	vendor_id = ((reg_data & PTN5150_REG_DEVICE_ID_VENDOR_MASK) >>
+				PTN5150_REG_DEVICE_ID_VENDOR_SHIFT);
+	version_id = ((reg_data & PTN5150_REG_DEVICE_ID_VERSION_MASK) >>
+				PTN5150_REG_DEVICE_ID_VERSION_SHIFT);
+
+	dev_info(info->dev, "Device type: version: 0x%x, vendor: 0x%x\n",
+			    version_id, vendor_id);
+
+	/* Clear any existing interrupts */
+	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &reg_data);
+	if (ret) {
+		dev_err(info->dev,
+			"failed to read PTN5150_REG_INT_STATUS %d\n",
+			ret);
+		return -EINVAL;
+	}
+
+	ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS, &reg_data);
+	if (ret) {
+		dev_err(info->dev,
+			"failed to read PTN5150_REG_INT_REG_STATUS %d\n", ret);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ptn5150_i2c_probe(struct i2c_client *i2c,
+				 const struct i2c_device_id *id)
+{
+	struct device *dev = &i2c->dev;
+	struct device_node *np = i2c->dev.of_node;
+	struct ptn5150_info *info;
+	int ret;
+
+	if (!np)
+		return -EINVAL;
+
+	info = devm_kzalloc(&i2c->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	i2c_set_clientdata(i2c, info);
+
+	info->dev = &i2c->dev;
+	info->i2c = i2c;
+	info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
+	if (!info->int_gpiod) {
+		dev_err(dev, "failed to get INT GPIO\n");
+		return -EINVAL;
+	}
+	info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_IN);
+	if (!info->vbus_gpiod) {
+		dev_err(dev, "failed to get VBUS GPIO\n");
+		return -EINVAL;
+	}
+	ret = gpiod_direction_output(info->vbus_gpiod, 0);
+	if (ret) {
+		dev_err(dev, "failed to set VBUS GPIO direction\n");
+		return -EINVAL;
+	}
+
+	mutex_init(&info->mutex);
+
+	INIT_WORK(&info->irq_work, ptn5150_irq_work);
+
+	info->regmap = devm_regmap_init_i2c(i2c, &ptn5150_regmap_config);
+	if (IS_ERR(info->regmap)) {
+		ret = PTR_ERR(info->regmap);
+		dev_err(info->dev, "failed to allocate register map: %d\n",
+				   ret);
+		return ret;
+	}
+
+	if (info->int_gpiod) {
+		info->irq = gpiod_to_irq(info->int_gpiod);
+		if (info->irq < 0) {
+			dev_err(dev, "failed to get INTB IRQ\n");
+			return info->irq;
+		}
+
+		ret = devm_request_threaded_irq(dev, info->irq, NULL,
+						ptn5150_irq_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						i2c->name, info);
+		if (ret < 0) {
+			dev_err(dev, "failed to request handler for INTB IRQ\n");
+			return ret;
+		}
+	}
+
+	/* Allocate extcon device */
+	info->edev = devm_extcon_dev_allocate(info->dev, ptn5150_extcon_cable);
+	if (IS_ERR(info->edev)) {
+		dev_err(info->dev, "failed to allocate memory for extcon\n");
+		return -ENOMEM;
+	}
+
+	/* Register extcon device */
+	ret = devm_extcon_dev_register(info->dev, info->edev);
+	if (ret) {
+		dev_err(info->dev, "failed to register extcon device\n");
+		return ret;
+	}
+
+	/* Initialize PTN5150 device and print vendor id and version id */
+	ret = ptn5150_init_dev_type(info);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct of_device_id ptn5150_dt_match[] = {
+	{ .compatible = "nxp,ptn5150" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ptn5150_dt_match);
+
+static const struct i2c_device_id ptn5150_i2c_id[] = {
+	{ "ptn5150", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ptn5150_i2c_id);
+
+static struct i2c_driver ptn5150_i2c_driver = {
+	.driver		= {
+		.name	= "ptn5150",
+		.of_match_table = ptn5150_dt_match,
+	},
+	.probe	= ptn5150_i2c_probe,
+	.id_table = ptn5150_i2c_id,
+};
+
+static int __init ptn5150_i2c_init(void)
+{
+	return i2c_add_driver(&ptn5150_i2c_driver);
+}
+subsys_initcall(ptn5150_i2c_init);
+
+MODULE_DESCRIPTION("NXP PTN5150 CC logic Extcon driver");
+MODULE_AUTHOR("Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>");
+MODULE_LICENSE("GPL v2");
--
2.7.4

