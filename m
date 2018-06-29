Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774DCC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECFC27B25
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzsQYkaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECFC27B25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754881AbeF2GUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:20:23 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39412 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754807AbeF2GUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:20:19 -0400
Received: by mail-pg0-f67.google.com with SMTP id n2-v6so3539234pgq.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 23:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RAkNTVnfjx0sqCftYi4+z+jIgEfTOT4ZKqT/BTZR498=;
        b=RzsQYkaa5Ud3Um+ACh+T3R/P5TjDavehXqIMPJMbvBeqd7Q4vEoJz/cpT4ouf1NzZZ
         PujeTGYs/ahUsf/4zJGKoRGvqnxUkznbte7ebuXTR8RSAoeDCt7XC9E1+C3P6SVxzyB8
         wl/SMkY5KPAkYgvfgpk3KY9fnr78OXb/m+3bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RAkNTVnfjx0sqCftYi4+z+jIgEfTOT4ZKqT/BTZR498=;
        b=fj9uojrqM8lhw55Zknpz070OhXXmpFC9MCeWRTJcCmEMl9Ud8NylYa48M4Xl+6kWV3
         YurlT1V3UAI8aLUoofvWdM3SgSyxtjafLg8ZAfGM6PalTM/FY6jRqZnhNY/XbQ4MwsMp
         n5aBUElDetZipHmwvXlYlMo/3W2PpeDR05rL4ekjyiKGduRH96KI++89DFLbn9ZtRwfv
         XQLiJOMiap2bhMK57gVNTEyvK9h5OTvmySMqx171AZVQIaD1+e1Men4iz69MfJ9lKM/f
         sqjB5d1aVBtRJb+ZCS/CaMVM5olQNYvxLY8HhxHzZnEF23wnqO/xiio8kV7AAPyhBv2p
         dwnw==
X-Gm-Message-State: APt69E2s214zX8M9VAPxd+y7WQWiD85DSf8oW3qQUdPrJOC1yNBpn/ph
        enzZADO71bsEn3SwpcRkcK/wdw==
X-Google-Smtp-Source: AAOMgpfrUXfBmmFRq78uaUNpKwHmprtqdrLbuTqw9sF+36dEPyAtm/hdLOrkMlyfkelOGTyeXNW/AA==
X-Received: by 2002:a62:2605:: with SMTP id m5-v6mr13178654pfm.223.1530253219211;
        Thu, 28 Jun 2018 23:20:19 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id i89-v6sm4730250pfi.170.2018.06.28.23.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 23:20:18 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] OPP: Configure all required OPPs
Date:   Fri, 29 Jun 2018 11:49:38 +0530
Message-Id: <c1da547faaa9fb4e3fe9034a643853847b106d68.1530252803.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the infrastructure is in place to support multiple required
OPPs, lets switch over to using it.

A new internal routine _set_required_opps() takes care of updating
performance state for all the required OPPs. With this the performance
state updates are supported even when the end device needs to configure
regulators as well, that wasn't the case earlier.

The pstates were earlier stored in the end device's OPP structures, that
also changes now as those values are stored in the genpd's OPP
structures. And so we switch over to using
genpd_opp_to_performance_state() instead of
of_genpd_opp_to_performance_state() to get performance state for the
genpd OPPs.

The routine _generic_set_opp_domain() is not required anymore and is
removed.

On errors we don't try to recover by reverting to old settings as things
are really complex now and the calls here should never really fail
unless there is a bug. There is no point increasing the complexity, for
code which will never be executed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 99 ++++++++++++++++++++++++----------------------
 drivers/opp/of.c   |  5 ++-
 2 files changed, 54 insertions(+), 50 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3a2f08c56c4e..6b3410ded1ca 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -543,44 +543,6 @@ _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 	return ret;
 }
 
-static inline int
-_generic_set_opp_domain(struct device *dev, struct clk *clk,
-			unsigned long old_freq, unsigned long freq,
-			unsigned int old_pstate, unsigned int new_pstate)
-{
-	int ret;
-
-	/* Scaling up? Scale domain performance state before frequency */
-	if (freq > old_freq) {
-		ret = dev_pm_genpd_set_performance_state(dev, new_pstate);
-		if (ret)
-			return ret;
-	}
-
-	ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
-	if (ret)
-		goto restore_domain_state;
-
-	/* Scaling down? Scale domain performance state after frequency */
-	if (freq < old_freq) {
-		ret = dev_pm_genpd_set_performance_state(dev, new_pstate);
-		if (ret)
-			goto restore_freq;
-	}
-
-	return 0;
-
-restore_freq:
-	if (_generic_set_opp_clk_only(dev, clk, freq, old_freq))
-		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
-			__func__, old_freq);
-restore_domain_state:
-	if (freq > old_freq)
-		dev_pm_genpd_set_performance_state(dev, old_pstate);
-
-	return ret;
-}
-
 static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 				      struct device *dev,
 				      unsigned long old_freq,
@@ -658,6 +620,42 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 	return opp_table->set_opp(data);
 }
 
+/* This is only called for PM domain for now */
+static int _set_required_opps(struct device *dev,
+			      const struct opp_table *opp_table,
+			      struct dev_pm_opp *opp)
+{
+	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
+	struct device **required_devices = opp_table->required_devices;
+	struct device *required_dev = dev;
+	unsigned int pstate;
+	int i, ret;
+
+	if (!required_opp_tables)
+		return 0;
+
+	for (i = 0; i < opp_table->required_opp_count; i++) {
+		pstate = opp->required_opps[i]->pstate;
+
+		if (required_devices) {
+			required_dev = required_devices[i];
+			if (!required_dev) {
+				dev_err(dev, "Missing OPP required device\n");
+				return -ENODEV;
+			}
+		}
+
+		ret = dev_pm_genpd_set_performance_state(required_dev, pstate);
+		if (ret) {
+			dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
+				dev_name(required_dev), pstate, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * dev_pm_opp_set_rate() - Configure new OPP based on frequency
  * @dev:	 device for which we do this operation
@@ -725,6 +723,13 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n", __func__,
 		old_freq, freq);
 
+	/* Scaling up? Configure required OPPs before frequency */
+	if (freq > old_freq) {
+		ret = _set_required_opps(dev, opp_table, opp);
+		if (ret)
+			goto put_opp;
+	}
+
 	if (opp_table->set_opp) {
 		ret = _set_opp_custom(opp_table, dev, old_freq, freq,
 				      IS_ERR(old_opp) ? NULL : old_opp->supplies,
@@ -735,19 +740,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 						 opp->supplies);
 	} else {
 		/* Only frequency scaling */
+		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+	}
 
-		/*
-		 * We don't support devices with both regulator and
-		 * domain performance-state for now.
-		 */
-		if (opp_table->genpd_performance_state)
-			ret = _generic_set_opp_domain(dev, clk, old_freq, freq,
-						      IS_ERR(old_opp) ? 0 : old_opp->pstate,
-						      opp->pstate);
-		else
-			ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+	/* Scaling down? Configure required OPPs after frequency */
+	if (!ret && freq < old_freq) {
+		ret = _set_required_opps(dev, opp_table, opp);
+		if (ret)
+			dev_err(dev, "Failed to set required opps: %d\n", ret);
 	}
 
+put_opp:
 	dev_pm_opp_put(opp);
 put_old_opp:
 	if (!IS_ERR(old_opp))
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 20baba090c17..e1e4a58dd748 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -584,12 +584,13 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
 
-	new_opp->pstate = of_genpd_opp_to_performance_state(dev, np);
-
 	ret = opp_parse_supplies(new_opp, dev, opp_table);
 	if (ret)
 		goto free_required_opps;
 
+	if (opp_table->is_genpd)
+		new_opp->pstate = genpd_opp_to_performance_state(dev, new_opp);
+
 	ret = _opp_add(dev, new_opp, opp_table, rate_not_available);
 	if (ret) {
 		/* Don't return error for duplicate OPPs */
-- 
2.18.0.rc1.242.g61856ae69a2c

