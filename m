Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1534FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2C027B28
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y6Cb3Gb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2C027B28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754945AbeF2GU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:20:27 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46470 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754851AbeF2GUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:20:22 -0400
Received: by mail-pg0-f66.google.com with SMTP id q14-v6so3529486pgt.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 23:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7HdC+3C2V6gtOSdBSxnueYDMAQcAswZVENc9D7squtE=;
        b=Y6Cb3Gb4VgKHPO+6QwCV45OlfZFgaw+QL/dC1wzweOv7qT+CfDUmWotTJvkUHV4PeF
         SRJ3vU2M7gUSzZYy+Vf6XuW3Xn8Q/fTLOEg7IUsAOmhVl6XO4EqJWgAjDPHnMuGHtlre
         cXoYhht82zk4Yzos5w8wqjBAgKfGfuMSaOykY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7HdC+3C2V6gtOSdBSxnueYDMAQcAswZVENc9D7squtE=;
        b=AwSL4rjGw2UEyYhWkEIvBE287xO7qXFhCf+aqxqnOpKuvqT/QknJbZskWYubXFafrd
         Makkrk9l8Bv3Pe8MpPf3z93nYltCiW3K8F4Luk6DfJu4m0NksVHOuD9nv+ALe0i34XBN
         /MS70h3AsIb6hAODh11vYEMoB8yPtUTo+raj6Hhm9W6UgXU6MkAI5Bu/h/0jvYQqZlKj
         0PMLRX6GB3Gwm/x+8IUudIZWm9F2KkgLetR6yHsUT0yiHkqhGIG1l4v2Z/P08AV39R1Y
         8YdsdQWSQetKZIzSuxSJKLZP9asLK0R8ZR/Y8+3PZcBlBFgPFeShjTYEPW3lVopqdYNL
         p/mA==
X-Gm-Message-State: APt69E2uswJWwV6L2gvX6igB7NCNTmd7vkrYQF4eK7j8+MNxngRTjQNk
        RE8A6ocUmj9coCJGpYvFOs4HFw==
X-Google-Smtp-Source: ADUXVKKseV63PqaEQfUfp1d6fi5VThcISY850IY5LZFj3knn+zM4gEadi50sO2I+WyPe7h91jDT7KA==
X-Received: by 2002:a65:4841:: with SMTP id i1-v6mr11249431pgs.75.1530253222241;
        Thu, 28 Jun 2018 23:20:22 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id f7-v6sm1980230pfj.101.2018.06.28.23.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 23:20:21 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] OPP: Rename and relocate of_genpd_opp_to_performance_state()
Date:   Fri, 29 Jun 2018 11:49:39 +0530
Message-Id: <9dddd2b291fcdf8eee7d95ca4346d9b3e4228e43.1530252803.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP core already has the performance state values for each of the
genpd's OPPs and there is no need to call the genpd callback again to
get the performance state for the case where the end device doesn't have
an OPP table and has the "required-opps" property directly in its node.

This commit renames of_get_required_opp_performance_state() as
of_get_required_opp_performance_state() and moves it to the OPP core, as
it is all about OPP stuff now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 48 ------------------------------------
 drivers/opp/of.c            | 49 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  9 -------
 include/linux/pm_opp.h      |  5 ++++
 4 files changed, 54 insertions(+), 57 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 15ffac081b0e..4b6acaac6ab9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2544,54 +2544,6 @@ unsigned int genpd_opp_to_performance_state(struct device *genpd_dev,
 }
 EXPORT_SYMBOL_GPL(genpd_opp_to_performance_state);
 
-/**
- * of_genpd_opp_to_performance_state- Gets performance state of device's
- * power domain corresponding to a DT node's "required-opps" property.
- *
- * @dev: Device for which the performance-state needs to be found.
- * @np: DT node where the "required-opps" property is present. This can be
- *	the device node itself (if it doesn't have an OPP table) or a node
- *	within the OPP table of a device (if device has an OPP table).
- *
- * Returns performance state corresponding to the "required-opps" property of
- * a DT node. This calls platform specific genpd->opp_to_performance_state()
- * callback to translate power domain OPP to performance state.
- *
- * Returns performance state on success and 0 on failure.
- */
-unsigned int of_genpd_opp_to_performance_state(struct device *dev,
-					       struct device_node *np)
-{
-	struct generic_pm_domain *genpd;
-	struct dev_pm_opp *opp;
-	int state = 0;
-
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return 0;
-
-	if (unlikely(!genpd->set_performance_state))
-		return 0;
-
-	genpd_lock(genpd);
-
-	opp = of_dev_pm_opp_find_required_opp(&genpd->dev, np);
-	if (IS_ERR(opp)) {
-		dev_err(dev, "Failed to find required OPP: %ld\n",
-			PTR_ERR(opp));
-		goto unlock;
-	}
-
-	state = genpd->opp_to_performance_state(genpd, opp);
-	dev_pm_opp_put(opp);
-
-unlock:
-	genpd_unlock(genpd);
-
-	return state;
-}
-EXPORT_SYMBOL_GPL(of_genpd_opp_to_performance_state);
-
 static int __init genpd_bus_init(void)
 {
 	return bus_register(&genpd_bus_type);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e1e4a58dd748..80fdeab4364a 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -964,6 +964,55 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
 
+/**
+ * of_get_required_opp_performance_state() - Search for required OPP and return its performance state.
+ * @np: Node that contains the "required-opps" property.
+ * @index: Index of the phandle to parse.
+ *
+ * Returns the performance state of the OPP pointed out by the "required-opps"
+ * property at @index in @np.
+ *
+ * Return: Positive performance state on success, otherwise 0 on errors.
+ */
+unsigned int of_get_required_opp_performance_state(struct device_node *np,
+						   int index)
+{
+	struct dev_pm_opp *opp;
+	struct device_node *required_np;
+	struct opp_table *opp_table;
+	unsigned int pstate = 0;
+
+	required_np = of_parse_required_opp(np, index);
+	if (!required_np)
+		return -ENODEV;
+
+	opp_table = _get_required_opp_table(required_np);
+	if (IS_ERR(opp_table)) {
+		pr_err("%s: Failed to find required OPP table %pOF: %ld\n",
+		       __func__, np, PTR_ERR(opp_table));
+		goto put_required_np;
+	}
+
+	mutex_lock(&opp_table->lock);
+
+	list_for_each_entry(opp, &opp_table->opp_list, node) {
+		if (opp->np == required_np) {
+			pstate = opp->pstate;
+			break;
+		}
+	}
+
+	mutex_unlock(&opp_table->lock);
+
+	dev_pm_opp_put_opp_table(opp_table);
+
+put_required_np:
+	of_node_put(required_np);
+
+	return pstate;
+}
+EXPORT_SYMBOL_GPL(of_get_required_opp_performance_state);
+
 /**
  * of_dev_pm_opp_find_required_opp() - Search for required OPP.
  * @dev: The device whose OPP node is referenced by the 'np' DT node.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b3c5f1eaf16c..685f982d56e4 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -235,8 +235,6 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
 unsigned int genpd_opp_to_performance_state(struct device *genpd_dev,
 					    struct dev_pm_opp *opp);
-unsigned int of_genpd_opp_to_performance_state(struct device *dev,
-				struct device_node *np);
 
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
@@ -280,13 +278,6 @@ genpd_opp_to_performance_state(struct device *genpd_dev, struct dev_pm_opp *opp)
 	return 0;
 }
 
-static inline unsigned int
-of_genpd_opp_to_performance_state(struct device *dev,
-				  struct device_node *np)
-{
-	return 0;
-}
-
 static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return 0;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index ffdb4a78edec..6d6b1febe068 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -309,6 +309,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev, struct device_node *np);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
+unsigned int of_get_required_opp_performance_state(struct device_node *np, int index);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -351,6 +352,10 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 {
 	return NULL;
 }
+static inline unsigned int of_get_required_opp_performance_state(struct device_node *np, int index)
+{
+	return 0;
+}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */
-- 
2.18.0.rc1.242.g61856ae69a2c

