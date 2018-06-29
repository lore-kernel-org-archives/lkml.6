Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6481C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9F927B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/K/Bfc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9F927B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754721AbeF2GUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:20:12 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42151 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754309AbeF2GUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:20:08 -0400
Received: by mail-pl0-f68.google.com with SMTP id y15-v6so2084245pll.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 23:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ZM+uZPd8Ym3pQOe6pOL3GJlnsslpoljPMAp53e4UWo=;
        b=E/K/Bfc58WsPRsVPdtRUpuKj5af2XXijVbChI8wWM6Ve7j4yEbTlSQUmxAlCnbnzh6
         uOE/KC38oQgZomN6G+iLXF5xJMvsdOF+aI9HiGmEbIuofD0uWp+Bi7g8tUTUEeZSjuVg
         xgva+EZoXV5Hw/DtuLnMhsVD4+YxVBpokyAiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8ZM+uZPd8Ym3pQOe6pOL3GJlnsslpoljPMAp53e4UWo=;
        b=T48J+MlQxk5o7wDTJB135jzCXJEHInS6TTj2OxKLnQSsyEDPslVRbqq/nzqykxwUMr
         oBy2SyNZ/wzQcfzcW0s8rSMjGSZzQMJNYhje9peRKUg44/aTBeAxdbf5QqiptS9JI4HG
         7Aejkir3WXrJJAi5vcrA9vEjx0SIc0uTYyI5ZBU1VIXgvXLQtbuyUqNeb31P3vEUGpbB
         5vFDrg5S1A27+EqMAztOScpFuzXWBm621rd+3AmlY6VlYVF+J0Z0bKwbin8TSkQxzIAy
         iXHME+osZfRwWk82tPgrLWoHRz6HthitXBzBEuuDH8TAbd9LA3/j+u21ZxnsqxMuoNMO
         WocQ==
X-Gm-Message-State: APt69E3UKewPJ1++OHdHQNgOVlRneaeL05FSulqVpckyJmxZ6QPKLJ9j
        wx6LcRHgBkC3yMQSMUrWwOnIRw==
X-Google-Smtp-Source: ADUXVKJXfJDihXlKUSXtLi13GFE/hjoh8OS+8+uxWcznejcNFXcl5yUDyrsLyulbtXu/0X1qMyPQSg==
X-Received: by 2002:a17:902:342:: with SMTP id 60-v6mr13596219pld.311.1530253207686;
        Thu, 28 Jun 2018 23:20:07 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id u21-v6sm7386537pfi.30.2018.06.28.23.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 23:20:07 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] OPP: Populate required opp tables from "required-opps" property
Date:   Fri, 29 Jun 2018 11:49:34 +0530
Message-Id: <e141629140b648d3fc4d2f685a3daf947447172d.1530252803.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation works only for the case where a single
phandle is present in the "required-opps" property, while DT allows
multiple phandles to be present there.

This patch adds new infrastructure to parse all the phandles present in
"required-opps" property and save pointers of the required OPP's OPP
tables. These will be used by later commits.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |   2 +
 drivers/opp/of.c   | 138 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/opp/opp.h  |   8 +++
 3 files changed, 148 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c0c657fdbf33..22c927c5e4ea 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -863,6 +863,8 @@ static void _opp_table_kref_release(struct kref *kref)
 	struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
 	struct opp_device *opp_dev;
 
+	_of_clear_opp_table(opp_table);
+
 	/* Release clk */
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 218b8997d817..b639195a1e3d 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -70,6 +70,138 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 	return managed_table;
 }
 
+static struct device_node *of_parse_required_opp(struct device_node *np,
+						 int index)
+{
+	struct device_node *required_np;
+
+	required_np = of_parse_phandle(np, "required-opps", index);
+	if (unlikely(!required_np)) {
+		pr_err("%s: Unable to parse required-opps: %pOF, index: %d\n",
+		       __func__, np, index);
+	}
+
+	return required_np;
+}
+
+/* The caller must call dev_pm_opp_put_opp_table() after the table is used */
+static struct opp_table *_get_required_opp_table(struct device_node *np)
+{
+	struct opp_table *opp_table, *required_opp_table = NULL;
+	struct dev_pm_opp *opp;
+
+	lockdep_assert_held(&opp_table_lock);
+
+	list_for_each_entry(opp_table, &opp_tables, node) {
+		mutex_lock(&opp_table->lock);
+
+		list_for_each_entry(opp, &opp_table->opp_list, node) {
+			if (opp->np == np) {
+				/* Found required OPP table */
+				if (opp_table->is_genpd) {
+					required_opp_table = opp_table;
+					break;
+				}
+
+				/*
+				 * We only support OPP of genpd's in the
+				 * "required-opps" for now, as we don't know how
+				 * to do DVFS for any other use cases. Error out
+				 * if the required OPP doesn't belong to a
+				 * genpd.
+				 */
+				pr_err("%s: required-opp doesn't belong to genpd: %pOF\n",
+				       __func__, opp->np);
+				break;
+			}
+		}
+
+		mutex_unlock(&opp_table->lock);
+
+		if (!required_opp_table)
+			continue;
+
+		_get_opp_table_kref(required_opp_table);
+
+		return required_opp_table;
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
+/* Free resources previously acquired by _opp_table_alloc_required_tables() */
+static void _opp_table_free_required_tables(struct opp_table *opp_table)
+{
+	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
+	int i;
+
+	if (!required_opp_tables)
+		return;
+
+	for (i = 0; i < opp_table->required_opp_count; i++) {
+		if (IS_ERR_OR_NULL(required_opp_tables[i]))
+			break;
+
+		dev_pm_opp_put_opp_table(required_opp_tables[i]);
+	}
+
+	kfree(required_opp_tables);
+
+	opp_table->required_opp_count = 0;
+	opp_table->required_opp_tables = NULL;
+}
+
+/*
+ * Populate all devices and opp tables which are part of "required-opps" list.
+ * Checking only the first OPP node should be enough.
+ */
+static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
+					     struct device *dev,
+					     struct device_node *opp_np)
+{
+	struct opp_table **required_opp_tables;
+	struct device_node *required_np, *np;
+	int count, i;
+
+	/* Traversing the first OPP node is all we need */
+	np = of_get_next_available_child(opp_np, NULL);
+	if (!np) {
+		dev_err(dev, "Empty OPP table\n");
+		return;
+	}
+
+	count = of_count_phandle_with_args(np, "required-opps", NULL);
+	if (!count)
+		goto put_np;
+
+	required_opp_tables = kcalloc(count, sizeof(*required_opp_tables),
+				      GFP_KERNEL);
+	if (!required_opp_tables)
+		goto put_np;
+
+	opp_table->required_opp_tables = required_opp_tables;
+	opp_table->required_opp_count = count;
+
+	for (i = 0; i < count; i++) {
+		required_np = of_parse_required_opp(np, i);
+		if (!required_np)
+			goto free_required_tables;
+
+		required_opp_tables[i] = _get_required_opp_table(required_np);
+		of_node_put(required_np);
+
+		if (IS_ERR(required_opp_tables[i]))
+			goto free_required_tables;
+	}
+
+	goto put_np;
+
+free_required_tables:
+	_opp_table_free_required_tables(opp_table);
+put_np:
+	of_node_put(np);
+}
+
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev)
 {
 	struct device_node *np, *opp_np;
@@ -103,9 +235,15 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev)
 	else
 		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
 
+	_opp_table_alloc_required_tables(opp_table, dev, opp_np);
 	of_node_put(opp_np);
 }
 
+void _of_clear_opp_table(struct opp_table *opp_table)
+{
+	_opp_table_free_required_tables(opp_table);
+}
+
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 			      struct device_node *np)
 {
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 3cd3b7b167b5..fea70c71cc99 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -131,6 +131,9 @@ enum opp_table_access {
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @shared_opp: OPP is shared between multiple devices.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
+ * @required_opp_tables: List of device OPP tables that are required by OPPs in
+ *		this table.
+ * @required_opp_count: Number of required devices.
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
@@ -168,6 +171,9 @@ struct opp_table {
 	enum opp_table_access shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
+	struct opp_table **required_opp_tables;
+	unsigned int required_opp_count;
+
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
@@ -203,8 +209,10 @@ struct opp_table *_add_opp_table(struct device *dev);
 
 #ifdef CONFIG_OF
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev);
+void _of_clear_opp_table(struct opp_table *opp_table);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev) {}
+static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
 #endif
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.18.0.rc1.242.g61856ae69a2c

