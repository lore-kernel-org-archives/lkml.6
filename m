Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C0BECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB562081B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkFlcfLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB562081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbeKEBKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:10:48 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33521 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730938AbeKEBKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:10:47 -0500
Received: by mail-it1-f194.google.com with SMTP id p11-v6so5612811itf.0;
        Sun, 04 Nov 2018 07:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVrZkFfP4E0tRP0E+tbX/PB8b/4a1UI+5rpfgNfxLPk=;
        b=UkFlcfLYqvzwP1TPg/gwqEBEqoBKV/X/IHTU7Ov2jSGjoMAtIT1e8YX76A+LVipt6y
         VSEcbr/qJl51WebPKMcGhNMPbwx0BfCZP0pxMc21EbDW+hlFgs+roayg35WLh290SSPU
         17A1Lc0IDoLIfNcrpr9e7BOHEHDd25ACGukCSC+ziZJGdTNYcppQJJUb/bOiSKZMpN/l
         ih4rD6OD7x2goZgRpWd7/S5JJFpfAyGoTzcDEAbIprEHgcdB7o4qUanp8nF0lJ+08ecM
         DfsYIA2LVLQx1iurWDKbNxoqBEnGO6OWwkhJMsfWLFXfmSulM6oJHoxh91bsfHrcjYkb
         oITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVrZkFfP4E0tRP0E+tbX/PB8b/4a1UI+5rpfgNfxLPk=;
        b=XeajK2jYoddicwL9bDlG5m8AtdOLuTeqoswtUKHQaKW8UpRc/LKXfSND0a+NdZ3XGm
         BG0NC79iJt7kKp8aZG83MM5GXYECr9hL4XO3Qz8oeI12YdkzRaldKQuvq71pcFLCaq96
         QSsDWuutU6pSw+9lXixxBo80ijbQoZ9WJx6a0CrBIL9haVTIWTXeBIEn2dj7WrOdDIMU
         g1obzIAfYqVYL8wlHCY+Qlgdm7qz40g/wTvGijBo59C/ETDQO1whRIlGKKnncd5EUJ/Q
         eEqsB4z2ZagNlvgUFSWcFh5rfYtkLMiUVFJkP/N78HxPSRUNfJ71v8HTS/0cNYbUKlBp
         Hs6w==
X-Gm-Message-State: AGRZ1gJgxdkQMHjXHcjuGi6VqADYPAfv1+9Br+f07+qHK7stzISHBKGl
        V0E7k4PFzJljuyIaBk/aOlo=
X-Google-Smtp-Source: AJdET5dvELciXLPquAx6dk8pCBYA+heP3dTffn2iuRua4z7dSRNFXP7SzO7AvuvlQjr55P5yK83Nhg==
X-Received: by 2002:a05:660c:342:: with SMTP id b2mr3761573itl.167.1541346919280;
        Sun, 04 Nov 2018 07:55:19 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id j13-v6sm2887482ita.27.2018.11.04.07.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 07:55:18 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH anybus v3 4/6] bus: support HMS Anybus-S bus
Date:   Sun,  4 Nov 2018 10:54:59 -0500
Message-Id: <20181104155501.14767-5-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104155501.14767-1-TheSven73@googlemail.com>
References: <20181104155501.14767-1-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

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

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 drivers/bus/Kconfig            |   10 +
 drivers/bus/Makefile           |    1 +
 drivers/bus/anybuss-host.c     | 1503 ++++++++++++++++++++++++++++++++
 include/linux/anybuss-client.h |  100 +++
 4 files changed, 1614 insertions(+)
 create mode 100644 drivers/bus/anybuss-host.c
 create mode 100644 include/linux/anybuss-client.h

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index f29131529ddb..a11980889711 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -45,6 +45,16 @@ config IMX_WEIM
 	  The WEIM(Wireless External Interface Module) works like a bus.
 	  You can attach many different devices on it, such as NOR, onenand.
 
+config HMS_ANYBUSS_HOST
+	tristate "HMS Anybus-S Host/Bus Driver"
+	select REGMAP
+	depends on OF
+	help
+	  Driver for the HMS Industrial Networks Anybus-S bus.
+	  You can attach Anybus-S compatible cards to it, which
+	  typically provide fieldbus and industrial ethernet
+	  functionality.
+
 config MIPS_CDMM
 	bool "MIPS Common Device Memory Map (CDMM) Driver"
 	depends on CPU_MIPSR2
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 24fa2cde0692..d2ab4716b509 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
 obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
 
 obj-$(CONFIG_IMX_WEIM)		+= imx-weim.o
+obj-$(CONFIG_HMS_ANYBUSS_HOST)	+= anybuss-host.o
 obj-$(CONFIG_MIPS_CDMM)		+= mips_cdmm.o
 obj-$(CONFIG_MVEBU_MBUS) 	+= mvebu-mbus.o
 
diff --git a/drivers/bus/anybuss-host.c b/drivers/bus/anybuss-host.c
new file mode 100644
index 000000000000..05b3bb0281d2
--- /dev/null
+++ b/drivers/bus/anybuss-host.c
@@ -0,0 +1,1503 @@
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
+ * This driver (running on the CPU/SoC) and the Anybus-S communicate
+ * by reading and writing data to/from the Anybus-S Dual-Port RAM (dpram).
+ * This is memory connected to both the SoC and Anybus-S host, which both sides
+ * can access freely and concurrently.
+ *
+ * Synchronization happens by means of two registers located in the dpram:
+ * IND_AB: written exclusively by the Anybus host; and
+ * IND_AP: written exclusively by the driver.
+ *
+ * Communication happens using one of the following mechanisms:
+ * 1. reserve, read/write, release dpram memory areas:
+ *	using an IND_AB/IND_AP protocol, the driver is able to reserve certain
+ *	memory areas. no dpram memory can be read or written except if reserved.
+ *	(with a few limited exceptions)
+ * 2. send and receive data structures via a shared mailbox:
+ *	using an IND_AB/IND_AP protocol, the driver and Anybus host are able to
+ *	exchange commands and responses using a shared mailbox.
+ * 3. receive software interrupts:
+ *	using an IND_AB/IND_AP protocol, the Anybus is able to notify the driver
+ *	of certain events such as: bus online/offline, data available.
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
+ * That function communicates with the Anybus hardware, and returns either
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
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/atomic.h>
+#include <linux/kthread.h>
+#include <linux/kfifo.h>
+#include <linux/spinlock.h>
+#include <linux/uaccess.h>
+#include <linux/reset.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/random.h>
+#include <linux/refcount.h>
+
+#include <linux/anybuss-client.h>
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
+struct anybus_mbox_hdr {
+	u16 id;
+	u16 info;
+	u16 cmd_num;
+	u16 data_size;
+	u16 frame_count;
+	u16 frame_num;
+	u16 offset_high;
+	u16 offset_low;
+	u16 extended[8];
+} __packed;
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
+	refcount_t		refcnt;
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
+	refcount_set(&t->refcnt, 1);
+	t->task_fn = task_fn;
+	t->done_fn = NULL;
+	t->result = 0;
+	init_completion(&t->done);
+	return t;
+}
+
+static void ab_task_put(struct ab_task *t)
+{
+	struct kmem_cache *cache = t->cache;
+
+	if (refcount_dec_and_test(&t->refcnt))
+		kmem_cache_free(cache, t);
+}
+
+static struct ab_task *__ab_task_get(struct ab_task *t)
+{
+	refcount_inc(&t->refcnt);
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
+	struct reset_control *reset;
+	struct regmap *regmap;
+	int irq;
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
+	atomic_t dc_event;
+	wait_queue_head_t dc_wq;
+	atomic_t fieldbus_online;
+	struct kernfs_node *fieldbus_online_sd;
+};
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
+	unsigned int a, b;
+
+	while (time_before_eq(jiffies, timeout)) {
+		regmap_read(regmap, REG_IND_AB, &a);
+		regmap_read(regmap, REG_IND_AB, &b);
+		if (likely(a == b))
+			return (int)a;
+		cpu_relax();
+	}
+	WARN(1, "IND_AB register not stable");
+	return -ETIMEDOUT;
+}
+
+static int write_ind_ap(struct regmap *regmap, unsigned int ind_ap)
+{
+	unsigned long timeout = jiffies + HZ/2;
+	unsigned int v;
+
+	while (time_before_eq(jiffies, timeout)) {
+		regmap_write(regmap, REG_IND_AP, ind_ap);
+		regmap_read(regmap, REG_IND_AP, &v);
+		if (likely(ind_ap == v))
+			return 0;
+		cpu_relax();
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
+	if (!cd->power_on)
+		return 0;
+	disable_irq(cd->irq);
+	reset_control_assert(cd->reset);
+	atomic_set(&cd->ind_ab, IND_AB_UPDATED);
+	atomic_set(&cd->fieldbus_online, 0);
+	sysfs_notify_dirent(cd->fieldbus_online_sd);
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
+		reset_control_assert(cd->reset);
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
+	reset_control_deassert(cd->reset);
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
+struct msgAnybusInit {
+	u16 input_io_len;
+	u16 input_dpram_len;
+	u16 input_total_len;
+	u16 output_io_len;
+	u16 output_dpram_len;
+	u16 output_total_len;
+	u16 op_mode;
+	u16 notif_config;
+	u16 wd_val;
+} __packed;
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
+		atomic_set(&cd->fieldbus_online, 1);
+		sysfs_notify_dirent(cd->fieldbus_online_sd);
+		dev_dbg(cd->dev, "Fieldbus ON");
+	}
+	if (ev & EVENT_CAUSE_FBOF) {
+		atomic_set(&cd->fieldbus_online, 0);
+		sysfs_notify_dirent(cd->fieldbus_online_sd);
+		dev_dbg(cd->dev, "Fieldbus OFF");
+	}
+	if (ev & EVENT_CAUSE_DC) {
+		atomic_inc(&cd->dc_event);
+		wake_up_all(&cd->dc_wq);
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
+int anybuss_read_output(struct anybuss_client *client, int *dc_event,
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
+	*dc_event = atomic_read(&cd->dc_event);
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
+unsigned int anybuss_poll(struct anybuss_client *client, int dc_event,
+				struct file *filp, poll_table *wait)
+{
+	struct anybuss_host *cd = client->host;
+	unsigned int mask = POLLIN | POLLRDNORM | POLLOUT | POLLWRNORM;
+
+	poll_wait(filp, &cd->dc_wq, wait);
+	/* data changed ? */
+	if (atomic_read(&cd->dc_event) != dc_event)
+		mask |= POLLPRI | POLLERR;
+	return mask;
+}
+EXPORT_SYMBOL_GPL(anybuss_poll);
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
+/* ------------------------ attributes ------------------------ */
+
+static ssize_t state_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct anybuss_host *cd = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+		atomic_read(&cd->fieldbus_online) ?
+			"online" : "offline");
+}
+
+static DEVICE_ATTR_RO(state);
+
+static struct attribute *ctrl_attrs[] = {
+	&dev_attr_state.attr,
+	NULL
+};
+
+static struct attribute_group ctrl_group = { .attrs = ctrl_attrs };
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
+/*
+ * parallel bus limitation:
+ *
+ * the anybus is 8-bit wide. we can't assume that the hardware will translate
+ * word accesses on the parallel bus to multiple byte-accesses on the anybus.
+ *
+ * therefore to be safe, we will limit parallel bus accesses to a single byte
+ * at a time.
+ *
+ * we can revisit if/when hardware becomes available that provides bus width
+ * translations.
+ */
+
+static int read_reg_bus(void *context, unsigned int reg,
+				unsigned int *val)
+{
+	void __iomem *base = context;
+
+	*val = readb(base + reg);
+	return 0;
+}
+
+static int write_reg_bus(void *context, unsigned int reg,
+				unsigned int val)
+{
+	void __iomem *base = context;
+
+	writeb(val, base + reg);
+	return 0;
+}
+
+static struct regmap *create_parallel_regmap(struct platform_device *pdev)
+{
+	struct regmap_config regmap_cfg = {
+		.reg_bits = 11,
+		.val_bits = 8,
+		/*
+		 * single-byte parallel bus accesses are atomic, so don't
+		 * require any synchronization.
+		 */
+		.disable_locking = true,
+		.reg_read = read_reg_bus,
+		.reg_write = write_reg_bus,
+	};
+	struct resource *res;
+	void __iomem *base;
+	struct device *dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (resource_size(res) < (1<<regmap_cfg.reg_bits))
+		return ERR_PTR(-EINVAL);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return (struct regmap *)base;
+	return devm_regmap_init(dev, NULL, base, &regmap_cfg);
+}
+
+static int anybus_host_probe(struct platform_device *pdev)
+{
+	int ret, i;
+	u8 val[4];
+	u16 fieldbus_type;
+	struct anybuss_host *cd;
+	struct device *dev = &pdev->dev;
+
+	cd = devm_kzalloc(dev, sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+	cd->dev = dev;
+	init_completion(&cd->card_boot);
+	init_waitqueue_head(&cd->wq);
+	init_waitqueue_head(&cd->dc_wq);
+	for (i = 0; i < ARRAY_SIZE(cd->qs); i++) {
+		ret = taskq_alloc(dev, &cd->qs[i]);
+		if (ret)
+			return ret;
+	}
+	if (WARN_ON(ARRAY_SIZE(cd->qs) < 3))
+		return -EINVAL;
+	cd->powerq = &cd->qs[0];
+	cd->mboxq = &cd->qs[1];
+	cd->areaq = &cd->qs[2];
+	cd->reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(cd->reset))
+		return PTR_ERR(cd->reset);
+	cd->regmap = create_parallel_regmap(pdev);
+	if (IS_ERR(cd->regmap))
+		return PTR_ERR(cd->regmap);
+	spin_lock_init(&cd->qlock);
+	atomic_set(&cd->dc_event, 0);
+	atomic_set(&cd->fieldbus_online, 0);
+	cd->qcache = kmem_cache_create(dev_name(dev),
+		sizeof(struct ab_task), 0, 0, NULL);
+	if (!cd->qcache)
+		return -ENOMEM;
+	cd->irq = platform_get_irq(pdev, 0);
+	if (cd->irq <= 0) {
+		ret = cd->irq;
+		goto err_qcache;
+	}
+	/*
+	 * use a dpram test to check if a card is present, this is only
+	 * possible while in reset.
+	 */
+	reset_control_assert(cd->reset);
+	if (test_dpram(cd->regmap)) {
+		dev_err(dev, "no Anybus-S card in slot");
+		ret = -ENODEV;
+		goto err_qcache;
+	}
+	ret = devm_request_irq(dev, cd->irq, irq_handler, 0, dev_name(dev), cd);
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
+	reset_control_deassert(cd->reset);
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
+	reset_control_assert(cd->reset);
+	atomic_set(&cd->ind_ab, IND_AB_UPDATED);
+	/* attributes */
+	ret = sysfs_create_group(&dev->kobj, &ctrl_group);
+	if (ret < 0)
+		goto err_reset;
+	cd->fieldbus_online_sd =
+		sysfs_get_dirent(dev->kobj.sd, "state");
+	if (!cd->fieldbus_online_sd) {
+		ret = -ENODEV;
+		goto err_sysfs;
+	}
+	/* fire up the queue thread */
+	cd->qthread = kthread_run(qthread_fn, cd, dev_name(dev));
+	if (IS_ERR(cd->qthread)) {
+		dev_err(dev, "could not create kthread");
+		ret = PTR_ERR(cd->qthread);
+		goto err_dirent;
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
+	cd->client->dev.id = pdev->id;
+	cd->client->dev.release = client_device_release;
+	dev_set_name(&cd->client->dev, "%s.card0",
+				dev_name(&pdev->dev));
+	ret = device_register(&cd->client->dev);
+	if (ret)
+		goto err_client;
+	platform_set_drvdata(pdev, cd);
+	dev_set_drvdata(dev, cd);
+	return 0;
+err_client:
+	put_device(&cd->client->dev);
+err_kthread:
+	kthread_stop(cd->qthread);
+err_dirent:
+	sysfs_put(cd->fieldbus_online_sd);
+err_sysfs:
+	sysfs_remove_group(&dev->kobj, &ctrl_group);
+err_reset:
+	reset_control_assert(cd->reset);
+err_qcache:
+	kmem_cache_destroy(cd->qcache);
+	return ret;
+}
+
+static int anybus_host_remove(struct platform_device *pdev)
+{
+	struct anybuss_host *cd = platform_get_drvdata(pdev);
+
+	device_unregister(&cd->client->dev);
+	kthread_stop(cd->qthread);
+	sysfs_put(cd->fieldbus_online_sd);
+	sysfs_remove_group(&cd->dev->kobj, &ctrl_group);
+	reset_control_assert(cd->reset);
+	kmem_cache_destroy(cd->qcache);
+	return 0;
+}
+
+static const struct of_device_id host_of_match[] = {
+	{ .compatible = "arcx,anybuss-host" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, host_of_match);
+
+static struct platform_driver anybus_host_driver = {
+	.probe = anybus_host_probe,
+	.remove = anybus_host_remove,
+	.driver	= {
+		.name = "anybuss-host",
+		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(host_of_match),
+	},
+};
+
+static int __init anybus_init(void)
+{
+	int ret;
+
+	ret = bus_register(&anybus_bus);
+	if (ret) {
+		pr_err("could not register Anybus-S bus: %d\n", ret);
+		return ret;
+	}
+	return platform_driver_register(&anybus_host_driver);
+}
+module_init(anybus_init);
+
+static void __exit anybus_exit(void)
+{
+	platform_driver_unregister(&anybus_host_driver);
+	bus_unregister(&anybus_bus);
+}
+module_exit(anybus_exit);
+
+MODULE_DESCRIPTION("HMS Anybus-S Host Driver");
+MODULE_AUTHOR("Sven Van Asbroeck <svendev@arcx.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/anybuss-client.h b/include/linux/anybuss-client.h
new file mode 100644
index 000000000000..9d439d1a496f
--- /dev/null
+++ b/include/linux/anybuss-client.h
@@ -0,0 +1,100 @@
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
+int anybuss_read_output(struct anybuss_client *client, int *dc_event,
+				char __user *buf, size_t size,
+				loff_t *offset);
+unsigned int anybuss_poll(struct anybuss_client *client,
+		int dc_event, struct file *filp, poll_table *wait);
+
+#endif /* __LINUX_ANYBUSS_CLIENT_H__ */
-- 
2.17.1

