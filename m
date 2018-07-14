Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0CEECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4152B2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNnAb9LT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4152B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeGNMR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 08:17:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42490 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbeGNMR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 08:17:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id x12-v6so676894ljj.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 04:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wTU5SksXyx6JGEJbN/ZmXVZtQx5uHlRmmoHhLRvBM7c=;
        b=vNnAb9LTv1WZ1uu2cUwyGfvTeso6mNIoI275JbPPq66uIW9TerEnIipJGUrAAcQJvZ
         cUhdic+gDXWkpRYNgD0dFvgjhSRJFhJcOy4Sqg0XBw+UngeYOx8iau99+NCzq9EL+RiG
         z+UfONKotiXNiF1jFdXgcC6FvmQG8XNpX6Z/DUUMOEIn+8XKLu42FWKNCE899X1Fix7Z
         aSEyeRN+/KtVsHqWzPANZaXBKB4ymqynUeP7E6ZDP/xw0jkvhQqo6enoErucBrt3PFh5
         fjhnr1JyfY2bYxvnf37PPNRHAjxY+X06AIN2XbxAaxDWQKu3j82RD+9a9N3ZTrCM2sgP
         jpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wTU5SksXyx6JGEJbN/ZmXVZtQx5uHlRmmoHhLRvBM7c=;
        b=g38pFzxoa72q0Ru+Ru3ubk9J/W5y8+7ygcTTRxGkIwKydiy9uUE2VE3dZs1M2UjCoz
         JKeJckjNRDpAmPkFxBperEyg7HoJrAaPnJieLMvz1gf97cLolZIig7pneEJb8NwpPe38
         ToFn25VoDnO9RiX1mE69ARI+xdQ4IU0anFazL5hMLlD2wAdofL2Gp28q7b58X7I5kjlX
         CJlFLCZt/MJj0nvV1RHqvaoLl8kdWgt/V25y9HV67h16ns0mwYyNg/3GcBI/xm8/eP0b
         e8IEW22S5z2WAtNmWKg9MUNcoXH/S/0JcIm6hca3sMbrHrGTUJC/fXzz6wDG4CR4+PL1
         /WqA==
X-Gm-Message-State: AOUpUlHYiobJlugugvUDtAKWPc0MO91wXaT5dEpU59nGsGVTQyfXZlWX
        ywARoDcZZHIPcdONvHuAZ+0=
X-Google-Smtp-Source: AAOMgpf/0Dw918ekD67J2zP+HVjrwxQF2Mhyr4JNRO0Etf1mhQIF1oDw2mCn2dSrcxHIszqys1PBNw==
X-Received: by 2002:a2e:458b:: with SMTP id s133-v6mr5343946lja.151.1531569542897;
        Sat, 14 Jul 2018 04:59:02 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id r64-v6sm7284222lff.90.2018.07.14.04.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Jul 2018 04:59:02 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 2/4] ntb: idt: Add basic hwmon sysfs interface
Date:   Sat, 14 Jul 2018 14:58:32 +0300
Message-Id: <20180714115834.3350-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180714115834.3350-1-fancer.lancer@gmail.com>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDT PCIe switches provide an embedded temperature sensor working
within [0; 127.5]C with resolution of 0.5C. They also can generate
a PCIe upstream interrupt in case if the temperature passes through
specified thresholds. Since this thresholds interface is very broken
the created hwmon-sysfs interface exposes only the next set of hwmon
nodes: current input temperature, lowest and highest values measured,
history resetting, value offset. HWmon alarm interface isn't provided.

IDT PCIe switch also've got an ADC/filter settings of the sensor.
This driver doesn't expose them to the hwmon-sysfs interface at the
moment, except the offset node.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 182 ++++++++++++++++++++++++++++++++++++++++
 drivers/ntb/hw/idt/ntb_hw_idt.h |  24 +++++-
 2 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 928f37877790..af767a13556a 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -49,11 +49,14 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/debugfs.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/ntb.h>
 
 #include "ntb_hw_idt.h"
@@ -1926,6 +1929,153 @@ static void idt_read_temp(struct idt_ntb_dev *ndev,
 }
 
 /*
+ * idt_write_temp() - write temperature to the chip sensor register
+ * @ntb:	NTB device context.
+ * @type:	IN - type of the temperature value to change
+ * @val:	IN - integer value of temperature in millidegree Celsius
+ */
+static void idt_write_temp(struct idt_ntb_dev *ndev,
+			   const enum idt_temp_val type, const long val)
+{
+	unsigned int reg;
+	u32 data;
+	u8 fmt;
+
+	/* Retrieve the properly formatted temperature value */
+	fmt = idt_temp_get_fmt(val);
+
+	mutex_lock(&ndev->hwmon_mtx);
+	switch (type) {
+	case IDT_TEMP_LOW:
+		reg = IDT_SW_TMPALARM;
+		data = SET_FIELD(TMPALARM_LTEMP, idt_sw_read(ndev, reg), fmt) &
+			~IDT_TMPALARM_IRQ_MASK;
+		break;
+	case IDT_TEMP_HIGH:
+		reg = IDT_SW_TMPALARM;
+		data = SET_FIELD(TMPALARM_HTEMP, idt_sw_read(ndev, reg), fmt) &
+			~IDT_TMPALARM_IRQ_MASK;
+		break;
+	case IDT_TEMP_OFFSET:
+		reg = IDT_SW_TMPADJ;
+		data = SET_FIELD(TMPADJ_OFFSET, idt_sw_read(ndev, reg), fmt);
+		break;
+	default:
+		goto inval_spin_unlock;
+	}
+
+	idt_sw_write(ndev, reg, data);
+
+inval_spin_unlock:
+	mutex_unlock(&ndev->hwmon_mtx);
+}
+
+/*
+ * idt_sysfs_show_temp() - printout corresponding temperature value
+ * @dev:	Pointer to the NTB device structure
+ * @da:		Sensor device attribute structure
+ * @buf:	Buffer to print temperature out
+ *
+ * Return: Number of written symbols or negative error
+ */
+static ssize_t idt_sysfs_show_temp(struct device *dev,
+				   struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct idt_ntb_dev *ndev = dev_get_drvdata(dev);
+	enum idt_temp_val type = attr->index;
+	long mdeg;
+
+	idt_read_temp(ndev, type, &mdeg);
+	return sprintf(buf, "%ld\n", mdeg);
+}
+
+/*
+ * idt_sysfs_set_temp() - set corresponding temperature value
+ * @dev:	Pointer to the NTB device structure
+ * @da:		Sensor device attribute structure
+ * @buf:	Buffer to print temperature out
+ * @count:	Size of the passed buffer
+ *
+ * Return: Number of written symbols or negative error
+ */
+static ssize_t idt_sysfs_set_temp(struct device *dev,
+				  struct device_attribute *da, const char *buf,
+				  size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct idt_ntb_dev *ndev = dev_get_drvdata(dev);
+	enum idt_temp_val type = attr->index;
+	long mdeg;
+	int ret;
+
+	ret = kstrtol(buf, 10, &mdeg);
+	if (ret)
+		return ret;
+
+	/* Clamp the passed value in accordance with the type */
+	if (type == IDT_TEMP_OFFSET)
+		mdeg = clamp_val(mdeg, IDT_TEMP_MIN_OFFSET,
+				 IDT_TEMP_MAX_OFFSET);
+	else
+		mdeg = clamp_val(mdeg, IDT_TEMP_MIN_MDEG, IDT_TEMP_MAX_MDEG);
+
+	idt_write_temp(ndev, type, mdeg);
+
+	return count;
+}
+
+/*
+ * idt_sysfs_reset_hist() - reset temperature history
+ * @dev:	Pointer to the NTB device structure
+ * @da:		Sensor device attribute structure
+ * @buf:	Buffer to print temperature out
+ * @count:	Size of the passed buffer
+ *
+ * Return: Number of written symbols or negative error
+ */
+static ssize_t idt_sysfs_reset_hist(struct device *dev,
+				    struct device_attribute *da,
+				    const char *buf, size_t count)
+{
+	struct idt_ntb_dev *ndev = dev_get_drvdata(dev);
+
+	/* Just set the maximal value to the lowest temperature field and
+	 * minimal value to the highest temperature field
+	 */
+	idt_write_temp(ndev, IDT_TEMP_LOW, IDT_TEMP_MAX_MDEG);
+	idt_write_temp(ndev, IDT_TEMP_HIGH, IDT_TEMP_MIN_MDEG);
+
+	return count;
+}
+
+/*
+ * Hwmon IDT sysfs attributes
+ */
+static SENSOR_DEVICE_ATTR(temp1_input, 0444, idt_sysfs_show_temp, NULL,
+			  IDT_TEMP_CUR);
+static SENSOR_DEVICE_ATTR(temp1_lowest, 0444, idt_sysfs_show_temp, NULL,
+			  IDT_TEMP_LOW);
+static SENSOR_DEVICE_ATTR(temp1_highest, 0444, idt_sysfs_show_temp, NULL,
+			  IDT_TEMP_HIGH);
+static SENSOR_DEVICE_ATTR(temp1_offset, 0644, idt_sysfs_show_temp,
+			  idt_sysfs_set_temp, IDT_TEMP_OFFSET);
+static DEVICE_ATTR(temp1_reset_history, 0200, NULL, idt_sysfs_reset_hist);
+
+/*
+ * Hwmon IDT sysfs attributes group
+ */
+static struct attribute *idt_temp_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_lowest.dev_attr.attr,
+	&sensor_dev_attr_temp1_highest.dev_attr.attr,
+	&sensor_dev_attr_temp1_offset.dev_attr.attr,
+	&dev_attr_temp1_reset_history.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(idt_temp);
+
+/*
  * idt_temp_isr() - temperature sensor alarm events ISR
  * @ndev:	IDT NTB hardware driver descriptor
  * @ntint_sts:	NT-function interrupt status
@@ -1957,6 +2107,35 @@ static void idt_temp_isr(struct idt_ntb_dev *ndev, u32 ntint_sts)
 		idt_get_deg(mdeg), idt_get_deg_frac(mdeg));
 }
 
+/*
+ * idt_init_temp() - initialize temperature sensor interface
+ * @ndev:	IDT NTB hardware driver descriptor
+ *
+ * Simple sensor initializarion method is responsible for device switching
+ * on and resource management based hwmon interface registration. Note, that
+ * since the device is shared we won't disable it on remove, but leave it
+ * working until the system is powered off.
+ */
+static void idt_init_temp(struct idt_ntb_dev *ndev)
+{
+	struct device *hwmon;
+
+	/* Enable sensor if it hasn't been already */
+	idt_sw_write(ndev, IDT_SW_TMPCTL, 0x0);
+
+	/* Initialize hwmon interface fields */
+	mutex_init(&ndev->hwmon_mtx);
+
+	hwmon = devm_hwmon_device_register_with_groups(&ndev->ntb.pdev->dev,
+		ndev->swcfg->name, ndev, idt_temp_groups);
+	if (IS_ERR(hwmon)) {
+		dev_err(&ndev->ntb.pdev->dev, "Couldn't create hwmon device");
+		return;
+	}
+
+	dev_dbg(&ndev->ntb.pdev->dev, "Temperature HWmon interface registered");
+}
+
 /*=============================================================================
  *                           8. ISRs related operations
  *
@@ -2651,6 +2830,9 @@ static int idt_pci_probe(struct pci_dev *pdev,
 	/* Initialize Messaging subsystem */
 	idt_init_msg(ndev);
 
+	/* Initialize hwmon interface */
+	idt_init_temp(ndev);
+
 	/* Initialize IDT interrupts handler */
 	ret = idt_init_isr(ndev);
 	if (ret != 0)
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.h b/drivers/ntb/hw/idt/ntb_hw_idt.h
index 9dfd6b11a621..032f81cb4d44 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.h
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.h
@@ -47,9 +47,9 @@
 #include <linux/pci_ids.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/ntb.h>
 
-
 /*
  * Macro is used to create the struct pci_device_id that matches
  * the supported IDT PCIe-switches
@@ -907,6 +907,10 @@
  * TMPSTS register fields related constants
  * @IDT_TMPSTS_TEMP_MASK:	Current temperature field mask
  * @IDT_TMPSTS_TEMP_FLD:	Current temperature field offset
+ * @IDT_TMPSTS_LTEMP_MASK:	Lowest temperature field mask
+ * @IDT_TMPSTS_LTEMP_FLD:	Lowest temperature field offset
+ * @IDT_TMPSTS_HTEMP_MASK:	Highest temperature field mask
+ * @IDT_TMPSTS_HTEMP_FLD:	Highest temperature field offset
  */
 #define IDT_TMPSTS_TEMP_MASK		0x000000FFU
 #define IDT_TMPSTS_TEMP_FLD		0
@@ -916,6 +920,20 @@
 #define IDT_TMPSTS_HTEMP_FLD		16
 
 /*
+ * TMPALARM register fields related constants
+ * @IDT_TMPALARM_LTEMP_MASK:	Lowest temperature field mask
+ * @IDT_TMPALARM_LTEMP_FLD:	Lowest temperature field offset
+ * @IDT_TMPALARM_HTEMP_MASK:	Highest temperature field mask
+ * @IDT_TMPALARM_HTEMP_FLD:	Highest temperature field offset
+ * @IDT_TMPALARM_IRQ_MASK:	Alarm IRQ status mask
+ */
+#define IDT_TMPALARM_LTEMP_MASK		0x0000FF00U
+#define IDT_TMPALARM_LTEMP_FLD		8
+#define IDT_TMPALARM_HTEMP_MASK		0x00FF0000U
+#define IDT_TMPALARM_HTEMP_FLD		16
+#define IDT_TMPALARM_IRQ_MASK		0x3F000000U
+
+/*
  * TMPADJ register fields related constants
  * @IDT_TMPADJ_OFFSET_MASK:	Temperature value offset field mask
  * @IDT_TMPADJ_OFFSET_FLD:	Temperature value offset field offset
@@ -1100,6 +1118,8 @@ struct idt_ntb_peer {
  * @msg_mask_lock:	Message mask register lock
  * @gasa_lock:		GASA registers access lock
  *
+ * @hwmon_mtx:		Temperature sensor interface update mutex
+ *
  * @dbgfs_info:		DebugFS info node
  */
 struct idt_ntb_dev {
@@ -1127,6 +1147,8 @@ struct idt_ntb_dev {
 	spinlock_t msg_mask_lock;
 	spinlock_t gasa_lock;
 
+	struct mutex hwmon_mtx;
+
 	struct dentry *dbgfs_info;
 };
 #define to_ndev_ntb(__ntb) container_of(__ntb, struct idt_ntb_dev, ntb)
-- 
2.12.0

