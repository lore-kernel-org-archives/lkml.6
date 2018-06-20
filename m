Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FFDC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C025B20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hhh6vM80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C025B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbeFTMNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:13:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40642 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbeFTMLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:11:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id n5-v6so6419028wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n4sE0lbtmDcgWS/ypmjwVPQdLxaoW24h+pZA52eS6gU=;
        b=Hhh6vM80I4C9aOfoSOTnO6StEqEm+PKPbgoCdcjTMuH1kRIZRm8Xq1Gw1fkHE/wQse
         nAilHLBkgPH9DPK/wgQQW4x2H87n2l0q890FV02Ixs5RxgRgPF8TiWVszWREuMM50FV8
         jMZZ62jMyT6ZPlN20PYE6yycAaozddgC9QoqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n4sE0lbtmDcgWS/ypmjwVPQdLxaoW24h+pZA52eS6gU=;
        b=mbnmGx3I/V3JbDFRAGncGUmLv/At6gsDveueUtF3gNFEBXZtkd5zwKIUwxvqA8DRTz
         PllYSngYVamdYtbwHDVPy2cjaVb2WTcG04d5c1q2TreuEYXFmqAOgsiXvRPuWgHEz9ll
         Uc2nMsfaDuhYb88ffEZ5811WaULPNR0BEWdFM91CuhAE22PmRAVTc7ixexKZBZAWbNpb
         MViZfxDMC+0KDgbEKW3+HnarHtDkh0CJ2J0A73ngzSYEenr6xatqKdSAKw+MFLKvYSld
         zwv+nhCOWt1ICP9FoSCuZWEkTSv8qoHHkcVK+YmVHTQMK5mWOh3/YNcaAnT0LMbWSp1d
         g1sg==
X-Gm-Message-State: APt69E3WIN9uSKvoqfKwu1wPxoVqHmPa7CemGCnW54Yw/9HLFE51RlHW
        LAEy6yingqktd0wS/unjUgA8wQ==
X-Google-Smtp-Source: ADUXVKJ8vleD5YVBIg8Ucv4KOsin+R/Dvl7FmISCJn5uwi+PdkXtN5sthFeVF1y3AerEU8t620tuDg==
X-Received: by 2002:a1c:e594:: with SMTP id c142-v6mr1555557wmh.161.1529496705898;
        Wed, 20 Jun 2018 05:11:45 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id e14-v6sm1656483wmh.17.2018.06.20.05.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 05:11:45 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v5 1/8] interconnect: Add generic on-chip interconnect API
Date:   Wed, 20 Jun 2018 15:11:34 +0300
Message-Id: <20180620121141.15403-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620121141.15403-1-georgi.djakov@linaro.org>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce a new API to get requirements and configure the
interconnect buses across the entire chipset to fit with the current
demand.

The API is using a consumer/provider-based model, where the providers are
the interconnect buses and the consumers could be various drivers.
The consumers request interconnect resources (path) between endpoints and
set the desired constraints on this data flow path. The providers receive
requests from consumers and aggregate these requests for all master-slave
pairs on that path. Then the providers configure each participating in the
topology node according to the requested data flow path, physical links and
constraints. The topology could be complicated and multi-tiered and is SoC
specific.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 Documentation/interconnect/interconnect.rst |  96 ++++
 drivers/Kconfig                             |   2 +
 drivers/Makefile                            |   1 +
 drivers/interconnect/Kconfig                |  10 +
 drivers/interconnect/Makefile               |   2 +
 drivers/interconnect/core.c                 | 586 ++++++++++++++++++++
 include/linux/interconnect-provider.h       | 127 +++++
 include/linux/interconnect.h                |  42 ++
 8 files changed, 866 insertions(+)
 create mode 100644 Documentation/interconnect/interconnect.rst
 create mode 100644 drivers/interconnect/Kconfig
 create mode 100644 drivers/interconnect/Makefile
 create mode 100644 drivers/interconnect/core.c
 create mode 100644 include/linux/interconnect-provider.h
 create mode 100644 include/linux/interconnect.h

diff --git a/Documentation/interconnect/interconnect.rst b/Documentation/interconnect/interconnect.rst
new file mode 100644
index 000000000000..a1ebd83ad0a1
--- /dev/null
+++ b/Documentation/interconnect/interconnect.rst
@@ -0,0 +1,96 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+GENERIC SYSTEM INTERCONNECT SUBSYSTEM
+=====================================
+
+Introduction
+------------
+
+This framework is designed to provide a standard kernel interface to control
+the settings of the interconnects on a SoC. These settings can be throughput,
+latency and priority between multiple interconnected devices or functional
+blocks. This can be controlled dynamically in order to save power or provide
+maximum performance.
+
+The interconnect bus is a hardware with configurable parameters, which can be
+set on a data path according to the requests received from various drivers.
+An example of interconnect buses are the interconnects between various
+components or functional blocks in chipsets. There can be multiple interconnects
+on a SoC that can be multi-tiered.
+
+Below is a simplified diagram of a real-world SoC interconnect bus topology.
+
+::
+
+ +----------------+    +----------------+
+ | HW Accelerator |--->|      M NoC     |<---------------+
+ +----------------+    +----------------+                |
+                         |      |                    +------------+
+  +-----+  +-------------+      V       +------+     |            |
+  | DDR |  |                +--------+  | PCIe |     |            |
+  +-----+  |                | Slaves |  +------+     |            |
+    ^ ^    |                +--------+     |         |   C NoC    |
+    | |    V                               V         |            |
+ +------------------+   +------------------------+   |            |   +-----+
+ |                  |-->|                        |-->|            |-->| CPU |
+ |                  |-->|                        |<--|            |   +-----+
+ |     Mem NoC      |   |         S NoC          |   +------------+
+ |                  |<--|                        |---------+    |
+ |                  |<--|                        |<------+ |    |   +--------+
+ +------------------+   +------------------------+       | |    +-->| Slaves |
+   ^  ^    ^    ^          ^                             | |        +--------+
+   |  |    |    |          |                             | V
+ +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
+ | CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
+ +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
+           |
+       +-------+
+       | Modem |
+       +-------+
+
+Terminology
+-----------
+
+Interconnect provider is the software definition of the interconnect hardware.
+The interconnect providers on the above diagram are M NoC, S NoC, C NoC, P NoC
+and Mem NoC.
+
+Interconnect node is the software definition of the interconnect hardware
+port. Each interconnect provider consists of multiple interconnect nodes,
+which are connected to other SoC components including other interconnect
+providers. The point on the diagram where the CPUs connects to the memory is
+called an interconnect node, which belongs to the Mem NoC interconnect provider.
+
+Interconnect endpoints are the first or the last element of the path. Every
+endpoint is a node, but not every node is an endpoint.
+
+Interconnect path is everything between two endpoints including all the nodes
+that have to be traversed to reach from a source to destination node. It may
+include multiple master-slave pairs across several interconnect providers.
+
+Interconnect consumers are the entities which make use of the data paths exposed
+by the providers. The consumers send requests to providers requesting various
+throughput, latency and priority. Usually the consumers are device drivers, that
+send request based on their needs. An example for a consumer is a video decoder
+that supports various formats and image sizes.
+
+Interconnect providers
+----------------------
+
+Interconnect provider is an entity that implements methods to initialize and
+configure a interconnect bus hardware. The interconnect provider drivers should
+be registered with the interconnect provider core.
+
+The interconnect framework provider API functions are documented in
+.. kernel-doc:: include/linux/interconnect-provider.h
+
+Interconnect consumers
+----------------------
+
+Interconnect consumers are the clients which use the interconnect APIs to
+get paths between endpoints and set their bandwidth/latency/QoS requirements
+for these interconnect paths.
+
+The interconnect framework consumer API functions are documented in
+.. kernel-doc:: include/linux/interconnect.h
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 95b9ccc08165..3ed6ede9d021 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -217,4 +217,6 @@ source "drivers/siox/Kconfig"
 
 source "drivers/slimbus/Kconfig"
 
+source "drivers/interconnect/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 24cd47014657..0cca95740d9b 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -185,3 +185,4 @@ obj-$(CONFIG_TEE)		+= tee/
 obj-$(CONFIG_MULTIPLEXER)	+= mux/
 obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
 obj-$(CONFIG_SIOX)		+= siox/
+obj-$(CONFIG_INTERCONNECT)	+= interconnect/
diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
new file mode 100644
index 000000000000..a261c7d41deb
--- /dev/null
+++ b/drivers/interconnect/Kconfig
@@ -0,0 +1,10 @@
+menuconfig INTERCONNECT
+	tristate "On-Chip Interconnect management support"
+	help
+	  Support for management of the on-chip interconnects.
+
+	  This framework is designed to provide a generic interface for
+	  managing the interconnects in a SoC.
+
+	  If unsure, say no.
+
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
new file mode 100644
index 000000000000..97fca2e09d24
--- /dev/null
+++ b/drivers/interconnect/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_INTERCONNECT)		+= core.o
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
new file mode 100644
index 000000000000..e7f96fc6722e
--- /dev/null
+++ b/drivers/interconnect/core.c
@@ -0,0 +1,586 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Interconnect framework core driver
+ *
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+static DEFINE_IDR(icc_idr);
+static LIST_HEAD(icc_provider_list);
+static DEFINE_MUTEX(icc_lock);
+
+/**
+ * struct icc_req - constraints that are attached to each node
+ *
+ * @req_node: entry in list of requests for the particular @node
+ * @node: the interconnect node to which this constraint applies
+ * @dev: reference to the device that sets the constraints
+ * @avg_bw: an integer describing the average bandwidth in kbps
+ * @peak_bw: an integer describing the peak bandwidth in kbps
+ */
+struct icc_req {
+	struct hlist_node req_node;
+	struct icc_node *node;
+	struct device *dev;
+	u32 avg_bw;
+	u32 peak_bw;
+};
+
+/**
+ * struct icc_path - interconnect path structure
+ * @num_nodes: number of hops (nodes)
+ * @reqs: array of the requests applicable to this path of nodes
+ */
+struct icc_path {
+	size_t num_nodes;
+	struct icc_req reqs[0];
+};
+
+static struct icc_node *node_find(const int id)
+{
+	struct icc_node *node;
+
+	mutex_lock(&icc_lock);
+	node = idr_find(&icc_idr, id);
+	mutex_unlock(&icc_lock);
+
+	return node;
+}
+
+static struct icc_path *path_allocate(struct icc_node *dst, ssize_t num_nodes)
+{
+	struct icc_node *node = dst;
+	struct icc_path *path;
+	size_t i;
+
+	path = kzalloc(sizeof(*path) + num_nodes * sizeof(*path->reqs),
+		       GFP_KERNEL);
+	if (!path)
+		return ERR_PTR(-ENOMEM);
+
+	path->num_nodes = num_nodes;
+
+	for (i = 0; i < num_nodes; i++) {
+		hlist_add_head(&path->reqs[i].req_node, &node->req_list);
+
+		path->reqs[i].node = node;
+		/* reference to previous node was saved during path traversal */
+		node = node->reverse;
+	}
+
+	return path;
+}
+
+static struct icc_path *path_find(struct device *dev, struct icc_node *src,
+				  struct icc_node *dst)
+{
+	struct icc_node *n, *node = NULL;
+	struct icc_provider *provider;
+	struct list_head traverse_list;
+	struct list_head edge_list;
+	struct list_head visited_list;
+	size_t i, depth = 0;
+	bool found = false;
+	int ret = -EPROBE_DEFER;
+
+	INIT_LIST_HEAD(&traverse_list);
+	INIT_LIST_HEAD(&edge_list);
+	INIT_LIST_HEAD(&visited_list);
+
+	list_add_tail(&src->search_list, &traverse_list);
+	src->reverse = NULL;
+
+	do {
+		list_for_each_entry_safe(node, n, &traverse_list, search_list) {
+			if (node == dst) {
+				found = true;
+				list_add(&node->search_list, &visited_list);
+				break;
+			}
+			for (i = 0; i < node->num_links; i++) {
+				struct icc_node *tmp = node->links[i];
+
+				if (!tmp) {
+					ret = -ENOENT;
+					goto out;
+				}
+
+				if (tmp->is_traversed)
+					continue;
+
+				tmp->is_traversed = true;
+				tmp->reverse = node;
+				list_add(&tmp->search_list, &edge_list);
+			}
+		}
+		if (found)
+			break;
+
+		list_splice_init(&traverse_list, &visited_list);
+		list_splice_init(&edge_list, &traverse_list);
+
+		/* count the hops away from the source */
+		depth++;
+
+	} while (!list_empty(&traverse_list));
+
+out:
+	/* reset the traversed state */
+	list_for_each_entry(provider, &icc_provider_list, provider_list) {
+		list_for_each_entry(n, &provider->nodes, node_list)
+			if (n->is_traversed)
+				n->is_traversed = false;
+	}
+
+	if (found) {
+		struct icc_path *path = path_allocate(dst, depth);
+
+		if (IS_ERR(path))
+			return path;
+
+		/* initialize the path */
+		for (i = 0; i < path->num_nodes; i++) {
+			node = path->reqs[i].node;
+			path->reqs[i].dev = dev;
+			node->provider->users++;
+		}
+		return path;
+	}
+
+	return ERR_PTR(ret);
+}
+
+/*
+ * We want the path to honor all bandwidth requests, so the average
+ * bandwidth requirements from each consumer are aggregated at each node
+ * and provider level. By default the average bandwidth is the sum of all
+ * averages and the peak will be the highest of all peak bandwidth requests.
+ */
+
+static int aggregate_requests(struct icc_node *node)
+{
+	struct icc_provider *p = node->provider;
+	struct icc_req *r;
+
+	node->avg_bw = 0;
+	node->peak_bw = 0;
+
+	hlist_for_each_entry(r, &node->req_list, req_node)
+		p->aggregate(node, r->avg_bw, r->peak_bw,
+			     &node->avg_bw, &node->peak_bw);
+
+	return 0;
+}
+
+static void aggregate_provider(struct icc_provider *p)
+{
+	struct icc_node *n;
+
+	p->avg_bw = 0;
+	p->peak_bw = 0;
+
+	list_for_each_entry(n, &p->nodes, node_list)
+		p->aggregate(n, n->avg_bw, n->peak_bw,
+			     &p->avg_bw, &p->peak_bw);
+}
+
+static int apply_constraints(struct icc_path *path)
+{
+	struct icc_node *next, *prev = NULL;
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < path->num_nodes; i++, prev = next) {
+		struct icc_provider *p;
+
+		next = path->reqs[i].node;
+		/*
+		 * Both endpoints should be valid master-slave pairs of the
+		 * same interconnect provider that will be configured.
+		 */
+		if (!prev || next->provider != prev->provider)
+			continue;
+
+		p = next->provider;
+
+		aggregate_provider(p);
+
+		if (p->set) {
+			/* set the constraints */
+			ret = p->set(prev, next, p->avg_bw, p->peak_bw);
+		}
+
+		if (ret)
+			goto out;
+	}
+out:
+	return ret;
+}
+
+/**
+ * icc_set() - set constraints on an interconnect path between two endpoints
+ * @path: reference to the path returned by icc_get()
+ * @avg_bw: average bandwidth in kbps
+ * @peak_bw: peak bandwidth in kbps
+ *
+ * This function is used by an interconnect consumer to express its own needs
+ * in terms of bandwidth for a previously requested path between two endpoints.
+ * The requests are aggregated and each node is updated accordingly. The entire
+ * path is locked by a mutex to ensure that the set() is completed.
+ * The @path can be NULL when the "interconnects" DT properties is missing,
+ * which will mean that no constraints will be set.
+ *
+ * Returns 0 on success, or an appropriate error code otherwise.
+ */
+int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
+{
+	struct icc_node *node;
+	struct icc_provider *p;
+	size_t i;
+	int ret = 0;
+
+	if (!path)
+		return 0;
+
+	mutex_lock(&icc_lock);
+
+	for (i = 0; i < path->num_nodes; i++) {
+		node = path->reqs[i].node;
+		p = node->provider;
+
+		/* update the consumer request for this path */
+		path->reqs[i].avg_bw = avg_bw;
+		path->reqs[i].peak_bw = peak_bw;
+
+		/* aggregate requests for this node */
+		aggregate_requests(node);
+	}
+
+	ret = apply_constraints(path);
+	if (ret)
+		pr_err("interconnect: error applying constraints (%d)", ret);
+
+	mutex_unlock(&icc_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(icc_set);
+
+/**
+ * icc_get() - return a handle for path between two endpoints
+ * @dev: the device requesting the path
+ * @src_id: source device port id
+ * @dst_id: destination device port id
+ *
+ * This function will search for a path between two endpoints and return an
+ * icc_path handle on success. Use icc_put() to release
+ * constraints when the they are not needed anymore.
+ *
+ * Return: icc_path pointer on success, or ERR_PTR() on error
+ */
+struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
+{
+	struct icc_node *src, *dst;
+	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
+
+	src = node_find(src_id);
+	if (!src) {
+		dev_err(dev, "%s: invalid src=%d\n", __func__, src_id);
+		goto out;
+	}
+
+	dst = node_find(dst_id);
+	if (!dst) {
+		dev_err(dev, "%s: invalid dst=%d\n", __func__, dst_id);
+		goto out;
+	}
+
+	mutex_lock(&icc_lock);
+	path = path_find(dev, src, dst);
+	mutex_unlock(&icc_lock);
+	if (IS_ERR(path)) {
+		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
+		goto out;
+	}
+
+out:
+	return path;
+}
+EXPORT_SYMBOL_GPL(icc_get);
+
+/**
+ * icc_put() - release the reference to the icc_path
+ * @path: interconnect path
+ *
+ * Use this function to release the constraints on a path when the path is
+ * no longer needed. The constraints will be re-aggregated.
+ */
+void icc_put(struct icc_path *path)
+{
+	struct icc_node *node;
+	size_t i;
+	int ret;
+
+	if (!path || WARN_ON_ONCE(IS_ERR(path)))
+		return;
+
+	ret = icc_set(path, 0, 0);
+	if (ret)
+		pr_err("%s: error (%d)\n", __func__, ret);
+
+	mutex_lock(&icc_lock);
+	for (i = 0; i < path->num_nodes; i++) {
+		node = path->reqs[i].node;
+		hlist_del(&path->reqs[i].req_node);
+
+		node->provider->users--;
+	}
+	mutex_unlock(&icc_lock);
+
+	kfree(path);
+}
+EXPORT_SYMBOL_GPL(icc_put);
+
+/**
+ * icc_node_create() - create a node
+ * @id: node id
+ *
+ * Return: icc_node pointer on success, or ERR_PTR() on error
+ */
+struct icc_node *icc_node_create(int id)
+{
+	struct icc_node *node;
+
+	/* check if node already exists */
+	node = node_find(id);
+	if (node)
+		goto out;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node) {
+		node = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	mutex_lock(&icc_lock);
+
+	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
+	if (WARN(id < 0, "couldn't get idr")) {
+		node = ERR_PTR(id);
+		goto out;
+	}
+
+	node->id = id;
+
+out:
+	mutex_unlock(&icc_lock);
+
+	return node;
+}
+EXPORT_SYMBOL_GPL(icc_node_create);
+
+/**
+ * icc_node_remove() - remove a node
+ * @id: node id
+ *
+ */
+void icc_node_remove(int id)
+{
+	struct icc_node *node;
+
+	node = node_find(id);
+	if (node) {
+		mutex_lock(&icc_lock);
+		idr_remove(&icc_idr, node->id);
+		mutex_unlock(&icc_lock);
+	}
+
+	kfree(node);
+}
+EXPORT_SYMBOL_GPL(icc_node_remove);
+
+/**
+ * icc_link_create() - create a link between two nodes
+ * @src_id: source node id
+ * @dst_id: destination node id
+ *
+ * Create a link between two nodes. The nodes might belong to different
+ * interconnect providers and the @dst_id node might not exist (if the
+ * provider driver has not probed yet). So just create the @dst_id node
+ * and when the actual provider driver is probed, the rest of the node
+ * data is filled.
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int icc_link_create(struct icc_node *node, const int dst_id)
+{
+	struct icc_node *dst;
+	struct icc_node **new;
+	int ret = 0;
+
+	if (!node->provider)
+		return -EINVAL;
+
+	dst = node_find(dst_id);
+	if (!dst) {
+		dst = icc_node_create(dst_id);
+
+		if (IS_ERR(dst)) {
+			ret = PTR_ERR(dst);
+			goto out;
+		}
+	}
+
+	mutex_lock(&icc_lock);
+
+	new = krealloc(node->links,
+		       (node->num_links + 1) * sizeof(*node->links),
+		       GFP_KERNEL);
+	if (!new) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	node->links = new;
+	node->links[node->num_links++] = dst;
+
+out:
+	mutex_unlock(&icc_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(icc_link_create);
+
+/**
+ * icc_link_remove() - remove a link between two nodes
+ * @src: pointer to source node
+ * @dst: pointer to destination node
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int icc_link_remove(struct icc_node *src, struct icc_node *dst)
+{
+	struct icc_node **new;
+	int ret = 0;
+	int i, j;
+
+	if (IS_ERR_OR_NULL(src))
+		return PTR_ERR(src);
+
+	if (IS_ERR_OR_NULL(dst))
+		return PTR_ERR(dst);
+
+	mutex_lock(&icc_lock);
+
+	new = krealloc(src->links,
+		       (src->num_links - 1) * sizeof(*src->links),
+		       GFP_KERNEL);
+	if (!new) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0, j = 0; j < src->num_links; j++) {
+		if (src->links[j] == dst)
+			continue;
+
+		new[i++] = src->links[j];
+	}
+
+	src->links = new;
+	src->num_links--;
+
+out:
+	mutex_unlock(&icc_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(icc_link_remove);
+
+/**
+ * icc_node_add() - add an interconnect node to interconnect provider
+ * @node: pointer to the interconnect node
+ * @provider: pointer to the interconnect provider
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int icc_node_add(struct icc_node *node, struct icc_provider *provider)
+{
+	mutex_lock(&icc_lock);
+
+	node->provider = provider;
+	list_add(&node->node_list, &provider->nodes);
+
+	mutex_unlock(&icc_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(icc_node_add);
+
+/**
+ * icc_provider_add() - add a new interconnect provider
+ * @icc_provider: the interconnect provider that will be added into topology
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int icc_provider_add(struct icc_provider *provider)
+{
+	if (WARN_ON(!provider->set))
+		return -EINVAL;
+
+	mutex_init(&icc_lock);
+
+	INIT_LIST_HEAD(&provider->nodes);
+	list_add(&provider->provider_list, &icc_provider_list);
+
+	mutex_unlock(&icc_lock);
+
+	dev_dbg(provider->dev, "interconnect provider added to topology\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(icc_provider_add);
+
+/**
+ * icc_provider_del() - delete previously added interconnect provider
+ * @icc_provider: the interconnect provider that will be removed from topology
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int icc_provider_del(struct icc_provider *provider)
+{
+	mutex_lock(&icc_lock);
+	if (provider->users) {
+		pr_warn("interconnect provider still has %d users\n",
+			provider->users);
+		mutex_unlock(&icc_lock);
+		return -EBUSY;
+	}
+
+	if (!list_empty_careful(&provider->nodes)) {
+		pr_warn("interconnect provider still has nodes\n");
+		mutex_unlock(&icc_lock);
+		return -EEXIST;
+	}
+
+	list_del(&provider->provider_list);
+	mutex_unlock(&icc_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(icc_provider_del);
+
+MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org");
+MODULE_DESCRIPTION("Interconnect Driver Core");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
new file mode 100644
index 000000000000..f4613c6dce4f
--- /dev/null
+++ b/include/linux/interconnect-provider.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef _LINUX_INTERCONNECT_PROVIDER_H
+#define _LINUX_INTERCONNECT_PROVIDER_H
+
+#include <linux/interconnect.h>
+
+#define icc_units_to_bps(bw)  ((bw) * 1000ULL)
+
+struct icc_node;
+
+/**
+ * struct icc_provider - interconnect provider (controller) entity that might
+ * provide multiple interconnect controls
+ *
+ * @provider_list: list of the registered interconnect providers
+ * @nodes: internal list of the interconnect provider nodes
+ * @set: pointer to device specific set operation function
+ * @aggregate: pointer to device specific aggregate operation function
+ * @dev: the device this interconnect provider belongs to
+ * @users: count of active users
+ * @avg_bw: aggregated value of average bandwidth requests from all nodes
+ * @peak_bw: aggregated value of peak bandwidth requests from all nodes
+ * @data: pointer to private data
+ */
+struct icc_provider {
+	struct list_head	provider_list;
+	struct list_head	nodes;
+	int (*set)(struct icc_node *src, struct icc_node *dst,
+		   u32 avg_bw, u32 peak_bw);
+	int (*aggregate)(struct icc_node *node, u32 avg_bw, u32 peak_bw,
+			 u32 *agg_avg, u32 *agg_peak);
+	struct device		*dev;
+	int			users;
+	u32			avg_bw;
+	u32			peak_bw;
+	void			*data;
+};
+
+/**
+ * struct icc_node - entity that is part of the interconnect topology
+ *
+ * @id: platform specific node id
+ * @name: node name used in debugfs
+ * @links: a list of targets pointing to where we can go next when traversing
+ * @num_links: number of links to other interconnect nodes
+ * @provider: points to the interconnect provider of this node
+ * @node_list: the list entry in the parent provider's "nodes" list
+ * @search_list: list used when walking the nodes graph
+ * @reverse: pointer to previous node when walking the nodes graph
+ * @is_traversed: flag that is used when walking the nodes graph
+ * @req_list: a list of QoS constraint requests associated with this node
+ * @avg_bw: aggregated value of average bandwidth requests from all consumers
+ * @peak_bw: aggregated value of peak bandwidth requests from all consumers
+ * @data: pointer to private data
+ */
+struct icc_node {
+	int			id;
+	const char              *name;
+	struct icc_node		**links;
+	size_t			num_links;
+
+	struct icc_provider	*provider;
+	struct list_head	node_list;
+	struct list_head	orphan_list;
+	struct list_head	search_list;
+	struct icc_node		*reverse;
+	bool			is_traversed;
+	struct hlist_head	req_list;
+	u32			avg_bw;
+	u32			peak_bw;
+	void			*data;
+};
+
+#if IS_ENABLED(CONFIG_INTERCONNECT)
+
+struct icc_node *icc_node_create(int id);
+void icc_node_remove(int id);
+int icc_link_create(struct icc_node *node, const int dst_id);
+int icc_link_remove(struct icc_node *src, struct icc_node *dst);
+int icc_node_add(struct icc_node *node, struct icc_provider *provider);
+int icc_provider_add(struct icc_provider *provider);
+int icc_provider_del(struct icc_provider *provider);
+
+#else
+
+static inline struct icc_node *icc_node_create(int id)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+void icc_node_remove(int id)
+{
+}
+
+static inline int icc_link_create(struct icc_node *node, const int dst_id)
+{
+	return -ENOTSUPP;
+}
+
+int icc_link_remove(struct icc_node *src, struct icc_node *dst)
+{
+	return -ENOTSUPP;
+}
+
+int icc_node_add(struct icc_node *node, struct icc_provider *provider)
+{
+	return -ENOTSUPP;
+}
+
+static inline int icc_provider_add(struct icc_provider *provider)
+{
+	return -ENOTSUPP;
+}
+
+static inline int icc_provider_del(struct icc_provider *provider)
+{
+	return -ENOTSUPP;
+}
+
+#endif /* CONFIG_INTERCONNECT */
+
+#endif /* _LINUX_INTERCONNECT_PROVIDER_H */
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
new file mode 100644
index 000000000000..593215371fd6
--- /dev/null
+++ b/include/linux/interconnect.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef _LINUX_INTERCONNECT_H
+#define _LINUX_INTERCONNECT_H
+
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+struct icc_path;
+struct device;
+
+#if IS_ENABLED(CONFIG_INTERCONNECT)
+
+struct icc_path *icc_get(struct device *dev, const int src_id,
+			 const int dst_id);
+void icc_put(struct icc_path *path);
+int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
+
+#else
+
+static inline struct icc_path *icc_get(struct device *dev, const int src_id,
+				       const int dst_id)
+{
+	return NULL;
+}
+
+static inline void icc_put(struct icc_path *path)
+{
+}
+
+static inline int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
+{
+	return 0;
+}
+
+#endif /* CONFIG_INTERCONNECT */
+
+#endif /* _LINUX_INTERCONNECT_H */
