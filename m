Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82899C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6DE20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfAULTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:19:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43319 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfAULTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:19:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBIZZt2493027
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:18:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBIZrV2493024;
        Mon, 21 Jan 2019 03:18:35 -0800
Date:   Mon, 21 Jan 2019 03:18:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Murray <tipbot@zytor.com>
Message-ID: <tip-1d899c0e9bc2a17895762b9457ac336cdee8e072@git.kernel.org>
Cc:     acme@kernel.org, mingo@kernel.org, mattst88@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, will.deacon@arm.com,
        bp@alien8.de, ink@jurassic.park.msu.ru, linux@armlinux.org.uk,
        benh@kernel.crashing.org, tglx@linutronix.de, peterz@infradead.org,
        mpe@ellerman.id.au, rth@twiddle.net, paulus@samba.org,
        andrew.murray@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com
Reply-To: mark.rutland@arm.com, hpa@zytor.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          rth@twiddle.net, paulus@samba.org, andrew.murray@arm.com,
          benh@kernel.crashing.org, tglx@linutronix.de,
          peterz@infradead.org, mpe@ellerman.id.au, acme@kernel.org,
          mattst88@gmail.com, mingo@kernel.org, s.hauer@pengutronix.de,
          shawnguo@kernel.org, will.deacon@arm.com, bp@alien8.de,
          ink@jurassic.park.msu.ru, linux@armlinux.org.uk
In-Reply-To: <1547128414-50693-6-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-6-git-send-email-andrew.murray@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core, arch/arm: Use PERF_PMU_CAP_NO_EXCLUDE
 conditionally
Git-Commit-ID: 1d899c0e9bc2a17895762b9457ac336cdee8e072
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

Commit-ID:  1d899c0e9bc2a17895762b9457ac336cdee8e072
Gitweb:     https://git.kernel.org/tip/1d899c0e9bc2a17895762b9457ac336cdee8e072
Author:     Andrew Murray <andrew.murray@arm.com>
AuthorDate: Thu, 10 Jan 2019 13:53:27 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:01:22 +0100

perf/core, arch/arm: Use PERF_PMU_CAP_NO_EXCLUDE conditionally

The ARM PMU driver can be used to represent a variety of ARM based
PMUs. Some of these PMUs do not provide support for context
exclusion, where this is the case we advertise the
PERF_PMU_CAP_NO_EXCLUDE capability to ensure that perf prevents us
from handling events where any exclusion flags are set.

Where an ARM PMU driver has the set_event_filter function implemented,
we rely on it to perform exclusion checks. At present some of these
functions do not test for all of the available exclude flags.

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
Link: https://lkml.kernel.org/r/1547128414-50693-6-git-send-email-andrew.murray@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/perf/arm_pmu.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index d0b7dd8fb184..eec75b97e7ea 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -356,13 +356,6 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 	return ret;
 }
 
-static int
-event_requires_mode_exclusion(struct perf_event_attr *attr)
-{
-	return attr->exclude_idle || attr->exclude_user ||
-	       attr->exclude_kernel || attr->exclude_hv;
-}
-
 static int
 __hw_perf_event_init(struct perf_event *event)
 {
@@ -393,9 +386,8 @@ __hw_perf_event_init(struct perf_event *event)
 	/*
 	 * Check whether we need to exclude the counter from certain modes.
 	 */
-	if ((!armpmu->set_event_filter ||
-	     armpmu->set_event_filter(hwc, &event->attr)) &&
-	     event_requires_mode_exclusion(&event->attr)) {
+	if (armpmu->set_event_filter &&
+	    armpmu->set_event_filter(hwc, &event->attr)) {
 		pr_debug("ARM performance counters do not support "
 			 "mode exclusion\n");
 		return -EOPNOTSUPP;
@@ -867,6 +859,9 @@ int armpmu_register(struct arm_pmu *pmu)
 	if (ret)
 		return ret;
 
+	if (!pmu->set_event_filter)
+		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
+
 	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
 	if (ret)
 		goto out_destroy;
