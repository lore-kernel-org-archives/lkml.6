Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813E2C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E6027B25
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kp828VCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E6027B25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754805AbeF2GUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:20:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39879 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754588AbeF2GUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:20:14 -0400
Received: by mail-pl0-f66.google.com with SMTP id s24-v6so3958848plq.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 23:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1AfuWlMOVWU1Vhlp0o/mTCtZRMnjimj2uS0MvsxSa7A=;
        b=Kp828VCDMiy5+Qwo7n9aaeY72R7ikkaQv2SAoEzU6Zj6hqvNhflClNUi0zR5e8KQZn
         4a10pqF7P19/HI7tX8LwIs/ssdiQxB6EfFCWAJ+4u6ueJnZCFRhLFJPp6QOFUPgNKlNs
         65cf4MF3XDQ57wz7YwqTBpNFKqOmAMfpLxoJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1AfuWlMOVWU1Vhlp0o/mTCtZRMnjimj2uS0MvsxSa7A=;
        b=bWGivOiRMsxfvXKuJWbmHfNneGNXbreB/xFEeXv9P4sJvbBgxSwmBvTfIIaN61X9Qr
         SnUEh++DDXP35jUvXO0bPXVTyie07urUHAhT1qO8l5ocFREQjhXxzpWlsIYYRqHeCYQD
         Upk6Zgijh/bMzOyjlhQ5GFQ34sFdpgODbhxya0ILao7btmwYa9jplw5cgVraHqiWu9Py
         z0Y+yPqEmf+bWbsp0eQ0Nn4UF5TRIplFBlJAu25xLn07e9X65UhIiV6BVqSkIaSrHE1j
         07XTbbQUPawQuN2fmnxEoL2/fl69PTH7GPxew84FTGu/msGpmnYmpBFecPDlJFDXrkAz
         wR+w==
X-Gm-Message-State: APt69E1Bj23qQI4kcuO09hivFUhSaHQzQxUokt3NRYeuYD2XoreHOIsL
        gAsSr8uavBljLQ/pJCvQpzcSrA==
X-Google-Smtp-Source: ADUXVKLJFoVL08SyPcN19KiYHg77Aplm3AczHJZ2kEW9+UBJz2bV9RJrW5mo2tv+C3cu5aGPZOvQnA==
X-Received: by 2002:a17:902:1007:: with SMTP id b7-v6mr13335305pla.277.1530253213695;
        Thu, 28 Jun 2018 23:20:13 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id m5-v6sm12709679pgn.45.2018.06.28.23.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 23:20:13 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] OPP: Add dev_pm_opp_{set|put}_required_device() helper
Date:   Fri, 29 Jun 2018 11:49:36 +0530
Message-Id: <282ac8092650c95595c84213dc87a4bf6b278da8.1530252803.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple generic power domains for a device are supported with the help
of virtual devices, which are created for each device-genpd pair. These
are the device structures which are attached to the power domain and are
required by the OPP core to set the performance state of the genpd.

The helpers added by this commit are required to be called once for each
genpd of a device. These are required only if multiple domains are
present for a device, otherwise the actual device structure will be used
instead by the OPP core.

This commit also updates the genpd core to automatically call the new
helper to set the required devices with the OPP layer, whenever the
virtual devices are created for multiple genpd. The prototype of
__genpd_dev_pm_attach() is slightly updated for this.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 31 ++++++++++++++---
 drivers/opp/core.c          | 69 +++++++++++++++++++++++++++++++++++++
 drivers/opp/of.c            | 12 +++++++
 drivers/opp/opp.h           |  2 ++
 include/linux/pm_opp.h      |  8 +++++
 5 files changed, 118 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index c298de8a8308..e9c85c96580c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2219,8 +2219,14 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 	genpd_queue_power_off_work(pd);
 
 	/* Unregister the device if it was created by genpd. */
-	if (dev->bus == &genpd_bus_type)
+	if (dev->bus == &genpd_bus_type) {
+		struct opp_table *opp_table = dev_get_drvdata(dev);
+
+		if (opp_table)
+			dev_pm_opp_put_required_device(opp_table, dev);
+
 		device_unregister(dev);
+	}
 }
 
 static void genpd_dev_pm_sync(struct device *dev)
@@ -2235,7 +2241,8 @@ static void genpd_dev_pm_sync(struct device *dev)
 }
 
 static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
-				 unsigned int index)
+				 unsigned int index,
+				 struct generic_pm_domain **pd_ptr)
 {
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
@@ -2277,6 +2284,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
 
 	if (ret)
 		genpd_remove_device(pd, dev);
+	else if (pd_ptr)
+		*pd_ptr = pd;
 
 	return ret ? -EPROBE_DEFER : 1;
 }
@@ -2307,7 +2316,7 @@ int genpd_dev_pm_attach(struct device *dev)
 				       "#power-domain-cells") != 1)
 		return 0;
 
-	return __genpd_dev_pm_attach(dev, dev->of_node, 0);
+	return __genpd_dev_pm_attach(dev, dev->of_node, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 
@@ -2330,6 +2339,7 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index)
 {
+	struct generic_pm_domain *pd;
 	struct device *genpd_dev;
 	int num_domains;
 	int ret;
@@ -2359,12 +2369,25 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	}
 
 	/* Try to attach the device to the PM domain at the specified index. */
-	ret = __genpd_dev_pm_attach(genpd_dev, dev->of_node, index);
+	ret = __genpd_dev_pm_attach(genpd_dev, dev->of_node, index, &pd);
 	if (ret < 1) {
 		device_unregister(genpd_dev);
 		return ret ? ERR_PTR(ret) : NULL;
 	}
 
+	if (pd->set_performance_state) {
+		struct opp_table *opp_table;
+
+		opp_table = dev_pm_opp_set_required_device(dev, genpd_dev,
+							   index);
+		if (IS_ERR(opp_table)) {
+			genpd_dev_pm_detach(genpd_dev, true);
+			return ERR_CAST(opp_table);
+		}
+
+		dev_set_drvdata(genpd_dev, opp_table);
+	}
+
 	pm_runtime_set_active(genpd_dev);
 	pm_runtime_enable(genpd_dev);
 
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index acc34c238fd6..3a2f08c56c4e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1532,6 +1532,75 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_set_opp_helper);
 
+/**
+ * dev_pm_opp_set_required_device - Set required device for an index
+ * @dev: Device for which the required device is getting set.
+ * @required_dev: required device.
+ * @index: index for which the required device is getting added.
+ *
+ * Multiple generic power domains for a device are supported with the help of
+ * virtual devices, which are created for each dev-genpd pair. These are the
+ * device structures which are attached to the power domain and are required by
+ * the OPP core to set the performance state of the genpd.
+ *
+ * This helper needs to be called once for each genpd of a device, but only if
+ * multiple domains are present for a device. Otherwise the original device
+ * structure will be used instead by the OPP core.
+ */
+struct opp_table *dev_pm_opp_set_required_device(struct device *dev,
+						 struct device *required_dev,
+						 int index)
+{
+	struct opp_table *opp_table;
+
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	if (!opp_table)
+		return ERR_PTR(-ENOMEM);
+
+	/* Make sure there are no concurrent readers while updating opp_table */
+	WARN_ON(!list_empty(&opp_table->opp_list));
+
+	if (unlikely(!opp_table->required_devices ||
+		     index >= opp_table->required_opp_count ||
+		     opp_table->required_devices[index])) {
+		dev_err(dev, "Invalid request to set required device\n");
+		dev_pm_opp_put_opp_table(opp_table);
+		return ERR_PTR(-EINVAL);
+	}
+
+	opp_table->required_devices[index] = required_dev;
+
+	return opp_table;
+}
+
+/**
+ * dev_pm_opp_put_required_device() - Releases resources blocked for required device.
+ * @opp_table: OPP table returned by dev_pm_opp_set_required_device().
+ * @required_dev: required device.
+ *
+ * This releases the resource previously acquired with a call to
+ * dev_pm_opp_set_required_device().
+ */
+void dev_pm_opp_put_required_device(struct opp_table *opp_table,
+				    struct device *required_dev)
+{
+	int i;
+
+	/* Make sure there are no concurrent readers while updating opp_table */
+	WARN_ON(!list_empty(&opp_table->opp_list));
+
+	for (i = 0; i < opp_table->required_opp_count; i++) {
+		if (opp_table->required_devices[i] != required_dev)
+			continue;
+
+		opp_table->required_devices[i] = NULL;
+		dev_pm_opp_put_opp_table(opp_table);
+		return;
+	}
+
+	dev_err(required_dev, "Failed to find required device entry\n");
+}
+
 /**
  * dev_pm_opp_add()  - Add an OPP table from a table definitions
  * @dev:	device for which we do this operation
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index ffefccfdbc26..20baba090c17 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -133,6 +133,7 @@ static struct opp_table *_get_required_opp_table(struct device_node *np)
 static void _opp_table_free_required_tables(struct opp_table *opp_table)
 {
 	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
+	struct device **required_devices = opp_table->required_devices;
 	int i;
 
 	if (!required_opp_tables)
@@ -146,8 +147,10 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
 	}
 
 	kfree(required_opp_tables);
+	kfree(required_devices);
 
 	opp_table->required_opp_count = 0;
+	opp_table->required_devices = NULL;
 	opp_table->required_opp_tables = NULL;
 }
 
@@ -159,6 +162,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 					     struct device *dev,
 					     struct device_node *opp_np)
 {
+	struct device **required_devices = NULL;
 	struct opp_table **required_opp_tables;
 	struct device_node *required_np, *np;
 	int count, i;
@@ -174,11 +178,19 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	if (!count)
 		goto put_np;
 
+	if (count > 1) {
+		required_devices = kcalloc(count, sizeof(*required_devices),
+					   GFP_KERNEL);
+		if (!required_devices)
+			goto put_np;
+	}
+
 	required_opp_tables = kcalloc(count, sizeof(*required_opp_tables),
 				      GFP_KERNEL);
 	if (!required_opp_tables)
 		goto put_np;
 
+	opp_table->required_devices = required_devices;
 	opp_table->required_opp_tables = required_opp_tables;
 	opp_table->required_opp_count = count;
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 9efdc3e4840c..857a7f5e66d0 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -133,6 +133,7 @@ enum opp_table_access {
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @shared_opp: OPP is shared between multiple devices.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
+ * @required_devices: List of virtual devices for multiple genpd support.
  * @required_opp_tables: List of device OPP tables that are required by OPPs in
  *		this table.
  * @required_opp_count: Number of required devices.
@@ -173,6 +174,7 @@ struct opp_table {
 	enum opp_table_access shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
+	struct device **required_devices;
 	struct opp_table **required_opp_tables;
 	unsigned int required_opp_count;
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 099b31960dec..ffdb4a78edec 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -125,6 +125,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
+struct opp_table *dev_pm_opp_set_required_device(struct device *dev, struct device *required_dev, int index);
+void dev_pm_opp_put_required_device(struct opp_table *opp_table, struct device *required_device);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -266,6 +268,12 @@ static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const
 
 static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
 
+static inline struct opp_table *dev_pm_opp_set_required_device(struct device *dev, struct device *required_dev, int index)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline void dev_pm_opp_put_required_device(struct opp_table *opp_table, struct device *required_device) {}
 static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	return -ENOTSUPP;
-- 
2.18.0.rc1.242.g61856ae69a2c

