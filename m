Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72059C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4248420861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfAULUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:20:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36627 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfAULUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:20:41 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBJrmD2493119
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:19:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBJrBw2493116;
        Mon, 21 Jan 2019 03:19:53 -0800
Date:   Mon, 21 Jan 2019 03:19:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Murray <tipbot@zytor.com>
Message-ID: <tip-306563985819ed2af9df0a26ae368ed12cf28f41@git.kernel.org>
Cc:     mingo@kernel.org, shawnguo@kernel.org, benh@kernel.crashing.org,
        mattst88@gmail.com, tglx@linutronix.de, acme@kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        andrew.murray@arm.com, peterz@infradead.org, bp@alien8.de,
        paulus@samba.org, ink@jurassic.park.msu.ru, s.hauer@pengutronix.de,
        will.deacon@arm.com, rth@twiddle.net, hpa@zytor.com,
        torvalds@linux-foundation.org, mark.rutland@arm.com,
        mpe@ellerman.id.au
Reply-To: paulus@samba.org, ink@jurassic.park.msu.ru, bp@alien8.de,
          peterz@infradead.org, andrew.murray@arm.com,
          mark.rutland@arm.com, mpe@ellerman.id.au,
          torvalds@linux-foundation.org, rth@twiddle.net, hpa@zytor.com,
          will.deacon@arm.com, s.hauer@pengutronix.de, tglx@linutronix.de,
          acme@kernel.org, mattst88@gmail.com, shawnguo@kernel.org,
          benh@kernel.crashing.org, mingo@kernel.org,
          linux@armlinux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <1547128414-50693-8-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-8-git-send-email-andrew.murray@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] For drivers that do not support context exclusion
 let's advertise the PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that
 perf will prevent us from handling events where any exclusion flags are
 set. Let's also remove the now unnecessary check for exclusion flags.
Git-Commit-ID: 306563985819ed2af9df0a26ae368ed12cf28f41
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  306563985819ed2af9df0a26ae368ed12cf28f41
Gitweb:     https://git.kernel.org/tip/306563985819ed2af9df0a26ae368ed12cf28f41
Author:     Andrew Murray <andrew.murray@arm.com>
AuthorDate: Thu, 10 Jan 2019 13:53:29 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:01:24 +0100

For drivers that do not support context exclusion let's advertise the PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that perf will prevent us from handling events where any exclusion flags are set. Let's also remove the now unnecessary check for exclusion flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: robin.murphy@arm.com
Cc: suzuki.poulose@arm.com
Link: https://lkml.kernel.org/r/1547128414-50693-8-git-send-email-andrew.murray@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/perf/arm-cci.c                        | 10 +---------
 drivers/perf/arm-ccn.c                        |  6 ++----
 drivers/perf/arm_dsu_pmu.c                    |  9 ++-------
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c |  1 +
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |  1 +
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  |  1 +
 drivers/perf/hisilicon/hisi_uncore_pmu.c      |  9 ---------
 drivers/perf/thunderx2_pmu.c                  | 10 +---------
 8 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 1bfeb160c5b1..bfd03e023308 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1327,15 +1327,6 @@ static int cci_pmu_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
-	/* We have no filtering of any kind */
-	if (event->attr.exclude_user	||
-	    event->attr.exclude_kernel	||
-	    event->attr.exclude_hv	||
-	    event->attr.exclude_idle	||
-	    event->attr.exclude_host	||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	/*
 	 * Following the example set by other "uncore" PMUs, we accept any CPU
 	 * and rewrite its affinity dynamically rather than having perf core
@@ -1433,6 +1424,7 @@ static int cci_pmu_init(struct cci_pmu *cci_pmu, struct platform_device *pdev)
 		.stop		= cci_pmu_stop,
 		.read		= pmu_read,
 		.attr_groups	= pmu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	cci_pmu->plat_device = pdev;
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 7dd850e02f19..2ae76026e947 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -741,10 +741,7 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
-	if (has_branch_stack(event) || event->attr.exclude_user ||
-			event->attr.exclude_kernel || event->attr.exclude_hv ||
-			event->attr.exclude_idle || event->attr.exclude_host ||
-			event->attr.exclude_guest) {
+	if (has_branch_stack(event)) {
 		dev_dbg(ccn->dev, "Can't exclude execution levels!\n");
 		return -EINVAL;
 	}
@@ -1290,6 +1287,7 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 		.read = arm_ccn_pmu_event_read,
 		.pmu_enable = arm_ccn_pmu_enable,
 		.pmu_disable = arm_ccn_pmu_disable,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	/* No overflow interrupt? Have to use a timer instead. */
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 660cb8ac886a..5851de56bbd0 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -562,13 +562,7 @@ static int dsu_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	if (has_branch_stack(event) ||
-	    event->attr.exclude_user ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv ||
-	    event->attr.exclude_idle ||
-	    event->attr.exclude_host ||
-	    event->attr.exclude_guest) {
+	if (has_branch_stack(event)) {
 		dev_dbg(dsu_pmu->pmu.dev, "Can't support filtering\n");
 		return -EINVAL;
 	}
@@ -735,6 +729,7 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 		.read		= dsu_pmu_read,
 
 		.attr_groups	= dsu_pmu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	rc = perf_pmu_register(&dsu_pmu->pmu, name, -1);
diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 69372e2bc93c..0eba947c2ee9 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -396,6 +396,7 @@ static int hisi_ddrc_pmu_probe(struct platform_device *pdev)
 		.stop		= hisi_uncore_pmu_stop,
 		.read		= hisi_uncore_pmu_read,
 		.attr_groups	= hisi_ddrc_pmu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	ret = perf_pmu_register(&ddrc_pmu->pmu, name, -1);
diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index 443906e0aff3..2553a844ebf6 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -407,6 +407,7 @@ static int hisi_hha_pmu_probe(struct platform_device *pdev)
 		.stop		= hisi_uncore_pmu_stop,
 		.read		= hisi_uncore_pmu_read,
 		.attr_groups	= hisi_hha_pmu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	ret = perf_pmu_register(&hha_pmu->pmu, name, -1);
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index 0bde5d919b2e..cf1cc34f402a 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -397,6 +397,7 @@ static int hisi_l3c_pmu_probe(struct platform_device *pdev)
 		.stop		= hisi_uncore_pmu_stop,
 		.read		= hisi_uncore_pmu_read,
 		.attr_groups	= hisi_l3c_pmu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	ret = perf_pmu_register(&l3c_pmu->pmu, name, -1);
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 9efd2413240c..f028cbc3443c 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -142,15 +142,6 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
-	/* counters do not have these bits */
-	if (event->attr.exclude_user	||
-	    event->attr.exclude_kernel	||
-	    event->attr.exclude_host	||
-	    event->attr.exclude_guest	||
-	    event->attr.exclude_hv	||
-	    event->attr.exclude_idle)
-		return -EINVAL;
-
 	/*
 	 *  The uncore counters not specific to any CPU, so cannot
 	 *  support per-task
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index c9a1701d3e54..43d76c85da56 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -424,15 +424,6 @@ static int tx2_uncore_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	/* We have no filtering of any kind */
-	if (event->attr.exclude_user	||
-	    event->attr.exclude_kernel	||
-	    event->attr.exclude_hv	||
-	    event->attr.exclude_idle	||
-	    event->attr.exclude_host	||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 
@@ -572,6 +563,7 @@ static int tx2_uncore_pmu_register(
 		.start		= tx2_uncore_event_start,
 		.stop		= tx2_uncore_event_stop,
 		.read		= tx2_uncore_event_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	tx2_pmu->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
