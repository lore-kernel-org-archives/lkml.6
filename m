Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB71C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F2D20881
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2dof+Ek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F2D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeILCRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:17:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47081 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeILCRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:17:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id e23-v6so21550376lfc.13;
        Tue, 11 Sep 2018 14:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2/afY1gY9mR17DENEZ6I9qbUoj/38d0pfhGqF+rvEAU=;
        b=G2dof+Ek87udTViitzRYw7KzyiVBzWpQMT71T6V9rpMKenqJ9Ehmt1AzzVhJQuuOta
         oihfG8VhMp7qn5A0qhant53m05BkipVafdFw5/T09WnIHXIMiQNhKGJDBXsJ+EZstWLs
         MDXNSX/zr8Z5cvT3VY+r+pQ5FNv3DOdLBTGRsVg6VKcSNqj1LhCZKb3umx6PJg5gfydM
         CsC9gE+XBnPohymTEqL/HAtTF7U7s3QqMiJA/s0rDkxb2kDV2ijCk4Xr1uEdkk7vnYHT
         gqfxaa5Js/XzgKvYfknjPpKp9rrSyDS89QqVBtODej42Q/fKU/ETYCc+vX6Kg2kTiLUj
         TFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2/afY1gY9mR17DENEZ6I9qbUoj/38d0pfhGqF+rvEAU=;
        b=U3a4/l7BT5X8XHKJ8Q3lh8czOmtDWbgTMsfh9rcQPytnmCs/6urtGNb2z99Xk2LDXw
         v2snKvSldB0Yp88zske7oYt8zA4RbS9R3l1OUHB07fKo2c35U22OK+1GvE1JNzXQr/hW
         NLmo87k/UxFQ8Ar+WsdqfIwxuUMDZdEp6rsX5CQkoiw5wi+DWbY1xnN+CyrPUibPegSA
         S+MXzkiwi7u6eosTvcDWO/Gak4WxQ0G2sa6VyuWaFWZUe9/YvRHqV4MvvjVTwmyJ9jCk
         3uxZhfA42J28Q9uQtdIiA6rbs2SozpLwCT7Rxu7YfXRj+p2m3P71Yxfd1DUc4AC2TYHp
         JWaw==
X-Gm-Message-State: APzg51Ab+Zr0OAtx+BiQG5ENX9h3SI43JslHx/NwcQjWJJR9T0zQ+7Eq
        6O+Eac/JKRtzG9crgrk9+00=
X-Google-Smtp-Source: ANB0VdYiJE0nvQwivpAcHHVSIq+A6OksPkUcjhip1SrUQBZhwGblJygf6CjljvJ1tbkX0CNt8CXzIA==
X-Received: by 2002:a19:11d1:: with SMTP id 78-v6mr16439052lfr.25.1536700589015;
        Tue, 11 Sep 2018 14:16:29 -0700 (PDT)
Received: from localhost.localdomain ([195.254.138.66])
        by smtp.gmail.com with ESMTPSA id e26-v6sm3479696ljl.67.2018.09.11.14.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 14:16:28 -0700 (PDT)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     w-kwok2@ti.com, m-karicheri2@ti.com, davem@davemloft.net,
        grygorii.strashko@ti.com
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        Vasyl Gomonovych <vasyl.gomonovych@nokia.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] knav: qmss: Introduce queue descriptors monitor
Date:   Tue, 11 Sep 2018 23:15:47 +0200
Message-Id: <20180911211549.12092-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Monitor and record available descriptors in knav_qmss queues
Get amount of available descriptors in free-descriptor queue
base on event-triggered RX traffic.
Also monitor free-descriptor queue base on periodic time interval
in kernel thread.
To start monitoring available descriptors in queue earlyi,
module parameters, enable start monitoring in boottime

This queue descriptor monitor helps debugging starvation issue.
The monitor should help debug queue under traffic pressure
and can describe the shape of this pressure when a queue
faced descriptors starvation.
Monitor helpful for IP blocks which do not have dedicated
descriptor starvation interrupt like RapidIO IP.

Registration and enable file in debugfs hierarchy

|-/sys/kernel/debug
|-- knav_qmssm_soc:hwqueue@2a40000
|   |-- 8710
|   |   |-- buffer_size
|   |   |-- enable
|   |   |-- monitor_stats
|   |   -- unregister

---

The current implementation is the first iteration
and require additional work.
By this patch I would like to know does this could be
helpful for other components and continue my work in a right way.

Signed-off-by: Vasyl Gomonovych <vasyl.gomonovych@nokia.com>
---
 drivers/net/ethernet/ti/netcp_core.c |   14 +
 drivers/soc/ti/Makefile              |    2 +-
 drivers/soc/ti/knav_qmss.h           |    3 +
 drivers/soc/ti/knav_qmss_queue.c     |   18 +
 drivers/soc/ti/knav_qmssm.c          | 1147 ++++++++++++++++++++++++++++++++++
 drivers/soc/ti/knav_qmssm.h          |  145 +++++
 include/linux/soc/ti/knav_qmss.h     |   19 +-
 7 files changed, 1346 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/ti/knav_qmssm.c
 create mode 100644 drivers/soc/ti/knav_qmssm.h

diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index e40aa3e31af2..d270901c48e1 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -1592,12 +1592,15 @@ static void netcp_free_navigator_resources(struct netcp_intf *netcp)
 		knav_pool_destroy(netcp->tx_pool);
 		netcp->tx_pool = NULL;
 	}
+
+	knav_queue_device_control(netcp->rx_queue, KNAV_QUEUE_SET_MONITOR, 0);
 }
 
 static int netcp_setup_navigator_resources(struct net_device *ndev)
 {
 	struct netcp_intf *netcp = netdev_priv(ndev);
 	struct knav_queue_notify_config notify_cfg;
+	struct knav_queue_monitor_config monitor_cfg;
 	struct knav_dma_cfg config;
 	u32 last_fdq = 0;
 	u8 name[16];
@@ -1664,6 +1667,9 @@ static int netcp_setup_navigator_resources(struct net_device *ndev)
 	knav_queue_disable_notify(netcp->rx_queue);
 
 	/* open Rx FDQs */
+	for (i = 0; i < KNAV_DMA_FDQ_PER_CHAN; i++)
+		monitor_cfg.fdq_arg[i] = NULL;
+
 	for (i = 0; i < KNAV_DMA_FDQ_PER_CHAN && netcp->rx_queue_depths[i];
 	     ++i) {
 		snprintf(name, sizeof(name), "rx-fdq-%s-%d", ndev->name, i);
@@ -1672,8 +1678,16 @@ static int netcp_setup_navigator_resources(struct net_device *ndev)
 			ret = PTR_ERR(netcp->rx_fdq[i]);
 			goto fail;
 		}
+		monitor_cfg.fdq_arg[i] = netcp->rx_fdq[i];
 	}
 
+	/* Set monitor for Rx queue */
+	monitor_cfg.fn = knav_qmssm_event_callback;
+	ret = knav_queue_device_control(netcp->rx_queue,
+					KNAV_QUEUE_SET_MONITOR, &monitor_cfg);
+	if (ret)
+		dev_err(netcp->ndev_dev, "fail set qmms %d", netcp->rx_queue_id);
+
 	memset(&config, 0, sizeof(config));
 	config.direction		= DMA_DEV_TO_MEM;
 	config.u.rx.einfo_present	= true;
diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
index a22edc0b258a..4375f3c4f013 100644
--- a/drivers/soc/ti/Makefile
+++ b/drivers/soc/ti/Makefile
@@ -3,7 +3,7 @@
 # TI Keystone SOC drivers
 #
 obj-$(CONFIG_KEYSTONE_NAVIGATOR_QMSS)	+= knav_qmss.o
-knav_qmss-y := knav_qmss_queue.o knav_qmss_acc.o
+knav_qmss-y := knav_qmss_queue.o knav_qmss_acc.o knav_qmssm.o
 obj-$(CONFIG_KEYSTONE_NAVIGATOR_DMA)	+= knav_dma.o
 obj-$(CONFIG_AMX3_PM)			+= pm33xx.o
 obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
index 3efc47e82973..a05b6174ab3a 100644
--- a/drivers/soc/ti/knav_qmss.h
+++ b/drivers/soc/ti/knav_qmss.h
@@ -289,6 +289,8 @@ struct knav_queue {
 	knav_queue_notify_fn		notifier_fn;
 	void				*notifier_fn_arg;
 	atomic_t			notifier_enabled;
+	struct knav_queue_monitor_config *monitor_cfg;
+	atomic_t			monitor_enabled;
 	struct rcu_head			rcu;
 	unsigned			flags;
 	struct list_head		list;
@@ -313,6 +315,7 @@ struct knav_device {
 	struct list_head			pdsps;
 	struct list_head			qmgrs;
 	enum qmss_version			version;
+	struct knav_qmssm			*qmon;
 };
 
 struct knav_range_ops {
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 6755f2af5619..9516bba9261e 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -30,6 +30,7 @@
 #include <linux/soc/ti/knav_qmss.h>
 
 #include "knav_qmss.h"
+#include "knav_qmssm.h"
 
 static struct knav_device *kdev;
 static DEFINE_MUTEX(knav_dev_lock);
@@ -101,6 +102,12 @@ void knav_queue_notify(struct knav_queue_inst *inst)
 			continue;
 		this_cpu_inc(qh->stats->notifies);
 		qh->notifier_fn(qh->notifier_fn_arg);
+
+		if (atomic_read(&qh->monitor_enabled) == KNAV_QMSSM_DISABLE)
+			continue;
+		if (WARN_ON(!qh->monitor_cfg))
+			continue;
+		qh->monitor_cfg->fn(qh);
 	}
 	rcu_read_unlock();
 }
@@ -600,6 +607,7 @@ int knav_queue_device_control(void *qhandle, enum knav_queue_ctrl_cmd cmd,
 {
 	struct knav_queue *qh = qhandle;
 	struct knav_queue_notify_config *cfg;
+	struct knav_queue_monitor_config *mcfg;
 	int ret;
 
 	switch ((int)cmd) {
@@ -628,6 +636,11 @@ int knav_queue_device_control(void *qhandle, enum knav_queue_ctrl_cmd cmd,
 		ret = knav_queue_get_count(qh);
 		break;
 
+	case KNAV_QUEUE_SET_MONITOR:
+		mcfg = (void *)arg;
+		ret = knav_queue_set_monitor(qh, mcfg);
+		break;
+
 	default:
 		ret = -ENOTSUPP;
 		break;
@@ -1874,6 +1887,10 @@ static int knav_queue_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	ret = knav_qmssm_register(kdev);
+	if (ret < 0)
+		dev_err(dev, "knav qmssm registration failed\n");
+
 	debugfs_create_file("qmss", S_IFREG | S_IRUGO, NULL, NULL,
 			    &knav_queue_debug_ops);
 	device_ready = true;
@@ -1891,6 +1908,7 @@ static int knav_queue_probe(struct platform_device *pdev)
 static int knav_queue_remove(struct platform_device *pdev)
 {
 	/* TODO: Free resources */
+	knav_qmssm_unregister(kdev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
diff --git a/drivers/soc/ti/knav_qmssm.c b/drivers/soc/ti/knav_qmssm.c
new file mode 100644
index 000000000000..2d249a998819
--- /dev/null
+++ b/drivers/soc/ti/knav_qmssm.c
@@ -0,0 +1,1147 @@
+/*
+ * Texas Instruments Keystone Navigator Queue Management SubSystem
+ * Queue Managers Monitor Implementation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/rhashtable.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/tick.h>
+#include <linux/ktime.h>
+#include <linux/io.h>
+#include <linux/stat.h>
+#include <linux/moduleparam.h>
+#include <linux/sched/signal.h>
+#include "knav_qmssm.h"
+
+static char *knav_qmssm_name;
+module_param(knav_qmssm_name, charp, 0644);
+MODULE_PARM_DESC(knav_qmssm_name, "Knav queue monitor name");
+
+#define MAX_BOOTIME_MQ 4
+static int knav_qmssm_qid[MAX_BOOTIME_MQ] = {-1, -1, -1, -1};
+module_param_array(knav_qmssm_qid, int, NULL, 0644);
+MODULE_PARM_DESC(knav_qmssm_qid, "Predefine knav queue ID for early monitoring start");
+
+static u64 knav_qmssm_interval_ms;
+module_param(knav_qmssm_interval_ms, ullong, 0644);
+MODULE_PARM_DESC(knav_qmssm_interval_ms, "Knav queue logger interval");
+
+static LIST_HEAD(knav_qmssm_list);
+static DEFINE_MUTEX(knav_qmssm_lock);
+
+#define TEMP_BUFF_SIZE 128
+
+static const char knav_qmssm_prefix[] = "knav_qmssm";
+static const char knav_qmssm_register_str[] = "register";
+static const char knav_qmssm_unregister_str[] = "unregister";
+static const char knav_qmssm_interval[] = "interval_ms";
+
+static const char knav_qmssm_qid_enable[] = "enable";
+static const char knav_qmssm_qid_wmark[] = "watermark";
+static const char knav_qmssm_qid_bufsize[] = "buffer_size";
+static const char knav_qmssm_qid_stats[] = "monitor_stats";
+
+#define MONITOR_WMARK_MIN  64
+#define MONITOR_WMARK_LOW  128
+#define MONITOR_WMARK_HIGH 256
+
+#define MONITOR_INTERVAL_MS	(10*1000) /* 10 sec */
+
+#define MONITOR_BS   8192
+#define MONITOR_BS_MAX   (64*1024)
+
+#define qmssm_dev(qmon)	(qmon->kdev->dev)
+#define mqd_dev(mqd)	(qmssm_dev(mqd->qmon))
+#define data_dev(data)	(mqd_dev(data->mqd))
+#define mqd_kdev(mqd)	(mqd->qmon->kdev)
+
+#define property(mqd) (mqd->mqe->data->property)
+
+#define INT_PTR(x) ((void *)(unsigned long)x)
+#define PTR_INT(x) ((int)(unsigned long)x)
+
+static inline void knav_qmssm_property_dump(struct monitor_queue_dentry *mqd)
+{
+	dev_dbg(mqd_dev(mqd), "dump: qid %d bs=%d, enable=%d, wmark=[%d %d %d]\n",
+			mqd->qid,
+			property(mqd).buffsize,
+			atomic_read(&property(mqd).enable),
+			property(mqd).wmark[WM_MIN],
+			property(mqd).wmark[WM_LOW],
+			property(mqd).wmark[WM_HIGH]);
+}
+
+static void knav_qmssm_dump(struct knav_qmssm *qmon)
+{
+	struct monitor_queue_dentry *mqd;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(mqd, &qmon->mqlist, list) {
+		if (mqd->mqe)
+			knav_qmssm_property_dump(mqd);
+	}
+	rcu_read_unlock();
+}
+
+static struct knav_queue *knav_qmssm_get_queue(struct knav_device *kdev,
+		unsigned int qid)
+{
+	struct knav_queue *qh = NULL;
+	struct knav_queue_inst *inst = NULL;
+
+	if (!kdev)
+		return NULL;
+
+	if (kdev->base_id <= qid && kdev->base_id + kdev->num_queues > qid) {
+		qid -= kdev->base_id;
+		inst = kdev->instances + (qid <<  kdev->inst_shift);
+	}
+
+	if (!inst)
+		return NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(qh, &inst->handles, list) {
+		if (knav_queue_device_control(qh, KNAV_QUEUE_GET_ID, 0) == qid)
+			break;
+	}
+	rcu_read_unlock();
+
+	return qh;
+}
+
+static int knav_qmssm_thread_logger(void *arg)
+{
+	struct knav_qmssm *qmon;
+	struct monitor_queue_dentry *mqd;
+	struct knav_queue *qh, *q[KNAV_QMSSM_FDQ_PER_CHAN];
+	unsigned int count[KNAV_QMSSM_FDQ_PER_CHAN];
+	unsigned int i = 0;
+	unsigned int qid[KNAV_QMSSM_FDQ_PER_CHAN];
+	ktime_t delay;
+	int ret;
+
+	qmon = (struct knav_qmssm *) arg;
+
+	while (!kthread_should_stop()) {
+
+		rcu_read_lock();
+		list_for_each_entry_rcu(mqd, &qmon->mqlist, list) {
+
+			qh = mqd->qh;
+			if (!qh || !qh->inst)
+				continue;
+
+			if (!qh->monitor_cfg) {
+				count[0] = knav_queue_device_control(qh,
+						KNAV_QUEUE_GET_COUNT, 0);
+				dev_info(qmssm_dev(qmon), "%d:%d",
+						mqd->qid, count[0]);
+				continue;
+			}
+
+			for (i = 0; i < KNAV_QMSSM_FDQ_PER_CHAN; i++) {
+				q[i] = qh->monitor_cfg->fdq_arg[i];
+				count[i] = 0;
+				qid[i] = 0;
+				if (!q[i] || !q[i]->inst)
+					continue;
+
+				count[i] = knav_queue_device_control(q[i],
+						KNAV_QUEUE_GET_COUNT, 0);
+				qid[i] = knav_queue_device_control(qh,
+						KNAV_QUEUE_GET_ID, 0);
+			}
+			dev_info(qmssm_dev(qmon), "%d:%d %d:%d %d:%d %d:%d",
+				qid[0], count[0], qid[1], count[1],
+				qid[2], count[2], qid[3], count[3]);
+		}
+		rcu_read_unlock();
+
+		delay = ms_to_ktime(qmon->ilogger.interval_ms);
+		set_current_state(TASK_INTERRUPTIBLE);
+		ret = schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
+		set_current_state(TASK_RUNNING);
+	}
+
+	return 0;
+}
+
+static int knav_qmssm_logger_start(struct knav_qmssm *qmon)
+{
+	struct task_struct *thread;
+	char name[TEMP_BUFF_SIZE] = {0};
+	int len = 0;
+	int ret = 0;
+
+	if (!qmon)
+		return -EINVAL;
+
+	mutex_lock(&qmon->mqlock);
+
+	if (qmon->ilogger.thread)
+		goto out;
+
+	len = snprintf(name, TEMP_BUFF_SIZE, "kthread_%s/%s\n",
+			knav_qmssm_prefix,
+			dev_name(qmssm_dev(qmon)));
+	name[len] = '\0';
+
+	thread = kthread_run(knav_qmssm_thread_logger, qmon, name);
+
+	if (IS_ERR(thread)) {
+		ret = PTR_ERR(thread);
+		goto out;
+	}
+
+	qmon->ilogger.thread = thread;
+
+out:
+	mutex_unlock(&qmon->mqlock);
+
+	return ret;
+}
+
+static void knav_qmssm_logger_stop(struct knav_qmssm *qmon)
+{
+	int ret;
+
+	if (!qmon)
+		return;
+
+	mutex_lock(&qmon->mqlock);
+
+	if (WARN_ON(!qmon->ilogger.thread)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	send_sig(SIGTERM, qmon->ilogger.thread, 1);
+	ret = kthread_stop(qmon->ilogger.thread);
+	qmon->ilogger.thread = NULL;
+
+out:
+	mutex_unlock(&qmon->mqlock);
+}
+
+static int knav_qmssm_alloc_rb(struct knav_qmssm_qdata *data)
+{
+	int size;
+
+	if (!data)
+		return -EINVAL;
+
+	size = data->property.buffsize;
+	(*data).ring_buffer = ring_buffer_alloc(size, RB_FL_OVERWRITE);
+	if (!data->ring_buffer) {
+		dev_dbg(data_dev(data), "cannot allocate log buffer\n");
+		return -ENOMEM;
+	}
+	dev_dbg(data_dev(data), "ring buffer allocated\n");
+
+	return 0;
+}
+
+static int knav_qmssm_free_rb(struct knav_qmssm_qdata *data)
+{
+	if (!data) {
+		dev_warn(data_dev(data), "%s() null data pointer\n", __func__);
+		return -EINVAL;
+	}
+
+	if (data->ring_buffer) {
+		ring_buffer_free(data->ring_buffer);
+		data->ring_buffer = NULL;
+		dev_dbg(data_dev(data), "ring buffer freed\n");
+	}
+
+	return 0;
+}
+
+static int knav_qmssm_write_rb(struct ring_buffer *buffer, void *entry,
+		unsigned long size)
+{
+	int ret = 0;
+
+	if (!buffer || !entry) {
+		pr_err("%s() rb=%p entry=%p", __func__, buffer, entry);
+		return -EINVAL;
+	}
+
+	ret = ring_buffer_write(buffer, size, entry);
+	if (ret)
+		pr_err("dropped log event %p size %lu\n", buffer, size);
+
+	return 0;
+}
+
+static void knav_qmssm_read_rb(struct seq_file *filp,
+		struct knav_qmssm_qdata *data)
+{
+	struct ring_buffer_event *event;
+	struct knav_qmssm_record_item *entry;
+	struct ring_buffer *rb;
+	int cpu;
+	int found = 1;
+	u64 ts;
+	unsigned long lost;
+	unsigned long rem_nsec;
+
+	rb = data->ring_buffer;
+
+	if (!rb) {
+		dev_err(data_dev(data), "%s null data\n", __func__);
+		return;
+	}
+
+	if (ring_buffer_empty(rb)) {
+		dev_dbg(data_dev(data), "log buffer empty qid %d\n",
+					data->mqd->qid);
+		found = 0;
+	}
+
+	while (found) {
+
+		found = 0;
+		for_each_online_cpu(cpu) {
+
+			event = ring_buffer_consume(rb, cpu, &ts, &lost);
+			if (!event)
+				continue;
+			else {
+				entry = ring_buffer_event_data(event);
+				found = 1;
+				if (!entry)
+					continue;
+
+				rem_nsec = do_div(ts, 1000000000);
+				seq_printf(filp, "[%5lu.%06lu]\t\t%d\t\t%d\n",
+					(unsigned long)ts, rem_nsec,
+					entry->qid, entry->count);
+			}
+		}
+	}
+}
+
+static void knav_qmssm_write_data(struct knav_qmssm_qdata *data,
+		struct knav_qmssm_record_item *entry)
+{
+	int ret = 0;
+
+	if (!data || !entry) {
+		pr_err("error ring buffer write\n");
+		return;
+	}
+
+	ret = knav_qmssm_write_rb(data->ring_buffer, entry, sizeof(*entry));
+	if (ret) {
+		pr_err("ring buffer error to write qid %d\n", data->mqd->qid);
+		return;
+	}
+}
+
+static void knav_qmssm_start_rb(struct knav_qmssm_qdata *data)
+{
+	if (!data->ring_buffer)
+		return;
+	ring_buffer_record_on(data->ring_buffer);
+	dev_dbg(data_dev(data), "%s() ring buffer start\n", __func__);
+}
+
+static void knav_qmssm_stop_rb(struct knav_qmssm_qdata *data)
+{
+	if (!data->ring_buffer)
+		return;
+	ring_buffer_record_off(data->ring_buffer);
+	dev_dbg(data_dev(data), "%s() ring buffer stop\n", __func__);
+}
+
+static int knav_qmssm_start(struct monitor_queue_dentry *mqd)
+{
+	struct knav_qmssm_qdata *data;
+	int ret = 0;
+
+	if (!mqd || WARN_ON(!mqd->mqe))
+		return -EINVAL;
+
+	mutex_lock(&mqd->lock);
+
+	data = mqd->mqe->data;
+	if (!data)
+		goto out0;
+
+	if (!(&mqd->mqe->data->property.enable)) //TODO
+		goto out0;
+
+	if (atomic_read(&property(mqd).enable) == KNAV_QMSSM_ENABLE)
+		goto out0;
+
+	ret = knav_qmssm_free_rb(data);
+	if (ret)
+		goto out0;
+
+	ret = knav_qmssm_alloc_rb(data);
+	if (ret)
+		goto out0;
+
+	knav_qmssm_start_rb(data);
+	ret = knav_queue_enable_monitor(mqd->qh);
+	if (ret) {
+		dev_dbg(mqd_dev(mqd), "cannot start not event-driven queue\n");
+		goto out1;
+	}
+	dev_dbg(mqd_dev(mqd), "%s(%d) success\n", __func__, mqd->qid);
+	atomic_set(&property(mqd).enable, KNAV_QMSSM_ENABLE);
+
+out0:
+	mutex_unlock(&mqd->lock);
+	return ret;
+
+out1:
+	knav_qmssm_stop_rb(data);
+	knav_qmssm_free_rb(data);
+	mutex_unlock(&mqd->lock);
+	return ret;
+}
+
+static int knav_qmssm_stop(struct monitor_queue_dentry *mqd)
+{
+	struct knav_qmssm_qdata *data;
+	int ret = 0;
+
+	if (!mqd)
+		return -EINVAL;
+
+	if (!mqd->mqe) {
+		dev_err(mqd_dev(mqd), "skip not event-driven queue");
+		return -EINVAL;
+	}
+
+	mutex_lock(&mqd->lock);
+	data = mqd->mqe->data;
+	if (atomic_read(&property(mqd).enable) == KNAV_QMSSM_DISABLE)
+		goto out;
+
+	ret = knav_queue_disable_monitor(mqd->qh);
+	if (ret) {
+		dev_dbg(mqd_dev(mqd), "%s(%d) error\n", __func__, mqd->qid);
+		goto out;
+	}
+	knav_qmssm_stop_rb(data);
+	atomic_set(&property(mqd).enable, KNAV_QMSSM_DISABLE);
+	dev_dbg(mqd_dev(mqd), "%s(%d) success\n", __func__, mqd->qid);
+
+out:
+	mutex_unlock(&mqd->lock);
+	return ret;
+}
+
+static int knav_qmssm_init_data(struct monitor_queue_dentry **mqd)
+{
+	struct knav_qmssm_qdata *data;
+	struct knav_qmssm *qmon;
+
+	if (!*mqd || !(*mqd)->mqe)
+		return -EINVAL;
+
+	qmon = (*mqd)->qmon;
+
+	data = devm_kzalloc(qmssm_dev(qmon), sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	(*mqd)->mqe->data = data;
+	data->mqd = *mqd;
+	data->property.buffsize = MONITOR_BS;
+	data->property.wmark[WM_MIN] = MONITOR_WMARK_MIN;
+	data->property.wmark[WM_LOW] = MONITOR_WMARK_LOW;
+	data->property.wmark[WM_HIGH] = MONITOR_WMARK_HIGH;
+	atomic_set(&data->property.enable, KNAV_QMSSM_DISABLE);
+	data->ring_buffer = NULL;
+	memset(&data->lchachee, 0, sizeof(data->lchachee));
+
+	return 0;
+}
+
+static int knav_qmssm_free_data(struct monitor_queue_dentry *mqd)
+{
+	struct knav_qmssm_qdata *data;
+
+	if (!mqd || !mqd->mqe)
+		return -EINVAL;
+
+	data = mqd->mqe->data;
+	mqd->mqe->data = NULL;
+
+	knav_qmssm_free_rb(data);
+	devm_kfree(mqd_dev(mqd), data);
+
+	return 0;
+}
+
+
+static int knav_qmssm_set_enable(void *d, u64 enable)
+{
+	struct monitor_queue_dentry *mqd = d;
+	int ret = 0;
+
+	if (enable == KNAV_QMSSM_ENABLE)
+		ret = knav_qmssm_start(mqd);
+	else if (enable == KNAV_QMSSM_DISABLE)
+		ret = knav_qmssm_stop(mqd);
+
+	return ret;
+}
+
+static int knav_qmssm_get_enable(void *d, u64 *enable)
+{
+	struct monitor_queue_dentry *mqd = d;
+	*enable = atomic_read(&property(mqd).enable);
+	return 0;
+}
+
+static int knav_qmssm_set_bufsize(void *d, u64 bufsize)
+{
+	struct monitor_queue_dentry *mqd = d;
+
+	mutex_lock(&mqd->lock);
+	if (atomic_read(&property(mqd).enable) == KNAV_QMSSM_ENABLE)
+		goto out;
+	property(mqd).buffsize =
+			bufsize > MONITOR_BS_MAX ? MONITOR_BS_MAX : bufsize;
+
+out:
+	mutex_unlock(&mqd->lock);
+	return 0;
+}
+
+static int knav_qmssm_get_bufsize(void *d, u64 *bufsize)
+{
+	struct monitor_queue_dentry *mqd = d;
+	struct ring_buffer *rb;
+	long size;
+
+	mutex_lock(&mqd->lock);
+	rb = mqd->mqe->data->ring_buffer;
+	if (rb)
+		size = ring_buffer_size(rb, smp_processor_id());
+	else
+		size = property(mqd).buffsize;
+	*bufsize = size;
+	mutex_unlock(&mqd->lock);
+	return 0;
+}
+
+/**
+ * knav_qmssm_set_watermark() - write watermark vector
+ */
+static ssize_t knav_qmssm_set_watermark(struct file *filp,
+		const char __user *buffer, size_t count, loff_t *ppos)
+{
+	struct monitor_queue_dentry *mqd;
+	char buff[TEMP_BUFF_SIZE] = {0};
+	ssize_t len = 0;
+	int num = 0;
+	unsigned int wmark[NR_WATERMARK] = {0};
+	unsigned int i = 0;
+	int ret = count;
+
+	if (!filp || *ppos != 0)
+		return -EINVAL;
+
+	mqd = (struct monitor_queue_dentry *)filp->private_data;
+
+	if (count >= sizeof(buff))
+		return -ENOSPC;
+
+	mutex_lock(&mqd->lock);
+
+	len = simple_write_to_buffer(buff, sizeof(buff)-1, ppos, buffer, count);
+
+	if (len < 0) {
+		ret = len;
+		goto out;
+	}
+
+	buff[len] = '\n';
+
+	num = sscanf(buff, "%u %u %u",
+			&wmark[WM_MIN], &wmark[WM_LOW], &wmark[WM_HIGH]);
+	if (num != NR_WATERMARK) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (i = 0; i < NR_WATERMARK; ++i) {
+		wmark[i] = wmark[i] < KNAV_QMSSM_WM_MIN ?
+				KNAV_QMSSM_WM_MIN : wmark[i];
+		wmark[i] = wmark[i] > KNAV_QMSSM_WM_MAX ?
+				KNAV_QMSSM_WM_MAX : wmark[i];
+		property(mqd).wmark[i] = wmark[i];
+	}
+out:
+	mutex_unlock(&mqd->lock);
+	return ret;
+}
+
+/**
+ * knav_qmssm_get_watermark() - read watermark vector
+ */
+static ssize_t knav_qmssm_get_watermark(struct file *filp,
+		char __user *buffer, size_t count, loff_t *ppos)
+{
+	struct monitor_queue_dentry *mqd;
+	char buff[TEMP_BUFF_SIZE] = {0};
+	ssize_t len = 0;
+	int ret = 0;
+
+	if (*ppos != 0 || !filp)
+		return -EINVAL;
+
+	mqd = (struct monitor_queue_dentry *)filp->private_data;
+
+	mutex_lock(&mqd->lock);
+	len = snprintf(buff, TEMP_BUFF_SIZE, "%u %u %u\n",
+			property(mqd).wmark[WM_MIN],
+			property(mqd).wmark[WM_LOW],
+			property(mqd).wmark[WM_HIGH]);
+
+	if (count < strlen(buff)) {
+		ret = -ENOSPC;
+		goto out;
+	}
+	ret = simple_read_from_buffer(buffer, count, ppos, buff, len);
+out:
+	mutex_unlock(&mqd->lock);
+	return ret;
+}
+
+static ssize_t knav_qmssm_show_statistics(struct seq_file *filp, void *d)
+{
+	struct monitor_queue_dentry *mqd = filp->private;
+
+	if (!mqd)
+		return -EINVAL;
+
+	if (atomic_read(&property(mqd).enable) == KNAV_QMSSM_DISABLE) {
+		seq_printf(filp, "%s to enable use:\n", mqd->qmon->name);
+		seq_printf(filp, "echo 1 > /sys/kernel/debug/%s/%d/enable\n\n",
+				mqd->qmon->name, mqd->qid);
+	}
+
+	seq_puts(filp, "timestamp\t\t\tfdq number\tsubmit count\n");
+	knav_qmssm_read_rb(filp, mqd->mqe->data);
+
+	return 0;
+}
+
+static int knav_qmssm_open_statistics(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, knav_qmssm_show_statistics, inode->i_private);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(queue_enable_fops, knav_qmssm_get_enable,
+		knav_qmssm_set_enable, "%llu\n");
+
+DEFINE_DEBUGFS_ATTRIBUTE(queue_bufsize_fops, knav_qmssm_get_bufsize,
+		knav_qmssm_set_bufsize, "%llu\n");
+
+static const struct file_operations knav_qmssm_watermark_fops = {
+		.owner	= THIS_MODULE,
+		.open	= simple_open,
+		.read	= knav_qmssm_get_watermark,
+		.write	= knav_qmssm_set_watermark,
+};
+
+static const struct file_operations knav_qmssm_stats_fops = {
+		.owner		= THIS_MODULE,
+		.open		= knav_qmssm_open_statistics,
+		.read		= seq_read,
+		.llseek		= seq_lseek,
+		.release	= single_release,
+};
+
+static inline bool knav_qmssm_int_queue(struct knav_queue *qh)
+{
+	unsigned int acc;
+
+	if (!qh)
+		return false;
+
+	acc = qh->inst->range->flags;
+	if (acc & RANGE_HAS_IRQ)
+		return true;
+
+	return false;
+}
+
+static int knav_qmssm_register_queue(void *arg, u64 qid)
+{
+	struct knav_qmssm *qmon = NULL;
+	struct monitor_queue_dentry *mqd = NULL;
+	struct monitor_queue_entry *mqe = NULL;
+	char hwq_monitor_qid[TEMP_BUFF_SIZE] = {0};
+	int ret = 0;
+	int len = 0;
+
+	if (!arg)
+		return -EINVAL;
+
+	qmon = (struct knav_qmssm *)arg;
+
+	if (qmon->kdev->num_queues <= qid)
+		return ret;
+
+	mutex_lock(&qmon->mqlock);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(mqd, &qmon->mqlist, list) {
+		if (qid == mqd->qid) {
+			dev_info(qmssm_dev(qmon),
+				"%llu already registered\n", qid);
+			ret = -EEXIST;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	if (ret)
+		goto out0;
+
+	mqd = devm_kzalloc(qmssm_dev(qmon), sizeof(*mqd), GFP_KERNEL);
+	if (!mqd) {
+		ret = -ENOMEM;
+		goto out0;
+	}
+	len = snprintf(hwq_monitor_qid, TEMP_BUFF_SIZE, "%llu", qid);
+	hwq_monitor_qid[len] = '\0';
+
+	mqd->root_qid = debugfs_create_dir(hwq_monitor_qid, qmon->mq_root);
+	mqd->qid = qid;
+	mqd->qmon = qmon;
+	mutex_init(&mqd->lock);
+	mqd->mqe = NULL;
+	mqd->qh	= knav_qmssm_get_queue(qmon->kdev, qid);
+	if (!mqd->qh)
+		goto out1;
+
+	if (knav_qmssm_int_queue(mqd->qh)) {
+
+		mqe = devm_kzalloc(qmssm_dev(qmon), sizeof(*mqe), GFP_KERNEL);
+		if (!mqe)
+			goto out1;
+
+		mqe->enable = debugfs_create_file(knav_qmssm_qid_enable,
+			0660, mqd->root_qid, mqd, &queue_enable_fops);
+		mqe->wmark = debugfs_create_file(knav_qmssm_qid_wmark,
+			0660, mqd->root_qid, mqd, &knav_qmssm_watermark_fops);
+		mqe->bufsize = debugfs_create_file(knav_qmssm_qid_bufsize,
+			0660, mqd->root_qid, mqd, &queue_bufsize_fops);
+		mqe->monitor_stats = debugfs_create_file(knav_qmssm_qid_stats,
+			0440, mqd->root_qid, mqd, &knav_qmssm_stats_fops);
+
+		mqd->mqe = mqe;
+
+		ret = knav_qmssm_init_data(&mqd);
+		if (ret)
+			goto out2;
+	}
+
+	list_add_rcu(&mqd->list, &qmon->mqlist);
+
+	knav_qmssm_dump(qmon);
+
+	mutex_unlock(&qmon->mqlock);
+
+	if (!qmon->ilogger.thread) {
+		ret = knav_qmssm_logger_start(qmon);
+		if (ret)
+			dev_err(qmssm_dev(qmon), "cannot run monitor thread\n");
+	}
+
+	dev_dbg(qmssm_dev(qmon), "%s(%d)\n", __func__, mqd->qid);
+
+	return PTR_INT(mqd);
+
+out2:
+	devm_kfree(qmssm_dev(qmon), mqe);
+
+out1:
+	debugfs_remove_recursive(mqd->root_qid);
+	devm_kfree(qmssm_dev(qmon), mqd);
+	ret = -EINVAL;
+	dev_err(qmssm_dev(qmon), "cannot initialize monitor data\n");
+
+out0:
+	mutex_unlock(&qmon->mqlock);
+	return ret;
+}
+
+static int knav_qmssm_unregister_queue_item(struct knav_qmssm *qmon,
+		struct monitor_queue_dentry *mqd)
+{
+	int ret = 0;
+
+	list_del_rcu(&mqd->list);
+	synchronize_rcu();
+
+	if (!mqd->mqe) {
+		dev_info(mqd_dev(mqd), "free not event-driven queue");
+		goto out;
+	}
+
+	ret = knav_qmssm_stop(mqd);
+	if (ret)
+		dev_err(qmssm_dev(qmon), "error stop monitoring\n");
+	dev_info(qmssm_dev(qmon), "stop event-driven queue\n");
+
+	ret = knav_qmssm_free_data(mqd);
+	if (ret)
+		dev_err(qmssm_dev(qmon), "error free monitoring data\n");
+
+	debugfs_remove_recursive(mqd->root_qid);
+
+	devm_kfree(qmssm_dev(qmon), mqd->mqe);
+
+	dev_dbg(qmssm_dev(qmon), "free event-driven queue %d", mqd->qid);
+
+out:
+	devm_kfree(qmssm_dev(qmon), mqd);
+
+	return ret;
+}
+
+static int knav_qmssm_unregister_queue(void *arg, u64 qid)
+{
+	struct knav_qmssm *qmon = NULL;
+	struct monitor_queue_dentry *mqd = NULL;
+	struct list_head *curr, *next;
+
+	if (!arg)
+		return -ENOENT;
+
+	qmon = (struct knav_qmssm *)arg;
+
+	mutex_lock(&qmon->mqlock);
+
+	if (list_empty(&qmon->mqlist)) {
+		dev_dbg(qmssm_dev(qmon), "no queues under monitoring\n");
+		goto out;
+	}
+
+	list_for_each_safe(curr, next, &qmon->mqlist) {
+
+		mqd = list_entry(curr, struct monitor_queue_dentry, list);
+		if (mqd->qid != qid)
+			continue;
+
+		knav_qmssm_unregister_queue_item(qmon, mqd);
+		break;
+	}
+
+	dev_dbg(qmssm_dev(qmon), "queue %llu unregistered\n", qid);
+
+out:
+	mutex_unlock(&qmon->mqlock);
+
+	if (list_empty(&qmon->mqlist))
+		knav_qmssm_logger_stop(qmon);
+
+	return 0;
+}
+
+static int knav_qmssm_setup_parm_base_queue(struct knav_qmssm *qmon)
+{
+	struct monitor_queue_dentry *mqd;
+	int i = 0, ret = 0;
+
+	dev_dbg(qmssm_dev(qmon), "%s %s %llu", __func__,
+			knav_qmssm_name,
+			knav_qmssm_interval_ms);
+
+	if (!knav_qmssm_name || strcmp(qmon->name, knav_qmssm_name))
+		return 0;
+
+	qmon->ilogger.interval_ms = knav_qmssm_interval_ms;
+
+	for (i = 0; i < MAX_BOOTIME_MQ && knav_qmssm_qid[i] > 0; i++) {
+		dev_dbg(qmssm_dev(qmon), "register boottime queue %d monitor %s\n",
+				knav_qmssm_qid[i], knav_qmssm_name);
+		ret = knav_qmssm_register_queue(qmon, knav_qmssm_qid[i]);
+		mqd = INT_PTR(ret);
+		if (IS_ERR(mqd))
+			continue;
+		knav_qmssm_start(mqd);
+	}
+
+	return 0;
+}
+
+static int knav_qmssm_set_interval(void *arg, u64 interval)
+{
+	struct knav_qmssm *qmon = arg;
+
+	qmon->ilogger.interval_ms = interval;
+
+	return 0;
+}
+
+static int knav_qmssm_get_interval(void *arg, u64 *interval)
+{
+	struct knav_qmssm *qmon = arg;
+
+	*interval = qmon->ilogger.interval_ms;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(knav_register_queue_fops,
+		NULL, knav_qmssm_register_queue, "%llu\n");
+
+DEFINE_DEBUGFS_ATTRIBUTE(knav_unregister_queue_fops,
+		NULL, knav_qmssm_unregister_queue, "%llu\n");
+
+DEFINE_DEBUGFS_ATTRIBUTE(knav_interval_legger_fops,
+		knav_qmssm_get_interval, knav_qmssm_set_interval, "%llu\n");
+
+/**
+ * knav_qmssm_event_callback() - Main monitor handler callback
+ */
+void knav_qmssm_event_callback(void *arg)
+{
+	struct knav_queue *qh;
+	struct knav_queue *q_submit;
+	struct knav_device *kdev;
+	struct knav_qmssm *qmon;
+	struct monitor_queue_dentry *mqd;
+	struct knav_qmssm_record_item itm;
+
+	int count = 0;
+	int cdiff = 0, pdiff = 0;
+	uint16_t qid = 0;
+	int i = 0, j = 0;
+
+	qh = (struct knav_queue *)arg;
+	kdev = qh->inst->kdev;
+	qmon = kdev->qmon;
+	qid = knav_queue_device_control(qh, KNAV_QUEUE_GET_ID, 0);
+	if (!qh->monitor_cfg)
+		return;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(mqd, &qmon->mqlist, list) {
+
+		if (mqd->qid != qid)
+			continue;
+
+		for (i = 0; i < KNAV_QMSSM_FDQ_PER_CHAN; i++) {
+
+			if (!qh->monitor_cfg->fdq_arg[i])
+				break;
+
+			q_submit = qh->monitor_cfg->fdq_arg[i];
+			itm.count = knav_queue_device_control(q_submit,
+					KNAV_QUEUE_GET_COUNT, 0);
+			count = mqd->mqe->data->lchachee[i].count;
+
+			for (j = WM_MIN; j < NR_WATERMARK; j++) {
+
+				cdiff = property(mqd).wmark[j] - itm.count;
+				pdiff = property(mqd).wmark[j] - count;
+
+				if (!((cdiff < 0 && pdiff > 0) ||
+						(cdiff > 0 && pdiff < 0)))
+					continue;
+
+				itm.qid = knav_queue_device_control(q_submit,
+						KNAV_QUEUE_GET_ID, 0);
+				knav_qmssm_write_data(mqd->mqe->data, &itm);
+				memcpy(&mqd->mqe->data->lchachee[i],
+						&itm, sizeof(itm));
+			}
+		}
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(knav_qmssm_event_callback);
+
+int knav_queue_enable_monitor(struct knav_queue *qh)
+{
+	if (!qh || WARN_ON(!qh->monitor_cfg))
+		return -EINVAL;
+
+	atomic_set(&qh->monitor_enabled, KNAV_QMSSM_ENABLE);
+
+	return 0;
+}
+
+int knav_queue_disable_monitor(struct knav_queue *qh)
+{
+	if (!qh || WARN_ON(!qh->monitor_cfg))
+		return -EINVAL;
+
+	atomic_set(&qh->monitor_enabled, KNAV_QMSSM_DISABLE);
+
+	return 0;
+}
+
+int knav_queue_set_monitor(struct knav_queue *qh,
+				struct knav_queue_monitor_config *cfg)
+{
+	int i = 0, j = 0, k = 0;
+	unsigned int qid;
+	bool diff;
+
+	if (!qh)
+		return -EINVAL;
+
+	if (!knav_qmssm_int_queue(qh))
+		return -ENOTSUPP;
+
+	knav_queue_disable_monitor(qh);
+
+	if (!cfg && qh->monitor_cfg) {
+		kzfree(qh->monitor_cfg);
+		return 0;
+	}
+
+	qh->monitor_cfg = kzalloc(sizeof(*(qh->monitor_cfg)), GFP_KERNEL);
+	if (!qh->monitor_cfg)
+		return -ENOMEM;
+
+	qh->monitor_cfg->fn = cfg->fn;
+	for (i = 0; i < KNAV_QMSSM_FDQ_PER_CHAN; i++) {
+
+		if (!cfg->fdq_arg[i])
+			continue;
+
+		diff = true;
+		for (j = 0; j < i; j++)
+			if (cfg->fdq_arg[i] == qh->monitor_cfg->fdq_arg[j]) {
+				diff = false;
+				break;
+			}
+
+		if (diff)
+			qh->monitor_cfg->fdq_arg[k++] = cfg->fdq_arg[i];
+	}
+
+	qid = knav_queue_device_control(qh, KNAV_QUEUE_GET_ID, 0);
+	dev_dbg(qh->inst->kdev->dev, "%s %d [%p %p %p %p]", __func__, qid,
+			qh->monitor_cfg->fdq_arg[0],
+			qh->monitor_cfg->fdq_arg[1],
+			qh->monitor_cfg->fdq_arg[2],
+			qh->monitor_cfg->fdq_arg[3]);
+
+	return 0;
+}
+
+void knav_qmssm_unregister(struct knav_device *kdev)
+{
+	struct list_head *cd, *nd;
+	struct list_head *cq, *nq;
+	struct knav_qmssm *qmon;
+	struct monitor_queue_dentry *mqd;
+
+	if (WARN_ON(!kdev))
+		return;
+
+	mutex_lock(&knav_qmssm_lock);
+
+	if (list_empty(&knav_qmssm_list))
+		goto out;
+
+	list_for_each_safe(cd, nd, &knav_qmssm_list) {
+
+		qmon = list_entry(cd, struct knav_qmssm, list);
+		if (qmon->kdev != kdev)
+			continue;
+
+		list_for_each_safe(cq, nq, &qmon->mqlist) {
+			mqd = list_entry(cq, struct monitor_queue_dentry, list);
+			knav_qmssm_unregister_queue_item(qmon, mqd);
+		}
+
+		debugfs_remove_recursive(qmon->mq_root);
+		list_del(cd);
+		kfree(qmon->name);
+		devm_kfree(qmssm_dev(qmon), qmon);
+	}
+out:
+	mutex_unlock(&knav_qmssm_lock);
+}
+EXPORT_SYMBOL(knav_qmssm_unregister);
+
+int knav_qmssm_register(struct knav_device *kdev)
+{
+	struct knav_qmssm *qmon = NULL;
+	int ret = 0;
+	int len = 0;
+
+	char buff[TEMP_BUFF_SIZE] = {0};
+
+	if (WARN_ON(!kdev))
+		return -ENODEV;
+
+	mutex_lock(&knav_qmssm_lock);
+
+	qmon = devm_kzalloc(kdev->dev, sizeof(*qmon), GFP_KERNEL);
+	if (!qmon) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	qmon->kdev = kdev;
+
+	len = snprintf(buff, TEMP_BUFF_SIZE, "%s_%s", knav_qmssm_prefix,
+			dev_name(kdev->dev));
+	buff[len] = '\0';
+	qmon->name = kstrdup(buff, GFP_KERNEL);
+	if (!qmon->name) {
+		devm_kfree(kdev->dev, qmon);
+		goto out;
+	}
+
+	qmon->mq_root = debugfs_create_dir(buff, NULL);
+
+	qmon->mq_register = debugfs_create_file(knav_qmssm_register_str,
+		0220, qmon->mq_root, qmon, &knav_register_queue_fops);
+
+	qmon->mq_unregister = debugfs_create_file(knav_qmssm_unregister_str,
+		0220, qmon->mq_root, qmon, &knav_unregister_queue_fops);
+
+	qmon->ilogger.mq_interval = debugfs_create_file(knav_qmssm_interval,
+		0220, qmon->mq_root, qmon, &knav_interval_legger_fops);
+
+	qmon->ilogger.interval_ms = MONITOR_INTERVAL_MS;
+
+	INIT_LIST_HEAD(&qmon->mqlist);
+	mutex_init(&qmon->mqlock);
+	list_add(&qmon->list, &knav_qmssm_list);
+	kdev->qmon = qmon;
+	dev_info(kdev->dev, "register %s\n", qmon->name);
+
+	knav_qmssm_setup_parm_base_queue(qmon);
+
+out:
+	mutex_unlock(&knav_qmssm_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(knav_qmssm_register);
diff --git a/drivers/soc/ti/knav_qmssm.h b/drivers/soc/ti/knav_qmssm.h
new file mode 100644
index 000000000000..5360ae9eca73
--- /dev/null
+++ b/drivers/soc/ti/knav_qmssm.h
@@ -0,0 +1,145 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Texas Instruments Keystone Navigator Queue Management SubSystem
+ * Queue Managers Monitor Header
+ */
+
+#ifndef __KNAV_QMSSM_H
+#define __KNAV_QMSSM_H
+
+#include <linux/rbtree.h>
+#include <linux/rhashtable.h>
+#include <linux/ring_buffer.h>
+#include <linux/soc/ti/knav_qmss.h>
+#include "knav_qmss.h"
+
+enum knav_mqmss_watermark {
+	WM_MIN,
+	WM_LOW,
+	WM_HIGH,
+	NR_WATERMARK
+};
+
+#define KNAV_QMSSM_WM_MIN 1
+#define KNAV_QMSSM_WM_MAX 4096
+
+#define KNAV_QMSSM_ENABLE	1
+#define KNAV_QMSSM_DISABLE	0
+
+/*
+ * knav_qmssm_record_item - statistics entry descriptor
+ * qid - queue number
+ * count - keep amount of available descriptors in a hardware queue qid
+ */
+struct knav_qmssm_record_item {
+	uint16_t qid;
+	uint16_t count;
+} __packed;
+
+/*
+ * knav_qmssm_queue_property - describe property for queue under monitoring
+ * new features and functionality could be added here
+ * wmark - watermakr vector
+ * enable - enable tracing
+ * buffsize - sizeof buffer
+ */
+struct knav_qmssm_queue_property {
+	atomic_t enable;
+	unsigned int wmark[NR_WATERMARK];
+	unsigned int buffsize;
+};
+
+/*
+ * knav_qmssm_qdata - logical data struct to get/set property for queue
+ * property - property for this knav queue entry
+ * ring_buffer - buffer with collected statistics/logs
+ * lchachee - last cache entry keep entry from rb to calc logging threshold
+ * mqd - pointer to relative queue dentry
+ */
+struct knav_qmssm_qdata {
+	struct knav_qmssm_queue_property property;
+	struct ring_buffer *ring_buffer;
+	struct knav_qmssm_record_item lchachee[KNAV_QMSSM_FDQ_PER_CHAN];
+	struct monitor_queue_dentry *mqd;
+};
+
+/*
+ * struct monitor_queue_entry - descride extended entry
+ * wmark - dentry represent watermark file
+ * enable - interface to enable/disable statistics collection
+ * bufsize - change buffer size for current queue statistics collection
+ * monitor_statas - show collected statistics
+ * data - pointer to relative data
+ */
+struct monitor_queue_entry {
+	struct dentry *wmark;
+	struct dentry *enable;
+	struct dentry *bufsize;
+	struct dentry *monitor_stats;
+	struct knav_qmssm_qdata *data;
+};
+
+/*
+ * monitor_queue_dentry - struct represent item for registered queue
+ * list - link all registered queues for monitoring for current device
+ * qid - queue id number
+ * qh - keep knav queue
+ * lock - protect property access
+ * root_qid - root dentry for queue
+ * qmon - point to parent monitor device
+ */
+struct monitor_queue_dentry {
+	struct list_head list;
+	unsigned int qid;
+	struct knav_queue *qh;
+	struct mutex lock;
+	struct dentry *root_qid;
+	struct monitor_queue_entry *mqe;
+	struct knav_qmssm *qmon;
+};
+
+/*
+ * struct knav_qmssm_ilogger - interval logger periodic interval monitor
+ * thread - kthread descriptor
+ * mq_interval - dentry descriptor for interval
+ * interval_ms - interval define monitor thread work cycle
+ */
+struct knav_qmssm_ilogger {
+	struct task_struct *thread;
+	struct dentry *mq_interval;
+	u64 interval_ms;
+};
+
+/*
+ * knav_qmssm - describe monitor for hardware queue device
+ * hdev - device which is under monitoring
+ * name - monitor instance name
+ * mqlist - monitoring queues list queue_dentry HEAD is a list to keep queues
+ * mqlock - protect for each list mqd for current device monitor
+ * list  - link hardware queue devices monitors in a list
+ * mq_root - hwq_monitor_%device_name% root debugfs dentry for monitored device
+ * mq_register - interface for new queue register to monitor
+ * mq_unregister - interface for queue unregister and stop monitoring
+ * ilogger - interval thread logger for monitor device
+ */
+struct knav_qmssm {
+	struct knav_device *kdev;
+	unsigned char *name;
+	struct list_head mqlist;
+	struct mutex mqlock;
+	struct list_head list;
+	struct dentry *mq_root;
+	struct dentry *mq_register;
+	struct dentry *mq_unregister;
+	struct knav_qmssm_ilogger ilogger;
+};
+
+int knav_queue_enable_monitor(struct knav_queue *qh);
+int knav_queue_disable_monitor(struct knav_queue *qh);
+int knav_queue_set_monitor(struct knav_queue *qh,
+				struct knav_queue_monitor_config *mcfg);
+
+int knav_qmssm_register(struct knav_device *kdev);
+void knav_qmssm_unregister(struct knav_device *kdev);
+
+#endif /*__KNAV_QMSSM_H*/
diff --git a/include/linux/soc/ti/knav_qmss.h b/include/linux/soc/ti/knav_qmss.h
index 9745df6ed9d3..cc7cf27f58b3 100644
--- a/include/linux/soc/ti/knav_qmss.h
+++ b/include/linux/soc/ti/knav_qmss.h
@@ -34,6 +34,8 @@
 /* queue flags */
 #define KNAV_QUEUE_SHARED	0x0001		/* Queue can be shared */
 
+#define KNAV_QMSSM_FDQ_PER_CHAN 4
+
 /**
  * enum knav_queue_ctrl_cmd -	queue operations.
  * @KNAV_QUEUE_GET_ID:		Get the ID number for an open queue
@@ -49,7 +51,9 @@ enum knav_queue_ctrl_cmd {
 	KNAV_QUEUE_SET_NOTIFIER,
 	KNAV_QUEUE_ENABLE_NOTIFY,
 	KNAV_QUEUE_DISABLE_NOTIFY,
-	KNAV_QUEUE_GET_COUNT
+	KNAV_QUEUE_GET_COUNT,
+	KNAV_QUEUE_SET_MONITOR,
+	KNAV_QUEUE_ENABLE_MONITOR
 };
 
 /* Queue notifier callback prototype */
@@ -65,6 +69,19 @@ struct knav_queue_notify_config {
 	void *fn_arg;
 };
 
+/* Queue monitor callback prototype */
+typedef void (*knav_queue_monitor_fn)(void *arg);
+
+/**
+ * struct knav_queue_moncfg:   Monitor configuration
+ * @fn: Monitor function
+ * @fdq_arg: Monitor fdq
+ */
+struct knav_queue_monitor_config {
+	knav_queue_monitor_fn fn;
+	void *fdq_arg[KNAV_QMSSM_FDQ_PER_CHAN];
+};
+
 void *knav_queue_open(const char *name, unsigned id,
 					unsigned flags);
 void knav_queue_close(void *qhandle);
-- 
2.14.1

