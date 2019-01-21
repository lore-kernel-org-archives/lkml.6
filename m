Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB03C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9E920663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfAULV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:21:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60875 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbfAULVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:21:54 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBLCBt2493490
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:21:12 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBLCqj2493487;
        Mon, 21 Jan 2019 03:21:12 -0800
Date:   Mon, 21 Jan 2019 03:21:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Murray <tipbot@zytor.com>
Message-ID: <tip-c2c9091d9e7b5f11be3c0868eefcff4217026f26@git.kernel.org>
Cc:     ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org,
        maddy@linux.vnet.ibm.com, bp@alien8.de, mingo@kernel.org,
        shawnguo@kernel.org, hpa@zytor.com, rth@twiddle.net,
        mattst88@gmail.com, s.hauer@pengutronix.de, mpe@ellerman.id.au,
        linux@armlinux.org.uk, benh@kernel.crashing.org,
        mark.rutland@arm.com, tglx@linutronix.de, peterz@infradead.org,
        acme@kernel.org, andrew.murray@arm.com, will.deacon@arm.com,
        paulus@samba.org, torvalds@linux-foundation.org
Reply-To: mingo@kernel.org, maddy@linux.vnet.ibm.com, bp@alien8.de,
          linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru,
          s.hauer@pengutronix.de, mpe@ellerman.id.au, mattst88@gmail.com,
          rth@twiddle.net, hpa@zytor.com, shawnguo@kernel.org,
          tglx@linutronix.de, mark.rutland@arm.com,
          benh@kernel.crashing.org, linux@armlinux.org.uk,
          torvalds@linux-foundation.org, paulus@samba.org,
          will.deacon@arm.com, andrew.murray@arm.com, acme@kernel.org,
          peterz@infradead.org
In-Reply-To: <1547128414-50693-10-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-10-git-send-email-andrew.murray@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core, arch/powerpc: use
 PERF_PMU_CAP_NO_EXCLUDE for exclusion incapable PMUs
Git-Commit-ID: c2c9091d9e7b5f11be3c0868eefcff4217026f26
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

Commit-ID:  c2c9091d9e7b5f11be3c0868eefcff4217026f26
Gitweb:     https://git.kernel.org/tip/c2c9091d9e7b5f11be3c0868eefcff4217026f26
Author:     Andrew Murray <andrew.murray@arm.com>
AuthorDate: Thu, 10 Jan 2019 13:53:31 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:01:26 +0100

perf/core, arch/powerpc: use PERF_PMU_CAP_NO_EXCLUDE for exclusion incapable PMUs

For PowerPC PMUs that do not support context exclusion let's
advertise the PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that
perf will prevent us from handling events where any exclusion flags
are set. Let's also remove the now unnecessary check for exclusion
flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: robin.murphy@arm.com
Cc: suzuki.poulose@arm.com
Link: https://lkml.kernel.org/r/1547128414-50693-10-git-send-email-andrew.murray@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/powerpc/perf/hv-24x7.c | 10 +---------
 arch/powerpc/perf/hv-gpci.c | 10 +---------
 arch/powerpc/perf/imc-pmu.c | 19 +------------------
 3 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 72238eedc360..d2b8e6061933 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1306,15 +1306,6 @@ static int h_24x7_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	/* no branch sampling */
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
@@ -1577,6 +1568,7 @@ static struct pmu h_24x7_pmu = {
 	.start_txn   = h_24x7_event_start_txn,
 	.commit_txn  = h_24x7_event_commit_txn,
 	.cancel_txn  = h_24x7_event_cancel_txn,
+	.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static int hv_24x7_init(void)
diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 43fabb3cae0f..735e77b09cdb 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -232,15 +232,6 @@ static int h_gpci_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	/* no branch sampling */
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
@@ -285,6 +276,7 @@ static struct pmu h_gpci_pmu = {
 	.start       = h_gpci_event_start,
 	.stop        = h_gpci_event_stop,
 	.read        = h_gpci_event_update,
+	.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static int hv_gpci_init(void)
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index f292a3f284f1..b1c37cc3fa98 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -473,15 +473,6 @@ static int nest_imc_event_init(struct perf_event *event)
 	if (event->hw.sample_period)
 		return -EINVAL;
 
-	/* unsupported modes and filters */
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
 
@@ -748,15 +739,6 @@ static int core_imc_event_init(struct perf_event *event)
 	if (event->hw.sample_period)
 		return -EINVAL;
 
-	/* unsupported modes and filters */
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
 
@@ -1069,6 +1051,7 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 	pmu->pmu.stop = imc_event_stop;
 	pmu->pmu.read = imc_event_update;
 	pmu->pmu.attr_groups = pmu->attr_groups;
+	pmu->pmu.capabilities = PERF_PMU_CAP_NO_EXCLUDE;
 	pmu->attr_groups[IMC_FORMAT_ATTR] = &imc_format_group;
 
 	switch (pmu->domain) {
