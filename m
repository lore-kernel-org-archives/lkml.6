Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D225DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DCA218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCNOViW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfB0T6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:58:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44930 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbfB0T6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:58:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id q128so14968978ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 11:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XKFXfVA/MFOFOm3N3DxhXtUoRuHmZYEZxmpq4iLOsS0=;
        b=BCNOViW05Viv/rVAqgh4Vsn2bB/S6rmx007nW5Zwfg3vOsf2oiUNr2cy+h1kftVC1O
         bu8OYpbnjns/sJO3ZVm2y2mMVvfyKc5T8ToLluuy4Ym+LbQsz5Bw8NYC596JvipOH2k9
         4hUg069/roFn9YCZWfP6Ya/L0OOyZxOhQvrivrUoEomsZXKx4S3j/C7bhV/lcIWBHY/9
         ZS+1Z69pFXGch6UfZOAc3Y2359plZH2U7Sx37NqdNH25je5jjhYblLPfuyWaY58vBevx
         uUqpLXxkYkaERvVNnnVdnmP1OxIeXVmuPuDi5S71RyTevI9kwdjMnD2n17nhk0uMunLa
         Fqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XKFXfVA/MFOFOm3N3DxhXtUoRuHmZYEZxmpq4iLOsS0=;
        b=efPOHewc5kRczIZEmTkXC5/wIvYxnhVKSI5GH4yn1Oq1aeciJyQ4QmYdyf78TPwL3p
         b6JGyNHTDLidkgGKOeENgRt6LG6artJPqxRAPN4JVjZzyvdnT5681CCQN7ryg8jHeBRw
         vowbQgAKPse80aCy/b1PVGJMA1TLqKQT6FXQ9gUoZu18IqPzxpQk0L1p8w0pgLNaMBr4
         4x46TAc3/Fayrhc4KBdL1MUtWWKSiCGjyVX927aJOZmsE+mRhurVnBO5ry6D0CY10qlD
         ONSMeSQwlEGJFpE8D50xxxOxst9EzytAydsaLJ3JowHJ5VT2UwmIp/KcAIe5+fSD7xoR
         0tNw==
X-Gm-Message-State: AHQUAua2w8guq12ixWVDw7CZRkYcWvFJ6yjORYNfeF2Lt+LFRCSSP5VY
        HiPCp/57w0eFIo3JCrT6etPQAA==
X-Google-Smtp-Source: APXvYqwoEEWsyKRDgF2ZqvMiwFnQqs7Nd2PwXFGAP3pHpMx7U5f+SRreNguy4ZpIWPZAhCu2g6hqmg==
X-Received: by 2002:a2e:9916:: with SMTP id v22mr2435944lji.68.1551297522613;
        Wed, 27 Feb 2019 11:58:42 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id z128sm723802lfa.60.2019.02.27.11.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 11:58:41 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 1/4] PM / Domains: Add a generic data pointer to the genpd_power_state struct
Date:   Wed, 27 Feb 2019 20:58:33 +0100
Message-Id: <20190227195836.24739-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227195836.24739-1-ulf.hansson@linaro.org>
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add a data pointer to the genpd_power_state struct, to allow a genpd
backend driver to store per state specific data. To introduce the pointer,
we need to change the way genpd deals with freeing of the corresponding
allocated data.

More precisely, let's clarify the responsibility of whom that shall free
the data, by adding a ->free_states() callback to the struct
generic_pm_domain. The one allocating the data shall assign the callback,
to allow genpd to invoke it from genpd_remove().

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v12:
	- None.

---
 drivers/base/power/domain.c | 12 ++++++++++--
 include/linux/pm_domain.h   |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2c334c01fc43..03885c003c6a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1685,6 +1685,12 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 }
 EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
 
+static void genpd_free_default_power_state(struct genpd_power_state *states,
+					   unsigned int state_count)
+{
+	kfree(states);
+}
+
 static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
 {
 	struct genpd_power_state *state;
@@ -1695,7 +1701,7 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
 
 	genpd->states = state;
 	genpd->state_count = 1;
-	genpd->free = state;
+	genpd->free_states = genpd_free_default_power_state;
 
 	return 0;
 }
@@ -1811,7 +1817,9 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
 	cancel_work_sync(&genpd->power_off_work);
-	kfree(genpd->free);
+	if (genpd->free_states)
+		genpd->free_states(genpd->states, genpd->state_count);
+
 	pr_debug("%s: removed %s\n", __func__, genpd->name);
 
 	return 0;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 1ed5874bcee0..8e1399231753 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -69,6 +69,7 @@ struct genpd_power_state {
 	s64 residency_ns;
 	struct fwnode_handle *fwnode;
 	ktime_t idle_time;
+	void *data;
 };
 
 struct genpd_lock_ops;
@@ -110,9 +111,10 @@ struct generic_pm_domain {
 			   struct device *dev);
 	unsigned int flags;		/* Bit field of configs for genpd */
 	struct genpd_power_state *states;
+	void (*free_states)(struct genpd_power_state *states,
+			    unsigned int state_count);
 	unsigned int state_count; /* number of states */
 	unsigned int state_idx; /* state that genpd will go to when off */
-	void *free; /* Free the state that was allocated for default */
 	ktime_t on_time;
 	ktime_t accounting_time;
 	const struct genpd_lock_ops *lock_ops;
-- 
2.17.1

