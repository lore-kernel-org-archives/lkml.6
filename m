Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58BAC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7201327B19
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GrmyM/NR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7201327B19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754538AbeF2GUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:20:04 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34047 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754277AbeF2GT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:19:59 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so3963217plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 23:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TBfHkYuERDOrgM/8wx6qu440hJJWlqeZST2ftQHE0NY=;
        b=GrmyM/NRDYQ9bL4gWJgXLdVEkbbXgAn2xakHyTqNBOpjvh30V/pJ4AA94WiLpyZhSO
         s5cyjtWInVfScgIQgd6q6MgR90xxspGGoJM9YsomdwJVqJnXqr9Eenf7FHb6gpZcKXLX
         I4HMO5zfDFj6EFw670u3zFwYnD5z1YZFA9ECg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TBfHkYuERDOrgM/8wx6qu440hJJWlqeZST2ftQHE0NY=;
        b=AChiRaMiNksBLSgQR5SmKY7c090xzd4q6JqqFBH4tsmnfpqG7oqIYHg3GU/QU5jxvM
         aeTLNrkqK1euSDHS5LkJxTgaZ3JfOM1ybUC0pFajXHCYcJKZ9IeaDY5vunro5CqkSi1x
         adN/UexwhmGyOGrNzIk0CcgOalXuqGYKWlif5fdarINWbIffdTtqb9NJljl5loMS2A6h
         9q/4xxDUpSDSq4dde/QleSDTWuIhCOHOdKZjF20Sh00R26QfzhwmBJJ32xQMAzi/XCkO
         uD/RZG0r0s79O8Bcv4bNQntIAaN7IvVti+8rAD3XNJ3f6CeO30hnMsiEIDm9Hg94HmOa
         +Geg==
X-Gm-Message-State: APt69E0DpoNe4hQLqQYK6dbvo1jgPfWAVwCiilPJ01ZZsWz3ms9tJWPr
        kkQwv0aDaumuOR1ysv3LxDHECA==
X-Google-Smtp-Source: ADUXVKJlcSN3r+zBPnwGEzdY0t1NHCq9jRb62/RjDQqd/CNtme7dIcwz/RbCae/R+4/B3CUQypnANw==
X-Received: by 2002:a17:902:e101:: with SMTP id cc1-v6mr13432682plb.96.1530253199322;
        Thu, 28 Jun 2018 23:19:59 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id m134-v6sm7561188pga.20.2018.06.28.23.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 23:19:58 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] OPP: Parse OPP table's DT properties from _of_init_opp_table()
Date:   Fri, 29 Jun 2018 11:49:31 +0530
Message-Id: <415e586b2dedcc6f97ee07a76bd54124c4b7e8bb.1530252803.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse the DT properties present in the OPP table from
_of_init_opp_table(), which is a dedicated routine of DT parsing.

Minor relocation of helpers was required for this.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 77 +++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 7af0ddec936b..44a6b81fd228 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -23,6 +23,24 @@
 
 #include "opp.h"
 
+/*
+ * Returns opp descriptor node for a device node, caller must
+ * do of_node_put().
+ */
+static struct device_node *_opp_of_get_opp_desc_node(struct device_node *np,
+						     int index)
+{
+	/* "operating-points-v2" can be an array for power domain providers */
+	return of_parse_phandle(np, "operating-points-v2", index);
+}
+
+/* Returns opp descriptor node for a device, caller must do of_node_put() */
+struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
+{
+	return _opp_of_get_opp_desc_node(dev->of_node, 0);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
+
 static struct opp_table *_managed_opp(const struct device_node *np)
 {
 	struct opp_table *opp_table, *managed_table = NULL;
@@ -54,22 +72,35 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev)
 {
-	struct device_node *np;
+	struct device_node *np, *opp_np;
+	u32 val;
 
 	/*
 	 * Only required for backward compatibility with v1 bindings, but isn't
 	 * harmful for other cases. And so we do it unconditionally.
 	 */
 	np = of_node_get(dev->of_node);
-	if (np) {
-		u32 val;
-
-		if (!of_property_read_u32(np, "clock-latency", &val))
-			opp_table->clock_latency_ns_max = val;
-		of_property_read_u32(np, "voltage-tolerance",
-				     &opp_table->voltage_tolerance_v1);
-		of_node_put(np);
-	}
+	if (!np)
+		return;
+
+	if (!of_property_read_u32(np, "clock-latency", &val))
+		opp_table->clock_latency_ns_max = val;
+	of_property_read_u32(np, "voltage-tolerance",
+			     &opp_table->voltage_tolerance_v1);
+
+	/* Get OPP table node */
+	opp_np = _opp_of_get_opp_desc_node(np, 0);
+	of_node_put(np);
+
+	if (!opp_np)
+		return;
+
+	if (of_property_read_bool(opp_np, "opp-shared"))
+		opp_table->shared_opp = OPP_TABLE_ACCESS_SHARED;
+	else
+		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
+
+	of_node_put(opp_np);
 }
 
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
@@ -249,22 +280,6 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
-/* Returns opp descriptor node for a device node, caller must
- * do of_node_put() */
-static struct device_node *_opp_of_get_opp_desc_node(struct device_node *np,
-						     int index)
-{
-	/* "operating-points-v2" can be an array for power domain providers */
-	return of_parse_phandle(np, "operating-points-v2", index);
-}
-
-/* Returns opp descriptor node for a device, caller must do of_node_put() */
-struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
-{
-	return _opp_of_get_opp_desc_node(dev->of_node, 0);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
-
 /**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
  * @opp_table:	OPP table
@@ -431,11 +446,13 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	if (pstate_count)
 		opp_table->genpd_performance_state = true;
 
+	/*
+	 * This is used by _managed_opp() to find OPP tables that are fully
+	 * initialized by other devices sharing clock/voltage rails with current
+	 * device. And so we can't set this from _of_init_opp_table() as tables
+	 * aren't fully initialized at that point.
+	 */
 	opp_table->np = opp_np;
-	if (of_property_read_bool(opp_np, "opp-shared"))
-		opp_table->shared_opp = OPP_TABLE_ACCESS_SHARED;
-	else
-		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
 
 put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
-- 
2.18.0.rc1.242.g61856ae69a2c

