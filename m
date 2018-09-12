Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1269C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCE320880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h26DAAA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCE320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeILNdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:33:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45010 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbeILNdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:33:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so637464pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Stjj/H9G3aXswDY/tKzqdma60cnAtlbZCxqe7sSqXuo=;
        b=h26DAAA1KuZS4qxlQp1c06/J7D11gwkLjpO5IZ+V47qLkzzVGGg/NtOqBBPF3/XAu0
         TkJXAnD6TDDlIC+fhtatYNezOH36RyotbwbhFKCb60Cbn5zkM2mKZuzBvr9wKZPoPUVc
         92Hj8ROTApXI8drMzT1AVbgMYX9mGqB6XrLow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Stjj/H9G3aXswDY/tKzqdma60cnAtlbZCxqe7sSqXuo=;
        b=TD+2GtGcj6xyuNMgRRyo7VDt41drkOtkEITyXxOmjA5guNP8N3z0VfMhsI8x1QMD07
         ItxOBhiBuY80gR8iDefrub6q+NpBeEjc8gwDz+KPhJH5KzF5E56zzaBUqok3if8dm+cg
         CYg9d8T38bKpe9XKtyaRzKyLF4oKfVMA9tABvU5KJ9oEyMzuKAJGJmzMUH+4L4fNaYSJ
         t29f0JLhtN2FnVsAgeqOLVo9JXqcVuO8BygrS2e4KLTwme0YG5LyyaAcB8dnu7EhFtzT
         hrUq2htVFLr7P1LCIjvIgFPivw+hY4cxKtLkQTmIX/lIOiZS9awpfBjhLShoA27TwoMx
         Hoew==
X-Gm-Message-State: APzg51AQmnUvcWffMgHniso7S4Ml33lDkgIv1LGQXpr5dOc+u68n2wcU
        RnGWF72vNxhV8nuuum9J60ixvA==
X-Google-Smtp-Source: ANB0VdYzTKGThD2/Im5nON/1IR/OxXIn4zNSzddOsvKYavqykl6N6W70Vv6GK7b5nYmyZ6jk6lp5Dw==
X-Received: by 2002:a63:352:: with SMTP id 79-v6mr922441pgd.112.1536741018546;
        Wed, 12 Sep 2018 01:30:18 -0700 (PDT)
Received: from localhost ([122.171.64.45])
        by smtp.gmail.com with ESMTPSA id x82-v6sm1688726pfe.129.2018.09.12.01.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 01:30:18 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     niklas.cassel@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] OPP: Prevent creating multiple OPP tables for devices sharing OPP nodes
Date:   Wed, 12 Sep 2018 13:58:49 +0530
Message-Id: <79af9cf4c4e8e4d6dd8288d013900939ab4d5855.1536736872.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1536736872.git.viresh.kumar@linaro.org>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When two or more devices are sharing their clock and voltage rails, they
share the same OPP table. But there are some corner cases where the OPP
core incorrectly creates separate OPP tables for them.

For example, CPU 0 and 1 share clock/voltage rails. The platform
specific code calls dev_pm_opp_set_regulators() for CPU0 and the OPP
core creates an OPP table for it (the individual OPPs aren't initialized
as of now). The same is repeated for CPU1 then. Because
_opp_get_opp_table() doesn't compare DT node pointers currently, it
fails to find the link between CPU0 and CPU1 and so creates a new OPP
table.

Fix this by calling _managed_opp() from _opp_get_opp_table().
_managed_opp() gain an additional argument (index) to get the right node
pointer. This resulted in simplifying code in _of_add_opp_table_v2() as
well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 25 ++++++++++++++++++++++---
 drivers/opp/of.c   | 35 +++++++++++++----------------------
 drivers/opp/opp.h  |  2 ++
 3 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d3e33fd32694..aaef20cf4df2 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -759,8 +759,8 @@ static void _remove_opp_dev(struct opp_device *opp_dev,
 	kfree(opp_dev);
 }
 
-struct opp_device *_add_opp_dev(const struct device *dev,
-				struct opp_table *opp_table)
+struct opp_device *_add_opp_dev_unlocked(const struct device *dev,
+					 struct opp_table *opp_table)
 {
 	struct opp_device *opp_dev;
 	int ret;
@@ -772,7 +772,6 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	/* Initialize opp-dev */
 	opp_dev->dev = dev;
 
-	mutex_lock(&opp_table->lock);
 	list_add(&opp_dev->node, &opp_table->dev_list);
 
 	/* Create debugfs entries for the opp_table */
@@ -780,6 +779,17 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	if (ret)
 		dev_err(dev, "%s: Failed to register opp debugfs (%d)\n",
 			__func__, ret);
+
+	return opp_dev;
+}
+
+struct opp_device *_add_opp_dev(const struct device *dev,
+				struct opp_table *opp_table)
+{
+	struct opp_device *opp_dev;
+
+	mutex_lock(&opp_table->lock);
+	opp_dev = _add_opp_dev_unlocked(dev, opp_table);
 	mutex_unlock(&opp_table->lock);
 
 	return opp_dev;
@@ -844,6 +854,15 @@ static struct opp_table *_opp_get_opp_table(struct device *dev, int index)
 	if (!IS_ERR(opp_table))
 		goto unlock;
 
+	opp_table = _managed_opp(dev, index);
+	if (opp_table) {
+		if (!_add_opp_dev_unlocked(dev, opp_table)) {
+			dev_pm_opp_put_opp_table(opp_table);
+			opp_table = NULL;
+		}
+		goto unlock;
+	}
+
 	opp_table = _allocate_opp_table(dev, index);
 
 unlock:
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index a5cba0234220..db3e4d2b969e 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -41,11 +41,14 @@ struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
 
-static struct opp_table *_managed_opp(const struct device_node *np)
+struct opp_table *_managed_opp(struct device *dev, int index)
 {
 	struct opp_table *opp_table, *managed_table = NULL;
+	struct device_node *np;
 
-	mutex_lock(&opp_table_lock);
+	np = _opp_of_get_opp_desc_node(dev->of_node, index);
+	if (!np)
+		return NULL;
 
 	list_for_each_entry(opp_table, &opp_tables, node) {
 		if (opp_table->np == np) {
@@ -65,7 +68,7 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 		}
 	}
 
-	mutex_unlock(&opp_table_lock);
+	of_node_put(np);
 
 	return managed_table;
 }
@@ -401,30 +404,19 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 {
 	struct device_node *np;
 	struct opp_table *opp_table;
-	int ret = 0, count = 0, pstate_count = 0;
+	int ret, count = 0, pstate_count = 0;
 	struct dev_pm_opp *opp;
 
-	opp_table = _managed_opp(opp_np);
-	if (opp_table) {
-		/* OPPs are already managed */
-		if (!_add_opp_dev(dev, opp_table)) {
-			ret = -ENOMEM;
-			goto put_opp_table;
-		}
-
-		if (opp_table->parsed_static_opps) {
-			kref_get(&opp_table->list_kref);
-			return 0;
-		}
-
-		goto initialize_static_opps;
-	}
-
 	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
 	if (!opp_table)
 		return -ENOMEM;
 
-initialize_static_opps:
+	/* OPP table is already initialized for the device */
+	if (opp_table->parsed_static_opps) {
+		kref_get(&opp_table->list_kref);
+		return 0;
+	}
+
 	kref_init(&opp_table->list_kref);
 
 	/* We have opp-table node now, iterate over it and add OPPs */
@@ -466,7 +458,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 
 put_list_kref:
 	_put_opp_list_kref(opp_table);
-put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index b260fb7b307a..a7e9adab4cd3 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -206,8 +206,10 @@ void _put_opp_list_kref(struct opp_table *opp_table);
 
 #ifdef CONFIG_OF
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index);
+struct opp_table *_managed_opp(struct device *dev, int index);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
+static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL };
 #endif
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.18.0.rc1.242.g61856ae69a2c

