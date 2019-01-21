Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F080BC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54BA20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfAULUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:20:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52037 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfAULUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:20:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBJFWv2493075
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:19:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBJFv42493072;
        Mon, 21 Jan 2019 03:19:15 -0800
Date:   Mon, 21 Jan 2019 03:19:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Murray <tipbot@zytor.com>
Message-ID: <tip-cafa780e7b012453d0155c3da3488b877a2fd133@git.kernel.org>
Cc:     mingo@kernel.org, acme@kernel.org, torvalds@linux-foundation.org,
        mattst88@gmail.com, mpe@ellerman.id.au, shawnguo@kernel.org,
        ink@jurassic.park.msu.ru, peterz@infradead.org, hpa@zytor.com,
        will.deacon@arm.com, andrew.murray@arm.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, paulus@samba.org,
        benh@kernel.crashing.org, tglx@linutronix.de, mark.rutland@arm.com,
        bp@alien8.de, s.hauer@pengutronix.de, rth@twiddle.net
Reply-To: peterz@infradead.org, will.deacon@arm.com, hpa@zytor.com,
          mingo@kernel.org, torvalds@linux-foundation.org, acme@kernel.org,
          mpe@ellerman.id.au, mattst88@gmail.com, ink@jurassic.park.msu.ru,
          shawnguo@kernel.org, benh@kernel.crashing.org,
          tglx@linutronix.de, bp@alien8.de, mark.rutland@arm.com,
          rth@twiddle.net, s.hauer@pengutronix.de, andrew.murray@arm.com,
          paulus@samba.org, linux@armlinux.org.uk,
          linux-kernel@vger.kernel.org
In-Reply-To: <1547128414-50693-7-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-7-git-send-email-andrew.murray@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core, arch/arm: Use PERF_PMU_CAP_NO_EXCLUDE
 for exclusion incapable PMUs
Git-Commit-ID: cafa780e7b012453d0155c3da3488b877a2fd133
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

Commit-ID:  cafa780e7b012453d0155c3da3488b877a2fd133
Gitweb:     https://git.kernel.org/tip/cafa780e7b012453d0155c3da3488b877a2fd133
Author:     Andrew Murray <andrew.murray@arm.com>
AuthorDate: Thu, 10 Jan 2019 13:53:28 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:01:23 +0100

perf/core, arch/arm: Use PERF_PMU_CAP_NO_EXCLUDE for exclusion incapable PMUs

For drivers that do not support context exclusion let's advertise the
PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that perf will
prevent us from handling events where any exclusion flags are set.
Let's also remove the now unnecessary check for exclusion flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Shawn Guo <shawnguo@kernel.org>
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: robin.murphy@arm.com
Cc: suzuki.poulose@arm.com
Link: https://lkml.kernel.org/r/1547128414-50693-7-git-send-email-andrew.murray@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/mach-imx/mmdc.c     | 9 ++-------
 arch/arm/mm/cache-l2x0-pmu.c | 9 +--------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index e49e06834516..fce4b426c379 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -294,13 +294,7 @@ static int mmdc_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
-	if (event->attr.exclude_user		||
-			event->attr.exclude_kernel	||
-			event->attr.exclude_hv		||
-			event->attr.exclude_idle	||
-			event->attr.exclude_host	||
-			event->attr.exclude_guest	||
-			event->attr.sample_period)
+	if (event->attr.sample_period)
 		return -EINVAL;
 
 	if (cfg < 0 || cfg >= MMDC_NUM_COUNTERS)
@@ -456,6 +450,7 @@ static int mmdc_pmu_init(struct mmdc_pmu *pmu_mmdc,
 			.start          = mmdc_pmu_event_start,
 			.stop           = mmdc_pmu_event_stop,
 			.read           = mmdc_pmu_event_update,
+			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 		},
 		.mmdc_base = mmdc_base,
 		.dev = dev,
diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index afe5b4c7b164..99bcd074916a 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -314,14 +314,6 @@ static int l2x0_pmu_event_init(struct perf_event *event)
 	    event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 
@@ -544,6 +536,7 @@ static __init int l2x0_pmu_init(void)
 		.del = l2x0_pmu_event_del,
 		.event_init = l2x0_pmu_event_init,
 		.attr_groups = l2x0_pmu_attr_groups,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	l2x0_pmu_reset();
