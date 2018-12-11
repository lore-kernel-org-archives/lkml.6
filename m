Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2516C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE2720672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE2720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeLKPbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:31:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38103 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeLKPbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:31:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFUovx4041951
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:30:50 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFUnYX4041948;
        Tue, 11 Dec 2018 07:30:49 -0800
Date:   Tue, 11 Dec 2018 07:30:49 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mukesh Ojha <tipbot@zytor.com>
Message-ID: <tip-43b9e4febc66b98d83cc1560196d56ac7fef3c32@git.kernel.org>
Cc:     mojha@codeaurora.org, jolsa@redhat.com,
        torvalds@linux-foundation.org, acme@kernel.org, hpa@zytor.com,
        namhyung@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
          namhyung@kernel.org, mojha@codeaurora.org, acme@kernel.org,
          torvalds@linux-foundation.org, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <1543310012-7967-1-git-send-email-mojha@codeaurora.org>
References: <1543310012-7967-1-git-send-email-mojha@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Declare the __percpu attribute on
 non-deref types
Git-Commit-ID: 43b9e4febc66b98d83cc1560196d56ac7fef3c32
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

Commit-ID:  43b9e4febc66b98d83cc1560196d56ac7fef3c32
Gitweb:     https://git.kernel.org/tip/43b9e4febc66b98d83cc1560196d56ac7fef3c32
Author:     Mukesh Ojha <mojha@codeaurora.org>
AuthorDate: Tue, 27 Nov 2018 14:43:32 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 15:01:48 +0100

perf/core: Declare the __percpu attribute on non-deref types

Sparse reports the current declaration of two perf percpu variables
with this warning:

  warning: incorrect type in initializer (different address spaces)
         expected void const [noderef] <asn:3>*__vpp_verify
         got struct perf_cpu_context *<noident>

While it's normally perfectly fine to place GCC attributes anywhere
in the definition, this particular attribute is for a checking
compiler's such as Sparse's benefit, which doesn't want __percpu
on pointers.

So reorder the attribute to come after the structure type, not after
the pointer type.

[ mingo: Rewrote the changelog. ]

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1543310012-7967-1-git-send-email-mojha@codeaurora.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/perf_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 53c500f0ca79..1d5c551a5add 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -262,8 +262,8 @@ struct pmu {
 	 */
 	int				capabilities;
 
-	int * __percpu			pmu_disable_count;
-	struct perf_cpu_context * __percpu pmu_cpu_context;
+	int __percpu			*pmu_disable_count;
+	struct perf_cpu_context __percpu *pmu_cpu_context;
 	atomic_t			exclusive_cnt; /* < 0: cpu; > 0: tsk */
 	int				task_ctx_nr;
 	int				hrtimer_interval_ms;
