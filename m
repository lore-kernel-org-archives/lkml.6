Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3CCC43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA48217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJppk29z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbfACQPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:15:53 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41673 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfACQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:15:51 -0500
Received: by mail-io1-f67.google.com with SMTP id s22so27391726ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 08:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDHUMJDkxxqYpFrh4knLl46JJ5pD4XsqO2HM7K6BS/0=;
        b=eJppk29zHbl2rGbW4/FQDPcoFoAFhsnScmqt+oMIOfUrHyYqVoQxYVsY/wrlgLiB2i
         uaazg7nABZFtQGQrIgb+31t1CS6rsYKFc5BVJvzDuDhvU7mx7tmgWiWKBHAptOV+o9ip
         8WmJJxuvqcRS5/Gut5Bitfd21MBTa7K5iwIf5rctW60RtTKXgVIwcDDQny7L08MXug+y
         nicgVARkmpzdFzSC9uEguAjLif9H1sEzMG3aBgQASlyrT02QtpBYpvTmYNEDb+wIRw9Q
         tu1y3XkBZVo+mAIqNjUJT2MjY0AqYKcifUGFPcqVv1sbjITJeEzFO/srEoHpPhCRxFgL
         AOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDHUMJDkxxqYpFrh4knLl46JJ5pD4XsqO2HM7K6BS/0=;
        b=VXQt2irK5EkqT3ChUedIaAfepy+lWrEEkP9EB4iGrCdn6MITxwRj7dN1GLxL7pyvTR
         /IgNZGxutVqM+Ydl3Q188oppvSMp8mVv9zC4VSs4qQEIsgLBj44+wvIhXCGZa48R/muc
         FpA9v2P/BQciQi4quFr6CQog5fpb+KpFsPq2zNaWRGZ6d1X5E3N+OGBY68XcQPfK6coR
         2OZFEeE0jVypnYgQpA71u6qomt7AB9r/WaqmhjTHznG2MfqK7/zwiOR3yLUia4WsMUUu
         unvvY/MhVOFjuuGhksIr439tfz34/3N2CNvm3HHkEiJo773EHAvXJUfyb7ZLzaAQtTW5
         HxQA==
X-Gm-Message-State: AJcUukchhbo7+r5HU8D3MbPKX/dWWHtW4J+jkDAdQA4sXtwvwUHmpx8B
        DBsbOz+OZbaiqOTEeBtT1lBfa+GO6Ic=
X-Google-Smtp-Source: ALg8bN6GnjRDCYN1yN8iwffsegAO6TqnQeK8N5XvmikNhMbXi9XuHbXoakyqqS9KKqKQ9VVhj0iszQ==
X-Received: by 2002:a5e:c00c:: with SMTP id u12mr35947618iol.152.1546532149547;
        Thu, 03 Jan 2019 08:15:49 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id d11sm6018423ioq.31.2019.01.03.08.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 08:15:48 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH fieldbus v6 2/6] anybus-s: support HMS Anybus-S bus
Date:   Thu,  3 Jan 2019 11:15:34 -0500
Message-Id: <20190103161538.20637-3-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190103161538.20637-1-TheSven73@googlemail.com>
References: <20190103161538.20637-1-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Anybus-S/Anybus-M is a series of interchangeable fieldbus communication
modules featuring on board memory and processing power. All software and
hardware functionality required to communicate on the fieldbus is
incorporated in the module itself, allowing the application to focus on
other tasks.

Typical applications are frequency inverters, HMI and visualization
devices, instruments, scales, robotics, PLC’s and intelligent measuring
devices.

Official documentation:
https://www.anybus.com/docs/librariesprovider7/default-document-library/
manuals-design-guides/hms-hmsi-27-275.pdf

Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
---
 drivers/fieldbus/Kconfig           |    3 +-
 drivers/fieldbus/Makefile          |    4 +-
 drivers/fieldbus/anybuss/Kconfig   |    9 +
 drivers/fieldbus/anybuss/Makefile  |    7 +
 drivers/fieldbus/anybuss/host.c    | 1459 ++++++++++++++++++++++++++++
 include/linux/anybuss-client.h     |  104 ++
 include/linux/anybuss-controller.h |   47 +
 7 files changed, 1630 insertions(+), 3 deletions(-)
 create mode 100644 drivers/fieldbus/anybuss/Kconfig
 create mode 100644 drivers/fieldbus/anybuss/Makefile
 create mode 100644 drivers/fieldbus/anybuss/host.c
 create mode 100644 include/linux/anybuss-client.h
 create mode 100644 include/linux/anybuss-controller.h

diff --git a/drivers/fieldbus/Kconfig b/drivers/fieldbus/Kconfig
index 5c2bef950d04..b62f06bd522c 100644
--- a/drivers/fieldbus/Kconfig
+++ b/drivers/fieldbus/Kconfig
@@ -14,6 +14,5 @@ menuconfig FIELDBUS_DEV
 
 	  If unsure, say no.
 
-if FIELDBUS_DEV
+source "drivers/fieldbus/anybuss/Kconfig"
 
-endif
diff --git a/drivers/fieldbus/Makefile b/drivers/fieldbus/Makefile
index 23877def5803..432dd9c03569 100644
--- a/drivers/fieldbus/Makefile
+++ b/drivers/fieldbus/Makefile
@@ -6,4 +6,6 @@
 obj-$(CONFIG_FIELDBUS_DEV)	+= fieldbus_dev.o
 fieldbus_dev-y			:= dev_core.o
 
-# Devices
+# Anybus-S core and devices
+obj-$(CONFIG_HMS_ANYBUSS_BUS)	+= anybuss/
+
diff --git a/drivers/fieldbus/anybuss/Kconfig b/drivers/fieldbus/anybuss/Kconfig
new file mode 100644
index 000000000000..5b495f25c11e
--- /dev/null
+++ b/drivers/fieldbus/anybuss/Kconfig
@@ -0,0 +1,9 @@
+config HMS_ANYBUSS_BUS
+	tristate "HMS Anybus-S Bus Support"
+	select REGMAP
+	depends on OF && FIELDBUS_DEV
+	help
+	  Driver for the HMS Industrial Networks Anybus-S bus.
+	  You can attach a single Anybus-S compatible card to it, which
+	  typically provides fieldbus and industrial ethernet
+	  functionality.
diff --git a/drivers/fieldbus/anybuss/Makefile b/drivers/fieldbus/anybuss/Makefile
new file mode 100644
index 000000000000..b1c386cb4ed2
--- /dev/null
+++ b/drivers/fieldbus/anybuss/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for anybuss drivers.
+#
+
+obj-y			+= anybuss_core.o
+anybuss_core-y		+= host.o
diff --git a/drivers/fieldbus/anybuss/host.c b/drivers/fieldbus/anybuss/host.c
new file mode 100644
index 000000000000..e07e5983baa1
--- /dev/null
+++ b/drivers/fieldbus/anybuss/host.c
@@ -0,0 +1,1459 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HMS Anybus-S Host Driver
+ *
+ * Copyright (C) 2018 Arcx Inc
+ */
+
+/*
+ * Architecture Overview
+ * =====================
+ * This driver (running on the CPU/SoC) and the Anybus-S card communicate
+ * by reading and writing data to/from the Anybus-S Dual-Port RAM (dpram).
+ * This is memory connected to both the SoC and Anybus-S card, which both sides
+ * can access freely and concurrently.
+ *
+ * Synchronization happens by means of two registers located in the dpram:
+ * IND_AB: written exclusively by the Anybus card; and
+ * IND_AP: written exclusively by this driver.
+ *
+ * Communication happens using one of the following mechanisms:
+ * 1. reserve, read/write, release dpram memory areas:
+ *	using an IND_AB/IND_AP protocol, the driver is able to reserve certain
+ *	memory areas. no dpram memory can be read or written except if reserved.
+ *	(with a few limited exceptions)
+ * 2. send and receive data structures via a shared mailbox:
+ *	using an IND_AB/IND_AP protocol, the driver and Anybus card are able to
+ *	exchange commands and responses using a shared mailbox.
+ * 3. receive software interrupts:
+ *	using an IND_AB/IND_AP protocol, the Anybus card is able to notify the
+ *	driver of certain events such as: bus online/offline, data available.
+ *	note that software interrupt event bits are located in a memory area
+ *	which must be reserved before it can be accessed.
+ *
+ * The manual[1] is silent on whether these mechanisms can happen concurrently,
+ * or how they should be synchronized. However, section 13 (Driver Example)
+ * provides the following suggestion for developing a driver:
+ * a) an interrupt handler which updates global variables;
+ * b) a continuously-running task handling area requests (1 above)
+ * c) a continuously-running task handling mailbox requests (2 above)
+ * The example conspicuously leaves out software interrupts (3 above), which
+ * is the thorniest issue to get right (see below).
+ *
+ * The naive, straightforward way to implement this would be:
+ * - create an isr which updates shared variables;
+ * - create a work_struct which handles software interrupts on a queue;
+ * - create a function which does reserve/update/unlock in a loop;
+ * - create a function which does mailbox send/receive in a loop;
+ * - call the above functions from the driver's read/write/ioctl;
+ * - synchronize using mutexes/spinlocks:
+ *	+ only one area request at a time
+ *	+ only one mailbox request at a time
+ *	+ protect AB_IND, AB_IND against data hazards (e.g. read-after-write)
+ *
+ * Unfortunately, the presence of the software interrupt causes subtle yet
+ * considerable synchronization issues; especially problematic is the
+ * requirement to reserve/release the area which contains the status bits.
+ *
+ * The driver architecture presented here sidesteps these synchronization issues
+ * by accessing the dpram from a single kernel thread only. User-space throws
+ * "tasks" (i.e. 1, 2 above) into a task queue, waits for their completion,
+ * and the kernel thread runs them to completion.
+ *
+ * Each task has a task_function, which is called/run by the queue thread.
+ * That function communicates with the Anybus card, and returns either
+ * 0 (OK), a negative error code (error), or -EINPROGRESS (waiting).
+ * On OK or error, the queue thread completes and dequeues the task,
+ * which also releases the user space thread which may still be waiting for it.
+ * On -EINPROGRESS (waiting), the queue thread will leave the task on the queue,
+ * and revisit (call again) whenever an interrupt event comes in.
+ *
+ * Each task has a state machine, which is run by calling its task_function.
+ * It ensures that the task will go through its various stages over time,
+ * returning -EINPROGRESS if it wants to wait for an event to happen.
+ *
+ * Note that according to the manual's driver example, the following operations
+ * may run independent of each other:
+ * - area reserve/read/write/release	(point 1 above)
+ * - mailbox operations			(point 2 above)
+ * - switching power on/off
+ *
+ * To allow them to run independently, each operation class gets its own queue.
+ *
+ * Userspace processes A, B, C, D post tasks to the appropriate queue,
+ * and wait for task completion:
+ *
+ *	process A	B	C	D
+ *		|	|	|	|
+ *		v	v	v	v
+ *	|<-----	========================================
+ *	|		|	   |		|
+ *	|		v	   v		v-------<-------+
+ *	|	+--------------------------------------+	|
+ *	|	| power q     | mbox q    | area q     |	|
+ *	|	|------------|------------|------------|	|
+ *	|	| task       | task       | task       |	|
+ *	|	| task       | task       | task       |	|
+ *	|	| task wait  | task wait  | task wait  |	|
+ *	|	+--------------------------------------+	|
+ *	|		^	   ^		^		|
+ *	|		|	   |		|		^
+ *	|	+--------------------------------------+	|
+ *	|	|	     queue thread	       |	|
+ *	|	|--------------------------------------|	|
+ *	|	| single-threaded:		       |	|
+ *	|	| loop:				       |	|
+ *	v	|   for each queue:		       |	|
+ *	|	|     run task state machine	       |	|
+ *	|	|     if task waiting:		       |	|
+ *	|	|       leave on queue		       |	|
+ *	|	|     if task done:		       |	|
+ *	|	|       complete task, remove from q   |	|
+ *	|	|   if software irq event bits set:    |	|
+ *	|	|     notify userspace		       |	|
+ *	|	|     post clear event bits task------>|>-------+
+ *	|	|   wait for IND_AB changed event OR   |
+ *	|	|            task added event	  OR   |
+ *	|	|	     timeout		       |
+ *	|	| end loop			       |
+ *	|	+--------------------------------------+
+ *	|	+		wake up		       +
+ *	|	+--------------------------------------+
+ *	|		^			^
+ *	|		|			|
+ *	+-------->-------			|
+ *						|
+ *		+--------------------------------------+
+ *		|	interrupt service routine      |
+ *		|--------------------------------------|
+ *		| wake up queue thread on IND_AB change|
+ *		+--------------------------------------+
+ *
+ * Note that the Anybus interrupt is dual-purpose:
+ * - after a reset, triggered when the card becomes ready;
+ * - during normal operation, triggered when AB_IND changes.
+ * This is why the interrupt service routine doesn't just wake up the
+ * queue thread, but also completes the card_boot completion.
+ *
+ * [1] https://www.anybus.com/docs/librariesprovider7/default-document-library/
+ *	manuals-design-guides/hms-hmsi-27-275.pdf
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/atomic.h>
+#include <linux/kthread.h>
+#include <linux/kfifo.h>
+#include <linux/spinlock.h>
+#include <linux/uaccess.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/random.h>
+#include <linux/kref.h>
+#include <linux/of_address.h>
+
+#include <linux/anybuss-client.h>
+#include <linux/anybuss-controller.h>
+
+#define DPRAM_SIZE		0x800
+#define MAX_MBOX_MSG_SZ		0x0FF
+#define TIMEOUT			(HZ*2)
+#define MAX_DATA_AREA_SZ	0x200
+#define MAX_FBCTRL_AREA_SZ	0x1BE
+
+#define REG_BOOTLOADER_V	0x7C0
+#define REG_API_V		0x7C2
+#define REG_FIELDBUS_V		0x7C4
+#define REG_SERIAL_NO		0x7C6
+#define REG_FIELDBUS_TYPE	0x7CC
+#define REG_MODULE_SW_V		0x7CE
+#define REG_IND_AB		0x7FF
+#define REG_IND_AP		0x7FE
+#define REG_EVENT_CAUSE		0x7ED
+#define MBOX_IN_AREA		0x400
+#define MBOX_OUT_AREA		0x520
+#define DATA_IN_AREA		0x000
+#define DATA_OUT_AREA		0x200
+#define FBCTRL_AREA		0x640
+
+#define EVENT_CAUSE_DC          0x01
+#define EVENT_CAUSE_FBOF        0x02
+#define EVENT_CAUSE_FBON        0x04
+
+#define IND_AB_UPDATED		0x08
+#define IND_AX_MIN		0x80
+#define IND_AX_MOUT		0x40
+#define IND_AX_IN		0x04
+#define IND_AX_OUT		0x02
+#define IND_AX_FBCTRL		0x01
+#define IND_AP_LOCK		0x08
+#define IND_AP_ACTION		0x10
+#define IND_AX_EVNT		0x20
+#define IND_AP_ABITS		(IND_AX_IN | IND_AX_OUT | \
+					IND_AX_FBCTRL | \
+					IND_AP_ACTION | IND_AP_LOCK)
+
+#define INFO_TYPE_FB		0x0002
+#define INFO_TYPE_APP		0x0001
+#define INFO_COMMAND		0x4000
+
+#define OP_MODE_FBFC		0x0002
+#define OP_MODE_FBS		0x0004
+#define OP_MODE_CD		0x0200
+
+#define CMD_START_INIT		0x0001
+#define CMD_ANYBUS_INIT		0x0002
+#define CMD_END_INIT		0x0003
+
+/*
+ * ---------------------------------------------------------------
+ * Anybus mailbox messages - definitions
+ * ---------------------------------------------------------------
+ * note that we're depending on the layout of these structures being
+ * exactly as advertised.
+ */
+
+struct anybus_mbox_hdr {
+	__be16 id;
+	__be16 info;
+	__be16 cmd_num;
+	__be16 data_size;
+	__be16 frame_count;
+	__be16 frame_num;
+	__be16 offset_high;
+	__be16 offset_low;
+	__be16 extended[8];
+};
+
+struct msgAnybusInit {
+	__be16 input_io_len;
+	__be16 input_dpram_len;
+	__be16 input_total_len;
+	__be16 output_io_len;
+	__be16 output_dpram_len;
+	__be16 output_total_len;
+	__be16 op_mode;
+	__be16 notif_config;
+	__be16 wd_val;
+};
+
+/* ------------- ref counted tasks ------------- */
+
+struct ab_task;
+typedef int (*ab_task_fn_t)(struct anybuss_host *cd,
+					struct ab_task *t);
+typedef void (*ab_done_fn_t)(struct anybuss_host *cd);
+
+struct area_priv {
+	bool is_write;
+	u16 flags;
+	u16 addr;
+	size_t count;
+	u8 buf[MAX_DATA_AREA_SZ];
+};
+
+struct mbox_priv {
+	struct anybus_mbox_hdr hdr;
+	size_t msg_out_sz;
+	size_t msg_in_sz;
+	u8 msg[MAX_MBOX_MSG_SZ];
+};
+
+struct ab_task {
+	struct kmem_cache	*cache;
+	struct kref		refcount;
+	ab_task_fn_t		task_fn;
+	ab_done_fn_t		done_fn;
+	int			result;
+	struct completion	done;
+	unsigned long		start_jiffies;
+	union {
+		struct area_priv area_pd;
+		struct mbox_priv mbox_pd;
+	};
+};
+
+static struct ab_task *ab_task_create_get(struct kmem_cache *cache,
+			ab_task_fn_t task_fn)
+{
+	struct ab_task *t;
+
+	t = kmem_cache_alloc(cache, GFP_KERNEL);
+	if (!t)
+		return NULL;
+	t->cache = cache;
+	kref_init(&t->refcount);
+	t->task_fn = task_fn;
+	t->done_fn = NULL;
+	t->result = 0;
+	init_completion(&t->done);
+	return t;
+}
+
+static void __ab_task_destroy(struct kref *refcount)
+{
+	struct ab_task *t = container_of(refcount, struct ab_task, refcount);
+	struct kmem_cache *cache = t->cache;
+
+	kmem_cache_free(cache, t);
+}
+
+static void ab_task_put(struct ab_task *t)
+{
+	kref_put(&t->refcount, __ab_task_destroy);
+}
+
+static struct ab_task *__ab_task_get(struct ab_task *t)
+{
+	kref_get(&t->refcount);
+	return t;
+}
+
+static void __ab_task_finish(struct ab_task *t, struct anybuss_host *cd)
+{
+	if (t->done_fn)
+		t->done_fn(cd);
+	complete(&t->done);
+}
+
+static void
+ab_task_dequeue_finish_put(struct kfifo *q, struct anybuss_host *cd)
+{
+	int ret;
+	struct ab_task *t;
+
+	ret = kfifo_out(q, &t, sizeof(t));
+	WARN_ON(!ret);
+	__ab_task_finish(t, cd);
+	ab_task_put(t);
+}
+
+static int
+ab_task_enqueue(struct ab_task *t, struct kfifo *q, spinlock_t *slock,
+		wait_queue_head_t *wq)
+{
+	int ret;
+
+	t->start_jiffies = jiffies;
+	__ab_task_get(t);
+	ret = kfifo_in_spinlocked(q, &t, sizeof(t), slock);
+	if (!ret) {
+		ab_task_put(t);
+		return -ENOMEM;
+	}
+	wake_up(wq);
+	return 0;
+}
+
+static int
+ab_task_enqueue_wait(struct ab_task *t, struct kfifo *q, spinlock_t *slock,
+		     wait_queue_head_t *wq)
+{
+	int ret;
+
+	ret = ab_task_enqueue(t, q, slock, wq);
+	if (ret)
+		return ret;
+	ret = wait_for_completion_interruptible(&t->done);
+	if (ret)
+		return ret;
+	return t->result;
+}
+
+/* ------------------------ anybus hardware ------------------------ */
+
+struct anybuss_host {
+	struct device *dev;
+	struct anybuss_client *client;
+	void (*reset)(struct device *dev, bool assert);
+	struct regmap *regmap;
+	int irq;
+	int host_idx;
+	struct task_struct *qthread;
+	wait_queue_head_t wq;
+	struct completion card_boot;
+	atomic_t ind_ab;
+	spinlock_t qlock;
+	struct kmem_cache *qcache;
+	struct kfifo qs[3];
+	struct kfifo *powerq;
+	struct kfifo *mboxq;
+	struct kfifo *areaq;
+	bool power_on;
+	bool softint_pending;
+};
+
+static void reset_assert(struct anybuss_host *cd)
+{
+	cd->reset(cd->dev, true);
+}
+
+static void reset_deassert(struct anybuss_host *cd)
+{
+	cd->reset(cd->dev, false);
+}
+
+static int test_dpram(struct regmap *regmap)
+{
+	int i;
+	unsigned int val;
+
+	for (i = 0; i < DPRAM_SIZE; i++)
+		regmap_write(regmap, i, (u8)i);
+	for (i = 0; i < DPRAM_SIZE; i++) {
+		regmap_read(regmap, i, &val);
+		if ((u8)val != (u8)i)
+			return -EIO;
+	}
+	return 0;
+}
+
+static int read_ind_ab(struct regmap *regmap)
+{
+	unsigned long timeout = jiffies + HZ/2;
+	unsigned int a, b, i = 0;
+
+	while (time_before_eq(jiffies, timeout)) {
+		regmap_read(regmap, REG_IND_AB, &a);
+		regmap_read(regmap, REG_IND_AB, &b);
+		if (likely(a == b))
+			return (int)a;
+		if (i < 10) {
+			cpu_relax();
+			i++;
+		} else {
+			usleep_range(500, 1000);
+		}
+	}
+	WARN(1, "IND_AB register not stable");
+	return -ETIMEDOUT;
+}
+
+static int write_ind_ap(struct regmap *regmap, unsigned int ind_ap)
+{
+	unsigned long timeout = jiffies + HZ/2;
+	unsigned int v, i = 0;
+
+	while (time_before_eq(jiffies, timeout)) {
+		regmap_write(regmap, REG_IND_AP, ind_ap);
+		regmap_read(regmap, REG_IND_AP, &v);
+		if (likely(ind_ap == v))
+			return 0;
+		if (i < 10) {
+			cpu_relax();
+			i++;
+		} else {
+			usleep_range(500, 1000);
+		}
+	}
+	WARN(1, "IND_AP register not stable");
+	return -ETIMEDOUT;
+}
+
+static irqreturn_t irq_handler(int irq, void *data)
+{
+	struct anybuss_host *cd = data;
+	int ind_ab;
+
+	/*
+	 * irq handler needs exclusive access to the IND_AB register,
+	 * because the act of reading the register acks the interrupt.
+	 *
+	 * store the register value in cd->ind_ab (an atomic_t), so that the
+	 * queue thread is able to read it without causing an interrupt ack
+	 * side-effect (and without spuriously acking an interrupt).
+	 */
+	ind_ab = read_ind_ab(cd->regmap);
+	if (ind_ab < 0)
+		return IRQ_NONE;
+	atomic_set(&cd->ind_ab, ind_ab);
+	complete(&cd->card_boot);
+	wake_up(&cd->wq);
+	return IRQ_HANDLED;
+}
+
+/* ------------------------ power on/off tasks --------------------- */
+
+static int task_fn_power_off(struct anybuss_host *cd,
+				struct ab_task *t)
+{
+	struct anybuss_client *client = cd->client;
+
+	if (!cd->power_on)
+		return 0;
+	disable_irq(cd->irq);
+	reset_assert(cd);
+	atomic_set(&cd->ind_ab, IND_AB_UPDATED);
+	if (client->on_online_changed)
+		client->on_online_changed(client, false);
+	cd->power_on = false;
+	return 0;
+}
+
+static int task_fn_power_on_2(struct anybuss_host *cd,
+				struct ab_task *t)
+{
+	if (completion_done(&cd->card_boot)) {
+		cd->power_on = true;
+		return 0;
+	}
+	if (time_after(jiffies, t->start_jiffies + TIMEOUT)) {
+		disable_irq(cd->irq);
+		reset_assert(cd);
+		dev_err(cd->dev, "power on timed out");
+		return -ETIMEDOUT;
+	}
+	return -EINPROGRESS;
+}
+
+static int task_fn_power_on(struct anybuss_host *cd,
+				struct ab_task *t)
+{
+	unsigned int dummy;
+
+	if (cd->power_on)
+		return 0;
+	/*
+	 * anybus docs: prevent false 'init done' interrupt by
+	 * doing a dummy read of IND_AB register while in reset.
+	 */
+	regmap_read(cd->regmap, REG_IND_AB, &dummy);
+	reinit_completion(&cd->card_boot);
+	enable_irq(cd->irq);
+	reset_deassert(cd);
+	t->task_fn = task_fn_power_on_2;
+	return -EINPROGRESS;
+}
+
+int anybuss_set_power(struct anybuss_client *client, bool power_on)
+{
+	struct anybuss_host *cd = client->host;
+	struct ab_task *t;
+	int err;
+
+	t = ab_task_create_get(cd->qcache, power_on ?
+				task_fn_power_on : task_fn_power_off);
+	if (!t)
+		return -ENOMEM;
+	err = ab_task_enqueue_wait(t, cd->powerq, &cd->qlock, &cd->wq);
+	ab_task_put(t);
+	return err;
+}
+EXPORT_SYMBOL_GPL(anybuss_set_power);
+
+/* ---------------------------- area tasks ------------------------ */
+
+static int task_fn_area_3(struct anybuss_host *cd, struct ab_task *t)
+{
+	struct area_priv *pd = &t->area_pd;
+
+	if (!cd->power_on)
+		return -EIO;
+	if (atomic_read(&cd->ind_ab) & pd->flags) {
+		/* area not released yet */
+		if (time_after(jiffies, t->start_jiffies + TIMEOUT))
+			return -ETIMEDOUT;
+		return -EINPROGRESS;
+	}
+	return 0;
+}
+
+static int task_fn_area_2(struct anybuss_host *cd, struct ab_task *t)
+{
+	struct area_priv *pd = &t->area_pd;
+	unsigned int ind_ap;
+	int ret;
+
+	if (!cd->power_on)
+		return -EIO;
+	regmap_read(cd->regmap, REG_IND_AP, &ind_ap);
+	if (!(atomic_read(&cd->ind_ab) & pd->flags)) {
+		/* we don't own the area yet */
+		if (time_after(jiffies, t->start_jiffies + TIMEOUT)) {
+			dev_warn(cd->dev, "timeout waiting for area");
+			dump_stack();
+			return -ETIMEDOUT;
+		}
+		return -EINPROGRESS;
+	}
+	/* we own the area, do what we're here to do */
+	if (pd->is_write)
+		regmap_bulk_write(cd->regmap, pd->addr, pd->buf,
+							pd->count);
+	else
+		regmap_bulk_read(cd->regmap, pd->addr, pd->buf,
+							pd->count);
+	/* ask to release the area, must use unlocked release */
+	ind_ap &= ~IND_AP_ABITS;
+	ind_ap |= pd->flags;
+	ret = write_ind_ap(cd->regmap, ind_ap);
+	if (ret)
+		return ret;
+	t->task_fn = task_fn_area_3;
+	return -EINPROGRESS;
+}
+
+static int task_fn_area(struct anybuss_host *cd, struct ab_task *t)
+{
+	struct area_priv *pd = &t->area_pd;
+	unsigned int ind_ap;
+	int ret;
+
+	if (!cd->power_on)
+		return -EIO;
+	regmap_read(cd->regmap, REG_IND_AP, &ind_ap);
+	/* ask to take the area */
+	ind_ap &= ~IND_AP_ABITS;
+	ind_ap |= pd->flags | IND_AP_ACTION | IND_AP_LOCK;
+	ret = write_ind_ap(cd->regmap, ind_ap);
+	if (ret)
+		return ret;
+	t->task_fn = task_fn_area_2;
+	return -EINPROGRESS;
+}
+
+static struct ab_task *
+create_area_reader(struct kmem_cache *qcache, u16 flags, u16 addr,
+				size_t count)
+{
+	struct ab_task *t;
+	struct area_priv *ap;
+
+	t = ab_task_create_get(qcache, task_fn_area);
+	if (!t)
+		return NULL;
+	ap = &t->area_pd;
+	ap->flags = flags;
+	ap->addr = addr;
+	ap->is_write = false;
+	ap->count = count;
+	return t;
+}
+
+static struct ab_task *
+create_area_writer(struct kmem_cache *qcache, u16 flags, u16 addr,
+				const void *buf, size_t count)
+{
+	struct ab_task *t;
+	struct area_priv *ap;
+
+	t = ab_task_create_get(qcache, task_fn_area);
+	if (!t)
+		return NULL;
+	ap = &t->area_pd;
+	ap->flags = flags;
+	ap->addr = addr;
+	ap->is_write = true;
+	ap->count = count;
+	memcpy(ap->buf, buf, count);
+	return t;
+}
+
+static struct ab_task *
+create_area_user_writer(struct kmem_cache *qcache, u16 flags, u16 addr,
+				const void __user *buf, size_t count)
+{
+	struct ab_task *t;
+	struct area_priv *ap;
+
+	t = ab_task_create_get(qcache, task_fn_area);
+	if (!t)
+		return ERR_PTR(-ENOMEM);
+	ap = &t->area_pd;
+	ap->flags = flags;
+	ap->addr = addr;
+	ap->is_write = true;
+	ap->count = count;
+	if (copy_from_user(ap->buf, buf, count)) {
+		ab_task_put(t);
+		return ERR_PTR(-EFAULT);
+	}
+	return t;
+}
+
+static bool area_range_ok(u16 addr, size_t count, u16 area_start,
+							size_t area_sz)
+{
+	u16 area_end_ex = area_start + area_sz;
+	u16 addr_end_ex;
+
+	if (addr < area_start)
+		return false;
+	if (addr >= area_end_ex)
+		return false;
+	addr_end_ex = addr + count;
+	if (addr_end_ex > area_end_ex)
+		return false;
+	return true;
+}
+
+/* -------------------------- mailbox tasks ----------------------- */
+
+static int task_fn_mbox_2(struct anybuss_host *cd, struct ab_task *t)
+{
+	struct mbox_priv *pd = &t->mbox_pd;
+	unsigned int ind_ap;
+
+	if (!cd->power_on)
+		return -EIO;
+	regmap_read(cd->regmap, REG_IND_AP, &ind_ap);
+	if (((atomic_read(&cd->ind_ab) ^ ind_ap) & IND_AX_MOUT) == 0) {
+		/* output message not here */
+		if (time_after(jiffies, t->start_jiffies + TIMEOUT))
+			return -ETIMEDOUT;
+		return -EINPROGRESS;
+	}
+	/* grab the returned header and msg */
+	regmap_bulk_read(cd->regmap, MBOX_OUT_AREA, &pd->hdr,
+		sizeof(pd->hdr));
+	regmap_bulk_read(cd->regmap, MBOX_OUT_AREA + sizeof(pd->hdr),
+		pd->msg, pd->msg_in_sz);
+	/* tell anybus we've consumed the message */
+	ind_ap ^= IND_AX_MOUT;
+	return write_ind_ap(cd->regmap, ind_ap);
+}
+
+static int task_fn_mbox(struct anybuss_host *cd, struct ab_task *t)
+{
+	struct mbox_priv *pd = &t->mbox_pd;
+	unsigned int ind_ap;
+	int ret;
+
+	if (!cd->power_on)
+		return -EIO;
+	regmap_read(cd->regmap, REG_IND_AP, &ind_ap);
+	if ((atomic_read(&cd->ind_ab) ^ ind_ap) & IND_AX_MIN) {
+		/* mbox input area busy */
+		if (time_after(jiffies, t->start_jiffies + TIMEOUT))
+			return -ETIMEDOUT;
+		return -EINPROGRESS;
+	}
+	/* write the header and msg to input area */
+	regmap_bulk_write(cd->regmap, MBOX_IN_AREA, &pd->hdr,
+					sizeof(pd->hdr));
+	regmap_bulk_write(cd->regmap, MBOX_IN_AREA + sizeof(pd->hdr),
+					pd->msg, pd->msg_out_sz);
+	/* tell anybus we gave it a message */
+	ind_ap ^= IND_AX_MIN;
+	ret = write_ind_ap(cd->regmap, ind_ap);
+	if (ret)
+		return ret;
+	t->start_jiffies = jiffies;
+	t->task_fn = task_fn_mbox_2;
+	return -EINPROGRESS;
+}
+
+static void log_invalid_other(struct device *dev,
+				struct anybus_mbox_hdr *hdr)
+{
+	size_t ext_offs = ARRAY_SIZE(hdr->extended) - 1;
+	u16 code = be16_to_cpu(hdr->extended[ext_offs]);
+
+	dev_err(dev, "   Invalid other: [0x%02X]", code);
+}
+
+static const char * const EMSGS[] = {
+	"Invalid Message ID",
+	"Invalid Message Type",
+	"Invalid Command",
+	"Invalid Data Size",
+	"Message Header Malformed (offset 008h)",
+	"Message Header Malformed (offset 00Ah)",
+	"Message Header Malformed (offset 00Ch - 00Dh)",
+	"Invalid Address",
+	"Invalid Response",
+	"Flash Config Error",
+};
+
+static int mbox_cmd_err(struct device *dev, struct mbox_priv *mpriv)
+{
+	int i;
+	u8 ecode;
+	struct anybus_mbox_hdr *hdr = &mpriv->hdr;
+	u16 info = be16_to_cpu(hdr->info);
+	u8 *phdr = (u8 *)hdr;
+	u8 *pmsg = mpriv->msg;
+
+	if (!(info & 0x8000))
+		return 0;
+	ecode = (info >> 8) & 0x0F;
+	dev_err(dev, "mailbox command failed:");
+	if (ecode == 0x0F)
+		log_invalid_other(dev, hdr);
+	else if (ecode < ARRAY_SIZE(EMSGS))
+		dev_err(dev, "   Error code: %s (0x%02X)",
+			EMSGS[ecode], ecode);
+	else
+		dev_err(dev, "   Error code: 0x%02X\n", ecode);
+	dev_err(dev, "Failed command:");
+	dev_err(dev, "Message Header:");
+	for (i = 0; i < sizeof(mpriv->hdr); i += 2)
+		dev_err(dev, "%02X%02X", phdr[i], phdr[i+1]);
+	dev_err(dev, "Message Data:");
+	for (i = 0; i < mpriv->msg_in_sz; i += 2)
+		dev_err(dev, "%02X%02X", pmsg[i], pmsg[i+1]);
+	dev_err(dev, "Stack dump:");
+	dump_stack();
+	return -EIO;
+}
+
+static int _anybus_mbox_cmd(struct anybuss_host *cd,
+				u16 cmd_num, bool is_fb_cmd,
+				const void *msg_out, size_t msg_out_sz,
+				void *msg_in, size_t msg_in_sz,
+				const void *ext, size_t ext_sz)
+{
+	struct ab_task *t;
+	struct mbox_priv *pd;
+	struct anybus_mbox_hdr *h;
+	size_t msg_sz = max(msg_in_sz, msg_out_sz);
+	u16 info;
+	int err;
+
+	if (msg_sz > MAX_MBOX_MSG_SZ)
+		return -EINVAL;
+	if (ext && (ext_sz > sizeof(h->extended)))
+		return -EINVAL;
+	t = ab_task_create_get(cd->qcache, task_fn_mbox);
+	if (!t)
+		return -ENOMEM;
+	pd = &t->mbox_pd;
+	h = &pd->hdr;
+	info = is_fb_cmd ? INFO_TYPE_FB : INFO_TYPE_APP;
+	/*
+	 * prevent uninitialized memory in the header from being sent
+	 * across the anybus
+	 */
+	memset(h, 0, sizeof(*h));
+	h->info = cpu_to_be16(info | INFO_COMMAND);
+	h->cmd_num = cpu_to_be16(cmd_num);
+	h->data_size = cpu_to_be16(msg_out_sz);
+	h->frame_count = cpu_to_be16(1);
+	h->frame_num = cpu_to_be16(1);
+	h->offset_high = cpu_to_be16(0);
+	h->offset_low = cpu_to_be16(0);
+	if (ext)
+		memcpy(h->extended, ext, ext_sz);
+	memcpy(pd->msg, msg_out, msg_out_sz);
+	pd->msg_out_sz = msg_out_sz;
+	pd->msg_in_sz = msg_in_sz;
+	err = ab_task_enqueue_wait(t, cd->powerq, &cd->qlock, &cd->wq);
+	if (err)
+		goto out;
+	/*
+	 * mailbox mechanism worked ok, but maybe the mbox response
+	 * contains an error ?
+	 */
+	err = mbox_cmd_err(cd->dev, pd);
+	if (err)
+		goto out;
+	memcpy(msg_in, pd->msg, msg_in_sz);
+out:
+	ab_task_put(t);
+	return err;
+}
+
+/* ------------------------ anybus queues ------------------------ */
+
+static void process_q(struct anybuss_host *cd, struct kfifo *q)
+{
+	struct ab_task *t;
+	int ret;
+
+	ret = kfifo_out_peek(q, &t, sizeof(t));
+	if (!ret)
+		return;
+	t->result = t->task_fn(cd, t);
+	if (t->result != -EINPROGRESS)
+		ab_task_dequeue_finish_put(q, cd);
+}
+
+static bool qs_have_work(struct kfifo *qs, size_t num)
+{
+	size_t i;
+	struct ab_task *t;
+	int ret;
+
+	for (i = 0; i < num; i++, qs++) {
+		ret = kfifo_out_peek(qs, &t, sizeof(t));
+		if (ret && (t->result != -EINPROGRESS))
+			return true;
+	}
+	return false;
+}
+
+static void process_qs(struct anybuss_host *cd)
+{
+	size_t i;
+	struct kfifo *qs = cd->qs;
+	size_t nqs = ARRAY_SIZE(cd->qs);
+
+	for (i = 0; i < nqs; i++, qs++)
+		process_q(cd, qs);
+}
+
+static void softint_ack(struct anybuss_host *cd)
+{
+	unsigned int ind_ap;
+
+	cd->softint_pending = false;
+	if (!cd->power_on)
+		return;
+	regmap_read(cd->regmap, REG_IND_AP, &ind_ap);
+	ind_ap &= ~IND_AX_EVNT;
+	ind_ap |= atomic_read(&cd->ind_ab) & IND_AX_EVNT;
+	write_ind_ap(cd->regmap, ind_ap);
+}
+
+static void process_softint(struct anybuss_host *cd)
+{
+	struct anybuss_client *client = cd->client;
+	static const u8 zero;
+	int ret;
+	unsigned int ind_ap, ev;
+	struct ab_task *t;
+
+	if (!cd->power_on)
+		return;
+	if (cd->softint_pending)
+		return;
+	regmap_read(cd->regmap, REG_IND_AP, &ind_ap);
+	if (!((atomic_read(&cd->ind_ab) ^ ind_ap) & IND_AX_EVNT))
+		return;
+	/* process software interrupt */
+	regmap_read(cd->regmap, REG_EVENT_CAUSE, &ev);
+	if (ev & EVENT_CAUSE_FBON) {
+		if (client->on_online_changed)
+			client->on_online_changed(client, true);
+		dev_dbg(cd->dev, "Fieldbus ON");
+	}
+	if (ev & EVENT_CAUSE_FBOF) {
+		if (client->on_online_changed)
+			client->on_online_changed(client, false);
+		dev_dbg(cd->dev, "Fieldbus OFF");
+	}
+	if (ev & EVENT_CAUSE_DC) {
+		if (client->on_area_updated)
+			client->on_area_updated(client);
+		dev_dbg(cd->dev, "Fieldbus data changed");
+	}
+	/*
+	 * reset the event cause bits.
+	 * this must be done while owning the fbctrl area, so we'll
+	 * enqueue a task to do that.
+	 */
+	t = create_area_writer(cd->qcache, IND_AX_FBCTRL,
+		REG_EVENT_CAUSE, &zero, sizeof(zero));
+	if (!t) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	t->done_fn = softint_ack;
+	ret = ab_task_enqueue(t, cd->powerq, &cd->qlock, &cd->wq);
+	ab_task_put(t);
+	cd->softint_pending = true;
+out:
+	WARN_ON(ret);
+	if (ret)
+		softint_ack(cd);
+}
+
+static int qthread_fn(void *data)
+{
+	struct anybuss_host *cd = data;
+	struct kfifo *qs = cd->qs;
+	size_t nqs = ARRAY_SIZE(cd->qs);
+	unsigned int ind_ab;
+
+	/*
+	 * this kernel thread has exclusive access to the anybus's memory.
+	 * only exception: the IND_AB register, which is accessed exclusively
+	 * by the interrupt service routine (ISR). This thread must not touch
+	 * the IND_AB register, but it does require access to its value.
+	 *
+	 * the interrupt service routine stores the register's value in
+	 * cd->ind_ab (an atomic_t), where we may safely access it, with the
+	 * understanding that it can be modified by the ISR at any time.
+	 */
+
+	while (!kthread_should_stop()) {
+		/*
+		 * make a local copy of IND_AB, so we can go around the loop
+		 * again in case it changed while processing queues and softint.
+		 */
+		ind_ab = atomic_read(&cd->ind_ab);
+		process_qs(cd);
+		process_softint(cd);
+		wait_event_timeout(cd->wq,
+			(atomic_read(&cd->ind_ab) != ind_ab) ||
+				qs_have_work(qs, nqs) ||
+				kthread_should_stop(),
+			HZ);
+		/*
+		 * time out so even 'stuck' tasks will run eventually,
+		 * and can time out.
+		 */
+	}
+
+	return 0;
+}
+
+/* ------------------------ anybus exports ------------------------ */
+
+int anybuss_start_init(struct anybuss_client *client,
+			const struct anybuss_memcfg *cfg)
+{
+	int ret;
+	u16 op_mode;
+	struct anybuss_host *cd = client->host;
+	struct msgAnybusInit msg = {
+		.input_io_len = cpu_to_be16(cfg->input_io),
+		.input_dpram_len = cpu_to_be16(cfg->input_dpram),
+		.input_total_len = cpu_to_be16(cfg->input_total),
+		.output_io_len = cpu_to_be16(cfg->output_io),
+		.output_dpram_len = cpu_to_be16(cfg->output_dpram),
+		.output_total_len = cpu_to_be16(cfg->output_total),
+		.notif_config = cpu_to_be16(0x000F),
+		.wd_val = cpu_to_be16(0),
+	};
+
+	switch (cfg->offl_mode) {
+	case AB_OFFL_MODE_CLEAR:
+		op_mode = 0;
+		break;
+	case AB_OFFL_MODE_FREEZE:
+		op_mode = OP_MODE_FBFC;
+		break;
+	case AB_OFFL_MODE_SET:
+		op_mode = OP_MODE_FBS;
+		break;
+	default:
+		return -EINVAL;
+	}
+	msg.op_mode = cpu_to_be16(op_mode | OP_MODE_CD);
+	ret = _anybus_mbox_cmd(cd, CMD_START_INIT, false, NULL, 0,
+						NULL, 0, NULL, 0);
+	if (ret)
+		return ret;
+	return _anybus_mbox_cmd(cd, CMD_ANYBUS_INIT, false,
+			&msg, sizeof(msg), NULL, 0, NULL, 0);
+}
+EXPORT_SYMBOL_GPL(anybuss_start_init);
+
+int anybuss_finish_init(struct anybuss_client *client)
+{
+	struct anybuss_host *cd = client->host;
+
+	return _anybus_mbox_cmd(cd, CMD_END_INIT, false, NULL, 0,
+					NULL, 0, NULL, 0);
+}
+EXPORT_SYMBOL_GPL(anybuss_finish_init);
+
+int anybuss_read_fbctrl(struct anybuss_client *client, u16 addr,
+				void *buf, size_t count)
+{
+	struct anybuss_host *cd = client->host;
+	struct ab_task *t;
+	int ret;
+
+	if (count == 0)
+		return 0;
+	if (!area_range_ok(addr, count, FBCTRL_AREA,
+					MAX_FBCTRL_AREA_SZ))
+		return -EFAULT;
+	t = create_area_reader(cd->qcache, IND_AX_FBCTRL, addr, count);
+	if (!t)
+		return -ENOMEM;
+	ret = ab_task_enqueue_wait(t, cd->powerq, &cd->qlock, &cd->wq);
+	if (ret)
+		goto out;
+	memcpy(buf, t->area_pd.buf, count);
+out:
+	ab_task_put(t);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(anybuss_read_fbctrl);
+
+int anybuss_write_input(struct anybuss_client *client,
+				const char __user *buf, size_t size,
+				loff_t *offset)
+{
+	ssize_t len = min_t(loff_t, MAX_DATA_AREA_SZ - *offset, size);
+	struct anybuss_host *cd = client->host;
+	struct ab_task *t;
+	int ret;
+
+	if (len <= 0)
+		return 0;
+	t = create_area_user_writer(cd->qcache, IND_AX_IN,
+		DATA_IN_AREA + *offset, buf, len);
+	if (IS_ERR(t))
+		return PTR_ERR(t);
+	ret = ab_task_enqueue_wait(t, cd->powerq, &cd->qlock, &cd->wq);
+	ab_task_put(t);
+	if (ret)
+		return ret;
+	/* success */
+	*offset += len;
+	return len;
+}
+EXPORT_SYMBOL_GPL(anybuss_write_input);
+
+int anybuss_read_output(struct anybuss_client *client,
+				char __user *buf, size_t size,
+				loff_t *offset)
+{
+	ssize_t len = min_t(loff_t, MAX_DATA_AREA_SZ - *offset, size);
+	struct anybuss_host *cd = client->host;
+	struct ab_task *t;
+	int ret;
+
+	if (len <= 0)
+		return 0;
+	t = create_area_reader(cd->qcache, IND_AX_OUT,
+		DATA_OUT_AREA + *offset, len);
+	if (!t)
+		return -ENOMEM;
+	ret = ab_task_enqueue_wait(t, cd->powerq, &cd->qlock, &cd->wq);
+	if (ret)
+		goto out;
+	if (copy_to_user(buf, t->area_pd.buf, len))
+		ret = -EFAULT;
+out:
+	ab_task_put(t);
+	if (ret)
+		return ret;
+	/* success */
+	*offset += len;
+	return len;
+}
+EXPORT_SYMBOL_GPL(anybuss_read_output);
+
+int anybuss_send_msg(struct anybuss_client *client, u16 cmd_num,
+				const void *buf, size_t count)
+{
+	struct anybuss_host *cd = client->host;
+
+	return _anybus_mbox_cmd(cd, cmd_num, true, buf, count, NULL, 0,
+					NULL, 0);
+}
+EXPORT_SYMBOL_GPL(anybuss_send_msg);
+
+int anybuss_send_ext(struct anybuss_client *client, u16 cmd_num,
+	const void *buf, size_t count)
+{
+	struct anybuss_host *cd = client->host;
+
+	return _anybus_mbox_cmd(cd, cmd_num, true, NULL, 0, NULL, 0,
+					buf, count);
+}
+EXPORT_SYMBOL_GPL(anybuss_send_ext);
+
+int anybuss_recv_msg(struct anybuss_client *client, u16 cmd_num,
+	void *buf, size_t count)
+{
+	struct anybuss_host *cd = client->host;
+
+	return _anybus_mbox_cmd(cd, cmd_num, true, NULL, 0, buf, count,
+					NULL, 0);
+}
+EXPORT_SYMBOL_GPL(anybuss_recv_msg);
+
+/* ------------------------ bus functions ------------------------ */
+
+static int anybus_bus_match(struct device *dev,
+				struct device_driver *drv)
+{
+	struct anybuss_client_driver *adrv =
+		to_anybuss_client_driver(drv);
+	struct anybuss_client *adev =
+		to_anybuss_client(dev);
+
+	return adrv->fieldbus_type == adev->fieldbus_type;
+}
+
+static int anybus_bus_probe(struct device *dev)
+{
+	struct anybuss_client_driver *adrv =
+		to_anybuss_client_driver(dev->driver);
+	struct anybuss_client *adev =
+		to_anybuss_client(dev);
+
+	if (!adrv->probe)
+		return -ENODEV;
+	return adrv->probe(adev);
+}
+
+static int anybus_bus_remove(struct device *dev)
+{
+	struct anybuss_client_driver *adrv =
+		to_anybuss_client_driver(dev->driver);
+
+	if (adrv->remove)
+		return adrv->remove(to_anybuss_client(dev));
+	return 0;
+}
+
+static struct bus_type anybus_bus = {
+	.name		= "anybuss",
+	.match		= anybus_bus_match,
+	.probe		= anybus_bus_probe,
+	.remove		= anybus_bus_remove,
+};
+
+int anybuss_client_driver_register(struct anybuss_client_driver *drv)
+{
+	drv->driver.bus = &anybus_bus;
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(anybuss_client_driver_register);
+
+void anybuss_client_driver_unregister(struct anybuss_client_driver *drv)
+{
+	return driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(anybuss_client_driver_unregister);
+
+static void client_device_release(struct device *dev)
+{
+	kfree(to_anybuss_client(dev));
+}
+
+static int taskq_alloc(struct device *dev, struct kfifo *q)
+{
+	void *buf;
+	size_t size = 64 * sizeof(struct ab_task *);
+
+	buf = devm_kzalloc(dev, size, GFP_KERNEL);
+	if (!buf)
+		return -EIO;
+	return kfifo_init(q, buf, size);
+}
+
+static int anybus_of_get_host_idx(struct device_node *np)
+{
+	const __be32 *host_idx;
+
+	host_idx = of_get_address(np, 0, NULL, NULL);
+	if (!host_idx)
+		return -ENOENT;
+	return __be32_to_cpu(*host_idx);
+}
+
+static struct device_node *anybus_of_find_child_device(
+			struct device *dev, int host_idx)
+{
+	struct device_node *node;
+
+	if (!dev || !dev->of_node)
+		return NULL;
+	for_each_child_of_node(dev->of_node, node) {
+		if (anybus_of_get_host_idx(node) == host_idx)
+			return node;
+	}
+	return NULL;
+}
+
+struct anybuss_host * __must_check
+anybuss_host_common_probe(struct device *dev,
+			      const struct anybuss_ops *ops)
+{
+	int ret, i;
+	u8 val[4];
+	u16 fieldbus_type;
+	struct anybuss_host *cd;
+
+	cd = devm_kzalloc(dev, sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return ERR_PTR(-ENOMEM);
+	cd->dev = dev;
+	cd->host_idx = ops->host_idx;
+	init_completion(&cd->card_boot);
+	init_waitqueue_head(&cd->wq);
+	for (i = 0; i < ARRAY_SIZE(cd->qs); i++) {
+		ret = taskq_alloc(dev, &cd->qs[i]);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+	if (WARN_ON(ARRAY_SIZE(cd->qs) < 3))
+		return ERR_PTR(-EINVAL);
+	cd->powerq = &cd->qs[0];
+	cd->mboxq = &cd->qs[1];
+	cd->areaq = &cd->qs[2];
+	cd->reset = ops->reset;
+	if (!cd->reset)
+		return ERR_PTR(-EINVAL);
+	cd->regmap = ops->regmap;
+	if (!cd->regmap)
+		return ERR_PTR(-EINVAL);
+	spin_lock_init(&cd->qlock);
+	cd->qcache = kmem_cache_create(dev_name(dev),
+		sizeof(struct ab_task), 0, 0, NULL);
+	if (!cd->qcache)
+		return ERR_PTR(-ENOMEM);
+	cd->irq = ops->irq;
+	if (cd->irq <= 0) {
+		ret = -EINVAL;
+		goto err_qcache;
+	}
+	/*
+	 * use a dpram test to check if a card is present, this is only
+	 * possible while in reset.
+	 */
+	reset_assert(cd);
+	if (test_dpram(cd->regmap)) {
+		dev_err(dev, "no Anybus-S card in slot");
+		ret = -ENODEV;
+		goto err_qcache;
+	}
+	ret = devm_request_threaded_irq(dev, cd->irq, NULL, irq_handler,
+			IRQF_ONESHOT, dev_name(dev), cd);
+	if (ret) {
+		dev_err(dev, "could not request irq");
+		goto err_qcache;
+	}
+	/*
+	 * startup sequence:
+	 *   perform dummy IND_AB read to prevent false 'init done' irq
+	 *     (already done by test_dpram() above)
+	 *   release reset
+	 *   wait for first interrupt
+	 *   interrupt came in: ready to go !
+	 */
+	reset_deassert(cd);
+	ret = wait_for_completion_timeout(&cd->card_boot, TIMEOUT);
+	if (ret == 0)
+		ret = -ETIMEDOUT;
+	if (ret < 0)
+		goto err_reset;
+	/*
+	 * according to the anybus docs, we're allowed to read these
+	 * without handshaking / reserving the area
+	 */
+	dev_info(dev, "Anybus-S card detected");
+	regmap_bulk_read(cd->regmap, REG_BOOTLOADER_V, val, 2);
+	dev_info(dev, "Bootloader version: %02X%02X",
+			val[0], val[1]);
+	regmap_bulk_read(cd->regmap, REG_API_V, val, 2);
+	dev_info(dev, "API version: %02X%02X", val[0], val[1]);
+	regmap_bulk_read(cd->regmap, REG_FIELDBUS_V, val, 2);
+	dev_info(dev, "Fieldbus version: %02X%02X", val[0], val[1]);
+	regmap_bulk_read(cd->regmap, REG_SERIAL_NO, val, 4);
+	dev_info(dev, "Serial number: %02X%02X%02X%02X",
+		val[0], val[1], val[2], val[3]);
+	add_device_randomness(&val, 4);
+	regmap_bulk_read(cd->regmap, REG_FIELDBUS_TYPE, &fieldbus_type,
+				sizeof(fieldbus_type));
+	fieldbus_type = be16_to_cpu(fieldbus_type);
+	dev_info(dev, "Fieldbus type: %04X", fieldbus_type);
+	regmap_bulk_read(cd->regmap, REG_MODULE_SW_V, val, 2);
+	dev_info(dev, "Module SW version: %02X%02X",
+		val[0], val[1]);
+	/* put card back reset until a client driver releases it */
+	disable_irq(cd->irq);
+	reset_assert(cd);
+	atomic_set(&cd->ind_ab, IND_AB_UPDATED);
+	/* fire up the queue thread */
+	cd->qthread = kthread_run(qthread_fn, cd, dev_name(dev));
+	if (IS_ERR(cd->qthread)) {
+		dev_err(dev, "could not create kthread");
+		ret = PTR_ERR(cd->qthread);
+		goto err_reset;
+	}
+	/*
+	 * now advertise that we've detected a client device (card).
+	 * the bus infrastructure will match it to a client driver.
+	 */
+	cd->client = kzalloc(sizeof(*cd->client), GFP_KERNEL);
+	if (!cd->client) {
+		ret = -ENOMEM;
+		goto err_kthread;
+	}
+	cd->client->fieldbus_type = fieldbus_type;
+	cd->client->host = cd;
+	cd->client->dev.bus = &anybus_bus;
+	cd->client->dev.parent = dev;
+	cd->client->dev.release = client_device_release;
+	cd->client->dev.of_node =
+		anybus_of_find_child_device(dev, cd->host_idx);
+	dev_set_name(&cd->client->dev, "anybuss.card%d", cd->host_idx);
+	ret = device_register(&cd->client->dev);
+	if (ret)
+		goto err_device;
+	return cd;
+err_device:
+	device_unregister(&cd->client->dev);
+err_kthread:
+	kthread_stop(cd->qthread);
+err_reset:
+	reset_assert(cd);
+err_qcache:
+	kmem_cache_destroy(cd->qcache);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(anybuss_host_common_probe);
+
+void anybuss_host_common_remove(struct anybuss_host *host)
+{
+	struct anybuss_host *cd = host;
+
+	device_unregister(&cd->client->dev);
+	kthread_stop(cd->qthread);
+	reset_assert(cd);
+	kmem_cache_destroy(cd->qcache);
+}
+EXPORT_SYMBOL_GPL(anybuss_host_common_remove);
+
+static void host_release(struct device *dev, void *res)
+{
+	struct anybuss_host **dr = res;
+
+	anybuss_host_common_remove(*dr);
+}
+
+struct anybuss_host * __must_check
+devm_anybuss_host_common_probe(struct device *dev,
+			      const struct anybuss_ops *ops)
+{
+	struct anybuss_host **dr;
+	struct anybuss_host *host;
+
+	dr = devres_alloc(host_release, sizeof(struct anybuss_host *),
+				GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	host = anybuss_host_common_probe(dev, ops);
+	if (IS_ERR(host)) {
+		devres_free(dr);
+		return host;
+	}
+	*dr = host;
+	devres_add(dev, dr);
+	return host;
+}
+EXPORT_SYMBOL_GPL(devm_anybuss_host_common_probe);
+
+static int __init anybus_init(void)
+{
+	int ret;
+
+	ret = bus_register(&anybus_bus);
+	if (ret)
+		pr_err("could not register Anybus-S bus: %d\n", ret);
+	return ret;
+}
+module_init(anybus_init);
+
+static void __exit anybus_exit(void)
+{
+	bus_unregister(&anybus_bus);
+}
+module_exit(anybus_exit);
+
+MODULE_DESCRIPTION("HMS Anybus-S Host Driver");
+MODULE_AUTHOR("Sven Van Asbroeck <TheSven73@googlemail.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/anybuss-client.h b/include/linux/anybuss-client.h
new file mode 100644
index 000000000000..a90b89eb5e26
--- /dev/null
+++ b/include/linux/anybuss-client.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Anybus-S client adapter definitions
+ *
+ * Copyright 2018 Arcx Inc
+ */
+
+#ifndef __LINUX_ANYBUSS_CLIENT_H__
+#define __LINUX_ANYBUSS_CLIENT_H__
+
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/poll.h>
+
+struct anybuss_host;
+
+struct anybuss_client {
+	struct device dev;
+	struct anybuss_host *host;
+	u16 fieldbus_type;
+	/*
+	 * these can be optionally set by the client to receive event
+	 * notifications from the host.
+	 */
+	void (*on_area_updated)(struct anybuss_client *client);
+	void (*on_online_changed)(struct anybuss_client *client, bool online);
+};
+
+struct anybuss_client_driver {
+	struct device_driver driver;
+	int (*probe)(struct anybuss_client *adev);
+	int (*remove)(struct anybuss_client *adev);
+	u16 fieldbus_type;
+};
+
+int anybuss_client_driver_register(struct anybuss_client_driver *drv);
+void anybuss_client_driver_unregister(
+				struct anybuss_client_driver *drv);
+
+static inline struct anybuss_client *to_anybuss_client(
+					struct device *dev)
+{
+	return container_of(dev, struct anybuss_client, dev);
+}
+
+static inline struct anybuss_client_driver *to_anybuss_client_driver(
+					struct device_driver *drv)
+{
+	return container_of(drv, struct anybuss_client_driver, driver);
+}
+
+static inline void *
+anybuss_get_drvdata(const struct anybuss_client *client)
+{
+	return dev_get_drvdata(&client->dev);
+}
+
+static inline void
+anybuss_set_drvdata(struct anybuss_client *client, void *data)
+{
+	dev_set_drvdata(&client->dev, data);
+}
+
+int anybuss_set_power(struct anybuss_client *client, bool power_on);
+
+enum anybuss_offl_mode {
+	AB_OFFL_MODE_CLEAR = 0,
+	AB_OFFL_MODE_FREEZE,
+	AB_OFFL_MODE_SET
+};
+
+struct anybuss_memcfg {
+	u16 input_io;
+	u16 input_dpram;
+	u16 input_total;
+
+	u16 output_io;
+	u16 output_dpram;
+	u16 output_total;
+
+	enum anybuss_offl_mode offl_mode;
+};
+
+int anybuss_start_init(struct anybuss_client *client,
+			const struct anybuss_memcfg *cfg);
+int anybuss_finish_init(struct anybuss_client *client);
+int anybuss_read_fbctrl(struct anybuss_client *client, u16 addr,
+				void *buf, size_t count);
+int anybuss_send_msg(struct anybuss_client *client, u16 cmd_num,
+	const void *buf, size_t count);
+int anybuss_send_ext(struct anybuss_client *client, u16 cmd_num,
+	const void *buf, size_t count);
+int anybuss_recv_msg(struct anybuss_client *client, u16 cmd_num,
+	void *buf, size_t count);
+
+/* these help clients make a struct file_operations */
+int anybuss_write_input(struct anybuss_client *client,
+				const char __user *buf, size_t size,
+				loff_t *offset);
+int anybuss_read_output(struct anybuss_client *client,
+				char __user *buf, size_t size,
+				loff_t *offset);
+
+#endif /* __LINUX_ANYBUSS_CLIENT_H__ */
diff --git a/include/linux/anybuss-controller.h b/include/linux/anybuss-controller.h
new file mode 100644
index 000000000000..48b13bbd426f
--- /dev/null
+++ b/include/linux/anybuss-controller.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Anybus-S controller definitions
+ *
+ * Copyright 2018 Arcx Inc
+ */
+
+#ifndef __LINUX_ANYBUSS_CONTROLLER_H__
+#define __LINUX_ANYBUSS_CONTROLLER_H__
+
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+/*
+ * To instantiate an Anybus-S host, a controller should provide the following:
+ * - a reset function which resets the attached card;
+ * - a regmap which provides access to the attached card's dpram;
+ * - the irq of the attached card
+ */
+/**
+ * struct anybuss_ops - Controller resources to instantiate an Anybus-S host
+ *
+ * @reset:	asserts/deasserts the anybus card's reset line.
+ * @regmap:	provides access to the card's dual-port RAM area.
+ * @irq:	number of the interrupt connected to the card's interrupt line.
+ * @host_idx:	for multi-host controllers, the host index:
+ *		0 for the first host on the controller, 1 for the second, etc.
+ */
+struct anybuss_ops {
+	void (*reset)(struct device *dev, bool assert);
+	struct regmap *regmap;
+	int irq;
+	int host_idx;
+};
+
+struct anybuss_host;
+
+struct anybuss_host * __must_check
+anybuss_host_common_probe(struct device *dev,
+			      const struct anybuss_ops *ops);
+void anybuss_host_common_remove(struct anybuss_host *host);
+
+struct anybuss_host * __must_check
+devm_anybuss_host_common_probe(struct device *dev,
+			      const struct anybuss_ops *ops);
+
+#endif /* __LINUX_ANYBUSS_CONTROLLER_H__ */
-- 
2.17.1

