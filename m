Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125BBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A6B20666
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A6B20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeH3FLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:11:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725758AbeH3FLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:11:33 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AC73D2865727F;
        Thu, 30 Aug 2018 09:11:34 +0800 (CST)
Received: from SZX1000462871.huawei.com (10.93.195.50) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Thu, 30 Aug 2018 09:11:25 +0800
From:   xiongsujuan <xiongsujuan.xiongsujuan@huawei.com>
To:     <davem@davemloft.net>, <zhaochen6@huawei.com>,
        <aviad.krawczyk@huawei.com>, <romain.perier@collabora.com>,
        <bhelgaas@google.com>, <keescook@chromium.org>,
        <colin.king@canonical.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V1] add huawei ibma driver modules The driver is used for communication between in-band management agent(iBMA) and out-of-band management controller(iBMC) via pcie bus in Huawei V3 server. The driver provides character device,VNIC and black box interface for application layer.
Date:   Thu, 30 Aug 2018 09:11:12 +0800
Message-ID: <1535591472-44997-1-git-send-email-xiongsujuan.xiongsujuan@huawei.com>
X-Mailer: git-send-email 2.1.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.93.195.50]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/net/ethernet/huawei/Kconfig               |    5 +-
 drivers/net/ethernet/huawei/Makefile              |    1 +
 drivers/net/ethernet/huawei/ibma/Kconfig          |   17 +
 drivers/net/ethernet/huawei/ibma/Makefile         |   12 +
 drivers/net/ethernet/huawei/ibma/bma_cdev.c       |  374 ++++
 drivers/net/ethernet/huawei/ibma/bma_devintf.c    |  619 ++++++
 drivers/net/ethernet/huawei/ibma/bma_devintf.h    |   39 +
 drivers/net/ethernet/huawei/ibma/bma_include.h    |  119 +
 drivers/net/ethernet/huawei/ibma/bma_ker_intf.h   |   89 +
 drivers/net/ethernet/huawei/ibma/bma_pci.c        |  515 +++++
 drivers/net/ethernet/huawei/ibma/bma_pci.h        |   87 +
 drivers/net/ethernet/huawei/ibma/edma_cmd.h       |   81 +
 drivers/net/ethernet/huawei/ibma/edma_host.c      | 1547 +++++++++++++
 drivers/net/ethernet/huawei/ibma/edma_host.h      |  357 +++
 drivers/net/ethernet/huawei/ibma/kbox_dump.c      |  141 ++
 drivers/net/ethernet/huawei/ibma/kbox_dump.h      |   35 +
 drivers/net/ethernet/huawei/ibma/kbox_hook.c      |  105 +
 drivers/net/ethernet/huawei/ibma/kbox_hook.h      |   34 +
 drivers/net/ethernet/huawei/ibma/kbox_include.h   |   44 +
 drivers/net/ethernet/huawei/ibma/kbox_main.c      |  207 ++
 drivers/net/ethernet/huawei/ibma/kbox_main.h      |   25 +
 drivers/net/ethernet/huawei/ibma/kbox_mce.c       |  293 +++
 drivers/net/ethernet/huawei/ibma/kbox_mce.h       |   25 +
 drivers/net/ethernet/huawei/ibma/kbox_panic.c     |  195 ++
 drivers/net/ethernet/huawei/ibma/kbox_panic.h     |   27 +
 drivers/net/ethernet/huawei/ibma/kbox_printk.c    |  377 ++++
 drivers/net/ethernet/huawei/ibma/kbox_printk.h    |   35 +
 drivers/net/ethernet/huawei/ibma/kbox_ram_drive.c |  212 ++
 drivers/net/ethernet/huawei/ibma/kbox_ram_drive.h |   33 +
 drivers/net/ethernet/huawei/ibma/kbox_ram_image.c |  138 ++
 drivers/net/ethernet/huawei/ibma/kbox_ram_image.h |   91 +
 drivers/net/ethernet/huawei/ibma/kbox_ram_op.c    | 1003 +++++++++
 drivers/net/ethernet/huawei/ibma/kbox_ram_op.h    |   77 +
 drivers/net/ethernet/huawei/ibma/memcpy_s.c       |   90 +
 drivers/net/ethernet/huawei/ibma/memset_s.c       |   71 +
 drivers/net/ethernet/huawei/ibma/securec.h        |   87 +
 drivers/net/ethernet/huawei/ibma/veth_hb.c        | 2467 +++++++++++++++++++++
 drivers/net/ethernet/huawei/ibma/veth_hb.h        |  578 +++++
 38 files changed, 10251 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/huawei/ibma/Kconfig
 create mode 100644 drivers/net/ethernet/huawei/ibma/Makefile
 create mode 100644 drivers/net/ethernet/huawei/ibma/bma_cdev.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/bma_devintf.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/bma_devintf.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/bma_include.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/bma_ker_intf.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/bma_pci.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/bma_pci.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/edma_cmd.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/edma_host.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/edma_host.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_dump.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_dump.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_hook.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_hook.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_include.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_main.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_main.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_mce.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_mce.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_panic.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_panic.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_printk.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_printk.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_ram_drive.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_ram_drive.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_ram_image.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_ram_image.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_ram_op.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/kbox_ram_op.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/memcpy_s.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/memset_s.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/securec.h
 create mode 100644 drivers/net/ethernet/huawei/ibma/veth_hb.c
 create mode 100644 drivers/net/ethernet/huawei/ibma/veth_hb.h

diff --git a/drivers/net/ethernet/huawei/Kconfig b/drivers/net/ethernet/huawei/Kconfig
index c1a95ae..68748e9 100644
--- a/drivers/net/ethernet/huawei/Kconfig
+++ b/drivers/net/ethernet/huawei/Kconfig
@@ -4,7 +4,7 @@
 
 config NET_VENDOR_HUAWEI
 	bool "Huawei devices"
-	default y
+	default y 
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 	  Note that the answer to this question doesn't directly affect the
@@ -16,4 +16,7 @@ if NET_VENDOR_HUAWEI
 
 source "drivers/net/ethernet/huawei/hinic/Kconfig"
 
+source "drivers/net/ethernet/huawei/ibma/Kconfig"
+
+
 endif # NET_VENDOR_HUAWEI
diff --git a/drivers/net/ethernet/huawei/Makefile b/drivers/net/ethernet/huawei/Makefile
index 5c37cc8..2221f48 100644
--- a/drivers/net/ethernet/huawei/Makefile
+++ b/drivers/net/ethernet/huawei/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-$(CONFIG_HINIC) += hinic/
+obj-$(CONFIG_IBMANIC) += ibma/
diff --git a/drivers/net/ethernet/huawei/ibma/Kconfig b/drivers/net/ethernet/huawei/ibma/Kconfig
new file mode 100644
index 0000000..810cc60
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/Kconfig
@@ -0,0 +1,17 @@
+#
+# Huawei driver configuration
+#
+
+config IBMANIC
+	tristate "Huawei IBMA PCIE Network Interface Card"
+	depends on (PCI_MSI && X86)
+	---help---
+	  This driver supports IBMANIC PCIE Ethernet cards.
+	  To compile this driver as part of the kernel, choose Y here.
+	  If unsure, choose N.
+	  The default is compiled as module.
+
+
+
+
+
diff --git a/drivers/net/ethernet/huawei/ibma/Makefile b/drivers/net/ethernet/huawei/ibma/Makefile
new file mode 100644
index 0000000..b37fb48
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/Makefile
@@ -0,0 +1,12 @@
+
+
+
+obj-$(CONFIG_IBMANIC) += host_edma_drv.o host_cdev_drv.o host_veth_drv.o host_kbox_drv.o
+host_edma_drv-y := bma_pci.o bma_devintf.o edma_host.o memcpy_s.o memset_s.o
+
+host_cdev_drv-y := bma_cdev.o
+
+host_veth_drv-y := veth_hb.o
+
+host_kbox_drv-y := kbox_main.o kbox_ram_drive.o kbox_ram_image.o kbox_ram_op.o kbox_printk.o kbox_dump.o kbox_hook.o kbox_mce.o kbox_panic.o
+
diff --git a/drivers/net/ethernet/huawei/ibma/bma_cdev.c b/drivers/net/ethernet/huawei/ibma/bma_cdev.c
new file mode 100644
index 0000000..95eb606
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/bma_cdev.c
@@ -0,0 +1,374 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include <linux/miscdevice.h>
+#include "bma_include.h"
+#include "bma_ker_intf.h"
+
+#define CDEV_NAME_PREFIX	"hwibmc"
+
+#ifdef DRV_VERSION
+#define CDEV_VERSION		MICRO_TO_STR(DRV_VERSION)
+#else
+#define CDEV_VERSION		"0.2.9"
+#endif
+
+#define CDEV_DEFAULT_NUM	4
+#define CDEV_MAX_NUM		8
+
+#define CDEV_NAME_MAX_LEN	32
+#define CDEV_INVALID_ID		(0xffffffff)
+
+struct cdev_statistics_s {
+	unsigned int recv_bytes;
+	unsigned int send_bytes;
+	unsigned int send_pkgs;
+	unsigned int recv_pkgs;
+	unsigned int send_failed_count;
+	unsigned int recv_failed_count;
+	unsigned int open_status;
+};
+
+struct cdev_dev {
+	struct miscdevice dev_struct;
+	struct cdev_statistics_s s;
+	char dev_name[CDEV_NAME_MAX_LEN];
+	dev_t dev_id;
+	void *dev_data;
+	atomic_t open;
+	int type;
+};
+
+struct cdev_dev_set {
+	struct cdev_dev dev_list[CDEV_MAX_NUM];
+	int dev_num;
+	unsigned int init_time;
+};
+
+int dev_num = CDEV_DEFAULT_NUM;	/* the dev num want to create */
+int debug = DLOG_ERROR;                  /* debug switch */
+module_param(dev_num, int, 0640);
+MODULE_PARM_DESC(dev_num, "cdev num you want");
+MODULE_PARM_DESC(debug, "Debug switch (0=close debug, 1=open debug)");
+
+#define CDEV_LOG(level, fmt, args...) do {\
+	if (debug >= level) {\
+		printk(KERN_NOTICE "edma_cdev: %s, %d, " fmt"\n", \
+		__func__, __LINE__, ## args);\
+		} \
+	} while (0)
+
+static int cdev_open(struct inode *inode, struct file *filp);
+static int cdev_release(struct inode *inode, struct file *filp);
+static unsigned int cdev_poll(struct file *file, poll_table *wait);
+static ssize_t cdev_read(struct file *filp, char __user  *data, size_t count,
+			 loff_t *ppos);
+static ssize_t cdev_write(struct file *filp, const char __user *data,
+			  size_t count, loff_t *ppos);
+
+struct cdev_dev_set g_cdev_set;
+
+#define INC_CDEV_STATS(pdev, name, count) \
+	(((struct cdev_dev *)pdev)->s.name += (count))
+#define GET_PRIVATE_DATA(f) (((struct cdev_dev *)((f)->private_data))->dev_data)
+
+module_param_call(debug, &edma_param_set_debug, &param_get_int, &debug, 0644);
+
+static int cdev_param_get_statics(char *buf, struct kernel_param *kp)
+{
+	int len = 0;
+	int i = 0;
+	__kernel_time_t running_time = 0;
+
+	if (!buf)
+		return 0;
+
+	GET_SYS_SECONDS(running_time);
+	running_time -= g_cdev_set.init_time;
+	len += sprintf(buf + len,
+		       "============================CDEV_DRIVER_INFO=======================\n");
+	len += sprintf(buf + len, "version      :%s\n", CDEV_VERSION);
+
+	len += sprintf(buf + len, "running_time :%luD %02lu:%02lu:%02lu\n",
+		       running_time / (SECONDS_PER_DAY),
+		       running_time % (SECONDS_PER_DAY) / SECONDS_PER_HOUR,
+		       running_time % SECONDS_PER_HOUR / SECONDS_PER_MINUTE,
+		       running_time % SECONDS_PER_MINUTE);
+
+	for (i = 0; i < g_cdev_set.dev_num; i++) {
+		len += sprintf(buf + len,
+			       "===================================================\n");
+		len += sprintf(buf + len, "name      :%s\n",
+			       g_cdev_set.dev_list[i].dev_name);
+		len +=
+		    sprintf(buf + len, "dev_id    :%08x\n",
+			    g_cdev_set.dev_list[i].dev_id);
+		len += sprintf(buf + len, "type      :%u\n",
+			       g_cdev_set.dev_list[i].type);
+		len += sprintf(buf + len, "status    :%s\n",
+			       g_cdev_set.dev_list[i].s.open_status ==
+			       1 ? "open" : "close");
+		len += sprintf(buf + len, "send_pkgs :%u\n",
+			       g_cdev_set.dev_list[i].s.send_pkgs);
+		len +=
+		    sprintf(buf + len, "send_bytes:%u\n",
+			    g_cdev_set.dev_list[i].s.send_bytes);
+		len += sprintf(buf + len, "send_failed_count:%u\n",
+			       g_cdev_set.dev_list[i].s.send_failed_count);
+		len += sprintf(buf + len, "recv_pkgs :%u\n",
+			       g_cdev_set.dev_list[i].s.recv_pkgs);
+		len += sprintf(buf + len, "recv_bytes:%u\n",
+			       g_cdev_set.dev_list[i].s.recv_bytes);
+		len += sprintf(buf + len, "recv_failed_count:%u\n",
+			       g_cdev_set.dev_list[i].s.recv_failed_count);
+	}
+
+	return len;
+}
+module_param_call(statistics, NULL, cdev_param_get_statics, &debug, 0444);
+MODULE_PARM_DESC(statistics, "Statistics info of cdev driver,readonly");
+
+const struct file_operations g_bma_cdev_fops = {
+	.owner = THIS_MODULE,
+	.open = cdev_open,
+	.release = cdev_release,
+	.poll = cdev_poll,
+	.read = cdev_read,
+	.write = cdev_write,
+};
+
+static int __init bma_cdev_init(void)
+{
+	int i = 0;
+
+	int ret = 0;
+	int err_count = 0;
+
+	if (!bma_intf_check_edma_supported())
+		return -ENXIO;
+
+	if (dev_num <= 0 || dev_num > CDEV_MAX_NUM)
+		return -EINVAL;
+
+	memset(&g_cdev_set, 0, sizeof(struct cdev_dev_set));
+	g_cdev_set.dev_num = dev_num;
+
+	for (i = 0; i < dev_num; i++) {
+		struct cdev_dev *pDev = &g_cdev_set.dev_list[i];
+
+		sprintf(pDev->dev_name, "%s%d", CDEV_NAME_PREFIX, i);
+		pDev->dev_struct.name = pDev->dev_name;
+		pDev->dev_struct.minor = MISC_DYNAMIC_MINOR;
+		pDev->dev_struct.fops = &g_bma_cdev_fops;
+
+		pDev->dev_id = CDEV_INVALID_ID;
+
+		ret = misc_register(&pDev->dev_struct);
+
+		if (ret) {
+			CDEV_LOG(DLOG_DEBUG, "misc_register failed %d", i);
+			err_count++;
+			continue;
+		}
+
+		pDev->dev_id = MKDEV(MISC_MAJOR, pDev->dev_struct.minor);
+
+		ret = bma_intf_register_type(TYPE_CDEV + i, 0, INTR_DISABLE,
+					     &pDev->dev_data);
+
+		if (ret) {
+			CDEV_LOG(DLOG_ERROR,
+				 "cdev %d open failed ,result = %d",
+				 i, ret);
+		misc_deregister(&pDev->dev_struct);
+		pDev->dev_id = CDEV_INVALID_ID;
+		err_count++;
+		continue;
+		} else {
+			pDev->type = TYPE_CDEV + i;
+			atomic_set(&pDev->open, 1);
+		}
+
+		CDEV_LOG(DLOG_DEBUG, "%s id is %08x", pDev->dev_struct.name,
+			 pDev->dev_id);
+	}
+
+	if (err_count == dev_num) {
+		CDEV_LOG(DLOG_ERROR, "init cdev failed!");
+		return -EFAULT;
+	}
+	GET_SYS_SECONDS(g_cdev_set.init_time);
+	return 0;
+}
+
+static void __exit bma_cdev_exit(void)
+{
+	while (dev_num--) {
+		struct cdev_dev *pDev = &g_cdev_set.dev_list[dev_num];
+
+		if (pDev->dev_id != CDEV_INVALID_ID) {
+			if (pDev->dev_data != NULL && pDev->type != 0)
+				(void)bma_intf_unregister_type(&pDev->dev_data);
+
+			(void)misc_deregister(
+				&g_cdev_set.dev_list[dev_num].dev_struct);
+		}
+	}
+}
+
+int cdev_open(struct inode *inode_prt, struct file *filp)
+{
+	int i = 0;
+	struct cdev_dev *pDev = NULL;
+
+	if (!inode_prt)
+		return -EFAULT;
+	if (!filp)
+		return -EFAULT;
+
+	if (dev_num <= 0) {
+		CDEV_LOG(DLOG_ERROR, "dev_num error");
+		return -EFAULT;
+	}
+
+	for (i = 0; i < dev_num; i++) {
+		pDev = &g_cdev_set.dev_list[i];
+
+		if (pDev->dev_id == inode_prt->i_rdev)
+			break;
+	}
+
+	if (i == dev_num) {
+		CDEV_LOG(DLOG_ERROR, "can not find dev id %08x",
+			 inode_prt->i_rdev);
+		return -ENODEV;
+	}
+	/*each device can be opened only onece */
+	if (atomic_dec_and_test(&pDev->open) == 0) {
+
+		CDEV_LOG(DLOG_ERROR, "%s is already opened",
+				 pDev->dev_name);
+			atomic_inc(&pDev->open);
+			return -EBUSY;	/* already opened */
+	}
+
+	filp->private_data = &g_cdev_set.dev_list[i];
+	bma_intf_set_open_status(pDev->dev_data, DEV_OPEN);
+	INC_CDEV_STATS(filp->private_data, open_status, 1);
+
+	return 0;
+
+}
+
+int cdev_release(struct inode *inode_prt, struct file *filp)
+{
+	struct cdev_dev *pDev = NULL;
+
+	if (!filp)
+		return 0;
+
+	pDev = (struct cdev_dev *)filp->private_data;
+	if (pDev) {
+		INC_CDEV_STATS(filp->private_data, open_status, -1);
+		bma_intf_set_open_status(pDev->dev_data, DEV_CLOSE);
+		atomic_inc(&pDev->open);
+		filp->private_data = NULL;
+	}
+
+	return 0;
+}
+
+unsigned int cdev_poll(struct file *filp, poll_table *wait)
+{
+	unsigned int mask = 0;
+	wait_queue_head_t *queue_head = NULL;
+
+	if (!filp)
+		return 0;
+	queue_head = (wait_queue_head_t *)
+	    bma_cdev_get_wait_queue(GET_PRIVATE_DATA(filp));
+
+	if (!queue_head)
+		return 0;
+
+	poll_wait(filp, queue_head, wait);
+
+	if (bma_cdev_check_recv(GET_PRIVATE_DATA(filp)))
+		mask |= (POLLIN | POLLRDNORM);
+
+	CDEV_LOG(DLOG_DEBUG, "poll return %08x", mask);
+
+	return mask;
+}
+
+ssize_t cdev_read(struct file *filp, char __user *data, size_t count,
+		  loff_t *ppos)
+{
+	int ret = 0;
+
+	CDEV_LOG(DLOG_DEBUG, "data is %p,count is %u", data,
+		 (unsigned int)count);
+
+	if (!data || count <= 0)
+		return -EFAULT;
+
+	ret = bma_cdev_recv_msg(GET_PRIVATE_DATA(filp), data, count);
+
+	if (ret > 0) {
+		INC_CDEV_STATS(filp->private_data, recv_bytes, ret);
+		INC_CDEV_STATS(filp->private_data, recv_pkgs, 1);
+	} else {
+		INC_CDEV_STATS(filp->private_data, recv_failed_count, 1);
+	}
+
+	return ret;
+
+}
+
+ssize_t cdev_write(struct file *filp, const char __user *data, size_t count,
+		   loff_t *ppos)
+{
+	int ret = 0;
+
+	if (!data || count <= 0)
+		return -EFAULT;
+
+	CDEV_LOG(DLOG_DEBUG, "data is %p,count is %u", data,
+		 (unsigned int)count);
+	ret = bma_cdev_add_msg(GET_PRIVATE_DATA(filp), data, count);
+
+	if (ret > 0) {
+		INC_CDEV_STATS(filp->private_data, send_bytes, ret);
+		INC_CDEV_STATS(filp->private_data, send_pkgs, 1);
+	} else {
+		INC_CDEV_STATS(filp->private_data, send_failed_count, 1);
+	}
+
+	return ret;
+}
+
+MODULE_AUTHOR("HUAWEI TECHNOLOGIES CO., LTD.");
+MODULE_DESCRIPTION("HUAWEI CDEV DRIVER");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(CDEV_VERSION);
+
+module_init(bma_cdev_init);
+module_exit(bma_cdev_exit);
diff --git a/drivers/net/ethernet/huawei/ibma/bma_devintf.c b/drivers/net/ethernet/huawei/ibma/bma_devintf.c
new file mode 100644
index 0000000..af5efc6
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/bma_devintf.c
@@ -0,0 +1,619 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <asm/ioctls.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/proc_fs.h>
+#include <linux/notifier.h>
+#include "bma_ker_intf.h"
+#include "bma_include.h"
+#include "bma_devintf.h"
+#include "bma_pci.h"
+#include "edma_host.h"
+
+static struct bma_dev_s *g_bma_dev;
+
+static ATOMIC_NOTIFIER_HEAD(bma_int_notify_list);
+
+static int bma_priv_insert_priv_list(struct bma_priv_data_s *priv, u32 type,
+				     u32 sub_type)
+{
+	unsigned long flags = 0;
+	int ret = 0;
+	struct edma_user_inft_s *user_inft = NULL;
+
+	if (type >= TYPE_MAX || !priv)
+		return -EFAULT;
+
+	user_inft = edma_host_get_user_inft(type);
+
+	if (user_inft && user_inft->user_register) {
+		ret = user_inft->user_register(priv);
+		if (ret) {
+			BMA_LOG(DLOG_ERROR, "register failed\n");
+			return -EFAULT;
+		}
+	} else {
+		if (!g_bma_dev)
+			return -ENXIO;
+
+		if (atomic_dec_and_test(&(g_bma_dev->au_count[type])) == 0) {
+
+			BMA_LOG(DLOG_ERROR,
+				"busy, init_dev_type.type = %d, au_count = %d\n",
+				type,
+				atomic_read(&(g_bma_dev->au_count[type])));
+			atomic_inc(&g_bma_dev->au_count[type]);
+			return -EBUSY;	/* already register */
+		}
+
+		priv->user.type = type;
+		priv->user.sub_type = sub_type;
+		priv->user.user_id = 0;
+
+		spin_lock_irqsave(&g_bma_dev->priv_list_lock, flags);
+
+		list_add_rcu(&priv->user.link, &g_bma_dev->priv_list);
+
+		spin_unlock_irqrestore(&g_bma_dev->priv_list_lock, flags);
+	}
+
+	return 0;
+}
+static int bma_priv_delete_priv_list(struct bma_priv_data_s *priv)
+{
+	unsigned long flags = 0;
+	struct edma_user_inft_s *user_inft = NULL;
+
+	if (!priv || priv->user.type >= TYPE_MAX)
+		return -EFAULT;
+	user_inft = edma_host_get_user_inft(priv->user.type);
+	if (user_inft && user_inft->user_register) {
+		user_inft->user_unregister(priv);
+	} else {
+		if (!g_bma_dev)
+			return -ENXIO;
+		spin_lock_irqsave(&g_bma_dev->priv_list_lock, flags);
+		list_del_rcu(&priv->user.link);
+		spin_unlock_irqrestore(&g_bma_dev->priv_list_lock,
+								flags);
+		/* release the type */
+		atomic_inc(&g_bma_dev->au_count[priv->user.type]);
+	}
+	return 0;
+}
+
+static int bma_priv_init(struct bma_priv_data_s **bma_priv)
+{
+	struct bma_priv_data_s *priv = NULL;
+
+	if (!bma_priv)
+		return -EFAULT;
+
+	priv = kmalloc(sizeof(struct bma_priv_data_s),
+					GFP_KERNEL); /*lint !e64*/
+	if (!priv) {
+		BMA_LOG(DLOG_ERROR, "malloc priv failed\n");
+		return -ENOMEM;
+	}
+
+	(void)memset_s(priv, sizeof(struct bma_priv_data_s), 0,
+		       sizeof(struct bma_priv_data_s));
+
+	spin_lock_init(&priv->recv_msg_lock);
+	INIT_LIST_HEAD(&priv->recv_msgs);
+	init_waitqueue_head(&priv->wait);
+
+	priv->user.type = TYPE_UNKNOWN;
+	priv->user.sub_type = 0;
+	priv->user.dma_transfer = 0;
+	priv->user.seq = 0;
+	priv->user.cur_recvmsg_nums = 0;
+	priv->user.max_recvmsg_nums = DEFAULT_MAX_RECV_MSG_NUMS;
+
+	*bma_priv = priv;
+
+	return 0;
+}
+
+static void bma_priv_clean_up(struct bma_priv_data_s *bma_priv)
+{
+	int ret = 0;
+	int i = 0;
+	struct bma_priv_data_s *priv = bma_priv;
+	struct edma_recv_msg_s *msg = NULL;
+
+	if (!priv)
+		return;
+
+	if (priv->user.type == TYPE_UNKNOWN) {
+		BMA_LOG(DLOG_ERROR, "already unknown type\n");
+		return;
+	}
+
+	for (i = 0; i < priv->user.max_recvmsg_nums; i++) {
+		ret = edma_host_recv_msg(&g_bma_dev->edma_host, priv, &msg);
+		if (ret)
+			break;
+
+		kfree(msg);
+	}
+
+	priv->user.type = TYPE_UNKNOWN;
+	priv->user.sub_type = 0;
+	priv->user.dma_transfer = 0;
+	priv->user.seq = 0;
+	priv->user.cur_recvmsg_nums = 0;
+	priv->user.max_recvmsg_nums = DEFAULT_MAX_RECV_MSG_NUMS;
+	kfree(priv);
+}
+
+static irqreturn_t bma_irq_handle(int irq, void *data)
+{
+	struct bma_dev_s *bma_dev = (struct bma_dev_s *)data;
+
+	if (!bma_dev)
+		return IRQ_HANDLED;
+
+	bma_dev->edma_host.statistics.b2h_int++;
+
+	if (!is_edma_b2h_int(&bma_dev->edma_host))
+		return edma_host_irq_handle(&bma_dev->edma_host);
+
+	return (irqreturn_t) atomic_notifier_call_chain(&bma_int_notify_list, 0,
+							data);
+}
+
+int bma_devinft_init(struct bma_pci_dev_s *bma_pci_dev)
+{
+	int ret = 0;
+	int i = 0;
+	struct bma_dev_s *bma_dev = NULL;
+
+	if (!bma_pci_dev)
+		return -EFAULT;
+
+	bma_dev = kmalloc(sizeof(struct bma_dev_s),
+						(int)GFP_KERNEL); /*lint !e64*/
+	if (!bma_dev)
+		return -ENOMEM;
+
+	(void)memset_s(bma_dev, sizeof(struct bma_dev_s), 0,
+		       sizeof(struct bma_dev_s));
+
+	bma_dev->bma_pci_dev = bma_pci_dev;
+	bma_pci_dev->bma_dev = bma_dev;
+
+	INIT_LIST_HEAD(&(bma_dev->priv_list));
+	spin_lock_init(&bma_dev->priv_list_lock);
+
+	for (i = 0; i < TYPE_MAX; i++)
+		atomic_set(&(bma_dev->au_count[i]), 1);
+
+	ret = edma_host_init(&bma_dev->edma_host);
+	if (ret) {
+		BMA_LOG(DLOG_ERROR, "init edma host failed!err = %d\n", ret);
+		goto err_free_bma_dev;
+	}
+
+	BMA_LOG(DLOG_DEBUG, "irq = %d\n", bma_pci_dev->pdev->irq);
+
+	ret = request_irq(bma_pci_dev->pdev->irq, bma_irq_handle, IRQF_SHARED,
+			"EDMA_IRQ", (void *)bma_dev);
+	if (ret) {
+		BMA_LOG(DLOG_ERROR, "request_irq failed!err = %d\n", ret);
+		goto err_edma_host_exit;
+	}
+
+	g_bma_dev = bma_dev;
+	BMA_LOG(DLOG_DEBUG, "ok\n");
+
+	return 0;
+
+err_edma_host_exit:
+	edma_host_cleanup(&bma_dev->edma_host);
+
+err_free_bma_dev:
+	kfree(bma_dev);
+	bma_pci_dev->bma_dev = NULL;
+
+	return ret;
+}
+
+void bma_devinft_cleanup(struct bma_pci_dev_s *bma_pci_dev)
+{
+	if (g_bma_dev) {
+		if ((bma_pci_dev) && (bma_pci_dev->pdev)
+		    && (bma_pci_dev->pdev->irq)) {
+			BMA_LOG(DLOG_DEBUG, "irq = %d\n",
+				bma_pci_dev->pdev->irq);
+			free_irq(bma_pci_dev->pdev->irq,
+				 (void *)bma_pci_dev->bma_dev);
+		}
+
+		edma_host_cleanup(&g_bma_dev->edma_host);
+
+		if ((bma_pci_dev) && (bma_pci_dev->bma_dev)) {
+			kfree(bma_pci_dev->bma_dev);
+			bma_pci_dev->bma_dev = NULL;
+		}
+
+		g_bma_dev = NULL;
+	}
+}
+
+int bma_intf_register_int_notifier(struct notifier_block *nb)
+{
+	if (!nb)
+		return -1;
+
+	return atomic_notifier_chain_register(&bma_int_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(bma_intf_register_int_notifier);
+
+void bma_intf_unregister_int_notifier(struct notifier_block *nb)
+{
+	if (!nb)
+		return;
+
+	atomic_notifier_chain_unregister(&bma_int_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(bma_intf_unregister_int_notifier);
+
+int bma_intf_register_type(u32 type, u32 sub_type, enum intr_mod support_int,
+			   void **handle)
+{
+	int ret = 0;
+	struct bma_priv_data_s *priv = NULL;
+
+	if (!handle)
+		return -EFAULT;
+
+	ret = bma_priv_init(&priv);
+	if (ret) {
+		BMA_LOG(DLOG_ERROR, "bma_priv_init failed! ret = %d\n", ret);
+		return ret;
+	}
+
+	ret = bma_priv_insert_priv_list(priv, type, sub_type);
+	if (ret) {
+		bma_priv_clean_up(priv);
+		BMA_LOG(DLOG_ERROR,
+			"bma_priv_insert_priv_list failed! ret = %d\n", ret);
+		return ret;
+	}
+
+	if (support_int)
+		priv->user.support_int = INTR_ENABLE;
+
+	if (type == TYPE_VETH) {
+		priv->specific.veth.pdev = g_bma_dev->bma_pci_dev->pdev;
+
+		priv->specific.veth.veth_swap_phy_addr =
+		    g_bma_dev->bma_pci_dev->veth_swap_phy_addr;
+		priv->specific.veth.veth_swap_addr =
+		    g_bma_dev->bma_pci_dev->veth_swap_addr;
+		priv->specific.veth.veth_swap_len =
+		    g_bma_dev->bma_pci_dev->veth_swap_len;
+	}
+
+	*handle = priv;
+
+	return 0;
+}
+EXPORT_SYMBOL(bma_intf_register_type);
+
+int bma_intf_unregister_type(void **handle)
+{
+	struct bma_priv_data_s *priv = NULL;
+
+	if (!handle) {
+		BMA_LOG(DLOG_ERROR, "edna_priv is NULL\n");
+		return -EFAULT;
+	}
+
+	priv = (struct bma_priv_data_s *)*handle;
+	*handle = NULL;
+
+	priv->user.cur_recvmsg_nums++;
+	wake_up_interruptible(&(priv->wait));
+
+	msleep(500);
+
+	bma_priv_delete_priv_list(priv);
+
+	bma_priv_clean_up(priv);
+
+	return 0;
+}
+EXPORT_SYMBOL(bma_intf_unregister_type);
+
+int bma_intf_check_edma_supported(void)
+{
+	return !(g_bma_dev == NULL);
+}
+EXPORT_SYMBOL(bma_intf_check_edma_supported);
+
+int bma_intf_check_dma_status(enum dma_direction_e dir)
+{
+	return edma_host_check_dma_status(dir);
+}
+EXPORT_SYMBOL(bma_intf_check_dma_status);
+
+void bma_intf_reset_dma(enum dma_direction_e dir)
+{
+	edma_host_reset_dma(&g_bma_dev->edma_host, dir);
+}
+EXPORT_SYMBOL(bma_intf_reset_dma);
+
+void bma_intf_clear_dma_int(enum dma_direction_e dir)
+{
+	if (dir == BMC_TO_HOST)
+		clear_int_dmab2h(&g_bma_dev->edma_host);
+	else if (dir == HOST_TO_BMC)
+		clear_int_dmah2b(&g_bma_dev->edma_host);
+	else
+		return;
+}
+EXPORT_SYMBOL(bma_intf_clear_dma_int);
+
+int bma_intf_start_dma(void *handle, struct bma_dma_transfer_s *dma_transfer)
+{
+	int ret = 0;
+	struct bma_priv_data_s *priv = (struct bma_priv_data_s *)handle;
+
+	if (!handle || !dma_transfer)
+		return -EFAULT;
+
+	ret = edma_host_dma_start(&g_bma_dev->edma_host, priv);
+	if (ret) {
+		BMA_LOG(DLOG_ERROR,
+			"edma_host_dma_start failed! result = %d\n", ret);
+		return ret;
+	}
+
+	ret = edma_host_dma_transfer(&g_bma_dev->edma_host, priv, dma_transfer);
+	if (ret)
+		BMA_LOG(DLOG_ERROR,
+			"edma_host_dma_transfer failed! ret = %d\n", ret);
+
+	ret = edma_host_dma_stop(&g_bma_dev->edma_host, priv);
+	if (ret) {
+		BMA_LOG(DLOG_ERROR,
+			"edma_host_dma_stop failed! result = %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(bma_intf_start_dma);
+
+int bma_intf_int_to_bmc(void *handle)
+{
+	struct bma_priv_data_s *priv = (struct bma_priv_data_s *)handle;
+
+	if (!handle) {
+		BMA_LOG(DLOG_ERROR, "input NULL! bma_priv = %p\n", handle);
+		return -EFAULT;
+	}
+
+	if (priv->user.support_int == 0) {
+		BMA_LOG(DLOG_ERROR, "not support int to bmc.\n");
+		return -EFAULT;
+	}
+
+	edma_int_to_bmc(&g_bma_dev->edma_host);
+
+	return 0;
+}
+EXPORT_SYMBOL(bma_intf_int_to_bmc);
+
+int bma_intf_is_link_ok(void)
+{
+	return (g_bma_dev->edma_host.statistics.remote_status ==
+		REGISTERED) ? 1 : 0;
+}
+EXPORT_SYMBOL(bma_intf_is_link_ok);
+
+int bma_cdev_recv_msg(void *handle, char __user *data, size_t count)
+{
+	struct bma_priv_data_s *priv = NULL;
+	struct edma_recv_msg_s *msg = NULL;
+	int result = 0;
+	int len = 0;
+	int ret = 0;
+
+	if ((!handle) || (!data) || (count == 0)) {
+		BMA_LOG(DLOG_DEBUG, "input NULL point!\n");
+		return -EFAULT;
+	}
+
+	priv = (struct bma_priv_data_s *)handle;
+
+	result = edma_host_recv_msg(&g_bma_dev->edma_host, priv, &msg);
+	if (result != 0) {
+		ret = -ENODATA;
+		goto failed;
+	}
+
+	if (msg->msg_len > count) {
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	if (copy_to_user(data, (void *)(msg->msg_data), msg->msg_len)) {
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	len = msg->msg_len;
+
+	kfree(msg);
+
+	return len;
+failed:
+	kfree(msg);
+
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(bma_cdev_recv_msg);
+
+int bma_cdev_add_msg(void *handle, const char __user *msg, size_t msg_len)
+{
+	struct bma_priv_data_s *priv = NULL;
+	struct edma_msg_hdr_s *hdr = NULL;
+	unsigned long flags = 0;
+	int total_len = 0;
+	int ret = 0;
+
+	if ((!handle) || (!msg) || (msg_len == 0)) {
+		BMA_LOG(DLOG_DEBUG, "input NULL point!\n");
+		return -EFAULT;
+	}
+
+	if (msg_len > CDEV_MAX_WRITE_LEN) {
+		BMA_LOG(DLOG_DEBUG, "input data is overlen!\n");
+		return -EINVAL;
+	}
+
+	priv = (struct bma_priv_data_s *)handle;
+
+	if (priv->user.type >= TYPE_MAX) {
+		BMA_LOG(DLOG_DEBUG, "error type = %d\n", priv->user.type);
+		return -EFAULT;
+	}
+	total_len = SIZE_OF_MSG_HDR + msg_len;
+
+	spin_lock_irqsave(&g_bma_dev->edma_host.send_msg_lock, flags);
+
+	if (g_bma_dev->edma_host.msg_send_write + total_len <=
+	    HOST_MAX_SEND_MBX_LEN - SIZE_OF_MBX_HDR) {
+		hdr = (struct edma_msg_hdr_s *)(
+				g_bma_dev->edma_host.msg_send_buf
+				+ g_bma_dev->edma_host.msg_send_write);
+		hdr->type = priv->user.type;
+		hdr->sub_type = priv->user.sub_type;
+		hdr->user_id = priv->user.user_id;
+		hdr->datalen = msg_len;
+		BMA_LOG(DLOG_DEBUG, "hdr->data is %p\n", hdr->data);
+		BMA_LOG(DLOG_DEBUG,
+			"g_edmaprivate.msg_send_buf is %p\n",
+			g_bma_dev->edma_host.msg_send_buf);
+		BMA_LOG(DLOG_DEBUG, "msg is %p\n", msg);
+		BMA_LOG(DLOG_DEBUG, "msg_len is %ld\n", msg_len);
+
+		if (copy_from_user(hdr->data, msg, msg_len)) {
+			BMA_LOG(DLOG_ERROR, "copy_from_user error\n");
+		ret = -EFAULT;
+		goto end;
+		}
+
+		g_bma_dev->edma_host.msg_send_write += total_len;
+		g_bma_dev->edma_host.statistics.send_bytes += total_len;
+		g_bma_dev->edma_host.statistics.send_pkgs++;
+#ifdef EDMA_TIMER
+		(void)mod_timer(&g_bma_dev->edma_host.timer,
+				jiffies_64);
+#endif
+		BMA_LOG(DLOG_DEBUG, "msg_send_write = %d\n",
+			g_bma_dev->edma_host.msg_send_write);
+
+		ret = msg_len;
+		goto end;
+	} else {
+
+		BMA_LOG(DLOG_DEBUG,
+			"msg lost,msg_send_write: %d,msg_len:%d,max_len: %d\n",
+			g_bma_dev->edma_host.msg_send_write, total_len,
+			HOST_MAX_SEND_MBX_LEN);
+		ret = -ENOSPC;
+		goto end;
+	}
+
+end:
+	spin_unlock_irqrestore(&(g_bma_dev->edma_host.send_msg_lock), flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(bma_cdev_add_msg);
+
+unsigned int bma_cdev_check_recv(void *handle)
+{
+	struct bma_priv_data_s *priv = (struct bma_priv_data_s *)handle;
+	unsigned long flags = 0;
+	unsigned int result = 0;
+
+	if (priv != NULL) {
+		spin_lock_irqsave(&priv->recv_msg_lock, flags);
+
+		if (!list_empty(&priv->recv_msgs))
+			result = 1;
+
+		spin_unlock_irqrestore(&priv->recv_msg_lock, flags);
+	}
+
+	return result;
+}
+EXPORT_SYMBOL_GPL(bma_cdev_check_recv);
+
+void *bma_cdev_get_wait_queue(void *handle)
+{
+	struct bma_priv_data_s *priv = (struct bma_priv_data_s *)handle;
+
+	return priv ? ((void *)&priv->wait) : NULL;
+}
+EXPORT_SYMBOL_GPL(bma_cdev_get_wait_queue);
+
+void bma_intf_set_open_status(void *handle, int s)
+{
+	struct bma_priv_data_s *priv = (struct bma_priv_data_s *)handle;
+	int i = 0;
+	int ret = 0;
+	unsigned long flags = 0;
+	char drv_msg[3] = { 0 };
+	struct edma_recv_msg_s *tmp_msg = NULL;
+
+	if (priv == NULL || priv->user.type >= TYPE_MAX)
+		return;
+
+	drv_msg[0] = 1;
+	drv_msg[1] = priv->user.type;
+	drv_msg[2] = s;
+
+	(void)edma_host_send_driver_msg((void *)drv_msg, sizeof(drv_msg),
+						DEV_OPEN_STATUS_ANS);
+
+		spin_lock_irqsave(&priv->recv_msg_lock, flags);
+		g_bma_dev->edma_host.local_open_status[priv->user.type] = s;
+
+		if (s == DEV_CLOSE && priv->user.cur_recvmsg_nums > 0) {
+			for (i = 0; i < priv->user.max_recvmsg_nums; i++) {
+				ret = edma_host_recv_msg(&g_bma_dev->edma_host,
+						priv, &tmp_msg);
+				if (ret < 0)
+					break;
+
+				kfree(tmp_msg);
+				tmp_msg = NULL;
+			}
+		}
+
+		spin_unlock_irqrestore(&priv->recv_msg_lock, flags);
+}
+EXPORT_SYMBOL_GPL(bma_intf_set_open_status);
diff --git a/drivers/net/ethernet/huawei/ibma/bma_devintf.h b/drivers/net/ethernet/huawei/ibma/bma_devintf.h
new file mode 100644
index 0000000..25ad9a5
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/bma_devintf.h
@@ -0,0 +1,39 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _BMA_DEVINTF_H_
+#define _BMA_DEVINTF_H_
+
+#include <linux/mutex.h>
+#include "bma_pci.h"
+#include "edma_host.h"
+
+struct bma_dev_s {
+	/* proc */
+	struct proc_dir_entry *proc_bma_root;
+
+	atomic_t au_count[TYPE_MAX];
+
+	struct list_head priv_list;
+	spinlock_t priv_list_lock;
+
+	struct bma_pci_dev_s *bma_pci_dev;
+	struct edma_host_s edma_host;
+};
+
+int bma_devinft_init(struct bma_pci_dev_s *bma_pci_dev);
+void bma_devinft_cleanup(struct bma_pci_dev_s *bma_pci_dev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/ibma/bma_include.h b/drivers/net/ethernet/huawei/ibma/bma_include.h
new file mode 100644
index 0000000..5950be2
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/bma_include.h
@@ -0,0 +1,119 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _BMA_INCLUDE_H_
+#define _BMA_INCLUDE_H_
+
+#include <linux/slab.h>
+#include <asm/ioctls.h>
+#include <linux/capability.h>
+#include <linux/uaccess.h>	/* copy_*_user */
+#include <linux/delay.h>	/* udelay */
+#include <linux/mm.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>	/*tasklet */
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/version.h>
+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2, 6, 18))	/*lint !e30 !e553 */
+#include <asm/semaphore.h>
+#else
+#include <linux/semaphore.h>
+#endif
+#include <linux/sched.h>
+#include "securec.h"
+
+#define UNUSED(x) (x = x)
+#define KBOX_FALSE (-1)
+#define KBOX_TRUE 0
+
+#define KBOX_IOC_MAGIC (0xB2)
+
+#define DEFAULT_MAX_RECV_MSG_NUMS   32
+#define MAX_RECV_MSG_NUMS 1024
+
+#define STRFICATION(R) #R
+#define MICRO_TO_STR(R) STRFICATION(R)
+
+
+enum {
+	DLOG_ERROR = 0,
+	DLOG_DEBUG = 1,
+};
+
+enum {
+	DEV_CLOSE = 0,
+	DEV_OPEN = 1,
+	DEV_OPEN_STATUS_REQ = 0xf0,
+	DEV_OPEN_STATUS_ANS
+};
+
+#define BAD_FUNC_ADDR(x) ((0xFFFFFFFF == (x)) || (0 == (x)))
+
+
+struct bma_user_s {
+	struct list_head link;
+
+	u32 type;
+	u32 sub_type;
+	u8 user_id;
+
+	u8 dma_transfer:1, support_int:1;
+
+	u8 reserve1[2];
+	u32 seq;
+	u16 cur_recvmsg_nums;
+	u16 max_recvmsg_nums;
+};
+
+struct bma_priv_data_veth_s {
+	struct pci_dev *pdev;
+
+	unsigned long veth_swap_phy_addr;
+	void __iomem *veth_swap_addr;
+	unsigned long veth_swap_len;
+};
+
+struct bma_priv_data_s {
+	struct bma_user_s user;
+	spinlock_t recv_msg_lock;
+	struct list_head recv_msgs;
+	struct file *file;
+	wait_queue_head_t wait;
+
+	union {
+		struct bma_priv_data_veth_s veth;
+	} specific;
+};
+
+void __iomem *kbox_get_base_addr(void);
+unsigned long kbox_get_io_len(void);
+unsigned long kbox_get_base_phy_addr(void);
+int edma_param_set_debug(const char *buf, struct kernel_param *kp);
+#define GET_SYS_SECONDS(t) do \
+	{\
+		struct timespec uptime;\
+		get_monotonic_boottime(&uptime);\
+		t = uptime.tv_sec;\
+	} while (0)
+
+
+#define SECONDS_PER_DAY (24*3600)
+#define SECONDS_PER_HOUR (3600)
+#define SECONDS_PER_MINUTE (60)
+
+#endif
diff --git a/drivers/net/ethernet/huawei/ibma/bma_ker_intf.h b/drivers/net/ethernet/huawei/ibma/bma_ker_intf.h
new file mode 100644
index 0000000..5e91925
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/bma_ker_intf.h
@@ -0,0 +1,89 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _BMA_KER_INTF_H_
+#define _BMA_KER_INTF_H_
+
+enum {
+	/* 0 -127 msg */
+	TYPE_LOGIC_PARTITION = 0,
+	TYPE_UPGRADE = 1,
+	TYPE_CDEV = 2,
+	TYPE_VETH = 0x40,
+	TYPE_MAX = 128,
+
+	TYPE_KBOX = 129,
+	TYPE_EDMA_DRIVER = 130,
+	TYPE_UNKNOWN = 0xff,
+};
+
+enum dma_direction_e {
+	BMC_TO_HOST = 0,
+	HOST_TO_BMC = 1,
+};
+
+enum dma_type_e {
+	DMA_NOT_LIST = 0,
+	DMA_LIST = 1,
+};
+
+enum intr_mod {
+	INTR_DISABLE = 0,
+	INTR_ENABLE = 1,
+};
+struct bma_dma_addr_s {
+	dma_addr_t dma_addr;
+	u32 dma_data_len;
+};
+
+struct dma_transfer_s {
+	struct bma_dma_addr_s host_addr;
+	struct bma_dma_addr_s bmc_addr;
+};
+
+struct dmalist_transfer_s {
+	dma_addr_t dma_addr;
+};
+
+struct bma_dma_transfer_s {
+	enum dma_type_e type;
+	enum dma_direction_e dir;
+
+	union {
+		struct dma_transfer_s nolist;
+		struct dmalist_transfer_s list;
+	} transfer;
+};
+
+int bma_intf_register_int_notifier(struct notifier_block *nb);
+void bma_intf_unregister_int_notifier(struct notifier_block *nb);
+int bma_intf_register_type(u32 type, u32 sub_type, enum intr_mod support_int,
+			   void **handle);
+int bma_intf_unregister_type(void **handle);
+int bma_intf_check_dma_status(enum dma_direction_e dir);
+int bma_intf_start_dma(void *handle, struct bma_dma_transfer_s *dma_transfer);
+int bma_intf_int_to_bmc(void *handle);
+void bma_intf_set_open_status(void *handle, int s);
+int bma_intf_is_link_ok(void);
+void bma_intf_reset_dma(enum dma_direction_e dir);
+void bma_intf_clear_dma_int(enum dma_direction_e dir);
+
+int bma_cdev_recv_msg(void *handle, char __user *data, size_t count);
+int bma_cdev_add_msg(void *handle, const char __user *msg, size_t msg_len);
+
+unsigned int bma_cdev_check_recv(void *handle);
+void *bma_cdev_get_wait_queue(void *handle);
+int bma_intf_check_edma_supported(void);
+#endif
diff --git a/drivers/net/ethernet/huawei/ibma/bma_pci.c b/drivers/net/ethernet/huawei/ibma/bma_pci.c
new file mode 100644
index 0000000..55c4bd9
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/bma_pci.c
@@ -0,0 +1,515 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/pci.h>
+#include <linux/version.h>
+#include <linux/module.h>
+
+#include "bma_include.h"
+#include "bma_devintf.h"
+#include "bma_pci.h"
+
+#define PCI_KBOX_MODULE_NAME		"edma_drv"
+#define PCI_VENDOR_ID_HUAWEI_FPGA	0x19aa
+#define PCI_DEVICE_ID_KBOX_0		0xe004
+
+#define PCI_VENDOR_ID_HUAWEI_PME	0x19e5
+#define PCI_DEVICE_ID_KBOX_0_PME	0x1710
+#define PCI_PME_USEABLE_SPACE		(4 * 1024 * 1024)
+
+#define PCI_BAR0_PME_1710		0x85800000
+#define PCI_BAR0			0
+#define PCI_BAR1			1
+#define PCI_USING_DAC_DEFAULT 0
+
+int pci_using_dac = PCI_USING_DAC_DEFAULT;
+int debug = DLOG_ERROR;
+MODULE_PARM_DESC(debug, "Debug switch (0=close debug, 1=open debug)");
+
+static struct bma_pci_dev_s *g_bma_pci_dev;
+
+static int bma_pci_suspend(struct pci_dev *pdev, pm_message_t state);
+static int bma_pci_resume(struct pci_dev *pdev);
+static int bma_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
+static void bma_pci_remove(struct pci_dev *pdev);
+
+static const struct pci_device_id bma_pci_tbl[] = {
+	{PCI_DEVICE(PCI_VENDOR_ID_HUAWEI_FPGA, PCI_DEVICE_ID_KBOX_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_HUAWEI_PME, PCI_DEVICE_ID_KBOX_0_PME)},
+	{}
+};
+MODULE_DEVICE_TABLE(pci, bma_pci_tbl);/*lint !e19*/
+
+int edma_param_get_statics(char *buf, struct kernel_param *kp)
+{
+	if (!buf)
+		return 0;
+
+	return edmainfo_show(buf);
+}
+
+
+module_param_call(statistics, NULL, edma_param_get_statics, &debug, 0444);
+MODULE_PARM_DESC(statistics, "Statistics info of edma driver,readonly");
+
+int edma_param_set_debug(const char *buf, struct kernel_param *kp)
+{
+	unsigned long val = 0;
+	int ret = 0;
+
+	if (!buf)
+		return -EINVAL;
+#if (KERNEL_VERSION(3, 0, 0) < LINUX_VERSION_CODE)
+	ret = kstrtoul(buf, 0, &val);
+#else
+	ret = strict_strtoul(buf, 0, &val);
+#endif
+	if (ret)
+		return ret;
+
+	if (val > 1)
+		return -EINVAL;
+
+	return param_set_int(buf, kp);
+}
+EXPORT_SYMBOL_GPL(edma_param_set_debug);
+
+module_param_call(debug, &edma_param_set_debug, &param_get_int, &debug, 0644);
+
+
+void __iomem *kbox_get_base_addr(void)
+{
+	if ((!g_bma_pci_dev)
+		|| (!(g_bma_pci_dev->kbox_base_addr))) {
+		BMA_LOG(DLOG_ERROR, "kbox_base_addr NULL point\n");
+		return NULL;
+	}
+
+	return g_bma_pci_dev->kbox_base_addr;
+}
+EXPORT_SYMBOL_GPL(kbox_get_base_addr);
+
+unsigned long kbox_get_io_len(void)
+{
+	if (!g_bma_pci_dev) {
+		BMA_LOG(DLOG_ERROR, "kbox_io_len is error,can not get it\n");
+		return 0;
+	}
+
+	return g_bma_pci_dev->kbox_base_len;
+}
+EXPORT_SYMBOL_GPL(kbox_get_io_len);
+
+unsigned long kbox_get_base_phy_addr(void)
+{
+	if ((!g_bma_pci_dev) || (!g_bma_pci_dev->kbox_base_phy_addr)) {
+		BMA_LOG(DLOG_ERROR, "kbox_base_phy_addr NULL point\n");
+		return 0;
+	}
+
+	return g_bma_pci_dev->kbox_base_phy_addr;
+}
+EXPORT_SYMBOL_GPL(kbox_get_base_phy_addr);
+
+static struct pci_driver bma_driver = {
+	.name = PCI_KBOX_MODULE_NAME,
+	.id_table = bma_pci_tbl,
+	.probe = bma_pci_probe,
+	.remove = bma_pci_remove,
+	.suspend = bma_pci_suspend,
+	.resume = bma_pci_resume,
+};
+
+s32 __atu_config_H(struct pci_dev *pdev, unsigned int region,
+		   unsigned int hostaddr_h, unsigned int hostaddr_l,
+		   unsigned int bmcaddr_h, unsigned int bmcaddr_l,
+		   unsigned int len)
+{
+
+	/*  atu index reg,inbound and region*//*lint -e648 */
+	(void)pci_write_config_dword(pdev, ATU_VIEWPORT,
+		REGION_DIR_INPUT + (region & REGION_INDEX_MASK));
+	(void)pci_write_config_dword(pdev, ATU_BASE_LOW, hostaddr_l);
+	(void)pci_write_config_dword(pdev, ATU_BASE_HIGH, hostaddr_h);
+	(void)pci_write_config_dword(pdev, ATU_LIMIT, hostaddr_l + len - 1);
+	(void)pci_write_config_dword(pdev, ATU_TARGET_LOW, bmcaddr_l);
+	(void)pci_write_config_dword(pdev, ATU_TARGET_HIGH, bmcaddr_h);
+	/*  atu ctrl1 reg   */
+	(void)pci_write_config_dword(pdev, ATU_REGION_CTRL1, ATU_CTRL1_DEFAULT);
+	/*  atu ctrl2 reg   */
+	(void)pci_write_config_dword(pdev, ATU_REGION_CTRL2, REGION_ENABLE);
+	/*lint +e648 */
+	return 0;
+}
+
+static void iounmap_bar_mem(struct bma_pci_dev_s *bma_pci_dev)
+{
+	if (bma_pci_dev->kbox_base_addr) {
+		iounmap(bma_pci_dev->kbox_base_addr);
+		bma_pci_dev->kbox_base_addr = NULL;
+	}
+
+	if (bma_pci_dev->bma_base_addr) {
+		iounmap(bma_pci_dev->bma_base_addr);
+		bma_pci_dev->bma_base_addr = NULL;
+		bma_pci_dev->edma_swap_addr = NULL;
+		bma_pci_dev->hostrtc_viraddr = NULL;
+	}
+}
+
+static int ioremap_bar_mem(struct pci_dev *pdev,
+			   struct bma_pci_dev_s *bma_pci_dev)
+{
+	int err = 0;
+	unsigned long bar0_resource_flag = 0;
+	unsigned long bar1_resource_flag = 0;
+	u32 data = 0;
+
+	BMA_LOG(DLOG_DEBUG, "pdev : %p\n", pdev);
+
+	bar0_resource_flag = pci_resource_flags(pdev, PCI_BAR0);
+
+	if (!(bar0_resource_flag & IORESOURCE_MEM)) {
+		BMA_LOG(DLOG_ERROR,
+			"Cannot find proper PCI device base address, aborting\n");
+		err = -ENODEV;
+		return err;
+	}
+
+	bma_pci_dev->kbox_base_phy_addr = pci_resource_start(pdev, PCI_BAR0);
+
+	bma_pci_dev->kbox_base_len = pci_resource_len(pdev, PCI_BAR0);
+
+	BMA_LOG(DLOG_DEBUG,
+		"bar0: kbox_base_phy_addr = 0x%lx, base_len = %ld(0x%lx)\n",
+		bma_pci_dev->kbox_base_phy_addr, bma_pci_dev->kbox_base_len,
+		bma_pci_dev->kbox_base_len);
+
+	if ((pdev->device == PCI_DEVICE_ID_KBOX_0_PME)
+	    && (pdev->vendor == PCI_VENDOR_ID_HUAWEI_PME)) {
+
+		bma_pci_dev->kbox_base_len = PCI_PME_USEABLE_SPACE;
+		BMA_LOG(DLOG_DEBUG, "1710\n");
+
+		bma_pci_dev->bma_base_phy_addr =
+		    pci_resource_start(pdev, PCI_BAR1);
+		bar1_resource_flag = pci_resource_flags(pdev, PCI_BAR1);
+
+		if (!(bar1_resource_flag & IORESOURCE_MEM)) {
+			BMA_LOG(DLOG_ERROR,
+				"Cannot find proper PCI device base address, aborting\n");
+			return -ENODEV;
+		}
+
+		bma_pci_dev->bma_base_len = pci_resource_len(pdev, PCI_BAR1);
+		bma_pci_dev->edma_swap_len = EDMA_SWAP_DATA_SIZE;
+		bma_pci_dev->veth_swap_len = VETH_SWAP_DATA_SIZE;
+
+		BMA_LOG(DLOG_DEBUG,
+			"bar1: bma_base_len = 0x%lx, edma_swap_len = %ld, veth_swap_len = %ld(0x%lx)\n",
+			bma_pci_dev->bma_base_len, bma_pci_dev->edma_swap_len,
+			bma_pci_dev->veth_swap_len, bma_pci_dev->veth_swap_len);
+
+		bma_pci_dev->hostrtc_phyaddr = bma_pci_dev->bma_base_phy_addr;
+		/* edma */
+		bma_pci_dev->edma_swap_phy_addr =
+			bma_pci_dev->bma_base_phy_addr + EDMA_SWAP_BASE_OFFSET;
+		/* veth */
+		bma_pci_dev->veth_swap_phy_addr =
+			bma_pci_dev->edma_swap_phy_addr + EDMA_SWAP_DATA_SIZE;
+
+		BMA_LOG(DLOG_DEBUG,
+			"bar1: hostrtc_phyaddr = 0x%lx, edma_swap_phy_addr = 0x%lx, veth_swap_phy_addr = 0x%lx\n",
+			bma_pci_dev->hostrtc_phyaddr,
+			bma_pci_dev->edma_swap_phy_addr,
+			bma_pci_dev->veth_swap_phy_addr);
+
+		__atu_config_H(pdev, 0, (sizeof(unsigned long) == 8) ?
+		((u64)(bma_pci_dev->kbox_base_phy_addr) >> 32)
+		: 0,/*lint !e506 !e572 */
+		((u64)(bma_pci_dev->kbox_base_phy_addr) &
+		0xffffffff), 0, PCI_BAR0_PME_1710,
+		PCI_PME_USEABLE_SPACE);
+
+		__atu_config_H(pdev, 1, (sizeof(unsigned long) == 8) ?
+		(bma_pci_dev->hostrtc_phyaddr >> 32) : 0,/*lint !e506 !e572 */
+		(bma_pci_dev->hostrtc_phyaddr & 0xffffffff),
+		0, HOSTRTC_REG_BASE, HOSTRTC_REG_SIZE);
+
+		__atu_config_H(pdev, 2, (sizeof(unsigned long) == 8) ?
+		(bma_pci_dev->edma_swap_phy_addr >> 32)
+		: 0,/*lint !e506 !e572 */
+		(bma_pci_dev->edma_swap_phy_addr & 0xffffffff),
+		0, EDMA_SWAP_DATA_BASE, EDMA_SWAP_DATA_SIZE);
+
+		__atu_config_H(pdev, 3, (sizeof(unsigned long) == 8) ?
+		(bma_pci_dev->veth_swap_phy_addr >> 32)
+		: 0,/*lint !e506 !e572 */
+		(bma_pci_dev->veth_swap_phy_addr & 0xffffffff),
+		0, VETH_SWAP_DATA_BASE, VETH_SWAP_DATA_SIZE);
+
+		if (bar1_resource_flag & IORESOURCE_CACHEABLE) {
+			bma_pci_dev->bma_base_addr =
+			    ioremap(bma_pci_dev->bma_base_phy_addr,
+				    bma_pci_dev->bma_base_len);
+		} else {
+			bma_pci_dev->bma_base_addr =
+			    ioremap_nocache(bma_pci_dev->bma_base_phy_addr,
+					    bma_pci_dev->bma_base_len);
+		}
+
+		if (!bma_pci_dev->bma_base_addr) {
+			BMA_LOG(DLOG_ERROR,
+				"Cannot map device registers, aborting\n");
+
+			return -ENODEV;
+		} else {
+			bma_pci_dev->hostrtc_viraddr =
+			    bma_pci_dev->bma_base_addr;
+			bma_pci_dev->edma_swap_addr =
+			    (unsigned char *)bma_pci_dev->bma_base_addr +
+			    EDMA_SWAP_BASE_OFFSET;
+			bma_pci_dev->veth_swap_addr =
+			    (unsigned char *)bma_pci_dev->edma_swap_addr +
+			    EDMA_SWAP_DATA_SIZE;
+
+		(void)pci_read_config_dword(pdev, 0x78, &data);
+			data = data & 0xfffffff0;
+			(void)pci_write_config_dword(pdev, 0x78, data);
+		(void)pci_read_config_dword(pdev, 0x78, &data);
+
+			BMA_LOG(DLOG_DEBUG,
+				"hostrtc_viraddr = %p, edma_swap_addr = %p, veth_swap_addr = %p\n",
+				bma_pci_dev->hostrtc_viraddr,
+				bma_pci_dev->edma_swap_addr,
+				bma_pci_dev->veth_swap_addr);
+		}
+	}
+
+	BMA_LOG(DLOG_DEBUG, "remap BAR0 KBOX\n");
+
+	if (bar0_resource_flag & IORESOURCE_CACHEABLE) {
+		bma_pci_dev->kbox_base_addr =
+		    ioremap(bma_pci_dev->kbox_base_phy_addr,
+			    bma_pci_dev->kbox_base_len);
+	} else {
+		bma_pci_dev->kbox_base_addr =
+		    ioremap_nocache(bma_pci_dev->kbox_base_phy_addr,
+				    bma_pci_dev->kbox_base_len);
+	}
+
+	BMA_LOG(DLOG_DEBUG, "kbox_base_addr = %p\n",
+		bma_pci_dev->kbox_base_addr);
+
+	if (!bma_pci_dev->kbox_base_addr) {
+		BMA_LOG(DLOG_ERROR, "Cannot map device registers, aborting\n");
+
+		iounmap(bma_pci_dev->bma_base_addr);
+		bma_pci_dev->bma_base_addr = NULL;
+		bma_pci_dev->edma_swap_addr = NULL;
+		bma_pci_dev->hostrtc_viraddr = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int bma_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	int err = 0;
+	struct bma_pci_dev_s *bma_pci_dev = NULL;
+
+	UNUSED(ent);
+
+	if (g_bma_pci_dev)
+		return -EPERM;
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		BMA_LOG(DLOG_ERROR, "Cannot enable PCI device,aborting\n");
+		return err;
+	}
+
+	if ((pdev->device == PCI_DEVICE_ID_KBOX_0_PME)
+	    && (pdev->vendor == PCI_VENDOR_ID_HUAWEI_PME)) {
+		pci_set_master(pdev);
+
+#ifdef CONFIG_PCI_MSI
+	if (pci_find_capability(pdev, PCI_CAP_ID_MSI)) {
+		BMA_LOG(DLOG_DEBUG, "support msi\n");
+	} else {
+		BMA_LOG(DLOG_ERROR, "not support msi\n");
+		goto err_out_disable_pdev;
+	}
+
+		err = pci_enable_msi(pdev);
+		if (err) {
+			BMA_LOG(DLOG_ERROR, "pci_enable_msi failed\n");
+			goto err_out_disable_pdev;
+		}
+#endif
+	}
+
+	BMA_LOG(DLOG_DEBUG, "pdev->device = 0x%x\n", pdev->device);
+	BMA_LOG(DLOG_DEBUG, "pdev->vendor = 0x%x\n", pdev->vendor);
+
+	bma_pci_dev = kmalloc(sizeof(struct bma_pci_dev_s),
+						GFP_KERNEL); /*lint !e64*/
+	if (!bma_pci_dev) {
+		err = -ENOMEM;
+		goto err_out_disable_msi;
+	}
+
+	bma_pci_dev->pdev = pdev;
+
+	err = pci_request_regions(pdev, PCI_KBOX_MODULE_NAME);
+	if (err) {
+		BMA_LOG(DLOG_ERROR, "Cannot obtain PCI resources, aborting\n");
+		goto err_out_free_dev;
+	}
+
+	err = ioremap_bar_mem(pdev, bma_pci_dev);
+	if (err) {
+		BMA_LOG(DLOG_ERROR, "ioremap_edma_io_mem failed\n");
+		goto err_out_release_regions;
+	}
+
+	g_bma_pci_dev = bma_pci_dev;
+
+	err = dma_set_mask(&(pdev->dev), DMA_BIT_MASK(64));
+
+	if (err) {
+		err = dma_set_coherent_mask(&(pdev->dev),
+				DMA_BIT_MASK(64)); /*lint !e1055*/
+
+		if (err) {
+
+			BMA_LOG(DLOG_ERROR,
+				"No usable DMA ,configuration, aborting,goto failed2!!!\n");
+			goto err_out_unmap_bar;
+		}
+	}
+
+	g_bma_pci_dev = bma_pci_dev;
+
+	if ((pdev->device == PCI_DEVICE_ID_KBOX_0_PME)
+	    && (pdev->vendor == PCI_VENDOR_ID_HUAWEI_PME)) {
+		err = bma_devinft_init(bma_pci_dev);
+		if (err) {
+			BMA_LOG(DLOG_ERROR, "bma_devinft_init failed\n");
+			goto err_out_clean_devinft;
+		}
+	} else {
+		BMA_LOG(DLOG_DEBUG, "edma is not supported on this pcie\n");
+	}
+
+	pci_set_drvdata(pdev, bma_pci_dev);
+
+	return 0;
+
+err_out_clean_devinft:
+	bma_devinft_cleanup(bma_pci_dev);
+err_out_unmap_bar:
+	iounmap_bar_mem(bma_pci_dev);
+	g_bma_pci_dev = NULL;
+err_out_release_regions:
+	pci_release_regions(pdev);
+err_out_free_dev:
+	kfree(bma_pci_dev);
+	bma_pci_dev = NULL;
+
+err_out_disable_msi:
+
+#ifdef CONFIG_PCI_MSI
+	pci_disable_msi(pdev);
+#endif
+err_out_disable_pdev:
+
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static void bma_pci_remove(struct pci_dev *pdev)
+{
+	struct bma_pci_dev_s *bma_pci_dev =
+		(struct bma_pci_dev_s *)pci_get_drvdata(pdev);	/*lint !e1055 */
+
+	g_bma_pci_dev = NULL;
+	(void)pci_set_drvdata(pdev, NULL);
+
+	if (bma_pci_dev) {
+		bma_devinft_cleanup(bma_pci_dev);
+
+		iounmap_bar_mem(bma_pci_dev);
+
+		kfree(bma_pci_dev);
+	}
+
+	pci_release_regions(pdev);
+
+
+#ifdef CONFIG_PCI_MSI
+	pci_disable_msi(pdev);
+#endif
+	pci_disable_device(pdev);
+}
+
+static int bma_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	UNUSED(pdev);
+	UNUSED(state);
+
+	return 0;
+}
+
+static int bma_pci_resume(struct pci_dev *pdev)
+{
+	UNUSED(pdev);
+
+	return 0;
+}
+
+int __init bma_pci_init(void)
+{
+	int ret = 0;
+
+	BMA_LOG(DLOG_DEBUG, "\n");
+
+	ret = pci_register_driver(&bma_driver);
+	if (ret)
+		BMA_LOG(DLOG_ERROR, "pci_register_driver failed\n");
+
+	return ret;
+}
+
+void __exit bma_pci_cleanup(void)
+{
+	BMA_LOG(DLOG_DEBUG, "\n");
+
+	pci_unregister_driver(&bma_driver);
+}
+
+/*lint -e19*/
+MODULE_AUTHOR("HUAWEI TECHNOLOGIES CO., LTD.");
+MODULE_DESCRIPTION("HUAWEI EDMA DRIVER");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(BMA_VERSION);
+#ifndef _lint
+
+module_init(bma_pci_init);
+module_exit(bma_pci_cleanup);
+#endif
+/*lint +e19*/
diff --git a/drivers/net/ethernet/huawei/ibma/bma_pci.h b/drivers/net/ethernet/huawei/ibma/bma_pci.h
new file mode 100644
index 0000000..41bd4b7
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/bma_pci.h
@@ -0,0 +1,87 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _BMA_PCI_H_
+#define _BMA_PCI_H_
+
+#include "bma_devintf.h"
+#include "bma_include.h"
+
+#define EDMA_SWAP_BASE_OFFSET	0x10000
+
+#define HOSTRTC_REG_BASE	0x2f000000
+#define HOSTRTC_REG_SIZE	EDMA_SWAP_BASE_OFFSET
+
+#define EDMA_SWAP_DATA_BASE	0x84810000
+#define EDMA_SWAP_DATA_SIZE	65536
+
+#define VETH_SWAP_DATA_BASE	0x84820000
+#define VETH_SWAP_DATA_SIZE	0xdf000
+
+#define ATU_VIEWPORT		0x900
+#define	ATU_REGION_CTRL1	0x904
+#define ATU_REGION_CTRL2	0x908
+#define ATU_BASE_LOW		0x90C
+#define ATU_BASE_HIGH		0x910
+#define ATU_LIMIT		0x914
+#define	ATU_TARGET_LOW		0x918
+#define ATU_TARGET_HIGH		0x91C
+#define REGION_DIR_OUTPUT	(0x0 << 31)
+#define REGION_DIR_INPUT	(0x1 << 31)
+#define REGION_INDEX_MASK	0x7
+#define	REGION_ENABLE		(0x1 << 31)
+#define	ATU_CTRL1_DEFAULT	0x0
+struct bma_pci_dev_s {
+	unsigned long kbox_base_phy_addr;
+	void __iomem *kbox_base_addr;
+	unsigned long kbox_base_len;
+
+	unsigned long bma_base_phy_addr;
+	void __iomem *bma_base_addr;
+	unsigned long bma_base_len;
+
+	unsigned long hostrtc_phyaddr;
+	void __iomem *hostrtc_viraddr;
+
+	unsigned long edma_swap_phy_addr;
+	void __iomem *edma_swap_addr;
+	unsigned long edma_swap_len;
+
+	unsigned long veth_swap_phy_addr;
+	void __iomem *veth_swap_addr;
+	unsigned long veth_swap_len;
+
+	struct pci_dev *pdev;
+	struct bma_dev_s *bma_dev;
+};
+
+#ifdef DRV_VERSION
+#define BMA_VERSION MICRO_TO_STR(DRV_VERSION)
+#else
+#define BMA_VERSION "0.2.9"
+#endif
+
+extern int debug;
+
+#define BMA_LOG(level, fmt, args...) \
+	do { \
+		if (debug >= level)\
+			printk(KERN_ALERT "edma: %s, %d, " fmt, \
+				__func__, __LINE__, ## args); \
+	} while (0)
+
+int edmainfo_show(char *buff);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/ibma/edma_cmd.h b/drivers/net/ethernet/huawei/ibma/edma_cmd.h
new file mode 100644
index 0000000..d14804d
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/edma_cmd.h
@@ -0,0 +1,81 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _EDMA_CMD_H_
+#define _EDMA_CMD_H_
+
+#include <linux/types.h>
+
+/* direction */
+#define CMD_H2B		0x80000000	/* H2B */
+#define CMD_B2H		0x00000000	/* B2H */
+
+/* logic partition */
+#define CMD_LP			0x00000100
+#define CMD_H2B_LP_HEARTBEAT	(CMD_H2B | CMD_LP | 0x00000000)
+#define CMD_H2B_LP_DMA_TRANSFER	(CMD_H2B | CMD_LP | 0x00000002)
+#define CMD_B2H_LP_CONFIG	(CMD_B2H | CMD_LP | 0x00000004)
+#define CMD_B2H_LP_UPGRADE	(CMD_B2H | CMD_LP | 0x00000006)
+
+/* uograde */
+#define CMD_UPGRADE			0x00000200
+#define CMD_H2B_UPGRADE_DMA_TRANSFER	(CMD_H2B | CMD_UPGRADE | 0x00000000)
+
+/* ipmi */
+#define CMD_IPMI			0x00000300
+#define CMD_H2B_IPMI_CMD		(CMD_H2B | CMD_IPMI | 0x00000000)
+
+struct edma_msg_hdr_s {
+	u32 command;
+	u32 type;
+	u32 sub_type;
+	u32 msg_id;
+	u8 user_id;
+	u8 need_response;
+	u8 reserve1[2];
+	u32 datalen;
+	u32 reserve2[2];
+} __attribute__((packed));
+
+#define SIZE_OF_MSG_HDR (sizeof(struct edma_msg_hdr_s))
+
+struct edma_msg_resp_s {
+	struct edma_msg_hdr_s hdr;
+	u8 complete_code;
+	u8 reserve1[3];
+} __attribute__((packed));
+
+struct lp_heartbeat_msg_s {
+	struct edma_msg_hdr_s hdr;
+} __attribute__((packed));
+
+struct lp_dma_transfer_msg_s {
+	struct edma_msg_hdr_s hdr;
+	u32 dmadata_len;
+} __attribute__((packed));
+
+struct lp_config_msg_s {
+	struct edma_msg_hdr_s hdr;
+	u8 conf_data[0];
+} __attribute__((packed));
+
+struct lp_upgrade_msg_s {
+	struct edma_msg_hdr_s hdr;
+	u32 dmadata_len;
+	u32 cur_packet_num;
+	u32 total_packet_nums;
+} __attribute__((packed));
+
+#endif
diff --git a/drivers/net/ethernet/huawei/ibma/edma_host.c b/drivers/net/ethernet/huawei/ibma/edma_host.c
new file mode 100644
index 0000000..04ea816
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/edma_host.c
@@ -0,0 +1,1547 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/errno.h>
+#include <linux/kthread.h>
+#include <linux/mm.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
+#include "bma_pci.h"
+#include "edma_host.h"
+
+static struct edma_user_inft_s *g_user_func[TYPE_MAX] = { 0 };
+
+static struct bma_dev_s *g_bma_dev;
+static int edma_host_dma_interrupt(struct edma_host_s *edma_host);
+
+int edmainfo_show(char *buf)
+{
+	struct bma_user_s *user_ptr = NULL;
+	struct edma_host_s *host_ptr = NULL;
+	int len = 0;
+	__kernel_time_t running_time = 0;
+	static const char * const host_status[] = { "deregistered",
+								"registered",
+								"lost" };
+
+	if (!buf)
+		return 0;
+
+	if (!g_bma_dev) {
+		len += sprintf(buf, "EDMA IS NOT SUPPORTED");
+		return len;
+	}
+
+	host_ptr = &g_bma_dev->edma_host;
+
+	GET_SYS_SECONDS(running_time);
+	running_time -= host_ptr->statistics.init_time;
+	len += sprintf(buf + len,
+		    "============================EDMA_DRIVER_INFO============================\n");
+	len += sprintf(buf + len, "version      :" BMA_VERSION "\n");
+
+	len += sprintf(buf + len, "running_time :%luD %02lu:%02lu:%02lu\n",
+		    running_time / SECONDS_PER_DAY,
+		    running_time % SECONDS_PER_DAY / SECONDS_PER_HOUR,
+		    running_time % SECONDS_PER_HOUR / SECONDS_PER_MINUTE,
+		    running_time % SECONDS_PER_MINUTE);
+
+	len += sprintf(buf + len, "remote_status:%s\n",
+		    host_status[host_ptr->statistics.remote_status]);
+	len += sprintf(buf + len, "lost_count   :%d\n",
+		    host_ptr->statistics.lost_count);
+	len += sprintf(buf + len, "b2h_int      :%d\n",
+		    host_ptr->statistics.b2h_int);
+	len += sprintf(buf + len, "h2b_int      :%d\n",
+		    host_ptr->statistics.h2b_int);
+	len += sprintf(buf + len, "dma_count    :%d\n",
+		    host_ptr->statistics.dma_count);
+	len += sprintf(buf + len, "recv_bytes   :%d\n",
+		    host_ptr->statistics.recv_bytes);
+	len += sprintf(buf + len, "send_bytes   :%d\n",
+		    host_ptr->statistics.send_bytes);
+	len += sprintf(buf + len, "recv_pkgs    :%d\n",
+		    host_ptr->statistics.recv_pkgs);
+	len += sprintf(buf + len, "send_pkgs    :%d\n",
+		    host_ptr->statistics.send_pkgs);
+	len += sprintf(buf + len, "drop_pkgs    :%d\n",
+		    host_ptr->statistics.drop_pkgs);
+	len += sprintf(buf + len, "fail_count   :%d\n",
+		    host_ptr->statistics.failed_count);
+	len += sprintf(buf + len, "debug        :%d\n", debug);
+	len += sprintf(buf + len,
+		    "================================USER_INFO===============================\n");
+
+	list_for_each_entry_rcu(user_ptr, &(g_bma_dev->priv_list), link) {
+		len += sprintf(buf + len,
+			    "type: %d\nsub type: %d\nopen:%d\nmax recvmsg nums: %d\ncur recvmsg nums: %d\n",
+			    user_ptr->type, user_ptr->sub_type,
+			    host_ptr->local_open_status[user_ptr->type],
+			    user_ptr->max_recvmsg_nums,
+			    user_ptr->cur_recvmsg_nums);
+		len += sprintf(buf + len,
+			    "========================================================================\n");
+
+	}
+
+	return len;
+}
+
+
+
+int is_edma_b2h_int(struct edma_host_s *edma_host)
+{
+	struct notify_msg *pnm = NULL;
+
+	if (!edma_host)
+		return -1;
+
+	pnm = (struct notify_msg *)edma_host->edma_flag;
+	if (!pnm) {
+		BMA_LOG(DLOG_ERROR, "pnm is 0\n");
+		return -1;
+	}
+
+	if (IS_EDMA_B2H_INT(pnm->int_flag)) {
+		CLEAR_EDMA_B2H_INT(pnm->int_flag);
+		return 0;
+	}
+
+	return -1;
+}
+
+void edma_int_to_bmc(struct edma_host_s *edma_host)
+{
+	unsigned int data = 0;
+
+	if (!edma_host)
+		return;
+
+	edma_host->statistics.h2b_int++;
+
+	data = *(unsigned int *)((char *)edma_host->hostrtc_viraddr +
+				  HOSTRTC_INT_OFFSET);
+
+	data |= 0x00000001;
+
+	*(unsigned int *)((char *)edma_host->hostrtc_viraddr +
+			  HOSTRTC_INT_OFFSET) = data;
+}
+
+static void edma_host_int_to_bmc(struct edma_host_s *edma_host)
+{
+	struct notify_msg *pnm = NULL;
+
+	if (!edma_host)
+		return;
+
+	pnm = (struct notify_msg *)edma_host->edma_flag;
+	if (pnm) {
+		SET_EDMA_H2B_INT(pnm->int_flag);
+		edma_int_to_bmc(edma_host);
+	}
+}
+
+static int check_status_dmah2b(struct edma_host_s *edma_host)
+{
+	unsigned int data = 0;
+	struct pci_dev *pdev = NULL;
+
+	if (!edma_host)
+		return 0;
+
+	pdev = edma_host->pdev;
+	if (!pdev)
+		return 0;
+
+	(void)pci_read_config_dword(pdev, REG_PCIE1_DMAREAD_STATUS,
+				    (u32 *)&data);
+
+	if (data & (1 << SHIFT_PCIE1_DMAREAD_STATUS))
+		return 1;	/* ok */
+	else
+		return 0;	/* busy */
+}
+
+static int check_status_dmab2h(struct edma_host_s *edma_host)
+{
+	unsigned int data = 0;
+	struct pci_dev *pdev = NULL;
+
+	if (!edma_host)
+		return 0;
+
+	pdev = edma_host->pdev;
+	if (!pdev)
+		return 0;
+
+	(void)pci_read_config_dword(pdev, REG_PCIE1_DMAWRITE_STATUS,
+				    (u32 *)&data);
+
+	if (data & (1 << SHIFT_PCIE1_DMAWRITE_STATUS))
+		return 1;	/* ok */
+	else
+		return 0;	/* busy */
+}
+
+void clear_int_dmah2b(struct edma_host_s *edma_host)
+{
+	unsigned int data = 0;
+	struct pci_dev *pdev = NULL;
+
+	if (!edma_host)
+		return;
+
+	pdev = edma_host->pdev;
+	if (!pdev)
+		return;
+
+	(void)pci_read_config_dword(pdev, REG_PCIE1_DMAREADINT_CLEAR,
+				    (u32 *)&data);
+	data = data & (~((1 << SHIFT_PCIE1_DMAREADINT_CLEAR)));
+	data = data | (1 << SHIFT_PCIE1_DMAREADINT_CLEAR);
+	(void)pci_write_config_dword(pdev, REG_PCIE1_DMAREADINT_CLEAR, data);
+}
+
+void clear_int_dmab2h(struct edma_host_s *edma_host)
+{
+	unsigned int data = 0;
+	struct pci_dev *pdev = NULL;
+
+	if (!edma_host)
+		return;
+
+	pdev = edma_host->pdev;
+	if (!pdev)
+		return;
+
+	(void)pci_read_config_dword(pdev, REG_PCIE1_DMAWRITEINT_CLEAR,
+				    (u32 *)&data);
+	data = data & (~((1 << SHIFT_PCIE1_DMAWRITEINT_CLEAR)));
+	data = data | (1 << SHIFT_PCIE1_DMAWRITEINT_CLEAR);
+	(void)pci_write_config_dword(pdev, REG_PCIE1_DMAWRITEINT_CLEAR, data);
+}
+
+int edma_host_check_dma_status(enum dma_direction_e dir)
+{
+	int ret = 0;
+
+	switch (dir) {
+	case BMC_TO_HOST:
+		ret = check_status_dmab2h(&g_bma_dev->edma_host);
+		if (ret == 1)
+			clear_int_dmab2h(&g_bma_dev->edma_host);
+
+		break;
+
+	case HOST_TO_BMC:
+		ret = check_status_dmah2b(&g_bma_dev->edma_host);
+		if (ret == 1)
+			clear_int_dmah2b(&g_bma_dev->edma_host);
+
+		break;
+
+	default:
+		BMA_LOG(DLOG_ERROR, "direction failed, dir = %d\n", dir);
+		ret = -EFAULT;
+		break;
+	}
+
+	return ret;
+}
+
+#ifdef USE_DMA
+
+static int start_transfer_h2b(struct edma_host_s *edma_host, unsigned int len,
+			      unsigned int src_h, unsigned int src_l,
+			      unsigned int dst_h, unsigned int dst_l)
+{
+	unsigned long flags = 0;
+	struct pci_dev *pdev = edma_host->pdev;
+
+	spin_lock_irqsave(&edma_host->reg_lock, flags);
+	/*  read engine enable    */
+	(void)pci_write_config_dword(pdev, 0x99c, 0x00000001);
+	/*  read ch,ch index 0   */
+	(void)pci_write_config_dword(pdev, 0xa6c, 0x80000000);
+	/*  ch ctrl,local int enable */
+	(void)pci_write_config_dword(pdev, 0xa70, 0x00000008);
+	/*  size    */
+	(void)pci_write_config_dword(pdev, 0xa78, len);
+	/*  src lower 32b    */
+	(void)pci_write_config_dword(pdev, 0xa7c, src_l);
+	/*  src upper 32b    */
+	(void)pci_write_config_dword(pdev, 0xa80, src_h);
+	/*  dst lower 32b    */
+	(void)pci_write_config_dword(pdev, 0xa84, dst_l);
+	/*  dst upper 32b    */
+	(void)pci_write_config_dword(pdev, 0xa88, dst_h);
+	/*  start read dma,ch 0   */
+	(void)pci_write_config_dword(pdev, 0x9a0, 0x00000000);
+	spin_unlock_irqrestore(&edma_host->reg_lock, flags);
+	return 0;
+}
+
+static int start_transfer_b2h(struct edma_host_s *edma_host, unsigned int len,
+			      unsigned int src_h, unsigned int src_l,
+			      unsigned int dst_h, unsigned int dst_l)
+{
+	unsigned long flags = 0;
+	struct pci_dev *pdev = edma_host->pdev;
+
+	BMA_LOG(DLOG_DEBUG,
+		"len = 0x%8x,src_h = 0x%8x,src_l = 0x%8x,dst_h = 0x%8x,dst_l = 0x%8x\n",
+		len, src_h, src_l, dst_h, dst_l);
+
+	spin_lock_irqsave(&edma_host->reg_lock, flags);
+	/*  write engine enable    */
+	(void)pci_write_config_dword(pdev, 0x97c, 0x00000001);
+	/*  write ch,ch index 0   */
+	(void)pci_write_config_dword(pdev, 0xa6c, 0x00000000);
+	/*  ch ctrl,local int enable */
+	(void)pci_write_config_dword(pdev, 0xa70, 0x00000008);
+	/*  size    */
+	(void)pci_write_config_dword(pdev, 0xa78, len);
+	/*  src lower 32b    */
+	(void)pci_write_config_dword(pdev, 0xa7c, src_l);
+	/*  src upper 32b    */
+	(void)pci_write_config_dword(pdev, 0xa80, src_h);
+	/*  dst lower 32b    */
+	(void)pci_write_config_dword(pdev, 0xa84, dst_l);
+	/*  dst upper 32b    */
+	(void)pci_write_config_dword(pdev, 0xa88, dst_h);
+	/*  start write dma,ch 0   */
+	(void)pci_write_config_dword(pdev, 0x980, 0x00000000);
+	spin_unlock_irqrestore(&edma_host->reg_lock, flags);
+
+	return 0;
+}
+#endif
+
+static void start_listtransfer_h2b(struct edma_host_s *edma_host,
+				   unsigned int list_h, unsigned int list_l)
+{
+	unsigned long flags = 0;
+	struct pci_dev *pdev = NULL;
+
+	if (!edma_host)
+		return;
+
+	pdev = edma_host->pdev;
+	if (!pdev)
+		return;
+
+	spin_lock_irqsave(&edma_host->reg_lock, flags);
+
+	/*  write engine enable    */
+	(void)pci_write_config_dword(pdev, 0x700 + 0x29c, 0x00000001);
+	/*  write list err enable   */
+	(void)pci_write_config_dword(pdev, 0x700 + 0x334, 0x00010000);
+	/* (void)pci_write_config_dword(pdev, 0x700+0x334, 0x00000001); */
+	/*  write ch,ch index 0   */
+	(void)pci_write_config_dword(pdev, 0x700 + 0x36c, 0x80000000);
+	/*  ch ctrl,local int enable */
+	(void)pci_write_config_dword(pdev, 0x700 + 0x370, 0x00000300);
+	/*  list lower 32b    */
+	(void)pci_write_config_dword(pdev, 0x700 + 0x38c, list_l);
+	/*  list upper 32b    */
+	(void)pci_write_config_dword(pdev, 0x700 + 0x390, list_h);
+	/*  start write dma,ch 0   */
+	(void)pci_write_config_dword(pdev, 0x700 + 0x2a0, 0x00000000);
+
+	spin_unlock_irqrestore(&edma_host->reg_lock, flags);
+}
+
+static void start_listtransfer_b2h(struct edma_host_s *edma_host,
+				   unsigned int list_h, unsigned int list_l)
+{
+	unsigned long flags = 0;
+	struct pci_dev *pdev = NULL;
+
+	if (!edma_host)
+		return;
+
+	pdev = edma_host->pdev;
+	if (!pdev)
+		return;
+
+	spin_lock_irqsave(&edma_host->reg_lock, flags);
+
+	/*  write engine enable    */
+	(void)pci_write_config_dword(pdev, 0x700 + 0x27c, 0x00000001);
+	/*  write list err enable   */
+	(void)pci_write_config_dword(pdev, 0x700 + 0x300, 0x00000001);
+	/*  write ch,ch index 0   */
+	(void)pci_write_config_dword(pdev, 0x700 + 0x36c, 0x00000000);
+	/*  ch ctrl,local int enable */
+	(void)pci_write_config_dword(pdev, 0x700 + 0x370, 0x00000300);
+	/*  list lower 32b    */
+	(void)pci_write_config_dword(pdev, 0x700 + 0x38c, list_l);
+	/*  list upper 32b    */
+	(void)pci_write_config_dword(pdev, 0x700 + 0x390, list_h);
+	/*  start write dma,ch 0   */
+	(void)pci_write_config_dword(pdev, 0x700 + 0x280, 0x00000000);
+
+	spin_unlock_irqrestore(&edma_host->reg_lock, flags);
+}
+
+int edma_host_dma_start(struct edma_host_s *edma_host,
+			struct bma_priv_data_s *priv)
+{
+
+	struct bma_user_s *pUser = NULL;
+	struct bma_dev_s *bma_dev = NULL;
+	unsigned long flags = 0;
+
+	if (!edma_host || !priv)
+		return -EFAULT;
+
+	bma_dev = list_entry(edma_host, struct bma_dev_s, edma_host);
+
+	spin_lock_irqsave(&bma_dev->priv_list_lock, flags);
+
+	list_for_each_entry_rcu(pUser, &(bma_dev->priv_list), link) {
+		if (pUser->dma_transfer) {
+
+			spin_unlock_irqrestore(&bma_dev->priv_list_lock, flags);
+			BMA_LOG(DLOG_ERROR, "type = %d dma is started\n",
+				pUser->type);
+
+			return -EBUSY;
+		}
+	}
+
+	priv->user.dma_transfer = 1;
+
+	spin_unlock_irqrestore(&bma_dev->priv_list_lock, flags);
+
+	return 0;
+}
+
+#ifdef USE_DMA
+
+static int edma_host_dma_h2b(struct edma_host_s *edma_host,
+			     struct bma_dma_addr_s *host_addr,
+			     struct bma_dma_addr_s *bmc_addr)
+{
+	int ret = 0;
+	struct notify_msg *pnm = (struct notify_msg *)edma_host->edma_flag;
+	unsigned long host_h2b_addr = 0;
+	unsigned long bmc_h2b_addr = 0;
+	unsigned int bmc_h2b_size = 0;
+	unsigned int src_h, src_l, dst_h, dst_l;
+
+	if (!host_addr) {
+		BMA_LOG(DLOG_ERROR, "host_addr is NULL\n");
+		return -EFAULT;
+	}
+
+	BMA_LOG(DLOG_DEBUG, "host_addr->dma_addr = 0x%llx\n",
+		host_addr->dma_addr);
+
+	if (host_addr->dma_addr)
+		host_h2b_addr = (unsigned long)(host_addr->dma_addr);
+	else
+		host_h2b_addr = edma_host->h2b_addr.dma_addr;
+
+	bmc_h2b_addr = pnm->h2b_addr;
+	bmc_h2b_size = pnm->h2b_size;
+
+	BMA_LOG(DLOG_DEBUG,
+		"host_h2b_addr = 0x%lx, dma_data_len = %d, bmc_h2b_addr = 0x%lx, bmc_h2b_size = %d\n",
+		host_h2b_addr, host_addr->dma_data_len, bmc_h2b_addr,
+		bmc_h2b_size);
+
+	if ((host_addr->dma_data_len > EDMA_DMABUF_SIZE) || (bmc_h2b_addr == 0)
+	    || (host_addr->dma_data_len > bmc_h2b_size)) {
+		BMA_LOG(DLOG_ERROR,
+			"dma_data_len too large = %d, bmc_h2b_size = %d\n",
+			host_addr->dma_data_len, bmc_h2b_size);
+		return -EFAULT;
+	}
+
+	edma_host->h2b_state = H2BSTATE_WAITDMA;
+
+	src_h = (unsigned int)((sizeof(unsigned long) == 8) ?
+					(host_h2b_addr >> 32) : 0);
+	src_l = (unsigned int)(host_h2b_addr & 0xffffffff);
+	dst_h = (unsigned int)((sizeof(unsigned long) == 8) ?
+					(bmc_h2b_addr >> 32) : 0);
+	dst_l = (unsigned int)(bmc_h2b_addr & 0xffffffff);
+	(void)start_transfer_h2b(edma_host,
+		host_addr->dma_data_len, src_h,	/*lint !e506 !e572 */
+		src_l, dst_h, dst_l);	/*lint !e506 !e572 */
+
+
+	(void)mod_timer(&(edma_host->dma_timer),
+			jiffies_64 + TIMER_INTERVAL_CHECK);
+
+	ret = wait_event_interruptible_timeout(edma_host->wq_dmah2b,
+					     (edma_host->h2b_state ==
+					      H2BSTATE_IDLE),
+					     EDMA_DMA_TRANSFER_WAIT_TIMEOUT);
+
+	if (ret == -ERESTARTSYS) {
+		BMA_LOG(DLOG_ERROR, "eintr 1\n");
+		ret = -EINTR;
+		goto end;
+	} else if (ret == 0) {
+		BMA_LOG(DLOG_ERROR, "timeout 2\n");
+		ret = -ETIMEDOUT;
+		goto end;
+	} else {
+		ret = 0;
+		BMA_LOG(DLOG_ERROR, "h2b dma successful\n");
+	}
+
+end:
+
+	return ret;
+}
+
+static int edma_host_dma_b2h(struct edma_host_s *edma_host,
+			     struct bma_dma_addr_s *host_addr,
+			     struct bma_dma_addr_s *bmc_addr)
+{
+	int ret = 0;
+	struct notify_msg *pnm = (struct notify_msg *)edma_host->edma_flag;
+	unsigned long bmc_b2h_addr = 0;
+	unsigned long host_b2h_addr = 0;
+	unsigned int src_h, src_l, dst_h, dst_l;
+
+	if (!bmc_addr)
+		return -EFAULT;
+
+	if (host_addr->dma_addr)
+		host_b2h_addr = (unsigned long)(host_addr->dma_addr);
+	else
+		host_b2h_addr = edma_host->b2h_addr.dma_addr;
+
+	if (bmc_addr->dma_addr)
+		bmc_b2h_addr = (unsigned long)(bmc_addr->dma_addr);
+	else
+		bmc_b2h_addr = pnm->b2h_addr;
+
+	BMA_LOG(DLOG_DEBUG,
+		"bmc_b2h_addr = 0x%lx, host_b2h_addr = 0x%lx, dma_data_len = %d\n",
+		bmc_b2h_addr, host_b2h_addr, bmc_addr->dma_data_len);
+
+	if ((bmc_addr->dma_data_len > EDMA_DMABUF_SIZE)
+	    || (bmc_addr->dma_data_len > edma_host->b2h_addr.len)) {
+		BMA_LOG(DLOG_ERROR,
+			"dma_data_len too large = %d, b2h_addr = %d\n",
+			host_addr->dma_data_len, edma_host->b2h_addr.len);
+		return -EFAULT;
+	}
+
+	edma_host->b2h_state = B2HSTATE_WAITDMA;
+
+	src_h = (unsigned int)((sizeof(unsigned long) == 8) ?
+					(bmc_b2h_addr >> 32) : 0);
+	src_l = (unsigned int)(bmc_b2h_addr & 0xffffffff);
+	dst_h = (unsigned int)((sizeof(unsigned long) == 8) ?
+					(host_b2h_addr >> 32) : 0);
+	dst_l = (unsigned int)(host_b2h_addr & 0xffffffff);
+	(void)start_transfer_b2h(edma_host,
+		bmc_addr->dma_data_len, src_h,	/*lint !e506 !e572 */
+		src_l, dst_h, dst_l);	/*lint !e506 !e572 */
+
+	(void)mod_timer(&(edma_host->dma_timer),
+			jiffies_64 + TIMER_INTERVAL_CHECK);
+
+	ret = wait_event_interruptible_timeout(edma_host->wq_dmab2h,
+					     (edma_host->b2h_state ==
+					      B2HSTATE_IDLE),
+					     EDMA_DMA_TRANSFER_WAIT_TIMEOUT);
+
+	if (ret == -ERESTARTSYS) {
+		BMA_LOG(DLOG_ERROR, "eintr 1\n");
+		ret = -EINTR;
+		goto end;
+	} else if (ret == 0) {
+		BMA_LOG(DLOG_ERROR, "timeout 2\n");
+		ret = -ETIMEDOUT;
+		goto end;
+	} else {
+		BMA_LOG(DLOG_DEBUG, "h2b dma successful\n");
+	}
+
+end:
+
+	return ret;
+}
+#endif
+
+int edma_host_dma_transfer(struct edma_host_s *edma_host,
+			   struct bma_priv_data_s *priv,
+			   struct bma_dma_transfer_s *dma_transfer)
+{
+
+	int ret = 0;
+	unsigned long flags = 0;
+	struct bma_dev_s *bma_dev = NULL;
+
+	if (!edma_host || !priv || !dma_transfer)
+		return -EFAULT;
+
+	bma_dev = list_entry(edma_host, struct bma_dev_s, edma_host);
+
+	spin_lock_irqsave(&bma_dev->priv_list_lock, flags);
+
+	if (priv->user.dma_transfer == 0) {
+		spin_unlock_irqrestore(&bma_dev->priv_list_lock, flags);
+		BMA_LOG(DLOG_ERROR, "dma_transfer = %hhd\n",
+			priv->user.dma_transfer);
+		return -EFAULT;
+	}
+
+	spin_unlock_irqrestore(&bma_dev->priv_list_lock, flags);
+
+	edma_host->statistics.dma_count++;
+
+	if (dma_transfer->type == DMA_NOT_LIST) {
+#ifdef USE_DMA
+		switch (dma_transfer->dir) {
+		case BMC_TO_HOST:
+			ret = edma_host_dma_b2h(edma_host,
+				&(dma_transfer->transfer.nolist.host_addr),
+				&(dma_transfer->transfer.nolist.bmc_addr));
+			break;
+
+		case HOST_TO_BMC:
+			ret = edma_host_dma_h2b(edma_host,
+				&(dma_transfer->transfer.nolist.host_addr),
+				&(dma_transfer->transfer.nolist.bmc_addr));
+			break;
+
+		default:
+			BMA_LOG(DLOG_ERROR, "direction failed, dir = %d\n",
+				dma_transfer->dir);
+			ret = -EFAULT;
+			break;
+		}
+
+#endif
+	} else if (dma_transfer->type == DMA_LIST) {
+		unsigned int list_h;
+		unsigned int list_l;
+
+		list_h = (unsigned int)((sizeof(unsigned long) == 8) ?
+			(dma_transfer->transfer.list.dma_addr >> 32)
+			: 0);/*lint !e506 !e572 */
+		list_l = (unsigned int)(dma_transfer->transfer.list.dma_addr
+					& 0xffffffff);
+
+		switch (dma_transfer->dir) {
+		case BMC_TO_HOST:
+			start_listtransfer_b2h(edma_host, list_h, list_l);
+
+			break;
+
+		case HOST_TO_BMC:
+			start_listtransfer_h2b(edma_host, list_h, list_l);
+
+			break;
+
+		default:
+			BMA_LOG(DLOG_ERROR, "direction failed, dir = %d\n\n",
+				dma_transfer->dir);
+			ret = -EFAULT;
+			break;
+		}
+	} else {
+		BMA_LOG(DLOG_ERROR, "type failed! type = %d\n",
+			dma_transfer->type);
+		return -EFAULT;
+	}
+
+	return ret;
+}
+
+void edma_host_reset_dma(struct edma_host_s *edma_host, int dir)
+{
+	u32 data = 0;
+	u32 reg_addr = 0;
+	unsigned long flags = 0;
+	int count = 0;
+	struct pci_dev *pdev = NULL;
+
+	if (!edma_host)
+		return;
+
+	pdev = edma_host->pdev;
+	if (!pdev)
+		return;
+
+	if (dir == BMC_TO_HOST)
+		reg_addr = REG_PCIE1_DMA_READ_ENGINE_ENABLE;
+	else if (dir == HOST_TO_BMC)
+		reg_addr = REG_PCIE1_DMA_WRITE_ENGINE_ENABLE;
+	else
+		return;
+
+	spin_lock_irqsave(&edma_host->reg_lock, flags);
+
+	(void)pci_read_config_dword(pdev, reg_addr, &data);
+	data &= ~(1 << SHIFT_PCIE1_DMA_ENGINE_ENABLE);
+	(void)pci_write_config_dword(pdev, reg_addr, data);
+
+	while (count++ < 10) {
+		(void)pci_read_config_dword(pdev, reg_addr, &data);
+
+		if (0 == (data & (1 << SHIFT_PCIE1_DMA_ENGINE_ENABLE))) {
+			BMA_LOG(DLOG_DEBUG, "reset dma succesfull\n");
+			break;
+		}
+
+		mdelay(100);
+	}
+
+	spin_unlock_irqrestore(&edma_host->reg_lock, flags);
+	BMA_LOG(DLOG_DEBUG, "reset dma reg_addr=0x%x count=%d data=0x%08x\n",
+		reg_addr, count, data);
+
+}
+
+int edma_host_dma_stop(struct edma_host_s *edma_host,
+		       struct bma_priv_data_s *priv)
+{
+
+	unsigned long flags = 0;
+	struct bma_dev_s *bma_dev = NULL;
+
+	if (!edma_host || !priv)
+		return -1;
+
+	bma_dev = list_entry(edma_host, struct bma_dev_s, edma_host);
+
+	spin_lock_irqsave(&bma_dev->priv_list_lock, flags);
+	priv->user.dma_transfer = 0;
+	spin_unlock_irqrestore(&bma_dev->priv_list_lock, flags);
+
+	return 0;
+}
+
+static int edma_host_send_msg(struct edma_host_s *edma_host)
+{
+	void *vaddr = NULL;
+	unsigned long flags = 0;
+	struct edma_mbx_hdr_s *send_mbx_hdr = NULL;
+	static unsigned long last_timer_record;
+
+	if (!edma_host)
+		return 0;
+
+	send_mbx_hdr = (struct edma_mbx_hdr_s *)edma_host->edma_send_addr;
+
+	if (send_mbx_hdr->mbxlen > 0) {
+		if (send_mbx_hdr->mbxlen > HOST_MAX_SEND_MBX_LEN) {
+			/*share memory is disable */
+			send_mbx_hdr->mbxlen = 0;
+			BMA_LOG(DLOG_ERROR, "mbxlen is too long\n");
+			return -EFAULT;
+		}
+
+		if (time_after(jiffies, last_timer_record + 10 * HZ)) {
+			BMA_LOG(DLOG_ERROR, "no response in 10s,clean msg\n");
+			edma_host->statistics.failed_count++;
+			send_mbx_hdr->mbxlen = 0;
+			return -EFAULT;
+		}
+
+		BMA_LOG(DLOG_DEBUG,
+			"still have msg : mbxlen: %d, msg_send_write: %d\n",
+			send_mbx_hdr->mbxlen, edma_host->msg_send_write);
+
+		/*  resend door bell */
+		if (time_after(jiffies, last_timer_record + 5 * HZ))
+			edma_host_int_to_bmc(edma_host);
+
+		return -EFAULT;
+	}
+
+	vaddr =
+		(void *)((unsigned char *)edma_host->edma_send_addr +
+			 SIZE_OF_MBX_HDR);
+
+	last_timer_record = jiffies;
+
+	spin_lock_irqsave(&(edma_host->send_msg_lock), flags);
+
+	if (edma_host->msg_send_write == 0) {
+		spin_unlock_irqrestore(&(edma_host->send_msg_lock),
+					   flags);
+		return 0;
+	}
+
+	if (EOK !=
+		memcpy_s(vaddr, HOST_MAX_SEND_MBX_LEN - SIZE_OF_MBX_HDR,
+			 edma_host->msg_send_buf,
+			 edma_host->msg_send_write)) {
+		BMA_LOG(DLOG_ERROR, "memcpy_s error,len=%d\n",
+			edma_host->msg_send_write);
+		edma_host->msg_send_write = 0;
+		spin_unlock_irqrestore(&(edma_host->send_msg_lock),
+					   flags);
+		return 0;
+	}
+
+	send_mbx_hdr->mbxlen = edma_host->msg_send_write;
+	edma_host->msg_send_write = 0;
+
+	spin_unlock_irqrestore(&(edma_host->send_msg_lock), flags);
+
+	edma_host_int_to_bmc(edma_host);
+
+	BMA_LOG(DLOG_DEBUG,
+		"vaddr: %p, mbxlen : %d, msg_send_write: %d\n", vaddr,
+		send_mbx_hdr->mbxlen, edma_host->msg_send_write);
+
+	return -EAGAIN;
+}
+
+#ifdef EDMA_TIMER
+
+static void edma_host_timeout(unsigned long data)
+{
+	int ret = 0;
+	unsigned long flags = 0;
+	struct edma_host_s *edma_host = (struct edma_host_s *)data;
+
+	ret = edma_host_send_msg(edma_host);
+	if (ret < 0) {
+		spin_lock_irqsave(&g_bma_dev->edma_host.send_msg_lock, flags);
+		(void)mod_timer(&(edma_host->timer),
+				jiffies_64 + TIMER_INTERVAL_CHECK);
+		spin_unlock_irqrestore(&edma_host->send_msg_lock, flags);
+	}
+}
+
+static void edma_host_heartbeat_timer(unsigned long data)
+{
+	static unsigned int bmc_heartbeat_count;
+	struct edma_host_s *edma_host = (struct edma_host_s *)data;
+	unsigned int remote_status = edma_host->statistics.remote_status;
+	struct notify_msg *pnm = (struct notify_msg *)edma_host->edma_flag;
+
+	if (pnm) {
+		if (pnm->bmc_registered) {
+			if ((pnm->host_heartbeat & 7) == 0) {
+				if (bmc_heartbeat_count != pnm->bmc_heartbeat) {
+					if (remote_status != REGISTERED) {
+						BMA_LOG(DLOG_DEBUG,
+							"bmc is registered\n");
+						edma_host->statistics.remote_status = REGISTERED;
+
+					}
+
+					bmc_heartbeat_count = pnm->bmc_heartbeat;
+				} else {
+					if (remote_status == REGISTERED) {
+						edma_host->statistics.remote_status = LOST;
+						edma_host->statistics.lost_count++;
+						BMA_LOG(DLOG_DEBUG,
+							"bmc is lost\n");
+					}
+				}
+			}
+		} else {
+			if (edma_host->statistics.remote_status == REGISTERED)
+				BMA_LOG(DLOG_DEBUG, "bmc is deregistered\n");
+
+			edma_host->statistics.remote_status = DEREGISTERED;
+		}
+
+		pnm->host_heartbeat++;
+	}
+
+	(void)mod_timer(&edma_host->heartbeat_timer,
+			jiffies_64 + HEARTBEAT_TIMER_INTERVAL_CHECK);
+}
+
+#ifdef USE_DMA
+
+static void edma_host_dma_timeout(unsigned long data)
+{
+	int ret = 0;
+	struct edma_host_s *edma_host = (struct edma_host_s *)data;
+
+	ret = edma_host_dma_interrupt(edma_host);
+	if (ret < 0)
+		(void)mod_timer(&(edma_host->dma_timer),
+				jiffies_64 + DMA_TIMER_INTERVAL_CHECK);
+}
+#endif
+#else
+
+static int edma_host_thread(void *arg)
+{
+	struct edma_host_s *edma_host = (struct edma_host_s *)arg;
+
+	BMA_LOG(DLOG_ERROR, "edma host thread\n");
+
+	while (!kthread_should_stop()) {
+		wait_for_completion_interruptible_timeout(&edma_host->msg_ready,
+							1 * HZ);
+		edma_host_send_msg(edma_host);
+		(void)edma_host_dma_interrupt(edma_host);
+	}
+
+	BMA_LOG(DLOG_ERROR, "edma host thread exiting\n");
+
+	return 0;
+}
+
+#endif
+
+int edma_host_send_driver_msg(void *msg, size_t msg_len, int subtype)
+{
+	int ret = 0;
+	unsigned long flags = 0;
+	struct edma_host_s *edma_host = NULL;
+	struct edma_msg_hdr_s *hdr = NULL;
+	int total_len = msg_len + SIZE_OF_MSG_HDR;
+
+	if (!msg || !g_bma_dev)
+		return -1;
+
+	edma_host = &g_bma_dev->edma_host;
+	if (!edma_host)
+		return -1;
+
+	spin_lock_irqsave(&(edma_host->send_msg_lock), flags);
+
+	if (edma_host->msg_send_write + total_len <=
+	    (HOST_MAX_SEND_MBX_LEN - SIZE_OF_MBX_HDR)) {
+		hdr = (struct edma_msg_hdr_s *)(edma_host->msg_send_buf +
+					      edma_host->msg_send_write);
+		hdr->type = TYPE_EDMA_DRIVER;
+		hdr->sub_type = subtype;
+		hdr->datalen = msg_len;
+
+		(void)memcpy_s(hdr->data,
+			       HOST_MAX_SEND_MBX_LEN - SIZE_OF_MBX_HDR -
+			       edma_host->msg_send_write - SIZE_OF_MSG_HDR, msg,
+			       msg_len);
+
+		edma_host->msg_send_write += total_len;
+
+		spin_unlock_irqrestore(&(edma_host->send_msg_lock), flags);
+
+		(void)mod_timer(&(edma_host->timer), jiffies_64);
+		BMA_LOG(DLOG_DEBUG, "msg_send_write = %d\n",
+			edma_host->msg_send_write);
+	} else {
+		ret = -ENOSPC;
+		spin_unlock_irqrestore(&(edma_host->send_msg_lock), flags);
+
+		BMA_LOG(DLOG_DEBUG,
+			"msg lost,msg_send_write: %d,msg_len:%d,max_len: %d\n",
+			edma_host->msg_send_write, total_len,
+			HOST_MAX_SEND_MBX_LEN);
+	}
+
+	return ret;
+}
+
+static int edma_host_insert_recv_msg(struct edma_host_s *edma_host,
+				     struct edma_msg_hdr_s *msg_header)
+{
+	unsigned long flags = 0, msg_flags = 0;
+	struct bma_dev_s *bma_dev = NULL;
+	struct bma_priv_data_s *priv = NULL;
+	struct bma_user_s *pUser = NULL;
+	struct list_head *entry = NULL;
+	struct edma_recv_msg_s *msg_tmp = NULL;
+	struct bma_user_s usertmp = { };
+	struct edma_recv_msg_s *recv_msg = NULL;
+
+	if (!edma_host || !msg_header
+	    || msg_header->datalen > CDEV_MAX_WRITE_LEN) {
+		return -EFAULT;
+	}
+
+	bma_dev = list_entry(edma_host, struct bma_dev_s, edma_host);
+
+	recv_msg = kmalloc(sizeof(*recv_msg) + msg_header->datalen,
+						GFP_ATOMIC); /*lint !e64*/
+	if (!recv_msg) {
+		BMA_LOG(DLOG_ERROR, "malloc recv_msg failed\n");
+		return -ENOMEM;
+	}
+
+	recv_msg->msg_len = msg_header->datalen;
+	(void)memcpy_s(recv_msg->msg_data, msg_header->datalen,
+		       msg_header->data, msg_header->datalen);
+
+	spin_lock_irqsave(&bma_dev->priv_list_lock, flags);
+	list_for_each_entry_rcu(pUser, &(bma_dev->priv_list), link) {
+
+		if ((pUser->type != msg_header->type)
+		|| (pUser->sub_type != msg_header->sub_type))
+			continue;
+
+		priv = list_entry(pUser, struct bma_priv_data_s, user);
+
+		(void)memcpy_s(&usertmp, sizeof(struct bma_user_s),
+			       pUser, sizeof(struct bma_user_s));
+
+		spin_lock_irqsave(&priv->recv_msg_lock, msg_flags);
+
+		if ((pUser->cur_recvmsg_nums >= pUser->max_recvmsg_nums)
+		|| (pUser->cur_recvmsg_nums >= MAX_RECV_MSG_NUMS)) {
+
+			entry = priv->recv_msgs.next;
+			msg_tmp =
+			    list_entry(entry, struct edma_recv_msg_s,
+				       link);
+			list_del(entry);
+			pUser->cur_recvmsg_nums--;
+			kfree(msg_tmp);
+		}
+
+		if (edma_host->local_open_status[pUser->type]
+			== DEV_OPEN) {
+			list_add_tail(&recv_msg->link, &priv->recv_msgs);
+			pUser->cur_recvmsg_nums++;
+			usertmp.cur_recvmsg_nums =
+			    pUser->cur_recvmsg_nums;
+			spin_unlock_irqrestore(&priv->recv_msg_lock,
+					       msg_flags);
+
+		} else {
+			spin_unlock_irqrestore(&priv->recv_msg_lock,
+					       msg_flags);
+			break;
+		}
+
+		wake_up_interruptible(&(priv->wait));
+		spin_unlock_irqrestore(&bma_dev->priv_list_lock, flags);
+
+		BMA_LOG(DLOG_DEBUG,
+			"find user, type = %d, sub_type = %d, user_id = %d, insert msg\n",
+			usertmp.type, usertmp.sub_type,
+			usertmp.user_id);
+		BMA_LOG(DLOG_DEBUG,
+			"msg_len = %d, cur_recvmsg_nums: %d, max_recvmsg_nums: %d\n",
+			recv_msg->msg_len, usertmp.cur_recvmsg_nums,
+			usertmp.max_recvmsg_nums);
+
+		return 0;
+	}
+
+	spin_unlock_irqrestore(&bma_dev->priv_list_lock, flags);
+	kfree(recv_msg);
+	edma_host->statistics.drop_pkgs++;
+	BMA_LOG(DLOG_DEBUG,
+		"insert msg failed! not find user, type = %d, sub_type = %d\n",
+		msg_header->type, msg_header->sub_type);
+
+	return -EFAULT;
+}
+
+int edma_host_recv_msg(struct edma_host_s *edma_host,
+		       struct bma_priv_data_s *priv,
+		       struct edma_recv_msg_s **msg)
+{
+	unsigned long flags = 0;
+	struct list_head *entry = NULL;
+	struct edma_recv_msg_s *msg_tmp = NULL;
+	struct bma_dev_s *bma_dev = NULL;
+
+	if (!edma_host || !priv || !msg)
+		return -EAGAIN;
+
+	bma_dev = list_entry(edma_host, struct bma_dev_s, edma_host);
+
+	spin_lock_irqsave(&bma_dev->priv_list_lock, flags);
+
+	if (list_empty(&priv->recv_msgs)) {
+		priv->user.cur_recvmsg_nums = 0;
+		spin_unlock_irqrestore(&bma_dev->priv_list_lock, flags);
+		BMA_LOG(DLOG_DEBUG, "recv msgs empty\n");
+		return -EAGAIN;
+	}
+
+	entry = priv->recv_msgs.next;
+	msg_tmp = list_entry(entry, struct edma_recv_msg_s, link);
+	list_del(entry);
+
+	if (priv->user.cur_recvmsg_nums > 0)
+		priv->user.cur_recvmsg_nums--;
+
+	spin_unlock_irqrestore(&bma_dev->priv_list_lock, flags);
+
+	*msg = msg_tmp;
+
+	BMA_LOG(DLOG_DEBUG, "msg->msg_len = %d\n", (int)msg_tmp->msg_len);
+
+	return 0;
+}
+
+static int edma_host_msg_process(struct edma_host_s *edma_host,
+				 struct edma_msg_hdr_s *msg_header)
+{
+	struct bma_user_s *user_ptr = NULL;
+	char drv_msg[TYPE_MAX * 2 + 1] = { 0 };
+
+	if (!edma_host || !msg_header)
+		return 0;
+
+	if (msg_header->type != TYPE_EDMA_DRIVER)
+		return -1;
+
+	if (msg_header->sub_type != DEV_OPEN_STATUS_REQ)
+		return 0;
+
+
+	list_for_each_entry_rcu(user_ptr, &(g_bma_dev->priv_list), link) {
+		drv_msg[drv_msg[0] * 2 + 1] = user_ptr->type;
+		drv_msg[drv_msg[0] * 2 + 2] =
+		    edma_host->local_open_status[user_ptr->type];
+		BMA_LOG(DLOG_DEBUG,
+			"send DEV_OPEN_STATUS_ANS index=%d type=%d status=%d\n",
+			drv_msg[0], drv_msg[drv_msg[0] * 2 + 1],
+			drv_msg[drv_msg[0] * 2 + 2]);
+		drv_msg[0]++;
+
+	}
+
+	if (drv_msg[0]) {
+		(void)edma_host_send_driver_msg((void *)drv_msg,
+						drv_msg[0] * 2 +
+						1,
+						DEV_OPEN_STATUS_ANS);
+		BMA_LOG(DLOG_DEBUG,
+			"send DEV_OPEN_STATUS_ANS %d\n",
+			drv_msg[0]);
+	}
+
+	return 0;
+}
+
+void edma_host_isr_tasklet(unsigned long data)
+{
+	int result = 0;
+	u16 len = 0;
+	u16 off = 0;
+	u16 msg_cnt = 0;
+	struct edma_mbx_hdr_s *recv_mbx_hdr = NULL;
+	struct edma_host_s *edma_host = (struct edma_host_s *)data;
+	struct edma_msg_hdr_s *msg_header = NULL;
+	unsigned char *ptr = NULL;
+
+	if (!edma_host)
+		return;
+
+	recv_mbx_hdr = (struct edma_mbx_hdr_s *)(edma_host->edma_recv_addr);
+	msg_header =
+		(struct edma_msg_hdr_s *)((char *)(edma_host->edma_recv_addr) +
+				SIZE_OF_MBX_HDR + recv_mbx_hdr->mbxoff);
+
+	off = readw((unsigned char *)edma_host->edma_recv_addr
+			+ EDMA_B2H_INT_FLAG);
+	len = readw((unsigned char *)edma_host->edma_recv_addr) - off;
+
+	BMA_LOG(DLOG_DEBUG,
+		" edma_host->edma_recv_addr = %p, len = %d, off = %d, mbxlen = %d\n",
+		edma_host->edma_recv_addr, len, off, recv_mbx_hdr->mbxlen);
+	edma_host->statistics.recv_bytes += (recv_mbx_hdr->mbxlen - off);
+
+	if (len == 0) {
+		writel(0, (void *)(edma_host->edma_recv_addr));
+		return;
+	}
+
+	while (recv_mbx_hdr->mbxlen - off) {
+		if (len == 0) {
+			BMA_LOG(DLOG_DEBUG, " recieve done\n");
+			break;
+		}
+
+		if (len < (SIZE_OF_MSG_HDR + msg_header->datalen)) {
+			BMA_LOG(DLOG_ERROR, " len too less, is %d\n", len);
+			break;
+		}
+
+		edma_host->statistics.recv_pkgs++;
+
+		if (edma_host_msg_process(edma_host, msg_header) == -1) {
+			result = edma_host_insert_recv_msg(edma_host,
+							   msg_header);
+			if (result < 0)
+				BMA_LOG(DLOG_DEBUG,
+					"edma_host_insert_recv_msg failed\n");
+		}
+
+		BMA_LOG(DLOG_DEBUG, "len = %d\n", len);
+		BMA_LOG(DLOG_DEBUG, "off = %d\n", off);
+		len -= (msg_header->datalen + SIZE_OF_MSG_HDR);
+		BMA_LOG(DLOG_DEBUG,
+			"msg_header->datalen = %d, SIZE_OF_MSG_HDR=%d\n",
+			msg_header->datalen, (int)SIZE_OF_MSG_HDR);
+		off += (msg_header->datalen + SIZE_OF_MSG_HDR);
+
+		msg_cnt++;
+
+		ptr = (unsigned char *)msg_header;
+		msg_header = (struct edma_msg_hdr_s *)(ptr +
+					      (msg_header->datalen +
+					       SIZE_OF_MSG_HDR));
+
+		if (msg_cnt > 2) {
+			recv_mbx_hdr->mbxoff = off;
+			BMA_LOG(DLOG_DEBUG, "len = %d\n", len);
+			BMA_LOG(DLOG_DEBUG, "off = %d\n", off);
+			BMA_LOG(DLOG_DEBUG, "off works\n");
+
+			tasklet_hi_schedule(&(edma_host->tasklet));
+
+			break;
+		}
+
+		if (!len) {
+			writel(0, (void *)(edma_host->edma_recv_addr));
+			recv_mbx_hdr->mbxoff = 0;
+		}
+	}
+}
+
+static int edma_host_dma_interrupt(struct edma_host_s *edma_host)
+{
+	if (!edma_host)
+		return 0;
+
+	if (check_status_dmah2b(edma_host)) {
+		clear_int_dmah2b(edma_host);
+
+		edma_host->h2b_state = H2BSTATE_IDLE;
+		wake_up_interruptible(&edma_host->wq_dmah2b);
+		return 0;
+	}
+
+	if (check_status_dmab2h(edma_host)) {
+		clear_int_dmab2h(edma_host);
+
+		edma_host->b2h_state = B2HSTATE_IDLE;
+		wake_up_interruptible(&edma_host->wq_dmab2h);
+
+		return 0;
+	}
+
+	return -EAGAIN;
+}
+
+irqreturn_t edma_host_irq_handle(struct edma_host_s *edma_host)
+{
+	if (edma_host) {
+		(void)edma_host_dma_interrupt(edma_host);
+
+		tasklet_hi_schedule(&(edma_host->tasklet));
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int edma_host_malloc_dma_buf(struct bma_dev_s *bma_dev)
+{
+	void *vphys = NULL;
+	dma_addr_t dma_addr = 0;
+	struct edma_host_s *edma_host = NULL;
+
+	if (!bma_dev)
+		return -EFAULT;
+
+	edma_host = &(bma_dev->edma_host);
+
+	(void)memset_s(&(edma_host->h2b_addr), sizeof(edma_host->h2b_addr),
+		       0, sizeof(edma_host->h2b_addr));
+	(void)memset_s(&(edma_host->b2h_addr), sizeof(edma_host->h2b_addr),
+		       0, sizeof(edma_host->h2b_addr));
+
+	vphys = pci_alloc_consistent(bma_dev->bma_pci_dev->pdev,
+				     EDMA_DMABUF_SIZE, &dma_addr);
+	if (!vphys) {
+		BMA_LOG(DLOG_ERROR, "pci_alloc_consistent h2b error\n");
+		return -ENOMEM;
+	}
+
+	edma_host->h2b_addr.kvaddr = vphys;
+	edma_host->h2b_addr.dma_addr = dma_addr;
+	edma_host->h2b_addr.len = EDMA_DMABUF_SIZE;
+
+	BMA_LOG(DLOG_DEBUG, "h2b - kvaddr = %p, dma_addr = 0x%llx, len = %d\n",
+		vphys, dma_addr, EDMA_DMABUF_SIZE);
+
+	vphys = pci_alloc_consistent(bma_dev->bma_pci_dev->pdev,
+				     EDMA_DMABUF_SIZE, &dma_addr);
+
+	if (!vphys) {
+		BMA_LOG(DLOG_ERROR, "pci_alloc_consistent b2h error\n");
+		pci_free_consistent(edma_host->pdev,
+				    edma_host->h2b_addr.len,
+				    edma_host->h2b_addr.kvaddr,
+				    edma_host->h2b_addr.dma_addr);
+		edma_host->h2b_addr.kvaddr = NULL;
+		edma_host->h2b_addr.dma_addr = 0;
+		edma_host->h2b_addr.len = 0;
+		return -ENOMEM;
+	}
+
+	edma_host->b2h_addr.kvaddr = vphys;
+	edma_host->b2h_addr.dma_addr = dma_addr;
+	edma_host->b2h_addr.len = EDMA_DMABUF_SIZE;
+
+	BMA_LOG(DLOG_DEBUG, "b2h - kvaddr = %p, dma_addr = 0x%llx, len = %d\n",
+		vphys, dma_addr, EDMA_DMABUF_SIZE);
+	return 0;
+}
+
+static void edma_host_free_dma_buf(struct bma_dev_s *bma_dev)
+{
+	struct edma_host_s *edma_host = NULL;
+
+	if (!bma_dev)
+		return;
+
+	edma_host = &bma_dev->edma_host;
+
+	if (edma_host->h2b_addr.kvaddr) {
+		BMA_LOG(DLOG_DEBUG,
+			"free h2b_addr dma mem, vphys: %p, dma_addr: 0x%llx\n",
+			edma_host->h2b_addr.kvaddr,
+			edma_host->h2b_addr.dma_addr);
+
+		pci_free_consistent(edma_host->pdev,
+				    edma_host->h2b_addr.len,
+				    edma_host->h2b_addr.kvaddr,
+				    edma_host->h2b_addr.dma_addr);
+
+		edma_host->h2b_addr.kvaddr = NULL;
+		edma_host->h2b_addr.dma_addr = 0;
+		edma_host->h2b_addr.len = 0;
+	}
+
+	if (edma_host->b2h_addr.kvaddr) {
+		BMA_LOG(DLOG_DEBUG,
+			"free b2h_addr dma mem, vphys: %p, dma_addr: 0x%llx\n",
+			edma_host->b2h_addr.kvaddr,
+			edma_host->b2h_addr.dma_addr);
+
+		pci_free_consistent(edma_host->pdev,
+				    edma_host->b2h_addr.len,
+				    edma_host->b2h_addr.kvaddr,
+				    edma_host->b2h_addr.dma_addr);
+
+		edma_host->b2h_addr.kvaddr = NULL;
+		edma_host->b2h_addr.dma_addr = 0;
+		edma_host->b2h_addr.len = 0;
+	}
+}
+
+struct edma_user_inft_s *edma_host_get_user_inft(u32 type)
+{
+	if (type >= TYPE_MAX) {
+		BMA_LOG(DLOG_ERROR, "type error %d\n", type);
+		return NULL;
+	}
+
+	return g_user_func[type];
+}
+
+int edma_host_user_register(u32 type, struct edma_user_inft_s *func)
+{
+	if (type >= TYPE_MAX) {
+		BMA_LOG(DLOG_ERROR, "type error %d\n", type);
+		return -EFAULT;
+	}
+
+	if (!func) {
+		BMA_LOG(DLOG_ERROR, "func is NULL\n");
+		return -EFAULT;
+	}
+
+	g_user_func[type] = func;
+
+	return 0;
+}
+
+int edma_host_user_unregister(u32 type)
+{
+	if (type >= TYPE_MAX) {
+		BMA_LOG(DLOG_ERROR, "type error %d\n", type);
+		return -EFAULT;
+	}
+
+	g_user_func[type] = NULL;
+
+	return 0;
+}
+
+int edma_host_init(struct edma_host_s *edma_host)
+{
+	int ret = 0;
+	struct bma_dev_s *bma_dev = NULL;
+	struct notify_msg *pnm = NULL;
+
+	if (!edma_host)
+		return -1;
+
+	bma_dev = list_entry(edma_host, struct bma_dev_s, edma_host);
+	g_bma_dev = bma_dev;
+
+	edma_host->pdev = bma_dev->bma_pci_dev->pdev;
+
+#ifdef EDMA_TIMER
+	setup_timer(&edma_host->timer, edma_host_timeout,
+		    (unsigned long)edma_host);
+	(void)mod_timer(&edma_host->timer, jiffies_64 + TIMER_INTERVAL_CHECK);
+#ifdef USE_DMA
+	setup_timer(&edma_host->dma_timer, edma_host_dma_timeout,
+		    (unsigned long)edma_host);
+	(void)mod_timer(&edma_host->dma_timer,
+			jiffies_64 + DMA_TIMER_INTERVAL_CHECK);
+#endif
+
+#else
+	init_completion(&(edma_host->msg_ready));
+
+	edma_host->edma_thread =
+	    kthread_run(edma_host_thread, (void *)edma_host, "edma_host_msg");
+
+	if (IS_ERR(edma_host->edma_thread)) {
+		BMA_LOG(DLOG_ERROR, "kernel_run  edma_host_msg failed\n");
+		return PTR_ERR(edma_host->edma_thread);
+	}
+#endif
+	edma_host->msg_send_buf = kmalloc(HOST_MAX_SEND_MBX_LEN,
+						GFP_KERNEL); /*lint !e64*/
+	if (!edma_host->msg_send_buf) {
+		BMA_LOG(DLOG_ERROR, "malloc msg_send_buf failed!");
+		ret = -ENOMEM;
+		goto failed1;
+	}
+
+	edma_host->msg_send_write = 0;
+
+	spin_lock_init(&(edma_host->send_msg_lock));
+
+	tasklet_init(&(edma_host->tasklet),
+		     (void (*)(unsigned long))edma_host_isr_tasklet,
+		     (unsigned long)edma_host);
+
+	edma_host->edma_flag = bma_dev->bma_pci_dev->edma_swap_addr;
+
+	edma_host->edma_send_addr =
+	    (void *)((unsigned char *)bma_dev->bma_pci_dev->edma_swap_addr +
+		     HOST_DMA_FLAG_LEN);
+	(void)memset_s(edma_host->edma_send_addr, SIZE_OF_MBX_HDR, 0,
+		       SIZE_OF_MBX_HDR);
+
+	edma_host->edma_recv_addr =
+	    (void *)((unsigned char *)edma_host->edma_send_addr +
+		     HOST_MAX_SEND_MBX_LEN);
+
+	BMA_LOG(DLOG_DEBUG,
+		"edma_flag = %p, edma_send_addr = %p, edma_recv_addr = %p\n",
+		edma_host->edma_flag, edma_host->edma_send_addr,
+		edma_host->edma_recv_addr);
+
+	edma_host->hostrtc_viraddr = bma_dev->bma_pci_dev->hostrtc_viraddr;
+
+	ret = edma_host_malloc_dma_buf(bma_dev);
+	if (ret) {
+		BMA_LOG(DLOG_DEBUG, "edma_host_malloc_dma_buf fail!\n");
+		goto failed2;
+	}
+
+	init_waitqueue_head(&edma_host->wq_dmah2b);
+	init_waitqueue_head(&edma_host->wq_dmab2h);
+
+	spin_lock_init(&edma_host->reg_lock);
+
+	edma_host->h2b_state = H2BSTATE_IDLE;
+	edma_host->b2h_state = B2HSTATE_IDLE;
+
+	setup_timer(&edma_host->heartbeat_timer, edma_host_heartbeat_timer,
+		    (unsigned long)edma_host);
+	(void)mod_timer(&edma_host->heartbeat_timer,
+			jiffies_64 + HEARTBEAT_TIMER_INTERVAL_CHECK);
+
+	pnm = (struct notify_msg *)edma_host->edma_flag;
+	if (pnm)
+		pnm->host_registered = REGISTERED;
+
+	GET_SYS_SECONDS(edma_host->statistics.init_time);
+
+
+#ifdef EDMA_TIMER
+	BMA_LOG(DLOG_DEBUG, "timer ok\n");
+#else
+	BMA_LOG(DLOG_ERROR, "thread ok\n");
+#endif
+	return 0;
+failed2:
+	tasklet_kill(&(edma_host->tasklet));
+	kfree(edma_host->msg_send_buf);
+	edma_host->msg_send_buf = NULL;
+
+failed1:
+#ifdef EDMA_TIMER
+	(void)del_timer_sync(&edma_host->timer);
+#ifdef USE_DMA
+	(void)del_timer_sync(&edma_host->dma_timer);
+#endif
+#else
+	kthread_stop(edma_host->edma_thread);
+	complete(&(edma_host->msg_ready));
+#endif
+	return ret;
+}
+
+void edma_host_cleanup(struct edma_host_s *edma_host)
+{
+	struct bma_dev_s *bma_dev = NULL;
+	struct notify_msg *pnm = NULL;
+
+	if (!edma_host)
+		return;
+
+	bma_dev = list_entry(edma_host, struct bma_dev_s, edma_host);
+	(void)del_timer_sync(&edma_host->heartbeat_timer);
+	pnm = (struct notify_msg *)edma_host->edma_flag;
+
+	if (pnm)
+		pnm->host_registered = DEREGISTERED;
+
+	tasklet_kill(&(edma_host->tasklet));
+
+	kfree(edma_host->msg_send_buf);
+	edma_host->msg_send_buf = NULL;
+#ifdef EDMA_TIMER
+	(void)del_timer_sync(&edma_host->timer);
+#ifdef USE_DMA
+	(void)del_timer_sync(&edma_host->dma_timer);
+#endif
+
+#else
+	kthread_stop(edma_host->edma_thread);
+
+	complete(&(edma_host->msg_ready));
+#endif
+
+	edma_host_free_dma_buf(bma_dev);
+}
diff --git a/drivers/net/ethernet/huawei/ibma/edma_host.h b/drivers/net/ethernet/huawei/ibma/edma_host.h
new file mode 100644
index 0000000..578e0f5
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/edma_host.h
@@ -0,0 +1,357 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _EDMA_HOST_H_
+#define _EDMA_HOST_H_
+
+#include "bma_include.h"
+#include "bma_ker_intf.h"
+
+#define EDMA_TIMER
+
+#ifndef IN
+#define IN
+#endif
+
+#ifndef OUT
+#define OUT
+#endif
+
+#ifndef UNUSED
+#define UNUSED
+#endif
+
+/*
+ * vm_flags in vm_area_struct, see mm_types.h.
+ */
+#define VM_NONE		0x00000000
+
+#define VM_READ		0x00000001	/* currently active flags */
+#define VM_WRITE	0x00000002
+#define VM_EXEC		0x00000004
+#define VM_SHARED	0x00000008
+
+#define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
+#define VM_MAYWRITE	0x00000020
+#define VM_MAYEXEC	0x00000040
+#define VM_MAYSHARE	0x00000080
+
+#define VM_GROWSDOWN	0x00000100	/* general info on the segment */
+/* Page-ranges managed without "struct page", just pure PFN */
+#define VM_PFNMAP	0x00000400
+#define VM_DENYWRITE	0x00000800	/* ETXTBSY on write attempts.. */
+
+#define VM_LOCKED	0x00002000
+#define VM_IO           0x00004000	/* Memory mapped I/O or similar */
+
+					/* Used by sys_madvise() */
+#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
+/* App will not benefit from clustered reads */
+#define VM_RAND_READ	0x00010000
+
+#define VM_DONTCOPY	0x00020000	/* Do not copy this vma on fork */
+#define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
+#define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
+#define VM_NORESERVE	0x00200000	/* should the VM suppress accounting */
+#define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
+#define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
+#define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
+#define VM_DONTDUMP	0x04000000	/* Do not include in the core dump */
+/* Can contain "struct page" and pure PFN pages */
+#define VM_MIXEDMAP	0x10000000
+
+#define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
+
+#if defined(CONFIG_X86)
+/* PAT reserves whole VMA at once (x86) */
+#define VM_PAT		VM_ARCH_1
+#elif defined(CONFIG_PPC)
+#define VM_SAO		VM_ARCH_1	/* Strong Access Ordering (powerpc) */
+#elif defined(CONFIG_PARISC)
+#define VM_GROWSUP	VM_ARCH_1
+#elif defined(CONFIG_METAG)
+#define VM_GROWSUP	VM_ARCH_1
+#elif defined(CONFIG_IA64)
+#define VM_GROWSUP	VM_ARCH_1
+#elif !defined(CONFIG_MMU)
+#define VM_MAPPED_COPY	VM_ARCH_1 /* T if mapped copy of data (nommu mmap) */
+#endif
+
+#ifndef VM_GROWSUP
+#define VM_GROWSUP	VM_NONE
+#endif
+
+/* Bits set in the VMA until the stack is in its final location */
+#define VM_STACK_INCOMPLETE_SETUP	(VM_RAND_READ | VM_SEQ_READ)
+
+#ifndef VM_STACK_DEFAULT_FLAGS	/* arch can override this */
+#define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
+#endif
+
+//#ifdef CONFIG_STACK_GROWSUP
+//#define VM_STACK_FLAGS	(VM_GROWSUP | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
+//#else
+//#define VM_STACK_FLAGS	(VM_GROWSDOWN | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
+//#endif
+
+#define VM_READHINTMASK			(VM_SEQ_READ | VM_RAND_READ)
+//#define VM_ClearReadHint(v)		((v)->vm_flags &= ~VM_READHINTMASK)
+#define VM_NormalReadHint(v)		(!((v)->vm_flags & VM_READHINTMASK))
+#define VM_SequentialReadHint(v)	((v)->vm_flags & VM_SEQ_READ)
+#define VM_RandomReadHint(v)		((v)->vm_flags & VM_RAND_READ)
+
+#define REG_PCIE1_DMAREAD_ENABLE	0xa18
+#define SHIFT_PCIE1_DMAREAD_ENABLE	0
+
+#define REG_PCIE1_DMAWRITE_ENABLE	0x9c4
+#define SHIFT_PCIE1_DMAWRITE_ENABLE	0
+
+#define REG_PCIE1_DMAREAD_STATUS	0xa10
+#define SHIFT_PCIE1_DMAREAD_STATUS	0
+#define REG_PCIE1_DMAREADINT_CLEAR	0xa1c
+#define SHIFT_PCIE1_DMAREADINT_CLEAR	0
+
+#define REG_PCIE1_DMAWRITE_STATUS	0x9bc
+#define SHIFT_PCIE1_DMAWRITE_STATUS	0
+#define REG_PCIE1_DMAWRITEINT_CLEAR	0x9c8
+#define SHIFT_PCIE1_DMAWRITEINT_CLEAR	0
+
+#define REG_PCIE1_DMA_READ_ENGINE_ENABLE	(0x99c)
+#define SHIFT_PCIE1_DMA_ENGINE_ENABLE		(0)
+#define REG_PCIE1_DMA_WRITE_ENGINE_ENABLE	(0x97C)
+
+#define HOSTRTC_INT_OFFSET		0x10
+
+#define H2BSTATE_IDLE			0
+#define H2BSTATE_WAITREADY		1
+#define H2BSTATE_WAITDMA		2
+#define H2BSTATE_WAITACK		3
+#define H2BSTATE_ERROR			4
+
+#define B2HSTATE_IDLE			0
+#define B2HSTATE_WAITREADY		1
+#define B2HSTATE_WAITRECV		2
+#define B2HSTATE_WAITDMA		3
+#define B2HSTATE_ERROR			4
+
+#define PAGE_ORDER			8
+#define EDMA_DMABUF_SIZE		(1 << (PAGE_SHIFT + PAGE_ORDER))
+
+#define EDMA_DMA_TRANSFER_WAIT_TIMEOUT	(10 * HZ)
+#define TIMEOUT_WAIT_NOSIGNAL		2
+
+#define TIMER_INTERVAL_CHECK		(HZ / 10)
+#define DMA_TIMER_INTERVAL_CHECK	50
+#define HEARTBEAT_TIMER_INTERVAL_CHECK	HZ
+
+#define EDMA_PCI_MSG_LEN		(56 * 1024)
+
+#define HOST_DMA_FLAG_LEN		(64)
+
+#define HOST_MAX_SEND_MBX_LEN		(40 * 1024)
+#define BMC_MAX_RCV_MBX_LEN		HOST_MAX_SEND_MBX_LEN
+
+#define HOST_MAX_RCV_MBX_LEN		(16 * 1024)
+#define BMC_MAX_SEND_MBX_LEN		HOST_MAX_RCV_MBX_LEN
+#define CDEV_MAX_WRITE_LEN		(4*1024)
+
+#define HOST_MAX_MSG_LENGTH		272
+
+#define EDMA_MMAP_H2B_DMABUF		0xf1000000
+
+#define EDMA_MMAP_B2H_DMABUF		0xf2000000
+
+#define EDMA_IOC_MAGIC			'e'
+
+#define EDMA_H_REGISTER_TYPE		_IOW(EDMA_IOC_MAGIC, 100, unsigned long)
+
+#define EDMA_H_UNREGISTER_TYPE		_IOW(EDMA_IOC_MAGIC, 101, unsigned long)
+
+#define EDMA_H_DMA_START		_IOW(EDMA_IOC_MAGIC, 102, unsigned long)
+
+#define EDMA_H_DMA_TRANSFER		_IOW(EDMA_IOC_MAGIC, 103, unsigned long)
+
+#define EDMA_H_DMA_STOP			_IOW(EDMA_IOC_MAGIC, 104, unsigned long)
+
+#define U64ADDR_H(addr)			((((u64)addr)>>32)&0xffffffff)
+#define U64ADDR_L(addr)			((addr)&0xffffffff)
+
+struct bma_register_dev_type_s {
+	u32 type;
+	u32 sub_type;
+};
+
+struct edma_mbx_hdr_s {
+	u16 mbxlen;
+	u16 mbxoff;
+	u8 reserve[28];
+} __attribute__((packed));
+
+#define SIZE_OF_MBX_HDR (sizeof(struct edma_mbx_hdr_s))
+
+struct edma_recv_msg_s {
+	struct list_head link;
+	u32 msg_len;
+	unsigned char msg_data[0];	/*lint !e1501 */
+};
+
+struct edma_dma_addr_s {
+	void *kvaddr;
+	dma_addr_t dma_addr;
+	u32 len;
+};
+
+struct edma_msg_hdr_s {
+	u32 type;
+	u32 sub_type;
+	u8 user_id;
+	u8 dma_flag;
+	u8 reserve1[2];
+	u32 datalen;
+	u8 data[0];		/*lint !e1501 */
+};
+#define SIZE_OF_MSG_HDR (sizeof(struct edma_msg_hdr_s))
+
+#pragma pack(1)
+
+#define IS_EDMA_B2H_INT(flag)		((flag) & 0x02)
+#define CLEAR_EDMA_B2H_INT(flag)	((flag) = (flag) & 0xfffffffd)
+#define SET_EDMA_H2B_INT(flag)		((flag) = (flag) | 0x01)
+#define EDMA_B2H_INT_FLAG                      0x02
+
+struct notify_msg {
+	volatile unsigned int host_registered;
+	volatile unsigned int host_heartbeat;
+	volatile unsigned int bmc_registered;
+	volatile unsigned int bmc_heartbeat;
+	volatile unsigned int int_flag;
+
+	volatile unsigned int reservrd5;
+	unsigned int h2b_addr;
+	unsigned int h2b_size;
+	unsigned int h2b_rsize;
+	unsigned int b2h_addr;
+	unsigned int b2h_size;
+	unsigned int b2h_rsize;
+};
+
+#pragma pack()
+
+struct edma_statistics_s {
+	unsigned int remote_status;
+	__kernel_time_t init_time;
+	unsigned int h2b_int;
+	unsigned int b2h_int;
+	unsigned int recv_bytes;
+	unsigned int send_bytes;
+	unsigned int send_pkgs;
+	unsigned int recv_pkgs;
+	unsigned int failed_count;
+	unsigned int drop_pkgs;
+	unsigned int dma_count;
+	unsigned int lost_count;
+};
+
+struct edma_host_s {
+	struct pci_dev *pdev;
+
+	struct tasklet_struct tasklet;
+
+	void __iomem *hostrtc_viraddr;
+
+	void __iomem *edma_flag;
+	void __iomem *edma_send_addr;
+	void __iomem *edma_recv_addr;
+#ifdef USE_DMA
+	struct timer_list dma_timer;
+#endif
+
+	struct timer_list heartbeat_timer;
+
+#ifdef EDMA_TIMER
+	struct timer_list timer;
+#else
+	struct completion msg_ready;	/* to sleep thread on      */
+	struct task_struct *edma_thread;
+#endif
+	spinlock_t send_msg_lock;
+	unsigned char *msg_send_buf;
+	unsigned int msg_send_write;
+
+	/* DMA */
+	wait_queue_head_t wq_dmah2b;
+	wait_queue_head_t wq_dmab2h;
+
+	spinlock_t reg_lock;
+	volatile int h2b_state;
+	volatile int b2h_state;
+	struct edma_dma_addr_s h2b_addr;
+	struct edma_dma_addr_s b2h_addr;
+
+	struct proc_dir_entry *proc_edma_dir;
+
+	struct edma_statistics_s statistics;
+	unsigned char local_open_status[TYPE_MAX];
+	unsigned char remote_open_status[TYPE_MAX];
+};
+
+struct edma_user_inft_s {
+	/* register user */
+	int (*user_register)(struct bma_priv_data_s *priv);
+
+	/* unregister user */
+	void (*user_unregister)(struct bma_priv_data_s *priv);
+
+	/* add msg */
+	int (*add_msg)(void *msg, size_t msg_len);
+};
+
+int is_edma_b2h_int(struct edma_host_s *edma_host);
+void edma_int_to_bmc(struct edma_host_s *edma_host);
+int edma_host_mmap(struct edma_host_s *edma_hos, struct file *filp,
+		   struct vm_area_struct *vma);
+int edma_host_copy_msg(struct edma_host_s *edma_host, void *msg,
+		       size_t msg_len);
+int edma_host_add_msg(struct edma_host_s *edma_host,
+		      struct bma_priv_data_s *priv, void *msg, size_t msg_len);
+int edma_host_recv_msg(struct edma_host_s *edma_host,
+		       struct bma_priv_data_s *priv,
+		       struct edma_recv_msg_s **msg);
+void edma_host_isr_tasklet(unsigned long data);
+int edma_host_check_dma_status(enum dma_direction_e dir);
+int edma_host_dma_start(struct edma_host_s *edma_host,
+			struct bma_priv_data_s *priv);
+int edma_host_dma_transfer(struct edma_host_s *edma_host,
+			   struct bma_priv_data_s *priv,
+			   struct bma_dma_transfer_s *dma_transfer);
+int edma_host_dma_stop(struct edma_host_s *edma_host,
+		       struct bma_priv_data_s *priv);
+irqreturn_t edma_host_irq_handle(struct edma_host_s *edma_host);
+struct edma_user_inft_s *edma_host_get_user_inft(u32 type);
+int edma_host_user_register(u32 type, struct edma_user_inft_s *func);
+int edma_host_user_unregister(u32 type);
+int edma_host_init(struct edma_host_s *edma_host);
+void edma_host_cleanup(struct edma_host_s *edma_host);
+int edma_host_send_driver_msg(void *msg, size_t msg_len, int subtype);
+void edma_host_reset_dma(struct edma_host_s *edma_host, int dir);
+void clear_int_dmah2b(struct edma_host_s *edma_host);
+void clear_int_dmab2h(struct edma_host_s *edma_host);
+
+enum EDMA_STATUS {
+	DEREGISTERED = 0,
+	REGISTERED = 1,
+	LOST,
+};
+#endif
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_dump.c b/drivers/net/ethernet/huawei/ibma/kbox_dump.c
new file mode 100644
index 0000000..d06dca7
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_dump.c
@@ -0,0 +1,141 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+
+#include <linux/spinlock.h>
+#include <linux/utsname.h>		/* system_utsname */
+#include <linux/rtc.h>		/* struct rtc_time */
+#include "kbox_include.h"
+#include "kbox_main.h"
+#include "kbox_printk.h"
+#include "kbox_ram_image.h"
+#include "kbox_ram_op.h"
+#include "kbox_dump.h"
+#include "kbox_mce.h"
+#include "kbox_panic.h"
+
+#define THREAD_TMP_BUF_SIZE 256
+
+#if (KERNEL_VERSION(3, 0, 0) < LINUX_VERSION_CODE)
+static DEFINE_SPINLOCK(g_dump_lock);
+#else
+static spinlock_t g_dump_lock = SPIN_LOCK_UNLOCKED;
+#endif
+
+static const char g_day_in_month[] = {
+	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
+};
+
+#define LEAPS_THRU_END_OF(y) ((y) / 4 - (y) / 100 + (y) / 400)
+#define LEAP_YEAR(year) ((!(year % 4) && (year % 100)) || !(year % 400))
+#define MONTH_DAYS(month, year) (g_day_in_month[(month)] \
+				+ (int)(LEAP_YEAR(year) && (month == 1)))
+
+
+static void kbox_show_kernel_version(void)
+{
+	(void)kbox_dump_painc_info(
+				"\nOS : %s,\nRelease : %s,\nVersion : %s,\nMachine : %s,\nNodename : %s\n",
+				   init_uts_ns.name.sysname,
+				   init_uts_ns.name.release,
+				   init_uts_ns.name.version,
+				   init_uts_ns.name.machine,
+				   init_uts_ns.name.nodename);
+}
+
+static void kbox_show_version(void)
+{
+	(void)kbox_dump_painc_info("\nKBOX_VERSION         : %s\n",
+				   KBOX_VERSION);
+}
+
+static void kbox_show_time_stamps(void)
+{
+	struct rtc_time rtc_time_val = { };
+	struct timeval time_value = { };
+
+	do_gettimeofday(&time_value);
+	time_value.tv_sec = time_value.tv_sec - sys_tz.tz_minuteswest * 60;
+	rtc_time_to_tm(time_value.tv_sec, &rtc_time_val);
+
+	(void)kbox_dump_painc_info(
+		"Current time         : %04d-%02d-%02d %02d:%02d:%02d\n",
+		rtc_time_val.tm_year + 1900, rtc_time_val.tm_mon + 1,
+		rtc_time_val.tm_mday, rtc_time_val.tm_hour,
+		rtc_time_val.tm_min, rtc_time_val.tm_sec);
+}
+
+int kbox_dump_thread_info(const char *fmt, ...)
+{
+	va_list args;
+	int num = 0;
+	char tmp_buf[THREAD_TMP_BUF_SIZE] = { };
+
+	va_start(args, fmt);/*lint !e530*/
+
+	num = vscnprintf(tmp_buf, sizeof(tmp_buf) - 1, fmt, args);
+	if (num >= 0) {
+		tmp_buf[num] = '\0';
+
+		(void)kbox_write_thread_info(tmp_buf, (unsigned int)num);
+	}
+
+	va_end(args);
+
+	return num;
+}
+
+void kbox_dump_event(enum kbox_error_type_e type, unsigned long event,
+		     const char *msg)
+{
+
+	if (!spin_trylock(&g_dump_lock))
+		return;
+
+	(void)kbox_dump_painc_info("\n====kbox begin dumping...====\n");
+
+	switch (type) {
+	case KBOX_MCE_EVENT:
+
+		kbox_handle_mce_dump(msg);
+
+		break;
+	case KBOX_OPPS_EVENT:
+
+		break;
+	case KBOX_PANIC_EVENT:
+		if (kbox_handle_panic_dump(msg) == KBOX_FALSE)
+			goto end;
+
+		break;
+	default:
+		break;
+	}
+
+	kbox_show_kernel_version();
+
+	kbox_show_version();
+
+	kbox_show_time_stamps();
+
+	(void)kbox_dump_painc_info("\n====kbox end dump====\n");
+
+	kbox_ouput_syslog_info();
+	kbox_ouput_printk_info();
+
+end:
+	spin_unlock(&g_dump_lock);
+}
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_dump.h b/drivers/net/ethernet/huawei/ibma/kbox_dump.h
new file mode 100644
index 0000000..84de92e
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_dump.h
@@ -0,0 +1,35 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+
+#ifndef _KBOX_DUMP_H_
+#define _KBOX_DUMP_H_
+
+#define DUMPSTATE_MCE_RESET 1
+#define DUMPSTATE_OPPS_RESET 2
+#define DUMPSTATE_PANIC_RESET 3
+
+enum kbox_error_type_e {
+	KBOX_MCE_EVENT = 1,
+	KBOX_OPPS_EVENT,
+	KBOX_PANIC_EVENT
+};
+
+int kbox_dump_thread_info(const char *fmt, ...);
+void kbox_dump_event(enum kbox_error_type_e type, unsigned long event,
+		     const char *msg);
+
+#endif
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_hook.c b/drivers/net/ethernet/huawei/ibma/kbox_hook.c
new file mode 100644
index 0000000..47aa355
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_hook.c
@@ -0,0 +1,105 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/notifier.h>
+#include "kbox_include.h"
+#include "kbox_dump.h"
+#include "kbox_hook.h"
+
+/*lint -e49 -e526 -e10 */
+int panic_notify(struct notifier_block *this,
+					unsigned long event,
+					void *msg);
+/*lint +e49 +e526 +e10*/
+
+static int die_notify(struct notifier_block *self,
+					unsigned long val,
+					void *data);
+
+static struct notifier_block g_panic_nb = {
+	.notifier_call = panic_notify, /*lint !e64*/
+	.priority = 100,
+};
+
+static struct notifier_block g_die_nb = {
+	.notifier_call = die_notify,
+};
+
+int panic_notify(struct notifier_block *pthis, unsigned long event, void *msg)
+{
+	UNUSED(pthis);
+	UNUSED(event);
+
+	kbox_dump_event(KBOX_PANIC_EVENT, DUMPSTATE_PANIC_RESET,
+			(const char *)msg);
+
+	return NOTIFY_OK;
+}
+
+int die_notify(struct notifier_block *self, unsigned long val, void *data)
+{
+	struct kbox_die_args *args = (struct kbox_die_args *)data;
+
+	if (!args)
+		return NOTIFY_OK;
+
+	switch (val) {
+	case 1:
+		break;
+	case 5:
+		if (strcmp(args->str, "nmi") == 0)
+			return NOTIFY_OK;
+
+		kbox_dump_event(KBOX_MCE_EVENT, DUMPSTATE_MCE_RESET, args->str);
+		break;
+
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+
+int kbox_register_hook(void)
+{
+	int ret = 0;
+
+	ret = atomic_notifier_chain_register(&panic_notifier_list, &g_panic_nb);
+	if (ret)
+		KBOX_MSG("atomic_notifier_chain_register g_panic_nb failed!\n");
+
+	ret = register_die_notifier(&g_die_nb);
+	if (ret)
+		KBOX_MSG("register_die_notifier g_die_nb failed!\n");
+
+	return ret;
+}
+
+void kbox_unregister_hook(void)
+{
+	int ret = 0;
+
+	ret =
+	    atomic_notifier_chain_unregister(&panic_notifier_list, &g_panic_nb);
+	if (ret < 0) {
+		KBOX_MSG
+		    ("atomic_notifier_chain_unregister g_panic_nb failed!\n");
+	}
+
+	ret = unregister_die_notifier(&g_die_nb);
+	if (ret < 0)
+		KBOX_MSG("unregister_die_notifier g_die_nb failed!\n");
+}
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_hook.h b/drivers/net/ethernet/huawei/ibma/kbox_hook.h
new file mode 100644
index 0000000..61d9c7b
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_hook.h
@@ -0,0 +1,34 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _KBOX_PANIC_HOOK_H_
+#define _KBOX_PANIC_HOOK_H_
+
+struct kbox_die_args {
+	struct pt_regs  *regs;
+	const char  *str;
+	long err;
+	int trapnr;
+	int signr;
+};
+
+extern int register_die_notifier(struct notifier_block *nb);
+extern int unregister_die_notifier(struct notifier_block *nb);
+
+int kbox_register_hook(void);
+void kbox_unregister_hook(void);
+
+#endif
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_include.h b/drivers/net/ethernet/huawei/ibma/kbox_include.h
new file mode 100644
index 0000000..17a912b
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_include.h
@@ -0,0 +1,44 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _KBOX_INCLUDE_H_
+#define _KBOX_INCLUDE_H_
+
+#include <linux/kernel.h>
+#include <linux/version.h>
+
+#ifdef DRV_VERSION
+#define KBOX_VERSION MICRO_TO_STR(DRV_VERSION)
+#else
+#define KBOX_VERSION "0.2.9"
+#endif
+
+#define UNUSED(x) (x = x)
+#define KBOX_FALSE (-1)
+#define KBOX_TRUE 0
+
+#ifdef KBOX_DEBUG
+#define KBOX_MSG(fmt, args...) do {\
+	printk(KERN_NOTICE "kbox: %s(), %d, " fmt, \
+	__func__, __LINE__, ## args);\
+	} while (0)
+#else
+#define KBOX_MSG(fmt, args...)
+#endif
+
+#define BAD_FUNC_ADDR(x) ((0xFFFFFFFF == (x)) || (0 == (x)))
+
+#endif
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_main.c b/drivers/net/ethernet/huawei/ibma/kbox_main.c
new file mode 100644
index 0000000..eb9e946
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_main.c
@@ -0,0 +1,207 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <asm/msr.h>
+#include <asm/processor.h>	/* for rdmsr and MSR_IA32_MCG_STATUS */
+#include <linux/fs.h>		/* everything... */
+#include <linux/file.h>		/*fput() */
+#include <linux/proc_fs.h>
+#include <linux/uaccess.h>		/* copy_*_user */
+#include <linux/version.h>
+#include "kbox_include.h"
+#include "kbox_mce.h"
+#include "kbox_panic.h"
+#include "kbox_main.h"
+#include "kbox_printk.h"
+#include "kbox_ram_image.h"
+#include "kbox_ram_op.h"
+#include "kbox_dump.h"
+#include "kbox_hook.h"
+#include "kbox_ram_drive.h"
+
+#define KBOX_LOADED_FILE ("/proc/kbox")
+
+#define KBOX_ROOT_ENTRY_NAME ("kbox")
+
+int kbox_read_user_log_region(unsigned long offset, char *buf, unsigned int len)
+{
+	int ret = 0;
+
+	ret = kbox_read_from_ram(offset, len, (char *)buf, KBOX_SECTION_USER);
+
+	if (ret < 0) {
+		KBOX_MSG("kbox_read_from_ram fail!\n");
+		return ret;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(kbox_read_user_log_region);
+
+int kbox_write_user_log_region(unsigned long offset, char *buf,
+			       unsigned int len)
+{
+	int ret = 0;
+
+	ret = kbox_write_to_ram(offset, len, (char *)buf, KBOX_SECTION_USER);
+
+	if (ret < 0) {
+		KBOX_MSG("kbox_write_to_ram fail!\n");
+		return ret;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(kbox_write_user_log_region);
+
+int kbox_memset_user_log_region(unsigned long offset, char set_byte,
+				unsigned int len)
+{
+	int ret = 0;
+
+	ret = kbox_memset_ram(offset, len, set_byte, KBOX_SECTION_USER);
+
+	if (ret < 0) {
+		KBOX_MSG("kbox_memset_ram fail!\n");
+		return ret;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(kbox_memset_user_log_region);
+
+static int kbox_is_loaded(void)
+{
+	struct file *fp = NULL;
+	mm_segment_t old_fs = { };
+
+	old_fs = get_fs();		/* save old flag */
+	set_fs(KERNEL_DS);	/*lint !e501*//* mark data from kernel space */
+
+	fp = filp_open(KBOX_LOADED_FILE, O_RDONLY, 0);
+
+	if (IS_ERR(fp)) {
+		set_fs(old_fs);
+		return KBOX_FALSE;
+	}
+
+	(void)filp_close(fp, NULL);
+
+	set_fs(old_fs);		/* restore old flag */
+
+	return KBOX_TRUE;
+}
+
+static int kbox_printk_proc_init(void)
+{
+	struct proc_dir_entry *kbox_entry = NULL;
+
+	if (kbox_is_loaded() != KBOX_TRUE) {
+		kbox_entry = proc_mkdir(KBOX_ROOT_ENTRY_NAME, NULL);
+		if (!kbox_entry) {
+			KBOX_MSG("can not create %s entry\n",
+				 KBOX_ROOT_ENTRY_NAME);
+			return -ENOMEM;
+		}
+	}
+
+	return KBOX_TRUE;
+}
+
+int __init kbox_init(void)
+{
+	int ret = KBOX_TRUE;
+	int kbox_proc_exist = 0;
+
+	if (!kbox_get_base_phy_addr())
+		return -ENXIO;
+
+	ret = kbox_super_block_init();
+	if (ret) {
+		KBOX_MSG("kbox_super_block_init failed!\n");
+		return ret;
+	}
+
+	if (kbox_is_loaded() == KBOX_TRUE)
+		kbox_proc_exist = 1;
+
+	ret = kbox_printk_init(kbox_proc_exist);
+	if (ret)
+		KBOX_MSG("kbox_printk_init failed!\n");
+
+	ret = kbox_panic_init();
+	if (ret) {
+		KBOX_MSG("kbox_panic_init failed!\n");
+		goto fail1;
+	}
+
+	ret = kbox_register_hook();
+	if (ret) {
+		KBOX_MSG("kbox_register_hook failed!\n");
+		goto fail2;
+	}
+
+	(void)kbox_mce_init();
+	ret = Kbox_read_super_block();
+	if (ret) {
+		KBOX_MSG("kbox_mce_init failed!\n");
+		goto fail3;
+	}
+
+	if (kbox_printk_proc_init() != 0) {
+		KBOX_MSG("kbox_printk_proc_init failed!\n");
+		goto fail4;
+	}
+
+	ret = kbox_drive_init();
+	if (ret) {
+		KBOX_MSG("kbox_drive_init failed!\n");
+		goto fail5;
+	}
+
+	return KBOX_TRUE;
+
+fail5:
+fail4:
+fail3:
+	kbox_mce_exit();
+	kbox_unregister_hook();
+fail2:
+	kbox_panic_exit();
+fail1:
+	kbox_printk_exit();
+
+	return ret;
+}
+
+void __exit kbox_cleanup(void)
+{
+	kbox_drive_cleanup();
+	kbox_mce_exit();
+	kbox_unregister_hook();
+	kbox_panic_exit();
+	kbox_printk_exit();
+}
+
+MODULE_AUTHOR("HUAWEI TECHNOLOGIES CO., LTD.");
+MODULE_DESCRIPTION("HUAWEI KBOX DRIVER");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(KBOX_VERSION);
+#ifndef _lint
+module_init(kbox_init);
+module_exit(kbox_cleanup);
+#endif
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_main.h b/drivers/net/ethernet/huawei/ibma/kbox_main.h
new file mode 100644
index 0000000..1e132bd
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_main.h
@@ -0,0 +1,25 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+
+#ifndef _KBOX_MAIN_H_
+#define _KBOX_MAIN_H_
+
+#include "bma_include.h"
+int kbox_init(void);
+void kbox_cleanup(void);
+
+#endif
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_mce.c b/drivers/net/ethernet/huawei/ibma/kbox_mce.c
new file mode 100644
index 0000000..fc72077
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_mce.c
@@ -0,0 +1,293 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/atomic.h>
+#include <linux/smp.h>
+#include <linux/notifier.h>
+#include <asm/mce.h>
+#include <asm/msr.h>
+
+#include "kbox_include.h"
+#include "kbox_mce.h"
+#include "kbox_dump.h"
+#include "kbox_printk.h"
+#include "kbox_panic.h"
+
+enum context {
+	KBOX_IN_KERNEL = 1, KBOX_IN_USER = 2
+};
+
+enum ser {
+	KBOX_SER_REQUIRED = 1, KBOX_NO_SER = 2
+};
+
+enum severity_level {
+	KBOX_MCE_NO_SEVERITY,
+	KBOX_MCE_KEEP_SEVERITY,
+	KBOX_MCE_SOME_SEVERITY,
+	KBOX_MCE_AO_SEVERITY,
+	KBOX_MCE_UC_SEVERITY,
+	KBOX_MCE_AR_SEVERITY,
+	KBOX_MCE_PANIC_SEVERITY,
+};
+
+static struct severity {
+	u64 kbox_mask;
+	u64 kbox_result;
+	unsigned char kbox_sev;
+	unsigned char kbox_mcgmask;
+	unsigned char kbox_mcgres;
+	unsigned char kbox_ser;
+	unsigned char kbox_context;
+	unsigned char kbox_covered;
+	char *kbox_msg;
+} kbox_severities[] = {
+
+#if (KERNEL_VERSION(2, 6, 18) >= LINUX_VERSION_CODE)
+#define MSR_IA32_MCx_CTL(x)         (MSR_IA32_MC0_CTL + 4*(x))
+#define MSR_IA32_MCx_STATUS(x)      (MSR_IA32_MC0_STATUS + 4*(x))
+#define MSR_IA32_MCx_ADDR(x)        (MSR_IA32_MC0_ADDR + 4*(x))
+#define MSR_IA32_MCx_MISC(x)        (MSR_IA32_MC0_MISC + 4*(x))
+#define MCI_STATUS_S    (1ULL<<56)		/* Signaled machine check */
+#define MCI_STATUS_AR   (1ULL<<55)	/* Action required */
+#define MCG_BANKCNT_MASK    0xff		/* Number of Banks */
+/* MCA recovery/new status bits */
+#define MCG_SER_P       (1ULL<<24)
+
+#endif
+
+/*lint -e665*/
+#define KBOX_KERNEL .kbox_context = KBOX_IN_KERNEL
+#define KBOX_USER .kbox_context = KBOX_IN_USER
+#define KBOX_SER .kbox_ser      = KBOX_SER_REQUIRED
+#define KBOX_NOSER .kbox_ser    = KBOX_NO_SER
+#define KBOX_SEV(s) .kbox_sev   = KBOX_MCE_ ## s ## _SEVERITY
+#define KBOX_BITCLR(x, s, m, r...) \
+	{ .kbox_mask = x,   .kbox_result = 0, KBOX_SEV(s), .kbox_msg = m, ## r }
+#define KBOX_BITSET(x, s, m, r...) \
+	{ .kbox_mask = x,   .kbox_result = x, KBOX_SEV(s), .kbox_msg = m, ## r }
+#define KBOX_MCGMASK(x, res, s, m, r...) \
+	{\
+		.kbox_mcgmask = x, \
+		.kbox_mcgres = res, \
+		KBOX_SEV(s), \
+		.kbox_msg = m, \
+		## r }
+#define KBOX_MASK(x, y, s, m, r...) \
+	{ .kbox_mask = x, .kbox_result = y, KBOX_SEV(s), .kbox_msg = m, ## r }
+#define KBOX_MCI_UC_S (MCI_STATUS_UC | MCI_STATUS_S)
+#define KBOX_MCI_UC_SAR (MCI_STATUS_UC | MCI_STATUS_S | MCI_STATUS_AR)
+#define KBOX_MCACOD 0xffff
+
+KBOX_BITCLR(MCI_STATUS_VAL, NO, "Invalid"),
+KBOX_BITCLR(MCI_STATUS_EN, NO, "Not enabled"),
+KBOX_BITSET(MCI_STATUS_PCC, PANIC, "Processor context corrupt"),
+
+KBOX_MCGMASK(MCG_STATUS_MCIP, 0, PANIC, "MCIP not set in MCA handler"),
+
+KBOX_MCGMASK(MCG_STATUS_RIPV | MCG_STATUS_EIPV, 0, PANIC,
+	"Neither restart nor error IP"),
+KBOX_MCGMASK(MCG_STATUS_RIPV, 0, PANIC, "In kernel and no restart IP",
+	KBOX_KERNEL),
+KBOX_BITCLR(MCI_STATUS_UC, KEEP, "Corrected error", KBOX_NOSER),
+KBOX_MASK(MCI_STATUS_OVER | MCI_STATUS_UC | MCI_STATUS_EN, MCI_STATUS_UC, SOME,
+	"Spurious not enabled", KBOX_SER),
+
+KBOX_MASK(KBOX_MCI_UC_SAR, MCI_STATUS_UC, KEEP,
+	"Uncorrected no action required", KBOX_SER),
+KBOX_MASK(MCI_STATUS_OVER | KBOX_MCI_UC_SAR, MCI_STATUS_UC | MCI_STATUS_AR,
+	PANIC, "Illegal combination (UCNA with AR=1)", KBOX_SER),
+KBOX_MASK(MCI_STATUS_S, 0, KEEP, "Non signalled machine check", KBOX_SER),
+
+KBOX_MASK(MCI_STATUS_OVER | KBOX_MCI_UC_SAR, MCI_STATUS_OVER | KBOX_MCI_UC_SAR,
+	PANIC, "Action required with lost events", KBOX_SER),
+KBOX_MASK(MCI_STATUS_OVER | KBOX_MCI_UC_SAR | KBOX_MCACOD, KBOX_MCI_UC_SAR,
+	PANIC, "Action required; unknown MCACOD", KBOX_SER),
+
+KBOX_MASK(KBOX_MCI_UC_SAR | MCI_STATUS_OVER | 0xfff0, KBOX_MCI_UC_S | 0xc0,
+	AO, "Action optional: memory scrubbing error", KBOX_SER),
+KBOX_MASK(KBOX_MCI_UC_SAR | MCI_STATUS_OVER | KBOX_MCACOD,
+	KBOX_MCI_UC_S | 0x17a, AO,
+	"Action optional: last level cache writeback error", KBOX_SER),
+
+KBOX_MASK(MCI_STATUS_OVER | KBOX_MCI_UC_SAR, KBOX_MCI_UC_S, SOME,
+	"Action optional unknown MCACOD", KBOX_SER),
+KBOX_MASK(MCI_STATUS_OVER | KBOX_MCI_UC_SAR, KBOX_MCI_UC_S | MCI_STATUS_OVER,
+	SOME, "Action optional with lost events", KBOX_SER),
+KBOX_BITSET(MCI_STATUS_UC | MCI_STATUS_OVER, PANIC, "Overflowed uncorrected"),
+KBOX_BITSET(MCI_STATUS_UC, UC, "Uncorrected"),
+KBOX_BITSET(0, SOME, "No match")
+};
+/*lint -e665*/
+
+
+
+static unsigned int g_kbox_nr_mce_banks;
+static unsigned int g_kbox_mce_ser;
+static atomic_t g_mce_dump_state = ATOMIC_INIT(0);
+
+static int kbox_mce_severity(u64 mcgstatus, u64 status)
+{
+	struct severity *s;
+
+	for (s = kbox_severities;; s++) {
+		if ((status & s->kbox_mask) != s->kbox_result)
+			continue;
+
+		if ((mcgstatus & s->kbox_mcgmask) != s->kbox_mcgres)
+			continue;
+
+		if ((s->kbox_ser == KBOX_SER_REQUIRED) && !g_kbox_mce_ser)
+			continue;
+
+		if ((s->kbox_ser == KBOX_NO_SER) && g_kbox_mce_ser)
+			continue;
+
+		break;
+	}
+
+	return s->kbox_sev;
+}
+
+static u64 kbox_mce_rdmsrl(u32 ulmsr)
+{
+	u64 ullv = 0;
+#if (KERNEL_VERSION(2, 6, 18) >= LINUX_VERSION_CODE)
+	rdmsrl(ulmsr, ullv);
+#else
+	if (rdmsrl_safe(ulmsr, &ullv)) {
+		(void)kbox_dump_painc_info("mce: Unable to read msr %d!\n",
+					   ulmsr);
+		ullv = 0;
+	}
+#endif
+
+	return ullv;
+}
+
+static int kbox_intel_machine_check(void)
+{
+	unsigned int idx = 0;
+	u64 mcgstatus = 0;
+	int worst = 0;
+
+	mcgstatus = kbox_mce_rdmsrl(MSR_IA32_MCG_STATUS);
+
+	(void)
+	    kbox_dump_painc_info
+	    ("CPU %d: Machine Check Exception MCG STATUS: 0x%016llx\n",
+	     smp_processor_id(), mcgstatus);
+
+	if (!(mcgstatus & MCG_STATUS_RIPV))
+		(void)kbox_dump_painc_info("Unable to continue\n");
+
+	for (idx = 0; idx < g_kbox_nr_mce_banks; idx++) {
+		u64 status = 0;
+		u64 misc = 0;
+		u64 addr = 0;
+		int lseverity = 0;
+
+		status = kbox_mce_rdmsrl(MSR_IA32_MCx_STATUS(idx));
+
+		(void)kbox_dump_painc_info("Bank %d STATUS: 0x%016llx\n", idx,
+					   status);
+
+		if (0 == (status & MCI_STATUS_VAL))
+			continue;
+
+		lseverity = kbox_mce_severity(mcgstatus, status);
+		if ((lseverity == KBOX_MCE_KEEP_SEVERITY)
+		    || (lseverity == KBOX_MCE_NO_SEVERITY))
+			continue;
+
+		(void)kbox_dump_painc_info("severity = %d\n", lseverity);
+
+		if (status & MCI_STATUS_MISCV) {
+			misc = kbox_mce_rdmsrl(MSR_IA32_MCx_MISC(idx));
+			(void)kbox_dump_painc_info("misc = 0x%016llx\n", misc);
+		}
+
+		if (status & MCI_STATUS_ADDRV) {
+			addr = kbox_mce_rdmsrl(MSR_IA32_MCx_ADDR(idx));
+			(void)kbox_dump_painc_info("addr = 0x%016llx\n", addr);
+		}
+
+		(void)kbox_dump_painc_info("\n");
+
+		if (lseverity > worst)
+			worst = lseverity;
+	}
+
+	if (worst >= KBOX_MCE_UC_SEVERITY)
+		return KBOX_FALSE;
+
+	(void)kbox_dump_painc_info("Attempting to continue.\n");
+
+	return KBOX_TRUE;
+}
+
+int kbox_handle_mce_dump(const char *msg)
+{
+	int mce_recoverable = KBOX_FALSE;
+
+	atomic_read(&g_mce_dump_state);
+
+	mce_recoverable = kbox_intel_machine_check();
+	if (mce_recoverable != KBOX_TRUE) {
+
+		static atomic_t mce_entry_tmp;
+
+		int flag = atomic_add_return(1, &mce_entry_tmp);
+
+		if (flag != 1)
+			return KBOX_FALSE;
+
+	}
+
+	atomic_set(&g_mce_dump_state, DUMPSTATE_MCE_RESET);
+
+	if (msg != NULL) {
+		(void)
+		    kbox_dump_painc_info
+		    ("-------[ System may reset by %s! ]-------\n\n", msg);
+	}
+
+	return KBOX_TRUE;
+}
+
+int kbox_mce_init(void)
+{
+	u64 cap = 0;
+
+	cap = kbox_mce_rdmsrl(MSR_IA32_MCG_CAP);
+	g_kbox_nr_mce_banks = cap & MCG_BANKCNT_MASK;
+
+	if (cap & MCG_SER_P)
+		g_kbox_mce_ser = 1;
+
+	KBOX_MSG("get nr_mce_banks:%d, g_kbox_mce_ser = %d, cap = 0x%016llx\n",
+		 g_kbox_nr_mce_banks, g_kbox_mce_ser, cap);
+
+	return KBOX_TRUE;
+}
+
+void kbox_mce_exit(void)
+{
+	g_kbox_nr_mce_banks = 0;
+	g_kbox_mce_ser = 0;
+}
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_mce.h b/drivers/net/ethernet/huawei/ibma/kbox_mce.h
new file mode 100644
index 0000000..68bb52e
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_mce.h
@@ -0,0 +1,25 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+
+#ifndef _KBOX_MCE_H_
+#define _KBOX_MCE_H_
+
+int kbox_handle_mce_dump(const char *msg);
+int kbox_mce_init(void);
+void kbox_mce_exit(void);
+
+#endif
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_panic.c b/drivers/net/ethernet/huawei/ibma/kbox_panic.c
new file mode 100644
index 0000000..d1565fe
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_panic.c
@@ -0,0 +1,195 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <asm/types.h>
+#include <asm/msr.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include "kbox_include.h"
+#include "kbox_panic.h"
+#include "kbox_ram_op.h"
+
+#define PANIC_TMP_BUF_SIZE 256
+
+static int g_panic_init_ok = KBOX_FALSE;
+
+static char  *g_panic_info_buf_tmp;
+static char  *g_panic_info_buf;
+
+static unsigned int g_panic_info_start;
+
+static unsigned int g_panic_info_end;
+
+static unsigned int g_panic_info_len;
+
+#if (KERNEL_VERSION(3, 0, 0) < LINUX_VERSION_CODE)
+static DEFINE_SPINLOCK(g_panic_buf_lock);
+#else
+static spinlock_t g_panic_buf_lock = SPIN_LOCK_UNLOCKED;
+#endif
+
+static void kbox_emit_syslog_char(const char c)
+{
+	if (unlikely(!g_panic_info_buf))
+		return;
+
+	 *(g_panic_info_buf + (g_panic_info_end % SLOT_LENGTH)) = c;
+	g_panic_info_end++;
+
+	if (g_panic_info_end > SLOT_LENGTH)
+		g_panic_info_start++;
+
+	if (g_panic_info_len < SLOT_LENGTH)
+		g_panic_info_len++;
+
+}
+
+static int kbox_duplicate_syslog_info(const char  *syslog_buf,
+				      unsigned int buf_len)
+{
+	unsigned int idx = 0;
+	unsigned long flags = 0;
+
+	if (!syslog_buf)
+		return 0;
+
+	spin_lock_irqsave(&g_panic_buf_lock, flags);
+
+	for (idx = 0; idx < buf_len; idx++)
+		kbox_emit_syslog_char(*syslog_buf++);
+
+	spin_unlock_irqrestore(&g_panic_buf_lock, flags);
+
+	return buf_len;
+}
+
+int kbox_dump_painc_info(const char  *fmt, ...)
+{
+	va_list args;
+	int num = 0;
+	char tmp_buf[PANIC_TMP_BUF_SIZE] = { };
+
+	va_start(args, fmt);/* lint !e530 */
+
+	num = vsnprintf(tmp_buf, sizeof(tmp_buf) - 1, fmt, args);
+	if (num >= 0)
+		(void)kbox_duplicate_syslog_info(tmp_buf, num);
+
+	va_end(args);
+
+	return num;
+}
+
+void kbox_ouput_syslog_info(void)
+{
+	unsigned int start_tmp = 0;
+	unsigned int end_tmp = 0;
+	unsigned int len_tmp = 0;
+	unsigned long flags = 0;
+
+	if (unlikely
+	    ((!g_panic_info_buf) || (!g_panic_info_buf_tmp)))
+		return;
+
+	spin_lock_irqsave(&g_panic_buf_lock, flags);
+	if (g_panic_info_len == 0) {
+		spin_unlock_irqrestore(&g_panic_buf_lock, flags);
+		return;
+	}
+
+	start_tmp = (g_panic_info_start % SLOT_LENGTH);
+	end_tmp = ((g_panic_info_end - 1) % SLOT_LENGTH);
+	len_tmp = g_panic_info_len;
+
+	if (start_tmp > end_tmp) {
+		memcpy(g_panic_info_buf_tmp,
+			(g_panic_info_buf + start_tmp),
+			len_tmp - start_tmp);/* lint !e522 !e64 */
+		memcpy((g_panic_info_buf_tmp + len_tmp - start_tmp),
+			g_panic_info_buf,
+			end_tmp + 1);/* lint !e522 !e64 */
+	} else {
+		memcpy(g_panic_info_buf_tmp,
+			(char  *)(g_panic_info_buf + start_tmp),
+			len_tmp);/* lint !e522 !e64 */
+	}
+
+	spin_unlock_irqrestore(&g_panic_buf_lock, flags);
+
+	(void)kbox_write_panic_info(g_panic_info_buf_tmp, len_tmp);
+
+}
+
+int kbox_panic_init(void)
+{
+	int ret = KBOX_TRUE;
+
+	g_panic_info_buf = kmalloc(SLOT_LENGTH, GFP_KERNEL); /* lint !e64 */
+	if (IS_ERR(g_panic_info_buf) || (!g_panic_info_buf)) {
+		KBOX_MSG("kmalloc g_panic_info_buf fail!\n");
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	memset(g_panic_info_buf, 0, SLOT_LENGTH);
+
+	g_panic_info_buf_tmp = kmalloc(SLOT_LENGTH, GFP_KERNEL); /* lint !e64 */
+	if (IS_ERR(g_panic_info_buf_tmp) || (!g_panic_info_buf_tmp)) {
+		KBOX_MSG("kmalloc g_panic_info_buf_tmp fail!\n");
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	memset(g_panic_info_buf_tmp, 0, SLOT_LENGTH);
+
+	g_panic_init_ok = KBOX_TRUE;
+
+	return ret;
+fail:
+
+	kfree(g_panic_info_buf);
+	g_panic_info_buf = NULL;
+
+	kfree(g_panic_info_buf_tmp);
+	g_panic_info_buf_tmp = NULL;
+
+	return ret;
+}
+
+void kbox_panic_exit(void)
+{
+	if (g_panic_init_ok != KBOX_TRUE)
+		return;
+
+	kfree(g_panic_info_buf);
+	g_panic_info_buf = NULL;
+
+	kfree(g_panic_info_buf_tmp);
+	g_panic_info_buf_tmp = NULL;
+
+	/* (void)unregister_console(&g_syslog_console); */
+}
+
+int kbox_handle_panic_dump(const char  *msg)
+{
+
+	if (msg)
+		(void)kbox_dump_painc_info("panic string: %s\n", msg);
+
+
+	return KBOX_TRUE;
+}
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_panic.h b/drivers/net/ethernet/huawei/ibma/kbox_panic.h
new file mode 100644
index 0000000..33181ef
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_panic.h
@@ -0,0 +1,27 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+
+#ifndef _KBOX_PANIC_H_
+#define _KBOX_PANIC_H_
+
+int kbox_handle_panic_dump(const char  *msg);
+void kbox_ouput_syslog_info(void);
+int kbox_dump_painc_info(const char  *fmt, ...);
+int kbox_panic_init(void);
+void kbox_panic_exit(void);
+
+#endif
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_printk.c b/drivers/net/ethernet/huawei/ibma/kbox_printk.c
new file mode 100644
index 0000000..0271680
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_printk.c
@@ -0,0 +1,377 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/console.h>		/* struct console */
+#include <linux/slab.h>
+#include <linux/err.h>
+#include "kbox_include.h"
+#include "kbox_main.h"
+#include "kbox_printk.h"
+#include "kbox_ram_image.h"
+#include "kbox_ram_op.h"
+
+#define TMP_BUF_SIZE 256
+
+static int g_printk_init_ok = KBOX_FALSE;
+
+static char *g_printk_info_buf;
+static char *g_printk_info_buf_tmp;
+
+static struct printk_ctrl_block_tmp_s g_printk_ctrl_block_tmp = { };
+
+#if (KERNEL_VERSION(3, 0, 0) < LINUX_VERSION_CODE)
+static DEFINE_SPINLOCK(g_printk_buf_lock);
+#else
+static spinlock_t g_printk_buf_lock = SPIN_LOCK_UNLOCKED;
+#endif
+
+static void kbox_printk_info_write(struct console *console,
+				   const char *printk_buf,
+				   unsigned int buf_len);
+
+static struct console g_printk_console = {
+	.name = "k_prtk",
+	.flags = CON_ENABLED | CON_PRINTBUFFER,
+	.write = kbox_printk_info_write,
+};
+
+static int kbox_printk_format_is_order(struct printk_info_ctrl_block_s *
+				       printk_ctrl_blk_first,
+				       struct printk_info_ctrl_block_s *
+				       printk_ctrl_blk_second)
+{
+	if (!printk_ctrl_blk_first || !printk_ctrl_blk_second)
+		return KBOX_FALSE;
+
+	if (!memcmp
+	    (printk_ctrl_blk_first->flag, PRINTK_CURR_FLAG, PRINTK_FLAG_LEN)
+	    && !memcmp(printk_ctrl_blk_second->flag, PRINTK_LAST_FLAG,
+		       PRINTK_FLAG_LEN)) {
+		return KBOX_TRUE;
+	}
+
+	return KBOX_FALSE;
+}
+
+static void kbox_printk_format(struct printk_info_ctrl_block_s *printk_ctrl_blk,
+			       char *flag)
+{
+	if (!printk_ctrl_blk || !flag)
+		return;
+
+	memset(printk_ctrl_blk, 0, sizeof(struct printk_info_ctrl_block_s));
+	memcpy(printk_ctrl_blk->flag, flag, PRINTK_FLAG_LEN);/*lint !e522 !e64*/
+
+}
+
+static void kbox_printk_init_info_first(struct image_super_block_s
+							*kbox_super_block)
+{
+	KBOX_MSG("\n");
+	if (kbox_printk_format_is_order(kbox_super_block->printk_ctrl_blk,
+					kbox_super_block->printk_ctrl_blk +
+					1) == KBOX_TRUE) {
+		memcpy(kbox_super_block->printk_ctrl_blk[0].flag,
+			PRINTK_LAST_FLAG,
+			PRINTK_FLAG_LEN);	/*lint !e64 !e522 */
+		memcpy(kbox_super_block->printk_ctrl_blk[1].flag,
+			PRINTK_CURR_FLAG,
+			PRINTK_FLAG_LEN);	/*lint !e64 !e522 */
+
+		kbox_super_block->printk_ctrl_blk[1].len = 0;
+		g_printk_ctrl_block_tmp.printk_region = 1;
+		g_printk_ctrl_block_tmp.section = KBOX_SECTION_PRINTK2;
+		(void)kbox_clear_region(KBOX_SECTION_PRINTK2);
+	} else if (kbox_printk_format_is_order(
+			kbox_super_block->printk_ctrl_blk + 1,
+			kbox_super_block->printk_ctrl_blk) == KBOX_TRUE) {
+
+		memcpy(kbox_super_block->printk_ctrl_blk[1].flag,
+			PRINTK_LAST_FLAG,
+			PRINTK_FLAG_LEN);	/*lint !e522 !e64*/
+		memcpy(kbox_super_block->printk_ctrl_blk[0].flag,
+			PRINTK_CURR_FLAG,
+			PRINTK_FLAG_LEN);	/*lint !e522 !e64*/
+
+		kbox_super_block->printk_ctrl_blk[0].len = 0;
+		g_printk_ctrl_block_tmp.printk_region = 0;
+		g_printk_ctrl_block_tmp.section = KBOX_SECTION_PRINTK1;
+		(void)kbox_clear_region(KBOX_SECTION_PRINTK1);
+	} else {
+		kbox_printk_format(kbox_super_block->printk_ctrl_blk,
+				   PRINTK_CURR_FLAG);
+		kbox_printk_format(kbox_super_block->printk_ctrl_blk + 1,
+				   PRINTK_LAST_FLAG);
+		g_printk_ctrl_block_tmp.printk_region = 0;
+		g_printk_ctrl_block_tmp.section = KBOX_SECTION_PRINTK1;
+		(void)kbox_clear_region(KBOX_SECTION_PRINTK1);
+		(void)kbox_clear_region(KBOX_SECTION_PRINTK2);
+	}
+
+	g_printk_ctrl_block_tmp.start = 0;
+	g_printk_ctrl_block_tmp.end = 0;
+	g_printk_ctrl_block_tmp.valid_len = 0;
+
+}
+
+static void kbox_printk_init_info_not_first(struct image_super_block_s
+					    *kbox_super_block)
+{
+	KBOX_MSG("\n");
+	if (KBOX_TRUE ==
+	    kbox_printk_format_is_order(kbox_super_block->printk_ctrl_blk,
+					kbox_super_block->printk_ctrl_blk +
+					1)) {
+		g_printk_ctrl_block_tmp.printk_region = 0;
+		g_printk_ctrl_block_tmp.section = KBOX_SECTION_PRINTK1;
+
+	} else if (KBOX_TRUE ==
+		   kbox_printk_format_is_order(
+		   kbox_super_block->printk_ctrl_blk + 1,
+		   kbox_super_block->printk_ctrl_blk)) {
+		g_printk_ctrl_block_tmp.printk_region = 1;
+		g_printk_ctrl_block_tmp.section = KBOX_SECTION_PRINTK2;
+
+	} else {
+		kbox_printk_format(kbox_super_block->printk_ctrl_blk,
+				   PRINTK_CURR_FLAG);
+		kbox_printk_format(kbox_super_block->printk_ctrl_blk + 1,
+				   PRINTK_LAST_FLAG);
+		g_printk_ctrl_block_tmp.printk_region = 0;
+		g_printk_ctrl_block_tmp.section = KBOX_SECTION_PRINTK1;
+		(void)kbox_clear_region(KBOX_SECTION_PRINTK1);
+		(void)kbox_clear_region(KBOX_SECTION_PRINTK2);
+
+	}
+
+	g_printk_ctrl_block_tmp.start = 0;
+
+}
+
+static int kbox_printk_init_info(int kbox_proc_exist)
+{
+	struct image_super_block_s kbox_super_block = { };
+	unsigned int read_len = 0;
+	unsigned int write_len = 0;
+
+	read_len =
+	    kbox_read_from_ram(SECTION_KERNEL_OFFSET,
+			       (unsigned int)sizeof(struct image_super_block_s),
+			       (char *)&kbox_super_block, KBOX_SECTION_KERNEL);
+	if (read_len != sizeof(struct image_super_block_s)) {
+		KBOX_MSG("fail to get superblock data!\n");
+		return KBOX_FALSE;
+	}
+
+	if (kbox_proc_exist) {
+		kbox_printk_init_info_not_first(&kbox_super_block);
+		if (KBOX_TRUE !=
+		    kbox_read_printk_info(g_printk_info_buf,
+					  &g_printk_ctrl_block_tmp)) {
+			g_printk_ctrl_block_tmp.end = 0;
+			g_printk_ctrl_block_tmp.valid_len = 0;
+		}
+	} else {
+		kbox_printk_init_info_first(&kbox_super_block);
+	}
+
+	kbox_super_block.checksum = 0;
+	kbox_super_block.checksum =
+	    ~((unsigned char)
+	      Kbox_checksum((char *)&kbox_super_block,
+			(unsigned int)sizeof(struct image_super_block_s))) + 1;
+	write_len =
+	    kbox_write_to_ram(SECTION_KERNEL_OFFSET,
+			      (unsigned int)sizeof(struct image_super_block_s),
+			      (char *)&kbox_super_block, KBOX_SECTION_KERNEL);
+	if (write_len <= 0) {
+		KBOX_MSG("fail to write superblock data!\n");
+		return KBOX_FALSE;
+	}
+
+	return KBOX_TRUE;
+}
+
+void kbox_ouput_printk_info(void)
+{
+	unsigned int start_tmp = 0;
+	unsigned int end_tmp = 0;
+	unsigned int len_tmp = 0;
+	unsigned long flags = 0;
+
+	if (unlikely((!g_printk_info_buf) || (!g_printk_info_buf_tmp)))
+		return;
+
+	if (g_printk_init_ok != KBOX_TRUE)
+		return;
+
+	spin_lock_irqsave(&g_printk_buf_lock, flags);
+	if (g_printk_ctrl_block_tmp.valid_len == 0) {
+		spin_unlock_irqrestore(&g_printk_buf_lock, flags);
+		return;
+	}
+
+	start_tmp = (g_printk_ctrl_block_tmp.start % SECTION_PRINTK_LEN);
+	end_tmp = ((g_printk_ctrl_block_tmp.end - 1) % SECTION_PRINTK_LEN);
+	len_tmp = g_printk_ctrl_block_tmp.valid_len;
+
+	if (start_tmp > end_tmp) {
+		memcpy(g_printk_info_buf_tmp,
+			g_printk_info_buf + start_tmp,
+			len_tmp - start_tmp);	/*lint !e64 !e522 */
+		memcpy(g_printk_info_buf_tmp + len_tmp - start_tmp,
+			g_printk_info_buf,
+			end_tmp + 1);	/*lint !e64 !e522 */
+	} else {
+		memcpy(g_printk_info_buf_tmp,
+			g_printk_info_buf + start_tmp,
+			len_tmp);	/*lint !e64 !e522 */
+	}
+
+	spin_unlock_irqrestore(&g_printk_buf_lock, flags);
+
+	(void)kbox_write_printk_info(g_printk_info_buf_tmp,
+				     &g_printk_ctrl_block_tmp);
+
+}
+
+static void kbox_emit_printk_char(const char c)
+{
+	if (unlikely(!g_printk_info_buf))
+		return;
+
+	*(g_printk_info_buf +
+	  (g_printk_ctrl_block_tmp.end % SECTION_PRINTK_LEN)) = c;
+	g_printk_ctrl_block_tmp.end++;
+
+	if (g_printk_ctrl_block_tmp.end > SECTION_PRINTK_LEN)
+		g_printk_ctrl_block_tmp.start++;
+
+	if (g_printk_ctrl_block_tmp.end < SECTION_PRINTK_LEN)
+		g_printk_ctrl_block_tmp.valid_len++;
+
+}
+
+static int kbox_duplicate_printk_info(const char *printk_buf,
+				      unsigned int buf_len)
+{
+	unsigned int idx = 0;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&g_printk_buf_lock, flags);
+	for (idx = 0; idx < buf_len; idx++)
+		kbox_emit_printk_char(*printk_buf++);
+
+	spin_unlock_irqrestore(&g_printk_buf_lock, flags);
+
+	return buf_len;
+}
+
+int kbox_dump_printk_info(const char *fmt, ...)
+{
+	va_list args;
+	int num = 0;
+	char tmp_buf[TMP_BUF_SIZE] = { };
+
+	if (g_printk_init_ok != KBOX_TRUE)
+		return 0;
+
+	va_start(args, fmt);	/*lint !e530*/
+
+	num = vsnprintf(tmp_buf, sizeof(tmp_buf) - 1, fmt, args);
+	if (num >= 0)
+		(void)kbox_duplicate_printk_info(tmp_buf, num);
+
+	va_end(args);
+
+	return num;
+}
+
+static void kbox_printk_info_write(struct console *pconsole,
+				   const char *printk_buf, unsigned int buf_len)
+{
+	UNUSED(pconsole);
+
+	if (unlikely(!printk_buf))
+		return;
+
+	(void)kbox_duplicate_printk_info(printk_buf, buf_len);
+}
+
+int kbox_printk_init(int kbox_proc_exist)
+{
+	int ret = KBOX_TRUE;
+
+	g_printk_info_buf = kmalloc(SECTION_PRINTK_LEN,
+					GFP_KERNEL); /*lint !e64*/
+	if (IS_ERR(g_printk_info_buf) || (!g_printk_info_buf)) {
+		KBOX_MSG("kmalloc g_printk_info_buf fail!\n");
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	memset(g_printk_info_buf, 0, SECTION_PRINTK_LEN);
+
+	g_printk_info_buf_tmp = kmalloc(SECTION_PRINTK_LEN,
+						GFP_KERNEL); /*lint !e64*/
+	if (IS_ERR(g_printk_info_buf_tmp) || (g_printk_info_buf_tmp == NULL)) {
+		KBOX_MSG("kmalloc g_printk_info_buf_tmp fail!\n");
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	memset(g_printk_info_buf_tmp, 0, SECTION_PRINTK_LEN);
+
+	ret = kbox_printk_init_info(kbox_proc_exist);
+	if (ret != KBOX_TRUE) {
+		KBOX_MSG("kbox_printk_init_info failed!\n");
+		goto fail;
+	}
+
+	register_console(&g_printk_console);
+
+	g_printk_init_ok = KBOX_TRUE;
+
+	return ret;
+fail:
+
+	kfree(g_printk_info_buf);
+	g_printk_info_buf = NULL;
+
+	kfree(g_printk_info_buf_tmp);
+	g_printk_info_buf_tmp = NULL;
+
+	return ret;
+}
+
+void kbox_printk_exit(void)
+{
+	int ret = 0;
+
+	if (g_printk_init_ok != KBOX_TRUE)
+		return;
+
+	kfree(g_printk_info_buf);
+	g_printk_info_buf = NULL;
+
+	kfree(g_printk_info_buf_tmp);
+	g_printk_info_buf_tmp = NULL;
+
+	ret = unregister_console(&g_printk_console);
+	if (ret)
+		KBOX_MSG("unregister_console failed!\n");
+}
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_printk.h b/drivers/net/ethernet/huawei/ibma/kbox_printk.h
new file mode 100644
index 0000000..e88afb1
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_printk.h
@@ -0,0 +1,35 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+
+#ifndef _KBOX_PRINTK_H_
+#define _KBOX_PRINTK_H_
+#include "kbox_ram_image.h"
+
+struct printk_ctrl_block_tmp_s {
+	int            printk_region;
+	enum kbox_section_e  section;
+	unsigned int   start;
+	unsigned int   end;
+	unsigned int   valid_len;/* valid length of printk section */
+};
+
+int  kbox_printk_init(int kbox_proc_exist);
+void kbox_ouput_printk_info(void);
+int  kbox_dump_printk_info(const char *fmt, ...);
+void kbox_printk_exit(void);
+
+#endif
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_ram_drive.c b/drivers/net/ethernet/huawei/ibma/kbox_ram_drive.c
new file mode 100644
index 0000000..1d0e4a5
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_ram_drive.c
@@ -0,0 +1,212 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/fs.h>		/* everything... */
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <asm/ioctls.h>
+#include <linux/slab.h>
+#include "kbox_include.h"
+#include "kbox_ram_drive.h"
+#include "kbox_main.h"
+#include "kbox_ram_image.h"
+#include "kbox_ram_op.h"
+
+#define KBOX_DEVICE_NAME "kbox"
+#define KBOX_DEVICE_MINOR 255
+
+static struct kbox_dev_s *g_kbox_dev;
+/*lint -e145*/
+static ssize_t kbox_read(struct file *filp, char __user *data, size_t count,
+			 loff_t *ppos);
+static ssize_t kbox_write(struct file *filp, const char __user *data,
+			  size_t count, loff_t *ppos);
+/*lint +e145*/
+
+#if (KERNEL_VERSION(3, 0, 0) < LINUX_VERSION_CODE)
+static long kbox_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+#else
+static int kbox_ioctl(struct inode *inode, struct file *filp, unsigned int cmd,
+		      unsigned long arg);
+#endif
+static int kbox_mmap(struct file *filp, struct vm_area_struct *vma);
+static int kbox_open(struct inode *inode, struct file *filp);
+static int kbox_release(struct inode *inode, struct file *filp);
+
+const struct file_operations kbox_fops = {
+	.owner = THIS_MODULE,
+	.read = kbox_read,
+	.write = kbox_write,
+#if (KERNEL_VERSION(3, 0, 0) < LINUX_VERSION_CODE)
+	.unlocked_ioctl = kbox_ioctl,
+#else
+	.ioctl = kbox_ioctl,
+#endif
+	.mmap = kbox_mmap,
+	.open = kbox_open,
+	.release = kbox_release,
+};
+
+static struct miscdevice kbox_device = {
+	KBOX_DEVICE_MINOR,
+	KBOX_DEVICE_NAME,
+	&kbox_fops,
+};
+
+static ssize_t kbox_read(struct file *filp, char __user *data, size_t count,
+			 loff_t *ppos)
+{
+	int read_len = 0;
+
+	if ((!filp) || (!data) || (!ppos)) {
+		KBOX_MSG("input NULL point!\n");
+		return -EFAULT;
+	}
+
+	read_len = kbox_read_op((unsigned long)(*ppos),
+				count,
+				data,
+				KBOX_SECTION_USER);
+	if (read_len < 0)
+		return -EFAULT;
+
+	*ppos += read_len;	/*lint !e56 !e110 */
+
+	return read_len;
+}
+
+static ssize_t kbox_write(struct file *filp, const char __user *data,
+			  size_t count, loff_t *ppos)
+{
+	int write_len = 0;
+
+	if ((!filp) || (!data) || (!ppos)) {
+		KBOX_MSG("input NULL point!\n");
+		return -EFAULT;
+	}
+
+	write_len = kbox_write_op((unsigned long)(*ppos),
+				count,
+				data,
+				KBOX_SECTION_USER);
+	if (write_len < 0)
+		return -EFAULT;
+
+	*ppos += write_len;
+
+	return write_len;
+}
+
+#if (KERNEL_VERSION(3, 0, 0) < LINUX_VERSION_CODE)
+static long kbox_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+#else
+static int kbox_ioctl(struct inode *pinode, struct file *filp, unsigned int cmd,
+		      unsigned long arg)
+#endif
+{
+	UNUSED(filp);
+
+	if (kbox_ioctl_detail(cmd, arg) < 0)
+		return -ENOTTY;
+
+	return 0;
+}
+
+static int kbox_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+
+	if ((!filp) || (!vma)) {
+		KBOX_MSG("input NULL point!\n");
+		return -EFAULT;
+	}
+
+	if (kbox_mmap_ram(filp, vma, KBOX_SECTION_USER) < 0)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int kbox_open(struct inode *pinode, struct file *filp)
+{
+	UNUSED(pinode);
+
+	if ((g_kbox_dev) && (!atomic_dec_and_test(&g_kbox_dev->au_count))) {
+		atomic_inc(&g_kbox_dev->au_count);
+		KBOX_MSG("EBUSY\n");
+		return -EBUSY;
+	}
+
+	filp->private_data = (void *)g_kbox_dev;
+
+	return 0;
+}
+
+int kbox_release(struct inode *pinode, struct file *filp)
+{
+	struct kbox_dev_s *kbox_dev = (struct kbox_dev_s *)filp->private_data;
+
+	UNUSED(pinode);
+
+	KBOX_MSG("\n");
+
+	if (kbox_dev)
+		atomic_inc(&kbox_dev->au_count);
+
+	return 0;
+}
+
+int kbox_drive_init(void)
+{
+	int ret = 0;
+
+	KBOX_MSG("\n");
+
+	g_kbox_dev =
+	    kmalloc(sizeof(struct kbox_dev_s), GFP_KERNEL); /*lint !e64*/
+	if (!g_kbox_dev)
+		return -ENOMEM;
+
+	ret = misc_register(&kbox_device);
+	if (ret)
+		goto fail;
+
+	atomic_set(&g_kbox_dev->au_count, 1);
+
+	KBOX_MSG("ok!\n");
+
+	return ret;
+
+fail:
+	kfree(g_kbox_dev);
+	g_kbox_dev = NULL;
+
+	return ret;
+}
+
+void kbox_drive_cleanup(void)
+{
+	if (!g_kbox_dev)
+		return;
+
+#if (KERNEL_VERSION(4, 4, 0) < LINUX_VERSION_CODE)
+	misc_deregister(&kbox_device);
+#else
+	(void)misc_deregister(&kbox_device);
+#endif
+
+	kfree(g_kbox_dev);
+	g_kbox_dev = NULL;
+
+}
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_ram_drive.h b/drivers/net/ethernet/huawei/ibma/kbox_ram_drive.h
new file mode 100644
index 0000000..3231cbc
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_ram_drive.h
@@ -0,0 +1,33 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+
+#ifndef _KBOX_RAM_DRIVE_H_
+#define _KBOX_RAM_DRIVE_H_
+
+#include <linux/types.h>
+#include <linux/atomic.h>
+
+struct kbox_dev_s {
+	atomic_t au_count;
+
+	struct kbox_pci_dev_s *kbox_pci_dev;
+};
+
+int kbox_drive_init(void);
+void kbox_drive_cleanup(void);
+
+#endif
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_ram_image.c b/drivers/net/ethernet/huawei/ibma/kbox_ram_image.c
new file mode 100644
index 0000000..0b9ac6f
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_ram_image.c
@@ -0,0 +1,138 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "kbox_include.h"
+#include "kbox_main.h"
+#include "kbox_ram_image.h"
+
+/*lint -e124*/
+void __iomem *kbox_get_section_addr(enum kbox_section_e  kbox_section)
+{
+	void __iomem *kbox_addr = kbox_get_base_addr();
+	unsigned long kbox_len = kbox_get_io_len();
+
+	if ((!kbox_addr) || (kbox_len == 0)) {
+		KBOX_MSG("get kbox_addr or kbox_len failed!\n");
+		return NULL;
+	}
+
+	switch (kbox_section) {
+	case KBOX_SECTION_KERNEL:
+		return kbox_addr;
+
+	case KBOX_SECTION_PANIC:
+		return kbox_addr + SECTION_KERNEL_LEN;
+
+	case KBOX_SECTION_THREAD:
+		return kbox_addr + SECTION_KERNEL_LEN + SECTION_PANIC_LEN;
+
+	case KBOX_SECTION_PRINTK1:
+		return kbox_addr + (kbox_len - (2 * SECTION_PRINTK_LEN) -
+				    SECTION_USER_LEN);
+
+	case KBOX_SECTION_PRINTK2:
+		return kbox_addr + (kbox_len - SECTION_PRINTK_LEN -
+				    SECTION_USER_LEN);
+
+	case KBOX_SECTION_USER:
+		return kbox_addr + (kbox_len - SECTION_USER_LEN);
+
+	case KBOX_SECTION_ALL:
+		return kbox_addr;
+
+	default:
+		KBOX_MSG("input kbox_section error!\n");
+		return NULL;
+	}
+}
+/*lint -e124*/
+
+unsigned long kbox_get_section_len(enum kbox_section_e  kbox_section)
+{
+	unsigned long kbox_len = kbox_get_io_len();
+
+	if (kbox_len == 0) {
+		KBOX_MSG("get kbox_len failed!\n");
+		return 0;
+	}
+
+	switch (kbox_section) {
+	case KBOX_SECTION_KERNEL:
+		return SECTION_KERNEL_LEN;
+
+	case KBOX_SECTION_PANIC:
+		return SECTION_PANIC_LEN;
+
+	case KBOX_SECTION_THREAD:
+		return (kbox_len - (2 * SECTION_PRINTK_LEN) -
+			SECTION_USER_LEN - SECTION_KERNEL_LEN -
+			SECTION_PANIC_LEN);
+
+	case KBOX_SECTION_PRINTK1:
+	case KBOX_SECTION_PRINTK2:
+		return SECTION_PRINTK_LEN;
+
+	case KBOX_SECTION_USER:
+		return SECTION_USER_LEN;
+
+	case KBOX_SECTION_ALL:
+		return kbox_len - SECTION_KERNEL_LEN;
+
+	default:
+		KBOX_MSG("input kbox_section error!\n");
+		return 0;
+	}
+}
+
+unsigned long kbox_get_section_phy_addr(enum kbox_section_e  kbox_section)
+{
+	unsigned long kbox_phy_addr = kbox_get_base_phy_addr();
+	unsigned long kbox_len = kbox_get_io_len();
+
+	if ((kbox_phy_addr == 0) || (kbox_len == 0)) {
+		KBOX_MSG("get kbox_phy_addr or kbox_len failed!\n");
+		return 0;
+	}
+
+	switch (kbox_section) {
+	case KBOX_SECTION_KERNEL:
+		return kbox_phy_addr;
+
+	case KBOX_SECTION_PANIC:
+		return kbox_phy_addr + SECTION_KERNEL_LEN;
+
+	case KBOX_SECTION_THREAD:
+		return kbox_phy_addr + SECTION_KERNEL_LEN + SECTION_PANIC_LEN;
+
+	case KBOX_SECTION_PRINTK1:
+		return kbox_phy_addr + (kbox_len - (2 * SECTION_PRINTK_LEN) -
+					SECTION_USER_LEN);
+
+	case KBOX_SECTION_PRINTK2:
+		return kbox_phy_addr + (kbox_len - SECTION_PRINTK_LEN -
+					SECTION_USER_LEN);
+
+	case KBOX_SECTION_USER:
+		return kbox_phy_addr + (kbox_len - SECTION_USER_LEN);
+
+	case KBOX_SECTION_ALL:
+		return kbox_phy_addr;
+
+	default:
+		KBOX_MSG("input kbox_section error!\n");
+		return 0;
+	}
+}
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_ram_image.h b/drivers/net/ethernet/huawei/ibma/kbox_ram_image.h
new file mode 100644
index 0000000..4d7513a
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_ram_image.h
@@ -0,0 +1,91 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _KBOX_RAM_IMAGE_H_
+#define _KBOX_RAM_IMAGE_H_
+
+enum kbox_section_e {
+	KBOX_SECTION_KERNEL = 1,
+	KBOX_SECTION_PANIC = 2,
+	KBOX_SECTION_THREAD = 3,
+	KBOX_SECTION_PRINTK1 = 4,
+	KBOX_SECTION_PRINTK2 = 5,
+	KBOX_SECTION_USER = 6,
+	KBOX_SECTION_ALL = 7
+};
+
+#define KBOX_BIG_ENDIAN (0x2B)
+#define KBOX_LITTLE_ENDIAN (0xB2)
+#define IMAGE_VER (0x0001)
+#define IMAGE_MAGIC (0xB202C086)
+#define VALID_IMAGE(x) (IMAGE_MAGIC == (x)->magic_flag)
+#define SLOT_NUM (8)
+#define SLOT_LENGTH (16 * 1024)
+#define MAX_RECORD_NO (0xFF)
+#define MAX_USE_NUMS (0xFF)
+
+#define PRINTK_NUM (2)
+#define PRINTK_CURR_FLAG ("curr")
+#define PRINTK_LAST_FLAG ("last")
+#define PRINTK_FLAG_LEN (4)
+
+struct panic_ctrl_block_s {
+	unsigned char use_nums;
+	unsigned char number;
+	unsigned short len;
+	unsigned int time;
+};
+
+struct thread_info_ctrl_block_s {
+	unsigned int thread_info_len;
+};
+
+struct printk_info_ctrl_block_s {
+	unsigned char flag[PRINTK_FLAG_LEN];
+	unsigned int len;
+};
+
+struct image_super_block_s {
+	unsigned char byte_order;
+	unsigned char checksum;
+	unsigned short version;
+	unsigned int magic_flag;
+	unsigned int panic_nums;
+	struct panic_ctrl_block_s panic_ctrl_blk[SLOT_NUM];
+	struct printk_info_ctrl_block_s printk_ctrl_blk[PRINTK_NUM];
+	struct thread_info_ctrl_block_s thread_ctrl_blk;
+};
+
+#define SECTION_KERNEL_LEN (sizeof(struct image_super_block_s))
+#define SECTION_PANIC_LEN (8 * SLOT_LENGTH)
+
+#if (KERNEL_VERSION(2, 6, 18) >= LINUX_VERSION_CODE)
+#define SECTION_PRINTK_LEN (128 * 1024)
+#else
+#define SECTION_PRINTK_LEN (512 * 1024)
+#endif
+
+#define SECTION_USER_LEN (2 * 1024 * 1024)
+
+#define SECTION_KERNEL_OFFSET (0)
+#define SECTION_PANIC_OFFSET SECTION_KERNEL_LEN
+#define SECTION_THREAD_OFFSET (SECTION_KERNEL_LEN + SECTION_PANIC_LEN)
+
+void __iomem *kbox_get_section_addr(enum kbox_section_e  kbox_section);
+unsigned long kbox_get_section_len(enum kbox_section_e  kbox_section);
+unsigned long kbox_get_section_phy_addr(enum kbox_section_e  kbox_section);
+
+#endif
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_ram_op.c b/drivers/net/ethernet/huawei/ibma/kbox_ram_op.c
new file mode 100644
index 0000000..ed329a4
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_ram_op.c
@@ -0,0 +1,1003 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/version.h>
+#if (KERNEL_VERSION(2, 6, 18) >= LINUX_VERSION_CODE)
+#include <asm/semaphore.h>
+#else
+#include <linux/semaphore.h>
+#endif
+#include <linux/slab.h>
+#include <linux/capability.h>
+#include <linux/uaccess.h>		/* copy_*_user */
+#include <linux/delay.h>		/* udelay */
+#include <linux/mm.h>
+#include "kbox_include.h"
+#include "kbox_main.h"
+#include "kbox_ram_image.h"
+#include "kbox_ram_op.h"
+
+#ifndef VM_RESERVED
+#define VM_RESERVED 0x00080000
+#endif
+
+#if (KERNEL_VERSION(3, 0, 0) < LINUX_VERSION_CODE)
+
+static DEFINE_SPINLOCK(g_kbox_super_block_lock);
+static DEFINE_SEMAPHORE(user_sem);
+#else
+static spinlock_t g_kbox_super_block_lock = SPIN_LOCK_UNLOCKED;
+static DECLARE_MUTEX(user_sem);
+#endif
+
+union char_int_transfer_u {
+	int data_int;
+	char data_char[KBOX_RW_UNIT];
+};
+
+static struct image_super_block_s g_kbox_super_block = { };
+
+void kbox_write_to_pci(void __iomem *dest, const void *src, int len,
+		       unsigned long offset)
+{
+	union char_int_transfer_u transfer = { };
+	int idx = 0;
+	int j = 0;
+	int four_byte_len = 0;
+	int left_len = 0;
+	char *src_temp = (char *)src;
+	char *dest_temp = (char *)dest;
+	int first_write_num = 0;
+
+	if ((offset % KBOX_RW_UNIT) != 0) {
+		transfer.data_int =
+		    *(int *)(dest_temp + offset - (offset % KBOX_RW_UNIT));
+		/*lint -e123*/
+		rmb();/* memory barriers. */
+		first_write_num =
+		    ((len + (offset % KBOX_RW_UNIT)) >
+		     KBOX_RW_UNIT) ? (KBOX_RW_UNIT -
+				      (offset % KBOX_RW_UNIT)) : len;
+		for (idx = (int)(offset % KBOX_RW_UNIT);
+		     idx < (int)(first_write_num + (offset % KBOX_RW_UNIT));
+		     idx++) {
+			if (!src_temp)
+				return;
+
+			transfer.data_char[idx] = *src_temp;
+			src_temp++;
+		}
+		*(int *)(dest_temp + offset - (offset % KBOX_RW_UNIT)) =
+		    transfer.data_int;
+		wmb();/* memory barriers. */
+		len -= first_write_num;
+		offset += first_write_num;
+	}
+
+	four_byte_len = (len / KBOX_RW_UNIT);
+	left_len = (len % KBOX_RW_UNIT);
+	for (idx = 0; idx < four_byte_len; idx++) {
+		for (j = 0; j < KBOX_RW_UNIT; j++) {
+			if (!src_temp)
+				return;
+
+			transfer.data_char[j] = *src_temp;
+			src_temp++;
+		}
+		*(int *)(dest_temp + offset) = transfer.data_int;
+		wmb();/* memory barriers. */
+		offset += KBOX_RW_UNIT;
+	}
+
+	if (left_len != 0) {
+		transfer.data_int = *(int *)(dest_temp + offset);
+		rmb();/* memory barriers. */
+		for (idx = 0; idx < left_len; idx++) {
+			if (!src_temp)
+				return;
+
+			transfer.data_char[idx] = *src_temp;
+			src_temp++;
+		}
+		*(int *)(dest_temp + offset) = transfer.data_int;
+		wmb();/* memory barriers. */
+		/*lint -e123*/
+	}
+
+	udelay(1);
+
+}
+
+void kbox_read_from_pci(void *dest, void __iomem *src, int len,
+			unsigned long offset)
+{
+	union char_int_transfer_u transfer = { };
+	int idx = 0;
+	int j = 0;
+	int four_byte_len = 0;
+	int left_len = 0;
+	char *dest_temp = (char *)dest;
+	char *src_temp = (char *)src;
+	int first_read_num = 0;
+
+	if ((offset % KBOX_RW_UNIT) != 0) {
+		transfer.data_int =
+		    *(int *)(src_temp + offset - (offset % KBOX_RW_UNIT));
+		first_read_num =
+		    ((len + (offset % KBOX_RW_UNIT)) >
+		     KBOX_RW_UNIT) ? (KBOX_RW_UNIT -
+				      (offset % KBOX_RW_UNIT)) : len;
+		rmb();/* memory barriers. */
+		for (idx = (int)(offset % KBOX_RW_UNIT);
+		     idx < (int)(first_read_num + (offset % KBOX_RW_UNIT));
+		     idx++) {
+			if (!dest_temp)
+				return;
+
+			*dest_temp = transfer.data_char[idx];
+			dest_temp++;
+		}
+		len -= first_read_num;
+		offset += first_read_num;
+	}
+
+	four_byte_len = (len / KBOX_RW_UNIT);
+	left_len = (len % KBOX_RW_UNIT);
+	for (idx = 0; idx < four_byte_len; idx++) {
+		transfer.data_int = *(int *)(src_temp + offset);
+		rmb();/* memory barriers. */
+		for (j = 0; j < KBOX_RW_UNIT; j++) {
+			if (!dest_temp)
+				return;
+
+			*dest_temp = transfer.data_char[j];
+			dest_temp++;
+		}
+		offset += KBOX_RW_UNIT;
+	}
+
+	if (left_len != 0) {
+		transfer.data_int = *(int *)(src_temp + offset);
+		rmb();/* memory barriers. */
+		for (idx = 0; idx < left_len; idx++) {
+			if (!dest_temp)
+				return;
+
+			*dest_temp = transfer.data_char[idx];
+			dest_temp++;
+		}
+	}
+
+}
+
+void kbox_memset_pci(void __iomem *dest, const char set_byte, int len,
+		     unsigned long offset)
+{
+	union char_int_transfer_u transfer = { };
+	int idx = 0;
+	int four_byte_len = 0;
+	int left_len = 0;
+	char *dest_temp = (char *)dest;
+	int first_memset_num = 0;
+
+	if ((offset % KBOX_RW_UNIT) != 0) {
+		transfer.data_int =
+		    *(int *)(dest_temp + offset - (offset % KBOX_RW_UNIT));
+		/*lint -e123 */
+		rmb();/* memory barriers. */
+		first_memset_num =
+		    ((len + (offset % KBOX_RW_UNIT)) >
+		     KBOX_RW_UNIT) ? (KBOX_RW_UNIT -
+				      (offset % KBOX_RW_UNIT)) : len;
+		for (idx = (int)(offset % KBOX_RW_UNIT);
+		     idx < (int)(first_memset_num + (offset % KBOX_RW_UNIT));
+		     idx++) {
+			transfer.data_char[idx] = set_byte;
+		}
+		*(int *)(dest_temp + offset - (offset % KBOX_RW_UNIT)) =
+		    transfer.data_int;
+		wmb();/* memory barriers. */
+		len -= first_memset_num;
+		offset += first_memset_num;
+	}
+
+	four_byte_len = (len / KBOX_RW_UNIT);
+	left_len = (len % KBOX_RW_UNIT);
+	for (idx = 0; idx < KBOX_RW_UNIT; idx++)
+		transfer.data_char[idx] = set_byte;
+
+	for (idx = 0; idx < four_byte_len; idx++) {
+		*(int *)(dest_temp + offset) = transfer.data_int;
+		wmb();/* memory barriers. */
+		offset += KBOX_RW_UNIT;
+	}
+
+	if (left_len != 0) {
+		transfer.data_int = *(int *)(dest_temp + offset);
+		rmb();/* memory barriers. */
+		for (idx = 0; idx < left_len; idx++)
+			transfer.data_char[idx] = set_byte;
+
+		*(int *)(dest_temp + offset) = transfer.data_int;
+		wmb();/* memory barriers. */
+	}
+
+	udelay(1);
+
+}
+
+int kbox_read_from_ram(unsigned long offset, unsigned int count, char *data,
+		       enum kbox_section_e  section)
+{
+	unsigned int read_len_total = count;
+	unsigned long offset_temp = offset;
+	void __iomem *kbox_section_addr = kbox_get_section_addr(section);
+	unsigned long kbox_section_len = kbox_get_section_len(section);
+	unsigned int read_len_real = 0;
+
+	if (!data) {
+		KBOX_MSG("input NULL point!\n");
+		return -EFAULT;
+	}
+
+	if ((!kbox_section_addr) || (kbox_section_len == 0)) {
+		KBOX_MSG("get kbox_section_addr or kbox_section_len failed!\n");
+		return -EFAULT;
+	}
+
+	if (offset >= kbox_section_len) {
+		KBOX_MSG("input offset is error!\n");
+		return -EFAULT;
+	}
+
+	if ((offset + count) > kbox_section_len)
+		read_len_total = (unsigned int)(kbox_section_len - offset);
+
+	while (1) {
+		unsigned int read_bytes = 0;
+
+		if (read_len_real >= count)
+			break;
+
+		read_bytes =
+		    (read_len_total >
+		     TEMP_BUF_SIZE) ? TEMP_BUF_SIZE : read_len_total;
+
+		kbox_read_from_pci(data, kbox_section_addr, read_bytes,
+				   offset_temp);
+
+		read_len_total -= read_bytes;
+		read_len_real += read_bytes;
+		data += read_bytes;
+		offset_temp += read_bytes;
+	}
+
+	return (int)read_len_real;
+}
+
+int kbox_write_to_ram(unsigned long offset, unsigned int count,
+		      const char *data, enum kbox_section_e  section)
+{
+	unsigned int write_len_total = count;
+	unsigned long offset_temp = offset;
+	void __iomem *kbox_section_addr = kbox_get_section_addr(section);
+	unsigned long kbox_section_len = kbox_get_section_len(section);
+	unsigned int write_len_real = 0;
+
+	if (!data) {
+		KBOX_MSG("input NULL point!\n");
+		return -EFAULT;
+	}
+
+	if ((!kbox_section_addr) || (kbox_section_len == 0)) {
+		KBOX_MSG("get kbox_section_addr or kbox_section_len failed!\n");
+		return -EFAULT;
+	}
+
+	if (offset >= kbox_section_len) {
+		KBOX_MSG("input offset is error!\n");
+		return -EFAULT;
+	}
+
+	if ((offset + count) > kbox_section_len)
+		write_len_total = (unsigned int)(kbox_section_len - offset);
+
+	KBOX_MSG("struct image_super_block_s = %x\n", count);
+	while (1) {
+		unsigned int write_bytes = 0;
+
+		if (write_len_real >= count) {
+			KBOX_MSG("write_len_real = %x\n", write_len_real);
+			break;
+		}
+		KBOX_MSG("write_len_total = %x\n", write_len_total);
+
+		write_bytes =
+		    (write_len_total >
+		     TEMP_BUF_SIZE) ? TEMP_BUF_SIZE : write_len_total;
+		KBOX_MSG("write_bytes = %x\n", write_bytes);
+
+		kbox_write_to_pci(kbox_section_addr, data, write_bytes,
+				  offset_temp);
+
+		write_len_total -= write_bytes;
+		write_len_real += write_bytes;
+		data += write_bytes;
+		offset_temp += write_bytes;
+	}
+
+	return (int)write_len_real;
+}
+
+int kbox_memset_ram(unsigned long offset, unsigned int count,
+		    const char set_byte, enum kbox_section_e  section)
+{
+	unsigned int memset_len = count;
+	void __iomem *kbox_section_addr = kbox_get_section_addr(section);
+	unsigned long kbox_section_len = kbox_get_section_len(section);
+
+	if ((!kbox_section_addr) || (kbox_section_len == 0)) {
+		KBOX_MSG("get kbox_section_addr or kbox_section_len failed!\n");
+		return -EFAULT;
+	}
+
+	if (offset >= kbox_section_len) {
+		KBOX_MSG("input offset is error!\n");
+		return -EFAULT;
+	}
+
+	if ((offset + count) > kbox_section_len)
+		memset_len = (unsigned int)(kbox_section_len - offset);
+
+	kbox_memset_pci(kbox_section_addr, set_byte, memset_len, offset);
+
+	return KBOX_TRUE;
+}
+
+int kbox_read_op(unsigned long offset, unsigned int count, char __user *data,
+		 enum kbox_section_e  section)
+{
+	unsigned int read_len = 0;
+	unsigned int left_len = count;
+	char *user_buf = data;
+	char *temp_buf_char = NULL;
+	unsigned long offset_tmp = offset;
+
+	if (!data) {
+		KBOX_MSG("input NULL point!\n");
+		return -EFAULT;
+	}
+
+	if (down_interruptible(&user_sem) != 0)
+		return KBOX_FALSE;
+
+	temp_buf_char = kmalloc(TEMP_BUF_DATA_SIZE, GFP_KERNEL); /*lint !e64*/
+	if (IS_ERR(temp_buf_char)) {
+		KBOX_MSG("kmalloc temp_buf_char fail!\n");
+		up(&user_sem);
+		return -ENOMEM;
+	}
+	memset((void *)temp_buf_char, 0, TEMP_BUF_DATA_SIZE);
+
+	while (1) {
+		unsigned int read_bytes = 0;
+
+		if (read_len >= count)
+			break;
+
+		read_bytes =
+		    (left_len >
+		     TEMP_BUF_DATA_SIZE) ? TEMP_BUF_DATA_SIZE : left_len;
+
+		if (kbox_read_from_ram
+		    (offset_tmp, read_bytes, temp_buf_char, section) < 0) {
+			KBOX_MSG("kbox_read_from_ram fail!\n");
+			break;
+		}
+
+		if (copy_to_user(user_buf, temp_buf_char, read_bytes)) {
+			KBOX_MSG("copy_to_user fail!\n");
+			break;
+		}
+
+		left_len -= read_bytes;
+		read_len += read_bytes;
+		user_buf += read_bytes;
+
+		offset_tmp += read_bytes;
+		memset((void *)temp_buf_char, 0, TEMP_BUF_DATA_SIZE);
+
+		msleep(20);
+	}
+
+	kfree(temp_buf_char);
+
+	up(&user_sem);
+
+	return (int)read_len;
+}
+
+int kbox_write_op(unsigned long offset, unsigned int count,
+		  const char __user *data, enum kbox_section_e  section)
+{
+	unsigned int write_len = 0;
+	unsigned int left_len = count;
+	const char *user_buf = data;
+	char *temp_buf_char = NULL;
+	unsigned long offset_tmp = offset;
+
+	if (!data) {
+		KBOX_MSG("input NULL point!\n");
+		return -EFAULT;
+	}
+
+	if (down_interruptible(&user_sem) != 0)
+		return KBOX_FALSE;
+
+	temp_buf_char = kmalloc(TEMP_BUF_DATA_SIZE, GFP_KERNEL); /*lint !e64*/
+	if (!temp_buf_char || IS_ERR(temp_buf_char)) {
+		KBOX_MSG("kmalloc temp_buf_char fail!\n");
+		up(&user_sem);
+		return -ENOMEM;
+	}
+
+	memset((void *)temp_buf_char, 0, TEMP_BUF_DATA_SIZE);
+
+	while (1) {
+		unsigned int write_bytes = 0;
+
+		if (write_len >= count)
+			break;
+
+		write_bytes =
+		    (left_len >
+		     TEMP_BUF_DATA_SIZE) ? TEMP_BUF_DATA_SIZE : left_len;
+
+		if (copy_from_user(temp_buf_char, user_buf, write_bytes)) {
+			KBOX_MSG("copy_from_user fail!\n");
+			break;
+		}
+
+		if (kbox_write_to_ram
+		    (offset_tmp, write_bytes, temp_buf_char, section) < 0) {
+			KBOX_MSG("kbox_write_to_ram fail!\n");
+			break;
+		}
+
+		left_len -= write_bytes;
+		write_len += write_bytes;
+		user_buf += write_bytes;
+
+		offset_tmp += write_bytes;
+		memset((void *)temp_buf_char, 0, TEMP_BUF_DATA_SIZE);
+
+		msleep(20);
+	}
+
+	kfree(temp_buf_char);
+
+	up(&user_sem);
+
+	return (int)write_len;
+}
+
+char Kbox_checksum(char *input_buf, unsigned int len)
+{
+	unsigned int idx = 0;
+	char checksum = 0;
+
+	for (idx = 0; idx < len; idx++)
+		checksum += input_buf[idx];
+
+	return checksum;
+}
+
+static int Kbox_update_super_block(void)
+{
+	int write_len = 0;
+
+	g_kbox_super_block.checksum = 0;
+	g_kbox_super_block.checksum =
+	    ~((unsigned char)
+	      Kbox_checksum((char *)&g_kbox_super_block,
+			(unsigned int)sizeof(struct image_super_block_s))) + 1;
+	write_len =
+	    kbox_write_to_ram(SECTION_KERNEL_OFFSET,
+			      (unsigned int)sizeof(struct image_super_block_s),
+			      (char *)&g_kbox_super_block, KBOX_SECTION_KERNEL);
+	if (write_len <= 0) {
+		KBOX_MSG("fail to write superblock data!\n");
+		return KBOX_FALSE;
+	}
+
+	return KBOX_TRUE;
+}
+
+int Kbox_read_super_block(void)
+{
+	int read_len = 0;
+
+	read_len =
+	    kbox_read_from_ram(SECTION_KERNEL_OFFSET,
+			       (unsigned int)sizeof(struct image_super_block_s),
+			       (char *)&g_kbox_super_block,
+			       KBOX_SECTION_KERNEL);
+	if (read_len != sizeof(struct image_super_block_s)) {
+		KBOX_MSG("fail to get superblock data!\n");
+		return KBOX_FALSE;
+	}
+
+	return KBOX_TRUE;
+}
+
+static unsigned char Kbox_get_byte_order(void)
+{
+	unsigned short data_short = 0xB22B;
+	unsigned char *data_char = (unsigned char *)&data_short;
+
+	return (unsigned char)((*data_char == 0xB2) ? KBOX_BIG_ENDIAN :
+			       KBOX_LITTLE_ENDIAN);
+}
+
+int kbox_super_block_init(void)
+{
+	int ret = 0;
+
+	ret = Kbox_read_super_block();
+	if (ret != KBOX_TRUE) {
+		KBOX_MSG("Kbox_read_super_block fail!\n");
+		return ret;
+	}
+
+	if (!VALID_IMAGE(&g_kbox_super_block)
+	    || 0 != Kbox_checksum((char *)&g_kbox_super_block,
+			(unsigned int)sizeof(struct image_super_block_s))) {
+		if (!VALID_IMAGE(&g_kbox_super_block)) {
+			memset((void *)&g_kbox_super_block, 0x00,
+			       sizeof(struct image_super_block_s));
+		}
+
+		g_kbox_super_block.byte_order = Kbox_get_byte_order();
+		g_kbox_super_block.version = IMAGE_VER;
+		g_kbox_super_block.magic_flag = IMAGE_MAGIC;
+	}
+
+	g_kbox_super_block.thread_ctrl_blk.thread_info_len = 0;
+
+	if (Kbox_update_super_block() != KBOX_TRUE) {
+		KBOX_MSG("Kbox_update_super_block failed!\n");
+		return KBOX_FALSE;
+	}
+
+	return KBOX_TRUE;
+}
+
+static unsigned char kbox_get_write_slot_num(void)
+{
+	struct panic_ctrl_block_s *panic_ctrl_block = NULL;
+	unsigned int idx = 0;
+	unsigned char slot_num = 0;
+	unsigned char min_use_nums = 0;
+
+	panic_ctrl_block = g_kbox_super_block.panic_ctrl_blk;
+	min_use_nums = panic_ctrl_block->use_nums;
+
+	for (idx = 1; idx < SLOT_NUM; idx++) {
+		panic_ctrl_block++;
+		if (panic_ctrl_block->use_nums < min_use_nums) {
+			min_use_nums = panic_ctrl_block->use_nums;
+			slot_num = (unsigned char)idx;
+		}
+	}
+
+	if (min_use_nums == MAX_USE_NUMS) {
+		panic_ctrl_block = g_kbox_super_block.panic_ctrl_blk;
+		for (idx = 0; idx < SLOT_NUM; idx++) {
+			panic_ctrl_block->use_nums = 1;
+			panic_ctrl_block++;
+		}
+	}
+
+	return slot_num;
+}
+
+static unsigned char kbox_get_new_record_number(void)
+{
+	struct panic_ctrl_block_s *panic_ctrl_block = NULL;
+	unsigned int idx = 0;
+	unsigned char max_number = 0;
+
+	panic_ctrl_block = g_kbox_super_block.panic_ctrl_blk;
+	for (idx = 0; idx < SLOT_NUM; idx++) {
+		if (panic_ctrl_block->number >= max_number)
+			max_number = panic_ctrl_block->number;
+
+		panic_ctrl_block++;
+	}
+
+	return (unsigned char)((max_number + 1) % MAX_RECORD_NO);
+}
+
+int kbox_write_panic_info(const char *input_data, unsigned int data_len)
+{
+	int write_len = 0;
+	unsigned int offset = 0;
+	struct panic_ctrl_block_s *panic_ctrl_block = NULL;
+	unsigned long time = get_seconds();
+	unsigned char slot_num = 0;
+	unsigned long flags = 0;
+
+	if ((!input_data) || (data_len == 0)) {
+		KBOX_MSG("input parameter error!\n");
+		return KBOX_FALSE;
+	}
+
+	if (data_len > SLOT_LENGTH)
+		data_len = SLOT_LENGTH;
+
+	spin_lock_irqsave(&g_kbox_super_block_lock, flags);
+
+	slot_num = kbox_get_write_slot_num();
+
+	panic_ctrl_block = &g_kbox_super_block.panic_ctrl_blk[slot_num];
+	panic_ctrl_block->use_nums++;
+
+	panic_ctrl_block->number = kbox_get_new_record_number();
+	panic_ctrl_block->len = 0;
+	panic_ctrl_block->time = (unsigned int)time;
+
+	g_kbox_super_block.panic_nums++;
+
+	spin_unlock_irqrestore(&g_kbox_super_block_lock, flags);
+
+	offset = slot_num * SLOT_LENGTH;
+	write_len =
+	    kbox_write_to_ram(offset, data_len, input_data, KBOX_SECTION_PANIC);
+	if (write_len <= 0) {
+		KBOX_MSG("fail to save panic information!\n");
+		return KBOX_FALSE;
+	}
+
+	spin_lock_irqsave(&g_kbox_super_block_lock, flags);
+
+	panic_ctrl_block->len += (unsigned short)write_len;
+
+	if (Kbox_update_super_block() != KBOX_TRUE) {
+		KBOX_MSG("Kbox_update_super_block failed!\n");
+		spin_unlock_irqrestore(&g_kbox_super_block_lock, flags);
+		return KBOX_FALSE;
+	}
+
+	spin_unlock_irqrestore(&g_kbox_super_block_lock, flags);
+
+	return KBOX_TRUE;
+}
+
+int kbox_write_thread_info(const char *input_data, unsigned int data_len)
+{
+	int write_len = 0;
+	unsigned int offset = 0;
+	unsigned long flags = 0;
+	unsigned int date_len_tmp = data_len;
+
+	if ((!input_data) || (date_len_tmp == 0)) {
+		KBOX_MSG("input parameter error!\n");
+		return KBOX_FALSE;
+	}
+
+	spin_lock_irqsave(&g_kbox_super_block_lock, flags);
+
+	offset = g_kbox_super_block.thread_ctrl_blk.thread_info_len;
+	write_len =
+	    kbox_write_to_ram(offset, date_len_tmp, input_data,
+			      KBOX_SECTION_THREAD);
+	if (write_len <= 0) {
+		KBOX_MSG("fail to save thread information!\n");
+		spin_unlock_irqrestore(&g_kbox_super_block_lock, flags);
+		return KBOX_FALSE;
+	}
+
+	g_kbox_super_block.thread_ctrl_blk.thread_info_len += write_len;
+
+	if (Kbox_update_super_block() != KBOX_TRUE) {
+		KBOX_MSG("Kbox_update_super_block failed!\n");
+		spin_unlock_irqrestore(&g_kbox_super_block_lock, flags);
+		return KBOX_FALSE;
+	}
+
+	spin_unlock_irqrestore(&g_kbox_super_block_lock, flags);
+
+	return KBOX_TRUE;
+}
+
+int kbox_read_printk_info(char *input_data,
+		struct printk_ctrl_block_tmp_s *printk_ctrl_block_tmp)
+{
+	int read_len = 0;
+	int printk_region = printk_ctrl_block_tmp->printk_region;
+	unsigned int len = 0;
+
+	if (!input_data) {
+		KBOX_MSG("input parameter error!\n");
+		return KBOX_FALSE;
+	}
+
+	len = g_kbox_super_block.printk_ctrl_blk[printk_region].len;
+	if (len <= 0) {
+		printk_ctrl_block_tmp->end = 0;
+		printk_ctrl_block_tmp->valid_len = 0;
+		return KBOX_TRUE;
+	}
+
+	read_len =
+	    kbox_read_from_ram(0, len, input_data,
+			       printk_ctrl_block_tmp->section);
+	if (read_len < 0) {
+		KBOX_MSG("fail to read printk information!(1)\n");
+		return KBOX_FALSE;
+	}
+
+	printk_ctrl_block_tmp->end = len;
+	printk_ctrl_block_tmp->valid_len = len;
+
+	return KBOX_TRUE;
+}
+
+int kbox_write_printk_info(const char *input_data,
+			struct printk_ctrl_block_tmp_s *printk_ctrl_block_tmp)
+{
+	int write_len = 0;
+	int printk_region = printk_ctrl_block_tmp->printk_region;
+	unsigned long flags = 0;
+	unsigned int len = 0;
+
+	if (!input_data) {
+		KBOX_MSG("input parameter error!\n");
+		return KBOX_FALSE;
+	}
+
+	len = printk_ctrl_block_tmp->valid_len;
+	write_len =
+	    kbox_write_to_ram(0, len, input_data,
+			      printk_ctrl_block_tmp->section);
+	if (write_len <= 0) {
+		KBOX_MSG("fail to save printk information!(1)\n");
+		return KBOX_FALSE;
+	}
+
+	spin_lock_irqsave(&g_kbox_super_block_lock, flags);
+
+	g_kbox_super_block.printk_ctrl_blk[printk_region].len = len;
+
+	if (Kbox_update_super_block() != KBOX_TRUE) {
+		KBOX_MSG("Kbox_update_super_block failed!\n");
+		spin_unlock_irqrestore(&g_kbox_super_block_lock, flags);
+		return KBOX_FALSE;
+	}
+
+	spin_unlock_irqrestore(&g_kbox_super_block_lock, flags);
+
+	return KBOX_TRUE;
+}
+
+static int kbox_read_region(unsigned long arg)
+{
+	unsigned int read_len = 0;
+	struct kbox_region_arg_s region_arg = { };
+
+	if (copy_from_user
+	    ((void *)&region_arg, (void __user *)arg,
+	     sizeof(struct kbox_region_arg_s))) {
+		KBOX_MSG("fail to copy_from_user!\n");
+		return KBOX_FALSE;
+	}
+
+	read_len = kbox_read_op(region_arg.offset, region_arg.count,
+				(char __user *)region_arg.data,
+				KBOX_SECTION_ALL);
+	if (read_len <= 0) {
+		KBOX_MSG("fail to get kbox data!\n");
+		return KBOX_FALSE;
+	}
+
+	if (copy_to_user
+	    ((void __user *)arg, (void *)&region_arg,
+	     sizeof(struct kbox_region_arg_s))) {
+		KBOX_MSG("fail to copy_to_user!\n");
+		return KBOX_FALSE;
+	}
+
+	return KBOX_TRUE;
+}
+
+static int kbox_writer_region(unsigned long arg)
+{
+	unsigned int write_len = 0;
+	struct kbox_region_arg_s region_arg = { };
+
+	if (copy_from_user
+	    ((void *)&region_arg, (void __user *)arg,
+	     sizeof(struct kbox_region_arg_s))) {
+		KBOX_MSG("fail to copy_from_user!\n");
+		return KBOX_FALSE;
+	}
+
+	write_len = kbox_write_op(region_arg.offset, region_arg.count,
+				  (char __user *)region_arg.data,
+				  KBOX_SECTION_ALL);
+	if (write_len <= 0) {
+		KBOX_MSG("fail to write kbox data!\n");
+		return KBOX_FALSE;
+	}
+
+	if (copy_to_user
+	    ((void __user *)arg, (void *)&region_arg,
+	     sizeof(struct kbox_region_arg_s))) {
+		KBOX_MSG("fail to copy_to_user!\n");
+		return KBOX_FALSE;
+	}
+
+	return KBOX_TRUE;
+}
+
+int kbox_clear_region(enum kbox_section_e  section)
+{
+	int ret = KBOX_TRUE;
+	unsigned long kbox_section_len = kbox_get_section_len(section);
+
+	if (kbox_section_len == 0) {
+		KBOX_MSG("get kbox_section_len failed!\n");
+		return -EFAULT;
+	}
+
+	ret = kbox_memset_ram(0, (unsigned int)kbox_section_len, 0, section);
+	if (ret != KBOX_TRUE) {
+		KBOX_MSG("kbox_memset_ram failed!\n");
+		return -EFAULT;
+	}
+
+	return KBOX_TRUE;
+}
+
+static int kbox_get_image_len(unsigned long arg)
+{
+	unsigned long __user *ptr = (unsigned long __user *)arg;
+	unsigned long kbox_len = 0;
+
+	kbox_len = kbox_get_section_len(KBOX_SECTION_ALL);
+	if (kbox_len == 0) {
+		KBOX_MSG("kbox_get_section_len section all fail!\n");
+		return -EFAULT;
+	}
+
+	return put_user(kbox_len, ptr);
+}
+
+static int kbox_get_user_region_len(unsigned long arg)
+{
+	unsigned long __user *ptr = (unsigned long __user *)arg;
+	unsigned long kbox_user_region_len = 0;
+
+	kbox_user_region_len = kbox_get_section_len(KBOX_SECTION_USER);
+	if (kbox_user_region_len == 0) {
+		KBOX_MSG("kbox_get_section_len section user fail!\n");
+		return -EFAULT;
+	}
+
+	/*lint -e123 */
+	return put_user(kbox_user_region_len, ptr);
+	/*lint +e123 */
+}
+
+static int kbox_ioctl_verify_cmd(unsigned int cmd, unsigned long arg)
+{
+
+	if ((arg == 0) || (_IOC_TYPE(cmd) != KBOX_IOC_MAGIC))
+		return KBOX_FALSE;
+
+	if (_IOC_NR(cmd) > KBOX_IOC_MAXNR)
+		return KBOX_FALSE;
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		KBOX_MSG("permit error\n");
+		return KBOX_FALSE;
+	}
+
+	return KBOX_TRUE;
+}
+
+int kbox_ioctl_detail(unsigned int cmd, unsigned long arg)
+{
+	if (kbox_ioctl_verify_cmd(cmd, arg) != KBOX_TRUE)
+		return -EFAULT;
+
+	switch (cmd) {
+	case GET_KBOX_TOTAL_LEN:	/*lint !e30 !e506 */
+		return kbox_get_image_len(arg);
+
+	case GET_KBOX_REGION_USER_LEN:	/*lint !e30 !e506 !e142 */
+		return kbox_get_user_region_len(arg);
+
+	case KBOX_REGION_READ:	/*lint !e30 !e506 !e142 */
+		return kbox_read_region(arg);
+
+	case KBOX_REGION_WRITE:	/*lint !e30 !e506 !e142 */
+		return kbox_writer_region(arg);
+
+	case CLEAR_KBOX_REGION_ALL:	/*lint !e30 !e506 */
+		return kbox_clear_region(KBOX_SECTION_ALL);
+
+	case CLEAR_KBOX_REGION_USER:	/*lint !e30 !e506 */
+		return kbox_clear_region(KBOX_SECTION_USER);
+
+	default:
+		return -ENOTTY;
+	}
+}
+
+int kbox_mmap_ram(struct file *pfile, struct vm_area_struct *vma,
+		  enum kbox_section_e  section)
+{
+	unsigned long kbox_section_phy_addr =
+	    kbox_get_section_phy_addr(section);
+	unsigned long kbox_section_len = kbox_get_section_len(section);
+	unsigned long offset = 0;
+	unsigned long length = 0;
+	unsigned long vm_size = 0;
+	int ret = 0;
+
+	UNUSED(pfile);
+
+	if ((kbox_section_phy_addr == 0) || (kbox_section_len == 0)) {
+		KBOX_MSG
+		    ("get kbox_section_phy_addr or kbox_section_len failed!\n");
+		return -EFAULT;
+	}
+
+	offset = vma->vm_pgoff << PAGE_SHIFT;
+	vm_size = vma->vm_end - vma->vm_start;
+
+	if (offset >= kbox_section_len) {
+		KBOX_MSG("vma offset is invalid!\n");
+		return -ESPIPE;
+	}
+
+	if (vma->vm_flags & VM_LOCKED) {
+		KBOX_MSG("vma is locked!\n");
+		return -EPERM;
+	}
+
+	length = kbox_section_len - offset;
+	if (vm_size > length) {
+		KBOX_MSG("vm_size is invalid!\n");
+		return -ENOSPC;
+	}
+
+	vma->vm_flags |= VM_RESERVED;
+	vma->vm_flags |= VM_IO;
+
+	ret = remap_pfn_range(vma,
+			      vma->vm_start,
+			      (unsigned long)(kbox_section_phy_addr >>
+					      PAGE_SHIFT), vm_size,
+			      vma->vm_page_prot);
+	if (ret) {
+		KBOX_MSG("remap_pfn_range failed! ret = %d\n", ret);
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
diff --git a/drivers/net/ethernet/huawei/ibma/kbox_ram_op.h b/drivers/net/ethernet/huawei/ibma/kbox_ram_op.h
new file mode 100644
index 0000000..f74a96f
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/kbox_ram_op.h
@@ -0,0 +1,77 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _KBOX_RAM_OP_H_
+#define _KBOX_RAM_OP_H_
+
+#include <asm/ioctls.h>
+
+
+#include "kbox_printk.h"
+
+
+#define KBOX_IOC_MAGIC (0xB2)
+
+#define GET_KBOX_TOTAL_LEN _IOR(KBOX_IOC_MAGIC, 0, unsigned long)
+
+#define GET_KBOX_REGION_USER_LEN  _IOR(KBOX_IOC_MAGIC, 1, unsigned long)
+
+#define CLEAR_KBOX_REGION_ALL _IO(KBOX_IOC_MAGIC, 2)
+
+#define CLEAR_KBOX_REGION_USER _IO(KBOX_IOC_MAGIC, 3)
+
+#define KBOX_REGION_READ _IOR(KBOX_IOC_MAGIC, 4, struct kbox_region_arg_s)
+
+#define KBOX_REGION_WRITE _IOW(KBOX_IOC_MAGIC, 5, struct kbox_region_arg_s)
+
+#define KBOX_IOC_MAXNR 6
+
+#define TEMP_BUF_SIZE (32 * 1024)
+#define TEMP_BUF_DATA_SIZE (128 * 1024)
+#define KBOX_RW_UNIT 4
+
+struct kbox_region_arg_s {
+	unsigned long offset;
+	unsigned int count;
+	char *data;
+};
+
+int kbox_read_op(unsigned long offset, unsigned int count, char __user *data,
+		 enum kbox_section_e section);
+int kbox_write_op(unsigned long offset, unsigned int count,
+		  const char __user *data, enum kbox_section_e section);
+int Kbox_read_super_block(void);
+int kbox_super_block_init(void);
+int kbox_write_panic_info(const char *input_data, unsigned int data_len);
+int kbox_write_thread_info(const char *input_data, unsigned int data_len);
+int kbox_write_printk_info(const char *input_data,
+			   struct printk_ctrl_block_tmp_s
+			   *printk_ctrl_block_tmp);
+int kbox_read_printk_info(char *input_data,
+			  struct printk_ctrl_block_tmp_s
+			  *printk_ctrl_block_tmp);
+int kbox_ioctl_detail(unsigned int cmd, unsigned long arg);
+int kbox_mmap_ram(struct file *file, struct vm_area_struct *vma,
+		  enum kbox_section_e section);
+char Kbox_checksum(char *input_buf, unsigned int len);
+int kbox_write_to_ram(unsigned long offset, unsigned int count,
+		      const char *data, enum kbox_section_e section);
+int kbox_read_from_ram(unsigned long offset, unsigned int count, char *data,
+		       enum kbox_section_e section);
+int kbox_clear_region(enum kbox_section_e section);
+int kbox_memset_ram(unsigned long offset, unsigned int count,
+		    const char set_byte, enum kbox_section_e section);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/ibma/memcpy_s.c b/drivers/net/ethernet/huawei/ibma/memcpy_s.c
new file mode 100644
index 0000000..6dd66638
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/memcpy_s.c
@@ -0,0 +1,90 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+
+#include "securec.h"
+
+/*******************************************************************************
+ * <NAME>
+ *    memcpy_s
+ *
+ * <SYNOPSIS>
+ *    int memcpy_s(void *dest, size_t destMax, const void *src, size_t count);
+ *
+ * <FUNCTION DESCRIPTION>
+ *    memcpy_s copies count bytes from src to dest
+ *
+ * <INPUT PARAMETERS>
+ *    dest                       new buffer.
+ *    destMax                    Size of the destination buffer.
+ *    src                        Buffer to copy from.
+ *    count                      Number of characters to copy
+ *
+ * <OUTPUT PARAMETERS>
+ *    dest buffer                is updated.
+ *
+ * <RETURN VALUE>
+ *    EOK                        Success
+ *    EINVAL                     dest == NULL or strSrc == NULL
+ *    ERANGE                     count > destMax or destMax >
+ *                               SECUREC_MEM_MAX_LEN or destMax == 0
+ *    EOVERLAP                   dest buffer and source buffer are overlapped
+ *
+ *    if an error occured, dest will be filled with 0.
+ *    If the source and destination overlap, the behavior of memcpy_s
+ *    is undefined. Use memmove_s to handle overlapping regions.
+ *******************************************************************************
+ */
+
+int memcpy_s(void *dest, size_t destMax, const void *src, size_t count)
+{
+	if (destMax == 0 || destMax > SECUREC_MEM_MAX_LEN) {
+		SECUREC_ERROR_INVALID_RANGE("memcpy_s");
+		return ERANGE;
+	}
+
+	if (!dest || !src) {
+		if (dest != NULL)
+			(void)memset(dest, 0, destMax);
+		SECUREC_ERROR_INVALID_PARAMTER("memcpy_s");
+		return EINVAL;
+	}
+	if (count > destMax) {
+		(void)memset(dest, 0, destMax);
+		SECUREC_ERROR_INVALID_RANGE("memcpy_s");
+		return ERANGE;
+	}
+	if (dest == src) {
+		return EOK;
+	}
+	if ((dest > src && dest < (void *)((uint8_t *) src + count)) ||
+	    (src > dest && src < (void *)((uint8_t *) dest + count))) {
+		(void)memset(dest, 0, destMax);
+		SECUREC_ERROR_BUFFER_OVERLAP("memcpy_s");
+		return EOVERLAP;
+	}
+#ifdef CALL_LIBC_COR_API
+	/*use underlying memcpy for performance consideration */
+	(void)memcpy(dest, src, count);	/*lint !e64 */
+#else
+	// User can use gcc's __SIZEOF_POINTER__ macro to
+	// copy memory by single byte, 4 bytes or 8 bytes.
+	// User can reference memcpy_32b() and memcpy_64b() in securecutil.c
+	memcpy_8b(dest, src, count);
+#endif
+
+	return EOK;
+}
+EXPORT_SYMBOL(memcpy_s);
diff --git a/drivers/net/ethernet/huawei/ibma/memset_s.c b/drivers/net/ethernet/huawei/ibma/memset_s.c
new file mode 100644
index 0000000..f513733
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/memset_s.c
@@ -0,0 +1,71 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+
+#include "securec.h"
+
+/*******************************************************************************
+ * <NAME>
+ *    memset_s
+ *
+ * <SYNOPSIS>
+ *    errno_t memset_s(void* dest, size_t destMax, int c, size_t count)
+ *
+ * <FUNCTION DESCRIPTION>
+ *    Sets buffers to a specified character.
+ *
+ * <INPUT PARAMETERS>
+ *    dest               Pointer to destination.
+ *    destMax            The size of the buffer.
+ *    c                  Character to set.
+ *    count              Number of characters.
+ *
+ * <OUTPUT PARAMETERS>
+ *    dest buffer        is uptdated.
+ *
+ * <RETURN VALUE>
+ *    EOK                Success
+ *    EINVAL             dest == NULL
+ *    ERANGE             count > destMax or destMax > SECUREC_MEM_MAX_LEN
+ *                       or destMax == 0
+ *******************************************************************************
+ */
+
+int memset_s(void *dest, size_t destMax, int c, size_t count)
+{
+	if (destMax == 0 || destMax > SECUREC_MEM_MAX_LEN) {
+		SECUREC_ERROR_INVALID_RANGE("memset_s");
+		return ERANGE;
+	}
+	if (!dest) {
+		SECUREC_ERROR_INVALID_PARAMTER("memset_s");
+		return EINVAL;
+	}
+	if (count > destMax) {
+		/*set entire buffer to value c */
+		(void)memset(dest, c, destMax);
+		SECUREC_ERROR_INVALID_RANGE("memset_s");
+		return ERANGE;
+	}
+#ifdef CALL_LIBC_COR_API
+	/*use underlying memcpy for performance consideration */
+	(void)memset(dest, c, count);
+#else
+	util_memset(dest, c, count);
+#endif
+
+	return EOK;
+}
+EXPORT_SYMBOL(memset_s);
diff --git a/drivers/net/ethernet/huawei/ibma/securec.h b/drivers/net/ethernet/huawei/ibma/securec.h
new file mode 100644
index 0000000..6a252c28
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/securec.h
@@ -0,0 +1,87 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+
+#ifndef __SECUREC_H__5D13A042_DC3F_4ED9_A8D1_882811274C27
+#define __SECUREC_H__5D13A042_DC3F_4ED9_A8D1_882811274C27
+
+#include <linux/kernel.h>	/*printk */
+#include <linux/module.h>
+#include <linux/errno.h>
+
+#define SECUREC_MEM_MAX_LEN (0x7fffffffUL)
+
+#define SECUREC_ERROR_INVALID_PARAMTER(msg) printk(\
+	KERN_NOTICE "edma_securec: %s invalid argument\n", \
+	msg)
+
+#define SECUREC_ERROR_INVALID_RANGE(msg)    printk(\
+	KERN_NOTICE "edma_securec: %s invalid dest buffer size\n", \
+	msg)
+
+#define SECUREC_ERROR_BUFFER_OVERLAP(msg)   printk(\
+	KERN_NOTICE "edma_securec: %s buffer overlap\n", \
+	msg)
+
+/* for performance consideration, the following macro will the corresponding API
+ * of libC for memcpy, memmove and memset
+ */
+#define CALL_LIBC_COR_API
+/*define error code*/
+
+/* success */
+#define EOK (0)
+
+/* invalid parameter */
+#ifdef EINVAL
+#undef EINVAL
+#endif
+#define EINVAL (22)
+
+/* invalid parameter range */
+#ifdef ERANGE
+#undef ERANGE			/* to avoid redefinition */
+#endif
+#define ERANGE (34)
+
+/* A wide-character code has been detected that does not correspond to a
+ * valid character, or a byte sequence does not form a valid wide-character code
+ */
+#ifdef EILSEQ
+#undef EILSEQ
+#endif
+#define EILSEQ (42)
+
+#ifdef EOVERLAP
+#undef EOVERLAP
+#endif
+#define EOVERLAP (54)
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+	/* memset  */
+	int memset_s(void *dest, size_t destMax, int c, size_t count);
+
+	/* memcpy */
+	int memcpy_s(void *dest, size_t destMax, const void *src,
+			 size_t count);
+
+#ifdef __cplusplus
+}
+#endif	/* __cplusplus */
+#endif	/* __SECUREC_H__5D13A042_DC3F_4ED9_A8D1_882811274C27 */
+
diff --git a/drivers/net/ethernet/huawei/ibma/veth_hb.c b/drivers/net/ethernet/huawei/ibma/veth_hb.c
new file mode 100644
index 0000000..0578dea
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/veth_hb.c
@@ -0,0 +1,2467 @@
+/*
+ * Huawei iBMA driver.
+ * Copyright (c) 2017, Huawei Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/kthread.h>
+
+#include <linux/ethtool.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+
+#include <linux/vmalloc.h>
+#include <linux/atomic.h>
+#include <linux/proc_fs.h>
+#include <linux/mm.h>
+#include <linux/gfp.h>
+#include <asm/page.h>
+
+#include <linux/ip.h>
+
+#include "veth_hb.h"
+
+static u32 veth_ethtool_get_link(struct net_device *dev);
+
+int debug;			/* debug switch*/
+module_param_call(debug, &edma_param_set_debug, &param_get_int, &debug, 0644);
+
+MODULE_PARM_DESC(debug, "Debug switch (0=close debug, 1=open debug)");
+
+#ifdef __UT_TEST
+u32 g_testdma;
+
+u32 g_testlbk;
+
+#endif
+
+struct bspveth_device g_bspveth_dev = {};
+
+static int veth_int_handler(struct notifier_block *pthis, unsigned long ev,
+			    void *unuse);
+
+static struct notifier_block g_veth_int_nb = {
+	.notifier_call = veth_int_handler,
+};
+
+static const struct veth_stats veth_gstrings_stats[] = {
+	{"rx_packets", NET_STAT(stats.rx_packets)},
+	{"rx_bytes", NET_STAT(stats.rx_bytes)},
+	{"rx_dropped", NET_STAT(stats.rx_dropped)},
+	{"rx_head", QUEUE_RX_STAT(head)},
+	{"rx_tail", QUEUE_RX_STAT(tail)},
+	{"rx_next_to_fill", QUEUE_RX_STAT(next_to_fill)},
+	{"rx_shmq_head", SHMQ_RX_STAT(head)},
+	{"rx_shmq_tail", SHMQ_RX_STAT(tail)},
+	{"rx_shmq_next_to_free", SHMQ_RX_STAT(next_to_free)},
+	{"rx_queue_full", QUEUE_RX_STAT(s.q_full)},
+	{"rx_dma_busy", QUEUE_RX_STAT(s.dma_busy)},
+	{"rx_dma_faild", QUEUE_RX_STAT(s.dma_faild)},
+
+	{"tx_packets", NET_STAT(stats.tx_packets)},
+	{"tx_bytes", NET_STAT(stats.tx_bytes)},
+	{"tx_dropped", NET_STAT(stats.tx_dropped)},
+
+	{"tx_head", QUEUE_TX_STAT(head)},
+	{"tx_tail", QUEUE_TX_STAT(tail)},
+	{"tx_next_to_free", QUEUE_TX_STAT(next_to_free)},
+	{"tx_shmq_head", SHMQ_TX_STAT(head)},
+	{"tx_shmq_tail", SHMQ_TX_STAT(tail)},
+	{"tx_shmq_next_to_free", SHMQ_TX_STAT(next_to_free)},
+
+	{"tx_queue_full", QUEUE_TX_STAT(s.q_full)},
+	{"tx_dma_busy", QUEUE_TX_STAT(s.dma_busy)},
+	{"tx_dma_faild", QUEUE_TX_STAT(s.dma_faild)},
+
+	{"recv_int", VETH_STAT(recv_int)},
+	{"tobmc_int", VETH_STAT(tobmc_int)},
+};
+
+#define VETH_GLOBAL_STATS_LEN	\
+		(sizeof(veth_gstrings_stats) / sizeof(struct veth_stats))
+
+
+static int veth_param_get_statics(char *buf, struct kernel_param *kp)
+{
+	int len = 0;
+	int i = 0, j = 0, type = 0;
+	struct bspveth_rxtx_q *pqueue = NULL;
+	__kernel_time_t running_time = 0;
+
+	if (!buf)
+		return 0;
+
+	GET_SYS_SECONDS(running_time);
+
+	running_time -= g_bspveth_dev.init_time;
+
+	len += sprintf(buf + len,
+		    "==========================VETH INFO======================\r\n");
+	len += sprintf(buf + len, "[version     ]:" VETH_VERSION "\n");
+	len += sprintf(buf + len, "[link state  ]:%d\n",
+		    veth_ethtool_get_link(g_bspveth_dev.pnetdev));
+	len += sprintf(buf + len, "[running_time]:%luD %02lu:%02lu:%02lu\n",
+		    running_time / (SECONDS_PER_DAY),
+		    running_time % (SECONDS_PER_DAY) / SECONDS_PER_HOUR,
+		    running_time % SECONDS_PER_HOUR / SECONDS_PER_MINUTE,
+		    running_time % SECONDS_PER_MINUTE);
+	len += sprintf(buf + len,
+		    "[bspveth_dev ]:MAX_QUEUE_NUM :0x%-16x    MAX_QUEUE_BDNUM :0x%-16x\r\n",
+		    MAX_QUEUE_NUM, MAX_QUEUE_BDNUM);
+	len += sprintf(buf + len,
+		    "[bspveth_dev ]:pnetdev       :0x%-16p    ppcidev         :0x%-16p\r\n",
+		    g_bspveth_dev.pnetdev, g_bspveth_dev.ppcidev);
+	len += sprintf(buf + len,
+		    "[bspveth_dev ]:pshmpool_p    :0x%-16p    pshmpool_v      :0x%-16p\r\n"
+		    "[bspveth_dev]:shmpoolsize   :0x%-16x    g_veth_dbg_lv       :0x%-16x\r\n",
+		    g_bspveth_dev.pshmpool_p, g_bspveth_dev.pshmpool_v,
+		    g_bspveth_dev.shmpoolsize, debug);
+
+	for (i = 0; i < MAX_QUEUE_NUM; i++) {
+		for (j = 0, type = BSPVETH_RX; j < 2; j++, type++) {
+			if (type == BSPVETH_RX) {
+				pqueue = g_bspveth_dev.prx_queue[i];
+				len += sprintf(buf + len,
+					    "=============RXQUEUE STATIS============\r\n");
+			} else {
+				pqueue = g_bspveth_dev.ptx_queue[i];
+				len += sprintf(buf + len,
+					    "=============TXQUEUE STATIS============\r\n");
+			}
+
+			if (!pqueue) {
+				len += sprintf(buf + len, "NULL\r\n");
+				continue;
+			}
+
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[pkt            ] :%lld\r\n", i,
+				    pqueue->s.pkt);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[pktbyte        ] :%lld\r\n", i,
+				    pqueue->s.pktbyte);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[refill         ] :%lld\r\n", i,
+				    pqueue->s.refill);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[freetx         ] :%lld\r\n", i,
+				    pqueue->s.freetx);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[dmapkt         ] :%lld\r\n", i,
+				    pqueue->s.dmapkt);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[dmapktbyte     ] :%lld\r\n", i,
+				    pqueue->s.dmapktbyte);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[next_to_fill   ] :%d\r\n", i,
+				    pqueue->next_to_fill);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[next_to_free   ] :%d\r\n", i,
+				    pqueue->next_to_free);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[head           ] :%d\r\n", i,
+				    pqueue->head);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[tail           ] :%d\r\n", i,
+				    pqueue->tail);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[work_limit     ] :%d\r\n", i,
+				    pqueue->work_limit);
+			len += sprintf(buf + len,
+				    "=================SHARE=================\r\n");
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[next_to_fill   ] :%d\r\n", i,
+				    pqueue->pshmqhd_v->next_to_fill);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[next_to_free   ] :%d\r\n", i,
+				    pqueue->pshmqhd_v->next_to_free);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[head           ] :%d\r\n", i,
+				    pqueue->pshmqhd_v->head);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[tail           ] :%d\r\n", i,
+				    pqueue->pshmqhd_v->tail);
+			len += sprintf(buf + len,
+				    "=======================================\r\n");
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[dropped_pkt    ] :%d\r\n", i,
+				    pqueue->s.dropped_pkt);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[netifrx_err    ] :%d\r\n", i,
+				    pqueue->s.netifrx_err);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[null_point     ] :%d\r\n", i,
+				    pqueue->s.null_point);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[retry_err      ] :%d\r\n", i,
+				    pqueue->s.retry_err);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[allocskb_err   ] :%d\r\n", i,
+				    pqueue->s.allocskb_err);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[q_full         ] :%d\r\n", i,
+				    pqueue->s.q_full);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[q_emp          ] :%d\r\n", i,
+				    pqueue->s.q_emp);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[need_fill      ] :%d\r\n", i,
+				    pqueue->s.need_fill);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[need_free      ] :%d\r\n", i,
+				    pqueue->s.need_free);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[type_err       ] :%d\r\n", i,
+				    pqueue->s.type_err);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[shm_full       ] :%d\r\n", i,
+				    pqueue->s.shm_full);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[shm_emp        ] :%d\r\n", i,
+				    pqueue->s.shm_emp);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[shmretry_err   ] :%d\r\n", i,
+				    pqueue->s.shmretry_err);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[shmqueue_noinit] :%d\r\n", i,
+				    pqueue->s.shmqueue_noinit);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[dma_busy       ] :%d\r\n", i,
+				    pqueue->s.dma_busy);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[dma_mapping_err] :%d\r\n", i,
+				    pqueue->s.dma_mapping_err);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[dma_faild      ] :%d\r\n", i,
+				    pqueue->s.dma_faild);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[dma_burst      ] :%d\r\n", i,
+				    pqueue->s.dma_burst);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[lbk_cnt        ] :%d\r\n", i,
+				    pqueue->s.lbk_cnt);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[dma_need_offset] :%d\r\n", i,
+				    pqueue->s.dma_need_offset);
+			len += sprintf(buf + len,
+				    "QUEUE[%d]--[lbk_txerr      ] :%d\r\n", i,
+				    pqueue->s.lbk_txerr);
+		}
+	}
+
+	len += sprintf(buf + len, "=============BSPVETH STATIS===========\r\n");
+	len += sprintf(buf + len, "[bspveth_dev]:run_dmaRXtask :0x%-8x(%d)\r\n",
+		    g_bspveth_dev.run_dmaRXtask, g_bspveth_dev.run_dmaRXtask);
+	len += sprintf(buf + len, "[bspveth_dev]:run_dmaTXtask :0x%-8x(%d)\r\n",
+		    g_bspveth_dev.run_dmaTXtask, g_bspveth_dev.run_dmaTXtask);
+	len += sprintf(buf + len, "[bspveth_dev]:run_skbRXtask :0x%-8x(%d)\r\n",
+		    g_bspveth_dev.run_skbRXtask, g_bspveth_dev.run_skbRXtask);
+	len += sprintf(buf + len, "[bspveth_dev]:run_skbFRtask :0x%-8x(%d)\r\n",
+		    g_bspveth_dev.run_skbFRtask, g_bspveth_dev.run_skbFRtask);
+	len += sprintf(buf + len, "[bspveth_dev]:recv_int      :0x%-8x(%d)\r\n",
+		    g_bspveth_dev.recv_int, g_bspveth_dev.recv_int);
+	len += sprintf(buf + len, "[bspveth_dev]:tobmc_int     :0x%-8x(%d)\r\n",
+		    g_bspveth_dev.tobmc_int, g_bspveth_dev.tobmc_int);
+	len += sprintf(buf + len, "[bspveth_dev]:shutdown_cnt  :0x%-8x(%d)\r\n",
+		    g_bspveth_dev.shutdown_cnt, g_bspveth_dev.shutdown_cnt);
+
+	return len;
+}
+
+module_param_call(statistics, NULL, veth_param_get_statics, &debug, 0444);
+
+MODULE_PARM_DESC(statistics, "Statistics info of veth driver,readonly");
+
+
+static void veth_reset_dma(int type)
+{
+	if (type == BSPVETH_RX)
+		bma_intf_reset_dma(BMC_TO_HOST);
+	else if (type == BSPVETH_TX)
+		bma_intf_reset_dma(HOST_TO_BMC);
+	else
+		return;
+}
+
+
+s32 bspveth_setup_tx_resources(struct bspveth_device *pvethdev,
+			       struct bspveth_rxtx_q *ptx_queue)
+{
+	int size;
+
+	if (!pvethdev || !ptx_queue)
+		return BSP_ERR_NULL_POINTER;
+
+	ptx_queue->count = MAX_QUEUE_BDNUM;
+
+	size = sizeof(struct bspveth_bd_info) * ptx_queue->count;
+	ptx_queue->pbdinfobase_v = vmalloc(size); /*lint !e64*/
+	if (!ptx_queue->pbdinfobase_v)
+		goto alloc_failed;
+
+	memset_s(ptx_queue->pbdinfobase_v, size, 0, size);
+
+	/* round up to nearest 4K */
+	ptx_queue->size = ptx_queue->count * sizeof(struct bspveth_bd_info);
+	ptx_queue->size = ALIGN(ptx_queue->size, 4096);
+
+	/* prepare  4096 send buffer */
+	ptx_queue->pbdbase_v = kmalloc(ptx_queue->size,
+						GFP_KERNEL); /*lint !e64*/
+	if (!ptx_queue->pbdbase_v) {
+		VETH_LOG(DLOG_ERROR,
+		"Unable to allocate memory for the receive descriptor ring\n");
+
+		vfree(ptx_queue->pbdinfobase_v);
+		ptx_queue->pbdinfobase_v = NULL;
+
+		goto alloc_failed;
+	}
+
+	ptx_queue->pbdbase_p = (u8 *)(__pa((BSP_VETH_T)(
+						ptx_queue->pbdbase_v)));
+
+	ptx_queue->next_to_fill = 0;
+	ptx_queue->next_to_free = 0;
+	ptx_queue->head = 0;
+	ptx_queue->tail = 0;
+	ptx_queue->work_limit = BSPVETH_WORK_LIMIT;
+
+	memset_s(&(ptx_queue->s), sizeof(struct bspveth_rxtx_statis), 0,
+		sizeof(struct bspveth_rxtx_statis));
+
+	return 0;
+
+alloc_failed:
+	return -ENOMEM;
+}
+
+
+void bspveth_free_tx_resources(struct bspveth_device *pvethdev,
+			       struct bspveth_rxtx_q *ptx_queue)
+{
+	unsigned int i;
+	unsigned long size;
+	struct bspveth_bd_info *pbdinfobase_v = NULL;
+	struct sk_buff *skb = NULL;
+
+	if (!ptx_queue || !pvethdev)
+		return;
+
+	pbdinfobase_v = ptx_queue->pbdinfobase_v;
+	if (!pbdinfobase_v)
+		return;
+
+	for (i = 0; i < ptx_queue->count; i++) {
+		skb = pbdinfobase_v[i].pdma_v;
+		if (skb)
+			dev_kfree_skb_any(skb);
+
+		pbdinfobase_v[i].pdma_v = NULL;
+	}
+
+	size = sizeof(struct bspveth_bd_info) * ptx_queue->count;
+	memset_s(ptx_queue->pbdinfobase_v, size, 0, size);
+	memset_s(ptx_queue->pbdbase_v, ptx_queue->size, 0, ptx_queue->size);
+
+	ptx_queue->next_to_fill = 0;
+	ptx_queue->next_to_free = 0;
+	ptx_queue->head = 0;
+	ptx_queue->tail = 0;
+
+	vfree(ptx_queue->pbdinfobase_v);
+	ptx_queue->pbdinfobase_v = NULL;
+
+	kfree(ptx_queue->pbdbase_v);
+	ptx_queue->pbdbase_v = NULL;
+
+	VETH_LOG(DLOG_DEBUG, "bspveth free tx resources ok, count=%d\n",
+		 ptx_queue->count);
+}
+s32 bspveth_setup_all_tx_resources(struct bspveth_device *pvethdev)
+{
+	int qid = 0;
+	int i = 0;
+	int err = 0;
+	u8 *shmq_head_p = NULL;
+	struct bspveth_shmq_hd *shmq_head = NULL;
+
+	if (!pvethdev)
+		return BSP_ERR_NULL_POINTER;
+	for (qid = 0; qid < MAX_QUEUE_NUM; qid++) {
+		pvethdev->ptx_queue[qid] = kmalloc(
+			sizeof(*pvethdev->ptx_queue[qid]),
+					GFP_KERNEL); /*lint !e64*/
+		if (!pvethdev->ptx_queue[qid]) {
+			VETH_LOG(DLOG_ERROR,
+				 "kmalloc faild for ptx_queue[%d]\n", qid);
+			err = -1;
+			goto failed;
+		}
+		memset_s(pvethdev->ptx_queue[qid],
+					sizeof(struct bspveth_rxtx_q),
+					0, sizeof(struct bspveth_rxtx_q));
+		shmq_head = (struct bspveth_shmq_hd *)(pvethdev->pshmpool_v +
+					MAX_SHAREQUEUE_SIZE * (qid));
+		pvethdev->ptx_queue[qid]->pshmqhd_v = shmq_head;
+		pvethdev->ptx_queue[qid]->pshmqhd_p = shmq_head_p =
+				pvethdev->pshmpool_p
+				+ MAX_SHAREQUEUE_SIZE * qid;
+
+		pvethdev->ptx_queue[qid]->pshmbdbase_v =
+			(struct bspveth_dma_shmbd *)((BSP_VETH_T)(shmq_head)
+			+ BSPVETH_SHMBDBASE_OFFSET); /*lint !e511*/
+		pvethdev->ptx_queue[qid]->pshmbdbase_p =
+			(u8 *)((BSP_VETH_T)(shmq_head_p)
+			+ BSPVETH_SHMBDBASE_OFFSET); /*lint !e511*/
+		pvethdev->ptx_queue[qid]->pdmalbase_v =
+			(struct bspveth_dmal *)((BSP_VETH_T)(shmq_head)
+			+ SHMDMAL_OFFSET); /*lint !e511*/
+		pvethdev->ptx_queue[qid]->pdmalbase_p =
+			(u8 *)(u64)(VETH_SHAREPOOL_BASE_INBMC
+			+ MAX_SHAREQUEUE_SIZE * qid
+			+ SHMDMAL_OFFSET);/*lint !e647*/
+
+		memset_s(pvethdev->ptx_queue[qid]->pdmalbase_v,
+					MAX_SHMDMAL_SIZE, 0, MAX_SHMDMAL_SIZE);
+
+		err = bspveth_setup_tx_resources(pvethdev,
+						 pvethdev->ptx_queue[qid]);
+		if (err) {
+			pvethdev->ptx_queue[qid]->pshmqhd_v = NULL;
+			kfree(pvethdev->ptx_queue[qid]);
+			pvethdev->ptx_queue[i] = NULL;
+			VETH_LOG(DLOG_ERROR,
+						"Allocation for Tx Queue %u failed\n",
+						qid);
+
+			goto failed;
+		}
+	}
+
+	return 0;
+failed:
+	for (i = 0; i < MAX_QUEUE_NUM; i++) {
+		bspveth_free_tx_resources(pvethdev, pvethdev->ptx_queue[i]);
+		kfree(pvethdev->ptx_queue[i]);
+		pvethdev->ptx_queue[i] = NULL;
+	}
+
+	return err;
+}
+
+
+
+void bspveth_free_all_tx_resources(struct bspveth_device *pvethdev)
+{
+	int i;
+
+	if (!pvethdev)
+		return;
+
+	for (i = 0; i < MAX_QUEUE_NUM; i++) {
+		if (pvethdev->ptx_queue[i])
+			bspveth_free_tx_resources(pvethdev,
+						  pvethdev->ptx_queue[i]);
+
+		kfree(pvethdev->ptx_queue[i]);
+		pvethdev->ptx_queue[i] = NULL;
+	}
+}
+
+
+s32 veth_alloc_one_rx_skb(struct bspveth_rxtx_q *prx_queue, int idx)
+{
+	dma_addr_t dma = 0;
+	struct sk_buff *skb;
+	struct bspveth_bd_info *pbdinfobase_v = NULL;
+	struct bspveth_dma_bd *pbdbase_v = NULL;
+
+	pbdinfobase_v = prx_queue->pbdinfobase_v;
+	pbdbase_v = prx_queue->pbdbase_v;
+
+	skb = netdev_alloc_skb(g_bspveth_dev.pnetdev,
+				     BSPVETH_SKB_SIZE + BSPVETH_CACHELINE_SIZE);
+	if (!skb) {
+		VETH_LOG(DLOG_ERROR, "netdev_alloc_skb faild\n");
+		return -ENOMEM;
+	}
+
+	/* advance the data pointer to the next cache line */
+	skb_reserve(skb, PTR_ALIGN(skb->data,
+			 BSPVETH_CACHELINE_SIZE) - skb->data);
+
+	dma = dma_map_single(&(g_bspveth_dev.ppcidev->dev),
+			skb->data, BSPVETH_SKB_SIZE, DMA_FROM_DEVICE);
+	if (DMA_MAPPING_ERROR(&(g_bspveth_dev.ppcidev->dev), dma)) {
+		VETH_LOG(DLOG_ERROR, "dma_mapping_error faild\n");
+		dev_kfree_skb_any(skb);
+		return -EFAULT;
+	}
+
+#ifdef __UT_TEST
+	if (g_testdma)
+		VETH_LOG(DLOG_ERROR,
+			 "[refill]:dma=0x%llx,skb=%p,skb->len=%d\r\n",
+			 dma, skb, skb->len);
+#endif
+
+
+	pbdinfobase_v[idx].pdma_v = skb;
+	pbdinfobase_v[idx].len = BSPVETH_SKB_SIZE;
+
+	pbdbase_v[idx].dma_p = dma;
+	pbdbase_v[idx].len = BSPVETH_SKB_SIZE;
+
+	return 0;
+}
+
+
+s32 veth_refill_rxskb(struct bspveth_rxtx_q *prx_queue, int queue)
+{
+	int i, work_limit;
+	int next_to_fill, tail;
+	int ret = BSP_OK;
+
+	if (!prx_queue)
+		return BSP_ERR_AGAIN;
+
+	work_limit = prx_queue->work_limit;
+	next_to_fill = prx_queue->next_to_fill;
+	tail = prx_queue->tail;
+
+	for (i = 0; i < work_limit; i++) {
+
+		if (!JUDGE_RX_QUEUE_SPACE(next_to_fill, tail, 1))
+			break;
+
+		ret = veth_alloc_one_rx_skb(prx_queue, next_to_fill);
+		if (ret)
+			break;
+
+		INC_STATIS_RX(queue, refill, 1);
+		next_to_fill = (next_to_fill + 1) & BSPVETH_POINT_MASK;
+	}
+
+	prx_queue->next_to_fill = next_to_fill;
+
+	tail = prx_queue->tail;
+	if (JUDGE_RX_QUEUE_SPACE(next_to_fill, tail, 1)) {
+		VETH_LOG(DLOG_DEBUG, "next_to_fill(%d) != tail(%d)\n",
+			 next_to_fill, tail);
+
+		return BSP_ERR_AGAIN;
+	}
+
+	return 0;
+}
+
+
+s32 bspveth_setup_rx_skb(struct bspveth_device *pvethdev,
+			 struct bspveth_rxtx_q *prx_queue)
+{
+	u32 idx;
+	int ret = 0;
+
+	if (!pvethdev || !prx_queue)
+		return BSP_ERR_NULL_POINTER;
+
+	VETH_LOG(DLOG_DEBUG, "waite setup rx skb ,count=%d\n",
+		 prx_queue->count);
+
+	for (idx = 0; idx < prx_queue->count - 1; idx++) {
+		ret = veth_alloc_one_rx_skb(prx_queue, idx);
+		if (ret)
+			break;
+	}
+
+	if (!idx)	/* Can't alloc even one packets */
+		return -EFAULT;
+
+	prx_queue->next_to_fill = idx;
+
+	VETH_LOG(DLOG_DEBUG, "prx_queue->next_to_fill=%d\n",
+			prx_queue->next_to_fill);
+
+	VETH_LOG(DLOG_DEBUG, "setup rx skb ok, count=%d\n", prx_queue->count);
+
+	return BSP_OK;
+}
+
+void bspveth_free_rx_skb(struct bspveth_device *pvethdev,
+			 struct bspveth_rxtx_q *prx_queue)
+{
+	u32 i = 0;
+	struct bspveth_bd_info *pbdinfobase_v = NULL;
+	struct bspveth_dma_bd *pbdbase_v = NULL;
+	struct sk_buff *skb = NULL;
+
+	if (!pvethdev || !prx_queue)
+		return;
+
+	pbdinfobase_v = prx_queue->pbdinfobase_v;
+	pbdbase_v = prx_queue->pbdbase_v;
+	if (!pbdinfobase_v || !pbdbase_v)
+		return;
+
+	/* Free all the Rx ring pages */
+	for (i = 0; i < prx_queue->count; i++) {
+		skb = pbdinfobase_v[i].pdma_v;
+		if (!skb)
+			continue;
+
+		dma_unmap_single(&(g_bspveth_dev.ppcidev->dev),
+				 pbdbase_v[i].dma_p, BSPVETH_SKB_SIZE,
+				 DMA_FROM_DEVICE);
+		dev_kfree_skb_any(skb);
+
+		pbdinfobase_v[i].pdma_v = NULL;
+	}
+
+	prx_queue->next_to_fill = 0;
+}
+
+
+s32 bspveth_setup_all_rx_skb(struct bspveth_device *pvethdev)
+{
+	int qid, i, err = BSP_OK;
+
+	if (!pvethdev)
+		return BSP_ERR_NULL_POINTER;
+
+	for (qid = 0; qid < MAX_QUEUE_NUM; qid++) {
+		err = bspveth_setup_rx_skb(pvethdev, pvethdev->prx_queue[qid]);
+		if (err) {
+			VETH_LOG(DLOG_ERROR, "queue[%d]setup RX skb failed\n",
+				qid);
+			goto failed;
+		}
+
+		VETH_LOG(DLOG_DEBUG, "queue[%d] bspveth_setup_rx_skb ok\n",
+				qid);
+	}
+
+	return 0;
+
+failed:
+	for (i = 0; i < MAX_QUEUE_NUM; i++)
+		bspveth_free_rx_skb(pvethdev, pvethdev->prx_queue[i]);
+
+	return err;
+}
+
+void bspveth_free_all_rx_skb(struct bspveth_device *pvethdev)
+{
+	int qid;
+
+	if (!pvethdev)
+		return;
+
+	/* Free all the Rx ring pages */
+	for (qid = 0; qid < MAX_QUEUE_NUM; qid++)
+		bspveth_free_rx_skb(pvethdev, pvethdev->prx_queue[qid]);
+}
+
+s32 bspveth_setup_rx_resources(struct bspveth_device *pvethdev,
+			       struct bspveth_rxtx_q *prx_queue)
+{
+	int size;
+
+	if (!pvethdev || !prx_queue)
+		return BSP_ERR_NULL_POINTER;
+
+	prx_queue->count = MAX_QUEUE_BDNUM;
+	size = sizeof(*prx_queue->pbdinfobase_v) * prx_queue->count;
+	prx_queue->pbdinfobase_v = vmalloc(size); /*lint !e64*/
+	if (!prx_queue->pbdinfobase_v) {
+		VETH_LOG(DLOG_ERROR,
+			 "Unable to vmalloc buffer memory for the receive descriptor ring\n");
+
+		goto alloc_failed;
+	}
+
+	memset_s(prx_queue->pbdinfobase_v, size, 0, size);
+
+	/* Round up to nearest 4K */
+	prx_queue->size = prx_queue->count * sizeof(*prx_queue->pbdbase_v);
+	prx_queue->size = ALIGN(prx_queue->size, 4096);
+	prx_queue->pbdbase_v = kmalloc(prx_queue->size,
+						GFP_ATOMIC); /*lint !e64*/
+	if (!prx_queue->pbdbase_v) {
+		VETH_LOG(DLOG_ERROR,
+		"Unable to allocate memory for the receive descriptor ring\n");
+
+		vfree(prx_queue->pbdinfobase_v);
+		prx_queue->pbdinfobase_v = NULL;
+
+		goto alloc_failed;
+	}
+
+	prx_queue->pbdbase_p = (u8 *)__pa((BSP_VETH_T) (prx_queue->pbdbase_v));
+
+	prx_queue->next_to_fill = 0;
+	prx_queue->next_to_free = 0;
+	prx_queue->head = 0;
+	prx_queue->tail = 0;
+
+	prx_queue->work_limit = BSPVETH_WORK_LIMIT;
+
+	memset_s(&(prx_queue->s), sizeof(struct bspveth_rxtx_statis), 0,
+		sizeof(struct bspveth_rxtx_statis));
+
+	return 0;
+
+alloc_failed:
+	return -ENOMEM;
+}
+
+void bspveth_free_rx_resources(struct bspveth_device *pvethdev,
+			       struct bspveth_rxtx_q *prx_queue)
+{
+	unsigned long size;
+	struct bspveth_bd_info *pbdinfobase_v = NULL;
+
+	if (!pvethdev || !prx_queue)
+		return;
+
+	pbdinfobase_v = prx_queue->pbdinfobase_v;
+	if (!pbdinfobase_v)
+		return;
+
+	if (!prx_queue->pbdbase_v)
+		return;
+
+	size = sizeof(struct bspveth_bd_info) * prx_queue->count;
+	memset_s(prx_queue->pbdinfobase_v, size, 0, size);
+
+	/* Zero out the descriptor ring */
+	memset_s(prx_queue->pbdbase_v, prx_queue->size, 0, prx_queue->size);
+
+	vfree(prx_queue->pbdinfobase_v);
+	prx_queue->pbdinfobase_v = NULL;
+
+	kfree(prx_queue->pbdbase_v);
+	prx_queue->pbdbase_v = NULL;
+
+	VETH_LOG(DLOG_DEBUG, "bspveth free rx resources ok!!count=%d\n",
+		 prx_queue->count);
+}
+s32 bspveth_setup_all_rx_resources(struct bspveth_device *pvethdev)
+{
+	int qid, i, err = 0;
+	struct bspveth_shmq_hd *shmq_head = NULL;
+	u8 *shmq_head_p = NULL;
+
+	if (!pvethdev)
+		return BSP_ERR_NULL_POINTER;
+
+	for (qid = 0; qid < MAX_QUEUE_NUM; qid++) {
+		pvethdev->prx_queue[qid] =
+			kmalloc(sizeof(*pvethdev->prx_queue[qid]),
+				GFP_KERNEL); /*lint !e64*/
+		if (!pvethdev->prx_queue[qid]) {
+			VETH_LOG(DLOG_ERROR,
+				 "kmalloc faild for prx_queue[%d]\n", qid);
+
+			goto failed;
+		}
+
+		memset_s(pvethdev->prx_queue[qid],
+			sizeof(struct bspveth_rxtx_q), 0,
+			sizeof(struct bspveth_rxtx_q));
+
+		shmq_head = (struct bspveth_shmq_hd *)(pvethdev->pshmpool_v +
+					   MAX_SHAREQUEUE_SIZE * (qid + 1));
+
+		pvethdev->prx_queue[qid]->pshmqhd_v = shmq_head;
+		pvethdev->prx_queue[qid]->pshmqhd_p = shmq_head_p =
+			pvethdev->pshmpool_p + MAX_SHAREQUEUE_SIZE * (qid + 1);
+		pvethdev->prx_queue[qid]->pshmbdbase_v =
+			(struct bspveth_dma_shmbd *)((BSP_VETH_T)(shmq_head)
+			+ BSPVETH_SHMBDBASE_OFFSET); /*lint !e511*/
+		pvethdev->prx_queue[qid]->pshmbdbase_p =
+			(u8 *)((BSP_VETH_T)(shmq_head_p)
+			+ BSPVETH_SHMBDBASE_OFFSET); /*lint !e511*/
+		pvethdev->prx_queue[qid]->pdmalbase_v =
+			(struct bspveth_dmal *)((BSP_VETH_T)(shmq_head)
+			+ SHMDMAL_OFFSET); /*lint !e511*/
+		pvethdev->prx_queue[qid]->pdmalbase_p =
+			(u8 *)(u64) (VETH_SHAREPOOL_BASE_INBMC
+			+ MAX_SHAREQUEUE_SIZE * (qid + 1)
+			+ SHMDMAL_OFFSET);/*lint !e647*/
+		memset_s(pvethdev->prx_queue[qid]->pdmalbase_v,
+			MAX_SHMDMAL_SIZE, 0, MAX_SHMDMAL_SIZE);
+
+		err = bspveth_setup_rx_resources(pvethdev,
+						 pvethdev->prx_queue[qid]);
+		if (err) {
+			kfree(pvethdev->prx_queue[qid]);
+			pvethdev->prx_queue[qid] = NULL;
+			VETH_LOG(DLOG_ERROR,
+					"Allocation for Rx Queue %u failed\n",
+					qid);
+
+			goto failed;
+		}
+	}
+
+	return 0;
+failed:
+	for (i = 0; i < MAX_QUEUE_NUM; i++) {
+		bspveth_free_rx_resources(pvethdev, pvethdev->prx_queue[i]);
+		kfree(pvethdev->prx_queue[i]);
+		pvethdev->prx_queue[i] = NULL;
+	}
+	return err;
+}
+
+
+void bspveth_free_all_rx_resources(struct bspveth_device *pvethdev)
+{
+	int i;
+
+	if (!pvethdev)
+		return;
+
+	for (i = 0; i < MAX_QUEUE_NUM; i++) {
+		if (pvethdev->prx_queue[i]) {
+			bspveth_free_rx_resources(pvethdev,
+						  pvethdev->prx_queue[i]);
+		}
+
+		kfree(pvethdev->prx_queue[i]);
+		pvethdev->prx_queue[i] = NULL;
+	}
+}
+
+
+s32 bspveth_dev_install(void)
+{
+	int err;
+
+	err = bspveth_setup_all_rx_resources(&g_bspveth_dev);
+	if (err != BSP_OK) {
+		err = -1;
+		goto err_setup_rx;
+	}
+
+	err = bspveth_setup_all_tx_resources(&g_bspveth_dev);
+	if (err != BSP_OK) {
+		err = -1;
+		goto err_setup_tx;
+	}
+
+	err = bspveth_setup_all_rx_skb(&g_bspveth_dev);
+	if (err != BSP_OK) {
+		err = -1;
+		goto err_setup_rx_skb;
+	}
+
+	return BSP_OK;
+
+err_setup_rx_skb:
+	bspveth_free_all_tx_resources(&g_bspveth_dev);
+
+err_setup_tx:
+	bspveth_free_all_rx_resources(&g_bspveth_dev);
+
+err_setup_rx:
+
+	return err;
+}
+
+
+s32 bspveth_dev_uninstall(void)
+{
+	int err = BSP_OK;
+
+
+	/* Free all the Rx ring pages */
+	bspveth_free_all_rx_skb(&g_bspveth_dev);
+
+	bspveth_free_all_tx_resources(&g_bspveth_dev);
+
+	VETH_LOG(DLOG_DEBUG, "bspveth_free_all_tx_resources ok\n");
+
+	bspveth_free_all_rx_resources(&g_bspveth_dev);
+
+	VETH_LOG(DLOG_DEBUG, "bspveth_free_all_rx_resources ok\n");
+
+	return err;
+}
+
+
+s32 veth_open(struct net_device *pstr_dev)
+{
+	s32 ret = BSP_OK;
+
+	if (!pstr_dev)
+		return -1;
+
+	if (!g_bspveth_dev.pnetdev)
+		g_bspveth_dev.pnetdev = pstr_dev;
+
+	ret = bspveth_dev_install();
+	if (ret != BSP_OK) {
+		ret = -1;
+		goto failed1;
+	}
+
+	veth_skbtimer_init();
+
+	veth_dmatimer_init_H();
+
+	ret = bma_intf_register_int_notifier(&g_veth_int_nb);
+	if (ret != BSP_OK) {
+		ret = -1;
+		goto failed2;
+	}
+
+	bma_intf_set_open_status(g_bspveth_dev.bma_priv, DEV_OPEN);
+
+	g_bspveth_dev.prx_queue[0]->pshmqhd_v->tail =
+				g_bspveth_dev.prx_queue[0]->pshmqhd_v->head;
+
+	bma_intf_int_to_bmc(g_bspveth_dev.bma_priv);
+
+	netif_start_queue(g_bspveth_dev.pnetdev);
+	netif_carrier_on(pstr_dev);
+
+	return BSP_OK;
+
+failed2:
+	veth_dmatimer_close_H();
+
+	veth_skbtimer_close();
+
+	(void)bspveth_dev_uninstall();
+
+failed1:
+	return ret;
+}
+
+
+s32 veth_close(struct net_device *pstr_dev)
+{
+	(void)bma_intf_unregister_int_notifier(&g_veth_int_nb);
+
+	netif_carrier_off(pstr_dev);
+
+	bma_intf_set_open_status(g_bspveth_dev.bma_priv, DEV_CLOSE);
+
+	netif_stop_queue(g_bspveth_dev.pnetdev);
+
+	(void)veth_dmatimer_close_H();
+	(void)veth_skbtimer_close();
+
+
+	(void)bspveth_dev_uninstall();
+
+	return BSP_OK;
+}
+
+
+s32 veth_config(struct net_device *pstr_dev, struct ifmap *pstr_map)
+{
+	if (!pstr_dev || !pstr_map)
+		return BSP_ERR_NULL_POINTER;
+
+	/* can't act on a running interface */
+	if (pstr_dev->flags & IFF_UP)
+		return -EBUSY;
+
+	/* Don't allow changing the I/O address */
+	if (pstr_map->base_addr != pstr_dev->base_addr)
+		return -EOPNOTSUPP;
+
+	/* ignore other fields */
+	return BSP_OK;
+}
+
+
+
+void bspveth_initstatis(void)
+{
+	int i;
+	struct bspveth_rxtx_q *prx_queue, *ptx_queue;
+
+	for (i = 0; i < MAX_QUEUE_NUM; i++) {
+		prx_queue = g_bspveth_dev.prx_queue[i];
+		ptx_queue = g_bspveth_dev.ptx_queue[i];
+
+		if (prx_queue && ptx_queue) {
+			memset_s(&(prx_queue->s),
+				sizeof(struct bspveth_rxtx_statis),
+				0, sizeof(struct bspveth_rxtx_statis));
+
+			memset_s(&(ptx_queue->s),
+				sizeof(struct bspveth_rxtx_statis),
+				0, sizeof(struct bspveth_rxtx_statis));
+		} else {
+			VETH_LOG(DLOG_ERROR,
+				 "prx_queue OR ptx_queue is NULL\n");
+		}
+	}
+
+	VETH_LOG(DLOG_DEBUG, "bspveth initstatis ok\n");
+
+}
+
+
+s32 veth_ioctl(struct net_device *pstr_dev, struct ifreq *pifr, s32 l_cmd)
+{
+	return -EFAULT;
+}
+
+
+struct net_device_stats *veth_stats(struct net_device *pstr_dev)
+{
+	return &(g_bspveth_dev.stats);
+}
+
+
+s32 veth_mac_set(struct net_device *pstr_dev, void *p_mac)
+{
+	struct sockaddr *str_addr = NULL;
+	u8 *puc_mac = NULL;
+
+	if (!pstr_dev || !p_mac)
+		return BSP_ERR_NULL_POINTER;
+
+	str_addr = (struct sockaddr *)p_mac;
+	puc_mac = (u8 *) str_addr->sa_data;
+
+	pstr_dev->dev_addr[0] = puc_mac[0];
+	pstr_dev->dev_addr[1] = puc_mac[1];
+	pstr_dev->dev_addr[2] = puc_mac[2];
+	pstr_dev->dev_addr[3] = puc_mac[3];
+	pstr_dev->dev_addr[4] = puc_mac[4];
+	pstr_dev->dev_addr[5] = puc_mac[5];
+
+	return BSP_OK;
+}
+
+void veth_tx_timeout(struct net_device *pstr_dev)
+{
+	VETH_LOG(DLOG_ERROR, "enter.\n");
+}
+
+
+static u32 veth_ethtool_get_link(struct net_device *dev)
+{
+	if (!bma_intf_is_link_ok() || !netif_running(g_bspveth_dev.pnetdev))
+		return 0;
+
+	if ((g_bspveth_dev.ptx_queue[0])
+	    && (g_bspveth_dev.ptx_queue[0]->pshmqhd_v))
+		return (u32)((BSPVETH_SHMQUEUE_INITOK ==
+			      g_bspveth_dev.ptx_queue[0]->pshmqhd_v->init)
+			      && netif_carrier_ok(dev));
+
+	return 0;
+}
+
+
+static void veth_ethtool_get_drvinfo(struct net_device *dev,
+				     struct ethtool_drvinfo *info)
+{
+	strlcpy(info->driver, MODULE_NAME, sizeof(info->driver));
+	strlcpy(info->version, VETH_VERSION, sizeof(info->version));
+
+	info->n_stats = VETH_GLOBAL_STATS_LEN;
+}
+
+
+static void veth_ethtool_get_stats(struct net_device *netdev,
+				   struct ethtool_stats *tool_stats, u64 *data)
+{
+	unsigned int i = 0;
+	char *p = NULL;
+	const struct veth_stats *p_stat = veth_gstrings_stats;
+	struct bspveth_rxtx_q *ptx_node = g_bspveth_dev.ptx_queue[0];
+	struct bspveth_rxtx_q *prx_node = g_bspveth_dev.prx_queue[0];
+
+	if (!data || !netdev || !tool_stats)
+		return;
+
+	for (i = 0; i < VETH_GLOBAL_STATS_LEN; i++) {
+		p = NULL;
+
+		switch (p_stat->type) {
+		case NET_STATS:
+			p = (char *)&g_bspveth_dev + p_stat->stat_offset;
+
+			break;
+
+		case QUEUE_RX_STATS:
+			if (prx_node)
+				p = (char *)prx_node + p_stat->stat_offset;
+
+			break;
+
+		case QUEUE_TX_STATS:
+			if (ptx_node)
+				p = (char *)ptx_node + p_stat->stat_offset;
+
+			break;
+
+		case VETH_STATS:
+			p = (char *)&g_bspveth_dev + p_stat->stat_offset;
+
+			break;
+
+		case SHMQ_RX_STATS:
+			if (prx_node && (prx_node->pshmqhd_v))
+				p = (char *)prx_node->pshmqhd_v
+					+ p_stat->stat_offset;
+
+			break;
+
+		case SHMQ_TX_STATS:
+			if (ptx_node && (ptx_node->pshmqhd_v))
+				p = (char *)ptx_node->pshmqhd_v
+					+ p_stat->stat_offset;
+
+			break;
+
+		default:
+			break;
+		}
+
+		if (p) {
+			if (p_stat->sizeof_stat == sizeof(u64))
+				data[i] = *(u64 *) p;
+			else
+				data[i] = *(u32 *) p;
+		} else {
+			data[i] = 0;
+		}
+
+		p_stat++;
+	}
+	/* BUG_ON(i != E1000_STATS_LEN); */
+}
+
+
+static void veth_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+{
+	u8 *p = data;
+	unsigned int i;
+
+	if (!p)
+		return;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < VETH_GLOBAL_STATS_LEN; i++) {
+
+			memcpy_s(p, ETH_GSTRING_LEN,
+				 veth_gstrings_stats[i].stat_string,
+				 ETH_GSTRING_LEN);
+
+			p += ETH_GSTRING_LEN;
+		}
+
+		break;
+	}
+}
+
+
+static int veth_get_sset_count(struct net_device *netdev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return VETH_GLOBAL_STATS_LEN;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+
+
+const struct ethtool_ops veth_ethtool_ops = {
+	.get_drvinfo = veth_ethtool_get_drvinfo,
+	.get_link = veth_ethtool_get_link,
+
+	.get_ethtool_stats = veth_ethtool_get_stats,
+	.get_strings = veth_get_strings,
+	.get_sset_count = veth_get_sset_count,
+
+};
+
+
+static const struct net_device_ops veth_ops = {
+	.ndo_open = veth_open,
+	.ndo_stop = veth_close,
+	.ndo_set_config = veth_config,
+	.ndo_start_xmit = veth_tx, /*lint !e64*/
+	.ndo_do_ioctl = veth_ioctl,
+	.ndo_get_stats = veth_stats,
+	.ndo_set_mac_address = veth_mac_set,
+	.ndo_tx_timeout = veth_tx_timeout,
+};
+
+
+
+void veth_netdev_func_init(struct net_device *dev)
+{
+	struct tag_pcie_comm_priv *priv =
+				(struct tag_pcie_comm_priv *)netdev_priv(dev);
+
+	VETH_LOG(DLOG_DEBUG, "eth init start\n");
+
+	ether_setup(dev);
+
+	dev->netdev_ops = &veth_ops;
+
+	dev->watchdog_timeo = BSPVETH_NET_TIMEOUT;
+	dev->mtu = BSPVETH_MTU_MAX;
+	dev->flags = IFF_BROADCAST;
+	dev->tx_queue_len = BSPVETH_MAX_QUE_DEEP;
+	dev->ethtool_ops = &veth_ethtool_ops;
+
+	/*
+	 * Then, initialize the priv field. This encloses the statistics
+	 * and a few private fields.
+	 */
+	memset_s(priv, sizeof(struct tag_pcie_comm_priv),
+			0, sizeof(struct tag_pcie_comm_priv));
+	strncpy(priv->net_type, MODULE_NAME, NET_TYPE_LEN);
+
+	/*9C:7D:A3:28:6F:F9*/
+	dev->dev_addr[0] = 0x9c;
+	dev->dev_addr[1] = 0x7d;
+	dev->dev_addr[2] = 0xa3;
+	dev->dev_addr[3] = 0x28;
+	dev->dev_addr[4] = 0x6f;
+	dev->dev_addr[5] = 0xf9;
+
+	VETH_LOG(DLOG_DEBUG, "set veth MAC addr OK\n");
+}
+
+
+s32 veth_send_one_pkt(struct sk_buff *skb, int queue)
+{
+	u32 head, next_to_free;
+	dma_addr_t dma = 0;
+	u32 off = 0;
+	int ret = 0;
+	int type = BSPVETH_TX;
+	struct bspveth_bd_info *pbdinfo_v;
+	struct bspveth_dma_bd *pbd_v;
+	struct bspveth_rxtx_q *ptx_queue = g_bspveth_dev.ptx_queue[queue];
+
+	if (!skb || !ptx_queue || !ptx_queue->pbdinfobase_v
+		|| !ptx_queue->pbdbase_v) {
+		INC_STATIS_RXTX(queue, null_point, 1, type);
+		return BSP_ERR_NULL_POINTER;
+	}
+
+	if (!bma_intf_is_link_ok()
+		|| (ptx_queue->pshmqhd_v->init != BSPVETH_SHMQUEUE_INITOK))
+		return -1;
+
+	head = ptx_queue->head;
+	next_to_free = ptx_queue->next_to_free;
+
+	/* stop to send pkt when queue is going to full */
+	if (!JUDGE_TX_QUEUE_SPACE(head, next_to_free, 3)) {
+		netif_stop_subqueue(g_bspveth_dev.pnetdev, queue);
+		//ptx_queue->s.tx_busy++;
+		VETH_LOG(DLOG_DEBUG,
+				"going to full, head: %d, nex to free: %d\n",
+				head, next_to_free);
+	}
+
+	if (!JUDGE_TX_QUEUE_SPACE(head, next_to_free, 1))
+		return BSP_NETDEV_TX_BUSY;
+
+	if (skb_shinfo(skb)->nr_frags) {
+		/* We don't support frags */
+		ret = skb_linearize(skb);
+		if (ret)
+			return -ENOMEM;
+	}
+
+
+	dma = dma_map_single(&(g_bspveth_dev.ppcidev->dev), skb->data, skb->len,
+			     DMA_TO_DEVICE);
+
+	ret = DMA_MAPPING_ERROR(&(g_bspveth_dev.ppcidev->dev), dma);
+	if (ret != BSP_OK) {
+		ret = BSP_ERR_DMA_ERR;
+		INC_STATIS_TX(queue, dma_mapping_err, 1);
+		goto failed;
+	}
+
+	off = dma & 0x3;
+	if (off)
+		INC_STATIS_TX(queue, dma_need_offset, 1);
+
+	pbdinfo_v = &(ptx_queue->pbdinfobase_v[head]);
+	pbdinfo_v->pdma_v = skb;
+	pbd_v = &(ptx_queue->pbdbase_v[head]);
+	pbd_v->dma_p = dma & (~((u64) 0x3));
+	pbd_v->off = off;
+	pbd_v->len = skb->len;
+
+	head = (head + 1) & BSPVETH_POINT_MASK;
+	ptx_queue->head = head;
+
+	VETH_LOG(DLOG_DEBUG,
+		 "[send]:oridma=0x%llx,skb=%p,skb->data=%p,skb->len=%d,head=%d,off=%d, alidma0x%llx\n",
+		 (u64) dma, skb, skb->data, skb->len, head, off,
+		 (u64) (dma & (~((u64) 0x3))));
+
+	return BSP_OK;
+
+failed:
+	return ret;
+}
+
+
+int veth_tx(struct sk_buff *skb, struct net_device *pstr_dev)
+{
+	u32 ul_ret = 0;
+	int queue = 0;
+
+	VETH_LOG(DLOG_DEBUG, "===============enter==================\n");
+
+	if (!skb || !pstr_dev) {
+		INC_STATIS_TX(queue, null_point, 1);
+		return NETDEV_TX_OK;
+	}
+
+	VETH_LOG(DLOG_DEBUG, "skb->data=%p\n", skb->data);
+	VETH_LOG(DLOG_DEBUG, "skb->len=%d\n", skb->len);
+
+	ul_ret = veth_send_one_pkt(skb, queue);
+
+
+	if (ul_ret == BSP_OK) {
+		INC_STATIS_TX_TONETSTATS(queue, pkt, 1, tx_packets);
+		INC_STATIS_TX_TONETSTATS(queue, pktbyte, skb->len, tx_bytes);
+
+#ifndef USE_TASKLET
+		(void)mod_timer(&g_bspveth_dev.dmatimer, jiffies_64);
+#else
+		tasklet_hi_schedule(&g_bspveth_dev.dma_task);
+#endif
+
+	} else {
+		VETH_LOG(DLOG_DEBUG,
+			"==========exit ret = %d=============\n",
+			ul_ret);
+		INC_STATIS_TX_TONETSTATS(queue, dropped_pkt, 1, tx_dropped);
+		dev_kfree_skb_any(skb);
+	}
+
+	return NETDEV_TX_OK;
+}
+
+
+s32 veth_free_txskb(struct bspveth_rxtx_q *ptx_queue, int queue)
+{
+	int i, work_limit;
+	int tail, next_to_free;
+	struct bspveth_bd_info *ptx_bdinfo_v;
+	struct sk_buff *skb;
+	struct bspveth_dma_bd *pbd_v;
+
+	if (!ptx_queue)
+		return BSP_ERR_AGAIN;
+
+	work_limit = ptx_queue->work_limit;
+	tail = ptx_queue->tail;
+	next_to_free = ptx_queue->next_to_free;
+
+	for (i = 0; i < work_limit; i++) {
+		if (next_to_free == tail)
+			break;
+
+		ptx_bdinfo_v = &(ptx_queue->pbdinfobase_v[next_to_free]);
+
+		pbd_v = &(ptx_queue->pbdbase_v[next_to_free]);
+
+		skb = ptx_bdinfo_v->pdma_v;
+
+		dma_unmap_single(&(g_bspveth_dev.ppcidev->dev),
+				 pbd_v->dma_p | pbd_v->off,
+				 pbd_v->len, DMA_TO_DEVICE);
+
+		if (skb)
+			dev_kfree_skb_any(skb);
+		else
+			VETH_LOG(DLOG_ERROR,
+				 "skb is NULL,tail=%d next_to_free=%d\n",
+				 tail, next_to_free);
+
+		ptx_bdinfo_v->pdma_v = NULL;
+		INC_STATIS_TX(queue, freetx, 1);
+
+		next_to_free = (next_to_free + 1) & BSPVETH_POINT_MASK;
+	}
+
+	ptx_queue->next_to_free = next_to_free;
+	tail = ptx_queue->tail;
+
+	if (next_to_free != tail) {
+		VETH_LOG(DLOG_DEBUG, "next_to_free(%d) != tail(%d)\n",
+			 next_to_free, tail);
+
+		return BSP_ERR_AGAIN;
+	}
+
+	return BSP_OK;
+}
+
+
+
+
+
+s32 veth_recv_pkt(struct bspveth_rxtx_q *prx_queue, int queue)
+{
+	int ret = BSP_OK, i, work_limit;
+	u32 tail, head;
+	struct bspveth_bd_info *prx_bdinfo_v;
+	struct bspveth_dma_bd *pbd_v;
+	struct sk_buff *skb;
+	dma_addr_t dma_map = 0;
+	u32 off = 0;
+
+	if (!prx_queue)
+		return BSP_ERR_AGAIN;
+
+	work_limit = prx_queue->work_limit;
+	tail = prx_queue->tail;
+
+	for (i = 0; i < work_limit; i++) {
+		head = prx_queue->head;
+		if (tail == head)
+			break;
+
+		prx_bdinfo_v = &(prx_queue->pbdinfobase_v[tail]);
+
+		skb = prx_bdinfo_v->pdma_v;
+		if (!skb) {
+			tail = (tail + 1) & BSPVETH_POINT_MASK;
+			continue;
+		}
+
+		prx_bdinfo_v->pdma_v = NULL;
+		pbd_v = &(prx_queue->pbdbase_v[tail]);
+
+		off = pbd_v->off;
+		if (off) {
+			skb_reserve(skb, off);
+			//pbd_v->len -= off;
+		}
+
+		dma_unmap_single(&(g_bspveth_dev.ppcidev->dev), pbd_v->dma_p,
+				 BSPVETH_SKB_SIZE, DMA_FROM_DEVICE);
+
+		tail = (tail + 1) & BSPVETH_POINT_MASK;
+
+		skb_put(skb, pbd_v->len);
+
+		skb->protocol = eth_type_trans(skb, g_bspveth_dev.pnetdev);
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+		VETH_LOG(DLOG_DEBUG,
+			 "skb->len=%d,skb->protocol=%d\n",
+			 skb->len, skb->protocol);
+
+		VETH_LOG(DLOG_DEBUG,
+			 "dma_p=0x%llx,dma_map=0x%llx,skb=%p,skb->data=%p,skb->len=%d,tail=%d,shm_off=%d\n",
+			 pbd_v->dma_p, dma_map, skb, skb->data,
+			 skb->len, tail, off);
+
+		VETH_LOG(DLOG_DEBUG,
+			"skb_transport_header=%p skb_mac_header=%p skb_network_header=%p\n",
+			 skb_transport_header(skb),
+			 skb_mac_header(skb), skb_network_header(skb));
+
+		VETH_LOG(DLOG_DEBUG,
+			  "skb->data=0x%p skb->tail=%08x skb->len=%08x\n",
+			  skb->data,
+			  (unsigned int)skb->tail,
+			  (unsigned int)skb->len);
+
+		INC_STATIS_RX_TONETSTATS(queue, pkt, 1, rx_packets);
+		INC_STATIS_RX_TONETSTATS(queue, pktbyte, skb->len, rx_bytes);
+
+		ret = netif_rx(skb);
+		if (ret == NET_RX_DROP) {
+			INC_STATIS_RX_TONETSTATS(queue, netifrx_err, 1,
+						 rx_errors);
+
+			VETH_LOG(DLOG_DEBUG, "netif_rx failed\n");
+		}
+	}
+
+	prx_queue->tail = tail;
+	head = prx_queue->head;
+
+	ret = veth_refill_rxskb(prx_queue, queue);
+	if (ret != BSP_OK)
+		VETH_LOG(DLOG_DEBUG, "veth_refill_rxskb failed\n");
+
+	if (tail != head) {
+		VETH_LOG(DLOG_DEBUG, "tail(%d) != head(%d)\n", tail, head);
+
+		return BSP_ERR_AGAIN;
+	}
+
+	return BSP_OK;
+}
+
+
+void veth_skbtrtimer_do(unsigned long data)
+{
+	int ret = 0;
+
+	ret = veth_skb_tr_task(data);
+	if (ret == BSP_ERR_AGAIN) {
+#ifndef USE_TASKLET
+		(void)mod_timer(&g_bspveth_dev.skbtrtimer, jiffies_64);
+#else
+		tasklet_hi_schedule(&g_bspveth_dev.skb_task);
+#endif
+	}
+}
+
+
+s32 veth_skbtimer_close(void)
+{
+#ifndef USE_TASKLET
+	(void)del_timer_sync(&(g_bspveth_dev.skbtrtimer));
+#else
+	tasklet_kill(&g_bspveth_dev.skb_task);
+#endif
+
+	VETH_LOG(DLOG_DEBUG, "veth skbtimer close ok\n");
+
+	return 0;
+}
+
+
+void veth_skbtimer_init(void)
+{
+#ifndef USE_TASKLET
+	setup_timer(&(g_bspveth_dev.skbtrtimer), veth_skbtrtimer_do,
+		    (unsigned long)&g_bspveth_dev);
+	(void)mod_timer(&g_bspveth_dev.skbtrtimer,
+			jiffies_64 + BSPVETH_SKBTIMER_INTERVAL);
+#else
+	tasklet_init(&g_bspveth_dev.skb_task, veth_skbtrtimer_do,
+		     (unsigned long)&g_bspveth_dev);
+#endif
+
+	VETH_LOG(DLOG_DEBUG, "veth skbtimer init OK\n");
+}
+
+
+void veth_netdev_exit(void)
+{
+	if (g_bspveth_dev.pnetdev) {
+		netif_stop_queue(g_bspveth_dev.pnetdev);
+		unregister_netdev(g_bspveth_dev.pnetdev);
+		free_netdev(g_bspveth_dev.pnetdev);
+
+		VETH_LOG(DLOG_DEBUG, "veth netdev exit OK.\n");
+	} else {
+		VETH_LOG(DLOG_DEBUG, "veth_dev.pnetdev NULL.\n");
+	}
+}
+
+
+static void veth_shutdown_task(struct work_struct *work)
+{
+	struct net_device *netdev = g_bspveth_dev.pnetdev;
+
+	VETH_LOG(DLOG_ERROR, "veth is going down, please restart it manual\n");
+
+	g_bspveth_dev.shutdown_cnt++;
+
+	if (netif_carrier_ok(netdev)) {
+		(void)bma_intf_unregister_int_notifier(&g_veth_int_nb);
+
+		netif_carrier_off(netdev);
+
+		bma_intf_set_open_status(g_bspveth_dev.bma_priv, DEV_CLOSE);
+
+		/* can't transmit any more */
+		netif_stop_queue(g_bspveth_dev.pnetdev);
+
+		(void)veth_skbtimer_close();
+
+		(void)veth_dmatimer_close_H();
+	}
+}
+
+
+s32 veth_netdev_init(void)
+{
+	s32 l_ret = 0;
+	struct net_device *netdev = NULL;
+
+#if (KERNEL_VERSION(4, 2, 0) < LINUX_VERSION_CODE)
+	netdev = alloc_netdev_mq(sizeof(struct tag_pcie_comm_priv),
+				BSPVETH_DEV_NAME, NET_NAME_UNKNOWN,
+				veth_netdev_func_init, 1);
+#else
+	netdev = alloc_netdev_mq(sizeof(struct tag_pcie_comm_priv),
+				BSPVETH_DEV_NAME, veth_netdev_func_init, 1);
+#endif
+	/* register netdev */
+	l_ret = register_netdev(netdev);
+	if (l_ret < 0) {
+		VETH_LOG(DLOG_ERROR, "register_netdev faild!ret=%d\n", l_ret);
+
+		return -ENODEV;
+	}
+
+	g_bspveth_dev.pnetdev = netdev;
+
+	VETH_LOG(DLOG_DEBUG, "veth netdev init OK\n");
+
+	INIT_WORK(&g_bspveth_dev.shutdown_task, veth_shutdown_task);
+
+	netif_carrier_off(netdev);
+
+	return BSP_OK;
+}
+
+
+int veth_skb_tr_task(unsigned long data)
+{
+	int rett = BSP_OK;
+	int retr = BSP_OK;
+	int i = 0;
+	int task_state = BSP_OK;
+	struct bspveth_rxtx_q *ptx_queue = NULL;
+	struct bspveth_rxtx_q *prx_queue = NULL;
+
+	for (i = 0; i < MAX_QUEUE_NUM; i++) {
+		prx_queue = g_bspveth_dev.prx_queue[i];
+		if (prx_queue) {
+			g_bspveth_dev.run_skbRXtask++;
+			retr = veth_recv_pkt(prx_queue, i);
+		}
+
+		ptx_queue = g_bspveth_dev.ptx_queue[i];
+		if (ptx_queue) {
+			g_bspveth_dev.run_skbFRtask++;
+			rett = veth_free_txskb(ptx_queue, i);
+			if (__netif_subqueue_stopped(g_bspveth_dev.pnetdev, i)
+				&& JUDGE_TX_QUEUE_SPACE(ptx_queue->head,
+				ptx_queue->next_to_free, 5)) {
+				netif_wake_subqueue(g_bspveth_dev.pnetdev, i);
+				VETH_LOG(DLOG_DEBUG,
+					"queue is free, head: %d, nex to free: %d\n",
+					ptx_queue->head,
+					ptx_queue->next_to_free);
+			}
+		}
+
+		if ((rett == BSP_ERR_AGAIN) || (retr == BSP_ERR_AGAIN))
+			task_state = BSP_ERR_AGAIN;
+	}
+
+	return task_state;
+}
+
+
+static int veth_int_handler(struct notifier_block *pthis, unsigned long ev,
+			    void *unuse)
+{
+	g_bspveth_dev.recv_int++;
+
+	if (netif_running(g_bspveth_dev.pnetdev)) {
+#ifndef USE_TASKLET
+		(void)mod_timer(&g_bspveth_dev.dmatimer, jiffies_64);
+#else
+		tasklet_schedule(&g_bspveth_dev.dma_task);
+
+#endif
+	} else {
+		VETH_LOG(DLOG_DEBUG, "netif is not running\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+void veth_dmaTXtimer_do_H(unsigned long data)
+{
+	int txret, rxret;
+
+	txret = veth_dma_task_H(BSPVETH_TX);
+
+	rxret = veth_dma_task_H(BSPVETH_RX);
+
+	if ((txret == BSP_ERR_AGAIN) || (rxret == BSP_ERR_AGAIN)) {
+#ifndef USE_TASKLET
+		(void)mod_timer(&g_bspveth_dev.dmatimer, jiffies_64);
+#else
+		tasklet_hi_schedule(&g_bspveth_dev.dma_task);
+#endif
+	}
+}
+
+s32 veth_dmatimer_close_H(void)
+{
+#ifndef USE_TASKLET
+	(void)del_timer_sync(&(g_bspveth_dev.dmatimer));
+#else
+	tasklet_kill(&g_bspveth_dev.dma_task);
+#endif
+
+	VETH_LOG(DLOG_DEBUG, "bspveth_dmatimer_close RXTX TIMER ok\n");
+
+	return 0;
+}
+
+
+void veth_dmatimer_init_H(void)
+{
+#ifndef USE_TASKLET
+	setup_timer(&(g_bspveth_dev.dmatimer), veth_dmaTXtimer_do_H,
+		    (unsigned long)&g_bspveth_dev);
+
+	(void)mod_timer(&g_bspveth_dev.dmatimer,
+			jiffies_64 + BSPVETH_DMATIMER_INTERVAL);
+#else
+	tasklet_init(&g_bspveth_dev.dma_task, veth_dmaTXtimer_do_H,
+		     (unsigned long)&g_bspveth_dev);
+#endif
+
+	VETH_LOG(DLOG_DEBUG, "bspveth_dmatimer_init RXTX TIMER OK\n");
+}
+
+
+s32 __check_dmacmp_H(struct bspveth_rxtx_q *prxtx_queue, u32 queue, u32 type)
+{
+	u32 cnt, len, host_head, host_tail, shm_head, shm_tail;
+	u16 start_dma = 0;
+	u16 dmacmperr = 0;
+	int i;
+	enum dma_direction_e dir;
+	struct bspveth_shmq_hd *pshmq_head = NULL;
+
+	if (!prxtx_queue || !prxtx_queue->pshmqhd_v)
+		return BSP_ERR_NULL_POINTER;
+
+	pshmq_head = prxtx_queue->pshmqhd_v;
+	dmacmperr = prxtx_queue->dmacmperr;
+	start_dma = prxtx_queue->start_dma;
+	if (!start_dma)
+		return BSP_OK;
+
+	if (dmacmperr > BSPVETH_WORK_LIMIT / 4) {
+		prxtx_queue->dmacmperr = 0;
+		prxtx_queue->start_dma = 0;
+
+		(void)veth_reset_dma(type);
+
+		if (type == BSPVETH_RX) {
+			VETH_LOG(DLOG_DEBUG,
+				 "bmc to host dma time out,dma count:%d,work_limit:%d\n",
+				 prxtx_queue->dmal_cnt,
+				 prxtx_queue->work_limit);
+
+			INC_STATIS_RX(queue, dma_faild, 1);
+		} else {
+			VETH_LOG(DLOG_DEBUG,
+				 "host to bmc dma time out,dma count:%d,work_limit:%d\n",
+				 prxtx_queue->dmal_cnt,
+				 prxtx_queue->work_limit);
+
+			INC_STATIS_TX(queue, dma_faild, 1);
+		}
+
+		if (prxtx_queue->dmal_cnt > 1)
+			prxtx_queue->work_limit = (prxtx_queue->dmal_cnt >> 1);
+
+		prxtx_queue->dma_overtime++;
+		if (prxtx_queue->dma_overtime > BSPVETH_MAX_QUE_DEEP) {
+			schedule_work(&g_bspveth_dev.shutdown_task);
+
+			return BSPVETH_DMA_BUSY;
+		}
+
+		return BSP_OK;
+	}
+
+	if (type == BSPVETH_RX)
+		dir = BMC_TO_HOST;
+	else
+		dir = HOST_TO_BMC;
+
+	for (i = 0; i < BSPVETH_CHECK_DMA_STATUS_TIMES; i++) {
+		if (bma_intf_check_dma_status(dir) == BSPVETH_DMA_OK)
+			break;
+
+		cpu_relax();
+
+		if (i > 20)
+			udelay(5);
+	}
+
+	if (i >= BSPVETH_CHECK_DMA_STATUS_TIMES) {
+		INC_STATIS_RXTX(queue, dma_busy, 1, type);
+		prxtx_queue->dmacmperr++;
+
+		return BSPVETH_DMA_BUSY;
+	}
+
+	prxtx_queue->start_dma = 0;
+	prxtx_queue->dma_overtime = 0;
+
+	if (type == BSPVETH_RX) {
+		cnt = prxtx_queue->dmal_cnt;
+		len = prxtx_queue->dmal_byte;
+
+		host_head = prxtx_queue->head;
+		shm_tail = pshmq_head->tail;
+
+		pshmq_head->tail = (shm_tail + cnt) & BSPVETH_POINT_MASK;
+		prxtx_queue->head = (host_head + cnt) & BSPVETH_POINT_MASK;
+
+		INC_STATIS_RX(queue, dmapkt, cnt);
+		INC_STATIS_RX(queue, dmapktbyte, len);
+	} else {
+
+		cnt = prxtx_queue->dmal_cnt;
+		len = prxtx_queue->dmal_byte;
+
+		host_tail = prxtx_queue->tail;
+		shm_head = pshmq_head->head;
+
+		prxtx_queue->tail = (host_tail + cnt) & BSPVETH_POINT_MASK;
+		pshmq_head->head = (shm_head + cnt) & BSPVETH_POINT_MASK;
+
+		INC_STATIS_TX(queue, dmapkt, cnt);
+		INC_STATIS_TX(queue, dmapktbyte, len);
+	}
+
+#ifndef USE_TASKLET
+	(void)mod_timer(&g_bspveth_dev.skbtrtimer, jiffies_64);
+#else
+	tasklet_hi_schedule(&g_bspveth_dev.skb_task);
+#endif
+
+	(void)bma_intf_int_to_bmc(g_bspveth_dev.bma_priv);
+
+	g_bspveth_dev.tobmc_int++;
+
+	return BSP_OK;
+}
+
+
+s32 __checkspace_H(struct bspveth_rxtx_q *prxtx_queue, u32 queue, u32 type,
+		   u32 *pcnt)
+{
+	int ret = BSP_OK;
+	u32 host_head, host_tail, host_nextfill;
+	u32 shm_head, shm_tail, shm_nextfill;
+	u32 shm_cnt, host_cnt, cnt_tmp, cnt;
+	struct bspveth_shmq_hd *pshmq_head = NULL;
+
+	if (!prxtx_queue || !prxtx_queue->pshmqhd_v)
+		return BSP_ERR_NULL_POINTER;
+
+	pshmq_head = prxtx_queue->pshmqhd_v;
+	host_head = prxtx_queue->head;
+	host_tail = prxtx_queue->tail;
+	host_nextfill = prxtx_queue->next_to_fill;
+	shm_head = pshmq_head->head;
+	shm_tail = pshmq_head->tail;
+	shm_nextfill = pshmq_head->next_to_fill;
+
+	switch (type) {
+	case BSPVETH_RX:
+		if (shm_tail == shm_head) {
+			INC_STATIS_RXTX(queue, shm_emp, 1, type);
+			ret = BSP_ERR_NOT_TO_HANDLE;
+			goto failed;
+		}
+
+		if (!JUDGE_RX_QUEUE_SPACE(host_head, host_nextfill, 1))
+			return -EFAULT;
+
+		shm_cnt = (shm_head - shm_tail) & BSPVETH_POINT_MASK;
+		cnt_tmp = min(shm_cnt, prxtx_queue->work_limit);
+
+		host_cnt = (host_nextfill - host_head) & BSPVETH_POINT_MASK;
+		cnt = min(cnt_tmp, host_cnt);
+
+		break;
+
+	case BSPVETH_TX:
+		if (host_tail == host_head) {
+			INC_STATIS_RXTX(queue, q_emp, 1, type);
+			ret = BSP_ERR_NOT_TO_HANDLE;
+			goto failed;
+		}
+
+		if (!JUDGE_TX_QUEUE_SPACE(shm_head, shm_nextfill, 1))
+			return -EFAULT;
+
+		host_cnt = (host_head - host_tail) & BSPVETH_POINT_MASK;
+		cnt_tmp = min(host_cnt, prxtx_queue->work_limit);
+		shm_cnt = (shm_nextfill - (shm_head + 1)) & BSPVETH_POINT_MASK;
+		cnt = min(cnt_tmp, shm_cnt);
+
+		break;
+
+	default:
+		INC_STATIS_RXTX(queue, type_err, 1, type);
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	if (cnt > (BSPVETH_DMABURST_MAX * 7 / 8))
+		INC_STATIS_RXTX(queue, dma_burst, 1, type);
+
+#ifdef __UT_TEST
+	if (g_testdma) {
+		VETH_LOG(DLOG_ERROR,
+			 "[type %d],host_cnt=%d cnt_tmp=%d shm_cnt=%d cnt=%d\n",
+			 type, host_cnt, cnt_tmp, shm_cnt, cnt);
+	}
+#endif
+
+	*pcnt = cnt;
+
+	return BSP_OK;
+
+failed:
+	return ret;
+}
+
+
+int __make_dmalistbd_h2b_H(struct bspveth_rxtx_q *prxtx_queue, u32 cnt,
+			    u32 type)
+{
+	u32 i, len = 0, host_tail, shm_head, off;
+	struct bspveth_dmal *pdmalbase_v = NULL;
+	struct bspveth_shmq_hd *pshmq_head = NULL;
+	struct bspveth_bd_info *pbdinfobase_v = NULL;
+	struct bspveth_dma_bd *pbdbase_v = NULL;
+	struct bspveth_dma_shmbd *pshmbdbase_v = NULL;
+
+	if (!prxtx_queue)
+		return BSP_ERR_NULL_POINTER;
+
+	pdmalbase_v = prxtx_queue->pdmalbase_v;
+	pshmq_head = prxtx_queue->pshmqhd_v;
+	pbdinfobase_v = prxtx_queue->pbdinfobase_v;
+	pbdbase_v = prxtx_queue->pbdbase_v;
+	pshmbdbase_v = prxtx_queue->pshmbdbase_v;
+	if (!pdmalbase_v || !pshmq_head || !pbdinfobase_v
+		|| !pbdbase_v || !pshmbdbase_v)
+		return BSP_ERR_NULL_POINTER;
+
+	host_tail = prxtx_queue->tail;
+	shm_head = pshmq_head->head;
+
+	for (i = 0; i < cnt; i++) {
+		off = pbdbase_v[QUEUE_MASK(host_tail + i)].off;
+
+		if (i == (cnt - 1))
+			pdmalbase_v[i].chl = 0x9;
+		else
+			pdmalbase_v[i].chl = 0x0000001;
+		pdmalbase_v[i].len =
+		    (pbdinfobase_v[QUEUE_MASK(host_tail + i)].pdma_v)->len;
+		pdmalbase_v[i].slow =
+		    lower_32_bits(pbdbase_v[QUEUE_MASK(host_tail + i)].dma_p);
+		pdmalbase_v[i].shi =
+		    upper_32_bits(pbdbase_v[QUEUE_MASK(host_tail + i)].dma_p);
+		pdmalbase_v[i].dlow =
+		    lower_32_bits(pshmbdbase_v[QUEUE_MASK(shm_head + i)].dma_p);
+		pdmalbase_v[i].dhi = 0;
+
+		pshmbdbase_v[QUEUE_MASK(shm_head + i)].len = pdmalbase_v[i].len;
+
+		pdmalbase_v[i].len += off;
+
+		pshmbdbase_v[QUEUE_MASK(shm_head + i)].off = off;
+
+		len += pdmalbase_v[i].len;
+
+#ifdef __UT_TEST
+		if (g_testdma) {
+			struct sk_buff *skb =
+			    pbdinfobase_v[QUEUE_MASK(host_tail + i)].pdma_v;
+
+			VETH_LOG(DLOG_ERROR,
+				 "[%d][makebd-H2B]:chl=0x%x,len=%d,slow=0x%x,shi=0x%x,dlow=0x%x,dhi=0x%x,skb=%p,skb->data=%p,skb->len=%d,host_tail+i=%d,shm_head+i=%d,off=%d\n",
+				 i, pdmalbase_v[i].chl, pdmalbase_v[i].len,
+				 pdmalbase_v[i].slow, pdmalbase_v[i].shi,
+				 pdmalbase_v[i].dlow, pdmalbase_v[i].dhi,
+				 skb, skb->data, skb->len,
+				 QUEUE_MASK(host_tail + i),
+				 QUEUE_MASK(shm_head + i), off);
+		}
+#endif
+	}
+
+	//pdmalbase_v[i - 1].chl = 0x9;
+	pdmalbase_v[i].chl = 0x7;
+	pdmalbase_v[i].len = 0x0;
+	pdmalbase_v[i].slow = lower_32_bits((u64)prxtx_queue->pdmalbase_p);
+	pdmalbase_v[i].shi = upper_32_bits((u64)prxtx_queue->pdmalbase_p);
+	pdmalbase_v[i].dlow = 0;
+	pdmalbase_v[i].dhi = 0;
+
+	prxtx_queue->dmal_cnt = cnt;
+	prxtx_queue->dmal_byte = len;
+
+#ifdef __UT_TEST
+	if (g_testdma) {
+		VETH_LOG(DLOG_ERROR,
+			 "[END][makebd-H2B]:chl=0x%x,len=%d,slow=0x%x,shi=0x%x,dmal_cnt=%d,dmal_dir=%d,dmal_byte=%d,pdmalbase_v=%p\n",
+			 pdmalbase_v[i].chl, pdmalbase_v[i].len,
+			 pdmalbase_v[i].slow, pdmalbase_v[i].shi, cnt, type,
+			 len, pdmalbase_v);
+	}
+#endif
+
+	return 0;
+}
+
+
+int __make_dmalistbd_b2h_H(struct bspveth_rxtx_q *prxtx_queue, u32 cnt,
+			    u32 type)
+{
+	u32 i, len = 0, host_head, shm_tail, off;
+	struct bspveth_dmal *pdmalbase_v = NULL;
+	struct bspveth_shmq_hd *pshmq_head = NULL;
+	struct bspveth_bd_info *pbdinfobase_v = NULL;
+	struct bspveth_dma_bd *pbdbase_v = NULL;
+	struct bspveth_dma_shmbd *pshmbdbase_v = NULL;
+
+	if (!prxtx_queue) {
+		VETH_LOG(DLOG_ERROR,
+			 "[END][makebd-B2H]:prxtx_queue NULL!!!\n");
+		return BSP_ERR_NULL_POINTER;
+	}
+
+	pdmalbase_v = prxtx_queue->pdmalbase_v;
+	pshmq_head = prxtx_queue->pshmqhd_v;
+	pbdinfobase_v = prxtx_queue->pbdinfobase_v;
+	pbdbase_v = prxtx_queue->pbdbase_v;
+	pshmbdbase_v = prxtx_queue->pshmbdbase_v;
+	if (!pdmalbase_v || !pshmq_head || !pbdinfobase_v
+		|| !pbdbase_v || !pshmbdbase_v) {
+		VETH_LOG(DLOG_ERROR,
+			 "[END][makebd-B2H]:pdmalbase_v NULL!!!\n");
+		return BSP_ERR_NULL_POINTER;
+	}
+
+	host_head = prxtx_queue->head;
+	shm_tail = pshmq_head->tail;
+
+	for (i = 0; i < cnt; i++) {
+		off = pshmbdbase_v[QUEUE_MASK(shm_tail + i)].off;
+		if (i == (cnt - 1))
+			pdmalbase_v[i].chl = 0x9;
+		else
+			pdmalbase_v[i].chl = 0x0000001;
+		pdmalbase_v[i].len = pshmbdbase_v[QUEUE_MASK(shm_tail + i)].len;
+		pdmalbase_v[i].slow =
+		    lower_32_bits(pshmbdbase_v[QUEUE_MASK(shm_tail + i)].dma_p);
+		pdmalbase_v[i].shi = 0;
+		pdmalbase_v[i].dlow =
+		    lower_32_bits(pbdbase_v[QUEUE_MASK(host_head + i)].dma_p);
+		pdmalbase_v[i].dhi =
+		    upper_32_bits(pbdbase_v[QUEUE_MASK(host_head + i)].dma_p);
+		pdmalbase_v[i].len += off;
+
+		pbdbase_v[QUEUE_MASK(host_head + i)].off = off;
+		pbdbase_v[QUEUE_MASK(host_head + i)].len = pdmalbase_v[i].len;
+
+		len += pdmalbase_v[i].len;
+
+#ifdef __UT_TEST
+		if (g_testdma) {
+			struct sk_buff *skb =
+			    pbdinfobase_v[QUEUE_MASK(host_head + i)].pdma_v;
+
+			VETH_LOG(DLOG_ERROR,
+				 "[%d][makebd-B2H]:chl=0x%x,len=%d,slow=0x%x,shi=0x%x,dlow=0x%x,dhi=0x%x,skb=%p,skb->data=%p,skb->len=%d,shm_tail+i=%d,host_head+i=%d,off=%d\n",
+				 i, pdmalbase_v[i].chl, pdmalbase_v[i].len,
+				 pdmalbase_v[i].slow, pdmalbase_v[i].shi,
+				 pdmalbase_v[i].dlow, pdmalbase_v[i].dhi,
+				 skb, skb->data, skb->len,
+				 QUEUE_MASK(shm_tail + i),
+				 QUEUE_MASK(host_head + i), off);
+		}
+#endif
+	}
+
+	//pdmalbase_v[i - 1].chl = 0x9;
+	pdmalbase_v[i].chl = 0x0000007;
+	pdmalbase_v[i].len = 0x0;
+	pdmalbase_v[i].slow = lower_32_bits((u64)prxtx_queue->pdmalbase_p);
+	pdmalbase_v[i].shi = upper_32_bits((u64)prxtx_queue->pdmalbase_p);
+	pdmalbase_v[i].dlow = 0;
+	pdmalbase_v[i].dhi = 0;
+
+	prxtx_queue->dmal_cnt = cnt;
+	prxtx_queue->dmal_byte = len;
+
+#ifdef __UT_TEST
+	if (g_testdma) {
+		VETH_LOG(DLOG_ERROR,
+			 "[END][makebd-B2H]:chl=0x%x,len=%d,slow=0x%x,shi=0x%x,dmal_cnt=%d,dmal_dir=%d,dmal_byte=%d pdmalbase_v=%p\n",
+			 pdmalbase_v[i].chl, pdmalbase_v[i].len,
+			 pdmalbase_v[i].slow, pdmalbase_v[i].shi, cnt, type,
+			 len, pdmalbase_v);
+	}
+
+#endif
+
+	return 0;
+}
+
+
+s32 __start_dmalist_H(struct bspveth_rxtx_q *prxtx_queue, u32 cnt, u32 type)
+{
+	int ret = BSP_OK;
+	struct bma_dma_transfer_s dma_transfer = { 0 }; /*lint !e64*/
+
+	if (!prxtx_queue)
+		return -1;
+
+	switch (type) {
+	case BSPVETH_RX:
+		ret = __make_dmalistbd_b2h_H(prxtx_queue, cnt, type);
+		if (ret)
+			goto failed;
+		dma_transfer.dir = BMC_TO_HOST;
+
+		break;
+
+	case BSPVETH_TX:
+		ret = __make_dmalistbd_h2b_H(prxtx_queue, cnt, type);
+		if (ret)
+			goto failed;
+		dma_transfer.dir = HOST_TO_BMC;
+
+		break;
+
+	default:
+		ret = -1;
+		goto failed;
+
+	}
+
+	dma_transfer.type = DMA_LIST;
+	dma_transfer.transfer.list.dma_addr =
+	    (dma_addr_t) prxtx_queue->pdmalbase_p;
+
+	ret = bma_intf_start_dma(g_bspveth_dev.bma_priv, &dma_transfer);
+	if (ret < 0)
+		goto failed;
+
+	prxtx_queue->start_dma = 1;
+
+	return BSP_OK;
+
+failed:
+	return ret;
+}
+
+
+s32 __dma_rxtx_H(struct bspveth_rxtx_q *prxtx_queue, u32 queue, u32 type)
+{
+	int ret = BSP_OK;
+	u32 cnt;
+	u32 shm_init;
+	struct bspveth_shmq_hd *pshmq_head = NULL;
+
+	if (!prxtx_queue || !prxtx_queue->pshmqhd_v)
+		return BSP_ERR_NULL_POINTER;
+
+	pshmq_head = prxtx_queue->pshmqhd_v;
+	shm_init = pshmq_head->init;
+	if (shm_init != BSPVETH_SHMQUEUE_INITOK) {
+		INC_STATIS_RXTX(queue, shmqueue_noinit, 1, type);
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	if (type == BSPVETH_RX) {
+		if (prxtx_queue->pshmqhd_v->head
+			== prxtx_queue->pshmqhd_v->tail)
+			return BSP_OK;
+	} else {
+		if (prxtx_queue->head == prxtx_queue->tail)
+			return BSP_OK;
+	}
+
+	if (prxtx_queue->dma_overtime > BSPVETH_MAX_QUE_DEEP)
+		return -EFAULT;
+
+	ret = __check_dmacmp_H(prxtx_queue, queue, type);
+	if (ret != BSP_OK) {
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	ret = __checkspace_H(prxtx_queue, queue, type, &cnt);
+	if (ret != BSP_OK) {
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	if (prxtx_queue->dmal_cnt > 1 && cnt < (prxtx_queue->work_limit / 2)
+	    && (type == BSPVETH_RX)) {
+		udelay(50);
+		prxtx_queue->dmal_cnt--;
+
+		return -EFAULT;
+	}
+
+	ret = __start_dmalist_H(prxtx_queue, cnt, type);
+	if (ret != BSP_OK) {
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	if (cnt <= 16) {
+		ret = __check_dmacmp_H(prxtx_queue, queue, type);
+		if (ret != BSP_OK) {
+			ret = -EFAULT;
+			goto failed;
+		}
+	}
+
+	return BSP_OK;
+
+failed:
+	return ret;
+}
+
+
+int veth_dma_task_H(u32 type)
+{
+	int i;
+	struct bspveth_rxtx_q *prxtx_queue;
+
+	for (i = 0; i < MAX_QUEUE_NUM; i++) {
+		if (type == BSPVETH_RX) {
+			g_bspveth_dev.run_dmaRXtask++;
+			prxtx_queue = g_bspveth_dev.prx_queue[i];
+		} else {
+			g_bspveth_dev.run_dmaTXtask++;
+			prxtx_queue = g_bspveth_dev.ptx_queue[i];
+		}
+
+		if (prxtx_queue) {
+			struct bspveth_shmq_hd *pshmq_head
+				= prxtx_queue->pshmqhd_v;
+			(void)__dma_rxtx_H(prxtx_queue, i, type);
+			if (((type == BSPVETH_RX)
+			    && (pshmq_head->head != pshmq_head->tail))
+			    || ((type == BSPVETH_TX)
+			    && (prxtx_queue->head != prxtx_queue->tail)))
+				return BSP_ERR_AGAIN;
+		}
+	}
+
+	return BSP_OK;
+}
+
+#ifdef __UT_TEST
+
+s32 __atu_config_H(struct pci_dev *pdev, unsigned int region,
+		   unsigned int hostaddr_h, unsigned int hostaddr_l,
+		   unsigned int bmcaddr_h, unsigned int bmcaddr_l,
+		   unsigned int len)
+{
+	(void)pci_write_config_dword(pdev, 0x900,
+				     0x80000000 + (region & 0x00000007));
+	(void)pci_write_config_dword(pdev, 0x90c, hostaddr_l);
+	(void)pci_write_config_dword(pdev, 0x910, hostaddr_h);
+	(void)pci_write_config_dword(pdev, 0x914, hostaddr_l + len - 1);
+	(void)pci_write_config_dword(pdev, 0x918, bmcaddr_l);
+	(void)pci_write_config_dword(pdev, 0x91c, bmcaddr_h);
+	/*  atu ctrl1 reg   */
+	(void)pci_write_config_dword(pdev, 0x904, 0x00000000);
+	/*  atu ctrl2 reg   */
+	(void)pci_write_config_dword(pdev, 0x908, 0x80000000);
+
+	return 0;
+}
+
+void bspveth_atu_config_H(void)
+{
+	__atu_config_H(g_bspveth_dev.ppcidev,
+		       1,
+		       (sizeof(unsigned long) == 8) ?
+		       ((u64) (g_bspveth_dev.phostrtc_p) >> 32) : 0,
+		       ((u64) (g_bspveth_dev.phostrtc_p) & 0xffffffff),
+		       0, HOSTRTC_REG_BASE, HOSTRTC_REG_SIZE);
+
+	__atu_config_H(g_bspveth_dev.ppcidev,
+		       2,
+		       (sizeof(unsigned long) == 8) ?
+		       ((u64) (g_bspveth_dev.pshmpool_p) >> 32) : 0,
+		       ((u64) (g_bspveth_dev.pshmpool_p) & 0xffffffff),
+		       0, VETH_SHAREPOOL_BASE_INBMC, VETH_SHAREPOOL_SIZE);
+
+}
+
+void bspveth_pcie_free_H(void)
+{
+	struct pci_dev *pdev = g_bspveth_dev.ppcidev;
+
+	if (pdev)
+		pci_disable_device(pdev);
+	else
+		VETH_LOG(DLOG_ERROR, "bspveth_dev.ppcidev  IS NULL\n");
+
+	VETH_LOG(DLOG_DEBUG, "bspveth_pcie_exit_H ok\n");
+}
+
+#endif
+
+
+void bspveth_host_exit_H(void)
+{
+	int ret = 0;
+
+	ret = bma_intf_unregister_type((void **)&(g_bspveth_dev.bma_priv));
+	if (ret < 0) {
+		VETH_LOG(DLOG_ERROR, "bma_intf_unregister_type failed\n");
+
+		return;
+	}
+
+	VETH_LOG(DLOG_DEBUG, "bspveth host exit H OK\n");
+}
+
+
+s32 bspveth_host_init_H(void)
+{
+	int ret = 0;
+	struct bma_priv_data_s *bma_priv = NULL;
+
+	ret = bma_intf_register_type(TYPE_VETH, 0,
+					INTR_ENABLE, (void **)&bma_priv);
+	if (ret) {
+		ret = -1;
+		goto failed;
+	}
+
+	if (!bma_priv) {
+		VETH_LOG(DLOG_ERROR, "bma_priv is NULL\n");
+		return -1;
+	}
+
+	VETH_LOG(DLOG_DEBUG,
+		 "bma_intf_register_type pdev = %p, veth_swap_addr = %p, veth_swap_len = 0x%lx, veth_swap_phy_addr = 0x%lx\n",
+		 bma_priv->specific.veth.pdev,
+		 bma_priv->specific.veth.veth_swap_addr,
+		 bma_priv->specific.veth.veth_swap_len,
+		 bma_priv->specific.veth.veth_swap_phy_addr);
+
+	g_bspveth_dev.bma_priv = bma_priv;
+	g_bspveth_dev.ppcidev = bma_priv->specific.veth.pdev;
+
+	/*bspveth_dev.phostrtc_p = (u8 *)bar1_base;*/
+	/*bspveth_dev.phostrtc_v = (u8 *)bar1_remap;*/
+	g_bspveth_dev.pshmpool_p =
+			(u8 *)bma_priv->specific.veth.veth_swap_phy_addr;
+	g_bspveth_dev.pshmpool_v =
+			(u8 *)bma_priv->specific.veth.veth_swap_addr;
+	g_bspveth_dev.shmpoolsize = bma_priv->specific.veth.veth_swap_len;
+
+	VETH_LOG(DLOG_DEBUG, "bspveth host init H OK\n");
+
+	return BSP_OK;
+
+failed:
+	return ret;
+}
+
+
+static int __init veth_init(void)
+{
+	int ret = BSP_OK;
+	int lBufLen = 0;
+
+	if (!bma_intf_check_edma_supported())
+		return -ENXIO;
+
+	memset_s(&g_bspveth_dev, sizeof(g_bspveth_dev),
+		 0, sizeof(g_bspveth_dev));
+
+
+	lBufLen = snprintf(g_bspveth_dev.name, NET_NAME_LEN,
+			   "%s", BSPVETH_DEV_NAME);
+	if ((lBufLen < 0) || ((u32)lBufLen >= (NET_NAME_LEN))) {
+		VETH_LOG(DLOG_ERROR, "BSP_SNPRINTF lRet =0x%x\n", lBufLen);
+		return BSP_ERR_INVALID_STR;
+	}
+
+	ret = bspveth_host_init_H();
+	if (ret != BSP_OK) {
+		ret = -1;
+		goto failed1;
+	}
+
+	ret = veth_netdev_init();
+	if (ret != BSP_OK) {
+		ret = -1;
+		goto failed2;
+	}
+
+	GET_SYS_SECONDS(g_bspveth_dev.init_time);
+
+
+	return BSP_OK;
+
+failed2:
+	bspveth_host_exit_H();
+
+failed1:
+
+	return ret;
+}
+
+
+static void __exit veth_exit(void)
+{
+	veth_netdev_exit();
+
+	bspveth_host_exit_H();
+}
+
+MODULE_AUTHOR("HUAWEI TECHNOLOGIES CO., LTD.");
+MODULE_DESCRIPTION("HUAWEI VETH DRIVER");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(VETH_VERSION);
+
+module_init(veth_init);
+module_exit(veth_exit);
diff --git a/drivers/net/ethernet/huawei/ibma/veth_hb.h b/drivers/net/ethernet/huawei/ibma/veth_hb.h
new file mode 100644
index 0000000..5f1f7fa
--- /dev/null
+++ b/drivers/net/ethernet/huawei/ibma/veth_hb.h
@@ -0,0 +1,578 @@
+/*
+*Huawei iBMA driver.
+*Copyright (c) 2017, Huawei Technologies Co., Ltd.
+*
+*This program is free software; you can redistribute it and/or
+*modify it under the terms of the GNU General Public License
+*as published by the Free Software Foundation; either version 2
+*of the License, or (at your option) any later version.
+*
+*This program is distributed in the hope that it will be useful,
+*but WITHOUT ANY WARRANTY; without even the implied warranty of
+*MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+*GNU General Public License for more details.
+*/
+
+
+#ifndef _VETH_HB_H_
+#define _VETH_HB_H_
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <linux/interrupt.h>
+
+#define DEP_BMA
+
+#include "bma_include.h"
+#include "bma_ker_intf.h"
+
+
+#ifdef DRV_VERSION
+#define VETH_VERSION	MICRO_TO_STR(DRV_VERSION)
+#else
+#define VETH_VERSION	"0.2.9"
+#endif
+
+#define MODULE_NAME	"veth"
+#define BSP_VETH_T	u64
+
+#define BSP_OK				(0)
+#define BSP_ERR				(0xFFFFFFFF)
+#define BSP_NETDEV_TX_BUSY		(1)
+#define BSP_ERR_INIT_ERR		(BSP_NETDEV_TX_BUSY)
+#define BSP_ETH_ERR_BASE		(0x0FFFF000)
+#define BSP_ERR_OUT_OF_MEM		(BSP_ETH_ERR_BASE + 1)
+#define BSP_ERR_NULL_POINTER		(BSP_ETH_ERR_BASE + 2)
+#define BSP_ERR_INVALID_STR		(BSP_ETH_ERR_BASE + 3)
+#define BSP_ERR_INVALID_PARAM		(BSP_ETH_ERR_BASE + 4)
+#define BSP_ERR_INVALID_DATA		(BSP_ETH_ERR_BASE + 5)
+#define BSP_ERR_OUT_OF_RANGE		(BSP_ETH_ERR_BASE + 6)
+#define BSP_ERR_INVALID_CARD		(BSP_ETH_ERR_BASE + 7)
+#define BSP_ERR_INVALID_GRP		(BSP_ETH_ERR_BASE + 8)
+#define BSP_ERR_INVALID_ETH		(BSP_ETH_ERR_BASE + 9)
+#define BSP_ERR_SEND_ERR		(BSP_ETH_ERR_BASE + 10)
+#define BSP_ERR_DMA_ERR			(BSP_ETH_ERR_BASE + 11)
+#define BSP_ERR_RECV_ERR		(BSP_ETH_ERR_BASE + 12)
+#define BSP_ERR_SKB_ERR			(BSP_ETH_ERR_BASE + 13)
+#define BSP_ERR_DMA_ADDR_ERR		(BSP_ETH_ERR_BASE + 14)
+#define BSP_ERR_IOREMAP_ERR		(BSP_ETH_ERR_BASE + 15)
+#define BSP_ERR_LEN_ERR			(BSP_ETH_ERR_BASE + 16)
+#define BSP_ERR_STAT_ERR		(BSP_ETH_ERR_BASE + 17)
+#define BSP_ERR_AGAIN			(BSP_ETH_ERR_BASE + 18)
+#define BSP_ERR_NOT_TO_HANDLE		(BSP_ETH_ERR_BASE + 19)
+
+#define VETH_H2B_IRQ_NO			(113)
+#define SYSCTL_REG_BASE			(0x20000000)
+#define SYSCTL_REG_SIZE			(0x1000)
+#define PCIE1_REG_BASE			(0x29000000)
+#define PCIE1_REG_SIZE			(0x1000)
+#define VETH_SHAREPOOL_BASE_INBMC	(0x84820000)
+#define VETH_SHAREPOOL_SIZE		(0xdf000)
+#define VETH_SHAREPOOL_OFFSET		(0x10000)
+#define MAX_SHAREQUEUE_SIZE		(0x20000)
+
+#define BSPVETH_SHMBDBASE_OFFSET	(0x80)
+#define SHMDMAL_OFFSET			(0x10000)
+#define MAX_SHMDMAL_SIZE		(BSPVETH_DMABURST_MAX*32)
+
+#define BSPVETH_DMABURST_MAX		64
+#define BSPVETH_SKBTIMER_INTERVAL	(1)
+#define BSPVETH_DMATIMER_INTERVAL	(1)
+#define BSPVETH_CTLTIMER_INTERVAL	(10)
+#define BSPVETH_HDCMD_CHKTIMER_INTERVAL	(10)
+#define BSP_DMA_64BIT_MASK		(0xffffffffffffffffULL)
+#define BSP_DMA_32BIT_MASK		(0x00000000ffffffffULL)
+#define HOSTRTC_REG_BASE		(0x2f000000)
+#define HOSTRTC_REG_SIZE		(0x10000)
+#define REG_SYSCTL_HOSTINT_CLEAR	(0x44)
+#define SHIFT_SYSCTL_HOSTINT_CLEAR	(22)
+#define REG_SYSCTL_HOSTINT		(0xf4)
+#define SHIFT_SYSCTL_HOSTINT		(26)
+
+#define NET_TYPE_LEN			(16)
+
+#define MAX_QUEUE_NUM			(1)
+#define MAX_QUEUE_BDNUM			(128)
+#define BSPVETH_MAX_QUE_DEEP		(MAX_QUEUE_BDNUM)
+#define BSPVETH_POINT_MASK		(MAX_QUEUE_BDNUM-1)
+#define BSPVETH_WORK_LIMIT		(64)
+#define BSPVETH_CHECK_DMA_STATUS_TIMES	(120)
+
+#define REG_PCIE1_DMAREAD_ENABLE	(0xa18)
+#define SHIFT_PCIE1_DMAREAD_ENABLE	(0)
+#define REG_PCIE1_DMAWRITE_ENABLE	(0x9c4)
+#define SHIFT_PCIE1_DMAWRITE_ENABLE	(0)
+#define REG_PCIE1_DMAREAD_STATUS	(0xa10)
+#define SHIFT_PCIE1_DMAREAD_STATUS	(0)
+#define REG_PCIE1_DMAREADINT_CLEAR	(0xa1c)
+#define SHIFT_PCIE1_DMAREADINT_CLEAR	(0)
+#define REG_PCIE1_DMAWRITE_STATUS	(0x9bc)
+#define SHIFT_PCIE1_DMAWRITE_STATUS	(0)
+#define REG_PCIE1_DMAWRITEINT_CLEAR	(0x9c8)
+#define SHIFT_PCIE1_DMAWRITEINT_CLEAR	(0)
+
+#define BSPVETH_DMA_OK			(1)
+#define BSPVETH_DMA_BUSY		(0)
+#define BSPVETH_RX			(2)
+#define BSPVETH_TX			(3)
+#define HOSTRTC_INT_OFFSET		(0x10)
+#define BSPVETH_DEV_NAME		(MODULE_NAME)
+#define NET_NAME_LEN			(64)
+
+#ifndef PCI_VENDOR_ID_HUAWEI
+#define PCI_VENDOR_ID_HUAWEI		(0x19e5)
+#endif
+
+#define PCI_DEVICE_ID_KBOX		(0x1710)
+#define BSPVETH_MTU_MAX			(1500)
+#define BSPVETH_MTU_MIN			(64)
+#define BSPVETH_SKB_SIZE 		(1536)
+#define BSPVETH_NET_TIMEOUT		(5 * HZ)
+#define BSPVETH_QUEUE_TIMEOUT_10MS	(100)
+#define BSPVETH_SHMQUEUE_INITOK		(0x12)
+#define BSPVETH_LBK_TYPE		(0x800)
+
+#ifndef VETH_BMC
+#define BSPVETH_CACHELINE_SIZE		(64)
+#else
+#define BSPVETH_CACHELINE_SIZE		(32)
+#endif
+#define BSPVETH_HBCMD_WCMP		(0x44)
+#define BSPVETH_HBCMD_CMP		(0x55)
+#define BSPVETH_HBCMD_OK		(0x66)
+#define BSPVETH_HEART_WACK		(0x99)
+#define BSPVETH_HEART_ACK		(0xaa)
+
+#define BSPVETH_HBCMD_TIMEOUT		(1000)
+
+enum VEthHBCmd {
+	VETH_HBCMD_UNKOWN = 0x0,
+	VETH_HBCMD_SETIP,
+
+	VETH_HBCMD_MAX,
+};
+
+#define USE_TASKLET
+
+#define BSPVETH_ETHTOOL_BASE		0x89F0
+#define BSPVETH_ETHTOOL_TESTINT		(BSPVETH_ETHTOOL_BASE + 1)
+#define BSPVETH_ETHTOOL_TESTSHAREMEM	(BSPVETH_ETHTOOL_BASE + 2)
+#define BSPVETH_ETHTOOL_DUMPSHAREMEM	(BSPVETH_ETHTOOL_BASE + 3)
+#define BSPVETH_ETHTOOL_TESTDMA		(BSPVETH_ETHTOOL_BASE + 4)
+#define BSPVETH_ETHTOOL_RWPCIEREG	(BSPVETH_ETHTOOL_BASE + 5)
+#define BSPVETH_ETHTOOL_TESTLBK		(BSPVETH_ETHTOOL_BASE + 6)
+#define BSPVETH_ETHTOOL_INITSTATIS	(BSPVETH_ETHTOOL_BASE + 7)
+#define BSPVETH_HBCMD			(BSPVETH_ETHTOOL_BASE + 8)
+
+struct bspveth_test {
+	u32 intdirect;	/*0--H2B,1--B2H*/
+	u32 rwshmcheck;	/*0--w,1--r and check*/
+	u32 dshmbase;
+	u32 dshmlen;
+	u32 testdma;	/*0--disable,1---enable*/
+	u32 pcierw;	/*0--w,1---r*/
+	u32 reg;
+	u32 data;
+	u32 testlbk;	/*0--disable,1---enable*/
+};
+
+struct bspveth_hdcmd {
+	u32 cmd;
+	u32 stat;
+	u32 heart;
+	u32 err;
+	u32 sequence;
+	u32 len;
+	u8 data[256];
+};
+
+
+struct bspveth_rxtx_statis {
+	u64 pkt;
+	u64 pktbyte;
+	u64 refill;
+	u64 freetx;
+	u64 dmapkt;
+	u64 dmapktbyte;
+
+	u32 dropped_pkt;
+	u32 netifrx_err;
+	u32 null_point;
+	u32 retry_err;
+	u32 dma_mapping_err;
+	u32 allocskb_err;
+	u32 q_full;
+	u32 q_emp;
+	u32 shm_full;
+	u32 shm_emp;
+	u32 dma_busy;
+	u32 need_fill;
+	u32 need_free;
+	u32 dmacmp_err;
+	u32 type_err;
+	u32 shmqueue_noinit;
+	u32 shmretry_err;
+	u32 dma_earlyint;
+	u32 clr_dma_earlyint;
+	u32 clr_dma_int;
+	u32 dmarx_shmaddr_unalign;
+	u32 dmarx_hostaddr_unalign;
+	u32 dmatx_shmaddr_unalign;
+	u32 dmatx_hostaddr_unalign;
+	u32 dma_need_offset;
+	u32 lastdmadir_err;
+	u32 dma_faild;
+	u32 dma_burst;
+	u32 lbk_cnt;
+	u32 lbk_txerr;
+};
+
+struct bspveth_bd_info {
+	struct sk_buff *pdma_v;
+	u32 len;
+	unsigned long time_stamp;
+};
+
+struct bspveth_dma_shmbd {
+	u32 dma_p;
+	u32 len;
+	u32 off;
+};
+
+struct bspveth_shmq_hd {
+	u32 count;
+	u32 size;	/*count x sizeof(dmaBD)*/
+	u32 next_to_fill;
+	u32 next_to_free;
+	u32 head;
+	u32 tail;
+	u16 init;	/*  1--ok,0--nok*/
+};
+
+struct bspveth_dma_bd {
+	u64 dma_p;
+	u32 len;
+	u32 off;
+};
+
+
+struct bspveth_dmal {
+	u32 chl;
+	u32 len;
+	u32 slow;
+	u32 shi;
+	u32 dlow;
+	u32 dhi;
+};
+
+struct bspveth_rxtx_q {
+
+#ifndef VETH_BMC
+	struct bspveth_dma_bd *pbdbase_v;
+	u8 *pbdbase_p;
+#endif
+
+	struct bspveth_bd_info *pbdinfobase_v;
+	struct bspveth_shmq_hd *pshmqhd_v;
+	u8 *pshmqhd_p;
+
+	struct bspveth_dma_shmbd *pshmbdbase_v;
+	u8 *pshmbdbase_p;
+
+	struct bspveth_dmal *pdmalbase_v;
+	u8 *pdmalbase_p;
+
+	u32 dmal_cnt;
+	u32 dmal_byte;
+
+	u32 count;
+	u32 size;
+	u32 rx_buf_len;
+
+	u32 next_to_fill;
+	u32 next_to_free;
+	u32 head;
+	u32 tail;
+	u16 start_dma;
+	u16 dmacmperr;
+
+	u16 dma_overtime;
+
+	u32 work_limit;
+	struct bspveth_rxtx_statis s;
+};
+
+struct bspveth_device {
+	struct bspveth_rxtx_q *ptx_queue[MAX_QUEUE_NUM];
+	struct bspveth_rxtx_q *prx_queue[MAX_QUEUE_NUM];
+	struct net_device *pnetdev;
+	char name[NET_NAME_LEN];
+
+	struct pci_dev *ppcidev;
+	u8 *phostrtc_p;
+	u8 *phostrtc_v;
+
+	u8 *psysctl_v;
+	u8 *ppcie1_v;
+
+	u8 *pshmpool_p;
+	u8 *pshmpool_v;
+	u32 shmpoolsize;
+
+	u32 recv_int;
+	u32 tobmc_int;
+	u32 tohost_int;
+	u32 run_dmaTXtask;
+	u32 run_dmaRXtask;
+	u32 run_skbRXtask;
+	u32 run_skbFRtask;
+	u32 shutdown_cnt;
+	__kernel_time_t init_time;
+
+	spinlock_t reg_lock;
+#ifndef USE_TASKLET
+	struct timer_list skbtrtimer;
+	struct timer_list dmatimer;
+#else
+	struct tasklet_struct skb_task;
+	struct tasklet_struct dma_task;
+#endif
+
+	struct net_device_stats stats;
+	struct work_struct shutdown_task;
+#ifdef DEP_BMA
+	struct bma_priv_data_s *bma_priv;
+#else
+	void *edma_priv;
+#endif
+};
+
+struct tag_pcie_comm_priv {
+	char net_type[NET_TYPE_LEN];
+	struct net_device_stats stats;
+	int status;
+	int irq_enable;
+	int pcie_comm_rx_flag;
+	spinlock_t lock;
+};
+
+#define QUEUE_MASK(p)		((p) & (BSPVETH_POINT_MASK))
+
+
+#define CHECK_ADDR_ALIGN(addr, statis)\
+	do {                         \
+		if (addr & 0x3) \
+			statis;\
+	} while (0)
+
+#define VETH_LOG(lv, fmt, args...)    \
+	do {                          \
+		if (debug >= lv) \
+			printk(KERN_NOTICE "edma_veth: %s(), %d, " fmt, \
+				__func__, __LINE__, ## args); \
+	} while (0)
+
+#define PROC_P_STATIS(name, statis)\
+	do {                          \
+		PROC_DPRINTK("[%10s]:\t0x%llx", #name, statis);\
+	} while (0)
+
+#define  INC_STATIS_RX(queue, name, count) \
+	do {\
+		g_bspveth_dev.prx_queue[queue]->s.name += (count);\
+	} while (0)
+
+#define  INC_STATIS_TX(queue, name, count) \
+	do { \
+		g_bspveth_dev.ptx_queue[queue]->s.name += (count);\
+	} while (0)
+
+#define  INC_STATIS_RX_TONETSTATS(queue, name, count, netstats) \
+	do {\
+		g_bspveth_dev.prx_queue[queue]->s.name += (count);\
+		g_bspveth_dev.stats.netstats += count;\
+	} while (0)
+
+#define  INC_STATIS_TX_TONETSTATS(queue, name, count, netstats) \
+	do {                 \
+		g_bspveth_dev.ptx_queue[queue]->s.name += (count);\
+		g_bspveth_dev.stats.netstats += count;\
+	} while (0)
+
+#define  INC_STATIS_RXTX(queue, name, count, type) \
+	do {                 \
+		if (type == BSPVETH_RX)\
+			g_bspveth_dev.prx_queue[queue]->s.name += count;\
+		else\
+			g_bspveth_dev.ptx_queue[queue]->s.name += count;\
+	} while (0)
+
+#define  INC_STATIS_RXTX_TONETSTATS(queue, name, count, type, netstats) \
+	do {                 \
+		if (type == BSPVETH_RX)\
+			g_bspveth_dev.prx_queue[queue]->s.name += count;\
+		else\
+			g_bspveth_dev.ptx_queue[queue]->s.name += count;\
+		g_bspveth_dev.stats.netstats += count;\
+	} while (0)
+
+
+#define PROC_P_STATIS_QUEUE_RXTX_PARA(queue, name, type)\
+	do {                                        \
+		if (type == BSPVETH_RX) {\
+			if (g_bspveth_dev.prx_queue[queue])\
+				PROC_P_STATIS_QUEUE_32(queue, name, \
+				      g_bspveth_dev.prx_queue[queue]->name);\
+		} else {\
+			if (g_bspveth_dev.ptx_queue[queue])\
+				PROC_P_STATIS_QUEUE_32(queue, name, \
+				      g_bspveth_dev.ptx_queue[queue]->name);\
+		} \
+	} while (0)
+
+
+#define PROC_P_STATIS_QUEUE_RXTX_SHARE(queue, name, type)\
+	do {                                        \
+		if (type == BSPVETH_RX) {\
+			if (g_bspveth_dev.prx_queue[queue])\
+				PROC_P_STATIS_QUEUE_32(queue, name,\
+				g_bspveth_dev.prx_queue[queue]->pshmqhd_v->name);\
+		} else {\
+			if (g_bspveth_dev.ptx_queue[queue])\
+				PROC_P_STATIS_QUEUE_32(queue, name,\
+				g_bspveth_dev.ptx_queue[queue]->pshmqhd_v->name);\
+		} \
+	} while (0)
+
+#define PROC_P_STATIS_QUEUE_RXTX(queue, name, type)\
+	do {                                        \
+		if (type == BSPVETH_RX) {\
+			if (g_bspveth_dev.prx_queue[queue])\
+				PROC_P_STATIS_QUEUE(queue, name,\
+				      g_bspveth_dev.prx_queue[queue]->s.name);\
+		} else {\
+			if (g_bspveth_dev.ptx_queue[queue])\
+				PROC_P_STATIS_QUEUE(queue, name,\
+				      g_bspveth_dev.ptx_queue[queue]->s.name);\
+		} \
+	} while (0)
+
+#define PROC_P_STATIS_QUEUE_RXTXERR(queue, name, type)\
+	do {                                        \
+		if (type == BSPVETH_RX) {\
+			if (g_bspveth_dev.prx_queue[queue])\
+				PROC_P_STATIS_QUEUE_ERR(queue, name,\
+				     g_bspveth_dev.prx_queue[queue]->s.name);\
+		} else {\
+			if (g_bspveth_dev.ptx_queue[queue])\
+				PROC_P_STATIS_QUEUE_ERR(queue, name,\
+				      g_bspveth_dev.ptx_queue[queue]->s.name);\
+		} \
+	} while (0)
+
+#define PROC_P_STATIS_QUEUE_32(queue, name, statis)\
+	do {                                        \
+		len += sprintf(buf + len, "QUEUE[%d]--[%16s]:\t0x%x(%u)\r\n",\
+				queue, #name, statis, statis);\
+	} while (0)
+
+#define PROC_P_STATIS_QUEUE(queue, name, statis)\
+	do {                                        \
+		len += sprintf(buf + len, "QUEUE[%d]--[%16s]:\t0x%llx(%llu)\r\n",\
+				queue, #name, (u64)statis, (u64)statis);\
+	} while (0)
+
+#define PROC_P_STATIS_QUEUE_ERR(queue, name, statis)\
+	do {                                        \
+		len += sprintf(buf + len, "QUEUE[%d]--[%16s]:\t0x%x(%u)\r\n",\
+				queue, #name, statis, statis);\
+	} while (0)
+
+#define PROC_DPRINTK(fmt, args...)                       \
+	do {                                        \
+		len += sprintf(buf + len, fmt, ##args);   \
+	} while (0)
+
+
+
+#define JUDGE_TX_QUEUE_SPACE(head, tail, len) \
+	(((BSPVETH_MAX_QUE_DEEP + (tail) - (head) - 1) & BSPVETH_POINT_MASK) >= (len))
+
+#define JUDGE_RX_QUEUE_SPACE(head, tail, len) \
+	(((BSPVETH_MAX_QUE_DEEP + (tail) - (head)) & BSPVETH_POINT_MASK) > (len))
+
+
+
+#define DMA_MAPPING_ERROR(device, dma)	dma_mapping_error(device, dma)
+
+
+#ifndef VETH_BMC
+#define BSPVETH_UNMAP_DMA(data, len)\
+	do {\
+		dma_unmap_single(&(g_bspveth_dev.ppcidev->dev), \
+				 data, len, DMA_FROM_DEVICE);\
+	} while (0)
+#else
+#define BSPVETH_UNMAP_DMA(data, len)\
+	do {\
+		dma_unmap_single(NULL, data, len, DMA_FROM_DEVICE);\
+	} while (0)
+#endif
+
+int veth_tx(struct sk_buff *pstr_skb, struct net_device *pstr_dev);
+int veth_dma_task_H(u32 type);
+s32 veth_skbtimer_close(void);
+void veth_skbtimer_init(void);
+s32 veth_dmatimer_close_H(void);
+void veth_dmatimer_init_H(void);
+int veth_skb_tr_task(unsigned long data);
+
+s32 __dma_rxtx_H(struct bspveth_rxtx_q *prxtx_queue, u32 queue, u32 type);
+s32 veth_recv_pkt(struct bspveth_rxtx_q *prx_queue, int queue);
+s32 veth_free_txskb(struct bspveth_rxtx_q *ptx_queue, int queue);
+
+enum {
+	QUEUE_TX_STATS,
+	QUEUE_RX_STATS,
+	VETH_STATS,
+	SHMQ_TX_STATS,
+	SHMQ_RX_STATS,
+	NET_STATS,
+};
+
+struct veth_stats {
+	char stat_string[ETH_GSTRING_LEN];
+	int type;
+	int sizeof_stat;
+	int stat_offset;
+};
+
+#define NET_STAT(m)		NET_STATS, \
+	sizeof(((struct bspveth_device *)0)->m), \
+	offsetof(struct bspveth_device, m)
+
+#define VETH_STAT(m)		VETH_STATS, \
+	sizeof(((struct bspveth_device *)0)->m), \
+	offsetof(struct bspveth_device, m)
+
+#define QUEUE_TX_STAT(m)	QUEUE_TX_STATS, \
+	sizeof(((struct bspveth_rxtx_q *)0)->m), \
+	offsetof(struct bspveth_rxtx_q, m)
+#define QUEUE_RX_STAT(m)	QUEUE_RX_STATS, \
+	sizeof(((struct bspveth_rxtx_q *)0)->m), \
+	offsetof(struct bspveth_rxtx_q, m)
+
+#define SHMQ_RX_STAT(m)		SHMQ_RX_STATS, \
+	sizeof(((struct bspveth_shmq_hd *)0)->m), \
+	offsetof(struct bspveth_shmq_hd, m)
+
+#define SHMQ_TX_STAT(m)		SHMQ_TX_STATS, \
+	sizeof(((struct bspveth_shmq_hd *)0)->m), \
+	offsetof(struct bspveth_shmq_hd, m)
+
+#ifdef __cplusplus
+}
+#endif
+#endif
-- 
2.1.3

