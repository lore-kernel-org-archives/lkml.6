Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9038DC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3C22088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmHC1PAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3C22088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeILNdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:33:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42811 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeILNdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:33:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so663176pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jLrWZpb9Eb/sZJFwJhTGcqYIBmyIgGhRRYN0pKoqWKA=;
        b=YmHC1PAZOI5n6UI3VqrIHJ4p8xgMRpVnossmXm8Jle2pHl8PWXHaj36llHqDYiN2KB
         PTWnzcUG1cnAl/2AFFfkwKAffo6T1wja42+n6Z4OYgZnY2X4/TwfpsqJTujtGzdHsiqk
         DgbbHt4Xdmuum/ttnLST2kp98td8CPkDEc4Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jLrWZpb9Eb/sZJFwJhTGcqYIBmyIgGhRRYN0pKoqWKA=;
        b=RoYXj6MqClYBLymmmGMcsBXeXHG9fsIsULWvYiOyukjyG24uYm++akjF3tIvPSluvK
         mGfjL8i4jGi7unGQGU2+lNkB0/KOvvvompJpRuShQGOD4dtdG3vGdwvfnaArJH1SxmlH
         9qcdK9lCVNCMFXuzOwACjsBPa66K3stf7pneT7HhmwvMKQDmhUihZbFPikIgZmd2m2Y3
         7Vdm0GeLNstuQy27+XCJT5GthtAbBIydSvkivicoMSjJJ7itIpgtv+9uIALCUmO7N5TA
         7iib/ibMUpudMYhpFWjmdHq8UATxvElCrI+nmcNqfd7KZlqEfW/6NV7BtQJBi2r869DA
         vaXg==
X-Gm-Message-State: APzg51CPuYZxeWyhNpg2PAY5ya1AiAQCb1f/Ytyhrr8nlDPFvS12WlMc
        xBt+mBwozkcerokB+KImP6LSwQ==
X-Google-Smtp-Source: ANB0VdbXDZ7ee+VR8DIJ4YuVJd0a0kDQhzPkPFw73FFOtpVCGx7K31bV36yNiil4zJPdy/vfCKHZKQ==
X-Received: by 2002:a62:5543:: with SMTP id j64-v6mr926879pfb.188.1536741015294;
        Wed, 12 Sep 2018 01:30:15 -0700 (PDT)
Received: from localhost ([122.171.64.45])
        by smtp.gmail.com with ESMTPSA id j16-v6sm1432654pfk.125.2018.09.12.01.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 01:30:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     niklas.cassel@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] OPP: Use a single mechanism to free the OPP table
Date:   Wed, 12 Sep 2018 13:58:48 +0530
Message-Id: <a2bbc242d235de4a565b55fcf7f052f1ae11ab6c.1536736872.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1536736872.git.viresh.kumar@linaro.org>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are two separate ways to free the OPP table based on how
it is created in the first place.

We call _dev_pm_opp_remove_table() to free the static and/or dynamic
OPP, OPP list devices, etc. This is done for the case where the OPP
table is added while initializing the OPPs, like via the path
dev_pm_opp_of_add_table().

We also call dev_pm_opp_put_opp_table() in some cases which eventually
frees the OPP table structure once the reference count reaches 0. This
is used by the first case as well as other cases like
dev_pm_opp_set_regulators() where the OPPs aren't necessarily
initialized at this point.

This whole thing is a bit unclear and messy and obstruct any further
cleanup/fixup of OPP core.

This patch tries to streamline this by keeping a single path for OPP
table destruction, i.e. dev_pm_opp_put_opp_table().

All the cleanup happens in _opp_table_kref_release() now after the
reference count reaches 0. _dev_pm_opp_remove_table() is removed as it
isn't required anymore.

We don't drop the reference to the OPP table after creating it from
_of_add_opp_table_v{1|2}() anymore and the same is dropped only when we
try to remove them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 54 ++++++++++++++--------------------------------
 drivers/opp/of.c   | 32 +++++++++++++++------------
 drivers/opp/opp.h  |  2 +-
 3 files changed, 35 insertions(+), 53 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2319ad4a0177..d3e33fd32694 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -867,23 +867,24 @@ struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev,
 static void _opp_table_kref_release(struct kref *kref)
 {
 	struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
-	struct opp_device *opp_dev;
+	struct opp_device *opp_dev, *temp;
 
 	/* Release clk */
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
 
-	/*
-	 * No need to take opp_table->lock here as we are guaranteed that no
-	 * references to the OPP table are taken at this point.
-	 */
-	opp_dev = list_first_entry(&opp_table->dev_list, struct opp_device,
-				   node);
+	WARN_ON(!list_empty(&opp_table->opp_list));
 
-	_remove_opp_dev(opp_dev, opp_table);
+	list_for_each_entry_safe(opp_dev, temp, &opp_table->dev_list, node) {
+		/*
+		 * The OPP table is getting removed, drop the performance state
+		 * constraints.
+		 */
+		if (opp_table->genpd_performance_state)
+			dev_pm_genpd_set_performance_state((struct device *)(opp_dev->dev), 0);
 
-	/* dev_list must be empty now */
-	WARN_ON(!list_empty(&opp_table->dev_list));
+		_remove_opp_dev(opp_dev, opp_table);
+	}
 
 	mutex_destroy(&opp_table->lock);
 	list_del(&opp_table->node);
@@ -1758,33 +1759,6 @@ int dev_pm_opp_unregister_notifier(struct device *dev,
 }
 EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
 
-/*
- * Free OPPs either created using static entries present in DT.
- */
-void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev)
-{
-	/* Protect dev_list */
-	mutex_lock(&opp_table->lock);
-
-	/* Find if opp_table manages a single device */
-	if (list_is_singular(&opp_table->dev_list)) {
-		/* Free static OPPs */
-		_put_opp_list_kref(opp_table);
-
-		/*
-		 * The OPP table is getting removed, drop the performance state
-		 * constraints.
-		 */
-		if (opp_table->genpd_performance_state)
-			dev_pm_genpd_set_performance_state(dev, 0);
-	} else {
-		_put_opp_list_kref(opp_table);
-		_remove_opp_dev(_find_opp_dev(dev, opp_table), opp_table);
-	}
-
-	mutex_unlock(&opp_table->lock);
-}
-
 void _dev_pm_opp_find_and_remove_table(struct device *dev)
 {
 	struct opp_table *opp_table;
@@ -1802,8 +1776,12 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev)
 		return;
 	}
 
-	_dev_pm_opp_remove_table(opp_table, dev);
+	_put_opp_list_kref(opp_table);
+
+	/* Drop reference taken by _find_opp_table() */
+	dev_pm_opp_put_opp_table(opp_table);
 
+	/* Drop reference taken while the OPP table was added */
 	dev_pm_opp_put_opp_table(opp_table);
 }
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 9c98682af374..a5cba0234220 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -407,14 +407,17 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 	opp_table = _managed_opp(opp_np);
 	if (opp_table) {
 		/* OPPs are already managed */
-		if (!_add_opp_dev(dev, opp_table))
+		if (!_add_opp_dev(dev, opp_table)) {
 			ret = -ENOMEM;
-		else if (!opp_table->parsed_static_opps)
-			goto initialize_static_opps;
-		else
+			goto put_opp_table;
+		}
+
+		if (opp_table->parsed_static_opps) {
 			kref_get(&opp_table->list_kref);
+			return 0;
+		}
 
-		goto put_opp_table;
+		goto initialize_static_opps;
 	}
 
 	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
@@ -432,17 +435,15 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
-			_dev_pm_opp_remove_table(opp_table, dev);
 			of_node_put(np);
-			goto put_opp_table;
+			goto put_list_kref;
 		}
 	}
 
 	/* There should be one of more OPP defined */
 	if (WARN_ON(!count)) {
 		ret = -ENOENT;
-		_put_opp_list_kref(opp_table);
-		goto put_opp_table;
+		goto put_list_kref;
 	}
 
 	list_for_each_entry(opp, &opp_table->opp_list, node)
@@ -453,8 +454,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
 			count, pstate_count);
 		ret = -ENOENT;
-		_dev_pm_opp_remove_table(opp_table, dev);
-		goto put_opp_table;
+		goto put_list_kref;
 	}
 
 	if (pstate_count)
@@ -462,6 +462,10 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 
 	opp_table->parsed_static_opps = true;
 
+	return 0;
+
+put_list_kref:
+	_put_opp_list_kref(opp_table);
 put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
 
@@ -507,13 +511,13 @@ static int _of_add_opp_table_v1(struct device *dev)
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
 				__func__, freq, ret);
-			_dev_pm_opp_remove_table(opp_table, dev);
-			break;
+			_put_opp_list_kref(opp_table);
+			dev_pm_opp_put_opp_table(opp_table);
+			return ret;
 		}
 		nr -= 2;
 	}
 
-	dev_pm_opp_put_opp_table(opp_table);
 	return ret;
 }
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 3b1d94748a4d..b260fb7b307a 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -190,11 +190,11 @@ struct opp_table {
 
 /* Routines internal to opp core */
 void dev_pm_opp_get(struct dev_pm_opp *opp);
+void _opp_remove_all_static(struct opp_table *opp_table);
 void _get_opp_table_kref(struct opp_table *opp_table);
 int _get_opp_count(struct opp_table *opp_table);
 struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
-void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev);
 void _dev_pm_opp_find_and_remove_table(struct device *dev);
 struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
-- 
2.18.0.rc1.242.g61856ae69a2c

