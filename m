Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03456ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CBD20C0B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiqYlL5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CBD20C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbeGQJ4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:56:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42722 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeGQJ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:56:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id x12-v6so377010ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gs6FTk9ruGFJRtRNX4xwCyJxBlscdHE1dLEpymbJd4w=;
        b=OiqYlL5kkk2oODERHs34+Mqaz7i8CzVNVfzJz4dFwnOKhwOLhnz2KeKTbHZ6gJ0YkL
         E1u+L7RVsFHpsD92I7XEbtmSi/WP1Wnm4pSUET74gOT8RFleHICi/3gsXipYxLm17vy0
         ydGQFU0NDCg4nAeeuIVSdQdh+fcHrlXxMqYc5IsDfHdr6n1Z2mLRTX6tNh6LC11x4l4G
         AgU2gmgJmLP4k5LO5UQkRhrYolq1eH2LlX7OmE9+khU1EQ5+/+b6DcMMWKkLCM2G9jrZ
         9dDRgHxReThquouX4X11/EPf+0RA85j5zgxzsNVMfMOJPGuTg7gk2KRd0WliSoL5IIu/
         us6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gs6FTk9ruGFJRtRNX4xwCyJxBlscdHE1dLEpymbJd4w=;
        b=abIP4wComSVjlfBt7PvAwLiNaZbq3cL9yfZr3kI9SegpLM6npX9u3QObFEcImrKLyc
         mr52G2gtv1b9953P6kstzhV3nd5nc0YvakqOLaJlk5mT2SqsPsV6psmukYfv/vuDvSkY
         i3AcPBV47WNpEFA9adGlf+bZ4IDBVQTm9nRh1TZPQj0/3enF0uPTEpLulugcPEJAhmpO
         CWoUn3Ri+dQOQO5NkAcJ4FL5Q7cIEuw6H9KRcdVyIm0IkYAuWfouGd9Q8FAenskscM1t
         SjYml44LWWrmSx+4hpmRXoyX9Wv/3GAn8Kx/GInYr+/sFPakSpywyhtbSqc0/I0w9RF+
         uwcA==
X-Gm-Message-State: AOUpUlHQgnADOjO0LI5eaKvsecOroJa0XIbNNYGzx6RC5cvkeQGsP+tu
        Koy0m9mEqVKLlTbMPhgvBvM=
X-Google-Smtp-Source: AAOMgpchUmI3IanbFGClq68XS8vL45pS4TJp/4oO+O9ETl9uTA6bYOMgrbYnmT0vRYEgzOYBko8GCg==
X-Received: by 2002:a2e:1101:: with SMTP id f1-v6mr803620lje.75.1531819497932;
        Tue, 17 Jul 2018 02:24:57 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id l1-v6sm94224lji.41.2018.07.17.02.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 02:24:57 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 2/4] ntb: idt: Add basic hwmon sysfs interface
Date:   Tue, 17 Jul 2018 12:24:35 +0300
Message-Id: <20180717092437.18918-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180717092437.18918-1-fancer.lancer@gmail.com>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
 <20180717092437.18918-1-fancer.lancer@gmail.com>
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

Changelog v2:
- Add "select HWMON" to the NTB_IDT kconfig

 drivers/ntb/hw/idt/Kconfig      |   1 +
 drivers/ntb/hw/idt/ntb_hw_idt.c | 182 ++++++++++++++++++++++++++++++++++++++++
 drivers/ntb/hw/idt/ntb_hw_idt.h |  24 +++++-
 3 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/idt/Kconfig b/drivers/ntb/hw/idt/Kconfig
index b360e5613b9f..2ed147368fa8 100644
--- a/drivers/ntb/hw/idt/Kconfig
+++ b/drivers/ntb/hw/idt/Kconfig
@@ -1,6 +1,7 @@
 config NTB_IDT
 	tristate "IDT PCIe-switch Non-Transparent Bridge support"
 	depends on PCI
+	select HWMON
 	help
 	 This driver supports NTB of cappable IDT PCIe-switches.
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index c086ae5c601c..f12088c6a92d 100644
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
@@ -1925,6 +1928,153 @@ static void idt_read_temp(struct idt_ntb_dev *ndev,
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
@@ -1956,6 +2106,35 @@ static void idt_temp_isr(struct idt_ntb_dev *ndev, u32 ntint_sts)
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
@@ -2650,6 +2829,9 @@ static int idt_pci_probe(struct pci_dev *pdev,
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

