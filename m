Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C38BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074F920857
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAlz1xGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfA3XB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:01:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35947 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3XB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:01:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so1280103wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kg7A8PfdO7vEuBe9psoY3dvyQHYWFBDEKkJvWDlrSrs=;
        b=OAlz1xGhTXMVGx3Ifycovg+nMGc7ecmA2d4jOofkXHvRqRIDH1E6qgOJS2BeYnTGiO
         idd0lYm7ja1cENnCBg02yY0u6fRff17cfWw8xPk69XeQ/06z9vjKMndfcCMT4g3SEx4T
         HnMATctPYzYcaWOCtZpy8joMWySi4Xu2gQVxA2HI4gJZBH5iLXa/Yklx0H3a6CXFvm7j
         WJPkeqmD8Mm90n2yz0m5/oN/KMI28BRjj0fpsRrrx/6G6DGzSGE8yMJKzLbpxirj+K29
         kOhVNnNcDxuJoSapgTITcdsGsGMp0A6l0OIyIvFaVQj7c8ThYcVzbXnarhKJ2MaYHA9E
         97jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kg7A8PfdO7vEuBe9psoY3dvyQHYWFBDEKkJvWDlrSrs=;
        b=IZl17bAdwWMXNjoQja0rzbh9w4Khd2RdV782vfkII7s5MPoY3BUDaTO0CKVajdToQi
         sB2rGZXVOBiS3rD48cIScX/iEMZE5RN0iVaKfbk00c1Gpzrd+qFFf415j6zSgUXX5mB9
         gDWVmfkUimYkcL1YgzYIfe3iUIQMtvYcSk6Tjc37vymwutmO6SqqYQI88S0HSgpTy+H5
         i+ZAbZdtL1GhunlU9UF7TUqvxs1wMeY+ukYXKzs51Ao6KLYrOlsrGJie8jijSD+17tAd
         U1gTHCUu3R1ADsS4/rjAJ1czjGn5g01vBtJbAcAwyFBVUTp695wo5UU4pq85Cr/seI1q
         E/+g==
X-Gm-Message-State: AJcUukdca1j6w7rU0CezKmZ89+U9tAYQGkQktSQxA7E0uZi3YH+K24/2
        3TbmzIzHTy70ihZRGxcbA/zYQGg3
X-Google-Smtp-Source: ALg8bN7alUy96HtTZoSmaHHXLVhyqRLGc8k2scmTbJ20rjUzQnknnZ/9sjw+yhlRRQrXyxHjeVUMKw==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr30397844wrs.86.1548886065776;
        Wed, 30 Jan 2019 14:07:45 -0800 (PST)
Received: from oded-ubuntu-des.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id b13sm2341349wrn.28.2019.01.30.14.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:07:45 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, rppt@linux.ibm.com
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v2 14/15] habanalabs: add debugfs support
Date:   Thu, 31 Jan 2019 00:06:16 +0200
Message-Id: <20190130220617.4862-15-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130220617.4862-1-oded.gabbay@gmail.com>
References: <20190130220617.4862-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds debugfs support to the driver. It allows the user-space to
display information that is contained in the internal structures of the
driver, such as:
- active command submissions
- active user virtual memory mappings
- number of allocated command buffers

It also enables the user to perform reads and writes through Goya's PCI
bars.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v2:
  - Replace /** with /* in all functions
  - Use generic function for testing disabled or in reset
  - Switch MMU physical pages list to array as list is not needed
  - Remove Authors: from comment at start of file
  - Remove bitfields in interface to F/W and use __le16/32/64
  - Remove bitfields in interface to QMAN and use __le16/32/64
 
 .../ABI/testing/debugfs-driver-habanalabs     |  127 ++
 drivers/misc/habanalabs/Makefile              |    2 +
 drivers/misc/habanalabs/command_buffer.c      |    4 +
 drivers/misc/habanalabs/command_submission.c  |   12 +
 drivers/misc/habanalabs/debugfs.c             | 1071 +++++++++++++++++
 drivers/misc/habanalabs/device.c              |    6 +
 drivers/misc/habanalabs/goya/goya.c           |  108 ++
 drivers/misc/habanalabs/goya/goyaP.h          |    5 +
 drivers/misc/habanalabs/habanalabs.h          |  190 +++
 drivers/misc/habanalabs/habanalabs_drv.c      |   16 +-
 drivers/misc/habanalabs/memory.c              |    8 +
 11 files changed, 1547 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-habanalabs
 create mode 100644 drivers/misc/habanalabs/debugfs.c

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
new file mode 100644
index 000000000000..2b606c84938c
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -0,0 +1,127 @@
+What:           /sys/kernel/debug/habanalabs/hl<n>/addr
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Sets the device address to be used for read or write through
+                PCI bar. The acceptable value is a string that starts with "0x"
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/command_buffers
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays a list with information about the currently allocated
+                command buffers
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/command_submission
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays a list with information about the currently active
+                command submissions
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/command_submission_jobs
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays a list with detailed information about each JOB (CB) of
+                each active command submission
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/data32
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Allows the root user to read or write directly through the
+                device's PCI bar. Writing to this file generates a write
+                transaction while reading from the file generates a read
+                transcation. This custom interface is needed (instead of using
+                the generic Linux user-space PCI mapping) because the DDR bar
+                is very small compared to the DDR memory and only the driver can
+                move the bar before and after the transaction
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/device
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Enables the root user to set the device to specific state.
+                Valid values are "disable", "enable", "suspend", "resume".
+                User can read this property to see the valid values
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/i2c_addr
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Sets I2C device address for I2C transaction that is generated
+                by the device's CPU
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/i2c_bus
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Sets I2C bus address for I2C transaction that is generated by
+                the device's CPU
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/i2c_data
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Triggers an I2C transaction that is generated by the device's
+                CPU. Writing to this file generates a write transaction while
+                reading from the file generates a read transcation
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/i2c_reg
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Sets I2C register id for I2C transaction that is generated by
+                the device's CPU
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/led0
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Sets the state of the first S/W led on the device
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/led1
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Sets the state of the second S/W led on the device
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/led2
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Sets the state of the third S/W led on the device
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/mmu
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays the hop values and physical address for a given ASID
+                and virtual address. The user should write the ASID and VA into
+                the file and then read the file to get the result.
+                e.g. to display info about VA 0x1000 for ASID 1 you need to do:
+                echo "1 0x1000" > /sys/kernel/debug/habanalabs/hl0/mmu
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/set_power_state
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Sets the PCI power state. Valid values are "1" for D0 and "2"
+                for D3Hot
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/userptr
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays a list with information about the currently user
+                pointers (user virtual addresses) that are pinned and mapped
+                to DMA addresses
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/vm
+Date:           Jan 2019
+KernelVersion:  5.1
+Contact:        oded.gabbay@gmail.com
+Description:    Displays a list with information about all the active virtual
+                address mappings per ASID
+
diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
index 2698bb6a2355..625046487aa0 100644
--- a/drivers/misc/habanalabs/Makefile
+++ b/drivers/misc/habanalabs/Makefile
@@ -8,6 +8,8 @@ habanalabs-y := habanalabs_drv.o device.o context.o asid.o habanalabs_ioctl.o \
 		command_buffer.o hw_queue.o irq.o sysfs.o hwmon.o memory.o \
 		command_submission.o mmu.o
 
+habanalabs-$(CONFIG_DEBUG_FS) += debugfs.o
+
 include $(src)/goya/Makefile
 habanalabs-y += $(HL_GOYA_FILES)
 
diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/command_buffer.c
index be5069dff2ad..bc3923a73ad6 100644
--- a/drivers/misc/habanalabs/command_buffer.c
+++ b/drivers/misc/habanalabs/command_buffer.c
@@ -36,6 +36,8 @@ static void cb_release(struct kref *ref)
 	cb = container_of(ref, struct hl_cb, refcount);
 	hdev = cb->hdev;
 
+	hl_debugfs_remove_cb(cb);
+
 	cb_do_release(hdev, cb);
 }
 
@@ -153,6 +155,8 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 	*handle = cb->id | HL_MMAP_CB_MASK;
 	*handle <<= PAGE_SHIFT;
 
+	hl_debugfs_add_cb(cb);
+
 	return 0;
 
 release_cb:
diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 95120a665916..8cbe8e069b4e 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -153,6 +153,8 @@ static void free_job(struct hl_device *hdev, struct hl_cs_job *job)
 	list_del(&job->cs_node);
 	spin_unlock(&cs->job_lock);
 
+	hl_debugfs_remove_job(hdev, job);
+
 	if (job->ext_queue)
 		cs_put(cs);
 
@@ -216,6 +218,12 @@ static void cs_do_release(struct kref *ref)
 		}
 	}
 
+	/*
+	 * Must be called before hl_ctx_put because inside we use ctx to get
+	 * the device
+	 */
+	hl_debugfs_remove_cs(cs);
+
 	hl_ctx_put(cs->ctx);
 
 	if (cs->timedout)
@@ -484,6 +492,8 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __user *chunks,
 
 	*cs_seq = cs->sequence;
 
+	hl_debugfs_add_cs(cs);
+
 	/* Validate ALL the CS chunks before submitting the CS */
 	for (i = 0, parse_cnt = 0 ; i < num_chunks ; i++, parse_cnt++) {
 		struct hl_cs_chunk *chunk = &cs_chunk_array[i];
@@ -532,6 +542,8 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __user *chunks,
 		if (job->ext_queue)
 			cs_get(cs);
 
+		hl_debugfs_add_job(hdev, job);
+
 		rc = cs_parser(hpriv, job);
 		if (rc) {
 			dev_err(hdev->dev,
diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
new file mode 100644
index 000000000000..ae4c1514f444
--- /dev/null
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -0,0 +1,1071 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "habanalabs.h"
+#include "include/hw_ip/mmu/mmu_general.h"
+
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+
+#define MMU_ADDR_BUF_SIZE	40
+#define MMU_ASID_BUF_SIZE	10
+#define MMU_KBUF_SIZE		(MMU_ADDR_BUF_SIZE + MMU_ASID_BUF_SIZE)
+
+static struct dentry *hl_debug_root;
+
+static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
+				u8 i2c_reg, u32 *val)
+{
+	struct armcp_packet pkt;
+	int rc;
+
+	if (hl_device_disabled_or_in_reset(hdev))
+		return 0;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_I2C_RD << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.i2c_bus = i2c_bus;
+	pkt.i2c_addr = i2c_addr;
+	pkt.i2c_reg = i2c_reg;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					HL_DEVICE_TIMEOUT_USEC, (long *) val);
+
+	if (rc)
+		dev_err(hdev->dev, "Failed to read from I2C, error %d\n", rc);
+
+	return rc;
+}
+
+static int hl_debugfs_i2c_write(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
+				u8 i2c_reg, u32 val)
+{
+	struct armcp_packet pkt;
+	int rc;
+
+	if (hl_device_disabled_or_in_reset(hdev))
+		return 0;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_I2C_WR << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.i2c_bus = i2c_bus;
+	pkt.i2c_addr = i2c_addr;
+	pkt.i2c_reg = i2c_reg;
+	pkt.value = val;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					HL_DEVICE_TIMEOUT_USEC, NULL);
+
+	if (rc)
+		dev_err(hdev->dev, "Failed to write to I2C, error %d\n", rc);
+
+	return rc;
+}
+
+static void hl_debugfs_led_set(struct hl_device *hdev, u8 led, u8 state)
+{
+	struct armcp_packet pkt;
+	int rc;
+
+	if (hl_device_disabled_or_in_reset(hdev))
+		return;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_LED_SET << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.led_index = led;
+	pkt.value = state;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+						HL_DEVICE_TIMEOUT_USEC, NULL);
+
+	if (rc)
+		dev_err(hdev->dev, "Failed to set LED %d, error %d\n", led, rc);
+}
+
+static int command_buffers_show(struct seq_file *s, void *data)
+{
+	struct hl_debugfs_entry *entry = s->private;
+	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
+	struct hl_cb *cb;
+	bool first = true;
+
+	spin_lock(&dev_entry->cb_spinlock);
+
+	list_for_each_entry(cb, &dev_entry->cb_list, debugfs_list) {
+		if (first) {
+			first = false;
+			seq_puts(s, "\n");
+			seq_puts(s, " CB ID   CTX ID   CB size    CB RefCnt    mmap?   CS counter\n");
+			seq_puts(s, "---------------------------------------------------------------\n");
+		}
+		seq_printf(s,
+			"   %03d        %d    0x%08x      %d          %d          %d\n",
+			cb->id, cb->ctx_id, cb->size,
+			kref_read(&cb->refcount),
+			cb->mmap, cb->cs_cnt);
+	}
+
+	spin_unlock(&dev_entry->cb_spinlock);
+
+	if (!first)
+		seq_puts(s, "\n");
+
+	return 0;
+}
+
+static int command_submission_show(struct seq_file *s, void *data)
+{
+	struct hl_debugfs_entry *entry = s->private;
+	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
+	struct hl_cs *cs;
+	bool first = true;
+
+	spin_lock(&dev_entry->cs_spinlock);
+
+	list_for_each_entry(cs, &dev_entry->cs_list, debugfs_list) {
+		if (first) {
+			first = false;
+			seq_puts(s, "\n");
+			seq_puts(s, " CS ID   CTX ASID   CS RefCnt   Submitted    Completed\n");
+			seq_puts(s, "------------------------------------------------------\n");
+		}
+		seq_printf(s,
+			"   %llu       %d          %d           %d            %d\n",
+			cs->sequence, cs->ctx->asid,
+			kref_read(&cs->refcount),
+			cs->submitted, cs->completed);
+	}
+
+	spin_unlock(&dev_entry->cs_spinlock);
+
+	if (!first)
+		seq_puts(s, "\n");
+
+	return 0;
+}
+
+static int command_submission_jobs_show(struct seq_file *s, void *data)
+{
+	struct hl_debugfs_entry *entry = s->private;
+	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
+	struct hl_cs_job *job;
+	bool first = true;
+
+	spin_lock(&dev_entry->cs_job_spinlock);
+
+	list_for_each_entry(job, &dev_entry->cs_job_list, debugfs_list) {
+		if (first) {
+			first = false;
+			seq_puts(s, "\n");
+			seq_puts(s, " JOB ID   CS ID    CTX ASID   H/W Queue\n");
+			seq_puts(s, "---------------------------------------\n");
+		}
+		if (job->cs)
+			seq_printf(s,
+				"    %02d       %llu         %d         %d\n",
+				job->id, job->cs->sequence, job->cs->ctx->asid,
+				job->hw_queue_id);
+		else
+			seq_printf(s,
+				"    %02d       0         %d         %d\n",
+				job->id, HL_KERNEL_ASID_ID, job->hw_queue_id);
+	}
+
+	spin_unlock(&dev_entry->cs_job_spinlock);
+
+	if (!first)
+		seq_puts(s, "\n");
+
+	return 0;
+}
+
+static int userptr_show(struct seq_file *s, void *data)
+{
+	struct hl_debugfs_entry *entry = s->private;
+	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
+	struct hl_userptr *userptr;
+	char dma_dir[4][30] = {"DMA_BIDIRECTIONAL", "DMA_TO_DEVICE",
+				"DMA_FROM_DEVICE", "DMA_NONE"};
+	bool first = true;
+
+	spin_lock(&dev_entry->userptr_spinlock);
+
+	list_for_each_entry(userptr, &dev_entry->userptr_list, debugfs_list) {
+		if (first) {
+			first = false;
+			seq_puts(s, "\n");
+			seq_puts(s, " user virtual address     size             dma dir\n");
+			seq_puts(s, "----------------------------------------------------------\n");
+		}
+		seq_printf(s,
+			"    0x%-14llx      %-10u    %-30s\n",
+			userptr->addr, userptr->size, dma_dir[userptr->dir]);
+	}
+
+	spin_unlock(&dev_entry->userptr_spinlock);
+
+	if (!first)
+		seq_puts(s, "\n");
+
+	return 0;
+}
+
+static int vm_show(struct seq_file *s, void *data)
+{
+	struct hl_debugfs_entry *entry = s->private;
+	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
+	struct hl_ctx *ctx;
+	struct hl_vm *vm;
+	struct hl_vm_hash_node *hnode;
+	struct hl_userptr *userptr;
+	struct hl_vm_phys_pg_pack *phys_pg_pack = NULL;
+	struct hl_vm_phys_pg *phys_pg;
+	enum vm_type_t *vm_type;
+	bool once = true;
+	int i;
+
+	if (!dev_entry->hdev->mmu_enable)
+		return 0;
+
+	spin_lock(&dev_entry->ctx_mem_hash_spinlock);
+
+	list_for_each_entry(ctx, &dev_entry->ctx_mem_hash_list, debugfs_list) {
+		once = false;
+		seq_puts(s, "\n\n----------------------------------------------------");
+		seq_puts(s, "\n----------------------------------------------------\n\n");
+		seq_printf(s, "ctx asid: %u\n", ctx->asid);
+
+		seq_puts(s, "\nmappings:\n\n");
+		seq_puts(s, "    virtual address        size          handle\n");
+		seq_puts(s, "----------------------------------------------------\n");
+		mutex_lock(&ctx->mem_hash_lock);
+		hash_for_each(ctx->mem_hash, i, hnode, node) {
+			vm_type = hnode->ptr;
+
+			if (*vm_type == VM_TYPE_USERPTR) {
+				userptr = hnode->ptr;
+				seq_printf(s,
+					"    0x%-14llx      %-10u\n",
+					hnode->vaddr, userptr->size);
+			} else {
+				phys_pg_pack = hnode->ptr;
+				seq_printf(s,
+					"    0x%-14llx      %-10u       %-4u\n",
+					hnode->vaddr, phys_pg_pack->total_size,
+					phys_pg_pack->handle);
+			}
+		}
+		mutex_unlock(&ctx->mem_hash_lock);
+
+		vm = &ctx->hdev->vm;
+		spin_lock(&vm->idr_lock);
+
+		if (!idr_is_empty(&vm->phys_pg_pack_handles))
+			seq_puts(s, "\n\nallocations:\n");
+
+		idr_for_each_entry(&vm->phys_pg_pack_handles, phys_pg_pack, i) {
+			if (phys_pg_pack->asid != ctx->asid)
+				continue;
+
+			seq_printf(s, "\nhandle: %u\n", phys_pg_pack->handle);
+			seq_puts(s, "   physical address        size\n");
+			seq_puts(s, "-------------------------------------\n");
+			for (i = 0 ; i < phys_pg_pack->npages ; i++) {
+				phys_pg = &phys_pg_pack->arr[i];
+				seq_printf(s, "    0x%-14llx      %-10u\n",
+					phys_pg->paddr, phys_pg->page_size);
+			}
+		}
+		spin_unlock(&vm->idr_lock);
+
+	}
+
+	spin_unlock(&dev_entry->ctx_mem_hash_spinlock);
+
+	if (!once)
+		seq_puts(s, "\n");
+
+	return 0;
+}
+
+/* these inline functions are copied from mmu.c */
+static inline u64 get_hop0_addr(struct hl_ctx *ctx)
+{
+	return ctx->hdev->asic_prop.mmu_pgt_addr +
+			(ctx->asid * ctx->hdev->asic_prop.mmu_hop_table_size);
+}
+
+static inline u64 get_hop0_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
+		u64 virt_addr)
+{
+	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
+			((virt_addr & HOP0_MASK) >> HOP0_SHIFT);
+}
+
+static inline u64 get_hop1_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
+		u64 virt_addr)
+{
+	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
+			((virt_addr & HOP1_MASK) >> HOP1_SHIFT);
+}
+
+static inline u64 get_hop2_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
+		u64 virt_addr)
+{
+	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
+			((virt_addr & HOP2_MASK) >> HOP2_SHIFT);
+}
+
+static inline u64 get_hop3_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
+		u64 virt_addr)
+{
+	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
+			((virt_addr & HOP3_MASK) >> HOP3_SHIFT);
+}
+
+static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
+		u64 virt_addr)
+{
+	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
+			((virt_addr & HOP4_MASK) >> HOP4_SHIFT);
+}
+
+static inline u64 get_next_hop_addr(u64 curr_pte)
+{
+	if (curr_pte & PAGE_PRESENT_MASK)
+		return curr_pte & PHYS_ADDR_MASK;
+	else
+		return ULLONG_MAX;
+}
+
+static int mmu_show(struct seq_file *s, void *data)
+{
+	struct hl_debugfs_entry *entry = s->private;
+	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
+	struct hl_device *hdev = dev_entry->hdev;
+	struct hl_ctx *ctx = hdev->user_ctx;
+
+	u64 hop0_addr = 0, hop0_pte_addr = 0, hop0_pte = 0,
+		hop1_addr = 0, hop1_pte_addr = 0, hop1_pte = 0,
+		hop2_addr = 0, hop2_pte_addr = 0, hop2_pte = 0,
+		hop3_addr = 0, hop3_pte_addr = 0, hop3_pte = 0,
+		hop4_addr = 0, hop4_pte_addr = 0, hop4_pte = 0,
+		virt_addr = dev_entry->mmu_addr;
+
+	if (!hdev->mmu_enable)
+		return 0;
+
+	if (!ctx) {
+		dev_err(hdev->dev, "no ctx available\n");
+		return 0;
+	}
+
+	mutex_lock(&ctx->mmu_lock);
+
+	/* the following lookup is copied from unmap() in mmu.c */
+
+	hop0_addr = get_hop0_addr(ctx);
+	hop0_pte_addr = get_hop0_pte_addr(ctx, hop0_addr, virt_addr);
+	hop0_pte = hdev->asic_funcs->read_pte(hdev, hop0_pte_addr);
+	hop1_addr = get_next_hop_addr(hop0_pte);
+
+	if (hop1_addr == ULLONG_MAX)
+		goto not_mapped;
+
+	hop1_pte_addr = get_hop1_pte_addr(ctx, hop1_addr, virt_addr);
+	hop1_pte = hdev->asic_funcs->read_pte(hdev, hop1_pte_addr);
+	hop2_addr = get_next_hop_addr(hop1_pte);
+
+	if (hop2_addr == ULLONG_MAX)
+		goto not_mapped;
+
+	hop2_pte_addr = get_hop2_pte_addr(ctx, hop2_addr, virt_addr);
+	hop2_pte = hdev->asic_funcs->read_pte(hdev, hop2_pte_addr);
+	hop3_addr = get_next_hop_addr(hop2_pte);
+
+	if (hop3_addr == ULLONG_MAX)
+		goto not_mapped;
+
+	hop3_pte_addr = get_hop3_pte_addr(ctx, hop3_addr, virt_addr);
+	hop3_pte = hdev->asic_funcs->read_pte(hdev, hop3_pte_addr);
+
+	if (!(hop3_pte & LAST_MASK)) {
+		hop4_addr = get_next_hop_addr(hop3_pte);
+
+		if (hop4_addr == ULLONG_MAX)
+			goto not_mapped;
+
+		hop4_pte_addr = get_hop4_pte_addr(ctx, hop4_addr, virt_addr);
+		hop4_pte = hdev->asic_funcs->read_pte(hdev, hop4_pte_addr);
+		if (!(hop4_pte & PAGE_PRESENT_MASK))
+			goto not_mapped;
+	} else {
+		if (!(hop3_pte & PAGE_PRESENT_MASK))
+			goto not_mapped;
+	}
+
+	seq_printf(s, "asid: %u, virt_addr: 0x%llx\n",
+			dev_entry->mmu_asid, dev_entry->mmu_addr);
+
+	seq_printf(s, "hop0_addr: 0x%llx\n", hop0_addr);
+	seq_printf(s, "hop0_pte_addr: 0x%llx\n", hop0_pte_addr);
+	seq_printf(s, "hop0_pte: 0x%llx\n", hop0_pte);
+
+	seq_printf(s, "hop1_addr: 0x%llx\n", hop1_addr);
+	seq_printf(s, "hop1_pte_addr: 0x%llx\n", hop1_pte_addr);
+	seq_printf(s, "hop1_pte: 0x%llx\n", hop1_pte);
+
+	seq_printf(s, "hop2_addr: 0x%llx\n", hop2_addr);
+	seq_printf(s, "hop2_pte_addr: 0x%llx\n", hop2_pte_addr);
+	seq_printf(s, "hop2_pte: 0x%llx\n", hop2_pte);
+
+	seq_printf(s, "hop3_addr: 0x%llx\n", hop3_addr);
+	seq_printf(s, "hop3_pte_addr: 0x%llx\n", hop3_pte_addr);
+	seq_printf(s, "hop3_pte: 0x%llx\n", hop3_pte);
+
+	if (!(hop3_pte & LAST_MASK)) {
+		seq_printf(s, "hop4_addr: 0x%llx\n", hop4_addr);
+		seq_printf(s, "hop4_pte_addr: 0x%llx\n", hop4_pte_addr);
+		seq_printf(s, "hop4_pte: 0x%llx\n", hop4_pte);
+	}
+
+	goto out;
+
+not_mapped:
+	dev_err(hdev->dev, "virt addr 0x%llx is not mapped to phys addr\n",
+			virt_addr);
+out:
+	mutex_unlock(&ctx->mmu_lock);
+
+	return 0;
+}
+
+static ssize_t mmu_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *f_pos)
+{
+	struct seq_file *s = file->private_data;
+	struct hl_debugfs_entry *entry = s->private;
+	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
+	struct hl_device *hdev = dev_entry->hdev;
+	char kbuf[MMU_KBUF_SIZE], asid_kbuf[MMU_ASID_BUF_SIZE],
+		addr_kbuf[MMU_ADDR_BUF_SIZE];
+	char *c;
+	ssize_t rc;
+
+	if (!hdev->mmu_enable)
+		return count;
+
+	memset(kbuf, 0, sizeof(kbuf));
+	memset(asid_kbuf, 0, sizeof(asid_kbuf));
+	memset(addr_kbuf, 0, sizeof(addr_kbuf));
+
+	if (copy_from_user(kbuf, buf, count))
+		goto err;
+
+	kbuf[MMU_KBUF_SIZE - 1] = 0;
+
+	c = strchr(kbuf, ' ');
+	if (!c)
+		goto err;
+
+	memcpy(asid_kbuf, kbuf, c - kbuf);
+
+	rc = kstrtouint(asid_kbuf, 10, &dev_entry->mmu_asid);
+	if (rc)
+		goto err;
+
+	c = strstr(kbuf, " 0x");
+	if (!c)
+		goto err;
+
+	c += 3;
+	memcpy(addr_kbuf, c, (kbuf + count) - c);
+
+	rc = kstrtoull(addr_kbuf, 16, &dev_entry->mmu_addr);
+	if (rc)
+		goto err;
+
+	return count;
+
+err:
+	dev_err(hdev->dev, "usage: echo <asid> <0xaddr> > mmu\n");
+
+	return -EINVAL;
+}
+
+static ssize_t hl_data_read32(struct file *f, char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	char tmp_buf[32];
+	u32 val;
+	ssize_t rc;
+
+	if (*ppos)
+		return 0;
+
+	rc = hdev->asic_funcs->debugfs_read32(hdev, entry->addr, &val);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to read from 0x%010llx\n",
+			entry->addr);
+		return rc;
+	}
+
+	sprintf(tmp_buf, "0x%08x\n", val);
+	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
+			strlen(tmp_buf) + 1);
+
+	return rc;
+}
+
+static ssize_t hl_data_write32(struct file *f, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	u32 value;
+	ssize_t rc;
+
+	rc = kstrtouint_from_user(buf, count, 16, &value);
+	if (rc)
+		return rc;
+
+	rc = hdev->asic_funcs->debugfs_write32(hdev, entry->addr, value);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to write 0x%08x to 0x%010llx\n",
+			value, entry->addr);
+		return rc;
+	}
+
+	return count;
+}
+
+static ssize_t hl_get_power_state(struct file *f, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	char tmp_buf[200];
+	ssize_t rc;
+	int i;
+
+	if (*ppos)
+		return 0;
+
+	if (hdev->pdev->current_state == PCI_D0)
+		i = 1;
+	else if (hdev->pdev->current_state == PCI_D3hot)
+		i = 2;
+	else
+		i = 3;
+
+	sprintf(tmp_buf,
+		"current power state: %d\n1 - D0\n2 - D3hot\n3 - Unknown\n", i);
+	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
+			strlen(tmp_buf) + 1);
+
+	return rc;
+}
+
+static ssize_t hl_set_power_state(struct file *f, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	u32 value;
+	ssize_t rc;
+
+	rc = kstrtouint_from_user(buf, count, 10, &value);
+	if (rc)
+		return rc;
+
+	if (value == 1) {
+		pci_set_power_state(hdev->pdev, PCI_D0);
+		pci_restore_state(hdev->pdev);
+		rc = pci_enable_device(hdev->pdev);
+	} else if (value == 2) {
+		pci_save_state(hdev->pdev);
+		pci_disable_device(hdev->pdev);
+		pci_set_power_state(hdev->pdev, PCI_D3hot);
+	} else {
+		dev_dbg(hdev->dev, "invalid power state value %u\n", value);
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t hl_i2c_data_read(struct file *f, char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	char tmp_buf[32];
+	u32 val;
+	ssize_t rc;
+
+	if (*ppos)
+		return 0;
+
+	rc = hl_debugfs_i2c_read(hdev, entry->i2c_bus, entry->i2c_addr,
+			entry->i2c_reg, &val);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to read from I2C bus %d, addr %d, reg %d\n",
+			entry->i2c_bus, entry->i2c_addr, entry->i2c_reg);
+		return rc;
+	}
+
+	sprintf(tmp_buf, "0x%02x\n", val);
+	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
+			strlen(tmp_buf) + 1);
+
+	return rc;
+}
+
+static ssize_t hl_i2c_data_write(struct file *f, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	u32 value;
+	ssize_t rc;
+
+	rc = kstrtouint_from_user(buf, count, 16, &value);
+	if (rc)
+		return rc;
+
+	rc = hl_debugfs_i2c_write(hdev, entry->i2c_bus, entry->i2c_addr,
+			entry->i2c_reg, value);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to write 0x%02x to I2C bus %d, addr %d, reg %d\n",
+			value, entry->i2c_bus, entry->i2c_addr, entry->i2c_reg);
+		return rc;
+	}
+
+	return count;
+}
+
+static ssize_t hl_led0_write(struct file *f, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	u32 value;
+	ssize_t rc;
+
+	rc = kstrtouint_from_user(buf, count, 10, &value);
+	if (rc)
+		return rc;
+
+	value = value ? 1 : 0;
+
+	hl_debugfs_led_set(hdev, 0, value);
+
+	return count;
+}
+
+static ssize_t hl_led1_write(struct file *f, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	u32 value;
+	ssize_t rc;
+
+	rc = kstrtouint_from_user(buf, count, 10, &value);
+	if (rc)
+		return rc;
+
+	value = value ? 1 : 0;
+
+	hl_debugfs_led_set(hdev, 1, value);
+
+	return count;
+}
+
+static ssize_t hl_led2_write(struct file *f, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	u32 value;
+	ssize_t rc;
+
+	rc = kstrtouint_from_user(buf, count, 10, &value);
+	if (rc)
+		return rc;
+
+	value = value ? 1 : 0;
+
+	hl_debugfs_led_set(hdev, 2, value);
+
+	return count;
+}
+
+static ssize_t hl_device_read(struct file *f, char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	char tmp_buf[200];
+	ssize_t rc;
+
+	if (*ppos)
+		return 0;
+
+	sprintf(tmp_buf,
+		"Valid values are: disable, enable, suspend, resume\n");
+	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
+			strlen(tmp_buf) + 1);
+
+	return rc;
+}
+
+static ssize_t hl_device_write(struct file *f, const char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+
+	if (strncmp("disable", buf, strlen("disable")) == 0) {
+		hdev->disabled = true;
+	} else if (strncmp("enable", buf, strlen("enable")) == 0) {
+		hdev->disabled = false;
+	} else if (strncmp("suspend", buf, strlen("suspend")) == 0) {
+		hdev->asic_funcs->suspend(hdev);
+	} else if (strncmp("resume", buf, strlen("resume")) == 0) {
+		hdev->asic_funcs->resume(hdev);
+	} else {
+		dev_err(hdev->dev,
+			"Valid values are: disable, enable, suspend, resume\n");
+		count = -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations hl_data32b_fops = {
+	.owner = THIS_MODULE,
+	.read = hl_data_read32,
+	.write = hl_data_write32
+};
+
+static const struct file_operations hl_i2c_data_fops = {
+	.owner = THIS_MODULE,
+	.read = hl_i2c_data_read,
+	.write = hl_i2c_data_write
+};
+
+static const struct file_operations hl_power_fops = {
+	.owner = THIS_MODULE,
+	.read = hl_get_power_state,
+	.write = hl_set_power_state
+};
+
+static const struct file_operations hl_led0_fops = {
+	.owner = THIS_MODULE,
+	.write = hl_led0_write
+};
+
+static const struct file_operations hl_led1_fops = {
+	.owner = THIS_MODULE,
+	.write = hl_led1_write
+};
+
+static const struct file_operations hl_led2_fops = {
+	.owner = THIS_MODULE,
+	.write = hl_led2_write
+};
+
+static const struct file_operations hl_device_fops = {
+	.owner = THIS_MODULE,
+	.read = hl_device_read,
+	.write = hl_device_write
+};
+
+static const struct hl_info_list hl_debugfs_list[] = {
+	{"command_buffers", command_buffers_show, NULL},
+	{"command_submission", command_submission_show, NULL},
+	{"command_submission_jobs", command_submission_jobs_show, NULL},
+	{"userptr", userptr_show, NULL},
+	{"vm", vm_show, NULL},
+	{"mmu", mmu_show, mmu_write},
+};
+
+static int hl_debugfs_open(struct inode *inode, struct file *file)
+{
+	struct hl_debugfs_entry *node = inode->i_private;
+
+	return single_open(file, node->info_ent->show, node);
+}
+
+static ssize_t hl_debugfs_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *f_pos)
+{
+	struct hl_debugfs_entry *node = file->f_inode->i_private;
+
+	if (node->info_ent->write)
+		return node->info_ent->write(file, buf, count, f_pos);
+	else
+		return -EINVAL;
+
+}
+
+static const struct file_operations hl_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.open = hl_debugfs_open,
+	.read = seq_read,
+	.write = hl_debugfs_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+void hl_debugfs_add_device(struct hl_device *hdev)
+{
+	struct hl_dbg_device_entry *dev_entry = &hdev->hl_debugfs;
+	int count = ARRAY_SIZE(hl_debugfs_list);
+	struct hl_debugfs_entry *entry;
+	struct dentry *ent;
+	int i;
+
+	dev_entry->hdev = hdev;
+	dev_entry->entry_arr = kmalloc_array(count,
+					sizeof(struct hl_debugfs_entry),
+					GFP_KERNEL);
+	if (!dev_entry->entry_arr)
+		return;
+
+	INIT_LIST_HEAD(&dev_entry->file_list);
+	INIT_LIST_HEAD(&dev_entry->cb_list);
+	INIT_LIST_HEAD(&dev_entry->cs_list);
+	INIT_LIST_HEAD(&dev_entry->cs_job_list);
+	INIT_LIST_HEAD(&dev_entry->userptr_list);
+	INIT_LIST_HEAD(&dev_entry->ctx_mem_hash_list);
+	mutex_init(&dev_entry->file_mutex);
+	spin_lock_init(&dev_entry->cb_spinlock);
+	spin_lock_init(&dev_entry->cs_spinlock);
+	spin_lock_init(&dev_entry->cs_job_spinlock);
+	spin_lock_init(&dev_entry->userptr_spinlock);
+	spin_lock_init(&dev_entry->ctx_mem_hash_spinlock);
+
+	dev_entry->root = debugfs_create_dir(dev_name(hdev->dev),
+						hl_debug_root);
+
+	debugfs_create_x64("addr",
+				0644,
+				dev_entry->root,
+				&dev_entry->addr);
+
+	debugfs_create_file("data32",
+				0644,
+				dev_entry->root,
+				dev_entry,
+				&hl_data32b_fops);
+
+	debugfs_create_file("set_power_state",
+				0200,
+				dev_entry->root,
+				dev_entry,
+				&hl_power_fops);
+
+	debugfs_create_u8("i2c_bus",
+				0644,
+				dev_entry->root,
+				&dev_entry->i2c_bus);
+
+	debugfs_create_u8("i2c_addr",
+				0644,
+				dev_entry->root,
+				&dev_entry->i2c_addr);
+
+	debugfs_create_u8("i2c_reg",
+				0644,
+				dev_entry->root,
+				&dev_entry->i2c_reg);
+
+	debugfs_create_file("i2c_data",
+				0644,
+				dev_entry->root,
+				dev_entry,
+				&hl_i2c_data_fops);
+
+	debugfs_create_file("led0",
+				0200,
+				dev_entry->root,
+				dev_entry,
+				&hl_led0_fops);
+
+	debugfs_create_file("led1",
+				0200,
+				dev_entry->root,
+				dev_entry,
+				&hl_led1_fops);
+
+	debugfs_create_file("led2",
+				0200,
+				dev_entry->root,
+				dev_entry,
+				&hl_led2_fops);
+
+	debugfs_create_file("device",
+				0200,
+				dev_entry->root,
+				dev_entry,
+				&hl_device_fops);
+
+	for (i = 0, entry = dev_entry->entry_arr ; i < count ; i++, entry++) {
+
+		ent = debugfs_create_file(hl_debugfs_list[i].name,
+					0444,
+					dev_entry->root,
+					entry,
+					&hl_debugfs_fops);
+		entry->dent = ent;
+		entry->info_ent = &hl_debugfs_list[i];
+		entry->dev_entry = dev_entry;
+	}
+}
+
+void hl_debugfs_remove_device(struct hl_device *hdev)
+{
+	struct hl_dbg_device_entry *entry = &hdev->hl_debugfs;
+
+	debugfs_remove_recursive(entry->root);
+
+	mutex_destroy(&entry->file_mutex);
+	kfree(entry->entry_arr);
+}
+
+void hl_debugfs_add_file(struct hl_fpriv *hpriv)
+{
+	struct hl_dbg_device_entry *dev_entry = &hpriv->hdev->hl_debugfs;
+
+	mutex_lock(&dev_entry->file_mutex);
+	list_add(&hpriv->debugfs_list, &dev_entry->file_list);
+	mutex_unlock(&dev_entry->file_mutex);
+}
+
+void hl_debugfs_remove_file(struct hl_fpriv *hpriv)
+{
+	struct hl_dbg_device_entry *dev_entry = &hpriv->hdev->hl_debugfs;
+
+	mutex_lock(&dev_entry->file_mutex);
+	list_del(&hpriv->debugfs_list);
+	mutex_unlock(&dev_entry->file_mutex);
+}
+
+void hl_debugfs_add_cb(struct hl_cb *cb)
+{
+	struct hl_dbg_device_entry *dev_entry = &cb->hdev->hl_debugfs;
+
+	spin_lock(&dev_entry->cb_spinlock);
+	list_add(&cb->debugfs_list, &dev_entry->cb_list);
+	spin_unlock(&dev_entry->cb_spinlock);
+}
+
+void hl_debugfs_remove_cb(struct hl_cb *cb)
+{
+	struct hl_dbg_device_entry *dev_entry = &cb->hdev->hl_debugfs;
+
+	spin_lock(&dev_entry->cb_spinlock);
+	list_del(&cb->debugfs_list);
+	spin_unlock(&dev_entry->cb_spinlock);
+}
+
+void hl_debugfs_add_cs(struct hl_cs *cs)
+{
+	struct hl_dbg_device_entry *dev_entry = &cs->ctx->hdev->hl_debugfs;
+
+	spin_lock(&dev_entry->cs_spinlock);
+	list_add(&cs->debugfs_list, &dev_entry->cs_list);
+	spin_unlock(&dev_entry->cs_spinlock);
+}
+
+void hl_debugfs_remove_cs(struct hl_cs *cs)
+{
+	struct hl_dbg_device_entry *dev_entry = &cs->ctx->hdev->hl_debugfs;
+
+	spin_lock(&dev_entry->cs_spinlock);
+	list_del(&cs->debugfs_list);
+	spin_unlock(&dev_entry->cs_spinlock);
+}
+
+void hl_debugfs_add_job(struct hl_device *hdev, struct hl_cs_job *job)
+{
+	struct hl_dbg_device_entry *dev_entry = &hdev->hl_debugfs;
+
+	spin_lock(&dev_entry->cs_job_spinlock);
+	list_add(&job->debugfs_list, &dev_entry->cs_job_list);
+	spin_unlock(&dev_entry->cs_job_spinlock);
+}
+
+void hl_debugfs_remove_job(struct hl_device *hdev, struct hl_cs_job *job)
+{
+	struct hl_dbg_device_entry *dev_entry = &hdev->hl_debugfs;
+
+	spin_lock(&dev_entry->cs_job_spinlock);
+	list_del(&job->debugfs_list);
+	spin_unlock(&dev_entry->cs_job_spinlock);
+}
+
+void hl_debugfs_add_userptr(struct hl_device *hdev, struct hl_userptr *userptr)
+{
+	struct hl_dbg_device_entry *dev_entry = &hdev->hl_debugfs;
+
+	spin_lock(&dev_entry->userptr_spinlock);
+	list_add(&userptr->debugfs_list, &dev_entry->userptr_list);
+	spin_unlock(&dev_entry->userptr_spinlock);
+}
+
+void hl_debugfs_remove_userptr(struct hl_device *hdev,
+				struct hl_userptr *userptr)
+{
+	struct hl_dbg_device_entry *dev_entry = &hdev->hl_debugfs;
+
+	spin_lock(&dev_entry->userptr_spinlock);
+	list_del(&userptr->debugfs_list);
+	spin_unlock(&dev_entry->userptr_spinlock);
+}
+
+void hl_debugfs_add_ctx_mem_hash(struct hl_device *hdev, struct hl_ctx *ctx)
+{
+	struct hl_dbg_device_entry *dev_entry = &hdev->hl_debugfs;
+
+	spin_lock(&dev_entry->ctx_mem_hash_spinlock);
+	list_add(&ctx->debugfs_list, &dev_entry->ctx_mem_hash_list);
+	spin_unlock(&dev_entry->ctx_mem_hash_spinlock);
+}
+
+void hl_debugfs_remove_ctx_mem_hash(struct hl_device *hdev, struct hl_ctx *ctx)
+{
+	struct hl_dbg_device_entry *dev_entry = &hdev->hl_debugfs;
+
+	spin_lock(&dev_entry->ctx_mem_hash_spinlock);
+	list_del(&ctx->debugfs_list);
+	spin_unlock(&dev_entry->ctx_mem_hash_spinlock);
+}
+
+int __init hl_debugfs_init(void)
+{
+	hl_debug_root = debugfs_create_dir("habanalabs", NULL);
+	if (IS_ERR_OR_NULL(hl_debug_root)) {
+		pr_err("can not create debugfs directory\n");
+		hl_debug_root = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void hl_debugfs_fini(void)
+{
+	debugfs_remove_recursive(hl_debug_root);
+}
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 1b1ad490b5b4..6317f68fa3da 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -30,6 +30,8 @@ static void hpriv_release(struct kref *ref)
 
 	put_pid(hpriv->taskpid);
 
+	hl_debugfs_remove_file(hpriv);
+
 	mutex_destroy(&hpriv->restore_phase_mutex);
 
 	kfree(hpriv);
@@ -820,6 +822,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto free_cb_pool;
 	}
 
+	hl_debugfs_add_device(hdev);
+
 	rc = hdev->asic_funcs->hw_init(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize the H/W\n");
@@ -949,6 +953,8 @@ void hl_device_fini(struct hl_device *hdev)
 
 	device_late_fini(hdev);
 
+	hl_debugfs_remove_device(hdev);
+
 	hl_sysfs_fini(hdev);
 
 	/*
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index b067fc5e176b..911fa8991294 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4352,6 +4352,8 @@ int goya_context_switch(struct hl_device *hdev, u32 asid)
 	job->user_cb_size = cb_size;
 	job->hw_queue_id = GOYA_QUEUE_ID_DMA_0;
 
+	hl_debugfs_add_job(hdev, job);
+
 	parser.ctx_id = HL_KERNEL_ASID_ID;
 	parser.cs_sequence = 0;
 	parser.job_id = job->id;
@@ -4384,6 +4386,7 @@ int goya_context_switch(struct hl_device *hdev, u32 asid)
 
 free_job:
 	hl_userptr_delete_list(hdev, &job->userptr_list);
+	hl_debugfs_remove_job(hdev, job);
 	kfree(job);
 	cb->cs_cnt--;
 
@@ -4414,6 +4417,106 @@ void goya_restore_phase_topology(struct hl_device *hdev)
 	i = RREG32(mmSYNC_MNGR_SOB_OBJ_0);
 }
 
+/*
+ * goya_debugfs_read32 - read a 32bit value from a given device address
+ *
+ * @hdev:	pointer to hl_device structure
+ * @addr:	address in device
+ * @val:	returned value
+ *
+ * In case of DDR address that is not mapped into the default aperture that
+ * the DDR bar exposes, the function will configure the iATU so that the DDR
+ * bar will be positioned at a base address that allows reading from the
+ * required address. Configuring the iATU during normal operation can
+ * lead to undefined behavior and therefore, should be done with extreme care
+ *
+ */
+int goya_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	int rc = 0;
+
+	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
+		*val = RREG32(addr - CFG_BASE);
+
+	} else if ((addr >= SRAM_BASE_ADDR) &&
+			(addr < SRAM_BASE_ADDR + SRAM_SIZE)) {
+
+		*val = readl(hdev->pcie_bar[SRAM_CFG_BAR_ID] +
+				(addr - SRAM_BASE_ADDR));
+
+	} else if ((addr >= DRAM_PHYS_BASE) &&
+			(addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_size)) {
+
+		u64 bar_base_addr = DRAM_PHYS_BASE +
+				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
+
+		rc = goya_set_ddr_bar_base(hdev, bar_base_addr);
+		if (!rc) {
+			*val = readl(hdev->pcie_bar[DDR_BAR_ID] +
+						(addr - bar_base_addr));
+
+			rc = goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE +
+				(MMU_PAGE_TABLES_ADDR &
+					~(prop->dram_pci_bar_size - 0x1ull)));
+		}
+	} else {
+		rc = -EFAULT;
+	}
+
+	return rc;
+}
+
+/*
+ * goya_debugfs_write32 - write a 32bit value to a given device address
+ *
+ * @hdev:	pointer to hl_device structure
+ * @addr:	address in device
+ * @val:	returned value
+ *
+ * In case of DDR address that is not mapped into the default aperture that
+ * the DDR bar exposes, the function will configure the iATU so that the DDR
+ * bar will be positioned at a base address that allows writing to the
+ * required address. Configuring the iATU during normal operation can
+ * lead to undefined behavior and therefore, should be done with extreme care
+ *
+ */
+int goya_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	int rc = 0;
+
+	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
+		WREG32(addr - CFG_BASE, val);
+
+	} else if ((addr >= SRAM_BASE_ADDR) &&
+			(addr < SRAM_BASE_ADDR + SRAM_SIZE)) {
+
+		writel(val, hdev->pcie_bar[SRAM_CFG_BAR_ID] +
+					(addr - SRAM_BASE_ADDR));
+
+	} else if ((addr >= DRAM_PHYS_BASE) &&
+			(addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_size)) {
+
+		u64 bar_base_addr = DRAM_PHYS_BASE +
+				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
+
+		rc = goya_set_ddr_bar_base(hdev, bar_base_addr);
+		if (!rc) {
+			writel(val, hdev->pcie_bar[DDR_BAR_ID] +
+						(addr - bar_base_addr));
+
+			rc = goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE +
+				(MMU_PAGE_TABLES_ADDR &
+					~(prop->dram_pci_bar_size - 0x1ull)));
+		}
+	} else {
+		rc = -EFAULT;
+	}
+
+	return rc;
+}
+
 static u64 goya_read_pte(struct hl_device *hdev, u64 addr)
 {
 	struct goya_device *goya = hdev->asic_specific;
@@ -4760,6 +4863,8 @@ static int goya_mmu_clear_pgt_range(struct hl_device *hdev)
 	job->user_cb_size = cb_size;
 	job->hw_queue_id = GOYA_QUEUE_ID_DMA_0;
 
+	hl_debugfs_add_job(hdev, job);
+
 	parser.ctx_id = HL_KERNEL_ASID_ID;
 	parser.cs_sequence = 0;
 	parser.job_id = job->id;
@@ -4788,6 +4893,7 @@ static int goya_mmu_clear_pgt_range(struct hl_device *hdev)
 
 free_job:
 	hl_userptr_delete_list(hdev, &job->userptr_list);
+	hl_debugfs_remove_job(hdev, job);
 	kfree(job);
 	cb->cs_cnt--;
 
@@ -5197,6 +5303,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.update_eq_ci = goya_update_eq_ci,
 	.context_switch = goya_context_switch,
 	.restore_phase_topology = goya_restore_phase_topology,
+	.debugfs_read32 = goya_debugfs_read32,
+	.debugfs_write32 = goya_debugfs_write32,
 	.add_device_attr = goya_add_device_attr,
 	.remove_device_attr = goya_remove_device_attr,
 	.handle_eqe = goya_handle_eqe,
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 571748e203a7..b71efd1dc449 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -168,6 +168,10 @@ struct goya_device {
 	u32		hw_cap_initialized;
 };
 
+int goya_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus,
+			u8 i2c_addr, u8 i2c_reg, u32 *val);
+int goya_debugfs_i2c_write(struct hl_device *hdev, u8 i2c_bus,
+			u8 i2c_addr, u8 i2c_reg, u32 val);
 int goya_test_cpu_queue(struct hl_device *hdev);
 int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
 				u32 timeout, long *result);
@@ -178,6 +182,7 @@ long goya_get_fan_speed(struct hl_device *hdev, int sensor_index, u32 attr);
 long goya_get_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr);
 void goya_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
 			long value);
+void goya_debugfs_led_set(struct hl_device *hdev, u8 led, u8 state);
 void goya_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
 int goya_add_device_attr(struct hl_device *hdev);
 void goya_remove_device_attr(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 097fc9c00939..46590685a84f 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -225,6 +225,7 @@ struct hl_cb_mgr {
  * @refcount: reference counter for usage of the CB.
  * @hdev: pointer to device this CB belongs to.
  * @lock: spinlock to protect mmap/cs flows.
+ * @debugfs_list: node in debugfs list of command buffers.
  * @pool_list: node in pool list of command buffers.
  * @kernel_address: Holds the CB's kernel virtual address.
  * @bus_address: Holds the CB's DMA address.
@@ -241,6 +242,7 @@ struct hl_cb {
 	struct kref		refcount;
 	struct hl_device	*hdev;
 	spinlock_t		lock;
+	struct list_head	debugfs_list;
 	struct list_head	pool_list;
 	u64			kernel_address;
 	dma_addr_t		bus_address;
@@ -442,6 +444,8 @@ enum hl_pll_frequency {
  * @update_eq_ci: update event queue CI.
  * @context_switch: called upon ASID context switch.
  * @restore_phase_topology: clear all SOBs amd MONs.
+ * @debugfs_read32: debug interface for reading u32 from DRAM/SRAM.
+ * @debugfs_write32: debug interface for writing u32 to DRAM/SRAM.
  * @add_device_attr: add ASIC specific device attributes.
  * @remove_device_attr: remove ASIC specific device attributes.
  * @handle_eqe: handle event queue entry (IRQ) from ArmCP.
@@ -510,6 +514,8 @@ struct hl_asic_funcs {
 	void (*update_eq_ci)(struct hl_device *hdev, u32 val);
 	int (*context_switch)(struct hl_device *hdev, u32 asid);
 	void (*restore_phase_topology)(struct hl_device *hdev);
+	int (*debugfs_read32)(struct hl_device *hdev, u64 addr, u32 *val);
+	int (*debugfs_write32)(struct hl_device *hdev, u64 addr, u32 val);
 	int (*add_device_attr)(struct hl_device *hdev);
 	void (*remove_device_attr)(struct hl_device *hdev);
 	void (*handle_eqe)(struct hl_device *hdev,
@@ -572,6 +578,7 @@ struct hl_va_range {
  * @mem_hash_lock: protects the mem_hash.
  * @mmu_lock: protects the MMU page tables. Any change to the PGT, modifing the
  *            MMU hash or walking the PGT requires talking this lock
+ * @debugfs_list: node in debugfs list of contexts.
  * @cs_sequence: sequence number for CS. Value is assigned to a CS and passed
  *			to user so user could inquire about CS. It is used as
  *			index to cs_pending array.
@@ -596,6 +603,7 @@ struct hl_ctx {
 	struct hl_va_range	dram_va_range;
 	struct mutex		mem_hash_lock;
 	struct mutex		mmu_lock;
+	struct list_head	debugfs_list;
 	u64			cs_sequence;
 	spinlock_t		cs_lock;
 	atomic64_t		dram_phys_mem;
@@ -654,6 +662,7 @@ struct hl_userptr {
  * @fence: pointer to the fence object of this CS.
  * @work_tdr: delayed work node for TDR.
  * @mirror_node : node in device mirror list of command submissions.
+ * @debugfs_list: node in debugfs list of command submissions.
  * @sequence: the sequence number of this CS.
  * @submitted: true if CS was submitted to H/W.
  * @completed: true if CS was completed by device.
@@ -671,6 +680,7 @@ struct hl_cs {
 	struct dma_fence	*fence;
 	struct delayed_work	work_tdr;
 	struct list_head	mirror_node;
+	struct list_head	debugfs_list;
 	u64			sequence;
 	u8			submitted;
 	u8			completed;
@@ -689,6 +699,7 @@ struct hl_cs {
  * @finish_work: workqueue object to run when job is completed.
  * @userptr_list: linked-list of userptr mappings that belong to this job and
  *			wait for completion.
+ * @debugfs_list: node in debugfs list of command submission jobs.
  * @id: the id of this job inside a CS.
  * @hw_queue_id: the id of the H/W queue this job is submitted to.
  * @user_cb_size: the actual size of the CB we got from the user.
@@ -702,6 +713,7 @@ struct hl_cs_job {
 	struct hl_cb		*patched_cb;
 	struct work_struct	finish_work;
 	struct list_head	userptr_list;
+	struct list_head	debugfs_list;
 	u32			id;
 	u32			hw_queue_id;
 	u32			user_cb_size;
@@ -840,6 +852,7 @@ struct hl_vm {
  * @ctx: current executing context.
  * @ctx_mgr: context manager to handle multiple context for this FD.
  * @cb_mgr: command buffer manager to handle multiple buffers for this FD.
+ * @debugfs_list: list of relevant ASIC debugfs.
  * @refcount: number of related contexts.
  * @restore_phase_mutex: lock for context switch and restore phase.
  */
@@ -850,11 +863,90 @@ struct hl_fpriv {
 	struct hl_ctx		*ctx; /* TODO: remove for multiple ctx */
 	struct hl_ctx_mgr	ctx_mgr;
 	struct hl_cb_mgr	cb_mgr;
+	struct list_head	debugfs_list;
 	struct kref		refcount;
 	struct mutex		restore_phase_mutex;
 };
 
 
+/*
+ * DebugFS
+ */
+
+/**
+ * struct hl_info_list - debugfs file ops.
+ * @name: file name.
+ * @show: function to output information.
+ * @write: function to write to the file.
+ */
+struct hl_info_list {
+	const char	*name;
+	int		(*show)(struct seq_file *s, void *data);
+	ssize_t		(*write)(struct file *file, const char __user *buf,
+				size_t count, loff_t *f_pos);
+};
+
+/**
+ * struct hl_debugfs_entry - debugfs dentry wrapper.
+ * @dent: base debugfs entry structure.
+ * @info_ent: dentry realted ops.
+ * @dev_entry: ASIC specific debugfs manager.
+ */
+struct hl_debugfs_entry {
+	struct dentry			*dent;
+	const struct hl_info_list	*info_ent;
+	struct hl_dbg_device_entry	*dev_entry;
+};
+
+/**
+ * struct hl_dbg_device_entry - ASIC specific debugfs manager.
+ * @root: root dentry.
+ * @hdev: habanalabs device structure.
+ * @entry_arr: array of available hl_debugfs_entry.
+ * @file_list: list of available debugfs files.
+ * @file_mutex: protects file_list.
+ * @cb_list: list of available CBs.
+ * @cb_spinlock: protects cb_list.
+ * @cs_list: list of available CSs.
+ * @cs_spinlock: protects cs_list.
+ * @cs_job_list: list of available CB jobs.
+ * @cs_job_spinlock: protects cs_job_list.
+ * @userptr_list: list of available userptrs (virtual memory chunk descriptor).
+ * @userptr_spinlock: protects userptr_list.
+ * @ctx_mem_hash_list: list of available contexts with MMU mappings.
+ * @ctx_mem_hash_spinlock: protects cb_list.
+ * @addr: next address to read/write from/to in read/write32.
+ * @mmu_addr: next virtual address to translate to physical address in mmu_show.
+ * @mmu_asid: ASID to use while translating in mmu_show.
+ * @i2c_bus: generic u8 debugfs file for bus value to use in i2c_data_read.
+ * @i2c_bus: generic u8 debugfs file for address value to use in i2c_data_read.
+ * @i2c_bus: generic u8 debugfs file for register value to use in i2c_data_read.
+ */
+struct hl_dbg_device_entry {
+	struct dentry			*root;
+	struct hl_device		*hdev;
+	struct hl_debugfs_entry		*entry_arr;
+	struct list_head		file_list;
+	struct mutex			file_mutex;
+	struct list_head		cb_list;
+	spinlock_t			cb_spinlock;
+	struct list_head		cs_list;
+	spinlock_t			cs_spinlock;
+	struct list_head		cs_job_list;
+	spinlock_t			cs_job_spinlock;
+	struct list_head		userptr_list;
+	spinlock_t			userptr_spinlock;
+	struct list_head		ctx_mem_hash_list;
+	spinlock_t			ctx_mem_hash_spinlock;
+	u64				addr;
+	u64				mmu_addr;
+	u32				mmu_asid;
+	u8				i2c_bus;
+	u8				i2c_addr;
+	u8				i2c_reg;
+};
+
+
 /*
  * DEVICES
  */
@@ -947,6 +1039,7 @@ struct hl_device_reset_work {
  * @hwmon_dev: H/W monitor device.
  * @pm_mng_profile: current power management profile.
  * @hl_chip_info: ASIC's sensors information.
+ * @hl_debugfs: device's debugfs manager.
  * @cb_pool: list of preallocated CBs.
  * @cb_pool_lock: protects the CB pool.
  * @user_ctx: current user context executing.
@@ -1011,6 +1104,8 @@ struct hl_device {
 	enum hl_pm_mng_profile		pm_mng_profile;
 	struct hwmon_chip_info		hl_chip_info;
 
+	struct hl_dbg_device_entry	hl_debugfs;
+
 	struct list_head		cb_pool;
 	spinlock_t			cb_pool_lock;
 
@@ -1248,6 +1343,101 @@ void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
 u64 hl_get_max_power(struct hl_device *hdev);
 void hl_set_max_power(struct hl_device *hdev, u64 value);
 
+#ifdef CONFIG_DEBUG_FS
+
+int hl_debugfs_init(void);
+void hl_debugfs_fini(void);
+void hl_debugfs_add_device(struct hl_device *hdev);
+void hl_debugfs_remove_device(struct hl_device *hdev);
+void hl_debugfs_add_file(struct hl_fpriv *hpriv);
+void hl_debugfs_remove_file(struct hl_fpriv *hpriv);
+void hl_debugfs_add_cb(struct hl_cb *cb);
+void hl_debugfs_remove_cb(struct hl_cb *cb);
+void hl_debugfs_add_cs(struct hl_cs *cs);
+void hl_debugfs_remove_cs(struct hl_cs *cs);
+void hl_debugfs_add_job(struct hl_device *hdev, struct hl_cs_job *job);
+void hl_debugfs_remove_job(struct hl_device *hdev, struct hl_cs_job *job);
+void hl_debugfs_add_userptr(struct hl_device *hdev, struct hl_userptr *userptr);
+void hl_debugfs_remove_userptr(struct hl_device *hdev,
+				struct hl_userptr *userptr);
+void hl_debugfs_add_ctx_mem_hash(struct hl_device *hdev, struct hl_ctx *ctx);
+void hl_debugfs_remove_ctx_mem_hash(struct hl_device *hdev, struct hl_ctx *ctx);
+
+#else
+
+static inline int __init hl_debugfs_init(void)
+{
+	return 0;
+}
+
+static inline void hl_debugfs_fini(void)
+{
+}
+
+static inline void hl_debugfs_add_device(struct hl_device *hdev)
+{
+}
+
+static inline void hl_debugfs_remove_device(struct hl_device *hdev)
+{
+}
+
+static inline void hl_debugfs_add_file(struct hl_fpriv *hpriv)
+{
+}
+
+static inline void hl_debugfs_remove_file(struct hl_fpriv *hpriv)
+{
+}
+
+static inline void hl_debugfs_add_cb(struct hl_cb *cb)
+{
+}
+
+static inline void hl_debugfs_remove_cb(struct hl_cb *cb)
+{
+}
+
+static inline void hl_debugfs_add_cs(struct hl_cs *cs)
+{
+}
+
+static inline void hl_debugfs_remove_cs(struct hl_cs *cs)
+{
+}
+
+static inline void hl_debugfs_add_job(struct hl_device *hdev,
+					struct hl_cs_job *job)
+{
+}
+
+static inline void hl_debugfs_remove_job(struct hl_device *hdev,
+					struct hl_cs_job *job)
+{
+}
+
+static inline void hl_debugfs_add_userptr(struct hl_device *hdev,
+					struct hl_userptr *userptr)
+{
+}
+
+static inline void hl_debugfs_remove_userptr(struct hl_device *hdev,
+					struct hl_userptr *userptr)
+{
+}
+
+static inline void hl_debugfs_add_ctx_mem_hash(struct hl_device *hdev,
+					struct hl_ctx *ctx)
+{
+}
+
+static inline void hl_debugfs_remove_ctx_mem_hash(struct hl_device *hdev,
+					struct hl_ctx *ctx)
+{
+}
+
+#endif
+
 /* IOCTLs */
 long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
 int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data);
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 27b4fb74f6c1..e2596df6ad4a 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -150,6 +150,8 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	 */
 	hl_device_set_frequency(hdev, PLL_HIGH);
 
+	hl_debugfs_add_file(hpriv);
+
 	return 0;
 
 out_err:
@@ -421,17 +423,20 @@ static int __init hl_init(void)
 		goto remove_major;
 	}
 
+	hl_debugfs_init();
+
 	rc = pci_register_driver(&hl_pci_driver);
 	if (rc) {
 		pr_err("failed to register pci device\n");
-		goto remove_class;
+		goto remove_debugfs;
 	}
 
 	pr_debug("driver loaded\n");
 
 	return 0;
 
-remove_class:
+remove_debugfs:
+	hl_debugfs_fini();
 	class_destroy(hl_class);
 remove_major:
 	unregister_chrdev_region(MKDEV(hl_major, 0), HL_MAX_MINORS);
@@ -445,6 +450,13 @@ static void __exit hl_exit(void)
 {
 	pci_unregister_driver(&hl_pci_driver);
 
+	/*
+	 * Removing debugfs must be after all devices or simulator devices
+	 * have been removed because otherwise we get a bug in the
+	 * debugfs module for referencing NULL objects
+	 */
+	hl_debugfs_fini();
+
 	class_destroy(hl_class);
 	unregister_chrdev_region(MKDEV(hl_major, 0), HL_MAX_MINORS);
 
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 16d46060aded..9a1fcbbe131c 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1283,6 +1283,8 @@ int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u32 size,
 		goto free_sgt;
 	}
 
+	hl_debugfs_add_userptr(hdev, userptr);
+
 	return 0;
 
 free_sgt:
@@ -1308,6 +1310,8 @@ int hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userptr)
 {
 	struct page **pages;
 
+	hl_debugfs_remove_userptr(hdev, userptr);
+
 	if (userptr->dma_mapped)
 		hdev->asic_funcs->hl_dma_unmap_sg(hdev,
 				userptr->sgt->sgl,
@@ -1469,6 +1473,8 @@ int hl_vm_ctx_init_with_ranges(struct hl_ctx *ctx, u64 host_range_start,
 		goto dram_vm_err;
 	}
 
+	hl_debugfs_add_ctx_mem_hash(hdev, ctx);
+
 	return 0;
 
 dram_vm_err:
@@ -1589,6 +1595,8 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	struct hlist_node *tmp_node;
 	int i;
 
+	hl_debugfs_remove_ctx_mem_hash(hdev, ctx);
+
 	if (!hash_empty(ctx->mem_hash))
 		dev_notice(hdev->dev, "ctx is freed while it has va in use\n");
 
-- 
2.17.1

